Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F16C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147BF20820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfFXNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:55:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36978 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfFXNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:55:42 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hfPRQ-0003fw-2b; Mon, 24 Jun 2019 15:55:28 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
Date:   Mon, 24 Jun 2019 15:55:26 +0200
In-Reply-To: <20190607162349.18199-2-john.ogness@linutronix.de> (John Ogness's
        message of "Fri, 7 Jun 2019 18:29:48 +0206")
Message-ID: <877e9bxf3l.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to point out an important typo related to memory
barriers...

On 2019-06-07, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
> new file mode 100644
> index 000000000000..d0b2b6a549b0
> --- /dev/null
> +++ b/lib/printk_ringbuffer.c
[...]
> +static struct prb_descr *remove_oldest_descr(struct printk_ringbuffer *rb)
> +{
> +	struct prb_list *l = &rb->descr_list;
> +	unsigned long oldest_id;
> +	struct prb_descr *d;
> +	unsigned long next;
> +
> +	for (;;) {
> +		oldest_id = READ_ONCE(l->oldest);
> +
> +		/* list empty */
> +		if (oldest_id == EOL)
> +			return NULL;
> +
> +		d = TO_DESCR(rb, oldest_id);
> +
> +		/* only descriptors with _invalid_ data can be removed */
> +		if (data_valid(rb, READ_ONCE(rb->data_list.oldest),
> +			       READ_ONCE(rb->data_list.newest),
> +			       READ_ONCE(d->data),
> +			       READ_ONCE(d->data_next))) {
> +			return NULL;
> +		}
> +
> +		/*
> +		 * MB6: synchronize link descr
> +		 *
> +		 * In particular: l->oldest is loaded as a data dependency so
> +		 * d->next and the following l->oldest will load afterwards,
> +		 * respectively.
> +		 */
> +		next = smp_load_acquire(&d->next);
> +
> +		if (next == EOL && READ_ONCE(l->oldest) == oldest_id) {
> +			/*
> +			 * The oldest has no next, so this is a list of one
> +			 * descriptor. Lists must always have at least one
> +			 * descriptor.
> +			 */
> +			return NULL;
> +		}
> +
> +		if (cmpxchg(&l->oldest, oldest_id, next) == oldest_id) {
> +			/* removed successfully */
> +			break;
> +		}

This is supposed to be cmpxchg_relaxed(), not cmpxchg(). I did not
intend to include the general mb() memory barriers around the RMW
operation. (For some reason I thought _relaxed was the default.) Sorry.

John Ogness
