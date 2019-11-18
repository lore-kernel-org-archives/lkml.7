Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C51FC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AFE206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJgUBCKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKRMoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:44:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44162 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKRMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:44:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id n186so1257332lfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 04:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=weamprY/BAAhsZ3zJUJ69hq1P4hOTR5QL4AMQKW40F4=;
        b=WJgUBCKIuW3ZXPWP+1ey063mDSjF5yHQVnF1Ogrvh5I+CM+qTo4ZG0YUHlcLxb4zvc
         jPVVd9GRl/8XS2fOUmNl5TWlTT93lUIODTUVlVDOz23VgJjVjeAtmp1cMsuggwlpqvVv
         tFOOT1ZsCY6EUJmwDsHSaqyYqlzUXEFlzSynVe0SxLVgjuKg8cpJwV7xpg2WIVJbzzdU
         dt5VP21UfU/A+mDvgu1AY6RvZEdTTuNcfz8JoW9FyimfoJ1RlhbEaK7vGpsmmub85TLa
         TmGApGw2zEWJos2Xlw1ojWBUN0eWILpRasyi59/jNveNIAMJNfQvPJcuS2Fr9CZ4ZeQV
         oRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=weamprY/BAAhsZ3zJUJ69hq1P4hOTR5QL4AMQKW40F4=;
        b=b154T6OyaqlI7DmEHF5VnHkQuHBY+/IEp+7VcgJm+ZxtGY2UOIthtIcVqYhn79xKt8
         h+XM/W2b+2U8cllTwwUZPSsLf9VLZz//KN1X8RcWvQ9YWO200rfINENf9aJtRfyd+6QD
         GiPfAA8+5P2ys/DAS+bNyw63LkF/wgoweB3xIv/e21uj2Y5FW6YIIBKipBd8kZpoLWfi
         XlpUFtvD4dElXkXihrFHevOmimbjgXMMDejobeQbeNKv6X7TUx9cs2/o2V/omDoUOxAk
         3ddMn3psmESGwYAslbt46yqCLNNX1Esmnc0SIQUdDbT0H7R0fPUVJiWyVGxjHR0OpVzF
         Z88w==
X-Gm-Message-State: APjAAAW2fWpEYajmbkfhCOD888fefdXTvUm/PKSqd2j2pV/kcoANOR90
        qyPfEy95fjYG9oZdZlstjewBYIILfV7OjClW3Yc=
X-Google-Smtp-Source: APXvYqwK+OotQ/dypqLdZQBMWvuNfkemTONUGiYCqna6cuI6xhqOMUAHtl6t5v60xOHRxzUUaWweLl99Vy+XbhXQyfE=
X-Received: by 2002:ac2:4a8a:: with SMTP id l10mr20353422lfp.185.1574081051168;
 Mon, 18 Nov 2019 04:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20191117000544.1019556-1-mail@maciej.szmigiero.name>
In-Reply-To: <20191117000544.1019556-1-mail@maciej.szmigiero.name>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Mon, 18 Nov 2019 13:43:58 +0100
Message-ID: <CAMJBoFNja-7sY=mU4hWDOqvOhZjvSNqyL1hYqJB+Hm1dygxpCA@mail.gmail.com>
Subject: Re: [PATCH v4] zswap: allow setting default status, compressor and
 allocator in Kconfig
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

sorry for jumping in late into this discussion.

On Sun, Nov 17, 2019 at 1:05 AM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
<snip>
> +config ZSWAP_COMPRESSOR_DEFAULT
> +       string
> +       default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
> +       default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
> +       default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
> +       default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
> +       default "lz4hc" if ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
> +       default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
> +       default ""

I guess this should also depend on ZSWAP. It looks a bit awkward when
this option is present in dotconfig while ZSWAP is not.

> +
> +choice
> +       prompt "Compressed cache for swap pages default allocator"
> +       depends on ZSWAP
> +       default ZSWAP_ZPOOL_DEFAULT_ZBUD
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
> +config ZSWAP_ZPOOL_DEFAULT_ZBUD
> +       bool "zbud"
> +       select ZBUD
> +       help
> +         Use the zbud allocator as the default allocator.
> +
> +config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
> +       bool "z3fold"
> +       select Z3FOLD
> +       help
> +         Use the z3fold allocator as the default allocator.
> +
> +config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> +       bool "zsmalloc"
> +       select ZSMALLOC
> +       help
> +         Use the zsmalloc allocator as the default allocator.
> +endchoice
> +
> +config ZSWAP_ZPOOL_DEFAULT
> +       string
> +       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
> +       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
> +       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> +       default ""

Same here.

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
> index 46a322316e52..71795b6f5b71 100644
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

Wouldn't it be better to have 'static bool zswap_enabled =
IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);' instead?

>  static int zswap_enabled_param_set(const char *,
>                                    const struct kernel_param *);
>  static struct kernel_param_ops zswap_enabled_param_ops = {
> @@ -82,8 +86,7 @@ static struct kernel_param_ops zswap_enabled_param_ops = {
>  module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644);
>
>  /* Crypto compressor to use */
> -#define ZSWAP_COMPRESSOR_DEFAULT "lzo"
> -static char *zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
> +static char *zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
>  static int zswap_compressor_param_set(const char *,
>                                       const struct kernel_param *);
>  static struct kernel_param_ops zswap_compressor_param_ops = {
> @@ -95,8 +98,7 @@ module_param_cb(compressor, &zswap_compressor_param_ops,
>                 &zswap_compressor, 0644);
>
>  /* Compressed storage zpool to use */
> -#define ZSWAP_ZPOOL_DEFAULT "zbud"
> -static char *zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
> +static char *zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
>  static int zswap_zpool_param_set(const char *, const struct kernel_param *);
>  static struct kernel_param_ops zswap_zpool_param_ops = {
>         .set =          zswap_zpool_param_set,
> @@ -569,11 +571,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
>         bool has_comp, has_zpool;
>
>         has_comp = crypto_has_comp(zswap_compressor, 0, 0);
> -       if (!has_comp && strcmp(zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT)) {
> +       if (!has_comp && strcmp(zswap_compressor,
> +                               CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
>                 pr_err("compressor %s not available, using default %s\n",
> -                      zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT);
> +                      zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
>                 param_free_charp(&zswap_compressor);
> -               zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
> +               zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
>                 has_comp = crypto_has_comp(zswap_compressor, 0, 0);
>         }
>         if (!has_comp) {
> @@ -584,11 +587,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
>         }
>
>         has_zpool = zpool_has_pool(zswap_zpool_type);
> -       if (!has_zpool && strcmp(zswap_zpool_type, ZSWAP_ZPOOL_DEFAULT)) {
> +       if (!has_zpool && strcmp(zswap_zpool_type,
> +                                CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
>                 pr_err("zpool %s not available, using default %s\n",
> -                      zswap_zpool_type, ZSWAP_ZPOOL_DEFAULT);
> +                      zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
>                 param_free_charp(&zswap_zpool_type);
> -               zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
> +               zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
>                 has_zpool = zpool_has_pool(zswap_zpool_type);
>         }
>         if (!has_zpool) {
