Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE79C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6743A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1PlBy5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441985AbfIXUhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 16:37:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44421 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfIXUhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:37:23 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so7760530iog.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaeaWBdArEAfa39+a057CzHk1IE9AGe9Y48nXTxnl5Y=;
        b=W1PlBy5P5VtV3sQkddl5oJuJMX55KxCaG67/yBgqducKodDImfrDuvr2N862waA2nj
         HQ5wdmPprUhTQMt+Hn9AIRQuuANbNohI7f3KbNc68ZWBmo/JAcWledMia/LrjmLWnQzN
         IsB3ZwPhyfjP9RMJweb+tOAkpq3xdcTfNcsYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaeaWBdArEAfa39+a057CzHk1IE9AGe9Y48nXTxnl5Y=;
        b=MU0G7IrCfeLHD2q+4xg5ZHz1zHj+GLFV6SMIOlFChSX0IT4dxx82SBxyw/ii9kRgeb
         JcjaiKObS8AAgYN9GK76oypo+uzj5JkK0NBBCSS8F2r56zUcNtqQmFkyR7NUY1j7oXwH
         ggn0kmKV23Wgr0bi3AIrjjTtoqkRCuIqb88Qjwrt9AKLL8g1Ko7XNUbFy42gFzpDHY1J
         VqJF1VpeWp6rnArwiSCQhx95izsFkTiaUD+9qyklrUfe299gwLdVJioAyih9XVbdD7VT
         n7JDK6oeT2FtZAWiAZVOvJAUuQ7749x5qoddF2mtnymz4w9u+nH3ptKFKK0sDrPHY/q+
         MraQ==
X-Gm-Message-State: APjAAAUXR0mrRyYkNpJy3vb8j4Ht1UpQlRYNB+N9W/xuQTScyxfUnlHF
        ty5wxfVOBnkZS1cySMslrZb0AtCeJJw=
X-Google-Smtp-Source: APXvYqzx9Mbt02iaJ9dtwVyRrdw332Z4biD5zuMgXnHM/n7mi8haZ5vY52NkKew9kLrj6ebiQjE7eg==
X-Received: by 2002:a02:a617:: with SMTP id c23mr870925jam.14.1569357441958;
        Tue, 24 Sep 2019 13:37:21 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:798c:e494:921c:d544])
        by smtp.gmail.com with ESMTPSA id u11sm3787705iof.22.2019.09.24.13.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 13:37:21 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v5] platform/chrome: wilco_ec: Add debugfs test_event file
Date:   Tue, 24 Sep 2019 14:37:16 -0600
Message-Id: <20190924203716.209420-1-campello@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduces a new debugfs file 'test_event' that when written
to causes the EC to generate a test event.
This adds a second sub cmd for the test event, and pulls out send_ec_cmd
to be a common helper between h1_gpio_get and test_event_set.

Signed-off-by: Daniel Campello <campello@chromium.org>
---
Changes for v2:
  - Cleaned up and added comments.
  - Renamed and updated function signature from write_to_mailbox to
    send_ec_cmd.
Changes for v3:
  - Switched NULL format string to empty format string
  - Renamed val parameter on send_ec_cmd to out_val
Changes for v4:
  - Provided a format string to avoid -Wformat-zero-length warning
Changes for v5:
  - Updated commit message to include more implementation details
  - Restored removed empty line between functions

 drivers/platform/chrome/wilco_ec/debugfs.c | 47 +++++++++++++++++-----
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 8d65a1e2f1a3..df5a5f6c3ec6 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -160,29 +160,29 @@ static const struct file_operations fops_raw = {

 #define CMD_KB_CHROME		0x88
 #define SUB_CMD_H1_GPIO		0x0A
+#define SUB_CMD_TEST_EVENT	0x0B

-struct h1_gpio_status_request {
+struct ec_request {
 	u8 cmd;		/* Always CMD_KB_CHROME */
 	u8 reserved;
-	u8 sub_cmd;	/* Always SUB_CMD_H1_GPIO */
+	u8 sub_cmd;
 } __packed;

-struct hi_gpio_status_response {
+struct ec_response {
 	u8 status;	/* 0 if allowed */
-	u8 val;		/* BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL */
+	u8 val;
 } __packed;

-static int h1_gpio_get(void *arg, u64 *val)
+static int send_ec_cmd(struct wilco_ec_device *ec, u8 sub_cmd, u8 *out_val)
 {
-	struct wilco_ec_device *ec = arg;
-	struct h1_gpio_status_request rq;
-	struct hi_gpio_status_response rs;
+	struct ec_request rq;
+	struct ec_response rs;
 	struct wilco_ec_message msg;
 	int ret;

 	memset(&rq, 0, sizeof(rq));
 	rq.cmd = CMD_KB_CHROME;
-	rq.sub_cmd = SUB_CMD_H1_GPIO;
+	rq.sub_cmd = sub_cmd;

 	memset(&msg, 0, sizeof(msg));
 	msg.type = WILCO_EC_MSG_LEGACY;
@@ -196,13 +196,38 @@ static int h1_gpio_get(void *arg, u64 *val)
 	if (rs.status)
 		return -EIO;

-	*val = rs.val;
+	*out_val = rs.val;

 	return 0;
 }

+/**
+ * h1_gpio_get() - Gets h1 gpio status.
+ * @arg: The wilco EC device.
+ * @val: BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL
+ */
+static int h1_gpio_get(void *arg, u64 *val)
+{
+	return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");

+/**
+ * test_event_set() - Sends command to EC to cause an EC test event.
+ * @arg: The wilco EC device.
+ * @val: unused.
+ */
+static int test_event_set(void *arg, u64 val)
+{
+	u8 ret;
+
+	return send_ec_cmd(arg, SUB_CMD_TEST_EVENT, &ret);
+}
+
+/* Format is unused since it is only required for get method which is NULL */
+DEFINE_DEBUGFS_ATTRIBUTE(fops_test_event, NULL, test_event_set, "%llu\n");
+
 /**
  * wilco_ec_debugfs_probe() - Create the debugfs node
  * @pdev: The platform device, probably created in core.c
@@ -226,6 +251,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
 	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
 	debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
 			    &fops_h1_gpio);
+	debugfs_create_file("test_event", 0200, debug_info->dir, ec,
+			    &fops_test_event);

 	return 0;
 }
--
2.23.0.351.gc4317032e6-goog

