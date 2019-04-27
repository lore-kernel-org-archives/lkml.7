Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E5C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385F621537
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330164;
	bh=+c61BKSb6nmxd2DA72ofE0nJ2DQCITWN2O5hvaus1X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l6o9rbh9aI/HMvF4uAsaXAiXn94V8XIGMKNi9zou1mp0htT3kLuKJdnrOYUt/aZCA
	 Vzg56E6QOF8JLnbMTFaweb6IoUSNEMuVS5YM4zpCdz2TfRGz4ZAOwSyBjlxMY9Cbd0
	 PQ3/t/Od9iuldWDKu8YOGpI6Hpmu0bHKxlqHzIiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfD0B4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfD0BjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4ABE208CB;
        Sat, 27 Apr 2019 01:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329140;
        bh=+c61BKSb6nmxd2DA72ofE0nJ2DQCITWN2O5hvaus1X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOP74druj3qouNzwtk5Qbx7hKaBIskjtECgSLGo21HPVqVH9j5a7VPAQSqJYNfs9X
         9ZTjVItvx5Ipz/6ACvhP08wlRycJie8DBvVzuGjYDW/pDOu0KfKbgtZ0fmAYugHq9p
         qIX9u7WQvqu3PLUV5bb+QP7TQGTR0HKFvaf+biM8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 18/79] clk: meson-gxbb: round the vdec dividers to closest
Date:   Fri, 26 Apr 2019 21:37:37 -0400
Message-Id: <20190427013838.6596-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
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
index 65f2599e5243..08824b2cd142 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -2213,6 +2213,7 @@ static struct clk_regmap gxbb_vdec_1_div = {
 		.offset = HHI_VDEC_CLK_CNTL,
 		.shift = 0,
 		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vdec_1_div",
@@ -2258,6 +2259,7 @@ static struct clk_regmap gxbb_vdec_hevc_div = {
 		.offset = HHI_VDEC2_CLK_CNTL,
 		.shift = 16,
 		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vdec_hevc_div",
-- 
2.19.1

