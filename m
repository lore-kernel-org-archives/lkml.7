Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F757C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8FB208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlw7JzBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfEMKaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33078 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfEMKaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so5806496wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0HzfJ8leQV9/Ia+5j4PgeiH8O0rzgjlyMwyBqLrNY4=;
        b=hlw7JzBtrgh3/XIvBJP98kqEUKf77GmYZoHuNHj9UWkdTEP3+5ukxMxY/xE0wdVrpS
         ij1IC/WHsr1VhutVOAyaZLEhE7uH1Ur+DlCo67iG8hS8kCmdyOWRMw5p0Sgn9lE4KE3C
         CNRgx6KuK70TofcGPFp8eRCWjAGq0zZsLbx3Fmwm8QDNeUExNphDlWd0bcufY1J7oVW3
         AW6xhVHbCraw/hUqjytBmMma0XUgWf4EfovjJwNAL8Ii6+NgjMsCPBB41YCc9LtcQutK
         W9NCvRhBZH1xxMuyTOPm2EAu5SiPHqCiuOLR4uIZ/UlczNskIJ9KNfRD3R5Hq0W+e30y
         JFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0HzfJ8leQV9/Ia+5j4PgeiH8O0rzgjlyMwyBqLrNY4=;
        b=SsBEdjF0db/mcRt64PdW1p6HBLFS+77fXJTgKHAQSdJKNUb/vmBj2dayIVqYjASICS
         HIHZUUbbFXuj8ViWQUrf8N8mf6liQDFDYPD8itsyo4ZpBftulFBM8JH52e5LLwecndpV
         302UbihkrUPtcsGR3x8mAITTe4cTsyZBmRVLGTwfPYadqv81Msx9ySqyb1CIAvg0ZxZc
         SVqMtC3SqrW7dGkzh3gxmZo6W/ofeYM2LWPaRtJNYFLbtZsuOK0y0GlykowXgFGYUNl+
         8xfqU4lWyoaA5Qf0Cr1Brh2BAhM1kw69KihA8AawQDIpcuyAqe0ynmoCFr0EFevTY2XZ
         NjhA==
X-Gm-Message-State: APjAAAUwV5Au39whzehMjRpWCmwgWGfc4zBGTMGt3C4G+AZf0q/RZ+oZ
        JOyhaedoXscEFyCwv2NsD86MA2SleCo=
X-Google-Smtp-Source: APXvYqx4GdWOndFx/J4I7ir2QJnMFsg6tHWBmBTx7fc8YtUmv2gLbb5819rkFM42HoDBFT+LaQQLkg==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr10369340wma.109.1557743404664;
        Mon, 13 May 2019 03:30:04 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] genirq/timings: Fix next event index function
Date:   Mon, 13 May 2019 12:29:45 +0200
Message-Id: <20190513102953.16424-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
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

