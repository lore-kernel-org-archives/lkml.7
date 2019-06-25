Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F155FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA24B2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHL5jm8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfFYRB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:01:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45947 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfFYRB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:01:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so9159516plb.12;
        Tue, 25 Jun 2019 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0Ss5+LU7eDAeFVRY0LXecg5U4+TVeAh5wZuoDOpiOto=;
        b=HHL5jm8ZrsVdm1c4qbx4HIt4KRKjIXNuEG9eNVTVFeSSdxsXnBc2k2jcgXkWkUW5Lt
         r3S1qyXX/nGiMj3XQRFBOl1Qe/NECxiPdCtpQpR5MgBNc+U096G0lJbzYzu81u9jFd74
         MGBMnQhsQCIXya8A+nwNYXufR/00WtKy5yU+R7pZ3ZJoKHA6arGJ53OBK4rqtLkuN1Ny
         hlBpMz5ouqzey6SrRT+dQ5/e6RTPc1cNfAZ+uasgzFGYQqjpMRuBRrfPmlMr6QjxUya1
         KnNozOOvezgntS774pdIgu5OYZNSMTPcn6MGDZHuUeE4xPYfR8A6Cu2SnrKEBwdlm10C
         tyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0Ss5+LU7eDAeFVRY0LXecg5U4+TVeAh5wZuoDOpiOto=;
        b=HLII8wovc5qZape+s3e48J3hpZBNApKviuAK699EA7XhWFozY2Avl3JZUYHKUEg11p
         4IZQYStvBHKaf03Udfp+yw8sa+Nuu5LSz3Hc1rMSqZX7rFk7nsUwn40Et3UqvP9R/tzs
         yeKzn0/59BtbmxqQc+N+Wrtsf7+a1dcZJAvCUkckIUKHb4+4Ia/iW6nb3lZ/4NhLETbg
         grsMG4Fz+9deKNGJPCH/1Q9yOftJwABXBfi5TqFllnmKzjqlUqSXp9FoqHi8NF0BGIOE
         Ax4bShXZKEhwB/VlEaZhr0Cfs6GM3HTukY13W3hfTjiXZX7DUVM8bkmDG1dlf5iWeeE2
         jXNg==
X-Gm-Message-State: APjAAAXCKUT2oOwKjdSosSctjgutaYFmNVaCX3AawLGLsbSbcZIOdqSA
        YFD+4JbqukbenIZXH65CWJcXKd6szdQ=
X-Google-Smtp-Source: APXvYqwWNlzyxKdthHKF6iYfkUVUDQ48V83ruedsMI8a4hxMMneNB+9hcg0En/c99Vls4w13WG3VXA==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr42257284plo.266.1561482085873;
        Tue, 25 Jun 2019 10:01:25 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a? ([240b:10:2720:5510:a182:288:3ffa:432a])
        by smtp.gmail.com with ESMTPSA id l2sm13465058pff.107.2019.06.25.10.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 10:01:25 -0700 (PDT)
