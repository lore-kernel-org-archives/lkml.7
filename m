Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7869DC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7F6218DE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765749;
	bh=ncVHPYFmiozDN9U5v1hLJfuoaHA5rbJwE4ruf1HSaoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bVbqjGKE+E6EDIijn2ruw7kVPvfsBpTp9ZvfamDN+BnFid3+xyef1QNX9yvnN/a8x
	 WsImHLH4qYhhrZwO7O4XfjGa70nSaJ/EJjP1fyKq6Pwvc+tWfqWQPoBrXU2VorCqWC
	 WMwFnvFn72xG4tGieBNqF0VZwppfiGXx2E24kIOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfI2OC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730194AbfI2OC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:02:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB542082F;
        Sun, 29 Sep 2019 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765744;
        bh=ncVHPYFmiozDN9U5v1hLJfuoaHA5rbJwE4ruf1HSaoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pX91gUCg1qr/pP/Xe/yVzaP6EDpGuejsFkUv+q+b4vM58PO2xUNIVryTbL/xHEbM0
         nIum3aNWzAw0e9io7eHxZfE7s/v8ET3M/OUQqpuiYVKqy0nPfoy33cMVlApfnCbZWi
         9AY7zywMdWqiurfwyPwTK+xIuSdJq+xth+fL2Nx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 37/45] Bluetooth: btrtl: HCI reset on close for Realtek BT chip
Date:   Sun, 29 Sep 2019 15:56:05 +0200
Message-Id: <20190929135032.904966845@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

[ Upstream commit 7af3f558aca74f2ee47b173f1c27f6bb9a5b5561 ]

Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
after on-off several times. Bluetooth daemon sets BT mode failed when
this issue happens. Scanning must be active while turning off for this
bug to be hit.

bluetoothd[1576]: Failed to set mode: Failed (0x03)

If BT is turned off, then turned on again, it works correctly again.

According to the vendor driver, the HCI_QUIRK_RESET_ON_CLOSE flag is set
during probing. So, this patch makes Realtek's BT reset on close to fix
this issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203429
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Reviewed-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btrtl.c | 20 ++++++++++++++++++++
 drivers/bluetooth/btrtl.h |  6 ++++++
 drivers/bluetooth/btusb.c |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 208feef63de40..d04b443cad1f2 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -637,6 +637,26 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btrtl_setup_realtek);
 
+int btrtl_shutdown_realtek(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int ret;
+
+	/* According to the vendor driver, BT must be reset on close to avoid
+	 * firmware crash.
+	 */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		bt_dev_err(hdev, "HCI reset during shutdown failed");
+		return ret;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
+
 static unsigned int btrtl_convert_baudrate(u32 device_baudrate)
 {
 	switch (device_baudrate) {
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index f1676144fce81..10ad40c3e42c2 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -55,6 +55,7 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev);
 int btrtl_download_firmware(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev);
 int btrtl_setup_realtek(struct hci_dev *hdev);
+int btrtl_shutdown_realtek(struct hci_dev *hdev);
 int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev,
 			    unsigned int *controller_baudrate,
@@ -83,6 +84,11 @@ static inline int btrtl_setup_realtek(struct hci_dev *hdev)
 	return -EOPNOTSUPP;
 }
 
+static inline int btrtl_shutdown_realtek(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
 					  struct btrtl_device_info *btrtl_dev,
 					  unsigned int *controller_baudrate,
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7954a79249235..0f4750322864a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3181,6 +3181,7 @@ static int btusb_probe(struct usb_interface *intf,
 #ifdef CONFIG_BT_HCIBTUSB_RTL
 	if (id->driver_info & BTUSB_REALTEK) {
 		hdev->setup = btrtl_setup_realtek;
+		hdev->shutdown = btrtl_shutdown_realtek;
 
 		/* Realtek devices lose their updated firmware over suspend,
 		 * but the USB hub doesn't notice any status change.
-- 
2.20.1



