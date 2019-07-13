Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31681C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 12:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD982084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 12:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfGMMEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 08:04:06 -0400
Received: from mailoutvs3.siol.net ([185.57.226.194]:35176 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbfGMMEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 08:04:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id C04B8520797;
        Sat, 13 Jul 2019 14:04:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9JqdsLTKX2Ig; Sat, 13 Jul 2019 14:04:01 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 7B44B5214F8;
        Sat, 13 Jul 2019 14:04:01 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 0A2A9520797;
        Sat, 13 Jul 2019 14:03:59 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 2/3] drm/sun4i: sun8i_csc: Simplify register writes
Date:   Sat, 13 Jul 2019 14:03:45 +0200
Message-Id: <20190713120346.30349-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190713120346.30349-1-jernej.skrabec@siol.net>
References: <20190713120346.30349-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out addition of 0x200 to constant parts (+0.5) is not really
necessary. Besides, we can consider that before and fix value in CSC
matrix.

This simplifies register writes quiet a bit.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/su=
n8i_csc.c
index b8c059f1a118..e07b7876d89b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -69,7 +69,7 @@ static void sun8i_csc_set_coefficients(struct regmap *m=
ap, u32 base,
 				       enum sun8i_csc_mode mode)
 {
 	const u32 *table;
-	int i, data;
+	u32 base_reg;
=20
 	switch (mode) {
 	case SUN8I_CSC_MODE_YUV2RGB:
@@ -83,13 +83,8 @@ static void sun8i_csc_set_coefficients(struct regmap *=
map, u32 base,
 		return;
 	}
=20
-	for (i =3D 0; i < 12; i++) {
-		data =3D table[i];
-		/* For some reason, 0x200 must be added to constant parts */
-		if (((i + 1) & 3) =3D=3D 0)
-			data +=3D 0x200;
-		regmap_write(map, SUN8I_CSC_COEFF(base, i), data);
-	}
+	base_reg =3D SUN8I_CSC_COEFF(base, 0);
+	regmap_bulk_write(map, base_reg, table, 12);
 }
=20
 static void sun8i_de3_ccsc_set_coefficients(struct regmap *map, int laye=
r,
--=20
2.22.0

