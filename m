Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A9ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4762720872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JzRUUJ0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbfJOWrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:47:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfJOWrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:47:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id e15so5014491pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MqCNoFXBnDQS65g3QEqNb06DM9l3Y39pluZuZL8mhfQ=;
        b=JzRUUJ0N7j75JfIwIlSihcUiHylr54bI1uG5EWH0+1obdUFxbvz/3Gcp0Mksm3QbSD
         DSqVZw4UVHxDaQO24T8/j09J3QdOIRgtDqEJFmTEVROpqXxxapfyhmLfN7QY4nk7MdEn
         ufhPEsGN1tPujh+8NcN+TtgLs+5SM7woNqW80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MqCNoFXBnDQS65g3QEqNb06DM9l3Y39pluZuZL8mhfQ=;
        b=DXTOsFjR1I0IfxPM+HRBFMnCOjsknsAN47aDdL6trk5ljmOzk/2cG4+KJ2WYZh4mpE
         7gFwJEIrNmeAL99elv9aX3fk+diV+zI40UQxsOE50U7ldJ8UD7/HZYLNnAKi8ANSPnEz
         IKVQGxR6LT/dBQaO8wXwqsW6sM/T64o961UnJ/1SpvHOi4z3APKrfKvL88GHytem4P9Z
         FA4NWbmS7dCKeMzyqoW505tqVFB9FjlH2136KMCdjoQlPIuj5qkxYUjHyqUyOJr/u8kq
         lL3DF3TyOuuKwkm1b0W57aASSIL3XylNI8vnYmyys0UpQWL91RX1btPHqwBP+D40I48N
         odIg==
X-Gm-Message-State: APjAAAW1iufU4zJPkOWvjC/h5azwOK5FZ1sqcrhfFnaE7Ry/aZL9Nt8n
        exrrwbv4Ori5cHC7bQioV29Hu5khw+1pfQ==
X-Google-Smtp-Source: APXvYqzi7hgCzLARhsxWspbuNKNQZPbT03PPel95bsqKxHHQyI6qpvtcPvYbcr1fQZy38ofNrCeknA==
X-Received: by 2002:a62:5ac3:: with SMTP id o186mr41145786pfb.20.1571179627935;
        Tue, 15 Oct 2019 15:47:07 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:47:07 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 8/8] memory: brcmstb: dpfe: Fixup API version/commands for 7211
Date:   Tue, 15 Oct 2019 15:45:13 -0700
Message-Id: <20191015224513.16969-9-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015224513.16969-1-mmayer@broadcom.com>
References: <20191015224513.16969-1-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

7211 uses a newer version of API v2 which is half way between what was
defined as API v3 and what used to be called API v2 but was used with
DPFE firmwares with major versions 1.x.x.x. Starting with **the new**
API v2, we are no longer getting loadable firmware images, so the
capability to load it is removed (like v3).

To avoid spreading more confusion, map 7268/7271/7278 to the old DPFE
API version 2, 7211 to the new API v2 and introduce the specific
commands for that, and leave newer versions to map to API v3.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 44 ++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 7c6e85ad25a7..82b415be18d1 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -231,9 +231,13 @@ static struct attribute *dpfe_v3_attrs[] = {
 };
 ATTRIBUTE_GROUPS(dpfe_v3);
 
-/* API v2 firmware commands */
-static const struct dpfe_api dpfe_api_v2 = {
-	.version = 2,
+/*
+ * Old API v2 firmware commands, as defined in the rev 0.61 specification, we
+ * use a version set to 1 to denote that it is not compatible with the new API
+ * v2 and onwards.
+ */
+static const struct dpfe_api dpfe_api_old_v2 = {
+	.version = 1,
 	.fw_name = "dpfe.bin",
 	.sysfs_attrs = dpfe_v2_groups,
 	.command = {
@@ -258,6 +262,30 @@ static const struct dpfe_api dpfe_api_v2 = {
 	}
 };
 
+/*
+ * API v2 firmware commands, as defined in the rev 0.8 specification, named new
+ * v2 here
+ */
+static const struct dpfe_api dpfe_api_new_v2 = {
+	.version = 2,
+	.fw_name = NULL, /* We expect the firmware to have been downloaded! */
+	.sysfs_attrs = dpfe_v2_groups,
+	.command = {
+		[DPFE_CMD_GET_INFO] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 0x101,
+		},
+		[DPFE_CMD_GET_REFRESH] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 0x201,
+		},
+		[DPFE_CMD_GET_VENDOR] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 0x202,
+		},
+	}
+};
+
 /* API v3 firmware commands */
 static const struct dpfe_api dpfe_api_v3 = {
 	.version = 3,
@@ -390,7 +418,7 @@ static void __finalize_command(struct brcmstb_dpfe_priv *priv)
 	 * It depends on the API version which MBOX register we have to write to
 	 * to signal we are done.
 	 */
-	release_mbox = (priv->dpfe_api->version < 3)
+	release_mbox = (priv->dpfe_api->version < 2)
 			? REG_TO_HOST_MBOX : REG_TO_DCPU_MBOX;
 	writel_relaxed(0, priv->regs + release_mbox);
 }
@@ -886,10 +914,10 @@ static int brcmstb_dpfe_remove(struct platform_device *pdev)
 
 static const struct of_device_id brcmstb_dpfe_of_match[] = {
 	/* Use legacy API v2 for a select number of chips */
-	{ .compatible = "brcm,bcm7268-dpfe-cpu", .data = &dpfe_api_v2 },
-	{ .compatible = "brcm,bcm7271-dpfe-cpu", .data = &dpfe_api_v2 },
-	{ .compatible = "brcm,bcm7278-dpfe-cpu", .data = &dpfe_api_v2 },
-	{ .compatible = "brcm,bcm7211-dpfe-cpu", .data = &dpfe_api_v2 },
+	{ .compatible = "brcm,bcm7268-dpfe-cpu", .data = &dpfe_api_old_v2 },
+	{ .compatible = "brcm,bcm7271-dpfe-cpu", .data = &dpfe_api_old_v2 },
+	{ .compatible = "brcm,bcm7278-dpfe-cpu", .data = &dpfe_api_old_v2 },
+	{ .compatible = "brcm,bcm7211-dpfe-cpu", .data = &dpfe_api_new_v2 },
 	/* API v3 is the default going forward */
 	{ .compatible = "brcm,dpfe-cpu", .data = &dpfe_api_v3 },
 	{}
-- 
2.17.1

