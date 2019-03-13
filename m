Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68792184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BKV3KLc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCMKaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:30:46 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6589 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfCMKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:30:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88dbd40000>; Wed, 13 Mar 2019 03:30:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 03:30:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 03:30:45 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 10:30:43 +0000
Subject: Re: [PATCH v2 2/2] bus: tegra-aconnect: add system sleep callbacks
To:     Sameer Pujar <spujar@nvidia.com>, <treding@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
 <1552452119-6574-2-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c7b1e930-238b-5943-9732-64246b9ffb7b@nvidia.com>
Date:   Wed, 13 Mar 2019 10:30:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552452119-6574-2-git-send-email-spujar@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552473044; bh=5EthRL8pJEKOJg1lHETIWhZP35/CXQKm9y2eNXtGCog=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BKV3KLc5t/+vvvQeCxDJmMfkcBZUjofY/pDo4RKJJ+9HCcZNA6w666J1307Xa+BfF
         YPPa++1u7m/eVarzZOIJkMr7n5HGe9WwirLLv76IGSNE4drXbQc0CsuZyg/du0Jd60
         3pEk7DIx30N8kNNNKciTxTqd5BbXWHZFh0JgVjmrvOZwyTx+aFwjIxxP5yWw2ZSs88
         v4OF9Hk7VAgpKPwCoeVr8uK7PYi+3B4cGXvJGqe91gCrVzyxxAs1HR/oroD2tdoNPo
         SDQ42h5sOOxQkkpnyYyCM2vJGDxE6Sug4MRvrhWHJACtLQjB5ynxRUS1qqrYQD95Ng
         qV5L11BCiSJ9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/03/2019 04:41, Sameer Pujar wrote:
> pm_runtime_force_suspend() and pm_runtime_force_resume() are used as system
> sleep noirq suspend and resume callbacks. If the driver is active till late
> suspend, where runtime PM cannot run, force suspend is essential for the
> device. This makes sure that the device is put into low power state during
> system wide PM transitions to sleep states.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/bus/tegra-aconnect.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bus/tegra-aconnect.c b/drivers/bus/tegra-aconnect.c
> index 9349157..ac58142 100644
> --- a/drivers/bus/tegra-aconnect.c
> +++ b/drivers/bus/tegra-aconnect.c
> @@ -94,6 +94,8 @@ static int tegra_aconnect_runtime_suspend(struct device *dev)
>  static const struct dev_pm_ops tegra_aconnect_pm_ops = {
>  	SET_RUNTIME_PM_OPS(tegra_aconnect_runtime_suspend,
>  			   tegra_aconnect_runtime_resume, NULL)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				      pm_runtime_force_resume)
>  };
>  
>  static const struct of_device_id tegra_aconnect_of_match[] = {

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
