Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21105C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77B220651
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RATLULHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDKOYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:24:02 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64966 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:24:02 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x3BENvlX011093;
        Thu, 11 Apr 2019 23:23:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x3BENvlX011093
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554992638;
        bh=n/2Uc/c7hLBI9nJ+LonSeTiSbBWQup3kE+zZQxb/+9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RATLULHpzteFwAFxHH/tkDvZ+EcfjwJkZTVAMPxa8+NJ4Rt7Pn914LN+Nx6E55VB2
         PY52xBoPFMO4ypU/4ZR/ztroxx0e9c6gXZGWAD0XZPam0oNssbbfK06ESR5yVtB6KG
         gdVsCjHyGvEi/W4J8nAUq/z8SF5npqtrMGZdLlISWpyD6b0PEPoppmGUpyfjSPmLLk
         yaKMxuPmzOuvCuqI4sfShSw0+wswo+HK44S3+JlAplMAi1LmJZ7sgSyHuj1J3OC/2o
         imhzCD+abQNNVTl6mqrME7gjWN2OIaKOkS73Y/PH0BVlAhpYI4nzFGgWIs0U05aV26
         h9amWr1poRpYg==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id n16so2076263uae.10;
        Thu, 11 Apr 2019 07:23:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVDtu8MN71NNOn/K9A6HvFmMgEgYJgo7V10PIzh0ygAlrSo47gC
        sDkYhbCfFgJ18mEcj0MBlFOBrc8AeGDlYuHi35A=
X-Google-Smtp-Source: APXvYqxW9s6S0RJAqKBmq581RnDIBQuzCO9ti6HsunU4f9OQ1ZlMEaaXuviZtRz9LgdolDfTlvP94gmJJ6eJviWjmrE=
X-Received: by 2002:ab0:1c1b:: with SMTP id a27mr4504805uaj.60.1554992637150;
 Thu, 11 Apr 2019 07:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR0701MB2652279C2863E22F19B871FCFA2F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
In-Reply-To: <HE1PR0701MB2652279C2863E22F19B871FCFA2F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 23:23:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1CMjggTc8whn2-NWtjXasnq-HjnaOOxVsDczSJZBotA@mail.gmail.com>
Message-ID: <CAK7LNAQ1CMjggTc8whn2-NWtjXasnq-HjnaOOxVsDczSJZBotA@mail.gmail.com>
Subject: Re: [PATCH v3] modpost: make KBUILD_MODPOST_WARN also configurable
 for external modules
To:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Cc:     "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 6:25 PM Wiebe, Wladislav (Nokia - DE/Ulm)
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
>
> As this patch changes the default behaving from warning to error,
> users can consider to fix it for external module builds by:
> - providing module symbol table via KBUILD_EXTRA_SYMBOLS for
>   modules which are dependent
> - OR getting old behaving back by passing KBUILD_MODPOST_WARN to the build
>
> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>


Applied to linux-kbuild.
Thanks.


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
