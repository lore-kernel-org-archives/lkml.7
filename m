Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93427C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F93218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWzSw4+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfC3U7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:59:40 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:39080 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfC3U7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 16:59:40 -0400
Received: by mail-pf1-f173.google.com with SMTP id i17so2648791pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUijhV8dvOp5quDJo+Y2duIDmubs9G49tAISmUGTeM4=;
        b=jWzSw4+JmgYpPJW7IQnYpnEj5DAsbMOVO9MaKHWkuBQKhtCmRu0OhfL+YLGelkIip9
         o32K3OZlQcPut6KZ2yvMnlhZGPFWMYj1DKPQZGCm8DqIA1WA2ikoxwQsF/5olIFs6T+1
         OT54YA3rVodu000NtMeBV34QqSZyjPa8/lel86nEaE24MXlGN3ZfljTWSkWziXIm3jBT
         xUtPHvbFBzpnAnjulEei7Vjp7ItkdvQrnYhQ0+H9QLEJ2mHDFAgQfRN9Me4IrIltvZ1I
         P9EafgK20zZItarYsR4Vu0Zhjp8UGd2niJfGQiez7iYM12RGKNLgNN/GDf4u5fN2vYrI
         /Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUijhV8dvOp5quDJo+Y2duIDmubs9G49tAISmUGTeM4=;
        b=hCjm+BdzuaNS2PJZNNaXAN/dvpU17Myj6S27k4e8ZiOwadktct4B7fuRNAp69e58kt
         0xJg0v6fJ/LRH5GMWTdS5/RFkF7B8LFbkX+QJkvabQ5RHYe3A4MdsogMr+/dX4yj+6aj
         hj1pbVgDyAmcsQ/UFcDdIG2e6tGShdsO0WYhEAJcydrglBalUy4IU7yp/9oC2X+SMKw3
         xZ1HdlHELKdZGoPRi6AYvTw/CBDGaZJ/cAwPROluO4cc/3IkB37dFdWGD56JHhr8lZ3h
         4WoVTj72pFreqXG+ach0VkTBoDM6leqV3G+olirVj1SHgFHydohv4aQrJqvLWIoItWhv
         z9pg==
X-Gm-Message-State: APjAAAX2pxPLWQnAX9SKglWLzcLlmaolQ7a/7D5ub7l2Vgit3qC9ZyXE
        RNULtschYw1NI0shyWm9FYddxWG/
X-Google-Smtp-Source: APXvYqzwCg3cFpW70M7+KU+YpnmdpKWmRHdkVzwppLqxme7yRPB43sO+W/ysnym7k+/oe0k8zgnl4Q==
X-Received: by 2002:a63:8142:: with SMTP id t63mr48037279pgd.63.1553979579059;
        Sat, 30 Mar 2019 13:59:39 -0700 (PDT)
Received: from zen.local (216-160-106-16.tukw.qwest.net. [216.160.106.16])
        by smtp.gmail.com with ESMTPSA id b2sm3095981pfo.150.2019.03.30.13.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 13:59:38 -0700 (PDT)
From:   Trent Piepho <tpiepho@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Trent Piepho <tpiepho@gmail.com>,
        Oskar Schirmer <oskar@scara.com>
Subject: [PATCH] lib: Fix possible incorrect result from rational fractions helper
Date:   Sat, 30 Mar 2019 13:58:55 -0700
Message-Id: <20190330205855.19396-1-tpiepho@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the previous algorithm would not return the closest
approximation.  This would happen when a semi-convergent was the
closest, as the previous algorithm would only consider convergents.

As an example, consider an initial value of 5/4, and trying to find the
closest approximation with a maximum of 4 for numerator and denominator.
The previous algorithm would return 1/1 as the closest approximation,
while this version will return the correct answer of 4/3.

To do this, the main loop performs effectively the same operations as it
did before.  It must now keep track of the last three approximations,
n2/d2 .. n0/d0, while before it only needed the last two.

