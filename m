Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA1CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D53222312
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfKTIab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:30:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37145 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKTIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:30:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id g50so28050632qtb.4;
        Wed, 20 Nov 2019 00:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rytSK3v6D5ukw1aPCwUZyXrevrACIVrt8Cqsqzwdlc8=;
        b=kHWfBu2EBSOPYGwtUhvHSsC4zqxGn+RuKBUTet+0Xe3hp705xFiVGomZ2GU/V8pyid
         cOivOJsgB5bPwobret5UyKQ3HYTUSVixJQ5ly1+tqUBlSt74w3j4NzWu50OJey+mhhSe
         tEQEuSksZY0ax+fJJZ+CqFL34wT09iEjjvpg06zwlHt8iuu85Q0sP0yAetqQdm+TUcg+
         2EQaymiIZBUa5tLJMKnoAKno2mNK7yOVVwWb0p2d50c5cxOPhMLUhTK44HtItqlPAqP2
         BmY5d2kravKoGpuQwOe/sjUqIKkD1h/gxL8APUobTfIJOk7GT6d4IF7R4Zg8Ec2fJQL6
         Mr4g==
X-Gm-Message-State: APjAAAXVqN/76m4qUIKjG5kczhrEyskU/R+K0uZdqjNv5q0mqx5cpIqc
        T9ouqUV/Ul64TZ+0y7q02NHMzRVai+YztFtFHctyek2s
X-Google-Smtp-Source: APXvYqzt9977Jz1rHm4q1nzL1okKoUsy1hMgVgphzGxtMK8FnUMP0veAcJ4G9WbR6glS3oU1ESQ4SZ8PXgwAmKfdP+Y=
X-Received: by 2002:ac8:35c4:: with SMTP id l4mr1437198qtb.151.1574238630355;
 Wed, 20 Nov 2019 00:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com> <802dc73e-080d-05aa-76fe-165bb4817959@infradead.org>
In-Reply-To: <802dc73e-080d-05aa-76fe-165bb4817959@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Nov 2019 09:30:18 +0100
Message-ID: <CAMuHMdUyN5FE21C3Bu6S4wrwTxe0xB2ZpPAgryvx_6EX+YkhFw@mail.gmail.com>
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, Nov 20, 2019 at 5:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
> > On Tue, Nov 19, 2019 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >> Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
> >> SYS_SUPPORTS_SMP and SMP.
> >>
> >> kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
> >> code + data inside topology.c is only built when CONFIG_NUMA is
> >> set/enabled, so these arch/sh/ configs need to select SMP and
> >> SYS_SUPPORTS_SMP to build the NUMA support.
> >>
> >> Fixes this build error in 3 different SUPERH configs:
> >>
> >> mm/page_alloc.o: In function `get_page_from_freelist':
> >> page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> Cc: Rich Felker <dalias@libc.org>
> >> Cc: linux-sh@vger.kernel.org
> >> ---
> >> or maybe these should be fixed in the defconfig files?
> >>
> >> or alternatively, does it make any sense to support NUMA without SMP?
> >
> > I think it does.  From arch/sh/mm/Kconfig config NUMA help:
> >
> >         Some SH systems have many various memories scattered around
> >         the address space, each with varying latencies. This enables
> >         support for these blocks by binding them to nodes and allowing
> >         memory policies to be used for prioritizing and controlling
> >         allocation behaviour.
>
> Note that this help text is under:
> config NUMA
>         bool "Non-Uniform Memory Access (NUMA) Support"
>         depends on MMU && SYS_SUPPORTS_NUMA
>         select ARCH_WANT_NUMA_VARIABLE_LOCALITY
>
> but ARCH_WANT_NUMA_VARIABLE_LOCALITY seems to be unimplemented anywhere in
> the kernel source tree.  I.e., the Kconfig symbol exists in init/Kconfig,
> but there is no code to support its use.

It does control (prevent) another option:

# For architectures that (ab)use NUMA to represent different memory regions
# all cpu-local but of different latencies, such as SuperH.
#
config ARCH_WANT_NUMA_VARIABLE_LOCALITY
        bool

config NUMA_BALANCING
        bool "Memory placement aware NUMA scheduler"
        depends on ARCH_SUPPORTS_NUMA_BALANCING
        depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
        depends on SMP && NUMA && MIGRATION
        help
          This option adds support for automatic NUMA aware
memory/task placement.
          The mechanism is quite primitive and is based on migrating memory when
          it has references to the node the task is running on.

          This system will be inactive on UMA systems.

The symbol was set by arch/metag, too (which was removed).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
