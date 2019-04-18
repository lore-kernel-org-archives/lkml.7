Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F33C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D752183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YYJ5UtOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbfDRLLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:11:14 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:49207 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388401AbfDRLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:11:14 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x3IBB434028908;
        Thu, 18 Apr 2019 20:11:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3IBB434028908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555585865;
        bh=8D56uvnp7/1886A3UmoC8LJI0l4moyaB1G1PAE8iT+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YYJ5UtOSe71b/eTdwA0kpZ2+sQBi1JBXOmhT+r5zMg7Lflhjv/RiXTTGsCpWUOKQS
         FbYXur7LiO5yIgHy47ukbZXRIwTXArb786xNsoaFQ4uQLHtXT3Sf6dwpqIl/SGuOyp
         28ruL9GEjUkaLExyGyiTdHk/S+TI5T+ZNfCvAut7FgBuvhJKYVg+gPfIa5S6UX2skj
         B7n4ODci+DzOV3+vWoYglp07Gs3Twk6DBFsVlniQWK2+52W8sBHBIMWalDGmL+w1gy
         xHY0/h+ipSgFRyGi6tC50KJYJ5YkMOUE5RR6hWBogCr5L9FYNlK4DxGjKeA10Vr71Y
         fiCH2yQnduXGQ==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id c13so616227uao.12;
        Thu, 18 Apr 2019 04:11:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWH/VdguRgFQCUyJNSF2DJXtdRjX5nJaqHWFZ3BAjQLFABol8kO
        ADJt1Go/FGF5NN5XbamI4C1VBdrzMQYPMvquS8o=
X-Google-Smtp-Source: APXvYqzwkCMzC4s4oC26lOp1GBADXUgH5b/MUU63cGvA8IHDwkn+ZWj5a1uyzkjy2+H63aG2CAK1Pr+aqF84Stz8roQ=
X-Received: by 2002:a9f:2d99:: with SMTP id v25mr5521176uaj.25.1555585863492;
 Thu, 18 Apr 2019 04:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190406121447.GB4047@localhost.localdomain>
In-Reply-To: <20190406121447.GB4047@localhost.localdomain>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Apr 2019 20:10:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATfo0K6kzwobkAZ_u2KnWL3XycJzbr3KPtPF=ePziCuDg@mail.gmail.com>
Message-ID: <CAK7LNATfo0K6kzwobkAZ_u2KnWL3XycJzbr3KPtPF=ePziCuDg@mail.gmail.com>
Subject: Re: [PATCH v2] moduleparam: Save information about built-in modules
 in separate file
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jessica Yu <jeyu@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 9:15 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> Problem:
>
> When a kernel module is compiled as a separate module, some important
> information about the kernel module is available via .modinfo section of
> the module.  In contrast, when the kernel module is compiled into the
> kernel, that information is not available.
>
> Information about built-in modules is necessary in the following cases:
>
> 1. When it is necessary to find out what additional parameters can be
> passed to the kernel at boot time.
>
> 2. When you need to know which module names and their aliases are in
> the kernel. This is very useful for creating an initrd image.
>
> Proposal:
>
> The proposed patch does not remove .modinfo section with module
> information from the vmlinux at the build time and saves it into a
> separate file after kernel linking. So, the kernel does not increase in
> size and no additional information remains in it. Information is stored
> in the same format as in the separate modules (null-terminated string
> array). Because the .modinfo section is already exported with a separate
> modules, we are not creating a new API.
>
> It can be easily read in the userspace:
>
> $ tr '\0' '\n' < kernel.builtin
> ext4.softdep=pre: crc32c
> ext4.license=GPL
> ext4.description=Fourth Extended Filesystem
> ext4.author=Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
> ext4.alias=fs-ext4
> ext4.alias=ext3
> ext4.alias=fs-ext3
> ext4.alias=ext2
> ext4.alias=fs-ext2
> md_mod.alias=block-major-9-*
> md_mod.alias=md
> md_mod.description=MD RAID framework
> md_mod.license=GPL
> md_mod.parmtype=create_on_open:bool
> md_mod.parmtype=start_dirty_degraded:int
> ...
>
> v2:
>  * Extract modinfo from vmlinux.o as suggested by Masahiro Yamada;
>  * Rename output file to kernel.builtin;

Sorry, I do not get why you renamed
"kernel.builtin.modinfo" to "kernel.builtin".

If you drop "modinfo", we do not understand
what kind information is contained in it.

I think "kernel" and "builtin" have
a quite similar meaning here.

How about "builtin.modinfo" for example?


It is shorter, and it is clear enough
that it contains module_info.



>  * Add MODULE_VERSION to modinfo that is saved to the kernel.builtin;
>  * Fix build warnings on powerpc.
>
> Co-Developed-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---


> diff --git a/.gitignore b/.gitignore
> index a20ac26aa2f5..432332fd745e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -45,6 +45,7 @@
>  *.xz
>  Module.symvers
>  modules.builtin
> +kernel.builtin

This file is generated only in the top of the tree.

Please add '/' prefix and move it to
the "# Top-level generic files" section.




> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index c8cf45362bd6..b914e026ef28 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -226,6 +226,10 @@ modpost_link vmlinux.o
>  # modpost vmlinux.o to check for section mismatches
>  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
>
> +info MODINFO kernel.builtin
> +"${OBJCOPY}" -j .modinfo -O binary vmlinux.o kernel.builtin
> +chmod 444 kernel.builtin


Could you explain why this "chmod" is necessary?


Thanks.




--
Best Regards
Masahiro Yamada
