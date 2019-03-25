Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC402082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1laP61N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfCYVJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:09:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35715 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:09:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id p19so535004plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W9paaqLgIowNzDLuzsh4dINSOzA1yebQK8v3bWaDjdc=;
        b=P1laP61NRjiV+8uruabKr5ViMurK1g4wGK08sTbggYyRHLHjIezwWfeHeCtbrKfMAt
         Fr0Ks5BCufh6psqZi+PbLVHX7UMbM9ufsf8xY/5AD0rshPCMUBdprL+2wAVVHm+EO3+d
         lzVDnxl/7uxx7xRUeha5ndCF2rnsTwrGETga+CB8R7qbvs1Qz/WWWmszirN1u4SG7TlP
         Ay5vdldwRuoGR451+HSUwz8lXpm8fL++YIW6k8rCX5A9ERzrBGiahodYsu+VhY27uKy9
         N2f0xb4QRjlES2UXgSLH8m0PCv2cNlpQls1x9xDigWzhVyzLvIm5YdVEOsgFR9fNzO9b
         kOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W9paaqLgIowNzDLuzsh4dINSOzA1yebQK8v3bWaDjdc=;
        b=e8cQyc1DSLPAdP69DTyaMOsg1HEVIvRa1f+uUqipNqF0ZmgFL1011p/meDoeoBpRCY
         K8nijTLHPEaPviYVDweRRVcFFmn3Vv18tqoXeB5S2EFKKo1ji9/F/9jPkXhd4ROyluwU
         BV0CYoIOElWs9nAd1jpjOpA85mb4/jD9lMiiA6bAHFfIdaxH4TVKYSMY3E4UzhKijhB/
         dug0fFsqZEaFmwRFpNki+8w8/tD/BCsBzA9z4IMua90PPMwTpICb2Asx0akL4fkIliPZ
         GiADMicOGAKLpSRjVCyTmw/9CvM8QyUcfFdgYoKvgQlHPT33orgos7QyjU2WzglFtS5/
         +4zg==
X-Gm-Message-State: APjAAAUqBJhOlBOlxbe39EsFu7unUgD8rXWOr6fMp9euv8R04AWQhI7W
        tC52tSwh2T+M3Tv4qxvqr3OzXrhXq8E=
X-Google-Smtp-Source: APXvYqwhMqb1qrtWBuiQ/VGGZhGRe4DdBxWq6vroFReB2rdal1xKheGZKQxqoeFIy8oZhVHGtyJZIw==
X-Received: by 2002:a17:902:8c81:: with SMTP id t1mr27762950plo.309.1553548184641;
        Mon, 25 Mar 2019 14:09:44 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y12sm13213948pgq.64.2019.03.25.14.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:09:41 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:09:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, david.brown@linaro.org,
        tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v2 1/4] firmware: qcom_scm-64: Add atomic version of
 qcom_scm_call
Message-ID: <20190325210925.GA2899@builder>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180910062551.28175-2-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910062551.28175-2-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Sep 23:25 PDT 2018, Vivek Gautam wrote:

