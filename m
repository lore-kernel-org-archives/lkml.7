Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA36BC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871DB20645
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhFedTGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfF0Sda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:33:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Sd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+YgjLvKpdVc3XIVqhIlEaP3FwXZDp6cS/xcLuWH3SKE=; b=DhFedTGxU8sBirStvD3v2SUEJ
        wAvytJ3Qr0r9/pdOVaZS12pL7fJPuybdBVRGQgb9RR2JBvAr+2sgwGSRbiebh+EMITIWsh/0B7mCM
        04Fq5YG+SjWjXvaRW0sd1BKBi3+kdZy5QtIGYMaG/l+kk6C7+a/qLNNiqyJoKHt8uiP9vGRz/RQos
        sTadM+9isZ7Dt9VsJ/0oIBwxUdi/ihZw5+tzjLdLk7ZZNfgpP9qUMZXNse40nOqStlHgbqa+NwC0U
        NEzmHWlz+rfnIPIAJpVj5ewE/EaVtOo/cVMrJ91Aawea/ArrtDF0hf+K5XrF3k2C+KsHXgOeBDkNf
        hiNh55hmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgZCc-0002hs-BS; Thu, 27 Jun 2019 18:32:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1AB598198F; Thu, 27 Jun 2019 00:53:15 +0200 (CEST)
Date:   Thu, 27 Jun 2019 00:53:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190626225315.GB8451@worktop.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
 <87k1df28x4.fsf@linutronix.de>
 <20190626224034.GK2490@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626224034.GK2490@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:40:34AM +0200, Peter Zijlstra wrote:
> You have a single linked list going from the tail to the head, while
> adding to the head and removing from the tail. And that sounds like a
> FIFO queue:
> 
> 	struct lqueue_head {
> 		struct lqueue_node *head, *tail;
> 	};
> 
> 	struct lqueue_node {
> 		struct lqueue_node *next;
> 	};
> 
> 	void lqueue_push(struct lqueue_head *h, struct lqueue_node *n)
> 	{
> 		struct lqueue_node *prev;
> 
> 		n->next = NULL;
> 		/*
> 		 * xchg() implies RELEASE; and thereby ensures @n is
> 		 * complete before getting published.
> 		 */
> 		prev = xchg(&h->head, n);
> 		/*
> 		 * xchg() implies ACQUIRE; and thereby ensures @tail is
> 		 * written after @head, see lqueue_pop()'s smp_rmb().
> 		 */
> 		if (prev)
> 			WRITE_ONCE(prev->next, n);
> 		else
> 			WRITE_ONCE(h->tail, n);
> 	}
> 
> 	struct lqueue_node *lqueue_pop(struct lqueue_head *h)
> 	{
> 		struct lqueue_node *head, *tail, *next;
> 
> 		do {
> 			tail = READ_ONCE(h->tail);
> 			/* If the list is empty, nothing to remove. */
> 			if (!tail)
> 				return NULL;
> 
> 			/*
> 			 * If we see @tail, we must then also see @head.
> 			 * Pairs with the xchg() in lqueue_push(),
> 			 * ensure no false positive on the singleton
> 			 * test below.

or is it false negative?, I'm too tired to think staight. What can
happen without the rmb is that the head load can get hoisted over the
tail load and then observe a NULL head and a !NULL tail and thus head !=
tail and we think there's multiple entries on the list and stuff goes
wobbly.

> 			 */
> 			smp_rmb();
> 			head = READ_ONCE(h->head);
> 
> 			/* If there is but one item; fail to remove. */
> 			if (head == tail)
> 				return NULL;
> 
> 			next = smp_cond_load_relaxed(&tail->next, VAL);
> 
> 		} while (cmpxchg(h->tail, tail, next) != tail);
> 
> 		return tail;
> 	}
