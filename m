Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18028C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF12120651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATcM2TmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfG3Jre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:47:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51913 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbfG3Jrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:47:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so56510039wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Gih1EHsgebwcACWtUzGv18Oquo6aqYMiENTGnfIBkgI=;
        b=ATcM2TmXSasjEgKTvti5jgR35noAIW2mESleutOMDEquUyPVpFeEkiyM46hITnD10V
         k16G1PVfuA2nSkq+d4egNUwXLKrfLL7v+wpSkWhhWBxFEMuBHE25GbwNRGpZGaC1HpxO
         1KWGWbJsColjJCdD7vw0P0r6QdXXOLdWxjLsOclcESuh7qRv80iZlUdOQZUqpzrR2kLk
         lHgr6z+A4JD0QBtGmTUehxPDMA4qIdE3HVhfPdIR+zqFM+8a+puRkxfj+i6vuxvCt8oi
         2XcyXQ+tmzqL+W5fKVDK0TOnTIVePkl0dLBG0v0+7THGcZuwOpWCHLhpfL89MS4CXOZk
         63Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Gih1EHsgebwcACWtUzGv18Oquo6aqYMiENTGnfIBkgI=;
        b=MIwG1oU3Tfmhz653fR4tk5FMKLKMFSHDgCETeCmpnwILg1ngPIKSGwYo9ytZcYygef
         PqAIxUb2ytg425loPp6c5CDVWpUJJneRWwylnjjWdkxjGtVlt+/OeSv/xYZKx6GMhUvY
         YqqGROeSpf6lqyuU+HT3rqouV5FDCGPl0Hy5GgPJ826Fof+yilVW9AKsh2MfQMubjhkQ
         lJvv5HxwrsatasZyoQs/xDJcs2+FXbThMkrbjjyPfEoHvVsrmO7FiKhdZpP/F6DeE8RX
         krs8ZPbRuDS4FpjqU11jrvzlNH8bnoiv8K+mmqIn1vMIrJXKK+IhZWGhmflButWXjYUB
         QKhw==
X-Gm-Message-State: APjAAAU/n85ePyaMMz+4Wx7JE7ZjOCFCaFS/ALSvGSL1X6uCIWmtouVS
        hIFU/JjHJSZsE/tD5UhQBGqfDZ+9syQ=
X-Google-Smtp-Source: APXvYqwcrwcLHm7FwVOOEh7LB4IVMdLeON4fmdPZIepZ+RZyBa0ZrBfcz3+MwFpZl+Ap+mHJgf9G+A==
X-Received: by 2002:a1c:cfc7:: with SMTP id f190mr99184056wmg.85.1564480050617;
        Tue, 30 Jul 2019 02:47:30 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k124sm105967360wmk.47.2019.07.30.02.47.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:47:29 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v2 2/7] habanalabs: kill user process after CS rollback
Date:   Tue, 30 Jul 2019 12:47:19 +0300
Message-Id: <20190730094724.18691-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730094724.18691-1-oded.gabbay@gmail.com>
References: <20190730094724.18691-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch calls the kill user process function after we rollback the
in-flight CSs. This is because the user process can't be closed while
there are open CSs. Therefore, there is no point of sending it a SIGKILL
before we do the rollback CS part.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 0c4894dd9c02..d1bc8f4ed5bb 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -630,8 +630,6 @@ static void device_hard_reset_pending(struct work_struct *work)
 		container_of(work, struct hl_device_reset_work, reset_work);
 	struct hl_device *hdev = device_reset_work->hdev;
 
-	device_kill_open_processes(hdev);
-
 	hl_device_reset(hdev, true, true);
 
 	kfree(device_reset_work);
@@ -736,6 +734,13 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
 
+	/* Kill processes here after CS rollback. This is because the process
+	 * can't really exit until all its CSs are done, which is what we
+	 * do in cs rollback
+	 */
+	if (from_hard_reset_thread)
+		device_kill_open_processes(hdev);
+
 	/* Release kernel context */
 	if ((hard_reset) && (hl_ctx_put(hdev->kernel_ctx) == 1))
 		hdev->kernel_ctx = NULL;
@@ -1130,8 +1135,6 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hdev->hard_reset_pending = true;
 
-	device_kill_open_processes(hdev);
-
 	hl_hwmon_fini(hdev);
 
 	device_late_fini(hdev);
@@ -1150,6 +1153,12 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
 
+	/* Kill processes here after CS rollback. This is because the process
+	 * can't really exit until all its CSs are done, which is what we
+	 * do in cs rollback
+	 */
+	device_kill_open_processes(hdev);
+
 	hl_cb_pool_fini(hdev);
 
 	/* Release kernel context */
-- 
2.17.1

