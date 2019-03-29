Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4BDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6B820657
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L/RpgE9l";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IIeXQT3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbfC2VA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:00:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbfC2VA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:00:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 855EC6087D; Fri, 29 Mar 2019 21:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553893255;
        bh=5+1ErKi4wAE6QPgFBx4XkwHCaffirQ3Em7+ThcJ/ky8=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=L/RpgE9l3lIFNavk8Rc5QOVr2BLARD9L2Av8he7pNTj9bTywYNQF8FSscRg94k/fX
         RAyqSZPyyJ/8YOG21enJgU3KwWtFFeCID/gO7C4NzHuG9064FoWtVhtE2BnVvqthjp
         6b1emOp+Gov9hERQkzM5JpmoIHyZuwmzOBQkFOX8=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE6F3602FC;
        Fri, 29 Mar 2019 21:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553893254;
        bh=5+1ErKi4wAE6QPgFBx4XkwHCaffirQ3Em7+ThcJ/ky8=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=IIeXQT3L4y13gBjApsY4RBROfMcB/OJNflPYTKKaEUet9zWHNwQWMHlrXmr8ty5FK
         H0OJDlGhCOYgz5+b/d9oFMX2j/UUa7b4Be68QM2nPyBHI0T7D7s8U31bpHjZW4alx2
         AfAkdXNnWIc6SaV/w1TNJdKnJp13+jiOm2MPZF7Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE6F3602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scsi: pm8001: clean up structurally dead code when
 PM8001_USE_MSIX is defined (part2)
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     Colin King <colin.king@canonical.com>,
        Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190329153221.29238-1-colin.king@canonical.com>
 <0c08b258-e61d-60ee-7702-728fa96c435d@codeaurora.org>
Message-ID: <2b2ad873-2303-62de-55cd-f63cc31a78b9@codeaurora.org>
Date:   Sat, 30 Mar 2019 02:30:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0c08b258-e61d-60ee-7702-728fa96c435d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2019 1:38 AM, Mukesh Ojha wrote:
>
> On 3/29/2019 9:02 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> When macro PM8001_USE_MSIX is defined there is redundant dead code
>> call to pm8001_cr32.  Clean this up for the defined PM8001_USE_MSIX and
>> undefined PM8001_USE_MSIX cases.
>>
>> Also rename the functions pm8001_chip_is_our_interupt,
>> pm80xx_chip_is_our_interupt and function pointer is_our_interrupt
>> to fix spelling mistakes.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> It would be better if you could split this into two patch, one for 
> dead code and other for renaming.

Also, What is that part2 in the subject ? please remove that too.


