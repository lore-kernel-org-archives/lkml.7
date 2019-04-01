Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9378C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B31213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bQlSsbhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDAJCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:02:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55410 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfDAJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:02:08 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31925Mr103629;
        Mon, 1 Apr 2019 04:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554109325;
        bh=HIW70Qx6J8+bjUuQvic4vpqdTfDr90JC35N2wi9o+zs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bQlSsbhwi+bC7CGiZNv21Gb562nK9hrxqkuku3C6B/g8RkPOyic/szb2ZR7MVLdf9
         XTk0dviMFvp2nro7euv9xYpeZC20+S63tG+Ish5bgXG3KNQy+0H0uEh97jVU4SJxm3
         /z8q7dn6whNLPvLmpENpjETLF/z2W22NasapFblA=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31925G1107917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 04:02:05 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 04:02:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 04:02:04 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x319220F035548;
        Mon, 1 Apr 2019 04:02:03 -0500
Subject: Re: [PATCH 1/2] mmc: sdhci: Add Quirk for enabling HISPD under
 special conditions
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20190329142202.15000-1-faiz_abbas@ti.com>
 <20190329142202.15000-2-faiz_abbas@ti.com>
 <f1417015-0e78-6df5-7917-a33e235fa1a9@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <350cd133-302f-4002-4b54-d95e7e5d3500@ti.com>
Date:   Mon, 1 Apr 2019 14:31:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f1417015-0e78-6df5-7917-a33e235fa1a9@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 01/04/19 2:21 PM, Adrian Hunter wrote:
> On 29/03/19 4:22 PM, Faiz Abbas wrote:
>> Some controllers on TI devices requires the HISPD bit to be cleared
>> even in some high speed modes. Add a quirk that facilitates this
>> requirement.
> 
> Could you use sdhci I/O accessors for this?

Can you elaborate? Not sure how this would be solved with
CONFIG_MMC_SDHCI_IO_ACCESSORS.

Thanks,
Faiz

> 
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++------------
>>  drivers/mmc/host/sdhci.h |  2 ++
>>  2 files changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index a8141ff9be03..ed4ed6054ddf 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1916,18 +1916,30 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>>  
>>  	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
>> -		if (ios->timing == MMC_TIMING_SD_HS ||
>> -		     ios->timing == MMC_TIMING_MMC_HS ||
>> -		     ios->timing == MMC_TIMING_MMC_HS400 ||
>> -		     ios->timing == MMC_TIMING_MMC_HS200 ||
>> -		     ios->timing == MMC_TIMING_MMC_DDR52 ||
>> -		     ios->timing == MMC_TIMING_UHS_SDR50 ||
>> -		     ios->timing == MMC_TIMING_UHS_SDR104 ||
>> -		     ios->timing == MMC_TIMING_UHS_DDR50 ||
>> -		     ios->timing == MMC_TIMING_UHS_SDR25)
>> -			ctrl |= SDHCI_CTRL_HISPD;
>> -		else
>> -			ctrl &= ~SDHCI_CTRL_HISPD;
>> +		if ((host->quirks2 & SDHCI_QUIRK2_TI_HISPD_BIT)) {
>> +			if (ios->timing == MMC_TIMING_MMC_HS400 ||
>> +			    ios->timing == MMC_TIMING_MMC_HS200 ||
>> +			    ios->timing == MMC_TIMING_MMC_DDR52 ||
>> +			    ios->timing == MMC_TIMING_UHS_SDR50 ||
>> +			    ios->timing == MMC_TIMING_UHS_SDR104 ||
>> +			    ios->timing == MMC_TIMING_UHS_DDR50)
>> +				ctrl |= SDHCI_CTRL_HISPD;
>> +			else
>> +				ctrl &= ~SDHCI_CTRL_HISPD;
>> +		} else {
>> +			if (ios->timing == MMC_TIMING_SD_HS ||
>> +			    ios->timing == MMC_TIMING_MMC_HS ||
>> +			    ios->timing == MMC_TIMING_MMC_HS400 ||
>> +			    ios->timing == MMC_TIMING_MMC_HS200 ||
>> +			    ios->timing == MMC_TIMING_MMC_DDR52 ||
>> +			    ios->timing == MMC_TIMING_UHS_SDR50 ||
>> +			    ios->timing == MMC_TIMING_UHS_SDR104 ||
>> +			    ios->timing == MMC_TIMING_UHS_DDR50 ||
>> +			    ios->timing == MMC_TIMING_UHS_SDR25)
>> +				ctrl |= SDHCI_CTRL_HISPD;
>> +			else
>> +				ctrl &= ~SDHCI_CTRL_HISPD;
>> +		}
>>  	}
>>  
>>  	if (host->version >= SDHCI_SPEC_300) {
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 01002cba1359..aac026c5e184 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -485,6 +485,8 @@ struct sdhci_host {
>>   * block count.
>>   */
>>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
>> +/* Some TI devices need the high speed bit disabled even in high speed modes */
>> +#define SDHCI_QUIRK2_TI_HISPD_BIT			(1<<19)
>>  
>>  	int irq;		/* Device IRQ */
>>  	void __iomem *ioaddr;	/* Mapped address */
>>
> 
