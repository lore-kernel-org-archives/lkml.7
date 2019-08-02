Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B59C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B849B217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752393;
	bh=Zlu+FMluWUdLvCE9sgOpTHdimenP8JMa4OO4KuQ0GuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rV0Il1hFabdHn7nyboxexy77wH7gzZgt69LxQFhhsrzRm3n6ORk9Qh+c6dRxXgwWq
	 eNR4d5XHRQOUV+trPzIAW+5VcFxjSRTFvh+eG9gL5XnJan2vP+EokF0QB15Yot+GPh
	 psLnfsS9myCY3JXopSUmuH/0LKJf0zM11iDIUngg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394595AbfHBN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391562AbfHBN01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:26:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDD8217D4;
        Fri,  2 Aug 2019 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752387;
        bh=Zlu+FMluWUdLvCE9sgOpTHdimenP8JMa4OO4KuQ0GuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sS9ht+9WTGf79LH2cxq60+Czy3UMBeZx8q3Cq+osxw9XfwTFTgc8zIdVtaKYaQ2Jc
         2okFuvyI3qXgGUvEbhleetNs09lSY/Jtwd1DlGJ+Rj/G/gZUjFzNaL7Rs5ZehvMvYJ
         xLDtSke27X9Y5dPde/OKPjjCpG9j6bdDhD6YPOIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        Zhangguanghui <zhang.guanghui@h3c.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 20/22] scsi: scsi_dh_alua: always use a 2 second delay before retrying RTPG
Date:   Fri,  2 Aug 2019 09:25:44 -0400
Message-Id: <20190802132547.14517-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132547.14517-1-sashal@kernel.org>
References: <20190802132547.14517-1-sashal@kernel.org>
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
index d3145799b92fa..98787588247bf 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -53,6 +53,7 @@
 #define ALUA_FAILOVER_TIMEOUT		60
 #define ALUA_FAILOVER_RETRIES		5
 #define ALUA_RTPG_DELAY_MSECS		5
+#define ALUA_RTPG_RETRY_DELAY		2
 
 /* device handler flags */
 #define ALUA_OPTIMIZE_STPG		0x01
@@ -681,7 +682,7 @@ static int alua_rtpg(struct scsi_device *sdev, struct alua_port_group *pg)
 	case SCSI_ACCESS_STATE_TRANSITIONING:
 		if (time_before(jiffies, pg->expiry)) {
 			/* State transition, retry */
-			pg->interval = 2;
+			pg->interval = ALUA_RTPG_RETRY_DELAY;
 			err = SCSI_DH_RETRY;
 		} else {
 			struct alua_dh_data *h;
@@ -809,6 +810,8 @@ static void alua_rtpg_work(struct work_struct *work)
 				spin_lock_irqsave(&pg->lock, flags);
 				pg->flags &= ~ALUA_PG_RUNNING;
 				pg->flags |= ALUA_PG_RUN_RTPG;
+				if (!pg->interval)
+					pg->interval = ALUA_RTPG_RETRY_DELAY;
 				spin_unlock_irqrestore(&pg->lock, flags);
 				queue_delayed_work(alua_wq, &pg->rtpg_work,
 						   pg->interval * HZ);
@@ -820,6 +823,8 @@ static void alua_rtpg_work(struct work_struct *work)
 		spin_lock_irqsave(&pg->lock, flags);
 		if (err == SCSI_DH_RETRY || pg->flags & ALUA_PG_RUN_RTPG) {
 			pg->flags &= ~ALUA_PG_RUNNING;
+			if (!pg->interval && !(pg->flags & ALUA_PG_RUN_RTPG))
+				pg->interval = ALUA_RTPG_RETRY_DELAY;
 			pg->flags |= ALUA_PG_RUN_RTPG;
 			spin_unlock_irqrestore(&pg->lock, flags);
 			queue_delayed_work(alua_wq, &pg->rtpg_work,
-- 
2.20.1

