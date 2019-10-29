Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82ABCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADABB21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oLxdOYd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbfJ2MmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:42:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46912 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbfJ2MmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:42:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so13445099wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BPXp7xNo1ijPMANZMC0OJQTiJUBGfJGREatgOxfICDA=;
        b=oLxdOYd2VPtLQZ8doEBWg3jJLtOOjZP0nu8AK0107eeu0xUi1HabO38UPUHtrxB2vJ
         r2mpnITzdzYIIqJ/W3iu+aEU8bgU4W0LncSrHb+UQAu7yhrjvZI4vKFMOCu2U9pFXqvi
         +5xbARGaMsnVr6r9l4LLzbw7OBSPNHSspPiIO0ZVlEYHkjpEBRj6pbDsjuIcyXnBmLTr
         LladgHavdxtVP4r13zbSlUYLXfn2vMjbA7T9FSdKXeaQbQXd+XiBUhQOrQ9IEcwF2azi
         q3OobcCUiDAGnX66Oc5MQpSpIzVfs2BYD9l8AoBtaj1Ri+QnV0jQr/Zi2OM9ICYyL8H5
         mh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BPXp7xNo1ijPMANZMC0OJQTiJUBGfJGREatgOxfICDA=;
        b=qJcv5E2Q43xKCFscxFoJMLGvEB2BSr+DaYJpRGUfLNWgIvxzragNlPqcmmbD0jDC1M
         eu9fGX7oBdJH1AN4soes4FTCxXIHBDgsLoUPwH4pWDQuEu+aYgv7uYTS0JXO7vmsAR/A
         z1ZjPeEJ88LIjTzDY9VY8crlYiWvr8tbPnWypOZ3aMsd5S2ACCDSPyMdZ4AkTN879UW6
         BYcsHip/fYy7c1qHdBm3IHwBVOvd5Wbze7wQes8Np6o0jl3gnShrIru14TEfxuINsvdv
         UPduU/PAYWV4Cp/rWZnB3nTFvfAHNcz1/Q0wq3WWY4DoIVg/ilo+VA3hdm8YER58F4NP
         1cYA==
X-Gm-Message-State: APjAAAWJlNnEYAPmUWGaVmm8gKoEYAh1DpgqmVF8S3rquUX3zi4d9E0I
        RKeZ6sy+LgUGccAhro/rOIRu0X6autpiiw==
X-Google-Smtp-Source: APXvYqwqHf4wuK2I5AO9f/kEeooVPfRaL4aX5EEIOq9YjaTwHJCt7yKNkRGNPtbE0yZCGA/QU/7aIQ==
X-Received: by 2002:adf:fbc4:: with SMTP id d4mr1318049wrs.265.1572352940992;
        Tue, 29 Oct 2019 05:42:20 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id f143sm3375496wme.40.2019.10.29.05.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 05:42:20 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:42:03 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] crypto: amlogic - Use kmemdup in meson_aes_setkey()
Message-ID: <20191029124203.GB18754@Red>
References: <20191029015523.126987-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029015523.126987-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 01:55:23AM +0000, YueHaibing wrote:
> Use kmemdup rather than duplicating its implementation
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-cipher.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index e9283ffdbd23..78e776c58705 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -372,10 +372,9 @@ int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  		kfree(op->key);
>  	}
>  	op->keylen = keylen;
> -	op->key = kmalloc(keylen, GFP_KERNEL | GFP_DMA);
> +	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
>  	if (!op->key)
>  		return -ENOMEM;
> -	memcpy(op->key, key, keylen);
>  
>  	return crypto_sync_skcipher_setkey(op->fallback_tfm, key, keylen);
>  }
> 
> 
> 

Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
