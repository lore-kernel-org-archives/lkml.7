Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC0EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04499208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620240;
	bh=0COEYLHtS43U96dxMDgTc85nTybfmkoIw9mJaGzf/TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DacooNU9tq6qm8qQ8tTzi1F9kOAxWlhGegvlBzDeVRdSHhVWMxa8AduayzSFvPgDy
	 1Zye8cO1rhpW/pDPmOIMw2NrzTVpBdZ+TM3qHRZipqD2lhTJ6JkN4qRGy6jeCD1qLI
	 ORcmgQucNj2ENiXkgvSNDotYxmvMC+GKF7aTrQZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbfIDSD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389032AbfIDSD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:03:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC982339E;
        Wed,  4 Sep 2019 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620235;
        bh=0COEYLHtS43U96dxMDgTc85nTybfmkoIw9mJaGzf/TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEvlNlWOFB3yFmF9CYRyWLZ6By/VLVEdroEGSm6sILAmxliQz1lU6hr2H45LhhOCZ
         ghor8OGa5ppySFcc62hyL0r17FEcXht8VQCXR7k1Z3LvgL6Yp+Q7BFY62NKHoGED5L
         /G3SMpFJPy/jgM8jCv2OZ6kPDXNSAT4/bggF4Y64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 39/57] mmc: sdhci-of-at91: add quirk for broken HS200
Date:   Wed,  4 Sep 2019 19:54:07 +0200
Message-Id: <20190904175305.841607330@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit 7871aa60ae0086fe4626abdf5ed13eeddf306c61 upstream.

HS200 is not implemented in the driver, but the controller claims it
through caps. Remove it via a quirk, to make sure the mmc core do not try
to enable HS200, as it causes the eMMC initialization to fail.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-at91.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -364,6 +364,9 @@ static int sdhci_at91_probe(struct platf
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
+	/* HS200 is broken at this moment */
+	host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto pm_runtime_disable;


