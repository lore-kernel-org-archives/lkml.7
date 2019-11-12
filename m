Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370D9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B93214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="C+6bLj8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKLSlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:41:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42261 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLSlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:41:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id i185so15759204oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VEGoFwrILa/Bz2Z5av58zC5E/xCfln7dzu7x1nqlQj0=;
        b=C+6bLj8x/BxaJhpnFaG2kWpSLjCPH7N3gGA4B2HmQWBnVa743Xf+w7JU9gGt46ZsqJ
         35bfMn4pCSCNbbVVegjCjUMxZ0MbyChHS/20CBYzSikRVulk2tgBAsoxEQ8b0KEtn3Zq
         z1FwS8H0h5ct89UqOqVBu9xGfa9kUrQWKNMK4UYzEOJ6UtRptcWR4UqGL26x8nOqTSzB
         exDIh7/vB0GPAjNKA8b4L1TWNZ6iqoBWQ35LNuPHOJ1mnk8UqAEERofFN8EzkKaMGfeH
         D3oPC6kI6U5yx++Km3/uiTcwqhcVjEGvOmf9j/BeSdExzMG1z0syAY9LvYKhRltmkjgg
         1wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VEGoFwrILa/Bz2Z5av58zC5E/xCfln7dzu7x1nqlQj0=;
        b=LIspvBh5I0gRAbV73o3/miC+yu6tbN7Y03LKPJp3d3QjkcY4rS8s+P/1vHnaal7GU5
         FVyc9lOWnck8x9K2aOjEkBc6laqvmkfG/YDHfxoxF+WNJFWB9/mXAbDTeBpoOx76vRsD
         Nt3zTPXWCldhK1kuEJIkzcrBopJ5Qhs39ZwwxgB02zzvwZODcBgyITWT+2HqlkBIBYhh
         d2hyB3uk0W4ABaPHsyUIYe22rH23/kfoJYg3wkNwxhS5PCep8lnw7DP0bCEd4BGg1fZa
         UkdWYzVngxwlf2fQnzfoiVAsIjU9dHeIgJ/rtN2G5wDAImTCvNys5GKeeGV6PfwNGIHJ
         YG+A==
X-Gm-Message-State: APjAAAXmryqdFt6dnvdcXzTNjZk7ODVHhrF73OO4+/3gFm1j6V/faokq
        C782fgMOAZks+qO2gfYbPG2Zxg==
X-Google-Smtp-Source: APXvYqwpIv3p55kAYFjXsw3MARmCQNdjHAUw1xtx7WrcYifyecc6dpULS7L6ofxBsbZAfSjeErr5fg==
X-Received: by 2002:aca:57d7:: with SMTP id l206mr395543oib.32.1573584073982;
        Tue, 12 Nov 2019 10:41:13 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id n9sm6636379otn.4.2019.11.12.10.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 10:41:13 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:41:11 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     "minyard@acm.org" <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asmaa@mellanox.com" <asmaa@mellanox.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB
Message-ID: <20191112184111.GA2938@minyard.net>
Reply-To: cminyard@mvista.com
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112123602.GD2882@minyard.net>
 <493C2E64-2E41-47FF-BDA6-6EA1DA758016@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <493C2E64-2E41-47FF-BDA6-6EA1DA758016@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 05:57:25PM +0000, Vijay Khemka wrote:
