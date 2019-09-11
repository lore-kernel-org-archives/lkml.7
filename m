Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9CDECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD78E222BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfIKHGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:06:36 -0400
Received: from ns.omicron.at ([212.183.10.25]:38858 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfIKHGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:06:36 -0400
X-Greylist: delayed 727 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 03:06:35 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id x8B6sQJo018425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 08:54:26 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at x8B6sQJo018425
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id E29CAA006D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 08:54:25 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id DDB1DA0068
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 08:54:25 +0200 (CEST)
Received: from EXC03-ATKLA.omicron.at ([172.22.100.188])
        by MGW01-ATKLA.omicron.at  with ESMTP id x8B6sP3d030596-x8B6sP3f030596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=CAFAIL);
        Wed, 11 Sep 2019 08:54:25 +0200
Received: from buiwinne01.omicron.at (172.22.97.206) by EXC03-ATKLA.omicron.at
 (172.22.100.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 11 Sep
 2019 08:54:24 +0200
From:   Christoph Fink <christoph.fink@omicron-lab.com>
CC:     Huang Shijie <shijie8@gmail.com>, Han Xu <han.xu@nxp.com>,
        Christoph Fink <fink.christoph@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix reading support of the 1-4-4-DTR read-mode from the wrong bit of the SFDP table which is part of the linux-imx fork located in the following repo: https://source.codeaurora.org/external/imx/linux-imx/?h=imx_4.14.98_2.1.0
Date:   Wed, 11 Sep 2019 08:54:03 +0200
Message-ID: <1568184843-11300-1-git-send-email-christoph.fink@omicron-lab.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.97.206]
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Fink <fink.christoph@gmail.com>

Signed-off-by: Christoph Fink <fink.christoph@gmail.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8cc4b04..7fd52fa 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2089,7 +2089,7 @@ static const struct sfdp_bfpt_read sfdp_bfpt_reads[] = {
 	/* Fast Read 1-4-4-DTR */
 	{
 		SNOR_HWCAPS_READ_1_4_4_DTR,
-		BFPT_DWORD(1), BIT(21),	/* Supported bit */
+		BFPT_DWORD(1), BIT(19),	/* Supported bit */
 		BFPT_DWORD(3), 0,	/* Settings */
 		SNOR_PROTO_1_4_4_DTR,
 	},
-- 
2.7.4

