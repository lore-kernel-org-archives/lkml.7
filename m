Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F45C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5318224E9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PuAAnneq";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="dFHrosy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfKTMQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:16:20 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:53224
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728251AbfKTMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574252177;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=wCK/Mhv6+MPpzpwecCGuCIsJ5GPUJ1lQqLatlAEBhTA=;
        b=PuAAnneq4FyreSZ7zXqRJmEZvIN3YPuk7WFlCvZr61fM7vyC+A5COFRi+VUEgWus
        V5XS0vd5VSp7ydz0d9RgW/El1hlj1NsqaTGjPnlsDZDdTiqeBLijVUe7FJn6tEfj/Hp
        hm+CDC7/PkWXxwu+/7iqfaRaVnQSotCzgZsYiCUc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574252177;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=wCK/Mhv6+MPpzpwecCGuCIsJ5GPUJ1lQqLatlAEBhTA=;
        b=dFHrosy32IFJcpLhdx/wgf37DYgLQCkqcF7q5O2Q2yZRdxMypxpbW1jNhJscsALJ
        VUsIXiHMymKU54XSlW2TzJn+SrJ7XEPcuwH5ERxdrZJgLOFOyHft+3msvtHg2w0XTvp
        gIa/0PR2ixzbVPXqA1ELPte2byjvbn1INRheOrZU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Nov 2019 12:16:17 +0000
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        swboyd@chromium.org, dianders@chromium.org
Subject: Re: [PATCH 3/6] soc: qcom: rpmhpd: Add SM8150 RPMH power-domains
In-Reply-To: <896c7edd-c511-3cdf-7281-01c894facc3b@codeaurora.org>
References: <20191118173944.27043-1-sibis@codeaurora.org>
 <0101016e7f99b99a-e1a501f1-823e-4ede-86ad-f517323c5014-000000@us-west-2.amazonses.com>
 <896c7edd-c511-3cdf-7281-01c894facc3b@codeaurora.org>
Message-ID: <0101016e88bde8d4-1c46c597-3795-49d9-a651-daf78a789b81-000000@us-west-2.amazonses.com>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.11.20-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-20 09:32, Rajendra Nayak wrote:
> On 11/18/2019 11:10 PM, Sibi Sankar wrote:
>> Add support for cx/mx/gfx/mss/ebi/mmcx power-domains found on
>> SM8150 SoCs.
> 
> lmx/lcx also?

yes will fix it

> 
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
> 
> Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
> 
>>   drivers/soc/qcom/rpmhpd.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>> 
>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>> index 51850cc68b701..3b109ee67a4d2 100644
>> --- a/drivers/soc/qcom/rpmhpd.c
>> +++ b/drivers/soc/qcom/rpmhpd.c
>> @@ -131,8 +131,44 @@ static const struct rpmhpd_desc sdm845_desc = {
>>   	.num_pds = ARRAY_SIZE(sdm845_rpmhpds),
>>   };
>>   +/* SM8150 RPMH powerdomains */
>> +
>> +static struct rpmhpd sm8150_mmcx_ao;
>> +static struct rpmhpd sm8150_mmcx = {
>> +	.pd = { .name = "mmcx", },
>> +	.peer = &sm8150_mmcx_ao,
>> +	.res_name = "mmcx.lvl",
>> +};
>> +
>> +static struct rpmhpd sm8150_mmcx_ao = {
>> +	.pd = { .name = "mmcx_ao", },
>> +	.active_only = true,
>> +	.peer = &sm8150_mmcx,
>> +	.res_name = "mmcx.lvl",
>> +};
>> +
>> +static struct rpmhpd *sm8150_rpmhpds[] = {
>> +	[SM8150_MSS] = &sdm845_mss,
>> +	[SM8150_EBI] = &sdm845_ebi,
>> +	[SM8150_LMX] = &sdm845_lmx,
>> +	[SM8150_LCX] = &sdm845_lcx,
>> +	[SM8150_GFX] = &sdm845_gfx,
>> +	[SM8150_MX] = &sdm845_mx,
>> +	[SM8150_MX_AO] = &sdm845_mx_ao,
>> +	[SM8150_CX] = &sdm845_cx,
>> +	[SM8150_CX_AO] = &sdm845_cx_ao,
>> +	[SM8150_MMCX] = &sm8150_mmcx,
>> +	[SM8150_MMCX_AO] = &sm8150_mmcx_ao,
>> +};
>> +
>> +static const struct rpmhpd_desc sm8150_desc = {
>> +	.rpmhpds = sm8150_rpmhpds,
>> +	.num_pds = ARRAY_SIZE(sm8150_rpmhpds),
>> +};
>> +
>>   static const struct of_device_id rpmhpd_match_table[] = {
>>   	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
>> +	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
>>   	{ }
>>   };
>> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
