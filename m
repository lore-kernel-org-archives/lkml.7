Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DACCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DA92064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKhqYHL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634345AbfJRRHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:07:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43647 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389580AbfJRRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:07:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so4253849pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4mBZS+ljuU08rW884SHkz0i5bxQ4SJXmq8jp6tRUPg=;
        b=yKhqYHL2pFUl4x0vzuSYcslNeVF/bHclgLn/jbiR4D31jUrWdwXJOkaY4oPnzZDaZX
         klcUgEiOu86wgFyATnDdOleKOmdqzEPxQNCjfbE8VyOenkKZGNlP9Z90fZLOWTmKCGok
         yl3Rz2uIwif2Uvh6c9EgeKbCUtKbF5dtcsB/oXeUEiLMe4KrpsGUbU6QQBjowWXagJ1D
         ARrvds73ksxjjg01m9PTHZ0NCMtz3Rw+CoT7iZeLrJwHGjeYSPWBdfNqGFpb4j1TnRLJ
         UzAfIkbLArZpKqcv0G8IeTQEGtfEYmRUviwIPPMCXFX0iqk0RpDIaDa9Z0GjVCRI8sIS
         k+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4mBZS+ljuU08rW884SHkz0i5bxQ4SJXmq8jp6tRUPg=;
        b=UKfuaSmyiaSh2BE6ayHeKH3b8o0WphyuCX47OVHGuI147xIXiyu+4bmeB1PwgPFJ4n
         Qd2oZ6OWrFllnPzvofkCoFbYfsf/3Hgz77sr733c0hQ6mUmRn19U6U8haYCGbK+NWK23
         uN6rbdzldZahsux2DkPGRznSr0tpaqPAbgHVlmvrLtKjc5gKZkYFGQmzeUvAma+zm0eb
         UdeygUOt+/nJZ7QRtBz450gkZjUOxoyY0NmyxRNp6lptaSxRwaSEP2UgJEZzL/vTA0NJ
         eZRMdqjTt0k6Of5yRTmOIyPMG73Fabe3ZYsadtGjc3Rb7EHd5pgnQ6INH0WrRPQfgVBs
         YJ0g==
X-Gm-Message-State: APjAAAXe65qZTydjVCKjXvzcjXpOGP3XU/64IhFAXJanOqWMZkTXPgCG
        mFoxGJDmuHRDpqTcpptPrqynZQ==
X-Google-Smtp-Source: APXvYqzCsL68VirLSBGvWUCdpFt/+Zq1BrRbdAcnSRDaLPTmDpRsFdPQLecri/RwQRFAROsaxnc6qA==
X-Received: by 2002:a62:6842:: with SMTP id d63mr7792318pfc.16.1571418421377;
        Fri, 18 Oct 2019 10:07:01 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f13sm6753490pgr.6.2019.10.18.10.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:07:00 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:06:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org,
        afaerber@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        jesper.nilsson@axis.com, lars.persson@axis.com,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, baruch@tkos.co.il,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
        linux-oxnas@groups.io, linux-renesas-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        vz@mleia.com, narmstrong@baylibre.com, geert+renesas@glider.be,
        daniel@zonque.org, haojian.zhuang@gmail.com, wens@csie.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, agross@kernel.org
Subject: Re: [PATCH -next 11/30] pinctrl: msm: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20191018170657.GD4500@tuxbook-pro>
References: <20191017122640.22976-1-yuehaibing@huawei.com>
 <20191017122640.22976-12-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017122640.22976-12-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Oct 05:26 PDT 2019, YueHaibing wrote:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 763da0b..62fcae9 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1150,8 +1150,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  				return PTR_ERR(pctrl->regs[i]);
>  		}
>  	} else {
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		pctrl->regs[0] = devm_ioremap_resource(&pdev->dev, res);
> +		pctrl->regs[0] = devm_platform_ioremap_resource(pdev, 0);
>  		if (IS_ERR(pctrl->regs[0]))
>  			return PTR_ERR(pctrl->regs[0]);
>  	}
> -- 
> 2.7.4
> 
> 
