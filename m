Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7053217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Vm1c2vvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKOZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:25:53 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:41021 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKOZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:25:53 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x3BEPMKu008825;
        Thu, 11 Apr 2019 23:25:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x3BEPMKu008825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554992723;
        bh=Oz6/GxcmTwOhGaU/CWLEo5ZIfjWtthtUuZlYPfs1pNc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vm1c2vvmJFUQuWxaY6zEHQ/bfyijC72PKPwYKIwo1Rnqi5jc+T4bq6B1GUIkUtJBv
         Fyxd2ZiTEuwmRYpx97LK+z6u3CZc00IHY+u3HT/osERmwj1uGWCVpODKTj8cRkNXcK
         zAA1/o3WpiX/PT+oR8INSibIbAuifGIoGfAay4NDc55iIxdzIK0gXlQCV2lOiVSnWf
         6CPCKux9BJNFU/zLhYQE1gcqSohK+NONsmv55532ab42hjuVWOo6UkJ2wyiMnDDmjW
         GsaWXcQtgSpQwWMVbKK9UBpB45eZiFIksEeR5rcAmEqhGLtMJyJAsxObmGU9onM7AR
         i6epsnaBxBY0Q==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id t15so2077804uao.5;
        Thu, 11 Apr 2019 07:25:23 -0700 (PDT)
X-Gm-Message-State: APjAAAVrW/RcplIwcnDMvbjJjJmLhZVewp7g+Sk+Gtj6eJixOMZmilRU
        6QaHdWxcGDm3Nv8OU/oFqBZKeZyiRxJR8nqcsv8=
X-Google-Smtp-Source: APXvYqzWsLQlEUCpnjSKWRhDJNqHOkttk5/5cMvS9bi6zkPMHX1o4vaxI2H6RBJGrVhlAyvw+oJWmRukDWMUwKbq+wo=
X-Received: by 2002:ab0:1c1b:: with SMTP id a27mr4509997uaj.60.1554992722468;
 Thu, 11 Apr 2019 07:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <1554633831-10303-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1554633831-10303-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 23:24:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQawsF2PC9VJ8PTHY1fNEAVvg6dm8soQ9rXwboYFxJQrw@mail.gmail.com>
Message-ID: <CAK7LNAQawsF2PC9VJ8PTHY1fNEAVvg6dm8soQ9rXwboYFxJQrw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: check arch/$(SRCARCH)/include/generated before
 out-of-tree build
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 7:44 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> After cross-compiling the kernel, "make mrproper" should be executed
> with the proper ARCH= option. Otherwise, stale objects will remain
> under arch/$(SRCARCH)/.
>
> One bad scenario is like this:
>
>   $ make ARCH=arm defconfig all   # cross-compile the kernel for arm
>   $ make mrproper                 # mrproper for host-arch (i.e. x86)
>   $ make ARCH=arm O=build_dir defconfig all
>
> If you miss ARCH= for mrproper and cross-compile the kernel with O=
> and ARCH= options, Kbuild will happily start to build, but may fail
> due to stale objects in the srctree.
>
> If $(srctree)/arch/$(SRCARCH)/include/generated/ exists, let's stop
> the out-of-tree build. To detect this, mrproper should clean only
> arch/$(SRCARCH)/include/generated/.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Applied to linux-kbuild.

> ---
>
>  Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 10643c3..17945ce 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1091,7 +1091,9 @@ PHONY += prepare archprepare prepare1 prepare3
>  prepare3: include/config/kernel.release
>  ifneq ($(srctree),.)
>         @$(kecho) '  Using $(srctree) as source for kernel'
> -       $(Q)if [ -f $(srctree)/.config -o -d $(srctree)/include/config ]; then \
> +       $(Q)if [ -f $(srctree)/.config -o \
> +                -d $(srctree)/include/config -o \
> +                -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
>                 echo >&2 "  $(srctree) is not clean, please run 'make mrproper'"; \
>                 echo >&2 "  in the '$(srctree)' directory.";\
>                 /bin/false; \
> @@ -1350,7 +1352,7 @@ CLEAN_DIRS  += $(MODVERDIR) include/ksym
>
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_DIRS  += include/config usr/include include/generated          \
> -                 arch/*/include/generated .tmp_objdiff
> +                 arch/$(SRCARCH)/include/generated .tmp_objdiff
>  MRPROPER_FILES += .config .config.old .version \
>                   Module.symvers tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS \
>                   signing_key.pem signing_key.priv signing_key.x509     \
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
