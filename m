Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1594ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6D021479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snicYa4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbfJ2Jxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:53:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38253 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733162AbfJ2Jxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:53:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id y8so10229907edu.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HGDKIfiK4WqAtiXxg2PaSaV3tKJwX+/+66kephvgEMc=;
        b=snicYa4xa75qBwamypvTLqSPyFkZPl5dVyOqrJzmSnFo9ZWuJnc5ulCdFp8WlWQHOl
         0AuO/24CzCPv7qVgEFhoukv2GFOuJ1bWq1gG2vGzILd3Sn50nx7Fi9m6nayEaiWTNeWY
         ZCadVMAYdVU8FMtX8KFyDOyJIcHoqkuUGtzHURxZSnjPpu6p02UHO+TMXf7o5/0gNxYn
         X+HUMTxEw5ceA3gawdZXe2RtYoL4PpaXATQWnklS4ADEMVGaVtRb2ZGtSlttNdf8qviH
         SrQ8FWJCTqwBRF+wvNq/NxQJiignNV7jT9hOeVxyd31CXmFMEC2a4MK+EqJ4CMbagW3M
         Jqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HGDKIfiK4WqAtiXxg2PaSaV3tKJwX+/+66kephvgEMc=;
        b=Y47JY08dyccPKkhqnzCu5TbyOE8Hv41btOhRTSSFcKQSk2LNWFZqXkdF+DKNbD2JQq
         Ji0KaKpQJ+90ZBnzhNGePVm7dqbOU1zIqz3MbxJg0WqJJvlhYjc8pIMAavEme/76XjeB
         LsN7YBtuaMHab2nfUshfEvDV9SwvMjvGPBazjif6k81LQdAGD0at8ZOHZ/USNNsO1nD0
         Fmp2VtMfFKP7jnfWK9qKDCh+a8TDGSbsza3Q9A3srx2Df6zb74PHvpwNwQZreCenBN9u
         AHZhuk2sOdyNLlAYCrDchZujP9v9CuNjCDoiccdXuqi29iEzy5QiTkGSoXhtq5zhFg8A
         JXuQ==
X-Gm-Message-State: APjAAAUuF+hpHl6iXv2ZCwTOABWcxCI9uqjNxhT+6OSjCwvvjypWOBg3
        pufuwUdwULimmKUva+VY67ku3Q==
X-Google-Smtp-Source: APXvYqyFyb/NYxsK1RWq4WxvayVYls/goH6XAAk9FVVYjH3wL1Zb5+8jNZclhKtCmGdk5NT+7BUT2g==
X-Received: by 2002:a50:eb92:: with SMTP id y18mr23242997edr.244.1572342824719;
        Tue, 29 Oct 2019 02:53:44 -0700 (PDT)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id x6sm664005edc.50.2019.10.29.02.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 02:53:44 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC PATCH 4/4] interconnect: qcom: sdm845: Split qnodes into
 their respective NoCs
To:     David Dai <daidavid1@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
 <1571278852-8023-5-git-send-email-daidavid1@codeaurora.org>
Openpgp: preference=signencrypt
Message-ID: <9f879f99-527d-50bc-d5ef-5a72d4a65c4d@linaro.org>
Date:   Tue, 29 Oct 2019 11:53:42 +0200
MIME-Version: 1.0
In-Reply-To: <1571278852-8023-5-git-send-email-daidavid1@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 17.10.19 г. 5:20 ч., David Dai wrote:
> In order to better represent the hardware and its different Network-On-Chip
> devices, split the sdm845 provider driver into NoC specific providers.
> Remove duplicate functionality already provided by the icc rpmh and
> bcm voter drivers to calculate and commit bandwidth requests to hardware.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  drivers/interconnect/qcom/sdm845.c | 727 +++++++++++--------------------------
>  1 file changed, 206 insertions(+), 521 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index 502a6c2..a731f4d 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
[..]
>  static int qnoc_probe(struct platform_device *pdev)
>  {
> @@ -808,6 +480,12 @@ static int qnoc_probe(struct platform_device *pdev)
>  	qp->bcms = desc->bcms;
>  	qp->num_bcms = desc->num_bcms;
>  
> +	qp->voter = of_bcm_voter_get(qp->dev, NULL);

I assume that we could have a second optional bcm-voter? The
"qcom,bcm-voter-names" DT property is not used anywhere, is it needed? Maybe
give an example in patch 1.

> +	if (IS_ERR(qp->voter)) {
> +		dev_err(&pdev->dev, "bcm_voter err:%d\n", PTR_ERR(qp->voter));

Should be %ld

> +		return PTR_ERR(qp->voter);
> +	}
> +
>  	ret = icc_provider_add(provider);
>  	if (ret) {
>  		dev_err(&pdev->dev, "error adding interconnect provider\n");

Nit: I would also put patch 2/4 at the end of the series.

Thanks,
Georgi
