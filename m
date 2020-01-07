Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451C7C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFB42073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBUN+/LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgAGOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:01:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46209 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgAGOBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:01:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id m8so50383059edi.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+90cyf4uCue1WitBn6EURq8L8npermjRUJaY8IVQ3o0=;
        b=DBUN+/LNYToXvlGc4wur3eoDDfxXHaJxAQSC9h9hO+wuGf3aIOmi/NIuVnQ9YZuGDC
         OhkfM24emqJgy+MHAaLzlG1xjwkAPI+xun02gWQ5VtJieumgdSsLpxuKusWSe6jn8m6V
         udwif7qLa6nGrXmBWlmhIP9Krk2+mAGVW3Pltww1RNeqFBv+wZZD5dsOAmCMSb3S5RMK
         PrgY36/tpph59ezpzzSXS+VV+/Nb9v0xw+UYiCrJwAEKpNPKl439WHgtFZzrVlyVOtV8
         hKNcNKJXq6w8XatSbefPePpj7Mb0fiHw6ST1dmgFcjtPSncF0fj+ChjvAWeR7lPLfJsQ
         FX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+90cyf4uCue1WitBn6EURq8L8npermjRUJaY8IVQ3o0=;
        b=b2STIxFyz6fPbAZDyr39GsLG0gPLiz/H0gbpwQ6ouvqQmWOfxAqHy1fMuocfT234Dt
         2WafGYHWkxQe9I8u2UE6N2ywci+FV5h+vNYWTNSPQYsslccPaN3HDUiq9wtbB/GSkPjJ
         SM6mFA1GoxZv+wBOO58YyAUVz8g5fTwSXTRC9Gul3QQK2xtgBnBsrcEVKV35F1FF9Py8
         5W4QyOxD2LJubvdunYJogwSk5ftkry2kRS8hyJjho5oDWPfPEmFAVIY84LIVO5ZkQ4MD
         VB/Fzq7+gDVQl8WeR+qcW2Cm3JMSCfgd7thNPBeyrgwUMsNZNTGJlI6vK/VVc+c60I3s
         VPfg==
X-Gm-Message-State: APjAAAU2leS1zJe/0IOXgIg2VXhm5kkkgrNW+S0BqsY1ILNLzohQk5Hv
        ygz1dT5ynOvvI1/HGEn80W3evw==
X-Google-Smtp-Source: APXvYqwDb/Sw2bFEL+GZhLau62Pc/gbapCMPuZYvYm7i6neHzkD2rdCQTSQR01s2I5Z2FEmRbMdEfw==
X-Received: by 2002:a17:906:4e07:: with SMTP id z7mr113972530eju.201.1578405676355;
        Tue, 07 Jan 2020 06:01:16 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id b4sm6809527ejb.37.2020.01.07.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 06:01:15 -0800 (PST)
Subject: Re: [PATCH V3 4/4] arm64: dts: sc7180: Add Venus firmware subnode
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1577971501-3732-1-git-send-email-dikshita@codeaurora.org>
 <1577971501-3732-5-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <7bf626f2-e943-5538-7405-b6edeb02bfba@linaro.org>
Date:   Tue, 7 Jan 2020 16:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577971501-3732-5-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/2/20 3:25 PM, Dikshita Agarwal wrote:
> This adds Venus firmware subnode for non-TZ platform.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 388f50a..2f82510 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -287,6 +287,12 @@
>  	vdda-pll-supply = <&vreg_l4a_0p8>;
>  };
>  
> +&venus {
> +	video-firmware {
> +		iommus = <&apps_smmu 0x0c42 0x0>;
> +	};
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
>  &qspi_clk {
> 

-- 
regards,
Stan
