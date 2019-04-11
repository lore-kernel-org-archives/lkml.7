Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C575C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90722133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CKK7J7rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDKFcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:32:20 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:17299 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:32:20 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x3B5WFeX025608
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 14:32:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x3B5WFeX025608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554960736;
        bh=jXlFVG4S2JW5MRoJEjXHRxG1pxHks11F7LB4CFGFPxo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CKK7J7rjQMivDAsCLJrjrTJUv5HhaXi+gwqmkC2B1g/uHWiUP08ukzschapvN+fLU
         z6Yo56CW4wL+494ssrBd5AGVw+JPqwxGY24Q74j1UuJXlt9AjN/VASbcX9byKiDfe0
         evsmEQIJsXDXqdZRxx1IycLoJGgrVwKaDvgimTbRjia3ApAPG3jRHVtK9hYPhslR77
         7Z1ZePZKILuBUwi+cgL8Nyw4p7HDmn+03n9vFCaBKjdA3m4ZaAQL7SZPcF1Tn6ehyV
         bqJOzql0yZPHIYFDKSiaFQv7jnPF1GQtuEdVc4157qzg/aTWKGC3ELfT9BPytd6LJ4
         WBNtjOkgwjdng==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id l17so1613430uar.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 22:32:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWicfAfb1DU2eJQTA4UmcEhbNAMv+XvtNC8F+ioJAhyESWt2PNQ
        ZfYKElKW1DXlqhI4nAP8zpK6AVo5fMYjarAdbgQ=
X-Google-Smtp-Source: APXvYqymR2W4mS+YHe1V4XeBDaiiQCpb2Ns7xIWTRSbPGFEXGuvGxHi7Bs+mdsGn7UJYaLx4JzIXY6RfY1vWWBrsolw=
X-Received: by 2002:ab0:65c7:: with SMTP id n7mr25201260uaq.3.1554960735124;
 Wed, 10 Apr 2019 22:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190411005634.8495-1-okaya@kernel.org>
In-Reply-To: <20190411005634.8495-1-okaya@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 14:31:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=G7-nXr=pT2EYExGNkCcOcd2NH1haaBMt+JsyhX2Z8Q@mail.gmail.com>
Message-ID: <CAK7LNAS=G7-nXr=pT2EYExGNkCcOcd2NH1haaBMt+JsyhX2Z8Q@mail.gmail.com>
Subject: Re: [PATCH v3] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 9:59 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> We can't seem to have a kernel with CONFIG_EXPERT set but
> CONFIG_DEBUG_KERNEL unset these days.
>
> While some of the features under the CONFIG_EXPERT require
> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
>
> It looks like CONFIG_KALLSYMS_ALL is the only feature that
> requires CONFIG_DEBUG_KERNEL.

Which part of KALLSYMS_ALL code requires CONFIG_DEBUG_KERNEL?



> Select CONFIG_EXPERT when CONFIG_DEBUG_KERNEL is chosen but
> you can still choose CONFIG_EXPERT without CONFIG_DEBUG_KERNEL.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  init/Kconfig      | 2 --
>  lib/Kconfig.debug | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 4592bf7997c0..37e10a8391a3 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1206,8 +1206,6 @@ config BPF
>
>  menuconfig EXPERT
>         bool "Configure standard kernel features (expert users)"
> -       # Unhide debug options, to make the on-by-default options visible
> -       select DEBUG_KERNEL
>         help
>           This option allows certain base kernel options and settings
>            to be disabled or tweaked. This is for specialized
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 0d9e81779e37..9fbf3499ec8d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -434,6 +434,7 @@ config MAGIC_SYSRQ_SERIAL
>
>  config DEBUG_KERNEL
>         bool "Kernel debugging"
> +       default EXPERT
>         help
>           Say Y here if you are developing drivers or trying to debug and
>           identify kernel problems.
> --
> 2.21.0
>


--
Best Regards

Masahiro Yamada