> 
> 
> ﻿On 11/12/19, 4:36 AM, "Corey Minyard" <tcminyard@gmail.com on behalf of minyard@acm.org> wrote:
> 
>     On Mon, Nov 11, 2019 at 06:36:09PM -0800, Vijay Khemka wrote:
>     > Many IPMB devices doesn't support smbus protocol and current driver
>     > support only smbus devices. So added support for raw i2c packets.
>     
>     I haven't reviewed this, really, because I have a more general
>     concern...
>     
>     Is it possible to not do this with a config item?  Can you add something
>     to the device tree and/or via an ioctl to make this dynamically
>     configurable?  That's more flexible (it can support mixed devices) and
>     is friendlier to users (don't have to get the config right).
> I agree with you, I was also not comfortable using config and couldn't find other 
> Options, I will look into more option now and update patch.

IMHO, device tree is the right way to do this.  You should also have a
sysfs setting for this, I think.

-corey

>     
>     Config items for adding new functionality are generally ok.  Config
>     items for choosing between two mutually exclusive choices are
>     generally not.
>     
>     -corey
>     
>     > 
>     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     > ---
>     >  drivers/char/ipmi/Kconfig        |  6 ++++++
>     >  drivers/char/ipmi/ipmb_dev_int.c | 30 ++++++++++++++++++++++++++++++
>     >  2 files changed, 36 insertions(+)
>     > 
>     > diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
>     > index a9cfe4c05e64..e5268443b478 100644
>     > --- a/drivers/char/ipmi/Kconfig
>     > +++ b/drivers/char/ipmi/Kconfig
>     > @@ -139,3 +139,9 @@ config IPMB_DEVICE_INTERFACE
>     >  	  Provides a driver for a device (Satellite MC) to
>     >  	  receive requests and send responses back to the BMC via
>     >  	  the IPMB interface. This module requires I2C support.
>     > +
>     > +config IPMB_SMBUS_DISABLE
>     > +	bool 'Disable SMBUS protocol for sending packet to IPMB device'
>     > +	depends on IPMB_DEVICE_INTERFACE
>     > +	help
>     > +	  provides functionality of sending raw i2c packets to IPMB device.
>     > diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
>     > index ae3bfba27526..2419b9a928b2 100644
>     > --- a/drivers/char/ipmi/ipmb_dev_int.c
>     > +++ b/drivers/char/ipmi/ipmb_dev_int.c
>     > @@ -118,6 +118,10 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>     >  	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
>     >  	u8 rq_sa, netf_rq_lun, msg_len;
>     >  	union i2c_smbus_data data;
>     > +#ifdef CONFIG_IPMB_SMBUS_DISABLE
>     > +	unsigned char *i2c_buf;
>     > +	struct i2c_msg i2c_msg;
>     > +#endif
>     >  	u8 msg[MAX_MSG_LEN];
>     >  	ssize_t ret;
>     >  
>     > @@ -133,6 +137,31 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>     >  	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
>     >  	netf_rq_lun = msg[NETFN_LUN_IDX];
>     >  
>     > +#ifdef CONFIG_IPMB_SMBUS_DISABLE
>     > +	/*
>     > +	 * subtract 1 byte (rq_sa) from the length of the msg passed to
>     > +	 * raw i2c_transfer
>     > +	 */
>     > +	msg_len = msg[IPMB_MSG_LEN_IDX] - 1;
>     > +
>     > +	i2c_buf = kzalloc(msg_len, GFP_KERNEL);
>     > +	if (!i2c_buf)
>     > +		return -EFAULT;
>     > +
>     > +	/* Copy message to buffer except first 2 bytes (length and address) */
>     > +	memcpy(i2c_buf, msg+2, msg_len);
>     > +
>     > +	i2c_msg.addr = rq_sa;
>     > +	i2c_msg.flags = ipmb_dev->client->flags &
>     > +			(I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB);
>     > +	i2c_msg.len = msg_len;
>     > +	i2c_msg.buf = i2c_buf;
>     > +
>     > +	ret = i2c_transfer(ipmb_dev->client->adapter, &i2c_msg, 1);
>     > +	kfree(i2c_buf);
>     > +
>     > +	return (ret == 1) ? count : ret;
>     > +#else
>     >  	/*
>     >  	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
>     >  	 * i2c_smbus_xfer
>     > @@ -149,6 +178,7 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>     >  			     I2C_SMBUS_BLOCK_DATA, &data);
>     >  
>     >  	return ret ? : count;
>     > +#endif
>     >  }
>     >  
>     >  static unsigned int ipmb_poll(struct file *file, poll_table *wait)
>     > -- 
>     > 2.17.1
>     > 
>     
> 
