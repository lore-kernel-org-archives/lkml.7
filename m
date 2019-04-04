Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67080C10F0D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3828121901
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368903;
	bh=chVVm/2/4OKB5cIRpVAtGVf8rX01/FTP83VSQQiQMuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qsrndl1x8hGwSJ8lHQNVlilGfglec79EihKIp7MSXyY35DhhIqz6ae8JoeZUrQszi
	 RQcivNBnEmHye25n7o5NfjUv9HzF75CUS2ZqNXUvtJFSSagdwhWsrO1DB2WH0eSu/Z
	 tX7fqOUlUwXYY0alAnYs2zYtQ19DouSxWqLANVMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfDDJIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbfDDJIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5821218FF;
        Thu,  4 Apr 2019 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368898;
        bh=chVVm/2/4OKB5cIRpVAtGVf8rX01/FTP83VSQQiQMuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aA9q99WK5rnIx7mery1T7dFmQOXb2xduhqG1i8ISqBhcPg/4Y+Qq2DP5PVzPRoyvr
         vgztnP6hA83bVA4hAd4pIwK3rUn0pCd0tBRGLFpY1F9oAbaaS8h7P7rNisGOn7VGZY
         Le9R5vWKcpzazSfqKjZYZx/Ba4q9l5mxKr8x8VkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 022/246] scsi: hisi_sas: Fix a timeout race of driver internal and SMP IO
Date:   Thu,  4 Apr 2019 10:45:22 +0200
Message-Id: <20190404084619.916001143@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



