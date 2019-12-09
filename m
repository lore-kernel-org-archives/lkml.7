Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D2AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F91206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575868585;
	bh=2HUa/vY3ulKUf2lVowtjfAKpUaXpkNrfavp20mOhY/c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xq5QAJDBa/t6UuvhjKedabK1RMOgpWuIwumBUpNEW0WaKWq+UUsrx10LDZmQ3itSb
	 pA6dNq6ClAYx71JyQxcVrl9OLn4QSp3CbgCY/T0QwAW3bbMXYH/1NVDardlwqfKmfG
	 CxA9tPyR5kTpUB92J70/BDwoMQJKc09hF1Vk9FGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfLIFQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:16:24 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:19005 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfLIFQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:16:24 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id xB95FR53012005;
        Mon, 9 Dec 2019 14:15:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com xB95FR53012005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575868528;
        bh=YUKwrQ0HNTM5/RA0jtvxUxrn3eWB5Xxa4b2uKY9dbao=;
        h=From:To:Cc:Subject:Date:From;
        b=gDedeshFSu7VE1TZH3L6Mc/zJwLLcWAC4nUfyH1+SRaTCFwOF0rphr6qHaZ5sDWsR
         6dteJukWCZYitIcH0RdDfWGC2gZVwxvjHvOg4sp8ME+yOqCaZXlTd0ANc3jQGMO0sM
         vS8mTs3PrFoK4cIFEhJ1rS3Hma9dcU1d94K1JWq//ZWx1AWXtsuyZBYHRzbS8Iay48
         kyTukskR/KlrkNZ5XZQN6KDYORqTHmLQ+XuAtZeMzQoauDswMur+PJ+fLx4NEPk/w2
         7iQ5yCP2kKWDYufFSTKqPDKfbiUynmB5yXb6DRge1r3evPDQsYbm6CVYOcMNf5XFO/
         Ho7W0mcaoXibw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: denali: error out if platform has no associated data
Date:   Mon,  9 Dec 2019 14:15:23 +0900
Message-Id: <20191209051523.21772-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

denali->ecc_caps is a mandatory parameter. If it were left unset,
nand_ecc_choose_conf() would end up with NULL pointer access.

So, every compatible must be associated with proper denali_dt_data.
If of_device_get_match_data() returns NULL, let it fail immediately.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali_dt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 8b779a899dcf..276187939689 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -118,11 +118,12 @@ static int denali_dt_probe(struct platform_device *pdev)
 	denali = &dt->controller;
 
 	data = of_device_get_match_data(dev);
-	if (data) {
-		denali->revision = data->revision;
-		denali->caps = data->caps;
-		denali->ecc_caps = data->ecc_caps;
-	}
+	if (WARN_ON(!data))
+		return -EINVAL;
+
+	denali->revision = data->revision;
+	denali->caps = data->caps;
+	denali->ecc_caps = data->ecc_caps;
 
 	denali->dev = dev;
 	denali->irq = platform_get_irq(pdev, 0);
-- 
2.17.1

