Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40259C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CA72087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KF2pw/oJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="awkpOm+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfC0N21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:28:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfC0N21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:28:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2693A6115B; Wed, 27 Mar 2019 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553693305;
        bh=nqDxPyi+v79rOFWgmnEUwEMTQ66Vm9Bb628rNt1wi2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KF2pw/oJ5wriG8t/HxeB4LL+e0/6A+k6sRB3vwkAH1Cv2WKAV8JILZuXDHWkfRgFG
         2H0KkrDFh8uGa6vgUYdwDBrEw6ltvV4CDNT0ZI92SzsbYc1oQJJHfvbasGuZf7RLXi
         NgUQ6gGItZozHhkzaFWF5q5gSxPhi2gr5g0CdzV0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 110FD60A44;
        Wed, 27 Mar 2019 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553693303;
        bh=nqDxPyi+v79rOFWgmnEUwEMTQ66Vm9Bb628rNt1wi2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=awkpOm+VUHu31O97fmRvgKsqraOj8tLiFYG+7myqa5xyoDYH3jgwlW9DPlOzuRtHv
         fiQtfd2gbgX1f7ViNZDeJrXnu59yRPp43aDASogL14fPZnokDfL/MhKgG62pa7UW2K
         vhUKPeSL8uIUpFTkI0XpqP1KxIce5iZrl2LayC24=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Mar 2019 18:58:22 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 3/9] soc: qcom: rpmpd: Modify corner defining macros
In-Reply-To: <6d1453af-b01f-9e5a-4c9a-b2af00d1f05f@codeaurora.org>
References: <20190324175007.29040-1-sibis@codeaurora.org>
 <20190324175007.29040-4-sibis@codeaurora.org>
 <6d1453af-b01f-9e5a-4c9a-b2af00d1f05f@codeaurora.org>
Message-ID: <0a3a6d819078cad74468c018efea586e@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-25 09:37, Rajendra Nayak wrote:
> On 3/24/2019 11:20 PM, Sibi Sankar wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>> 
>> QCS404 uses individual resource type magic for each power-domain, so
>> adjust the macros slightly to make them reusable for this.
>> 
>> [sibi: Extend rpmpd corner pair to a generic rpmpd pair]
> 
> This needs to be right above your SoB I think.

will re-order them in v3

> 
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   drivers/soc/qcom/rpmpd.c | 39 
>> +++++++++++++++++----------------------
>>   1 file changed, 17 insertions(+), 22 deletions(-)
>> 
>> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
>> index 71fdfafad2ea..17cd59d1ac3b 100644
>> --- a/drivers/soc/qcom/rpmpd.c
>> +++ b/drivers/soc/qcom/rpmpd.c
>> @@ -17,8 +17,8 @@
>>   #define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, 
>> pd)
>>     /* Resource types */
>> -#define RPMPD_SMPA 0x61706d73
>> -#define RPMPD_LDOA 0x616f646c
>> +#define RPMPD_SMPA 0x61706d73 /* smpa */
>> +#define RPMPD_LDOA 0x616f646c /* ldoa */
>>     /* Operation Keys */
>>   #define KEY_CORNER		0x6e726f63 /* corn */
>> @@ -27,46 +27,41 @@
>>     #define MAX_RPMPD_STATE		6
>>   -#define DEFINE_RPMPD_CORNER_SMPA(_platform, _name, _active, 
>> r_id)		\
>> +#define DEFINE_RPMPD_PAIR(_platform, _name, _active, r_type, r_key,	\
>> +			  r_id)						\
>>   	static struct rpmpd _platform##_##_active;			\
>>   	static struct rpmpd _platform##_##_name = {			\
>>   		.pd = {	.name = #_name,	},				\
>>   		.peer = &_platform##_##_active,				\
>> -		.res_type = RPMPD_SMPA,					\
>> +		.res_type = RPMPD_##r_type,				\
>>   		.res_id = r_id,						\
>> -		.key = KEY_CORNER,					\
>> +		.key = KEY_##r_key,					\
>>   	};								\
>>   	static struct rpmpd _platform##_##_active = {			\
>>   		.pd = { .name = #_active, },				\
>>   		.peer = &_platform##_##_name,				\
>>   		.active_only = true,					\
>> -		.res_type = RPMPD_SMPA,					\
>> +		.res_type = RPMPD_##r_type,				\
>>   		.res_id = r_id,						\
>> -		.key = KEY_CORNER,					\
>> +		.key = KEY_##r_key,					\
>>   	}
>>   -#define DEFINE_RPMPD_CORNER_LDOA(_platform, _name, r_id)			\
>> +#define DEFINE_RPMPD_CORNER(_platform, _name, r_type, r_id)		\
>>   	static struct rpmpd _platform##_##_name = {			\
>>   		.pd = { .name = #_name, },				\
>> -		.res_type = RPMPD_LDOA,					\
>> +		.res_type = RPMPD_##r_type,				\
>>   		.res_id = r_id,						\
>>   		.key = KEY_CORNER,					\
>>   	}
>>   -#define DEFINE_RPMPD_VFC(_platform, _name, r_id, r_type)		\
>> +#define DEFINE_RPMPD_VFC(_platform, _name, r_type, r_id)		\
>>   	static struct rpmpd _platform##_##_name = {			\
>>   		.pd = { .name = #_name, },				\
>> -		.res_type = r_type,					\
>> +		.res_type = RPMPD_##r_type,				\
>>   		.res_id = r_id,						\
>>   		.key = KEY_FLOOR_CORNER,				\
>>   	}
>>   -#define DEFINE_RPMPD_VFC_SMPA(_platform, _name, r_id)			\
>> -	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_SMPA)
>> -
>> -#define DEFINE_RPMPD_VFC_LDOA(_platform, _name, r_id)			\
>> -	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_LDOA)
>> -
>>   struct rpmpd_req {
>>   	__le32 key;
>>   	__le32 nbytes;
>> @@ -96,12 +91,12 @@ struct rpmpd_desc {
>>   static DEFINE_MUTEX(rpmpd_lock);
>>     /* msm8996 RPM Power domains */
>> -DEFINE_RPMPD_CORNER_SMPA(msm8996, vddcx, vddcx_ao, 1);
>> -DEFINE_RPMPD_CORNER_SMPA(msm8996, vddmx, vddmx_ao, 2);
>> -DEFINE_RPMPD_CORNER_LDOA(msm8996, vddsscx, 26);
>> +DEFINE_RPMPD_PAIR(msm8996, vddcx, vddcx_ao, SMPA, CORNER, 1);
>> +DEFINE_RPMPD_PAIR(msm8996, vddmx, vddmx_ao, SMPA, CORNER, 2);
>> +DEFINE_RPMPD_CORNER(msm8996, vddsscx, LDOA, 26);
>>   -DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
>> -DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
>> +DEFINE_RPMPD_VFC(msm8996, vddcx_vfc, SMPA, 1);
>> +DEFINE_RPMPD_VFC(msm8996, vddsscx_vfc, LDOA, 26);
>>     static struct rpmpd *msm8996_rpmpds[] = {
>>   	[MSM8996_VDDCX] =	&msm8996_vddcx,
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
