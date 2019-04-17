Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D09C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616412075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfDQCqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:46:46 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:7802 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbfDQCqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:46:43 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CDDD3FB3C976136B9B7B;
        Wed, 17 Apr 2019 10:46:40 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3H2kWNL061453;
        Wed, 17 Apr 2019 10:46:32 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041710465228-8910308 ;
          Wed, 17 Apr 2019 10:46:52 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] firmware: arm_sdei: fix leaked of_node references
Date:   Wed, 17 Apr 2019 10:44:51 +0800
Message-Id: <1555469093-35179-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555469093-35179-1-git-send-email-wen.yang99@zte.com.cn>
References: <1555469093-35179-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-17 10:46:52,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-17 10:46:24,
        Serialize complete at 2019-04-17 10:46:24
X-MAIL: mse01.zte.com.cn x3H2kWNL061453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdei_present_dt function, fw_np is obtained by calling
of_find_node_by_name(), np is obtained by calling
of_find_matching_node(), and the reference counts of those
two device_nodes, fw_np and np, are increased.
But when the function exits, only of_node_put is called on np,
and fw_np's reference count is leaked.

Detected by coccinelle with the following warnings:
./drivers/firmware/arm_sdei.c:1088:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1082, but without a corresponding object release within this function.
./drivers/firmware/arm_sdei.c:1091:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1082, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/firmware/arm_sdei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index e6376f9..2faa329 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1084,6 +1084,7 @@ static bool __init sdei_present_dt(void)
 		return false;
 
 	np = of_find_matching_node(fw_np, sdei_of_match);
+	of_node_put(fw_np);
 	if (!np)
 		return false;
 	of_node_put(np);
-- 
2.9.5

