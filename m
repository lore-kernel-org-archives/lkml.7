Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED730C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C075A2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGO5KOgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDLSOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:14:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33489 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDLSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:14:49 -0400
Received: by mail-it1-f194.google.com with SMTP id v8so1088154itf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZzaKnbC8+hFXRgfCxELHqZr7egazzefCjZH1uttlhY=;
        b=hGO5KOgU9232NBDJ80m8RRy/Z9topxYwO/U3sEZX9caRUm4lb0Az5CJxIdavZxhDoL
         gVldpNThh/CSMSbJLrojZliVpV9glB5Fa64e2GVbl7Hg0p90REA2Gta8rJYZ9fSTfpBM
         oLUjbvLTBQbzunSk4CQgZL5aRzi/MvbcvC/no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZzaKnbC8+hFXRgfCxELHqZr7egazzefCjZH1uttlhY=;
        b=lQ7Y7aT906aBjPlXCRg55V5h7vwPgDDZFcaLvAyQfpDqtrt+4i4hlkzVMuw5dmtlEC
         MiPMao+NAOn14Nl9F3UFV81tkztAYmoYCBHZpH4GsyjMhNZSciOOBeDPJL2RpUpUt9S8
         aa0gldm69skWwmS9QOhlVJ/N9fNr6evj3AIAi4Vy/hNnOyk/tO1G0viUKevoGmaujwOr
         Sks2M55hWdxWJtLlm09AmWl409AeoEFdo04vtY/SS/fTsO3cfs/K+Y+2ztJPwk8ySlIl
         5HP+RUuET+O3THG1IDn8XlcUPgJj1MmTzi87lk+QR2WT05zQroa7+ZEORsGptQxltXeU
         nITA==
X-Gm-Message-State: APjAAAWap1r9xiTKwkD1RcZEMMjGex3vomlpErBaClQeUbBVOkzZRKQA
        4uZ3dAuW2JR25VwC0z4ZPYQOFQ==
X-Google-Smtp-Source: APXvYqxpAKMWgKsp5mwnbToOye0LZV+jEPDgI1j19nZbzGo4BmW1iXfJSv6DmTNPkgk90rIl62Dzng==
X-Received: by 2002:a24:5e06:: with SMTP id h6mr13110040itb.107.1555092888842;
        Fri, 12 Apr 2019 11:14:48 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id m30sm4276605iti.41.2019.04.12.11.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 11:14:48 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, alevkoy@chromium.org, keithshort@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v4 2/2] platform/chrome: wilco_ec: Add h1_gpio status to debugfs
Date:   Fri, 12 Apr 2019 12:14:43 -0600
Message-Id: <20190412181443.239166-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412181443.239166-1-ncrews@chromium.org>
References: <20190412181443.239166-1-ncrews@chromium.org>
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

Changes in v4:
- Use "0x02x\n" instead of "02x\n" for format string
- Use DEFINE_DEBUGFS_ATTRIBUTE()
- Add documentation
Changes in v3:
- Fix documentation to correspond with formatting change in v2.
Changes in v2:
- Zero out the unused fields in the request.
- Format result as "%02x\n" instead of as a decimal.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/debugfs-wilco-ec | 13 ++++++
 drivers/platform/chrome/wilco_ec/debugfs.c | 47 ++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-wilco-ec b/Documentation/ABI/testing/debugfs-wilco-ec
index 7ff6b45be703..73a5a66ddca6 100644
--- a/Documentation/ABI/testing/debugfs-wilco-ec
+++ b/Documentation/ABI/testing/debugfs-wilco-ec
@@ -1,3 +1,16 @@
+What:		/sys/kernel/debug/wilco_ec/h1_gpio
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		As part of Chrome OS's FAFT (Fully Automated Firmware Testing)
+		tests, we need to ensure that the H1 chip is properly setting
+		some GPIO lines. The h1_gpio attribute exposes the state
+		of the lines:
+		- ENTRY_TO_FACT_MODE in BIT(0)
+		- SPI_CHROME_SEL in BIT(1)
+
+		Output will formatted with "0x%02x\n".
+
 What:		/sys/kernel/debug/wilco_ec/raw
 Date:		January 2019
 KernelVersion:	5.1
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 8d307378c1cb..20482e590587 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -164,6 +164,51 @@ static const struct file_operations fops_raw = {
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
+static int h1_gpio_get(void *arg, u64 *val)
+{
+	struct wilco_ec_device *ec = arg;
+	struct h1_gpio_status_request rq;
+	struct hi_gpio_status_response rs;
+	struct wilco_ec_message msg;
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
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (rs.status)
+		return -EIO;
+
+	*val = rs.val;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02x\n");
+
 /**
  * wilco_ec_debugfs_probe() - Create the debugfs node
  * @pdev: The platform device, probably created in core.c
@@ -185,6 +230,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
 	if (!debug_info->dir)
 		return 0;
 	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
+	debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
+			    &fops_h1_gpio);
 
 	return 0;
 }
-- 
2.20.1

