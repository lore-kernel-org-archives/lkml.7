Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08B421916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255263;
	bh=Kpi/V1xl/BD3nK7qOcBfcmTIo4nwzokaFgiIyGq6AFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iylvT8ukQt2hp9G2CsbhItRwiEY/bcwcCWO/8xZRou1bjUJp96TURueIvMc6DTtcR
	 4zr31tJmYZXLl5pfvvAHD8RcmvT1lI9jJw8eG55PFZYrNZ6gYjCn9KGKWkqJfqu8wV
	 JpfsiALAjSjhLSjAu9uiSfaEcrAV6xdQPSvyk0LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfCVLrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfCVLrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE8A72075E;
        Fri, 22 Mar 2019 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255259;
        bh=Kpi/V1xl/BD3nK7qOcBfcmTIo4nwzokaFgiIyGq6AFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOOaGLBcCNcgPVLYBWlM69TsF8xPksjiB0lsgoR+PvzUzx5po6nUzjbD3K7zHNbl3
         RmAKOPqF1PFehc/tvXE8wP8V51M62uUHT96Xp52o9mfz1DOPgVDWtZH+yoLDESM0vW
         sfZPL6g+qtjP6z0mP0v9rrG+ipBmsorxG0a0cFaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yizhuo <yzhai003@ucr.edu>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 017/183] ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized
Date:   Fri, 22 Mar 2019 12:14:05 +0100
Message-Id: <20190322111243.026705146@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b3f6eb5d04a2..6e7440ef503a 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -84,6 +84,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	u32 enable_mask, enable_shift;
 	u32 pipd_mask, pipd_shift;
 	u32 reg;
+	int ret;
 
 	if (dsi_id == 0) {
 		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
@@ -99,7 +100,11 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
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



