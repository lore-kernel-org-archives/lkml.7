Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6B4CA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC31F20663
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="KP3o5+kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442623AbfJRLT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:19:56 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34151 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbfJRLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:19:56 -0400
Received: by mail-il1-f195.google.com with SMTP id c12so5211906ilm.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRnwFaeBISwCOBtGneHhEDkXuGB9hR6LCfM4cAgGpb8=;
        b=KP3o5+kjXiH6idIVoxUECH4C9jODkFMgoVxloHFyQRJnkdhGjLvhzH+xG0LkZv+x2I
         CH2bFl5MisZQp3jP7zWY8qK42vaV+jIjrn2Htvjk8ofXuH8rLHPfTmKgznEdaWOlz0Pv
         7+V1f92BXBtbBQsVhS5uYpLD8iWQCvmEvsius=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRnwFaeBISwCOBtGneHhEDkXuGB9hR6LCfM4cAgGpb8=;
        b=daMtIoZLnDw4WzcCKL6xJAFuRzzI4I1atzMgYS2KwJh8P7pLn5hesJ96vLrmuEPdAR
         0t3fi15mfZ5Zcremzoha1hPgateI1bZDxu7I/oggoTZdXVxLCipgGYPA/ikrqH3vDwom
         V/Ktl6WRX3yhpbvxpAiKwaTESnLqSnMqcoBddi0Xd6m6rBNUX42Cfoe95eSIGATL6OGh
         5MatGryIRyJG+HqbJeZ5KKKMuxV3fXGmrAOcP2hj7TI5XIo8Wq2mxfxqQ4MPIMtt074L
         mCwtet/pKcrsFuB+LKRWzZA0VbMY+7EhHmZCrFxqsrn+Y0XO3tLFpNnzuX9AWs6+DWM1
         QWzA==
X-Gm-Message-State: APjAAAXHCPnu2uOLVOdCMasdiM7nIw7N/OaG0IIK5OALp6QS5h/NLP5t
        hULQ4UdKGOutPfA5Lz22a4DPuBUJUq1eP7ZdrFE=
X-Google-Smtp-Source: APXvYqxIft51tgSGAMUPe7vgyxfNkwZ1ompTrZP710NZxqHkVHnjX9HwnvJsXI5tQBZd0tr0VoRk4/YLRs4YBR4HLIU=
X-Received: by 2002:a92:1083:: with SMTP id 3mr9975411ilq.259.1571397594755;
 Fri, 18 Oct 2019 04:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191011234038.198995-1-mail@maciej.szmigiero.name>
In-Reply-To: <20191011234038.198995-1-mail@maciej.szmigiero.name>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Fri, 18 Oct 2019 07:19:18 -0400
Message-ID: <CALZtONCx4L5K7+h3TuS1Ms_q_Mt_5JcZ+XTgACqdDyVsaCS76g@mail.gmail.com>
Subject: Re: [PATCH] zswap: allow setting default status, compressor and
 allocator in Kconfig
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitalywool@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 7:40 PM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> The compressed cache for swap pages (zswap) currently needs from 1 to 3
> extra kernel command line parameters in order to make it work: it has to be
> enabled by adding a "zswap.enabled=1" command line parameter and if one
> wants a different compressor or pool allocator than the default lzo / zbud
> combination then these choices also need to be specified on the kernel
> command line in additional parameters.
>
> Using a different compressor and allocator for zswap is actually pretty
> common as guides often recommend using the lz4 / z3fold pair instead of
> the default one.
> In such case it is also necessary to remember to enable the appropriate
> compression algorithm and pool allocator in the kernel config manually.
>
> Let's avoid the need for adding these kernel command line parameters and
> automatically pull in the dependencies for the selected compressor
> algorithm and pool allocator by adding an appropriate default switches to
> Kconfig.

Who is the target for using these kernel build-time defaults?  I don't
think any distribution would be defaulting zswap to enabled, and if
the config defaults are intended for personal kernel builds, it is
really so much harder to just configure it on the boot cmdline?

