Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7C6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC84B2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fn83oNtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfHUWsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 18:48:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44251 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfHUWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:48:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id c81so2419858pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=teKoEoZBkGuWM1am+bLxrzg6jS/TPSFr7t15zPBCNd0=;
        b=fn83oNtnI1C2eL/2sCStFsle3PKFMa1Tz57GE6Dkhr7A7QS4lH9XiGvffGi10XTFKV
         UsdNPY7I+LpQATbTGIgv7S0LftxvcXeDTKQffKaWrtb9vVR4wU7TNoHVG9WeC+HwjzJI
         ehriVN2QCZnH5FkGXbZeAx8QYXrakhPnYv9qBGrdxpVcW/tfmSVS/FYsKRbPfDglqMzN
         eJ44IDYR6NuXCBuB+dxB347ZfCQ2qbmNR+Tl6X6FSUASKblhb4KeDqVFDxY/vvnyFFVL
         WNyAX1XfPO3sD473CoaKkJaYn05hbRcw9nOyI3JOnVaIYLdm1qyvwWDqaLnUhH0pvsto
         F4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=teKoEoZBkGuWM1am+bLxrzg6jS/TPSFr7t15zPBCNd0=;
        b=ITgeF3pTmxT5D/u2eQf/q0ewpCM4kRsiX43Nm0sbprNoi08lV5YjwGIbgp720n0mpn
         5wJ7CQli6/IyNtMFJTWiC8ddeAraZthd94ofbtXOzUZkPO4uEHzN8Xs3wIxlC22AfhVw
         ZRfKRGdUoDXHG1LsKYCbo4UjzJohrfdFbgEdKQD0k+LnhvtAxiZZhXLIF1zIpxpYTy7p
         krbXiOeVqDvGyTbzltoJ/PopxR7ceH2NmA6i5fsX1LB2bNyA0+b317S2OOnw1WLEILaF
         gBAMh87XI4NNLorTK9wbLdGkPjVmIqeZLg/H7VFDUn268hnHQTeDRRt4Roffx3p3HTAg
         bq3w==
X-Gm-Message-State: APjAAAV3KLqonj0kpt8NphKHITGOTWnObaelleNDgJm6BPbhxa+8ClS4
        kBo5ZaBmadmRWf04q/fp6UDV/A==
X-Google-Smtp-Source: APXvYqze4CscdkpN+NmoXK9M3820ciVP/ebbyCnpT1BSOyOKbjJX/1IXyEnQhdqXoEY4Czkz9iK+jw==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr30949865pgj.4.1566427725453;
        Wed, 21 Aug 2019 15:48:45 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 5sm21909049pgh.93.2019.08.21.15.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:48:44 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:50:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, aneela@codeaurora.org,
        mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org
Subject: Re: [PATCH v2 5/7] mailbox: qcom: Add support for Qualcomm SM8150
 and SC7180 SoCs
Message-ID: <20190821225031.GA1892@tuxbook-pro>
References: <20190807070957.30655-1-sibis@codeaurora.org>
 <20190807070957.30655-6-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807070957.30655-6-sibis@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Aug 00:09 PDT 2019, Sibi Sankar wrote:

> Add the corresponding APSS shared offset for SM8150 and SC7180 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 705e17a5479cc..2dfd288fe720d 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -118,7 +118,9 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = (void *)16 },
>  	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = (void *)8 },
>  	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = (void *)8 },
> +	{ .compatible = "qcom,sc7180-apss-shared", .data = (void *)12 },
>  	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
> +	{ .compatible = "qcom,sm8150-apss-shared", .data = (void *)12 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
