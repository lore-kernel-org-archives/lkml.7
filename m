Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6756FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9EC21897
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FS+bxCoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfIDEKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:10:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46158 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfIDEKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:10:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so4500384pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 21:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dcYAzYNxQfFqfgdx0zCpj/KDgBQyEbUaQn4XvdZRh0o=;
        b=FS+bxCoUQzMvxNRSiuwbjLMktNYmoSyiiTcfCGtEnw7oz/RaknS05DuDykC403577e
         aynw2TKjaDfAEI23jPVLOhc/3G/rkAz7G2O2HHg72LBDavjfVPwQra/xf+dEjHoI8kOg
         IuWAw1rPOjzVw796xT4ci53dIXgxwE4RflDxmwDNlGVJJP4z73z7kX1HxNZgPVd/y3uf
         ZiaFmvt6+NBqLMfUefRGhd3q/L9SptsrKfBO5fc/AT324K1GAYNVE2yOMjEDtVE6hqD9
         YT8wZYLepIB8cl/py+xsQeevHiNdcHFOnB8+icy62A7ytTqLZZZp90F2cuiuOY7NGrmD
         E8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dcYAzYNxQfFqfgdx0zCpj/KDgBQyEbUaQn4XvdZRh0o=;
        b=nUKLBdV0OyV1e+kb5LzpRX52/ufjEQL4qFUuLqbY1+DAsLKGwkevCZZO8yvmvHMocP
         RJXvKLsD3C7H8XcwBOqkDRJqxdNhPU9ADXTGKXeq4xz4qQrscKVLJAwE7T/CFgo7VHpB
         nk3qeBLE33VZ8uOdYpk+cO0Qor00L/6ckvtOzGyPHaAM3DMEC8HucyNcubefSDNtMpdd
         9UIpEOKb/PFPFct0g1eJ7r+dmQRy4l2XOTnH/LfEIG2C0QVeHd8AJ4NjzisrNMY8L29Q
         azqHWjxX0/+M2rJ/HKn7+cyrj/SEjQcGpUrKpKCrUIdnMUXkPDS+yzZubolru8ckqEYQ
         TeSA==
X-Gm-Message-State: APjAAAUbUjBuKY9AKGKOJHYHh5TlJ4WBzeVi45k9lMkpDQG4Wf8Wdu1H
        gV9MkX8sMSEwCEkj3Rg5tLZbIg==
X-Google-Smtp-Source: APXvYqwXBC7IUWS8hioJj3UhbdiVmNX4j6uLKBpFtP+lG8xcx7bnu+iFYAnbEW6qGLSWRKczEYAZHQ==
X-Received: by 2002:aa7:851a:: with SMTP id v26mr43247304pfn.238.1567570245048;
        Tue, 03 Sep 2019 21:10:45 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v12sm17321805pgr.86.2019.09.03.21.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:10:44 -0700 (PDT)
Date:   Tue, 3 Sep 2019 21:10:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] pinctrl: qcom: sdm845: Fix UFS_RESET pin
Message-ID: <20190904041042.GA3081@tuxbook-pro>
References: <20190830060227.12792-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830060227.12792-1-swboyd@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Aug 23:02 PDT 2019, Stephen Boyd wrote:

> The UFS_RESET pin is the magical pin #150 now, not 153 per the
> sdm845_groups array declared in this file. Fix the order of pins so that
> UFS_RESET is 150 and the SDC pins follow after.
> 

Woops, thanks

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Fixes: 53a5372ce326 ("pinctrl: qcom: sdm845: Expose ufs_reset as gpio")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-sdm845.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 39f498c09906..ce495970459d 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -262,10 +262,10 @@ static const struct pinctrl_pin_desc sdm845_pins[] = {
>  	PINCTRL_PIN(147, "GPIO_147"),
>  	PINCTRL_PIN(148, "GPIO_148"),
>  	PINCTRL_PIN(149, "GPIO_149"),
> -	PINCTRL_PIN(150, "SDC2_CLK"),
> -	PINCTRL_PIN(151, "SDC2_CMD"),
> -	PINCTRL_PIN(152, "SDC2_DATA"),
> -	PINCTRL_PIN(153, "UFS_RESET"),
> +	PINCTRL_PIN(150, "UFS_RESET"),
> +	PINCTRL_PIN(151, "SDC2_CLK"),
> +	PINCTRL_PIN(152, "SDC2_CMD"),
> +	PINCTRL_PIN(153, "SDC2_DATA"),
>  };
>  
>  #define DECLARE_MSM_GPIO_PINS(pin) \
> -- 
> Sent by a computer through tubes
> 
