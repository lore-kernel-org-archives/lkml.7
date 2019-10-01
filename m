Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F6ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB7821855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJAUHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:07:06 -0400
Received: from mailoutvs11.siol.net ([185.57.226.202]:49809 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbfJAUHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:07:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 6FBE452312C;
        Tue,  1 Oct 2019 22:07:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id isMDxlO-iXu6; Tue,  1 Oct 2019 22:07:03 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 2708D52314C;
        Tue,  1 Oct 2019 22:07:03 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 7632F52312C;
        Tue,  1 Oct 2019 22:07:01 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: h6: Allow GPU to change parent rate
Date:   Tue,  1 Oct 2019 22:06:56 +0200
Message-Id: <20191001200656.730198-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPU PLL was designed with dynamic frequency switching in mind so driver
can adjust rate based on the GPU load.

Allow GPU clock to change parent rate (GPU PLL is the only possible
parent of GPU clock).

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/=
ccu-sun50i-h6.c
index d89353a3cdec..e254c06c8621 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -290,7 +290,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_=
parents, 0x670,
 				       0, 3,	/* M */
 				       24, 1,	/* mux */
 				       BIT(31),	/* gate */
-				       0);
+				       CLK_SET_RATE_PARENT);
=20
 static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
 		      0x67c, BIT(0), 0);
--=20
2.23.0

