Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75301C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EFB20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THWg/XKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbfFXQqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:46:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45256 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfFXQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:46:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so7828763pfq.12;
        Mon, 24 Jun 2019 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rk32yi4TS8gcxPCzX8v7QY6cOglFHE8dF0I29LG2lnc=;
        b=THWg/XKi4hT+eXURO6zCxBWh5cSpNTHmniF8SOoFsAEqFw3MYLE75X73Ad7B0Uoa/u
         Js0H1vA9IBcQT7Y2zHy34pz1g5j7v/pxeblkUMN1Rk1Xz1mPZ6gmwgJcNTFcmTXPsF08
         SrSoJKUdi3xus6naqN3TllR7GRAsM4YE9Be/qcoLjROxw2xVWemXxpRXJ/fx3Yf90u1U
         DhvS26rMMyGG74u6F2J/dT609qVBy/gKV5dk5hA9Rsm0gJVfmuByPHgw2qcLYBZUnE1x
         3KNGBWUu1sus3xLGGP5KtbBKJQ8PZnNvr48Gb77b8xwc8IJUi+KjhZ0uIdZ9udXpVBls
         p3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rk32yi4TS8gcxPCzX8v7QY6cOglFHE8dF0I29LG2lnc=;
        b=obBZZvmdXJkTWnoEI5vC0QNde4bIrk/KL7tpxd1f7ZhmhbHVzr33bTefDNSJHW1RqN
         5QDr1uPMqZwNEZ5qxlSzBhdXfyFy013Y7szBKcww8rhxYJd7eoq9I7cXyEVArprWSYGC
         T//S9JMH8G0oyo6flSdkhO8iAfRp+2Gk4siS2bE6bSi/CXOV+Esh2cWbBxl5S7y4XqSA
         9BJ9TZcfZ9Hgc/fLSeH2G+fsJW7M77hCAlgdaWJa3qFZYyJVWHEA0M4ariia9zt7n33V
         FlZ+GITTpFomfyrd1PzvDbccRYwHX8BnBM1TJwLMB5jMOqgjy+aeSK+xOgAYSe2gWyAv
         mJSg==
X-Gm-Message-State: APjAAAUlzW+cCmqheGilj+A/RlRZ2IbH+oJy8CLyBr8lSWCBvkrgUvmX
        M5EIGLv2iRzZIEOHR4Kiks0=
X-Google-Smtp-Source: APXvYqxi3TsEmcjsEdXwtgJuHHbQfba3PGZKeJ2cIWYwMjOqJarwHX0qFk08wKvYtbaSkUp58mDLAA==
X-Received: by 2002:a17:90a:c504:: with SMTP id k4mr25698395pjt.104.1561394778617;
        Mon, 24 Jun 2019 09:46:18 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a? ([240b:10:2720:5510:a182:288:3ffa:432a])
        by smtp.gmail.com with ESMTPSA id y22sm15041975pgj.38.2019.06.24.09.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:46:17 -0700 (PDT)
