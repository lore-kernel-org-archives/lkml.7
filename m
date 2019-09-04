Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599D3C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274402070C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612713;
	bh=5NRVbviL4hGRRTEFYHM8bP08XnwcxyDGbBIrfHxPVpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6hycyWXZwvTnZoF0uQTZrSKr7Z1YhcBYdn+pjl0SGDf8Ew2unC9iRCQWMCG49JBc
	 erMnOYH0JnDhk8XJ/D2zlVD/JBXA9kzkXYLKw9NCrVBeSUmwD7BtGkRcDCMiIt0U8U
	 6PVePuvOONpZz05Jr1DlJ+UnhRIiuFE1mWiPy/FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfIDP6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731971AbfIDP6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:58:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D5DF2339D;
        Wed,  4 Sep 2019 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612710;
        bh=5NRVbviL4hGRRTEFYHM8bP08XnwcxyDGbBIrfHxPVpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VStP4nskP7Fs+K+7OzavMEnevfPEdbIbflvMJ/r3I5PvfvM9wcEDhhSvfmUovNwfd
         5LJEs5g1fOSZaQ4L9lkT89prqMxBfbkuqC9fBqw8ZhJxVR3FTQj9pCQNdxjaqZvqdt
         feCWIMOTZMEtZkkL9+Sk4Tniooe9AVxkyJJle9Bc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 35/94] drm/omap: Fix port lookup for SDI output
Date:   Wed,  4 Sep 2019 11:56:40 -0400
Message-Id: <20190904155739.2816-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 8090f7eb318d4241625449252db2741e7703e027 ]

When refactoring port lookup for DSS outputs, commit d17eb4537a7e
("drm/omap: Factor out common init/cleanup code for output devices")
incorrectly hardcoded usage of DT port 0. This breaks operation for SDI
(which uses the DT port 1) and DPI outputs other than DPI0 (which are
not used in mainline DT sources).

Fix this by using the port number from the output omap_dss_device
of_ports field.

Fixes: d17eb4537a7e ("drm/omap: Factor out common init/cleanup code for output devices")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190821183226.13784-1-laurent.pinchart@ideasonboard.com
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index de0f882f0f7b0..14b41de44ebcd 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -4,6 +4,7 @@
  * Author: Archit Taneja <archit@ti.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -20,7 +21,8 @@ int omapdss_device_init_output(struct omap_dss_device *out)
 {
 	struct device_node *remote_node;
 
-	remote_node = of_graph_get_remote_node(out->dev->of_node, 0, 0);
+	remote_node = of_graph_get_remote_node(out->dev->of_node,
+					       ffs(out->of_ports) - 1, 0);
 	if (!remote_node) {
 		dev_dbg(out->dev, "failed to find video sink\n");
 		return 0;
-- 
2.20.1

