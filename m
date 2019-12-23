Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F90C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F06206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWOXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:23:25 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59913 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbfLWOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:23:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TlkllZi_1577110976;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TlkllZi_1577110976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Dec 2019 22:23:05 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH 1/3] firmware: arm_sdei: fix possible deadlock
Date:   Mon, 23 Dec 2019 22:22:53 +0800
Message-Id: <1577110975-54782-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liguang Zhang <zhangliguang@linux.alibaba.com>

We call sdei_reregister_event() with sdei_list_lock held but
_sdei_event_register() and sdei_event_destroy() also acquires
sdei_list_lock thus creating A-A deadlock.

Fixes: da351827240e ("firmware: arm_sdei: Add support for CPU and system power states")
Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/firmware/arm_sdei.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index a479023..b122927 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -651,20 +651,19 @@ static int sdei_reregister_event(struct sdei_event *event)
 
 	lockdep_assert_held(&sdei_events_lock);
 
-	err = _sdei_event_register(event);
+	err = sdei_api_event_register(event->event_num,
+				       sdei_entry_point,
+				       event->registered,
+				       SDEI_EVENT_REGISTER_RM_ANY, 0);
 	if (err) {
 		pr_err("Failed to re-register event %u\n", event->event_num);
-		sdei_event_destroy(event);
+		list_del(&event->list);
+		kfree(event->registered);
 		return err;
 	}
 
-	if (event->reenable) {
-		if (event->type == SDEI_EVENT_TYPE_SHARED)
-			err = sdei_api_event_enable(event->event_num);
-		else
-			err = sdei_do_cross_call(_local_event_enable, event);
-	}
-
+	if (event->reenable)
+		err = sdei_api_event_enable(event->event_num);
 	if (err)
 		pr_err("Failed to re-enable event %u\n", event->event_num);
 
-- 
1.8.3.1

