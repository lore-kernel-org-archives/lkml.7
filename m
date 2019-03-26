Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B77C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99082070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582210;
	bh=6s5MqJL9+KNEUBEtVwkMCyVQrQAius6m1WjXC0mGuVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1x/YriAQ2bZtCUn2CylWK6GPl6MkWXFcCtrqj0ZwxzWFlKuqIptozE+3cTQPsCG0b
	 ps+7DqZOPbxLKL4iRYW6ZeqzAfSjiIFa7Xd5Bg5NkO7MnrbV35Jp/C6NKlbVCFcAXH
	 WUeetRzBJNzTGYLtYOlgHhUUOnDQrt6QAxDNunf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfCZGgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731428AbfCZGgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:45 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E792070B;
        Tue, 26 Mar 2019 06:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582204;
        bh=6s5MqJL9+KNEUBEtVwkMCyVQrQAius6m1WjXC0mGuVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdL4hAgEt9YQh+ElkYemCC+QTnBd8PloXE8ipCnf2epbWcOmGw+A2+Y9Im2MJ6i3r
         JFP162sl/FP03UJxQjZcd4f4120gn0LxTG7HZ45qGvFwjKGyYQk/alDE0kj3uFTWfT
         D54RQ949DHlzI40w1dqiRkLWvOTvzQi36zHqLdgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+257790c15bcdef6fe00c@syzkaller.appspotmail.com,
        Jeremy Cline <jcline@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.19 32/45] Bluetooth: hci_ldisc: Initialize hci_dev before open()
Date:   Tue, 26 Mar 2019 15:30:15 +0900
Message-Id: <20190326042704.352272978@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jcline@redhat.com>

commit 32a7b4cbe93b0a0ef7e63d31ca69ce54736c4412 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_ldisc.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -207,11 +207,11 @@ void hci_uart_init_work(struct work_stru
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
 
@@ -616,6 +616,7 @@ static void hci_uart_tty_receive(struct
 static int hci_uart_register_dev(struct hci_uart *hu)
 {
 	struct hci_dev *hdev;
+	int err;
 
 	BT_DBG("");
 
@@ -659,11 +660,22 @@ static int hci_uart_register_dev(struct
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
@@ -683,17 +695,12 @@ static int hci_uart_set_proto(struct hci
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
 


