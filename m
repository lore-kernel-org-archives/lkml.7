Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64236C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362CC2339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620889;
	bh=bZL5zCNcdNHk5Kj8/hfVZlyAXCY5M1AF1eWosfk3xZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W2bIHaNVlW699K3DBM9C9UvSujcVCRf/8akCjXgecYG982X6FHZj5MOtLbmePBmLm
	 ELXxEe6wgWPcZwLdP5BP9ObdMk4DdSnpmPdZ01EEsxWH4QbomAJzPLnoU5/wG94snK
	 GCaY45J+Xo6ZoU2strPOZ9JR3leGdORZwfcvFcn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbfIDSOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390392AbfIDSOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:14:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4340C22CF7;
        Wed,  4 Sep 2019 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620883;
        bh=bZL5zCNcdNHk5Kj8/hfVZlyAXCY5M1AF1eWosfk3xZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fstsv59U4H9FoVPqxK2xkvfJ1IFKQGaI8+eJbxz2hkl0KirjP+yVF7u64bq78Kyd
         ndyvmZKfoM2RrZOFg5wOwxb2iEY1H40RW0afq3daF9P251fKQvjkMlwdks6KdZuXMR
         IW74Fbr8BqdlwrrN5E0oe1gt3WNGHmkGbQo3JO1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 130/143] mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
Date:   Wed,  4 Sep 2019 19:54:33 +0200
Message-Id: <20190904175319.491925858@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7486831d7d6aebcf851f9a4bbe65080351d5c9fb ]

Implement the get_max_timeout_count() interface to set the Spredtrum SD
host controller actual maximum timeout count.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-sprd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 9d0f58a665276..1c5e6b77ca641 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -285,6 +285,12 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
 	usleep_range(300, 500);
 }
 
+static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
+{
+	/* The Spredtrum controller actual maximum timeout count is 1 << 31 */
+	return 1 << 31;
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -296,6 +302,7 @@ static struct sdhci_ops sdhci_sprd_ops = {
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
+	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
-- 
2.20.1



