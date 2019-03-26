Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A239C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BAF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553612392;
	bh=ZZd2gWOAbJyHwYFO91LwuWU/IXDKUg1YC9qpX23omtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zwB7H2lXk8HDDmhYWSSUTEhMtilXHQaSBYh2EuiPOonrfXw1E25tCB0TgrsiLTs6R
	 Zx9x6PjPG+Sxi93uHPkyPVv8+AzvV+XaSC7a8tJemZHFkLH2xIQW5/pHnKGIqYxaWz
	 ZdJCjQbXh+PWc7JOVljuneHtTVEOvEQnGrdh+t/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfCZO7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:59:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37048 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbfCZO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:59:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so11737852otn.4;
        Tue, 26 Mar 2019 07:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xVQ68l5JfxG2TY0Rdl/q57fy2SI4NooP/LvdcLHtM6A=;
        b=P5vhLBvN4359UBHeU32CekodsUYxaAyGgQ8OjngJHBuO6xlkcB6RuoIBu16BrSlSvM
         JIBEq0QgY50HG6cqTxVqTGashOmvp0+m19OatbtJTvTETZgTwvZfudyPZeL4xE8PjjPI
         GzSBDKocfgI5qS3yCh2TYpfVLNH/4eo8QaEQXX+IWqbhJKWTkvvNxCa+hnECLgtDGGMB
         B+iUprXu1l0Q5rUuyz3ouIrrZ5U2wXulA9VI4untCMSekd/0lXzIPMw7hT36rGADW/AH
         fjszgt38TKIExNXzM1YOqCnI61kuyWa5OP9PSDkJKXOZq7QN5MrHiIUGTJVUeFgvPuNH
         D2xA==
X-Gm-Message-State: APjAAAXp2iCxhy2iE36gnxeWhTaxsyWAY6biQVdTfIJObou/Tw2iG76v
        XLIh7e85l9y4TIJbeUJbsw==
X-Google-Smtp-Source: APXvYqzLBECETYwD41Ro/qpwBwEP6W/3eoTABZuZrZZswW+7IIjDie5bpVKB8kw5orfcC1iHptEIsQ==
X-Received: by 2002:a9d:3b04:: with SMTP id z4mr21910443otb.1.1553612389217;
        Tue, 26 Mar 2019 07:59:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 66sm1182334otn.39.2019.03.26.07.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 07:59:48 -0700 (PDT)
Date:   Tue, 26 Mar 2019 09:59:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH] phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
Message-ID: <20190326145947.GA21213@bogus>
References: <20190226065919.22218-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226065919.22218-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:59:19PM -0800, Bjorn Andersson wrote:
> qcom_qmp_phy_init() is extended to support the additional register
> writes needed in PCS MISC and the appropriate sequences and resources
> are defined for SDM845.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   7 +

Please split bindings.

>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 160 ++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |  12 ++
>  3 files changed, 179 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 5d181fc3cc18..dd2725a9d3f7 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -11,6 +11,7 @@ Required properties:
>  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>  	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
>  	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
> +	       "qcom,sdm845-qmp-pcie-phy" for PCIe phy on sdm845,
>  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>  	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
>  	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> @@ -48,6 +49,10 @@ Required properties:
>  			"aux", "cfg_ahb", "ref".
>  		For "qcom,msm8998-qmp-ufs-phy" must contain:
>  			"ref", "ref_aux".
> +		For "qcom,sdm845-qmp-usb3-phy" must contain:
> +			"aux", "cfg_ahb", "ref", "refgen".
> +		For "qcom,sdm845-qmp-usb3-phy" must contain:
> +			"aux", "cfg_ahb", "ref", "com_aux".

Copy-n-paste error?

>  		For "qcom,sdm845-qmp-usb3-phy" must contain:
>  			"aux", "cfg_ahb", "ref", "com_aux".
>  		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
> @@ -70,6 +75,8 @@ Required properties:
>  		For "qcom,msm8998-qmp-usb3-phy" must contain
>  			"phy", "common".
>  		For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
> +		For "qcom,sdm845-qmp-pcie-phy" must contain:
> +			"phy".
>  		For "qcom,sdm845-qmp-usb3-phy" must contain:
>  			"phy", "common".
>  		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
