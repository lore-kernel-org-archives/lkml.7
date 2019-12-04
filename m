Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EE6C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD182073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b7NmR+qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfLDUES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:04:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38046 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfLDUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:04:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so173941pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELTAmH9zkiQxFiFkiHdPx6vGU7gbG/ie/I1ns5+Qwf0=;
        b=b7NmR+qF+vnxWm4yIdm9VpajCEJKepEQB55cnHNpOMHIokAoPr34EBknlvq7Rx4SIX
         HzzkF1H2mla69oKJZOjib3KdC1hLFVpPt6/JB3wIyoX+7CcRy7GXBX2cIo7YYAbL4QIm
         SkECYLq/nhBcSmvVpJtYpE5Y67vz0aRAWHz14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELTAmH9zkiQxFiFkiHdPx6vGU7gbG/ie/I1ns5+Qwf0=;
        b=sqo/Nb2/a3Hz8a8LTxCQFotdzP+E6nlEiiedeH274XZFn+U2KWdA4vgHSr+6ZkcG5b
         9rjIsJJeODL6D5SMjgWsHPYw50Nl50nCQqQKYKEQbRD2affnAf+Ufn8Xhb3+5xWg34dH
         4RvG0zL/CrNB69GHNplVp0uRNJpD0i6yyR8v9q5VFtf5P26UH+fmfv/pGqXDLziT5bO7
         G8aXfNJ6e5lE8K8sRElXArlbVvaI0qAMBTOAsAkfQtXZLztOb5P1g3IXcjPrnlthNZiX
         IVjDMEYaRYrOZBTs3MZDh6NFP0t+/bzoJCXI285GSk81xIllI3s2FeJb8q+TIcDm5jg3
         Mecw==
X-Gm-Message-State: APjAAAV9QshuqIiEq0W5SSGDFh02lMSYXX29QzQt/EHQN/kujgoSgHwX
        e2gV2HmK1oBexV0OZSzbPVfV/w==
X-Google-Smtp-Source: APXvYqyvlVyp3wP4RGPm+o/Ndrxy5XeKmjPozpw3mhNrwwRc7fTWujDUcpkjGLkMlZTIn4J60g5EhA==
X-Received: by 2002:a17:90a:366e:: with SMTP id s101mr5231134pjb.18.1575489857123;
        Wed, 04 Dec 2019 12:04:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z23sm8423636pgj.43.2019.12.04.12.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 12:04:16 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] clk: qcom: gcc-sc7180: Fix setting flag for votable GDSCs
Date:   Wed,  4 Dec 2019 12:04:12 -0800
Message-Id: <20191204120341.1.I9971817e83ee890d1096c43c5a6ce6ced53d5bd3@changeid>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 17269568f7267 ("clk: qcom: Add Global Clock controller (GCC)
driver for SC7180") sets the VOTABLE flag in .pwrsts, but it needs
to be set in .flags, fix this.

Fixes: 17269568f7267 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/clk/qcom/gcc-sc7180.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index 38424e63bcae2..7f59fb8da0337 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -2186,7 +2186,8 @@ static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
 	.pd = {
 		.name = "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON | VOTABLE,
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
@@ -2194,7 +2195,8 @@ static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
 	.pd = {
 		.name = "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON | VOTABLE,
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc *gcc_sc7180_gdscs[] = {
-- 
2.24.0.393.g34dc348eaf-goog

