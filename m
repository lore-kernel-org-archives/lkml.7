Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D2C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2594020873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Znq1UXh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfFRLXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:23:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfFRLXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zp5AooaLXIN2zMPxGFL82LcIQK5jh+gkBGpk8JLf+1Q=; b=Znq1UXh362Oz3PQTLfHTJX6KJ
        NJd3/ib4+L1srDfuk06XsBY2B3g09LiLAcNOcDSkhukHqDG0e4gC5mSmVnDtQsSqcG5kADGFoXnks
        nge0t+S4n1cO6l0Gou22MdfwQ96GUYbs6Biu4UlLQalmQoMLkUCudOZ1k/oXVPGBmSAe6XcxpDuo/
        ETxfN7dFyW54oxlPqueJFDWHpxJjAc5uNrtAb87lJ0DQ+p+5i2ZinOg08S4TGbJgDYCVJzDO7Bnrl
        gvpCROz3KjfWwpkyHPwgMjTulXWeyCMJgvX8ovL2fnAaoQHSU7w3inBg6+p7EXBfe/TWN2IsJE98x
        mUhzC94dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdCCF-0000UT-Ez; Tue, 18 Jun 2019 11:22:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C81EE20A3C471; Tue, 18 Jun 2019 13:22:37 +0200 (CEST)
Date:   Tue, 18 Jun 2019 13:22:37 +0200
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
Message-ID: <20190618112237.GP3436@hirez.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607162349.18199-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 06:29:48PM +0206, John Ogness wrote:
> +/**
> + * DOC: memory barriers

What's up with that 'DOC' crap?

> + *
> + * Writers
> + * -------
> + * The main issue with writers is expiring/invalidating old data blocks in
> + * order to create new data blocks. This is performed in 6 steps that must
> + * be observed in order by all writers to allow cooperation. Here is a list
> + * of the 6 steps and the named acquire/release memory barrier pairs that
> + * are used to synchronized them:
> + *
> + * * old data invalidation (MB1): Pushing rb.data_list.oldest forward.
> + *   Necessary for identifying if data has been expired.
> + *
> + * * new data reservation (MB2): Pushing rb.data_list.newest forward.
> + *   Necessary for validating data.
> + *
> + * * assign the data block to a descriptor (MB3): Setting data block id to
> + *   descriptor id. Necessary for finding the descriptor associated with th
> + *   data block.
> + *
> + * * commit data (MB4): Setting data block data_next. (Now data block is
> + *   valid). Necessary for validating data.
> + *
> + * * make descriptor newest (MB5): Setting rb.descr_list.newest to descriptor.
> + *   (Now following new descriptors will be linked to this one.) Necessary for
> + *   ensuring the descriptor's next is set to EOL before adding to the list.
> + *
> + * * link descriprtor to previous newest (MB6): Setting the next of the
> + *   previous descriptor to this one. Necessary for correctly identifying if
> + *   a descriptor is the only descriptor on the list.
> + *
> + * Readers
> + * -------
> + * Readers only make of smb_rmb() to ensure that certain critical load
> + * operations are performed in an order that allows readers to evaluate if
> + * the data they read is really valid.
> + */

This isn't really helping much I feel. It doesn't begin to describe the
ordering. But maybe the code makes more sense.
