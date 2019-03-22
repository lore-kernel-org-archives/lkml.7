Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF41D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255886;
	bh=FrCnEjrLKzm156mKOj8wr6uNfA4dJMSJA/gKvG/lXn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fl8tP+DLKII7RhgI7RTNFgazw2YdiMYsJnCbDME7Bo39iwqeh8r2vLM6jltoKO/3e
	 a3WRP8eKzs680gEwHRstSu2goWyf04SQ0DrBrTTCFuOrq6vkCdlegn/KE54fzQ2gri
	 KlMZBAH9Lg1DCPDBMfIJKdoadgoDR1WT6f719tU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfCVL6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732207AbfCVL6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614062192B;
        Fri, 22 Mar 2019 11:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255881;
        bh=FrCnEjrLKzm156mKOj8wr6uNfA4dJMSJA/gKvG/lXn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9+Acnq+NGN7ZCc6EN5f/3yOCYChI7TazcfFZ8Usi6vIcIl2iprwSR3A3qCtfm/lx
         JCWSYWKOmUZplZp7F/GUoQmz8l9fQ6ll7JoJe2mG/W2K7pWrdKb5jkvVkHsmyNLURL
         nL8SdR1z+lCwOjhC8qE1+jBgW05dziVEDXsaETS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/280] drm/imx: imx-ldb: add missing of_node_puts
Date:   Fri, 22 Mar 2019 12:12:58 +0100
Message-Id: <20190322111307.706952479@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



