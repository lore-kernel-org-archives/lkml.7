Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32097C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0751820651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnnTckmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbfG2Lid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:38:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36894 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387626AbfG2Lib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:38:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so3998007ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xk5sDImFAW53ku5zPrNSNKzA4D6EyzpMXW4in0cztWM=;
        b=UnnTckmqXi6dtRJI9TtME6/cOTOcSTuagOIEvn4oN/YeXXjr5tMv5ApU90sSRCjsqx
         g5/P0yo7sMTWflAbYRhLb7bjzwJskohzcBQdkL82fHU/R1UKJrfOjyn0P1K0qqB9ECdk
         8IwoGlQyAc80cZy4Z7FZIy9MWsJNwPxOswu/lfTO4iep56sONTC0VlTL6yUAprVJL/xh
         TB5m9+Rh/larF/cef6tPOz8IzzsSuOvTkYMiBGqMWJzZQV3EGXlN3rz40NtxYVVjFNwI
         QS42vLzUOOqg1gz/qivvEXjngOePSIfS7ac9GWJ7di18Vu299bueL05K5EQu2IPkeYaO
         pAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xk5sDImFAW53ku5zPrNSNKzA4D6EyzpMXW4in0cztWM=;
        b=f625m2V9MKbzxebEKf/KasCy02DD5+4c6ar/h6C3tBOjudNUIm0ZXyQ4VkH6u48uzP
         f3HmcL5inA5Pkvkhkhsf2D7JPx60UfolaHfEYj5QBljVKeOJazrM5GU0dZNCNzwE/qei
         3XVj9CW7neTXlY3+J1e3+5WHfS33FaDHeJ2YGvmdZhjdGW/E3X+6I41N/BfuXDhdbXwg
         tvt70d8wS7DDoHO/TEEF8XVrCuCnjZFJGFOn8z0WRIJetnp50xfsZ0IrM40LI32/JLLP
         zps3M451eLISqfTM1bzaUcwl1kWPrpHrcYa011ykMzJPm8rEvpoFJAeQhi6bIFSBPZ18
         5fAQ==
X-Gm-Message-State: APjAAAXwJrGF5TrazWwXRvUaQbFGwq5CJBcJUfqFnzwFDT9O/esTfCCt
        MBKne9Xp0MKS9ekQdg7i6nA2pg==
X-Google-Smtp-Source: APXvYqxNUBeruTZFEiy3HdGgth8M3XFHuGw1Wi0lvd8yms4gJBEi00iudCF1A+C/YpnaL5sgIlzSSw==
X-Received: by 2002:a2e:9e81:: with SMTP id f1mr58208530ljk.29.1564400308785;
        Mon, 29 Jul 2019 04:38:28 -0700 (PDT)
Received: from [192.168.28.50] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id v14sm12759730ljh.51.2019.07.29.04.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 04:38:28 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] media: venus: Update to bitrate based clock
 scaling
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1563786452-22188-1-git-send-email-amasule@codeaurora.org>
 <1563786452-22188-3-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <cdfde490-8d02-c9a1-5fbd-9ae001692f55@linaro.org>
Date:   Mon, 29 Jul 2019 14:38:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563786452-22188-3-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/22/19 12:07 PM, Aniket Masule wrote:
> Introduced clock scaling using bitrate, preavious
> calculations consider only the cycles per mb.
> Also, clock scaling is now triggered before every
> buffer being queued to the device. This helps in
> deciding precise clock cycles required.
> 
> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 33 +++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 2c976e4..edf403d 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -399,17 +399,26 @@ static int scale_clocks(struct venus_inst *inst)
>  	return ret;
>  }
>  
> -static unsigned long calculate_vpp_freq(struct venus_inst *inst)
> +static unsigned long calculate_inst_freq(struct venus_inst *inst,
> +					 unsigned long filled_len)
>  {
> -	unsigned long vpp_freq = 0;
> +	unsigned long vpp_freq = 0, vsp_freq = 0;
> +	u64 fps = inst->fps;
>  	u32 mbs_per_sec;
>  
>  	mbs_per_sec = load_per_instance(inst);
>  	vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
>  	/* 21 / 20 is overhead factor */
>  	vpp_freq += vpp_freq / 20;
> +	vsp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vsp_freq;
>  
> -	return vpp_freq;
> +	/* 10 / 7 is overhead factor */
> +	if (inst->session_type == VIDC_SESSION_TYPE_ENC)
> +		vsp_freq += (inst->controls.enc.bitrate * 10) / 7;
> +	else
> +		vsp_freq += ((fps * filled_len * 8) * 10) / 7;

load_per_instance() already taken into account fps, thus I think fps
should be excluded from calculation.

> +
> +	return max(vpp_freq, vsp_freq);
>  }
>  


-- 
regards,
Stan
