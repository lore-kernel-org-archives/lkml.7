Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10770C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D642624684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pL9OgSTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfLTLeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:34:01 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36600 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLTLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:33:58 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xBKBW2Wu010984;
        Fri, 20 Dec 2019 20:32:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xBKBW2Wu010984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576841525;
        bh=WGVhzVxsVRHHV9K5PX1qsTPL9sZ/TX/2a6e9iLEFkEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pL9OgSTYihHRsBMj0HJjckEVg+6jPwcYJ1MVymxrrVFMOSwkVPwH7zMi6+cqfTCpH
         waSMA/0JLXDGt1amff3gogIeH8tQIeV5TIkhEp2veEcozWQkOyN1cDfw4CG9S9mzme
         VmWg0vxUnZMBUwaYk9yc+DBk5l32sknvf8bf3mW1erkUZix5UhNzdBni865Gv6eH/c
         sH7HiR2XHewDHs29xNJCrqoBlyd3Nc+9MS6sLcsGT3qRvd3uMmk1ax8dGPrrOuQ3Q+
         J6o0e8RgsGWUsXhszV0iZoHaqDbv4dJ/MQYhcl8JCrwjZE1oWUjazczErtLbQ09cbS
         E1FDCqDymC9iw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] mtd: rawnand: denali_dt: error out if platform has no associated data
Date:   Fri, 20 Dec 2019 20:31:51 +0900
Message-Id: <20191220113155.28177-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220113155.28177-1-yamada.masahiro@socionext.com>
References: <20191220113155.28177-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

denali->ecc_caps is a mandatory parameter. If it were left unset,
nand_ecc_choose_conf() would end up with NULL pointer access.

So, every compatible must be associated with proper denali_dt_data.
If of_device_get_match_data() returns NULL, let it fail immediately.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

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

