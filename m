Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C7CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCD72064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334863;
	bh=uRVOipWAcziKozJ3kRcBRLEnpoqHr1yw0T/FXsdIG2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bc+Gc73SHLEAEUxYvvEK/p2Rp8vOx88KgcHoTUIhou4UmuCzbhxryXxEMEizNBJXA
	 alLsZndl/G23eKgQSwN9tkOCAp4aFO3ESWPgMA7BTHl8sKFSEPP+gzYkbLcJJlJKrw
	 xWC3ANQSWI9DK6eG92WS+zpy7O+xzvDQA34uEWoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfCKUHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbfCKT51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1D3214AE;
        Mon, 11 Mar 2019 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334246;
        bh=uRVOipWAcziKozJ3kRcBRLEnpoqHr1yw0T/FXsdIG2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlk+cb42hvSopQiJNSN+8ot/VGLqE+kuKDvpJ6DfLViYV0xdLo+v9codzFP7ZLsRW
         k16Torond1zvkCDdm9a5oR+qx8Tjlq3RPzjOpl14jVV8XeqMuav0yBmPZF0jT23P3E
         F/MPQUGO/xP9zkJmJ1Suevcb+rcERBBCg6DSZiwI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yizhuo <yzhai003@ucr.edu>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/44] ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized
Date:   Mon, 11 Mar 2019 15:56:29 -0400
Message-Id: <20190311195700.138462-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yizhuo <yzhai003@ucr.edu>

[ Upstream commit dc30e70391376ba3987aeb856ae6d9c0706534f1 ]

In function omap4_dsi_mux_pads(), local variable "reg" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the later context, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 9500b6e27380..5d73f2c0b117 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -83,6 +83,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	u32 enable_mask, enable_shift;
 	u32 pipd_mask, pipd_shift;
 	u32 reg;
+	int ret;
 
 	if (dsi_id == 0) {
 		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
@@ -98,7 +99,11 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 		return -ENODEV;
 	}
 
-	regmap_read(omap4_dsi_mux_syscon, OMAP4_DSIPHY_SYSCON_OFFSET, &reg);
+	ret = regmap_read(omap4_dsi_mux_syscon,
+					  OMAP4_DSIPHY_SYSCON_OFFSET,
+					  &reg);
+	if (ret)
+		return ret;
 
 	reg &= ~enable_mask;
 	reg &= ~pipd_mask;
-- 
2.19.1

