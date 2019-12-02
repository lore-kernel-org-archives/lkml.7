Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181E7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50FC20748
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfLBPsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:48:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:49756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfLBPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:48:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6335BD1E;
        Mon,  2 Dec 2019 15:48:44 +0000 (UTC)
Date:   Mon, 2 Dec 2019 16:48:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128015235.12940-2-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have seen few prelimitary versions before this public one.
I am either happy with it or blind to see new problems[*].

It would be great if anyone else could look at it. Especially
I am intreseted:

  + Whether the algorithm can be understood by people who
    see it for the "first" time.

  + Whether there are any obvious races. I wonder if our assumtions
    about atomic_cmpxchg() guaranttes are correct.


[*] I have found one theoretical ABA problem. I think that is
    really rather theoretical and should not block this patch.
    I think that we could do something to prevent it either
    now or later. See below for more details


On Thu 2019-11-28 02:58:33, John Ogness wrote:
> Add a new lockless ringbuffer implementation to be used for printk.
> First only add support for writers. Reader support will be added in
> a follow-up commit.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk_ringbuffer.c | 676 ++++++++++++++++++++++++++++++
>  kernel/printk/printk_ringbuffer.h | 239 +++++++++++
>  2 files changed, 915 insertions(+)
>  create mode 100644 kernel/printk/printk_ringbuffer.c
>  create mode 100644 kernel/printk/printk_ringbuffer.h
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> new file mode 100644
> index 000000000000..09c32e52fd40
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -0,0 +1,676 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/irqflags.h>
> +#include <linux/string.h>
> +#include <linux/errno.h>
> +#include <linux/bug.h>
> +#include "printk_ringbuffer.h"
> +
> +/**
> + * DOC: printk_ringbuffer overview
> + *
> + * Data Structure
> + * --------------
> + * The printk_ringbuffer is made up of 3 internal ringbuffers::
> + *
> + * * desc_ring:      A ring of descriptors. A descriptor contains all record
> + *                   meta-data (sequence number, timestamp, loglevel, etc.) as
> + *                   well as internal state information about the record and
> + *                   logical positions specifying where in the other
> + *                   ringbuffers the text and dictionary strings are located.
> + *
> + * * text_data_ring: A ring of data blocks. A data block consists of a 32-bit
> + *                   integer (ID) that maps to a desc_ring index followed by
> + *                   the text string of the record.
> + *
> + * * dict_data_ring: A ring of data blocks. A data block consists of a 32-bit
> + *                   integer (ID) that maps to a desc_ring index followed by
> + *                   the dictionary string of the record.
> + *

I slightly miss some top level description of the approach. Especially
how the code deals with races. The following comes to my mind:


The state of each entry is always defined by desc->state_val.
It consists of 30-bit id and 2-bit state value, see DESC_INDEX()
and get_desc_state.

prb_reserve() call returns descriptor in a reserved state. It points
to reserved data blocks in the data rings.

The algorithm starts with using never used descriptors and data
blocks. Later it uses descriptors and data blocks in the reusable
state.

The descriptors and data space are reused in a round-robin fahion.
Only records in the committed state could be moved to reusable state.

prb_reserve() has to do several steps. Namely it has to update head
and tail positions in all ring buffers. Also it has to manipulare
desc->state_val. Most races are avoided by using atomic_cmpxchg()
operations. They make sure that all values are moved from one
well defined state to another well defined state.

ABA races are avoided by using logical positions and indexes.
The rinbuffer must be reused many times before these values
overflow. Anyway, logical positions to data ring could not overflow
wildly. They are manipulated only when the descriptor is already
reserved. The descriptor could get reused only when it was commited
before. It means that there is a limited number of writers
until they would need to reuse a particular descriptor. [*]

Back to the prb_reserve() algorithm. The repeated pattern is that
it does not matter what caller invalidates oldest entries. They are
fine when it has already been done by another writer in the meantime.
The real winner is the caller that is able to move the head position
and reserve the space. Others need to go back to invalidating the oldest
entry, etc.

prb_reserve() caller has exclusive write access to the reserved
descriptor and data blocks. It has to call prb_commit() when finished.
It is a signal that the data are valid for readers. But it is also
a signal that the descriptor and the space might get reused be
other writers.


Finally, readers just need to check the state of the descriptor
before and after reading the data. The data are correct only
when the descriptor is in committed state.

[*] Hmm, the ABA problem might theoretically happen in desc_reserve(),
    see below.



> +/*
> + * Sanity checker for reserve size. The ringbuffer code assumes that a data
> + * block does not exceed the maximum possible size that could fit within the
> + * ringbuffer. This function provides that basic size check so that the
> + * assumption is safe.
> + */
> +static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
> +{
> +	struct prb_data_block *db = NULL;
> +
> +	/* Writers are not allowed to write data-less records. */
> +	if (size == 0)
> +		return false;

I would personally let this decision to the API caller.

The code actually have to support data-less records. They are used
when the descriptor is reserved but the data block can't get reserved.

The above statement might create false feeling that it could not
happen later in the code. It might lead to bugs in writer code.
Also reader API users might not expect to get a "valid" data-less
record.

> +	/*
> +	 * Ensure the alignment padded size could possibly fit in the data
> +	 * array. The largest possible data block must still leave room for
> +	 * at least the ID of the next block.
> +	 */
> +	size = to_blk_size(size);
> +	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
> +		return false;
> +
> +	return true;
> +}
> +
> +/* Reserve a new descriptor, invalidating the oldest if necessary. */
> +static bool desc_reserve(struct printk_ringbuffer *rb, u32 *id_out)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	struct prb_desc *desc;
> +	u32 id_prev_wrap;
> +	u32 head_id;
> +	u32 id;
> +
> +	head_id = atomic_read(&desc_ring->head_id);
> +
> +	do {
> +		desc = to_desc(desc_ring, head_id);
> +
> +		id = DESC_ID(head_id + 1);
> +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
> +
> +		if (id_prev_wrap == atomic_read(&desc_ring->tail_id)) {
> +			if (!desc_push_tail(rb, id_prev_wrap))
> +				return false;
> +		}
> +	} while (!atomic_try_cmpxchg(&desc_ring->head_id, &head_id, id));

