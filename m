Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD1AC04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C909216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnNLFUno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfEQPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:40:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36298 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbfEQPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:40:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so7201306wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A2JLxlWuEH6j0Jh7jAHHHzHa1EMwyEMqpv3GEMW1UVs=;
        b=OnNLFUnou1xM7X9pYuJqa+LVW0qwSMf+DVBI6GQs7SanL/bRMnBwUzh0kMmXsYqszC
         Mc1FUipe50YAXj5jxDdDe1nIwoWb900P47imnAlMwtwvZ6EwlhrSaeO1Z1Y7Vy2WLc7k
         wwXuBikra23V6CL/9FaNnJTwMS0+FBDDfHZzOm2C7I/JnH2n/zELxzvbSxmiaj0ro/8k
         rjnl49Py8dOupgUfyZYxUpWEBPVYVIHbnl1HD0dV53jf2AtEIhk3lJkmkMlF4nFcbcEG
         k8R4BJUhGf3f1okowhT5Q4bOmLSVlCxZEdoPmRz4LwSiuaAdMWpuIgFbYOYjNBuvvfjG
         FoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A2JLxlWuEH6j0Jh7jAHHHzHa1EMwyEMqpv3GEMW1UVs=;
        b=mQCKlPcNwjCXKouBisZmMYeoZFyXRxBII+a+DpIUjAX9h5ySi9d4zxlP3AE80tMs0i
         SOMo2fRjsvoer6SS7fUBGKQMsJ2uuJn859pGxUvHERZKiTNw5y+XE7dUJeg4bKes7v8P
         9ICc4cZUeBEWba9/8FKq5CCUu9e5HgzzATQqR5QWBgoTdXBlYgFthTSaTr80DSX6/F1V
         9v1TbJeDYh+7xPtmhaeB2GKNh2gavO93yjVs/dlTkEJcdpj3YIPldVx4oZed9i/gbl4K
         apYWnQiVQ2tzy2nVhv55/DqCS7hyLj8l9Ug3DgYo0+Usg3oltv0VftptVAlX0HzKjbks
         UaDA==
X-Gm-Message-State: APjAAAXb/+e3+421waLYN3coBoWJw/bAxO9fKRlV6L2tFEjkJbFk0fUe
        C5x+OctVFJNclPJZv1Pe6FDKJw==
X-Google-Smtp-Source: APXvYqyBEseYF+JOeF1EzQIGYvflNRNaMOYKQCUeq9NX4feFVh2lSJ0/WgBMHsfh9zDaJfJaXKuALA==
X-Received: by 2002:a1c:65c3:: with SMTP id z186mr2681206wmb.93.1558107611140;
        Fri, 17 May 2019 08:40:11 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id h13sm7028152wrv.6.2019.05.17.08.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 08:40:10 -0700 (PDT)
Subject: Re: [PATCHv1 3/8] arm64: dts: qcom: msm8916: Add entry-method
 property for the idle-states node
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <030b5d9c6dc2e872466b7132e4fd65c473f9883f.1557486950.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <35c77a53-d8cb-0b32-6b60-ce57fabd5243@linaro.org>
Date:   Fri, 17 May 2019 17:40:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <030b5d9c6dc2e872466b7132e4fd65c473f9883f.1557486950.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 13:29, Amit Kucheria wrote:
> The idle-states binding documentation[1] mentions that the
> 'entry-method' property is required on 64-bit platforms and must be set
> to "psci".
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 0803ca8c02da..ded1052e5693 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -158,6 +158,8 @@
>  		};
>  
>  		idle-states {
> +			entry-method="psci";
> +
>  			CPU_SPC: spc {
>  				compatible = "arm,idle-state";
>  				arm,psci-suspend-param = <0x40000002>;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

