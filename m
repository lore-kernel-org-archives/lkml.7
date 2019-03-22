Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BBF21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZVItmiS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfCVRZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:25:30 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37782 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfCVRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oETpZyH7xLKUdQHFKiHuSJuVBCjYUIIZETTJzqHKcsc=; b=ZVItmiS/eWU+t+u/Ypr3JsIfH
        K7gIVIjf/tMjHU4ClkIDbVc0xR0NNLF0n2wa84s5q/gE/RJhZVCvd6fK2BNDfxu1OEk0mYW6Lxe7q
        sC878zm3M3R4xuyn5EQKV8utKNN6YSO3kcgC8Z2P6R2io6qHXXWUfM93/Ov1/3+ISTVKCxVxfdeDX
        PVBv72GKBfeUmK+m8QEwUJ4ZgLNUaSU3cKPuLzRsEu+5uvRBLZJnNeejkUlyxFeYXi169VW+wjQc0
        N/vQusiIGyjYjOyaXtJOkcSeuERNZ5lHhz/nfZftS80Z3QEJEyuhGvEhBze/s0OwRLKs+0Mt+5wAq
        NBOeDpgHA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55184)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h7Nus-0002MI-Vr; Fri, 22 Mar 2019 17:25:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h7Nuf-0000lO-F7; Fri, 22 Mar 2019 17:25:01 +0000
Date:   Fri, 22 Mar 2019 17:25:01 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        x86@kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
        linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-parisc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        nios2-dev@lists.rocketboards.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/3] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190322172501.3nbjw6e2wqsaisgw@shell.armlinux.org.uk>
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322143008.21313-4-longman@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 10:30:08AM -0400, Waiman Long wrote:
> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> it generate slightly better code.
> 
> Before this patch, down_read_trylock:
> 
>    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
>    0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
>    0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
>    0x000000000000000b <+11>:    mov    %rdx,%rax
>    0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
>    0x0000000000000013 <+19>:    cmp    %rax,%rdx
>    0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
>    0x0000000000000018 <+24>:    mov    (%rdi),%rdx
>    0x000000000000001b <+27>:    test   %rdx,%rdx
>    0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
>    0x0000000000000020 <+32>:    xor    %eax,%eax
>    0x0000000000000022 <+34>:    retq
>    0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
>    0x000000000000002c <+44>:    or     $0x3,%rax
>    0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
>    0x0000000000000034 <+52>:    mov    $0x1,%eax
>    0x0000000000000039 <+57>:    retq
> 
> After patch, down_read_trylock:
> 
>    0x0000000000000000 <+0>:	callq  0x5 <down_read_trylock+5>
>    0x0000000000000005 <+5>:	xor    %eax,%eax
>    0x0000000000000007 <+7>:	lea    0x1(%rax),%rdx
>    0x000000000000000b <+11>:	lock cmpxchg %rdx,(%rdi)
>    0x0000000000000010 <+16>:	jne    0x29 <down_read_trylock+41>
>    0x0000000000000012 <+18>:	mov    %gs:0x0,%rax
>    0x000000000000001b <+27>:	or     $0x3,%rax
>    0x000000000000001f <+31>:	mov    %rax,0x20(%rdi)
>    0x0000000000000023 <+35>:	mov    $0x1,%eax
>    0x0000000000000028 <+40>:	retq
>    0x0000000000000029 <+41>:	test   %rax,%rax
>    0x000000000000002c <+44>:	jns    0x7 <down_read_trylock+7>
>    0x000000000000002e <+46>:	xor    %eax,%eax
>    0x0000000000000030 <+48>:	retq
> 
> By using a rwsem microbenchmark, the down_read_trylock() rate (with a
> load of 10 to lengthen the lock critical section) on a x86-64 system
> before and after the patch were:
> 
>                  Before Patch    After Patch
>    # of Threads     rlock           rlock
>    ------------     -----           -----
>         1           14,496          14,716
>         2            8,644           8,453
> 	4            6,799           6,983
> 	8            5,664           7,190
> 
> On a ARM64 system, the performance results were:
> 
>                  Before Patch    After Patch
>    # of Threads     rlock           rlock
>    ------------     -----           -----
>         1           23,676          24,488
>         2            7,697           9,502
>         4            4,945           3,440
>         8            2,641           1,603
> 
> For the uncontended case (1 thread), the new down_read_trylock() is a
> little bit faster. For the contended cases, the new down_read_trylock()
> perform pretty well in x86-64, but performance degrades at high
> contention level on ARM64.

So, 70% for 4 threads, 61% for 4 threads - does this trend
continue tailing off as the number of threads (and cores)
increase?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
