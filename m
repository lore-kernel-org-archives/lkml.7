Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E71A218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KkHyRv/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCVVJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:09:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45672 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCVVJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:09:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so1475517pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AEQ41jmKi9Yhg8I/UUhiOo+ULlmAx5Opbbl+Ew9GgWk=;
        b=KkHyRv/TOrtU6JucIUJW7tDIIdL7J2wL3g4iyRb1CUCxGOzxXE0UKytoCLXv88wVnm
         0KfMBT3Cb1hVYmt0KuTi6Fk+ojKJFeExAFsrlP+gK3USyXlRjgUXTiJ694jYUspLdf7Y
         iCE61njFeK+AXzy+4RT541rg61NxM20DxMul8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AEQ41jmKi9Yhg8I/UUhiOo+ULlmAx5Opbbl+Ew9GgWk=;
        b=uX9OvIKJ7LLOAU/7YZo0oTLgNh/pLC+b3sk09x+y3wPYOnoAJSc87mdhd2s0fBAUwd
         CKVbdlrKZLYjD+Z/Ewwdd86/FJEpxeBCMmW25BQX4ElY5HC62t+1PLqjHfLhJsiFJh/a
         h2XbhkVS67pE99Az6pH67uSqXqKeud6UUY1ceGqYs6bM8TvDUzOEpdWvmsV1T94XjJPG
         BPNzRjY09TtREHz0X//D0URr9mkX4/C+1UMYLXvQ1F2BG9SRH+x70aPG48/9Ma5YTJZF
         xMf5LqfyTQJLkjr8sGpq70sWi9Uiv0f03SdGF7goey9JEoK3kmtBbYaLzlCgknKOCu+c
         91uw==
X-Gm-Message-State: APjAAAWAVgX1aKLVpSt3Kn4Ywg7n0zAam2hsUC9tPMHaZMRePp6lTmj/
        gNSB05KnTMZVbFUBQsPOPa71juZ2+vDHD+4mOMh1rueE7ZdjELPU+1/5pFCJnGT+ffs5uxR2yqC
        7JF2MRAK7EQxaICLFKvG/VTZMo76AYOhCuXxGJ19xMqwpvlh5UrjdeL2aw5FbuGsqwQPTywpB1P
        mu
X-Google-Smtp-Source: APXvYqyR6GocgyE4Rgb/PeqfhkMZPjrcfg3dm3G9bKqVdT5hzJIu0FPGcgMHiPGGqZBlqJkt4DRXzg==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr11853589plo.254.1553288975481;
        Fri, 22 Mar 2019 14:09:35 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x23sm9786275pgf.10.2019.03.22.14.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 14:09:34 -0700 (PDT)
Subject: Re: [PATCH] Add i2c recovery handling for bcm-iproc based devices.
To:     Richard Laing <richard.laing@alliedtelesis.co.nz>,
        rjui@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-kernel@vger.kernel.org
References: <20190321233528.16568-1-richard.laing@alliedtelesis.co.nz>
 <20190321233528.16568-2-richard.laing@alliedtelesis.co.nz>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <cf458878-9c9c-8e0f-fbe9-137b3204875b@broadcom.com>
Date:   Fri, 22 Mar 2019 14:09:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190321233528.16568-2-richard.laing@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 3/21/2019 4:35 PM, Richard Laing wrote:
> It is possible for the i2c bus to become locked up preventing
> communication with devices on the bus, add the hooks required to
> allow the existing i2c recovery code to be used to clear the lock up.>

Can you be more specific on how the locked up condition happened? Is it
from the slave device locking up the SCL line and prevents the host from
pulling it high?


> Before the recovery can be perfored the device needs to be configured in

Typo. 'performed'

> the bit-bang mode allow the clock line to be controlled directly by the
> i2c_generic_recovery() in i2c-core.c. Access routines are provided to get
> and set the clock line state and on completion the device is returned to
> normal operations and initialised.

Typo. Initialized.

> 
> Signed-off-by: Richard Laing <richard.laing@alliedtelesis.co.nz>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c | 120 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 4c8c3bc..4cd041b 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -23,6 +23,7 @@
>  #define CFG_OFFSET                   0x00
>  #define CFG_RESET_SHIFT              31
>  #define CFG_EN_SHIFT                 30
> +#define CFG_BIT_BANG_SHIFT           29
>  #define CFG_M_RETRY_CNT_SHIFT        16
>  #define CFG_M_RETRY_CNT_MASK         0x0f
>  
> @@ -78,6 +79,11 @@
>  #define M_RX_DATA_SHIFT              0
>  #define M_RX_DATA_MASK               0xff
>  
> +#define M_BB_CTRL_OFFSET             0x14
> +#define M_BB_CTRL_CLK_IN_SHIFT       31
> +#define M_BB_CTRL_CLK_SHIFT          30

M_BB_CTRL_CLK_OUT_SHIFT to indicate it's for controlling the clock

> +#define M_BB_CTRL_DATA_SHIFT         29

#define M_BB_CTRL_DATA_IN_SHIFT 29

to indicate it's RO and consistent with your naming for bit 31

> +
>  #define I2C_TIMEOUT_MSEC             50000
>  #define M_TX_RX_FIFO_SIZE            64
>  
> @@ -208,6 +214,117 @@ static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	writel(val, iproc_i2c->base + CFG_OFFSET);
>  }
>  
> +/*
> + * Put the i2c controller into reset.
> + */
> +static void bcm_iproc_i2c_reset(struct bcm_iproc_i2c_dev *iproc_i2c)

If you are going to introduce the reset function, I think it makes way
more sense to add a second argument: 'bool reset'

