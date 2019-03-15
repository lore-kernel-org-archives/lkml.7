Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D952184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS+1egnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfCOTKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:10:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35614 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfCOTKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:10:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id y15so7156113wma.0;
        Fri, 15 Mar 2019 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5B/xXHEVenCPejwYpnlBrM1Xy4JUrSSBY9vU2vcGVlQ=;
        b=ZS+1egnHyEuMCUKILaS3UB5h5rixuXGhhIWsAhTRGGT7QEcRWSF8e58k3+cFUYgxzE
         W5ewjjpNdmlrOWUF4v0UUdWeJIfVkR928fVG+9GTG43hw5HqqH2ExgyIM5ZdKy6W1G0n
         EghFGG9IOpB5xZZQAAxlN2bDtLtJIcusDnsH91lPUN86WM3DurAMjC2eRhmna89w4hD3
         RsHYE5giGt8BFkITanQ1gsJ7DRSyRbIFX8+eRR6yTos5+6Q/oXd1Q1yjqiiUEpPtowsM
         t/M65yapr/UHg55P+3W6vZ45SUCTx3gr/xOrPypjHhdwnP/aSB+vrYY3m0sdb/LbD6a5
         xesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5B/xXHEVenCPejwYpnlBrM1Xy4JUrSSBY9vU2vcGVlQ=;
        b=e+tP1IA2xDwlD4U3hgPYIdJdGdQrc3VM3n+TkwGjjDiYttAOpSj0m9JAGhx/LK8dAN
         TmFSrFw9gDq6IwX8mF4+WM+ywuXgAHIgu58XrXetWksyLsFEcec/ss+BWXNbi1UclIym
         7NSSkEK8G5s62SR6+JOR6OHUR3XTJG0kuELHfLIDVPpOP2QAKH6JFNFUMSc6l0xSYt9U
         Vk8Vv7MmpRW1dFLU2MEF+k6B2x0OTcy80654u+dpHjaAndWU0t3gTnYf7J4zjATuudKF
         /mUZmQOL+1i8pCNNbFGVIsjdy+gpGG1Oj73RLwZMGQ7GARyewGNU3yPwc3O4HzaQOu9I
         /VwA==
X-Gm-Message-State: APjAAAVoHjegjskBYv2+VvEfSltH4FOUop+N7p+QIDCYc0duhLzVsUJc
        e2tPmbxL60nk8IzMxyY7qTs=
X-Google-Smtp-Source: APXvYqz3F06C9KLq1tCvxNt5JbJzY13qvWSMhL/hVJFhF5KgxQkWFY15sskSDkTdPhGvyIG2mqBMBg==
X-Received: by 2002:a1c:9913:: with SMTP id b19mr3070854wme.127.1552677035510;
        Fri, 15 Mar 2019 12:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c50e:5126:7a00:3114:da88:9fb:388d])
        by smtp.gmail.com with ESMTPSA id t18sm2752044wmt.8.2019.03.15.12.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 12:10:34 -0700 (PDT)
From:   Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Simon Gene Gottlieb <simon@gottliebtfreitag.de>
Cc:     Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH] HID: steam: fix deadlock with input devices.
Date:   Fri, 15 Mar 2019 20:09:10 +0100
Message-Id: <20190315190910.4602-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using this driver with the wireless dongle and some usermode
program that monitors every input device (acpid, for example), while
another usermode client opens and closes the low-level device
repeadedly, the system eventually deadlocks.

The reason is that steam_input_register_device() must not be called with
the mutex held, because the input subsystem has its own synchronization
that clashes with this one: it is possible that steam_input_open() is
called before input_register_device() returns, and since
steam_input_open() needs to lock the mutex, it deadlocks.

However we must hold the mutex when calling any function that sends
commands to the controller. If not, random commands end up falling fail.

Reported-by: Simon Gene Gottlieb <simon@gottliebtfreitag.de>
Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Tested-by: Simon Gene Gottlieb <simon@gottliebtfreitag.de>
---
 drivers/hid/hid-steam.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 8141cadfca0e..8dae0f9b819e 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -499,6 +499,7 @@ static void steam_battery_unregister(struct steam_device *steam)
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
+	bool client_opened;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -511,9 +512,11 @@ static int steam_register(struct steam_device *steam)
 		 * Unlikely, but getting the serial could fail, and it is not so
 		 * important, so make up a serial number and go on.
 		 */
+		mutex_lock(&steam->mutex);
 		if (steam_get_serial(steam) < 0)
 			strlcpy(steam->serial_no, "XXXXXXXXXX",
 					sizeof(steam->serial_no));
+		mutex_unlock(&steam->mutex);
 
 		hid_info(steam->hdev, "Steam Controller '%s' connected",
 				steam->serial_no);
@@ -528,13 +531,15 @@ static int steam_register(struct steam_device *steam)
 	}
 
 	mutex_lock(&steam->mutex);
-	if (!steam->client_opened) {
+	client_opened = steam->client_opened;
+	if (!client_opened)
 		steam_set_lizard_mode(steam, lizard_mode);
+	mutex_unlock(&steam->mutex);
+
+	if (!client_opened)
 		ret = steam_input_register(steam);
-	} else {
+	else
 		ret = 0;
-	}
-	mutex_unlock(&steam->mutex);
 
 	return ret;
 }
@@ -630,14 +635,21 @@ static void steam_client_ll_close(struct hid_device *hdev)
 {
 	struct steam_device *steam = hdev->driver_data;
 
+	unsigned long flags;
+	bool connected;
+
+	spin_lock_irqsave(&steam->lock, flags);
+	connected = steam->connected;
+	spin_unlock_irqrestore(&steam->lock, flags);
+
 	mutex_lock(&steam->mutex);
 	steam->client_opened = false;
+	if (connected)
+		steam_set_lizard_mode(steam, lizard_mode);
 	mutex_unlock(&steam->mutex);
 
-	if (steam->connected) {
-		steam_set_lizard_mode(steam, lizard_mode);
+	if (connected)
 		steam_input_register(steam);
-	}
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
-- 
2.21.0

