Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6032C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F48214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ndQakGne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfLLVJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:09:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbfLLVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NfTrfkPSa1ladziv/NA8uZx3AQzUk89ICwWABT2MQUM=; b=ndQakGnefV+QEporHtSLrSWtR
        lUPOben5zYX2quN3mRuu5nH6XQLIGJD4qLJxpk/tTXsSSN5K9TXLqkaKE0SzeAQqrCioBSVl/rG2i
        sHEQQ+bkq3+k5l2DUzwLOk3MnmgOg1D5ngV+WaSKu42rtnrxdZR5ASX1L6YQZ6WTuh5Be+YeOsNfe
        aer1pxdOHKR160osM9yf9iyalNAo/stwVksu/HSVgwN40oUFbJb1SpQcoYmux9WM5z6ExO291fjmN
        tA2CSMBcE6rU5IODAW8TSdU0WZpjWG8dxRdxFpXeXVkzvIuu6lIhczf5b8Kyz7/5/MDycrKgaTGLg
        z6wvSXDmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifViZ-0006So-Kf; Thu, 12 Dec 2019 21:09:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90D97980CCD; Thu, 12 Dec 2019 22:09:49 +0100 (CET)
Date:   Thu, 12 Dec 2019 22:09:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/
Message-ID: <20191212210949.GE11457@worktop.programming.kicks-ass.net>
References: <20191212210052.GA8906@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212210052.GA8906@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:00:52AM +0300, Alexey Dobriyan wrote:
> > We could move the kernel to C++ and write:
> > 
> > 	std::remove_volatile<typeof(p)>::type __p = (p);
> > 
> > /me runs like hell...
> 
> Did you just said I can send "struct sched_domain::private" and
> "struct wait_queue_entry::private" rename?
> :^)

I don't believe those are the only usage of C++ keywords. IIRC I'm using
'class' somewhere as well.

> Doable but not until C++20. constinit and designated initializers are
> pretty mandatory.
> 
> Debian GNU/Linux 8 debian88 ttyS0
> 
> debian88 login: root
> Password:
> Last login: Thu Sep 19 01:04:29 +03 2019 on tty1
> Linux debian88 5.3.0+ #1 SMP PREEMPT Thu Sep 19 01:02:26 +03 2019 x86_64
> root@debian88:~# cat /proc/$(pgrep sshd)/stack
> [<0>] _ZL9do_selectiP11fd_set_bitsP10timespec64+0x5ac/0x750
> [<0>] _Z15core_sys_selectiP15__kernel_fd_setS0_S0_P10timespec64+0x143/0x260

Argh.. I forgot how I hated mangled names.

> [<0>] __x64_sys_select+0xa7/0xf0
> [<0>] do_syscall_64+0x3b/0xe7
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
