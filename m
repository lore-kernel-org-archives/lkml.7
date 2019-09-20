Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E63EC4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E5E218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568967357;
	bh=QwMjH3PGds4c8HSBbJZ29Z638cfXCuyiV1/O5hMrQA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AIlrVW0y5UXR9zeOF2eiv79zKmLj/VpnMnv+dv3R4r6qjY0TwmBJYt3aUN/oPhqkM
	 1gKTLw2TZ+Q2diETwXk93OsNk1O80Ew+7fI9yrlMfKXvoZ4coo5XIR3cghRS83SibU
	 RWGBXt/TTqo3Zj7OE4Uyao8t9Qz6cp3Tr3fN5i/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393310AbfITIP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:15:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40399 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbfITIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:15:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id d17so4390540lfa.7;
        Fri, 20 Sep 2019 01:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LrfyjdPdxewWc/E+N/Begl6k2uWPZL/n9FnhRH8LaEQ=;
        b=L4xKTRo5CywFFEod/xneTJPJ4AJi4ZDibX5jF0KeEjr56KB+U7ZAp70O522X9PFrNW
         f70ZH8Dv+SelbCodozOLcwsop7/cq0jqE7GNlXzJqmAGJdWIxQ5XZzjqCIbGMCvtzy90
         GlQvBZZKXyL9mS0igp65hIRtwFkoCInp5MtCZUjAOVOChoy5N5L6KvwnzeS+0LzAc0G4
         7dkK5agy8qfDxV8cVglm361V/ctAR615+mZvzI2aPDbkVeKOgUrqeGUQy09rsFV2ev3j
         dyI96SgDN7PDBYEArm7kACIPBFQ7BD9hrd76DZ0wbZwZflu1cIv+XZRvnWFzi4ppgSCS
         gaZQ==
X-Gm-Message-State: APjAAAV58Ms5XAHYIKTmrSNptSoHGBD46Q1OUraXqqDXjx8A4YASXqcn
        o92y2+OxHhD3jyAP+c1qMu8=
X-Google-Smtp-Source: APXvYqxYAQOhQ7mSab3tLmDNSXrRiwwfk4BebreALvJsxW+ZAIMQ4zlYbDIvNdHFxwmpK8a8xBW3zA==
X-Received: by 2002:ac2:50c5:: with SMTP id h5mr7947101lfm.105.1568967351210;
        Fri, 20 Sep 2019 01:15:51 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id b19sm266554lji.41.2019.09.20.01.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 01:15:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iBE50-00017w-FP; Fri, 20 Sep 2019 10:15:50 +0200
Date:   Fri, 20 Sep 2019 10:15:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 3/6] USB: serial: f81232: Add generator for F81534A
Message-ID: <20190920081550.GK30545@localhost>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1559789656-15847-4-git-send-email-hpeter+linux_kernel@gmail.com>
 <20190828150252.GJ13017@localhost>
 <b194f7e6-963d-df3b-5295-4323dae0846d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b194f7e6-963d-df3b-5295-4323dae0846d@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:59:17AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi Johan,
