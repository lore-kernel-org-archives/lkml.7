Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA09C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC719216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dcNIgu5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfIQV6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 17:58:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46124 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfIQV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:58:11 -0400
Received: by mail-io1-f65.google.com with SMTP id d17so11231036ios.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxX/zwaBjlGD4EBBXdUpYuZJNp14w4mDoEUeeP5ZijY=;
        b=dcNIgu5x9wmQdheVTIPUciETkPNJh4ntZuXpR1erK+REUuvYgET56FXk9FrVZlAF4Y
         mHGCye1jbIyPsLmp/qJ91xJ5z/BahiTODzD/+2CmtiWWzEkWGxo1+eayrVcS8SXOHxBu
         /BKqmneFA7lmsyz/42mB+TMeoSzWM3/V4h75A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxX/zwaBjlGD4EBBXdUpYuZJNp14w4mDoEUeeP5ZijY=;
        b=rXQMN3Chb3XnxDgZzkw60XElFQBq9uAHgMjM5+suddvmxYVMNQvJWDBAV+oJsI4wxz
         bwYCb384HrUAb52cvRg5xWRgvBTw/C+TWN9VatawKn7/rw27KaHrfZ77LR+sxhQ3TOxS
         pvQA3DIHnNULrD2HMQlO6BCnzd3x0LQKYtdGjY/thxeu+gsYutqGNTRyolFra4n5+bex
         +lZO90jfUF8wBtiSjUvrBWnpc55INYoWWy3iOUbitCSkdGb1SeFvyQQ8s+FgIl2qc65T
         a9Fw+NFGBbN0oNzwJm2OB48L/1t4gd2eytENsWdhANuPjFx+u6E3x/4nsaC+nYIMeHex
         VpuA==
X-Gm-Message-State: APjAAAWQfQlimOkNzBBCNifrZOQgP0crBaNjQTCZIA2oG784azgSKIxm
        97VaDS666G6xrt77fce/eDoI5q5eRY8=
X-Google-Smtp-Source: APXvYqzNh6hw8Ul2LlHDqPZlx26ZvgF1QJmTAKDHmwb0HW+pO24qd28iJuU053DNzPPVrLKxJVCqQA==
X-Received: by 2002:a6b:b78b:: with SMTP id h133mr1271952iof.276.1568757490173;
        Tue, 17 Sep 2019 14:58:10 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:798c:e494:921c:d544])
        by smtp.gmail.com with ESMTPSA id 197sm4561618ioc.78.2019.09.17.14.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 14:58:09 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v2] platform/chrome: wilco_ec: Add debugfs test_event file
Date:   Tue, 17 Sep 2019 15:57:52 -0600
Message-Id: <20190917215752.67391-1-campello@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduces a new debugfs file 'test_event' that when written
to causes the EC to generate a test event.

Signed-off-by: Daniel Campello <campello@chromium.org>
---
Changes for v2:
  - Cleaned up and added comments.
  - Renamed and updated function signature from write_to_mailbox to
    send_ec_cmd.

 drivers/platform/chrome/wilco_ec/debugfs.c | 46 +++++++++++++++++-----
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 8d65a1e2f1a3..f27e67f057fe 100644
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
+static int send_ec_cmd(struct wilco_ec_device *ec, u8 sub_cmd, u8 *val)
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
@@ -200,9 +200,35 @@ static int h1_gpio_get(void *arg, u64 *val)

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
+/* Format set to NULL since it is only used on read operations which are
+ * forbidden by file permissions.
+ */
+DEFINE_DEBUGFS_ATTRIBUTE(fops_test_event, NULL, test_event_set, NULL);
+
 /**
  * wilco_ec_debugfs_probe() - Create the debugfs node
  * @pdev: The platform device, probably created in core.c
@@ -226,6 +252,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
 	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
 	debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
 			    &fops_h1_gpio);
+	debugfs_create_file("test_event", 0200, debug_info->dir, ec,
+			    &fops_test_event);

 	return 0;
 }
--
2.23.0.237.gc6a4ce50a0-goog

