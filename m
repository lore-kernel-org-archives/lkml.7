Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A582077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8dIQV0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfDWHXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:23:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39957 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfDWHXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:23:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so7138129pgl.7;
        Tue, 23 Apr 2019 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlEwioMQ7r0YtuF2RvBtp1JPJLlQhSJVNXle47+PAQI=;
        b=r8dIQV0/4sByEXb/e+Jj4gshDSFYSb320uJvo8jVJ0up1Q7L5HM8rFtuav7lMvdaKU
         oSa3Q9+rTv2WH4KMsvEVDC0WNrf5r8P0nilPtgTSFesZb6oNVQy1p3emSKYL/jabSCkU
         HhO2+ILilnW8L/kgkXTpDwWaKiUmQ8oLUD5iI6ub4dog0wPOyctedLUaB7y/rW9ujCpU
         8i0vIheNIzUBBsCLCGCYsFnGKzrNXG+FP9it+uHTI5yzq6A6vNHoo+VDtvV+0029WBnk
         LFuMCo5Z1axqbafcEhrkl3x7BXG3mJvwe96Xm1WgAKVWF/7M8triVarT+2Qhmh+3L3ty
         RLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlEwioMQ7r0YtuF2RvBtp1JPJLlQhSJVNXle47+PAQI=;
        b=ImpfD4q7zGMc6dlIDjSA0jVSZ/YyuFdVK7+eTTNMSSdVFWZWT5qhpKRjZrjAFjShz7
         wRVEZH7Ofz5Wgmni5If3nvkCtbK+jji3nBV/dAXv5lo8pXOyfpUP9ncVx+npUNXnzwzw
         7IqTzexAfyBtd9kU/jERTrJaUgBmxa+uvaA09JCUO9zcUDwruNjIGMM0CrBQFnEXaKE9
         RxvQ4M6zrNnH4zQZ4bBUceHLAPcH+ocoLflXqZPRLxR7hCS6i0h7f5ChIYIjGYJtcg2F
         4SG7nfwxRCW6O5GzlzH2Jd5KscYHkIEQTeBMNYvCZQwAFQKbHfZi6wGL40EpiyhedYXR
         Jh7w==
X-Gm-Message-State: APjAAAU6zYKlMhDrDMnB2z/5EjM+BsBq/QUWtsmEY7SS23CLnkiXLRXl
        8Y7pO0AHsyvd9Bbhr9Crdoo=
X-Google-Smtp-Source: APXvYqxlTOTD4oTWMYMFxKPdKSvkuT9GMWkJEAy9GegJb6Ps/r/LeqE5ekxdqEnrmjuc4KvhvdxnuA==
X-Received: by 2002:a62:fb0a:: with SMTP id x10mr24868078pfm.179.1556004184662;
        Tue, 23 Apr 2019 00:23:04 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id p20sm12560594pgj.86.2019.04.23.00.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 00:23:04 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     bgodavar@codeaurora.org, ytkim@qca.qualcomm.com,
        "David S . Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH 2/2] Bluetooth: Set HCI_QUIRK_WAIT_FOR_MATCHING_CC for QCA9377
Date:   Tue, 23 Apr 2019 15:22:36 +0800
Message-Id: <20190423072236.24999-3-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423072236.24999-1-jprvita@endlessm.com>
References: <20190423072236.24999-1-jprvita@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCA9377 devices send an extra command complete for the
LE_SET_RANDOM_ADDR when trying to start an active scanning procedure. It
has to be ignored to avoid confusing the kernel into thinking a passive
scanning procedure is being performed instead, which makes impossible to
discover BTLE devices since no device found events are generated for
passive scanning.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded198328f21..650ba4b7908a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -70,6 +70,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM2045		0x40000
 #define BTUSB_IFNUM_2		0x80000
 #define BTUSB_CW6622		0x100000
+#define BTUSB_QCA9377		0x200000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -394,6 +395,10 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
 
+	/* QCA9377 devices */
+	{ USB_DEVICE(0x13d3, 0x3491), .driver_info = BTUSB_QCA9377 },
+	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA9377 },
+
 	{ }	/* Terminating entry */
 };
 
@@ -3196,6 +3201,10 @@ static int btusb_probe(struct usb_interface *intf,
 		btusb_check_needs_reset_resume(intf);
 	}
 
+	if (id->driver_info & BTUSB_QCA9377) {
+		set_bit(HCI_QUIRK_WAIT_FOR_MATCHING_CC, &hdev->quirks);
+	}
+
 #ifdef CONFIG_BT_HCIBTUSB_RTL
 	if (id->driver_info & BTUSB_REALTEK) {
 		hdev->setup = btrtl_setup_realtek;
-- 
2.20.1

