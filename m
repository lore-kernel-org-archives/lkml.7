Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA51FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BF7218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pHkKQ/LI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P2Denelq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfC2UI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:08:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbfC2UI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:08:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B58E6079C; Fri, 29 Mar 2019 20:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553890106;
        bh=UmAeqrYgORAQU1P7uA+dzqDjikUQdc0mD1x4bfTKj+k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pHkKQ/LISwXgwVrWJh5lB3q4++bxdCYj6F5al9peMEE7GyH9HqoNzXl046uBvOW82
         Xty4YniU8ZWnXf+vW1A/kI0JM+WGh0Xj/P7wKJg7t3RgEi7hPT9oblwEyA3pMgCrUE
         sTwg/osvnwoE4ncqM+77iRXQ0TGHnn0JZLYitxDE=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03E2C605A2;
        Fri, 29 Mar 2019 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553890105;
        bh=UmAeqrYgORAQU1P7uA+dzqDjikUQdc0mD1x4bfTKj+k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P2Denelqjz3TgvlD+0P0qcBRc4F0KTH0HOUszXykTdE+ZxYvGhN7ZzLu3DoNv1ncM
         l5lqaV/HrP2jfrnU8JtDdfAvQzilhQ4djA1qT+VwPS/z+2K3w7qzpwaavSGvb0L0/k
         DfvExRchjCPT2snAG5etQe0rTuXdGTqFJtICzSa8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03E2C605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scsi: pm8001: clean up structurally dead code when
 PM8001_USE_MSIX is defined (part2)
To:     Colin King <colin.king@canonical.com>,
        Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190329153221.29238-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <0c08b258-e61d-60ee-7702-728fa96c435d@codeaurora.org>
Date:   Sat, 30 Mar 2019 01:38:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329153221.29238-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 9:02 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> When macro PM8001_USE_MSIX is defined there is redundant dead code
> call to pm8001_cr32.  Clean this up for the defined PM8001_USE_MSIX and
> undefined PM8001_USE_MSIX cases.
>
> Also rename the functions pm8001_chip_is_our_interupt,
> pm80xx_chip_is_our_interupt and function pointer is_our_interrupt
> to fix spelling mistakes.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

It would be better if you could split this into two patch, one for dead 
code and other for renaming.

Otherwise change looks good.

Once you fix above you could include .
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh


> ---
>   drivers/scsi/pm8001/pm8001_hwi.c  | 11 ++++++-----
>   drivers/scsi/pm8001/pm8001_init.c |  4 ++--
>   drivers/scsi/pm8001/pm8001_sas.h  |  2 +-
>   drivers/scsi/pm8001/pm80xx_hwi.c  | 11 ++++++-----
>   4 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index e4209091c1da..627075d00918 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -4623,17 +4623,18 @@ static int pm8001_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
>   	return ret;
>   }
>   
> -static u32 pm8001_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
> +static u32 pm8001_chip_is_our_interrupt(struct pm8001_hba_info *pm8001_ha)
>   {
> -	u32 value;
>   #ifdef PM8001_USE_MSIX
>   	return 1;
> -#endif
> +#else
> +	u32 value;
> +
>   	value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>   	if (value)
>   		return 1;
>   	return 0;
> -
> +#endif
>   }
>   
>   /**
> @@ -5119,7 +5120,7 @@ const struct pm8001_dispatch pm8001_8001_dispatch = {
>   	.chip_rst		= pm8001_hw_chip_rst,
>   	.chip_iounmap		= pm8001_chip_iounmap,
>   	.isr			= pm8001_chip_isr,
> -	.is_our_interupt	= pm8001_chip_is_our_interupt,
> +	.is_our_interrupt	= pm8001_chip_is_our_interrupt,
>   	.isr_process_oq		= process_oq,
>   	.interrupt_enable 	= pm8001_chip_interrupt_enable,
>   	.interrupt_disable	= pm8001_chip_interrupt_disable,
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index a36060c23b37..3374f553c617 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -201,7 +201,7 @@ static irqreturn_t pm8001_interrupt_handler_msix(int irq, void *opaque)
>   
>   	if (unlikely(!pm8001_ha))
>   		return IRQ_NONE;
> -	if (!PM8001_CHIP_DISP->is_our_interupt(pm8001_ha))
> +	if (!PM8001_CHIP_DISP->is_our_interrupt(pm8001_ha))
>   		return IRQ_NONE;
>   #ifdef PM8001_USE_TASKLET
>   	tasklet_schedule(&pm8001_ha->tasklet[irq_vector->irq_id]);
> @@ -224,7 +224,7 @@ static irqreturn_t pm8001_interrupt_handler_intx(int irq, void *dev_id)
>   	pm8001_ha = sha->lldd_ha;
>   	if (unlikely(!pm8001_ha))
>   		return IRQ_NONE;
> -	if (!PM8001_CHIP_DISP->is_our_interupt(pm8001_ha))
> +	if (!PM8001_CHIP_DISP->is_our_interrupt(pm8001_ha))
>   		return IRQ_NONE;
>   
>   #ifdef PM8001_USE_TASKLET
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index f88b0d33c385..ac6d8e3f22de 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -197,7 +197,7 @@ struct pm8001_dispatch {
>   	int (*chip_ioremap)(struct pm8001_hba_info *pm8001_ha);
>   	void (*chip_iounmap)(struct pm8001_hba_info *pm8001_ha);
>   	irqreturn_t (*isr)(struct pm8001_hba_info *pm8001_ha, u8 vec);
> -	u32 (*is_our_interupt)(struct pm8001_hba_info *pm8001_ha);
> +	u32 (*is_our_interrupt)(struct pm8001_hba_info *pm8001_ha);
>   	int (*isr_process_oq)(struct pm8001_hba_info *pm8001_ha, u8 vec);
>   	void (*interrupt_enable)(struct pm8001_hba_info *pm8001_ha, u8 vec);
>   	void (*interrupt_disable)(struct pm8001_hba_info *pm8001_ha, u8 vec);
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 536d2b4384f8..301de40eb708 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4617,17 +4617,18 @@ static int pm80xx_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
>   	return pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload, 0);
>   }
>   
> -static u32 pm80xx_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
> +static u32 pm80xx_chip_is_our_interrupt(struct pm8001_hba_info *pm8001_ha)
>   {
> -	u32 value;
>   #ifdef PM8001_USE_MSIX
>   	return 1;
> -#endif
> +#else
> +	u32 value;
> +
>   	value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>   	if (value)
>   		return 1;
>   	return 0;
> -
> +#endif
>   }
>   
>   /**
> @@ -4724,7 +4725,7 @@ const struct pm8001_dispatch pm8001_80xx_dispatch = {
>   	.chip_rst		= pm80xx_hw_chip_rst,
>   	.chip_iounmap		= pm8001_chip_iounmap,
>   	.isr			= pm80xx_chip_isr,
> -	.is_our_interupt	= pm80xx_chip_is_our_interupt,
> +	.is_our_interrupt	= pm80xx_chip_is_our_interrupt,
>   	.isr_process_oq		= process_oq,
>   	.interrupt_enable	= pm80xx_chip_interrupt_enable,
>   	.interrupt_disable	= pm80xx_chip_interrupt_disable,
