Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47865C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC3A2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfC0Oon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:44:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1545 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbfC0Oon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:44:43 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2REetnp016025;
        Wed, 27 Mar 2019 15:44:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhbrg0u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Mar 2019 15:44:23 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA55834;
        Wed, 27 Mar 2019 14:44:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ACA615905;
        Wed, 27 Mar 2019 14:44:22 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 27 Mar
 2019 15:44:21 +0100
Subject: Re: [PATCH V4 4/5] mmc: mmci: stm32: define get_dctrl_cfg
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
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
 <1553677532-3539-5-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFrGRojw5jmGZ_J-nmP4bHqd0BnKwyKweAr6aLD4C4NMPQ@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <bef06e28-4521-af86-adf4-bc904280707a@st.com>
Date:   Wed, 27 Mar 2019 15:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrGRojw5jmGZ_J-nmP4bHqd0BnKwyKweAr6aLD4C4NMPQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/19 11:54 AM, Ulf Hansson wrote:
> On Wed, 27 Mar 2019 at 10:05, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch defines get_dctrl_cfg callback for sdmmc variant.
>> sdmmc variant has specific stm32 transfer modes.
>> sdmmc data transfer mode selection could be:
>> -Block data transfer ending on block count.
>> -SDIO multibyte data transfer.
>> -MMC Stream data transfer (not used).
>> -Block data transfer ending with STOP_TRANSMISSION command.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.h             |  5 +++++
>>   drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++++++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 35c91d0..82e9f94 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -131,6 +131,11 @@
>>   /* Control register extensions in the Qualcomm versions */
>>   #define MCI_DPSM_QCOM_DATA_PEND        BIT(17)
>>   #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
>> +/* Control register extensions in STM32 versions */
>> +#define MCI_DPSM_STM32_MODE_BLOCK      (0 << 2)
>> +#define MCI_DPSM_STM32_MODE_SDIO       (1 << 2)
>> +#define MCI_DPSM_STM32_MODE_STREAM     (2 << 2)
>> +#define MCI_DPSM_STM32_MODE_BLOCK_STOP (3 << 2)
>>
>>   #define MMCIDATACNT            0x030
>>   #define MMCISTATUS             0x034
>> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> index cfbfc6f..8e83ae6 100644
>> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
>> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> @@ -265,10 +265,28 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
>>          }
>>   }
>>
>> +static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
>> +{
>> +       u32 datactrl;
>> +
>> +       datactrl = mmci_dctrl_blksz(host);
>> +
>> +       if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
>> +           host->data->blocks == 1)
>> +               datactrl |= MCI_DPSM_STM32_MODE_SDIO;
>> +       else if (host->data->stop && !host->mrq->sbc)
>> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
> 
> Just a question here. Does this mean that the controller sends the
> stop command automatically when a transfer has finished successfully?

The controller not sends the stop command, this bit is just an 
information for the Data State Machine to know how the data transfer 
finish.

Regards,
Ludo

> 
>> +       else
>> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK;
>> +
>> +       return datactrl;
>> +}
>> +
>>   static struct mmci_host_ops sdmmc_variant_ops = {
>>          .validate_data = sdmmc_idma_validate_data,
>>          .prep_data = sdmmc_idma_prep_data,
>>          .unprep_data = sdmmc_idma_unprep_data,
>> +       .get_datactrl_cfg = sdmmc_get_dctrl_cfg,
>>          .dma_setup = sdmmc_idma_setup,
>>          .dma_start = sdmmc_idma_start,
>>          .dma_finalize = sdmmc_idma_finalize,
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
