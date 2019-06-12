Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8FBC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E89208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sSyJq0xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407452AbfFLM1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:27:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406351AbfFLM1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:27:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCRd91685107
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:27:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCRd91685107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342460;
        bh=Tm/1EUthS7+yPjnl5CHbEXqupEC97Y+DzIGcP3UVbxk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=sSyJq0xlRWhGyQejnkIfniakUPWqz934ALYOZR4sx1PKdpY3uKOqsJG7rASVt5140
         fwNQenxpTLk7snkUhx0Ha5GwRlMy1X7ls+ydDmvEQwvH47+3PNOMMn9d5cVo2ePh5J
         bMyGxKTvlmkAjVgKDZ1V6I/SHeSPYazwSvsus5hApJplRCgTFYH7ieSHiPVeiStw+F
         JQjpocO4L4zRKrIlRZHcsnJi8JTxaCTRPxAHO+Ve1IU0FFGyoZH0YcQi7VzvkRW1wt
         XMh9YcO1US/ctYl9MNVCCrNXDy9TWqxe/2r6vdQMsrUP+uvIoA2x549rdBcXx44Cdq
         WAfEjPYuemifA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCRcxJ685104;
        Wed, 12 Jun 2019 05:27:38 -0700
Date:   Wed, 12 Jun 2019 05:27:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-619c1baa91b2820eae9ff5d89eb525df81ea7a5a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190527205521.12091-2-daniel.lezcano@linaro.org>
References: <20190527205521.12091-2-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Fix next event index function
Git-Commit-ID: 619c1baa91b2820eae9ff5d89eb525df81ea7a5a
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

Commit-ID:  619c1baa91b2820eae9ff5d89eb525df81ea7a5a
Gitweb:     https://git.kernel.org/tip/619c1baa91b2820eae9ff5d89eb525df81ea7a5a
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Mon, 27 May 2019 22:55:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:47:03 +0200

genirq/timings: Fix next event index function

The current code is luckily working with most of the interval samples
testing but actually it fails to correctly detect pattern repetition
breaking at the end of the buffer.

Narrowing down the bug has been a real pain because of the pointers,
so the routine is rewrittne by using indexes instead.

Fixes: bbba0e7c5cda "genirq/timings: Add array suffix computation code"
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20190527205521.12091-2-daniel.lezcano@linaro.org

---
 kernel/irq/timings.c | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 90c735da15d0..4f5daf3db13b 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -297,7 +297,16 @@ static u64 irq_timings_ema_new(u64 value, u64 ema_old)
 
 static int irq_timings_next_event_index(int *buffer, size_t len, int period_max)
 {
-	int i;
+	int period;
+
+	/*
+	 * Move the beginning pointer to the end minus the max period x 3.
+	 * We are at the point we can begin searching the pattern
+	 */
+	buffer = &buffer[len - (period_max * 3)];
+
+	/* Adjust the length to the maximum allowed period x 3 */
+	len = period_max * 3;
 
 	/*
 	 * The buffer contains the suite of intervals, in a ilog2
@@ -306,21 +315,45 @@ static int irq_timings_next_event_index(int *buffer, size_t len, int period_max)
 	 * period beginning at the end of the buffer. We do that for
 	 * each suffix.
 	 */
-	for (i = period_max; i >= PREDICTION_PERIOD_MIN ; i--) {
+	for (period = period_max; period >= PREDICTION_PERIOD_MIN; period--) {
 
-		int *begin = &buffer[len - (i * 3)];
-		int *ptr = begin;
+		/*
+		 * The first comparison always succeed because the
+		 * suffix is deduced from the first n-period bytes of
+		 * the buffer and we compare the initial suffix with
+		 * itself, so we can skip the first iteration.
+		 */
+		int idx = period;
+		size_t size = period;
 
 		/*
 		 * We look if the suite with period 'i' repeat
 		 * itself. If it is truncated at the end, as it
 		 * repeats we can use the period to find out the next
-		 * element.
+		 * element with the modulo.
 		 */
-		while (!memcmp(ptr, begin, i * sizeof(*ptr))) {
-			ptr += i;
-			if (ptr >= &buffer[len])
-				return begin[((i * 3) % i)];
+		while (!memcmp(buffer, &buffer[idx], size * sizeof(int))) {
+
+			/*
+			 * Move the index in a period basis
+			 */
+			idx += size;
+
+			/*
+			 * If this condition is reached, all previous
+			 * memcmp were successful, so the period is
+			 * found.
+			 */
+			if (idx == len)
+				return buffer[len % period];
+
+			/*
+			 * If the remaining elements to compare are
+			 * smaller than the period, readjust the size
+			 * of the comparison for the last iteration.
+			 */
+			if (len - idx < period)
+				size = len - idx;
 		}
 	}
 
