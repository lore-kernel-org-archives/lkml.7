Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C40C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E5F20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRUituCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfE0Uzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:55:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39050 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfE0Uzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so609403wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lTcJJUHPBZrrX04wBrI5geMIeaqBLm2JwprDLfuI4WQ=;
        b=hRUituCUL6zlQFvBPkeIcnyXJzilIaTWZfysfx2y5BvWZn1RBFzD9onDgp3PfrG3Za
         7M/zPlqSqK2BBu1d//QEZwsidxL4WdKJMvPlpljHdztK0U22Ma/2IPA6RU0h+YyeTaKa
         51wjGzMl5ZMHfIO4cA01nMy9owwGDXZGBOQi6ieahJ5oke91Hl36D5D9ZVgAvCoRnQ3e
         bKCV9gvijSDZzTOBUbTRcLuzfBRkevL5csRNLXyr5/gU4DRXIiIInF+SRcew3VyB2ifG
         Ho8h+wTDNMT+WcGt3EsXjkqnrN/C2BwrRMHO91QV4PKUPhQUaWvreWCnyv+NzI50megQ
         iAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lTcJJUHPBZrrX04wBrI5geMIeaqBLm2JwprDLfuI4WQ=;
        b=py5HC6No34OxnpESPjZQyz2KuU0KjtmvKw3FzDig6LrjzKshnPLY8/VS5JUCNPecg9
         fBizFriSpYdonFNKme3sg6T6b6TiTl2BYw9V2ZoRGqQY9j0CNQfr+F++326qEmyU3K2q
         /5XiGIZjkon3xrymI5WIIGYsLDetbty6cm+VedOwhSHBwDVgNUXqNe7MkKuc6cY+17jA
         eNFqBLBtGQQaovoMukd9UxFAnPakQK7Ok7xbAw5eTSp/PmvmNqeS87AGb3t17WV49/iS
         yuroB8h0gxzKPZfzC2ntALKX6uccDDhBvV+oglwVuhR6bMEbuQq+1IVSDIza+ezoo7UE
         FtFg==
X-Gm-Message-State: APjAAAWDU4cwzhKKaMpjKPnj7MDt8PCE60D15xVXLo6bl39HSaWWwzb+
        udmYKhfmhDskGrFqU0Glvns+SQ==
X-Google-Smtp-Source: APXvYqxWtp1f4jJ86Jmoe1jqGsyvjpGGvf3FdZT1mvjg0LP9P8IlIjk4xyNku6mjF6L88d44ASWsdw==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr585012wml.45.1558990541563;
        Mon, 27 May 2019 13:55:41 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 1/8] genirq/timings: Fix next event index function
Date:   Mon, 27 May 2019 22:55:14 +0200
Message-Id: <20190527205521.12091-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527205521.12091-1-daniel.lezcano@linaro.org>
References: <20190527205521.12091-1-daniel.lezcano@linaro.org>
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
 kernel/irq/timings.c | 51 ++++++++++++++++++++++++++++++++++++--------
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
 
-- 
2.17.1

