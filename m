Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3592087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCLTqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:46:54 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58770 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726937AbfCLTqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:46:54 -0400
Received: (qmail 7719 invoked by uid 2102); 12 Mar 2019 15:46:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Mar 2019 15:46:53 -0400
Date:   Tue, 12 Mar 2019 15:46:53 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ondrej Zary <linux@zary.sk>
cc:     linux-usb@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: Resetting dead USB controllers automatically?
In-Reply-To: <201903121520.08430.linux@zary.sk>
Message-ID: <Pine.LNX.4.44L0.1903121536480.1457-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019, Ondrej Zary wrote:

> Hello,
> my USB controller sometimes dies when plugging a device (maybe because of static):
> 
> [11197.529334] ehci-pci 0000:00:09.2: HC died; cleaning up
> [11197.529883] uhci_hcd 0000:00:09.0: host system error, PCI problems?
> [11197.529893] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
> [11197.530568] usb 1-1: USB disconnect, device number 7
> [11197.531224] uhci_hcd 0000:00:09.0: host system error, PCI problems?
> [11197.531278] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
> [11197.532155] uhci_hcd 0000:00:09.0: host system error, PCI problems?
> [11197.532203] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
> [11197.539798] uhci_hcd 0000:00:09.0: host system error, PCI problems?
> [11197.539865] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
> [11197.540092] uhci_hcd 0000:00:09.0: host system error, PCI problems?
> [11197.540109] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
> [11197.541210] uhci_hcd 0000:00:09.0: host system error, PCI problems?
> [11197.541285] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
> [11197.553179] usb 1-2: USB disconnect, device number 3
> [11197.554087] usb 1-4: USB disconnect, device number 4
> [11197.580154] uhci_hcd 0000:00:09.0: FGR not stopped yet!
> [11197.943554] uhci_hcd 0000:00:09.0: host system error, PCI problems?
> [11197.943717] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
> [11197.943735] uhci_hcd 0000:00:09.0: host controller halted, very bad!
> [11197.943794] uhci_hcd 0000:00:09.0: HCRESET not completed yet!
> [11197.943809] uhci_hcd 0000:00:09.0: HC died; cleaning up
> 
> rmmod & modprobe isn't enough to fix it. Reboot is needed to make it work again.
> Or something like this:
> #!/bin/sh
> rmmod ehci-pci
> rmmod uhci-hcd
> echo 1 >"/sys/bus/pci/devices/0000:00:09.0/remove"
> echo 1 >"/sys/bus/pci/devices/0000:00:09.1/remove"
> echo 1 >"/sys/bus/pci/devices/0000:00:09.2/remove"
> echo 1 >/sys/bus/pci/rescan
> modprobe uhci-hcd
> 
> I'm not the only one affected by this problem:
> http://www.google.com/search?q=%22HC+died%3B+cleaning+up%22

It's noticeable that the majority of the reports listed by Google 
concern xHCI controllers, not UHCI like yours.

> Maybe the uhci/ehci drivers (or the USB core?) could reset the controller automatically to improve reliability.

Maybe.  Note that your script above interacts with the PCI core more
than the USB core, however.  In addition, there are potential problems
with this approach (for example, getting stuck in a loop that chews up
large amounts of CPU time because the hardware is in such bad shape
that resetting it doesn't help).

Given that the problem is pretty rare, and given that it can be fixed
by running a script like the one you list above, maybe there should be
a userspace daemon that periodically checks for controller failures and
tries to reset the hardware when appropriate.  Such a daemon could be
more flexible than a kernel driver.

> Looks like someone thought about this before but it was never implemented.
> There's a comment in ehci_handle_controller_death() function in drivers/usb/host/ehci-timer.c:
> 	/* Not in process context, so don't try to reset the controller */

No, you are misinterpreting that comment.  It doesn't mean resetting
the controller in order to make the hardware start working again; it
means resetting the controller to make sure that the hardware is idle
and isn't doing anything bad or unexpected.

Alan Stern

> The controller is:
> 00:09.0 USB controller [0c03]: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 Controller [1106:3038] (rev 62)
> 00:09.1 USB controller [0c03]: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 Controller [1106:3038] (rev 62)
> 00:09.2 USB controller [0c03]: VIA Technologies, Inc. USB 2.0 [1106:3104] (rev 65)

