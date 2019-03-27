Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D8D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715149;
	bh=uLV+b8csXIpp+5O77PUcn60dRftAUzlG52ayYezGYpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqj5QV6ulUlYz2L1/AaKU1DrNhbNyjuIgrPing1EHo8ftQYHwYpaZ04lzRfDck1mY
	 zo9CReg6D/BgFexg8jfr/dxIym3tRLGS+PhwWo0tkIN53bVFqXcpvmr7/ndMwyiyKL
	 4l3ptAPcBOmsJVIn+ojmhlw9rW7pygDmz1g3mHpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfC0Tc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730973AbfC0SCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF25821738;
        Wed, 27 Mar 2019 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709760;
        bh=uLV+b8csXIpp+5O77PUcn60dRftAUzlG52ayYezGYpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPKUOKOeouO9JCPkCkjFi0XlrDyqwHEQguJiaeqpNq2gsqAGEsSnq3ykfzxoGw02p
         QdxeaxUxFiQWyIbET9EEnk1IHVgqsgKATL3JHej55RQDH3Dp0NnatugQIEW8tk0L9C
         Nk8Hy7j2MAf9HtWemqWWXKxVXQ1NmP8DSrmuFhJc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 026/262] scsi: hisi_sas: Fix a timeout race of driver internal and SMP IO
Date:   Wed, 27 Mar 2019 13:58:01 -0400
Message-Id: <20190327180158.10245-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 4790595723d4b833b18c994973d39f9efb842887 ]

For internal IO and SMP IO, there is a time-out timer for them. In the
timer handler, it checks whether IO is done according to the flag
task->task_state_lock.

There is an issue which may cause system suspended: internal IO or SMP IO
is sent, but at that time because of hardware exception (such as inject
2Bit ECC error), so IO is not completed and also not timeout. But, at that
time, the SAS controller reset occurs to recover system. It will release
the resource and set the status of IO to be SAS_TASK_STATE_DONE, so when IO
timeout, it will never complete the completion of IO and wait for ever.

[  729.123632] Call trace:
[  729.126791] [<ffff00000808655c>] __switch_to+0x94/0xa8
[  729.133106] [<ffff000008d96e98>] __schedule+0x1e8/0x7fc
[  729.138975] [<ffff000008d974e0>] schedule+0x34/0x8c
[  729.144401] [<ffff000008d9b000>] schedule_timeout+0x1d8/0x3cc
[  729.150690] [<ffff000008d98218>] wait_for_common+0xdc/0x1a0
[  729.157101] [<ffff000008d98304>] wait_for_completion+0x28/0x34
[  729.165973] [<ffff000000dcefb4>] hisi_sas_internal_task_abort+0x2a0/0x424 [hisi_sas_test_main]
[  729.176447] [<ffff000000dd18f4>] hisi_sas_abort_task+0x244/0x2d8 [hisi_sas_test_main]
[  729.185258] [<ffff000008971714>] sas_eh_handle_sas_errors+0x1c8/0x7b8
[  729.192391] [<ffff000008972774>] sas_scsi_recover_host+0x130/0x398
[  729.199237] [<ffff00000894d8a8>] scsi_error_handler+0x148/0x5c0
[  729.206009] [<ffff0000080f4118>] kthread+0x10c/0x138
[  729.211563] [<ffff0000080855dc>] ret_from_fork+0x10/0x18

To solve the issue, callback function task_done of those IOs need to be
called when on SAS controller reset.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 88ae415e907a..62d158574281 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -873,7 +873,8 @@ static void hisi_sas_do_release_task(struct hisi_hba *hisi_hba, struct sas_task
 		spin_lock_irqsave(&task->task_state_lock, flags);
 		task->task_state_flags &=
 			~(SAS_TASK_STATE_PENDING | SAS_TASK_AT_INITIATOR);
-		task->task_state_flags |= SAS_TASK_STATE_DONE;
+		if (!slot->is_internal && task->task_proto != SAS_PROTOCOL_SMP)
+			task->task_state_flags |= SAS_TASK_STATE_DONE;
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
 	}
 
-- 
2.19.1

