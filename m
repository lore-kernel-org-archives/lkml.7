Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D6C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6069B2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFNIGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:06:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45794 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfFNIGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:06:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB11F200E44;
        Fri, 14 Jun 2019 10:06:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37E1C2005D2;
        Fri, 14 Jun 2019 10:05:58 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BE37C402A0;
        Fri, 14 Jun 2019 16:05:52 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] soc: imx8: Fix potential kernel dump in error path
Date:   Fri, 14 Jun 2019 16:07:47 +0800
Message-Id: <20190614080748.32997-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

When SoC's revision value is 0, SoC driver will print out
"unknown" in sysfs's revision node, this "unknown" is a
static string which can NOT be freed, this will caused below
kernel dump in later error path which calls kfree:

kernel BUG at mm/slub.c:3942!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc4-next-20190611-00023-g705146c-dirty #2197
Hardware name: NXP i.MX8MQ EVK (DT)
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : kfree+0x170/0x1b0
lr : imx8_soc_init+0xc0/0xe4
sp : ffff00001003bd10
x29: ffff00001003bd10 x28: ffff00001121e0a0
x27: ffff000011482000 x26: ffff00001117068c
x25: ffff00001121e100 x24: ffff000011482000
x23: ffff000010fe2b58 x22: ffff0000111b9ab0
x21: ffff8000bd9dfba0 x20: ffff0000111b9b70
x19: ffff7e000043f880 x18: 0000000000001000
x17: ffff000010d05fa0 x16: ffff0000122e0000
x15: 0140000000000000 x14: 0000000030360000
x13: ffff8000b94b5bb0 x12: 0000000000000038
x11: ffffffffffffffff x10: ffffffffffffffff
x9 : 0000000000000003 x8 : ffff8000b9488147
x7 : ffff00001003bc00 x6 : 0000000000000000
x5 : 0000000000000003 x4 : 0000000000000003
x3 : 0000000000000003 x2 : b8793acd604edf00
x1 : ffff7e000043f880 x0 : ffff7e000043f888
Call trace:
 kfree+0x170/0x1b0
 imx8_soc_init+0xc0/0xe4
 do_one_initcall+0x58/0x1b8
 kernel_init_freeable+0x1cc/0x288
 kernel_init+0x10/0x100
 ret_from_fork+0x10/0x18

This patch fixes this potential kernel dump when a chip's
revision is "unknown", it is done by checking whether the
revision space can be freed.

Fixes: a7e26f356ca1 ("soc: imx: Add generic i.MX8 SoC driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- still need the "unknown" info for revision to avoid confusion, so fix this issue
	  by checking whether the revision space can be freed before freeing it.
---
 drivers/soc/imx/soc-imx8.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index 02309a2..5c7f330 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -155,7 +155,8 @@ static int __init imx8_soc_init(void)
 	return 0;
 
 free_rev:
-	kfree(soc_dev_attr->revision);
+	if (strcmp(soc_dev_attr->revision, "unknown"))
+		kfree(soc_dev_attr->revision);
 free_soc:
 	kfree(soc_dev_attr);
 	of_node_put(root);
-- 
2.7.4

