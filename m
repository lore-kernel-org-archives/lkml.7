Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98228C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6472089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyOSfdjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfFGPe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:34:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38364 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfFGPe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:34:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so974763plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1nKFwhuq2ZEy0/ENH2G+07fPOyOK64gti3KBgl78Rg=;
        b=qyOSfdjE5eweGadE+c1zpwMdiopx6p5B6y5hDjgg7mxbdYLW+L8J24CH5j4tGB24zV
         frtVpsgEqgv6t0pEMPRIxFRqVIX0XgCddlV3xDyn1kxpBLE035ZJQOz6kto8nCXg+UZf
         3l7L9b+cHyqGyCAwfT9+M4kKBg68+6SbY8qKCBLm2/GJrIinPcHKCZSBbzw38kfTeMMU
         EMojC7jY+x/kucJIy1Ah1RqjKjPV4mWyT+oJ0ADB487CKYFz6hkJsgu7L1BlqgPV+3Uf
         F6o4XVJKM5m2ohulV2gmIEOi8xdfpLXSLNqRCIqfa2kMPX3Ry3A3L97uY65WipPofcEt
         6mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1nKFwhuq2ZEy0/ENH2G+07fPOyOK64gti3KBgl78Rg=;
        b=fiuqs38Q6J2Vaov+dK1mhfZ3UU0DJ+SsDYyJbfvy7AySbMjNUWqiKJtmMr8OEUn2Fm
         /lMUW27opCrN4XbGH33MXnmMFjFGPwIB3ZRWIxGL9Uy8rl/RvBl9M+f2+4l8SI9vjQ9T
         hTDzAJNDESTzcTlMyXo48tvOObFm2hQ9yktgujeOZKVe03tl8HyZO7ESEV423QDIY7rI
         Ug5aWhTlQp9qoQctoig3OwFWS1dam82l4RJ6B2oj516X75A03OQIrVI6LDC1rEKTjNVv
         vzvgl24BPutt/ic/TFcJLDLSeyNrOpZbMitr370BFv/9z5y6TrcI/TziQRq8WMwejMaf
         14DQ==
X-Gm-Message-State: APjAAAW/4PNlkoXbkMFbJeknBi081xQ8PvC1nmXcpXEmJCAnq8gbjBWs
        3d8Bs2aWNyBrrzfzpLGVV9QX+dPtGYo73wnzyrE=
X-Google-Smtp-Source: APXvYqw9nXGzWmX8nvxYPgthgjSRzhgkrmwKTLa6iOK+lafpfMeLjTUNEDhZpxPGfckotfg78xd7BTWVl8SfhZRFCxs=
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr55075010pla.33.1559921668118;
 Fri, 07 Jun 2019 08:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190515210202.21169-1-richard@nod.at>
In-Reply-To: <20190515210202.21169-1-richard@nod.at>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Fri, 7 Jun 2019 17:34:16 +0200
Message-ID: <CAO1O6sdU=kAYS2sTKwiagxrbg+fMer9nvbwA9C4LoFMgH7e1dQ@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Add support for zstd compression.
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        LKML <linux-kernel@vger.kernel.org>,
        Michele Dionisio <michele.dionisio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Den ons 15 maj 2019 kl 23:03 skrev Richard Weinberger <richard@nod.at>:
