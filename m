Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D6EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324F20679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="BSXssWeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfJGPz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:55:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11902 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727791AbfJGPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:55:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97FpF8F032613;
        Mon, 7 Oct 2019 17:55:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=IndfOZ3euQc5yphJYWP38eEWIsfndJdvzqT18BJbLBE=;
 b=BSXssWeK1Mo6yqm+2U1oQeCvWE5+GMrSlBWKv888GkcVGm8epFn33b5bl/Pl4fNbPluW
 CaBwHZdt2Y+ee3MmzKCMJK/Xziqhxk8n58A6rG5C6a6NTLwtHjfRMyjV6dfrpvTPewW6
 cqcfy9OyGuQu9AGM1qr0yK3gmauhQZiZQrYjzJ1oRcanWjgHvkGBA1MI7DUsLE87yu5P
 WO6zX+Lu0+JUeu575plVRyQiB4NkJaGRf3erkApWZXbrTuJa2OxdZjheoEWQGTEAxmp0
 SDKFF6oG9gf6taGd7g0WyGIswXLoKFIvngWL/mbQXYMco+ER9lTJHhvxKON1JcFoljyO eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vegaguk9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 17:55:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 79555100034;
        Mon,  7 Oct 2019 17:55:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 671082D3768;
        Mon,  7 Oct 2019 17:55:45 +0200 (CEST)
Received: from lmecxl0923.lme.st.com (10.75.127.48) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Oct
 2019 17:55:44 +0200
Subject: Re: [PATCH V6 3/3] mmc: mmci: sdmmc: add busy_complete callback
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20190905122112.29672-1-ludovic.Barre@st.com>
 <20190905122112.29672-4-ludovic.Barre@st.com>
 <CAPDyKFqbEzYpNty8u_QuSDfLgPoiTMZS2Bx4GbzfX-Y9TqXJTg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <6a45203b-66c8-25d6-55d6-042778695c8d@st.com>
Date:   Mon, 7 Oct 2019 17:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqbEzYpNty8u_QuSDfLgPoiTMZS2Bx4GbzfX-Y9TqXJTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_03:2019-10-07,2019-10-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

Le 10/4/19 à 9:31 AM, Ulf Hansson a écrit :
> On Thu, 5 Sep 2019 at 14:22, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds a specific busy_complete callback for sdmmc variant.
>>
>> sdmmc has 2 status flags:
>> -busyd0: This is a hardware status flag (inverted value of d0 line).
>> it does not generate an interrupt.
>> -busyd0end: This indicates only end of busy following a CMD response.
>> On busy to Not busy changes, an interrupt is generated (if unmask)
>> and BUSYD0END status flag is set. Status flag is cleared by writing
>> corresponding interrupt clear bit in MMCICLEAR.
>>
>> The legacy busy completion monitors step by step the busy progression
>> start/in-progress/end. On sdmmc variant, the monitoring of busy steps
>> is difficult and not adapted (the software can miss a step and locks
>> the monitoring), the sdmmc has just need to wait the busyd0end bit
>> without monitoring all the changes.
> 
> To me it's a bit of the opposite as you describe it above. The legacy
> variants suffers from a somewhat broken HW that generates also a
> "busystart" IRQ. For the stm32_sdmmc variant, it's more clean/correct
> as only a busyend IRQ is raised.
> 
> Maybe you can rephrase the above a bit to make that more clear somehow.

Yes, I will rephrase.
     The legacy busy completion has no dedicated interrupt for the end
     of busy, so it's must monitor step by step the busy progression.
     On sdmmc variant, this procedure is not needed, it's just need
     to wait the busyd0end status.

