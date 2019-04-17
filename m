Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C382FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0AE2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHdqJATL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfDQAjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:39:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43976 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDQAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:39:15 -0400
Received: by mail-yw1-f67.google.com with SMTP id j66so8004420ywc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 17:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7btjnZJJsVH7a05mL6N2+sPALOw8aN3snjUMwDiACKk=;
        b=oHdqJATLuyujGmQdpy6pAAy0MveEUBULsXkuuvniGSVnmwOa9ri25G42eDf0hzlQ3F
         xX76v+cuSENRVNKT8+5BRQEBz9hfV9B70W8Rb+efasNgf50WieX903q32kvbfYF4CU46
         ue5v+6c3f9TF9Wtf6qU3iI4ej8L7aP4P/dgW8wDa+ebC8Sq31iLngTjUarpiOhwQ/lnN
         uEifeCRbkvOPNUPZ5tySlMW4YcpxO6rEpK0T1gbcYcfnxLvh7IaaYstb/XVsCcOmdF4J
         r2ay+/4976s+d4vWjenT1xF4/RrpxXAv8QMUXjHhB52V3LIK2mfxOiKz4CBi2zb0PSpg
         zWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7btjnZJJsVH7a05mL6N2+sPALOw8aN3snjUMwDiACKk=;
        b=Nf+CJZu/botrgv2jMXJksmIvvl5uFIxoWc7aFp1i8fziU78nFdteObW1GYA10IvHgl
         VbgQQL1uoXJBvHTzZy2e7fblJ10JOYilfRE0pmc3twcxqQmhE86TVBzKJSwadNcAz0IR
         Pz+gOnuCZ6BypN3pzTp/r8Khk3OGF2HhcFiDxll8G8/EnjSlXA7gcyPCEq+UReSnyn8Z
         XA9NmdUkUvuh4TWE0KckZUlAbQvMcwxZtKK0Kr3f8DjOfwbMVFYVXKTrynwJki1Hdk2s
         QaGkQnX3dNpIJo+BLFFUCj+6339jM7ZX/bWJhdaFf7GKMNVzrQ3jQ/bUicgoLDVNTLs+
         qIgQ==
X-Gm-Message-State: APjAAAVARWLQ4uFAWTHxOeY9wAMQEo+Ba6rAYv2m3HikN9aO2cc4TFqa
        SKnKLUzd7NW2DuzUoJmUa4f2r/yaVvptd93uiNIJVQ==
X-Google-Smtp-Source: APXvYqx3IFpghy7cy1jpETVvvfxbT9vf+YbBghZ/XyV2Jd2vTunl3hvmSW6teNt9gMvXS3K/BXeVFrOu1n7dtKVIHsY=
X-Received: by 2002:a81:3c14:: with SMTP id j20mr66867617ywa.367.1555461554303;
 Tue, 16 Apr 2019 17:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <155544804466.1032396.13418949511615676665.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190416164418.3ca1d8cef2713a1154067291@linux-foundation.org> <CAPcyv4iJxyiGWqjGKLuRgjr9UgDO9ERSghUi3k597gk=X5votQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iJxyiGWqjGKLuRgjr9UgDO9ERSghUi3k597gk=X5votQ@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 16 Apr 2019 17:39:03 -0700
Message-ID: <CABXOdTdSNgEnn+mEk-X5ZWph8rCz+yW7EKiA-GHnZdsBC3rsNg@mail.gmail.com>
Subject: Re: [PATCH] init: Initialize jump labels before command line option parsing
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 5:04 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Apr 16, 2019 at 4:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 16 Apr 2019 13:54:04 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > When a module option, or core kernel argument, toggles a static-key it
> > > requires jump labels to be initialized early. While x86, PowerPC, and
> > > ARM64 arrange for jump_label_init() to be called before parse_args(),
> > > ARM does not.
> > >
> > >   Kernel command line: rdinit=/sbin/init page_alloc.shuffle=1 panic=-1 console=ttyAMA0,115200 page_alloc.shuffle=1
> > >   ------------[ cut here ]------------
> > >   WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:303
> > >   page_alloc_shuffle+0x12c/0x1ac
> > >   static_key_enable(): static key 'page_alloc_shuffle_key+0x0/0x4' used
> > >   before call to jump_label_init()
> > >   Modules linked in:
> > >   CPU: 0 PID: 0 Comm: swapper Not tainted
> > >   5.1.0-rc4-next-20190410-00003-g3367c36ce744 #1
> > >   Hardware name: ARM Integrator/CP (Device Tree)
> > >   [<c0011c68>] (unwind_backtrace) from [<c000ec48>] (show_stack+0x10/0x18)
> > >   [<c000ec48>] (show_stack) from [<c07e9710>] (dump_stack+0x18/0x24)
> > >   [<c07e9710>] (dump_stack) from [<c001bb1c>] (__warn+0xe0/0x108)
> > >   [<c001bb1c>] (__warn) from [<c001bb88>] (warn_slowpath_fmt+0x44/0x6c)
> > >   [<c001bb88>] (warn_slowpath_fmt) from [<c0b0c4a8>]
> > >   (page_alloc_shuffle+0x12c/0x1ac)
> > >   [<c0b0c4a8>] (page_alloc_shuffle) from [<c0b0c550>] (shuffle_store+0x28/0x48)
> > >   [<c0b0c550>] (shuffle_store) from [<c003e6a0>] (parse_args+0x1f4/0x350)
> > >   [<c003e6a0>] (parse_args) from [<c0ac3c00>] (start_kernel+0x1c0/0x488)
> > >
> > > Move the fallback call to jump_label_init() to occur before
> > > parse_args(). The redundant calls to jump_label_init() in other archs
> > > are left intact in case they have static key toggling use cases that are
> > > even earlier than option parsing.
> >
> > Has it been confirmed that this fixes
> > mm-shuffle-initial-free-memory-to-improve-memory-side-cache-utilization.patch
> > on beaglebone-black?
>
> This only fixes dynamically enabling the shuffling on 32-bit ARM.
> Guenter happened to run without the mm-only 'force-enable-always'
> patch and when he went to use the command line option to enable it he
> hit the jump-label warning.
>

For my part I have not seen the original failure; it seems that the
kernelci logs are no longer present. As such, I neither know how it
looks like nor how to (try to) reproduce it. I just thought it might
be worthwhile to run the patch through my boot tests to see if
anything pops up. From the feedback I got, though, it sounded like the
failure is/was very omap2 specific, so I would not be able to
reproduce it anyway.

Guenter

> The original beaglebone-black failure was something different and
> avoided this case because the jump-label was never used.
>
> I am otherwise unable to recreate the failure on either the original
> failing -next, nor on v5.1-rc5 plus the latest state of the patches. I
> need from someone who is actually still seeing the failure so they can
> compare with the configuration that is working for me. For reference
> that's the Yocto beaglebone-black defconfig:
>
> https://github.com/jumpnow/meta-bbb/blob/thud/recipes-kernel/linux/linux-stable-5.0/beaglebone/defconfig
