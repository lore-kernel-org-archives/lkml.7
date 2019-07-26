Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2141BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2A6229F3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfGZVsE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:48:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43280 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfGZVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:48:04 -0400
Received: from marcel-macpro.fritz.box (p5B3D2BA7.dip0.t-ipconnect.de [91.61.43.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0B8A5CECD2;
        Fri, 26 Jul 2019 23:56:40 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] Bluetooth: hci_ldisc: check for missing tty operations
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190726142628.20534-1-vdronov@redhat.com>
Date:   Fri, 26 Jul 2019 23:48:02 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suraj Sumangala <suraj@atheros.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Loic Poulain <loic.poulain@intel.com>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        syzkaller@googlegroups.com
Content-Transfer-Encoding: 8BIT
Message-Id: <62A82405-46E2-4921-BA52-D1660FC2DDDB@holtmann.org>
References: <20190726142628.20534-1-vdronov@redhat.com>
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
> operations the same way it is done for write().
> 
> This fixes CVE-2019-10207. The Fixes: lines list commits where calls to
> tiocm[gs]et() or hci_uart_set_flow_control() were added to the HCI UART
> protocols.
> 
> Link: https://syzkaller.appspot.com/bug?id=1b42faa2848963564a5b1b7f8c837ea7b55ffa50
> Reported-by: syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org # v2.6.36+
> Fixes: c19483cc5e56 ("bluetooth: Fix missing NULL check")
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
> I believe, this is a good location for the check. This way we protect protocols
> which does not call tiocm[gs]et() or hci_uart_set_flow_control() but may
> change to call them in the future.
> 
> Also we do not need hci_uart_has_tiocm_support() helper now.
> 
> drivers/bluetooth/hci_ldisc.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index c84f985f348d..4a85c51d0307 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -459,10 +459,11 @@ static int hci_uart_tty_open(struct tty_struct *tty)
> 
> 	BT_DBG("tty %p", tty);
> 
> -	/* Error if the tty has no write op instead of leaving an exploitable
> -	 * hole
> +	/* Error if the tty has no write or tiocm[gs]et ops instead of leaving
> +	 * an exploitable hole
> 	 */
> -	if (tty->ops->write == NULL)
> +	if (tty->ops->write == NULL || tty->ops->tiocmget == NULL ||
> +	    tty->ops->tiocmset == NULL)
> 		return -EOPNOTSUPP;

this means that you can not run hci_h4.c on any TTY anymore. For all the vendor specific ones, I agree, but H:4 is a Bluetooth SIG defined standard one that we might want to allow on any kind of TTY since it doesn’t really mandate anything.

So I would prefer if we go with a hci_uart_has_tiocm_support helper for now. 

Regards

Marcel