If an exact answer is not found, the algorithm will now calculate the
best semi-convergent term, t, which is a single expression with two
divisions:
    min((max_numerator - n0) / n1, (max_denominator - d0) / d1)

This will be used if it is better than previous convergent.  The test
for this is generally a simple comparison, 2*t > a.  But in an edge
case, where the convergent's final term is even and the best allowable
semi-convergent has a final term of exactly half the convergent's final
term, the more complex comparison (d0*dp > d1*d) is used.

I also wrote some comments explaining the code.  While one still needs
to look up the math elsewhere, they should help a lot to follow how the
code relates to that math.

Cc: Oskar Schirmer <oskar@scara.com>
Signed-off-by: Trent Piepho <tpiepho@gmail.com>
---
 lib/rational.c | 63 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/lib/rational.c b/lib/rational.c
index ba7443677c90..31fb27db2deb 100644
--- a/lib/rational.c
+++ b/lib/rational.c
@@ -3,6 +3,7 @@
  * rational fractions
  *
  * Copyright (C) 2009 emlix GmbH, Oskar Schirmer <oskar@scara.com>
+ * Copyright (C) 2019 Trent Piepho <tpiepho@gmail.com>
  *
  * helper functions when coping with rational numbers
  */
@@ -10,6 +11,7 @@
 #include <linux/rational.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
+#include <linux/kernel.h>
 
 /*
  * calculate best rational approximation for a given fraction
@@ -33,30 +35,65 @@ void rational_best_approximation(
 	unsigned long max_numerator, unsigned long max_denominator,
 	unsigned long *best_numerator, unsigned long *best_denominator)
 {
-	unsigned long n, d, n0, d0, n1, d1;
+	/* n/d is the starting rational, which is continually
+	 * decreased each iteration using the Euclidean algorithm.
+	 *
+	 * dp is the value of d from the prior iteration.
+	 *
+	 * n2/d2, n1/d1, and n0/d0 are our successively more accurate
+	 * approximations of the rational.  They are, respectively,
+	 * the current, previous, and two prior iterations of it.
+	 *
+	 * a is current term of the continued fraction.
+	 */
+	unsigned long n, d, n0, d0, n1, d1, n2, d2;
 	n = given_numerator;
 	d = given_denominator;
 	n0 = d1 = 0;
 	n1 = d0 = 1;
+
 	for (;;) {
-		unsigned long t, a;
-		if ((n1 > max_numerator) || (d1 > max_denominator)) {
-			n1 = n0;
-			d1 = d0;
-			break;
-		}
+		unsigned long dp, a;
+
 		if (d == 0)
 			break;
-		t = d;
+		/* Find next term in continued fraction, 'a', via
+		 * Euclidean algorithm.
+		 */
+		dp = d;
 		a = n / d;
 		d = n % d;
-		n = t;
-		t = n0 + a * n1;
+		n = dp;
+
+		/* Calculate the current rational approximation (aka
+		 * convergent), n2/d2, using the term just found and
+		 * the two prior approximations.
+		 */
+		n2 = n0 + a * n1;
+		d2 = d0 + a * d1;
+
+		/* If the current convergent exceeds the maxes, then
+		 * return either the previous convergent or the
+		 * largest semi-convergent, the final term of which is
+		 * found below as 't'.
+		 */
+		if ((n2 > max_numerator) || (d2 > max_denominator)) {
+			unsigned long t = min((max_numerator - n0) / n1,
+					      (max_denominator - d0) / d1);
+
+			/* This tests if the semi-convergent is closer
+			 * than the previous convergent.
+			 */
+			if (2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
+				n1 = n0 + t * n1;
+				d1 = d0 + t * d1;
+			}
+			break;
+		}
 		n0 = n1;
-		n1 = t;
-		t = d0 + a * d1;
+		n1 = n2;
 		d0 = d1;
-		d1 = t;
+		d1 = d2;
 	}
 	*best_numerator = n1;
 	*best_denominator = d1;
-- 
2.20.1

