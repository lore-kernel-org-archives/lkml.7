Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6871C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B891204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDKBo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:44:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfDKBo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:44:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 117C44E423450D38A795;
        Thu, 11 Apr 2019 09:44:26 +0800 (CST)
Received: from huawei.com (10.67.189.167) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Apr 2019
 09:44:19 +0800
From:   xiaojiangfeng <xiaojiangfeng@huawei.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>, <robh@kernel.org>,
        <grant.likely@secretlab.ca>, <xiaojiangfeng@huawei.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] of: fix expression using sizeof(void)
Date:   Thu, 11 Apr 2019 09:47:35 +0800
Message-ID: <1554947255-80031-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.167]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

problem detected by sparse:
drivers/of/fdt.c:1094:34: warning: expression using sizeof(void)

Signed-off-by: xiaojiangfeng <xiaojiangfeng@huawei.com>
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4734223..75c6c55 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1091,7 +1091,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
 	if (p != NULL && l > 0)
-		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
+		strlcpy(data, p, COMMAND_LINE_SIZE);
 
 	/*
 	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-- 
1.8.5.6

