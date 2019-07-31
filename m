Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B59C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F71206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEiIEPSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfGaFdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:33:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44711 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaFdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 01:33:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so68133262wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loiK9wXUCOiEY9KsTjnNAjKwl1yaWs5jTqxh2hr1suU=;
        b=aEiIEPSp1AJ2+tVsqc5bS6kU/EOdjHNsSwpNEKGjlrbsV2rNvXmgTJpWFoA7vGEdOU
         9EdsC+YaQVZM6b6VE89HsgoAhA70wVUfvEXl8SZ+x7T1fR1n5vCj+glb7dqPUfUWR0WI
         p1j4JzNul4oGnXuhq8GYssbzgZPjUR7A6oLx0zGEpwpHJSGCwh0E3Y9ycnlIc2C2OqTi
         nEvaZQCVFtpb9dkIJKnCR+AO1wc0i2cYn6j3tIg/bpOflUiTTPBCBx5EHQpWSRLI8+lt
         BiHv8u1U9Q7JweVygK+icmqR3gb2F7cE+XG7JQVyhq0ZiPFgAoR+CjGLU61YpfcHdSBb
         yC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loiK9wXUCOiEY9KsTjnNAjKwl1yaWs5jTqxh2hr1suU=;
        b=aKN5PPRDUMWn31kSNhKnv8zvLCWxstVFtVKwAV68UKTiCsOIHxojevhPu9zlk011Fz
         kcZ3Mygw9YCCXbPZ2mJA0sOrWvt85kmRsLOEVkHtppkGdoIjFi6NvEcZZ+Qtw00GKgT3
         LNHZRhFJDcNuW/n5BuvmznS1jbbjkHaXxwgi83Qow7H4LJbLjppikmtPsMAAdHCbCTxa
         50rdMGvu41mTeYHhOwqyaRsjO+g5UgHO59YHj6m+5ejfK4k7QoE2IZ/fFfnS2KmSbEXG
         Tb2x+PS8Hx8YeYIsqX1VP7HwD6QzV5zTEeK3akYPkwm0QlOdA79DlSptUGe4Ks3q0Xng
         QOlA==
X-Gm-Message-State: APjAAAW6R57tlkdqaHaV/wRtqyhfNAGoqsUo+WyJviGqpYX4L0lFIbGm
        L18ENs+ZMaVs3FRdt2JWld0p2cQcMTYiatCCPTzRtA==
X-Google-Smtp-Source: APXvYqxhshVQRxJPu9P5SIvWuW4Sa8P4b92k4Xh507OU4+Jac8/nsKvirOJ8JOEIXH82zG39w5tN3qwlUoh6wirKz+w=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr136343841wrs.93.1564551183914;
 Tue, 30 Jul 2019 22:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <1564482824-26581-1-git-send-email-iuliana.prodan@nxp.com> <1564482824-26581-3-git-send-email-iuliana.prodan@nxp.com>
In-Reply-To: <1564482824-26581-3-git-send-email-iuliana.prodan@nxp.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 31 Jul 2019 08:32:53 +0300
Message-ID: <CAKv+Gu_VEEZFPpJfv2JbB02vhmc_1_wpxNDBHf__pv-t7BvN0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] crypto: aes - helper function to validate key
 length for AES algorithms
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 at 13:33, Iuliana Prodan <iuliana.prodan@nxp.com> wrote:
>
> Add inline helper function to check key length for AES algorithms.
> The key can be 128, 192 or 256 bits size.
> This function is used in the generic aes implementation.
>
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  include/crypto/aes.h | 17 +++++++++++++++++
>  lib/crypto/aes.c     |  8 ++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/include/crypto/aes.h b/include/crypto/aes.h
> index 8e0f4cf..8ee07a8 100644
> --- a/include/crypto/aes.h
> +++ b/include/crypto/aes.h
> @@ -31,6 +31,23 @@ struct crypto_aes_ctx {
>  extern const u32 crypto_ft_tab[4][256] ____cacheline_aligned;
>  extern const u32 crypto_it_tab[4][256] ____cacheline_aligned;
>
> +/*
> + * validate key length for AES algorithms
> + */
> +static inline int crypto_aes_check_keylen(unsigned int keylen)

Please rename this to aes_check_keylen()

> +{
> +       switch (keylen) {
> +       case AES_KEYSIZE_128:
> +       case AES_KEYSIZE_192:
> +       case AES_KEYSIZE_256:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
>                 unsigned int key_len);
>
> diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
> index 4e100af..3407b01 100644
> --- a/lib/crypto/aes.c
> +++ b/lib/crypto/aes.c
> @@ -187,11 +187,11 @@ int aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
>  {
>         u32 kwords = key_len / sizeof(u32);
>         u32 rc, i, j;
> +       int err;
>
> -       if (key_len != AES_KEYSIZE_128 &&
> -           key_len != AES_KEYSIZE_192 &&
> -           key_len != AES_KEYSIZE_256)
> -               return -EINVAL;
> +       err = crypto_aes_check_keylen(key_len);
> +       if (err)
> +               return err;
>
>         ctx->key_length = key_len;
>
> --
> 2.1.0
>
