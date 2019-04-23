Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DBC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6693E20449
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfDWXbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:31:45 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:44952 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfDWXbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:31:44 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 402ACAE8D7E33F37F477;
        Wed, 24 Apr 2019 07:31:42 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x3NNVdiU094113;
        Wed, 24 Apr 2019 07:31:39 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019042407315666-9404756 ;
          Wed, 24 Apr 2019 07:31:56 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: stratix10-soc: fix use-after-free on s10_init()
Date:   Wed, 24 Apr 2019 07:32:05 +0800
Message-Id: <1556062325-26141-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-24 07:31:56,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-24 07:31:31,
        Serialize complete at 2019-04-24 07:31:31
X-MAIL: mse-fl2.zte.com.cn x3NNVdiU094113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refcount of fw_np has already been decreased by of_find_matching_node()
so it shouldn't be used anymore.
This patch adds an of_node_get() before of_find_matching_node() to avoid
the use-after-free problem.

Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/fpga/stratix10-soc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 13851b3..215d337 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -507,12 +507,16 @@ static int __init s10_init(void)
 	if (!fw_np)
 		return -ENODEV;
 
+	of_node_get(fw_np);
 	np = of_find_matching_node(fw_np, s10_of_match);
-	if (!np)
+	if (!np) {
+		of_node_put(fw_np);
 		return -ENODEV;
+	}
 
 	of_node_put(np);
 	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
+	of_node_put(fw_np);
 	if (ret)
 		return ret;
 
-- 
2.9.5

