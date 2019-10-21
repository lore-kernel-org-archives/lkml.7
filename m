Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A5CA9EAE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9D521928
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WK0tvccT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfJUDCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:02:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44673 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 23:02:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so7445641pfn.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 20:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X1eK+NEyVQBtfNuPFEp6l0dI2uta1Eahnc/cFfsNqiQ=;
        b=WK0tvccTx2DeB4CUYuCDL66HxZtd1Sap9zxjlQofSF2tieZmraP/KeQEMGtHktBXRR
         5O/pZZ16xe/JWOrMaXp1NByBxB6E5GBsE3x+CfAYMnm38ctfxZtYERtkBTx33Vdx8pBY
         is+0ex+/W4jVdXtvcRZk4L6CbY9mE0VDQcqI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X1eK+NEyVQBtfNuPFEp6l0dI2uta1Eahnc/cFfsNqiQ=;
        b=fbFSIUVnpEFWRuWfSP6OozYfNcOOkUUXNl1MjEN+xZxEkrGkjrT+INXkk+oUZCFWPW
         oztTVkrrLI1uDklzb5zHZ5NFub1/0nuPTMDoCWYaD5EXulN4nFqpGU6hlCGB1JCM1TnS
         kAvJxYQAMtA8YPOexx0XPYeT2bKT9M7ROZlTaMXzYD9zuEzZnPiUGWyrxBnE1GFr55DO
         61FAMFMGcuIrTLw+P1m4RecTGuR5+G3cxtlTxe4DpZAJGz78upbWxh+cBQzB4CMpjp1Z
         6zOfc3FIwPHEaurFVzxR5StbyPHSg2+iOsR1mWOAVU1ZpuJRrv/YU94Zt+WHb1hhUjST
         EzeQ==
X-Gm-Message-State: APjAAAVLjm+Qbpc3l/Xfu+02ANc2qcuD969kYjs8NnZNaAhpeRGKGOwD
        EcNPvzby5TAWd1J1mjFd5iBavA==
X-Google-Smtp-Source: APXvYqxUUoJOAyB2wgSrG9oFIZmiN1g2Uwzzl0ruzJP8tMcRwMsU7LTXKoT32oc7VUPe6nlgSwX5KA==
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr149420pjn.39.1571626961198;
        Sun, 20 Oct 2019 20:02:41 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id x65sm14250600pgb.75.2019.10.20.20.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 20:02:39 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Boitchat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2 2/2] HID: google: Add of_match table to Whiskers switch device.
Date:   Mon, 21 Oct 2019 11:02:33 +0800
Message-Id: <20191021030233.32592-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree match table.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 84f8c127ebdc..b726f8a15044 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -17,6 +17,7 @@
 #include <linux/hid.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
@@ -264,12 +265,21 @@ static const struct acpi_device_id cbas_ec_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id cbas_ec_of_match[] = {
+	{ .compatible = "google,cros-cbas" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cbas_ec_of_match);
+#endif
+
 static struct platform_driver cbas_ec_driver = {
 	.probe = cbas_ec_probe,
 	.remove = cbas_ec_remove,
 	.driver = {
 		.name = "cbas_ec",
 		.acpi_match_table = ACPI_PTR(cbas_ec_acpi_ids),
+		.of_match_table = of_match_ptr(cbas_ec_of_match),
 		.pm = &cbas_ec_pm_ops,
 	},
 };
-- 
2.23.0.866.gb869b98d4c-goog