Caller uses reset = true to put the controller into reset
reset = false to bring the controller out of reset

And convert all reset related code in the driver to use this function.


> +{
> +	u32 tmp;
> +
> +	tmp = readl(iproc_i2c->base + CFG_OFFSET);
> +	tmp |= BIT(CFG_RESET_SHIFT);
> +	writel(tmp, iproc_i2c->base + CFG_OFFSET);
> +	udelay(100);
> +}
> +
> +/*
> + * Switch to bit bang mode to prepare for i2c generic recovery.
> + */
> +static void bcm_iproc_i2c_prepare_recovery(struct i2c_adapter *adap)
> +{
> +	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adap);
> +	u32 tmp;
> +
> +	dev_dbg(iproc_i2c->device, "Prepare recovery\n");
> +
> +	/* Disable interrupts */
> +	writel(0, iproc_i2c->base + IE_OFFSET);
> +	readl(iproc_i2c->base + IE_OFFSET);
> +	synchronize_irq(iproc_i2c->irq);
> +
> +	bcm_iproc_i2c_reset(iproc_i2c);
> +
> +	/* Switch to bit-bang mode */
> +	tmp = readl(iproc_i2c->base + CFG_OFFSET);
> +	tmp |= BIT(CFG_BIT_BANG_SHIFT);
> +	writel(tmp, iproc_i2c->base + CFG_OFFSET);
> +}
> +
> +/*
> + * Return to normal i2c operation following recovery.
> + */
> +static void bcm_iproc_i2c_unprepare_recovery(struct i2c_adapter *adap)
> +{
> +	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adap);
> +	u32 tmp;
> +
> +	/* Switch to normal mode */
> +	tmp = readl(iproc_i2c->base + CFG_OFFSET);
> +	tmp &= ~BIT(CFG_BIT_BANG_SHIFT);
> +	writel(tmp, iproc_i2c->base + CFG_OFFSET);
> +	udelay(100);
> +
> +	bcm_iproc_i2c_init(iproc_i2c);
> +	bcm_iproc_i2c_enable_disable(iproc_i2c, true);
> +
> +	dev_dbg(iproc_i2c->device, "Recovery complete\n");
> +}
> +
> +/*
> + * Return the SCL state, we must be configured in bit bang mode for this
> + * to work.
> + */
> +static int bcm_iproc_i2c_get_scl(struct i2c_adapter *adap)
> +{
> +	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adap);
> +	u32 tmp;
> +
> +	tmp = readl(iproc_i2c->base + M_BB_CTRL_OFFSET);
> +
> +	return tmp & BIT(M_BB_CTRL_CLK_IN_SHIFT);
> +}
> +
> +/*
> + * Set the SCL state, we must be configured in bit bang mode for this
> + * to work.
> + */
> +static void bcm_iproc_i2c_set_scl(struct i2c_adapter *adap, int val)

use bool instead of int for val, since it can only be high or low.

> +{
> +	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adap);
> +	u32 tmp;
> +
> +	tmp = readl(iproc_i2c->base + M_BB_CTRL_OFFSET);
> +	if (val)
> +		tmp |= BIT(M_BB_CTRL_CLK_SHIFT);
> +	else
> +		tmp &= ~BIT(M_BB_CTRL_CLK_SHIFT);
> +
> +	writel(tmp, iproc_i2c->base + M_BB_CTRL_OFFSET);
> +}
> +
> +/*
> + * Return the SDA state, we must be configured in bit bang mode for this
> + * to work.
> + */
> +static int bcm_iproc_i2c_get_sda(struct i2c_adapter *adap)
> +{
> +	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adap);
> +	u32 tmp;
> +
> +	tmp = readl(iproc_i2c->base + M_BB_CTRL_OFFSET);
> +
> +	return tmp & BIT(M_BB_CTRL_DATA_SHIFT);
> +}
> +
> +static struct i2c_bus_recovery_info bcm_iproc_recovery_info = {
> +	.recover_bus = i2c_generic_scl_recovery,
> +	.prepare_recovery = bcm_iproc_i2c_prepare_recovery,
> +	.unprepare_recovery = bcm_iproc_i2c_unprepare_recovery,
> +	.set_scl = bcm_iproc_i2c_set_scl,
> +	.get_scl = bcm_iproc_i2c_get_scl,
> +	.get_sda = bcm_iproc_i2c_get_sda,
> +};
> +
>  static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
>  				      struct i2c_msg *msg)
>  {
> @@ -261,6 +378,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
>  	       BIT(M_CMD_START_BUSY_SHIFT))) {
>  		dev_warn(iproc_i2c->device, "bus is busy\n");
> +		i2c_recover_bus(&iproc_i2c->adapter);

I'm not sure if it makes sense to do it here immediately. It may make
more sense to introduce some simple waiting logic here, and then only
execute i2c_recover_bus after it times out.

>  		return -EBUSY;
>  	}
>  
> @@ -341,6 +459,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  		val = (1 << M_FIFO_RX_FLUSH_SHIFT) |
>  		      (1 << M_FIFO_TX_FLUSH_SHIFT);
>  		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +		i2c_recover_bus(&iproc_i2c->adapter);

Then it may also make sense to try to recover if
'bcm_iproc_i2c_check_status' fails below.

>  		return -ETIMEDOUT;
>  	}
>  
> @@ -487,6 +606,7 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
>  	adap->quirks = &bcm_iproc_i2c_quirks;
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
> +	adap->bus_recovery_info = &bcm_iproc_recovery_info;
>  
>  	return i2c_add_adapter(adap);
>  }
> 

Thanks,

Ray
