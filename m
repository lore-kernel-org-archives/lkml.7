Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B582C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90DF2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4eIm2t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfCRRpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:45:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41167 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfCRRpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:45:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so11880979pgb.8;
        Mon, 18 Mar 2019 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOFLBHkANFhXo+UiLTjhc4pOXOuEKVv5E6K1AKgH0wA=;
        b=A4eIm2t3+pSWgp+BvzC3h116Z1YKJoLNeEGX4qERZae92LZpSlhg0iSm4W0hpXFUFu
         NPiE6EnsaZBsnl9O32BKGaJQH0BQDXR5+aVkHFyidv6h6lP7tqO7DyDd8I2+N863rivJ
         m03i0OEm2qoKxfAc8GMcDd8ySWgi80WLM6v5/IJZzbZUsym7tZ1h+biBrH0Y15LtgpZ2
         zdupA1avDKcxt1NV3Sr998ZtR0IToDj4Wh+rOsRhT/H+FBMM0xcqt4bDWM4X8FWdUFOL
         O+Tg0n3c4eV2JlX+mPg7KZUQ8qqUPkkhSWthLmYvXL3EmhvEuqOkk4BF7UebMM6mCjh2
         99Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mOFLBHkANFhXo+UiLTjhc4pOXOuEKVv5E6K1AKgH0wA=;
        b=kj6cj54jYvi1x2XRyS9i/5AamOToF3kxdkk+l3DGckHMbOhVbGVxifqBp2RBe3lw5s
         uGLgEVIZ1EbETohCeLQYAjgDM/Io88sUvVAzqxGTwM2OeEnWWGOWAbuI9eJ+eUf8tYjQ
         yqb0cvIRhEZiWV5wuYyjr3F4Mm15J01ysF02kuhLQWr9OMObqNNn7eeOsgjlm3R4OvPL
         w0QHYstOm/sRSI49LVpQ1g7itguS9pIXP+HwFcJvNUxO05POb2IwKLLYsg17Yf8J9r6B
         S4U4LP7ddoIVG9d3FCExmdgO5AZ6i/KD2iGJaGIisp8W0YlaU9sYB4snvD0RLXn64Yx6
         4ltg==
X-Gm-Message-State: APjAAAXdgTVrf23NvAQthPRUV9kI3mx6azJWe/8m+mSFXWZpvKhGCe9T
        zrySswbWqvUV3Sse7ZVGMrU=
X-Google-Smtp-Source: APXvYqw4oqn2vpJmrkDBQHsQNnhC8hovcn4cD6kcJzJ3Z32yKv/H+ng6lbXtUSkP1DPX03nOhX5KaA==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr21259151plp.333.1552931114595;
        Mon, 18 Mar 2019 10:45:14 -0700 (PDT)
Received: from [10.67.50.0] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id l28sm27620821pfi.186.2019.03.18.10.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:45:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in
 MDIO read/write functions.
To:     Parshuram Thombare <pthombar@cadence.com>, andrew@lunn.ch
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        piotrs@cadence.com, jank@cadence.com
References: <20190223152540.GE10693@lunn.ch>
 <1552930948-6755-1-git-send-email-pthombar@cadence.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <8098736e-d8a3-0fd9-9f51-277979aadf01@gmail.com>
Date:   Mon, 18 Mar 2019 10:45:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552930948-6755-1-git-send-email-pthombar@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 10:42 AM, Parshuram Thombare wrote:
> Sorry for sending this patch again, but I didn't sent previous
> email --in-reply-to last comment on v1 of this patch. So
> rectifying this mistake.

You have 3 patches in your series, you need to resend all of them even
if there is only one to which you are making changes, this is not
documented in netdev-FAQ.rst though, let's update that.

