Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AAACA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5903E214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wDf/2Qxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfJZIJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 04:09:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52473 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJZIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 04:09:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id p21so4493795wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M1jsTJqQrqJpNIMjJF4dpzKdXTPDMuQsKyFuLmv9Zrw=;
        b=wDf/2Qxklu53OHTOjb7Q3ytidPVHX1uOZPtbA0h28ECfFyFoOlAoq9pBZintkYmOUj
         9zJjyT+/JZdgxgv0bVIfwm7Yft9eaeWl0LKcEleW27Kc3i+I9Xhq6NrKH3CbnNb/Hpz2
         Roaxz9QHwUwY0AqpGpwiwPH5k1fpoE5LkUBHKLTab1SbPwTrnk3FyAlYn+Wq8moPJq+w
         PbK7rhQOZJdfo2mausMR0jrEVTDbESFLnqnbG/ZTINvej2i+e4LBMaB/eco9js4Y9+4a
         ZXIErkvnBD2XTPilFCgLysdV8z69PY2t43Lrp8V5ZGvmUbGA5GROm+HhRYCMPGoZLRp8
         vcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M1jsTJqQrqJpNIMjJF4dpzKdXTPDMuQsKyFuLmv9Zrw=;
        b=UT/gquVfQDJHp/A0usX5AOxgspAa31D6BtkQlvAFXikQL6qW99lhkkyK7yhkdJ1RkT
         DgKz4L1pgfcIeEQ+1iEEOVhh5J2QRJH2FHy70acCjLiXfUh5OcNGxMfUp2Rit7lRr7P5
         zhE3/cVGRKimTh33iS1GNH7LA5d6Q4Sr9+nNeaXZB2a+ZUTO+YHQ8Rho5ERNkQ61ihiH
         VftV1TI+8TWJzemfrzm5sIxb/LA+0PhVx1qYLB3QzZa5pZD/DQBS4Lzr+dyaoGSTbwv/
         zpsRBFrckbE17PMNs0uvOTYUbLaSmxMyOD5EdKa0+WP4fX7LnHtXLidyKYEk9g1QuAjv
         suVQ==
X-Gm-Message-State: APjAAAUZN5hmowmARSmLCCJiMwylooIsb41aCI4rkG+tSAMu0Zen8C4A
        8Q9kmUP32lcJXC3jUP736T6WHg==
X-Google-Smtp-Source: APXvYqyp/6rBvR7ThsZ6BJKtiqBJ+BtFnIVT3DF3ajYAXZJZ42T/DzY07kVVekQBw2JeUcgki+BxJA==
X-Received: by 2002:a1c:814b:: with SMTP id c72mr7284441wmd.167.1572077371918;
        Sat, 26 Oct 2019 01:09:31 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id r15sm4579844wro.20.2019.10.26.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 01:09:31 -0700 (PDT)
Date:   Sat, 26 Oct 2019 10:09:30 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     epomozov@marvell.com, igor.russkikh@aquantia.com,
        davem@davemloft.net, dmitry.bezrukov@aquantia.com,
        sergey.samoilenko@aquantia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: aquantia: Fix build error wihtout
 CONFIG_PTP_1588_CLOCK
Message-ID: <20191026080929.GD31244@netronome.com>
References: <20191025133726.31796-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025133726.31796-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 09:37:26PM +0800, YueHaibing wrote:
> If PTP_1588_CLOCK is n, building fails:
> 
> drivers/net/ethernet/aquantia/atlantic/aq_ptp.c: In function aq_ptp_adjfine:
> drivers/net/ethernet/aquantia/atlantic/aq_ptp.c:279:11:
>  error: implicit declaration of function scaled_ppm_to_ppb [-Werror=implicit-function-declaration]
>            scaled_ppm_to_ppb(scaled_ppm));
> 
> Just cp scaled_ppm_to_ppb() from ptp_clock.c to fix this.
> 
> Fixes: 910479a9f793 ("net: aquantia: add basic ptp_clock callbacks")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Hi YueHaibing,

thanks for your patch.

What is the motivation for not using the existing copy of this function?

> ---
>  drivers/net/ethernet/aquantia/atlantic/aq_ptp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> index 3ec0841..80c001d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> @@ -262,6 +262,26 @@ static void aq_ptp_tx_timeout_check(struct aq_ptp_s *aq_ptp)
>  	}
>  }
>  
> +static s32 scaled_ppm_to_ppb(long ppm)
> +{
> +	/*
> +	 * The 'freq' field in the 'struct timex' is in parts per
> +	 * million, but with a 16 bit binary fractional field.
> +	 *
> +	 * We want to calculate
> +	 *
> +	 *    ppb = scaled_ppm * 1000 / 2^16
> +	 *
> +	 * which simplifies to
> +	 *
> +	 *    ppb = scaled_ppm * 125 / 2^13
> +	 */
> +	s64 ppb = 1 + ppm;
> +	ppb *= 125;
> +	ppb >>= 13;
> +	return (s32) ppb;
> +}
> +
>  /* aq_ptp_adjfine
>   * @ptp: the ptp clock structure
>   * @ppb: parts per billion adjustment from base
> -- 
> 2.7.4
> 
> 
