Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1907EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A6D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JGESc3LJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfCMRoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:44:22 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:21809 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:44:22 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2DHi93l008064;
        Thu, 14 Mar 2019 02:44:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2DHi93l008064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552499049;
        bh=E6WtDBVfsV3JHaMx/LpsSY73bCNZN/FcMnJlG85BnkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JGESc3LJr0EWm8knjP4SfjNOfoNc3JE3v6Iefak6TF2uQw4SmaLBkkRERbIWwsiIo
         IvZMLeN5BFoAGhAEPtjbzOY7vo/iLlKAC9F1B1hfrvuK9VFi7X/BlIa5/ZBVLeDHFY
         WC+ftnd363rEWKFq1q+TxMK2VRx16Dib9I7jdgD441k788cahNArDvBwcba7LiE9Ss
         sTYKQ5yOGr/3mT0StynSk+fJb40LF395VpNGH7KyGDeuBz2MSaFJM6jVunzhvN3Y4Z
         +UF+bof04pB3njOvN+BFUNyZdGvN9FE7+uO/SaM9mUBmtTPzc1TJn2bT4OSqjfZHLV
         cvbLV5Rl+vSEQ==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id x1so963366uaj.4;
        Wed, 13 Mar 2019 10:44:09 -0700 (PDT)
X-Gm-Message-State: APjAAAW4rxNsyJrEebFiqU83Jqhr7EHxtyvCBDhy0MaLprNvRDLQXNi5
        qqgMFIEME8rVEfI9YrSqHL6LWVARt1rjlqJmdmg=
X-Google-Smtp-Source: APXvYqzUJkR35RYJ9kvNu7jL3DxH0GBp5isnGer2GUab97UkkTXcQ0OwhT3mJezoGv3DXcTKs8wwmtpb5N+rC/3f5ew=
X-Received: by 2002:ab0:c07:: with SMTP id a7mr2648420uak.55.1552499048436;
 Wed, 13 Mar 2019 10:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <1552411404-32271-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1552411404-32271-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 02:43:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARXpg-LwbNnZMySGJHFFjUKes5tCcKx1=mpygpyX3GEJQ@mail.gmail.com>
Message-ID: <CAK7LNARXpg-LwbNnZMySGJHFFjUKes5tCcKx1=mpygpyX3GEJQ@mail.gmail.com>
Subject: Re: [PATCH] deb-pkg: generate correct build dependencies
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 2:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> From: Riku Voipio <riku.voipio@linaro.org>
>
> bison/flex is now needed always for building for kconfig. Some build
> dependencies depend on kernel configuration, enable them as needed:
>
> - libelf-dev when UNWINDER_ORC is set
> - libssl-dev for SYSTEM_TRUSTED_KEYRING
>
> Since the libssl-dev is needed for extract_cert binary, denote with
> :native to install the libssl-dev for the build machines architecture,
> rather than for the architecture of the kernel being built.
>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> Reviewed-by: Ben Hutchings <ben@decadent.org.uk>
> Acked-by: maximilian attems <maks@stro.at>
> [masahiro.yamada: add change 'flex' to 'flex | flex:native' ]
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>


Applied to linux-kbuild.


> Hi Riku,
>
> I did not get your update, but anyway I changed
> 'flex' to 'flex | flex:native'.
>
> With this change, now I am able to cross-compile deb-pkg.
>
>
>  scripts/package/mkdebian | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index f030961..110cd8d 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -134,6 +134,8 @@ fi
>
>  mkdir -p debian/
>  echo $debarch > debian/arch
> +extra_build_depends=", $(if_enabled_echo UNWINDER_ORC libelf-dev)"
> +extra_build_depends="$extra_build_depends, $(if_enabled_echo SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
>
>  # Generate a simple changelog template
>  cat <<EOF > debian/changelog
> @@ -170,7 +172,7 @@ Source: $sourcename
>  Section: kernel
>  Priority: optional
>  Maintainer: $maintainer
> -Build-Depends: bc, kmod, cpio
> +Build-Depends: bc, kmod, cpio, bison, flex | flex:native $extra_build_depends
>  Homepage: http://www.kernel.org/
>
>  Package: $packagename
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
