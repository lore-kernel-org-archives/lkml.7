Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E7E20828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CG+M0wSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfCKRno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:43:44 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:48324 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:43:44 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2BHhdPQ022368;
        Tue, 12 Mar 2019 02:43:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2BHhdPQ022368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552326220;
        bh=+CZQeUcOauqWEqCHTvIsTi9HekeJELm9Qu4ksBOo56E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CG+M0wSEW5BLsg59b2wo0Bf3yTlIZnhpEyKDAXyJLbrQkIyRkOg5M/MFvsgNYgcL8
         g4xnHXAGtXtfqBflIooPJL19jfX32MkQ0jQXdYVcHZQX3A+YXA8lJisqSkdA9hBrtj
         1Mb8DMyTvEts3ZhbvixVHfltRBBQhzPNNueZ1LTAGU0JPfUGMTumKs4Ur0A1HO9PIA
         ch5yyG/9hE2oz6JGOb4wyidD8zWeO+Xgn2CW4sg6IZ/H/i1aab8W9zFxEcWvmlKGgR
         aUrwjaKXaPlJqHHp1EPrjwSljPJqt0H0fJMRK7QmixzZKn1u74BIwIga9u97ZA0wrW
         wTgWRCIzaQoYw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id w14so3255780vso.6;
        Mon, 11 Mar 2019 10:43:40 -0700 (PDT)
X-Gm-Message-State: APjAAAUc38gE8J6T8rcm1a1Q3tyq0UWVrv+H5v7F3h0YWBgPlIQQEsyZ
        eo+0gy3IHM9xFeTGtAFvhG5nYBaAqhSpghTPAXQ=
X-Google-Smtp-Source: APXvYqyPMhLoztL5Qx8FPm/9LcHwWrJF7Evj6JSqaisuiEpFXsTG3x2ygsUL9HLJqB8qhQ4EqlLsrP81rSLhjmGx87A=
X-Received: by 2002:a67:f90e:: with SMTP id t14mr17627803vsq.181.1552326219132;
 Mon, 11 Mar 2019 10:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190309154307.23039-1-ar@cs.msu.ru>
In-Reply-To: <20190309154307.23039-1-ar@cs.msu.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 02:43:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4sM+pnQyxNVpE2O3ChEirpUq6LjLnvT6xhJ7LuFGKHQ@mail.gmail.com>
Message-ID: <CAK7LNAT4sM+pnQyxNVpE2O3ChEirpUq6LjLnvT6xhJ7LuFGKHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] scripts/package/Makefile: put proper config in
 source tarball
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 12:44 AM Arseny Maslennikov <ar@cs.msu.ru> wrote:
>
> It is widely known that one can build a kernel without a .config in the
> source tree by setting KCONFIG_CONFIG equal to the actual configuration
> file path.
>
> When making a *-pkg target, make(1) prepares a source tarball and tries
> to pack `.config' in there regardless of the value of KCONFIG_CONFIG,
> failing spectacularly if .config is absent and packing the wrong config
> if it exists.
> Let's fix that by including whatever KCONFIG_CONFIG points to in the
> archive under the traditional name `.config'.
>
> We have to pass --absolute-names to tar, since it seems to trim the
> paths of archive members first and only then consider --transform, which
> breaks KCONFIG_CONFIG=../../some.config, as well as absolute paths.
>
> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>


rpm-pkg will work in a strange way.
(probably snap-pkg too).

rpm package is compiled in $(HOME)/rpmbuild/BUILD.
The source package will contain the .config in the standard location,
but KCONFIG_CONFIG will point to a different path.

Rather, I'd like to stop the build.


quiet_cmd_src_tar = TAR     $(2).tar.gz
      cmd_src_tar = \
if test "$(objtree)" != "$(srctree)"; then \
        echo >&2; \
        echo >&2 "  ERROR:"; \
        echo >&2 "  Building source tarball is not possible outside the"; \
        echo >&2 "  kernel source tree. Don't set KBUILD_OUTPUT, or use the"; \
        echo >&2 "  binrpm-pkg or bindeb-pkg target instead."; \
        echo >&2; \
        false; \
fi ; \
if test "$(KCONFIG_CONFIG)" != .config; then \
        echo >&2; \
        echo >&2 "  ERROR:"; \
        echo >&2 "  Please do not override KCONFIG_CONFIG"; \
        echo >&2 "  for source package build"; \
        echo >&2; \
        false; \
fi ; \
$(srctree)/scripts/setlocalversion --save-scmversion; \
tar -cz $(RCS_TAR_IGNORE) -f $(2).tar.gz \
--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
rm -f $(objtree)/.scmversion



I am included to do the opposite;
replace KCONFIG_CONFIG with the hard-coded .config

KCONFIG_CONFIG does not work.
It is half-baked at best.



> ---
>  scripts/package/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/package/Makefile b/scripts/package/Makefile
> index 2c6de21e5152..134cefee068d 100644
> --- a/scripts/package/Makefile
> +++ b/scripts/package/Makefile
> @@ -27,7 +27,7 @@ KDEB_SOURCENAME ?= linux-$(KERNELRELEASE)
>  KBUILD_PKG_ROOTCMD ?="fakeroot -u"
>  export KDEB_SOURCENAME
>  # Include only those top-level files that are needed by make, plus the GPL copy
> -TAR_CONTENT := $(KBUILD_ALLDIRS) .config .scmversion Makefile \
> +TAR_CONTENT := $(KBUILD_ALLDIRS) $(KCONFIG_CONFIG) .scmversion Makefile \
>                 Kbuild Kconfig COPYING $(wildcard localversion*)
>  MKSPEC     := $(srctree)/scripts/package/mkspec
>
> @@ -44,6 +44,7 @@ if test "$(objtree)" != "$(srctree)"; then \
>  fi ; \
>  $(srctree)/scripts/setlocalversion --save-scmversion; \
>  tar -cz $(RCS_TAR_IGNORE) -f $(2).tar.gz \
> +       --absolute-names --transform 's:^$(KCONFIG_CONFIG)$$:.config:S' \
>         --transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
>  rm -f $(objtree)/.scmversion
>
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
