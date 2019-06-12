Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0799EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB60A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407613AbfFLDei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:34:38 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52528 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404347AbfFLDeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:34:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A77731A0C2D;
        Wed, 12 Jun 2019 05:34:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 26B1E1A0C1D;
        Wed, 12 Jun 2019 05:34:31 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4B33F402CA;
        Wed, 12 Jun 2019 11:34:25 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] soc: imx8: Fix potential kernel dump in error path
Date:   Wed, 12 Jun 2019 11:36:19 +0800
Message-Id: <20190612033620.3556-1-Anson.Huang@nxp.com>
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
revision is "unknown", it is done by always printing out
the revision value.

Fixes: a7e26f356ca1 ("soc: imx: Add generic i.MX8 SoC driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index 02309a2..86b925a 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -96,11 +96,6 @@ static const struct of_device_id imx8_soc_match[] = {
 	{ }
 };
 
-#define imx8_revision(soc_rev) \
-	soc_rev ? \
-	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
-	"unknown"
-
 static int __init imx8_soc_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
@@ -135,7 +130,10 @@ static int __init imx8_soc_init(void)
 			soc_rev = data->soc_revision();
 	}
 
-	soc_dev_attr->revision = imx8_revision(soc_rev);
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL,
+					   "%d.%d",
+					   (soc_rev >> 4) & 0xf,
+					   soc_rev & 0xf);
 	if (!soc_dev_attr->revision) {
 		ret = -ENOMEM;
 		goto free_soc;
-- 
2.7.4

