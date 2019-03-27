Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C360AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93440206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713279;
	bh=ZDhQpB0ioPGHMPMBgA0cHbi3r2MKPFAktmo+AUTS5c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QRM5g8mNiAfUtX8lXu6Macon1PVaiI70Q8CD/cvPuPITVk9EoD0WS1sPzNV2P1B6C
	 t0nRqFcABvo0KbZVLenmm5hxkyjo0x0pVmRYUA/nnI6+xfBDV2UcCBO4UUZ54uD1da
	 1gpluSeO/8dtLn0fLnz0hqSONo7Ssbv9/WioOb2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbfC0TBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389613AbfC0SOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:14:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC8020449;
        Wed, 27 Mar 2019 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710460;
        bh=ZDhQpB0ioPGHMPMBgA0cHbi3r2MKPFAktmo+AUTS5c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1js0NqmKNUldpsrsbFYpOlT3Cl8op12gvQX6tOBTl/KnMHcL4mLJc7zNz/lnaFnmS
         qNSADtIshLa/4rpS2ABY7p6/XTBzdJxsdFsyDRY5DDUqzNAhavVGeaQ7pNuN3AZTr/
         MDb9zAFvBB9sZ+pJgKVsQyiMVAipNcymvCCjXU8s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 130/192] i2c: of: Try to find an I2C adapter matching the parent
Date:   Wed, 27 Mar 2019 14:09:22 -0400
Message-Id: <20190327181025.13507-130-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

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

