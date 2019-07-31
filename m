Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B05A208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtiCQNDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfGaM7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:59:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37645 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfGaM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:59:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so44506287wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Gih1EHsgebwcACWtUzGv18Oquo6aqYMiENTGnfIBkgI=;
        b=LtiCQNDf3XqQntRVYhrjKLZBmtPGkBmv4pF392Hsw6PuaEqnaamfR5oOceZHDeBZGQ
         5qS1VC7fAaOijVLe14MTdBxfrJUoRWYUOYy6EmXq0TyBO8cLVh90mjB1IhQGQfX2dFYD
         Am4q++8/527zDMnOR7UL0LrYIC5IoGVTqTI01H2N/mIZ3F6TplZ/HfKjSRArKZrJs7J4
         KUvyzcTZKZokG62n5Od8iL8PW9PMd0fBB6EdtAiS9gGm4uMC14fM+bx6Z68mL88GU6eE
         oanx7SElfoQ1NXHiW2o1grMOMzPilXrdDjNaABSIjugJFuaf74RIO9PFFgh+HIM/QXkT
         oUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Gih1EHsgebwcACWtUzGv18Oquo6aqYMiENTGnfIBkgI=;
        b=oXFnPpFsjQ2t2tSXXqfnbyL+zv04vZTmOQ1rIPjVEerrd2XAYKmA2LgoBfp3PxAzD1
         HlvkmwXufQqWGCTwaHatTOlfz7iP5+blC9+BXSdFWiIgG40IYYAKa9t/CqSyfysD1I6x
         zfU3FgPKPHt1uC0mtJfTCDhBC7r13Kn2Aa1C5eE+CRqPtdiqgi8tQXkH5OUw10XeDc7g
         UibNvo9obgIRveMJ12cVWP3frSdY/avQTlpaDrWOii6GcshodwPFBqP46jc9B6H/bRa0
         /T7x6qZB8dZ+RRhFgMvGMd4IS9mhu5nOTzZma1VTLrvOPAjKbMNSE7+B7bWx2HIY4CvP
         N6rw==
X-Gm-Message-State: APjAAAVBOK6ePKRNvmNqWAAADnxtryC0xA+3MIHq3lCovpV8N/Py3mU5
        AbgCyhTlDEpnfMDgUOBuHs/5FiCJZko=
X-Google-Smtp-Source: APXvYqyjTGpRAAn6SemJ1c3xw/Nj7lAbc9xN1xDMRv2BvYyHHQXVgwZCiNkHUo2qCNJnjlaGoVZczw==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr46360226wrq.28.1564577946621;
        Wed, 31 Jul 2019 05:59:06 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c6sm69247800wma.25.2019.07.31.05.59.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:59:06 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v3 2/7] habanalabs: kill user process after CS rollback
Date:   Wed, 31 Jul 2019 15:58:56 +0300
Message-Id: <20190731125901.20709-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731125901.20709-1-oded.gabbay@gmail.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
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

