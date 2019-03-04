Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E132DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12D020835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfCDC2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:28:50 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:51157 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDC2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:28:49 -0500
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 4 Mar
 2019 10:29:54 +0800
Subject: Re: [PATCH 2/2] mtd: rawnand: meson: fix a potential memory leak in
 meson_nfc_read_buf
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>
CC:     <bbrezillon@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <jianxin.pan@amlogic.com>,
        <linux-kernel@vger.kernel.org>
References: <20190301173820.30776-1-martin.blumenstingl@googlemail.com>
 <20190301173820.30776-3-martin.blumenstingl@googlemail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <c152e9a7-55ce-424c-8468-a4e861792582@amlogic.com>
Date:   Mon, 4 Mar 2019 10:29:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301173820.30776-3-martin.blumenstingl@googlemail.com>
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

Hello Martin,

Thank you very much.

On 2019/3/2 1:38, Martin Blumenstingl wrote:
> meson_nfc_dma_buffer_setup() is called with the "info" buffer which is
> allocated a few lines before using kzalloc(). If
> meson_nfc_dma_buffer_setup() fails we need to free the allocated "info"
> buffer instead of only freeing it upon success.
> 
> Fixes: 8fae856c53500a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index a1d8506b61c7..38db4fd61459 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -534,7 +534,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>   	ret = meson_nfc_dma_buffer_setup(nand, buf, len, info,
>   					 PER_INFO_BYTE, DMA_FROM_DEVICE);
>   	if (ret)
> -		return ret;
> +		goto out;
>   Looks good to me.
Acked-by: Liang Yang <liang.yang@amlogic.com>

>   	cmd = NFC_CMD_N2M | (len & GENMASK(5, 0));
>   	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> @@ -542,6 +542,8 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>   	meson_nfc_drain_cmd(nfc);
>   	meson_nfc_wait_cmd_finish(nfc, 1000);
>   	meson_nfc_dma_buffer_release(nand, len, PER_INFO_BYTE, DMA_FROM_DEVICE);
> +
> +out:
Looks good to me.
Acked-by: Liang Yang <liang.yang@amlogic.com>
>   	kfree(info);
>   
>   	return ret;
> 
