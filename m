Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE6BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 02:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2494F21871
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 02:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="M3slvbGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCQCvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 22:51:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:27322 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfCQCve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 22:51:34 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2H2p6DM004982;
        Sun, 17 Mar 2019 11:51:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2H2p6DM004982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552791067;
        bh=DKPamK0hoaqhNy/DV4SeLx87SPhPHDMMcdWgh8BWLd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M3slvbGQVOWApOUZM1NZ7kO9tYg6X4G37axoC/qCHUMA+oWiXvI/MwfON6GQOJiaa
         WEXOcJZ8I33T51hPI2M56a13ZRPyFJ3WMLTXFtqP1l2hBbO66HB7EQhg+BNWp0kkFF
         zy6RUi0p4U3zJjUO+NC2qipYGFBi51A6Wa/sGFLGxscN7QYKYzBoELCnmAXpcPFO+j
         JeXHUDowoQeXzRu3t41XtGPEzYh67GBltseqREjGIRs7gJCNPEBXro7BB9I/0CQNt2
         KOVpGfOuPYTA0E3l9F1kRkgXi9fKqRqRwXOo+GWn6uIsWWymz+tjSEnldzLZ0HAVL2
         Z0Un7T6gfMUQQ==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id e131so3041134vkf.10;
        Sat, 16 Mar 2019 19:51:07 -0700 (PDT)
X-Gm-Message-State: APjAAAVAoO0KRb9hF1x1fNahyf6KjA8hu/5RGAUpx8Ru+Yfms8mxm0hj
        h5eAXkGJII/D0RoodclmgHuLe8JXas8T/kE/47o=
X-Google-Smtp-Source: APXvYqzE2NYJ2vdzzGVDiSBKOY1K6d+7uyupfDgrG24+rwX+J7RqPfcQ4BnZO3r8LhcJsCDrMGoQFjd+w/c1EIr7n1M=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr5841019vkd.84.1552791066020;
 Sat, 16 Mar 2019 19:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190315162503.131510-1-dianders@chromium.org>
In-Reply-To: <20190315162503.131510-1-dianders@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 17 Mar 2019 11:50:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUfyoUSaAVLhrT+N9w7AH81y6-gqkUcTYOeFJM8Dv1AQ@mail.gmail.com>
Message-ID: <CAK7LNAQUfyoUSaAVLhrT+N9w7AH81y6-gqkUcTYOeFJM8Dv1AQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "modsign: Abort modules_install when signing fails"
To:     Douglas Anderson <dianders@chromium.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 1:25 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> This reverts commit caf6fe91ddf62a96401e21e9b7a07227440f4185.
>
> The commit was fine but is no longer needed as of commit 3a2429e1faf4
> ("kbuild: change if_changed_rule for multi-line recipe").  Let's go
> back to using ";" to be consistent.
>
> For some discussion, see:
>
> https://lkml.kernel.org/r/CAK7LNASde0Q9S5GKeQiWhArfER4S4wL1=R_FW8q0++_X3T5=hQ@mail.gmail.com
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---


Applied to linux-kbuild. Thanks.




>  scripts/Makefile.modinst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index ff5ca9817a85..0dae402661f3 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -23,7 +23,7 @@ quiet_cmd_modules_install = INSTALL $@
>      mkdir -p $(2) ; \
>      cp $@ $(2) ; \
>      $(mod_strip_cmd) $(2)/$(notdir $@) ; \
> -    $(mod_sign_cmd) $(2)/$(notdir $@) $(patsubst %,|| true,$(KBUILD_EXTMOD)) && \
> +    $(mod_sign_cmd) $(2)/$(notdir $@) $(patsubst %,|| true,$(KBUILD_EXTMOD)) ; \
>      $(mod_compress_cmd) $(2)/$(notdir $@)
>
>  # Modules built outside the kernel source tree go into extra by default
> --
> 2.21.0.360.g471c308f928-goog
>


-- 
Best Regards
Masahiro Yamada
