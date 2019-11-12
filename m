Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BB7206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap5qQJLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfKLMgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:36:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45931 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfKLMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:36:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id 14so8618061oir.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 04:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VyuE9R1Zt8unWqsQYiOdffXM+EG4glnnIjYggC8eTEU=;
        b=Ap5qQJLCwOnu9WaClYB8g/Q1afEqOIjnsLLeX4YKaPAHPvdg06LmhwoD/t+F7c6a7A
         kUbQbSq3g99S+2xvZjizsMXAbY8rWjRAHWA/dlIAA1tqcRTdkPA2Zi8z0ZIIji/G0aDb
         Yv7GenVSZ3COOocISD214Gglk7dxKnU75NmyPmBbZ8nJktJehxBgEJzVQ2bJ12WPfBfl
         d59xGFIDSVOcHaDMAak2raOsnWT7LXtTA19FmxIovxUeO7yQoe5pRxz50We+Rp27L/Ux
         zY7AJG3vN7Dta7oh3DUK3itcAVfRL3FuOvBSQuDZz8CNGf1hbQnhlva6q87SDrCIGy+L
         TqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=VyuE9R1Zt8unWqsQYiOdffXM+EG4glnnIjYggC8eTEU=;
        b=qj0gZE6xAKp0ktbbu4n+dAEk/nIjvVx0g3H75hUVDrA/n51vP6/MoREfp2UXCUcYXB
         H6/gu3cKbgxEIkYHis8GH3DSwc6FYI/mXaXHq6Oa4jPbZBdYmpgvS/qg+mzny09td2fb
         dma8lm9gFMwq/GZga8kaqjqNYkcZN/1h/1ONyaIn5akim4cTwjGiqD4DGh9/45igMHEX
         VUnD0NU7jh7/7ll7UnqVTsDJvOVARuZpXXMEnxV8+9wYFHO0sxc5izVn9LmSzGzElUvj
         aBbDEo4Qstj21xKDDBMQrAmRO3nIsjfj//vjjGKsOkH/IOhlhqDX1YEL4F73cihClsZY
         D4AQ==
X-Gm-Message-State: APjAAAUlzJtBUZjU40FmegG00ePZaDvcr86zcVKJICcW9NnS4oHXNaNd
        DfBLYJA0q3/r+CESMAfSzA==
X-Google-Smtp-Source: APXvYqwvHqp0DJEHcQBsvLeHESCHlfxJvRpyP9XdBImq8kFvgUt0egV647ozlcxYXSXHzNjp4tOoFw==
X-Received: by 2002:a05:6808:ab1:: with SMTP id r17mr3574728oij.111.1573562164874;
        Tue, 12 Nov 2019 04:36:04 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id 18sm3921292oip.57.2019.11.12.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 04:36:04 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 85168180046;
        Tue, 12 Nov 2019 12:36:03 +0000 (UTC)
Date:   Tue, 12 Nov 2019 06:36:02 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, cminyard@mvista.com,
        asmaa@mellanox.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        sdasari@fb.com
Subject: Re: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB
Message-ID: <20191112123602.GD2882@minyard.net>
Reply-To: minyard@acm.org
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112023610.3644314-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 06:36:09PM -0800, Vijay Khemka wrote:
> Many IPMB devices doesn't support smbus protocol and current driver
> support only smbus devices. So added support for raw i2c packets.

I haven't reviewed this, really, because I have a more general
concern...

Is it possible to not do this with a config item?  Can you add something
to the device tree and/or via an ioctl to make this dynamically
configurable?  That's more flexible (it can support mixed devices) and
is friendlier to users (don't have to get the config right).

Config items for adding new functionality are generally ok.  Config
items for choosing between two mutually exclusive choices are
generally not.

-corey

> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/char/ipmi/Kconfig        |  6 ++++++
>  drivers/char/ipmi/ipmb_dev_int.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> index a9cfe4c05e64..e5268443b478 100644
> --- a/drivers/char/ipmi/Kconfig
> +++ b/drivers/char/ipmi/Kconfig
> @@ -139,3 +139,9 @@ config IPMB_DEVICE_INTERFACE
>  	  Provides a driver for a device (Satellite MC) to
>  	  receive requests and send responses back to the BMC via
>  	  the IPMB interface. This module requires I2C support.
> +
> +config IPMB_SMBUS_DISABLE
> +	bool 'Disable SMBUS protocol for sending packet to IPMB device'
> +	depends on IPMB_DEVICE_INTERFACE
> +	help
> +	  provides functionality of sending raw i2c packets to IPMB device.
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index ae3bfba27526..2419b9a928b2 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -118,6 +118,10 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>  	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
>  	u8 rq_sa, netf_rq_lun, msg_len;
>  	union i2c_smbus_data data;
> +#ifdef CONFIG_IPMB_SMBUS_DISABLE
> +	unsigned char *i2c_buf;
> +	struct i2c_msg i2c_msg;
> +#endif
>  	u8 msg[MAX_MSG_LEN];
>  	ssize_t ret;
>  
> @@ -133,6 +137,31 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>  	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
>  	netf_rq_lun = msg[NETFN_LUN_IDX];
>  
> +#ifdef CONFIG_IPMB_SMBUS_DISABLE
> +	/*
> +	 * subtract 1 byte (rq_sa) from the length of the msg passed to
> +	 * raw i2c_transfer
> +	 */
> +	msg_len = msg[IPMB_MSG_LEN_IDX] - 1;
> +
> +	i2c_buf = kzalloc(msg_len, GFP_KERNEL);
> +	if (!i2c_buf)
> +		return -EFAULT;
> +
> +	/* Copy message to buffer except first 2 bytes (length and address) */
> +	memcpy(i2c_buf, msg+2, msg_len);
> +
> +	i2c_msg.addr = rq_sa;
> +	i2c_msg.flags = ipmb_dev->client->flags &
> +			(I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB);
> +	i2c_msg.len = msg_len;
> +	i2c_msg.buf = i2c_buf;
> +
> +	ret = i2c_transfer(ipmb_dev->client->adapter, &i2c_msg, 1);
> +	kfree(i2c_buf);
> +
> +	return (ret == 1) ? count : ret;
> +#else
>  	/*
>  	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
>  	 * i2c_smbus_xfer
> @@ -149,6 +178,7 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>  			     I2C_SMBUS_BLOCK_DATA, &data);
>  
>  	return ret ? : count;
> +#endif
>  }
>  
>  static unsigned int ipmb_poll(struct file *file, poll_table *wait)
> -- 
> 2.17.1
> 