>
> From: Michele Dionisio <michele.dionisio@gmail.com>
>
> zstd shows a good compression rate and is faster than lzo,
> also on slow ARM cores.
>
> Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
> [rw: rewrote commit message]
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/ubifs/Kconfig       | 10 ++++++++++
>  fs/ubifs/compress.c    | 27 ++++++++++++++++++++++++++-
>  fs/ubifs/super.c       |  2 ++
>  fs/ubifs/ubifs-media.h |  2 ++
>  4 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
> index 9da2f135121b..8d84d2ed096d 100644
> --- a/fs/ubifs/Kconfig
> +++ b/fs/ubifs/Kconfig
> @@ -5,8 +5,10 @@ config UBIFS_FS
>         select CRYPTO if UBIFS_FS_ADVANCED_COMPR
>         select CRYPTO if UBIFS_FS_LZO
>         select CRYPTO if UBIFS_FS_ZLIB
> +       select CRYPTO if UBIFS_FS_ZSTD
>         select CRYPTO_LZO if UBIFS_FS_LZO
>         select CRYPTO_DEFLATE if UBIFS_FS_ZLIB
> +       select CRYPTO_ZSTD if UBIFS_FS_ZSTD
>         select CRYPTO_HASH_INFO
>         select UBIFS_FS_XATTR if FS_ENCRYPTION
>         depends on MTD_UBI
> @@ -37,6 +39,14 @@ config UBIFS_FS_ZLIB
>         help
>           Zlib compresses better than LZO but it is slower. Say 'Y' if unsure.
>
> +config UBIFS_FS_ZSTD
> +       bool "ZSTD compression support" if UBIFS_FS_ADVANCED_COMPR
> +       depends on UBIFS_FS
> +       default y
> +       help
> +         ZSTD compresses is a big win in speed over Zlib and
> +         in compression ratio over LZO. Say 'Y' if unsure.
> +
>  config UBIFS_ATIME_SUPPORT
>         bool "Access time support"
>         default n
> diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
> index 565cb56d7225..89183aeeeb7a 100644
> --- a/fs/ubifs/compress.c
> +++ b/fs/ubifs/compress.c
> @@ -71,6 +71,24 @@ static struct ubifs_compressor zlib_compr = {
>  };
>  #endif
>
> +#ifdef CONFIG_UBIFS_FS_ZSTD
> +static DEFINE_MUTEX(zstd_enc_mutex);
> +static DEFINE_MUTEX(zstd_dec_mutex);
> +
> +static struct ubifs_compressor zstd_compr = {
> +       .compr_type = UBIFS_COMPR_ZSTD,
> +       .comp_mutex = &zstd_enc_mutex,
> +       .decomp_mutex = &zstd_dec_mutex,
> +       .name = "zstd",
> +       .capi_name = "zstd",
> +};
> +#else
> +static struct ubifs_compressor zstd_compr = {
> +       .compr_type = UBIFS_COMPR_ZSTD,
> +       .name = "zstd",
> +};
> +#endif
> +
>  /* All UBIFS compressors */
>  struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
>
> @@ -228,13 +246,19 @@ int __init ubifs_compressors_init(void)
>         if (err)
>                 return err;
>
> -       err = compr_init(&zlib_compr);
> +       err = compr_init(&zstd_compr);
>         if (err)
>                 goto out_lzo;
>
> +       err = compr_init(&zlib_compr);
> +       if (err)
> +               goto out_zstd;
> +
>         ubifs_compressors[UBIFS_COMPR_NONE] = &none_compr;
>         return 0;
>
> +out_zstd:
> +       compr_exit(&zstd_compr);
>  out_lzo:
>         compr_exit(&lzo_compr);
>         return err;
> @@ -247,4 +271,5 @@ void ubifs_compressors_exit(void)
>  {
>         compr_exit(&lzo_compr);
>         compr_exit(&zlib_compr);
> +       compr_exit(&zstd_compr);
>  }
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 04b8ecfd3470..ea8615261936 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -1055,6 +1055,8 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
>                                 c->mount_opts.compr_type = UBIFS_COMPR_LZO;
>                         else if (!strcmp(name, "zlib"))
>                                 c->mount_opts.compr_type = UBIFS_COMPR_ZLIB;
> +                       else if (!strcmp(name, "zstd"))
> +                               c->mount_opts.compr_type = UBIFS_COMPR_ZSTD;
>                         else {
>                                 ubifs_err(c, "unknown compressor \"%s\"", name); //FIXME: is c ready?
>                                 kfree(name);
> diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
> index 8b7c1844014f..697b1b89066a 100644
> --- a/fs/ubifs/ubifs-media.h
> +++ b/fs/ubifs/ubifs-media.h
> @@ -348,12 +348,14 @@ enum {
>   * UBIFS_COMPR_NONE: no compression
>   * UBIFS_COMPR_LZO: LZO compression
>   * UBIFS_COMPR_ZLIB: ZLIB compression
> + * UBIFS_COMPR_ZSTD: ZSTD compression
>   * UBIFS_COMPR_TYPES_CNT: count of supported compression types
>   */
>  enum {
>         UBIFS_COMPR_NONE,
>         UBIFS_COMPR_LZO,
>         UBIFS_COMPR_ZLIB,
> +       UBIFS_COMPR_ZSTD,
>         UBIFS_COMPR_TYPES_CNT,
>  };
>
> --
> 2.16.4

In fs/ubifs/sb.c we have

static int get_default_compressor(struct ubifs_info *c)
{
    if (ubifs_compr_present(c, UBIFS_COMPR_LZO))
        return UBIFS_COMPR_LZO;

    if (ubifs_compr_present(c, UBIFS_COMPR_ZLIB))
        return UBIFS_COMPR_ZLIB;

    return UBIFS_COMPR_NONE;
}

Maybe add an entry for zstd here as well?

/Emil
