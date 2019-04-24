Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9730C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71E1218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126225;
	bh=mndFGD+NbQ7efly0W+gyY3LNQA2jJx4fntKFmjcS94I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rGSE4j2d9qHmgUoj/sOG8lY9Zk9j/yEfXtgkSfR63fx2pFPQDN6O3dBN5kZ9MNMCB
	 u//OoKD+QBenw4th/b9AEkVyXPtkpBoBiIGOIZ/kw6lquS9V59PnMT+88HqbIPdfni
	 XEV/AZEwdW+vVzNoEA9YKoqDH7q0W/Qux9eozpFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbfDXRRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387765AbfDXRQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:16:59 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7010E2054F;
        Wed, 24 Apr 2019 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126218;
        bh=mndFGD+NbQ7efly0W+gyY3LNQA2jJx4fntKFmjcS94I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxPfEdtnG5CmaZY65o7P34DawCfovots/84Vs7NmUTBgMc+nEnp0bunT6NHkLl1yM
         a1MsUWsHgp37wnPiKoVrr2be2AakAH7wRnrbmZ/lGD2GDg8qS9RDjgCo3ISRb+8TB6
         A0Rt9wdRKSEQSWoZEiQgT4dMHPiEkx9N2fO65WHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 032/168] mmc: omap: fix the maximum timeout setting
Date:   Wed, 24 Apr 2019 19:07:56 +0200
Message-Id: <20190424170925.615693331@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 5bcf4f45f8b4..20d422558fa3 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -921,7 +921,7 @@ static inline void set_cmd_timeout(struct mmc_omap_host *host, struct mmc_reques
 	reg &= ~(1 << 5);
 	OMAP_MMC_WRITE(host, SDIO, reg);
 	/* Set maximum timeout */
-	OMAP_MMC_WRITE(host, CTO, 0xff);
+	OMAP_MMC_WRITE(host, CTO, 0xfd);
 }
 
 static inline void set_data_timeout(struct mmc_omap_host *host, struct mmc_request *req)
-- 
2.19.1



