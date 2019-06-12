Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AEDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B83B208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fj9h9MnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439022AbfFLMcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:32:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436805AbfFLMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:32:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCWe9H685877
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:32:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCWe9H685877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342761;
        bh=87ih78ecyWWEaRcf1tlUfHtm4KXNt0XJG/zmNQ/YodI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Fj9h9MnPZtoKEtfc7wBzg/g8djLgLXvMiv4QFvhn8/tgIZeG7ldH6ycBD958LwliJ
         3PZOEfohVTlQAd8aVj6jpvFjWxwaG5lf0zQw5uS+mM+HzqUggV/jtp9I/6+PQ+oANe
         8CHhJbXned9MhxHQHkS7exVEXZgplaEwX7QitIKO1uzwUiFHMXD9EFelD6FdCreICh
         V38dpdvbLbwvtb8NxhVX4MCovjHzwCzYVyRbEKuIkkBsbh66l2iWkMC4FfIjDOPrBl
         47Ok8ZjZ7tDiZk7CTPuSp9h6TuOInr+ilP7DSp0PHkyvBhIHvz5zNoJuga+rMWfAVN
         5n55OHUFWZnDQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCWenn685873;
        Wed, 12 Jun 2019 05:32:40 -0700
Date:   Wed, 12 Jun 2019 05:32:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-699785f5d898965408430e841d10cd1cb2c02a77@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, daniel.lezcano@linaro.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, daniel.lezcano@linaro.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190527205521.12091-9-daniel.lezcano@linaro.org>
References: <20190527205521.12091-9-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Add selftest for next event
 computation
Git-Commit-ID: 699785f5d898965408430e841d10cd1cb2c02a77
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

Commit-ID:  699785f5d898965408430e841d10cd1cb2c02a77
Gitweb:     https://git.kernel.org/tip/699785f5d898965408430e841d10cd1cb2c02a77
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Mon, 27 May 2019 22:55:21 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:47:05 +0200

genirq/timings: Add selftest for next event computation

The circular buffers are now validated with selftests. The next interrupt
index algorithm which is the hardest part to validate needs extra coverage.

Add a selftest which uses the intervals stored in the arrays and insert all
the values except the last one. The next event computation must return the
same value as the last element which was not inserted.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20190527205521.12091-9-daniel.lezcano@linaro.org

---
 kernel/irq/timings.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
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
