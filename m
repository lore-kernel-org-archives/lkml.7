Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D01721916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfCUMO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:14:58 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:42486 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:14:57 -0400
Received: from localhost.localdomain (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Thu, 21 Mar 2019
 20:16:06 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/1] mtd: rawnand: meson: set oob layout ops
Date:   Thu, 21 Mar 2019 20:14:01 +0800
Message-ID: <1553170441-23448-1-git-send-email-liang.yang@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.21]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the oob layout operation to avoid no oob scheme defined for
some nand flash.

Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Signed-off-by: Liang Yang <liang.yang@amlogic.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 3e8aa71..a2154a2 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1183,6 +1183,8 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 		return -EINVAL;
 	}
 
+	mtd_set_ooblayout(mtd, &meson_ooblayout_ops);
+
 	ret = meson_nand_bch_mode(nand);
 	if (ret)
 		return -EINVAL;
-- 
1.9.1

