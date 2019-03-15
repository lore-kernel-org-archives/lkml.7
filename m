Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE336C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957632184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfCOJWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:22:52 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33107 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfCOJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:22:52 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8666C40020;
        Fri, 15 Mar 2019 09:22:49 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH] of: property: Document that of_graph_get_endpoint_by_regs needs of_node_put
Date:   Fri, 15 Mar 2019 10:22:47 +0100
Message-Id: <20190315092247.7286-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node returned by of_graph_get_endpoint_by_regs has a reference taken,
and we need to put that reference back when done with the node.

However, the documentation for that node doesn't mention it, so let's make
sure it does.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 08430031bd28..29bfc5d3b783 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -659,7 +659,7 @@ EXPORT_SYMBOL(of_graph_get_next_endpoint);
  *
  * Return: An 'endpoint' node pointer which is identified by reg and at the same
  * is the child of a port node identified by port_reg. reg and port_reg are
- * ignored when they are -1.
+ * ignored when they are -1. Use of_node_put() on the pointer when done.
  */
 struct device_node *of_graph_get_endpoint_by_regs(
 	const struct device_node *parent, int port_reg, int reg)
-- 
2.20.1

