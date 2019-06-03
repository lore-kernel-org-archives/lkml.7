Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBDEC28D16
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EF427F07
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIMKxnbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfFCJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:15:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44431 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbfFCJPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:15:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so12984144lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PR8lLBLyYvGMiS0Uym8abST4zelhaOVi9Iwrklqg+JM=;
        b=WIMKxnbm4jO3KJFthTYVKBxdmkT1G96bERBd6FIDYNYhFfSTjUb3750sWesJG0TUYL
         bxWMY37Ut3+qwQttQ+NSVhD2nzOpnVadPB7YAZSmTvHbRNm9Vsw0pjGkbrjkhfCV9Qoi
         qtRXjAe+4qc7ZkyUel1mSbqjR/epygQ0DNkwGnKF9qRfQEEkRGIsQGP4G5AWKC36h7RL
         jRVzmDYhz5eFURzz2IQ8gJEa71grNVKYOacWuRLabzeEtxIAwaUb59PPVymqS0pEF1k3
         TT42cFX5wZMHxIb7CdLFy+R/SnaPs77uoDVYWvEPreCWjB6tx5WdBkS5ZQmuCOXCN49b
         HNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PR8lLBLyYvGMiS0Uym8abST4zelhaOVi9Iwrklqg+JM=;
        b=PtwbjpSJ2NjXEKcQo+elueG4ZM+PnKZkN1aLUkl9qxdeR8v4LOoGy/ftG3K3y/A4Bp
         6yRiARXIlSQKcrW8VqpmGy016qBDMxzVjTdn65HcN6t1SsIjCSdCg21v6V8r21yG/qcV
         cqggw4aPABWk0LTS40tqL0qkIKjkRxVNgG/A6t6+sgUf1wXtNGzQGBkn4UQN1kJtu9zd
         nx7EqnurywRXeSrRQhwxpmydVqdgbUeSdNgLFd10gSuvXVEvK+zoMS6c/XbYr14zzh1C
         PDEMEWcQf9zjRCpm3KBGe4Am1KNZHX0zHF1vKKsiLWrDqt/bYQtqa0A4MUM1Ols2rSl9
         p1FA==
X-Gm-Message-State: APjAAAVJAkrgvr9/ifhv+SA7CYJknTkD6fGgzY30fhad7TV6r1GqnPwX
        J/DJoAY3U+Z7pJa27P4lp9E2RA==
X-Google-Smtp-Source: APXvYqwctOBDRg0FjRVPjNSS+OgP9LZF1AQuiSF/Mk+/WqjBT70Z2+BjtM8kSX3oNGhLTa/6lXJf6w==
X-Received: by 2002:a19:4bc5:: with SMTP id y188mr13319717lfa.113.1559553317031;
        Mon, 03 Jun 2019 02:15:17 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id k16sm3018089lje.30.2019.06.03.02.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 02:15:16 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mark.rutland@arm.com, marc.zyngier@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 3/3] arm: arch_timer: mark functions as __always_inline
Date:   Mon,  3 Jun 2019 11:15:12 +0200
Message-Id: <20190603091512.25298-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_FUNCTION_GRAPH_TRACER is enabled function
arch_counter_get_cntvct() is marked as notrace. However, function
__arch_counter_get_cntvct is marked as inline. If
CONFIG_OPTIMIZE_INLINING is set that will make the two functions
tracable which they shouldn't.

Rework so that functions __arch_counter_get_* are marked with
__always_inline so they will be inlined even if CONFIG_OPTIMIZE_INLINING
is turned on.

Originally found on arm64, but doing the same thing on arm for
consistency.

Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable counters")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/include/asm/arch_timer.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 4b66ecd6be99..73a72ce41dc3 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -83,7 +83,7 @@ static inline u32 arch_timer_get_cntfrq(void)
 	return val;
 }
 
-static inline u64 __arch_counter_get_cntpct(void)
+static __always_inline u64 __arch_counter_get_cntpct(void)
 {
 	u64 cval;
 
@@ -92,12 +92,12 @@ static inline u64 __arch_counter_get_cntpct(void)
 	return cval;
 }
 
-static inline u64 __arch_counter_get_cntpct_stable(void)
+static __always_inline u64 __arch_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct();
 }
 
-static inline u64 __arch_counter_get_cntvct(void)
+static __always_inline u64 __arch_counter_get_cntvct(void)
 {
 	u64 cval;
 
@@ -106,7 +106,7 @@ static inline u64 __arch_counter_get_cntvct(void)
 	return cval;
 }
 
-static inline u64 __arch_counter_get_cntvct_stable(void)
+static __always_inline u64 __arch_counter_get_cntvct_stable(void)
 {
 	return __arch_counter_get_cntvct();
 }
-- 
2.20.1

