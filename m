Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E312DC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A9B2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IH7IK3ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfGAOKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:10:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfGAOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ND3leTtyQHL/47K3vzIhUCuphz+1LPNb9J1HXn7CNbc=; b=IH7IK3ZXhq0ixk2oUfkz6uCEF
        HMUZCXPAqlfGDvsKEmZHHboNrh9Nb5fjoc2rQasTCIIgIqOhMQASuvG7oYDlu4UG9cOI7+D9r4TU7
        m+9PG09VKkxYJBFtGqCKdeudta5L6LVOh7i0wsTNzxnJEzPT5gIuQVBymXWAFygobiYnJqNmkIQuY
        SV7WcQBaSGGQ9Z2JcuaOdt2LBpD+0GSCEVKvq423krhlfZOPKBg65py1oYyLDhN0/AWA/IBh5yRM5
        kDkH8i5VXFw2ywJ3QyMBtvG7w1isj6uEMzd/mVhkYqfmwHz1Ba03yLIQLl3M9+pKCLVedWV8hS1TU
        oCrBNPRng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhx0w-0008IZ-F8; Mon, 01 Jul 2019 14:10:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25DC020963E3D; Mon,  1 Jul 2019 16:10:37 +0200 (CEST)
Date:   Mon, 1 Jul 2019 16:10:37 +0200
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
Message-ID: <20190701141037.GY3402@hirez.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
 <87k1df28x4.fsf@linutronix.de>
 <20190626224034.GK2490@worktop.programming.kicks-ass.net>
 <87mui2ujh2.fsf@linutronix.de>
 <20190628154435.GZ7905@worktop.programming.kicks-ass.net>
 <877e92f388.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e92f388.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 12:39:35PM +0200, John Ogness wrote:

> Thanks. I overlooked that subtle detail. Can I assume NMIs do not exist
> on architectures that need to implement locking for cmpxchg()? Or did I
> just hit a major obstacle?

I think that is a fair assumption, I'm not aware of anybody having NMIs
_and_ 'broken' atomics.

Then again, we also have ARCH_HAVE_NMI_SAFE_CMPXCHG.
