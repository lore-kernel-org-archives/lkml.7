Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BF0C28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD20D2449A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185984;
	bh=KgfFfvXbmF9jyBrWd76voKESVs9EhcpcLD/gKewa8Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZIBapW3pKkKl5jHWIYLoxv7Oo83w2U6RKwFCvChsE6esW2LlE6O2zzAKUnM5/A5aA
	 OSe0vwAb9xXGp68KXImXaa2xMl6sO6536pMRgR0PjzCAjOt8XE4qDOyI22DzkL0A0E
	 ILOu70jWFKpw9Wwv+eZJpa1QRNm+Ydh3jXTFqUdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfE3DNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbfE3DLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:23 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BEC2244B0;
        Thu, 30 May 2019 03:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185882;
        bh=KgfFfvXbmF9jyBrWd76voKESVs9EhcpcLD/gKewa8Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaIVaHmagwDG70VQJVcRi65KqsamBtSZ0lU8WS2Nv1q7AynGcVq81VF/iaKM6b6bB
         WB7cEJs38eajsovjqJSiF3KpgGkCqq9YLi+hNFOkgIMObJTL3vcYAvPMLGHpSDi/AV
         zrqVJtHcYKWT8bgRmGaEJx+X9SA+qtr6/baBhoig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 233/405] habanalabs: all FD must be closed before removing device
Date:   Wed, 29 May 2019 20:03:51 -0700
Message-Id: <20190530030552.813887885@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit caa3c8e52582fc4d2ed82afd5e7ea164c18ef4fe ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/device.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 77d51be66c7e8..652c8edb2164c 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -498,11 +498,8 @@ int hl_device_resume(struct hl_device *hdev)
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
 
@@ -537,6 +534,12 @@ static void hl_device_hard_reset_pending(struct work_struct *work)
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
@@ -552,6 +555,16 @@ static void hl_device_hard_reset_pending(struct work_struct *work)
 
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
@@ -635,7 +648,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		 * from a dedicated work
 		 */
 		INIT_WORK(&device_reset_work->reset_work,
-				hl_device_hard_reset_pending);
+				device_hard_reset_pending);
 		device_reset_work->hdev = hdev;
 		schedule_work(&device_reset_work->reset_work);
 
@@ -1035,6 +1048,15 @@ void hl_device_fini(struct hl_device *hdev)
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
2.20.1



