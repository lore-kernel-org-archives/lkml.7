Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E3C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC8F2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329879;
	bh=IiKAiFW+hYK5C10wwntKSzHbQfUCwg+iYamz3Y4IRnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LwA4jh//C/hngy+x3FfiVjubnXjNEEC9WmPmEe8XcxM5Wzlf3QE1ZQK+MG23Gsade
	 q6xMwnCsv4rVdfYYl2/LUcExWgvHdHmhxuxqZnjjt3fjKusnkFew8IlPIaW8OIygyD
	 +KG/JONYZnJnMaQLogA1tiAQOVeFEPd7ww6pE0MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfD0BvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfD0BlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC4420873;
        Sat, 27 Apr 2019 01:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329272;
        bh=IiKAiFW+hYK5C10wwntKSzHbQfUCwg+iYamz3Y4IRnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzVkHgVZzwa0+chjW/6sCBCCwfseB2T1+0Cz81tMEBRQTRn7RybpNPVE1pORkK8eQ
         0U7/IyeRacLw7XXfxn6EONo1aeatyC8YiDYXJM7lUeUr5XNiVODMy37fxq9F7sfM23
         SoYZbX2sPm74/aUIb1/3TWZZVd19UodqswIYsMVU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/53] clk: meson-gxbb: round the vdec dividers to closest
Date:   Fri, 26 Apr 2019 21:40:10 -0400
Message-Id: <20190427014051.7522-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Jourdan <mjourdan@baylibre.com>

[ Upstream commit 9b70c697e87286ade406e6a02091757307dd4b7c ]

We want the video decoder clocks to always round to closest. While the
muxes are already using CLK_MUX_ROUND_CLOSEST, the corresponding
CLK_DIVIDER_ROUND_CLOSEST was forgotten for the dividers.

Fix this by adding the flag to the two vdec dividers.

Fixes: a565242eb9fc ("clk: meson: gxbb: add the video decoder clocks")
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20190319102537.2043-1-mjourdan@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/gxbb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 6628ffa31383..4d4f6d842c31 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1571,6 +1571,7 @@ static struct clk_regmap gxbb_vdec_1_div = {
 		.offset = HHI_VDEC_CLK_CNTL,
 		.shift = 0,
 		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vdec_1_div",
@@ -1616,6 +1617,7 @@ static struct clk_regmap gxbb_vdec_hevc_div = {
 		.offset = HHI_VDEC2_CLK_CNTL,
 		.shift = 16,
 		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vdec_hevc_div",
-- 
2.19.1

