Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC2FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D221C216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YS5aDbbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfEHQlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:41:04 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44770 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfEHQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:41:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id j4so16737598ywk.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pK0d0RZmUxDAg2UlpJZk6eqKP4c8MBzekwXBlQJcaEA=;
        b=YS5aDbbBHo/ZpqucQo4JmlEVicPBsSMyK91OtXe2V8t5TpyOfWVVDZcWLMQ/dv72Jf
         v62QeBR8G9/vH2qg+fbIYKlXx5sgCxG23YYKxDnUkXd6o3YISBsF+FfsL2MJqAoy1Qzy
         wBj+YvrFo99bgAxJ4s7iDmnOj9bnYrxt2dH3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pK0d0RZmUxDAg2UlpJZk6eqKP4c8MBzekwXBlQJcaEA=;
        b=EEjpRQA6sPrdfOszVFnp8TmYHRlSpUR7PeWLStExa7qemaGpZwHUL+f6ANtNqcPbjf
         e7v6wv3lFQclGt7PpZ+ofCxvMOdO/V3ugHe2xuIZMt2e8oYQkbNggtevqDk72aQSAC2+
         F6BjDb9VcvsFbcHIsdo9rLJs/EA8Pu8f9QDCIbbOli/oiG6MLxzz6Xv54mneR8rvkjyr
         lsnHrrpSyVXyWaMnboW2A7M9564p1YYgI5s/uW7kz3PdenHmCgKAxYGfR2mASrmPSciB
         FuPEZ/ECcHgKvEdZUAXBBPKJGzeetPrQjfg7lgi5lsASHHZ4oSjDdJjCLpo/QHk8Alwi
         fJBg==
X-Gm-Message-State: APjAAAXC4YjfxtSOdJY/G1je3WT9Jmheuvk38rdvtJwLP5jn+iiddmD1
        DBQU/P5ZIk3ylI997+Dkbd6u5g==
X-Google-Smtp-Source: APXvYqz9ir/Gh8NUb1ycpQcDDVHcfdkyx6GifoD6MZrbq72G+zOHknduP6n8ZVhZZ9W94OE4VgRLcg==
X-Received: by 2002:a25:4941:: with SMTP id w62mr27324493yba.360.1557333661480;
        Wed, 08 May 2019 09:41:01 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u6sm4671081ywl.71.2019.05.08.09.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:41:00 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        stable@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Wed,  8 May 2019 09:40:44 -0700
Message-Id: <20190508164044.22451-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508164044.22451-1-scott.branden@broadcom.com>
References: <20190508164044.22451-1-scott.branden@broadcom.com>
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

Cc: stable@vger.kernel.org # v4.12+
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

