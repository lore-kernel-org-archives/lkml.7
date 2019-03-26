Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A29C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66BD213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nk8W++yU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f0Uz1mhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfCZICy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:02:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37236 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCZICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:02:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2ADA60E3E; Tue, 26 Mar 2019 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553587372;
        bh=bPZgnP6vm8+OXqQdN9iVydPzpTvJ4cUhesDJi46cZJk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nk8W++yUvrrA5rP+UL/XapiiW153v79F+hp5TTnrIbCUGETsDB3wuBDAYDvLGXoLs
         mubYc4on/wCtVikGPoYCXNeu+6sEJr70eCRPr11Ap4DSN/VUY/RuFwTKGRHUrz8F43
         det2zYiB387xlrJnOtgq5kr2BWurMKREED+cKzlI=
Received: from [10.131.114.79] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6811160DAA;
        Tue, 26 Mar 2019 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553587371;
        bh=bPZgnP6vm8+OXqQdN9iVydPzpTvJ4cUhesDJi46cZJk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f0Uz1mhFalqnZDiyMTGJW6Hdi9Qu6G2ilJGlRokxsMIGzuaaum21ipKGl5nMmu7Mk
         dOprlSc/RzdNxJCl7ZMVGSEhf5H4efcJ+4GFHanmyAYtER9x5aZmQJ3O3h1t8Vq5wB
         ba277nSm6gReJ5iNewCYnWekeRWt9nfexTjmARfg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6811160DAA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v2 1/4] firmware: qcom_scm-64: Add atomic version of
 qcom_scm_call
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, david.brown@linaro.org,
        tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180910062551.28175-2-vivek.gautam@codeaurora.org>
 <20190325210925.GA2899@builder>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <21b0deec-8663-6b59-52e4-6fe568834eb8@codeaurora.org>
