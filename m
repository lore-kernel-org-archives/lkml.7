Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF01C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77369275D5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfFCPvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53556 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfFCPvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0A715AB;
        Mon,  3 Jun 2019 08:51:06 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CD0C3F246;
        Mon,  3 Jun 2019 08:51:04 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC PATCH 05/57] drm: mipi_dsi: Use bus_find_device_by_of_node() helper
Date:   Mon,  3 Jun 2019 16:49:31 +0100
Message-Id: <1559577023-558-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_of_node() helper.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 80b7550..4c5a397 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -93,11 +93,6 @@ static struct bus_type mipi_dsi_bus_type = {
 	.pm = &mipi_dsi_device_pm_ops,
 };
 
-static int of_device_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * of_find_mipi_dsi_device_by_node() - find the MIPI DSI device matching a
  *    device tree node
@@ -110,7 +105,7 @@ struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&mipi_dsi_bus_type, NULL, np, of_device_match);
+	dev = bus_find_device_by_of_node(&mipi_dsi_bus_type, NULL, np);
 
 	return dev ? to_mipi_dsi_device(dev) : NULL;
 }
-- 
2.7.4

