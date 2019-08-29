Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376F922CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvU4rec9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfH2Br3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:47:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46870 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2Br2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:47:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so668518pgv.13;
        Wed, 28 Aug 2019 18:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGoXtAO0ftV52GZRH7pV8AYEqnIRYcSzCikRX7NepxI=;
        b=BvU4rec9mQ2H/jsLvyZftYbPBdWw8JV4F13Ey+a+isv76gZ8mKf4IQc6O3vqdaXC86
         1XzFseQZO6YHxzHn9pVoe8QTz2bAMI3nXlPWfY6fm/IdrTGMs+zINQ/BW/64z6JHjxJN
         nPzVrAQMJjoQuDipUZ8h7mBRSGlE5I0rnVjLCi3MTrahbhVDNxpFOBT9yZPfFR+cqnM1
         A4jtt5k9gnM6z4IsdBgEloO1o4ZTG6eo7PFGv1dD7IdZ8GP3bNuNXz2uErLs4mmHYJ2b
         YmRaHLacW0x5jMHOtMVy9gtlArPs+kbOo28DOk7hLjv8Q5X8jAnOzxkECqw4GhPCNwpr
         2k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGoXtAO0ftV52GZRH7pV8AYEqnIRYcSzCikRX7NepxI=;
        b=oYFqkSMjIBJngQ2HL5Zh8fbqXGOaHvPYS62YriYFHng7fzcuTMeVSPc4njnQL69izR
         WpSio/jl/LRbAicf44lTHsDRsKpz0W55t9nj0P2oi9YuxJ/0V5Wc7XTUD7wBJ3YYN2FH
         iw7zqR/zB6bAdAsNmvP3hXGpxLQuJq6bsCJzLbpcv6f9ZxauC+kq022RKCUwR/yXPrAG
         PCdJ5MBc5bw3pCDp9tY91PYxqV7E+ZM6LURbZ4+BxsOinKsJAPLR8t6qZUM6IHLtVxsT
         B66hU/7aFBDaDb9WKgDlNKIi+zpr9QQ+9jYLKGHxtoCkYtnavfD79XehavIY3Wcp/HoX
         CtpA==
X-Gm-Message-State: APjAAAU25cqe2feQZcfJ09wPKYGB2VR98oAbjdJjXwCxflX98Yu3ASwL
        ceAdQSvl+eyRb0UFogKwFDk=
X-Google-Smtp-Source: APXvYqxdXG8zDdX/WeI7C+KfUWzlvGqrK4voiDbCRBZJ2PdoJdni6lMSsuMcK4vEJRMSWZdjMylcBw==
X-Received: by 2002:a17:90a:f011:: with SMTP id bt17mr7455588pjb.42.1567043248202;
        Wed, 28 Aug 2019 18:47:28 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j10sm404548pjn.3.2019.08.28.18.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 18:47:27 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 2/5] mmc: sdhci-sprd: add get_ro hook function
Date:   Thu, 29 Aug 2019 09:46:42 +0800
Message-Id: <20190829014645.4479-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829014645.4479-1-zhang.lyra@gmail.com>
References: <20190829014645.4479-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller doesn't support write protect to sd card.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d5871865a1e9..90cb2af91159 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -374,6 +374,11 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	return 1 << 31;
 }
 
+static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
+{
+	return 0;
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -386,6 +391,7 @@ static struct sdhci_ops sdhci_sprd_ops = {
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
+	.get_ro = sdhci_sprd_get_ro,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
-- 
2.20.1

