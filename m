Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A50FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30430205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="GAvjog6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfFYIcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:32:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44552 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbfFYIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:32:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so9078558pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eMlPVY24HiKoID6dzydanFhmPA3RfckjVd3enlhBYw=;
        b=GAvjog6fXTPDm8Zj/MWi+YqqZvAXOnu6RbEkNm5o349sRyL41W4ik/hRY7MZ9xx+Zj
         r+V8ygpCfaszrP2WT6vlf1gDMbfTIs6+qs5J326zeINqVZZwq8Vf7W6723NjW72iLWIx
         6yuJ1584bkhDREJNIlLoAoShh0kDZZ0uf6vrqc5AdAVNJHk+rlQ0r9NYo727QxUYthpT
         hKfzg66UwBRtiZMHKY6+q5n6qOJINCNxIDrudolIg/5so4DrZaQjwBuExdv8TC8axN1Y
         lctI9cz/YQHcsY/eJ0s/O/2ESh/2GN0Kv39qjif83PqLKjwhz8/chzwX5YcX8e8EYr1/
         lFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eMlPVY24HiKoID6dzydanFhmPA3RfckjVd3enlhBYw=;
        b=m9ja9DLSgnXcuojHk9rbgzxQ0D92l3XR8evgOBfaOIB3ze1vhdMdO7LXXLkkPYcO7U
         WNopqKOUDn2qIgleUF3ICcI0cOFcAbyv7dp/MldNfDA9vH2GVLvM6FoW22e/I3IbbU72
         pyq8BxzAF7pUz3wFSjHrQRgkHsPRntNME8J6u9szbBmgc0t2FkYiezOeQYtA4uUJDmvC
         Mk2J0wagCRuGnbBXEpDJhqW8xg302k9n6FhhXAd0UNIuKRV+eFEYzrUR2sENi+EVRMHV
         OY3ctPkN4tAuPIMB9gYxWw64MRmAST8+rdL40t+lAX7zjzSO6tPmi2EPu/Ut6pvfwRtJ
         pH0A==
X-Gm-Message-State: APjAAAW4FD3dCVV+LR5nPtSWtJ8WuOlBkrN8Qhu6pNvk4+aHTvpKGcr7
        KKC8zCgo9uffIdz/FkTmMwfFyg==
X-Google-Smtp-Source: APXvYqygKfikzR6BYrFJoIc7Gzyz3ec9Ws4XQBmlsZcPC5rySKVVebr0h4ft47XGnakA39G74h7DNw==
X-Received: by 2002:a17:90a:ca0f:: with SMTP id x15mr29575281pjt.82.1561451536737;
        Tue, 25 Jun 2019 01:32:16 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id v13sm14533710pfe.105.2019.06.25.01.32.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:32:16 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Daniel Drake <drake@endlessm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v3] Bluetooth: btrtl: HCI reset on close for Realtek BT chip
Date:   Tue, 25 Jun 2019 16:30:51 +0800
Message-Id: <20190625083051.7525-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <B8AD29F1-444A-4BB7-8C12-9C31EB974D11@holtmann.org>
References: <B8AD29F1-444A-4BB7-8C12-9C31EB974D11@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
v2:
 - According to the vendor driver, it makes "all" Realtek's BT reset on
   close. So, this version makes it the same.
 - Change to the new subject for all Realtek BT chips.

v3:
 - Fix the commit message and add the bug link.
 - Have btrtl_shutdown_realtek() which sends HCI reset command and as
   the callback function of hdev->shutdown for Realtek BT instead of
   setting HCI_QUIRK_RESET_ON_CLOSE flag.

 drivers/bluetooth/btrtl.c | 20 ++++++++++++++++++++
 drivers/bluetooth/btrtl.h |  6 ++++++
 drivers/bluetooth/btusb.c |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 208feef63de4..d04b443cad1f 100644
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
index f1676144fce8..10ad40c3e42c 100644
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
index 50aed5259c2b..342e1de6bcba 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3184,6 +3184,7 @@ static int btusb_probe(struct usb_interface *intf,
 #ifdef CONFIG_BT_HCIBTUSB_RTL
 	if (id->driver_info & BTUSB_REALTEK) {
 		hdev->setup = btrtl_setup_realtek;
+		hdev->shutdown = btrtl_shutdown_realtek;
 
 		/* Realtek devices lose their updated firmware over suspend,
 		 * but the USB hub doesn't notice any status change.
-- 
2.22.0

