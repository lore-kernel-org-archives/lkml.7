Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B97C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14D120869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RcGv2MsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbfDRP1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:27:30 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:28274 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:27:30 -0400
X-Greylist: delayed 15376 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 11:27:28 EDT
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x3IFRAI1000644;
        Fri, 19 Apr 2019 00:27:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x3IFRAI1000644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555601231;
        bh=IZhFShJ6jDiysCuABWEkQgQvv5e4ZaTURElBN4UyQy8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RcGv2MsVY9871J747cWMrMvVAJrvKtzcous8CoBAOH4ZTw1RFFdKfWrhFUSZs+BTA
         MmmKd26RRXLeHHXpiDeemnE4mXrz4jf4EQvts5p1S0lp76qkgMZA8erHdGzvlgF9/o
         MZgWYw8eqvoYsU05enUbPD283kbMm0+pZvw3f7UQrlkGIRkHJieJv6Dw+lN5dpQxPz
         wXpWFp7pL9wgqFK7XByS8mB7wNG3JNfv/d2U5C+QruqfoNzzIK5A9STYxsAQhXa1/3
         7+7DTGLksLJPOGX/4NXJbh1Bm2/wdrayx77fWLzS0eSnlduC5HR60LTCzcQLKq2K4j
         N2YyM0n/VDP7w==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id g127so1372552vsd.6;
        Thu, 18 Apr 2019 08:27:10 -0700 (PDT)
X-Gm-Message-State: APjAAAVcEdLFwvv0T5BDNutyiKtQ5wpSc7y1nZCJNMrW6gN5e0cZZvzb
        J61Gj8W+MeccAEdtO8uWdSeWDspZ2Hq51snpcjc=
X-Google-Smtp-Source: APXvYqyOpBWWg2uYNK0qf3CyHiNJr6VMFSUPz8vF9tVsbcHZpS8rkp9GWstvnRugAXFQPG1W7QOPifC4D5msTLBFX6w=
X-Received: by 2002:a67:f948:: with SMTP id u8mr9436544vsq.179.1555601229490;
 Thu, 18 Apr 2019 08:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190406121447.GB4047@localhost.localdomain> <CAK7LNATfo0K6kzwobkAZ_u2KnWL3XycJzbr3KPtPF=ePziCuDg@mail.gmail.com>
 <20190418135238.GA5626@linux-8ccs>
In-Reply-To: <20190418135238.GA5626@linux-8ccs>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Apr 2019 00:26:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKHXLgniczKXY01JhxhBpL2p-X_hWg70AcsrXRaLyDSg@mail.gmail.com>
Message-ID: <CAK7LNARKHXLgniczKXY01JhxhBpL2p-X_hWg70AcsrXRaLyDSg@mail.gmail.com>
Subject: Re: [PATCH v2] moduleparam: Save information about built-in modules
 in separate file
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:52 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [18/04/19 20:10 +0900]:
> >On Sat, Apr 6, 2019 at 9:15 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> >>
> >> Problem:
> >>
> >> When a kernel module is compiled as a separate module, some important
> >> information about the kernel module is available via .modinfo section of
> >> the module.  In contrast, when the kernel module is compiled into the
> >> kernel, that information is not available.
> >>
> >> Information about built-in modules is necessary in the following cases:
> >>
> >> 1. When it is necessary to find out what additional parameters can be
> >> passed to the kernel at boot time.
> >>
> >> 2. When you need to know which module names and their aliases are in
> >> the kernel. This is very useful for creating an initrd image.
> >>
> >> Proposal:
> >>
> >> The proposed patch does not remove .modinfo section with module
> >> information from the vmlinux at the build time and saves it into a
> >> separate file after kernel linking. So, the kernel does not increase in
> >> size and no additional information remains in it. Information is stored
> >> in the same format as in the separate modules (null-terminated string
> >> array). Because the .modinfo section is already exported with a separate
> >> modules, we are not creating a new API.
> >>
> >> It can be easily read in the userspace:
> >>
> >> $ tr '\0' '\n' < kernel.builtin
> >> ext4.softdep=pre: crc32c
> >> ext4.license=GPL
> >> ext4.description=Fourth Extended Filesystem
> >> ext4.author=Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
> >> ext4.alias=fs-ext4
> >> ext4.alias=ext3
> >> ext4.alias=fs-ext3
> >> ext4.alias=ext2
> >> ext4.alias=fs-ext2
> >> md_mod.alias=block-major-9-*
> >> md_mod.alias=md
> >> md_mod.description=MD RAID framework
> >> md_mod.license=GPL
> >> md_mod.parmtype=create_on_open:bool
> >> md_mod.parmtype=start_dirty_degraded:int
> >> ...
> >>
> >> v2:
> >>  * Extract modinfo from vmlinux.o as suggested by Masahiro Yamada;
> >>  * Rename output file to kernel.builtin;
> >
> >Sorry, I do not get why you renamed
> >"kernel.builtin.modinfo" to "kernel.builtin".
> >
> >If you drop "modinfo", we do not understand
> >what kind information is contained in it.
> >
> >I think "kernel" and "builtin" have
> >a quite similar meaning here.
> >
> >How about "builtin.modinfo" for example?
> >
> >
> >It is shorter, and it is clear enough
> >that it contains module_info.
>
> I agree that the name kernel.builtin is unclear in what kind of
> information it contains. Apologies for not having clarified this in
> the previous review.
>
> Since kbuild already produces "modules.order" and "modules.builtin"
> files, why not just name it "modules.builtin.modinfo" to keep the
> names consistent with what is already there?


Is it consistent?

If we had "modules.order" and "modules.builtin.order" there,
I would agree with "modules.builtin.modinfo",
and also "modules.alias" vs "modules.builtin.alias".


We already have "modules.builtin", and probably impossible
to rename it, so we cannot keep consistency in any way.


"modules.builtin" is a weird name since
it actually contains "order", but its extension
does not express what kind of information is in it.
Hence, I doubt "modules.builtin" is a good precedent.

IMHO, "modules" and "builtin" are opposite
to each other. "modules.builtin" sounds iffy to me.





> It clearly conveys that
> this file contains modinfo for builtin modules.
>
> I'll leave it up to Lucas to decide if the file format is OK for kmod.
> With the modinfo dump, kmod could then decide what to do with the
> information, append to modules.alias{,.bin}, etc.
>
> Also, I think this file needs to be documented in Documentation/kbuild/kbuild.txt.
>
> Thanks,
>
> Jessica
--
Best Regards
Masahiro Yamada
