Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B338AC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9F6217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OAl71d2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfDSWSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:18:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45202 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDSWSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:18:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so3127526plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 15:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1sB1GoBG8jgYUqmC8R7BIjAuUM8QSOtRx/2W9R3rOk=;
        b=OAl71d2uuhHRB0be/hhOKjQWPonk8yDHaNCvHAhGIqFhy5mrexY0tRFlcAwxRXuyrC
         vEhUhFIdHv5scwPVQPSmWp8YTUunCNeVm+haVVpqktcrW/a4c4w4BEnh1r2n0tMOGLE1
         X9lr3QfmQoprME/6UDLpaecSwcGzJWG2ySbbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1sB1GoBG8jgYUqmC8R7BIjAuUM8QSOtRx/2W9R3rOk=;
        b=nIbOxPQjGdJxwz5ArLiT5Wt6hLYa/+jUYSBcB6wxg7RNQ40FM5vyrysEVxXtEPTLvX
         jIV642yzx6E8I2w9RX1JNZoUAeOHcegfRmehRWuO3j1fFjxDEcYLrqY0RoH9iYPXZoxV
         su0KqideR6/pm8QgmDa8pkM18INDfy1hbfuQnZSnT7i1ZKP61VWN8mDIWIkaPR5hoXw3
         8xUTmg0AwfrGj2Jc4Wc4uIoFcc8O0YcmScm/YKFHKuOZ0Jc+YVBCi0ynJdH7TKDefpfo
         XFS4/GLJPzlrGXsJA/UjZB/pedcMC1/QasnBjB2Be02sWX/LALCIrQ26K01EtCvZNUGB
         V2TQ==
X-Gm-Message-State: APjAAAVx3eLyqSU0vc/2RRBubIa3rog03ZFF6pEBcHfrtbAb9dLaj6Kl
        O7nwvyUiMz9KUhpRREVW5SaXgw==
X-Google-Smtp-Source: APXvYqy040/JIipaz4jkwC3Bd/TwLllG3XTi4pBeE74yt9sxtLCjQEjMOrZ5EmDGWm4GllX6yy5SGg==
X-Received: by 2002:a17:902:7043:: with SMTP id h3mr6404044plt.228.1555712321184;
        Fri, 19 Apr 2019 15:18:41 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id a3sm8162536pfn.182.2019.04.19.15.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 15:18:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     mark.rutland@arm.com, Salva.Climent@arm.com,
        linux-rockchip@lists.infradead.org, sonnyrao@chromium.org,
        will.deacon@arm.com, bbatacha@arm.com, mka@chromium.org,
        robin.murphy@arm.com, heiko@sntech.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: errata: Workaround errata A12 857271 / A17 857272
Date:   Fri, 19 Apr 2019 15:18:02 -0700
Message-Id: <20190419221803.99322-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonny Rao <sonnyrao@chromium.org>

This adds support for working around errata A12 857271 / A17 857272.
These errata were causing hangs on rk3288-based Chromebooks and it was
confirmed that this workaround fixed the problems.  In the Chrome OS
3.14 kernel [1] this erratum was known as ERRATA_FOOBAR due to lack of
an official number from ARM (though the workaround of setting chicken
bit 10 came from ARM).  In the meantime ARM came up with official
errata numbers but never published the workaround upstream.

Let's actually get the workaround landed.

[1] https://crrev.com/c/342753

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/Kconfig      | 19 +++++++++++++++++++
 arch/arm/mm/proc-v7.S | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b509cd338219..4376fe74f95e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1172,6 +1172,15 @@ config ARM_ERRATA_825619
 	  DMB NSHST or DMB ISHST instruction followed by a mix of Cacheable
 	  and Device/Strongly-Ordered loads and stores might cause deadlock
 
+config ARM_ERRATA_857271
+	bool "ARM errata: A12: CPU might deadlock under some very rare internal conditions"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 857271 Cortex-A12
+	  (all revs) erratum. Under very rare timing conditions, the CPU might
+	  hang. The workaround is expected to have a negligible performance
+	  impact.
+
 config ARM_ERRATA_852421
 	bool "ARM errata: A17: DMB ST might fail to create order between stores"
 	depends on CPU_V7
@@ -1193,6 +1202,16 @@ config ARM_ERRATA_852423
 	  config option from the A12 erratum due to the way errata are checked
 	  for and handled.
 
+config ARM_ERRATA_857272
+	bool "ARM errata: A17: CPU might deadlock under some very rare internal conditions"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 857272 Cortex-A17 erratum.
+	  This erratum is not known to be fixed in any A17 revision.
+	  This is identical to Cortex-A12 erratum 857271.  It is a separate
+	  config option from the A12 erratum due to the way errata are checked
+	  for and handled.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 339eb17c9808..cd2accbab844 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -391,6 +391,11 @@ __ca12_errata:
 	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
 	orr	r10, r10, #1 << 24		@ set bit #24
 	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+#ifdef CONFIG_ARM_ERRATA_857271
+	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orr	r10, r10, #1 << 10		@ set bit #10
+	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 	b	__errata_finish
 
@@ -406,6 +411,11 @@ __ca17_errata:
 	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
 	orrle	r10, r10, #1 << 12		@ set bit #12
 	mcrle	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+#ifdef CONFIG_ARM_ERRATA_857272
+	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orr	r10, r10, #1 << 10		@ set bit #10
+	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 	b	__errata_finish
 
-- 
2.21.0.593.g511ec345e18-goog

