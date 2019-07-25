Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E307FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5B721951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfGYM7q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:59:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50657 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGYM7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:59:46 -0400
Received: from marcel-macbook.fritz.box (p5B3D2BA7.dip0.t-ipconnect.de [91.61.43.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id A8EA1CEC82;
        Thu, 25 Jul 2019 15:08:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: hci_uart: check for missing tty operations in
 protocol handlers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190725120909.31235-1-vdronov@redhat.com>
Date:   Thu, 25 Jul 2019 14:59:42 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suraj Sumangala <suraj@atheros.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Loic Poulain <loic.poulain@intel.com>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        syzkaller@googlegroups.com
Content-Transfer-Encoding: 8BIT
Message-Id: <2E234F47-724D-4CFB-93B5-48E5BDA6F230@holtmann.org>
References: <20190725120909.31235-1-vdronov@redhat.com>
To:     Vladis Dronov <vdronov@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladis,

> Certain ttys operations (pty_unix98_ops) lack tiocmget() and tiocmset()
> functions which are called by the certain HCI UART protocols (hci_ath,
> hci_bcm, hci_intel, hci_mrvl, hci_qca) via hci_uart_set_flow_control()
> or directly. This leads to an execution at NULL and can be triggered by
> an unprivileged user. Fix this by adding a check for the missing tty
> operations to the protocols which use them.
> 
> This fixes CVE-2019-10207.
> 
> Link: https://syzkaller.appspot.com/bug?id=1b42faa2848963564a5b1b7f8c837ea7b55ffa50
> Reported-by: syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org # v2.6.36+
> Fixes: b3190df62861 ("Bluetooth: Support for Atheros AR300x serial chip")
> Fixes: 118612fb9165 ("Bluetooth: hci_bcm: Add suspend/resume PM functions")
> Fixes: ff2895592f0f ("Bluetooth: hci_intel: Add Intel baudrate configuration support")
> Fixes: 162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")
> Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
> drivers/bluetooth/hci_ath.c   | 3 +++
> drivers/bluetooth/hci_bcm.c   | 5 +++++
> drivers/bluetooth/hci_intel.c | 3 +++
> drivers/bluetooth/hci_mrvl.c  | 3 +++
> drivers/bluetooth/hci_qca.c   | 4 ++++
> 5 files changed, 18 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> index a55be205b91a..99df8a13e47e 100644
> --- a/drivers/bluetooth/hci_ath.c
> +++ b/drivers/bluetooth/hci_ath.c
> @@ -98,6 +98,9 @@ static int ath_open(struct hci_uart *hu)
> 
> 	BT_DBG("hu %p", hu);
> 
> +	if (!hu->tty->driver->ops->tiocmget || !hu->tty->driver->ops->tiocmset)
> +		return -ENOTSUPP;
> +
> 	ath = kzalloc(sizeof(*ath), GFP_KERNEL);
> 	if (!ath)
> 		return -ENOMEM;
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 8905ad2edde7..8c3e09cc341c 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -406,6 +406,11 @@ static int bcm_open(struct hci_uart *hu)
> 
> 	bt_dev_dbg(hu->hdev, "hu %p", hu);
> 
> +#ifdef CONFIG_PM
> +	if (!hu->tty->driver->ops->tiocmget || !hu->tty->driver->ops->tiocmset)
> +		return -ENOTSUPP;
> +#endif
> +

why is this one hidden behind CONFIG_PM? The general baud rate changes are independent of runtime power management support.

And I would introduce a bool hci_uart_has_tiocm_support(struct hci_uart *) helper.

Regards

Marcel

