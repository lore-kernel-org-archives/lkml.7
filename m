Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C859C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D561720854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ZW2rmKku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfCOMrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:47:25 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:36236 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbfCOMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:47:24 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9AEA825B7E0;
        Fri, 15 Mar 2019 23:47:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552654039; bh=crIyvFdrU43YPANtqiq6ONuo/H1Hm8WHFUsnWslAhGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZW2rmKkut/PxPFVKFaqeNYikSILyW8nIxdf8QOqyu2SMRqih4ZHR3jaVcy8Oiwfsd
         JKn1UiNM5fA6yeK2dQxrFuLBSt9RSQu+w+eBozSo5GNIqyQzqRLWrGfE9dmLR8gSqg
         AMSoNIewNRBj5B2QVK4zT+8g7cyduh8qYljOHxP8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 17F3F9403F2; Fri, 15 Mar 2019 13:47:18 +0100 (CET)
Date:   Fri, 15 Mar 2019 13:47:18 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/7] i2c: busses: omap: Add the
 master_xfer_irqless hook
Message-ID: <20190315124717.x3do5evok5syipo7@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 02:47:33PM +0100, Wolfram Sang wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Add the master_xfer_irqless hook to enable i2c transactions
> in irq disabled contexts like the poweroff case.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Minor nit below not withstanding

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


> ---
>  drivers/i2c/busses/i2c-omap.c | 79 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index cd9c65f3d404..bf48126faf94 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -269,6 +269,8 @@ static const u8 reg_map_ip_v2[] = {
>  	[OMAP_I2C_IP_V2_IRQENABLE_CLR] = 0x30,
>  };
>  
> +static int omap_i2c_xfer_data(struct omap_i2c_dev *omap);
> +
>  static inline void omap_i2c_write_reg(struct omap_i2c_dev *omap,
>  				      int reg, u16 val)
>  {
> @@ -648,15 +650,28 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *omap, u8 size, bool is_rx)
>  			(1000 * omap->speed / 8);
>  }
>  
> +static void omap_i2c_wait(struct omap_i2c_dev *omap)
> +{
> +	u16 stat;
> +	u16 mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
> +	int count = 0;
> +
> +	do {
> +		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
> +		count++;
> +	} while (!(stat & mask) && count < 5);
> +}
> +
>  /*
>   * Low level master read/write transaction.
>   */
>  static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> -			     struct i2c_msg *msg, int stop)
> +			     struct i2c_msg *msg, int stop, bool polling)
>  {
>  	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
>  	unsigned long timeout;
>  	u16 w;
> +	int ret;
>  
>  	dev_dbg(omap->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
>  		msg->addr, msg->len, msg->flags, stop);
> @@ -680,7 +695,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
>  	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, w);
>  
> -	reinit_completion(&omap->cmd_complete);
> +	if (!polling)
> +		reinit_completion(&omap->cmd_complete);
>  	omap->cmd_err = 0;
>  
>  	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
> @@ -732,8 +748,21 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	 * REVISIT: We should abort the transfer on signals, but the bus goes
>  	 * into arbitration and we're currently unable to recover from it.
>  	 */
> -	timeout = wait_for_completion_timeout(&omap->cmd_complete,
> -						OMAP_I2C_TIMEOUT);
> +	if (!polling) {
> +		timeout = wait_for_completion_timeout(&omap->cmd_complete,
> +						      OMAP_I2C_TIMEOUT);
> +	} else {
> +		do {
> +			omap_i2c_wait(omap);
> +			ret = omap_i2c_xfer_data(omap);
> +		} while (ret == -EAGAIN);
> +
> +		if (!ret)
> +			timeout = 1;
> +		else
> +			timeout = 0;


nit: the following might be cleaner

		ret = !!timeout;

> +	}
> +
>  	if (timeout == 0) {
>  		dev_err(omap->dev, "controller timed out\n");
>  		omap_i2c_reset(omap);
> @@ -772,7 +801,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>   * to do the work during IRQ processing.
>   */
>  static int
> -omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +omap_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg msgs[], int num,
> +		     bool polling)
>  {
>  	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
>  	int i;
> @@ -794,7 +824,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  		omap->set_mpu_wkup_lat(omap->dev, omap->latency);
>  
>  	for (i = 0; i < num; i++) {
> -		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
> +		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)),
> +				      polling);
>  		if (r != 0)
>  			break;
>  	}
> @@ -813,6 +844,18 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	return r;
>  }
>  
> +static int
> +omap_i2c_xfer_irq(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +{
> +	return omap_i2c_xfer_common(adap, msgs, num, false);
> +}
> +
> +static int
> +omap_i2c_xfer_polling(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +{
> +	return omap_i2c_xfer_common(adap, msgs, num, true);
> +}
> +
>  static u32
>  omap_i2c_func(struct i2c_adapter *adap)
>  {
> @@ -1035,10 +1078,8 @@ omap_i2c_isr(int irq, void *dev_id)
>  	return ret;
>  }
>  
> -static irqreturn_t
> -omap_i2c_isr_thread(int this_irq, void *dev_id)
> +static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>  {
> -	struct omap_i2c_dev *omap = dev_id;
>  	u16 bits;
>  	u16 stat;
>  	int err = 0, count = 0;
> @@ -1056,7 +1097,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  
>  		if (!stat) {
>  			/* my work here is done */
> -			goto out;
> +			err = -EAGAIN;
> +			break;
>  		}
>  
>  		dev_dbg(omap->dev, "IRQ (ISR = 0x%04x)\n", stat);
> @@ -1165,14 +1207,25 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  		}
>  	} while (stat);
>  
> -	omap_i2c_complete_cmd(omap, err);
> +	return err;
> +}
> +
> +static irqreturn_t
> +omap_i2c_isr_thread(int this_irq, void *dev_id)
> +{
> +	int ret;
> +	struct omap_i2c_dev *omap = dev_id;
> +
> +	ret = omap_i2c_xfer_data(omap);
> +	if (ret != -EAGAIN)
> +		omap_i2c_complete_cmd(omap, ret);
>  
> -out:
>  	return IRQ_HANDLED;
>  }
>  
>  static const struct i2c_algorithm omap_i2c_algo = {
> -	.master_xfer	= omap_i2c_xfer,
> +	.master_xfer	= omap_i2c_xfer_irq,
> +	.master_xfer_atomic	= omap_i2c_xfer_polling,
>  	.functionality	= omap_i2c_func,
>  };
>  
> -- 
> 2.11.0
> 
