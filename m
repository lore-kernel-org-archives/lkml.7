Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B7C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3785A2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344291;
	bh=eSh8T2nSPy8y2TgRE1CffHRlokwH0nJvPtRMTdfQcbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MRSPZy+h/qySdCJJIIvBDek11lxpSO39xp5Mk65IHZLDT6tsdkUYejyhn616QWKPN
	 TOy+FcBNhNqxqKPZcD8uA0iT1PC6RL9m0O90VByn1wQAN3lE3pQDEYhdPOiYa5Oy45
	 /rvvn7RLLGBzpECzztpVTzQlTwOL4icrm/AZiaQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393357AbfIXQsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392140AbfIXQsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:48:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD17620673;
        Tue, 24 Sep 2019 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343693;
        bh=eSh8T2nSPy8y2TgRE1CffHRlokwH0nJvPtRMTdfQcbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkGFrO9W+o7/vum1LbPJHqItFCAbR1RSeEw0+Si3fXMOZYdwLsQHVeMSsTG/XB51W
         ZVoFUsTUpp0D/+aCBrD2yGGcuHb0/BtuoRd2y2iFDjruj4lpeRZarujckeZmMwpja3
         UYrs+jpE/f9AH10M1GEHeQI+rxOmY93iGwlSCKHg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 57/70] mailbox: mediatek: cmdq: clear the event in cmdq initial flow
Date:   Tue, 24 Sep 2019 12:45:36 -0400
Message-Id: <20190924164549.27058-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bibby Hsieh <bibby.hsieh@mediatek.com>

[ Upstream commit 6058f11870b8e6d4f5cc7b591097c00bf69a000d ]

GCE hardware stored event information in own internal sysram,
if the initial value in those sysram is not zero value
it will cause a situation that gce can wait the event immediately
after client ask gce to wait event but not really trigger the
corresponding hardware.

In order to make sure that the wait event function is
exactly correct, we need to clear the sysram value in
cmdq initial flow.

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 5 +++++
 include/linux/mailbox/mtk-cmdq-mailbox.h | 3 +++
 include/linux/soc/mediatek/mtk-cmdq.h    | 3 ---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 00d5219094e5d..48bba49139523 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -22,6 +22,7 @@
 #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
 
 #define CMDQ_CURR_IRQ_STATUS		0x10
+#define CMDQ_SYNC_TOKEN_UPDATE		0x68
 #define CMDQ_THR_SLOT_CYCLES		0x30
 #define CMDQ_THR_BASE			0x100
 #define CMDQ_THR_SIZE			0x80
@@ -104,8 +105,12 @@ static void cmdq_thread_resume(struct cmdq_thread *thread)
 
 static void cmdq_init(struct cmdq *cmdq)
 {
+	int i;
+
 	WARN_ON(clk_enable(cmdq->clock) < 0);
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
+	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
+		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
 	clk_disable(cmdq->clock);
 }
 
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index ccb73422c2fa2..e6f54ef6698b1 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -20,6 +20,9 @@
 #define CMDQ_WFE_WAIT			BIT(15)
 #define CMDQ_WFE_WAIT_VALUE		0x1
 
+/** cmdq event maximum */
+#define CMDQ_MAX_EVENT			0x3ff
+
 /*
  * CMDQ_CODE_MASK:
  *   set write mask
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 54ade13a9b157..4e8899972db4d 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -13,9 +13,6 @@
 
 #define CMDQ_NO_TIMEOUT		0xffffffffu
 
-/** cmdq event maximum */
-#define CMDQ_MAX_EVENT				0x3ff
-
 struct cmdq_pkt;
 
 struct cmdq_client {
-- 
2.20.1

