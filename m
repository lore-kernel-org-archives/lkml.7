Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AEF20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDEVpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:45:02 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34379 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfDEVo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:44:58 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id F1A07E0003;
        Fri,  5 Apr 2019 21:44:54 +0000 (UTC)
Date:   Fri, 5 Apr 2019 23:44:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Han Nandor <nandor.han@vaisala.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] rtc: ds3232: get SRAM access using NVMEM Framework
Message-ID: <20190405214454.GJ22216@piout.net>
References: <20190405111348.28935-1-nandor.han@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405111348.28935-1-nandor.han@vaisala.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/04/2019 11:14:35+0000, Han Nandor wrote:
> DS3232 RTC has 236 bytes of persistent memory.
> 
> Add RTC SRAM read and write access using
> the NVMEM Framework.
> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
> 
> Description
> -----------
> Provides DS3232 RTC SRAM access using NVMEM framework.
> 
> Testing
> -------
> The test was done on a custom board which contains a
> DS3232 RTC device.
> Kernel Version: 4.14.60 (Just for clarity, the patch is against master)
> 
> 1. Verify that SRAM is accessible using NVMEM interface: PASS
> `
> # hexdump /sys/bus/nvmem/devices/ds3232_sram0/nvmem
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 00000e0
> `
> 2. Modify the content.
> `
> # echo testing > /sys/bus/nvmem/devices/ds3232_sram0/nvmem
> #
> `
> 3. Power cycle the board and verify that contents are preserved: PASS
> `
> # hexdump -n 10 -C /sys/bus/nvmem/devices/ds3232_sram0/nvmem
> 00000000  74 65 73 74 69 6e 67 0a  00 00                    |testing...|
> 0000000a
> `
> 

Thanks for that nice description!

>  drivers/rtc/rtc-ds3232.c | 41 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> index 7184e5145f12..fe615aedaa9a 100644
> --- a/drivers/rtc/rtc-ds3232.c
> +++ b/drivers/rtc/rtc-ds3232.c
> @@ -24,6 +24,8 @@
>  #include <linux/regmap.h>
>  #include <linux/hwmon.h>
>  
> +#include "rtc-core.h"
> +

The drivers should not have to include that header, see
fd5cd21d995e67f87b3eb4adf938be85fe83ef4b (from 4.16).

>  #define DS3232_REG_SECONDS      0x00
>  #define DS3232_REG_MINUTES      0x01
>  #define DS3232_REG_HOURS        0x02
> @@ -48,12 +50,17 @@
>  #       define DS3232_REG_SR_A1F     0x01
>  
>  #define DS3232_REG_TEMPERATURE	0x11
> +#define DS3232_REG_SRAM_START   0x14
> +#define DS3232_REG_SRAM_END     0xFF
> +
> +#define DS3232_REG_SRAM_SIZE    236
>  

>  struct ds3232 {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	int irq;
>  	struct rtc_device *rtc;
> +	struct nvmem_config	nvmem_cfg;
>  

You don't actually need to keep that structure for the whole life of the
device as it is copied as soon as it is registered. I usually prefer to
have it on the stack.

>  	bool suspended;
>  };
> @@ -461,6 +468,24 @@ static const struct rtc_class_ops ds3232_rtc_ops = {
>  	.alarm_irq_enable = ds3232_alarm_irq_enable,
>  };
>  
> +static int ds3232_nvmem_read(void *priv, unsigned int offset, void *val,
> +			     size_t bytes)
> +{
> +	struct ds3232 *ds3232 = (struct ds3232 *)priv;
> +
> +	return regmap_bulk_read(ds3232->regmap, DS3232_REG_SRAM_START + offset,
> +				val, bytes);
> +}
> +
> +static int ds3232_nvmem_write(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{
> +	struct ds3232 *ds3232 = (struct ds3232 *)priv;
> +
> +	return regmap_bulk_write(ds3232->regmap, DS3232_REG_SRAM_START + offset,
> +				 val, bytes);
> +}
> +
>  static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>  			const char *name)
>  {
> @@ -476,6 +501,14 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>  	ds3232->dev = dev;
>  	dev_set_drvdata(dev, ds3232);
>  
> +	ds3232->nvmem_cfg.name = "ds3232_sram";
> +	ds3232->nvmem_cfg.stride = 1;
> +	ds3232->nvmem_cfg.size = DS3232_REG_SRAM_SIZE;
> +	ds3232->nvmem_cfg.word_size = 1;
> +	ds3232->nvmem_cfg.reg_read = ds3232_nvmem_read;
> +	ds3232->nvmem_cfg.reg_write = ds3232_nvmem_write;
> +	ds3232->nvmem_cfg.priv = ds3232;

Please also set the type (battery backed).

> +
>  	ret = ds3232_check_rtc_status(dev);
>  	if (ret)
>  		return ret;
> @@ -490,6 +523,10 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>  	if (IS_ERR(ds3232->rtc))
>  		return PTR_ERR(ds3232->rtc);
>  
> +	ds3232->rtc->dev.of_node = dev->of_node;

Please don't mess with rtc->dev.

> +	ds3232->rtc->nvmem_config = &ds3232->nvmem_cfg;
> +	rtc_nvmem_register(ds3232->rtc);

This part will not compile on v5.1-rc1.

> +
>  	if (ds3232->irq > 0) {
>  		ret = devm_request_threaded_irq(dev, ds3232->irq, NULL,
>  						ds3232_irq,
> @@ -542,7 +579,7 @@ static int ds3232_i2c_probe(struct i2c_client *client,
>  	static const struct regmap_config config = {
>  		.reg_bits = 8,
>  		.val_bits = 8,
> -		.max_register = 0x13,
> +		.max_register = DS3232_REG_SRAM_END,
>  	};
>  
>  	regmap = devm_regmap_init_i2c(client, &config);
> @@ -609,7 +646,7 @@ static int ds3234_probe(struct spi_device *spi)
>  	static const struct regmap_config config = {
>  		.reg_bits = 8,
>  		.val_bits = 8,
> -		.max_register = 0x13,
> +		.max_register = DS3232_REG_SRAM_END,
>  		.write_flag_mask = 0x80,
>  	};
>  	struct regmap *regmap;
> -- 
> 2.17.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