> 
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c             |  3 +++
>>   drivers/mmc/host/mmci.h             |  1 +
>>   drivers/mmc/host/mmci_stm32_sdmmc.c | 38 +++++++++++++++++++++++++++++
>>   3 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index e20164f4354d..a666d826dbbd 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -260,6 +260,9 @@ static struct variant_data variant_stm32_sdmmc = {
>>          .datalength_bits        = 25,
>>          .datactrl_blocksz       = 14,
>>          .stm32_idmabsize_mask   = GENMASK(12, 5),
>> +       .busy_timeout           = true,
>> +       .busy_detect_flag       = MCI_STM32_BUSYD0,
>> +       .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
>>          .init                   = sdmmc_variant_init,
>>   };
>>
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 733f9a035b06..841c5281beb5 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -164,6 +164,7 @@
>>   #define MCI_ST_CARDBUSY                (1 << 24)
>>   /* Extended status bits for the STM32 variants */
>>   #define MCI_STM32_BUSYD0       BIT(20)
>> +#define MCI_STM32_BUSYD0END    BIT(21)
>>
>>   #define MMCICLEAR              0x038
>>   #define MCI_CMDCRCFAILCLR      (1 << 0)
>> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> index 8e83ae6920ae..bb5499cc9e81 100644
>> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
>> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> @@ -282,6 +282,43 @@ static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
>>          return datactrl;
>>   }
>>
>> +bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>> +{
>> +       void __iomem *base = host->base;
>> +       u32 busy_d0, busy_d0end, mask;
>> +
>> +       mask = readl_relaxed(base + MMCIMASK0);
>> +       busy_d0end = readl_relaxed(base + MMCISTATUS) & MCI_STM32_BUSYD0END;
>> +       busy_d0 = readl_relaxed(base + MMCISTATUS) & MCI_STM32_BUSYD0;
> 
> I have found some potential optimizations, but I leave it to you to
> decide what to do with my comments.
> 
> *) You could avoid to read registers upfront, if that be skipped
> because of checking a known error condition. For example:
> "if (!host->busy_status && !(status & err_msk))" - would tell if it's
> even worth considering to unmask the busyend IRQ.

Yes, it's a possibility, but I prefer to keep reading the bits
busy_doend and busy_d0. This is not the most optimized way, but it is
easier to understand the completion's reason (based on hardware bit).
On the other hand, I would be independent of any change about status or 
busy_status.

> 
> **) Reading MMCISTATUS twice in row seems a bit silly, why not read it
> once and store its value in a local variable that you operate upon
> instead.
> 

yes, I will store MMCISTATUS in local variable (thx).

>> +
>> +       /* complete if there is an error or busy_d0end */
>> +       if ((status & err_msk) || busy_d0end)
>> +               goto complete;
> 
>  From here, you may end up writing to MMCIMASK0 and MMCICLEAR, even if
> you didn't unmask the busyend IRQ in first place.

I will add this condition into
complete:
	if (host->busy_status) {
		...
	}
	return true;
}

> 
>> +
>> +       /*
>> +        * On response the busy signaling is reflected in the BUSYD0 flag.
>> +        * if busy_d0 is in-progress we must activate busyd0end interrupt
>> +        * to wait this completion. Else this request has no busy step.
>> +        */
>> +       if (busy_d0) {
>> +               if (!host->busy_status) {
>> +                       writel_relaxed(mask | host->variant->busy_detect_mask,
>> +                                      base + MMCIMASK0);
>> +                       host->busy_status = status &
>> +                               (MCI_CMDSENT | MCI_CMDRESPEND);
>> +               }
>> +               return false;
>> +       }
>> +
>> +complete:
>> +       writel_relaxed(mask & ~host->variant->busy_detect_mask,
>> +                      base + MMCIMASK0);
>> +       writel_relaxed(host->variant->busy_detect_mask, base + MMCICLEAR);
>> +       host->busy_status = 0;
>> +
>> +       return true;
>> +}
>> +
>>   static struct mmci_host_ops sdmmc_variant_ops = {
>>          .validate_data = sdmmc_idma_validate_data,
>>          .prep_data = sdmmc_idma_prep_data,
>> @@ -292,6 +329,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
>>          .dma_finalize = sdmmc_idma_finalize,
>>          .set_clkreg = mmci_sdmmc_set_clkreg,
>>          .set_pwrreg = mmci_sdmmc_set_pwrreg,
>> +       .busy_complete = sdmmc_busy_complete,
>>   };
>>
>>   void sdmmc_variant_init(struct mmci_host *host)
>> --
>> 2.17.1
>>
> 
> Other than the comments above, which are plain suggestions for
> optimizations, the code looks correct to me!

I will send a next series soon, thx for review.

> 
> Kind regards
> Uffe
> 
