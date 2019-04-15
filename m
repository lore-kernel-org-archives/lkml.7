Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7908C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8269520833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfDOGEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:04:32 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:30410 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOGEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:04:31 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 15 Apr
 2019 14:04:30 +0800
Subject: Re: [PATCH 4/4] mtd: rawnand: meson: only initialize the RB
 completion once
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <marek.vasut@gmail.com>,
        <linux-kernel@vger.kernel.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <bbrezillon@kernel.org>,
        <jianxin.pan@amlogic.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
 <20190411220056.19109-5-martin.blumenstingl@googlemail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <bd1900db-7ca1-a6e5-39f9-db54e0b570dd@amlogic.com>
Date:   Mon, 15 Apr 2019 14:04:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411220056.19109-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.125]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/12 6:00, Martin Blumenstingl wrote:
> Documentation/scheduler/completion.txt states:
>    Calling init_completion() on the same completion object twice is
>    most likely a bug as it re-initializes the queue to an empty queue and
>    enqueued tasks could get "lost" - use reinit_completion() in that case,
>    but be aware of other races.
> 
> Initialize nfc->completion in meson_nfc_probe using init_completion and
> change the call in meson_nfc_queue_rb to reinit_completion so the logic
> matches what the documentation suggests.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 57cc4bd3f665..ea57ddcec41e 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -400,7 +400,7 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>   	cfg |= NFC_RB_IRQ_EN;
>   	writel(cfg, nfc->reg_base + NFC_REG_CFG);
>   
> -	init_completion(&nfc->completion);
> +	reinit_completion(&nfc->completion);
Tested-by:Liang Yang <liang.yang@amlogic.com>
Acked-by: Liang Yang <liang.yang@amlogic.com>
>   
>   	/* use the max erase time as the maximum clock for waiting R/B */
>   	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
> @@ -1380,6 +1380,7 @@ static int meson_nfc_probe(struct platform_device *pdev)
>   
>   	nand_controller_init(&nfc->controller);
>   	INIT_LIST_HEAD(&nfc->chips);
> +	init_completion(&nfc->completion);
Tested-by:Liang Yang <liang.yang@amlogic.com>
Acked-by: Liang Yang <liang.yang@amlogic.com>
>   
>   	nfc->dev = dev;
>   
> 
