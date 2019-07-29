Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C9C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F464206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrXqod/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfG2Ife (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:35:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40255 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfG2Ife (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:35:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so41466439lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FWpcboH2lysDc+UrR6Wnjx8ccwzYsU3RW3Ru+qtWu5A=;
        b=lrXqod/GOpdBTZkWoxXDZ17shQKWM487kOaSK1LgCm2FwBkLcud39wneA5ccGlfs+7
         FKUB228G4iV7Qo0xtwP/flLX5ubrte6v1W3Y/IXs/ZDzBUsU3S0xSe/xKhIz4ytzncA0
         EDAnWHuLFUX6HoUr9CKWLfX7/dQKTpBoiiSd3aqcMir26yhzEa9pWaZXx4Uf9St6w9p9
         ydVB9f4b71I09P9Jwa7jEZiI/BEZ9l3F+srB8uYkOK5tAGnMm9cAvftdULR1YGN/6kzU
         F79jPVldqPgbc9wcqxnq2J0/Qxv4fZi7b7kcvjPXsaKoml2snhkWqZf7+ObuAXZjllGU
         vZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FWpcboH2lysDc+UrR6Wnjx8ccwzYsU3RW3Ru+qtWu5A=;
        b=BxNYBgt7S8Kfv6KbWlkrJ3wGeV3Lv/SxfyEBTgSR+YtCSc8K/T54zEFdQRTfdTsQxp
         YnV7sIzTiyzfCFKfnQFCc45OEt+3YeovljCTEkdoh4UU6GghUTPtJDRLzk1J9ZFytlWy
         ZAI89e4U4ETKR9om3StmI6XF4ULbkbLEjvAHNe/2a9UcT2oZ4ZeUQKd1mUGpiY97goK3
         jU7XEGx9qpImelKi4zeXTinZza8efPS0xoXr7Z7+kDABTG9RmBXc8tPHubVxaDD0pN9a
         e7G2ozoROzxVGYezFdHDZ8dB5YQxYav4sj/qQYMwcdjIYCXgJ9lwvVKpoZgF9WTae4rB
         LztA==
X-Gm-Message-State: APjAAAVyClWyMVDSUwEYHBvBk+dvFns4n06/HNWlUDpDOHZ/TVwfpHte
        fyh4HK8PWVoTbRNyh/t2jbYLHw==
X-Google-Smtp-Source: APXvYqwuSBZ0x68X+CtDlZClvW63jEOIokVvwaoOBI28kgPF3P0i2zUz8qwlC7LvLnUv3iPCWnhMxw==
X-Received: by 2002:a19:ca0d:: with SMTP id a13mr49228459lfg.110.1564389331265;
        Mon, 29 Jul 2019 01:35:31 -0700 (PDT)
Received: from [192.168.28.50] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id d10sm12537047ljc.15.2019.07.29.01.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 01:35:30 -0700 (PDT)
Subject: Re: [PATCH v6 2/4] media: venus: Update clock scaling
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1563786452-22188-1-git-send-email-amasule@codeaurora.org>
 <1563786452-22188-2-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <c02c070d-7f22-88ba-d254-18951c34ce5e@linaro.org>
Date:   Mon, 29 Jul 2019 11:35:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563786452-22188-2-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aniket,

On 7/22/19 12:07 PM, Aniket Masule wrote:
> Current clock scaling calculations are same for vpu4 and
> previous versions. For vpu4, Clock scaling calculations
> are updated with cycles/mb. This helps in getting precise
> clock required.
> 
> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 91 +++++++++++++++++++++++++++--
>  1 file changed, 87 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 7492373..2c976e4 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -348,8 +348,9 @@ static u32 load_per_type(struct venus_core *core, u32 session_type)
>  	return mbs_per_sec;
>  }
>  
> -static int load_scale_clocks(struct venus_core *core)
> +static int scale_clocks(struct venus_inst *inst)
>  {
> +	struct venus_core *core = inst->core;
>  	const struct freq_tbl *table = core->res->freq_tbl;
>  	unsigned int num_rows = core->res->freq_tbl_size;
>  	unsigned long freq = table[0].freq;
> @@ -398,6 +399,89 @@ static int load_scale_clocks(struct venus_core *core)
>  	return ret;
>  }
>  
> +static unsigned long calculate_vpp_freq(struct venus_inst *inst)
> +{
> +	unsigned long vpp_freq = 0;
> +	u32 mbs_per_sec;
> +
> +	mbs_per_sec = load_per_instance(inst);
> +	vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
> +	/* 21 / 20 is overhead factor */
> +	vpp_freq += vpp_freq / 20;
> +
> +	return vpp_freq;
> +}
> +
> +static int scale_clocks_v4(struct venus_inst *inst)
> +{
> +	struct venus_core *core = inst->core;
> +	const struct freq_tbl *table = core->res->freq_tbl;
> +	unsigned int num_rows = core->res->freq_tbl_size;
> +	struct clk *clk = core->clks[0];
> +	struct device *dev = core->dev;
> +	unsigned int i;
> +	unsigned long freq = 0, freq_core1 = 0, freq_core2 = 0;
> +	int ret;
> +
> +	freq = calculate_vpp_freq(inst);
> +
> +	if (freq > table[0].freq)
> +		dev_warn(dev, "HW is overloaded, needed: %lu max: %lu\n",
> +			 freq, table[0].freq);
> +

...

> +	for (i = 0; i < num_rows; i++) {
> +		if (freq > table[i].freq)
> +			break;
> +		freq = table[i].freq;
> +	}

The above code snippet will select the biggest table[0].freq always.
Infact do we need to "normalize" the calculated freq to the table of
possible clock rates? I think tjat should be made after sum all needed
frequencies for all cores.

> +
> +	inst->clk_data.freq = freq;
> +
> +	mutex_lock(&core->lock);
> +	list_for_each_entry(inst, &core->instances, list) {
> +		if (inst->clk_data.core_id == VIDC_CORE_ID_1) {
> +			freq_core1 += inst->clk_data.freq;
> +		} else if (inst->clk_data.core_id == VIDC_CORE_ID_2) {
> +			freq_core2 += inst->clk_data.freq;
> +		} else if (inst->clk_data.core_id == VIDC_CORE_ID_3) {
> +			freq_core1 += inst->clk_data.freq;
> +			freq_core2 += inst->clk_data.freq;
> +		}
> +	}
> +	mutex_unlock(&core->lock);
> +
> +	freq = max(freq_core1, freq_core2);
> +
> +	ret = clk_set_rate(clk, freq);
> +	if (ret)
> +		goto err;
> +
> +	ret = clk_set_rate(core->core0_clk, freq);
> +	if (ret)
> +		goto err;
> +
> +	ret = clk_set_rate(core->core1_clk, freq);
> +	if (ret)
> +		goto err;

This is duplicated in both scale_clocks and scale_clocks_v4, and could
be a common function.

> +
> +	return 0;
> +
> +err:
> +	dev_err(dev, "failed to set clock rate %lu (%d)\n", freq, ret);
> +	return ret;
> +}
> +
> +static int load_scale_clocks(struct venus_inst *inst)
> +{
> +	if (IS_V4(inst->core))
> +		return scale_clocks_v4(inst);
> +
> +	if (inst->state == INST_START)
> +		return 0;

I'm still not sure about this check of the instance state.

If we look into load_per_instance() it already doing similar check :

!(inst->state >= INST_INIT && inst->state < INST_STOP)


> +
> +	return scale_clocks(inst);
> +}
> +
>  static void fill_buffer_desc(const struct venus_buffer *buf,
>  			     struct hfi_buffer_desc *bd, bool response)
>  {
> @@ -1053,7 +1137,7 @@ void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
>  
>  		venus_helper_free_dpb_bufs(inst);
>  
> -		load_scale_clocks(core);
> +		load_scale_clocks(inst);
>  		INIT_LIST_HEAD(&inst->registeredbufs);
>  	}
>  
> @@ -1070,7 +1154,6 @@ void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
>  
>  int venus_helper_vb2_start_streaming(struct venus_inst *inst)
>  {
> -	struct venus_core *core = inst->core;
>  	int ret;
>  
>  	ret = intbufs_alloc(inst);
> @@ -1081,7 +1164,7 @@ int venus_helper_vb2_start_streaming(struct venus_inst *inst)
>  	if (ret)
>  		goto err_bufs_free;
>  
> -	load_scale_clocks(core);
> +	load_scale_clocks(inst);
>  
>  	ret = hfi_session_load_res(inst);
>  	if (ret)
> 

-- 
regards,
Stan
