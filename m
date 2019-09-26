Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A9C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FED8222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfIZCwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 22:52:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56076 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfIZCwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:52:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AA44D2004DD;
        Thu, 26 Sep 2019 04:51:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 173CF200049;
        Thu, 26 Sep 2019 04:51:55 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2A031402D5;
        Thu, 26 Sep 2019 10:51:49 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, ran.wang_1@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [v4,1/3] soc: fsl: handle RCPM errata A-008646 on SoC LS1021A
Date:   Thu, 26 Sep 2019 10:41:16 +0800
Message-Id: <20190926024118.15931-1-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
	- Reading configuration register RCPM_IPPDEXPCR1
	  always return zero

Workaround:
	- Save register RCPM_IPPDEXPCR1's value to
	  register SCFG_SPARECR8.(uboot's psci also
	  need reading value from the register SCFG_SPARECR8
	  to set register RCPM_IPPDEXPCR1)

Impact:
	- FlexTimer module will cannot wakeup system in
	  deep sleep on SoC LS1021A

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v4:
	- rename property name
	  fsl,ippdexpcr-alt-addr -> fsl,ippdexpcr1-alt-addr

Change in v3:
	- update commit message
	- rename property name
	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr

Change in v2:
	- fix stype problems

 drivers/soc/fsl/rcpm.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index 82c0ad5e663e..9a29c482fc2e 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #define RCPM_WAKEUP_CELL_MAX_SIZE	7
 
@@ -29,6 +31,9 @@ static int rcpm_pm_prepare(struct device *dev)
 	struct rcpm		*rcpm;
 	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1], tmp;
 	int i, ret, idx;
+	struct regmap *scfg_addr_regmap = NULL;
+	u32 reg_offset[RCPM_WAKEUP_CELL_MAX_SIZE + 1];
+	u32 reg_value = 0;
 
 	rcpm = dev_get_drvdata(dev);
 	if (!rcpm)
@@ -63,6 +68,34 @@ static int rcpm_pm_prepare(struct device *dev)
 					tmp |= value[i + 1];
 					iowrite32be(tmp, rcpm->ippdexpcr_base + i * 4);
 				}
+				/* Workaround of errata A-008646 on SoC LS1021A:
+				 * There is a bug of register ippdexpcr1.
+				 * Reading configuration register RCPM_IPPDEXPCR1
+				 * always return zero. So save ippdexpcr1's value
+				 * to register SCFG_SPARECR8.And the value of
+				 * ippdexpcr1 will be read from SCFG_SPARECR8.
+				 */
+				scfg_addr_regmap = syscon_regmap_lookup_by_phandle(np,
+										   "fsl,ippdexpcr1-alt-addr");
+				if (scfg_addr_regmap && (1 == i)) {
+					if (of_property_read_u32_array(dev->of_node,
+					    "fsl,ippdexpcr1-alt-addr",
+					    reg_offset,
+					    1 + sizeof(u64)/sizeof(u32))) {
+						scfg_addr_regmap = NULL;
+						continue;
+					}
+					/* Read value from register SCFG_SPARECR8 */
+					regmap_read(scfg_addr_regmap,
+						    (u32)(((u64)(reg_offset[1] << (sizeof(u32) * 8) |
+						    reg_offset[2])) & 0xffffffff),
+						    &reg_value);
+					/* Write value to register SCFG_SPARECR8 */
+					regmap_write(scfg_addr_regmap,
+						     (u32)(((u64)(reg_offset[1] << (sizeof(u32) * 8) |
+						     reg_offset[2])) & 0xffffffff),
+						     tmp | reg_value);
+				}
 			}
 		}
 	} while (ws = wakeup_source_get_next(ws));
-- 
2.17.1

