Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F2F21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259520;
	bh=8VO6imNKF8h6IidgpNoaPg68byfQXpDskgbyHhELRR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FAPd+44/+fCdwh3iV0fXluVawg7nObnosnT3Ud8gdjPzol3RwOWjZOfjzCfTpFMXm
	 L4goZIteQQqrmODsuwBxdIla7TUKjvTkm/UgpqrSEZz//RVa2ZElqt4TjK1giy91aq
	 lIEge+usB0GyI1VTS7m4pMhATbZ7WhpjZlaJamWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfCVM6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731904AbfCVLqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD532075E;
        Fri, 22 Mar 2019 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255183;
        bh=8VO6imNKF8h6IidgpNoaPg68byfQXpDskgbyHhELRR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJO4kMO0J4Lfck9Ek3qqzFVUYvVO68wG0UX9yn2dDbj0MUjTbUpcH9+Jy06/mmYhi
         LxCDxLF1wVm4WYXfkhorCR0qw1BAl81BNS5W5V5gnw79D+ecI0ylOeuwI0AY9Z12ie
         s/eH6KNzoEcU8fQ+/1btqSwJAOn2vm+7L0e/xe9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 012/183] drm/imx: imx-ldb: add missing of_node_puts
Date:   Fri, 22 Mar 2019 12:14:00 +0100
Message-Id: <20190322111242.675449996@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index dd5312b02a8d..4f2e6c7e04c1 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -652,8 +652,10 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
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
@@ -666,7 +668,6 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		channel = &imx_ldb->channel[i];
 		channel->ldb = imx_ldb;
 		channel->chno = i;
-		channel->child = child;
 
 		/*
 		 * The output port is port@4 with an external 4-port mux or
@@ -676,13 +677,13 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
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
@@ -698,18 +699,26 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
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



