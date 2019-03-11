Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D69C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A03A214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334124;
	bh=uuJY5hsgnonw1TO77Svvlxi6xb0Kj4kb/7j4muJT6bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RfYNqgPETrmj9wQhw0p7s4ekpNhfas1oCMFLcr2VCoqd0v4eStsb6yxZJ5Qsw5BD2
	 mltZchbKqzXyLn5vxfwQDH5nkAnDt+byWQOPzOKCcnKyO2jv1VuS8bKICqejNu479H
	 CFeTPSBKMVIDc0oQiSuIMEhThkUVoNvnu2/sKc20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfCKTzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfCKTzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:55:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7698421741;
        Mon, 11 Mar 2019 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334120;
        bh=uuJY5hsgnonw1TO77Svvlxi6xb0Kj4kb/7j4muJT6bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2vxy0G3RBTcL0y2oxMlHLXivJ9TTAYCfU7zdtSOGGmzjpt+Q1eA3GFTgbPrmtxMX
         mycuVLx8HFfLSSpQDjoEvdRYC3Vd/BSvoxeVUGT+jEe93D9HQvRHHPTAR6d1hMBe9Y
         VWuMvzjkAEHPzhyYwTmp+xgjVDnzX73YEVp6iiqw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 03/52] drm/imx: imx-ldb: add missing of_node_puts
Date:   Mon, 11 Mar 2019 15:54:27 -0400
Message-Id: <20190311195516.137772-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit aa3312012f103f91f123600bbf768b11c8f431bc ]

The device node iterators perform an of_node_get on each
iteration, so a jump out of the loop requires an of_node_put.

Move the initialization channel->child = child; down to just
before the call to imx_ldb_register so that intervening failures
don't need to clear it.  Add a label at the end of the function to
do all the of_node_puts.

The semantic patch that finds part of this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
(
   return child;
|
*  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/imx-ldb.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index 3bd0f8a18e74..42daa5c9ff8e 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -651,8 +651,10 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		int bus_format;
 
 		ret = of_property_read_u32(child, "reg", &i);
-		if (ret || i < 0 || i > 1)
-			return -EINVAL;
+		if (ret || i < 0 || i > 1) {
+			ret = -EINVAL;
+			goto free_child;
+		}
 
 		if (!of_device_is_available(child))
 			continue;
@@ -665,7 +667,6 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		channel = &imx_ldb->channel[i];
 		channel->ldb = imx_ldb;
 		channel->chno = i;
-		channel->child = child;
 
 		/*
 		 * The output port is port@4 with an external 4-port mux or
@@ -675,13 +676,13 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 						  imx_ldb->lvds_mux ? 4 : 2, 0,
 						  &channel->panel, &channel->bridge);
 		if (ret && ret != -ENODEV)
-			return ret;
+			goto free_child;
 
 		/* panel ddc only if there is no bridge */
 		if (!channel->bridge) {
 			ret = imx_ldb_panel_ddc(dev, channel, child);
 			if (ret)
-				return ret;
+				goto free_child;
 		}
 
 		bus_format = of_get_bus_format(dev, child);
@@ -697,18 +698,26 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		if (bus_format < 0) {
 			dev_err(dev, "could not determine data mapping: %d\n",
 				bus_format);
-			return bus_format;
+			ret = bus_format;
+			goto free_child;
 		}
 		channel->bus_format = bus_format;
+		channel->child = child;
 
 		ret = imx_ldb_register(drm, channel);
-		if (ret)
-			return ret;
+		if (ret) {
+			channel->child = NULL;
+			goto free_child;
+		}
 	}
 
 	dev_set_drvdata(dev, imx_ldb);
 
 	return 0;
+
+free_child:
+	of_node_put(child);
+	return ret;
 }
 
 static void imx_ldb_unbind(struct device *dev, struct device *master,
-- 
2.19.1

