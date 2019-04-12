Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A473C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E90F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qat6M4p3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDLSOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:14:52 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34451 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfDLSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:14:49 -0400
Received: by mail-it1-f195.google.com with SMTP id z17so1084816itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy1RTJNul8Gq4kA2LdEWHyvJv8U3hvPPKDySjtoIuxI=;
        b=Qat6M4p3JWchst2c5rWTulSkKl6l4tu2zvHfsz6x1FLayqa6sq04hQCvHuRogWsr91
         MdT1Wp+lxIxlhOQWah4baFSQiFqxPvwGhJIP7c+EurKNREeulGQbJ2UnXnh76yhIYjDq
         BA9xWL/94yYp7aYgn2Exz60PFDjBW6A8nPi4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy1RTJNul8Gq4kA2LdEWHyvJv8U3hvPPKDySjtoIuxI=;
        b=GffY75/tXdKkxjFneS9n45JumGvMS0tjfw1UtvEcB3+JuHUxhgNU2w46IzMsYeFfcH
         G6+LplitaE4NN71wMT3F7SywpG7EQY6Kk75yogejxF91Bd3jiyOISghkXQIDCntf5gAp
         W7LWXCwTzH7TIJIAZ3aE4IDvgfJCSkNrkVc7C4ykcFOvyP5Od9697/RIoV7Hbd1WH0Hl
         4iteXHMtLeOQCGif+tG9yIqBr93mebrqxi1B1yOuHe4XZiUp1ljW5YBbUoRyiaKp2MgP
         vg9nf/kTrB8V9xwwWwIpI1kybNzXZZGLQYhGH9i0mj4/oq13u1jJxaWuAebb0JmVNcqc
         Tu1g==
X-Gm-Message-State: APjAAAW12d/jXsho9ALkAUhLf5DFjsG+yRNFtkqieD9KK+h0KChNUt96
        6wMdzoeBFB4puesehU9M/2dtfw==
X-Google-Smtp-Source: APXvYqzQ0AF/m/NUEtjm4G4/BuIfKcTcji6aSWW8VFx7T3j//Cu+cDzd0ACO4T00Kf7tg4nzpNDBEg==
X-Received: by 2002:a24:e85:: with SMTP id 127mr14575469ite.4.1555092887973;
        Fri, 12 Apr 2019 11:14:47 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id m30sm4276605iti.41.2019.04.12.11.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 11:14:47 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, alevkoy@chromium.org, keithshort@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v4 1/2] platform/chrome: wilco_ec: Fix documentation for debugfs raw attribute
Date:   Fri, 12 Apr 2019 12:14:42 -0600
Message-Id: <20190412181443.239166-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous refactor [repo chrome-platform, branch for-next,
commit 9cced499d6fdb60434ffa94f8f4b5087ad35802b
("platform/chrome: wilco_ec: Standardize mailbox interface")], the
documentation for the raw debugfs attribute became incorrect, but I
forgot to fix it. This patch fixes it, as well as de-duplicates
the documentation by removing it from the source file header comment.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/debugfs-wilco-ec | 32 ++++++++++++++--------
 drivers/platform/chrome/wilco_ec/debugfs.c | 27 +-----------------
 2 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-wilco-ec b/Documentation/ABI/testing/debugfs-wilco-ec
index f814f112e213..7ff6b45be703 100644
--- a/Documentation/ABI/testing/debugfs-wilco-ec
+++ b/Documentation/ABI/testing/debugfs-wilco-ec
@@ -4,20 +4,30 @@ KernelVersion:	5.1
 Description:
 		Write and read raw mailbox commands to the EC.
 
-		For writing:
-		Bytes 0-1 indicate the message type:
-			00 F0 = Execute Legacy Command
-			00 F2 = Read/Write NVRAM Property
-		Byte 2 provides the command code
-		Bytes 3+ consist of the data passed in the request
+		You can write a hexadecimal sentence to raw, and that series of
+		bytes will be sent to the EC. Then, you can read the bytes of
+		response by reading from raw.
 
-		At least three bytes are required, for the msg type and command,
-		with additional bytes optional for additional data.
+		For writing, bytes 0-1 indicate the message type, one of enum
+		wilco_ec_msg_type. Byte 2+ consist of the data passed in the
+		request, starting at MBOX[0]
+
+		At least three bytes are required for writing, two for the type
+		and at least a single byte of data. Only the first
+		EC_MAILBOX_DATA_SIZE bytes of MBOX will be used.
 
 		Example:
 		// Request EC info type 3 (EC firmware build date)
-		$ echo 00 f0 38 00 03 00 > raw
+		// Corresponds with sending type 0x00f0 with
+		// MBOX = [38, 00, 03, 00]
+		$ echo 00 f0 38 00 03 00 > /sys/kernel/debug/wilco_ec/raw
 		// View the result. The decoded ASCII result "12/21/18" is
 		// included after the raw hex.
-		$ cat raw
-		00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8...
+		// Corresponds with MBOX = [00, 00, 31, 32, 2f, 32, 31, 38, ...]
+		$ cat /sys/kernel/debug/wilco_ec/raw
+		00 00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  ..12/21/18.8...
+
+		Note that the first 32 bytes of the received MBOX[] will be
+		printed, even if some of the data is junk. It is up to you to
+		know how many of the first bytes of data are the actual
+		response.
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 17c4c9068aaf..8d307378c1cb 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -4,32 +4,7 @@
  *
  * Copyright 2019 Google LLC
  *
- * There is only one attribute used for debugging, called raw.
- * You can write a hexadecimal sentence to raw, and that series of bytes
- * will be sent to the EC. Then, you can read the bytes of response
- * by reading from raw.
- *
- * For writing:
- * Bytes 0-1 indicate the message type, one of enum wilco_ec_msg_type
- * Byte 2+ consist of the data passed in the request, starting at MBOX[0]
- *
- * At least three bytes are required for writing, two for the type and at
- * least a single byte of data. Only the first EC_MAILBOX_DATA_SIZE bytes
- * of MBOX will be used.
- *
- * Example:
- * // Request EC info type 3 (EC firmware build date)
- * // Corresponds with sending type 0x00f0 with MBOX = [38, 00, 03, 00]
- * $ echo 00 f0 38 00 03 00 > /sys/kernel/debug/wilco_ec/raw
- * // View the result. The decoded ASCII result "12/21/18" is
- * // included after the raw hex.
- * // Corresponds with MBOX = [00, 00, 31, 32, 2f, 32, 31, ...]
- * $ cat /sys/kernel/debug/wilco_ec/raw
- * 00 00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  ..12/21/18.8...
- *
- * Note that the first 32 bytes of the received MBOX[] will be printed,
- * even if some of the data is junk. It is up to you to know how many of
- * the first bytes of data are the actual response.
+ * See Documentation/ABI/testing/debugfs-wilco-ec for usage.
  */
 
 #include <linux/ctype.h>
-- 
2.20.1