Subject: Re: [PATCH v7 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org
References: <20190620172250.9102-1-vigneshr@ti.com>
 <20190620172250.9102-2-vigneshr@ti.com>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <571484c7-0cf4-6a7d-6d7f-375cfb13ce8b@gmail.com>
Date:   Tue, 25 Jun 2019 01:46:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190620172250.9102-2-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/06/21 2:22, Vignesh Raghavendra wrote:
> HyperFlash devices are compliant with CFI AMD/Fujitsu Extended Command
> Set (0x0002) for flash operations, therefore
> drivers/mtd/chips/cfi_cmdset_0002.c can be used as is. But these devices
> do not support DQ polling method of determining chip ready/good status.
> These flashes provide Status Register whose bits can be polled to know
> status of flash operation.
>
> Cypress HyperFlash datasheet here[1], talks about CFI Amd/Fujitsu
> Extended Query version 1.5. Bit 0 of "Software Features supported" field
> of CFI Primary Vendor-Specific Extended Query table indicates
> presence/absence of status register and Bit 1 indicates whether or not
> DQ polling is supported. Using these bits, its possible to determine
> whether flash supports DQ polling or need to use Status Register.
>
> Add support for polling Status Register to know device ready/status of
> erase/write operations when DQ polling is not supported.
> Print error messages on erase/program failure by looking at related
> Status Register bits.
>
> [1] https://www.cypress.com/file/213346/download
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> v7: No change
>
>   drivers/mtd/chips/cfi_cmdset_0002.c | 90 +++++++++++++++++++++++++++++
>   include/linux/mtd/cfi.h             |  5 ++
>   2 files changed, 95 insertions(+)
>
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index c8fa5906bdf9..0f571f162e3b 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -49,6 +49,16 @@
>   #define SST49LF008A		0x005a
>   #define AT49BV6416		0x00d6
>   
> +/*
> + * Status Register bit description. Used by flash devices that don't
> + * support DQ polling (e.g. HyperFlash)
> + */
> +#define CFI_SR_DRB		BIT(7)
> +#define CFI_SR_ESB		BIT(5)
> +#define CFI_SR_PSB		BIT(4)
> +#define CFI_SR_WBASB		BIT(3)
> +#define CFI_SR_SLSB		BIT(1)
> +
>   static int cfi_amdstd_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
>   static int cfi_amdstd_write_words(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
>   static int cfi_amdstd_write_buffers(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
> @@ -97,6 +107,48 @@ static struct mtd_chip_driver cfi_amdstd_chipdrv = {
>   	.module		= THIS_MODULE
>   };
>   
> +/*
> + * Use status register to poll for Erase/write completion when DQ is not
> + * supported. This is indicated by Bit[1:0] of SoftwareFeatures field in
> + * CFI Primary Vendor-Specific Extended Query table 1.5
> + */
> +static int cfi_use_status_reg(struct cfi_private *cfi)
> +{
> +	struct cfi_pri_amdstd *extp = cfi->cmdset_priv;
> +
> +	return extp->MinorVersion >= '5' &&
> +		(extp->SoftwareFeatures & 0x3) == 0x1;

Seems to be better to use defined values instead of 0x3 and 0x1 hard 
coded values.

> +}
> +
> +static void cfi_check_err_status(struct map_info *map, unsigned long adr)
> +{
> +	struct cfi_private *cfi = map->fldrv_priv;
> +	map_word status;
> +
> +	if (!cfi_use_status_reg(cfi))
> +		return;
> +
> +	cfi_send_gen_cmd(0x70, cfi->addr_unlock1, 0, map, cfi,

Is it not necessary to set chip->start as the base parameter for 
cfi_send_gen_cmd()?

> +			 cfi->device_type, NULL);
> +	status = map_read(map, adr);
> +
> +	if (map_word_bitsset(map, status, CMD(0x3a))) {
> +		unsigned long chipstatus = MERGESTATUS(status);
> +
> +		if (chipstatus & CFI_SR_ESB)
> +			pr_err("%s erase operation failed, status %lx\n",
> +			       map->name, chipstatus);
> +		if (chipstatus & CFI_SR_PSB)
> +			pr_err("%s program operation failed, status %lx\n",
> +			       map->name, chipstatus);
> +		if (chipstatus & CFI_SR_WBASB)
> +			pr_err("%s buffer program command aborted, status %lx\n",
> +			       map->name, chipstatus);
> +		if (chipstatus & CFI_SR_SLSB)
> +			pr_err("%s sector write protected, status %lx\n",
> +			       map->name, chipstatus);
> +	}
> +}
>   
>   /* #define DEBUG_CFI_FEATURES */
>   
> @@ -744,8 +796,22 @@ static struct mtd_info *cfi_amdstd_setup(struct mtd_info *mtd)
>    */
>   static int __xipram chip_ready(struct map_info *map, unsigned long addr)
>   {
> +	struct cfi_private *cfi = map->fldrv_priv;
>   	map_word d, t;
>   
> +	if (cfi_use_status_reg(cfi)) {
> +		map_word ready = CMD(CFI_SR_DRB);
> +		/*
> +		 * For chips that support status register, check device
> +		 * ready bit
> +		 */
> +		cfi_send_gen_cmd(0x70, cfi->addr_unlock1, 0, map, cfi,

Same comment as cfi_check_err_status() about the base address.

> +				 cfi->device_type, NULL);
> +		d = map_read(map, addr);
> +
> +		return map_word_andequal(map, d, ready, ready);
> +	}
> +
>   	d = map_read(map, addr);
>   	t = map_read(map, addr);
>   
> @@ -769,8 +835,27 @@ static int __xipram chip_ready(struct map_info *map, unsigned long addr)
>    */
>   static int __xipram chip_good(struct map_info *map, unsigned long addr, map_word expected)
>   {
> +	struct cfi_private *cfi = map->fldrv_priv;
>   	map_word oldd, curd;
>   
> +	if (cfi_use_status_reg(cfi)) {
> +		map_word ready = CMD(CFI_SR_DRB);
> +		map_word err = CMD(CFI_SR_PSB | CFI_SR_ESB);

Is it not necessary to check CFI_SR_WBASB and CFI_SR_SLSB that are 
checked by cfi_check_err_status()?

> +		/*
> +		 * For chips that support status register, check device
> +		 * ready bit and Erase/Program status bit to know if
> +		 * operation succeeded.
> +		 */
> +		cfi_send_gen_cmd(0x70, cfi->addr_unlock1, 0, map, cfi,

Same as cfi_check_err_status() and chip_ready() about the base address.

> +				 cfi->device_type, NULL);
> +		curd = map_read(map, addr);
> +
> +		if (map_word_andequal(map, curd, ready, ready))
> +			return !map_word_bitsset(map, curd, err);
> +
> +		return 0;
> +	}
> +
>   	oldd = map_read(map, addr);
>   	curd = map_read(map, addr);
>   
> @@ -1644,6 +1729,7 @@ static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
>   	/* Did we succeed? */
>   	if (!chip_good(map, adr, datum)) {
>   		/* reset on all failures. */
> +		cfi_check_err_status(map, adr);
>   		map_write(map, CMD(0xF0), chip->start);
>   		/* FIXME - should have reset delay before continuing */
>   
> @@ -1901,6 +1987,7 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
>   	 * See e.g.
>   	 * http://www.spansion.com/Support/Application%20Notes/MirrorBit_Write_Buffer_Prog_Page_Buffer_Read_AN.pdf
>   	 */
> +	cfi_check_err_status(map, adr);
>   	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi,
>   			 cfi->device_type, NULL);
>   	cfi_send_gen_cmd(0x55, cfi->addr_unlock2, chip->start, map, cfi,
> @@ -2107,6 +2194,7 @@ static int do_panic_write_oneword(struct map_info *map, struct flchip *chip,
>   
>   	if (!chip_good(map, adr, datum)) {
>   		/* reset on all failures. */
> +		cfi_check_err_status(map, adr);
>   		map_write(map, CMD(0xF0), chip->start);
>   		/* FIXME - should have reset delay before continuing */
>   
> @@ -2316,6 +2404,7 @@ static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
>   	/* Did we succeed? */
>   	if (ret) {
>   		/* reset on all failures. */
> +		cfi_check_err_status(map, adr);
>   		map_write(map, CMD(0xF0), chip->start);
>   		/* FIXME - should have reset delay before continuing */
>   
> @@ -2412,6 +2501,7 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
>   	/* Did we succeed? */
>   	if (ret) {
>   		/* reset on all failures. */
> +		cfi_check_err_status(map, adr);
>   		map_write(map, CMD(0xF0), chip->start);
>   		/* FIXME - should have reset delay before continuing */
>   
> diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
> index 208c87cf2e3e..b50416169049 100644
> --- a/include/linux/mtd/cfi.h
> +++ b/include/linux/mtd/cfi.h
> @@ -219,6 +219,11 @@ struct cfi_pri_amdstd {
>   	uint8_t  VppMin;
>   	uint8_t  VppMax;
>   	uint8_t  TopBottom;
> +	/* Below field are added from version 1.5 */
> +	uint8_t  ProgramSuspend;
> +	uint8_t  UnlockBypass;
> +	uint8_t  SecureSiliconSector;
> +	uint8_t  SoftwareFeatures;
>   } __packed;
>   
>   /* Vendor-Specific PRI for Atmel chips (command set 0x0002) */
