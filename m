Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DD8218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd3NUcOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfB1Iq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54584 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbfB1Iqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so8401192wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=n6uC1+gP2LMd35imvetLbG7fqryk+PfAO/nvDitKwAA=;
        b=Rd3NUcOHpmc6sGoG6We9KOg9bVmvFVDYlFBvbp339poIPHP/T+AwmY282NmcyU7bqN
         IbTgZ3wOOJfCkftfDSKRzCVTLzbfrRNCqDNMCFlf7AFLD84iaVkVg/cGXa2dWUy+woaC
         fhaCAsq/e7252sZsKpTOd5UyJLDn4N4y4NHSSdyGMn8xbQYk18o0CMsCynHumruQdYNA
         19+bEgZFpLo8hEp64vyfjQf+P9LKiVziXfTzi0gnLH6GOYoVizmhPwC2ks1f29cScF+8
         pn4fS2mXIktK2I/ymNmqOIXzpjpV2KwBy3yUT+DIfed9A0EDFmZCgnZLIMhzTMVuPTZn
         OsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=n6uC1+gP2LMd35imvetLbG7fqryk+PfAO/nvDitKwAA=;
        b=mIZVYl9Dt+LS7HKOL8Cia0oScp+uChchE0d/p7x5WmBKx03JJ9qq/6AySpbuEePFhi
         1IYYClYxEWuEzql0Sp6luvd163JdfweDRD9asq6K+6QdHVYfUZtjWg78VTA2w0NOqs7P
         VHMHu0dREJPJyurkf7V8ACl0YLYYehjlNlyrjpOvn9vK+P9+aPt4LJKFOn9XDlF/81uI
         6/QtEzlnh1LaHud2S+wYomNM4uryesnQmBB9yHes0IQn86WKOsyPNuf5wC6sCPpqTsnl
         XLVVl8Nzvi1rKpT5xMFyRPfIurAQHbIE030AU37IwKTsTPhyAOSduvLSwSvM/mzrTrZu
         TCyw==
X-Gm-Message-State: AHQUAubIyCikzS/ug5Swoxexv6xCYb6jyTdXrKQ8AzYQPziKssmHAUET
        DvuDoeiDw04x1Wxj7pR0lK1MZ/PN
X-Google-Smtp-Source: AHgI3IYcXCaqL/KWGqSJNa3RdmzlDYvafIUnJexIqF4LXBmg2iHQZNK1H7AlXbGFFDcgvfpSgXYEww==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr2090445wmh.55.1551343611328;
        Thu, 28 Feb 2019 00:46:51 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:50 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] habanalabs: soft-reset device if context-switch fails
Date:   Thu, 28 Feb 2019 10:46:21 +0200
Message-Id: <20190228084624.25288-13-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a bug in the driver, where if the TPC or MME remains in
non-IDLE even after all the command submissions are done (due to user bug
or malicious user), then future command submissions will fail in the
context-switch stage and the driver will remain in "stuck" mode.

The fix is to do a soft-reset of the device in case the context-switch
fails, because the device should be IDLE during context-switch. If it is
not IDLE, then something is wrong and we should reset the compute engines.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 16 +++++++++-------
 drivers/misc/habanalabs/goya/goya.c          |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 25ad9d805cfa..3525236ed8d9 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -622,13 +622,15 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 					"Failed to switch to context %d, rejecting CS! %d\n",
 					ctx->asid, rc);
 				/*
-				 * If we timedout, we need to soft-reset because
-				 * QMAN is probably stuck. However, we can't
-				 * call to reset here directly because of
-				 * deadlock, so need to do it at the very end
-				 * of this function
+				 * If we timedout, or if the device is not IDLE
+				 * while we want to do context-switch (-EBUSY),
+				 * we need to soft-reset because QMAN is
+				 * probably stuck. However, we can't call to
+				 * reset here directly because of deadlock, so
+				 * need to do it at the very end of this
+				 * function
 				 */
-				if (rc == -ETIMEDOUT)
+				if ((rc == -ETIMEDOUT) || (rc == -EBUSY))
 					need_soft_reset = true;
 				mutex_unlock(&hpriv->restore_phase_mutex);
 				goto out;
@@ -706,7 +708,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		args->out.seq = cs_seq;
 	}
 
-	if ((rc == -ETIMEDOUT) && (need_soft_reset))
+	if (((rc == -ETIMEDOUT) || (rc == -EBUSY)) && (need_soft_reset))
 		hl_device_reset(hdev, false, false);
 
 	return rc;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 39824214ce61..11597432f519 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3138,7 +3138,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	if (!hdev->asic_funcs->is_device_idle(hdev)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't send KMD job on QMAN0 if device is not idle\n");
-		return -EFAULT;
+		return -EBUSY;
 	}
 
 	fence_ptr = hdev->asic_funcs->dma_pool_zalloc(hdev, 4, GFP_KERNEL,
-- 
2.17.1

