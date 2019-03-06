Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBD720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfCFNC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:02:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:18290 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfCFNC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:02:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 05:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,448,1544515200"; 
   d="scan'208";a="325930658"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2019 05:02:24 -0800
Subject: Re: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        riteshh@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a320c841-7e58-4d3e-5df6-61e10520d9d8@intel.com>
Date:   Wed, 6 Mar 2019 15:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/03/19 7:20 AM, Sowjanya Komatineni wrote:
> This patch adds a quirk for setting CMD_TIMING to 1 in descriptor
> for DCMD with R1B response type to allow the command to be sent to
> device during data activity or busy time.
> 
> Tegra186 CQHCI host has bug where it selects DATA_PRESENT_SELECT
> to 1 by CQHCI controller for DCMDs with R1B response type and
> since DCMD does not trigger any data transfer, DCMD task complete
> happens leaving the DATA FSM of host controller in wait state for
> data.
> 
> This effects the data transfer task issued after R1B DCMD task
> and no interrupt is generated for the data transfer task.
> 
> SW WAR for this issue is to set CMD_TIMING bit to 1 in DCMD task
> descriptor and as DCMD task descriptor preparation is done by
> cqhci driver, this patch adds cqequirk to handle this.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/cqhci.c | 5 ++++-
>  drivers/mmc/host/cqhci.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index a8af682a9182..b34c07125f32 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -521,7 +521,10 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
>  	} else {
>  		if (mrq->cmd->flags & MMC_RSP_R1B) {
>  			resp_type = 0x3;
> -			timing = 0x0;
> +			if (cq_host->quirks & CQHCI_QUIRK_CMD_TIMING_R1B_DCMD)
> +				timing = 0x1;
> +			else
> +				timing = 0x0;

I was thinking it would be nice if there was a generic way for drivers to
make changes to descriptors before a task is started.  Currently there is
host->ops->write_l() which would make it possible by checking for CQHCI_TDBR
register and, in this case, the DCMD tag.  We would need to export
get_desc(), perhaps rename it cqhci_get_desc() and put it in cqhci.h since
it is an inline function.

Alternatively we could add host->ops for descriptor preparation.

What do people think?

>  		} else {
>  			resp_type = 0x2;
>  			timing = 0x1;
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 9e68286a07b4..f96d8565cc07 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -170,6 +170,7 @@ struct cqhci_host {
>  
>  	u32 quirks;
>  #define CQHCI_QUIRK_SHORT_TXFR_DESC_SZ	0x1
> +#define CQHCI_QUIRK_CMD_TIMING_R1B_DCMD	0x2
>  
>  	bool enabled;
>  	bool halted;
> 

