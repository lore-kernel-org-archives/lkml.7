Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E21ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E2C2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0uSfxw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbfJORCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:02:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40181 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388553AbfJORCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:02:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id d17so15077526lfa.7;
        Tue, 15 Oct 2019 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lHQRX/0nej0WuuBggHgivhPJMPJeSRnbCLnwWmZEkg=;
        b=I0uSfxw7E6O85wleD5CO8/aLWXAEpIhpGNZ4IdvldsuHrbgDFfGSzoJek714RHNVNA
         qDeHjnKxKWfm60TcwVnlqhLaxutweNOskPuxwG2FlJAzGZ+0PylA4s7xK98x/tbWKIc3
         LULTwzyrdRbP/r5yZiL27fEAlNzeObyJsOvDiXpKXsUom/ZmAgar/JG0hTairjr+NBU0
         ZfnFnSfqHsfYKws1oGO7TWpo/iz6zFKCP3v4bBQZ3OTEk+y4YckpL4DsifNEWRwjLKrP
         JyP9DCSrTX5Dp/l4dnotzvm1sqMuAqTgLhGqMl0hY3TJuLtfTJv+mAuVMOaQF0tOMXEp
         bZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lHQRX/0nej0WuuBggHgivhPJMPJeSRnbCLnwWmZEkg=;
        b=m5dCwSqGXfvb/7KqdOqQsDTHu6/l21wIbNg9z6F+qa7w3ioC1PP9iwNlA5SnGWbd0B
         mxo1u0W8UXUFFB34b4za+v7bnYHpBy4WHcWAKQkYDZrSezPLAM8F32lt1jTuMpT5MI+R
         18QuoigwiRKzeRgUHCD6f0YtjDOucCVZZAOVVE+J0pSByvwwcrIj9O4xuXY5H8XDhgtQ
         py8YVB2/Tp5YWXOjnRLnwuXXlPMW7crIQ1m2Y1R21OcrzDQWu7hjw2p6M/G1cm0UQJH9
         1v0+gjtAdLq24YNFB7fXdB3DTM12LvEFJhaoUxLkFdy0d7AUIQ3knYnuB/OxD2vHkr1f
         hSeQ==
X-Gm-Message-State: APjAAAWrSNAJZg2j3yyxvFp1tvxvXVhKPaSuS9aSgmHV5eRB1I5/inDl
        Q1xYRWsB2sIGxzaTQ18tC/s=
X-Google-Smtp-Source: APXvYqznpEti9qfmzCeGOL24bxtmbcLEOCVrfTdn3PE4L4pNOoxytWOTRLVSglovOOV/v40G2x1D0w==
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr22038282lfc.79.1571158918342;
        Tue, 15 Oct 2019 10:01:58 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 18/18] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Tue, 15 Oct 2019 20:00:15 +0300
Message-Id: <20191015170015.1135-19-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8f5c6a5b444c..9a2f11a780a8 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -25,6 +25,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.23.0

