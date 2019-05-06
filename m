Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB4C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E56120830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zj1Isurv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfEFReu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:34:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35856 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEFRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:34:49 -0400
Received: by mail-io1-f67.google.com with SMTP id e19so2024554iob.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5TGF5z/eKOr21882h2Y3ID4iEx5tbyPHEylutD2waAM=;
        b=Zj1IsurvycroaS0B3tZ+83qdV2fM4oLxLs/klJnexZA3yGzpW+uCl/ItyQtNb2KjJH
         8uq28ccpnB/RH3MYGXoosFcDlWRRcGfNgi7kqNP8ZMGWVX2G9mdQjtpTAzfyWB5n9TCy
         aocf2M5qe6+8EquFgcVZH7g6hZVPYEz4ji+kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5TGF5z/eKOr21882h2Y3ID4iEx5tbyPHEylutD2waAM=;
        b=a7xI0qB/mL1gcMXIpEsukqR/wZIa/gPuLxyNXQGmDYXJYbY3fkDcZQPIKL8qN8UPC2
         ECONHZZaDUlo8BHityr3z66Z11Xjzftwto+9TYez2C3B6gcRd2Lqvpz7ENx3nBzsqHL8
         iQCZA8AhimItN+BC6YWMYLAUbtaaoAhDU/tpt+9Zgbt2oQCuoDtGycDCVHcswbX8ClYT
         CzPiqqlmANiMvtsGxf4oRauVpu9UtXgVrmph25I0ht+VkqSO5FkX9+wBYJpIKAUFAp0t
         JN7woKhWl+VV8Hc1Rrhwf3ZeWA0uR5LVlMkIDH9nSMqocYFG5fGKlGaZNs2kKGcU7q21
         MHQg==
X-Gm-Message-State: APjAAAXft8PbriStv9vWwsfg59IMDfdi7eAggF1l51cd7aD6NNhWPksm
        NelCsYPXNeNHjSjDkVedJdRD4g==
X-Google-Smtp-Source: APXvYqzHiPPSqGo5jF/zA02FvmbotoFIDm6SF6VOQK8yRXmRMn4QI1Ua1SEh2lKMwf6GUhbEH1kTnA==
X-Received: by 2002:a05:6602:2143:: with SMTP id y3mr3383652ioy.175.1557164088384;
        Mon, 06 May 2019 10:34:48 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id f17sm4806229itb.13.2019.05.06.10.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 10:34:47 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, dtor@google.com, sjg@chromium.org,
        bartfab@chromium.org, lamzin@google.com, jchwong@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v3 1/2] platform/chrome: wilco_ec: Remove 256 byte transfers
Date:   Mon,  6 May 2019 11:34:38 -0600
Message-Id: <20190506173439.67291-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 0xF6 command, intended to send and receive 256 byte payloads to
and from the EC, is not needed. The 0xF5 command for 32 byte
payloads is sufficient. This patch removes support for the 0xF6
command and 256 byte payloads.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/debugfs-wilco-ec | 16 +++++++---------
 drivers/platform/chrome/wilco_ec/core.c    |  4 +---
 drivers/platform/chrome/wilco_ec/debugfs.c | 10 ++--------
 drivers/platform/chrome/wilco_ec/mailbox.c | 19 ++++---------------
 include/linux/platform_data/wilco-ec.h     |  9 ++-------
 5 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-wilco-ec b/Documentation/ABI/testing/debugfs-wilco-ec
index 73a5a66ddca6..9d8d9d2def5b 100644
--- a/Documentation/ABI/testing/debugfs-wilco-ec
+++ b/Documentation/ABI/testing/debugfs-wilco-ec
@@ -23,11 +23,9 @@ Description:
 
 		For writing, bytes 0-1 indicate the message type, one of enum
 		wilco_ec_msg_type. Byte 2+ consist of the data passed in the
-		request, starting at MBOX[0]
-
-		At least three bytes are required for writing, two for the type
-		and at least a single byte of data. Only the first
-		EC_MAILBOX_DATA_SIZE bytes of MBOX will be used.
+		request, starting at MBOX[0]. At least three bytes are required
+		for writing, two for the type and at least a single byte of
+		data.
 
 		Example:
 		// Request EC info type 3 (EC firmware build date)
@@ -40,7 +38,7 @@ Description:
 		$ cat /sys/kernel/debug/wilco_ec/raw
 		00 00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  ..12/21/18.8...
 
-		Note that the first 32 bytes of the received MBOX[] will be
-		printed, even if some of the data is junk. It is up to you to
-		know how many of the first bytes of data are the actual
-		response.
+		Note that the first 16 bytes of the received MBOX[] will be
+		printed, even if some of the data is junk, and skipping bytes
+		17 to 32. It is up to you to know how many of the first bytes of
+		data are the actual response.
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..d060d3aa5bae 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -52,9 +52,7 @@ static int wilco_ec_probe(struct platform_device *pdev)
 	ec->dev = dev;
 	mutex_init(&ec->mailbox_lock);
 
