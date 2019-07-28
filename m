Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651CC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F12D2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biSBdgIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfG1L2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45184 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfG1L2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so58759144wre.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hKpyjTDk7o+25T3/HgBgX1TYyMZs1MLZWqa1gyuadF0=;
        b=biSBdgIe4Szk/LbEmvlaNiJX6GxgwjCPp/H8AZIB/SmtMU2AotN1h7itC2eMQUtXW9
         jb6GwyoiJFfe2lSSu/wpQnZQHZC6ba42sokOgjEOzicTxY85ySJrPKYXC9wUyyYWmYy4
         jQq/bCWIwFljBbraBLF1CS9Eo4oZ+gGJB0XUQpNPdkdYU0ck/F/14nKEBmykPnOpJV7T
         Kneqoe5OADYqFTJ5C15Sk/dJeJot/6ujQnBRUMjHqHWv7QscvNAeotuLf5K4oDkiYPWe
         EaOpmXuq6JPuI1BAhmTAXpPrOlzMX1q6/oEn9BvdomPHojVYrrpJNxV71aDumExvBYQ1
         isgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hKpyjTDk7o+25T3/HgBgX1TYyMZs1MLZWqa1gyuadF0=;
        b=r+qqjUHyzG1tvdp5cVtiKnpVetI8xuZvTvYLFlJGI9mbY13QEjNawo5e2qG+/Y6JsP
         bNdBLXQ/3UXaFZ+xGRm6kkOz59FMnegl7N2fyCmh/hhAjNoOl81W64PYof1fmSowPeeZ
         w0cUvVuVfVfApE/d45h2afVo3NHrjTf3qbZHF5kRZb/4GwVmfGZKSWyo3AVBd7COApHV
         1gWlyA7WNCERQC+BxuVDRZuvrp2wMCBtizqXlnHdUUAvgmHReCv17yZ2HYCYKzG8apgq
         9g+LyhwQxe+TWWfkONTxfnPpSkZ9TTeIqPax9LZz6uiL6gM3MNaGLG4QrGY9jZTVaVgY
         0fPw==
X-Gm-Message-State: APjAAAUpCTQq0V2fpDcspM98zbU1kmVnK4nNVWF4BPGybCjAKOFiWVTy
        OpW1oHE6pvwM/mQl5qgRjPFmmA8tMn4=
X-Google-Smtp-Source: APXvYqzUi+GjiE2SUjTUehYNuf+KSi/lr7aAD3dGnlyp/lm9G+Shku9M5F98ObPFI+CeLcCSsIW3kA==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr24852787wrt.295.1564313311548;
        Sun, 28 Jul 2019 04:28:31 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:30 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 8/9] habanalabs: kill user process after CS rollback
Date:   Sun, 28 Jul 2019 14:28:17 +0300
Message-Id: <20190728112818.30397-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
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
index 471506b54217..2677160c01b8 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -631,8 +631,6 @@ static void device_hard_reset_pending(struct work_struct *work)
 		container_of(work, struct hl_device_reset_work, reset_work);
 	struct hl_device *hdev = device_reset_work->hdev;
 
-	device_kill_open_processes(hdev);
-
 	hl_device_reset(hdev, true, true);
 
 	kfree(device_reset_work);
@@ -737,6 +735,13 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
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
@@ -1131,8 +1136,6 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hdev->hard_reset_pending = true;
 
-	device_kill_open_processes(hdev);
-
 	hl_hwmon_fini(hdev);
 
 	device_late_fini(hdev);
@@ -1151,6 +1154,12 @@ void hl_device_fini(struct hl_device *hdev)
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

