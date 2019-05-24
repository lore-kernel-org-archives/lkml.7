Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B77C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E056221773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnm0jHfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391103AbfEXLRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:17:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35452 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390960AbfEXLQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2700021wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYRnpnNRQ7/Yn4sCtvCK5+WUBHE5avZWWYPxLbImYZU=;
        b=rnm0jHfAzJ1AP8s88sisdQZ5nQbg3x8BdKbT5ATKq3y8Rvvg9GMLdi6LmAr+t24XxH
         03Vl+bouHsiOY+/gkQ+nvo6h3zSCgChzAps95hweWo4EBPX2zO3Vt4gJisiMLRZx7dY6
         XJEUp0L8pwD7v3nEeGEGFK44YIHBQWOZJHbgy+qNI+JUXwsnxa312EB1BG1g1Zscl0Ys
         Jk7JXT4zBXaOEDe/2DlkX4b3mEtotUM+OB6ji+4Rp60zc++vNUhBVERvBjnkDB4XVPcY
         jF7HD9bUDWqXH1YggzwV8bSzP3HKTaK7zsrwSTFyJgfHJ2BohOyTD6UqFtInrB8PfosK
         LHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYRnpnNRQ7/Yn4sCtvCK5+WUBHE5avZWWYPxLbImYZU=;
        b=Vs7YNgsJzQXce83BA+8XX5rv/MmCN6xfydM2iMLPR0tc3SaZJokV1JWgcM0AmHnJ4V
         9T1NPsYoe7Sd65vnts5HVXmiAyIqV2QR1+1ciPW+TLcHABa1rUEeK1QKtWT7OHc9yR7G
         7pJzx44xO72bakfGNji1Yzb0fnmyOp5hRk4AdpgsE5iqKa5gHrJKIKZv6jf5nh3Nc6Wq
         N8TwL/Mrc4szZSvsG9l85DYhApFqK17YvzyXqJc7gDmeueyPh0B1QvGTjkN9ihFENN3o
         Qeor6WD7R47mUl6VEa8sZUR83rUWWyhWQFQ1DAV1G6PgHjtNieuDkIZUKYctLkvTs9NM
         7/Dg==
X-Gm-Message-State: APjAAAWTppLanfu3II6NwljsqSIqfWvBGep0kKqeSexzfPqGJrUYe5Z9
        mkLQpsRDdA2jdjKwj/RhNebYHA==
X-Google-Smtp-Source: APXvYqxCiyh6rAWYbIziPRw6M8e/SQdLjYhO6jS9ibrCF9xxkSfFqksoNfCn5r67E3TEIpRNcX1yDQ==
X-Received: by 2002:a7b:c765:: with SMTP id x5mr9377556wmk.26.1558696612702;
        Fri, 24 May 2019 04:16:52 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 9/9] genirq/timings: Add selftest for next event computation
Date:   Fri, 24 May 2019 13:16:15 +0200
Message-Id: <20190524111615.4891-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524111615.4891-1-daniel.lezcano@linaro.org>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
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

