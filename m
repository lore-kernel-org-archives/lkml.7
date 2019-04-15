Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAC720825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfDOGBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:01:22 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:28543 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOGBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:01:21 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 15 Apr
 2019 14:01:13 +0800
Subject: Re: [PATCH 1/4] mtd: rawnand: meson: use struct_size macro
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <marek.vasut@gmail.com>,
        <linux-kernel@vger.kernel.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <bbrezillon@kernel.org>,
        <jianxin.pan@amlogic.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
 <20190411220056.19109-2-martin.blumenstingl@googlemail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <effed7e2-114d-75c3-186e-7f53b96f210d@amlogic.com>
Date:   Mon, 15 Apr 2019 14:01:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411220056.19109-2-martin.blumenstingl@googlemail.com>
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

Hello Martin and Miquel,

On 2019/4/12 6:00, Martin Blumenstingl wrote:
> Use the recently introduced struct_size macro instead of open-coding
> it's logic.
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index cb0b03e36a35..c1a6af57dab5 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -1242,8 +1242,7 @@ meson_nfc_nand_chip_init(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> -	meson_chip = devm_kzalloc(dev,
> -				  sizeof(*meson_chip) + (nsels * sizeof(u8)),
> +	meson_chip = devm_kzalloc(dev, struct_size(meson_chip, sels, nsels),
>   				  GFP_KERNEL);
Tested-by:Liang Yang <liang.yang@amlogic.com>
Acked-by: Liang Yang <liang.yang@amlogic.com>
>   	if (!meson_chip)
>   		return -ENOMEM;
> 
