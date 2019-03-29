Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDDBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E84F218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cFyX65t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfC2Pds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:33:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53614 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbfC2Pdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:33:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so2955253wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StsbiAbV0Vt+lXEMy/BJGmoZrMBaAxbvBsCBZl1IPto=;
        b=cFyX65t+guMxH0r6wwSuBGb7zt9F3l3OAKQIUEhzCLXzE9CP1DjsgeoNuVQfOmgQ9y
         3E/6EPaEtzmqGcEH9hfmtSE7ExYLYk9jyUkcSonbTaAG0Q3Qg/SKCR6whaIsLf2y0pe0
         p1TmqbeqhCmxnkBkINo/3nH2dQ8k+Hay49Ayh6DwhFa+fwuJtSUi7FP3LxePzFlJpRJp
         zN3NkuPjWOXkDWZzcO9QaOPs+4MMfYbXS428Oj+P3uT/N7oHtV/j215UkGowhHb6JFyn
         kgS4PwzsxbTByarKfja5OCK9EBCgaGjwGaRlp7Ex0fp55rpLgW+SU7NIFFj/Gr/Cx+ix
         CoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StsbiAbV0Vt+lXEMy/BJGmoZrMBaAxbvBsCBZl1IPto=;
        b=frcY3BmRWZrTti/qAC9tZSMnCaPAyia+urhfES47AGtHyRN9s/4BVoy4v/17EpIA2K
         DCk+qRzY5sLOGG1Gviprk1XicsHG2qpn08LFKSi9L2xdoQ5aCo+pQ+QKoXXy6245GOJt
         +SXoh2I3wx1GVGOlfEcJ1AoI2DpemmnENSEbv+5ZI+x7QpGX3uHOjj99ghZUa9P9Lg5z
         HrC9WZd8bkxkCEp+0BW+aeRo6gAn8BdqVoFdc1IfEWS9622XwSln54y2PubIQa7VmrCV
         0P6weQE2jClQhvLzIbeeMNFWrBgYWxhrJ+uKphLcuFVLnWwsU/7/fhhWVvYSEjNt0N75
         2WqA==
X-Gm-Message-State: APjAAAWXdPjmGkC8oEd58yxTnSI0t6YTRR1u53lbsmMNN1LNj9t3AoFb
        uDMWmuOgPzIQ8KGPVF8dZc0Qpw==
X-Google-Smtp-Source: APXvYqzNbjnC9hVvavPvh6hiCMbrxTVwkUIlSPcCZxicH/X9jL4cLAFyRnst0XB/BIatQc++j61sgA==
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr4275362wmt.102.1553873617383;
        Fri, 29 Mar 2019 08:33:37 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s18sm1930173wmc.41.2019.03.29.08.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 08:33:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clk: meson: axg: spread spectrum is on mpll2
Date:   Fri, 29 Mar 2019 16:33:25 +0100
Message-Id: <20190329153325.23869-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329153325.23869-1-jbrunet@baylibre.com>
References: <20190329153325.23869-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After testing, it appears that the SSEN bit controls the spread
spectrum function on MPLL2, not MPLL0.

Fixes: 78b4af312f91 ("clk: meson-axg: add clock controller drivers")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 7a8ef80e5f2c..3ddd0efc9ee0 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -469,11 +469,6 @@ static struct clk_regmap axg_mpll0_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.ssen = {
-			.reg_off = HHI_MPLL_CNTL,
-			.shift   = 25,
-			.width	 = 1,
-		},
 		.misc = {
 			.reg_off = HHI_PLL_TOP_MISC,
 			.shift   = 0,
@@ -568,6 +563,11 @@ static struct clk_regmap axg_mpll2_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
+		.ssen = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 25,
+			.width	 = 1,
+		},
 		.misc = {
 			.reg_off = HHI_PLL_TOP_MISC,
 			.shift   = 2,
-- 
2.20.1

