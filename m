Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD2C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11972206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZjaefs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbfIHBbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:31:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34337 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbfIHBbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:31:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so5667778pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=poARC7nH5qyqXeO1x1xXars1F6UE2Nd7PqDJ8pU4Urk=;
        b=kZjaefs2zu6FFETZgXJy9uQeDexA+5X+zHA3jNCd7M5n3DBm6A8/1M4Z0unIUxLTdy
         P8VsVJElFxrAtU5jH3hsz9R9rA06yp3G1VaOcb4t0XbrmEZjwH3Vp9ft31CtZrJuwu7d
         KEr7FH1haPzjq1rvLWNztwhnxjS3GGe7VI+sltejF1AvKppydtPcEZ16+UbrzMMXUBLW
         r7irjhYhHHoBG0bIWiamPlp6vvvL/QFcv069dG4QDeofGeTI7NBF7ZHiEnRpsnIgbPkj
         foQ2yEkJXphrgvUJY5NaizJ9EbLmyCkm6b58gaooRVz9N0XN4c/uXmOF/M0B0sqoaUiS
         t8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=poARC7nH5qyqXeO1x1xXars1F6UE2Nd7PqDJ8pU4Urk=;
        b=kbDV+WaRXTi3Y6/KGWE+uNFmIWLog5hQA5lwx0hYJrDQXZgFCdtd4M0CK1cu+VtTTh
         VYvPjg0lamFb/mwmaEUMEGXotSIie8fZsZi0uBHaFsXqiGb1HvBwaO8MdkQx4Xz3kV7u
         rP9jy3lCHN8G9wc6YjF4nUVFH8ZCFGltOMfa3N3R3czAhHSf93X5Z7gMfHUDyQsrqxO3
         d+Wj8wi8kwU+AnvYCazBrUL2Adi8Az+5mPRUmRzZJb7lqDJ0hMB1zGvgaxBhJrnS2Sl2
         u1Fe7wdGi3i6p0Ud5vJfE5Zoq+rdkjiauwOGSngDkdD2MlQyjSOzXaOrtOl8k7NjaJ55
         2VuQ==
X-Gm-Message-State: APjAAAVLoYogD6WO5/yuySXG7WXqqVTmjpc6suB4S9DbdD/YFoP7OV3U
        jq73fwmq7QohkwCnMK/ZzPQ=
X-Google-Smtp-Source: APXvYqwpSiBHk13x0CBCroReB4e0aIeJ3WDsV98VZtO/j/eSiS9nW/gVnPUvagx3S8Dxa88f1zyGeg==
X-Received: by 2002:a65:6288:: with SMTP id f8mr14645161pgv.292.1567906261589;
        Sat, 07 Sep 2019 18:31:01 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id j10sm9805008pjn.3.2019.09.07.18.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:31:01 -0700 (PDT)
Date:   Sun, 8 Sep 2019 09:30:54 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] kconfig/hacking: make 'kernel hacking' menu better
 structured
Message-ID: <20190908013053.zqwivb5t4fcepcey@mail.google.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a preview:
  │ ┌───────────────────────────────────────────────────────────────────┐ │
  │ │        printk and dmesg options  --->                             │ │
  │ │        Compile-time checks and compiler options  --->             │ │
  │ │        Generic Kernel Debugging Instruments  --->                 │ │
  │ │    -*- Kernel debugging                                           │ │
  │ │    [*]   Miscellaneous debug code                                 │ │
  │ │        Memory Debugging  --->                                     │ │
  │ │        IRQ Debugging  --->                                        │ │
  │ │        Debug Oops, Lockups and Hangs  --->                        │ │
  │ │        Scheduler Debugging  --->                                  │ │
  │ │    [*] Enable extra timekeeping sanity checking                   │ │
  │ │        Lock Debugging (spinlocks, mutexes, etc...)  --->          │ │
  │ │    -*- Stack backtrace support                                    │ │
  │ │    [ ] Warn for all uses of unseeded randomness                   │ │
  │ │    [ ] kobject debugging                                          │ │
  │ │        Debug kernel data structures  --->                         │ │
  │ │    [ ] Debug notifier call chains                                 │ │
  │ │    [ ] Debug credential management                                │ │
  │ │        RCU Debugging  --->                                        │ │
  │ │    [ ] Force round-robin CPU selection for unbound work items     │ │
  │ │    [ ] Force extended block device numbers and spread them        │ │
  │ │    [ ] Enable CPU hotplug state control                           │ │
  │ │    [*] Latency measuring infrastructure                           │ │
  │ │    [*] Tracers  --->                                              │ │
  │ │    [ ] Remote debugging over FireWire early on boot               │ │
  │ │    [*] Sample kernel code  --->                                   │ │
  │ │    [*] Filter access to /dev/mem                                  │ │
  │ │    [ ]   Filter I/O access to /dev/mem                            │ │
  │ │        x86 Debugging  --->                                        │ │
  │ │        Kernel Testing and Coverage  --->                          │ │
  │ │                                                                   │ │
  │ │                                                                   │ │
  │ └───────────────────────────────────────────────────────────────────┘ │
  ├───────────────────────────────────────────────────────────────────────┤
  │       <Select>    < Exit >    < Help >    < Save >    < Load >        │
  └───────────────────────────────────────────────────────────────────────┘

On Sun, Sep 08, 2019 at 09:27:52AM +0800, Changbin Du wrote:
> This series is a trivial improvment for the layout of 'kernel hacking'
> configuration menu. Now we have many items in it which makes takes
> a little time to look up them since they are not well structured yet.
> 
> Early discussion is here:
> https://lkml.org/lkml/2019/9/1/39
> 
> Changbin Du (8):
>   kconfig/hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging
>     Instruments'
>   kconfig/hacking: Create submenu for arch special debugging options
>   kconfig/hacking: Group kernel data structures debugging together
>   kconfig/hacking: Move kernel testing and coverage options to same
>     submenu
>   kconfig/hacking: Move Oops into 'Lockups and Hangs'
>   kconfig/hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
>   kconfig/hacking: Create a submenu for scheduler debugging options
>   kconfig/hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
> 
>  lib/Kconfig.debug | 627 ++++++++++++++++++++++++----------------------
>  1 file changed, 324 insertions(+), 303 deletions(-)
> 
> -- 
> 2.20.1
> 

-- 
Cheers,
Changbin Du
