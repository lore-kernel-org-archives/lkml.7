Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5F1C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776E42467A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575757496;
	bh=T3/4wZPL9p7tEA69OL6cyT7PPtrc6Pr84n3ts0k0Pfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMb1CefD8bMF8VGFYvl2B/GoTLUHDae+yH7Tbun9FiUciYtKSpWL/QuRjTaMFJcbk
	 ifFyVczRVYD9rnFSv1d0qv9BCBNijbA/IQIoiUBy0Xt55hhi6CxEH9Kd6bs6nGVn6k
	 C1ap00ylC6JVSGvJULp9nBbmkvRF3hIprz11BG5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfLGWYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfLGWYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:24:53 -0500
Received: from ziggy.de (unknown [95.169.229.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2722467D;
        Sat,  7 Dec 2019 22:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575757492;
        bh=T3/4wZPL9p7tEA69OL6cyT7PPtrc6Pr84n3ts0k0Pfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxXS1VAMa98HE9acicpZKn+v42FOxv/RwEn0KlvGqCpmFiXQQB+VvpdNB5J8kHNgY
         mDI3JrWQOHNThSTkpfpxL4P459FvdL1qqJs5C3u+VHcJ+bV+D/fWZiNoow7ajO+EHM
         HZ2Sg2xGCo4X8lW1mO/BssttoEDiRv2hrD4cqwH4=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@codeaurora.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, enric.balletbo@collabora.com
Cc:     sean.wang@mediatek.com, sean.wang@kernel.org,
        rdunlap@infradead.org, wens@csie.org, hsinyi@chromium.org,
        frank-w@public-files.de, drinkcat@chromium.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, mbrugger@suse.com
Subject: [PATCH v6 05/12] media: mtk-mdp: Check return value of of_clk_get
Date:   Sat,  7 Dec 2019 23:23:42 +0100
Message-Id: <20191207222349.23161-6-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191207222349.23161-1-matthias.bgg@kernel.org>
References: <20191207222349.23161-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Check the return value of of_clk_get and print an error
message if not EPROBE_DEFER.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index 9afe8161a8c0..4e2fc1337b80 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -110,6 +110,12 @@ int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
 
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		comp->clk[i] = of_clk_get(node, i);
+		if (IS_ERR(comp->clk[i])i) {
+			if (PTR_ERR(comp->clk[i] != -EPROBE_DEFER)
+					dev_err(dev, "Failed to get clock\n");
+
+			return PTR_ERR(comp->clk[i]);
+		}
 
 		/* Only RDMA needs two clocks */
 		if (comp->type != MTK_MDP_RDMA)
-- 
2.24.0

