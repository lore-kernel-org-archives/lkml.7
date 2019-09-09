Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F0C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9461C206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JU7/JELG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfIIQzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:55:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfIIQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
        Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3fWTUyRxX0mvy7shQ7gKeWr5v7P/Tt6F0XOk74ciJFA=; b=JU7/JELGI4YFnkDhrJWcATIm8
        fmXDWLHGf7GgyQIqzLWrkrWt2Jn1HmF5XRf+BXR8i5cxcHEeuIaDY/DrYwB0gLcN0UyAzfFcrtaoy
        Kp1yjwOwWWFoUI+KfhOvAiXlVrUkdjZIAVlbXH3PKmDKWbuLomDz5+OQnGhzx7PTXpcJGKAy8PR9U
        9dc2ctrWHNnXhXv+qPx2Cg93DkTFNFO48SPjLzxvSzODe0UX/i7nGR7EduFnq4NkbwGhNAss4bwiv
        Bd0JoQ1625cnbFAfASUWSd4xPMKkE1+orhVW3QhDQOhvfGZc0+5Z5LT/1GXxOdeTBk7l1qvWu8bh/
        ITzAqNpkg==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7MxF-00073u-Ur; Mon, 09 Sep 2019 16:55:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 0/9] hacking: make 'kernel hacking' menu better
 structurized
To:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20190909144453.3520-1-changbin.du@gmail.com>
Message-ID: <da2774e1-fc41-0dde-01ed-0607920ce762@infradead.org>
Date:   Mon, 9 Sep 2019 09:53:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/19 7:44 AM, Changbin Du wrote:
> This series is a trivial improvment for the layout of 'kernel hacking'
> configuration menu. Now we have many items in it which makes takes
> a little time to look up them since they are not well structurized yet.
> 
> Early discussion is here:
> https://lkml.org/lkml/2019/9/1/39
> 
> This is a preview:
> 
>   │ ┌─────────────────────────────────────────────────────────────────────────┐ │  
>   │ │        printk and dmesg options  --->                                   │ │  
>   │ │        Compile-time checks and compiler options  --->                   │ │  
>   │ │        Generic Kernel Debugging Instruments  --->                       │ │  
>   │ │    -*- Kernel debugging                                                 │ │  
>   │ │    [*]   Miscellaneous debug code                                       │ │  
>   │ │        Memory Debugging  --->                                           │ │  
>   │ │    [ ] Debug shared IRQ handlers                                        │ │  
>   │ │        Debug Oops, Lockups and Hangs  --->                              │ │  
>   │ │        Scheduler Debugging  --->                                        │ │  
>   │ │    [*] Enable extra timekeeping sanity checking                         │ │  
>   │ │        Lock Debugging (spinlocks, mutexes, etc...)  --->                │ │  
>   │ │    -*- Stack backtrace support                                          │ │  
>   │ │    [ ] Warn for all uses of unseeded randomness                         │ │  
>   │ │    [ ] kobject debugging                                                │ │  
>   │ │        Debug kernel data structures  --->                               │ │  
>   │ │    [ ] Debug credential management                                      │ │  
>   │ │        RCU Debugging  --->                                              │ │  
>   │ │    [ ] Force round-robin CPU selection for unbound work items           │ │  
>   │ │    [ ] Force extended block device numbers and spread them              │ │  
>   │ │    [ ] Enable CPU hotplug state control                                 │ │  
>   │ │    [*] Latency measuring infrastructure                                 │ │  
>   │ │    [*] Tracers  --->                                                    │ │  
>   │ │    [ ] Remote debugging over FireWire early on boot                     │ │  
>   │ │    [*] Sample kernel code  --->                                         │ │  
>   │ │    [*] Filter access to /dev/mem                                        │ │  
>   │ │    [ ]   Filter I/O access to /dev/mem                                  │ │  
>   │ │    [ ] Additional debug code for syzbot                                 │ │  
>   │ │        x86 Debugging  --->                                              │ │  
>   │ │        Kernel Testing and Coverage  --->                                │ │  
>   │ │                                                                         │ │  
>   │ │                                                                         │ │  
>   │ └─────────────────────────────────────────────────────────────────────────┘ │  
>   ├─────────────────────────────────────────────────────────────────────────────┤  
>   │          <Select>    < Exit >    < Help >    < Save >    < Load >           │  
>   └─────────────────────────────────────────────────────────────────────────────┘ 
> 
> v3:
>   o change subject prefix.
> v2:
>   o rebase to linux-next.
>   o move DEBUG_FS to 'Generic Kernel Debugging Instruments'
>   o move DEBUG_NOTIFIERS to 'Debug kernel data structures'
> 
> Changbin Du (9):
>   hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging
>     Instruments'
>   hacking: Create submenu for arch special debugging options
>   hacking: Group kernel data structures debugging together
>   hacking: Move kernel testing and coverage options to same submenu
>   hacking: Move Oops into 'Lockups and Hangs'
>   hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
>   hacking: Create a submenu for scheduler debugging options
>   hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
>   hacking: Move DEBUG_FS to 'Generic Kernel Debugging Instruments'
> 
>  lib/Kconfig.debug | 659 ++++++++++++++++++++++++----------------------
>  1 file changed, 340 insertions(+), 319 deletions(-)

Hi,
Looks good to me.

I verified that the before and after kernel .config file contains the same
symbols and values (for allmodconfig).
I also tested with menuconfig, nconfig, gconfig, and xconfig.

for all 9 patches:
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
