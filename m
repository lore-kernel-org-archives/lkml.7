Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E64C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979312173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImzuAe+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfH2LZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:25:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45584 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfH2LZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:25:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id l1so2607817lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SEXw+QRJoy/Zw++CiU1hS9QPCb+vnyFD+grq4TKD4o=;
        b=ImzuAe+lRaaytGnmLlr3YyNIlg6wvfK0gNIW92d3yyBjapIQC8UYgkKKWJ+dOn8YlQ
         PdbCEa6KjsZlie24Bp93fBjWnKXkmtIqOe9cQaj/ftpaorxjf1g8qgPS9lRxicumFXId
         IOvMxDvTxIbDUbvAKazMmNTqtKP/JOFL7Hc3z0FajnBNxWDlhRLcZwTZu3QtWZfOibOf
         yGmb/AoKeJOFVe7wKzzWQH8MvQRGM9Sbkebdem+EWPyXliHwCpBIzU5NBRfyxyK4ZCN2
         b9SUjX1UQ2crrztiaMi+GRGxV3Z1vNj1U1ikJtfLzmjYStvkEpuy9pYKQksrpmBMQ7iT
         DoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SEXw+QRJoy/Zw++CiU1hS9QPCb+vnyFD+grq4TKD4o=;
        b=kCFyiK5JjTXYPTfAcZk1rOIIj8/kPhBuJjsMvGIxlMTMFFjcYnZdgzj8kT4O5QMCFf
         Ib9/hIPSstAcia8B/WcUYgOnuVdLK/SvaVAkxYSql8trDjIxpRw/50yFF+suGBb3734k
         S2CikWOjzhjI/kAqlTiWFkQPr8VzHisdjanxtpFdnU7SQjJjq/yoFT+IHoU6EEybcynx
         hshCmwvHx3D8YkVS5uKAaOIMgsANG/aGDFP7LuY5SucPDQkrLY3N/Qaq9iW89FUe3oaJ
         Etkdq5ORpgGhiaoJpq4UbaReYia8vb2JS3E5e6Vq5QbcnbWmyZ2J5sk4EEIaY/4Lnxk0
         m1AA==
X-Gm-Message-State: APjAAAUvxTN9qHuKy0BgVM9H+7U7f4tX64+W9tsWjurSswO5ltZLqkdA
        HkrsXprHVBnLE9jHosUWEsdR7g==
X-Google-Smtp-Source: APXvYqzFEDirmqHILvceN7+977cUfB9gBF3xZthSXyM/mJOqKv36EHwY2HAn0E5PLoIqaZTMM7emXQ==
X-Received: by 2002:a2e:9a10:: with SMTP id o16mr5085094lji.104.1567077908566;
        Thu, 29 Aug 2019 04:25:08 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id d21sm350092lfc.73.2019.08.29.04.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:25:07 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] mfd: db8500-prcmu: Support the higher DB8520 ARMSS
Date:   Thu, 29 Aug 2019 13:25:01 +0200
Message-Id: <20190829112501.30185-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DB8520 used in a lot of Samsung phones has a slightly higher
maximum ARMSS frequency than the DB8500. In order to not confuse
the OPP framework and cpufreq, make sure the PRCMU driver
returns the correct frequency.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 40 +++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index a1e09bf06977..6c9905652e08 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -1692,21 +1692,41 @@ static long round_clock_rate(u8 clock, unsigned long rate)
 	return rounded_rate;
 }
 
-static const unsigned long armss_freqs[] = {
+static const unsigned long db8500_armss_freqs[] = {
 	200000000,
 	400000000,
 	800000000,
 	998400000
 };
 
+/* The DB8520 has slightly higher ARMSS max frequency */
+static const unsigned long db8520_armss_freqs[] = {
+	200000000,
+	400000000,
+	800000000,
+	1152000000
+};
+
+
+
 static long round_armss_rate(unsigned long rate)
 {
 	unsigned long freq = 0;
+	const unsigned long *freqs;
+	int nfreqs;
 	int i;
 
+	if (fw_info.version.project == PRCMU_FW_PROJECT_U8520) {
+		freqs = db8520_armss_freqs;
+		nfreqs = ARRAY_SIZE(db8520_armss_freqs);
+	} else {
+		freqs = db8500_armss_freqs;
+		nfreqs = ARRAY_SIZE(db8500_armss_freqs);
+	}
+
 	/* Find the corresponding arm opp from the cpufreq table. */
-	for (i = 0; i < ARRAY_SIZE(armss_freqs); i++) {
-		freq = armss_freqs[i];
+	for (i = 0; i < nfreqs; i++) {
+		freq = freqs[i];
 		if (rate <= freq)
 			break;
 	}
@@ -1851,11 +1871,21 @@ static int set_armss_rate(unsigned long rate)
 {
 	unsigned long freq;
 	u8 opps[] = { ARM_EXTCLK, ARM_50_OPP, ARM_100_OPP, ARM_MAX_OPP };
+	const unsigned long *freqs;
+	int nfreqs;
 	int i;
 
+	if (fw_info.version.project == PRCMU_FW_PROJECT_U8520) {
+		freqs = db8520_armss_freqs;
+		nfreqs = ARRAY_SIZE(db8520_armss_freqs);
+	} else {
+		freqs = db8500_armss_freqs;
+		nfreqs = ARRAY_SIZE(db8500_armss_freqs);
+	}
+
 	/* Find the corresponding arm opp from the cpufreq table. */
-	for (i = 0; i < ARRAY_SIZE(armss_freqs); i++) {
-		freq = armss_freqs[i];
+	for (i = 0; i < nfreqs; i++) {
+		freq = freqs[i];
 		if (rate == freq)
 			break;
 	}
-- 
2.21.0

