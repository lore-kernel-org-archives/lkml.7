Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29158C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20B420859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pC54YjrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfE0U4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:56:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35834 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfE0Uzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so17972481wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dfUdgBJPtbCYc/uhDOpMaPmMlc4FCxxcnSQ96C7YgX8=;
        b=pC54YjrChaPbEwjQzWzOtVgI4Qfy3JE7gSPnbvirKitnpg3zXdThxMKqBnbW0zLitf
         jWYAtQll0nL4ZAuDMmHjmhAkzIf3BJu+eYMOe4FF/9oDdQtnjBlKRfwj12q83g+pP6Nf
         N0TYoOM1d12w6pdxrm/ChgZ11uOOiGKs4fWblPpQis91t42RBRyKETFU1v9rtKpEOTW+
         oYKjOELW3eM9GpBHBb+kTK/vpnn197yu+CoKaQigoLQI+JJiaNSMjekcIJERuCiwG9CW
         kbtLh+PZXbaiooedeV2h00nqAD6L/4YJIcUHbNw+0UbWpP67iVJoMuF9MSPvHbGsPTJh
         u1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dfUdgBJPtbCYc/uhDOpMaPmMlc4FCxxcnSQ96C7YgX8=;
        b=fvctPqJ/fmwPbyWCEHJxrwgtye9gae44Te4NIDBS6h7v/v6R9Xh3IAQnPTDedDuHtI
         U4l5AnMTVpOBmNCN/yp6fnOMj1tl/koQUU3aIE/ct0glGuEXZ7FRnBvMg8uNUzpHp/jw
         JUdLKKKrVU761YewUO3hwL1LbnjO9tehlTvogEyagG69/QfjlfhhEWLe6+3R3KjWflmY
         ip7jYC8jpBIYt4U98vWtA1Q7lNPH6kqErfSTTEvxDybLiuvgKIZYE7Um/LYNU0f/MqBz
         iTSaRciSTrGC1+TuQgZpK4dV7sicTI5Tk7H3lurQAPDRXRdC/PWFn1o39qL2ZSPZIg4S
         1gkQ==
X-Gm-Message-State: APjAAAVWVghIr7U8k3ImBKw9e+j80bUVZH54wvbFET5aXUtiodYmK23Q
        BNhoWdTB5nwFnjlGJYUvvDfDpQ==
X-Google-Smtp-Source: APXvYqw9AWq7l/BVAos9otlLSQgDWYcyVUH+7bEP3nfgEk9gLPxJcG2TGcPln+j7HUcfkX9AF2n9QA==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr7803842wrw.345.1558990551007;
        Mon, 27 May 2019 13:55:51 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:50 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 8/8] genirq/timings: Add selftest for next event computation
Date:   Mon, 27 May 2019 22:55:21 +0200
Message-Id: <20190527205521.12091-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527205521.12091-1-daniel.lezcano@linaro.org>
References: <20190527205521.12091-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The circular buffers are now validated at this point with the two
previous patches. The next interrupt index algorithm which is the
hardest part to validate can be validated with the tests provided with
this patch.

It uses the intervals stored in the arrays and insert all the values
except the last one. The next event computation must return the same
value as the last element we did not inserted.

Add tests for the next event index computation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 5b13c2231d4f..e960d7ce7bcc 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -704,6 +704,68 @@ static struct timings_intervals tis[] __initdata = {
 	{ intervals4, ARRAY_SIZE(intervals4) },
 };
 
+static int __init irq_timings_test_next_index(struct timings_intervals *ti)
+{
+	int _buffer[IRQ_TIMINGS_SIZE];
+	int buffer[IRQ_TIMINGS_SIZE];
+	int index, start, i, count, period_max;
+
+	count = ti->count - 1;
+
+	period_max = count > (3 * PREDICTION_PERIOD_MAX) ?
+		PREDICTION_PERIOD_MAX : count / 3;
+
+	/*
+	 * Inject all values except the last one which will be used
+	 * to compare with the next index result.
+	 */
+	pr_debug("index suite: ");
+
+	for (i = 0; i < count; i++) {
+		index = irq_timings_interval_index(ti->intervals[i]);
+		_buffer[i & IRQ_TIMINGS_MASK] = index;
+		pr_cont("%d ", index);
+	}
+
+	start = count < IRQ_TIMINGS_SIZE ? 0 :
+		count & IRQ_TIMINGS_MASK;
+
+	count = min_t(int, count, IRQ_TIMINGS_SIZE);
+
+	for (i = 0; i < count; i++) {
+		int index = (start + i) & IRQ_TIMINGS_MASK;
+		buffer[i] = _buffer[index];
+	}
+
+	index = irq_timings_next_event_index(buffer, count, period_max);
+	i = irq_timings_interval_index(ti->intervals[ti->count - 1]);
+
+	if (index != i) {
+		pr_err("Expected (%d) and computed (%d) next indexes differ\n",
+		       i, index);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init irq_timings_next_index_selftest(void)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(tis); i++) {
+
+		pr_info("---> Injecting intervals number #%d (count=%zd)\n",
+			i, tis[i].count);
+
+		ret = irq_timings_test_next_index(&tis[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int __init irq_timings_test_irqs(struct timings_intervals *ti)
 {
 	struct irqt_stat __percpu *s;
@@ -875,6 +937,10 @@ static int __init irq_timings_selftest(void)
 		goto out;
 
 	ret = irq_timings_irqs_selftest();
+	if (ret)
+		goto out;
+
+	ret = irq_timings_next_index_selftest();
 out:
 	pr_info("---------- selftest end with %s -----------\n",
 		ret ? "failure" : "success");
-- 
2.17.1