>
> The default values for these options match what the code was using
> previously as its defaults.
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  mm/Kconfig | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/zswap.c |  26 ++++++++------
>  2 files changed, 117 insertions(+), 12 deletions(-)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5dae9a7eb51..4309bcaaa29d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -525,7 +525,6 @@ config MEM_SOFT_DIRTY
>  config ZSWAP
>         bool "Compressed cache for swap pages (EXPERIMENTAL)"
>         depends on FRONTSWAP && CRYPTO=y
> -       select CRYPTO_LZO
>         select ZPOOL
>         help
>           A lightweight compressed cache for swap pages.  It takes
> @@ -541,6 +540,108 @@ config ZSWAP
>           they have not be fully explored on the large set of potential
>           configurations and workloads that exist.
>
> +choice

Using choice becomes a bit of a maintenence issue...if we add this,
wouldn't it be better to use string input so new compression algs can
be added without having to update this Kconfig?

> +       prompt "Compressed cache for swap pages default compressor"
> +       depends on ZSWAP
> +       default ZSWAP_DEFAULT_COMP_LZO
> +       help
> +         Selects the default compression algorithm for the compressed cache
> +         for swap pages.
> +         If in doubt, select 'LZO'.
> +
> +         The selection made here can be overridden by using the kernel
> +         command line 'zswap.compressor=' option.
> +
> +config ZSWAP_DEFAULT_COMP_DEFLATE
> +       bool "Deflate"
> +       select CRYPTO_DEFLATE
> +       help
> +         Use the Deflate algorithm as the default compression algorithm.
> +
> +config ZSWAP_DEFAULT_COMP_LZO
> +       bool "LZO"
> +       select CRYPTO_LZO
> +       help
> +         Use the LZO algorithm as the default compression algorithm.
> +
> +config ZSWAP_DEFAULT_COMP_842
> +       bool "842"
> +       select CRYPTO_842
> +       help
> +         Use the 842 algorithm as the default compression algorithm.
> +
> +config ZSWAP_DEFAULT_COMP_LZ4
> +       bool "LZ4"
> +       select CRYPTO_LZ4
> +       help
> +         Use the LZ4 algorithm as the default compression algorithm.
> +
> +config ZSWAP_DEFAULT_COMP_LZ4HC
> +       bool "LZ4HC"
> +       select CRYPTO_LZ4HC
> +       help
> +         Use the LZ4HC algorithm as the default compression algorithm.
> +
> +config ZSWAP_DEFAULT_COMP_ZSTD
> +       bool "zstd"
> +       select CRYPTO_ZSTD
> +       help
> +         Use the zstd algorithm as the default compression algorithm.
> +endchoice
> +
> +config ZSWAP_DEFAULT_COMP_NAME
> +       string
> +       default "deflate" if ZSWAP_DEFAULT_COMP_DEFLATE
> +       default "lzo" if ZSWAP_DEFAULT_COMP_LZO
> +       default "842" if ZSWAP_DEFAULT_COMP_842
> +       default "lz4" if ZSWAP_DEFAULT_COMP_LZ4
> +       default "lz4hc" if ZSWAP_DEFAULT_COMP_LZ4HC
> +       default "zstd" if ZSWAP_DEFAULT_COMP_ZSTD
> +       default ""
> +
> +choice
> +       prompt "Compressed cache for swap pages default allocator"
> +       depends on ZSWAP
> +       default ZSWAP_DEFAULT_ZPOOL_ZBUD
> +       help
> +         Selects the default allocator for the compressed cache for
> +         swap pages.
> +         The default is 'zbud' for compatibility, however please do
> +         read the description of each of the allocators below before
> +         making a right choice.
> +
> +         The selection made here can be overridden by using the kernel
> +         command line 'zswap.zpool=' option.
> +
> +config ZSWAP_DEFAULT_ZPOOL_ZBUD
> +       bool "zbud"
> +       select ZBUD
> +       help
> +         Use the zbud allocator as the default allocator.
> +
> +config ZSWAP_DEFAULT_ZPOOL_Z3FOLD
> +       bool "z3fold"
> +       select Z3FOLD
> +       help
> +         Use the z3fold allocator as the default allocator.
> +endchoice
> +
> +config ZSWAP_DEFAULT_ZPOOL_NAME
> +       string
> +       default "zbud" if ZSWAP_DEFAULT_ZPOOL_ZBUD
> +       default "z3fold" if ZSWAP_DEFAULT_ZPOOL_Z3FOLD
> +       default ""
> +
> +config ZSWAP_DEFAULT_ON
> +       bool "Enable the compressed cache for swap pages by default"
> +       depends on ZSWAP
> +       help
> +         If selected, the compressed cache for swap pages will be enabled
> +         at boot, otherwise it will be disabled.
> +
> +         The selection made here can be overridden by using the kernel
> +         command line 'zswap.enabled=' option.
> +
>  config ZPOOL
>         tristate "Common API for compressed memory storage"
>         help
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 46a322316e52..59231f6fb2ca 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -71,8 +71,12 @@ static u64 zswap_duplicate_entry;
>
>  #define ZSWAP_PARAM_UNSET ""
>
> -/* Enable/disable zswap (disabled by default) */
> +/* Enable/disable zswap */
> +#ifdef CONFIG_ZSWAP_DEFAULT_ON
> +static bool zswap_enabled = true;
> +#else
>  static bool zswap_enabled;
> +#endif
>  static int zswap_enabled_param_set(const char *,
>                                    const struct kernel_param *);
>  static struct kernel_param_ops zswap_enabled_param_ops = {
> @@ -82,8 +86,7 @@ static struct kernel_param_ops zswap_enabled_param_ops = {
>  module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644);
>
>  /* Crypto compressor to use */
> -#define ZSWAP_COMPRESSOR_DEFAULT "lzo"
> -static char *zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
> +static char *zswap_compressor = CONFIG_ZSWAP_DEFAULT_COMP_NAME;
>  static int zswap_compressor_param_set(const char *,
>                                       const struct kernel_param *);
>  static struct kernel_param_ops zswap_compressor_param_ops = {
> @@ -95,8 +98,7 @@ module_param_cb(compressor, &zswap_compressor_param_ops,
>                 &zswap_compressor, 0644);
>
>  /* Compressed storage zpool to use */
> -#define ZSWAP_ZPOOL_DEFAULT "zbud"
> -static char *zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
> +static char *zswap_zpool_type = CONFIG_ZSWAP_DEFAULT_ZPOOL_NAME;
>  static int zswap_zpool_param_set(const char *, const struct kernel_param *);
>  static struct kernel_param_ops zswap_zpool_param_ops = {
>         .set =          zswap_zpool_param_set,
> @@ -569,11 +571,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
>         bool has_comp, has_zpool;
>
>         has_comp = crypto_has_comp(zswap_compressor, 0, 0);
> -       if (!has_comp && strcmp(zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT)) {
> +       if (!has_comp && strcmp(zswap_compressor,
> +                               CONFIG_ZSWAP_DEFAULT_COMP_NAME)) {

bit of bikeshedding, wouldn't CONFIG_ZSWAP_COMPRESSOR_DEFAULT be
clearer than CONFIG_ZSWAP_DEFAULT_COMP_NAME?

>                 pr_err("compressor %s not available, using default %s\n",
> -                      zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT);
> +                      zswap_compressor, CONFIG_ZSWAP_DEFAULT_COMP_NAME);
>                 param_free_charp(&zswap_compressor);
> -               zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
> +               zswap_compressor = CONFIG_ZSWAP_DEFAULT_COMP_NAME;
>                 has_comp = crypto_has_comp(zswap_compressor, 0, 0);
>         }
>         if (!has_comp) {
> @@ -584,11 +587,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
>         }
>
>         has_zpool = zpool_has_pool(zswap_zpool_type);
> -       if (!has_zpool && strcmp(zswap_zpool_type, ZSWAP_ZPOOL_DEFAULT)) {
> +       if (!has_zpool && strcmp(zswap_zpool_type,
> +                                CONFIG_ZSWAP_DEFAULT_ZPOOL_NAME)) {
>                 pr_err("zpool %s not available, using default %s\n",
> -                      zswap_zpool_type, ZSWAP_ZPOOL_DEFAULT);
> +                      zswap_zpool_type, CONFIG_ZSWAP_DEFAULT_ZPOOL_NAME);
>                 param_free_charp(&zswap_zpool_type);
> -               zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
> +               zswap_zpool_type = CONFIG_ZSWAP_DEFAULT_ZPOOL_NAME;
>                 has_zpool = zpool_has_pool(zswap_zpool_type);
>         }
>         if (!has_zpool) {
