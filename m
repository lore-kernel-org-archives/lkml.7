Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC449C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CC921928
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178768;
	bh=V+EsCjQI6pwEz0xG635aQChwJvmLDUEbk1VmxR03NkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0EmLouBGMRNLV9SmINkh/g/gcFGPca25GhtOTQ2u5HHrn/sPqWs70/yvJeaGdkhYS
	 P+3oalIJZrC9uysYMNXh+SCioJsVUjWC36RwE/Tv8oQC8pJypSxArEsa025RUGGLD4
	 FelJVYc8bM9aofzISWpLPy7OHbGd0QeRNIoseDRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438856AbfIVS71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438823AbfIVS7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:59:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9592184D;
        Sun, 22 Sep 2019 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178758;
        bh=V+EsCjQI6pwEz0xG635aQChwJvmLDUEbk1VmxR03NkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+YMjfm4fN81hFJbPzKWY6Qr5AzSqGu6yRXOxae84XJwj9D8mLdhn6MG8ku5X3IWM
         cjd72ra88CqaoIHEpfB+GeuvAif1/T+pjwDCgumjcL1e3dUuEg9rSwu3jnUQOqdVja
         +a4iXzV6P833Invrqcu+jD6zBkwoMFj/m/gGSVwM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 80/89] mmc: sdhci: Fix incorrect switch to HS mode
Date:   Sun, 22 Sep 2019 14:57:08 -0400
Message-Id: <20190922185717.3412-80-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

[ Upstream commit c894e33ddc1910e14d6f2a2016f60ab613fd8b37 ]

When switching from any MMC speed mode that requires 1.8v
(HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
ends up configured for SDR12 with a 50MHz clock which is an illegal
mode.

This happens because the SDHCI_CTRL_VDD_180 bit in the
SDHCI_HOST_CONTROL2 register is left set and when this bit is
set, the speed mode is controlled by the SDHCI_CTRL_UHS field
in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
because there is no UHS mode being set.

The fix is to change sdhci_set_uhs_signaling() to set the
SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
any switch to HS mode.

This was found on a new eMMC controller that does strict checking
of the speed mode and the corresponding clock rate. It caused the
switch to HS400 mode to fail because part of the sequence to switch
to HS400 requires a switch from HS200 to HS before going to HS400.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9540fda7fc6ba..3741d4c846e5e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1635,7 +1635,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
 	else if (timing == MMC_TIMING_UHS_SDR12)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-	else if (timing == MMC_TIMING_UHS_SDR25)
+	else if (timing == MMC_TIMING_SD_HS ||
+		 timing == MMC_TIMING_MMC_HS ||
+		 timing == MMC_TIMING_UHS_SDR25)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
 	else if (timing == MMC_TIMING_UHS_SDR50)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-- 
2.20.1

