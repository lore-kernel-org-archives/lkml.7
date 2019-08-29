Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102F7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2F023403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DVoeJBCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfH2KuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:50:11 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:17272 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2KuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:50:09 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x7TAnToh013730;
        Thu, 29 Aug 2019 19:49:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x7TAnToh013730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567075773;
        bh=lYozHE89Wu43zYr2OY/wYXUHm6PW8Z5Hu122oF77ydQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVoeJBCfK1a2SJY98pTQua2p/4ENI6cD/18ReVMUkbiY1fGmE1j20A7KskiM7e887
         ZIOs6yhheiTLUdIt2Sm4idniog4XTjm2fGapOO5WtIkFLTxA1npSBXnyEpo2aFIXQK
         fyYTHLxSIqBjNTAgHoPsrjTCU6YVBeEUbQER5+2nnEhXULrokb8uk8LSE/kPKUBlZK
         rdBE4rcE35S1QyM9sISGO0SHpngpMeX0mkeOnduXERg5QKKiCr0M5UyOYxZjR9kUFY
         nwXjo/vlL/myi40n+XsikxPA8E5HRc/O2F3Upuy4/DiMja3fJUiJkr1HBLZFdthiQi
         GwCM0HYlmUvBg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Piotr Sroka <piotrs@cadence.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mmc: sdhci-cadence: override spec version
Date:   Thu, 29 Aug 2019 19:49:28 +0900
Message-Id: <20190829104928.27404-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190829104928.27404-1-yamada.masahiro@socionext.com>
References: <20190829104928.27404-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet of the IP (sd4hc) says it is compiatible with SDHCI v4,
but the spec version field in the version register is read as 2
(i.e. SDHCI_SPEC_300) based on the RTL provided by Cadence.

Socionext did not fix it up when it integrated the IP into the SoCs.
So, it is working as SDHCI v3.

It is not a real problem because there is no difference in the program
flow in sdhci.c between SDHCI_SPEC_300/400, but set the real version
just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 44139fceac24..9837214685b6 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -341,6 +341,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
+	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
 
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
@@ -370,6 +371,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
 	sdhci_enable_v4_mode(host);
+	__sdhci_read_caps(host, &version, NULL, NULL);
 
 	sdhci_get_of_property(pdev);
 
-- 
2.17.1