> There are scnenarios where drivers are required to make a
> scm call in atomic context, such as in one of the qcom's
> arm-smmu-500 errata [1].
> 
> [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/
>       tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842")
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/firmware/qcom_scm-64.c | 136 ++++++++++++++++++++++++++++-------------
>  1 file changed, 92 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> index 688525dd4aee..3a8c867cdf51 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -70,32 +70,71 @@ static DEFINE_MUTEX(qcom_scm_lock);
>  #define FIRST_EXT_ARG_IDX 3
>  #define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
>  
> -/**
> - * qcom_scm_call() - Invoke a syscall in the secure world
> - * @dev:	device
> - * @svc_id:	service identifier
> - * @cmd_id:	command identifier
> - * @desc:	Descriptor structure containing arguments and return values
> - *
> - * Sends a command to the SCM and waits for the command to finish processing.
> - * This should *only* be called in pre-emptible context.
> -*/
> -static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> -			 const struct qcom_scm_desc *desc,
> -			 struct arm_smccc_res *res)
> +static void __qcom_scm_call_do(const struct qcom_scm_desc *desc,
> +			       struct arm_smccc_res *res, u32 fn_id,
> +			       u64 x5, u32 type)
> +{
> +	u64 cmd;
> +	struct arm_smccc_quirk quirk = {.id = ARM_SMCCC_QUIRK_QCOM_A6};
> +
> +	cmd = ARM_SMCCC_CALL_VAL(type, qcom_smccc_convention,
> +				 ARM_SMCCC_OWNER_SIP, fn_id);
> +
> +	quirk.state.a6 = 0;
> +
> +	do {
> +		arm_smccc_smc_quirk(cmd, desc->arginfo, desc->args[0],
> +				    desc->args[1], desc->args[2], x5,
> +				    quirk.state.a6, 0, res, &quirk);
> +
> +		if (res->a0 == QCOM_SCM_INTERRUPTED)
> +			cmd = res->a0;
> +
> +	} while (res->a0 == QCOM_SCM_INTERRUPTED);
> +}
> +
> +static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
> +			     struct arm_smccc_res *res, u32 fn_id,
> +			     u64 x5, bool atomic)
> +{
> +	int retry_count = 0;
> +
> +	if (!atomic) {
> +		do {
> +			mutex_lock(&qcom_scm_lock);
> +
> +			__qcom_scm_call_do(desc, res, fn_id, x5,
> +					   ARM_SMCCC_STD_CALL);
> +
> +			mutex_unlock(&qcom_scm_lock);
> +
> +			if (res->a0 == QCOM_SCM_V2_EBUSY) {
> +				if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> +					break;
> +				msleep(QCOM_SCM_EBUSY_WAIT_MS);
> +			}
> +		}  while (res->a0 == QCOM_SCM_V2_EBUSY);
> +	} else {
> +		__qcom_scm_call_do(desc, res, fn_id, x5, ARM_SMCCC_FAST_CALL);
> +	}
> +}
> +
> +static int ___qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +			    const struct qcom_scm_desc *desc,
> +			    struct arm_smccc_res *res, bool atomic)
>  {
>  	int arglen = desc->arginfo & 0xf;
> -	int retry_count = 0, i;
> +	int i;
>  	u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
> -	u64 cmd, x5 = desc->args[FIRST_EXT_ARG_IDX];
> +	u64 x5 = desc->args[FIRST_EXT_ARG_IDX];
>  	dma_addr_t args_phys = 0;
>  	void *args_virt = NULL;
>  	size_t alloc_len;
> -	struct arm_smccc_quirk quirk = {.id = ARM_SMCCC_QUIRK_QCOM_A6};
> +	gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
>  
>  	if (unlikely(arglen > N_REGISTER_ARGS)) {
>  		alloc_len = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
> -		args_virt = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
> +		args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
>  
>  		if (!args_virt)
>  			return -ENOMEM;
> @@ -125,33 +164,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>  		x5 = args_phys;
>  	}
>  
> -	do {
> -		mutex_lock(&qcom_scm_lock);
> -
> -		cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
> -					 qcom_smccc_convention,
> -					 ARM_SMCCC_OWNER_SIP, fn_id);
> -
> -		quirk.state.a6 = 0;
> -
> -		do {
> -			arm_smccc_smc_quirk(cmd, desc->arginfo, desc->args[0],
> -				      desc->args[1], desc->args[2], x5,
> -				      quirk.state.a6, 0, res, &quirk);
> -
> -			if (res->a0 == QCOM_SCM_INTERRUPTED)
> -				cmd = res->a0;
> -
> -		} while (res->a0 == QCOM_SCM_INTERRUPTED);
> -
> -		mutex_unlock(&qcom_scm_lock);
> -
> -		if (res->a0 == QCOM_SCM_V2_EBUSY) {
> -			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> -				break;
> -			msleep(QCOM_SCM_EBUSY_WAIT_MS);
> -		}
> -	}  while (res->a0 == QCOM_SCM_V2_EBUSY);
> +	qcom_scm_call_do(desc, res, fn_id, x5, atomic);
>  
>  	if (args_virt) {
>  		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
> @@ -164,6 +177,41 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>  	return 0;
>  }
>  
> +/**
> + * qcom_scm_call() - Invoke a syscall in the secure world
> + * @dev:	device
> + * @svc_id:	service identifier
> + * @cmd_id:	command identifier
> + * @desc:	Descriptor structure containing arguments and return values
> + *
> + * Sends a command to the SCM and waits for the command to finish processing.
> + * This should *only* be called in pre-emptible context.
> + */
> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +			 const struct qcom_scm_desc *desc,
> +			 struct arm_smccc_res *res)
> +{
> +	return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, false);
> +}
> +
> +/**
> + * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
> + * @dev:	device
> + * @svc_id:	service identifier
> + * @cmd_id:	command identifier
> + * @desc:	Descriptor structure containing arguments and return values
> + * @res:	Structure containing results from SMC/HVC call
> + *
> + * Sends a command to the SCM and waits for the command to finish processing.
> + * This should be called in atomic context only.
> + */
> +static int qcom_scm_call_atomic(struct device *dev, u32 svc_id, u32 cmd_id,
> +				const struct qcom_scm_desc *desc,
> +				struct arm_smccc_res *res)
> +{
> +	return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, true);
> +}
> +
>  /**
>   * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
>   * @entry: Entry point function for the cpus
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
