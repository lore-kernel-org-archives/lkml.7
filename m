Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B81BC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E295D218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XwvnvmUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfDWXAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:00:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42382 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfDWXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:00:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id x15so3883474pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ra8Ms5CUfBwXQRLy73kzr5XO2DuaX+tzW+qegRE+LGM=;
        b=XwvnvmUbLauRVIj4hvNXed/2GB6dgP6nTAJ4mI/51T2G61NvDJlzvPajYR08sH0oA+
         NeMe9ChkLDPHVDr9ieDzVm6sGk8nMPgxApd/QoGwCgjr8vIj3lbstDd0j+taCdwK1Xa4
         ky4untPiEV8NDidCJlxOIXfW9owEj5lAR48CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ra8Ms5CUfBwXQRLy73kzr5XO2DuaX+tzW+qegRE+LGM=;
        b=mgFaq5aF8j1aDsKnwBgwYwYydr8EOgOlvIbEHiWWkiedNWVx+GHtCq80ge1lCSGEZR
         0hj2IBMHSyHrWPQgNbq0QXWXUszDU68GjEaUWfldjeSVIn9h5rK3297kUBGXy2oXRgC2
         Ww2jgIb4CfREkI3+98PkvzBcJts/4dpFLT076DIe0J7ntuePnH2OB3gdiCHA343VaQ9s
         QykXDe8Mc83uNpIKpGHPCBwYYg93xhFBxiEbXDwcHnS8ENwbBjBYCF2P4n9/6OtmPdmH
         d250vtU3gTQ7+VOGJo25amtmRHoyYOIKBZt7YnzPbJ3HgcOavKeIkDETQkrnhGplOyDQ
         cCxg==
X-Gm-Message-State: APjAAAVxgMKByM0PKFKzhCwdtW+nF+ClVKNM8uJwRF06F/m7sOHLR6cv
        hWSXLBvaDNKv6fq7QzZ3CEEfDg==
X-Google-Smtp-Source: APXvYqxCEK2LTIUfGGL05MZVufslqWsTB7Kv3HMeLX6IGw8zPEdUXkD39e7d0eqVk1oWDX1zvd5nEQ==
X-Received: by 2002:a17:902:263:: with SMTP id 90mr29254648plc.257.1556060438495;
        Tue, 23 Apr 2019 16:00:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f66sm854467pfa.5.2019.04.23.16.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:00:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     mark.rutland@arm.com, Salva.Climent@arm.com,
        marc.w.gonzalez@free.fr, linux-rockchip@lists.infradead.org,
        sonnyrao@chromium.org, will.deacon@arm.com, bbatacha@arm.com,
        mka@chromium.org, robin.murphy@arm.com, heiko@sntech.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2] ARM: errata: Workaround errata A12 857271 / A17 857272
Date:   Tue, 23 Apr 2019 15:59:59 -0700
Message-Id: <20190423225959.43742-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for working around errata A12 857271 / A17 857272.
These errata were causing hangs on rk3288-based Chromebooks and it was
confirmed that this workaround fixed the problems.  In the Chrome OS
3.14 kernel this was treated as two errata: ERRATA_FOOBAR [1] and
ERRATA_CR711784 [2].  Apparently the two errata got lumped together at
some point in time.

Let's actually get the workaround landed.

[1] https://crrev.com/c/342753
[2] https://crbug.com/711784

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v2:
- Squashed bits 10 and 11 into one errata.

 arch/arm/Kconfig      | 18 ++++++++++++++++++
 arch/arm/mm/proc-v7.S | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b509cd338219..59fdcd51d7ee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1172,6 +1172,14 @@ config ARM_ERRATA_825619
 	  DMB NSHST or DMB ISHST instruction followed by a mix of Cacheable
 	  and Device/Strongly-Ordered loads and stores might cause deadlock
 
+config ARM_ERRATA_857271
+	bool "ARM errata: A12: CPU might deadlock under some very rare internal conditions"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 857271 Cortex-A12
+	  (all revs) erratum. Under very rare timing conditions, the CPU might
+	  hang. The workaround is expected to have a < 1% performance impact.
+
 config ARM_ERRATA_852421
 	bool "ARM errata: A17: DMB ST might fail to create order between stores"
 	depends on CPU_V7
@@ -1193,6 +1201,16 @@ config ARM_ERRATA_852423
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
index 339eb17c9808..2966086d8a45 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -391,6 +391,11 @@ __ca12_errata:
 	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
 	orr	r10, r10, #1 << 24		@ set bit #24
 	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+#ifdef CONFIG_ARM_ERRATA_857271
+	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orr	r10, r10, #3 << 10		@ set bits #10 and #11
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
+	orr	r10, r10, #3 << 10		@ set bits #10 and #11
+	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 	b	__errata_finish
 
-- 
2.21.0.593.g511ec345e18-goog

