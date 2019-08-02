Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD85C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809BB2183F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752266;
	bh=BkgF6W6cU4t03/sCPsJI+irpnsEjZPklwtgxSw3KkzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iGTy0iR8KaHxQHZtfMDhZzIfSHEKTdbJQumUSNeeLzqHXjV0Gr96D7HCOo3ikKvXh
	 u9+/N/GppSVN/uiblPZcYjrAv1L3bJQDy3bmxy9UGWf3zdbErwSs0nYgj8iJ8ETGig
	 LDeo/ARmNKuoSCmLJVMCJfm3Xz7rPxNH13pwAvqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394163AbfHBNYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730993AbfHBNYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC53521773;
        Fri,  2 Aug 2019 13:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752247;
        bh=BkgF6W6cU4t03/sCPsJI+irpnsEjZPklwtgxSw3KkzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpHQpV/VZVkIEyjvKFE5QQ4mDiSEic7ljbJxECxybwCKFS/S3lgGYWXsx9DBixumF
         pIUIrxIbeuVBZj3feoGfQBzbqJbL0lFFANFBC4SklKzBp84eob44cwnW95cfMoU7Qx
         1xN7MwHXVD+ka4f6OvCqOnsr96agiOWZ1Fmprmm0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        Zhangguanghui <zhang.guanghui@h3c.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 36/42] scsi: scsi_dh_alua: always use a 2 second delay before retrying RTPG
Date:   Fri,  2 Aug 2019 09:22:56 -0400
Message-Id: <20190802132302.13537-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132302.13537-1-sashal@kernel.org>
References: <20190802132302.13537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 20122994e38aef0ae50555884d287adde6641c94 ]

Retrying immediately after we've received a 'transitioning' sense code is
pretty much pointless, we should always use a delay before retrying.  So
ensure the default delay is applied before retrying.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Tested-by: Zhangguanghui <zhang.guanghui@h3c.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index d1154baa9436a..9c21938ed67ed 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -54,6 +54,7 @@
 #define ALUA_FAILOVER_TIMEOUT		60
 #define ALUA_FAILOVER_RETRIES		5
 #define ALUA_RTPG_DELAY_MSECS		5
+#define ALUA_RTPG_RETRY_DELAY		2
 
 /* device handler flags */
 #define ALUA_OPTIMIZE_STPG		0x01
@@ -696,7 +697,7 @@ static int alua_rtpg(struct scsi_device *sdev, struct alua_port_group *pg)
 	case SCSI_ACCESS_STATE_TRANSITIONING:
 		if (time_before(jiffies, pg->expiry)) {
 			/* State transition, retry */
-			pg->interval = 2;
+			pg->interval = ALUA_RTPG_RETRY_DELAY;
 			err = SCSI_DH_RETRY;
 		} else {
 			struct alua_dh_data *h;
@@ -821,6 +822,8 @@ static void alua_rtpg_work(struct work_struct *work)
 				spin_lock_irqsave(&pg->lock, flags);
 				pg->flags &= ~ALUA_PG_RUNNING;
 				pg->flags |= ALUA_PG_RUN_RTPG;
+				if (!pg->interval)
+					pg->interval = ALUA_RTPG_RETRY_DELAY;
 				spin_unlock_irqrestore(&pg->lock, flags);
 				queue_delayed_work(kaluad_wq, &pg->rtpg_work,
 						   pg->interval * HZ);
@@ -832,6 +835,8 @@ static void alua_rtpg_work(struct work_struct *work)
 		spin_lock_irqsave(&pg->lock, flags);
 		if (err == SCSI_DH_RETRY || pg->flags & ALUA_PG_RUN_RTPG) {
 			pg->flags &= ~ALUA_PG_RUNNING;
+			if (!pg->interval && !(pg->flags & ALUA_PG_RUN_RTPG))
+				pg->interval = ALUA_RTPG_RETRY_DELAY;
 			pg->flags |= ALUA_PG_RUN_RTPG;
 			spin_unlock_irqrestore(&pg->lock, flags);
 			queue_delayed_work(kaluad_wq, &pg->rtpg_work,
-- 
2.20.1