> 
> Johan Hovold 於 2019/8/28 下午 11:02 寫道:
> > On Thu, Jun 06, 2019 at 10:54:13AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> >> The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
> >> but the UART is default disable and need enabled by GPIO device(2c42/16F8).
> >> When F81534A plug to host, we can only see 1 HUB & 1 GPIO device, add
> >> GPIO device USB interface to device_list and trigger generate worker,
> >> f81534a_generate_worker to run f81534a_ctrl_generate_ports().
> >>
> >> The operation in f81534a_ctrl_generate_ports() as following:
> >> 	1: Write 0x8fff to F81534A_CMD_ENABLE_PORT register for enable all
> >> 	   UART device.
> >>
> >> 	2: Read port existence & current status from F81534A_CMD_PORT_STATUS
> >> 	   register. the higher 16bit will indicate the UART existence. If the
> >> 	   UART is existence, we'll check it GPIO mode as long as not default
> >> 	   value (default is all input mode).
> >>
> >> 	3: 1 GPIO device will check with max 15s and check next GPIO device when
> >> 	   timeout. (F81534A_CTRL_RETRY * F81534A_CTRL_TIMER)
> >>
> >> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> > 
> > This is all looks crazy... Please better describe how the device works,
> > and you want to implement support.
> 
> I'll try to refactor more simply for first add into kernel.
> 
> >> ---
> >>   drivers/usb/serial/f81232.c | 356 +++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 355 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> >> index 75dfc0b9ef30..e9470fb0d691 100644
> >> --- a/drivers/usb/serial/f81232.c
> >> +++ b/drivers/usb/serial/f81232.c
> >> @@ -41,6 +41,12 @@ static const struct usb_device_id id_table[] = {
> >>   };
> >>   MODULE_DEVICE_TABLE(usb, id_table);
> >>   
> >> +static const struct usb_device_id f81534a_ctrl_id_table[] = {
> >> +	{ USB_DEVICE(0x2c42, 0x16f8) },		/* Global control device */
> >> +	{ }					/* Terminating entry */
> >> +};
> >> +MODULE_DEVICE_TABLE(usb, f81534a_ctrl_id_table);
> > 
> > You can only have one MODULE_DEVICE_TABLE()...
> 
> I had a question about this. In this file, we'll need support 3 sets of
> id f81232(1)/f81534a(9)/f81534a_ctrl(1). So I will refactor the code
> about id section to the below due to the id table will use more than
> once:
> 
> =======================================================================
> #define F81232_ID		\
> 	{ USB_DEVICE(0x1934, 0x0706) }	/* 1 port UART device */
> 
> #define F81534A_SERIES_ID	\
> 	{ USB_DEVICE(0x2c42, 0x1602) },	/* In-Box 2 port UART device */	\
> 	{ USB_DEVICE(0x2c42, 0x1604) },	/* In-Box 4 port UART device */	\
> 	{ USB_DEVICE(0x2c42, 0x1605) },	/* In-Box 8 port UART device */	\
> 	{ USB_DEVICE(0x2c42, 0x1606) },	/* In-Box 12 port UART device */ \
> 	{ USB_DEVICE(0x2c42, 0x1608) },	/* Non-Flash type */ \
> 	{ USB_DEVICE(0x2c42, 0x1632) },	/* 2 port UART device */ \
> 	{ USB_DEVICE(0x2c42, 0x1634) },	/* 4 port UART device */ \
> 	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
> 	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
> 
> #define F81534A_CTRL_ID		\
> 	{ USB_DEVICE(0x2c42, 0x16f8) }	/* Global control device */
> 
> static const struct usb_device_id id_table[] = {
> 	F81232_ID,
> 	{ }					/* Terminating entry */
> };
> 
> static const struct usb_device_id f81534a_id_table[] = {
> 	F81534A_SERIES_ID,
> 	{ }					/* Terminating entry */
> };
> 
> static const struct usb_device_id f81534a_ctrl_id_table[] = {
> 	F81534A_CTRL_ID,
> 	{ }					/* Terminating entry */
> };
> 
> static const struct usb_device_id all_serial_id_table[] = {
> 	F81232_ID,
> 	F81534A_SERIES_ID,
> 	{ }					/* Terminating entry */
> };
> MODULE_DEVICE_TABLE(usb, all_serial_id_table);
> =======================================================================
> 
> but the checkpatch.pl give me the warning below:
> ERROR: Macros with complex values should be enclosed in parentheses
> #42: FILE: f81232.c:28:
> +#define F81534A_SERIES_ID      \
> +       { USB_DEVICE(0x2c42, 0x1602) }, /* In-Box 2 port UART device */ \
> +       { USB_DEVICE(0x2c42, 0x1604) }, /* In-Box 4 port UART device */ \
> +       { USB_DEVICE(0x2c42, 0x1605) }, /* In-Box 8 port UART device */ \
> +       { USB_DEVICE(0x2c42, 0x1606) }, /* In-Box 12 port UART device */ \
> +       { USB_DEVICE(0x2c42, 0x1608) }, /* Non-Flash type */ \
> +       { USB_DEVICE(0x2c42, 0x1632) }, /* 2 port UART device */ \
> +       { USB_DEVICE(0x2c42, 0x1634) }, /* 4 port UART device */ \
> +       { USB_DEVICE(0x2c42, 0x1635) }, /* 8 port UART device */ \
> +       { USB_DEVICE(0x2c42, 0x1636) }  /* 12 port UART device */
> 
> Is any suggestion ?

Just ignore checkpatch.pl, that's often the right answer. We already
have something similar to the above in usb-serial-simple.c.

Unless you can come up with some better way to deal with this.

Johan
