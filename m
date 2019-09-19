Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C46EC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD8E21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930919;
	bh=5NRVbviL4hGRRTEFYHM8bP08XnwcxyDGbBIrfHxPVpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t94FaCkalDWP3TodJC4jLan/caXklEHNd9b3U/R8rdEDTUppLY7SPhEg49Zw5xzL6
	 ie4/ciS4kJ95NRjpFT1KYilS64DUOvLUwm1TdEEXBXSHwG0HkD0irl5r4p9mfEOcjy
	 VDmesfcWbiIH30lgY598DEFUcmuBo/kM9ryhT41k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393459AbfISWIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391216AbfISWIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:08:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF8321A4C;
        Thu, 19 Sep 2019 22:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930911;
        bh=5NRVbviL4hGRRTEFYHM8bP08XnwcxyDGbBIrfHxPVpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPzPfDlTSB2lmeM/Bx7HDvx7WZChnvP78cnkVyOKOopc7mhuUOscsQSdap+CrBYac
         VYfA9XTUtixAssA3TFHdviumnCsPL/wni7M1Hjo+ovuxxuQ7bTcLvaDw4McbXvnKoR
         jvYdAm6+9WlNc41wE3LwEQLodk5np9d2+gfKEti0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 059/124] drm/omap: Fix port lookup for SDI output
Date:   Fri, 20 Sep 2019 00:02:27 +0200
Message-Id: <20190919214821.145939136@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



