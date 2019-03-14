Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D108C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A38E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EKZ6EDw3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R4aZ0hg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfCNFcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:32:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfCNFcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:32:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E5FB60909; Thu, 14 Mar 2019 05:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552541555;
        bh=pxermHq6zXeNhOFIdRTWlt/5Pj8meTaPBvybhvwtFMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EKZ6EDw3Ap/lvcq0Zq+7abMy0DPafGXsX7TGGg/auXn5/amD+odauCHtO62DkrXYf
         1UprJQksIGfxWued0m2m4SmE55gIsW2heS1tyc53ms6ntrluuWu4HIwVcqJMQC5z/S
         sbt4QsXYeUYZRV3ZdBXRWX2xB4JXrbnZdXeqOnZk=
Received: from [10.206.25.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: riteshh@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5C7660909;
        Thu, 14 Mar 2019 05:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552541554;
        bh=pxermHq6zXeNhOFIdRTWlt/5Pj8meTaPBvybhvwtFMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R4aZ0hg5n5n/ZKW26RTxt4hSav7zmH8Y5NXObxCbcTWhsBrTf/5zE5qj9BDxfh+xB
         j6QvA9dEg7M9eJsxhsRLKmCujta5TwbQJ1lZNIezh45QsB6YdoyHw8OTyW2gG1MH08
         S0H3NPnm4Z9xckqTx3gz9ASigVNjIw+w5nDxVz0I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5C7660909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=riteshh@codeaurora.org
Subject: Re: [PATCH V3 06/10] mmc: cqhci: allow hosts to update dcmd cmd desc
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-6-git-send-email-skomatineni@nvidia.com>
From:   Ritesh Harjani <riteshh@codeaurora.org>
Message-ID: <8a90c2e5-fd0a-9ea3-59a5-c237c0003a3b@codeaurora.org>
Date:   Thu, 14 Mar 2019 11:02:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1552513552-23423-6-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/2019 3:15 AM, Sowjanya Komatineni wrote:
> This patch adds update_dcmd_desc interface to cqhci_host_ops to
> allow hosts to update any of the DCMD task descriptor attributes
> and parameters.
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Thanks,

Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>

> ---
>   drivers/mmc/host/cqhci.c | 2 ++
>   drivers/mmc/host/cqhci.h | 2 ++
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index a8af682a9182..d59cb0a51964 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -537,6 +537,8 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
>   		 CQHCI_ACT(0x5) |
>   		 CQHCI_CMD_INDEX(mrq->cmd->opcode) |
>   		 CQHCI_CMD_TIMING(timing) | CQHCI_RESP_TYPE(resp_type));
> +	if (cq_host->ops->update_dcmd_desc)
> +		cq_host->ops->update_dcmd_desc(mmc, mrq, &data);
>   	*task_desc |= data;
>   	desc = (u8 *)task_desc;
>   	pr_debug("%s: cqhci: dcmd: cmd: %d timing: %d resp: %d\n",
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 9e68286a07b4..8c8ec6f01c45 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -210,6 +210,8 @@ struct cqhci_host_ops {
>   	u32 (*read_l)(struct cqhci_host *host, int reg);
>   	void (*enable)(struct mmc_host *mmc);
>   	void (*disable)(struct mmc_host *mmc, bool recovery);
> +	void (*update_dcmd_desc)(struct mmc_host *mmc, struct mmc_request *mrq,
> +				 u64 *data);
>   };
>   
>   static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
