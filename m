Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161B6213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDAJN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:13:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:48351 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfDAJN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:13:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 02:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="127576383"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2019 02:13:20 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci: Add Quirk for enabling HISPD under
 special conditions
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20190329142202.15000-1-faiz_abbas@ti.com>
 <20190329142202.15000-2-faiz_abbas@ti.com>
 <f1417015-0e78-6df5-7917-a33e235fa1a9@intel.com>
 <350cd133-302f-4002-4b54-d95e7e5d3500@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6d8f9b8c-dd5c-a091-7a82-10e5f6606b4e@intel.com>
Date:   Mon, 1 Apr 2019 12:12:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <350cd133-302f-4002-4b54-d95e7e5d3500@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/04/19 12:01 PM, Faiz Abbas wrote:
> Hi Adrian,
> 
> On 01/04/19 2:21 PM, Adrian Hunter wrote:
>> On 29/03/19 4:22 PM, Faiz Abbas wrote:
>>> Some controllers on TI devices requires the HISPD bit to be cleared
>>> even in some high speed modes. Add a quirk that facilitates this
>>> requirement.
>>
>> Could you use sdhci I/O accessors for this?
> 
> Can you elaborate? Not sure how this would be solved with
> CONFIG_MMC_SDHCI_IO_ACCESSORS.

In ->writeb()

if (reg == SDHCI_HOST_CONTROL) {
	if (host->mmc->ios->timing == whatever)
		val &= ~SDHCI_CTRL_HISPD;
}

writeb(val, host->ioaddr + reg);


> 
> Thanks,
> Faiz
> 
>>
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++------------
>>>  drivers/mmc/host/sdhci.h |  2 ++
>>>  2 files changed, 26 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index a8141ff9be03..ed4ed6054ddf 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1916,18 +1916,30 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>>>  
>>>  	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
>>> -		if (ios->timing == MMC_TIMING_SD_HS ||
>>> -		     ios->timing == MMC_TIMING_MMC_HS ||
>>> -		     ios->timing == MMC_TIMING_MMC_HS400 ||
>>> -		     ios->timing == MMC_TIMING_MMC_HS200 ||
>>> -		     ios->timing == MMC_TIMING_MMC_DDR52 ||
>>> -		     ios->timing == MMC_TIMING_UHS_SDR50 ||
>>> -		     ios->timing == MMC_TIMING_UHS_SDR104 ||
>>> -		     ios->timing == MMC_TIMING_UHS_DDR50 ||
>>> -		     ios->timing == MMC_TIMING_UHS_SDR25)
>>> -			ctrl |= SDHCI_CTRL_HISPD;
>>> -		else
>>> -			ctrl &= ~SDHCI_CTRL_HISPD;
>>> +		if ((host->quirks2 & SDHCI_QUIRK2_TI_HISPD_BIT)) {
>>> +			if (ios->timing == MMC_TIMING_MMC_HS400 ||
>>> +			    ios->timing == MMC_TIMING_MMC_HS200 ||
>>> +			    ios->timing == MMC_TIMING_MMC_DDR52 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR50 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR104 ||
>>> +			    ios->timing == MMC_TIMING_UHS_DDR50)
>>> +				ctrl |= SDHCI_CTRL_HISPD;
>>> +			else
>>> +				ctrl &= ~SDHCI_CTRL_HISPD;
>>> +		} else {
>>> +			if (ios->timing == MMC_TIMING_SD_HS ||
>>> +			    ios->timing == MMC_TIMING_MMC_HS ||
>>> +			    ios->timing == MMC_TIMING_MMC_HS400 ||
>>> +			    ios->timing == MMC_TIMING_MMC_HS200 ||
>>> +			    ios->timing == MMC_TIMING_MMC_DDR52 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR50 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR104 ||
>>> +			    ios->timing == MMC_TIMING_UHS_DDR50 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR25)
>>> +				ctrl |= SDHCI_CTRL_HISPD;
>>> +			else
>>> +				ctrl &= ~SDHCI_CTRL_HISPD;
>>> +		}
>>>  	}
>>>  
>>>  	if (host->version >= SDHCI_SPEC_300) {
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 01002cba1359..aac026c5e184 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -485,6 +485,8 @@ struct sdhci_host {
>>>   * block count.
>>>   */
>>>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
>>> +/* Some TI devices need the high speed bit disabled even in high speed modes */
>>> +#define SDHCI_QUIRK2_TI_HISPD_BIT			(1<<19)
>>>  
>>>  	int irq;		/* Device IRQ */
>>>  	void __iomem *ioaddr;	/* Mapped address */
>>>
>>
> 

