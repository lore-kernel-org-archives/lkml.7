Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4B9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839BE21019
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeJ5IkT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfCPULM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:11:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51916 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfCPULJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:11:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id n19so9491531wmi.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GBTtd9QPqHk7yBLOGjinUWZDBh5MgI9dKM9ken14BGE=;
        b=QeJ5IkT/SlBHoi07Aoc/9QmDOQe7brpizfJ6jVp7y8fMgVJFuXFUjha4Cn+Zy0LuwG
         +dYbxaM+wSTqy6xviGd/xbSz3LyO23BMVxkgKcSYp3Pgv1qMXBv7dHT9zFufvmw1kAd7
         km0WD15Q7vAyj1WKqIol4feR2kadHo8Ac2wFiEbeGsvLUo6cCM9gwlZjfRwxaIOh456W
         2fTCHPVFrvOmjet72bWDpXCjhrH0eNJ5SftGQvbRmTQMfK+Qc2cCf9u6sOZBWiy1T7G/
         6fnaHuEvC1MnAh1qBaWs0tEI3EaeYcEnJ/SJSJl6Gq41zsSp+rODnJ6bXrrh5v/z9YzX
         fZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GBTtd9QPqHk7yBLOGjinUWZDBh5MgI9dKM9ken14BGE=;
        b=TZ0x3gasxEW+JKi9ZHXNvOIJmvsqgY6Zif/ZIqHmRovmUAYxB5RIpvJ0pM1vUJRpqB
         vUFdbGnR5jHTZiMbydyXZKnSaap8B46E9cKxMkSFhZv/rpnWYahVMyF+wWNX2B8MPOK9
         0GxzMG9uVO1PSoOEL6BwYq5yQRGxdf25vjimqwihJgNqjKrsZnH6bDeNSd+y4GtxLDGt
         vN2lGWu7y3eAUjAJvAtD7XwmCYyDMKbbEPtQorIDMZenQWcIEDBNwb5i5IabfpMGV9ng
         PTdyFU3XACUMILN/GQCS6mC7WkbPtn+V9KgYMfWBK3JipEThhjn0Hk4X5+IOTLsi6nta
         vwkw==
X-Gm-Message-State: APjAAAXOnuEBGlc2cQPyty2yhE6dXBxAC8XIoz5XH24TT2L5Eda1p+vN
        K8FpneXiLPTzJ4OIRTnlelwKwqYL
X-Google-Smtp-Source: APXvYqygUW1CGyw0MSgOAggmJ1cMcq39zCRk0T+k0LCbrLvqdrs1T1e3HzYEgM2XothY7Up4M4WhnA==
X-Received: by 2002:a7b:cd0c:: with SMTP id f12mr6127254wmj.27.1552767067783;
        Sat, 16 Mar 2019 13:11:07 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h10sm8722221wmf.2.2019.03.16.13.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 13:11:07 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 3/4] habanalabs: complete user context cleanup before hard reset
Date:   Sat, 16 Mar 2019 22:10:46 +0200
Message-Id: <20190316201047.22516-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316201047.22516-1-oded.gabbay@gmail.com>
References: <20190316201047.22516-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch fixes a bug which led to a crash during hard reset flow.
Before a hard reset is executed, we wait a few seconds for the user
context cleanup to complete.
If it wasn't completed, we kill the user process and move on to the reset
flow.
Upon killing the user process, the context cleanup flow begins and may
take a while due to MMU unmaps.
Meanwhile, in the driver reset flow, we change the PCI DRAM bar location
which can interfere with the MMU that uses the bar.
If the context cleanup flow didn't finish quickly, a crash may occur due
to PCI DRAM bar mislocation during the MMU unmap.
Hence adding a wait between killing the user process and the start of the
reset flow.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index de46aa6ed154..93d67983ddba 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -11,6 +11,8 @@
 #include <linux/sched/signal.h>
 #include <linux/hwmon.h>
 
+#define HL_PLDM_PENDING_RESET_PER_SEC	(HL_PENDING_RESET_PER_SEC * 10)
+
 bool hl_device_disabled_or_in_reset(struct hl_device *hdev)
 {
 	if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
@@ -462,9 +464,16 @@ static void hl_device_hard_reset_pending(struct work_struct *work)
 	struct hl_device_reset_work *device_reset_work =
 		container_of(work, struct hl_device_reset_work, reset_work);
 	struct hl_device *hdev = device_reset_work->hdev;
-	u16 pending_cnt = HL_PENDING_RESET_PER_SEC;
+	u16 pending_total, pending_cnt;
 	struct task_struct *task = NULL;
 
+	if (hdev->pldm)
+		pending_total = HL_PLDM_PENDING_RESET_PER_SEC;
+	else
+		pending_total = HL_PENDING_RESET_PER_SEC;
+
+	pending_cnt = pending_total;
+
 	/* Flush all processes that are inside hl_open */
 	mutex_lock(&hdev->fd_open_cnt_lock);
 
@@ -489,6 +498,19 @@ static void hl_device_hard_reset_pending(struct work_struct *work)
 		}
 	}
 
+	pending_cnt = pending_total;
+
+	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
+
+		pending_cnt--;
+
+		ssleep(1);
+	}
+
+	if (atomic_read(&hdev->fd_open_cnt))
+		dev_crit(hdev->dev,
+			"Going to hard reset with open user contexts\n");
+
 	mutex_unlock(&hdev->fd_open_cnt_lock);
 
 	hl_device_reset(hdev, true, true);
-- 
2.17.1