> 
> This version 2 of patch to modify MDIO read/write functions to support
> communication with C45 PHY in Cadence ethernet controller driver.
> 
> Changes:
> 	1. Added timeout
> 	2. Removed unused operation macro MACB_MAN_C45_POST_READ_INCR
> 
> I thought of starting with relatively smaller, independant and simpler changes.
> This patch is independant of patch series and looks relatively straight forward
> with aim of supporting C45 PHY for support of high speed PHY's.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   14 +++++--
>  drivers/net/ethernet/cadence/macb_main.c |   61 ++++++++++++++++++++++++-----
>  2 files changed, 60 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index acc66a7..d25fa03 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -629,10 +629,16 @@
>  #define GEM_CLK_DIV96				5
>  
>  /* Constants for MAN register */
> -#define MACB_MAN_SOF				1
> -#define MACB_MAN_WRITE				1
> -#define MACB_MAN_READ				2
> -#define MACB_MAN_CODE				2
> +#define MACB_MAN_C22_SOF                        1
> +#define MACB_MAN_C22_WRITE                      1
> +#define MACB_MAN_C22_READ                       2
> +#define MACB_MAN_C22_CODE                       2
> +
> +#define MACB_MAN_C45_SOF                        0
> +#define MACB_MAN_C45_ADDR                       0
> +#define MACB_MAN_C45_WRITE                      1
> +#define MACB_MAN_C45_READ                       3
> +#define MACB_MAN_C45_CODE                       2
>  
>  /* Capability mask bits */
>  #define MACB_CAPS_ISR_CLEAR_ON_WRITE		0x00000001
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ad099fd..17072fd 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -345,11 +345,30 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  	if (status < 0)
>  		goto mdio_read_exit;
>  
> -	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
> -			      | MACB_BF(RW, MACB_MAN_READ)
> -			      | MACB_BF(PHYA, mii_id)
> -			      | MACB_BF(REGA, regnum)
> -			      | MACB_BF(CODE, MACB_MAN_CODE)));
> +	if (regnum & MII_ADDR_C45) {
> +		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
> +			    | MACB_BF(RW, MACB_MAN_C45_ADDR)
> +			    | MACB_BF(PHYA, mii_id)
> +			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
> +			    | MACB_BF(DATA, regnum & 0xFFFF)
> +			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
> +
> +		status = macb_mdio_wait_for_idle(bp);
> +		if (status < 0)
> +			goto mdio_read_exit;
> +
> +		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
> +			    | MACB_BF(RW, MACB_MAN_C45_READ)
> +			    | MACB_BF(PHYA, mii_id)
> +			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
> +			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
> +	} else {
> +		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
> +				| MACB_BF(RW, MACB_MAN_C22_READ)
> +				| MACB_BF(PHYA, mii_id)
> +				| MACB_BF(REGA, regnum)
> +				| MACB_BF(CODE, MACB_MAN_C22_CODE)));
> +	}
>  
>  	status = macb_mdio_wait_for_idle(bp);
>  	if (status < 0)
> @@ -378,12 +397,32 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
>  	if (status < 0)
>  		goto mdio_write_exit;
>  
> -	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
> -			      | MACB_BF(RW, MACB_MAN_WRITE)
> -			      | MACB_BF(PHYA, mii_id)
> -			      | MACB_BF(REGA, regnum)
> -			      | MACB_BF(CODE, MACB_MAN_CODE)
> -			      | MACB_BF(DATA, value)));
> +	if (regnum & MII_ADDR_C45) {
> +		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
> +			    | MACB_BF(RW, MACB_MAN_C45_ADDR)
> +			    | MACB_BF(PHYA, mii_id)
> +			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
> +			    | MACB_BF(DATA, regnum & 0xFFFF)
> +			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
> +
> +		status = macb_mdio_wait_for_idle(bp);
> +		if (status < 0)
> +			goto mdio_write_exit;
> +
> +		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
> +			    | MACB_BF(RW, MACB_MAN_C45_WRITE)
> +			    | MACB_BF(PHYA, mii_id)
> +			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
> +			    | MACB_BF(CODE, MACB_MAN_C45_CODE)
> +			    | MACB_BF(DATA, value)));
> +	} else {
> +		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
> +				| MACB_BF(RW, MACB_MAN_C22_WRITE)
> +				| MACB_BF(PHYA, mii_id)
> +				| MACB_BF(REGA, regnum)
> +				| MACB_BF(CODE, MACB_MAN_C22_CODE)
> +				| MACB_BF(DATA, value)));
> +	}
>  
>  	status = macb_mdio_wait_for_idle(bp);
>  	if (status < 0)
> 


-- 
Florian
