Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F71C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F30920854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="B5BHmYRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfCYGmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:42:24 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:58369 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfCYGmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:42:24 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2P6gH3B016514;
        Mon, 25 Mar 2019 15:42:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2P6gH3B016514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553496138;
        bh=LgQdWuJL8bNmI1YWcIHsJUQQGbgjm968J3Ixazu7mco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B5BHmYRn07ugANaqhyD5xO4JbB9Xbz4/RyPosjdApvptYCTdEHZJwF4S/cef5s3XL
         xgr8JBi3F9QqIHdtJhkDHV0z2ik2eS34K8r222LAa4L/PtKmua1/9+L9UcyHa15gEQ
         6troHDwfJJTRiGa1fvlcjYN8vUOLXMNKJnanzZqOvs3D5IEbf21ZetR2KbePZGg7Vy
         TGuZ3a2dWHy0yJS3E28btdsw7vDYtaA4a1fhUfSmr6wO/ZzS+1yqeaGTTL6AssOukR
         S9yWqFekaN0j2MMugIJLNVROpX/aiU2iaZRc/QLBJTo0AHLiKWAuZBU6YLJSPc3xGb
         j/OxosQ7PJ0ug==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id i207so4713344vsd.10;
        Sun, 24 Mar 2019 23:42:17 -0700 (PDT)
X-Gm-Message-State: APjAAAWWcuGH57Ad+/aimQZotiAU92yPWPPKtVUoBsU2ySyVFnTO4DsE
        AuoCgmAN9Qnhychr9E9EHWgJPUGTlwH08Apjd9g=
X-Google-Smtp-Source: APXvYqyyUgsfjkb2CI6m0F2jXuyjGsa3FI80DxdTqPDcKBaFVGYLQUc0UBXUPhXDlcgUWlgSzTRT1EpoZhGotWfYWKM=
X-Received: by 2002:a67:74cd:: with SMTP id p196mr13915498vsc.215.1553496136642;
 Sun, 24 Mar 2019 23:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com> <20190321080133.GB3916@osiris>
In-Reply-To: <20190321080133.GB3916@osiris>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 25 Mar 2019 15:41:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0JxvKOEOE6-SvFWzAueZL0qb6XaANDud0pVa_Ew3NWg@mail.gmail.com>
Message-ID: <CAK7LNAR0JxvKOEOE6-SvFWzAueZL0qb6XaANDud0pVa_Ew3NWg@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,


On Thu, Mar 21, 2019 at 5:02 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Wed, Mar 20, 2019 at 03:20:27PM +0900, Masahiro Yamada wrote:
> > Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> > CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
> >
> > The idea is obviously arch-agnostic although we need some code fixups.
> > This commit moves the config entry from arch/x86/Kconfig.debug to
> > lib/Kconfig.debug so that all architectures (except MIPS for now) can
> > benefit from it.
> >
> > At this moment, I added "depends on !MIPS" because fixing 0day bot reports
> > for MIPS was complex to me.
> >
> > I tested this patch on my arm/arm64 boards.
> >
> > This can make a huge difference in kernel image size especially when
> > CONFIG_OPTIMIZE_FOR_SIZE is enabled.
> >
> > For example, I got 3.5% smaller arm64 kernel image for v5.1-rc1.
> >
> >   dec       file
> >   18983424  arch/arm64/boot/Image.before
> >   18321920  arch/arm64/boot/Image.after
>
> Well, this will change, since now people (have to) start adding
> __always_inline annotations on all architectures, most likely until
> all have about the same amount of annotations like x86. This will
> reduce the benefit.


If people start to replace inline with __always_inline here and there,
yes, the difference will be reduced.

Perhaps, we might end up with fixing dozens of places or so,
but I guess we would still get benefit.


> Not sure if it's really a win that we get the inline vs
> __always_inline discussion now on all architectures.


This feature is not x86-specific.

I prefer "do it for all arches or don't do it at all"
instead of the half-baked state.

If we force inlining for the 'inline' marker
there is no point of having __always_inline.


-- 
Best Regards
Masahiro Yamada