Hmm, in theory, ABA problem might cause that we successfully
move desc_ring->head_id when tail has not been pushed yet.

As a result we would never call desc_push_tail() until
it overflows again.

I am not sure if we need to take care of it. The code is called with
interrupts disabled. IMHO, only NMI could cause ABA problem
in reality. But the game (debugging) is lost anyway when NMI ovewrites
the buffer several times.

Also it should not be a complete failure. We still could bail out when
the previous state was not reusable. We are on the safe side
when it was reusable.

Also we could probably detect when desc_ring->tail_id is not
updated any longer and do something about it.

> +
> +	desc = to_desc(desc_ring, id);
> +
> +	/* Set the descriptor's ID and also set its state to reserved. */
> +	atomic_set(&desc->state_var, id | 0);

We should check here that the original state id from the previous
wrap in reusable state (or 0 for bootstrap). On error, we know that
there was the ABA problem and would need to do something about it.

> +
> +	/* Store new ID/state before making any other changes. */
> +	smp_wmb(); /* LMM_TAG(desc_reserve:A) */
> +
> +	*id_out = id;
> +	return true;
> +}
> +
> +/* Determine the end of a data block. */
> +static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
> +				   unsigned long lpos, unsigned int size)
> +{
> +	unsigned long begin_lpos;
> +	unsigned long next_lpos;
> +
> +	begin_lpos = lpos;
> +	next_lpos = lpos + size;
> +
> +	if (DATA_WRAPS(data_ring, begin_lpos) ==
> +	    DATA_WRAPS(data_ring, next_lpos)) {
> +		/* The data block does not wrap. */
> +		return next_lpos;
> +	}
> +
> +	/* Wrapping data blocks store their data at the beginning. */
> +	return (DATA_THIS_WRAP_START_LPOS(data_ring, next_lpos) + size);
> +}
> +
> +/**
> + * prb_reserve() - Reserve space in the ringbuffer.
> + *
> + * @e:  The entry structure to setup.
> + * @rb: The ringbuffer to reserve data in.
> + * @r:  The record structure to allocate buffers for.
> + *
> + * This is the public function available to writers to reserve data.
> + *
> + * The writer specifies the text and dict sizes to reserve by setting the
> + * @text_buf_size and @dict_buf_size fields of @r, respectively. Dictionaries
> + * are optional, so @dict_buf_size is allowed to be 0.
> + *
> + * Context: Any context. Disables local interrupts on success.
> + * Return: true if at least text data could be allocated, otherwise false.
> + *
> + * On success, the fields @info, @text_buf, @dict_buf of @r will be set by
> + * this function and should be filled in by the writer before committing.
> + *
> + * If the function fails to reserve dictionary space (but all else succeeded),
> + * it will still report success. In that case @dict_buf is set to NULL and
> + * @dict_buf_size is set to 0. Writers must check this before writing to
> + * dictionary space.
> + */
> +bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> +		 struct printk_record *r)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	struct prb_desc *d;
> +	u32 id;
> +
> +	if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
> +		return false;
> +
> +	/* Records without dictionaries are allowed. */
> +	if (r->dict_buf_size) {
> +		if (!data_check_size(&rb->dict_data_ring, r->dict_buf_size))
> +			return false;
> +	}
> +
> +	/* Disable interrupts during the reserve/commit window. */
> +	local_irq_save(e->irqflags);
> +
> +	if (!desc_reserve(rb, &id)) {
> +		/* Descriptor reservation failures are tracked. */
> +		atomic_long_inc(&rb->fail);
> +		local_irq_restore(e->irqflags);
> +		return false;
> +	}
> +
> +	d = to_desc(desc_ring, id);
> +
> +	/*
> +	 * Set the @e fields here so that prb_commit() can be used if
> +	 * text data allocation fails.
> +	 */
> +	e->rb = rb;
> +	e->id = id;
> +
> +	/*
> +	 * Initialize the sequence number if it has never been set.
> +	 * Otherwise just increment it by a full wrap.
> +	 *
> +	 * @seq is considered "never been set" if it has a value of 0,
> +	 * _except_ for descs[0], which was set by the ringbuffer initializer
> +	 * and therefore is always considered as set.
> +	 *
> +	 * See the "Bootstrap" comment block in printk_ringbuffer.h for
> +	 * details about how the initializer bootstraps the descriptors.
> +	 */
> +	if (d->info.seq == 0 && DESC_INDEX(desc_ring, id) != 0)
> +		d->info.seq = DESC_INDEX(desc_ring, id);
> +	else
> +		d->info.seq += DESCS_COUNT(desc_ring);
> +
> +	r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
> +				 &d->text_blk_lpos, id);
> +	/* If text data allocation fails, a data-less record is committed. */
> +	if (r->text_buf_size && !r->text_buf) {
> +		d->info.text_len = 0;
> +		d->info.dict_len = 0;

I would prefer to clear all four variables at the beginning:

		r->text_buf = NULL;
		r->dict_buf = NULL;
		d->info.text_len = 0;
		d->info.dict_len = 0;

So that we never return an outdated/random pointer back.

I might be too careful. But I think that it is a good price for
a more safe API. Especially that broken printk() is not easy
to debug.

Best Regards,
Petr

> +		prb_commit(e);
> +		return false;
> +	}
> +
> +	r->dict_buf = data_alloc(rb, &rb->dict_data_ring, r->dict_buf_size,
> +				 &d->dict_blk_lpos, id);
> +	/*
> +	 * If dict data allocation fails, the caller can still commit
> +	 * text. But dictionary information will not be available.
> +	 */
> +	if (r->dict_buf_size && !r->dict_buf)
> +		r->dict_buf_size = 0;
> +
> +	r->info = &d->info;
> +
> +	/* Set default values for the lengths. */
> +	d->info.text_len = r->text_buf_size;
> +	d->info.dict_len = r->dict_buf_size;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(prb_reserve);
> +
