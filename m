Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0761EECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAECF206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3qcTtdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfIKHVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:21:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44477 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKHVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:21:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so13082146pfn.11;
        Wed, 11 Sep 2019 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0a/Ttcv1b84BQ/BKZwWZSK7rdmYU6EM1Hc5Czp/KOEk=;
        b=V3qcTtddc3yo40buBXwwrD0vajRM89aCkIV7zLE/1wk+X29XHOD0VWcv0LPzr0ldL0
         XYrwSqHwCDDDe1MHbBhPKOUzd7L60OWuowGP1hj4tnYItXP/T0f/eTHBkIo8DzLtfxTU
         ZDMCLmWlVB5HIS3gztSzQYSaHfU0wFvskNTELiIcBs9FkXU7IB2C1FBDazdOZ/7FGXnd
         eB02OloHbFSvh24hJbOKWWAKHoUAwNkYIfrSG6LckQj50p6ATOVBq3GAI+wpF1VUkwFX
         jJsayheq92Stc9Z+ZY8EiocHsJTJ8XTNuKpTIVlIfTXvvGrJEeIzR3GLjUYWSOcz4f0t
         XfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0a/Ttcv1b84BQ/BKZwWZSK7rdmYU6EM1Hc5Czp/KOEk=;
        b=nCaLmRXkoRFiFzO+xKvbsWx4F2yWDm2Kg2dEyIlJXscvxKE1KPzsFSP04ozYZsGr57
         z73JvDK+yU+RxH1rOv1R2NLSWFGMGhGBawP4lrdGrngblAuR7A9y+HbE/Bet1cXEuVE7
         X6C/fCiwfA7DPbGJk+KXctiPVJSYgUgfIRpLwSfMRHrT1YZYd19+gevAA9hAkBiR9x1u
         8JWLqd3quV7rjClPGUb0yHYmRdp5g0bRrbkiJxpMOYtthrToLa+6AItV6KjGm6mjHJVG
         z1TD2YUjBwscZTI1lWDy64B5NuM+/zjcPMIEnHtrdy3ANKaiN7i2qx0tHkoA/js1ToIw
         EqqA==
X-Gm-Message-State: APjAAAUWjlAQgkPIqeaGo8TK6dkpTKLXWRNECI84b4HSyVFc79jZ22j1
        +6F55u7gqOgEFMyesrJ2leU=
X-Google-Smtp-Source: APXvYqxP40ELMsVal6Ho+IuzuATf3DR7IVB7v+DnFGXZBevSrxyzMEI1s2oI00WHkn5E7boogdJAqg==
X-Received: by 2002:a17:90a:890c:: with SMTP id u12mr3901328pjn.117.1568186513912;
        Wed, 11 Sep 2019 00:21:53 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id r2sm34227993pfq.60.2019.09.11.00.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:21:53 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V9 1/5] mmc: sdhci: Change timeout of loop for checking internal clock stable
Date:   Wed, 11 Sep 2019 15:22:10 +0800
Message-Id: <0c090d866e2b4cd7966672b1b6cf5667a5ce39dd.1568184581.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568184581.git.benchuanggli@gmail.com>
References: <cover.1568184581.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

According to section 3.2.1 internal clock setup in SD Host Controller
Simplified Specifications 4.20, the timeout of loop for checking
internal clock stable is defined as 150ms.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..bed0760a6c2a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
 	while (1) {
 		bool timedout = ktime_after(ktime_get(), timeout);
 
-- 
2.23.0

