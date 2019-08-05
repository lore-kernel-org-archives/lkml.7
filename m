Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E45CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A34621841
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cJK9+0cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfHEHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:33:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29358 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726394AbfHEHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:33:42 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x757WDuS007598;
        Mon, 5 Aug 2019 09:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ELEd8ZxDb7OfiConavdH3VksFxUv47PrkLTaOF/CEmU=;
 b=cJK9+0cPWxphMfTR2X7N0k4Qd/pJTWpyQP7xmPodbFYsZY4TukHFk29x34sHuBTfMBri
 EYIGFX/AjpB0Z0ta1UUx+m0ftLoLbppExROO6Lszg1eHPuZ3o29EAXleZgw/cyJCTRHX
 mvOO7PsQl5kiYqcuZVIP9Tqp31q6Q7KcgC8+gxTYiACHMkuH7Q6HEDxtGaaSHQMjOiFA
 SMIygIB/l/Q1JXzdouWm7IfpDnXOv898XHAo1O/KJ6NHtDtXX8ucXaQ2CJxgpBihBuOb
 ROpea/o9zOxBzMaanx9ZJVd7Ls7bPsKsnMJ3UIvxn4ESe2oDwMf99KWipwPvQlFtOCj5 zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u5sd1d4jg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 05 Aug 2019 09:33:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF36249;
        Mon,  5 Aug 2019 07:33:24 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CC0DB2C35BB;
        Mon,  5 Aug 2019 09:33:24 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 5 Aug 2019
 09:33:24 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 5 Aug 2019
 09:33:24 +0200
Subject: Re: [Linux-stm32] [PATCH V3 1/3] mmc: mmci: fix read status for busy
 detect
From:   Ludovic BARRE <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
 <1559577325-19266-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpJPbpTnfA2cynFURyxFY_YCm7MRXw3m2nQyU+z=ZWsFA@mail.gmail.com>
 <dd5c1e86-f0b1-cdfa-1b91-486f99d4e50c@st.com>
Message-ID: <7eed2ec4-30db-ae26-f07d-6a8ace7fce12@st.com>
Date:   Mon, 5 Aug 2019 09:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <dd5c1e86-f0b1-cdfa-1b91-486f99d4e50c@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

