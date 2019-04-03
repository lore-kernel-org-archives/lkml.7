Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9C82084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDCPOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:14:24 -0400
Received: from mailoutvs38.siol.net ([185.57.226.229]:52284 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726099AbfDCPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:14:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 29BA55229E9;
        Wed,  3 Apr 2019 17:14:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id z3kRh_h6lRjd; Wed,  3 Apr 2019 17:14:16 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E058B5229DF;
        Wed,  3 Apr 2019 17:14:16 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 8C9595229E9;
        Wed,  3 Apr 2019 17:14:14 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, jernej.skrabec@siol.net
Subject: [PATCH v2 2/2] clk: sunxi-ng: nkmp: Explain why zero width check is needed
Date:   Wed,  3 Apr 2019 17:14:04 +0200
Message-Id: <20190403151404.26542-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403151404.26542-1-jernej.skrabec@siol.net>
References: <20190403151404.26542-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explanation why zero width check is needed when generating factor
mask using GENMASK() macro.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nkmp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_n=
kmp.c
index 69dfc6de1c4e..cbcdf664f336 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -186,6 +186,12 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsi=
gned long rate,
=20
 	ccu_nkmp_find_best(parent_rate, rate, &_nkmp);
=20
+	/*
+	 * If width is 0, GENMASK() macro may not generate expected mask (0)
+	 * as it falls under undefined behaviour by C standard due to shifts
+	 * which are equal or greater than width of left operand. This can
+	 * be easily avoided by explicitly checking if width is 0.
+	 */
 	if (nkmp->n.width)
 		n_mask =3D GENMASK(nkmp->n.width + nkmp->n.shift - 1,
 				 nkmp->n.shift);
--=20
2.21.0

