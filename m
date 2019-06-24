Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7E4C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8870E213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="znbgMB7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfFXNOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34710 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbfFXNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so13895851wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwJfFyhhvRsina5sbst5ytafYocQofbOLZV0dXVMw8Y=;
        b=znbgMB7xt0WVpnamMVqZHdETd0ihHMGExjiUFxlp3G9YizldIBWaQef0fCDjATzk7M
         EVTNoxTKq+/igSlV4eX9kX+hEUS9N8gviLhbBXIMEurndfUIAME4iXOSfbPhtBWwwgFr
         Qnsv7C8vw6GwxS935vlQak9VAGoXE3F6YYw2V7fU708c7KvCjZcug4DhXWNM3YeJdnC5
         KnuUwMLAQ2J07qlSzuv+vRBoOPpso5tDyyXGui+DwMINLsYfZgxbp8Y374tnO6iDrn+C
         DVI6mIuH/FqflhIHSjw9RBPJWEA3PbGLIoN9Qz/N8xpv2uqCaF8E49mt8TprrgUYgTVK
         jp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwJfFyhhvRsina5sbst5ytafYocQofbOLZV0dXVMw8Y=;
        b=US4dCCk+ubVzo/fY1SOHNrkHIpaAp1o5TI3YNcNAldhHZw3ToMvwuNDOweWmAeGU5F
         F4mirQ3NsVUSRrTG1Z0CUcj7wgFCPiTvxXdC2lxAD4/knEeZPY0hCXMj/IQ1uwSL1IAd
         rYpIdbm028XSvtDgflyvvTwdhsX1nF4i+7GPk/Z7CjNpclVv/rD9sKD+bolLHCcvnVdT
         I5iNwUoWqwqfeMeDbGdTxbfHuro8WkG14ER/O8glZZPyp4sNe33rvp4u8y5QA6VlK1IP
         ZVdrTLchjbQHK26UqljxN3vVORt87YSntqTf7HpJYiHrF/Hw2Lyyxn2uUsQZEn1O4Y9A
         KJEA==
X-Gm-Message-State: APjAAAVIOCjXQOhe9vo4N5QV70RjfIo3mnUhicBHKJW4MssZFPSSHnDc
        IdjsHbv17C3Ce9zsVBZvtQNDIrqD3Q8=
X-Google-Smtp-Source: APXvYqz6IEyF22X4CA4PFAUz9/IJDUYISVDGCvMm/IKKad7O/BeUf/my1+zJNFPwjydPUUXwUBk4xg==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr59111958wrw.8.1561382043483;
        Mon, 24 Jun 2019 06:14:03 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/10] ARM: davinci: WARN_ON() if clk_get() fails
Date:   Mon, 24 Jun 2019 15:13:43 +0200
Message-Id: <20190624131351.3732-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624131351.3732-1-brgl@bgdev.pl>
References: <20190624131351.3732-1-brgl@bgdev.pl>
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

