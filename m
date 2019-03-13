Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127882077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="07hkHys1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfCMRmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:42:21 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:49036 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCMRmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:42:21 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2DHgF7G004696;
        Thu, 14 Mar 2019 02:42:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2DHgF7G004696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552498936;
        bh=rB31vrSQRI+OCPHtNmN06TMRpdMt3bMz1Lx/B5eLOyQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=07hkHys1fPfD1AtWF6TyZdZC0+3qdfqIymFf0LLLx0rOJeuJbvrubQtsrvyEh2oM5
         zEtuKd5JHdg+M/ur/+fahGc4eRyMPFHCaH3M7UGBUj+5wlrCs3OuwhKZJRXtl5wv/W
         GDhwtMITQ4s1oChJgkzTW4sQ/vhq2H5TFCYXtqAloGQjN47Pt4iH3U8y64FMRuqKyV
         cPpVnH0YOkM5XHDHEb25PMhfRlyJMySMkbAxd75ahDrYfulvYUTgnswQngTf5BiJNY
         QgSia/NxyCr9MzIBCJ8tVVFjCEjeFwoq9cWSxxmii+TuLiXsPBhoEtL6bE6mv/31ll
         EbTOh4LpLMr9g==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id j7so952438uak.8;
        Wed, 13 Mar 2019 10:42:16 -0700 (PDT)
X-Gm-Message-State: APjAAAW/paDlt14xoRoHlOxap87f34ybtzLylRfXSTr7Xa++uzH3ur5G
        6foqVpx0M3hiqEjEVvzlu74eYMf2fa7M31TISLM=
X-Google-Smtp-Source: APXvYqwkHZ4R5Ki/kSrcEaikko/FZVxlFbhjUnwzFLYir9CJscsJAH0N/cYxzbfEBn+6V/nWs9H6bqoyqjGMJcdu4uo=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr23123922uam.93.1552498935169;
 Wed, 13 Mar 2019 10:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <1552023035-29826-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1552023035-29826-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 02:41:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpy6aAKqhM3ef05Oi2zYHVM2A+7x5y7tx-Z1q6BA=bvg@mail.gmail.com>
Message-ID: <CAK7LNATpy6aAKqhM3ef05Oi2zYHVM2A+7x5y7tx-Z1q6BA=bvg@mail.gmail.com>
Subject: Re: [PATCH] unicore32: simplify linker script generation for decompressor
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guan Xuetao <gxt@pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 2:31 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> When I was searching for unneeded $(KCONFIG_CONFIG) usages, I noticed
> this strange build dependency.
>
> It can use $(call if_changed,...) in case ZTEXTADDR and ZBSSADDR are
> changed, but even a simpler way is to use the pattern rule in
> scripts/Makefile.build. This is what arch/arm/boot/compressed/Makefile
> does.
>
> I did only build test. I confirmed equivalent vmlinux.lds was generated.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.



>  arch/unicore32/boot/compressed/Makefile                          | 5 +----
>  arch/unicore32/boot/compressed/{vmlinux.lds.in => vmlinux.lds.S} | 0
>  2 files changed, 1 insertion(+), 4 deletions(-)
>  rename arch/unicore32/boot/compressed/{vmlinux.lds.in => vmlinux.lds.S} (100%)
>
> diff --git a/arch/unicore32/boot/compressed/Makefile b/arch/unicore32/boot/compressed/Makefile
> index 9aecdd3..150fafc 100644
> --- a/arch/unicore32/boot/compressed/Makefile
> +++ b/arch/unicore32/boot/compressed/Makefile
> @@ -61,7 +61,4 @@ $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/head.o $(obj)/piggy.o \
>  ZTEXTADDR      := 0x03000000
>  ZBSSADDR       := ALIGN(4)
>
> -SEDFLAGS_lds   = s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
> -$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in arch/unicore32/boot/Makefile $(KCONFIG_CONFIG)
> -       @sed "$(SEDFLAGS_lds)" < $< > $@
> -
> +CPPFLAGS_vmlinux.lds = -DTEXT_START="$(ZTEXTADDR)" -DBSS_START="$(ZBSSADDR)"
> diff --git a/arch/unicore32/boot/compressed/vmlinux.lds.in b/arch/unicore32/boot/compressed/vmlinux.lds.S
> similarity index 100%
> rename from arch/unicore32/boot/compressed/vmlinux.lds.in
> rename to arch/unicore32/boot/compressed/vmlinux.lds.S
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
