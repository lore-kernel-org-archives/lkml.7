Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE260C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989B12089E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2DIE87n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfFPXtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:49:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37703 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfFPXtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:49:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so7527013ljf.4;
        Sun, 16 Jun 2019 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+5yDRvcNIN4RUhpeH+EVFUJxnejknqZPYJEnpgH9uI=;
        b=I2DIE87nZet0GxiEsPHnRBPee2Nct6hYA0VsbLtWI2hTS2IcxmZaBMt3j1YB6KnFDW
         bL0kVcVcey+0Ce8yytXOokVz0sWLKx+OeIbhS628Tn9lHcna/r1N+bmiv3UfvGVTu38R
         veRxzSh0i1AlgBjc2UXjNKr4dCyGO8LNEegQ0ePMIE0B3tQcKnfFkd+2eol4UCQ8wlH9
         PXrGto4DAw0ub8XG79V6Ca9wa8c9BSwdCQq1VQq6hDWQXJ3X/q62Pt3nGaWOJl8qc/d1
         tN86HbJ1/70XxUo2XbCuoRMkZllAIQelK7LiRs0lCIzG4FtK1jj9fPA8C7snmyzZJme/
         gEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+5yDRvcNIN4RUhpeH+EVFUJxnejknqZPYJEnpgH9uI=;
        b=moNz9SNemn8sRar+HzMqRkknp7q65t4VVY9NBc8GNo8YrnRb17VhADtTVKaovKHJsu
         TiAjsaTWXUPCXBvu7U2sKrE93FfcF5N0bZwkIixc9IrGVvHElwVlBRq7BPu/e8GYOFmm
         LsOXtYOURNeA58FR0mMOAWab8Lg0dW7Cqo1vJOUlyvLBBipGsR0O46YS11Nou1F9V5rC
         DpJd4/10aJLZ9IDZR8V2ZTMy22+z04CwzvRyp4g0Kg4BXYVDlWu+OIhVPq47VSUKXNcn
         yxmG9P3XX+tidNDB7OFe6JfaWeQIhYsmo43aheezXsxMZpdnqRgt9bhu10aEIgnAXAHi
         plNQ==
X-Gm-Message-State: APjAAAWm4a210LYAiVVoWkrBweEMSfG4WrqwXXHQk3Seasj6hvePYz+C
        MSOlZTIKib5WSyLGG3GtRxQ=
X-Google-Smtp-Source: APXvYqzLiyi3CILtjo8tsRuB+ZrO67sNW5f+HoFMMYOB1BfFkdjvpNaEx0PNX92mlbfsJPxn9EbKow==
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr27454859ljm.180.1560728952126;
        Sun, 16 Jun 2019 16:49:12 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id w1sm2032390ljm.81.2019.06.16.16.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:49:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] clocksource/drivers/tegra: Cycles can't be 0
Date:   Mon, 17 Jun 2019 02:47:43 +0300
Message-Id: <20190616234744.8975-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum number of "cycles" is limited to 1 by
clockevents_config_and_register().

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index f6a8eb0d7322..090c85358fe8 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -54,9 +54,7 @@ static int tegra_timer_set_next_event(unsigned long cycles,
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel_relaxed(TIMER_PTV_EN |
-		       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
-		       reg_base + TIMER_PTV);
+	writel_relaxed(TIMER_PTV_EN | (cycles - 1), reg_base + TIMER_PTV);
 
 	return 0;
 }
-- 
2.22.0

