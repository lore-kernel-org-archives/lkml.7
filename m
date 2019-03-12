Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD205C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F976214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JUhVQ7f3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfCLRe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:34:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48812 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbfCLRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:34:55 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2CHYrJr082095;
        Tue, 12 Mar 2019 12:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552412093;
        bh=5IN74cas7YzPe70PVw8u0CSKEPiMborvtVhoYXKDMmM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JUhVQ7f3AFMZxwHg762N6FXAUUITtB0lmAWbBxUhp4Prycq8ZquOl87DWddI56FfN
         9OHRojOP58AC8Q6Gxl0sSK6edBRHWYc9kYNNTzBiatHFH1F6NSb9tUuB3craOja0yY
         ah7ysiUCdUwC94liO8va7bHekxJ4KMzkoP1pT63U=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2CHYrZY099160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 12:34:53 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 12
 Mar 2019 12:34:52 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 12:34:52 -0500
Received: from [172.22.88.180] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2CHYmFN023532;
        Tue, 12 Mar 2019 12:34:49 -0500
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>
References: <20190301083824.23918-1-faiz_abbas@ti.com>
 <20190301083824.23918-3-faiz_abbas@ti.com>
 <0283e92e-9e01-227d-0987-7801dd88cf78@intel.com>
From:   "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>
Message-ID: <eb76397b-aa02-f1b8-ef0d-df7569275144@ti.com>
Date:   Tue, 12 Mar 2019 23:04:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0283e92e-9e01-227d-0987-7801dd88cf78@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 3/6/2019 5:39 PM, Adrian Hunter wrote:
> On 1/03/19 10:38 AM, Faiz Abbas wrote:
>> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
>> callback") skips data resets during tuning operation. Because of this,
>> a data error or data finish interrupt might still arrive after a command
>> error has been handled and the mrq ended. This ends up with a "mmc0: Got
>> data interrupt 0x00000002 even though no data operation was in progress"
>> error message.
>>
>> Fix this by adding a platform specific callback for command errors. Mark
>> the mrq as a failure but wait for a data interrupt instead of calling
>> finish_mrq().
>>
>> Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
>> callback")
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/mmc/host/sdhci-omap.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>> index b1a66ca3821a..67b361a403bc 100644
>> --- a/drivers/mmc/host/sdhci-omap.c
>> +++ b/drivers/mmc/host/sdhci-omap.c
>> @@ -797,6 +797,29 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>>  	sdhci_reset(host, mask);
>>  }
>>  
>> +void sdhci_omap_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	if (omap_host->is_tuning) {
>> +		/*
>> +		 * Since we are not resetting data lines during tuning
>> +		 * operation, data error or data complete interrupts
>> +		 * might still arrive. Mark this request as a failure
>> +		 * but still wait for the data interrupt
>> +		 */
>> +		if (intmask & SDHCI_INT_TIMEOUT)
>> +			host->cmd->error = -ETIMEDOUT;
>> +		else
>> +			host->cmd->error = -EILSEQ;
>> +
>> +		sdhci_finish_command(host);
>> +	} else {
>> +		sdhci_cmd_err(host, intmask, intmask_p);
>> +	}
>> +}
> 
> Could this be done by the existing ->irq() callback? i.e. mask the error
> bits in intmask (have to write them back to SDHCI_INT_STATUS also) but set
> cmd->error.
> 

It is possible but I really don't want the callback to be unnecessarily
called for every single interrupt that happens. I think we should only
use the callback in the case of an actual error interrupt :-)

Thanks,
Faiz