Subject: Re: [PATCH v8 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190625075746.10439-1-vigneshr@ti.com>
 <20190625075746.10439-2-vigneshr@ti.com>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <ade6097f-bd02-1e6d-017e-cf6bd06e03bd@gmail.com>
Date:   Wed, 26 Jun 2019 02:01:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625075746.10439-2-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the fix.

Reviewed-by: Tokunori Ikegami <ikegami.t@gmail.com>

I have just tested the patch quickly on my local environment that uses 
the cfi_cmdset_0002 flash device but not HyperFlash family.
So tested as not affected by the change.

On 2019/06/25 16:57, Vignesh Raghavendra wrote:
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
> v8:
> Fix up status register polling to support banked flashes in patch 1/5.
>
>
>   drivers/mtd/chips/cfi_cmdset_0002.c | 130 ++++++++++++++++++++++++----
>   include/linux/mtd/cfi.h             |   7 ++
>   2 files changed, 120 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index c8fa5906bdf9..09f8aaf1e763 100644
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
> @@ -97,6 +107,50 @@ static struct mtd_chip_driver cfi_amdstd_chipdrv = {
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
> +	u8 poll_mask = CFI_POLL_STATUS_REG | CFI_POLL_DQ;
> +
> +	return extp->MinorVersion >= '5' &&
> +		(extp->SoftwareFeatures & poll_mask) == CFI_POLL_STATUS_REG;
> +}
> +
> +static void cfi_check_err_status(struct map_info *map, struct flchip *chip,

Just a minor comment.
I though that it is better to be called this function in chip_good() 
instead of to be called separately.
But I can understand that the chip_good() is called repeatedly in 
do_erase_chip(), do_erase_oneblock() and do_write_buffer() until timeout.
Also do_write_oneword() is also possible to be changed to call the 
chip_good() repeatedly instead of chip_ready().
So additional logics is needed to avoid the repeated error messages in 
the function above.
Anyway it is okay for the current implementation to me.

Regards,
Ikegami

> +				 unsigned long adr)
> +{
> +	struct cfi_private *cfi = map->fldrv_priv;
> +	map_word status;
> +
> +	if (!cfi_use_status_reg(cfi))
> +		return;
> +
> +	cfi_send_gen_cmd(0x70, cfi->addr_unlock1, chip->start, map, cfi,
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
> @@ -742,10 +796,25 @@ static struct mtd_info *cfi_amdstd_setup(struct mtd_info *mtd)
>    * correctly and is therefore not done	(particularly with interleaved chips
>    * as each chip must be checked independently of the others).
>    */
> -static int __xipram chip_ready(struct map_info *map, unsigned long addr)
> +static int __xipram chip_ready(struct map_info *map, struct flchip *chip,
> +			       unsigned long addr)
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
> +		cfi_send_gen_cmd(0x70, cfi->addr_unlock1, chip->start, map, cfi,
> +				 cfi->device_type, NULL);
> +		d = map_read(map, addr);
> +
> +		return map_word_andequal(map, d, ready, ready);
> +	}
> +
>   	d = map_read(map, addr);
>   	t = map_read(map, addr);
>   
> @@ -767,10 +836,30 @@ static int __xipram chip_ready(struct map_info *map, unsigned long addr)
>    * as each chip must be checked independently of the others).
>    *
>    */
> -static int __xipram chip_good(struct map_info *map, unsigned long addr, map_word expected)
> +static int __xipram chip_good(struct map_info *map, struct flchip *chip,
> +			      unsigned long addr, map_word expected)
>   {
> +	struct cfi_private *cfi = map->fldrv_priv;
>   	map_word oldd, curd;
>   
> +	if (cfi_use_status_reg(cfi)) {
> +		map_word ready = CMD(CFI_SR_DRB);
> +		map_word err = CMD(CFI_SR_PSB | CFI_SR_ESB);
> +		/*
> +		 * For chips that support status register, check device
> +		 * ready bit and Erase/Program status bit to know if
> +		 * operation succeeded.
> +		 */
> +		cfi_send_gen_cmd(0x70, cfi->addr_unlock1, chip->start, map, cfi,
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
> @@ -792,7 +881,7 @@ static int get_chip(struct map_info *map, struct flchip *chip, unsigned long adr
>   
>   	case FL_STATUS:
>   		for (;;) {
> -			if (chip_ready(map, adr))
> +			if (chip_ready(map, chip, adr))
>   				break;
>   
>   			if (time_after(jiffies, timeo)) {
> @@ -830,7 +919,7 @@ static int get_chip(struct map_info *map, struct flchip *chip, unsigned long adr
>   		chip->state = FL_ERASE_SUSPENDING;
>   		chip->erase_suspended = 1;
>   		for (;;) {
> -			if (chip_ready(map, adr))
> +			if (chip_ready(map, chip, adr))
>   				break;
>   
>   			if (time_after(jiffies, timeo)) {
> @@ -1362,7 +1451,7 @@ static int do_otp_lock(struct map_info *map, struct flchip *chip, loff_t adr,
>   	/* wait for chip to become ready */
>   	timeo = jiffies + msecs_to_jiffies(2);
>   	for (;;) {
> -		if (chip_ready(map, adr))
> +		if (chip_ready(map, chip, adr))
>   			break;
>   
>   		if (time_after(jiffies, timeo)) {
> @@ -1628,22 +1717,24 @@ static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
>   			continue;
>   		}
>   
> -		if (time_after(jiffies, timeo) && !chip_ready(map, adr)){
> +		if (time_after(jiffies, timeo) &&
> +		    !chip_ready(map, chip, adr)) {
>   			xip_enable(map, chip, adr);
>   			printk(KERN_WARNING "MTD %s(): software timeout\n", __func__);
>   			xip_disable(map, chip, adr);
>   			break;
>   		}
>   
> -		if (chip_ready(map, adr))
> +		if (chip_ready(map, chip, adr))
>   			break;
>   
>   		/* Latency issues. Drop the lock, wait a while and retry */
>   		UDELAY(map, chip, adr, 1);
>   	}
>   	/* Did we succeed? */
> -	if (!chip_good(map, adr, datum)) {
> +	if (!chip_good(map, chip, adr, datum)) {
>   		/* reset on all failures. */
> +		cfi_check_err_status(map, chip, adr);
>   		map_write(map, CMD(0xF0), chip->start);
>   		/* FIXME - should have reset delay before continuing */
>   
> @@ -1881,10 +1972,11 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
>   		 * We check "time_after" and "!chip_good" before checking "chip_good" to avoid
>   		 * the failure due to scheduling.
>   		 */
> -		if (time_after(jiffies, timeo) && !chip_good(map, adr, datum))
> +		if (time_after(jiffies, timeo) &&
> +		    !chip_good(map, chip, adr, datum))
>   			break;
>   
> -		if (chip_good(map, adr, datum)) {
> +		if (chip_good(map, chip, adr, datum)) {
>   			xip_enable(map, chip, adr);
>   			goto op_done;
>   		}
> @@ -1901,6 +1993,7 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
>   	 * See e.g.
>   	 * http://www.spansion.com/Support/Application%20Notes/MirrorBit_Write_Buffer_Prog_Page_Buffer_Read_AN.pdf
>   	 */
> +	cfi_check_err_status(map, chip, adr);
>   	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi,
>   			 cfi->device_type, NULL);
>   	cfi_send_gen_cmd(0x55, cfi->addr_unlock2, chip->start, map, cfi,
> @@ -2018,7 +2111,7 @@ static int cfi_amdstd_panic_wait(struct map_info *map, struct flchip *chip,
>   	 * If the driver thinks the chip is idle, and no toggle bits
>   	 * are changing, then the chip is actually idle for sure.
>   	 */
> -	if (chip->state == FL_READY && chip_ready(map, adr))
> +	if (chip->state == FL_READY && chip_ready(map, chip, adr))
>   		return 0;
>   
>   	/*
> @@ -2035,7 +2128,7 @@ static int cfi_amdstd_panic_wait(struct map_info *map, struct flchip *chip,
>   
>   		/* wait for the chip to become ready */
>   		for (i = 0; i < jiffies_to_usecs(timeo); i++) {
> -			if (chip_ready(map, adr))
> +			if (chip_ready(map, chip, adr))
>   				return 0;
>   
>   			udelay(1);
> @@ -2099,14 +2192,15 @@ static int do_panic_write_oneword(struct map_info *map, struct flchip *chip,
>   	map_write(map, datum, adr);
>   
>   	for (i = 0; i < jiffies_to_usecs(uWriteTimeout); i++) {
> -		if (chip_ready(map, adr))
> +		if (chip_ready(map, chip, adr))
>   			break;
>   
>   		udelay(1);
>   	}
>   
> -	if (!chip_good(map, adr, datum)) {
> +	if (!chip_good(map, chip, adr, datum)) {
>   		/* reset on all failures. */
> +		cfi_check_err_status(map, chip, adr);
>   		map_write(map, CMD(0xF0), chip->start);
>   		/* FIXME - should have reset delay before continuing */
>   
> @@ -2300,7 +2394,7 @@ static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
>   			chip->erase_suspended = 0;
>   		}
>   
> -		if (chip_good(map, adr, map_word_ff(map)))
> +		if (chip_good(map, chip, adr, map_word_ff(map)))
>   			break;
>   
>   		if (time_after(jiffies, timeo)) {
> @@ -2316,6 +2410,7 @@ static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
>   	/* Did we succeed? */
>   	if (ret) {
>   		/* reset on all failures. */
> +		cfi_check_err_status(map, chip, adr);
>   		map_write(map, CMD(0xF0), chip->start);
>   		/* FIXME - should have reset delay before continuing */
>   
> @@ -2396,7 +2491,7 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
>   			chip->erase_suspended = 0;
>   		}
>   
> -		if (chip_good(map, adr, map_word_ff(map)))
> +		if (chip_good(map, chip, adr, map_word_ff(map)))
>   			break;
>   
>   		if (time_after(jiffies, timeo)) {
> @@ -2412,6 +2507,7 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
>   	/* Did we succeed? */
>   	if (ret) {
>   		/* reset on all failures. */
> +		cfi_check_err_status(map, chip, adr);
>   		map_write(map, CMD(0xF0), chip->start);
>   		/* FIXME - should have reset delay before continuing */
>   
> @@ -2589,7 +2685,7 @@ static int __maybe_unused do_ppb_xxlock(struct map_info *map,
>   	 */
>   	timeo = jiffies + msecs_to_jiffies(2000);	/* 2s max (un)locking */
>   	for (;;) {
> -		if (chip_ready(map, adr))
> +		if (chip_ready(map, chip, adr))
>   			break;
>   
>   		if (time_after(jiffies, timeo)) {
> diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
> index 208c87cf2e3e..c98a21108688 100644
> --- a/include/linux/mtd/cfi.h
> +++ b/include/linux/mtd/cfi.h
> @@ -219,6 +219,13 @@ struct cfi_pri_amdstd {
>   	uint8_t  VppMin;
>   	uint8_t  VppMax;
>   	uint8_t  TopBottom;
> +	/* Below field are added from version 1.5 */
> +	uint8_t  ProgramSuspend;
> +	uint8_t  UnlockBypass;
> +	uint8_t  SecureSiliconSector;
> +	uint8_t  SoftwareFeatures;
> +#define CFI_POLL_STATUS_REG	BIT(0)
> +#define CFI_POLL_DQ		BIT(1)
>   } __packed;
>   
>   /* Vendor-Specific PRI for Atmel chips (command set 0x0002) */
