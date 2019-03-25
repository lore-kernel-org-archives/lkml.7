Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF5BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E8720850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U9pqkt4T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hw0egklQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfCYEDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:03:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48236 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfCYEDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:03:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D616607C6; Mon, 25 Mar 2019 04:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553486586;
        bh=Z94ZkmDZiKq9xJSJAYdw1e9rY0F2pjJZrVpDrfKoo/8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U9pqkt4TfqLUBnFCMO+ne/KAEY1Njp4AuDM0FiscXXVeopRr3KptOj5e2rM7T7MxU
         UbxTWuvoCAUJ122d1ZSVDllHcE3/kxpC1pzj0sYmNx1kr/S87c27WGoh6g1uw+rpf+
         M0PQM/NyX5pIIXC/AYiTlQFqUlSJtV63gNumhtEU=
Received: from [10.79.128.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BED860712;
        Mon, 25 Mar 2019 04:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553486585;
        bh=Z94ZkmDZiKq9xJSJAYdw1e9rY0F2pjJZrVpDrfKoo/8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hw0egklQXq/RnKgjiA3m/BklE8OE0FOYCLJVTZo/wjnXfnHlp8IlI5ehF6iU3peh7
         gqLrz55tAQN5mJSA8/cn38AEBwynWDPUdGINM5sjVkEajKF8l0DUFFhItwHs1SfS/W
         VjNWcc1Rm2vCVRuww4/z4tlhH/MqjgiVXpGco6zo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BED860712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 1/9] soc: qcom: rpmpd: fixup rpmpd set performance
 state
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, andy.gross@linaro.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190324175007.29040-1-sibis@codeaurora.org>
 <20190324175007.29040-2-sibis@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <a224821a-6e28-cea5-9928-440f5e132460@codeaurora.org>
Date:   Mon, 25 Mar 2019 09:33:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190324175007.29040-2-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/2019 11:19 PM, Sibi Sankar wrote:
> Fixup rpmpd state to max if the required state is greater than all the
> supported states.

This should also say why, 'so the clients which just want to vote on whatever
is the max state supported can do so by passing an INT_MAX'?

> 
> Fixes: 075d3db8d10d ("Add support for the .set_performace_state() and
> .opp_to_performance_state()")
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>   drivers/soc/qcom/rpmpd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 005326050c23..235d01870dd8 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -226,7 +226,7 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
>   	struct rpmpd *pd = domain_to_rpmpd(domain);
>   
>   	if (state > MAX_RPMPD_STATE)
> -		goto out;
> +		state = MAX_RPMPD_STATE;
>   
>   	mutex_lock(&rpmpd_lock);
>   
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
