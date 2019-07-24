Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F017C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6830122CBB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X18Azr3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfGXMX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:23:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36230 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfGXMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:23:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so21966033plt.3;
        Wed, 24 Jul 2019 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M65x0rcjdQ+L+xMxfa4ktYvbjy7eRRieI4KAgQxJ2Bo=;
        b=X18Azr3FSYrvMf2tklpGL/Bg3aJ2xBIQDt9JQUBcx05HLo8w7qR1MvNQW7ReZlsAKO
         7yPVxgYH4v7drBG86eJ+4ivpSILcV9ILklLbO9uyrgj+W+A7P+E4SraFN45jQypXqQ3r
         8c8Pknc4LR/pN63Mf8cpPp/mTRJ7+mDPsmff0z/VoPsRLoCAEtAGWWLHSC1/SoB22rSi
         6rFh7fNYTlMJgr8i8TXdY03W6SKZNCwsjNFg6z4iue5EVVoV/fZxtslILEz83y+Zvc11
         07ElYodQKsRsyy32cTQfC48yKMxbfr4OKS1qlBWdhYG/f8jtZOEVBb+fnCg5hQchX9Mm
         CFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M65x0rcjdQ+L+xMxfa4ktYvbjy7eRRieI4KAgQxJ2Bo=;
        b=I2paR2PDkD+/gkjPfWsN348ML36rYE/WqrL5Gxn9/njTY+IOmbRaJ6hndEUGHmGOg/
         ycdb776Xk1pqnsN0UmeVy/8pHzE3n8Sh9W+DJTFDRWcUXmN+p8Pq1iehIjTz4bVR5Cv+
         S8KoIkXP8yW0euy4O0ZeDB7vExkdFcyGJZh6OcA8+x8GZQJPA+n0DFPI+yToyQ1pZCuw
         aHId3q3mNDaIYCbr9o4ihOzumlhHH7gjiTtwLrIeImwkj+kZgA2Ux91tQye2IavkuQ+o
         cmriid06KQEu1WjR7PbWfVn2Lq7WI5oTEPl2VJoBcLkiAn3repvfuhYCoSydbjfOatFn
         cOnw==
X-Gm-Message-State: APjAAAWj9GZROS6MaZol2+ObrErnKni9+vvR0MJ05gv7DnhFReIrB0Z2
        7EefPWzoH8WAPcB7YM6UhW5xhXfg834=
X-Google-Smtp-Source: APXvYqw3LHYiOOlsx6rep3pBSVg9nqey/WKzm8bvaToKW7kZWye9i/l9w0dT+8jdGO5g27bwQ42BYg==
X-Received: by 2002:a17:902:740a:: with SMTP id g10mr85999960pll.82.1563971005247;
        Wed, 24 Jul 2019 05:23:25 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id u9sm13675245pgc.5.2019.07.24.05.23.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 05:23:24 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] platform/x86: ISST: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 20:23:20 +0800
Message-Id: <20190724122320.21802-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index f7266a115a08..ad8c7c0df4d9 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -132,11 +132,9 @@ static void isst_if_remove(struct pci_dev *pdev)
 
 static int __maybe_unused isst_if_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct isst_if_device *punit_dev;
+	struct isst_if_device *punit_dev = dev_get_drvdata(device);
 	int i;
 
-	punit_dev = pci_get_drvdata(pdev);
 	for (i = 0; i < ARRAY_SIZE(punit_dev->range_0); ++i)
 		punit_dev->range_0[i] = readl(punit_dev->punit_mmio +
 						mmio_range[0].beg + 4 * i);
@@ -149,11 +147,9 @@ static int __maybe_unused isst_if_suspend(struct device *device)
 
 static int __maybe_unused isst_if_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct isst_if_device *punit_dev;
+	struct isst_if_device *punit_dev = dev_get_drvdata(device);
 	int i;
 
-	punit_dev = pci_get_drvdata(pdev);
 	for (i = 0; i < ARRAY_SIZE(punit_dev->range_0); ++i)
 		writel(punit_dev->range_0[i], punit_dev->punit_mmio +
 						mmio_range[0].beg + 4 * i);
-- 
2.20.1

