Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288FDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EC420679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfKYPym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:54:42 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44654 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728243AbfKYPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:54:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tj4pjJn_1574697251;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Tj4pjJn_1574697251)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Nov 2019 23:54:29 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Wen Yang <wenyang@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: avoid double free in error flow
Date:   Mon, 25 Nov 2019 23:54:09 +0800
Message-Id: <20191125155409.9948-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device_register() fails, both put_device() and kfree()
are called, ending with a double free of the scmi_dev.

Calling kfree() is needed only when a failure happens between the
allocation of the scmi_dev and its registration, so move it to
there and remove it from the error flow.

Fixes: 46edb8d1322c ("firmware: arm_scmi: provide the mandatory device release callback")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/firmware/arm_scmi/bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 92f843ea..7a30952 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -135,8 +135,10 @@ struct scmi_device *
 		return NULL;
 
 	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
-	if (id < 0)
-		goto free_mem;
+	if (id < 0) {
+		kfree(scmi_dev);
+		return NULL;
+	}
 
 	scmi_dev->id = id;
 	scmi_dev->protocol_id = protocol;
@@ -154,8 +156,6 @@ struct scmi_device *
 put_dev:
 	put_device(&scmi_dev->dev);
 	ida_simple_remove(&scmi_bus_id, id);
-free_mem:
-	kfree(scmi_dev);
 	return NULL;
 }
 
-- 
1.8.3.1

