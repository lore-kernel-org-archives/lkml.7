Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDDEC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC1C21873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509590;
	bh=G66xy09mZodkdS9l/UgxrGZcUVk1+9P+0GLt95wlr2I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VL96K7e43wu1641GdqjWnsg3WbzTv5tRqHH9mV8u2zJ/JE8xytMZOY3zo47Msx2Bu
	 CjJzk1SCnjGa57SQf2Q9Un/bldN/YcZxlvHRtjDM1fgTmS26rZF7vsK+JmioGi9BN3
	 jE4Y93VnDS0lT+ygLbCM6xaIhJAUhnVDntoOguuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbfGSENJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389027AbfGSENH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:13:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC4F21850;
        Fri, 19 Jul 2019 04:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509586;
        bh=G66xy09mZodkdS9l/UgxrGZcUVk1+9P+0GLt95wlr2I=;
        h=From:To:Cc:Subject:Date:From;
        b=JWc4rEkQ2slZdI+sDxB2UGSxz7xHyq4/qCKgjAp0eAMULgcz+egid2cT8FZ5ouT8j
         2rv1uEqF0694eiy9RYQeercae8eVr0de0W0JVGWAS2I3xiyq2bxh1PabhO5f8HC5MF
         YtolhENrUZ+Or1M6ckJVxQJ4Ue5nNOm+Zs08XoAw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 01/45] drm/panel: simple: Fix panel_simple_dsi_probe
Date:   Fri, 19 Jul 2019 00:12:20 -0400
Message-Id: <20190719041304.18849-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 7ad9db66fafb0f0ad53fd2a66217105da5ddeffe ]

In case mipi_dsi_attach() fails remove the registered panel to avoid added
panel without corresponding device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190226081153.31334-1-peter.ujfalusi@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5b2a9f97ff04..68a2b25deb50 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1944,7 +1944,14 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
 
-	return mipi_dsi_attach(dsi);
+	err = mipi_dsi_attach(dsi);
+	if (err) {
+		struct panel_simple *panel = dev_get_drvdata(&dsi->dev);
+
+		drm_panel_remove(&panel->base);
+	}
+
+	return err;
 }
 
 static int panel_simple_dsi_remove(struct mipi_dsi_device *dsi)
-- 
2.20.1

