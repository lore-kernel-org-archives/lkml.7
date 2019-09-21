Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7B1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 02:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA7D20882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 02:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv4Pbmow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437536AbfIUCBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 22:01:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38392 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbfIUCBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 22:01:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so4853334pgi.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s7rtp8+3h4C3IBYEotoH2Fyo4uHZ7vD+FW4R7ZbbnDI=;
        b=Gv4Pbmow9JhD94n6wG5bhpKnRLFYA40dyIt6pmxcLVZmEzZr1Ey8FnYGVQuZqdIOAM
         jI8GElt2t21qJzODpn9NW2fHSXTqO/vkrbbM6k1hEBPjVArRAYO8QBREc5meA2sf11pL
         4H4bqrZ7NV1YNnfqZ519mkfzjxO3IcPivfI5tzEB5RwPCkZdT1CXZ+2rPUgIBrDFRf+s
         RjRUUeo7MTa02+oEAhYuxIedb9BX1GwDF+oXUjhXvhDFPx8H6fYplhOPI/GFHDLJ2twX
         HqmxQjAvbo+0Dvbmn9o1DLzNGCc9iUKXowqm3J6vIbmD0ZIeI8tSEhTHbevpdWJuiWnh
         2yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s7rtp8+3h4C3IBYEotoH2Fyo4uHZ7vD+FW4R7ZbbnDI=;
        b=b6GYOfGDEvMlwHGQ7+25yQvKc5wdMD11CaTNyI4//kn93rfB2L6LFntlGI6cQxmQBX
         fvUt7nxS7QUyA7AQBJlr7l9kYoyk9Jt8GXi2NKjvJML/MIopsaH389h1myDNXGiJMzfQ
         oJxfCgmAo5KGgpiyl7J1mpooTjDRRuFo/51qiZDk2iKQ/Mr/NSbZLMvKsCEYdosFvFZc
         eRFmcg+1M7pTz9E5f510oZ131mF/Q9DNRy0tSfdqRFZ9CBRyRlCcyhEtCXM+lnBQeYo8
         aVHMlZh8wMO+5yU8u28DgalPJMteikcimG1webk4ornlyOvF/AOsIHhrO+ZMVHUkG+Ga
         tG6g==
X-Gm-Message-State: APjAAAXrfoN5yJl3m5XnREMt8HaE3M6by7cwmkK479fCkEb4zmY+Uc9b
        5xITNf5c6AxEr6g1B2EmGog=
X-Google-Smtp-Source: APXvYqyChTjJK6QC7FB4M8ZRTh9P5ewwvNNN/MYq8qdkwssNssqOS1JPr99P8kDs6SOZgdZ0Q0YQ5w==
X-Received: by 2002:a62:2787:: with SMTP id n129mr20878331pfn.45.1569031305216;
        Fri, 20 Sep 2019 19:01:45 -0700 (PDT)
Received: from mail.google.com ([207.148.65.56])
        by smtp.gmail.com with ESMTPSA id m2sm4150039pff.154.2019.09.20.19.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 19:01:44 -0700 (PDT)
Date:   Sat, 21 Sep 2019 02:01:41 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] hacking: make 'kernel hacking' menu better
 structurized
Message-ID: <20190921020140.okm3pqdupvlt3hdq@mail.google.com>
References: <20190909144453.3520-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping for status of this series. thx!

On Mon, Sep 09, 2019 at 10:44:44PM +0800, Changbin Du wrote:
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
> 
> -- 
> 2.20.1
> 

-- 
Cheers,
Changbin Du
