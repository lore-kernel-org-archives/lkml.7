Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21820C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 12:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D976D2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 12:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ljWOUTfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfCJMrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 08:47:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42970 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCJMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 08:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IYURsCA7wYU7KPGkG0eMg3FFUlv0OL24IBlYWRvSY80=; b=ljWOUTfjUyWPg+/2qW6nDZE3e
        RywceWyEes4pVx64URDPE0Rdd1Mu0vUVhQbeFSPhy4amXha92byt+57j1ksXFcNzOjc0w0zHhhUtb
        ZBIZZWusAUMeauUNEQiX9PTUXAS/PAmOxoTBuG/KTggDFTUparVVp2eU5JFW9kyT2Gf/1T/KBN3m2
        9cwku/ehcVLJ/QeHfRVwrcKZhlMA4yMu2PKwobCcK8LWiYTSpcuSJqz3Iyp+lirYy0Mm+8zV6KXwN
        kaPGqgdi/wpvYKD7FHRh0ZNiWY+hLRsU2XqR/kjmtHZ5ITrQ+g+UWjabc++JzJo39IFbdDj4r8pG8
        Lp5XUUhZw==;
Received: from [188.207.104.17] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2xqv-0003uw-Lr; Sun, 10 Mar 2019 12:46:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F202981BBE; Sun, 10 Mar 2019 13:46:50 +0100 (CET)
Date:   Sun, 10 Mar 2019 13:46:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/percpu semantics and fixes
Message-ID: <20190310124650.GA6840@worktop.programming.kicks-ass.net>
References: <20190227101252.413192716@infradead.org>
 <20190308145031.GY32494@hirez.programming.kicks-ass.net>
 <64526663-1F10-42A6-A005-92657264D587@vmware.com>
 <20190308205637.GC2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308205637.GC2482@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:56:37PM +0100, Peter Zijlstra wrote:

> Anyway, can anybody explain percpu_stable_op() vs percpu_from_op() ?
> 
> I'm thinking of a variant of Linus' patch, but I'm confused about the
> above.

So whatever I tried with +m only made things worse and always affects
thousands of symbols.

Now, afaict the whole percpu_stable_op thing is an ugly hack becaues some
earlier compiler would not CSE the regular percpu_from_op. But since it
does do that today; esp. after my first patch, I tried implementing
this_cpu_read_stable() with percpu_from_op() (no volatile, obv).

That also affects _lots_ of sites, but also significantly shrinks the
kernel image.

It's 2307 symbols affected, but:

17642871        2157438  747808 20548117        1398a15 defconfig-build1/vmlinux.o (patch 1)
17639081        2157438  747808 20544327        1397b47 defconfig-build0/vmlinux.o (patch 1 - percpu_stable_op)

So I think I'll add a patch removing percpu_stable_op and all its users.
