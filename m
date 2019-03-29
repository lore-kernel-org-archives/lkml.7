Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5584F2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aNIVHJr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfC2HnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:43:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52054 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfC2HnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:43:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2T7grvS032333;
        Fri, 29 Mar 2019 02:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553845373;
        bh=bGY0Z7Ou6IamYD+XHfqe2rerY3Eelzz0pgg/vrD57ag=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aNIVHJr1O+fqdaFAPTW4miW7LdkH8SSYMXrExFlgi5x+Ied4pIiH3JZVU1siOlqlV
         w/MMUme2J35fN4MrqM+LGYOIMXxvZgvDmXmFlhuXLAZfp5kcb5oxyrNd/gl5KEQ1PN
         RT2jgzMxfJSQhUdUU3RmrVDczlEG+IlMhQ19QvsQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2T7gr65007879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 02:42:53 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 02:42:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 02:42:53 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2T7go6a065837;
        Fri, 29 Mar 2019 02:42:51 -0500
Subject: Re: [PATCH v4 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>
References: <20190326110057.7055-1-faiz_abbas@ti.com>
 <20190326110057.7055-3-faiz_abbas@ti.com>
 <508e9423-c1f9-f2cc-4aa9-2cc5b1cf40a8@intel.com>
 <05a2f5ef-1fee-15f4-6a9b-e3f3f3ee5a82@ti.com>
 <ee4c90b8-aed8-ba3b-3aea-9e4257771cfe@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <5a8d57ae-3417-95bc-6dcd-6ed0f1336288@ti.com>
Date:   Fri, 29 Mar 2019 13:12:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ee4c90b8-aed8-ba3b-3aea-9e4257771cfe@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 28/03/19 1:43 PM, Adrian Hunter wrote:
> On 27/03/19 1:47 PM, Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 27/03/19 4:45 PM, Adrian Hunter wrote:
>>> On 26/03/19 1:00 PM, Faiz Abbas wrote:
>>>> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
>>>> callback") skips data resets during tuning operation. Because of this,
>>>> a data error or data finish interrupt might still arrive after a command
>>>> error has been handled and the mrq ended. This ends up with a "mmc0: Got
>>>> data interrupt 0x00000002 even though no data operation was in progress"
>>>> error message.
>>>>
>>>> Fix this by adding a platform specific callback for sdhci_irq. Mark the
>>>> mrq as a failure but wait for a data interrupt instead of calling
>>>> finish_mrq().
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-omap.c | 37 +++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>>>> index 5bbed477c9b1..9da2ff9ede8b 100644
>>>> --- a/drivers/mmc/host/sdhci-omap.c
>>>> +++ b/drivers/mmc/host/sdhci-omap.c
>>>> @@ -797,6 +797,42 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>>>>  	sdhci_reset(host, mask);
>>>>  }
>>>>  
>>>> +#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX |\
>>>> +		      SDHCI_INT_TIMEOUT)
>>>> +#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
>>>> +
>>>> +static irqreturn_t sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
>>>> +{
>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>>>> +
>>>> +	if (omap_host->is_tuning && (intmask & CMD_ERR_MASK)) {
>>>> +
>>>> +		/*
>>>> +		 * Since we are not resetting data lines during tuning
>>>> +		 * operation, data error or data complete interrupts
>>>> +		 * might still arrive. Mark this request as a failure
>>>> +		 * but still wait for the data interrupt
>>>> +		 */
>>>> +		if (intmask & SDHCI_INT_TIMEOUT)
>>>> +			host->cmd->error = -ETIMEDOUT;
>>>> +		else
>>>> +			host->cmd->error = -EILSEQ;
>>>> +
>>>> +		sdhci_finish_command(host);
>>>
>>> Would it be possible to set SDHCI_INT_RESPONSE instead of calling
>>> sdhci_finish_command() directly?
>>>
>>
>> It should be possible. But what we are trying to do won't be very clear
>> from the code. Ideally an interrupt handler should not set any interrupt
>> bits, just handle and clear them. Also, setting the RESPONSE bit even
>> when there has been no response seems wrong and makes the code more
>> convoluted.
> 
> Well, I am not in favour of exporting sdhci_finish_command().
> So I had a look and it is not obvious why you need to call it.
> What about something this:
> 
> 	if (omap_host->is_tuning && host->cmd && !host->data_early &&
> 	    (intmask & CMD_ERR_MASK)) {
> 
> 		if (intmask & SDHCI_INT_TIMEOUT)
> 			host->cmd->error = -ETIMEDOUT;
> 		else
> 			host->cmd->error = -EILSEQ;
> 
> 		host->cmd = NULL;
> 
> 		sdhci_writel(host, intmask & CMD_MASK, SDHCI_INT_STATUS);
> 		intmask &= ~CMD_MASK;
> 	}
> 

Yeah. I guess host->cmd = NULL was the only thing that was being done
sdhci_finish_command(). This works with 100 time boot tests for me. Will
post next version.

Thanks,
Faiz
