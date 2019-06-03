Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F99BC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC52327EEA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwNM5aaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfFCJOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:14:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41874 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfFCJOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:14:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so1465400lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+y2pHh+GcgrSTo/c/Dh+rI5M9UbSYW68+phN/wa7KlA=;
        b=XwNM5aaSm3fVul6uRnmu+Fwt9JaXj3z2dqhDZMARNqS5naUoZNgGLSLwsvVmsEz9yL
         c0arF2jfhe472ek/T7KaHJmQe9ZWn1vIfZ1zP3sWpdcTKzQYLngpHvbE9cMqmevghtv2
         92WTx36NG/u22grAhRBghDdGYWYAN10P/F+6XrvTXTaVMDBR/IAUa7VqHxE5fhzulF7u
         TBxjumz03UwitufJJztAVu7RNIaNbl7bk2FnoJQgm9CNOu+gAMsfZDTuf2C3ANydj6hx
         8nQoerNpFuFxav5hC+2HVyIO1P5ydRDPAKnde4Ng8ABvXfh6QZ+0BZrD8Kl48BfUb6cH
         mriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+y2pHh+GcgrSTo/c/Dh+rI5M9UbSYW68+phN/wa7KlA=;
        b=j1bqvcR05wwiAL1U0/68KfLPDmzS+Zy5Fdmsdmwt/ovNe9VZIV+6K1SLeC3lBPZpqT
         qz4dNdns2tBBHLXDB+HR6EG7zyVSQXxPcFZovgpASFFUkDxD4vmosDNOtDNC5Ud/CMCz
         YCIDtkuYRxSz92g5VZd67srbJYHDiiiBGfho2NcxExvKFZYx9cPicOlLgbkln5cdDnmv
         JM5HdfTb7MLaCjP0VVI68kHOrN1Ts8FPRR9Gbd2+Ak1SamVpDxnqAXJcP0TyXukSik7t
         6NnOhvVj7lOC2tj2FTOcgm0S4kVKSd8UY3AIqsZu07VG5qKOVyGTX0figV52utfyBC2r
         Az5Q==
X-Gm-Message-State: APjAAAUYR8sjaB1gVFB1wNrNnnX0KKGn+CedBQxZwatJkno4R2KTd0c5
        pL8NNueoVnjrf1MJs0vD5BCofA==
X-Google-Smtp-Source: APXvYqycSNEtNTgVc9EBZuUkjuvDVTlF4uWCWZ8DhHDbwtYYrszDaNXZo89BJZ2WkACsE6TdHAl2TA==
X-Received: by 2002:ac2:5449:: with SMTP id d9mr14199136lfn.126.1559553247684;
        Mon, 03 Jun 2019 02:14:07 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id o184sm3068020lfo.37.2019.06.03.02.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 02:14:07 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/3] arm64: arch_timer: mark functions as __always_inline
Date:   Mon,  3 Jun 2019 11:14:02 +0200
Message-Id: <20190603091402.25115-1-anders.roxell@linaro.org>
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

Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable counters")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/include/asm/arch_timer.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index b7bca1ae09e6..50b3ab7ded4f 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -193,7 +193,7 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	: "=r" (tmp) : "r" (_val));					\
 } while (0)
 
-static inline u64 __arch_counter_get_cntpct_stable(void)
+static __always_inline u64 __arch_counter_get_cntpct_stable(void)
 {
 	u64 cnt;
 
@@ -203,7 +203,7 @@ static inline u64 __arch_counter_get_cntpct_stable(void)
 	return cnt;
 }
 
-static inline u64 __arch_counter_get_cntpct(void)
+static __always_inline u64 __arch_counter_get_cntpct(void)
 {
 	u64 cnt;
 
@@ -213,7 +213,7 @@ static inline u64 __arch_counter_get_cntpct(void)
 	return cnt;
 }
 
-static inline u64 __arch_counter_get_cntvct_stable(void)
+static __always_inline u64 __arch_counter_get_cntvct_stable(void)
 {
 	u64 cnt;
 
@@ -223,7 +223,7 @@ static inline u64 __arch_counter_get_cntvct_stable(void)
 	return cnt;
 }
 
-static inline u64 __arch_counter_get_cntvct(void)
+static __always_inline u64 __arch_counter_get_cntvct(void)
 {
 	u64 cnt;
 
-- 
2.20.1

