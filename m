Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77652C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494952173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C+nJPyP7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C+nJPyP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfGPPOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:14:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfGPPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:14:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8ED53615E6; Tue, 16 Jul 2019 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563290070;
        bh=ZYSdtIgK50Fu8oOMNcEQi3EqXqQBz3umfj8a01IRyDc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=C+nJPyP7E6v1WXDdIKCNPaT13FE7yk6c6zBAMe/rbzJCwwOl7hM4v+x5R1e4G3qvn
         vLCk/IoI+KLvaN7v9JvGjTZE21iHvVzb/sr/JXgOoRtfI0kFh2ZhSZN2MIl48t4TP/
         VYDL812Wz1MNKzH5F8aDxQbRmaqtsiqudi2FBdNo=
Received: from [10.79.43.230] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A076360364
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563290070;
        bh=ZYSdtIgK50Fu8oOMNcEQi3EqXqQBz3umfj8a01IRyDc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=C+nJPyP7E6v1WXDdIKCNPaT13FE7yk6c6zBAMe/rbzJCwwOl7hM4v+x5R1e4G3qvn
         vLCk/IoI+KLvaN7v9JvGjTZE21iHvVzb/sr/JXgOoRtfI0kFh2ZhSZN2MIl48t4TP/
         VYDL812Wz1MNKzH5F8aDxQbRmaqtsiqudi2FBdNo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A076360364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 1/4] OPP: Allow required-opps even if the device
 doesn't have power-domains
To:     linux-kernel@vger.kernel.org
References: <20190625213337.157525-1-saravanak@google.com>
 <20190625213337.157525-2-saravanak@google.com>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <397f6d91-7093-f4f1-06ee-5f6798561cb5@codeaurora.org>
Date:   Tue, 16 Jul 2019 20:44:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625213337.157525-2-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Saravana,
Thanks for taking time to post out this series.

On 6/26/19 3:03 AM, Saravana Kannan wrote:
> A Device-A can have a (minimum) performance requirement on another
> Device-B to be able to function correctly. This performance requirement
> on Device-B can also change based on the current performance level of
> Device-A.
> 
> The existing required-opps feature fits well to describe this need. So,
> instead of limiting required-opps to point to only PM-domain devices,
> allow it to point to any device.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   drivers/opp/core.c |  2 +-
>   drivers/opp/of.c   | 14 --------------
>   2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0e7703fe733f..74c7bdc6f463 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -710,7 +710,7 @@ static int _set_required_opps(struct device *dev,
>   		return 0;
>   
>   	/* Single genpd case */
> -	if (!genpd_virt_devs) {
> +	if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {

https://patchwork.kernel.org/patch/10940671/
This was already removed as a part of ^^ and is in linux-next.

>   		pstate = opp->required_opps[0]->pstate;
>   		ret = dev_pm_genpd_set_performance_state(dev, pstate);
>   		if (ret) {
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c10c782d15aa..7c8336e94aff 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -195,9 +195,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>   	 */
>   	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
>   					      "#power-domain-cells");
> -	if (!count_pd)
> -		goto put_np;
> -
>   	if (count_pd > 1) {
>   		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
>   					GFP_KERNEL);
> @@ -226,17 +223,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>   
>   		if (IS_ERR(required_opp_tables[i]))
>   			goto free_required_tables;
> -
> -		/*
> -		 * We only support genpd's OPPs in the "required-opps" for now,
> -		 * as we don't know how much about other cases. Error out if the
> -		 * required OPP doesn't belong to a genpd.
> -		 */
> -		if (!required_opp_tables[i]->is_genpd) {
> -			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> -				required_np);
> -			goto free_required_tables;
> -		}

I expect the series to not work as is in its current state since I
see a circular dependency here. The required-opp tables of the parent
devfreq won't be populated until we add the opp-table of the child 
devfreq node while the child devfreq using passive governor would
return -EPROBE_DEFER until the parent devfreq probes.

The same applies to this patch -> https://patchwork.kernel.org/patch
/11046147/ I posted out based on your series. So we would probably have
to address the dependency here.

>   	}
>   
>   	goto put_np;
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
