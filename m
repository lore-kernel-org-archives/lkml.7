Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94952C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FAF2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a52kVBz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCTJ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:56:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40311 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:56:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id u10so16977550wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RyQRDbneuUcopel4ePcYPEKczczt6Epk4IFH7CruhCI=;
        b=a52kVBz44/1n1fevwoAiewr+VHf4iJ5zMja8q3Oq2GiKtEhMk4T6TkcjhUJtBOXEqC
         aeBvrxsId1uDPNpYSFWE9r4EATFGQmWe56Jago7faHRuK3xbud/ZkxRt9fy+SqLOiNjA
         ziXEwYSLyavbW4f+Ynwwcf+8PFFy9F7mgC1MuElBHBdG7D0ukvp4gi932wlMX0kaG97K
         AcId181wDIWHTRSwyqhQCdgWA3AUVjtSIyPgMUXEFv0F6GzLfn4yB9lAg9CGauMIsvFd
         eZBVDhJ1xvfHC+vV4J5Q89+lB2I+a8GeYjj+tmvQP5qaK3cWip/BCGCAZmVk0ZPz/UCS
         TRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RyQRDbneuUcopel4ePcYPEKczczt6Epk4IFH7CruhCI=;
        b=oafmL+leK0x+JEF4waiQOz3DIve6K7uZSJnEh2CroGOWmF6bBZum9RAweA2M7Huor1
         JIKY8nWbkh4DnYBMtbPBEgq3FsU+My7TM85KJ/GNK/2NyK6E7sgs/ZJUrHOmBVAdPY68
         G6kwundxDUNJu7/UTJja06bKI35L8NktLJaSlEUs0epA5DiMcYgI3p+bH6MoYGNEhoMK
         v5xcdEjad533fU1skjzNb/gSLH7ikPj6i7da9UI2YtzTM3ebhwHfaCD9BxjmWTzFeDUw
         DoX31jzw76ZtrEpzVxCAmwvK/zMVrYvKeRRM42hdkm8yLUCtCOPbnAdp+NNmpm6WxMK/
         JZVg==
X-Gm-Message-State: APjAAAWHXW9Yr6Y7CfDmiapO/de/QfP3cdEmrtn3nlXrWK02clFhtsk0
        UnehSvq0f6YOBdMOXb1HlzsWRA==
X-Google-Smtp-Source: APXvYqzQ9z1fTJZ2cdLVzpKWUsNhEI15sAGZD7JPUjENIUnOiiOZOnFLqZGX8Wzn2u8yTVYZAzSzdQ==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr6950713wmd.64.1553075810401;
        Wed, 20 Mar 2019 02:56:50 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id n189sm2284796wmb.28.2019.03.20.02.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 02:56:49 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:56:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] mfd: Add leds MFD cell for intel_soc_pmic_chtwc
Message-ID: <20190320095648.GI4731@dell>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-3-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212205901.13037-3-jekhor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Yauhen Kharuzhy wrote:

> Add MFD cell for LEDs driver to the Intel Cherry Trail Whiskey Cove PMIC
> mfd device driver.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 1 +
>  1 file changed, 1 insertion(+)

I'll fix up the subject line for you.

In future, please do the following to see what is expected:

  git log --oneline -- <subsystem>

> diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
> index 64a3aece9c5e..be84bb2aa837 100644
> --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> @@ -60,6 +60,7 @@ static struct mfd_cell cht_wc_dev[] = {
>  		.resources = cht_wc_ext_charger_resources,
>  	},
>  	{	.name = "cht_wcove_region", },
> +	{	.name = "cht_wcove_leds", },
>  };
>  
>  /*

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
