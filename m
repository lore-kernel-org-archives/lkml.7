Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD4C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3492184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvNpKcLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390894AbfEXLQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:16:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46503 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390410AbfEXLQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so9578114wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0HzfJ8leQV9/Ia+5j4PgeiH8O0rzgjlyMwyBqLrNY4=;
        b=pvNpKcLsEz+1W37HcVISnMK4xkdCyLtbas0+BI0hYTjlzR/fSpFpW7oqy0Nk7KvHwx
         BxHl44BzkSqRlNJhucVvuVCrgCGGQO6decnRTfn12JuxgpSvDQ+ouiu5kba2JFwy+OJR
         BTJbBFDg17pyytm0KbCGpghu4BjNRDIVEmfXZCKwARZSevQBe/bE0pjHs6sFqG0qDgyc
         HxZ/NMWbPrzbIVMbeHXTU2Na9e01X8aT7e7OIzCXs7cgJKeK8otHCzSESBjs8q+8/0kV
         U/rQUYpkoIqbdy865VwfoCkjhL5vFxFEqLtJw+hixLdQNJ+JEjKHWzFXC+ULshxJrIc9
         nYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0HzfJ8leQV9/Ia+5j4PgeiH8O0rzgjlyMwyBqLrNY4=;
        b=Qg0BIgN9dDs0n4NAvSflcHsswb8dCK2IuRg/yyUpWNTkur6Ubm9BuKGOIltVeaGQ2b
         gCJDaYa0zXTkYpd588sn0haFz7719KuYMpDFVn51//jNs+rtx/onoae1JvAoCLkfzjWu
         6l7P/HrJcK1BZwrC/0XOSDSeAuU0G6rNHvvTpkML8cM6sCiKmEbE3ma0VLijPZ8LYTWr
         FjiD4v3pA1D8LoOijavxHGXkS6wEb53CCTy1gfQ8HGivJptvZjqBp3oi3W1tEfAXUMbt
         FONgREhStDCQwgWKWZ5ETP5y4qmiqBZYZjUGzVcGmUER1B86M6RvKvy9FhbptCXnwrJX
         cRIA==
X-Gm-Message-State: APjAAAU7q9Y5OriknPJZqgJiwu8qOTD8yF4pBihCm2pSq3ytIzPipAlS
        0GuKfsMwFshilN7xbf8nl+dCziu5+pA=
X-Google-Smtp-Source: APXvYqxuE0d5xdGWQJE+c9M90XY85xYZMHaMvDk0/gvF3HXxprlp1muq6u5JWC6kZD3MTvgrkCnjDw==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr9522454wrs.328.1558696597623;
        Fri, 24 May 2019 04:16:37 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 1/9] genirq/timings: Fix next event index function
Date:   Fri, 24 May 2019 13:16:07 +0200
Message-Id: <20190524111615.4891-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524111615.4891-1-daniel.lezcano@linaro.org>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code was luckily working with most of the interval samples
testing but actually it fails to correctly detect pattern repeatition
breaking at the end of the buffer.

Narrowing down the bug has been a real pain because of the pointers,
so the routine is rewrite by using indexes instead.

Fixes: bbba0e7c5cda "genirq/timings: Add array suffix computation code"
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 53 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 90c735da15d0..60362aca4ca4 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -297,7 +297,18 @@ static u64 irq_timings_ema_new(u64 value, u64 ema_old)
 
 static int irq_timings_next_event_index(int *buffer, size_t len, int period_max)
 {
-	int i;
+	int period;
+
+	/*
+	 * Move the beginnning pointer to the end minus the max period
+	 * x 3. We are at the point we can begin searching the pattern
+	 */
+	buffer = &buffer[len - (period_max * 3)];
+
+	/*
+	 * Adjust the length to the maximum allowed period x 3
+	 */
+	len = period_max * 3;
 
 	/*
 	 * The buffer contains the suite of intervals, in a ilog2
@@ -306,21 +317,45 @@ static int irq_timings_next_event_index(int *buffer, size_t len, int period_max)
 	 * period beginning at the end of the buffer. We do that for
 	 * each suffix.
 	 */
-	for (i = period_max; i >= PREDICTION_PERIOD_MIN ; i--) {
+	for (period = period_max; period >= PREDICTION_PERIOD_MIN ; period--) {
 
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
 
-- 
2.17.1

