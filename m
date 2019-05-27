Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9165CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1A120859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajP3I39P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfE0Uzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:55:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39454 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfE0Uzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id e2so9189084wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q6ZhvfBGbl+6q1sQb52SrU1ERF5WJa7s4b+iAbTaZGw=;
        b=ajP3I39Puo+dxnCTFyLhawYAzrXoh5nwu6fXrQNgJH/tlhYbHwYcsyAQudHZJKB2I7
         +G7y9/LeTb8SFvTP0SZ7RQeLDs1lX34oTsxuB7/ytrN/mKEPcelK6iNTUQnacS9rAwmz
         7XZBY7quoXZRrLw8QcAR+6g1htYZKkiqllAXNj7kA1ZbHurIe1KDN/4NMR7xXbG7dV5B
         vs4HdwqM7xaIrPesWIuvUVh7gRDLSnX14AGsTDBrjAczicTDfitLTFMwYmLs44BSHuQH
         v18eb3XeA4mCJXuxc5UBRAYwWUkaOyUHQI/s/tkOjrXiyDocLWP9MsBZPvD1s0IKt38x
         XW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q6ZhvfBGbl+6q1sQb52SrU1ERF5WJa7s4b+iAbTaZGw=;
        b=E/YJscFZuewGRGUO/SyAmZ/28j3NkYszGJuZSnNCspFHT4941eZcCChYj+WdBH+0lb
         Ld7g/QHheEKo/5e8058C0H8RnTQfiXl3pePaNQwTmH65XTR2B1aWRepmJJcjWSpgq8Gr
         Ne5l5jBylMAfP2ZPJJaM+VFDzD2+y8uUvJoxGad5ykPT043nqCnjAzsjb6sQOoimscn/
         el5CKbv/Vpzp2Ix7PXoBZFvj4DeYaTTHWvOIV1ZBNPdoOr95Ahwc6mQeGXsug0r8MCX5
         uAtllZIzvJiT2oh6N8KjwQ4Uben4K+KMAxHFCR0l8NEE7vJYAXGQHxoYOkmtGp+2Ye7g
         xfCw==
X-Gm-Message-State: APjAAAV86Jav/7jb9JZKdgyiyrjH2ZEIW16AwgGUFHX7ZlEiEmgP4iLs
        MpOUvY/PX7Pogx8I9pPLnBlmzWzLW2Y=
X-Google-Smtp-Source: APXvYqw8cRGhCMuMXur2AudFhRsKjFM0cvVZ5eiC9EqptlAvuj5i3RnJRqrKvWq6GXeioFycBziLUw==
X-Received: by 2002:a5d:49d0:: with SMTP id t16mr13357007wrs.324.1558990544988;
        Mon, 27 May 2019 13:55:44 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 3/8] genirq/timings: Optimize the period detection speed
Date:   Mon, 27 May 2019 22:55:16 +0200
Message-Id: <20190527205521.12091-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527205521.12091-1-daniel.lezcano@linaro.org>
References: <20190527205521.12091-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a minimal period and if there is a period which is a
multiple of it but lesser than the max period then it will be detected
before and the minimal period will be never reached.

 1 2 1 2 1 2 1 2 1 2 1 2
 <-----> <-----> <----->
 <-> <-> <-> <-> <-> <->

In our case, the minimum period is 2 and the maximum period is 5. That
means all repeating pattern of 2 will be detected as repeating pattern
of 4, it is pointless to go up to 2 when searching for the period as it
will always fail.

Remove one loop iteration by increasing the minimal period to 3.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 19d2fad379ee..1d1c411d4cae 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -261,7 +261,7 @@ void irq_timings_disable(void)
 #define EMA_ALPHA_VAL		64
 #define EMA_ALPHA_SHIFT		7
 
-#define PREDICTION_PERIOD_MIN	2
+#define PREDICTION_PERIOD_MIN	3
 #define PREDICTION_PERIOD_MAX	5
 #define PREDICTION_FACTOR	4
 #define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
-- 
2.17.1

