Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2412D20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm2FJzjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCQUAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:00:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33316 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfCQUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:00:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so14775038wrm.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DeHJpGmgIprkXSbxtuoa2bWxcrU0/AOTAKP+BZJz78w=;
        b=pm2FJzjnwxLFwG3eSMA32uerskFCHK/cKtAleDcXuA+RD5rrs2Wbt2mBoU4iYCM4Fc
         OOvj+5UFIbh9/ulbgdJCYcnadCo4X5XNvLZSHrSyLbh2l5I31tDcVBZX6FXiKk4PvTpp
         iWOu0Aty1UfcI4zdLNV+RrQUUUofvtoCCnPJQ0r7uA1WmAunQDJjFeirXo5RGhfZhK38
         SkGCYd02w6h8Asdb7BxsqPsoqP3BXV3aZZtO5Ln1f1rp6/ZqCI1Kfpv7V6wxlNkpvGl5
         rKoVLleiJPlxYX1mLTACAEWyoNPrqAH9NudE//f4/9XGLpm2XZe1BQHjn2kASlPcRzfC
         N9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DeHJpGmgIprkXSbxtuoa2bWxcrU0/AOTAKP+BZJz78w=;
        b=CjXsdYTQuki1FlmVv81GPsyUPI9Dpi/SFc6DRkHQc36XPvjflNWWYOV7HItKwVltJ/
         FKvtQY+KBQe1Vy72psdFZTW6kNiNIKhGhL5CbEktA8P8YclJHo+DbIdT0JEsnYZhgVRN
         VJYAG/6v6POZzR0X+Q5AeiSXHHvqsLfwWw04xrJSAuJdVca4A6uX6FsDhxAPt0bNDybh
         Rt3SQBwfQsXWJ9ZWNdpZ8F95zSMOqbHrQBgkk9Hkk2kwLzpQDhoIlXkb76BQ/VnORPzM
         QUu0yGGZGHh5Xk/dzjdklr8OP2r6TzWtCKUfJH0RIsRj/4P53jw5ac2tpw8uffN3uyOR
         G9KQ==
X-Gm-Message-State: APjAAAXZZ34pOmX4cHHLyyDY+A5YB5oyM1DtlpjLbrSlDJCUjALd/S1b
        +0TbD4uDXtgh7NGPzonh2mkWLqAJ
X-Google-Smtp-Source: APXvYqyCFwtsbA4Admg1j3JB31tMzazAsX29Ho0Lg3jALEPNyKUHfKdWINOGFoN1JQWwAuPsnknCfQ==
X-Received: by 2002:adf:cd0f:: with SMTP id w15mr9993356wrm.267.1552852800221;
        Sun, 17 Mar 2019 13:00:00 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:59 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 15/15] habanalabs: never fail hard reset of device
Date:   Sun, 17 Mar 2019 21:59:27 +0200
Message-Id: <20190317195927.26238-16-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hard-reset of our device should never fail, due to dangers of permanent
damage to the H/W.

This patch removes the last place in the reset path where the driver might
exit before doing the actual reset.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 77d51be66c7e..c51d1062d0bc 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -663,17 +663,9 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
 
-	if (hard_reset) {
-		/* Release kernel context */
-		if (hl_ctx_put(hdev->kernel_ctx) != 1) {
-			dev_err(hdev->dev,
-				"kernel ctx is alive during hard reset\n");
-			rc = -EBUSY;
-			goto out_err;
-		}
-
+	/* Release kernel context */
+	if ((hard_reset) && (hl_ctx_put(hdev->kernel_ctx) == 1))
 		hdev->kernel_ctx = NULL;
-	}
 
 	/* Reset the H/W. It will be in idle state after this returns */
 	hdev->asic_funcs->hw_fini(hdev, hard_reset);
@@ -699,6 +691,13 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	if (hard_reset) {
 		hdev->device_cpu_disabled = false;
 
+		if (hdev->kernel_ctx) {
+			dev_crit(hdev->dev,
+				"kernel ctx was alive during hard reset, something is terribly wrong\n");
+			rc = -EBUSY;
+			goto out_err;
+		}
+
 		/* Allocate the kernel context */
 		hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx),
 						GFP_KERNEL);
-- 
2.17.1

