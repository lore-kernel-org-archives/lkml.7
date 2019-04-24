Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB49B218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Awl8eUGD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J4J3W0bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfDXKFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:05:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDXKFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:05:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D81060734; Wed, 24 Apr 2019 10:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556100313;
        bh=1iP53itJVqukv9e44JvGELtHuaJvsw88o2Ix6301OOQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Awl8eUGDVrqhdzOXNPuXYs96dK6oRzlZSCyqTn2I/xU8OjcqSEarqR6lSay3sYh/b
         nmebdYyvMf4WYAz7F+Cr6qh5zUYIRi8sYBT8m3uT41Pm3KY92M72CJ7RfCk1/KjrrP
         iXmZKvKf1+VG2T5wSXlYMM7b4xfGt0HbFrsadl+c=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08BD26021C;
        Wed, 24 Apr 2019 10:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556100312;
        bh=1iP53itJVqukv9e44JvGELtHuaJvsw88o2Ix6301OOQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J4J3W0bHlA3buYpNG7qxsWQOM1sET2hI+Z1jnbVq7wzRUQaRiZAin1wazcudkXOMS
         Q7h/ICvlLE1YRA/g/vhLcm7IecnKHMLffEQpsOFGCVX/y8AaK91wzz9jfi77BbaeaE
         6ASwF90978P7NyEsStTv8tgmF588L0yLZ3u2VBm8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08BD26021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 4/5] OPP: Update the bandwidth on OPP frequency changes
To:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-5-georgi.djakov@linaro.org>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <7b0e014e-f6dd-bcc8-9f96-0d589e284bff@codeaurora.org>
Date:   Wed, 24 Apr 2019 15:35:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190423132823.7915-5-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Georgi,

On 4/23/19 6:58 PM, Georgi Djakov wrote:
> If the OPP bandwidth values are populated, we want to switch also the
> interconnect bandwidth in addition to frequency and voltage.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/opp/core.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 97ee39ecdebd..91d1c2abfb3e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -707,7 +707,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>   	unsigned long freq, old_freq;
>   	struct dev_pm_opp *old_opp, *opp;
>   	struct clk *clk;
> -	int ret;
> +	int ret, i;
>   
>   	if (unlikely(!target_freq)) {
>   		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
> @@ -780,6 +780,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>   		ret = _generic_set_opp_clk_only(dev, clk, freq);
>   	}
>   
> +	if (!ret && !IS_ERR_OR_NULL(opp_table->paths)) {
> +		for (i = 0; i < opp_table->path_count; i++) {
> +			icc_set_bw(opp_table->paths[i], opp->bandwidth[i].avg,
> +				   opp->bandwidth[i].peak);
> +		}
> +	}

An helper funcion dev_pm_opp_set_bw() would be needed by devices that
use alternative ways of scaling like "qcom-cpufreq-hw". I can probably
do that when I get ddr scaling working on sdm845 with your series.

> +
>   	/* Scaling down? Configure required OPPs after frequency */
>   	if (!ret && freq < old_freq) {
>   		ret = _set_required_opps(dev, opp_table, opp);
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
