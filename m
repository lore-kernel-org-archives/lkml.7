Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB01C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FCA20659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfH3Osm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:48:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbfH3Osl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:48:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DBBAB667;
        Fri, 30 Aug 2019 14:48:39 +0000 (UTC)
Date:   Fri, 30 Aug 2019 16:48:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: dataring API Re: [RFC PATCH v4 1/9] printk-rb: add a new printk
 ringbuffer implementation
Message-ID: <20190830144838.smyfudvrqpfswphy@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807222634.1723-2-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-08-08 00:32:26, John Ogness wrote:
> diff --git a/kernel/printk/dataring.c b/kernel/printk/dataring.c
> new file mode 100644
> index 000000000000..911bac593ec1
> --- /dev/null
> +++ b/kernel/printk/dataring.c
> + * DOC: dataring overview

I have to spend a lot of time thinking about dataring API. I started
with some small comments. I ended with a description how I see
the API consistency.

I am still not sure that I see it from the right angle. Let's see.

> + * A dataring is a lockless ringbuffer consisting of variable length data
> + * blocks, each of which are assigned an ID. The IDs map to descriptors, which
> + * contain metadata about the data block. The lookup function mapping IDs to
> + * descriptors is implemented by the user.
> + *
> + * Descriptors
> + * -----------
> + * A descriptor is a handle to a data block. How descriptors are structured
> + * and mapped to IDs is implemented by the user.

We should add a note that logical IDs are used to avoid ABA problems.

> + * Descriptors contain the begin (begin_lpos) and end (next_lpos) logical
> + * positions of the data block they represent. The end logical position
> + * matches the begin logical position of the adjacent data block.
> + *
> + * Why Descriptors?
> + * ----------------
> + * The data ringbuffer supports variable length entities, which means that
> + * data blocks will not always begin at a predictable offset of the byte
> + * array. This is a major problem for lockless writers that, for example, will
> + * compete to expire and reuse old data blocks when the ringbuffer is full.
> + * Without a predictable begin for the data blocks, a writer has no reliable
> + * information about the status of the "free" area. Are any flags or state
> + * variables already set or is it just garbage left over from previous usage?
> + *
> + * Descriptors allow safe and controlled access to data block metadata by
> + * providing predictable offsets for such metadata. This is key to supporting
> + * multiple concurrent lockless writers.
> + *
> + * Behavior
> + * --------
> + * The data ringbuffer allows writers to commit data without regard for
> + * readers. Readers must pre- and post-validate the data blocks they are
> + * processing to be sure the processed data is consistent. A function
> + * dataring_datablock_isvalid() is available for that. Readers can only
> + * iterate data blocks by utilizing an external implementation using
> + * descriptor lookups based on IDs.
> + *
> + * Writers commit data in two steps:
> + *
> + * (1) Reserve a new data block (dataring_push()).
> + * (2) Commit the data block (dataring_datablock_setid()).
> + *
> + * Once a data block is committed, it is available for recycling by another
> + * writer. Therefore, once committed, a writer must no longer access the data
> + * block.
> + *
> + * If data block reservation fails, it means the oldest reserved data block
> + * has not yet been committed by its writer. This acts as a blocker for any
> + * future data block reservation.

Let's start with something easier. I am not sure with the FIFO interface:

> +bool dataring_pop(struct dataring *dr);
> +char *dataring_push(struct dataring *dr, unsigned int size,
> +		    struct dr_desc *desc, unsigned long id);

This is the same FIFO interface as in numlist. But the semantic
is different, especially the push() part:

   + numlist_push():
      + adds a new (external node)
      + node is valid when added
      + always succeeds

   + dataring_push()
      + just reserves space in its own data structure;
      + data are written later and not valid until anyone calls
	setid() (commits)
      + might fail when it is unable to remove old (non-committed)
	data with wrong id

The pop() part is similar but the wording is slightly different:

    + numlist_pop()
      + succeeds only when the oldest node is not blocked().
      + blocked state is defined by external callback

    + dataring_pop()
      + succeeds only when the oldest node has correct id (committed)
      + the id is validated using external callback


I am somehow confused by the same names and the differences.
Also dataring_push() does not push any data. It is only making
space.

I believe that the following interface will be much easier
to understand. It is inspired by ringbuffer API. Both APIs
actually have similar usage:

  + dataring_reserve() instead of push()
  + dataring_commit() instead of setid()
  + dataring_remove_oldest() instead of pop()


> +struct dr_datablock *dataring_getdatablock(struct dataring *dr,
> +					   struct dr_desc *desc, int *size);

please: getdatablock -> get_datablock

On the same note, please, rename getdesc() callback to get_desc().

> +bool dataring_datablock_isvalid(struct dataring *dr, struct dr_desc *desc);

I am always in doubts what it exactly means, especially whether
the data are valid. I suggest something like:

   dataring_datablock_is_used()  (means reserved or committed)

