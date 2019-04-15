Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F44BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BC9206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT3Vyx+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfDONVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:21:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37141 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfDONVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:21:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so8574055ply.4;
        Mon, 15 Apr 2019 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cng98D1sLtFny7NfKUTJmzPVb2Gs1r7JU5Dqd1xYT/4=;
        b=MT3Vyx+ai2dLIr/Ayy2hZfQmcy2Jd4Qgdq7/5XVTDwowB0ctBt8/kNhL4ukv7bCgw9
         shk8UIxGqNRaxLL3b94D+KU1ue8iKZzyA4+xMqPlsbUmgFAMU0NNEO9v0L3J1QlX/JME
         wJYptjPGs+ZhHA8ha2UUA/Z4eEbce8RTly3KIfetl3Woki8WnafgpUP7V/KHrOevLPVQ
         gxfjsH+Wok1JoWlr8sh+jCaSNkDhJwwGjgj1yU4BEHc1Ix/fbFIOeHGMFgmhBOEG56uV
         EbwETC3H0wutBwD1Q49pK1m0lPkv7r6fskP7qE0GV6RhWuOVkl699EJUS0coTHpuMCU5
         rSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cng98D1sLtFny7NfKUTJmzPVb2Gs1r7JU5Dqd1xYT/4=;
        b=EWCnHAU1msp0xfzQzmXflWxPeA0GVCHP++mVJmflCBc1UL+2SLEXSZuDeZRLmNUAwy
         mctCFVSNNHn4qNt7iDhdN2U6tHSPonLpNwjjCMB+XlqSDgZk2rpA4zGvoTMj1ESBd4gQ
         x8dWY0fs1hIIZm3WE+nM1+kFgSF8O2QPimIyFLliCQRVHCiNmFNs9QChi0lixMXVcEI5
         8LP8igQ6U07g0ogo/ivzbvqgZG19jlfOdX51S79EcZQzQ4taU5npfF1oT+t6Iw1LH19s
         n5N0RiBnxfFTe0tjhdR9v1FYlMpKdGw5nhDQhnU757FsN1eNkoUL70G193qk6SFLeqfV
         mlAA==
X-Gm-Message-State: APjAAAXHS+ZfXREFC4s1/QZNf8dkDOqOi8ZUqnd8g0kqVV9biU/QxssU
        sST/aqGh2cdFO07LcIfKO4UdhXdi
X-Google-Smtp-Source: APXvYqycmG/9/xyqgR/FudbsBmexxeZ42ZIxP9a8s99yg0VlYEyEHPjXBi1KkQ6xgdmjXH0eZCpwbg==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr42752103pla.78.1555334467384;
        Mon, 15 Apr 2019 06:21:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h187sm97430125pfc.52.2019.04.15.06.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:21:05 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] misc: npcm: add NPCM LPC BPC driver
To:     Tomer Maimon <tmaimon77@gmail.com>, gregkh@linuxfoundation.org,
        arnd@arnd.de, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190415121235.255028-1-tmaimon77@gmail.com>
 <20190415121235.255028-3-tmaimon77@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e47e88b5-5aac-cf9b-b54c-228f80501fa9@roeck-us.net>
