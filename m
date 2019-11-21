Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6041BC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3907C20637
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUUsGcoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfKUQEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:04:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50900 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfKUQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:04:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so4351262wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=87tiBp3c75vDSn7hIQnnDZhCnOm8JFXZ75XeKixOdSM=;
        b=qUUsGcojBpG1gCO1BJ5PXIeexMi7RCkgqWBgWl984UjvHuJgTYhbEn08ftoAPZvzx3
         p4Vy6fbkVkXnDjtb2LGqKNq2bWwD2c3k0lYX7YdyzU5T6Qfoj4hWC0KdJfpbKb21/7Pc
         bTRQ/7pAZI8mu6mwmtuHV2F9OG1LXyK4vfMW1G39BERxfgRZaZsXq8M+23crHQwjhW4g
         Xq/E2oiX72VHPoscikXPO9wAczEABwPDzLPoS2YL5PiDuaSHP4zSJrks/RuFvzSvls6z
         Ql9t9rK9WWY4pxhmSYGwGPqdfkK3pzXrD8DDWGZspgVgIQqbUDXs91gS4VCsVSVdQQC/
         iUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=87tiBp3c75vDSn7hIQnnDZhCnOm8JFXZ75XeKixOdSM=;
        b=JTQ13LaMElnDJOCY1fAwBC4Jox37Oi8oSe0ynfCJ2jXQTfIlxpCocC/nQSU+grmNkY
         JnIsEmmifHbVKAa6lCTvO6OKP44bk/W66uoAw+zBR+dTEqtdBjxbQLB7VJFbuOAXT2m7
         TAVWi8gh25AGcbof+kZRDt2RV3MOJ0wIlNKfxcNgchC5dQ2LbpFD7fZBN9mrvESggpqw
         E1CZ9GX5xXXj1SMhdTnUTw8wa77DTJxS3SkxON81vSVx3S/qD7OapT95Fm6SmoRmRoaI
         Lzsy30bjXZ3JvoxOkSH4nCSktHVqxmFLulN8FvBd9GCuTX0+GAwlJUf8GgiREDRz8x8H
         7+tw==
X-Gm-Message-State: APjAAAVPMFe/6H/DNEAs2SCXqpELGLPRxCdeTJqzyNs21wbUypJ37bt5
        GEu07E71VY3I/lEnyFHMzZQ5Cg==
X-Google-Smtp-Source: APXvYqz8t59aCjs93Wh8D7M2VkgT3kCB9nTafuHTSPwHjb4uywwfkxqK30tFpEIbitNI6DRQhp8UbA==
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr10980467wme.89.1574352292043;
        Thu, 21 Nov 2019 08:04:52 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w17sm4003453wrt.45.2019.11.21.08.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:04:51 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: soc: qcom: apr: Add protection domain
 bindings
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, tsoni@codeaurora.org
Cc:     agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org
References: <20191118142728.30187-1-sibis@codeaurora.org>
 <0101016e7ee9c786-fcf80f4e-9b57-4d6b-8806-9ca408e21b55-000000@us-west-2.amazonses.com>
Message-ID: <55d4bf2c-58e1-f5ce-4b2d-502b89140f93@linaro.org>
Date:   Thu, 21 Nov 2019 16:04:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0101016e7ee9c786-fcf80f4e-9b57-4d6b-8806-9ca408e21b55-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2019 14:28, Sibi Sankar wrote:
> Add optional "qcom,protection-domain" bindings for APR services. This
> helps to capture the dependencies between APR services and the PD on
> which each apr service run.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

LGTM

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   .../devicetree/bindings/soc/qcom/qcom,apr.txt | 59 +++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> index db501269f47b8..f87c0b2a48de4 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> @@ -45,6 +45,12 @@ by the individual bindings for the specific service
>   			12 - Ultrasound stream manager.
>   			13 - Listen stream manager.
>   
> +- qcom,protection-domain
> +	Usage: optional
> +	Value type: <stringlist>
> +	Definition: Must list the protection domain service name and path
> +		    that the particular apr service has a dependency on.
> +
>   = EXAMPLE
>   The following example represents a QDSP based sound card on a MSM8996 device
>   which uses apr as communication between Apps and QDSP.
> @@ -82,3 +88,56 @@ which uses apr as communication between Apps and QDSP.
>   			...
>   		};
>   	};
> +
> += EXAMPLE 2
> +The following example represents a QDSP based sound card on SDM845 device.
> +Here the apr services are dependent on "avs/audio" service running on AUDIO
> +Protection Domain hosted on ADSP remote processor.
> +
> +	apr {
> +		compatible = "qcom,apr-v2";
> +		qcom,glink-channels = "apr_audio_svc";
> +		qcom,apr-domain = <APR_DOMAIN_ADSP>;
> +
> +		q6core {
> +			compatible = "qcom,q6core";
> +			reg = <APR_SVC_ADSP_CORE>;
> +			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +		};
> +
> +		q6afe: q6afe {
> +			compatible = "qcom,q6afe";
> +			reg = <APR_SVC_AFE>;
> +			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +			q6afedai: dais {
> +				compatible = "qcom,q6afe-dais";
> +				#sound-dai-cells = <1>;
> +
> +				qi2s@22 {
> +					reg = <22>;
> +					qcom,sd-lines = <3>;
> +				};
> +			};
> +		};
> +
> +		q6asm: q6asm {
> +			compatible = "qcom,q6asm";
> +			reg = <APR_SVC_ASM>;
> +			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +			q6asmdai: dais {
> +				compatible = "qcom,q6asm-dais";
> +				#sound-dai-cells = <1>;
> +				iommus = <&apps_smmu 0x1821 0x0>;
> +			};
> +		};
> +
> +		q6adm: q6adm {
> +			compatible = "qcom,q6adm";
> +			reg = <APR_SVC_ADM>;
> +			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +			q6routing: routing {
> +				compatible = "qcom,q6adm-routing";
> +				#sound-dai-cells = <0>;
> +			};
> +		};
> +	};
> 
