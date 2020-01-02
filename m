Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772CEC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449D22464E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004222;
	bh=gUN+kAnWfc1ZcNtrlOl182rF7UiZMNBamdOsPlYao0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1xARTcEx5HmYKo8JcwBsoIV2xsz3Pdt2AkUlz2vptI/iodztcm28hteo4fptIsJYL
	 LXjFVYRt89jDbXVDfIc/1AT3Eo1aJ+6+CALADYL8eRLW9Jzi8Y6GYEta65GjiK3bR4
	 NK1CNZOJcTiI91k9IcawJMdKxuoraoTyXpTkc+9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgABWaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbgABWaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:30:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBB3222C3;
        Thu,  2 Jan 2020 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004214;
        bh=gUN+kAnWfc1ZcNtrlOl182rF7UiZMNBamdOsPlYao0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlSSIgn1vnH1NxDsHCQ8Cz7NkK2N9bBshOL2r7jG2yTL0vXPc7/zRxgf+KSF59R9q
         CnTgh/R6oTSYHu+rYQ9bsr1Vx39TC3QMqzA4JNGFH3yqObAJQb0d4+d1J+/EaWR9aK
         XnIDrw6ayerSyVTeyqB18xZNlH6ceqISTIfzTxgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.9 086/171] Revert "mmc: sdhci: Fix incorrect switch to HS mode"
Date:   Thu,  2 Jan 2020 23:06:57 +0100
Message-Id: <20200102220558.950964515@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

commit 07bcc411567cb96f9d1fc84fff8d387118a2920d upstream.

This reverts commit c894e33ddc1910e14d6f2a2016f60ab613fd8b37.

This commit aims to treat SD High speed and SDR25 as the same while
setting UHS Timings in HOST_CONTROL2 which leads to failures with some
SD cards in AM65x. Revert this commit.

The issue this commit was trying to fix can be implemented in a platform
specific callback instead of common sdhci code.

Cc: <stable@vger.kernel.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20191128110422.25917-1-faiz_abbas@ti.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1557,9 +1557,7 @@ void sdhci_set_uhs_signaling(struct sdhc
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
 	else if (timing == MMC_TIMING_UHS_SDR12)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-	else if (timing == MMC_TIMING_SD_HS ||
-		 timing == MMC_TIMING_MMC_HS ||
-		 timing == MMC_TIMING_UHS_SDR25)
+	else if (timing == MMC_TIMING_UHS_SDR25)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
 	else if (timing == MMC_TIMING_UHS_SDR50)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;


