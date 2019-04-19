Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B80C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8403217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aza8PDw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDSWSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:18:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40514 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDSWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:18:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3132801plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pmFy/F7Y+9nJ0AHy8XDviXaJUnstsHwng/faFGXf8Ko=;
        b=Aza8PDw+bba+FVBbZ5IcJt3QhHpEhdCJye0rT2ueBDpBTtObY8A7byyPpsF8IK+f21
         l+5Yl+UKDVWSbu4vINlQCMt/ZMTmuy913V7JOu6BiydfNIlQ32WpidjWqgT/4uUVXDba
         /97k401A2Cy2Sg4mggDKBlUI9/GFr5Fv7kBrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmFy/F7Y+9nJ0AHy8XDviXaJUnstsHwng/faFGXf8Ko=;
        b=ZpDVxGe3qhn3+FxuctIybWUuzdTwDF/mqVpWp79tecyoCzy9GCQYw53WiPO9MCQ+F0
         BgNMcg+XagTPghXaxTSXoMCM3DraeDNfl9WgdU/ya47AYCdXnGSsJwTWxc8CKD2v75uS
         o8nn2XN5w6m5cu90QqYgiGYwkhsRdJeMiTTcR2mJv5DbxOAqqedjqmEXL/jgGx4UQ944
         TKqxLIR+fXZ3GSFs5aJ4Xxi9gQfndL+CE/72dtN526EeiSTJtWLhRY0UBxYWWrJ3jawh
         tWELcQ/5qyGma+qbfpqexEWoWS9nrRPvfPSuoHqgLGAy/6HXjxbnx5IzBWvA1Sq/kiFc
         kvkA==
X-Gm-Message-State: APjAAAV28FPrEr+9O162qO3qhWZTp3S78KEPNSq+LgR5mVM+xA4fydeZ
        Ez31aX5zDuwlLrHLZ+bgM3XJOA==
X-Google-Smtp-Source: APXvYqwD4Qo3e9qUi57ZVQh4GPpV+TC78quohbp4D0Vaxq2cmqU8sakD0iIm4mwYRaEvoGRpOT4Bfg==
X-Received: by 2002:a17:902:b20f:: with SMTP id t15mr6301266plr.341.1555712322413;
        Fri, 19 Apr 2019 15:18:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id a3sm8162536pfn.182.2019.04.19.15.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 15:18:41 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     mark.rutland@arm.com, Salva.Climent@arm.com,
        linux-rockchip@lists.infradead.org, sonnyrao@chromium.org,
        will.deacon@arm.com, bbatacha@arm.com, mka@chromium.org,
        robin.murphy@arm.com, heiko@sntech.de,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: errata: add support for A12/A17 errata CR711784
Date:   Fri, 19 Apr 2019 15:18:03 -0700
Message-Id: <20190419221803.99322-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190419221803.99322-1-dianders@chromium.org>
References: <20190419221803.99322-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a code for turning on chicken bit 11, which appears to avoid
a potential CPU deadlock that could occur.  The exact set of
instruction needed to trigger this errata is not totaly known but we
have a high level of confidence that the problem is fixed by setting
chicken bit 11.

All details are in http://crbug.com/711784

This erratum has no known number and thus I have tagged it CR711784
(after the Chrome OS bug number).  I have created separate A12 / A17
configs to match how the rest of the A12 / A17 errata is handled.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/Kconfig      | 18 ++++++++++++++++++
 arch/arm/mm/proc-v7.S | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4376fe74f95e..34ec9039206b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1181,6 +1181,13 @@ config ARM_ERRATA_857271
 	  hang. The workaround is expected to have a negligible performance
 	  impact.
 
+config ARM_ERRATA_CR711784_A12
+	bool "ARM errata: A12: conditional instructions can lead to a CPU hang"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for a Cortex-A12 erratum without a
+	  number. The problems are best described in https://crbug.com/711784
+
 config ARM_ERRATA_852421
 	bool "ARM errata: A17: DMB ST might fail to create order between stores"
 	depends on CPU_V7
@@ -1212,6 +1219,17 @@ config ARM_ERRATA_857272
 	  config option from the A12 erratum due to the way errata are checked
 	  for and handled.
 
+config ARM_ERRATA_CR711784_A17
+	bool "ARM errata: A17: conditional instructions can lead to a CPU hang"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for a Cortex-A17 erratum without a
+	  number. The problems are best described in https://crbug.com/711784
+	  This erratum is not known to be fixed in any A17 revision.
+	  This is identical to Cortex-A12 erratum CR711784.  It is a separate
+	  config option from the A12 erratum due to the way errata are checked
+	  for and handled.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index cd2accbab844..a5156ea734ee 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -396,6 +396,11 @@ __ca12_errata:
 	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
 	orr	r10, r10, #1 << 10		@ set bit #10
 	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+#ifdef CONFIG_ARM_ERRATA_CR711784_A12
+	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orr	r10, r10, #1 << 11		@ set bit #11
+	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 	b	__errata_finish
 
@@ -416,6 +421,11 @@ __ca17_errata:
 	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
 	orr	r10, r10, #1 << 10		@ set bit #10
 	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+#ifdef CONFIG_ARM_ERRATA_CR711784_A17
+	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orr	r10, r10, #1 << 11		@ set bit #11
+	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 	b	__errata_finish
 
-- 
2.21.0.593.g511ec345e18-goog