Date:   Mon, 15 Apr 2019 06:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415121235.255028-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 5:12 AM, Tomer Maimon wrote:
> Add Nuvoton BMC NPCM BIOS post code (BPC) driver.
> 
> The NPCM BPC monitoring two I/O address written by
> the host on the Low Pin Count (LPC) bus, the capure
> data stored in 128-word FIFO.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>   drivers/misc/Kconfig              |   8 +
>   drivers/misc/Makefile             |   1 +
>   drivers/misc/npcm-lpc-bpc-snoop.c | 393 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 402 insertions(+)
>   create mode 100644 drivers/misc/npcm-lpc-bpc-snoop.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 42ab8ec92a04..320a1d0083d2 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -532,6 +532,14 @@ config PVPANIC
>   	  a paravirtualized device provided by QEMU; it lets a virtual machine
>   	  (guest) communicate panic events to the host.
>   
> +config NPCM_LPC_BPC_SNOOP
> +	tristate "NPCM LPC BIOS Post Code snoop support"
> +	depends on (ARCH_NPCM || COMPILE_TEST)
> +	help
> +	  Provides a NPCM BMC driver to control the LPC BIOS Post Code
> +	  interface which allows the BMC to monitoring and save
> +	  the data written by the host to an arbitrary LPC I/O port.
> +
>   source "drivers/misc/c2port/Kconfig"
>   source "drivers/misc/eeprom/Kconfig"
>   source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index d5b7d3404dc7..5dd0bff75b60 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -59,5 +59,6 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>   obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>   obj-$(CONFIG_OCXL)		+= ocxl/
>   obj-y				+= cardreader/
> +obj-$(CONFIG_NPCM_LPC_BPC_SNOOP) += npcm-lpc-bpc-snoop.o
>   obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
>   obj-$(CONFIG_HABANA_AI)		+= habanalabs/
> diff --git a/drivers/misc/npcm-lpc-bpc-snoop.c b/drivers/misc/npcm-lpc-bpc-snoop.c
> new file mode 100644
> index 000000000000..851994184076
> --- /dev/null
> +++ b/drivers/misc/npcm-lpc-bpc-snoop.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2014-2018 Nuvoton Technology corporation.
> +
> +#include <linux/fs.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/kfifo.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/miscdevice.h>
> +#include <linux/poll.h>
> +
> +#define DEVICE_NAME	"npcm-lpc-bpc"
> +
> +#define NUM_BPC_CHANNELS		2
> +#define DW_PAD_SIZE			3
> +
> +/* BIOS POST Code FIFO Registers */
> +#define NPCM_BPCFA2L_REG	0x2 //BIOS POST Code FIFO Address 2 LSB
> +#define NPCM_BPCFA2M_REG	0x4 //BIOS POST Code FIFO Address 2 MSB
> +#define NPCM_BPCFEN_REG	0x6 //BIOS POST Code FIFO Enable
> +#define NPCM_BPCFSTAT_REG	0x8 //BIOS POST Code FIFO Status
> +#define NPCM_BPCFDATA_REG	0xA //BIOS POST Code FIFO Data
> +#define NPCM_BPCFMSTAT_REG	0xC //BIOS POST Code FIFO Miscellaneous Status
> +#define NPCM_BPCFA1L_REG	0x10 //BIOS POST Code FIFO Address 1 LSB
> +#define NPCM_BPCFA1M_REG	0x12 //BIOS POST Code FIFO Address 1 MSB
> +
> +/*BIOS regiser data*/
> +#define FIFO_IOADDR1_ENABLE	0x80
> +#define FIFO_IOADDR2_ENABLE	0x40
> +
> +/* BPC interface package and structure definition */
> +#define BPC_KFIFO_SIZE		0x400
> +
> +/*BPC regiser data*/
> +#define FIFO_DATA_VALID		0x80
> +#define FIFO_OVERFLOW		0x20
> +#define FIFO_READY_INT_ENABLE	0x8
> +#define FIFO_DWCAPTURE		0x4
> +#define FIFO_ADDR_DECODE	0x1
> +
> +/*Host Reset*/
> +#define HOST_RESET_INT_ENABLE	0x10
> +#define HOST_RESET_CHANGED	0x40
> +
> +struct npcm_bpc_channel {
> +	struct npcm_bpc	*data;
> +	struct kfifo		fifo;
> +	wait_queue_head_t	wq;
> +	bool			host_reset;
> +	struct miscdevice	miscdev;
> +};
> +
> +struct npcm_bpc {
> +	void __iomem			*base;
> +	int				irq;
> +	bool				en_dwcap;
> +	struct npcm_bpc_channel	ch[NUM_BPC_CHANNELS];
> +};
> +
> +static struct npcm_bpc_channel *npcm_file_to_ch(struct file *file)
> +{
> +	return container_of(file->private_data, struct npcm_bpc_channel,
> +			    miscdev);
> +}
> +
> +static ssize_t npcm_bpc_read(struct file *file, char __user *buffer,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct npcm_bpc_channel *chan = npcm_file_to_ch(file);
> +	struct npcm_bpc *lpc_bpc = chan->data;
> +	unsigned int copied;
> +	int ret = 0;
> +	int cond_size = 1;
> +
> +	if (lpc_bpc->en_dwcap)
> +		cond_size = 3;
> +
> +	if (kfifo_len(&chan->fifo) < cond_size) {
> +		if (file->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		ret = wait_event_interruptible
> +			(chan->wq, kfifo_len(&chan->fifo) > cond_size);
> +		if (ret == -ERESTARTSYS)
> +			return -EINTR;
> +	}
> +
> +	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> +
> +	return ret ? ret : copied;
> +}
> +
> +static __poll_t npcm_bpc_poll(struct file *file, struct poll_table_struct *pt)
> +{
> +	struct npcm_bpc_channel *chan = npcm_file_to_ch(file);
> +	__poll_t mask = 0;
> +
> +	poll_wait(file, &chan->wq, pt);
> +	if (!kfifo_is_empty(&chan->fifo))
> +		mask |= POLLIN;
> +
> +	if (chan->host_reset) {
> +		mask |= POLLHUP;
> +		chan->host_reset = false;
> +	}
> +
> +	return mask;
> +}
> +
> +static const struct file_operations npcm_bpc_fops = {
> +	.owner		= THIS_MODULE,
> +	.read		= npcm_bpc_read,
> +	.poll		= npcm_bpc_poll,
> +	.llseek		= noop_llseek,
> +};
> +
> +static irqreturn_t npcm_bpc_irq(int irq, void *arg)
> +{
> +	struct npcm_bpc *lpc_bpc = arg;
> +	u8 fifo_st;
> +	u8 host_st;
> +	u8 addr_index = 0;
> +	u8 Data;
> +	u8 padzero[3] = {0};
> +	u8 last_addr_bit = 0;
> +	bool isr_flag = false;
> +
> +	fifo_st = ioread8(lpc_bpc->base + NPCM_BPCFSTAT_REG);
> +	while (FIFO_DATA_VALID & fifo_st) {
> +		 /* If dwcapture enabled only channel 0 (FIFO 0) used */
> +		if (!lpc_bpc->en_dwcap)
> +			addr_index = fifo_st & FIFO_ADDR_DECODE;
> +		else
> +			last_addr_bit = fifo_st & FIFO_ADDR_DECODE;
> +
> +		/*Read data from FIFO to clear interrupt*/
> +		Data = ioread8(lpc_bpc->base + NPCM_BPCFDATA_REG);
> +		if (kfifo_is_full(&lpc_bpc->ch[addr_index].fifo))
> +			kfifo_skip(&lpc_bpc->ch[addr_index].fifo);
> +		kfifo_put(&lpc_bpc->ch[addr_index].fifo, Data);
> +		if (fifo_st & FIFO_OVERFLOW)
> +			pr_info("BIOS Post Codes FIFO Overflow!!!\n");
> +
> +		fifo_st = ioread8(lpc_bpc->base + NPCM_BPCFSTAT_REG);
> +		if (lpc_bpc->en_dwcap && last_addr_bit) {
> +			if ((fifo_st & FIFO_ADDR_DECODE) ||
> +			    ((FIFO_DATA_VALID & fifo_st) == 0)) {
> +				while (kfifo_avail(&lpc_bpc->ch[addr_index].fifo) < DW_PAD_SIZE)
> +					kfifo_skip(&lpc_bpc->ch[addr_index].fifo);
> +				kfifo_in(&lpc_bpc->ch[addr_index].fifo,
> +					 padzero, DW_PAD_SIZE);
> +			}
> +		}
> +		isr_flag = true;
> +	}
> +
> +	host_st = ioread8(lpc_bpc->base + NPCM_BPCFMSTAT_REG);
> +	if (host_st & HOST_RESET_CHANGED) {
> +		iowrite8(HOST_RESET_CHANGED,
> +			 lpc_bpc->base + NPCM_BPCFMSTAT_REG);
> +		lpc_bpc->ch[addr_index].host_reset = true;
> +		isr_flag = true;
> +	}
> +
> +	if (isr_flag) {
> +		wake_up_interruptible(&lpc_bpc->ch[addr_index].wq);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int npcm_bpc_config_irq(struct npcm_bpc *lpc_bpc,
> +			       struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int rc;
> +
> +	lpc_bpc->irq = platform_get_irq(pdev, 0);
> +	if (lpc_bpc->irq < 0) {
> +		dev_err(dev, "get IRQ failed\n");
> +		return lpc_bpc->irq;
> +	}
> +
> +	rc = devm_request_irq(dev, lpc_bpc->irq,
> +			      npcm_bpc_irq, IRQF_SHARED,
> +			      DEVICE_NAME, lpc_bpc);
> +	if (rc < 0) {
> +		dev_warn(dev, "Unable to request IRQ %d\n", lpc_bpc->irq);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int npcm_enable_bpc(struct npcm_bpc *lpc_bpc, struct device *dev,
> +			   int channel, u16 lpc_port)
> +{
> +	int rc;
> +	u8 addr_en, reg_en;
> +
> +	init_waitqueue_head(&lpc_bpc->ch[channel].wq);
> +
> +	rc = kfifo_alloc(&lpc_bpc->ch[channel].fifo,
> +			 BPC_KFIFO_SIZE, GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +
> +	lpc_bpc->ch[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
> +	lpc_bpc->ch[channel].miscdev.name =
> +		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
> +	lpc_bpc->ch[channel].miscdev.fops = &npcm_bpc_fops;
> +	lpc_bpc->ch[channel].miscdev.parent = dev;
> +	rc = misc_register(&lpc_bpc->ch[channel].miscdev);
> +	if (rc)
> +		return rc;
> +
> +	lpc_bpc->ch[channel].data = lpc_bpc;
> +	lpc_bpc->ch[channel].host_reset = false;
> +
> +	/* Enable LPC snoop channel at requested port */
> +	switch (channel) {
> +	case 0:
> +		addr_en = FIFO_IOADDR1_ENABLE;
> +		iowrite8((u8)lpc_port & 0xFF,
> +			 lpc_bpc->base + NPCM_BPCFA1L_REG);
> +		iowrite8((u8)(lpc_port >> 8),
> +			 lpc_bpc->base + NPCM_BPCFA1M_REG);
> +		break;
> +	case 1:
> +		addr_en = FIFO_IOADDR2_ENABLE;
> +		iowrite8((u8)lpc_port & 0xFF,
> +			 lpc_bpc->base + NPCM_BPCFA2L_REG);
> +		iowrite8((u8)(lpc_port >> 8),
> +			 lpc_bpc->base + NPCM_BPCFA2M_REG);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (lpc_bpc->en_dwcap)
> +		addr_en = FIFO_DWCAPTURE;
> +
> +	/*
> +	 * Enable FIFO Ready Interrupt, FIFO Capture of I/O addr,
> +	 * and Host Reset
> +	 */
> +	reg_en = ioread8(lpc_bpc->base + NPCM_BPCFEN_REG);
> +	iowrite8(reg_en | addr_en | FIFO_READY_INT_ENABLE |
> +		 HOST_RESET_INT_ENABLE, lpc_bpc->base + NPCM_BPCFEN_REG);
> +
> +	return 0;
> +}
> +
> +static void npcm_disable_bpc(struct npcm_bpc *lpc_bpc, int channel)
> +{
> +	u8 reg_en;
> +
> +	switch (channel) {
> +	case 0:
> +		reg_en = ioread8(lpc_bpc->base + NPCM_BPCFEN_REG);
> +		if (lpc_bpc->en_dwcap)
> +			iowrite8(reg_en & ~FIFO_DWCAPTURE,
> +				 lpc_bpc->base + NPCM_BPCFEN_REG);
> +		else
> +			iowrite8(reg_en & ~FIFO_IOADDR1_ENABLE,
> +				 lpc_bpc->base + NPCM_BPCFEN_REG);
> +		break;
> +	case 1:
> +		reg_en = ioread8(lpc_bpc->base + NPCM_BPCFEN_REG);
> +		iowrite8(reg_en & ~FIFO_IOADDR2_ENABLE,
> +			 lpc_bpc->base + NPCM_BPCFEN_REG);
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	if (!(reg_en & (FIFO_IOADDR1_ENABLE | FIFO_IOADDR2_ENABLE)))
> +		iowrite8(reg_en &
> +			 ~(FIFO_READY_INT_ENABLE | HOST_RESET_INT_ENABLE),
> +			 lpc_bpc->base + NPCM_BPCFEN_REG);
> +
> +	kfifo_free(&lpc_bpc->ch[channel].fifo);
> +	misc_deregister(&lpc_bpc->ch[channel].miscdev);
> +}
> +
> +static int npcm_bpc_probe(struct platform_device *pdev)
> +{
> +	struct npcm_bpc *lpc_bpc;
> +	struct resource *res;
> +	struct device *dev;
> +	u32 port;
> +	int rc;
> +
> +	dev = &pdev->dev;
> +
> +	lpc_bpc = devm_kzalloc(dev, sizeof(*lpc_bpc), GFP_KERNEL);
> +	if (!lpc_bpc)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "BIOS post code reg resource not found\n");
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(dev, "BIOS post code base resource is %pR\n", res);
> +	lpc_bpc->base = devm_ioremap_resource(dev, res);

Any reason for not using devm_platform_ioremap_resource() ?

Guenter

> +	if (IS_ERR(lpc_bpc->base))
> +		return PTR_ERR(lpc_bpc->base);
> +
> +	dev_set_drvdata(&pdev->dev, lpc_bpc);
> +
> +	rc = of_property_read_u32_index(dev->of_node, "snoop-ports", 0,
> +					&port);
> +	if (rc) {
> +		dev_err(dev, "no snoop ports configured\n");
> +		return -ENODEV;
> +	}
> +
> +	lpc_bpc->en_dwcap =
> +		of_property_read_bool(dev->of_node, "nuvoton,lpc-en-dwcapture");
> +
> +	rc = npcm_bpc_config_irq(lpc_bpc, pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = npcm_enable_bpc(lpc_bpc, dev, 0, port);
> +	if (rc) {
> +		dev_err(dev, "Enable BIOS post code I/O port 0 failed\n");
> +		return rc;
> +	}
> +
> +	/*
> +	 * Configuration of second BPC channel port is optional
> +	 * Double-Word Capture ignoring address 2
> +	 */
> +	if (!lpc_bpc->en_dwcap) {
> +		if (of_property_read_u32_index(dev->of_node, "snoop-ports",
> +					       1, &port) == 0) {
> +			rc = npcm_enable_bpc(lpc_bpc, dev, 1, port);
> +			if (rc) {
> +				dev_err(dev, "Enable BIOS post code I/O port 1 failed, disable I/O port 0\n");
> +				npcm_disable_bpc(lpc_bpc, 0);
> +				return rc;
> +			}
> +		}
> +	}
> +
> +	pr_info("NPCM BIOS post code probe\n");
> +
> +	return rc;
> +}
> +
> +static int npcm_bpc_remove(struct platform_device *pdev)
> +{
> +	struct npcm_bpc *lpc_bpc = dev_get_drvdata(&pdev->dev);
> +	u8 reg_en;
> +
> +	reg_en = ioread8(lpc_bpc->base + NPCM_BPCFEN_REG);
> +
> +	if (reg_en & FIFO_IOADDR1_ENABLE)
> +		npcm_disable_bpc(lpc_bpc, 0);
> +	if (reg_en & FIFO_IOADDR2_ENABLE)
> +		npcm_disable_bpc(lpc_bpc, 1);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id npcm_bpc_match[] = {
> +	{ .compatible = "nuvoton,npcm750-lpc-bpc-snoop" },
> +	{ },
> +};
> +
> +static struct platform_driver npcm_bpc_driver = {
> +	.driver = {
> +		.name		= DEVICE_NAME,
> +		.of_match_table = npcm_bpc_match,
> +	},
> +	.probe = npcm_bpc_probe,
> +	.remove = npcm_bpc_remove,
> +};
> +
> +module_platform_driver(npcm_bpc_driver);
> +
> +MODULE_DEVICE_TABLE(of, npcm_bpc_match);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> +MODULE_DESCRIPTION("Linux driver to control NPCM LPC BIOS post code snooping");
> 

