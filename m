Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD34C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142402075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfDQCqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:46:50 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:58616 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfDQCqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:46:43 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A9875A74D1A8B70B2D7A;
        Wed, 17 Apr 2019 10:46:42 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3H2kXZd061455;
        Wed, 17 Apr 2019 10:46:33 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041710465318-8910313 ;
          Wed, 17 Apr 2019 10:46:53 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Tull <atull@kernel.org>,
        Richard Gong <richard.gong@intel.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 3/3] firmware: stratix10-svc: fix leaked of_node references
Date:   Wed, 17 Apr 2019 10:44:53 +0800
Message-Id: <1555469093-35179-4-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555469093-35179-1-git-send-email-wen.yang99@zte.com.cn>
References: <1555469093-35179-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-17 10:46:53,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-17 10:46:25,
        Serialize complete at 2019-04-17 10:46:25
X-MAIL: mse01.zte.com.cn x3H2kXZd061455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In stratix10_svc_init function, fw_np is obtained by calling
of_find_node_by_name(), np is obtained by calling
of_find_matching_node(), and the reference counts of those
two device_nodes, fw_np and np, are increased.
But when the function exits, only of_node_put is called on np,
and fw_np's reference count is leaked.

Detected by coccinelle with the following warnings:
./drivers/firmware/stratix10-svc.c:1020:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1014, but without a corresponding object release within this function.
./drivers/firmware/stratix10-svc.c:1025:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1014, but without a corresponding object release within this function.
./drivers/firmware/stratix10-svc.c:1027:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1014, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Tull <atull@kernel.org>
Cc: Richard Gong <richard.gong@intel.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux-kernel@vger.kernel.org
---
 drivers/firmware/stratix10-svc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 6e65148..482a6bd 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1016,15 +1016,21 @@ static int __init stratix10_svc_init(void)
 		return -ENODEV;
 
 	np = of_find_matching_node(fw_np, stratix10_svc_drv_match);
-	if (!np)
-		return -ENODEV;
+	if (!np) {
+		ret = -ENODEV;
+		goto out_put_fw_np;
+	}
 
 	of_node_put(np);
 	ret = of_platform_populate(fw_np, stratix10_svc_drv_match, NULL, NULL);
 	if (ret)
-		return ret;
+		goto out_put_fw_np;
 
-	return platform_driver_register(&stratix10_svc_driver);
+	ret = platform_driver_register(&stratix10_svc_driver);
+
+out_put_fw_np:
+	of_node_put(fw_np);
+	return ret;
 }
 
 static void __exit stratix10_svc_exit(void)
-- 
2.9.5

