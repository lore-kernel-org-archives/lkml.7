Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A3F206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfLaK3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:29:49 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60245 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727134AbfLaK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:29:31 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 31 Dec 2019 12:29:28 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xBVATJ7f008518;
        Tue, 31 Dec 2019 12:29:28 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 8/9] platform/mellanox: mlxreg-hotplug: Add support for new capability register
Date:   Tue, 31 Dec 2019 10:29:16 +0000
Message-Id: <20191231102917.24181-9-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191231102917.24181-1-vadimp@mellanox.com>
References: <20191231102917.24181-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for capability register, which is used for detection of the
actual number of interrupt capable components within the particular
group, supported by the specific system.
Such components could be for example the number of power units and
interrupts related to these units.
The motivation is to avoid adding a new code in the future in order to
distinct between the systems type supported different number of the
components like power supplies, FANs, ASICs, line cards.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 14 ++++++++++++++
 include/linux/platform_data/mlxreg.h       |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 706207d192ae..77be37a1fbcf 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -504,6 +504,20 @@ static int mlxreg_hotplug_set_irq(struct mlxreg_hotplug_priv_data *priv)
 	item = pdata->items;
 
 	for (i = 0; i < pdata->counter; i++, item++) {
+		if (item->capability) {
+			/*
+			 * Read group capability register to get actual number
+			 * of interrupt capable components and set group mask
+			 * accordingly.
+			 */
+			ret = regmap_read(priv->regmap, item->capability,
+					  &regval);
+			if (ret)
+				goto out;
+
+			item->mask = GENMASK((regval & item->mask) - 1, 0);
+		}
+
 		/* Clear group presense event. */
 		ret = regmap_write(priv->regmap, item->reg +
 				   MLXREG_HOTPLUG_EVENT_OFF, 0);
diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index 6d54fe3bcac9..b8da8aef2446 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -101,6 +101,7 @@ struct mlxreg_core_data {
  * @aggr_mask: group aggregation mask;
  * @reg: group interrupt status register;
  * @mask: group interrupt mask;
+ * @capability: group capability register;
  * @cache: last status value for elements fro the same group;
  * @count: number of available elements in the group;
  * @ind: element's index inside the group;
@@ -112,6 +113,7 @@ struct mlxreg_core_item {
 	u32 aggr_mask;
 	u32 reg;
 	u32 mask;
+	u32 capability;
 	u32 cache;
 	u8 count;
 	u8 ind;
-- 
2.11.0

