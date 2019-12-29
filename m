Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9E7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9BC206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642315;
	bh=ct6RR3EXqXFObaq0/biByEaWsnHO72OApa+dEmxh4as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rzjkKcsO5Lqv3n8HORE2XQ08oaM7v/LwEkeF0xmYp/ReCKZNz9rHgK/i4xduWsXb5
	 GFRleKnLCL69Mz+IkeOn9x7Y/VHrbykGWnlISDZJXETHV+wIRRzX4cJ4BXkijlT6Wo
	 bESVnFNWaMeOF1mGWPobvTsFs3XUT0IYnMFHGpH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfL2R6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:58:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387537AbfL2R63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:58:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C337A206DB;
        Sun, 29 Dec 2019 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642309;
        bh=ct6RR3EXqXFObaq0/biByEaWsnHO72OApa+dEmxh4as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgCammbl1gVjsFAuYn6nH3QS+BUkiGRfpvvXj48qqQcQ/pJjc5gPScv3jD/MAFfig
         koYTR5YEQTgohA4VJS7wuCgpnQdHGTQ3+Mbc7PHoKZRjwZ7FvKIa+GSqZ3dUtgxU2L
         JHB27kTwPD2yrdPXJ3dQCIeqyrVRaJEfFfWCehrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 430/434] mmc: sdhci-of-esdhc: fix P2020 errata handling
Date:   Sun, 29 Dec 2019 18:28:03 +0100
Message-Id: <20191229172731.903253580@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>

commit fe0acab448f68c3146235afe03fb932e242ec94c upstream.

Two previous patches introduced below quirks for P2020 platforms.
- SDHCI_QUIRK_RESET_AFTER_REQUEST
- SDHCI_QUIRK_BROKEN_TIMEOUT_VAL

The patches made a mistake to add them in quirks2 of sdhci_host
structure, while they were defined for quirks.
	host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
	host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

This patch is to fix them.
	host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

Fixes: 05cb6b2a66fa ("mmc: sdhci-of-esdhc: add erratum eSDHC-A001 and A-008358 support")
Fixes: a46e42712596 ("mmc: sdhci-of-esdhc: add erratum eSDHC5 support")
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191216031842.40068-1-yangbo.lu@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-esdhc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1123,8 +1123,8 @@ static int sdhci_esdhc_probe(struct plat
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 
 	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc")) {
-		host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
-		host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+		host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 	}
 
 	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||


