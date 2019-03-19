Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D83C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E491E217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Z07DzWWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfCSOy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:54:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60346 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfCSOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553007260; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=txBGNL3WV5PLBSLwOCKqka4x+d588iuGk/YjkJGGM6U=;
        b=Z07DzWWMw60WSjcJu+9E1fnMfKEvoFHfbQHOuVCkGICEO+4A93QSM6PzeJoou5758KEgoZ
        Zyqfp2vKpkVq6NXRk+r5EnZJ3DgGdnRYTn2pJQjMB8/A+JJJGxIfQQ7nRJFEEhQHI0jDe7
        iyKKRVwcT4HFXZKGT7Mu1wKiPT7pmkA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 13/13] mtd: rawnand: ingenic: Move BBTs out of ECC area
Date:   Tue, 19 Mar 2019 15:54:03 +0100
Message-Id: <20190319145403.31627-14-paul@crapouillou.net>
In-Reply-To: <20190319145403.31627-1-paul@crapouillou.net>
References: <20190319145403.31627-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic layout for BBT markers will most likely overlap with our
ECC bytes in the OOB, so move the BBT markers outside the OOB area.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v6: New patch

 drivers/mtd/nand/raw/ingenic/ingenic_nand.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index d32d68ef0dc7..ad0c905a03ba 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
@@ -282,6 +282,13 @@ static int ingenic_nand_attach_chip(struct nand_chip *chip)
 		return -EINVAL;
 	}
 
+	/*
+	 * The generic layout for BBT markers will most likely overlap with our
+	 * ECC bytes in the OOB, so move the BBT markers outside the OOB area.
+	 */
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+
 	/* For legacy reasons we use a different layout on the qi,lb60 board. */
 	if (of_machine_is_compatible("qi,lb60"))
 		mtd_set_ooblayout(mtd, &qi_lb60_ooblayout_ops);
-- 
2.11.0

