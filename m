Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A52CC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3008213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JKkpyvWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDGJFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 05:05:36 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:33941 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDGJFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 05:05:36 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x3795RuM018906;
        Sun, 7 Apr 2019 18:05:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x3795RuM018906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554627928;
        bh=kLpXAcvSQHgloL1x+icxlYdRnxTaQZINJIRzBf5b6dc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JKkpyvWwG9CVCBZbBEnXPNiWAf4689dBIKJMaD28zfDQ6Fo9YpDqruvEP0SDRs72H
         Nkfs8GvmT0+ZHFvFq0tr5mm96oJttbTkPr7hrWDe7AhXs6lkCgNx9Gb+O0DG+y/qvH
         ndVTN23e2ZEZk3Am8rle7KQXa7CUtH2G2JKMTgNZBTcTqjflfvWTU6pcUb2Q6GEC84
         CWHHhdK9uijUTe23oG+zy+J/UXwXvVm73dZ+SuUHXC4tYjm7S/yTF+NBlrVYKwFhLw
         tnyjO/HoN4idUcPEzDfAv/3kAhxYI9FS7pZ1Wi6W99H+RQ+Vvs+qEoUSOSRkoCTQNc
         pPonyHN1X/R7A==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id t78so5905012vsc.1;
        Sun, 07 Apr 2019 02:05:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUSnxwOoDgkLKe/V0jzz0PbLzmNoncBKNBinU4O8NTvfHMv8P+b
        HO8IGulgdS3OMvUq8y9W6GQVPKnypRhpM9KRrCc=
X-Google-Smtp-Source: APXvYqzdAkwg2QFGdWDgILz93a4fa5x23rAxoKdwMGBijoirvuAn5AUWp3hiWvXN4h5aR9V/Er/pXa3KCCroFG3RLAg=
X-Received: by 2002:a67:f714:: with SMTP id m20mr13807543vso.211.1554627927315;
 Sun, 07 Apr 2019 02:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR0701MB2652FC3F5D8E46EA93AF033AFA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
In-Reply-To: <HE1PR0701MB2652FC3F5D8E46EA93AF033AFA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Apr 2019 18:04:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEQyEyj_ozkARj8xjDf7EncHeBv0GY8xoP8e_Fn-qaag@mail.gmail.com>
Message-ID: <CAK7LNAQEQyEyj_ozkARj8xjDf7EncHeBv0GY8xoP8e_Fn-qaag@mail.gmail.com>
Subject: Re: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
To:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Cc:     "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC Jonas Gorski)


On Tue, Mar 26, 2019 at 6:58 PM Wiebe, Wladislav (Nokia - DE/Ulm)
<wladislav.wiebe@nokia.com> wrote:
>
> Commit ea837f1c0503 ("kbuild: make modpost processing configurable")
> was intended to give KBUILD_MODPOST_WARN flexibility to be configurable.
> Right now KBUILD_MODPOST_WARN gets just ignored when KBUILD_EXTMOD is
> set which happens per default when building modules out of the tree.
>
> This change gives the opportunity to define module build behaving also
> in case of out of tree builds and default will become exit on error.
> Errors which can be detected by the build should be trapped out of the box
> there, unless somebody wants to notice broken stuff later at runtime.

If an external module refers to a symbol
provided by another external module,
this patch will turn the warning into the error by default,
which is probably a bad idea.


I suggested a desired change in the following.
https://patchwork.kernel.org/patch/9980691/

I am poking Jonas Gorski
if he plans to send v2.


> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>  scripts/Makefile.modpost | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 6b7f354f189a..fec6ec2ffa47 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -78,7 +78,7 @@ modpost = scripts/mod/modpost                    \
>   $(if $(KBUILD_EXTRA_SYMBOLS), $(patsubst %, -e %,$(KBUILD_EXTRA_SYMBOLS))) \
>   $(if $(KBUILD_EXTMOD),-o $(modulesymfile))      \
>   $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)  \
> - $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w)
> + $(if $(KBUILD_MODPOST_WARN),-w)
>
>  MODPOST_OPT=$(subst -i,-n,$(filter -i,$(MAKEFLAGS)))
>
> --
> 2.19.2



-- 
Best Regards
Masahiro Yamada
