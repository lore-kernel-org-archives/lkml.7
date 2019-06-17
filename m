Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068CEC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88AB2238D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsdfradK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfFQIhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:37:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37490 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFQIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:37:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so8452984ljf.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 01:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1t397wHVI5ZNALcSXhk1nacawojdv2GANgE2+/C/lrk=;
        b=TsdfradKQQ05GRFtFroQtR18VGuUsdZ8Ef4vutW+jvbv/tStv5tn9N7/CSI5qjdl1W
         vq2EBs2sf7XmzSJkyeBUp1wh195LybQsjS7YCj5gJX6DVX8uwQ10FHPgSQ/9jBjvWtpB
         soncHi954l+uz3w0t9xMwSUM/WrQ2ANZp07v5u/jYEb9DO0HB74PRYnx0LSkWg6073kN
         1/zfgFNEgRSLkx6ETC4Jmly1hlazmgvK7Ml6Nkp4LEMl+I21vVKeiCjDCQswTlCSF6qT
         Ot3/fOyzRUjD9SUhZF6Vc8t+GapYSm8wCOfZyeZ6xo1lUpNP4z23rUAkpWusfeI2tX8c
         yamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1t397wHVI5ZNALcSXhk1nacawojdv2GANgE2+/C/lrk=;
        b=XaAKdMJS+dImAS8/2QawNz9jRWKpnZEp+T1xoAICmqqLUtKxWkaDQqIjaDvB5Vg1wT
         TZREsuqHZW5fRjJ3agBk3uRos0Lv4DlOcqo28YAnulyg8RUhsFjUnbiPuETSzyx4+Xq2
         AdrToQ/cmJsd6fTzIXN48gttTLjYkavtnceoUm5VbtFsRLai6KFHKTZsIU+m9mUYeMdb
         TRDUi9ED6sRjoy8lVcMFjMS19lhMsbpjv9C/2znbvBfI0I5zTquGpOqj/XRLCD31cZDs
         UnhYrQDBD9FSNDdbDEGJ3EF0c+kTSB+LC2zX9ObuRYSNMceJG7qr3mzM1o3qcnoorYEZ
         6omw==
X-Gm-Message-State: APjAAAU7YDjp311G7uSbykSgsUs6ysq9Uk0MfwcfrkwXPlM4v0o4wGu5
        vTsEuTfCvrMpCOujECOn39i5wA==
X-Google-Smtp-Source: APXvYqwuI7QluNPFP2mma7scZggW3BzbiuTdonR73HjPRCl/98WoZfQEt+sDgHch0mQH0RQJlUsFRg==
X-Received: by 2002:a2e:b047:: with SMTP id d7mr11082859ljl.8.1560760623861;
        Mon, 17 Jun 2019 01:37:03 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id p27sm1686189lfo.16.2019.06.17.01.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 01:37:03 -0700 (PDT)
Subject: Re: [PATCH 1/5] media: venus: Add codec data table
To:     Aniket Masule <amasule@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1560233130-27264-1-git-send-email-amasule@codeaurora.org>
 <1560233130-27264-2-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <bc6035d8-2688-f79a-068e-bf6630dd65ef@linaro.org>
Date:   Mon, 17 Jun 2019 11:37:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560233130-27264-2-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aniket,

On 6/11/19 9:05 AM, Aniket Masule wrote:
> Add vpp cycles for for different types of codec
> It indicates the cycles required by video hardware
> to process each macroblock.
> 
> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 13 +++++++++++++
>  drivers/media/platform/qcom/venus/core.h | 15 +++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 7393667..43eb446 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -473,9 +473,22 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
>  	{  244800, 100000000 },	/* 1920x1080@30 */
>  };
>  
> +static struct codec_data sdm845_codec_data[] =  {
> +	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675 },
> +	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675 },
> +	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675 },
> +	{ V4L2_PIX_FMT_MPEG2, VIDC_SESSION_TYPE_DEC, 200 },
> +	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 200 },
> +	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 200 },
> +	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_DEC, 200 },
> +	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 200 },
> +};
> +
>  static const struct venus_resources sdm845_res = {
>  	.freq_tbl = sdm845_freq_table,
>  	.freq_tbl_size = ARRAY_SIZE(sdm845_freq_table),
> +	.codec_data = sdm845_codec_data,
> +	.codec_data_size = ARRAY_SIZE(sdm845_codec_data),
>  	.clks = {"core", "iface", "bus" },
>  	.clks_num = 3,
>  	.max_load = 2563200,
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 7a3feb5..b1a9b43 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -35,12 +35,20 @@ struct reg_val {
>  	u32 value;
>  };
>  
> +struct codec_data {

The name is very generic, could you rename the structure to something
like vpp_cycles_data?

> +u32 pixfmt;
> +u32 session_type;
> +int vpp_cycles;

please check your editor, those fields should have a tab to the right.

> +};
> +
>  struct venus_resources {
>  	u64 dma_mask;
>  	const struct freq_tbl *freq_tbl;
>  	unsigned int freq_tbl_size;
>  	const struct reg_val *reg_tbl;
>  	unsigned int reg_tbl_size;
> +	const struct codec_data *codec_data;
> +	unsigned int codec_data_size;
>  	const char * const clks[VIDC_CLKS_NUM_MAX];
>  	unsigned int clks_num;
>  	enum hfi_version hfi_version;
> @@ -216,6 +224,12 @@ struct venus_buffer {
>  	struct list_head ref_list;
>  };
>  
> +struct clock_data {
> +	u32 core_id;
> +	unsigned long freq;

I cannot see how this 'freq' structure field is used? I can see that you
fill it in 3/5 patch but you don't used nowhere.

> +	struct codec_data *codec_data;
> +};

Having the fact that freq field seems not needed can we just merge the
fields in venus_inst structure?

> +
>  #define to_venus_buffer(ptr)	container_of(ptr, struct venus_buffer, vb)
>  
>  /**
> @@ -275,6 +289,7 @@ struct venus_inst {
>  	struct list_head list;
>  	struct mutex lock;
>  	struct venus_core *core;
> +	struct clock_data clk_data;
>  	struct list_head dpbbufs;
>  	struct list_head internalbufs;
>  	struct list_head registeredbufs;
> 

-- 
regards,
Stan
