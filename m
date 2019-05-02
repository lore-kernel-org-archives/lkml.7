Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F52C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70A22075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfEBMpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:45:38 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:54758 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfEBMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:45:38 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 7Qld200053XaVaC06Qldtr; Thu, 02 May 2019 14:45:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hMB5k-0007h4-WA; Thu, 02 May 2019 14:45:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hMB5k-0001eE-Uc; Thu, 02 May 2019 14:45:36 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: unittest: Remove error printing on OOM
Date:   Thu,  2 May 2019 14:45:35 +0200
Message-Id: <20190502124535.6292-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print a backtrace or other error message if
kzalloc(), kmemdup(), or devm_kzalloc() fails, as the memory allocation
core already takes care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/unittest.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 2f8e43876c3da70c..a3d31103962b7dd9 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -344,7 +344,7 @@ static void __init of_unittest_check_phandles(void)
 		}
 
 		nh = kzalloc(sizeof(*nh), GFP_KERNEL);
-		if (WARN_ON(!nh))
+		if (!nh)
 			return;
 
 		nh->np = np;
@@ -1199,12 +1199,9 @@ static int __init unittest_data_add(void)
 
 	/* creating copy */
 	unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
-
-	if (!unittest_data) {
-		pr_warn("%s: Failed to allocate memory for unittest_data; "
-			"not running tests\n", __func__);
+	if (!unittest_data)
 		return -ENOMEM;
-	}
+
 	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
@@ -1845,10 +1842,8 @@ static int unittest_i2c_bus_probe(struct platform_device *pdev)
 	dev_dbg(dev, "%s for node @%pOF\n", __func__, np);
 
 	std = devm_kzalloc(dev, sizeof(*std), GFP_KERNEL);
-	if (!std) {
-		dev_err(dev, "Failed to allocate unittest i2c data\n");
+	if (!std)
 		return -ENOMEM;
-	}
 
 	/* link them together */
 	std->pdev = pdev;
-- 
2.17.1

