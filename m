Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4686FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD302072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxqQGUWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfKOMoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:44:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42232 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfKOMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:44:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so7227031edv.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xR5jlMTS/0mlZS9BTKyNRoNtTkP0SvB+AtI0uCjnmWc=;
        b=VxqQGUWcBlv2aNQVn8vSNrrxzjzWrOIDktSkPUulLRJhNNTdjFeZDb5/fVRjZTKnP8
         1jFt7rqqvZPT60aPFJxeup0IbaWzHmxlWlgaVUJIL1TtXOTh4iAcK40t7HoRPhANsmQu
         kB0cWIoWj0D+kjzgn8P/6gGwd9dBVRp4FVGamy7ekphA+aehFSxwtzTJMED7mnXhskBV
         en97mf3TQVlhV8ihLGsVyetY+8B8GFr19ARx7/jixLfUYlGiPg+gZDnYpLChpfIl+Sn4
         CbP5JB1dpPPQ9eIkDiuFLigvqHFDG0/g4sjr0SKs+pJVjfTVZ2HMBKBR2djjcF3SS7yU
         U3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xR5jlMTS/0mlZS9BTKyNRoNtTkP0SvB+AtI0uCjnmWc=;
        b=e978NGr70FLzd+oyXueD1hKItwcrET4QJ2FroJ2gerHOZFOKhyf9stM+wRVuJcGlAO
         BuWOBenTqVSt9ec1WolIVK3lTkwyVVM7XmfXAhz2cJ8TCupnwhSN/FlADFn+uTaV1mLz
         jKQwoDRKUWM/UIXCKfpOjfqqNv4SFQmfKOHjp90zHFByUtGfVc21qz2z1Xta4xDfy5J3
         mcH/WS4pelIvzDlN7VYOXxcA1E8gXFRkQsw4h66azETpxO32+FddYCpH3VJGynEBvrlC
         3ZvkYF29t8bEcCqaPom6ccNpvt1BJpb7Owhv7znHZTKzJb0Gq06lmv9ke19XYJJVk3M1
         ki/A==
X-Gm-Message-State: APjAAAXB5kjAUWnTvfgkXK4+mYIvb4jxrmnjvumCDAZRXSlglwgo/Mh6
        lYQE04N5DdGTDeBZOJf52GJwSg==
X-Google-Smtp-Source: APXvYqwazSl6duqZxWH30Xs6SO99FC1WQeKgdjbmW3vMfzXpP4Vmy/3XbLKCb0ygghb37l01a0+Syg==
X-Received: by 2002:a17:906:af5a:: with SMTP id ly26mr693135ejb.252.1573821845901;
        Fri, 15 Nov 2019 04:44:05 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id n3sm563860edc.49.2019.11.15.04.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:44:04 -0800 (PST)
Subject: Re: [PATCH v5 5/5] arm64: defconfig: enable
 CONFIG_ARM_QCOM_CPUFREQ_NVMEM
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191115121544.2339036-1-niklas.cassel@linaro.org>
 <20191115121544.2339036-6-niklas.cassel@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <aed0bac0-ca9d-febd-ac57-120e60e99e0d@linaro.org>
Date:   Fri, 15 Nov 2019 14:44:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191115121544.2339036-6-niklas.cassel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On 11/15/19 2:15 PM, Niklas Cassel wrote:
> Enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM.

Shouldn't this be selected from qcom-cpr.c Kconfig ?

> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4385033c0a34..09aaffd473a0 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -88,6 +88,7 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
>  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ARM_IMX_CPUFREQ_DT=m
> +CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
>  CONFIG_ARM_QCOM_CPUFREQ_HW=y
>  CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
> 

-- 
regards,
Stan
