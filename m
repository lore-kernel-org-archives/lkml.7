Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF4BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555C220825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfDOGCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:02:30 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:29247 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:02:29 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 15 Apr
 2019 14:02:28 +0800
Subject: Re: [PATCH 2/4] mtd: rawnand: meson: use
 of_property_count_elems_of_size helper
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <marek.vasut@gmail.com>,
        <linux-kernel@vger.kernel.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <bbrezillon@kernel.org>,
        <jianxin.pan@amlogic.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
 <20190411220056.19109-3-martin.blumenstingl@googlemail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <e96ea061-5d5f-de59-cd64-0239d81b9a13@amlogic.com>
Date:   Mon, 15 Apr 2019 14:02:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411220056.19109-3-martin.blumenstingl@googlemail.com>
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
> Use the of_property_count_elems_of_size() helper instead of open-coding
> it's logic. As a bonus this will now error out if the "reg" property
> values use an incorrect size (anything other than sizeof(u32)).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index c1a6af57dab5..9a6023638101 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -1233,10 +1233,7 @@ meson_nfc_nand_chip_init(struct device *dev,
>   	int ret, i;
>   	u32 tmp, nsels;
>   
> -	if (!of_get_property(np, "reg", &nsels))
> -		return -EINVAL;
> -
> -	nsels /= sizeof(u32);
> +	nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
Tested-by:Liang Yang <liang.yang@amlogic.com>
Acked-by: Liang Yang <liang.yang@amlogic.com>
>   	if (!nsels || nsels > MAX_CE_NUM) {
>   		dev_err(dev, "invalid register property size\n");
>   		return -EINVAL;
> 
