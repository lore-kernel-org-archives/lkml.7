Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676A3C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7F62146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pm7zqWzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgAFTPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:15:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33048 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgAFTPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:15:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so27393510pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ebYvaopqdPQE4iTnO1QzF+XjovTSGvUJKDf1PFA/Ysc=;
        b=Pm7zqWzCezSNB83fb8CFkcOFMzH9M9mVXfza3NE3Afqi0/3y5dQQmFsVZCldUllf8A
         4WN0ip3LDbI7gPMFIbe30Ur6dUWDgkLjCYAscilpgsGJ/E9KcoLmUVbcFn3G993zDsJP
         e4zonurP3cAPpwUgnuDER6YeaO9btWzuZOVv+oZYzMPXaPykI/xqm/rycO8S6lPPWlyt
         wA4C2IjQSfvyC5SZ2YqaiSf3OrVCN2BBW9TDKH6gEUKME27aSBv6rjFkVFcWA5hYtErn
         m5wSxj7J3z6CP9BJnyzPcI/XwrCJ3Hm+T+mNT57BfS6jSEoWs3IEO8BGMhXDDphqaeXC
         ZQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ebYvaopqdPQE4iTnO1QzF+XjovTSGvUJKDf1PFA/Ysc=;
        b=sC3cPXMhWv1/dUixQyUyDsC/2Otvv0SWa65Q6vJyJRR0qWTUL4SicRSwjpcY4qq0PX
         rduXxq0boQnxCOp6iaLyWUSVOrb7fck88wac3gc5jdJmRUSg4IMKV7DI1zDkwSlbAEmN
         teJ4LkVrmmpEIHqZXexRfA5ajpnyY2koTGVX/Daljza+P3w5VUVATriYWWrxLaazMP5S
         GQhrbLrEgUAcuWbqaMlBqg5OWREky0MRPEYYY8edFykVC7G7XC5+ymrS/YkSir75n+nx
         uTPIn5ZFtSnQ2FEtqCXmRcIAP512ER/HRWqNYgS1nF2XeB6JoBbwaMjKuBFXIHtsTa2m
         Zueg==
X-Gm-Message-State: APjAAAXnk3Amge7yyhkrDbxSd2dVlYkWrnqCSmyS/NF7nVe5h0NZdZzJ
        PEmYLLnjnbSQ73phUw52iCnyiw==
X-Google-Smtp-Source: APXvYqyTrMUuggjcjCVjWZThwMhUiBXsZlVSJjWQLamuL2PeE7k0ysia04/f3gpOxFjmjbjAKfnkBg==
X-Received: by 2002:a63:fe50:: with SMTP id x16mr93985603pgj.31.1578338153208;
        Mon, 06 Jan 2020 11:15:53 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k9sm25088975pjo.19.2020.01.06.11.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:15:52 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:15:50 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manaf@codeaurora.org
Subject: Re: [PATCH v2 2/2] dt-bindings: thermal: tsens: Add configuration in
 yaml
Message-ID: <20200106191550.GW3755841@builder>
References: <1578317369-16045-1-git-send-email-rkambl@codeaurora.org>
 <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Jan 05:29 PST 2020, Rajeshwari wrote:

> Added configuration in dt-bindings for SC7180.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index eef13b9..c0ed030 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -38,6 +38,7 @@ properties:
>            - enum:
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
> +              - qcom,sc7180-tsens
>                - qcom,sdm845-tsens
>            - const: qcom,tsens-v2
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
