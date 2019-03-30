Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412DFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF7620657
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FfK9mrK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfC3MOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:14:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:52463 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbfC3MOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:14:54 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2UCEh92006588
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 21:14:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2UCEh92006588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553948084;
        bh=FvcjRSwm+l7BcuSlqeVv/mbXcW2eWKSjZsOPYlTDy5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FfK9mrK9uHifnafe/Syjn+OTbLsjjKABEoL8m8AAETaidDkKwSmRDD/buTnJiJjBn
         SPzM9bkcJQOuaSfPhwJ3qIBOp/poSVxib34iEmb5bB6ImoAyByZfFZwOX9Rj45Fjth
         iHHQQdbb3PpnQvqcFbZqwgAbxbHJEmBf6H8uBV++jD9p3RqoVcILZvof2VzRvGm6fE
         7XMtZY6l7/5X8Cqn43KwVcBODqAq/rYefiSRkM3YvH9SB2qs9maO0xSawEbo25KkZb
         Ks1BKiGBL48rfOYNuQAof6HW6mwSpCO1XP1Kxm+ZrCBPOJeDwZ+7kFKgIZQsS2n+me
         kGD9qF1GHJmSQ==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id p13so1571381uaa.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 05:14:43 -0700 (PDT)
X-Gm-Message-State: APjAAAUoODNnWZmSMJemBDHZDlaXNlTh4lU0oyOWLgj739DpF1nr6Tj0
        cGO58SC5JbMJMl1sg4U2Wvx+w5uTeNlp/KMmy70=
X-Google-Smtp-Source: APXvYqxMOHLkMRjk6Z4+nR25e0Kg2WWnh+QXl3hVxkBLSDJZnaHyaBspHAtcwThItcA+BgTH9czpHiuahchqdwedtBQ=
X-Received: by 2002:ab0:348a:: with SMTP id c10mr30776275uar.25.1553948082679;
 Sat, 30 Mar 2019 05:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015227.245455-1-dianders@chromium.org>
In-Reply-To: <20190323015227.245455-1-dianders@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 30 Mar 2019 21:14:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARe3gQeBqNux4hFoq2-uHRQ=vS_6C=h2Dpy=ruZaRZkEA@mail.gmail.com>
Message-ID: <CAK7LNARe3gQeBqNux4hFoq2-uHRQ=vS_6C=h2Dpy=ruZaRZkEA@mail.gmail.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in kdb summary
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:55 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> If you drop into kdb and type "summary", it prints out a line that
> says this:
>
>   ccversion  CCVERSION
>
> ...and I don't mean that it actually prints out the version of the C
> compiler.  It literally prints out the string "CCVERSION".
>
> The version of the C Compiler is already printed at boot up and it
> doesn't seem useful to replicate this in kdb.  Let's just delete it.
> We can also delete the bit of the Makefile that called the C compiler
> in an attempt to pass this into kdb.  This will remove one extra call
> to the C compiler at Makefile parse time and (very slightly) speed up
> builds.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



>  kernel/debug/kdb/Makefile   | 1 -
>  kernel/debug/kdb/kdb_main.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/kernel/debug/kdb/Makefile b/kernel/debug/kdb/Makefile
> index d4fc58f4b88d..efac857c5511 100644
> --- a/kernel/debug/kdb/Makefile
> +++ b/kernel/debug/kdb/Makefile
> @@ -6,7 +6,6 @@
>  # Copyright (c) 2009 Wind River Systems, Inc. All Rights Reserved.
>  #
>
> -CCVERSION      := $(shell $(CC) -v 2>&1 | sed -ne '$$p')
>  obj-y := kdb_io.o kdb_main.o kdb_support.o kdb_bt.o gen-kdb_cmds.o kdb_bp.o kdb_debugger.o
>  obj-$(CONFIG_KDB_KEYBOARD)    += kdb_keyboard.o
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 82a3b32a7cfc..fc96dbf8d9de 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2522,7 +2522,6 @@ static int kdb_summary(int argc, const char **argv)
>         kdb_printf("machine    %s\n", init_uts_ns.name.machine);
>         kdb_printf("nodename   %s\n", init_uts_ns.name.nodename);
>         kdb_printf("domainname %s\n", init_uts_ns.name.domainname);
> -       kdb_printf("ccversion  %s\n", __stringify(CCVERSION));
>
>         now = __ktime_get_real_seconds();
>         time64_to_tm(now, 0, &tm);
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Best Regards
Masahiro Yamada
