Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0FAC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61DA208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y9PsKCkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438924AbfFLM3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:29:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438909AbfFLM3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:29:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCTmC2685354
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:29:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCTmC2685354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342588;
        bh=GDCBdM17qNBUzw3wBHDJpKdZXtdyZ/NWJc7v/8rTrZk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Y9PsKCkEpjavZT8r4lPizmm9C3OZ70koJRsnO+9pswsuRUdI3CWHupZaELmB+/aUE
         44mwNyx4xlA/FFoK+h6EQiHJH5qDl9TALXyDm2lnBExQnRbaYILuzhRDEroIntsjB5
         8OZmdcgG41BnKEL2mcHaG7kwLcwQ0YekuJMaslBwpvjLknDKa1RZFJ72zOqtn/5ysa
         gqq2Y6NOomXfF7c9mwcFSje2q5yyaplOEXqdb3MS/xf3RXe9rlgdOuy+CcOdf/khYw
         OsvzVER1mzW/j7sCspDND4nO5rJPORw2yeqObxYOjU8f+69ARqIP3g9mHHUHxzS1RO
         lWvSb9MASYlxA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCTl6w685351;
        Wed, 12 Jun 2019 05:29:47 -0700
Date:   Wed, 12 Jun 2019 05:29:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-df025e47e4e34b779af2cc72c350877be7104ef3@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          daniel.lezcano@linaro.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190527205521.12091-5-daniel.lezcano@linaro.org>
References: <20190527205521.12091-5-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Encapsulate timings push
Git-Commit-ID: df025e47e4e34b779af2cc72c350877be7104ef3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  df025e47e4e34b779af2cc72c350877be7104ef3
Gitweb:     https://git.kernel.org/tip/df025e47e4e34b779af2cc72c350877be7104ef3
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Mon, 27 May 2019 22:55:17 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:47:04 +0200

genirq/timings: Encapsulate timings push

For the next patches providing the selftest, it is required to artificially
insert timings value in the circular buffer in order to check the
correctness of the code. Encapsulate the common code between the future
test code and the current code with an always-inline tag.

No functional change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20190527205521.12091-5-daniel.lezcano@linaro.org

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
