Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652A6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFEC2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712190;
	bh=i4J60JcTR2AZDGF22aA/OXqKdTRnPaeZ853LEL+myt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1pBDXsKJ5mPbVgRACCYTDmXgXfYGhrV6yVti0Go7G8r9GHBdBeFDT4nQkimzdS39W
	 0ZNnWvTStgJo/OL2+1KWfBbG8nNAP22BEzhw5TYmQlUuAEXccGepywm8f0e3xX+9kx
	 Bl/Ev8vBgKBBcN/8mO9LUpYAYdR+8HH/UHMY6VtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbfC0SVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391196AbfC0SVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:21:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823BC20643;
        Wed, 27 Mar 2019 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710893;
        bh=i4J60JcTR2AZDGF22aA/OXqKdTRnPaeZ853LEL+myt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujTL8YN1iboUDF66HoVYQcRHfUZumBdWVOF095okmVJIP1V9U18FKQ8nIuQLDtrDz
         alNMMv/IGV5MYywxyU5GP3uRCIHJ7iew3cTLfIfVJJ4Gw2Pz5S/lMIzP3qCnB3UM3s
         b+V7z2WmdZBppxXMuibXHqc3J+v+vB6AoK8a3RuM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 31/87] mmc: omap: fix the maximum timeout setting
Date:   Wed, 27 Mar 2019 14:19:44 -0400
Message-Id: <20190327182040.17444-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit a6327b5e57fdc679c842588c3be046c0b39cc127 ]

When running OMAP1 kernel on QEMU, MMC access is annoyingly noisy:

	MMC: CTO of 0xff and 0xfe cannot be used!
	MMC: CTO of 0xff and 0xfe cannot be used!
	MMC: CTO of 0xff and 0xfe cannot be used!
	[ad inf.]

Emulator warnings appear to be valid. The TI document SPRU680 [1]
("OMAP5910 Dual-Core Processor MultiMedia Card/Secure Data Memory Card
(MMC/SD) Reference Guide") page 36 states that the maximum timeout is 253
cycles and "0xff and 0xfe cannot be used".

Fix by using 0xfd as the maximum timeout.

Tested using QEMU 2.5 (Siemens SX1 machine, OMAP310), and also checked on
real hardware using Palm TE (OMAP310), Nokia 770 (OMAP1710) and Nokia N810
(OMAP2420) that MMC works as before.

[1] http://www.ti.com/lit/ug/spru680/spru680.pdf

Fixes: 730c9b7e6630f ("[MMC] Add OMAP MMC host driver")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index a4bf14e21b5e..21dfce21aa63 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -920,7 +920,7 @@ static inline void set_cmd_timeout(struct mmc_omap_host *host, struct mmc_reques
 	reg &= ~(1 << 5);
 	OMAP_MMC_WRITE(host, SDIO, reg);
 	/* Set maximum timeout */
-	OMAP_MMC_WRITE(host, CTO, 0xff);
+	OMAP_MMC_WRITE(host, CTO, 0xfd);
 }
 
 static inline void set_data_timeout(struct mmc_omap_host *host, struct mmc_request *req)
-- 
2.19.1

