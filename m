Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50C6C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D6F2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JJaWHvYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLDIyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:54:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46512 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:54:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id a17so5414253lfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1owaEg/Q3EobHWa/P9ZQ3aJl+evoIYnoNwkMlvjjHb0=;
        b=JJaWHvYdXZXSFNCwUGxfi4nXoRwMZ0oS5UnGMK+Scpgykfyh+J9OCfct5zkEH1Zfrh
         Jvw+gAIOAu2P8Lf9SnbuNkGFSXxlGN7jTQdXmjtAVjjrgUB0fAV8i8igZe4UH+V3JoGU
         n35GOhR/+wMuetD3quEL+6+FKHQi9qtz6hzdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1owaEg/Q3EobHWa/P9ZQ3aJl+evoIYnoNwkMlvjjHb0=;
        b=hp/Gk7T2YmUfQju67qI1NcGoMIwpYxmZrwABK1KO7sX1e05CzRGHjnzLs/49nfd2GB
         rBcDPK3m8sghlqJoF400eiKq5VdKMK6tMmgS5YXnwVY1qdSBnTp1W+SEc4aXstDVZNKE
         kAVqXyvTBMwyHGDQKvnd7JciRPtSfJof/wK/3Gq267DnpLlupRi4S7x+nN9NalD+daQS
         8RKxnnXtaAojgrZ6weNP/5uDIKnb3onatgqbwavRPY6S28d8qExD1sV6JAh+y6Vy3sf/
         3DBD3RNEJb0+z1h2m2afwxPDAAb1+EdJubzHo+GaZstvvAzYYHXMQmJDJrfeDKH/5NRh
         CO7w==
X-Gm-Message-State: APjAAAU6vG06uR39wYRr+HIAOqeaBm44+3yipObb3jtkRkt4nUeZYYXZ
        vM0roaPxo+2Pd+IEpJErs/5yfQ==
X-Google-Smtp-Source: APXvYqxQBYdHB2PyobYinLvVW1nEcg1acM+FtkltLUEzE1tjT3ZHwHaWkGyZ1Oy0DQ69aYcFZH9Lpw==
X-Received: by 2002:a19:7b1a:: with SMTP id w26mr1281048lfc.17.1575449689914;
        Wed, 04 Dec 2019 00:54:49 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q25sm2732011lji.7.2019.12.04.00.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 00:54:49 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yinbo Zhu <yinbo.zhu@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add erratum A-009204 support"
Date:   Wed,  4 Dec 2019 09:54:46 +0100
Message-Id: <20191204085447.27491-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

The errata sheet for mpc8309 also mentions A-009204, so I'm not at all
opposed to having a fix for that. But it needs to be done properly
without causing a huge performance or latency impact. We should
probably just add a bit to struct sdhci_esdhc which gets initialized
in esdhc_init.

 drivers/mmc/host/sdhci-of-esdhc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 5cca3fa4610b..7f87a90bf56a 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -764,9 +764,6 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 
-	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc"))
-		mdelay(5);
-
 	if (mask & SDHCI_RESET_ALL) {
 		val = sdhci_readl(host, ESDHC_TBCTL);
 		val &= ~ESDHC_TB_EN;
-- 
2.23.0

