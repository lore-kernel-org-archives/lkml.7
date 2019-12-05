Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA74C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C773720675
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfLEMBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:01:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfLEMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:01:40 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1icpp4-0001Gy-Jw; Thu, 05 Dec 2019 13:01:30 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-2-john.ogness@linutronix.de>
        <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
        <20191202155955.meawljmduiciw5t2@pathway.suse.cz>
        <87sgm2fzuh.fsf@linutronix.de> <20191203011721.GH93017@google.com>
        <20191203091843.678461e4@gandalf.local.home>
Date:   Thu, 05 Dec 2019 13:01:28 +0100
Message-ID: <874kyf56cn.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-03, Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>> +/* Reserve a new descriptor, invalidating the oldest if necessary. */
>>>>> +static bool desc_reserve(struct printk_ringbuffer *rb, u32 *id_out)
>>>>> +{
>>>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>>>> +	struct prb_desc *desc;
>>>>> +	u32 id_prev_wrap;
>>>>> +	u32 head_id;
>>>>> +	u32 id;
>>>>> +
>>>>> +	head_id = atomic_read(&desc_ring->head_id);
>>>>> +
>>>>> +	do {
>>>>> +		desc = to_desc(desc_ring, head_id);
>>>>> +
>>>>> +		id = DESC_ID(head_id + 1);
>>>>> +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
>>>>> +
>>>>> +		if (id_prev_wrap == atomic_read(&desc_ring->tail_id)) {
>>>>> +			if (!desc_push_tail(rb, id_prev_wrap))
>>>>> +				return false;
>>>>> +		}
>>>>> +	} while (!atomic_try_cmpxchg(&desc_ring->head_id, &head_id, id));
>>>>
>>>> Hmm, in theory, ABA problem might cause that we successfully
>>>> move desc_ring->head_id when tail has not been pushed yet.
>>>>
>>>> As a result we would never call desc_push_tail() until
>>>> it overflows again.
>>>>
>>>> I am not sure if we need to take care of it. The code is called
>>>> with interrupts disabled. IMHO, only NMI could cause ABA problem in
>>>> reality. But the game (debugging) is lost anyway when NMI ovewrites
>>>> the buffer several times.
>>>>
>>>> Also it should not be a complete failure. We still could bail out
>>>> when the previous state was not reusable. We are on the safe side
>>>> when it was reusable.
>>>>
>>>> Also we could probably detect when desc_ring->tail_id is not
>>>> updated any longer and do something about it.
>>>>
>>>> BTW: If I am counting correctly. The ABA problem would happen when
>>>> exactly 2^30 (1G) messages is written in the mean time.
>>> 
>>> All the ringbuffer code assumes that the use of index numbers
>>> handles the ABA problem (i.e. there must not be 1 billion printk's
>>> within an NMI). If we want to support 1 billion+ printk's within an
>>> NMI, then perhaps the index number should be increased. For 64-bit
>>> systems it would be no problem to go to 62 bits. For 32-bit systems,
>>> I don't know how well the 64-bit atomic operations are supported.
>> 
>> ftrace dumps from NMI (DUMP_ALL type ftrace_dump_on_oops on a $BIG
>> machine)? 1G seems large enough, but who knows.
>
> ftrace dump from NMI is the most likely case to hit this, but when
> that happens, you are in debugging mode, and the system usually
> becomes unreliable at this moment. I agree with Petr, that we should
> not complicate the code more to handle this theoretical condition.

I will change the data block ID size to "unsigned long". Then it is
really only an issue for 32-bit systems.

AFAICT, the only real issue is that the head can be pushed to the
descriptor index that the tail is pointing to. From there, the head can
be advanced beyond and the tail may never move again. So writers just
need to make sure the tail gets pushed beyond the newly reserved head
before making any changes to that descriptor.

Aside from moving to "unsigned long" ID's, I believe this can be handled
with the following 4 changes when reserving a new descriptor:

- also push the tail forward if it falls behind

- after pushing the head, re-check if the tail is still ok

- verify the state of the reserved descriptor before changing it

- use cmpxchg() to change it

Below is the patch snippet I use for this. (Note that the patch is
against a version where ID's have already been changed to unsigned
longs.)

John Ogness


@@ -468,19 +470,53 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 		id = DESC_ID(head_id + 1);
 		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
 
-		if (id_prev_wrap == atomic_long_read(&desc_ring->tail_id)) {
-			if (!desc_push_tail(rb, id_prev_wrap))
+		/*
+		 * Make space for the new descriptor by pushing the tail
+		 * beyond the descriptor to be reserved. Normally this only
+		 * requires pushing the tail once. But due to possible ABA
+		 * problems with the ID, the tail could be too far behind.
+		 * Use a loop to push the tail where it needs to be.
+		 */
+		tail_id = atomic_long_read(&desc_ring->tail_id);
+		while (DESC_ID(id_prev_wrap - tail_id) <
+		       DESCS_COUNT(desc_ring)) {
+
+			if (!desc_push_tail(rb, tail_id))
 				return false;
+			tail_id = DESC_ID(tail_id + 1);
 		}
 	} while (!atomic_long_try_cmpxchg(&desc_ring->head_id, &head_id, id));
 
+	/*
+	 * Before moving the head, it was ensured that the tail was pushed to
+	 * where it needs to be. Due to possible ABA problems with the ID, the
+	 * reserved descriptor may not be what was expected. Re-check the tail
+	 * to see if it is still where it needs to be.
+	 */
+	tail_id = atomic_long_read(&desc_ring->tail_id);
+	if (DESC_ID(id_prev_wrap - tail_id) < DESCS_COUNT(desc_ring))
+		return false;
+
 	desc = to_desc(desc_ring, id);
 
+	/* If the descriptor has been recycled, verify the old state val. */
+	prev_state_val = atomic_long_read(&desc->state_var);
+	if (prev_state_val && prev_state_val != (id_prev_wrap |
+						 DESC_COMMITTED_MASK |
+						 DESC_REUSE_MASK)) {
+		/* Unexpected value. Hit ABA issue for ID? */
+		return false;
+	}
+
+	/*
+	 * Set the descriptor's ID and also set its state to reserved.
+	 * The new ID/state is stored before making any other changes.
+	 */
+	if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
+				id | 0)) { /* LMM_TAG(desc_reserve:A) */
+		/* Unexpected value. Hit ABA issue for ID? */
+		return false;
+	}
-	/* Set the descriptor's ID and also set its state to reserved. */
-	atomic_long_set(&desc->state_var, id | 0);
-
-	/* Store new ID/state before making any other changes. */
-	smp_wmb(); /* LMM_TAG(desc_reserve:A) */
 
 	*id_out = id;
 	return true;
