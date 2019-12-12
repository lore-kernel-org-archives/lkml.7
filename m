Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98B6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FADC24654
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cZ5wPiQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfLLELz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:11:55 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34222 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfLLELy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:11:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id d202so549028qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LZQF+cj5Bhxi0fnKlCZLhWKPYoA+2wvT9NUU/aNTlDY=;
        b=cZ5wPiQg+y190GfRUdHxHfr45yDlULDc+9gI0ExsfvWfblHgptSgKSVJAQTST1WZ9H
         cvrmmq1s3R58rGA3H/JzHXAQweX4kpdOrOBQbGLyOZlpNtLzTOLUyq/B4jNukqqMlJq8
         /+g6BeaVhxGzA6pIiiIvv/kEkPew/Uykzeqq2Wy0L1iPbd4LfXaeSSKTMNpqU+9mKy22
         apevOxfODbGBUHCKxSZKv3EXV36mN8sWMYuVodf0gi/RrmHQ/ZFNs4xXvJgt0vI6r8+e
         WUo0s5ZYOiRnxHlcQRG8tyKkdABID6J2DI1YGhTDOhvMUnJtYAksegkpPpYI5uaVQh89
         o70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LZQF+cj5Bhxi0fnKlCZLhWKPYoA+2wvT9NUU/aNTlDY=;
        b=osNOuh/StkiteKu205G5X7hZA0S9xKRdTgW42a4cMOsz3bj/3SUtPt1/nYPSDsvmgb
         B2+H02Q6OoUFX6Fk47LRWrdbwt1eUKJHxfmfK/WoIf4SxYvovI9HNOcCNQ24malZwd17
         FkDuzuvUv/0MJFKpEZ18rFarcY/VZm72fdOKlueGbD6dFZb177fGozwEMir77eUgPd/O
         vu1oarJAW1JGi/laEH9TbtaQFAl6KNzuDEgyFoN5WQuBWDNIEKihaRGcETo7NsGEza1L
         WAYPbLu3aNs1NgbdFuJV0hmVYa0ci8i0WySF1d8V7vw7585yQqUmCuCquOTBRdUKaykZ
         wSnQ==
X-Gm-Message-State: APjAAAUnYPPCD0xly484SCgkKf2R2XT3FTckh0lUg6O2UjW/OO9GiFW9
        FftP3goqjfeTPaGOrUgsyXJf/Q==
X-Google-Smtp-Source: APXvYqxZE63w//InsBXreUdmI0+0yaAR9HoOpTFmb7W5hLezN0UM8HZzlKBwCTqDJ1KpkGsZvHvDyg==
X-Received: by 2002:a37:4943:: with SMTP id w64mr6275611qka.300.1576123913015;
        Wed, 11 Dec 2019 20:11:53 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id s11sm1364126qkg.99.2019.12.11.20.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 20:11:52 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v6 2/7] sched: Add hook to read per cpu thermal pressure.
Date:   Wed, 11 Dec 2019 23:11:43 -0500
Message-Id: <1576123908-12105-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce arch_scale_thermal_capacity to retrieve per cpu thermal
pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/linux/sched/topology.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f341163..f1e22f9 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -225,6 +225,14 @@ unsigned long arch_scale_cpu_capacity(int cpu)
 }
 #endif
 
+#ifndef arch_scale_thermal_capacity
+static __always_inline
+unsigned long arch_scale_thermal_capacity(int cpu)
+{
+	return 0;
+}
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
-- 
2.1.4

