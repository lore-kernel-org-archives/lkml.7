Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3449CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ECC20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKBYpjIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbfHFJjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:39:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35924 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfHFJjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:39:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so71648481wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C7TmI/PbYUbfMNCcuBdm2/gfYnotvm+U5V2PWxd2Dx8=;
        b=GKBYpjIrHe0nk6+JIacLaHqrij52L3cXGTJSBl/Bkk0eYXGfLMIrmZAw0jqIB4u6Aq
         7WMiEClzapc9W1qZ0v1o/mIZgAMWqj78lZkGZgnUUaD5utUAFjJrLgY7ZrDmjprE7BeU
         FDKae67PTf/ajIgGcdmkDZ5MGzhuXgVihACZtB1etkP1GdetzORDw1pJZ0zimge44V52
         m+p8pVPlwZYgGig5JuDiC2qPbTCWgl0B1jnjtURZYqdjY5v5ZMzFrbr6R65pm0PvuISH
         VDsvC9Ougbx9Fe3nqBc194QDWe4VSedvFKzuhTxUwWCibBDS2KNAQAnAhInv/Ew5gseP
         n1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7TmI/PbYUbfMNCcuBdm2/gfYnotvm+U5V2PWxd2Dx8=;
        b=GYsH9VR+H4EThjbfcjNWWPdT7cWnLhJ12BxXq6oQbppuVNO0eJ2Ej8w5/YEk/zOPKC
         /PH/kPLyJ14VMkQODmlzBP3TZhG3cFZcx0ulPi8wg4+c45ai+va13lphRmBLdomoL7AD
         L5dRVOLLiRiJhpXJm4mRYGcaEe+7fy4WL4tLyujF3xe20pXih56agaI1wDaEERe8UKA1
         2WOXafNlfwzt220uws9FHGAOdW2Pdv3sep/vHIdbtbzSWi/Ya8yRMB1AcMBy/XswmJvw
         Dr1auqu1f1X2sk1DyfwOkRtFh4Sig5GDgHAJuSZNXpaRfAUMF1+okscfRu4eyd9jxBYn
         MnHA==
X-Gm-Message-State: APjAAAUpgZuGUvROOrT0s9ZymgNWh2+2026DMGwcCncwkLafJM3vpIxZ
        zJBRf4wlbZsc8xeZTV0FVa3uZQ==
X-Google-Smtp-Source: APXvYqxal+ZBDO7JHFcqsftztLQjLnTQ0KMWc6lBrcodchC0+vVixyeZ6eNcuccOmEmhBF8PQNmrfA==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr3740633wma.46.1565084351694;
        Tue, 06 Aug 2019 02:39:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h16sm101823496wrv.88.2019.08.06.02.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 02:39:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: imx-ocotp: Add i.MX8MN compatible
To:     Anson.Huang@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <20190711023714.16000-1-Anson.Huang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e38b758f-13b9-e2fe-188b-373861716ef8@linaro.org>
Date:   Tue, 6 Aug 2019 10:39:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190711023714.16000-1-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2019 03:37, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add compatible for i.MX8MN and add i.MX8MM/i.MX8MN to the description.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both the patches.

Thanks,
srini

> ---
>   Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> index 96ffd06..904dadf 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> @@ -2,7 +2,7 @@ Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
>   
>   This binding represents the on-chip eFuse OTP controller found on
>   i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
> -i.MX7D/S, i.MX7ULP and i.MX8MQ SoCs.
> +i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM and i.MX8MN SoCs.
>   
>   Required properties:
>   - compatible: should be one of
> @@ -16,6 +16,7 @@ Required properties:
>   	"fsl,imx7ulp-ocotp" (i.MX7ULP),
>   	"fsl,imx8mq-ocotp" (i.MX8MQ),
>   	"fsl,imx8mm-ocotp" (i.MX8MM),
> +	"fsl,imx8mn-ocotp" (i.MX8MN),
>   	followed by "syscon".
>   - #address-cells : Should be 1
>   - #size-cells : Should be 1
> 
