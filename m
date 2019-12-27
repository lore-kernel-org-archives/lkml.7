Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8778C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C073320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 14:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfL0Or1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 09:47:27 -0500
Received: from netrider.rowland.org ([192.131.102.5]:44793 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726935AbfL0Or0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 09:47:26 -0500
Received: (qmail 5815 invoked by uid 500); 27 Dec 2019 09:47:25 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Dec 2019 09:47:25 -0500
Date:   Fri, 27 Dec 2019 09:47:25 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Peter Chen <peter.chen@nxp.com>
cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Chen <peter.chen@freescale.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: host: Disable port power only if previously
 enabled
In-Reply-To: <20191227014459.GA5283@b29397-desktop>
Message-ID: <Pine.LNX.4.44L0.1912270945001.5688-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019, Peter Chen wrote:

> On 19-12-26 14:46:15, Alan Stern wrote:
> > On Thu, 26 Dec 2019, Guenter Roeck wrote:
> > 
> > > On shutdown, ehci_power_off() is called unconditionally to power off
> > > each port, even if it was never called to power on the port.
> > > For chipidea, this results in a call to ehci_ci_portpower() with a request
> > > to power off ports even if the port was never powered on.
> > > This results in the following warning from the regulator code.
> > 
> > That's weird -- we should always power-on every port during hub 
> > initialization.
> > 
> > It looks like there's a bug in hub.c:hub_activate(): The line under
> > HUB_INIT which calls hub_power_on() should call
> > usb_hub_set_port_power() instead.  In fact, the comment near the start
> > of hub_power_on() is wrong.  It says "Enable power on each port", but
> > in fact it only enables power for ports that had been powered-on
> > previously (i.e., the port's bit in hub->power_bits was set).  
> > Apparently this got messed up in commit ad493e5e5805 ("usb: add usb
> > port auto power off mechanism").
> > 
> > Now, the chipidea driver may still need to be updated, because 
> > ehci_turn_off_all_ports() will still be called during shutdown and it 
> > will try to power-down all ports, even those which are already powered 
> > down (for example, because the port is suspended).
> > 
> 
> Hi Alan,
> 
> When the port is suspended, why it was turned off? If it was turned
> off, how could respond wakeup event?

You're right; if a port is powered off then it can't respond to wakeup 
events.

But if the power/wakeup attribute is set to "disabled" then the port 
doesn't need to respond to wakeup events.  In that situation, usbcore 
may decide to power-down the port.

Alan Stern