Date:   Tue, 26 Mar 2019 13:32:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325210925.GA2899@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2019 2:39 AM, Bjorn Andersson wrote:
> On Sun 09 Sep 23:25 PDT 2018, Vivek Gautam wrote:
>
>> There are scnenarios where drivers are required to make a
>> scm call in atomic context, such as in one of the qcom's
>> arm-smmu-500 errata [1].
>>
>> [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/
>>        tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842")
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Thanks Bjorn for reviewing and testing this series.
I will repost the series on latest head.

Best regards
Vivek

>
> Regards,
> Bjorn
>
>> ---
>>   drivers/firmware/qcom_scm-64.c | 136 ++++++++++++++++++++++++++++-------------
>>   1 file changed, 92 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
>> index 688525dd4aee..3a8c867cdf51 100644
>> --- a/drivers/firmware/qcom_scm-64.c
>> +++ b/drivers/firmware/qcom_scm-64.c
>> @@ -70,32 +70,71 @@ static DEFINE_MUTEX(qcom_scm_lock);
>>   #define FIRST_EXT_ARG_IDX 3
>>   #define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
>>   
>> -/**
>> - * qcom_scm_call() - Invoke a syscall in the secure world
>> - * @dev:	device
>> - * @svc_id:	service identifier
>> - * @cmd_id:	command identifier
>> - * @desc:	Descriptor structure containing arguments and return values
>> - *
>> - * Sends a command to the SCM and waits for the command to finish processing.
>> - * This should *only* be called in pre-emptible context.
>> -*/
>> -static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>> -			 const struct qcom_scm_desc *desc,
>> -			 struct arm_smccc_res *res)
>> +static void __qcom_scm_call_do(const struct qcom_scm_desc *desc,
>> +			       struct arm_smccc_res *res, u32 fn_id,
>> +			       u64 x5, u32 type)
>> +{
>> +	u64 cmd;
>> +	struct arm_smccc_quirk quirk = {.id = ARM_SMCCC_QUIRK_QCOM_A6};
>> +
>> +	cmd = ARM_SMCCC_CALL_VAL(type, qcom_smccc_convention,
>> +				 ARM_SMCCC_OWNER_SIP, fn_id);
>> +
>> +	quirk.state.a6 = 0;
>> +
>> +	do {
>> +		arm_smccc_smc_quirk(cmd, desc->arginfo, desc->args[0],
>> +				    desc->args[1], desc->args[2], x5,
>> +				    quirk.state.a6, 0, res, &quirk);
>> +
>> +		if (res->a0 == QCOM_SCM_INTERRUPTED)
>> +			cmd = res->a0;
>> +
>> +	} while (res->a0 == QCOM_SCM_INTERRUPTED);
>> +}
>> +
>> +static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
>> +			     struct arm_smccc_res *res, u32 fn_id,
>> +			     u64 x5, bool atomic)
>> +{
>> +	int retry_count = 0;
>> +
>> +	if (!atomic) {
>> +		do {
>> +			mutex_lock(&qcom_scm_lock);
>> +
>> +			__qcom_scm_call_do(desc, res, fn_id, x5,
>> +					   ARM_SMCCC_STD_CALL);
>> +
>> +			mutex_unlock(&qcom_scm_lock);
>> +
>> +			if (res->a0 == QCOM_SCM_V2_EBUSY) {
>> +				if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
>> +					break;
>> +				msleep(QCOM_SCM_EBUSY_WAIT_MS);
>> +			}
>> +		}  while (res->a0 == QCOM_SCM_V2_EBUSY);
>> +	} else {
>> +		__qcom_scm_call_do(desc, res, fn_id, x5, ARM_SMCCC_FAST_CALL);
>> +	}
>> +}
>> +
>> +static int ___qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>> +			    const struct qcom_scm_desc *desc,
>> +			    struct arm_smccc_res *res, bool atomic)
>>   {
>>   	int arglen = desc->arginfo & 0xf;
>> -	int retry_count = 0, i;
>> +	int i;
>>   	u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
>> -	u64 cmd, x5 = desc->args[FIRST_EXT_ARG_IDX];
>> +	u64 x5 = desc->args[FIRST_EXT_ARG_IDX];
>>   	dma_addr_t args_phys = 0;
>>   	void *args_virt = NULL;
>>   	size_t alloc_len;
>> -	struct arm_smccc_quirk quirk = {.id = ARM_SMCCC_QUIRK_QCOM_A6};
>> +	gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
>>   
>>   	if (unlikely(arglen > N_REGISTER_ARGS)) {
>>   		alloc_len = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
>> -		args_virt = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
>> +		args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
>>   
>>   		if (!args_virt)
>>   			return -ENOMEM;
>> @@ -125,33 +164,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>>   		x5 = args_phys;
>>   	}
>>   
>> -	do {
>> -		mutex_lock(&qcom_scm_lock);
>> -
>> -		cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
>> -					 qcom_smccc_convention,
>> -					 ARM_SMCCC_OWNER_SIP, fn_id);
>> -
>> -		quirk.state.a6 = 0;
>> -
>> -		do {
>> -			arm_smccc_smc_quirk(cmd, desc->arginfo, desc->args[0],
>> -				      desc->args[1], desc->args[2], x5,
>> -				      quirk.state.a6, 0, res, &quirk);
>> -
>> -			if (res->a0 == QCOM_SCM_INTERRUPTED)
>> -				cmd = res->a0;
>> -
>> -		} while (res->a0 == QCOM_SCM_INTERRUPTED);
>> -
>> -		mutex_unlock(&qcom_scm_lock);
>> -
>> -		if (res->a0 == QCOM_SCM_V2_EBUSY) {
>> -			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
>> -				break;
>> -			msleep(QCOM_SCM_EBUSY_WAIT_MS);
>> -		}
>> -	}  while (res->a0 == QCOM_SCM_V2_EBUSY);
>> +	qcom_scm_call_do(desc, res, fn_id, x5, atomic);
>>   
>>   	if (args_virt) {
>>   		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
>> @@ -164,6 +177,41 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * qcom_scm_call() - Invoke a syscall in the secure world
>> + * @dev:	device
>> + * @svc_id:	service identifier
>> + * @cmd_id:	command identifier
>> + * @desc:	Descriptor structure containing arguments and return values
>> + *
>> + * Sends a command to the SCM and waits for the command to finish processing.
>> + * This should *only* be called in pre-emptible context.
>> + */
>> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>> +			 const struct qcom_scm_desc *desc,
>> +			 struct arm_smccc_res *res)
>> +{
>> +	return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, false);
>> +}
>> +
>> +/**
>> + * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
>> + * @dev:	device
>> + * @svc_id:	service identifier
>> + * @cmd_id:	command identifier
>> + * @desc:	Descriptor structure containing arguments and return values
>> + * @res:	Structure containing results from SMC/HVC call
>> + *
>> + * Sends a command to the SCM and waits for the command to finish processing.
>> + * This should be called in atomic context only.
>> + */
>> +static int qcom_scm_call_atomic(struct device *dev, u32 svc_id, u32 cmd_id,
>> +				const struct qcom_scm_desc *desc,
>> +				struct arm_smccc_res *res)
>> +{
>> +	return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, true);
>> +}
>> +
>>   /**
>>    * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
>>    * @entry: Entry point function for the cpus
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>
