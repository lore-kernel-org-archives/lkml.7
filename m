Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B73A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfCYKlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:41:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:60904 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbfCYKlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:41:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 03:41:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134508449"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 03:41:09 -0700
Subject: Re: [PATCH V4 06/10] mmc: cqhci: allow hosts to update dcmd cmd desc
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        riteshh@codeaurora.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
 <1553402727-23130-6-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <03a445c1-58a9-96b3-95d6-daa19b5095f1@intel.com>
Date:   Mon, 25 Mar 2019 12:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553402727-23130-6-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/19 6:45 AM, Sowjanya Komatineni wrote:
> This patch adds update_dcmd_desc interface to cqhci_host_ops to
> allow hosts to update any of the DCMD task descriptor attributes
> and parameters.
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  [V4]: Minor fix of missing declaration of mmc_request
> 
>  drivers/mmc/host/cqhci.c | 2 ++
>  drivers/mmc/host/cqhci.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index a8af682a9182..d59cb0a51964 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -537,6 +537,8 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
>  		 CQHCI_ACT(0x5) |
>  		 CQHCI_CMD_INDEX(mrq->cmd->opcode) |
>  		 CQHCI_CMD_TIMING(timing) | CQHCI_RESP_TYPE(resp_type));
> +	if (cq_host->ops->update_dcmd_desc)
> +		cq_host->ops->update_dcmd_desc(mmc, mrq, &data);
>  	*task_desc |= data;
>  	desc = (u8 *)task_desc;
>  	pr_debug("%s: cqhci: dcmd: cmd: %d timing: %d resp: %d\n",
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 9e68286a07b4..928ec491eecf 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -147,6 +147,7 @@
>  
>  struct cqhci_host_ops;
>  struct mmc_host;
> +struct mmc_request;
>  struct cqhci_slot;
>  
>  struct cqhci_host {
> @@ -210,6 +211,8 @@ struct cqhci_host_ops {
>  	u32 (*read_l)(struct cqhci_host *host, int reg);
>  	void (*enable)(struct mmc_host *mmc);
>  	void (*disable)(struct mmc_host *mmc, bool recovery);
> +	void (*update_dcmd_desc)(struct mmc_host *mmc, struct mmc_request *mrq,
> +				 u64 *data);
>  };
>  
>  static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
> 

