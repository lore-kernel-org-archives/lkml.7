Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE6C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FB720859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EePZvjMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfE0Uzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:55:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfE0Uzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so17972340wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2Cp7f/Qid/by7EIC98tg3BbhOaVwQta3p5eP2Mz3hQ=;
        b=EePZvjMZcgu/kixTEABhJt4zmZ4II7f9mSzF7+7lCB7Jc4MuoxmuTuvlRWq4xGGY3d
         28M0CRfZtHnrnjGfsbNmCBnAwnJI7TdO5zojYKV58xxPLtyCf+qaYlQg94txEKEFI7qx
         TTDo+fIzQYYxfPbdE0se2j2i9RVbv216RwKnsH4NJ6mTAGmJl48ObP4g4u3cm96kUSHU
         7su+KIDLSHZsTDCgRYH0U54dWWk/EJ39kDDXzURrwvGMsGu6NUxUgkpybASzQ9u1a220
         eWGPiXVVCq4od8z6k/6IFtEuD+ZnR3itJc48TxbeiSefi2CWfCCowpV0PWLcFCp9fm+l
         G4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D2Cp7f/Qid/by7EIC98tg3BbhOaVwQta3p5eP2Mz3hQ=;
        b=L1jg19Vhw1/2n5X40wLaVlaVJF/aUR4scbD5suaArcaueybbsExVbFLnguzjmOdcSP
         I9mINmFUdZpztqLOcXDeamY7VZDcTzx0kyZSALdeEEmhiGfaMxstjKYGpO7+WYTcsqO/
         PL8yDEr/Q53V3cbduyaJFgE13EL8knDqJjJrLnGmj3RIL6JAQY5j6xKjRf4wzJdz5LCP
         Jmv0v/sQ5RWAUboaJJ48oUTTfiAfUPBk4eNtx50dfO9XbJSxp2OyK2JVZ/kqCTcbMpl7
         faoJh6CusH29Kj9cMpSKDbedmgnBFQUDoWpfxIhIr3CKqXxu083qsk0EpSI3sx/d0d0D
         Rr5g==
X-Gm-Message-State: APjAAAXKF5YuVxmeP5m74ZCRymBujx4B8UH9N2RqoPfvlv94goQiitdi
        mTV8k14yigVtmSn1EgrTjzwinpcKwWE=
X-Google-Smtp-Source: APXvYqw2kzsHT5jLK0Ao93gGkfVhvRZgTY00b0lP5OQYgVPUGNRRoCeTqDWwRru/4Djf3N6CIMM5SA==
X-Received: by 2002:adf:f2c2:: with SMTP id d2mr1977240wrp.153.1558990546120;
        Mon, 27 May 2019 13:55:46 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 4/8] genirq/timings: Encapsulate timings push
Date:   Mon, 27 May 2019 22:55:17 +0200
Message-Id: <20190527205521.12091-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527205521.12091-1-daniel.lezcano@linaro.org>
References: <20190527205521.12091-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the next patches providing the selftest, we do want to
artificially insert timings value in the circular buffer in order to
check the correctness of the code. Encapsulate the common code between
the future test code and the current with an always-inline tag.

No functional change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/internals.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70c3053bc1f6..21f9927ff5ad 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -354,6 +354,16 @@ static inline int irq_timing_decode(u64 value, u64 *timestamp)
 	return value & U16_MAX;
 }
 
+static __always_inline void irq_timings_push(u64 ts, int irq)
+{
+	struct irq_timings *timings = this_cpu_ptr(&irq_timings);
+
+	timings->values[timings->count & IRQ_TIMINGS_MASK] =
+		irq_timing_encode(ts, irq);
+
+	timings->count++;
+}
+
 /*
  * The function record_irq_time is only called in one place in the
  * interrupts handler. We want this function always inline so the code
@@ -367,15 +377,8 @@ static __always_inline void record_irq_time(struct irq_desc *desc)
 	if (!static_branch_likely(&irq_timing_enabled))
 		return;
 
-	if (desc->istate & IRQS_TIMINGS) {
-		struct irq_timings *timings = this_cpu_ptr(&irq_timings);
-
-		timings->values[timings->count & IRQ_TIMINGS_MASK] =
-			irq_timing_encode(local_clock(),
-					  irq_desc_get_irq(desc));
-
-		timings->count++;
-	}
+	if (desc->istate & IRQS_TIMINGS)
+		irq_timings_push(local_clock(), irq_desc_get_irq(desc));
 }
 #else
 static inline void irq_remove_timings(struct irq_desc *desc) {}
-- 
2.17.1

