Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A2C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A042320848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005466;
	bh=G2S2ZfSJj1ktCtGE+riaKeypG8fBit0q2RLQXZ1U2Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uiiMZL5Blp8AGMN0+6uDMp+K/xefQZC9oDBm0hOPNY/YNuZZdyOJyUNAwKYhtULXa
	 ruwvpwp3DnQL+U/8DaJHY/wwKXo9oJbHrUVZJWQLfEZaQzVR9OdS9vlYS41lPRqET0
	 bJZLLcbcdYbOOAy9NA5Kx9NTS3LiOIKz6wj5kk+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgABWYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbgABWYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:24:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A3FC222C3;
        Thu,  2 Jan 2020 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003872;
        bh=G2S2ZfSJj1ktCtGE+riaKeypG8fBit0q2RLQXZ1U2Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ST8Cnlf55uLEgV3H5Z+RoGkkxj+4U/aYmlICag+8qT2WHdsEeUe7d+9RTxM09QBYL
         9SDcMgVPnw577NUjOUpFne58odb8clTaxw15NiRZ/5boaFFpw2YIpYw9fRrgoy272F
         eM491ESd5RD9LWEx+4dOwr8D5DgPZGENYp+VNnoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/91] scsi: ufs: fix potential bug which ends in system hang
Date:   Thu,  2 Jan 2020 23:07:09 +0100
Message-Id: <20200102220429.170756865@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

[ Upstream commit cfcbae3895b86c390ede57b2a8f601dd5972b47b ]

In function __ufshcd_query_descriptor(), in the event of an error
happening, we directly goto out_unlock and forget to invaliate
hba->dev_cmd.query.descriptor pointer. This results in this pointer still
valid in ufshcd_copy_query_response() for other query requests which go
through ufshcd_exec_raw_upiu_cmd(). This will cause __memcpy() crash and
system hangs. Log as shown below:

Unable to handle kernel paging request at virtual address
ffff000012233c40
Mem abort info:
   ESR = 0x96000047
   Exception class = DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
Data abort info:
   ISV = 0, ISS = 0x00000047
   CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp = 0000000028cc735c
[ffff000012233c40] pgd=00000000bffff003, pud=00000000bfffe003,
pmd=00000000ba8b8003, pte=0000000000000000
 Internal error: Oops: 96000047 [#2] PREEMPT SMP
 ...
 Call trace:
  __memcpy+0x74/0x180
  ufshcd_issue_devman_upiu_cmd+0x250/0x3c0
  ufshcd_exec_raw_upiu_cmd+0xfc/0x1a8
  ufs_bsg_request+0x178/0x3b0
  bsg_queue_rq+0xc0/0x118
  blk_mq_dispatch_rq_list+0xb0/0x538
  blk_mq_sched_dispatch_requests+0x18c/0x1d8
  __blk_mq_run_hw_queue+0xb4/0x118
  blk_mq_run_work_fn+0x28/0x38
  process_one_work+0x1ec/0x470
  worker_thread+0x48/0x458
  kthread+0x130/0x138
  ret_from_fork+0x10/0x1c
 Code: 540000ab a8c12027 a88120c7 a8c12027 (a88120c7)
 ---[ end trace 793e1eb5dff69f2d ]---
 note: kworker/0:2H[2054] exited with preempt_count 1

This patch is to move "descriptor = NULL" down to below the label
"out_unlock".

Fixes: d44a5f98bb49b2(ufs: query descriptor API)
Link: https://lore.kernel.org/r/20191112223436.27449-3-huobean@gmail.com
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 07cae5ea608c..9feae23bfd09 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2867,10 +2867,10 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 		goto out_unlock;
 	}
 
-	hba->dev_cmd.query.descriptor = NULL;
 	*buf_len = be16_to_cpu(response->upiu_res.length);
 
 out_unlock:
+	hba->dev_cmd.query.descriptor = NULL;
 	mutex_unlock(&hba->dev_cmd.lock);
 out:
 	ufshcd_release(hba);
-- 
2.20.1



