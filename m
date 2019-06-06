Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E51DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482F32083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfFFRac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:30:32 -0400
Received: from swift.blarg.de ([138.201.185.127]:37802 "EHLO swift.blarg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfFFRab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:30:31 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 13:30:30 EDT
Received: by swift.blarg.de (Postfix, from userid 1000)
        id C92E14030F; Thu,  6 Jun 2019 19:24:40 +0200 (CEST)
Date:   Thu, 6 Jun 2019 19:24:40 +0200
From:   Max Kellermann <max@blarg.de>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
Message-ID: <20190606172440.GA24838@swift.blarg.de>
Mail-Followup-To: Justin Piszcz <jpiszcz@lucidpixels.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
 <20190509111343.rvmy5noqlf4os3zk@box>
 <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/16 16:14, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> Kernel: 5.1.2
> 
> $ sudo cat /proc/$(pidof khugepaged)/stack
> [<0>] 0xffffffffffffffff
> 
> $ perf top
> 
>    PerfTop:    3716 irqs/sec  kernel:92.9%  exact: 99.1% lost: 68/68
> drop: 0/0 [4000Hz cycles],  (all, 12 CPUs)
> -------------------------------------------------------------------------------
> 
>     47.53%  [kernel]                 [k] compaction_alloc
>     38.88%  [kernel]                 [k] __pageblock_pfn_to_page
>      6.68%  [kernel]                 [k] nmi
>      0.58%  [kernel]                 [k] __list_del_entry_valid
>      0.48%  [kernel]                 [k] format_decode
>      0.39%  [kernel]                 [k] __rb_insert_augmented
>      0.25%  libdbus-1.so.3.19.9      [.] _dbus_string_hex_decode
>      0.24%  [kernel]                 [k] entry_SYSCALL_64_after_hwframe
>      0.20%  perf                     [.] rb_next
>      0.19%  perf                     [.] __symbols__insert

I have the same problem (kernel 5.1.7), but over here, it's a PHP
process, not khugepaged, which is looping inside compaction_alloc.

This is from "perf report":

   100.00%     0.00%  php-cgi7.0  php-cgi7.0         [.] 0x000055d0e88bc5ee
            |
            ---0x55d0e88bc5ee
               page_fault
               __do_page_fault
               handle_mm_fault
               __handle_mm_fault
               do_huge_pmd_anonymous_page
               __alloc_pages_nodemask
               __alloc_pages_slowpath
               __alloc_pages_direct_compact
               try_to_compact_pages
               compact_zone_order
               compact_zone
               migrate_pages
               compaction_alloc
               |          
               |--24.43%--__pageblock_pfn_to_page
               |          
                --2.22%--_cond_resched
                          |          
                           --0.89%--rcu_all_qs

ftrace:

           <...>-263514 [012] .... 109004.793009: rcu_all_qs <-_cond_resched
           <...>-263514 [012] .... 109004.793009: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793009: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793009: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793009: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793009: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793009: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793009: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793010: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: __pageblock_pfn_to_page <-compaction_alloc
           <...>-263514 [012] .... 109004.793011: _cond_resched <-compaction_alloc

(Repeating this sequence over and over.)

Nothing useful in /proc/263514/{stack,wchan,syscall}.

What else can I do to collect more information to aid fix this?

Max
