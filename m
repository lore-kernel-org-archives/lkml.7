Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150C3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E122E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCLOq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:46:59 -0400
Received: from ns.gsystem.sk ([62.176.172.50]:42592 "EHLO gsystem.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfCLOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:46:59 -0400
X-Greylist: delayed 1606 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 10:46:58 EDT
Received: from [192.168.1.3]
        by gsystem.sk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <linux@zary.sk>)
        id 1h3iGJ-00025t-5P; Tue, 12 Mar 2019 15:20:11 +0100
From:   Ondrej Zary <linux@zary.sk>
To:     linux-usb@vger.kernel.org
Subject: Resetting dead USB controllers automatically?
Date:   Tue, 12 Mar 2019 15:20:08 +0100
User-Agent: KMail/1.9.10
Cc:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201903121520.08430.linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
my USB controller sometimes dies when plugging a device (maybe because of static):

[11197.529334] ehci-pci 0000:00:09.2: HC died; cleaning up
[11197.529883] uhci_hcd 0000:00:09.0: host system error, PCI problems?
[11197.529893] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
[11197.530568] usb 1-1: USB disconnect, device number 7
[11197.531224] uhci_hcd 0000:00:09.0: host system error, PCI problems?
[11197.531278] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
[11197.532155] uhci_hcd 0000:00:09.0: host system error, PCI problems?
[11197.532203] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
[11197.539798] uhci_hcd 0000:00:09.0: host system error, PCI problems?
[11197.539865] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
[11197.540092] uhci_hcd 0000:00:09.0: host system error, PCI problems?
[11197.540109] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
[11197.541210] uhci_hcd 0000:00:09.0: host system error, PCI problems?
[11197.541285] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
[11197.553179] usb 1-2: USB disconnect, device number 3
[11197.554087] usb 1-4: USB disconnect, device number 4
[11197.580154] uhci_hcd 0000:00:09.0: FGR not stopped yet!
[11197.943554] uhci_hcd 0000:00:09.0: host system error, PCI problems?
[11197.943717] uhci_hcd 0000:00:09.0: host controller process error, something bad happened!
[11197.943735] uhci_hcd 0000:00:09.0: host controller halted, very bad!
[11197.943794] uhci_hcd 0000:00:09.0: HCRESET not completed yet!
[11197.943809] uhci_hcd 0000:00:09.0: HC died; cleaning up

rmmod & modprobe isn't enough to fix it. Reboot is needed to make it work again.
Or something like this:
#!/bin/sh
rmmod ehci-pci
rmmod uhci-hcd
echo 1 >"/sys/bus/pci/devices/0000:00:09.0/remove"
echo 1 >"/sys/bus/pci/devices/0000:00:09.1/remove"
echo 1 >"/sys/bus/pci/devices/0000:00:09.2/remove"
echo 1 >/sys/bus/pci/rescan
modprobe uhci-hcd

I'm not the only one affected by this problem:
http://www.google.com/search?q=%22HC+died%3B+cleaning+up%22

Maybe the uhci/ehci drivers (or the USB core?) could reset the controller automatically to improve reliability.

Looks like someone thought about this before but it was never implemented.
There's a comment in ehci_handle_controller_death() function in drivers/usb/host/ehci-timer.c:
	/* Not in process context, so don't try to reset the controller */



The controller is:
00:09.0 USB controller [0c03]: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 Controller [1106:3038] (rev 62)
00:09.1 USB controller [0c03]: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 Controller [1106:3038] (rev 62)
00:09.2 USB controller [0c03]: VIA Technologies, Inc. USB 2.0 [1106:3104] (rev 65)

-- 
Ondrej Zary
