Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA17C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394DB20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DmQP4i9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCGVbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:31:44 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17048 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:31:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c818db60000>; Thu, 07 Mar 2019 13:31:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Mar 2019 13:31:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Mar 2019 13:31:43 -0800
Received: from [10.26.11.134] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Mar
 2019 21:31:39 +0000
Subject: Re: [PATCH V1 01/11] mmc: tegra: fix ddr signaling for non-ddr modes
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ff9d8656-fc4b-e460-d72b-2cb7ec4985ea@nvidia.com>
Date:   Thu, 7 Mar 2019 21:31:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551994294; bh=78jL9PSv0ZZtPP2XtpJzvXOjbVqQzaJq7FvAV1tdEz4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DmQP4i9/Z5QGCHLUqYslGtbivkmw7fx3m2nxHXhtFgqFAueLG04uMv2lMyhjrkuxT
         tsOVNb7fV1+3h5SJqrYMONGsaciS1nm4MUDZ+1ct+6hK/YNrgLjMzSpR3GlEgsJKXa
         XbGXKzPdOCbqfcW7Ek9IMt0tiArCALj5KcomOBDR28itsu92mD0hl7g3l0NQ+n+UJo
         rizovZ0OIANIGL59FwXK4WFfqD2STEIcQmLUrXqFqLqGlV6kA2WGZrW2tdFRLTTno7
         xYpQdo2etE12I8O61rLQb6ucGvSDNzVQM33mDZPZZ1GVh865XJ0+BAa7aiC2GI2MXO
         X4Z6Rr9AF1Nlw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sowjanya,

On 02/03/2019 05:20, Sowjanya Komatineni wrote:
> ddr_signaling is set to true for DDR50 and DDR52 modes but is
> not set back to false for other modes. This programs incorrect
> host clock when mode change happens from DDR52/DDR50 to other
> SDR or HS modes like incase of mmc_retune where it switches
> from HS400 to HS DDR and then from HS DDR to HS mode and then
> to HS200.
> 
> This patch fixes the ddr_signaling to set properly for non DDR
> modes.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 32e62904c0d3..46086dd43bfb 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -779,6 +779,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>  	bool set_dqs_trim = false;
>  	bool do_hs400_dll_cal = false;
>  
> +	tegra_host->ddr_signaling = false;
>  	switch (timing) {
>  	case MMC_TIMING_UHS_SDR50:
>  	case MMC_TIMING_UHS_SDR104:

I have tested this series on Tegra210, Tegra186 and Tegra194 and see no
further issues. Thanks for getting this out! Feel free to add my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
