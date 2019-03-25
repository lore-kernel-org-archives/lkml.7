Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212FD20872
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fAbc3p+n";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bhP4rX21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCYEG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:06:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfCYEG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:06:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04250602F8; Mon, 25 Mar 2019 04:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553486785;
        bh=xSIemBEqmDWV8Rhrbu3xWO8WPZje/xzXz2fyfh2XZ4I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fAbc3p+ndnJVha0WScUdNMdtp91UCNqjCqAX6tQMUQOyBBj6p7aWzmOR1bSGP5UDM
         LPIErfFvUvm7Z2hA0IzxC1YQBy0aFaeAwjIO3EJcNkDBQv5Gab8qvOHJOIJ+zAOc/6
         LJj4W8D9bfZhPPNJ24u28AQ13q/jlNcAgCNdji90=
Received: from [10.79.128.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC914602F8;
        Mon, 25 Mar 2019 04:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553486784;
        bh=xSIemBEqmDWV8Rhrbu3xWO8WPZje/xzXz2fyfh2XZ4I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bhP4rX21cG1c7FzTvaCIPrdNSi6YHhF0x2wo/2Myg6IWoOsgDXYj21Hnha1x2V8Ua
         m0hb5bX3W+viZJ7NWTP4ADHhX0exhliSZOcNHkLUPsQJGA+A0+GsJuH6DoEEkQQNBh
         yHX6EXDexDQZB7lRcXPohg3MZvnuOh8HdltASz1s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC914602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 2/9] soc: qcom: rpmpd: Add support to set rpmpd state
 to max
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, andy.gross@linaro.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190324175007.29040-1-sibis@codeaurora.org>
 <20190324175007.29040-3-sibis@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <696866e5-740a-f7b0-5193-f79b5c1e908c@codeaurora.org>
Date:   Mon, 25 Mar 2019 09:36:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190324175007.29040-3-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/2019 11:20 PM, Sibi Sankar wrote:
> Add support to set rpmpd state to max across SoCs.

Changelog could be better, 'rpmpd max state varies across SoCs
and SoC families, add support in the driver to make it SoC/SoC
family specific'

> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>   drivers/soc/qcom/rpmpd.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 235d01870dd8..71fdfafad2ea 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -83,12 +83,14 @@ struct rpmpd {
>   	const int res_type;
>   	const int res_id;
>   	struct qcom_smd_rpm *rpm;
> +	unsigned int max_state;
>   	__le32 key;
>   };
>   
>   struct rpmpd_desc {
>   	struct rpmpd **rpmpds;
>   	size_t num_pds;
> +	unsigned int max_state;
>   };
>   
>   static DEFINE_MUTEX(rpmpd_lock);
> @@ -114,6 +116,7 @@ static struct rpmpd *msm8996_rpmpds[] = {
>   static const struct rpmpd_desc msm8996_desc = {
>   	.rpmpds = msm8996_rpmpds,
>   	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
> +	.max_state = MAX_RPMPD_STATE,

Maybe this needs to be renamed to avoid confusion, MAX_8996_RPMPD_STATE?

>   };
>   
>   static const struct of_device_id rpmpd_match_table[] = {
> @@ -225,8 +228,8 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
>   	int ret = 0;
>   	struct rpmpd *pd = domain_to_rpmpd(domain);
>   
> -	if (state > MAX_RPMPD_STATE)
> -		state = MAX_RPMPD_STATE;
> +	if (state > pd->max_state)
> +		state = pd->max_state;
>   
>   	mutex_lock(&rpmpd_lock);
>   
> @@ -287,6 +290,7 @@ static int rpmpd_probe(struct platform_device *pdev)
>   		}
>   
>   		rpmpds[i]->rpm = rpm;
> +		rpmpds[i]->max_state = desc->max_state;
>   		rpmpds[i]->pd.power_off = rpmpd_power_off;
>   		rpmpds[i]->pd.power_on = rpmpd_power_on;
>   		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
