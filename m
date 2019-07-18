Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D5AC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EA52173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S7yNsI2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390463AbfGROGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:06:33 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:46622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727708AbfGROGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:06:32 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 03C8AC2955;
        Thu, 18 Jul 2019 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563458792; bh=v6UNc6lWngEqHMHQcuaMIXOAFhJfAEwqk3fGKGKinmU=;
        h=From:To:Cc:Subject:Date:From;
        b=S7yNsI2y/yubF+7p6A5F42g8p26e4OA1Y6mToIn0s9lyhL+ZYuHj29AYohiRQy/Wk
         eMiOHJyS4CNd2aRbrsEPkV6XTd7+w6dqRXp0IR8pSTAeYkthcGFWTpCCiGrK/gCWp6
         t61HtxsINfAtnBS3al6jieXscvGSl0b1di+Nt7JMdtOFDEDxlzvFYPLTNS2G+kupT4
         RyKK/m+QFidkp/gweb7hsznweWgme9gm6+AEafPDH6BI9myVlbDxMVF6jSDiJRDulN
         j80wqrQIoeQroLsjfk4GOI2EpqlmaM3Dc7D+imJZIS0qWrS7QaWvZZa6Db8o4o5hex
         uZwdvlB8zlxlg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9CB84A0057;
        Thu, 18 Jul 2019 14:06:27 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-mtd@lists.infradead.org, Marek Vasut <marex@denx.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] mtd: spi-nor: add support for sst26wf016b memory IC
Date:   Thu, 18 Jul 2019 17:06:23 +0300
Message-Id: <20190718140623.20862-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for the SST sst26wf016b flash memory IC.
This IC was tested with  "snps,dw-apb-ssi" SPI controller.
We don't test dual/quad reads however sst26wf016b flash's datasheet
advertises both dual and quad reads (and support of corresponding
commands)

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * drop sst26wf032 support as untested
 * add note about SPI controller used and dual/quad reads to commit
   message.

 drivers/mtd/spi-nor/spi-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 73172d7f512b..0beed856bad8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1945,6 +1945,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K) },
 	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
+	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 
 	/* ST Microelectronics -- newer production may have feature updates */
-- 
2.21.0

