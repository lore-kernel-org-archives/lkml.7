Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14890C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91E7214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369360;
	bh=1QFjPgMqdXg/E+tk0d9TepEzoUCaRSpt7CGPlpKt3Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bfiZkbAwMBU4HhST5SRxcDOGgC+9USRvJr22rWM+PnPIsbbmeYD3MSsaZiTqB9Skd
	 hEnyZ/xcqncaZguKszoCPsyL+IkDmqVS8YiuDheZEMzxO46oMTkjtBBQqka5EJBKlx
	 7LBaBudK4SVG9g3ufYSStTGsxkWBRa/1tLwCR1L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbfDDJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387557AbfDDJP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07122075E;
        Thu,  4 Apr 2019 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369355;
        bh=1QFjPgMqdXg/E+tk0d9TepEzoUCaRSpt7CGPlpKt3Vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0VpeJ6aoFp6r7ktfG3VbbUYtRIefnyAb97pfgjec95gX1e6jUcjPLu4s4JSBuEYH
         36VScR0a7GqiqDrcPrG7bRxsivU5mZwumEVjeAOqOL3CrnznvBLSNPl+s4i5BraiBL
         KAUVkVIl/uItIdPv5lTTaatCpA0TRIqqg0PHR054=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Tristan Bastian <tristan-c.bastian@gmx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 170/246] i2c: of: Try to find an I2C adapter matching the parent
Date:   Thu,  4 Apr 2019 10:47:50 +0200
Message-Id: <20190404084625.128642593@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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