-	/* Largest data buffer size requirement is extended data response */
-	ec->data_size = sizeof(struct wilco_ec_response) +
-		EC_MAILBOX_DATA_SIZE_EXTENDED;
+	ec->data_size = sizeof(struct wilco_ec_response) + EC_MAILBOX_DATA_SIZE;
 	ec->data_buffer = devm_kzalloc(dev, ec->data_size, GFP_KERNEL);
 	if (!ec->data_buffer)
 		return -ENOMEM;
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index f163476d080d..281ec595e8e0 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -17,13 +17,13 @@
 #define DRV_NAME "wilco-ec-debugfs"
 
 /* The 256 raw bytes will take up more space when represented as a hex string */
-#define FORMATTED_BUFFER_SIZE (EC_MAILBOX_DATA_SIZE_EXTENDED * 4)
+#define FORMATTED_BUFFER_SIZE (EC_MAILBOX_DATA_SIZE * 4)
 
 struct wilco_ec_debugfs {
 	struct wilco_ec_device *ec;
 	struct dentry *dir;
 	size_t response_size;
-	u8 raw_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
+	u8 raw_data[EC_MAILBOX_DATA_SIZE];
 	u8 formatted_data[FORMATTED_BUFFER_SIZE];
 };
 static struct wilco_ec_debugfs *debug_info;
@@ -124,12 +124,6 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
 	msg.response_data = debug_info->raw_data;
 	msg.response_size = EC_MAILBOX_DATA_SIZE;
 
-	/* Telemetry commands use extended response data */
-	if (msg.type == WILCO_EC_MSG_TELEMETRY_LONG) {
-		msg.flags |= WILCO_EC_FLAG_EXTENDED_DATA;
-		msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
-	}
-
 	ret = wilco_ec_mailbox(debug_info->ec, &msg);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
index 7fb58b487963..c9c6c3194d12 100644
--- a/drivers/platform/chrome/wilco_ec/mailbox.c
+++ b/drivers/platform/chrome/wilco_ec/mailbox.c
@@ -119,7 +119,6 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
 	struct wilco_ec_response *rs;
 	u8 checksum;
 	u8 flag;
-	size_t size;
 
 	/* Write request header, then data */
 	cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, 0, sizeof(*rq), (u8 *)rq);
@@ -148,21 +147,11 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
 		return -EIO;
 	}
 
-	/*
-	 * The EC always returns either EC_MAILBOX_DATA_SIZE or
-	 * EC_MAILBOX_DATA_SIZE_EXTENDED bytes of data, so we need to
-	 * calculate the checksum on **all** of this data, even if we
-	 * won't use all of it.
-	 */
-	if (msg->flags & WILCO_EC_FLAG_EXTENDED_DATA)
-		size = EC_MAILBOX_DATA_SIZE_EXTENDED;
-	else
-		size = EC_MAILBOX_DATA_SIZE;
-
 	/* Read back response */
 	rs = ec->data_buffer;
 	checksum = cros_ec_lpc_io_bytes_mec(MEC_IO_READ, 0,
-					    sizeof(*rs) + size, (u8 *)rs);
+					    sizeof(*rs) + EC_MAILBOX_DATA_SIZE,
+					    (u8 *)rs);
 	if (checksum) {
 		dev_dbg(ec->dev, "bad packet checksum 0x%02x\n", rs->checksum);
 		return -EBADMSG;
@@ -173,9 +162,9 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
 		return -EBADMSG;
 	}
 
-	if (rs->data_size != size) {
+	if (rs->data_size != EC_MAILBOX_DATA_SIZE) {
 		dev_dbg(ec->dev, "unexpected packet size (%u != %zu)",
-			rs->data_size, size);
+			rs->data_size, EC_MAILBOX_DATA_SIZE);
 		return -EMSGSIZE;
 	}
 
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 1ff224793c99..e8e1c6e52d83 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -13,12 +13,9 @@
 
 /* Message flags for using the mailbox() interface */
 #define WILCO_EC_FLAG_NO_RESPONSE	BIT(0) /* EC does not respond */
-#define WILCO_EC_FLAG_EXTENDED_DATA	BIT(1) /* EC returns 256 data bytes */
 
 /* Normal commands have a maximum 32 bytes of data */
 #define EC_MAILBOX_DATA_SIZE		32
-/* Extended commands have 256 bytes of response data */
-#define EC_MAILBOX_DATA_SIZE_EXTENDED	256
 
 /**
  * struct wilco_ec_device - Wilco Embedded Controller handle.
@@ -85,14 +82,12 @@ struct wilco_ec_response {
  * enum wilco_ec_msg_type - Message type to select a set of command codes.
  * @WILCO_EC_MSG_LEGACY: Legacy EC messages for standard EC behavior.
  * @WILCO_EC_MSG_PROPERTY: Get/Set/Sync EC controlled NVRAM property.
- * @WILCO_EC_MSG_TELEMETRY_SHORT: 32 bytes of telemetry data provided by the EC.
- * @WILCO_EC_MSG_TELEMETRY_LONG: 256 bytes of telemetry data provided by the EC.
+ * @WILCO_EC_MSG_TELEMETRY: Request telemetry data from the EC.
  */
 enum wilco_ec_msg_type {
 	WILCO_EC_MSG_LEGACY = 0x00f0,
 	WILCO_EC_MSG_PROPERTY = 0x00f2,
-	WILCO_EC_MSG_TELEMETRY_SHORT = 0x00f5,
-	WILCO_EC_MSG_TELEMETRY_LONG = 0x00f6,
+	WILCO_EC_MSG_TELEMETRY = 0x00f5,
 };
 
 /**
-- 
2.20.1

