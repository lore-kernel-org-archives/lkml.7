Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE262063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QPCK9ufq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfCKR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:26:08 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30244 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:26:08 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2BHPo8w013037;
        Tue, 12 Mar 2019 02:25:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2BHPo8w013037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552325151;
        bh=/uTXvDqoIkGNMXXXDJ+c1whBGdzleS4VwYBQuTu5TSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QPCK9ufq1EkWd4ea7WzLwAeEIB3a5ZdOlZma1+2dWpp7m9zNlrjbgy0uTGZmmPqrS
         PM3hpJYEvans19WFKO+Rm5amCQmHcQIcxLGMlFhgJWvmzne/GDlBInVi9dHNUEsiw1
         15BWMspej794IqHW87XsvLvre4zS4dZhBGztaT5X4d2Cu6xq/DWItUrQYU1FuTpLDd
         bvFJMjeLiLzfU0OxubkplxYteJRnN7N5S66coFTazBZSsPUaTVHWTbhNYHhf024J0G
         4GbF5GaLZPb7URcAVSc0f2zQHrY3s2gqKtp/fhZ9XuvpOoGwaNXY89nXKOkywpMLlE
         UydjbmlAfr29w==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id j12so3225034vsd.3;
        Mon, 11 Mar 2019 10:25:50 -0700 (PDT)
X-Gm-Message-State: APjAAAV+pNZKXfwg4t4Nhffxyy02cXxp9fj9keu8kwRAn/MQbTfGRV7p
        MyMn2alUXqxL0rBFrtLk7dQZ6GC/SStBnPdh+Nw=
X-Google-Smtp-Source: APXvYqwVWfwnkQ22Qr8JgOqqcj14FI4XLr2p4959uakaEuPpbTe2q7e5B9RSjp6T0PpcvYgXnFmlamLM4Ui9Evqs5qU=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr17485537vsq.215.1552325149774;
 Mon, 11 Mar 2019 10:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190304165732.24043-1-ar@cs.msu.ru> <20190304165732.24043-3-ar@cs.msu.ru>
In-Reply-To: <20190304165732.24043-3-ar@cs.msu.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 02:25:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzyyga_jbd_9BbEqws9PE-19L3FSxxoPwbC7ieic0yQg@mail.gmail.com>
Message-ID: <CAK7LNATzyyga_jbd_9BbEqws9PE-19L3FSxxoPwbC7ieic0yQg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: kselftest: use KCONFIG_CONFIG
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
>
> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d5713e7b1e50..4d8760166a47 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1199,9 +1199,9 @@ kselftest-clean:
>
>  PHONY += kselftest-merge
>  kselftest-merge:
> -       $(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
> +       $(if $(wildcard $(objtree)/$(KCONFIG_CONFIG)),, $(error No $(KCONFIG_CONFIG) exists, config your kernel first!))
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> -               -m $(objtree)/.config \
> +               -m $(objtree)/$(KCONFIG_CONFIG) \


You are blindly replacing .config with $(KCONFIG_CONFIG).


What kind of usage do you assume for KCONFIG_CONFIG ?

$(objtree)/$(KCONFIG_CONFIG) means
$(KCONFIG_CONFIG) never becomes an absolute path.








>                 $(srctree)/tools/testing/selftests/*/config
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
> --
> 2.20.1
>


--
Best Regards
Masahiro Yamada
