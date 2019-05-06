Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14BFC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB452087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I8H0Zyd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfEFRBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:01:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38032 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfEFRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:01:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so7093663pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8NEZr+lKEciEtlqvodjs9s9WnuQgHUyLTCz6jchZs+U=;
        b=I8H0Zyd/6abn7dp3fZUDD5BAADvTaLKVYQyECZWLsA+qoSdkJoPxMGWvXMYSmE+/5G
         HzeDykXqLtteyK90RTj5aDi0qjBFqibsa+GjQowv7CvI4t4HoQ0B+whnCgg6mnRxPAmq
         rvEHs/YNkC5QnX8Er4iEBGvy+hpKN/5FlJYqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8NEZr+lKEciEtlqvodjs9s9WnuQgHUyLTCz6jchZs+U=;
        b=i+MUjFo7n63nUmxWCA37C+fjx/0fS6ABg0iSBS/H34igZvQ1E+9ariFBbj4rrv+hAE
         7SE/HDKp80ZELbQQBGHDh/hkfyHxAFcpeJSWublIk9hoUlYL0O7ayvxhViRLik7hbJeM
         x9PU1YQkcKV1xSjCMH5xrw1fVl4Mm8lu5EOmh9c+9e8QfOivq4MoxTkQj1kJweZ9ETOZ
         80jFDrjoTaYm1jATD33+2UPzFnfHrs1hP4cRpr4Z508JKA/ax+7JSsYsXofpQ2OI74Uv
         QzYDzba8U2ruYE96WV7twP1iFK1efQc1+WrfvBOUhrGCUO/H1Z4YFDKVnkE2rOoiPR/c
         fsGQ==
X-Gm-Message-State: APjAAAWoVtFOmFPn+c1Nq7axCxLabPuXd+aT6LAEPYlCWI7POFlWpewA
        6IsN/oljFhVwYrPDC8uQEosstg==
X-Google-Smtp-Source: APXvYqyWFjkQJYyagZNhe7lr3N8EEii7ANc4xZeB7K2J92cARdpf2QgOrjQVLq3JRa2QaZrvfBcu2Q==
X-Received: by 2002:a63:165f:: with SMTP id 31mr33584426pgw.321.1557162098028;
        Mon, 06 May 2019 10:01:38 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l23sm4555644pgh.68.2019.05.06.10.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:01:37 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Mon,  6 May 2019 10:01:15 -0700
Message-Id: <20190506170115.10840-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506170115.10840-1-scott.branden@broadcom.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trac Hoang <trac.hoang@broadcom.com>

The iproc host eMMC/SD controller hold time does not meet the
specification in the HS50 mode.  This problem can be mitigated
by disabling the HISPD bit; thus forcing the controller output
data to be driven on the falling clock edges rather than the
rising clock edges.

Fixes: f5f968f2371c ("mmc: sdhci-iproc: suppress spurious interrupt with Multiblock read")
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 9d4071c41c94..2feb4ef32035 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -220,7 +220,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
 
 static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
 	.ops = &sdhci_iproc_ops,
 };
-- 
2.17.1