>
>
> Otherwise change looks good.
>
> Once you fix above you could include .
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> Cheers,
> -Mukesh
>
>
>> ---
>>   drivers/scsi/pm8001/pm8001_hwi.c  | 11 ++++++-----
>>   drivers/scsi/pm8001/pm8001_init.c |  4 ++--
>>   drivers/scsi/pm8001/pm8001_sas.h  |  2 +-
>>   drivers/scsi/pm8001/pm80xx_hwi.c  | 11 ++++++-----
>>   4 files changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c 
>> b/drivers/scsi/pm8001/pm8001_hwi.c
>> index e4209091c1da..627075d00918 100644
>> --- a/drivers/scsi/pm8001/pm8001_hwi.c
>> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
>> @@ -4623,17 +4623,18 @@ static int pm8001_chip_phy_ctl_req(struct 
>> pm8001_hba_info *pm8001_ha,
>>       return ret;
>>   }
>>   -static u32 pm8001_chip_is_our_interupt(struct pm8001_hba_info 
>> *pm8001_ha)
>> +static u32 pm8001_chip_is_our_interrupt(struct pm8001_hba_info 
>> *pm8001_ha)
>>   {
>> -    u32 value;
>>   #ifdef PM8001_USE_MSIX
>>       return 1;
>> -#endif
>> +#else
>> +    u32 value;
>> +
>>       value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>>       if (value)
>>           return 1;
>>       return 0;
>> -
>> +#endif
>>   }
>>     /**
>> @@ -5119,7 +5120,7 @@ const struct pm8001_dispatch 
>> pm8001_8001_dispatch = {
>>       .chip_rst        = pm8001_hw_chip_rst,
>>       .chip_iounmap        = pm8001_chip_iounmap,
>>       .isr            = pm8001_chip_isr,
>> -    .is_our_interupt    = pm8001_chip_is_our_interupt,
>> +    .is_our_interrupt    = pm8001_chip_is_our_interrupt,
>>       .isr_process_oq        = process_oq,
>>       .interrupt_enable     = pm8001_chip_interrupt_enable,
>>       .interrupt_disable    = pm8001_chip_interrupt_disable,
>> diff --git a/drivers/scsi/pm8001/pm8001_init.c 
>> b/drivers/scsi/pm8001/pm8001_init.c
>> index a36060c23b37..3374f553c617 100644
>> --- a/drivers/scsi/pm8001/pm8001_init.c
>> +++ b/drivers/scsi/pm8001/pm8001_init.c
>> @@ -201,7 +201,7 @@ static irqreturn_t 
>> pm8001_interrupt_handler_msix(int irq, void *opaque)
>>         if (unlikely(!pm8001_ha))
>>           return IRQ_NONE;
>> -    if (!PM8001_CHIP_DISP->is_our_interupt(pm8001_ha))
>> +    if (!PM8001_CHIP_DISP->is_our_interrupt(pm8001_ha))
>>           return IRQ_NONE;
>>   #ifdef PM8001_USE_TASKLET
>> tasklet_schedule(&pm8001_ha->tasklet[irq_vector->irq_id]);
>> @@ -224,7 +224,7 @@ static irqreturn_t 
>> pm8001_interrupt_handler_intx(int irq, void *dev_id)
>>       pm8001_ha = sha->lldd_ha;
>>       if (unlikely(!pm8001_ha))
>>           return IRQ_NONE;
>> -    if (!PM8001_CHIP_DISP->is_our_interupt(pm8001_ha))
>> +    if (!PM8001_CHIP_DISP->is_our_interrupt(pm8001_ha))
>>           return IRQ_NONE;
>>     #ifdef PM8001_USE_TASKLET
>> diff --git a/drivers/scsi/pm8001/pm8001_sas.h 
>> b/drivers/scsi/pm8001/pm8001_sas.h
>> index f88b0d33c385..ac6d8e3f22de 100644
>> --- a/drivers/scsi/pm8001/pm8001_sas.h
>> +++ b/drivers/scsi/pm8001/pm8001_sas.h
>> @@ -197,7 +197,7 @@ struct pm8001_dispatch {
>>       int (*chip_ioremap)(struct pm8001_hba_info *pm8001_ha);
>>       void (*chip_iounmap)(struct pm8001_hba_info *pm8001_ha);
>>       irqreturn_t (*isr)(struct pm8001_hba_info *pm8001_ha, u8 vec);
>> -    u32 (*is_our_interupt)(struct pm8001_hba_info *pm8001_ha);
>> +    u32 (*is_our_interrupt)(struct pm8001_hba_info *pm8001_ha);
>>       int (*isr_process_oq)(struct pm8001_hba_info *pm8001_ha, u8 vec);
>>       void (*interrupt_enable)(struct pm8001_hba_info *pm8001_ha, u8 
>> vec);
>>       void (*interrupt_disable)(struct pm8001_hba_info *pm8001_ha, u8 
>> vec);
>> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c 
>> b/drivers/scsi/pm8001/pm80xx_hwi.c
>> index 536d2b4384f8..301de40eb708 100644
>> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
>> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
>> @@ -4617,17 +4617,18 @@ static int pm80xx_chip_phy_ctl_req(struct 
>> pm8001_hba_info *pm8001_ha,
>>       return pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, 
>> &payload, 0);
>>   }
>>   -static u32 pm80xx_chip_is_our_interupt(struct pm8001_hba_info 
>> *pm8001_ha)
>> +static u32 pm80xx_chip_is_our_interrupt(struct pm8001_hba_info 
>> *pm8001_ha)
>>   {
>> -    u32 value;
>>   #ifdef PM8001_USE_MSIX
>>       return 1;
>> -#endif
>> +#else
>> +    u32 value;
>> +
>>       value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>>       if (value)
>>           return 1;
>>       return 0;
>> -
>> +#endif
>>   }
>>     /**
>> @@ -4724,7 +4725,7 @@ const struct pm8001_dispatch 
>> pm8001_80xx_dispatch = {
>>       .chip_rst        = pm80xx_hw_chip_rst,
>>       .chip_iounmap        = pm8001_chip_iounmap,
>>       .isr            = pm80xx_chip_isr,
>> -    .is_our_interupt    = pm80xx_chip_is_our_interupt,
>> +    .is_our_interrupt    = pm80xx_chip_is_our_interrupt,
>>       .isr_process_oq        = process_oq,
>>       .interrupt_enable    = pm80xx_chip_interrupt_enable,
>>       .interrupt_disable    = pm80xx_chip_interrupt_disable,
