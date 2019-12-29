Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A65C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846F1206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640990;
	bh=coJCxagjgyUDd+VqanPTFNqIug/xnV+LkxVnKj7/EHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cIF2zM97f65UnMNGrUcEvnoKObae0zIyLPEgOehNDp/oKijwOz8YuttolBQtXDu4L
	 Bp4tY4nicXFahahJmWXZrFXq3Sem0jWO5BDyVyWGTV8QECMGA3tMz2nQ0YpNZ4Q13j
	 Wv39h3we3oCvOlNBUtanStbyoAb1xe5mXxEWJ3Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfL2Rg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfL2Rg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:36:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8AB0206CB;
        Sun, 29 Dec 2019 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640987;
        bh=coJCxagjgyUDd+VqanPTFNqIug/xnV+LkxVnKj7/EHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=af3YbElEwEOzrAb70Irb0/BxSbdiwGtdFZ1xzLbG7hKLSl2Nu+RAEaHDGJLhEDVvk
         EZWTShZRNsM3vlhCUiFsg4T6x9QtuNj97MvaxhmgqzNUHQjavaNXQCoS/zBDuSLHwF
         01E0xQuZoRfAj6S2k8O+R2kSqmkOIbGQHrU8+nt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 214/219] mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add erratum A-009204 support"
Date:   Sun, 29 Dec 2019 18:20:16 +0100
Message-Id: <20191229162542.807700563@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 8b6dc6b2d60221e90703babbc141f063b8a07e72 upstream.

This reverts commit 5dd195522562542bc6ebe6e7bd47890d8b7ca93c.

First, the fix seems to be plain wrong, since the erratum suggests
waiting 5ms before setting setting SYSCTL[RSTD], but this msleep()
happens after the call of sdhci_reset() which is where that bit gets
set (if SDHCI_RESET_DATA is in mask).

Second, walking the whole device tree to figure out if some node has a
"fsl,p2020-esdhc" compatible string is hugely expensive - about 70 to
100 us on our mpc8309 board. Walking the device tree is done under a
raw_spin_lock, so this is obviously really bad on an -rt system, and a
waste of time on all.

In fact, since esdhc_reset() seems to get called around 100 times per
second, that mpc8309 now spends 0.8% of its time determining that
it is not a p2020. Whether those 100 calls/s are normal or due to some
other bug or misconfiguration, regularly hitting a 100 us
non-preemptible window is unacceptable.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191204085447.27491-1-linux@rasmusvillemoes.dk
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-esdhc.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -648,9 +648,6 @@ static void esdhc_reset(struct sdhci_hos
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 
-	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc"))
-		mdelay(5);
-
 	if (mask & SDHCI_RESET_ALL) {
 		val = sdhci_readl(host, ESDHC_TBCTL);
 		val &= ~ESDHC_TB_EN;


