Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D433521741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368724;
	bh=sYiXaetmFzKT4ZVuK2gso+n3K12dYqioNeoNFKYIuhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QF9wtXOjK1OIHx0J1sRXhvsFlB+/Bxzwh6RbAjZYJRrAALgxSLtL6U5ATQT4PgBw9
	 1Qwv8JVFlsMLeIbosbJIfx+XteSZD0OFJHYjjwOrQ3Y2FFoVrtMv/eEvSEVaoObH7T
	 z82Px9O5hNIrFyC4moKEOLA/367Z/FSHABx/8RIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfDDJFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732126AbfDDJFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8A121741;
        Thu,  4 Apr 2019 09:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368719;
        bh=sYiXaetmFzKT4ZVuK2gso+n3K12dYqioNeoNFKYIuhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgiietFjrPiB3RO2F8yyyevoYWdCPWLHtYpQLs7jgyvtA08E4amHs7eh2yW+3OWGC
         LmmRw2yk/VdxwGWpwwEAR9O65quTzCwtK8mthNl5jHTYpw0pQylQ4gFTooXIbQH68x
         ubx/YnMPQwYoW+3nYdagthPig5IzrTYsPZfKLuqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Tristan Bastian <tristan-c.bastian@gmx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 128/187] i2c: of: Try to find an I2C adapter matching the parent
Date:   Thu,  4 Apr 2019 10:47:45 +0200
Message-Id: <20190404084609.246668450@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

[ Upstream commit e814e688413aabd7b0d75e2a8ed1caa472951dec ]

If an I2C adapter doesn't match the provided device tree node, also try
matching the parent's device tree node. This allows finding an adapter
based on the device node of the parent device that was used to register
it.

This fixes a regression on Tegra124-based Chromebooks (Nyan) where the
eDP controller registers an I2C adapter that is used to read to EDID.
After commit 993a815dcbb2 ("dt-bindings: panel: Add missing .txt
suffix") this stopped working because the I2C adapter could no longer
be found. The approach in this patch fixes the regression without
introducing the issues that the above commit solved.

Fixes: 17ab7806de0c ("drm: don't link DP aux i2c adapter to the hardware device node")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Tested-by: Tristan Bastian <tristan-c.bastian@gmx.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-of.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 6cb7ad608bcd..0f01cdba9d2c 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -121,6 +121,17 @@ static int of_dev_node_match(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static int of_dev_or_parent_node_match(struct device *dev, void *data)
+{
+	if (dev->of_node == data)
+		return 1;
+
+	if (dev->parent)
+		return dev->parent->of_node == data;
+
+	return 0;
+}
+
 /* must call put_device() when done with returned i2c_client device */
 struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 {
@@ -145,7 +156,8 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 	struct device *dev;
 	struct i2c_adapter *adapter;
 
-	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
+	dev = bus_find_device(&i2c_bus_type, NULL, node,
+			      of_dev_or_parent_node_match);
 	if (!dev)
 		return NULL;
 
-- 
2.19.1



