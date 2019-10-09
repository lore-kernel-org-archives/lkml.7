Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43EECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE58218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEITJ9pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbfJIRjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:39:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35877 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbfJIRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:39:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so1870042pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L8Js8kZvbgCYVI2QyS8R6uJL7k9QOYvlnFzB0XQV1NY=;
        b=zEITJ9ptdEbe4Kd+wErOiMycPRneU1csyzM46b9bx6yNxkCwajksugUpZsF1QhW/Yw
         hIFW3Dz9aarzqMKR2LDV36teMslOaIbSOirpGgE/Au8DOBxKTdSKPXia5LRWwbDJGm8s
         ApMZLA7DgPvis/xHs0yh2xp3vBR+wQVBIibqQCFMhG/E7qnuaeu31sVgusyCMd7VHKJq
         nenS7ghnwe60Xf020MQvivQ/HALLF3anqUTFM284sEOQXBD+3axfDZufXVVoOeNe/6sy
         NXYDhuTtTAPSm7FK7IcEdVoV6UuaON67zYECszcXu0A1Ac2y+cY9oBZ4EZexcBRD0mSL
         vOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8Js8kZvbgCYVI2QyS8R6uJL7k9QOYvlnFzB0XQV1NY=;
        b=M34i6f8wdEPaTPdq3eyb8WJoVvb0AwU79F2BdJtf0+KmxI1j7OoJeJfN0KlyML5ope
         EiqMfIoP7zKx0b2JjATBdMHX2Id1bQyX462P4pyn58Q43qL3ynSThDBkPRrwKXEjPECi
         oT6FYtUYtGvrpVNOcxvtPSk1yj4Fc3D9OQI5t88B6XzzojzccdoFEVtKylqpK7z7kkM5
         E9NFLZSIRULUPlPlM3ci0003xEVMv55FfCx3sg2fqyph+WtOfnEUjibGl7P486Mx7T05
         ltood7Pk/Pcg9zspfT2MjAe+bBVtUnw173+IzcVYingkKSRaiye3VG4/DF0u0lspPjnA
         kKCQ==
X-Gm-Message-State: APjAAAXXodbhoYaoUJD2+3q8KY2uv3cdJz94wLJCTm8qKR6Aa0riGZb8
        eJ36i7xoJvd0+7pbIto7bxn1fA==
X-Google-Smtp-Source: APXvYqwn9tO6PZbW6jj/ziXR3QqtGNubxwFnDNi4apZb7SO1ZnVGM0cAabx+RI44Uox6cowfB2et6Q==
X-Received: by 2002:a63:5813:: with SMTP id m19mr5646017pgb.43.1570642745999;
        Wed, 09 Oct 2019 10:39:05 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s97sm2713599pjc.4.2019.10.09.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:39:04 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:39:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     agross@kernel.org, vivek.gautam@codeaurora.org,
        jcrouse@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soc: qcom: Fix llcc-qcom definitions to include
Message-ID: <20191009173902.GM6390@tuxbook-pro>
References: <20191008071614.21692-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008071614.21692-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Oct 00:16 PDT 2019, YueHaibing wrote:

