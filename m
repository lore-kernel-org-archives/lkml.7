Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49611C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CDC20665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfG3JeO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:34:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38663 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfG3JeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:34:13 -0400
Received: from marcel-macbook.fritz.box (p5B3D2BA7.dip0.t-ipconnect.de [91.61.43.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 54285CECFD;
        Tue, 30 Jul 2019 11:42:50 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] Bluetooth: hci_uart: check for missing tty operations
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190729122215.9948-1-vdronov@redhat.com>
Date:   Tue, 30 Jul 2019 11:34:11 +0200
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Loic Poulain <loic.poulain@intel.com>,
        Suraj Sumangala <suraj@atheros.com>, syzkaller@googlegroups.com
Content-Transfer-Encoding: 8BIT
Message-Id: <F6BBC244-B565-4651-9EDD-8C1B8621392F@holtmann.org>
References: <62A82405-46E2-4921-BA52-D1660FC2DDDB@holtmann.org>
 <20190729122215.9948-1-vdronov@redhat.com>
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
> an unprivileged user. Fix this by adding a helper function and a check
> for the missing tty operations in the protocols code.
> 
> This fixes CVE-2019-10207. The Fixes: lines list commits where calls to
> tiocm[gs]et() or hci_uart_set_flow_control() were added to the HCI UART
> protocols.
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
> 
> out-of-commit-message-note:
> 
> it is possible that a HCI UART protocol uses serial device's
> operations and not a tty ones. i made hci_uart_has_flow_control() to
> check this also, hence the name. serial device's code checks if
> the needed operations are present itself.
> 
> i believe, hci_h5 does not need this check, as it uses serial device
> functions only (as of now):
> 
>    serdev_device_set_flow_control(h5->hu->serdev, false);
>    serdev_device_set_baudrate(h5->hu->serdev, 115200);
> 
> drivers/bluetooth/hci_ath.c   | 3 +++
> drivers/bluetooth/hci_bcm.c   | 3 +++
> drivers/bluetooth/hci_intel.c | 3 +++
> drivers/bluetooth/hci_ldisc.c | 7 +++++++
> drivers/bluetooth/hci_mrvl.c  | 3 +++
> drivers/bluetooth/hci_qca.c   | 3 +++
> drivers/bluetooth/hci_uart.h  | 1 +
> 7 files changed, 23 insertions(+)

I changed the hci_uart_has_flow_control function into using more readable separate checks and then send the patch directly to Linus.

Regards

Marcel

