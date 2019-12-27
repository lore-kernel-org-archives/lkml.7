Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5259EC2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1232067D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyLe1gIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfL0SaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:30:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53065 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0SaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:30:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so8717202wmc.2;
        Fri, 27 Dec 2019 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tt4Pc7HYKEhSHSLFHDqLZhfbyrh0xZPyn1XrmozpGLQ=;
        b=jyLe1gIxAD2xLDv7qkfoxrW8Ii++LkqCIwoU2AfFd3JqScNSPUbahZjsjcAaAt6mLZ
         NNoGbZH/U9CVCHfPGaC04/ulwPJbunmU4Or3dUDAyGPDuvI/CpX5L2e2FuBgABX9+tEn
         we5kVyVP6I34DSDVepNHiUOdaW+o8gDdOwpdKHh5NpUQT66lCB9O2XCtJLPjs/quFa3f
         gW7dNtEXaxls4IIOlHuUpobUhlkEyot3QPhTy0xVSjHqJVEdsA8Nq9ULctpcVMPgRL1d
         abVYxA6lFgLUownk6mwDWeKOluMQPTFi178P/gs7nyBbUpEDfEi4G5Vv5TPlx78njjHu
         yRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tt4Pc7HYKEhSHSLFHDqLZhfbyrh0xZPyn1XrmozpGLQ=;
        b=OWh/XKFC1IpkT0fjSz5BT7G9qbL/vk8SPSpYW1kxBavagYltRN0cR4ijPr8RaXONIR
         6K6BWt9RKJ9Vf2DfHjo644rSrDxlt+qBqEIMGFayw4RQtgUk+b2Zr5CmKr02ghuCydMW
         j6djybIiuX2Easb2nkcHAZtB9CWTa1ac7A1P6NqAvLsEDBvs0R7LLNkpxAuL/UBcwl0i
         JtELIJGW4ieGJOTNLp+XDLnXKFfFNquo7KnAGpVgsqGGUWXFqpwknn7n4ntdVrqXvCE9
         w7YB4aZ/jtQ2xoPerNtFio6UZPb0UFfOCwGpl88+f0oAEdFBhRStUHMJ75/g6CrX00tX
         y46w==
X-Gm-Message-State: APjAAAWMmQ+N85YC2+E6krkfGWH1sAqKct3+AeRKxsblgpDCiDDkHM/V
        3muix3cMPdrbv8t9v/jxbeNl0dDGTHg=
X-Google-Smtp-Source: APXvYqzVFvda+uLl5sPwotnxNMETPYN/BZEdwY9h+ZAw2FopdG6mb6Sh6h6A5oULdI6kb8xactcwKg==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr19425167wmj.88.1577471415166;
        Fri, 27 Dec 2019 10:30:15 -0800 (PST)
Received: from debian (host-78-144-219-162.as13285.net. [78.144.219.162])
        by smtp.gmail.com with ESMTPSA id v83sm12033947wmg.16.2019.12.27.10.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Dec 2019 10:30:13 -0800 (PST)
Date:   Fri, 27 Dec 2019 18:30:11 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc3
Message-ID: <20191227183011.ij5wcawu6kpf52fb@debian>
References: <20191220070747.GA2190169@kroah.com>
 <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
 <20191223120651.GC114474@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="spmmowioe5m7hsux"
Content-Disposition: inline
In-Reply-To: <20191223120651.GC114474@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--spmmowioe5m7hsux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 23, 2019 at 07:06:51AM -0500, Greg KH wrote:
> On Fri, Dec 20, 2019 at 10:08:03AM -0800, Linus Torvalds wrote:
> > On Thu, Dec 19, 2019 at 11:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > The last tty core fix should resolve a long-standing bug with a race
> > > at port creation time that some people would see, and Sudip finally
> > > tracked down.
> > 
> > Hmm, looks good. But it makes me wonder if we should now try to remove
> > the second call to tty_port_link_device()?
> > 
> > Now we have a number of helpers that do that tty_port_link_device()
> > call for the driver (eg tty_port_register_device_attr_serdev(),
> > tty_port_register_device_attr(), and the just added
> > uart_add_one_port()).
> > 
> > But we also have drivers doing it by hand, and presumably we now have
> > drivers that do it through multiple paths? I guess it's harmless, but
> > it feels a bit odd. No?
> 
> It does.  I'll try to look at this after the holidays unless Sudip beats
> me to it.

The second call to tty_port_link_device() is in
tty_port_register_device_attr_serdev() and tty_port_register_device_attr()
is being called from many other places apart from uart_add_one_port().
The attached patch should be safe. I will test and send it properly unless
someone objects to it.

--
Regards
Sudip

--spmmowioe5m7hsux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7c2782785736..09df885442ae 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2858,7 +2858,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 * setserial to be used to alter this port's parameters.
 	 */
 	tty_dev = tty_port_register_device_attr_serdev(port, drv->tty_driver,
-			uport->line, uport->dev, port, uport->tty_groups);
+			uport->line, uport->dev, port, uport->tty_groups,
+			false);
 	if (!IS_ERR(tty_dev)) {
 		device_set_wakeup_capable(tty_dev, 1);
 	} else {
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 5023c85ebc6e..dc66543fa2c3 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -152,11 +152,12 @@ EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
 struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp)
+		const struct attribute_group **attr_grp, bool link)
 {
 	struct device *dev;
 
-	tty_port_link_device(port, driver, index);
+	if (link)
+		tty_port_link_device(port, driver, index);
 
 	dev = serdev_tty_port_register(port, device, driver, index);
 	if (PTR_ERR(dev) != -ENODEV) {
@@ -184,7 +185,7 @@ struct device *tty_port_register_device_serdev(struct tty_port *port,
 		struct device *device)
 {
 	return tty_port_register_device_attr_serdev(port, driver, index,
-			device, NULL, NULL);
+			device, NULL, NULL, true);
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_serdev);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index bfa4e2ee94a9..7f2ad47ecf88 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -587,7 +587,7 @@ extern struct device *tty_port_register_device_serdev(struct tty_port *port,
 extern struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
-		const struct attribute_group **attr_grp);
+		const struct attribute_group **attr_grp, bool link);
 extern void tty_port_unregister_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index);
 extern int tty_port_alloc_xmit_buf(struct tty_port *port);

--spmmowioe5m7hsux--
