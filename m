Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F536C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36632217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KuTTEVlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfDDSEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:04:22 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37826 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:04:21 -0400
Received: by mail-yw1-f65.google.com with SMTP id w66so1323641ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+awzsklRaN8f3VMg5myT4W3vKGVqS7FvEt6SUL9b1g=;
        b=KuTTEVlu+qenNrlW6DvIcq3r+boUNs2z4LWlg/MFiHmO5w09dEEeEeSUU2Y5F1MaYR
         xiNJBjoyEzT8zKxGwdPlti3+yYbLVcsr4UMRDSTXcfGWspULAVDhyimjXxWi3tMSsOw/
         sulddG1X0VWN28FXmw2CUoLEkiOY85teLW3pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+awzsklRaN8f3VMg5myT4W3vKGVqS7FvEt6SUL9b1g=;
        b=HeBjTvF236ANJHHmb2GlfnGTs4gmjRXxtMt2pB1xf1S/KBYDA9wSPXOgL/63C+se7c
         ZXMZpLsn5BkLTU5xfKdWHFw9//uMj4M33BoTa9IIm/vPbd1pnNeoficHvCYdERToezRi
         hmMudz+gRix044dQiNqz8R00lBk9zlyOGojSCugnPndcAydQvnb3VY0zpvOFFUQqGQw0
         OV/JrqudAQr9BDoJawuvQVOWmozHVXTcIBBKjUBPZBOGlPRqsqyC6gYKTml72WUTqriu
         Llt6AAZ4gdQ7jc+AcVQI7q5nkX52zRs8mIx9xrzeBGYOEkjaqYnOFWay+U0JT7OfLZL6
         XZJQ==
X-Gm-Message-State: APjAAAUY1rU4SdYeIPDTHqvGI+J/cAgcoO0+ycAG2o1xwDFD3jSLvcsP
        RFwzHLw3bFdlttN+9/T/uHrzExmGyO+NyBZoI2pfC8an6WGNQHr8mCYZu4lqWF2b+IoAn3/PfLf
        YZnhqe3KhGQZXsz0kfcD1GD2NU88q8ZH/Diws3ah8GIXLMsq0wRj6u/736vGAcdq+PiVd+jIEZu
        vA
X-Google-Smtp-Source: APXvYqzARoDvyNzBFZe/Xx8uoBDrrrYsOMxM6+l/+AFJrJ3GPhsQcmXf7nmefet/r0ZruRHsyPWLsw==
X-Received: by 2002:a81:3111:: with SMTP id x17mr5955229ywx.260.1554401060164;
        Thu, 04 Apr 2019 11:04:20 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g133sm11041196ywg.84.2019.04.04.11.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:04:19 -0700 (PDT)
Subject: Re: [PATCH v2] Add i2c recovery handling for bcm-iproc based devices.
To:     Richard Laing <richard.laing@alliedtelesis.co.nz>,
        rjui@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-kernel@vger.kernel.org
References: <20190325205933.2726-1-richard.laing@alliedtelesis.co.nz>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <c62ca931-950e-7979-99f8-97b45b2ba220@broadcom.com>
Date:   Thu, 4 Apr 2019 11:04:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190325205933.2726-1-richard.laing@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 1:59 PM, Richard Laing wrote:
> It is possible for the i2c bus to become locked up preventing
> communication with devices on the bus. This can occur when
> another i2c device fails to be reset correctly. In this case
> the SDA line will be held low preventing further communication
> on the bus.
> 
> This situation can be corrected by sending a series of clock
> pulses to allow the blocking device to complete the transaction
> and release the bus.
> 
> Add the hooks required to allow the existing i2c recovery code
> to be used to clear the lock up.
> 
> Before the recovery can be performed the device needs to be configured in
> the bit-bang mode allow the clock line to be controlled directly by the
> i2c_generic_recovery() in i2c-core.c. Access routines are provided to get
> and set the clock line state and on completion the device is returned to
> normal operations and initialized.
> 
> Signed-off-by: Richard Laing <richard.laing@alliedtelesis.co.nz>
> ---
> changes in v2:
> - fix typos/spelling
> - change M_BB_CTRL_DATA_SHIFT to M_BB_CTRL_DATA_IN_SHIFT
> - change from int to bool for bcm_iproc_i2c_set_scl was NOT done, the type for
>   the function pointer does not match and compilation therefore fails.
> - updated calls to i2c_recover_bus
> 
>  drivers/i2c/busses/i2c-bcm-iproc.c | 111 +++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 4c8c3bc4669c..78393c3b5e83 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c

[...]

> @@ -78,6 +79,11 @@
>  #define M_RX_DATA_SHIFT              0
>  #define M_RX_DATA_MASK               0xff
>  
> +#define M_BB_CTRL_OFFSET             0x14
> +#define M_BB_CTRL_CLK_IN_SHIFT       31
> +#define M_BB_CTRL_CLK_SHIFT          30

I think it missed this from my previous review: M_BB_CTRL_CLK_OUT_SHIFT

> +#define M_BB_CTRL_DATA_IN_SHIFT      29
> +
>  #define I2C_TIMEOUT_MSEC             50000
>  #define M_TX_RX_FIFO_SIZE            64
>  
> @@ -208,6 +214,108 @@ static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	writel(val, iproc_i2c->base + CFG_OFFSET);
>  }
>  
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
> +	/* Put the i2c controller into reset. */
> +	tmp = readl(iproc_i2c->base + CFG_OFFSET);
> +	tmp |= BIT(CFG_RESET_SHIFT);
> +	writel(tmp, iproc_i2c->base + CFG_OFFSET);
> +	udelay(100);
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

You are missing to address or reply to another comment from me here.

I'll stop my review here. Please ensure you go through my previous
review thoroughly, and reply/address all of the comments.

In addition, note Wolfram just merged a series of iProc I2C patches into
his tree in branch 'i2c/for-next'. You may want to rebase your patch to
that for the next iteration.

Thanks,

Ray
