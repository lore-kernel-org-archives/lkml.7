Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5729C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF86E2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tD/8cwXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfE2JVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:21:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50344 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbfE2JVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:21:00 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T9HJmV011994;
        Wed, 29 May 2019 11:20:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=OqzTfdhqia5TW2akazmwmN49UNTjwbfJGUFpC1QJyQ8=;
 b=tD/8cwXryQRpID8VESzInftZqx7l0uVgJd4LEML5K4zgD/y6L5XdDdIjvve50czGN4rF
 KZnV8l4i1lGf4gjH4Uz1cAxqal0oW4PGraXIy++Ux0wjL5NuD6/ox37iWSR/a7IdtAIr
 lXW+GYKSs3vSeCUurICVquKOMb+Dl7uvsMLMvwOjYtFY5lRkINATZZ8aaFovaryuBNSN
 Nb0jWQBmuccXkGI0FF+utl82sPZUs/n64/dqohbx7I81f/e/IPNb3Nj5ObNW0uKEzmUN
 81d/rU6Wbb/03MBMOQJ+12abw3m0FmS+HI8zYEhEWv/5icVLDyKFQcIe6pgf0icUka2K 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2spvkh6hn7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 11:20:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1C7C34;
        Wed, 29 May 2019 09:20:43 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7AE9D2653;
        Wed, 29 May 2019 09:20:43 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 29 May
 2019 11:20:42 +0200
Subject: Re: [PATCH V2 3/5] mmc: mmci: fix clear of busy detect status
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
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
 <1556264798-18540-4-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFrxp3Y3AudNvkkSRaph2Fe-A-F6Cs0jfy9RUja76GYeiA@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <a6a74431-50a6-6298-b77d-9d27a77fd6cc@st.com>
Date:   Wed, 29 May 2019 11:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrxp3Y3AudNvkkSRaph2Fe-A-F6Cs0jfy9RUja76GYeiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

On 5/27/19 8:17 PM, Ulf Hansson wrote:
> On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> The "busy_detect_flag" is used to read/clear busy value of
>> mmci status. The "busy_detect_mask" is used to manage busy irq of
>> mmci mask.
>> For sdmmc variant, the 2 properties have not the same offset.
>> To clear the busyd0 status bit, we must add busy detect flag,
>> the mmci mask is not enough.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> 
> Ludovic, again, apologies for the delay.
> 
>> ---
>>   drivers/mmc/host/mmci.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index a040f54..3cd52e8 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>                   * to make sure that both start and end interrupts are always
>>                   * cleared one after the other.
>>                   */
>> -               status &= readl(host->base + MMCIMASK0);
>> +               status &= readl(host->base + MMCIMASK0) |
>> +                       host->variant->busy_detect_flag;
> 
> I think this is not entirely correct, because it would mean we check
> for busy even if we haven't unmasked the busy IRQ via the
> variant->busy_detect_mask.

if the variant is busy_detect false:
  => no problem because the busy_detect_flag or busy_detect_mask is not
     defined.

if variant is busy_detect true:
the busy handle is split in 3 steps (see mmci_cmd_irq):
step 1: detection of busy line => unmasked the busy irq end
step 2: in busy wait => ignore cmd irq while current busy flag is
enabled.
step 3: end of busy => clear and mask busy irq

To detect the first step (see mmci_cmd_irq: which unmasks the busy irq)
we need to know the current busy state. Actually, the status register is
re-read in mmci_cmd_irq, why not used the status read in mmci_irq and in
parameter ?

Regards,
Ludo

> 
> I suggest to store a new bool in the host (call it
> "busy_detect_unmasked" or whatever makes sense to you), to track
> whether we have unmasked the busy IRQ or not. Then take this flag into
> account, before ORing the value of host->variant->busy_detect_flag,
> according to above.
> 
>>                  if (host->variant->busy_detect)
>>                          writel(status & ~host->variant->busy_detect_mask,
>>                                 host->base + MMCICLEAR);
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
