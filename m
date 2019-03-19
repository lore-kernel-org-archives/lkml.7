Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEF52146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vNE8NWAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfCSLpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:45:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36690 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfCSLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:45:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JBjXwt073849;
        Tue, 19 Mar 2019 06:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552995933;
        bh=oCwrapSIcYjb5JnXkJkpsOKYaG2eWaskLlJhrT5tQfQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vNE8NWAAiHzbhm9AFnNeZFd0KCEROw4L7yXe6dkqEKii81ywdXCTeeevi8hU7HVyA
         oT7nVq0rMz7/XR7BsoXIPbvGnGGNtJ84WTYZfUfTNOnjYikxbq8uguOlGt0a79G5+u
         69L2Pj00CSOHy/z9WhQ+9deaf9pKkmKbXGlK/a4A=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JBjXg2091125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 06:45:33 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 06:45:33 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 06:45:33 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JBjUpM026317;
        Tue, 19 Mar 2019 06:45:31 -0500
Subject: Re: [PATCH v3 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20190319063533.12171-1-faiz_abbas@ti.com>
 <20190319063533.12171-3-faiz_abbas@ti.com>
 <8261c01f-fd8e-0930-fee5-793b02071542@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <b52277dd-39aa-b6ea-313e-55ed65afba1e@ti.com>
Date:   Tue, 19 Mar 2019 17:15:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8261c01f-fd8e-0930-fee5-793b02071542@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 19/03/19 1:37 PM, Kishon Vijay Abraham I wrote:
> Hi Faiz,
> 
> On 19/03/19 12:05 PM, Faiz Abbas wrote:
>> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
>> callback") skips data resets during tuning operation. Because of this,
>> a data error or data finish interrupt might still arrive after a command
>> error has been handled and the mrq ended. This ends up with a "mmc0: Got
>> data interrupt 0x00000002 even though no data operation was in progress"
>> error message.
>>
>> Fix this by adding a platform specific callback for sdhci_irq. Mark the
>> mrq as a failure but wait for a data interrupt instead of calling
>> finish_mrq().
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/mmc/host/sdhci-omap.c | 36 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>> index b1a66ca3821a..765873dff7ca 100644
>> --- a/drivers/mmc/host/sdhci-omap.c
>> +++ b/drivers/mmc/host/sdhci-omap.c
>> @@ -797,6 +797,41 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>>  	sdhci_reset(host, mask);
>>  }
>>  
>> +#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX)
>> +#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
>> +
>> +static irqreturn_t sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	if (omap_host->is_tuning && (intmask & CMD_ERR_MASK)) {
>> +
>> +		/*
>> +		 * Since we are not resetting data lines during tuning
>> +		 * operation, data error or data complete interrupts
>> +		 * might still arrive. Mark this request as a failure
>> +		 * but still wait for the data interrupt
>> +		 */
>> +		if (intmask & SDHCI_INT_TIMEOUT)
> 
> CMD_ERR_MASK doesn't have SDHCI_INT_TIMEOUT. So this will never be true.
> 

Yeah, need to SDHCI_INT_TIMEOUT to CMD_ERR_MASK.

Thanks,
Faiz
