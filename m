Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52955C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179702086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8f6fj7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfIIOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:41:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45051 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfIIOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:41:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id k1so6613135pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uC05T6OzEgW6D9R47LZsBlTEyshQuOy1KHz8dbUIb8o=;
        b=K8f6fj7wGOOqNPpcQly1pOiFKD1s06y8nbYHIcGqWDK5/tkTEZTn2r29GcU+BA4w3J
         sIMJ8+7jTEFe9fZneGa3yGXejF97V2liZtBK007iPvakM3l53zO6XmJqTmpcDJJbLoLt
         +7YBWm2nhnDRv4oCeF7uYlo58n6yUOdhsX/XocOMgvWEp+d57hlOcsPKZiHp7U/i+2mE
         GjuAYmtLP+cbK+zN8yeLEn6wh6BBhj7vTh4VKStK43ndddjdl6nv3NP604nMK6XYm7+q
         ppUPbRfNIqAI6Wr4b2VwHCsYrgm314bR2ReKa9j8MQCGj1yFNcf8WC8yLgmUQkHMNzuZ
         Fl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uC05T6OzEgW6D9R47LZsBlTEyshQuOy1KHz8dbUIb8o=;
        b=FiRnKqQ655FRD4gWKLzeQdQ42dVWSIvJEVaYrZZCvks27hA2IvpyY7zy9glveT3C16
         kr7EPqqj6OM8FFBAOi49SUgbsEJLwc3v2RxW1gbA86RbBihDNNlkwUXnxedg67lO6SfA
         WsTnNumbArDjKkQCSEy97CncrnoYFIgyPgV+lAzZd6yKB8xCWSHnJzHXEEBUtS0l7ajn
         k5PqcR0ep3in6GX0GxdEo/YIZjJqpOcr0qja3MhaDmORsj407/NFZXlcpp50IMTVnylh
         3DSt8J7qbTEafzza2GT6hMs7V9x7xWSypGH9v35l2yLVQdDjLt3zKRDICynwRUDhzW3Y
         YCRw==
X-Gm-Message-State: APjAAAW+zwHZdZKHNmYa3evZjxho0A4CsPQBO6ZJbZ5lTcoAXPpjCLHF
        XoWg7YMjq24gRdVySdDs7XU=
X-Google-Smtp-Source: APXvYqz7Fyqy75Z6D/c9N4gu+v8aZvhuGRGMzGj1ncnyIlLTGRfUpFR428NmBRDeG1BkIhoqVgoxiA==
X-Received: by 2002:a17:902:7613:: with SMTP id k19mr24582377pll.89.1568040101043;
        Mon, 09 Sep 2019 07:41:41 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id l6sm36565606pje.28.2019.09.09.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:41:40 -0700 (PDT)
Date:   Mon, 9 Sep 2019 22:41:32 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] kconfig/hacking: make 'kernel hacking' menu
 better structurized
Message-ID: <20190909144130.4xvir2svtcizlc2g@mail.google.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
 <CAK7LNAQGk_4f-aGVH3bxZdNna_gdHEBHeD6DNwY49Q5kxU=U7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQGk_4f-aGVH3bxZdNna_gdHEBHeD6DNwY49Q5kxU=U7w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 11:31:10PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> On Mon, Sep 9, 2019 at 11:18 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This series is a trivial improvment for the layout of 'kernel hacking'
> > configuration menu. Now we have many items in it which makes takes
> > a little time to look up them since they are not well structurized yet.
> 
> 
> Could you please change the subject prefix "kconfig/hacking:" ?
> ("hacking:" , "debug:" or whatever, but no "kconfig")
>
sure, I pick 'hacking'.

> I just opened this thread just in case it might be related to kconfig,
> but it was not.
> 
> Thanks.
> 
> 
> 
> 
> 
> 
> > Early discussion is here:
> > https://lkml.org/lkml/2019/9/1/39
> >
> > This is a preview:
> >
> >   │ ┌─────────────────────────────────────────────────────────────────────────┐ │
> >   │ │        printk and dmesg options  --->                                   │ │
> >   │ │        Compile-time checks and compiler options  --->                   │ │
> >   │ │        Generic Kernel Debugging Instruments  --->                       │ │
> >   │ │    -*- Kernel debugging                                                 │ │
> >   │ │    [*]   Miscellaneous debug code                                       │ │
> >   │ │        Memory Debugging  --->                                           │ │
> >   │ │    [ ] Debug shared IRQ handlers                                        │ │
> >   │ │        Debug Oops, Lockups and Hangs  --->                              │ │
> >   │ │        Scheduler Debugging  --->                                        │ │
> >   │ │    [*] Enable extra timekeeping sanity checking                         │ │
> >   │ │        Lock Debugging (spinlocks, mutexes, etc...)  --->                │ │
> >   │ │    -*- Stack backtrace support                                          │ │
> >   │ │    [ ] Warn for all uses of unseeded randomness                         │ │
> >   │ │    [ ] kobject debugging                                                │ │
> >   │ │        Debug kernel data structures  --->                               │ │
> >   │ │    [ ] Debug credential management                                      │ │
> >   │ │        RCU Debugging  --->                                              │ │
> >   │ │    [ ] Force round-robin CPU selection for unbound work items           │ │
> >   │ │    [ ] Force extended block device numbers and spread them              │ │
> >   │ │    [ ] Enable CPU hotplug state control                                 │ │
> >   │ │    [*] Latency measuring infrastructure                                 │ │
> >   │ │    [*] Tracers  --->                                                    │ │
> >   │ │    [ ] Remote debugging over FireWire early on boot                     │ │
> >   │ │    [*] Sample kernel code  --->                                         │ │
> >   │ │    [*] Filter access to /dev/mem                                        │ │
> >   │ │    [ ]   Filter I/O access to /dev/mem                                  │ │
> >   │ │    [ ] Additional debug code for syzbot                                 │ │
> >   │ │        x86 Debugging  --->                                              │ │
> >   │ │        Kernel Testing and Coverage  --->                                │ │
> >   │ │                                                                         │ │
> >   │ │                                                                         │ │
> >   │ └─────────────────────────────────────────────────────────────────────────┘ │
> >   ├─────────────────────────────────────────────────────────────────────────────┤
> >   │          <Select>    < Exit >    < Help >    < Save >    < Load >           │
> >   └─────────────────────────────────────────────────────────────────────────────┘
> >
> > v2:
> >   o rebase to linux-next.
> >   o move DEBUG_FS to 'Generic Kernel Debugging Instruments'
> >   o move DEBUG_NOTIFIERS to 'Debug kernel data structures'
> >
> > Changbin Du (9):
> >   kconfig/hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging
> >     Instruments'
> >   kconfig/hacking: Create submenu for arch special debugging options
> >   kconfig/hacking: Group kernel data structures debugging together
> >   kconfig/hacking: Move kernel testing and coverage options to same
> >     submenu
> >   kconfig/hacking: Move Oops into 'Lockups and Hangs'
> >   kconfig/hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
> >   kconfig/hacking: Create a submenu for scheduler debugging options
> >   kconfig/hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
> >   kconfig/hacking: Move DEBUG_FS to 'Generic Kernel Debugging
> >     Instruments'
> >
> >  lib/Kconfig.debug | 659 ++++++++++++++++++++++++----------------------
> >  1 file changed, 340 insertions(+), 319 deletions(-)
> >
> > --
> > 2.20.1
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada

-- 
Cheers,
Changbin Du
