Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B863C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5A520882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfIDIdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:33:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:7729 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfIDIdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:33:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 01:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="198976730"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2019 01:33:04 -0700
Subject: Re: [PATCH v2] mmc: tegra: Implement enable_dma() to set dma_mask
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
References: <20190814005741.13331-1-nicoleotsuka@gmail.com>
 <09d9ba41-f4cd-e515-cd2d-0b4134648059@intel.com>
 <20190815231646.GA15635@Asurada-Nvidia.nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4a9c5d15-5f33-4275-8cf0-24cf374ad86b@intel.com>
Date:   Wed, 4 Sep 2019 11:31:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815231646.GA15635@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/19 2:16 AM, Nicolin Chen wrote:
> On Thu, Aug 15, 2019 at 02:48:20PM +0300, Adrian Hunter wrote:
>> On 14/08/19 3:57 AM, Nicolin Chen wrote:
>>> [ Integrated the change and commit message made by Thierry Reding ]
>>>
>>> The SDHCI controller found in early Tegra SoCs (from Tegra20 through
>>> Tegra114) used an AHB interface to the memory controller, which allowed
>>> only 32 bits of memory to be addressed.
>>>
>>> Starting with Tegra124, this limitation was removed by making the SDHCI
>>> controllers native MCCIF clients, which means that they got increased
>>> bandwidth and better arbitration to the memory controller as well as an
>>> address range extended to 40 bits, out of which only 34 were actually
>>> used (bits 34-39 are tied to 0 in the controller).
>>>
>>> For Tegra186, all of the 40 bits can be used; For Tegra194, 39-bit can
>>> be used.
>>>
>>> So far, sdhci-tegra driver has been relying on sdhci core to configure
>>> the DMA_BIT_MASK between 32-bit or 64-bit, using one of quirks2 flags:
>>> SDHCI_QUIRK2_BROKEN_64_BIT_DMA. However, there is a common way, being
>>> mentioned in sdhci.c file, to set dma_mask via enable_dma() callback in
>>> the device driver directly.
>>>
>>> So this patch implements an enable_dma() callback in the sdhci-tegra,
>>> in order to set an accurate DMA_BIT_MASK, other than just 32/64 bits.
>>
>> Is there a reason this cannot be done at probe time?
> 
> It's supposed to be done at probe() time. But sdhci_setup_host()
> does both 32-bit/64-bit dma_mask setting and dma_alloc(), so if
> the dma_mask isn't correctly set inside sdhci_setup_host(), the
> allocation would fall to a 64-bit IOVA range that hardware does
> not support -- smmu error would happen and crash the system. On
> the other hand, ->enable_dma() is called in that function right
> after 32-bit/64-bit dma_mask setting. Or is there any other way
> of adding to probe() that I am missing here?

Hmmm.  Maybe we should clean that up a bit.  What do about this:

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 4 Sep 2019 11:28:51 +0300
Subject: [PATCH] mmc: sdhci: Let drivers define their DMA mask

Add host operation ->set_dma_mask() so that drivers can define their own
DMA masks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 12 ++++--------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 66c2cf89ee22..43d32ba63ff5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3756,18 +3756,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_USE_ADMA;
 	}
 
-	/*
-	 * It is assumed that a 64-bit capable device has set a 64-bit DMA mask
-	 * and *must* do 64-bit DMA.  A driver has the opportunity to change
-	 * that during the first call to ->enable_dma().  Similarly
-	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
-	 * implement.
-	 */
 	if (sdhci_can_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
-		ret = sdhci_set_dma_mask(host);
+		if (host->ops->set_dma_mask)
+			ret = host->ops->set_dma_mask(host);
+		else
+			ret = sdhci_set_dma_mask(host);
 
 		if (!ret && host->ops->enable_dma)
 			ret = host->ops->enable_dma(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 81e23784475a..a9ab2deaeb45 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -623,6 +623,7 @@ struct sdhci_ops {
 	u32		(*irq)(struct sdhci_host *host, u32 intmask);
 
 	int		(*enable_dma)(struct sdhci_host *host);
+	int		(*set_dma_mask)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	/* get_timeout_clock should return clk rate in unit of Hz */
-- 
2.17.1

