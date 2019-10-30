Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B2CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C232820856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbchFVgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfJ3Vx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:53:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43461 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfJ3Vx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:53:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id s4so4354637ljj.10;
        Wed, 30 Oct 2019 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrhIzqAOKcThSWpXVPxHX0ADaa3rzHyxkRuOfbx8IPw=;
        b=YbchFVgC3wpZUXEOaMjzcmtOkpjJhy86/i2w94hoelj0CeW162PV5eSTZQkTAhGhlB
         JqQjSktlo0xAfY5Kt+dXooEoFGxXdN7bbDFGq9ez3f8ENcl2vlNjMkRL4rL3Shsq/WlC
         5pIWipHRmxfwKr/TicnFRPNmV+plo7Ni6fS0m0nLvx09gkNOMg6qMYoddymOgI4NvYmt
         SZE3O/muI+uHvUNRQk+MD/Nds/hvXJa5zzcMhi//I/k/4LwIkg8h9/b0lHZnrOSAkCX1
         kMw7Sj+cMJJVZhZj5IW/GmIytVR6CEHXEcWxzLtdGsFzX2Sf0LBiKJTlq58aHyV1Ahyq
         HOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrhIzqAOKcThSWpXVPxHX0ADaa3rzHyxkRuOfbx8IPw=;
        b=L0BhTtmSO7QWlJre6jwQWav7WhExZZKFZoLum5/hwErTKR5Z58XNYy22074u8E5C0F
         uOL2gnertT62OQAx6z1b2QDw7QIvn31m0HCyKwU/GJwo2weTow4o8JsalxLGlSOZHXJN
         YczeK1vOlido3X8fsHSVZ8qieCBSmLwgoFJz0fe8FJdqclhmT95UMaOeDzC/wLQo9wJf
         o99by3y9cwNcZoNRfBCgQYnRBNEfjcIEsQYPrg1XR32Zm5kIyPtjCHcNbmrZHbgaljCc
         StTi3iNXCWo0eeQaftebdmAlbzvQbc8cqSqKeBRfqROuv2tGGaLWZLZYN5CtZGKRCiLA
         6aLg==
X-Gm-Message-State: APjAAAX0Wwp1etrrzFp/zqL8aVskqL4a8w0jXW2bRczJdBlK3XW0vcrl
        yXUB0gKuWS+2gT8z6N4QYLc=
X-Google-Smtp-Source: APXvYqyh+MeH0kSO9RSqv+LxrHF2Z40UZrsRQJdqxel0BvA8mn/9z5tEY/vzT7dQzNkNeMQ3yU6k6g==
X-Received: by 2002:a05:651c:1b0:: with SMTP id c16mr1286453ljn.192.1572472434371;
        Wed, 30 Oct 2019 14:53:54 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id a2sm520316lfh.73.2019.10.30.14.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:53:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
Date:   Thu, 31 Oct 2019 00:53:42 +0300
Message-Id: <20191030215342.14948-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030215342.14948-1-digetx@gmail.com>
References: <20191030215342.14948-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLLX may be kept disabled if cpufreq driver selects some other clock for
CPU. In that case PLLX will be disabled later in the resume path by the
CLK driver, which also can enable PLLX if necessary by itself. Thus there
is no need to enable PLLX early during resume. Tegra114/124 CLK drivers do
not manage PLLX on resume and thus they are left untouched by this patch.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 2f9e5076d201..3caae60a75a0 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -358,7 +358,6 @@ _no_pll_iddq_exit:
 
 	pll_enable r1, r0, CLK_RESET_PLLM_BASE, CLK_RESET_PLLM_MISC
 	pll_enable r1, r0, CLK_RESET_PLLC_BASE, CLK_RESET_PLLC_MISC
-	pll_enable r1, r0, CLK_RESET_PLLX_BASE, CLK_RESET_PLLX_MISC
 
 _pll_m_c_x_done:
 	pll_enable r1, r0, CLK_RESET_PLLP_BASE, CLK_RESET_PLLP_MISC
@@ -368,8 +367,18 @@ _pll_m_c_x_done:
 	pll_locked r1, r0, CLK_RESET_PLLP_BASE
 	pll_locked r1, r0, CLK_RESET_PLLA_BASE
 	pll_locked r1, r0, CLK_RESET_PLLC_BASE
+
+	/*
+	 * CPUFreq driver could select other PLL for CPU. PLLX will be
+	 * enabled by the Tegra30 CLK driver on an as-needed basis, see
+	 * tegra30_cpu_clock_resume().
+	 */
+	cmp	r10, #TEGRA30
+	beq	_pll_m_c_x_locked
+
 	pll_locked r1, r0, CLK_RESET_PLLX_BASE
 
+_pll_m_c_x_locked:
 	mov32	r7, TEGRA_TMRUS_BASE
 	ldr	r1, [r7]
 	add	r1, r1, #LOCK_DELAY
-- 
2.23.0

