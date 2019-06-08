Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C2C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824DB2166E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994145;
	bh=K1MApQ/oZF1VzMLMdr0fGQ8ZObjTCfSeKPtjXmgD38I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JJXycmeBx9sj4UqmogvfHl9OCIxJ5l3ca8rg674zQ3LKqf/VR2jEe+yUKOxniuRgv
	 O+VRjQiT1Z6gKZDEGrFl9gCV30HeUcLjKZLfDTl20dO4O8C93++du7JJh3zC4qi9ag
	 Tuezb1ZjEb4dnRi0dbyd5glbmHU3O42BRk6FCmlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfFHLmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfFHLmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:42:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38BA9214DA;
        Sat,  8 Jun 2019 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994142;
        bh=K1MApQ/oZF1VzMLMdr0fGQ8ZObjTCfSeKPtjXmgD38I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxENHbCWG+aCkjOSv5BN7/jnrPxsUpAoUavGxab1sDtfQoGEpAz4ucaQTkkrE+OIo
         Q96x7W+1WudyG4cDMtEgt3QXVYvuZe+JBjdqroPh8gItnOzFZCHgcAE9pn63BinrY7
         cJr5odhfgArHbYDDETs0b7bqsJgEKQ88llGBxeJU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 67/70] scsi: scsi_dh_alua: Fix possible null-ptr-deref
Date:   Sat,  8 Jun 2019 07:39:46 -0400
Message-Id: <20190608113950.8033-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 12e750bc62044de096ab9a95201213fd912b9994 ]

If alloc_workqueue fails in alua_init, it should return -ENOMEM, otherwise
it will trigger null-ptr-deref while unloading module which calls
destroy_workqueue dereference
wq->lock like this:

BUG: KASAN: null-ptr-deref in __lock_acquire+0x6b4/0x1ee0
Read of size 8 at addr 0000000000000080 by task syz-executor.0/7045

CPU: 0 PID: 7045 Comm: syz-executor.0 Tainted: G         C        5.1.0+ #28
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
Call Trace:
 dump_stack+0xa9/0x10e
 __kasan_report+0x171/0x18d
 ? __lock_acquire+0x6b4/0x1ee0
 kasan_report+0xe/0x20
 __lock_acquire+0x6b4/0x1ee0
 lock_acquire+0xb4/0x1b0
 __mutex_lock+0xd8/0xb90
 drain_workqueue+0x25/0x290
 destroy_workqueue+0x1f/0x3f0
 __x64_sys_delete_module+0x244/0x330
 do_syscall_64+0x72/0x2a0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 03197b61c5ec ("scsi_dh_alua: Use workqueue for RTPG")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index d7ac498ba35a..2a9dcb8973b7 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1174,10 +1174,8 @@ static int __init alua_init(void)
 	int r;
 
 	kaluad_wq = alloc_workqueue("kaluad", WQ_MEM_RECLAIM, 0);
-	if (!kaluad_wq) {
-		/* Temporary failure, bypass */
-		return SCSI_DH_DEV_TEMP_BUSY;
-	}
+	if (!kaluad_wq)
+		return -ENOMEM;
 
 	r = scsi_register_device_handler(&alua_dh);
 	if (r != 0) {
-- 
2.20.1

