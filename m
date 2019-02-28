Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE58C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D08220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367737;
	bh=899JCUwufzWKsD9e8vqf8oe7VFLgv2qbgeVm1d/uD0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQAY+IJpiwh2/lPw8O5yZLfnqCaXdNQL5h8Etwao7WwoFH+xpJgIRsxoHD8soKh9i
	 C3lmjD2K4/g305MkijpN0id67KzAkkE/2gRWyEIvyFUUGoH//Daw89Br00spUvazk+
	 /mlEdaXq6y/OJ8yUNtOlEZuV14grjyglr1TgIFQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbfB1PKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732666AbfB1PKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367452171F;
        Thu, 28 Feb 2019 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366649;
        bh=899JCUwufzWKsD9e8vqf8oe7VFLgv2qbgeVm1d/uD0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0qQl1PK8iz9URxG0Ru3xs13I8+oLKI4HlbyBUh2e2cKw4mtbaEd/aYyHAIppkEX3
         ekxMootWmXPA/VgGW4QDf0YIAzNYKk/JPHReXkPNOcK36vY9z2iUKGBRHeZQExkskt
         XnzPLP9ou0fojXiro3Wv1GRovUf+RIifxvK+NpAc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 72/81] drm/omap: dsi: Fix crash in DSI debug dumps
Date:   Thu, 28 Feb 2019 10:08:04 -0500
Message-Id: <20190228150813.10256-72-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 4df04ac9b37f278c48bb696289aff8f81226af4b ]

Reading any of the DSI debugfs files results in a crash, as wrong
pointer is passed to the dump functions, and the dump functions use a
wrong pointer. This patch fixes DSI debug dumps.

Fixes: f3ed97f9ae7d ("drm/omap: dsi: Simplify debugfs implementation")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190111035120.20668-3-laurent.pinchart@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 00a9c2ab9e6c8..277f9dd2ec8ca 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -1406,7 +1406,7 @@ static void dsi_pll_disable(struct dss_pll *pll)
 
 static int dsi_dump_dsi_clocks(struct seq_file *s, void *p)
 {
-	struct dsi_data *dsi = p;
+	struct dsi_data *dsi = s->private;
 	struct dss_pll_clock_info *cinfo = &dsi->pll.cinfo;
 	enum dss_clk_source dispc_clk_src, dsi_clk_src;
 	int dsi_module = dsi->module_id;
@@ -1467,7 +1467,7 @@ static int dsi_dump_dsi_clocks(struct seq_file *s, void *p)
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 static int dsi_dump_dsi_irqs(struct seq_file *s, void *p)
 {
-	struct dsi_data *dsi = p;
+	struct dsi_data *dsi = s->private;
 	unsigned long flags;
 	struct dsi_irq_stats stats;
 
@@ -1558,7 +1558,7 @@ static int dsi_dump_dsi_irqs(struct seq_file *s, void *p)
 
 static int dsi_dump_dsi_regs(struct seq_file *s, void *p)
 {
-	struct dsi_data *dsi = p;
+	struct dsi_data *dsi = s->private;
 
 	if (dsi_runtime_get(dsi))
 		return 0;
@@ -5083,15 +5083,15 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 
 	snprintf(name, sizeof(name), "dsi%u_regs", dsi->module_id + 1);
 	dsi->debugfs.regs = dss_debugfs_create_file(dss, name,
-						    dsi_dump_dsi_regs, &dsi);
+						    dsi_dump_dsi_regs, dsi);
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 	snprintf(name, sizeof(name), "dsi%u_irqs", dsi->module_id + 1);
 	dsi->debugfs.irqs = dss_debugfs_create_file(dss, name,
-						    dsi_dump_dsi_irqs, &dsi);
+						    dsi_dump_dsi_irqs, dsi);
 #endif
 	snprintf(name, sizeof(name), "dsi%u_clks", dsi->module_id + 1);
 	dsi->debugfs.clks = dss_debugfs_create_file(dss, name,
-						    dsi_dump_dsi_clocks, &dsi);
+						    dsi_dump_dsi_clocks, dsi);
 
 	return 0;
 }
-- 
2.19.1

