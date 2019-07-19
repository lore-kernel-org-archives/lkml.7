Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27353C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78A721851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509843;
	bh=KZoO2DbCrcXXwCkCBpTdbKSSy5QdZX/Zsz62Y1pUrSU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gt9NGQy4S4TXuedatKC9IZ0rXRcw6cAWIpeT4Xme6hF06MF+qOUast8brdLmLr6mV
	 6ff6lHA6LaChnl18Kslk/NtK29RXW8FNDcuFW3mwAzgq+gK4AocmGJcFLcUt+6+sk8
	 GTgdnyF1GBn/f3juRI4Pc/JAOoKRcctergObzIcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbfGSERV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388611AbfGSEOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:14:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9962189D;
        Fri, 19 Jul 2019 04:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509665;
        bh=KZoO2DbCrcXXwCkCBpTdbKSSy5QdZX/Zsz62Y1pUrSU=;
        h=From:To:Cc:Subject:Date:From;
        b=04Et1vEbT4Qi+G4f6gatpWw5ULyJetbGhA/McfzFU29QteyoZadAt1PpfBhoZ6eBV
         8AjIcgiktMM1tThv9p+ZJRJ+5omBQgFn5suqDB2EVM09RgGWm+zQwx3cUDQthbfuj/
         2Q1HGWI/AF8Y2NPFz63RqA6Q1XyJIbhN93JGdMn8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 01/35] drm/panel: simple: Fix panel_simple_dsi_probe
Date:   Fri, 19 Jul 2019 00:13:49 -0400
Message-Id: <20190719041423.19322-1-sashal@kernel.org>
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
index f418c002d323..ecad4d7c6cd1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1389,7 +1389,14 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
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

