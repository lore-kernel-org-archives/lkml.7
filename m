Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F07C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788622075B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE2KRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:17:12 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2482 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2KRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:17:12 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15cee5c1c5ec-e1cb0; Wed, 29 May 2019 18:17:01 +0800 (CST)
X-RM-TRANSID: 2ee15cee5c1c5ec-e1cb0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95cee5c1c2ed-2ea11;
        Wed, 29 May 2019 18:17:01 +0800 (CST)
X-RM-TRANSID: 2ee95cee5c1c2ed-2ea11
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh/intc: Fix obsolete function
Date:   Wed, 29 May 2019 18:16:11 +0800
Message-Id: <1559124971-13074-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple_strtoul is obsolete, use kstrtoul instead.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/sh/intc/userimask.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
index 87d69e7..d1d8e9b 100644
--- a/drivers/sh/intc/userimask.c
+++ b/drivers/sh/intc/userimask.c
@@ -33,7 +33,8 @@
 {
 	unsigned long level;
 
-	level = simple_strtoul(buf, NULL, 10);
+	if (kstrtoul(buf, 10, &level))
+		return -EINVAL;
 
 	/*
 	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but
-- 
1.9.1



