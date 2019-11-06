Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8374C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EC52087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOQEjBet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfKFAaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:30:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33320 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbfKFAaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:30:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id u23so15869551pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qn/J/1PPzN9yYPx8ms3UdKQj06L6swPahcKzYXCyGo4=;
        b=ZOQEjBetAhlpeBEjjy35YzhHVGrbMEHXWH4SxMAcEk6gHOyX7cYfh0qG3+v3Gnxete
         swT0iYfkaaiadSbE9Sqn6OK0nwyZ9P3n6d9NzICQ6h5urypunAwaZBqNk6fuXPcAgtEr
         FuKAnkmA3RLkbRVUYXbtQPDrh8e+iM3AsTFHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qn/J/1PPzN9yYPx8ms3UdKQj06L6swPahcKzYXCyGo4=;
        b=Qz18DciPSRa/VeUDjEALiiw+30n37xzT5Hn1q7eiK4AfphDtBEBrsZN52wzCfu9AmP
         NfswxUsOllyOIaJB6y32r4PEbhP0HIHHqX7zLs8DGPK2ke8XtSWKctaqszNdwmi+FsIz
         egnwlokdLFTv+VjKzMXSksGUwZsy5y+QRI9gg2z4MwJ8cXC86BHRYOwyWNftHkoKQpLJ
         2qtrhwA3teOR0csnkHWeBSc9vC2BLlprX4OCbE+BTK7ByL0wzHaacFCxuRQuooYkKxTz
         26s5GD7AcKyZIV14k0X3OtHg+qTMjoQIoHyuo7w3nN8VM5+RYIXYXtlhjZgOiLnXFB1k
         H3aQ==
X-Gm-Message-State: APjAAAV+FjVdYwnncRnVGK17NqsFzYXM4v2EOp7MYOq0KOwr6ppKXVEk
        dMUZZFJKgYLEvh1u5Nc8nNFhF8y5TXE=
X-Google-Smtp-Source: APXvYqz5mZO2Oz5hXUS9MiNZ+n6TppXtk7hqUvUmmoCt0zqNVUdHs6HA1fpCBkFRp53KYB3tWDd6IQ==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr40736136pgi.128.1573000208956;
        Tue, 05 Nov 2019 16:30:08 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k9sm21032835pfk.72.2019.11.05.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 16:30:08 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: hci_bcm: Support pcm params in dts
Date:   Tue,  5 Nov 2019 16:29:22 -0800
Message-Id: <20191106002923.109344-4-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106002923.109344-1-abhishekpandit@chromium.org>
References: <20191106002923.109344-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM chips may require configuration of PCM to operate correctly and
there is a vendor specific HCI command to do this. Add support in the
hci_bcm driver to parse this from devicetree and configure the chip.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/hci_bcm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 4fe66e52927d..e94908a7e407 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -79,6 +79,7 @@
  * @hu: pointer to HCI UART controller struct,
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
+ * @pcm_params: Bytestring of pcm int and format params.
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -112,6 +113,9 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+
+	bool			has_pcm_params;
+	u8			pcm_params[BCM_PCM_PARAMS_COUNT];
 };
 
 /* generic bcm uart resources */
@@ -529,6 +533,8 @@ static int bcm_setup(struct hci_uart *hu)
 	const struct firmware *fw;
 	unsigned int speed;
 	int err;
+	struct bcm_set_pcm_int_params int_params;
+	struct bcm_set_pcm_format_params format_params;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
@@ -576,6 +582,23 @@ static int bcm_setup(struct hci_uart *hu)
 			host_set_baudrate(hu, speed);
 	}
 
+	/* PCM parameters if any*/
+	if (bcm->dev && bcm->dev->has_pcm_params) {
+		memcpy(&int_params, &(bcm->dev->pcm_params[0]),
+		       sizeof(int_params));
+		memcpy(&format_params, &(bcm->dev->pcm_params[5]),
+		       sizeof(format_params));
+
+		err = btbcm_set_pcm_params(hu->hdev, &int_params,
+					   &format_params);
+
+		if (err) {
+			bt_dev_info(hu->hdev, "BCM: Set pcm params failed (%d)",
+				    err);
+		}
+
+	}
+
 finalize:
 	release_firmware(fw);
 
@@ -1112,7 +1135,15 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 static int bcm_of_probe(struct bcm_device *bdev)
 {
+	int plen;
+
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+	plen = device_property_read_u8_array(bdev->dev, "pcm-parameters",
+					     bdev->pcm_params,
+					     BCM_PCM_PARAMS_COUNT);
+	if (plen == 0)
+		bdev->has_pcm_params = true;
+
 	return 0;
 }
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

