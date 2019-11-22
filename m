Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DEEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B04E20674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421962;
	bh=3PvQFrDSNvxXT8aqxDPH2197sp+KfURArbLR4QgM/34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dLQo7KWLkQLfNJarv4e46zFZx2tCHI4xRkM4XaODMeFtEGXoQpTzcdKZgYy2jowqe
	 3zfq2u0j4nwtJN97XOHX8kX6ulwhcbj9KrESDpHdUl3z4mnqPbS4wWABXezPbiWC65
	 P3rp0/5owKFEjgxxapVhrpA8MZFM1RVja2oJCVU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKVKfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfKVKfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:35:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D1520708;
        Fri, 22 Nov 2019 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418918;
        bh=3PvQFrDSNvxXT8aqxDPH2197sp+KfURArbLR4QgM/34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+TBBCCSsmZ84UujW/giNSG/XhgUpgrtXFVkvY5VcS/csnUcFpeDqcDzc6oJzV/6r
         PfiyMYyaeZn+cLZ+RgKRNAP6YlGQBql+ClWPgVpYUNcbLB4/8Vm/INfpqC0s8+CYl+
         u9j4xjVMXw1pv+swvoZ5KEpE2/J+2XUX0/vTbpnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH 4.4 096/159] Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data
Date:   Fri, 22 Nov 2019 11:28:07 +0100
Message-Id: <20191122100816.692418047@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@intel.com>

commit 84cb3df02aea4b00405521e67c4c67c2d525c364 upstream.

HCI_UART_PROTO_SET flag is set before hci_uart_set_proto call. If we
receive data from tty layer during this procedure, proto pointer may
not be assigned yet, leading to null pointer dereference in rx method
hci_uart_tty_receive.

This patch fixes this issue by introducing HCI_UART_PROTO_READY flag in
order to avoid any proto operation before proto opening and assignment.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_ldisc.c |   11 +++++++----
 drivers/bluetooth/hci_uart.h  |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -227,7 +227,7 @@ static int hci_uart_flush(struct hci_dev
 	tty_ldisc_flush(tty);
 	tty_driver_flush_buffer(tty);
 
-	if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		hu->proto->flush(hu);
 
 	return 0;
@@ -506,7 +506,7 @@ static void hci_uart_tty_close(struct tt
 
 	cancel_work_sync(&hu->write_work);
 
-	if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
+	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
@@ -514,6 +514,7 @@ static void hci_uart_tty_close(struct tt
 		}
 		hu->proto->close(hu);
 	}
+	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
 	kfree(hu);
 }
@@ -540,7 +541,7 @@ static void hci_uart_tty_wakeup(struct t
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -564,7 +565,7 @@ static void hci_uart_tty_receive(struct
 	if (!hu || tty != hu->tty)
 		return;
 
-	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		return;
 
 	/* It does not need a lock here as it is already protected by a mutex in
@@ -652,9 +653,11 @@ static int hci_uart_set_proto(struct hci
 		return err;
 
 	hu->proto = p;
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
+		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		p->close(hu);
 		return err;
 	}
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -94,6 +94,7 @@ struct hci_uart {
 /* HCI_UART proto flag bits */
 #define HCI_UART_PROTO_SET	0
 #define HCI_UART_REGISTERED	1
+#define HCI_UART_PROTO_READY	2
 
 /* TX states  */
 #define HCI_UART_SENDING	1


