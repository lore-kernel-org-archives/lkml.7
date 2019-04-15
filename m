Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCC2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6982220663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfDOGEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:04:02 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:30057 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOGEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:04:01 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 15 Apr
 2019 14:03:59 +0800
Subject: Re: [PATCH 3/4] mtd: rawnand: meson: use a void pointer for
 meson_nfc_dma_buffer_setup
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <marek.vasut@gmail.com>,
        <linux-kernel@vger.kernel.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <bbrezillon@kernel.org>,
        <jianxin.pan@amlogic.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
 <20190411220056.19109-4-martin.blumenstingl@googlemail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <6ed284c1-ed34-9483-51a4-a79dfd0bd42c@amlogic.com>
Date:   Mon, 15 Apr 2019 14:03:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411220056.19109-4-martin.blumenstingl@googlemail.com>
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
> This simplifies the code because it gets rid of the casts to an
> u8-pointer when passing "info_buf" from struct meson_nfc_nand_chip.
> Also it gets rid of the cast of the u8 databuf pointer to a void
> pointer.
> The logic inside meson_nfc_dma_buffer_setup() doesn't care about the
> pointer types themselves because it only passes them to dma_map_single
> which accepts a void pointer.
> 
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 9a6023638101..57cc4bd3f665 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -470,15 +470,15 @@ static int meson_nfc_ecc_correct(struct nand_chip *nand, u32 *bitflips,
>   	return ret;
>   }
>   
> -static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, u8 *databuf,
> -				      int datalen, u8 *infobuf, int infolen,
> +static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, void *databuf,
> +				      int datalen, void *infobuf, int infolen,
>   				      enum dma_data_direction dir)
Tested-by:Liang Yang <liang.yang@amlogic.com>
Acked-by: Liang Yang <liang.yang@amlogic.com>
>   {
>   	struct meson_nfc *nfc = nand_get_controller_data(nand);
>   	u32 cmd;
>   	int ret = 0;
>   
> -	nfc->daddr = dma_map_single(nfc->dev, (void *)databuf, datalen, dir);
> +	nfc->daddr = dma_map_single(nfc->dev, databuf, datalen, dir);
>   	ret = dma_mapping_error(nfc->dev, nfc->daddr);
>   	if (ret) {
>   		dev_err(nfc->dev, "DMA mapping error\n");
> @@ -645,7 +645,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>   		return ret;
>   
>   	ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
> -					 data_len, (u8 *)meson_chip->info_buf,
> +					 data_len, meson_chip->info_buf,
>   					 info_len, DMA_TO_DEVICE);
Tested-by:Liang Yang <liang.yang@amlogic.com>
Acked-by: Liang Yang <liang.yang@amlogic.com>
>   	if (ret)
>   		return ret;
> @@ -729,7 +729,7 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>   		return ret;
>   
>   	ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
> -					 data_len, (u8 *)meson_chip->info_buf,
> +					 data_len, meson_chip->info_buf,
Tested-by:Liang Yang <liang.yang@amlogic.com>
Acked-by: Liang Yang <liang.yang@amlogic.com>
>   					 info_len, DMA_FROM_DEVICE);
>   	if (ret)
>   		return ret;
> 
