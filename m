Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD2720854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nll7LU+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbfIFUmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:42:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38575 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbfIFUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:42:11 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so15787620iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TU1m8XRgJARH3A3nHJsonvmUMfEtHU2fRLYFPigNRcA=;
        b=Nll7LU+HGszbS28fPBR20DlR+6UbIqoNFcrgiUiBrMrX202kuHbInpZWkJ/u/xeFxV
         0ze0iIlMNXxOPV1bdmCbRUsK3oMSUL+wB1XHKP7OmFW88EPb0tp91dEHtTJANj9lRBSr
         Nor+rSTTPkKrvZ2b3RWGM0YIULt0qswIenTcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TU1m8XRgJARH3A3nHJsonvmUMfEtHU2fRLYFPigNRcA=;
        b=a+kct6brMfwNbdtI4Oue8nMYyrZiYVxRs/Jq7LCu8XHZyTsBaBGeI3Up/9Mpfj/s86
         Z4LVB0ErDUJgkoi97o6wLQ9aBIuSVeqmmMZmA1TE9twCSE3bV1J8qcBf+v5v+zrjiSOT
         +qspi81KyuuDDRK431jfFqa1SFbm/H7FyDRRl4HWlhXZmQpPjrT62NDxbe00I4g1kX9m
         zgkE9zexq2C2YlNhizvkPzcRlZq8lmoV8j4+7Bfr2xfYHXP3bNDNDdYL5dFMh4zJHhJL
         7mrMr+yiO1BoSg1wp9kUQOUqHv+Ps+4EfVdRaEjykT/BSnQm94nLhySvfEcEBukVVH2W
         cDPQ==
X-Gm-Message-State: APjAAAW+RT1Hx2MBBrnj0sLpyBYRDq6ZvJQPmDtT+3wn52zFG4U2r4VA
        qyIKdK35MQ7r3TFUJz+gP4Unqb3/GDM=
X-Google-Smtp-Source: APXvYqwrUOIQ4LFF0YaIKsFfpQbLGtQbATytgOfPakU690aTj23UXiFbMbwlWuxYOpSCwUcGbunM+w==
X-Received: by 2002:a6b:b4c7:: with SMTP id d190mr7660297iof.209.1567802530694;
        Fri, 06 Sep 2019 13:42:10 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:798c:e494:921c:d544])
        by smtp.gmail.com with ESMTPSA id c15sm6009166ioi.74.2019.09.06.13.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 13:42:09 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH] platform/chrome: wilco_ec: Add debugfs test_event file
Date:   Fri,  6 Sep 2019 14:42:05 -0600
Message-Id: <20190906204205.50799-1-campello@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
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

 drivers/platform/chrome/wilco_ec/debugfs.c | 33 +++++++++++++++++-----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 8d65a1e2f1a3..2103c3ed8385 100644
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
 	u8 sub_cmd;	/* Always SUB_CMD_H1_GPIO */
 } __packed;

-struct hi_gpio_status_response {
+struct ec_response {
 	u8 status;	/* 0 if allowed */
 	u8 val;		/* BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL */
 } __packed;

-static int h1_gpio_get(void *arg, u64 *val)
+static int write_to_mailbox(struct wilco_ec_device *ec, u8 sub_cmd, u64 *val)
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
@@ -201,8 +201,25 @@ static int h1_gpio_get(void *arg, u64 *val)
 	return 0;
 }

+static int h1_gpio_get(void *arg, u64 *val)
+{
+	return write_to_mailbox(arg, SUB_CMD_H1_GPIO, val);
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");

+static int test_event_set(void *arg, u64 val)
+{
+	u64 ret;
+
+	return write_to_mailbox(arg, SUB_CMD_TEST_EVENT, &ret);
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
@@ -226,6 +243,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
 	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
 	debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
 			    &fops_h1_gpio);
+	debugfs_create_file("test_event", 0200, debug_info->dir, ec,
+			    &fops_test_event);

 	return 0;
 }
--
2.23.0.162.g0b9fbb3734-goog