On 7/26/19 11:41 AM, Ludovic BARRE wrote:
> hi Ulf
> 
> Thanks to your "Clarify comments ..." commit, like is closes
> I resumed upstream of this series.
> 
> On 7/15/19 6:31 PM, Ulf Hansson wrote:
>> On Mon, 3 Jun 2019 at 17:55, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> "busy_detect_flag" is used to read & clear busy value of mmci status.
>>> "busy_detect_mask" is used to manage busy irq of mmci mask.
>>> So to read mmci status the busy_detect_flag must be take account.
>>> if the variant does not support busy detect feature the flag is null
>>> and there is no impact.
>>
>> By reading the changelog, it doesn't tell me the purpose of this
>> change. When going forward, please work harder on your changelogs.
>>
>> Make sure to answer the questions, *why* is this change needed,
>> *what/how* does the change do.
> 
> Ok, I will explain the differences with the legacy and the needs of 
> sdmmc variant about busy detection.
> 
>>
>>>
>>> Not need to re-read the status register in mmci_cmd_irq, the
>>> status parameter can be used.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/mmc/host/mmci.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index 356833a..5b5cc45 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -1240,7 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct 
>>> mmc_command *cmd,
>>>                   */
>>>                  if (!host->busy_status &&
>>>                      !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>>> -                   (readl(base + MMCISTATUS) & 
>>> host->variant->busy_detect_flag)) {
>>> +                   (status & host->variant->busy_detect_flag)) {
>>
>> I suggested you to do this change through some of my earlier comments,
>> however I think it should be made as a stand alone change.
>>
>> Anyway, when looking at the details in your series, I decided to try
>> to help out a bit, so I have prepared a couple of related patches for
>> cleaning up and clarifying the busy detection code/comments in mmci. I
>> have incorporated the above change, so let me post them asap.
>>
>>>
>>>                          /* Clear the busy start IRQ */
>>>                          writel(host->variant->busy_detect_mask,
>>> @@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>>                   * to make sure that both start and end interrupts 
>>> are always
>>>                   * cleared one after the other.
>>>                   */
>>> -               status &= readl(host->base + MMCIMASK0);
>>> +               status &= readl(host->base + MMCIMASK0) |
>>> +                       host->variant->busy_detect_flag;
>>
>> As I told earlier in the review, this looks wrong to me.
>>
>> It means that you will add the bit for the ->busy_detect_flag to the
>> status field we have just read from the MMCISTATUS register. That
>> means the busy status may be set when it shouldn't.
>>
>>>                  if (host->variant->busy_detect)
>>>                          writel(status & 
>>> ~host->variant->busy_detect_mask,
>>>                                 host->base + MMCICLEAR);
>>> -- 
>>> 2.7.4
>>>
>>
>> By looking at the other changes in the series, I assume @subject patch
>> is intended to prepare for the other changes on top. But it's not
>> really clear.
>>
>> Anyway, in that regards, the below is my observations of what seems to
>> be important part, when supporting busy detection for the stm32 sdmmc
>> variant (except the timeout things in patch2, which I intend to
>> comment separately on).
>>
>> I figured, these are the involved register bits/masks:
>>
>> MMCISTATUS:
>> MCI_STM32_BUSYD0 BIT(20)
>> MCI_STM32_BUSYD0END BIT(21)
>>
>> MMCIMASK0:
>> MCI_STM32_BUSYD0ENDMASK BIT(21)
> 
> it's exact:
> MCI_STM32_BUSYD0 BIT(20): This is a hardware status flag only (inverted 
> value of d0 line), it does not generate an interrupt, and so no mask
> bit.
> 
> MCI_STM32_BUSYD0ENDMASK BIT(21): This indicates only end of busy
> following a CMD response. On busy to Not busy changes, an interrupt
> is generated (if unmask) and BUSYD0END status flag is set.
> status flag is cleared by writing corresponding interrupt clear bit in 
> MMCICLEAR.
> 
>>
>> For the legacy ST variant, there is only one register bit in
>> MMCISTATUS that is used for indicating busy (MCI_ST_CARDBUSY BIT(24)).
>> There is no dedicated busy-end bit for the busy-end IRQ, which I
>> believe is the reason to why the current code also is bit messy.
> 
> yes
> 
>>
>> It seems like the stm32 sdmmc variant have a separate status bit for
>> the busy-end IRQ, correct?
> 
> yes
> 
>>
>> If I understand correctly by looking at patch3, you don't use the
>> dedicated busy-end status bit (MCI_STM32_BUSYD0END), right? Then why
>> not?
> 
> like your are clarify in previous series, the busy detection is done
> in 3 steps.
> 
> if I use:
> .busy_detect_flag    = MCI_STM32_BUSYD0ENDMASK,
> .busy_detect_mask    = MCI_STM32_BUSYD0ENDMASK,
> 
> the sdmmc request will be not correctly completed, because the third 
> step can't be happen.
> 
> chronologies:
> step1: when busyd0end change to 1
>   => busyd0end interrupt is unmasked
>   => busy_status = cmd_sent | respend
>   => return to mmci_irq
> step2: busyd0end is yet to 1
>   => clear the busyd0end interrupt
>      => the hardware clear busyd0end status flag on interrupt clear
>   => return to mmci_irq
> 
> like MCI_STM32_BUSYD0END interrupt is generated only on change
> busy to not busy, when the interrupt is cleared (status is 0)
> the step 3 can't happen (no irq pending to re-enter in mmci_cmd_irq).
> sdmmc can't complete the request.
> 
> If I use:
> .busy_detect_flag    = MCI_STM32_BUSYD0,
> .busy_detect_mask    = MCI_STM32_BUSYD0ENDMASK,
> 
> Like there is no MCI_STM32_BUSYD0 irq mask, the status read in mmci_irq
> "status &= readl(host->base + MMCIMASK0)" can't take account the 
> busy_detect_flag (for sdmmc). So the  step 2 can't be passed.
> However we could share re-read between step 1 and step 2.
> 
> proposal:
> 
> +
> +        u32 busy_val = readl(base + MMCISTATUS) &
> +            host->variant->busy_detect_flag;
> +
>           if (!host->busy_status &&
> -            !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> -            (readl(base + MMCISTATUS) & 
> host->variant->busy_detect_flag)) {
> +            !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) && busy_val) {
> 
>               writel(readl(base + MMCIMASK0) |
>                      host->variant->busy_detect_mask,
> @@ -1262,8 +1265,7 @@ mmci_cmd_irq(struct mmci_host *host, struct 
> mmc_command *cmd,
>            * both the start and the end interrupts needs to be cleared,
>            * one after the other. So, clear the busy start IRQ here.
>            */
> -        if (host->busy_status &&
> -            (status & host->variant->busy_detect_flag)) {
> +        if (host->busy_status && busy_val) {
> 
> 
> what do you think about it ?
> 

I give up this proposal for a new version based on mmci_host_ops
callback to done the busy completion.

>>
>> Thoughts?
>>
>> Kind regards
>> Uffe
>>
> 
> Regards
> Ludo
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
