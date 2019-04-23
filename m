Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4755BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2054020645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfDWQ2f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:28:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34390 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:28:34 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 20F41CF2E8;
        Tue, 23 Apr 2019 18:36:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Disable LE Advertising on system
 suspend
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190422092034.21461-2-kai.heng.feng@canonical.com>
Date:   Tue, 23 Apr 2019 18:28:32 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3E3982D2-2912-4467-A8BF-C0BE53C9B82C@holtmann.org>
References: <20190422092034.21461-1-kai.heng.feng@canonical.com>
 <20190422092034.21461-2-kai.heng.feng@canonical.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

> System may freeze during suspend, and it's caused by btusb early wakeup:
> 
> kernel: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
> kernel: dpm_run_callback(): pci_pm_suspend+0x0/0x130 returns -16
> kernel: PM: Device 0000:00:14.0 failed to suspend async: error -16
> kernel: PM: Some devices failed to suspend, or early wake event detected
> kernel: usb usb1: usb resume
> kernel: hub 1-0:1.0: hub_resume
> kernel: usb usb1-port1: status 0507 change 0000
> kernel: usb usb1-port6: status 0103 change 0004
> kernel: usb usb1-port10: status 0107 change 0000
> 
> where btusb is connecte to usb1-port6.
> 
> The expirement shows that the early wakeup is caused by LE Advertising
> packet.
> 
> Disabling it via event mask can prevent the issue from happening.
> 
> BugLink: https://bugs.launchpad.net/bugs/1823029
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 10c8f9872ee5..f03fcf5687e4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -490,6 +490,7 @@ struct btusb_data {
> 	int (*setup_on_usb)(struct hci_dev *hdev);
> 
> 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> +	bool suspended;
> };
> 
> static inline void btusb_free_frags(struct btusb_data *data)
> @@ -3316,12 +3317,18 @@ static void btusb_disconnect(struct usb_interface *intf)
> static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
> {
> 	struct btusb_data *data = usb_get_intfdata(intf);
> +	struct hci_dev *hdev = data->hdev;
> 
> 	BT_DBG("intf %p", intf);
> 
> 	if (data->suspend_count++)
> 		return 0;
> 
> +	if (!PMSG_IS_AUTO(message)) {
> +		hci_disable_le_advertising(hdev);
> +		data->suspended = true;
> +	}
> +
> 	spin_lock_irq(&data->txlock);
> 	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
> 		set_bit(BTUSB_SUSPENDING, &data->flags);
> @@ -3427,6 +3434,11 @@ static int btusb_resume(struct usb_interface *intf)
> 	spin_unlock_irq(&data->txlock);
> 	schedule_work(&data->work);
> 
> +	if (data->suspended) {
> +		hci_enable_le_advertising(hdev);
> +		data->suspended = false;
> +	}
> +
> 	return 0;

this is a clear NAK. Please stop hacking things.

Lets use hci_suspend_dev and hci_resume_dev and make it actually do something to disable the events for advertising.

Regards

Marcel

