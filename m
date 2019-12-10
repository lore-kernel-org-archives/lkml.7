Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE17C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCB52073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBybQrbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLJLlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:41:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40412 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfLJLlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:41:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so2745553wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 03:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CCNCtyIpljxGbglOKFnRn5m+itMarmJl7+8snb+zxSE=;
        b=PBybQrbTFnbA6gaSClKcbfpJusLBtFBY3aqxZYLgVvz8j2iCSQxIDJTk8vRJdyX5IQ
         yC70f61tkLJPxnwNmw7KQ2A/w7luHlokBJxIi754fSUB76TUsD/z6FHiR12gz7wU3+ss
         GnXisc0hHIgmFv4DZw2cfU7U+QuQbMtE4HsyuJS0iUOteQrsFHJB13L+dqngPzLKfu+s
         Nnj0G3ywBceqZSP+bYXPQlUms1lhNJC9uL2dwy6mEpSIJibGX8ROmEcLmMQ/mNFPqoWf
         62vJNmPFjihxUuiTOZ1UnpDe2D1gt24ZR5vGd4OYo8gkggv72rrquEdWS2NdaTNuHPst
         mWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCNCtyIpljxGbglOKFnRn5m+itMarmJl7+8snb+zxSE=;
        b=kvbM7PA47HunbQG3RkpPiNpJqF7gZ96wUJWYgQJf1D01SoHYZBD5VGWFb+GvQUaXOA
         +eok/q5suTRFzjS/h/3SJH63nGg30na+b2yJPL4Hbuk2z+aRKSgB8ZyC38F2GCHZKT+R
         819pqGHrSzqP4iFrzZgdbJsUUcQFbGod258zF36uH8uyhVz9A8Dvr09bYpQidFGbJYQV
         ohFoqhRryc7CwVc5PLeQoYIuIDEtNC163nL1NoJyo3KmjnP91FqOg1MvJ1bBz1JWJWuZ
         IjSVk+11gA9H2Gk9czXDkdXSSRB+pAaAbBa3ZE3BhT1rzybSWS66owGCmkTODxmYi2IW
         KV2Q==
X-Gm-Message-State: APjAAAX7DFmZ5T4rCVU5Hyqwp0Q9+eDjvvHRvTkvQRxKfkhb+ziu+QOt
        pOl0EUNq1X0loG66b587rSQ=
X-Google-Smtp-Source: APXvYqz1fQqZaTpf4dhqEtZPiBvAnmTiVbP5QGngcmFM8sLv7CnFa8gKXc8rhDVNFCTrF27qdAZ7JQ==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr4664994wmk.119.1575978110010;
        Tue, 10 Dec 2019 03:41:50 -0800 (PST)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z83sm1612038wmg.2.2019.12.10.03.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 03:41:49 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:41:47 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty: use tty_init_dev_retry() to workaround a
 race condition
Message-ID: <20191210114147.ivple4ccr4bj6c4h@debian>
References: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
 <20191121152239.28405-2-sudipm.mukherjee@gmail.com>
 <20191121164138.GD651886@kroah.com>
 <20191121210155.limd7v6cpd5yz2e7@debian>
 <eef58b47-f208-2ac5-6e02-a87f9568c70f@suse.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xyokhrw7wuwg5wwa"
Content-Disposition: inline
In-Reply-To: <eef58b47-f208-2ac5-6e02-a87f9568c70f@suse.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xyokhrw7wuwg5wwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiri,

On Fri, Nov 22, 2019 at 10:05:09AM +0100, Jiri Slaby wrote:
> On 21. 11. 19, 22:01, Sudip Mukherjee wrote:
> > Hi Greg,
> > 
> > On Thu, Nov 21, 2019 at 05:41:38PM +0100, Greg Kroah-Hartman wrote:
> >> On Thu, Nov 21, 2019 at 03:22:39PM +0000, Sudip Mukherjee wrote:
> >>> There seems to be a race condition in tty drivers and I could see on
> >>> many boot cycles a NULL pointer dereference as tty_init_dev() tries to
> >>> do 'tty->port->itty = tty' even though tty->port is NULL.
<snip>
> >>>
> >>> uart_add_one_port() registers the console, as soon as it registers, the
> >>> userspace tries to use it and that leads to tty_open() but
> >>> uart_add_one_port() has not yet done tty_port_link_device() and so
> >>> tty->port is not yet configured when control reaches tty_init_dev().
> >>
> >> Shouldn't we do tty_port_link_device() before uart_add_one_port() to
> >> remove that race?  Once you register the console, yes, tty_open() can
> >> happen, so the driver had better be ready to go at that point in time.
> >>
> > 
> > But tty_port_link_device() is done by uart_add_one_port() itself.
> > After registering the console uart_add_one_port() will call
> > tty_port_register_device_attr_serdev() and tty_port_link_device() is
> > called from this. Thats still tty core.
> 
> Interferences of console vs tty code are ugly. Does it help to simply
> put tty_port_link_device to uart_add_one_port before uart_configure_port?

sorry for the late response, got busy with an out-of-tree driver.

It fixes the problem if I put tty_port_link_device() before
uart_configure_port(). Please check the attached patch and that
completely fixes the problem. Do you want me to send a proper patch for
it or do you want me to check more into it?

--
Regards
Sudip

--xyokhrw7wuwg5wwa
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 351843f847c0..006d478a63be 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2820,6 +2820,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
+	tty_port_link_device(port, drv->tty_driver, uport->line);
 	uart_configure_port(drv, state, uport);
 
 	port->console = uart_console(uport);
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index a9e12b3bc31d..a4f85fc75539 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -89,7 +89,8 @@ void tty_port_link_device(struct tty_port *port,
 {
 	if (WARN_ON(index >= driver->num))
 		return;
-	driver->ports[index] = port;
+	if (!driver->ports[index])
+		driver->ports[index] = port;
 }
 EXPORT_SYMBOL_GPL(tty_port_link_device);
 

--xyokhrw7wuwg5wwa--
