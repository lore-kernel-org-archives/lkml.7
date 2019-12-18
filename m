Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E002C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467B02176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thPumv5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRSoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:44:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43722 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRSoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:44:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so3281781ljm.10;
        Wed, 18 Dec 2019 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EpQ7EVQ0aGkFQjgOVCKiJvDzcZVMql3g2JOMsgEUNSU=;
        b=thPumv5fAYHTM097c7raI8dSZI+GCRYI3OeDcBVPBkoaK1tErsjgvM3h36gRZez/cW
         yO/VsIhx+dKFAb0tB4cQjr0xInTqCpnISu2rj3Xovu9SBcnum8X0/xB4g7NTVouJftgx
         jgCddhgQyNkmSrBAtA+Z6aQus//rI+AIM7VfiSOivH4IEShEIwZuc3U0/Uhf2Jc+xT83
         OeaKSn6ZxRWlXFNy3h2f+0KF/Evsax1EsujeY/5UnB4cPM1pSQcGTxoDtgDxWfMhaxlw
         AUBdhoWk4MXJDPwUH5eXxVj8EKprRMVi1594SgiVCgfV0fakjJsK4cMpXbsR0io6YGhY
         cD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EpQ7EVQ0aGkFQjgOVCKiJvDzcZVMql3g2JOMsgEUNSU=;
        b=Djj23qXzmaTE+AAm/xnWtkdcm+Lfpd3qv3ext083eN/7vPq0c4msnIkktdy4/tgWYj
         mmUDfm03advi3MgDarfMHfr7GMAua4DyqTQDJ3m6NlTriqmiaOemtwqwynW9l7djlYAT
         mjEfLqS44wxKxupL9wUfMnfqTObwxLYQtHTfYPcX8n5tbh6s+mg5jXsBkuM7rmFEGDJb
         NfXw1IljE/xaufaez62Nem8jZ13H+eVB6gcCjScGrxvu4V3S8jQerKhLF1O3bs5qRuMM
         RbNxXRyCMP8caw4Xf1ZG+QC6hWYeI3EY+ig/Pp8awOW7rXJsT1gXvvuhp6yCsATdLB86
         OEUw==
X-Gm-Message-State: APjAAAWnIYH69prc9ICrX3cSmuoG2yn+MtNF8mDth4AilqOhhy/g/hmD
        +qmmeObH88TKQER4zuUwEv8=
X-Google-Smtp-Source: APXvYqyvMaRtp4686l1Lo52cqWmm7b7M2mtvgdEr0RyPC5bN64UhVtKq8ynkLXVs5B63lyVD/CQxKg==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr2989694lji.103.1576694668005;
        Wed, 18 Dec 2019 10:44:28 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j204sm1553354lfj.38.2019.12.18.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 10:44:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND for 5.6 v1 1/3] clk: tegra: divider: Check UART's divider enable-bit state on rate's recalculation
Date:   Wed, 18 Dec 2019 21:44:05 +0300
Message-Id: <20191218184407.25790-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART clock is divided using divisor values from DLM/DLL registers when
enable-bit is unset in clk register and clk's divider configuration isn't
taken onto account in this case. This doesn't cause any problems, but
let's add a check for the divider's enable-bit state, for consistency.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-divider.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index ca0de5f11f84..38daf483ddf1 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -40,8 +40,13 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
 	int div, mul;
 	u64 rate = parent_rate;
 
-	reg = readl_relaxed(divider->reg) >> divider->shift;
-	div = reg & div_mask(divider);
+	reg = readl_relaxed(divider->reg);
+
+	if ((divider->flags & TEGRA_DIVIDER_UART) &&
+	    !(reg & PERIPH_CLK_UART_DIV_ENB))
+		return rate;
+
+	div = (reg >> divider->shift) & div_mask(divider);
 
 	mul = get_mul(divider);
 	div += mul;
-- 
2.24.0

