Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE32BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9084120692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="M5xVGmXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKRNER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:04:17 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:35031 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRNER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574082255;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=ukcHuF3D4wPigrPHkkFZTsmWR0K50dSJVxn/jbjgb0w=;
        b=M5xVGmXmTsZIqx14XuCzb6iREqRCgJ3NciAiuwTg8tSKgvlUg0y2H40lK5O8gh2FTj
        jp7Ri+GsUOU1cCvyExHO1fvLYXkg9rHFTwECpRRTdOHSJM0ayXNo6Dm/5/DLb7f+J5n9
        qOSEjueBMe3X59y35s+2RaQ9pHafFabB8sOT6ZkxBlSfajRp3yMjBL1h6RJZA7P+WLaJ
        Ym+3DIbB2FPRL6ZPj8KVnR3uFRK03CvKbGd5tID8Bq21/m9LMoetOxR4BIwQ59ogdsAi
        49/NNxw5fCwpQlA4cXev3A3RpAPYaBn06d9Wieaw7p/MR8Mx+biD5B+mghJc4BY4MMP6
        tJMg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1JjWArIj7M="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id e07688vAID4Eedk
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Nov 2019 14:04:14 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] drm/mcde: dsi: Fix invalid pointer dereference if panel cannot be found
Date:   Mon, 18 Nov 2019 14:02:52 +0100
Message-Id: <20191118130252.170324-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "panel" pointer is not reset to NULL if of_drm_find_panel()
returns an error. Therefore we later assume that a panel was found,
and try to dereference the error pointer, resulting in:

    mcde-dsi a0351000.dsi: failed to find panel try bridge (4294966779)
    Unable to handle kernel paging request at virtual address fffffe03
    PC is at drm_panel_bridge_add.part.0+0x10/0x5c
    LR is at mcde_dsi_bind+0x120/0x464
    ...

Reset "panel" to NULL to avoid this problem.
Also change the format string of the error to %ld to print
the negative errors correctly. The crash above then becomes:

    mcde-dsi a0351000.dsi: failed to find panel try bridge (-517)
    mcde-dsi a0351000.dsi: no panel or bridge
    ...

Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index 03896a1f339a..eb3a855aef9a 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -924,11 +924,13 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 	for_each_available_child_of_node(dev->of_node, child) {
 		panel = of_drm_find_panel(child);
 		if (IS_ERR(panel)) {
-			dev_err(dev, "failed to find panel try bridge (%lu)\n",
+			dev_err(dev, "failed to find panel try bridge (%ld)\n",
 				PTR_ERR(panel));
+			panel = NULL;
+
 			bridge = of_drm_find_bridge(child);
 			if (IS_ERR(bridge)) {
-				dev_err(dev, "failed to find bridge (%lu)\n",
+				dev_err(dev, "failed to find bridge (%ld)\n",
 					PTR_ERR(bridge));
 				return PTR_ERR(bridge);
 			}
-- 
2.23.0

