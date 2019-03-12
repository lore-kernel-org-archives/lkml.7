Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8063DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF5E205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413686;
	bh=5kHaqUmfpLMXkY+5HePOO2XMbhU6BtfMp74J1+Gcgtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gpt3CQZrswFSizlk/iGgB//xFr35DM94hLlJIBXi9U+vYboPU3gZPzfunYtkXD1fl
	 uS/n8+TQfVxQjQ6oD6fxA6THA7JbL2Zhn5TsTgbZL8YGKFw0CrKoV9S/Gi1DK7W3y9
	 1YSq7USug6LKJVkseHqXBsuj2FF7Jgpmv8/wC9iU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfCLSBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbfCLRNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:12 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C990D2183E;
        Tue, 12 Mar 2019 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410791;
        bh=5kHaqUmfpLMXkY+5HePOO2XMbhU6BtfMp74J1+Gcgtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Q/Y3k/glKW76ls1Wk0YH72dUkH3FO3NG2+tcMtf69SCHfyDPo9O6ZzUnlsj511q/
         vRrkDh0N5dSP6tx2ZN8UMmniepG4OcntM48HybNddcs3nX7djywDEICSrHG9WGWzGC
         tqjvd1REKhAkxvhmwgdD9J85+0mYUC5g164BOh9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 136/171] drm/omap: dsi: Fix crash in DSI debug dumps
Date:   Tue, 12 Mar 2019 10:08:36 -0700
Message-Id: <20190312170359.396944642@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 00a9c2ab9e6c..277f9dd2ec8c 100644
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



