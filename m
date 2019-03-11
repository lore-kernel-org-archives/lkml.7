Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73319C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414CC205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cbV/G9mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCKRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:17:09 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:18779 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:17:08 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2BHGoEp006039;
        Tue, 12 Mar 2019 02:16:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2BHGoEp006039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552324611;
        bh=uxEOGkO/pSi+njEemSlT3GVEUBgcDNhufQDLI0FTmM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cbV/G9mQWunANu9NBkOXaxrHr3fzdWFI+zi2mlorfoTLp++2bcgWvW9UTRmYcq+3b
         bUp/OTMNWeXpdPEbZSwnOt7fTMVFzilEyTkG6oD23v9KrtnbuN5hEnJbwPdizBlH0X
         lU6V+GaCUFQzTiveC6LIjPY4MdmwJLvlSWcTQ13lgNSnQbRFM1VIQnklDZY5KUbXHq
         +JBBQVP6u0PxrjLPZ5QIjolRACq8ALEAQtMl42rF+1dKhtWt1NfQODDTW9R49rLpuF
         v+gt9dqQ/I772DX8ggzTZN5/izQ7vGVyyrBaQ3yKHmcsoVJsByckH7yx7GMTBV4dnM
         FOmNIXMBGsqBg==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id e131so1248786vkf.10;
        Mon, 11 Mar 2019 10:16:51 -0700 (PDT)
X-Gm-Message-State: APjAAAVZZ+wGrGcjCFsBrg056qkhR/SGDp1cGhxpJiRg2VHnWiQJptAA
        sXLrgREtudB33Y2yRaD4bR50VXHCoyxRPGXBfe4=
X-Google-Smtp-Source: APXvYqxT3GER1KSAgv9j8us5Jv+GjJiH6QZDNCXeE39DVTeAdYzMyfHqVX5KKLC6eEjdfbypgxzl8qvleJOhwgHWImc=
X-Received: by 2002:a1f:b754:: with SMTP id h81mr16839422vkf.64.1552324609858;
 Mon, 11 Mar 2019 10:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190304165732.24043-1-ar@cs.msu.ru> <20190304165732.24043-2-ar@cs.msu.ru>
In-Reply-To: <20190304165732.24043-2-ar@cs.msu.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 02:16:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNARThXJ_+uL-oQN7YAL2ODpfo5kx09WwrTvxa1wdM4VV3w@mail.gmail.com>
Message-ID: <CAK7LNARThXJ_+uL-oQN7YAL2ODpfo5kx09WwrTvxa1wdM4VV3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] kconfig/Makefile: localmodconfig: use KCONFIG_CONFIG
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:58 AM Arseny Maslennikov <ar@cs.msu.ru> wrote:
>
> If the config file is reassigned through the KCONFIG_CONFIG
> makeflag/envvar, this rule still attempts to use the wrong, possibly
> nonexistent file.
> Let's fix that.


Are you just replacing .config with KCONFIG_CONFIG at random?

scripts/kconfig/streamline_config.pl
hard-codes the .config path,
so this does not work anyway.




> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---
>  scripts/kconfig/Makefile | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 1c7ac07def4d..28be91964a20 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -44,14 +44,14 @@ build_xconfig: $(obj)/qconf
>
>  localyesconfig localmodconfig: $(obj)/conf
>         $(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
> -       $(Q)if [ -f .config ]; then                                     \
> -                       cmp -s .tmp.config .config ||                   \
> -                       (mv -f .config .config.old.1;                   \
> -                        mv -f .tmp.config .config;                     \
> +       $(Q)if [ -f $(KCONFIG_CONFIG) ]; then                           \
> +                       cmp -s .tmp.config $(KCONFIG_CONFIG) ||         \
> +                       (mv -f $(KCONFIG_CONFIG) .tmp.config.old.1;     \
> +                        mv -f .tmp.config $(KCONFIG_CONFIG);           \
>                          $< $(silent) --oldconfig $(Kconfig);           \
> -                        mv -f .config.old.1 .config.old)               \
> +                        mv -f .tmp.config.old.1 $(KCONFIG_CONFIG).old) \
>         else                                                            \
> -                       mv -f .tmp.config .config;                      \
> +                       mv -f .tmp.config $(KCONFIG_CONFIG);            \
>                         $< $(silent) --oldconfig $(Kconfig);            \
>         fi
>         $(Q)rm -f .tmp.config
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
