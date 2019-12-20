Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2085EC2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7421206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTFMDuI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLTCIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:08:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45283 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfLTCIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:08:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so3403149pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 18:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YgvV3JiKfTlI0AC6OxzkH9DBISf/5R3CxM7BpAzpYkU=;
        b=nTFMDuI5r0hPonHwCOmY38ZRalajQ7FNgMs8hvXzjY+eN6YLoLpM/VHZU+GfKHoMl2
         tBbpXoXqhQEMwl36O6OXNJg5BuTZ/tCorNbprd+Iot/cvhVHT6qVtrAuMeecMR9eNlX3
         Yum6w4BZBzSnQmH1MeSVyy+gyRZjyTMyANYGwOm+jmf6+4hWSaLcUQ0FxXd09ZFmZYzu
         G33aOhxz4VQpI85aGAl53GyJMIzI+waf52lKU8rKPt+t8JJDcr0bOruM+NnF2/rsEx6p
         PawStYSSJ9bhY7L91n4IryV6R7xiG5lpyxV4GVvWnNn7jFD1LoxfcyfRfLS1/NU86jF5
         SDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgvV3JiKfTlI0AC6OxzkH9DBISf/5R3CxM7BpAzpYkU=;
        b=JqL+BBtp0jl++LmiT4vSY7KaL0+ltihzdpM7aNJnGiW4QrJ28pVMqeITKp/Z6aHgTc
         IT+i+eJOz27jWwj4PybvURlY+iJ+Ouue5IrIH+cDF4Lw0sjfL/XjIbmMCFjdU9BjedGr
         nnw3DJBJG3CKUIOvJ6LoFKJrVGDA08poZmS1rdJExRlMnXFpioeoTbyiYWgCBYJyEtbp
         6WUxKOvY6GOvxADyoSNFe+ioy9niC9g1Dxs2mCHRHNiL2ux2+709CaHK0mL93lqOAkN2
         fbEZs0Piw0YLuzPuJS2r3XluFh7EhPeTI1t3YBW3Yjx4cJFPAlZd9ebBN+ce7fvAtrWC
         Teuw==
X-Gm-Message-State: APjAAAWqQd5/AakYmBGKSbXx4Pl49+nxrvtcYBb2b+GALJRu/Fjxmx3v
        cJU6Ij7BLZG6+t5fspNCt6uBKw==
X-Google-Smtp-Source: APXvYqwQ14+aR8caqAjIWLVwonbpH1I+WYABcpfUV25nRJAyDe7M4sZ8y+X77Ngtju5gOW7X9Dx5HQ==
X-Received: by 2002:a17:902:9043:: with SMTP id w3mr12454955plz.8.1576807718574;
        Thu, 19 Dec 2019 18:08:38 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 11sm10238716pfz.25.2019.12.19.18.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 18:08:37 -0800 (PST)
Date:   Thu, 19 Dec 2019 18:08:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] phy: qcom-qmp: Increase the phy init timeout
Message-ID: <20191220020835.GK448416@yoga>
References: <20191219150433.2785427-1-vkoul@kernel.org>
 <20191219150433.2785427-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219150433.2785427-2-vkoul@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Dec 07:04 PST 2019, Vinod Koul wrote:

> If we do full reset of the phy, it seems to take a couple of ms to come
> up on my system so increase the timeout to 10ms.
> 
> This was found by full reset addition by commit 870b1279c7a0
> ("scsi: ufs-qcom: Add reset control support for host controller") and
> fixes the regression to platforms by this commit.
> 
> Suggested-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

This does look familiar...

https://lore.kernel.org/linux-arm-msm/20191107000917.1092409-3-bjorn.andersson@linaro.org/

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 091e20303a14..c2e800a3825a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -66,7 +66,7 @@
>  /* QPHY_V3_PCS_MISC_CLAMP_ENABLE register bits */
>  #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
>  
> -#define PHY_INIT_COMPLETE_TIMEOUT		1000
> +#define PHY_INIT_COMPLETE_TIMEOUT		100000

100ms seems a little bit excessive, and we do end up waiting this long
when we have PCIe links without an attached device...

Do you need >10ms or could we just have my patch merged?

Regards,
Bjorn

>  #define POWER_DOWN_DELAY_US_MIN			10
>  #define POWER_DOWN_DELAY_US_MAX			11
>  
> -- 
> 2.23.0
> 
