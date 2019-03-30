Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C549CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5BB217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909421;
	bh=JLzQlWt0boTi6yvZh3Jwb3iPIXo0kW4misJTt5D4JDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S6pLllwmm1cI/ECI00+eVgSQ9gYac/Sd0dREYkiQvN8e4yYoiLFJ73lIXD404eK95
	 8zyhULIK9BPpZgr83KJ7ZuMaNeVdPsJKxfBI5+5lB8nUMzC9aZmCvJ7yK09atVeM8Z
	 YtZmqJZLe4y3GMzmWgJ/22yIaZ8tKAELk2taKtRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfC3BaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbfC3BaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F6D218D9;
        Sat, 30 Mar 2019 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909412;
        bh=JLzQlWt0boTi6yvZh3Jwb3iPIXo0kW4misJTt5D4JDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fu6dLFdee4sZ6b/FmPZ0ZVvEQYHLxe1XWIpId9+UqTyjkczmKkxDgYRCAjqFn/coo
         kYVgHCgmm3MTr0/9rqy1+YXCvaJ9JAmIgUJBtW2jGm5L1QjeFmiTEt0vb7HipGog8n
         YkAf2nHjvCokFlM3tB030lnCb/PfhSSNhg3jA6Sw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Przemek Socha <soprwa@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 39/57] scsi: core: Avoid that system resume triggers a kernel warning
Date:   Fri, 29 Mar 2019 21:28:32 -0400
Message-Id: <20190330012854.32212-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 388b4e6a00bb3097278ed1648ac5a1cb48c894e6 ]

scsi_device_quiesce() and scsi_device_resume() are called during
system-wide suspend and resume. scsi_device_quiesce() only succeeds for
SCSI devices that are in one of the RUNNING, OFFLINE or TRANSPORT_OFFLINE
states (see also scsi_set_device_state()).  This patch avoids that the
following warning is triggered when resuming a system for which quiescing a
SCSI device failed:

WARNING: CPU: 2 PID: 11303 at drivers/scsi/scsi_lib.c:2600 scsi_device_resume+0x4f/0x58
CPU: 2 PID: 11303 Comm: kworker/u8:70 Not tainted 5.0.0-rc1+ #50
Hardware name: LENOVO 80E3/Lancer 5B2, BIOS A2CN45WW(V2.13) 08/04/2016
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 scsi_dev_type_resume+0x2e/0x60
 async_run_entry_fn+0x32/0xd8
 process_one_work+0x1f4/0x420
 worker_thread+0x28/0x3c0
 kthread+0x118/0x130
 ret_from_fork+0x22/0x40

Cc: Przemek Socha <soprwa@gmail.com>
Reported-by: Przemek Socha <soprwa@gmail.com>
Fixes: 3a0a529971ec ("block, scsi: Make SCSI quiesce and resume work reliably") # v4.15
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 18e4289baf99..655790f30434 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3095,7 +3095,6 @@ void scsi_device_resume(struct scsi_device *sdev)
 	 * device deleted during suspend)
 	 */
 	mutex_lock(&sdev->state_mutex);
-	WARN_ON_ONCE(!sdev->quiesced_by);
 	sdev->quiesced_by = NULL;
 	blk_clear_preempt_only(sdev->request_queue);
 	if (sdev->sdev_state == SDEV_QUIESCE)
-- 
2.19.1

