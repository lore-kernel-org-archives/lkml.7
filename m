Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350D1CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085BE21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571831568;
	bh=LD+J+ZExC/pqSgprd/uLaXnogXmNDPWV/k/HnXBzzK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RjDF16CPhW09PNuQXQ/D3E6utnh5MyiGLPVEZ9zFNdWyoFNU0tvdcOElA5IMaR3FS
	 vgeI7iNMi9EbtVBiBAf2djIRASikSih6qqbYyM48N1W9Z1xVae9ASa6KlV8Ys0CjRg
	 jKl/yN0UJalJfdWFfYVcUwP0JSoaNI0lFXK7UP0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405118AbfJWLwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:52:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46992 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbfJWLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:52:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so15804911lfc.13;
        Wed, 23 Oct 2019 04:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UP5gdkUuUJ2fsIKZrjEEkYxT+1Zl1EyXr08pcip8sao=;
        b=ZOwB7v2fJxbfdvIDy77oGHpdx0ITObnIMzLP1PBA0JYHycFiCFTimtItIut2yaexKd
         Nvw9nLxfhtbFpmjUSdzOmVq74vn0R+SnDGIf9Zd9zgtJBGyw5L7wMJiaDrp4OrQFvlQ/
         gllURpAn+uBcYT2QYmqeNDvD0C5wTyTHVqylvt4EKVPLDQLWIZN2bxKPdvsIPKJ4dhsQ
         79tWPVmD0A04/28kdiIrdqSxOQD0K8hld1jwB69hFG+X8BjDPlqUQEIPCTv11aPQqqn1
         +IJ91s3X0GznTY/541ho3JC7cdnmJ2of77P40E2+lUP+HFX5I58PV/hfvF3dm/7cfEhM
         XgAw==
X-Gm-Message-State: APjAAAW16DTjjcrGwAFdZ0e7hn36uy/C+sMIFMy73uEm0rpF5TYLxsxz
        HsOAvJpHOJHgNnQzJirvCSM=
X-Google-Smtp-Source: APXvYqyRaVJn6WIOly1Fo+ZbC/dp1NYNTs+N33NvoETznb2nPYT//qen03pc4/5IirEEcUHwT5GFNQ==
X-Received: by 2002:a19:5517:: with SMTP id n23mr5873958lfe.139.1571831564526;
        Wed, 23 Oct 2019 04:52:44 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id u24sm6049489ljl.64.2019.10.23.04.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 04:52:43 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNFCG-00074i-P9; Wed, 23 Oct 2019 13:53:00 +0200
Date:   Wed, 23 Oct 2019 13:53:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 5/7] USB: serial: f81232: Set F81534A serial port with
 RS232 mode
Message-ID: <20191023115300.GU24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-6-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-6-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:47AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
> and the serial ports are default disabled. Each port contains max 3 pins
> GPIO and the 3 pins are default pull high with input mode.
> 
> When the serial port had activated (running probe()), we'll transform the
> 3 pins from GPIO function publicly to control Tranceiver privately use.

I'm not sure I understand what you're saying here.

> We'll default set to 0/0/1 for control transceiver to RS232 mode.
> 
> Otherwise, If the serial port is not active, the 3 pins is in GPIO mode
> and controlled by global GPIO device with VID/PID: 2c42/16f8.

Does this mean that you can control the three GPIOs either through the
serial device or through the gpio-control device (which are two separate
USB devices)?

> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 36a17aedc2ae..01cb5a5ea1d2 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -96,6 +96,15 @@ MODULE_DEVICE_TABLE(usb, all_serial_id_table);
>  #define F81534A_TRIGGER_MULTPILE_4X	BIT(3)
>  #define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
>  
> +/* Serial port self GPIO control, 2bytes [control&output data][input data] */
> +#define F81534A_GPIO_REG		0x10e
> +#define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
> +#define F81534A_GPIO_MODE1_DIR		BIT(5)
> +#define F81534A_GPIO_MODE0_DIR		BIT(4)
> +#define F81534A_GPIO_MODE2_OUTPUT	BIT(2)
> +#define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
> +#define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
> +
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
> @@ -866,6 +875,14 @@ static int f81232_port_probe(struct usb_serial_port *port)
>  
>  static int f81534a_port_probe(struct usb_serial_port *port)
>  {
> +	int status;
> +
> +	/* tri-state with pull-high, default RS232 Mode */
> +	status = f81232_set_register(port, F81534A_GPIO_REG,
> +					F81534A_GPIO_MODE2_DIR);
> +	if (status)
> +		return status;

Ok, so you reset the tranceiver config on every probe.

Are the three GPIOs always connected to one particular tranceiver, or
are they truly general purpose?

In the latter case, it doesn't seem like a good idea to drive pins 0
and 1 low here as you have know idea what they're used for.

> +
>  	return f81232_port_probe(port);
>  }

Johan
