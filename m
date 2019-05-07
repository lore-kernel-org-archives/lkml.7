Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858E7C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571DE20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207834;
	bh=8NQddyDvhDHI0W0/+44DvOna4t2fOYlxJuDCeJ9gO48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQNtag/10K1t/TdxkLgoATbggx/dEsYNtmIcH2/NvzDOp0VMIHa3WLi0yVXZMYmuy
	 K+pgCKfLa5Qrev1SvMrTUWTj5lAujoPbVLn8MLsT7XkXLB9L5bK+/y9FHVMqJVOeiq
	 YzMbIoLsP3eKp1lfVdEWtFyljvkXI3Y/8rtyRkkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfEGFmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbfEGFmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:42:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4113A205ED;
        Tue,  7 May 2019 05:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207766;
        bh=8NQddyDvhDHI0W0/+44DvOna4t2fOYlxJuDCeJ9gO48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFg1e1WBhhj//ieFrItZTumgKFQXNlDmGsAPkJDvqYlGVzixktNwuM13jP9T5M0Xe
         2xw9mM2y4P5W1i4Ev6fXSYgu91CEDBwIFmnrNpL8xSBAlhAUq0O4008MELvV1BwObp
         eTg5NCTpEe3e+m9KO5g71B8fmi2bcejIxfGrfZ9I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Jonathan Marek <jonathan@marek.ca>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 14/14] gpu: ipu-v3: dp: fix CSC handling
Date:   Tue,  7 May 2019 01:42:16 -0400
Message-Id: <20190507054218.340-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507054218.340-1-sashal@kernel.org>
References: <20190507054218.340-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit d4fad0a426c6e26f48c9a7cdd21a7fe9c198d645 ]

Initialize the flow input colorspaces to unknown and reset to that value
when the channel gets disabled. This avoids the state getting mixed up
with a previous mode.

Also keep the CSC settings for the background flow intact when disabling
the foreground flow.

Root-caused-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-dp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-dp.c b/drivers/gpu/ipu-v3/ipu-dp.c
index 98686edbcdbb..33de3a1bac49 100644
--- a/drivers/gpu/ipu-v3/ipu-dp.c
+++ b/drivers/gpu/ipu-v3/ipu-dp.c
@@ -195,7 +195,8 @@ int ipu_dp_setup_channel(struct ipu_dp *dp,
 		ipu_dp_csc_init(flow, flow->foreground.in_cs, flow->out_cs,
 				DP_COM_CONF_CSC_DEF_BOTH);
 	} else {
-		if (flow->foreground.in_cs == flow->out_cs)
+		if (flow->foreground.in_cs == IPUV3_COLORSPACE_UNKNOWN ||
+		    flow->foreground.in_cs == flow->out_cs)
 			/*
 			 * foreground identical to output, apply color
 			 * conversion on background
@@ -261,6 +262,8 @@ void ipu_dp_disable_channel(struct ipu_dp *dp)
 	struct ipu_dp_priv *priv = flow->priv;
 	u32 reg, csc;
 
+	dp->in_cs = IPUV3_COLORSPACE_UNKNOWN;
+
 	if (!dp->foreground)
 		return;
 
@@ -268,8 +271,9 @@ void ipu_dp_disable_channel(struct ipu_dp *dp)
 
 	reg = readl(flow->base + DP_COM_CONF);
 	csc = reg & DP_COM_CONF_CSC_DEF_MASK;
-	if (csc == DP_COM_CONF_CSC_DEF_FG)
-		reg &= ~DP_COM_CONF_CSC_DEF_MASK;
+	reg &= ~DP_COM_CONF_CSC_DEF_MASK;
+	if (csc == DP_COM_CONF_CSC_DEF_BOTH || csc == DP_COM_CONF_CSC_DEF_BG)
+		reg |= DP_COM_CONF_CSC_DEF_BG;
 
 	reg &= ~DP_COM_CONF_FG_EN;
 	writel(reg, flow->base + DP_COM_CONF);
@@ -350,6 +354,8 @@ int ipu_dp_init(struct ipu_soc *ipu, struct device *dev, unsigned long base)
 	mutex_init(&priv->mutex);
 
 	for (i = 0; i < IPUV3_NUM_FLOWS; i++) {
+		priv->flow[i].background.in_cs = IPUV3_COLORSPACE_UNKNOWN;
+		priv->flow[i].foreground.in_cs = IPUV3_COLORSPACE_UNKNOWN;
 		priv->flow[i].foreground.foreground = true;
 		priv->flow[i].base = priv->base + ipu_dp_flow_base[i];
 		priv->flow[i].priv = priv;
-- 
2.20.1

