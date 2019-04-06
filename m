Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE8C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25CD2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTQadLaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDFMpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 08:45:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46602 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDFMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 08:45:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so10933762wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XBTKzw1wYc7IXbgccpsKSSYGQHbAZdRsjxY9YMj165k=;
        b=OTQadLaYmsp41u58jzxPorrfwDSgA/3drxBHaYHV5U6DDHoY+atb52mIZsj7UIRifN
         pIa317QfM/TpJxIlijUeYGKLIM/Fj/TlEtUQ39am7batbXnYPzALFfvJqPlHzcnTjKwv
         WBShsnlYtNpfklCMI87VUwLRIlGOZqHS8CQfjT16MTEY/vQg3TK6pQdlij5TT5vfSGzl
         gcNW/RXpVjTxTayYwEdW6cZH0zJ0xDLxD4Z+hPimwWueRu+kIK/r4u7YezDy3q9PtFFp
         +91HBPnjPskP2YpMkA/ybST0EnyH999g1LG+Nwuz9Bj6FcZihvWUWTBIZbUars+TKNfm
         0PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XBTKzw1wYc7IXbgccpsKSSYGQHbAZdRsjxY9YMj165k=;
        b=ZS804IK+iB+h3/9++O2OUIL3smAgnepzTYKaACNcAGFiKvPJhxeOXp1c9RQXW967zz
         CQGsS5IS6Q5NfC7WDglf2GmhF9KNtmhT2TR4KjHGCn44kNg0gfQMdbZAq4jAXEGmQY97
         J8LTUz24jiwFCP+Z+B5ZyZCpRA3JQNkevDURPszQn5lzQerEHGQQZQwO/FSCD+Q00hTA
         HFYeM2IeM8Xw3ZUm7tHuTcxJKo1LElpBJhyad1ZBqnTPhWC1Co999y7TLHNpilC+ULuI
         hVkaKQN0FO7TiKeVFdn0XmctGQT1FUugO3tKiNYrvQcUJXpKXCKfkMl0FjlcpfAbTH6K
         IOew==
X-Gm-Message-State: APjAAAWY0jo4FMKXLFaGoNjh1HkwDHaAh8YV/Ud3wNh4B/GRkDhePKJd
        QENdxSRFfL7bhBPCuFl9iMCGdEup
X-Google-Smtp-Source: APXvYqwjskjfhVl3TRU3KdFUEGY0/H0TRI8ryquvkkw8njqBdydH8tPC/VJRerflSTPWQ/gw9Lb+dA==
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr11464987wrg.149.1554554713918;
        Sat, 06 Apr 2019 05:45:13 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f15sm29230576wru.21.2019.04.06.05.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 05:45:13 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/3] habanalabs: all FD must be closed before removing device
Date:   Sat,  6 Apr 2019 15:45:09 +0300
Message-Id: <20190406124511.7535-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in the implementation of the function that removes
the device.

The bug can happen when the device is removed but not the driver itself
(e.g. remove by the OS due to PCI freeze in Power architecture).

In that case, there maybe open users that are calling IOCTLs while the
device is removed. This is a possible race condition that the driver must
handle. Otherwise, a kernel panic may occur.

This race is prevented in the hard-reset flow, because the driver makes
sure the users are closed before continuing with the hard-reset. This
race can not occur when the driver itself is removed because the OS makes
sure all the file descriptors are closed.

The fix is to make sure the open users close their file descriptors and if
they don't (after a certain amount of time), the driver sends them a
SIGKILL, because the remove of the device can't be stopped.

The patch re-uses the same code that is called from the hard-reset flow.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 6cbfd560721e..56d3ba53c661 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -513,11 +513,8 @@ int hl_device_resume(struct hl_device *hdev)
 	return rc;
 }
 
-static void hl_device_hard_reset_pending(struct work_struct *work)
+static void device_kill_open_processes(struct hl_device *hdev)
 {
-	struct hl_device_reset_work *device_reset_work =
-		container_of(work, struct hl_device_reset_work, reset_work);
-	struct hl_device *hdev = device_reset_work->hdev;
 	u16 pending_total, pending_cnt;
 	struct task_struct *task = NULL;
 
@@ -552,6 +549,12 @@ static void hl_device_hard_reset_pending(struct work_struct *work)
 		}
 	}
 
+	/* We killed the open users, but because the driver cleans up after the
+	 * user contexts are closed (e.g. mmu mappings), we need to wait again
+	 * to make sure the cleaning phase is finished before continuing with
+	 * the reset
+	 */
+
 	pending_cnt = pending_total;
 
 	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
@@ -567,6 +570,16 @@ static void hl_device_hard_reset_pending(struct work_struct *work)
 
 	mutex_unlock(&hdev->fd_open_cnt_lock);
 
+}
+
+static void device_hard_reset_pending(struct work_struct *work)
+{
+	struct hl_device_reset_work *device_reset_work =
+		container_of(work, struct hl_device_reset_work, reset_work);
+	struct hl_device *hdev = device_reset_work->hdev;
+
+	device_kill_open_processes(hdev);
+
 	hl_device_reset(hdev, true, true);
 
 	kfree(device_reset_work);
@@ -650,7 +663,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		 * from a dedicated work
 		 */
 		INIT_WORK(&device_reset_work->reset_work,
-				hl_device_hard_reset_pending);
+				device_hard_reset_pending);
 		device_reset_work->hdev = hdev;
 		schedule_work(&device_reset_work->reset_work);
 
@@ -1049,6 +1062,15 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
+	/*
+	 * Flush anyone that is inside the critical section of enqueue
+	 * jobs to the H/W
+	 */
+	hdev->asic_funcs->hw_queues_lock(hdev);
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+
+	device_kill_open_processes(hdev);
+
 	hl_hwmon_fini(hdev);
 
 	device_late_fini(hdev);
-- 
2.17.1

