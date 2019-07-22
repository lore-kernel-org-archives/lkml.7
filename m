Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61901C76197
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3653721921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JupiVnuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfGVNSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:18:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41550 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfGVNR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:17:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so36192901wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwJfFyhhvRsina5sbst5ytafYocQofbOLZV0dXVMw8Y=;
        b=JupiVnuDy2n2aPCZgFJmLG37jMrOtH0zvxXZZQu8FgDcankNuQTwvQDYy0I5IzsJSA
         F8KruVAy701YL+AZHs5cwB0d/pqodtxmtqFzGF++S/CBkO48zLx4Xh2Oni/wMRatRfn9
         jnm+eMPB+Jqtswlu7JHM+e/gIpjJULO0sTX+hGynCJsZDxeRY52bMDx5veq+Dt5nmjDE
         udir5IJWjd+ptyx7uXEBNNdp3CXvOASNAYE28jdL0A2UblFhIuyi/bRTLh9xXgOhrU/5
         DQ9V2zBkS3YZhJrn7pmGDZOwBuU1hUGwr2fW5jQJA5ucCgRdjem/A/NVZyb1hJygiQEb
         Nu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwJfFyhhvRsina5sbst5ytafYocQofbOLZV0dXVMw8Y=;
        b=sobddXHzuelFJOqEwmMUXboo/6PdY/PMmRGdl3q5bCtiPlrGwRrpQgutLlmkRh2t1t
         1JAaM6gt/bgpGV7+2ZizVJ1L8ReB78ppQrpAWAWIhpvhIlbo+Kgn75NDjR8Dlkd/BXKd
         t7TdGQXaOu0cwbtchAPhgXpkvxV5IukH2UK+Gx2dvHI5DULXG1N+QYi8cq5Hc+li3RHa
         H/HY4z9f+ePbTanACamq+ysRIHjzpvlydtmRD3fH/e/++PPN10AkIE6LKM02SuEQxq/u
         YdgcsBF4JGBmWdvE5L418dkGfxKozk7D+JLFfyYZ/KGecQZISN5UvdWrPStU0s+HLCJm
         BNlQ==
X-Gm-Message-State: APjAAAVPXjek1oPFjfbNVhYXW23LCwE/G92NMGXIkBsplPwCLrWV9M9X
        oHgYizxPl/Wfokh3zngpBT4=
X-Google-Smtp-Source: APXvYqzqJfinGvtWGLtZwmywOZm3G950NbAUa+GIqCAGlJY4Nyl0B4GPHLntvvYmvyc3AYD8ddwjBA==
X-Received: by 2002:adf:f591:: with SMTP id f17mr60699781wro.119.1563801473928;
        Mon, 22 Jul 2019 06:17:53 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:17:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH 02/10] ARM: davinci: WARN_ON() if clk_get() fails
Date:   Mon, 22 Jul 2019 15:17:40 +0200
Message-Id: <20190722131748.30319-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722131748.30319-1-brgl@bgdev.pl>
References: <20190722131748.30319-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails. Apply this to all davinci platforms.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da830.c  | 4 ++++
 arch/arm/mach-davinci/da850.c  | 4 ++++
 arch/arm/mach-davinci/dm355.c  | 4 ++++
 arch/arm/mach-davinci/dm365.c  | 4 ++++
 arch/arm/mach-davinci/dm644x.c | 4 ++++
 arch/arm/mach-davinci/dm646x.c | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index e6b8ffd934a1..220e99438ae0 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -751,6 +751,10 @@ void __init da830_init_time(void)
 	da830_pll_init(NULL, pll, NULL);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 77bc64d6e39b..dcf3536c46bc 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -681,6 +681,10 @@ void __init da850_init_time(void)
 	da850_pll0_init(NULL, pll0, cfgchip);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index c6073326be2e..a38a3648345b 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -743,6 +743,10 @@ void __init dm355_init_time(void)
 	dm355_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2f9ae6431bf5..8062412be70f 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -784,6 +784,10 @@ void __init dm365_init_time(void)
 	dm365_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 1b9e9a6192ef..7a6b5a48cae5 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -679,6 +679,10 @@ void __init dm644x_init_time(void)
 	dm644x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 62ca952fe161..97fe533726e9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -663,6 +663,10 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	dm646x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
-- 
2.21.0

