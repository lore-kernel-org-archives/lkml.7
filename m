Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B5BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894DA208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmBOW939"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfEMKaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52112 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfEMKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id o189so13314197wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYRnpnNRQ7/Yn4sCtvCK5+WUBHE5avZWWYPxLbImYZU=;
        b=UmBOW939gLTq232p+iwK3f8nCudEncfvXezxIaacngiWvHR8NtB7S5O7nxFq1G9SKz
         ssd8Zi5tDEqiCdHVFS51Gw4UZYFqp+S7fqqHcqiaXYKet2KtrLRD4PD2VZE59dgrsvkj
         3R4liWCFsEBSbG2sUJaHoZ0Uxw3sbivwcwRMp+bY0Xm1ayPdP+ZN8KhMJETc4zqYoZ8o
         wt2DLh1MiZuUNBhKsYrmewM0i3WxsFP7W4pU5/eGIF0G7ZOQ+c50PZFxrz8wIz4DAg6c
         zUeryUgBE5tPYqmhPjZvjMcCmCUFy9WkLnU2Mc4tn0/cHh9dF3Sr28aGM8yAVsYnP8x7
         r4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYRnpnNRQ7/Yn4sCtvCK5+WUBHE5avZWWYPxLbImYZU=;
        b=VOGuMlew3N0vfOTc4bJcwazVoROoZnyvR0f/PrlobpRVzWcN28Mj+2w6wwBJWewUFR
         OhYyBd+HiTwXCZbEXXRfS6FJyE5DyfxHQ/CVpzMwDZ/16+zK9lVisYyaOdyH2S4uv+7c
         tWBzPUpNTjiJ9If82jZUeQLC2S5ORo3uAJlIZmIPOSoVmR5ZZGgC332EfLpBc3s8ZOAe
         8q/IVef8RLQZsLuonyGpx+e2i/EqjXB+TAOL0Mu8BMbZQlcYLRVm7OHL6NTOUo0yy5Th
         bAfaDoEW7yGAEpTomJDS/AtWMFEXX/kOVha+/dIFVG01QgF+2mR05qAQcRXmUHUyBF2Z
         hLyg==
X-Gm-Message-State: APjAAAVxo5D98w9+S0vIEl/b6qI80EAoq3hTKXVzLJeMLrnMsEHTXEvD
        BHP/Ka4AYaZUaattKcPgyp6Fi6mjExo=
X-Google-Smtp-Source: APXvYqyy/1L6imqzBDSn9+0fWvo5keqx0qRGE8q6hHZf+fXclKoMF2IapzzL8fxz7CB5t4Cnh59PbQ==
X-Received: by 2002:a1c:ca08:: with SMTP id a8mr14602038wmg.5.1557743419532;
        Mon, 13 May 2019 03:30:19 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] genirq/timings: Add selftest for next event computation
Date:   Mon, 13 May 2019 12:29:53 +0200
Message-Id: <20190513102953.16424-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
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
index 5e4efac967fd..eb2bb1d1551f 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -705,6 +705,68 @@ static struct timings_intervals tis[] __initdata = {
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
@@ -876,6 +938,10 @@ static int __init irq_timings_selftest(void)
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

