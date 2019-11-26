Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0388C20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tvg1pKuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfKZLhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:37:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39320 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfKZLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:37:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so2902410wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 03:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLH4BrSwVF86z9PVzc6/l1WPZ28dg/nj2SgGFSXg/4s=;
        b=Tvg1pKucO2eBBRJ73ny/u1bw+hrEteN+mT7Sef1jxxIgtOvzGGlWc0X+S9f9Fcol8f
         4sB2urNnvTc+szm8XSdCHkNClxw/6KaeU6XeGl4TEZVyYpxwgSRAbZTdvPPiMYHB7Zc9
         fHr94aJIIv4TH8yXl1cga55rMYv+LpMDBkTHEaaCqAH7NISkytyxbNEVOOP8ZazhcyxK
         9SENnf8K3X+vNIefLVzBlm6Z+jsz6VJ10QZqxiu992/IFXh+K2fiEUogD17IxJRSi+CB
         oONuZhwIasWdomWwhc+e+84UmiFAIfnBk30J2Yg+Nmk9rEpw/yiH4sTTJuDlSfHClLkH
         daEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLH4BrSwVF86z9PVzc6/l1WPZ28dg/nj2SgGFSXg/4s=;
        b=qb87nhZDddVFbTAK1nMmLpcHSYzRF3kXv+QGEzFEbGA4mSgUlhIWqmNmp4DOcuMTLV
         O0w4+Jbn/s/ff0/7cahEfWWglAB2tp32ry/qlXuKM6bNA1v8lRpc0ZrNaHaY/UmEFyjK
         2WTHv0grZZiMcr4oQjdCxrLEfBXgz7KSLcylNgCt+lPjz5dvjmqgrjz89VtHcXrr0OYj
         D7lg4jk9rbuPkS/w4M2Nh9Z+EhV00kpaVP/n/1BzQmV+jHTiuX1oQq/KA+7RtxTKHbdw
         Jjf9pJ0v7GduDODg0iKS51hZ8d4BWXfgkTPbc8wS1+Xd+MfKg6B03QvJDYW8jmqYNTzc
         FCMQ==
X-Gm-Message-State: APjAAAXZgkoPvAHcWKIHrXQ7pnf4bDh9/ePhH0g6mb5H0NV8P85RJwC/
        q9fIS97EdCHt672p9y/HscJY1s7T1K7JZyVG9r5DPw==
X-Google-Smtp-Source: APXvYqxLMX48nLo+/golBhaJ2UO6Gx2S1X4x5Bzy9iQgSb1HydYWS+id+8gsSDPHITZhoFOIEeQO/tpP2e2W28xTp6c=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr3654300wma.119.1574768240747;
 Tue, 26 Nov 2019 03:37:20 -0800 (PST)
MIME-Version: 1.0
References: <201911240718.6RqTEBvE%lkp@intel.com> <20191126112836.tnim24tiafufe7z4@gondor.apana.org.au>
In-Reply-To: <20191126112836.tnim24tiafufe7z4@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 26 Nov 2019 12:37:22 +0100
Message-ID: <CAKv+Gu9N7cbYfzwRX4LXSu9xJRKhUzsZW7XUwmc97s6M6guC7Q@mail.gmail.com>
Subject: Re: [PATCH] crypto: talitos - Fix build error by selecting LIB_DES
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 at 12:28, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sun, Nov 24, 2019 at 07:42:21AM +0800, kbuild test robot wrote:
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/crypto/talitos.o: In function `crypto_des_verify_key':
> > >> include/crypto/internal/des.h:31: undefined reference to `des_expand_key'
>
> This patch should fix it.
>
> ---8<---
> The talitos driver needs to select LIB_DES as it needs calls
> des_expand_key.
>
> Fixes: 9d574ae8ebc1 ("crypto: talitos/des - switch to new...")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 43ed1b621718..91eb768d4221 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -289,6 +289,7 @@ config CRYPTO_DEV_TALITOS
>         select CRYPTO_AUTHENC
>         select CRYPTO_SKCIPHER
>         select CRYPTO_HASH
> +       select CRYPTO_LIB_DES
>         select HW_RANDOM
>         depends on FSL_SOC
>         help
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