Or make it clear that it only compares the given ranges:

   dataring_range_in_use()



OK, now, the complicated part: consistency:

Dataring API works with:

   + global: head_lpos, tail_lpos
   + per datablock:
       + locally stored: id
       + externally stored: begin_lpos, next_lpos

Let's look at "id" more closely from the dataring API side of view:

  1. ID stored the in the external struct prb_desc.

     Here the ID match is a bit fuzzy from dataring API point of view.
     begin_lpos and next_lpos stored in the external prb_desc can point
     to datablock for the current id or id from the previous
     cycle because they were not updated yet.

     Now, dataring API is allowed to rewrite them in
     dataring_push()/reserve(). But it does not know
     if they are consistent in another situation.


  2. ID stored in the datablock

     Here the ID match means that the data are committed
     and could get reused. Except when they are already
     overwritten and the ID matches just by chance.

Summary:

     The dataring API could not decide about the validity on its own.

     The API is a slave that does some actions when asked.
     The action is that it computes all the lpos indexes.
     But the external code decides when they are valid and
     when they can be written.


More pitfalls of the internally stored id (in datablock):

      + invalid value (id - 1) is set in dataring_push/reserve()
      + valid value (id) is set in dataring_setid/commit()
      + id is used only in one check and indirectly!!!

     In particular, the "id" is used to index the external dr_desc
     in dataring_pop().

     The external prb_getdesc() callback then checks that it
     matches with id stored in the external prb_desc. It returns
     back pointer to db_desc. dataring_pop() then checks that
     lpos_begin and lpos_next are in bounds.

     WARN: I do not see a check whether lpos_begin points back
	   to exactly the same location when the original
	   "id" was read.

     WARN: Reader, prb_iter_next_valid_entry(), does not check
	   the ID stored in datablock. It should make sure
	   the data are consistent. It relies on the fact that
	   only valid datablocks are reachable via numlist.

	   Except that the related numlist entries are not
	   removed from the list when the related datablock
	   is poped. It relies on the fact that the stored
	   lpos values are not longer in valid range.

	   Sigh, these are a lot of assumptions that are
	   hard to describe and keep in mind.


      BTW: The check at the end of the reading is really weak,
	   see prb_iter_next_valid_entry(). It does not check
	   that the ID is still the same and that lpos_begin
	   and lpos_end are still the same.


OK, the above looks a bit scary to me. Let's look at it
from another angle.

What is the purpose of the API?

  + provide the requested space for writer
  + assist with reading the data???


What are the responsibilities (current code):

  + Writer:

     + provides "id" pointing to external struct db_desc
       where the ring buffer could store lpos for
       the reserved space.

     + ensures exclusive write access to this structure until
       the space is reserved.

     + tells when the data are committed and the space can get
       reused

     + provides callback to find the external struct prb_desc
       for a given ID. The callback does only basic consistency
       check (by ID). The information is used to check if
       the space is reusable.


  + Reader:

     + uses dataring_getdatablock() to get address and size
       of the datablock; There are no barriers and no consistency
       checks done by the dataring API.

     + Calls dataring_datablock_isvalid() to check if lpos
       are in valid bounds. The dataring API does not provide
       any barriers to assist with it.


  + dataring API:

     + Manipulates the global lpos_head, lpos_tail indexes
       and "id" field.

     + Uses barriers to manipulate the above three variables
       a safe way.


Power and weakness:

  + The dataring API helps:

     + separate lpos computation
     + handle lpos related barriers


  + The dataring API does not help much:

      + writer has many responsibilities and have to use
	the API carefully.

      + readers have to get and validate information by more
	API calls

      + more consistency checks are possible; it is hard to
	say what is must-to-have or nice-to-have and
	which API is responsible for what.


Result:

I am sure that this API might get improved. But I am not sure
that it is worth it.

I though that the splint into 3 layers (ringbuffer, dataring, numlist)
might help to split the problem and make it easier. It helped,
definitely. But the consistency is still too complicated. The number
of memory barriers is really high.

There might be also argument that the APIs are reusable. But I do not
believe it. They are too complicated and depends on each other.
I do not think that anyone else might need exactly this complexity
for their use case.


OK, I have spent big part of two weeks with this patchset. I think
that I did a big progress. But it seems that either me or someone
else would need to put quite some effort to make this approach
manageable for me.

This brings me back to my alternative solution, see
https://lore.kernel.org/lkml/20190704103321.10022-1-pmladek@suse.com/
I believe that it might be easier to get into some
usable and manageable state than to fight with the numlist
based approach.

John did a port on top of this patchset, see
https://lore.kernel.org/lkml/87lfvwcssu.fsf@linutronix.de/
and it seems to work. It would need to get refactored
back to a cleaner state: remove numlist and maybe even
ringbuffer API. What do you think?

Best Regards,
Petr
