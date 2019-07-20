Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E421EC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80042085A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="H9qV5v12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGTJMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 05:12:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33743 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfGTJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 05:12:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so29375425qtt.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9vzWV8Ca5ZiwBPqlX5aD97Lzj7PenGNrz85lKl2vuo=;
        b=H9qV5v12Wqel771w5xTXj+jziGxBFfS/uTmnakG2aeCUovo0UsALCPBQ2pOpL0ljPw
         dWAanbnmRfnE2Ltk9hiNcAfVyqWBuR6N+fa/ZnxsMQN9frYsbsgLFK6UY5X7H6kGvFOI
         v7gITakCnzoG6CEuL43YokrFmuiEXGHgbTFKiSSXTidlrMPylvV2olPM0th82hnsCUV9
         4ieTy5DpsKNkPCaaliCHPT3NEEs1xcEBSS11gyunIbK6Wjmr5yGE18WXV+G1uicw6QAv
         w8lvQ76SRqHzN+7NygzwyoIlmobDne94K5se2ZEGXszG7ITM5zFP1FavwLDUQ9L3Hzoi
         M3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9vzWV8Ca5ZiwBPqlX5aD97Lzj7PenGNrz85lKl2vuo=;
        b=rde2lwmyXPRSuk00TT2teqSGrP99HSE0vfh8SeBBfAuQ4KhxOWFKxqgGJlerm7DTvk
         VffY7pTc1nqeDcqILXUKzEKTdAGyacGqxwKk2TfPPfw6W5cjMiHeDnB1PZpE3LpIfP3U
         T25KJ1rAPGSb9jxhJ7kOLwiV7+uxTQocFy+NGYA/Qa5zLMuNN5nyN+snTjkUFDL2rqlT
         RSdWQmLI5XN4+MEO1/E+o0ju7+OYrQf670lw2maTszNoXFR2+GG0s7vttjklWrzB1yxz
         mXibVcFIup7VoWQjqIS0kE0F2nsEmeXaeRog+aBMyUgtvIGqFYGtHi7jyDJWCzsfvZwv
         9f1g==
X-Gm-Message-State: APjAAAWW3C+Mz3a4puGW4qdObgyKsGOEiur5yxTcKIdnSCJRpGOU44sX
        g5jEKQixu6qZ4h6Xnp3zmoW3dwTQCwso3gQU6M4=
X-Google-Smtp-Source: APXvYqwJ4BFSC+qGqZdtK/SwiFSTKqxi9AS9364/sZanXQ6+jrool4Px1bNT16XjF59ECzEG25/bsi2CR2aVtDMcrlM=
X-Received: by 2002:a0c:9214:: with SMTP id a20mr42018745qva.195.1563613941752;
 Sat, 20 Jul 2019 02:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com> <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Sat, 20 Jul 2019 10:12:10 +0100
Message-ID: <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 at 08:57, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 17 Jul 2019, Masahiro Yamada wrote:
> > On Wed, Jul 17, 2019 at 4:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > So instead of dealing with attempts to duct tape gold support without
> > > understanding the root cause and without support from the gold folks, fail
> > > the build when gold is detected.
> > >
> >
> > The code looks OK in the build system point of view.
> >
> > Please let me confirm this, just in case:
> > For now, we give up all architectures, not only x86, right?
>
> Well, that's the logical consequence of a statement which says: don't use
> gold for the kernel.
>
> > I have not not heard much from other arch maintainers.
>
> Cc'ed linux-arch for that matter.
>
> Thanks,
>
>         tglx

Hi

I've done a bit more digging, I had a second machine that was building
Linus's tree just fine with ld.gold

I tried forcing ld.bfd on the problem machine and got this:

ld.bfd: arch/x86/boot/compressed/head_64.o: warning: relocation in
read-only section `.head.text'
ld.bfd: warning: creating a DT_TEXTREL in object

I had a look at the differences in the kernel configs and noticed this:

CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0

Unsetting CONFIG_RANDOMIZE_BASE=y gets things working for me with ld.gold again

In light of this - can we drop this patch?

Cheers

Mike
