Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36941C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ECF21850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfGZO0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:26:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfGZO0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:26:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBABBC06511C;
        Fri, 26 Jul 2019 14:26:32 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.43.2.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3B075FCC8;
        Fri, 26 Jul 2019 14:26:30 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     vdronov@redhat.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suraj Sumangala <suraj@atheros.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Loic Poulain <loic.poulain@intel.com>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        syzkaller@googlegroups.com
Subject: [PATCH v2] Bluetooth: hci_ldisc: check for missing tty operations
Date:   Fri, 26 Jul 2019 16:26:28 +0200
Message-Id: <20190726142628.20534-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 26 Jul 2019 14:26:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain ttys operations (pty_unix98_ops) lack tiocmget() and tiocmset()
functions which are called by the certain HCI UART protocols (hci_ath,
hci_bcm, hci_intel, hci_mrvl, hci_qca) via hci_uart_set_flow_control()
or directly. This leads to an execution at NULL and can be triggered by
an unprivileged user. Fix this by adding a check for the missing tty
operations the same way it is done for write().

This fixes CVE-2019-10207. The Fixes: lines list commits where calls to
tiocm[gs]et() or hci_uart_set_flow_control() were added to the HCI UART
protocols.

Link: https://syzkaller.appspot.com/bug?id=1b42faa2848963564a5b1b7f8c837ea7b55ffa50
Reported-by: syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org # v2.6.36+
Fixes: c19483cc5e56 ("bluetooth: Fix missing NULL check")
Fixes: b3190df62861 ("Bluetooth: Support for Atheros AR300x serial chip")
Fixes: 118612fb9165 ("Bluetooth: hci_bcm: Add suspend/resume PM functions")
Fixes: ff2895592f0f ("Bluetooth: hci_intel: Add Intel baudrate configuration support")
Fixes: 162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")
Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---

out-of-commit-message-note:

I believe, this is a good location for the check. This way we protect protocols
which does not call tiocm[gs]et() or hci_uart_set_flow_control() but may
change to call them in the future.

Also we do not need hci_uart_has_tiocm_support() helper now.

 drivers/bluetooth/hci_ldisc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c84f985f348d..4a85c51d0307 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -459,10 +459,11 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 
 	BT_DBG("tty %p", tty);
 
-	/* Error if the tty has no write op instead of leaving an exploitable
-	 * hole
+	/* Error if the tty has no write or tiocm[gs]et ops instead of leaving
+	 * an exploitable hole
 	 */
-	if (tty->ops->write == NULL)
+	if (tty->ops->write == NULL || tty->ops->tiocmget == NULL ||
+	    tty->ops->tiocmset == NULL)
 		return -EOPNOTSUPP;
 
 	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
-- 
2.21.0
