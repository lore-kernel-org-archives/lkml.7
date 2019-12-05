Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B48C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1ED224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfLEJcX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:32:23 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58626 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfLEJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:32:22 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5BDCCCECD4;
        Thu,  5 Dec 2019 10:41:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Bluetooth: btusb: Disable runtime suspend on Realtek
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191205090701.12440-1-kai.heng.feng@canonical.com>
Date:   Thu, 5 Dec 2019 10:32:19 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alex Lu <alex_lu@realsil.com.cn>, pkshih@realtek.com,
        linux-bluetooth@vger.kernel.or, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F8377E2D-EB26-4AF4-83B2-A7903C4A4D2D@holtmann.org>
References: <20191205090701.12440-1-kai.heng.feng@canonical.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

> After commit 9e45524a0111 ("Bluetooth: btusb: Fix suspend issue for
> Realtek devices") both WiFi and Bluetooth stop working after reboot:
> [   34.322617] usb 1-8: reset full-speed USB device number 3 using xhci_hcd
> [   34.450401] usb 1-8: device descriptor read/64, error -71
> [   34.694375] usb 1-8: device descriptor read/64, error -71
> ...
> [   44.599111] rtw_pci 0000:02:00.0: failed to poll offset=0x5 mask=0x3 value=0x0
> [   44.599113] rtw_pci 0000:02:00.0: mac power on failed
> [   44.599114] rtw_pci 0000:02:00.0: failed to power on mac
> [   44.599114] rtw_pci 0000:02:00.0: leave idle state failed
> [   44.599492] rtw_pci 0000:02:00.0: failed to leave ips state
> [   44.599493] rtw_pci 0000:02:00.0: failed to leave idle state
> 
> That commit removed USB_QUIRK_RESET_RESUME, which not only resets the USB
> device after resume, it also prevents the device from being runtime
> suspended by USB core. My experiment shows if the Realtek btusb device
> ever runtime suspends once, the entire wireless module becomes useless
> after reboot.
> 
> So let's explicitly disable runtime suspend on Realtek btusb device for
> now.
> 
> Fixes: 9e45524a0111 ("Bluetooth: btusb: Fix suspend issue for Realtek devices")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

