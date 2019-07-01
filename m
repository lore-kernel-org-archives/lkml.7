Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7490BC06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E0321721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sz7+x4QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfGAN6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:58:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37309 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfGAN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:58:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id d11so8904326lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RYgtzP3dt/Qrug6nYBa8QkcAXzJmawtUUkX7/voB/EQ=;
        b=sz7+x4QK/QK8sTSyvVZpoFFtDRJv8dEikYUpKolCPzUEDhlATMwpdIOp6iwENQdGeC
         vQM8o7PG9RlQ9ZY1OrVSga+KgDHuQzAqwLTUqkFngrg59stcWvrBox6GHwKfpuHkp1gk
         JoOQvrqjZkKTrfXHKXwM3bJ+SfvLmkLiupUpWoBxGQ61FZzWZL1kgl8UcHc06yqZapJd
         teuw+V5mGuJIcGGizSTTFf816/uEWSYCv0tLksvjC5OFpP2hQOPIwrzTfqQylCAstlLX
         5bvPgBFL9rPkZu+AcMaMhTbJk5qVzrUYPU/GxbA32RI5oCPHSnxSK2wBYG0iAk/qDhD4
         EBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RYgtzP3dt/Qrug6nYBa8QkcAXzJmawtUUkX7/voB/EQ=;
        b=AyVAIYBHeLYFOnU1CJ813uHFMrIcZkbtPQIp70Qo/ZE73UTmcKnidveY9/dQp0yby/
         Cmg73rm1oMmz5e0X0EK107hvylA1YCJmWuxh+JA1RItizhm/2fbfZuS8pQnwnk4CvHYV
         2SVMQxDOBL4k/fe3S0kEy26SARO/aKDlWfnZZua4lxsOCumUBk+kuHYGeWqpY+Vr4dve
         3/ZigEsCRlcsQB2qVWIHcG0q1YP+mkur7r7G9kMrFQzNPoZdjIPZq/kpS80ZSh90zc8n
         oHg2iQaVfH95TiY5qw8zSSto/pOLQk7+bnwISnTezh0uStKS7ZzkmWehEy81LjYcy/wF
         qznw==
X-Gm-Message-State: APjAAAXxpwLCDzuYFTzXHSKEybOMPaMtr6xWLrsqZlA64M16Q3i9XpH5
        3SJGIHr8D+jLTBPF6fnVw5qJUg==
X-Google-Smtp-Source: APXvYqxy6aPi0pn0hFSol6tJgvWAwVmmETmhI0LK/v1G9o+JJREkF0d1y94g7Dz7ppUD+MQISWdA8g==
X-Received: by 2002:ac2:5601:: with SMTP id v1mr11975581lfd.106.1561989525545;
        Mon, 01 Jul 2019 06:58:45 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id c1sm2619562lfh.13.2019.07.01.06.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:58:45 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] media: venus: Update core selection
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1561480044-11834-1-git-send-email-amasule@codeaurora.org>
 <1561480044-11834-5-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ac2170e6-6925-bfaf-523d-9e412d9ac1a7@linaro.org>
Date:   Mon, 1 Jul 2019 16:58:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561480044-11834-5-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/25/19 7:27 PM, Aniket Masule wrote:
> Present core assignment is static. Introduced load balancing
> across the cores. Load on earch core is calculated and core
> with minimum load is assigned to given instance.
> 
> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 52 +++++++++++++++++++++++++----
>  drivers/media/platform/qcom/venus/helpers.h |  2 +-
>  drivers/media/platform/qcom/venus/vdec.c    |  2 +-
>  drivers/media/platform/qcom/venus/venc.c    |  2 +-
>  4 files changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index b79e83a..ef35fd8 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -498,6 +498,16 @@ static int load_scale_clocks(struct venus_inst *inst)
>  	return scale_clocks(inst);
>  }
>  
> +int set_core_usage(struct venus_inst *inst, u32 usage)
> +{
> +	const u32 ptype = HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE;
> +	struct hfi_videocores_usage_type cu;
> +
> +	cu.video_core_enable_mask = usage;
> +
> +	return hfi_session_set_property(inst, ptype, &cu);
> +}
> +
>  static void fill_buffer_desc(const struct venus_buffer *buf,
>  			     struct hfi_buffer_desc *bd, bool response)
>  {
> @@ -801,19 +811,49 @@ int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_set_work_mode);
>  
> -int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage)
> +int venus_helper_set_core(struct venus_inst *inst)
>  {
> -	const u32 ptype = HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE;
> -	struct hfi_videocores_usage_type cu;
> +	struct venus_core *core = inst->core;
> +	u32 min_core_id = 0, core0_load = 0, core1_load = 0;

the same comment, please use the same counting scheme as for VIDC_CORE_ID_

> +	unsigned long min_load, max_freq, cur_inst_load;
> +	u32 cores_max;
> +	int ret;
>  
>  	if (!IS_V4(inst->core))
>  		return 0;
>  
> -	cu.video_core_enable_mask = usage;
> +	core0_load = load_per_core(core, VIDC_CORE_ID_1);
> +	core1_load = load_per_core(core, VIDC_CORE_ID_2);
>  
> -	return hfi_session_set_property(inst, ptype, &cu);
> +	min_core_id = core0_load < core1_load ? VIDC_CORE_ID_1 : VIDC_CORE_ID_2;
> +	min_load = min(core0_load, core1_load);
> +	cores_max = core_num_max(inst);
> +
> +	if (cores_max < VIDC_CORE_ID_2) {
> +		min_core_id = VIDC_CORE_ID_1;
> +		min_load = core0_load;
> +	}
> +
> +	cur_inst_load = load_per_instance(inst) *
> +		inst->clk_data.codec_freq_data->vpp_freq;
> +	max_freq = core->res->freq_tbl[0].freq;
> +
> +	if ((cur_inst_load + min_load)	> max_freq) {
> +		dev_warn(core->dev, "HW is overloaded, needed: %lu max: %lu\n",
> +			 cur_inst_load, max_freq);
> +		return -EINVAL;
> +	}
> +
> +	ret = set_core_usage(inst, min_core_id);
> +

please, delete this blank line

> +	if (ret)
> +		return ret;
> +
> +	inst->clk_data.core_id = min_core_id;
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL_GPL(venus_helper_set_core_usage);
> +EXPORT_SYMBOL_GPL(venus_helper_set_core);
>  
>  int venus_helper_init_codec_freq_data(struct venus_inst *inst)
>  {
> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index 2c13245..1034111 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -42,7 +42,7 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
>  				       u32 buftype);
>  int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode);
>  int venus_helper_init_codec_freq_data(struct venus_inst *inst);
> -int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage);
> +int venus_helper_set_core(struct venus_inst *inst);
>  int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
>  			      unsigned int output_bufs,
>  			      unsigned int output2_bufs);
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index d037f80..620e060 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -551,7 +551,7 @@ static int vdec_output_conf(struct venus_inst *inst)
>  	if (ret)
>  		return ret;
>  
> -	ret = venus_helper_set_core_usage(inst, VIDC_CORE_ID_1);
> +	ret = venus_helper_set_core(inst);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index cdddc82..28e76cc 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -660,7 +660,7 @@ static int venc_set_properties(struct venus_inst *inst)
>  	if (ret)
>  		return ret;
>  
> -	ret = venus_helper_set_core_usage(inst, VIDC_CORE_ID_2);
> +	ret = venus_helper_set_core(inst);
>  	if (ret)
>  		return ret;
>  
> 

-- 
regards,
Stan
