Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD41C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CCC21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyOlkmdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbfDROgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:36:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51919 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388907AbfDROgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:36:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so3040185wmf.1;
        Thu, 18 Apr 2019 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZebXCDZh23oSVAps9/qDaV/3OsIk6+l4osGFKchiqk=;
        b=CyOlkmdIy7KxwPiBuHtn3v4aJgge89+1g38yBJ0r+jNLyNMUiSthGM+OBocfMsB3Ew
         Y/uqmjoxAHH3XqmufrGHCNii7qiIRInlV7Q17nQSXLUtqpjdFV/Jb21ZCLdxg14vPjU3
         ZROAisMMcZgB13ty3o0OSD4zDK6dQadZ3RWSKVdl1WlHKpaGADm2kRGApuIHIYkb37xd
         qd9reVuVFjoFMmxfvXx2bUymNplsgdm1sYGi17vnXrF8vEynj3scJ0W50ie1AEeyFABj
         ZgeM/Av97qyV1p28qF22G68VAUoIax071wpvB4gbOpWjsPzSlf/+n6awJQgzY84m3PZ7
         D6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZebXCDZh23oSVAps9/qDaV/3OsIk6+l4osGFKchiqk=;
        b=oybjx0vMMcTuk4WxQf1wrfR/1wdhnX8h9iQevDqt2UXUagd3iZVqqTDFiLYbJ7V3Av
         0NGgogMjIo1bl1c8mAY9L3dXawPdQLWOxQcF7p0FvonaeaMhqvx8Y3pIeCJNJGLpxlb7
         H1Xxk+j+ivx6In32RJcKgGIy7uUsS8DZLpW+fkC0o/JeDBpoC+JrBK60xsLxPTdWjBnB
         N2JmCnGM21wq2JJBl4mV0UOlyRHk7mp+ghb7NowCqAYjSVCYXueGZtNRnqV7NWi2lfTz
         0qvaMhVevqqZtlp7lVHUsbv3bpv1iSGuoT5e+Gq8bgjVkdR0WkmzbBatWAORAo0zNz2+
         GNNQ==
X-Gm-Message-State: APjAAAUxQbKajZXMTEEHfe2Wa+uJYQN7WbsYqdklzP21fsO6n7NQmoP4
        MIfu5U9LM0i8VI+5h8EbbIRw7DZgFU0jtR9kb+w=
X-Google-Smtp-Source: APXvYqyZWfqQaXOwhO2itLxhPTgfbRwbepDsGhDTKm8lUxIfAq557JRAejIC4vtDC4Bp+t2Hm+hFZt35Br1Dzwl0d8E=
X-Received: by 2002:a1c:dc84:: with SMTP id t126mr3252812wmg.143.1555598202270;
 Thu, 18 Apr 2019 07:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190406121447.GB4047@localhost.localdomain> <CAK7LNATfo0K6kzwobkAZ_u2KnWL3XycJzbr3KPtPF=ePziCuDg@mail.gmail.com>
 <20190418135238.GA5626@linux-8ccs>
In-Reply-To: <20190418135238.GA5626@linux-8ccs>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 18 Apr 2019 07:36:25 -0700
Message-ID: <CAKi4VALprR0+p-pk9h4Jt1+v2nxGqs_aO7p6bM_2oVsutsTsyQ@mail.gmail.com>
Subject: Re: [PATCH v2] moduleparam: Save information about built-in modules
 in separate file
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-modules <linux-modules@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 6:52 AM Jessica Yu <jeyu@kernel.org> wrote:
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

I agree with modules.builtin.modinfo

> names consistent with what is already there? It clearly conveys that
> this file contains modinfo for builtin modules.
>
> I'll leave it up to Lucas to decide if the file format is OK for kmod.
> With the modinfo dump, kmod could then decide what to do with the
> information, append to modules.alias{,.bin}, etc.

I think it's ok with the current format. It's simple enough. I would
delay merging it until
the userspace counterpart is implemented though. So to make sure we
have everything we need.
I can work on that in ~1 or 2 weeks.

thanks
Lucas De Marchi

>
> Also, I think this file needs to be documented in Documentation/kbuild/kbuild.txt.
>
> Thanks,
>
> Jessica



-- 
Lucas De Marchi
