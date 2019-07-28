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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5287C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B522075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/pv6Fwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfG1L2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45182 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfG1L2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so58759119wre.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=oh4it4O+BCVIshsKL1XggNsUtd5ItSDidUyOsRvbrOQ=;
        b=D/pv6FwedurX759H4av8/3DLOowAUv1Cp0CV12ihsCtOHaTSzdp7+aaxgnDbFQtnEf
         aMkpAWS+SvfXpjDIDxS4IKrZTA9tiS6vlF9XTqdkgja+7t0dYMFlCbSmsiXyfRYWoqsL
         XNptvX8agWxBAxVa3f0ngEGyDCTUbpzfIkBx81o2xavvrl0Rh/zrgtVJ3LJ5W4VoxJmf
         w+LrAN3L+fqwf+RV5IR1aKSnQzhQA7sC6Pvo98UibjUDoCwEk9NiKBc+8+n8FNXbc1mU
         rF95XS9zaSf71GjME356XtmbifjHXossz9SXDtvFOFxaChVbxVdeKJyx1ts4akk9dZDL
         9W1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=oh4it4O+BCVIshsKL1XggNsUtd5ItSDidUyOsRvbrOQ=;
        b=lnt+6PFArL7rbs6lc7pJsE+z8WeW6UVOJlT8BNEgs0CtNzDxogIM4Oc0HNrAixthis
         YSZlO2BfEuvrYyNrsEghrAqxNmYF1KEWYBCTIwz/Aln8fyfekkBtaxFLvBNJG54qzy9r
         miY+OgiB861lq3mFZ4RGtQaFi6vq7w2PVnvxPVI/WsYQX0Z9C2ZRdEgjcEqi9cysr8Pg
         PINTzEevPL9iMSOhFXzWrifUnChd1qa0jFgHrhV/YoR5RgVUAzRii/nt87RfQFquoJaq
         YSKxKS9WSJVa30IBuLg9FOqJUhTwd5OO4Gf6XDNtWgPXAU+Jdzt4pHKS1uWVL9Q0Bh27
         JcTA==
X-Gm-Message-State: APjAAAVCqBSxrpSsVJ8DCpnjPJn2gCwfGBgpxgMVNKLtAFC2k9G39BfA
        U6dAzYT3F0o1+bd8vdxT944de/2bw4U=
X-Google-Smtp-Source: APXvYqwQRIxj2BBbOfk65X7BrsP6nVrkHZKr0aYVuWg8dROLbexZqjbdcOdCyX7c0eBUAJnVJm3Irg==
X-Received: by 2002:adf:ed04:: with SMTP id a4mr105936777wro.86.1564313310147;
        Sun, 28 Jul 2019 04:28:30 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:29 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 7/9] habanalabs: protect only pointer dereference in hard-reset
Date:   Sun, 28 Jul 2019 14:28:16 +0300
Message-Id: <20190728112818.30397-8-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the location of taking a mutex lock and releasing it
during the hard-reset process of the ASIC.

The only place we need to protect is when we dereference pointers that may
go away in case the user process aborts/closes the FD.

That way, we allow the user process to actually close its FD in case we
tell him that an error occurred.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 5400e65ba5fa..471506b54217 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -574,20 +574,21 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	else
 		pending_total = HL_PENDING_RESET_PER_SEC;
 
-	pending_cnt = pending_total;
-
 	/* Flush all processes that are inside hl_open */
 	mutex_lock(&hdev->fpriv_list_lock);
+	mutex_unlock(&hdev->fpriv_list_lock);
 
-	while ((!list_empty(&hdev->fpriv_list)) && (pending_cnt)) {
-
-		pending_cnt--;
-
-		dev_info(hdev->dev,
-			"Can't HARD reset, waiting for user to close FD\n");
+	/* Giving time for user to close FD, and for processes that are inside
+	 * hl_device_open to finish
+	 */
+	if (!list_empty(&hdev->fpriv_list))
 		ssleep(1);
-	}
 
+	mutex_lock(&hdev->fpriv_list_lock);
+
+	/* This section must be protected because we are dereferencing
+	 * pointers that are freed if the process exits
+	 */
 	if (!list_empty(&hdev->fpriv_list)) {
 		task = get_pid_task(hdev->compute_ctx->hpriv->taskpid,
 					PIDTYPE_PID);
@@ -600,6 +601,8 @@ static void device_kill_open_processes(struct hl_device *hdev)
 		}
 	}
 
+	mutex_unlock(&hdev->fpriv_list_lock);
+
 	/* We killed the open users, but because the driver cleans up after the
 	 * user contexts are closed (e.g. mmu mappings), we need to wait again
 	 * to make sure the cleaning phase is finished before continuing with
@@ -609,6 +612,8 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	pending_cnt = pending_total;
 
 	while ((!list_empty(&hdev->fpriv_list)) && (pending_cnt)) {
+		dev_info(hdev->dev,
+			"Waiting for all unmap operations to finish before hard reset\n");
 
 		pending_cnt--;
 
@@ -618,9 +623,6 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	if (!list_empty(&hdev->fpriv_list))
 		dev_crit(hdev->dev,
 			"Going to hard reset with open user contexts\n");
-
-	mutex_unlock(&hdev->fpriv_list_lock);
-
 }
 
 static void device_hard_reset_pending(struct work_struct *work)
-- 
2.17.1

