Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40010C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0382082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XILQgtaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDJWHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:07:23 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39712 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJWHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:07:22 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so6158880ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8FysnlMUpmL4hHlzvOFrNctpm/LUPXwoq+FgvOXRqo=;
        b=XILQgtaDVNLn10Z3Aelam+w9wWZCH3gXAiw2rxm7gk1eercwQJEqDGAvOVoOCFzn4s
         X8+Z5oL9rqpCvyUIB3/jmiHBYD/rXNp5LDKxg+O8DAmWZs4HsC5VnqHpVXnWbfG3y12L
         W4qlc/IIj2dbpvkZcTEPIpjJkt0Y4k7exVKRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8FysnlMUpmL4hHlzvOFrNctpm/LUPXwoq+FgvOXRqo=;
        b=Y9vtX6EVEYmPiu6EYz0VEmsx/VlKoKVLgI7OoK++yAMEZrTwFnRAX5rv1DqIygB6mA
         Hjc4+kRqlPxdzlqS9dF9E0NUYThTX5zgXddv77VkinPAbbPBzOdXERHHkO7PETvNiELf
         gqy3b8pN0AlG/T0R22LcRODrkTh6oezJMfZOkBLAVAs7BxuUqpIR8eNihEvvJMj2dYs2
         0NsWesmhlbZm0Di4Wx4cRSKwhLFLl3nyTk4kp0Y36ZdZsF2MqYABb3zNCj+TRcytGSnz
         fRCwGNYr0ZpoIlgyS9VTZpibWRg0zIIhJ0uU3opnNCJUvnfxAfUYSbeXFOjq2gaR4GQX
         ySdg==
X-Gm-Message-State: APjAAAVdNKxyHZBNWz2tVBkKiqFLE6nGUEZs+fqb+i54bW/SMXO8fNzs
        W2pLrTatylBOnPeE+kNhNC81uQ==
X-Google-Smtp-Source: APXvYqwuyYHHhFM5DUXnwyJ6ge/IdIgpuQjw1VamxVpMVUSvGdRM9KcUjIySR8OjC34/Dv1Da1Sjzg==
X-Received: by 2002:a24:10c2:: with SMTP id 185mr5405199ity.52.1554934041689;
        Wed, 10 Apr 2019 15:07:21 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id y17sm3040426ita.2.2019.04.10.15.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 15:07:21 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, alevkoy@chromium.org, keithshort@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v3] platform/chrome: wilco_ec: Add h1_gpio status to debugfs
Date:   Wed, 10 Apr 2019 16:07:04 -0600
Message-Id: <20190410220703.51627-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of Chrome OS's FAFT (Fully Automated Firmware Testing)
tests, we need to ensure that the H1 chip is properly setting
some GPIO lines. The h1_gpio attribute exposes the state
of the lines:
- ENTRY_TO_FACT_MODE in BIT(0)
- SPI_CHROME_SEL in BIT(1)

There are two reasons that I am exposing this in debugfs,
and not as a GPIO:
1. This is only useful for testing, so end users shouldn't ever
care about this. In fact, if it passes the tests, then the value of
h1_gpio will always be 2, so it would be really uninteresting for users.
2. This GPIO is not connected to, controlled by, or really even related
to the AP. The GPIO runs between the EC and the H1 security chip.

Changes in v3:
- Fix documentation to correspond with formatting change in v2.
Changes in v2:
- Zero out the unused fields in the request.
- Format result as "%02x\n" instead of as a decimal.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/debugfs.c | 64 +++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 17c4c9068aaf..1b93243c8954 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2019 Google LLC
  *
- * There is only one attribute used for debugging, called raw.
+ * The raw attribute is very useful for EC debugging.
  * You can write a hexadecimal sentence to raw, and that series of bytes
  * will be sent to the EC. Then, you can read the bytes of response
  * by reading from raw.
@@ -30,6 +30,16 @@
  * Note that the first 32 bytes of the received MBOX[] will be printed,
  * even if some of the data is junk. It is up to you to know how many of
  * the first bytes of data are the actual response.
+ *
+ * There is also another debugfs attribute, called h1_gpio.
+ * As part of Chrome OS's FAFT (Fully Automated Firmware Testing)
+ * tests, we need to ensure that the H1 chip is properly setting
+ * some GPIO lines. The h1_gpio attribute exposes the state
+ * of the lines:
+ * - ENTRY_TO_FACT_MODE in BIT(0)
+ * - SPI_CHROME_SEL in BIT(1)
+
+ * Output will formatted with "%02x\n".
  */
 
 #include <linux/ctype.h>
@@ -189,6 +199,56 @@ static const struct file_operations fops_raw = {
 	.llseek = no_llseek,
 };
 
+#define CMD_KB_CHROME		0x88
+#define SUB_CMD_H1_GPIO		0x0A
+
+struct h1_gpio_status_request {
+	u8 cmd;		/* Always CMD_KB_CHROME */
+	u8 reserved;
+	u8 sub_cmd;	/* Always SUB_CMD_H1_GPIO */
+} __packed;
+
+struct hi_gpio_status_response {
+	u8 status;	/* 0 if allowed */
+	u8 val;		/* BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL */
+} __packed;
+
+static ssize_t h1_gpio_read(struct file *file, char __user *user_buf,
+			    size_t count, loff_t *ppos)
+{
+	struct h1_gpio_status_request rq;
+	struct hi_gpio_status_response rs;
+	struct wilco_ec_message msg;
+	char buf[4];
+	int ret;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.cmd = CMD_KB_CHROME;
+	rq.sub_cmd = SUB_CMD_H1_GPIO;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = &rq;
+	msg.request_size = sizeof(rq);
+	msg.response_data = &rs;
+	msg.response_size = sizeof(rs);
+	ret = wilco_ec_mailbox(debug_info->ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (rs.status)
+		return -EIO;
+
+	sprintf(buf, "%02x\n", rs.val);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, sizeof(buf));
+}
+
+static const struct file_operations fops_h1_gpio = {
+	.owner = THIS_MODULE,
+	.read = h1_gpio_read,
+	.llseek = no_llseek,
+};
+
 /**
  * wilco_ec_debugfs_probe() - Create the debugfs node
  * @pdev: The platform device, probably created in core.c
@@ -210,6 +270,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
 	if (!debug_info->dir)
 		return 0;
 	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
+	debugfs_create_file("h1_gpio", 0444, debug_info->dir, NULL,
+			    &fops_h1_gpio);
 
 	return 0;
 }
-- 
2.20.1

