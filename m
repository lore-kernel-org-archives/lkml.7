Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF96CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41F121787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rk/TdVgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfK1QuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36605 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfK1QuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so13393170pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jY7j7XGeZ35a5OePHaCLSQ6i6f4GRHNTIE3RrACf924=;
        b=rk/TdVgoD1IwdNF/bmyE65/dESdOwICMlgGj86MG4i4pagGw7ktUvMFDE6omLZM7Am
         3FCdQsSAtE6cELEQg8ed+WrvSkgrD6+bLxTv+Ls7ZxJqFZCV5S+F2WaQ1vAjwKHOhXfU
         QiHqCQ3FWcWYfmUxBSzbRWZw5qoiQWEWdkguK0EW4tn3e7FXImtRaWK4QLPBrPLdlYIJ
         BHdEXrOzIenD/PmnpoySm4HkRnCylqayGHDdb+SMImj2Fq6AZKTY9LNSe20vG4PViqxK
         s13sdUzGfh/dhNaR6DIGF4JPCCnC+kozLTDtGz1YTPyhqEzTiDALZ+82RJY4GLlRrNQd
         xsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jY7j7XGeZ35a5OePHaCLSQ6i6f4GRHNTIE3RrACf924=;
        b=fqYopEgHYe8a02W3TvgfZuDMXnOOol5VKRNmFBKlG1jr+xWANInhxMgGXj0+fF4rGf
         7LedFMvyl1p+6/tO+DlTzUD0uiDYE9wDMBJGEkl5wWcC3iWJmdKn9bT4WnKXgwx8Q2DQ
         vZv1lQbl3y7rNCpO/TZkz3lWIekrpt9Do50RAkNTC9JFWuGTuJ3wOTOjj3WvbcKFvUtk
         Oo+rRKM6YcW1BB8tsvLn/aBBsnsNHZLbSCqUuCgr15dHrDAkEK924fCh2/K7XDaId0Fg
         d5MhV31Nbdy9JmAPq7NxFHnt0pwXioWAX7CdKcaRCW6bh8856UZvpdir3tsLA8mpoXDZ
         I1cQ==
X-Gm-Message-State: APjAAAVSLVmkH0dc94LUsBMf6XPZAOOnfIPwatHBEjTxXC0UqLk2MHHk
        rDLCCkpEBjWDDXZRDKgXaBz7wA==
X-Google-Smtp-Source: APXvYqweYzi4M9AMfmWN/j96HV08rLj6Z1utHyfK7EpXnpTX4iAGw5js/j8Q7AK1jayA/akmq+Oa7Q==
X-Received: by 2002:a65:4242:: with SMTP id d2mr12151883pgq.166.1574959813448;
        Thu, 28 Nov 2019 08:50:13 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:13 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 10/17] clk: stm32mp1: parent clocks update
Date:   Thu, 28 Nov 2019 09:49:55 -0700
Message-Id: <20191128165002.6234-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit 749c9e553e1f063eb132a78d80225532cbfedb80 upstream

Fixes parent clock for axi, fdcan, sai and adc12 clocks.

Fixes: e51d297e9a92 ("clk: stm32mp1: add Sub System clocks")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/clk/clk-stm32mp1.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 8e25ed62f67b..bf3b6a4c78d0 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -121,7 +121,7 @@ static const char * const cpu_src[] = {
 };
 
 static const char * const axi_src[] = {
-	"ck_hsi", "ck_hse", "pll2_p", "pll3_p"
+	"ck_hsi", "ck_hse", "pll2_p"
 };
 
 static const char * const per_src[] = {
@@ -225,19 +225,19 @@ static const char * const usart6_src[] = {
 };
 
 static const char * const fdcan_src[] = {
-	"ck_hse", "pll3_q", "pll4_q"
+	"ck_hse", "pll3_q", "pll4_q", "pll4_r"
 };
 
 static const char * const sai_src[] = {
-	"pll4_q", "pll3_q", "i2s_ckin", "ck_per"
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "pll3_r"
 };
 
 static const char * const sai2_src[] = {
-	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb"
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb", "pll3_r"
 };
 
 static const char * const adc12_src[] = {
-	"pll4_q", "ck_per"
+	"pll4_r", "ck_per", "pll3_q"
 };
 
 static const char * const dsi_src[] = {
-- 
2.17.1

