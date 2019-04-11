Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41811C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C064217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KlAIUqIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDKCpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:45:55 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34029 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKCpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:45:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id t78so2630470vsc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 19:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7h8a+DAJL8hqysadYjKn6udNQom9LPAme8QIHO+0C3c=;
        b=KlAIUqIxxmcZ08qH5i3m8xv/hSw2NOeltTNqKv1oMrmpP12o7GQ1Pa0iDslYClGBT/
         VN8FWKctABfFTAzLEzCbqb1WWL9YWZinF5hcWdORbQi9Gr6Pu/Wgt+ba1wcmydMSFUsj
         tJP24DNDeIoMx75nyGBFLQ/bi20yCPDCBLvUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7h8a+DAJL8hqysadYjKn6udNQom9LPAme8QIHO+0C3c=;
        b=FQKc5AZgkTzRvdRevR/Gyte5NKHXXQFI8J7IwIkyCHQCdBA7SB9Yhxru1pMWN5Rqbw
         L7HO/cKLOg45/H4sAklxoR5gtMBVyVCvlIpYSsboC3uSN2wIfyrk63E/mS+2p5huxJWi
         zTVZdp1xWNhDfvs14cUN7ZMJ92+Wxon7X+gfgwIAIgO4B3csrQ2TOicig2qPyEO9d7RE
         atM2tJ7Z7nNNP67sz6kjmIs/FQbn3iXfIaIHBOPhy+vsubBGwBxb+4GFh5Crb9KH9BQ2
         XxI8DzalaTPOSBG0wd+6309qG8FksLn80U4XOVD9sQ5lvAFjfru8thgdwIep8jKh8K41
         +ftg==
X-Gm-Message-State: APjAAAWciLN7yvdTDc83EXh2NpNEVIY3U80NeIO2z60vgY9NN9dwXOMV
        0GvHDdJBV0K4pykTlDLxwwRgaMCc/SE=
X-Google-Smtp-Source: APXvYqzrz/cXkCtOblX/f+HSml4D9ikODojZRgdJXfmsU96OBz3JnUGlsrvF2oQfgd5nl0HA8CBH3g==
X-Received: by 2002:a67:f753:: with SMTP id w19mr25789709vso.27.1554950754322;
        Wed, 10 Apr 2019 19:45:54 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 2sm16844042vke.27.2019.04.10.19.45.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 19:45:54 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id h4so1511073uaj.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 19:45:53 -0700 (PDT)
X-Received: by 2002:ab0:a97:: with SMTP id d23mr8084301uak.99.1554950355141;
 Wed, 10 Apr 2019 19:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190411005634.8495-1-okaya@kernel.org>
In-Reply-To: <20190411005634.8495-1-okaya@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 19:39:03 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLU8Nh0+9rMSeOxwv4hUoPFWSiGf_L_SKpSHO_=VZxisg@mail.gmail.com>
Message-ID: <CAGXu5jLU8Nh0+9rMSeOxwv4hUoPFWSiGf_L_SKpSHO_=VZxisg@mail.gmail.com>
Subject: Re: [PATCH v3] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <okaya@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
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

On Wed, Apr 10, 2019 at 5:56 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> We can't seem to have a kernel with CONFIG_EXPERT set but
> CONFIG_DEBUG_KERNEL unset these days.
>
> While some of the features under the CONFIG_EXPERT require
> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
>
> It looks like CONFIG_KALLSYMS_ALL is the only feature that
> requires CONFIG_DEBUG_KERNEL.
>
> Select CONFIG_EXPERT when CONFIG_DEBUG_KERNEL is chosen but
> you can still choose CONFIG_EXPERT without CONFIG_DEBUG_KERNEL.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Masahiro, should this go via your tree, or somewhere else?

Thanks!

-Kees

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
Kees Cook