> commit 99356b03b431 ("soc: qcom: Make llcc-qcom a
> generic driver") move these out of llcc-qcom.h, make
> the building fails:
> 
> drivers/edac/qcom_edac.c:86:40: error: array type has incomplete element type struct llcc_edac_reg_data
>  static const struct llcc_edac_reg_data edac_reg_data[] = {
>                                         ^~~~~~~~~~~~~
> drivers/edac/qcom_edac.c:87:3: error: array index in non-array initializer
>   [LLCC_DRAM_CE] = {
>    ^~~~~~~~~~~~
> drivers/edac/qcom_edac.c:87:3: note: (near initialization for edac_reg_data)
> drivers/edac/qcom_edac.c:88:3: error: field name not in record or union initializer
>    .name = "DRAM Single-bit",
> ...
> drivers/edac/qcom_edac.c:169:51: warning: struct llcc_drv_data declared inside parameter
>  list will not be visible outside of this definition or declaration
>  qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
>                                                    ^~~~~~~~~~~~~
> 
> This patch move the needed definitions back to include.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 99356b03b431 ("soc: qcom: Make llcc-qcom a generic driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Sorry for missing this, thanks for the fix YueHaibing!

Regards,
Bjorn

> ---
>  drivers/soc/qcom/llcc-qcom.c       | 50 --------------------------------------
>  include/linux/soc/qcom/llcc-qcom.h | 50 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 98563ef..43606736 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -86,56 +86,6 @@ struct llcc_slice_config {
>  	bool activate_on_init;
>  };
>  
> -/**
> - * llcc_drv_data - Data associated with the llcc driver
> - * @regmap: regmap associated with the llcc device
> - * @bcast_regmap: regmap associated with llcc broadcast offset
> - * @cfg: pointer to the data structure for slice configuration
> - * @lock: mutex associated with each slice
> - * @cfg_size: size of the config data table
> - * @max_slices: max slices as read from device tree
> - * @num_banks: Number of llcc banks
> - * @bitmap: Bit map to track the active slice ids
> - * @offsets: Pointer to the bank offsets array
> - * @ecc_irq: interrupt for llcc cache error detection and reporting
> - */
> -struct llcc_drv_data {
> -	struct regmap *regmap;
> -	struct regmap *bcast_regmap;
> -	const struct llcc_slice_config *cfg;
> -	struct mutex lock;
> -	u32 cfg_size;
> -	u32 max_slices;
> -	u32 num_banks;
> -	unsigned long *bitmap;
> -	u32 *offsets;
> -	int ecc_irq;
> -};
> -
> -/**
> - * llcc_edac_reg_data - llcc edac registers data for each error type
> - * @name: Name of the error
> - * @synd_reg: Syndrome register address
> - * @count_status_reg: Status register address to read the error count
> - * @ways_status_reg: Status register address to read the error ways
> - * @reg_cnt: Number of registers
> - * @count_mask: Mask value to get the error count
> - * @ways_mask: Mask value to get the error ways
> - * @count_shift: Shift value to get the error count
> - * @ways_shift: Shift value to get the error ways
> - */
> -struct llcc_edac_reg_data {
> -	char *name;
> -	u64 synd_reg;
> -	u64 count_status_reg;
> -	u64 ways_status_reg;
> -	u32 reg_cnt;
> -	u32 count_mask;
> -	u32 ways_mask;
> -	u8  count_shift;
> -	u8  ways_shift;
> -};
> -
>  struct qcom_llcc_config {
>  	const struct llcc_slice_config *sct_data;
>  	int size;
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index c0acdb2..90b8646 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -37,6 +37,56 @@ struct llcc_slice_desc {
>  	size_t slice_size;
>  };
>  
> +/**
> + * llcc_edac_reg_data - llcc edac registers data for each error type
> + * @name: Name of the error
> + * @synd_reg: Syndrome register address
> + * @count_status_reg: Status register address to read the error count
> + * @ways_status_reg: Status register address to read the error ways
> + * @reg_cnt: Number of registers
> + * @count_mask: Mask value to get the error count
> + * @ways_mask: Mask value to get the error ways
> + * @count_shift: Shift value to get the error count
> + * @ways_shift: Shift value to get the error ways
> + */
> +struct llcc_edac_reg_data {
> +	char *name;
> +	u64 synd_reg;
> +	u64 count_status_reg;
> +	u64 ways_status_reg;
> +	u32 reg_cnt;
> +	u32 count_mask;
> +	u32 ways_mask;
> +	u8  count_shift;
> +	u8  ways_shift;
> +};
> +
> +/**
> + * llcc_drv_data - Data associated with the llcc driver
> + * @regmap: regmap associated with the llcc device
> + * @bcast_regmap: regmap associated with llcc broadcast offset
> + * @cfg: pointer to the data structure for slice configuration
> + * @lock: mutex associated with each slice
> + * @cfg_size: size of the config data table
> + * @max_slices: max slices as read from device tree
> + * @num_banks: Number of llcc banks
> + * @bitmap: Bit map to track the active slice ids
> + * @offsets: Pointer to the bank offsets array
> + * @ecc_irq: interrupt for llcc cache error detection and reporting
> + */
> +struct llcc_drv_data {
> +	struct regmap *regmap;
> +	struct regmap *bcast_regmap;
> +	const struct llcc_slice_config *cfg;
> +	struct mutex lock;
> +	u32 cfg_size;
> +	u32 max_slices;
> +	u32 num_banks;
> +	unsigned long *bitmap;
> +	u32 *offsets;
> +	int ecc_irq;
> +};
> +
>  #if IS_ENABLED(CONFIG_QCOM_LLCC)
>  /**
>   * llcc_slice_getd - get llcc slice descriptor
> -- 
> 2.7.4
> 
> 
