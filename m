Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F9C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE052054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qfKzVF/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEFOLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:11:14 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:50496 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:11:13 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x46EAi0T022722
        for <linux-kernel@vger.kernel.org>; Mon, 6 May 2019 23:10:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x46EAi0T022722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557151845;
        bh=Yfgg3QKu1Iisil+Puvfnva5rPVonGAHhK+8uA4kJp68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qfKzVF/Cf/Z9p+v/Zv74k9kk6MeqqBPv+Dd2kkwKN8qEi31BWO+nnuSJBWQ1KPBT/
         qXiRLDlbB7B/fX8xD3Epz1PHcaymuKQ04yRakaN6+VsTXAcsBJ5eGUphov6WKzJpPl
         TJWBL7T3YXFcqXkYad2mu46PIJhSof6Xg3eqNRJXTWY0b9E0/ENqoOkcEkOi014XMz
         8mTKaTzfD3hjmz8N85swT47nd0qiwBWSvrKAwm7XtcT1aO3a5TjDr8l7qMoYL+BwNc
         Ugb+2pTDByegeqjec/Cq7/khOZ+kOFX+Em+nH4D/IHrWbtU4imYSznyqlCRS+VSIEf
         eu9IXhavm6ycA==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id t15so4703812uao.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 07:10:45 -0700 (PDT)
X-Gm-Message-State: APjAAAUFeOryrwmUey3sUrySU+ATaEUQz9Vmp83QoBusOcKJbPoNWlSz
        WrduyvYV4yp/1G+XO1PK2Qm2zbJoLlnyF8CQNeM=
X-Google-Smtp-Source: APXvYqyUSgQ0VZ5x5hRZUkKTXa/lrNbKe3ZXKlpeRD6ErqM7DVQbk9EzH0BBTqHkj+HDsIqNagAwVY7Iz2nfvAiqGxQ=
X-Received: by 2002:ab0:2bd8:: with SMTP id s24mr12929168uar.121.1557151843824;
 Mon, 06 May 2019 07:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <1557146400-12269-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1557146400-12269-1-git-send-email-krzk@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 6 May 2019 23:10:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4TB5CCm-X8MzeWNvyjJdotV0fSf2V3UodAVyvC85haQ@mail.gmail.com>
Message-ID: <CAK7LNAT4TB5CCm-X8MzeWNvyjJdotV0fSf2V3UodAVyvC85haQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix cross compile link with ccache
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,


On Mon, May 6, 2019 at 9:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Fix calling objcopy in case of cross compile environments:
>
>         ARCH="arm" CROSS_COMPILE="ccache arm-linux-gnueabi-" make
>         scripts/link-vmlinux.sh: line 211: ccache arm-linux-gnueabi-objcopy: command not found
>
> Fixes: 6a26793a7891 ("moduleparam: Save information about built-in modules in separate file")


Thanks for the report.

I need to drop this commit from my tree for now
and re-spin as Stephen reported some build breakage:

https://lkml.org/lkml/2019/5/5/269


I will squash this when I re-add the former patch.

Thanks.





> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  scripts/link-vmlinux.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 62b9fc561af7..42ea6f9264ef 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -208,7 +208,7 @@ modpost_link vmlinux.o
>  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
>
>  info MODINFO modules.builtin.modinfo
> -"${OBJCOPY}" -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
> +${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
>
>  kallsymso=""
>  kallsyms_vmlinux=""
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
