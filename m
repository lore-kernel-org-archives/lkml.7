Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F63CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E59217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709959;
	bh=RjFWTkJ6gpACcsLvmy+kyqlzVKRiTFDE3NNAdDRzJe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KgJM0B6zHt1kD1EGJnS90ffc5Bfgp8PP258FXh5+PCxc5uBiqztTe7VBQZdfYMOXE
	 Dlbxf1UJZgdMqLlKRigo61Uf8YV+obFxFrnK8cY1TXqN4B2mKWvx9NO2VXkeLDchYn
	 CLlRVijQNKLkF81zG3fV+2vNTwnPTxMDCcInAEFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbfC0SF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387790AbfC0SFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE09D217F9;
        Wed, 27 Mar 2019 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709952;
        bh=RjFWTkJ6gpACcsLvmy+kyqlzVKRiTFDE3NNAdDRzJe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDWI3bFaZ1WSNXvfc83hwzAuKjhu+/63MKSe0/TkawbShUWzPityAHZhRt6HZJLGu
         JqAcC55fSf9X8VdouQB5I+EbF+1PL9ncBs+xL09sTPDOX9aQq5fxAMTGscHJnwQRXW
         6uvicYhUCX7CTexhHO2ppSp7TM/Acnc5bp04oprQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeremy Cline <jcline@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 128/262] Bluetooth: hci_ldisc: Initialize hci_dev before open()
Date:   Wed, 27 Mar 2019 13:59:43 -0400
Message-Id: <20190327180158.10245-128-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jcline@redhat.com>

[ Upstream commit 32a7b4cbe93b0a0ef7e63d31ca69ce54736c4412 ]

The hci_dev struct hdev is referenced in work queues and timers started
by open() in some protocols. This creates a race between the
initialization function and the work or timer which can result hdev
being dereferenced while it is still null.

The syzbot report contains a reliable reproducer which causes a null
pointer dereference of hdev in hci_uart_write_work() by making the
memory allocation for hdev fail.

To fix this, ensure hdev is valid from before calling a protocol's
open() until after calling a protocol's close().

Reported-by: syzbot+257790c15bcdef6fe00c@syzkaller.appspotmail.com
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..4918fefc4a6f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -207,11 +207,11 @@ void hci_uart_init_work(struct work_struct *work)
 	err = hci_register_dev(hu->hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device");
+		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		hu->proto->close(hu);
 		hdev = hu->hdev;
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
-		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		hu->proto->close(hu);
 		return;
 	}
 
@@ -616,6 +616,7 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 static int hci_uart_register_dev(struct hci_uart *hu)
 {
 	struct hci_dev *hdev;
+	int err;
 
 	BT_DBG("");
 
@@ -659,11 +660,22 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	else
 		hdev->dev_type = HCI_PRIMARY;
 
+	/* Only call open() for the protocol after hdev is fully initialized as
+	 * open() (or a timer/workqueue it starts) may attempt to reference it.
+	 */
+	err = hu->proto->open(hu);
+	if (err) {
+		hu->hdev = NULL;
+		hci_free_dev(hdev);
+		return err;
+	}
+
 	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return 0;
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+		hu->proto->close(hu);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
 		return -ENODEV;
@@ -683,17 +695,12 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 	if (!p)
 		return -EPROTONOSUPPORT;
 
-	err = p->open(hu);
-	if (err)
-		return err;
-
 	hu->proto = p;
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		p->close(hu);
 		return err;
 	}
 
-- 
2.19.1

