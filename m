Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D4C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D91D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdH58kHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfFQJFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:05:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44872 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFQJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:05:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so5908294lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GRLI3Z2O8SkTky112/FI8HFAdykgQAeWvWkCXXseK+Y=;
        b=RdH58kHwYUCFIYpWmi0PSzN/yHMgmUIkovI4RdHzwry6cuWPSahEcsB3lR8JNqPdIA
         UhzSafN7pfojujjEzV5epj9HzM/lGDbJ3URm4Y+cLRihNhJ+Ii5vgF67zeG1jZLnx3AJ
         AHihrBkPU0MZ9846/AdlG3rlQsxUeMVenkNTenJxGMuKaYdKbQq+Tzv4NZrDsG2uojND
         w60td4Zxt/2/rC+L86PZgHg+8qsoZTxYVt4aOSf/gkJvJi4eoWS0nNnOGtn6TXqWk6Hb
         omAiZODeoHBw8rs6vYti/WayTdrZU8whHlvDs72jv0eEIVLRHF5AGEfte5BzBFzXPH9R
         NMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRLI3Z2O8SkTky112/FI8HFAdykgQAeWvWkCXXseK+Y=;
        b=hkOvRLENJiedTxYkz41s/8dtVcUAzT6dAYksftwhRl0KOGQi5PKfx+uDvRRCHD4nGW
         Nc5hRjCW44695jSm7uTSmVbtXEPpgMIRpeyQi+Wq/Zbz7NagYMcJF9EvsmSJcdAKUIF0
         gVZXhp2cn7HtpkUMpTt0A/qSEhuABT7lB+zB4BBmScQqu5jieNhECpx7B9c+7EtcHbUj
         4nFbxY+N4ZA/u7G91A5QwkvaKgIZ5fQhGGijznwTzYxO20QFtDX27AxtFFqJNwc44QA9
         tpkmOXRXJL1pf10coSN+WCeU7K1/okyExoGN0RK/CgLHBU7K906GPOC4Es5eE4SoDuD+
         iv7w==
X-Gm-Message-State: APjAAAXgQ4hu6hICIVplxQffPbdfAFlvMviUIf8u4ItCsGaFSZIF9Pib
        SHhnCrMZ/INHABoU96aQHC/Ihw==
X-Google-Smtp-Source: APXvYqzf5ced+QJqjoZWOGh8R0yAqNwDIMornTW7Q+foDset57AyNfggHCWPYfIc+SySSGowX6zRqw==
X-Received: by 2002:a05:6512:dc:: with SMTP id c28mr54082739lfp.105.1560762326347;
        Mon, 17 Jun 2019 02:05:26 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id n1sm1653660lfl.77.2019.06.17.02.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 02:05:25 -0700 (PDT)
Subject: Re: [PATCH 4/5] media: venus: Add interface for load per core
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1560233130-27264-1-git-send-email-amasule@codeaurora.org>
 <1560233130-27264-5-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <e8cbed4c-65f4-adfb-3c58-5c9773a01e0d@linaro.org>
Date:   Mon, 17 Jun 2019 12:05:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560233130-27264-5-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aniket,

On 6/11/19 9:05 AM, Aniket Masule wrote:
> Add and interface to calculate load per core. Also,
> add an interface to get maximum cores available with
> video. This interface is preparation for updating core
> selection.
> 
> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c    | 18 ++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_helper.h |  1 +
>  drivers/media/platform/qcom/venus/hfi_parser.h |  5 +++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 7bcc1e6..edb653e 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -331,6 +331,24 @@ static u32 load_per_instance(struct venus_inst *inst)
>  	return mbs * inst->fps;
>  }
>  
> +static u32 load_per_core(struct venus_core *core, u32 core_id)
> +{
> +	struct venus_inst *inst = NULL;
> +	u32 mbs_per_sec = 0, load = 0;
> +
> +	mutex_lock(&core->lock);
> +	list_for_each_entry(inst, &core->instances, list) {
> +		if (!(inst->clk_data.core_id == core_id))
> +			continue;
> +
> +		mbs_per_sec += load_per_instance(inst);
> +		load += mbs_per_sec * inst->clk_data.codec_data->vpp_cycles;
> +	}
> +	mutex_unlock(&core->lock);
> +
> +	return load;
> +}
> +
>  static u32 load_per_type(struct venus_core *core, u32 session_type)
>  {
>  	struct venus_inst *inst = NULL;
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index 34ea503..3677e2e 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -559,6 +559,7 @@ struct hfi_bitrate {
>  #define HFI_CAPABILITY_LCU_SIZE				0x14
>  #define HFI_CAPABILITY_HIER_P_HYBRID_NUM_ENH_LAYERS	0x15
>  #define HFI_CAPABILITY_MBS_PER_SECOND_POWERSAVE		0x16
> +#define HFI_CAPABILITY_MAX_VIDEOCORES          0x2B

please use tabs instead of spaces.

>  
>  struct hfi_capability {
>  	u32 capability_type;
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.h b/drivers/media/platform/qcom/venus/hfi_parser.h
> index 3e931c7..264e6dd 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.h
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.h
> @@ -107,4 +107,9 @@ static inline u32 frate_step(struct venus_inst *inst)
>  	return cap_step(inst, HFI_CAPABILITY_FRAMERATE);
>  }
>  
> +static inline u32 core_num_max(struct venus_inst *inst)
> +{
> +	return cap_max(inst, HFI_CAPABILITY_MAX_VIDEOCORES);
> +}
> +
>  #endif
> 

-- 
regards,
Stan
