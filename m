Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6596BC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A00320879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0hr3OtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfEWOib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:38:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54510 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbfEWOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:38:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so6104170wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/HlefMV0bwmUzLKXhAmlVYeXPjcTFvz8Ki1WeUsw4eA=;
        b=s0hr3OtJjjizR8t7XxwJFiZcY+6l+tr9RBVt0An3WE8H+XpnT9Q354IZCKjX87NYVI
         KMk1cXfrqu6RCRqcI98jFGRx1YYoz3lbaq4KFt6yMwBS8R+K9ASEWZqavrD1Wsnu/WU8
         yi+6BwDM4vC3tlJ212bOE7v1LDXV5rEc4NkCtXp3021wJGiS1NsImjO5DEfvBr7ZGbT4
         yXmuBa7JWmTolKuO24gcGD1V3qcuYN+PPrXNlhSmWqXzRlnDNU8celvj0R2+jQ15sJln
         xLhJFArPQsm3zOfKh/0nJNYSJ7GYhYDW15rmrA9P8f56L9m/E3lPhPbFx4F5A3efrQh5
         QWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HlefMV0bwmUzLKXhAmlVYeXPjcTFvz8Ki1WeUsw4eA=;
        b=ijzfpBjui9aX0gim197PhOv89mowXs2LLZ9igtJR50p2NozRCIYmvUbYQgPaTNb4Ff
         JfrpEjSjnW7nBmQoiuA3HoTvlRT2P3Wl4z0+1mP8QP+np8rlLA1VqQN0aqCQehQtwVVh
         mH3mvtCSZMxNEMT2gQ86VQ5Bsxo8dbSpvKcN1W0e8b7EudZjgLOO7tkqQZgP3atwTfTu
         HBFVRim6WOjB3fjkU3CX4bWbB6QDEvWTdQPhwBXSrvRClKnMvgt6jwTWKIIJ7ZF7sysN
         uRLL2HNcbFTNT+Kl6yiw53Gdj2td98yawl5imcWhRm+9i4ciJud+cuDIs8hdZsibkx+E
         jvoQ==
X-Gm-Message-State: APjAAAWFtyqRgEKVno0poZNB5TmDQqPLq64AnhPTdJTuY4wSTiveV8mR
        Xr5nCSNgFcIGI7mYL2/ED+QM2CZtYh+wiA==
X-Google-Smtp-Source: APXvYqxQgq+rdSwKf1bkfpHBWA6HZtKthLBgqdX6MDBQOoVwnphvJBoTyijnAK9ayk/rlfQnsZN15g==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12mr12266159wmh.3.1558622308599;
        Thu, 23 May 2019 07:38:28 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t13sm60423742wra.81.2019.05.23.07.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 07:38:27 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: apr: Don't use reg for domain id
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190522015342.29501-1-bjorn.andersson@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e7046725-578d-8854-872b-a7837d0fc20a@linaro.org>
Date:   Thu, 23 May 2019 15:38:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522015342.29501-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2019 02:53, Bjorn Andersson wrote:
> The reg property represents the address and size on the bus that a
> device lives, but for APR the parent is a rpmsg bus, which does not have
> numerical addresses. Simply defining #address/#size-cells to 1 and 0,
> respectively, to silence the compiler is not an appropriate solution.
> 
I agree.

> Replace the use of "reg" with an APR specific property.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
Can you also change the example too.

other than that am okay with the change.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
> 
> The APR device was recently added to msm8996.dtsi, but this is still
> depending on working SMMU to provide functional audio support.
> 
>   Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt | 2 +-
>   drivers/soc/qcom/apr.c                                  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> index bcc612cc7423..38d3c06abc41 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> @@ -9,7 +9,7 @@ used for audio/voice services on the QDSP.
>   	Value type: <stringlist>
>   	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
>   
> -- reg
> +- qcom,apr-domain
>   	Usage: required
>   	Value type: <u32>
>   	Definition: Destination processor ID.
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index 74f8b9607daa..b83d71b2e0a4 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -276,7 +276,7 @@ static int apr_probe(struct rpmsg_device *rpdev)
>   	if (!apr)
>   		return -ENOMEM;
>   
> -	ret = of_property_read_u32(dev->of_node, "reg", &apr->dest_domain_id);
> +	ret = of_property_read_u32(dev->of_node, "qcom,apr-domain", &apr->dest_domain_id);
>   	if (ret) {
>   		dev_err(dev, "APR Domain ID not specified in DT\n");
>   		return ret;
> 
