Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3936C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932BC205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGeyFwB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfLKJi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:38:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45876 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfLKJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:38:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so23195013wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpAB2VunJi/hr5WJdoV5Gbgby6kk23SzTl+e0ymIH3E=;
        b=PGeyFwB2stSmWA6Y07SK58oUwxsuOdFywJjIQOqKUtnN/Vgv26e5IJt3bLoso0HWAl
         umL3nzIIcaCU3opZL0eacrNCQVS557vvz6S98jpxkp8k9Z97a4rjzLpuTZ2rnCXaoAuX
         1krLvgrF1UFYXT6XpcrwcJXi7bDBwaPvAtsarvKYxc8YLV/tVicv9Wxsp/Rcsl9RYnMn
         wdCg+wBrSfVU1o9dRhXb0kDBm9VJwATzO9KwGewATTyZDaBsTzVzpQAfIN4cgNjb558c
         4Be2mIqIest13/lbhIEbYh2b3ca8dQJeqoiAuViGyuCj/kYIxCASXw8QQijYiLT/C+F9
         d4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpAB2VunJi/hr5WJdoV5Gbgby6kk23SzTl+e0ymIH3E=;
        b=X2tqrMpd31Tr8WBxwT7uS02ph6CwxYjOQdJLcU+y+vswzTh3RMYl93CQ0zLiSV4Tg2
         NBAwhLUQd6xEWx1XjFFCes43AxPO8HoK9waObi6ntzhBdLSNkQYvVEIZS1LFZk1rmioo
         s3xdmVykoZn219QKYQvO9dAdfajtAgUdqibI9eO1tEdPXuc2ESknCNsjl87NlpBJPzri
         FgdvjviOf1IbgswlkAshgtVC4PWWaiK7kdp7CfL9aGLJqpEJlo1wBt3EOEqHK+wHtRgD
         pWNqrbnJTun0m2/N4ugw0IAWYbsvNm9Dow9L+7b30D3uAO1zZqqqW5LKonQ1zPZTaH7s
         34SA==
X-Gm-Message-State: APjAAAV45khAfSvCib9qb57eY4Iu2jWZ4xNlgm4C4QZS4qhe9qL+Kl2T
        UWWjH+PRKMUWfTX3TsZfn18JonKrZBOxhN3vQaXBYNYnP/fiYw==
X-Google-Smtp-Source: APXvYqzS9NV895DIXOWDSxsk8Dt5Yb3kvVGBjEhZUimO4Ao8HcRX1tAJFyvLkxzffrJ9VDtoRG82u/OcFftgIXiBkLs=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr2765986wrw.246.1576057136102;
 Wed, 11 Dec 2019 01:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20191211102455.7b55218e@canb.auug.org.au> <20191211092640.107621-1-Jason@zx2c4.com>
In-Reply-To: <20191211092640.107621-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Dec 2019 09:38:54 +0000
Message-ID: <CAKv+Gu80vONMAuv=2OpSOuZHvVv22quRxeNtbxnSkFBz_DvfbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: arm/curve25519 - add arch-specific key
 generation function
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 at 10:27, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Somehow this was forgotten when Zinc was being split into oddly shaped
> pieces, resulting in linker errors.

Zinc has no historical significance here, so it doesn't make sense to
keep referring to it in the commit logs.

> The x86_64 glue has a specific key
> generation implementation, but the Arm one does not. However, it can
> still receive the NEON speedups by calling the ordinary DH function
> using the base point.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

With the first sentence dropped,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/crypto/curve25519-glue.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/crypto/curve25519-glue.c b/arch/arm/crypto/curve25519-glue.c
> index f3f42cf3b893..776ae07e0469 100644
> --- a/arch/arm/crypto/curve25519-glue.c
> +++ b/arch/arm/crypto/curve25519-glue.c
> @@ -38,6 +38,13 @@ void curve25519_arch(u8 out[CURVE25519_KEY_SIZE],
>  }
>  EXPORT_SYMBOL(curve25519_arch);
>
> +void curve25519_base_arch(u8 pub[CURVE25519_KEY_SIZE],
> +                         const u8 secret[CURVE25519_KEY_SIZE])
> +{
> +       return curve25519_arch(pub, secret, curve25519_base_point);
> +}
> +EXPORT_SYMBOL(curve25519_base_arch);
> +
>  static int curve25519_set_secret(struct crypto_kpp *tfm, const void *buf,
>                                  unsigned int len)
>  {
> --
> 2.24.0
>
