Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E517C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B24F21738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfGXOg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:36:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33133 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfGXOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:36:58 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Jul 2019 17:36:52 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x6OEaptX008814;
        Wed, 24 Jul 2019 10:36:51 -0400
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x6OEapho015962;
        Wed, 24 Jul 2019 10:36:51 -0400
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     minyard@acm.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org,
        asmaa@mellanox.com
Subject: [PATCH v1 1/1] Fix uninitialized variable in ipmb_dev_int.c
Date:   Wed, 24 Jul 2019 10:36:42 -0400
Message-Id: <84ef25695b2bfa5100803d5bb30e5d4152e336e0.1563978634.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1563978634.git.Asmaa@mellanox.com>
References: <cover.1563978634.git.Asmaa@mellanox.com>
In-Reply-To: <cover.1563978634.git.Asmaa@mellanox.com>
References: <cover.1563978634.git.Asmaa@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 5720433..285e0b8 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -76,7 +76,7 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
 	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
 	struct ipmb_request_elem *queue_elem;
 	struct ipmb_msg msg;
-	ssize_t ret;
+	ssize_t ret = 0;
 
 	memset(&msg, 0, sizeof(msg));
 
-- 
2.1.2

