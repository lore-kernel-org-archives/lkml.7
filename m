Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452F520838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 16:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA+DBK1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfL1QTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 11:19:18 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55593 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfL1QTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 11:19:17 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so6020391pjz.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 08:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8Z+N/807+ZsOkZBMDVN42U9UfY5gz5RxtiyFOSkakOI=;
        b=BA+DBK1PqlTEoEn8M7tM2h+N3oiR76NJtjhQT0eP6TGXWdlQ7cGgo4U90Rp7UWRWcB
         3U16ZpczVLYZMMrJl05JvU6dFvqfriWVcYDuw+k5/pQWZn2KuB+TJYOWz8d9JMLxESF7
         XNtydTmkY5AezOjRtO7yNxbUXHii/xd8kx6y9EVRyCcIeHYPNUHEr8YYnNZMc6qotokj
         MmbM7Tpw4Pzgj/e0zrgZ+TAps4ZHw47j5eQqpZlvPGuH8a6zH7vdoM1GLErBe5XoX4hk
         fH8dZg4cQYRc2AkWjpcJZR4enXSCVA+6fixIGRD4uiqN8xL6PglRDp3IvYGAYb+K5H8T
         jygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Z+N/807+ZsOkZBMDVN42U9UfY5gz5RxtiyFOSkakOI=;
        b=fKwObrbX+zDd9PdbbbicLtLC+ExaLxuL7QvO4Q92coouCZQw7mf2FckXLDu50/IBnu
         9z3R8vnTl/56qFxjHAlbnSb2x0jPrsYU343FUDjfwzphucDgZmUk6riA1U2NGaL+NyfR
         TZZlVC8yF72I5//dB47k1XdgxtA14qr3798SfTbXrvsaT5g9c6KJKyItqP6SFMoLK6f4
         uT3lNI/CEy+TxaFwCxUOClbvm08+VtTsIpnYu6j6HkVKkYB54M2yoUDv4mQ78ELWysj5
         LRJYpKo6Sq/XG5ungZjf18tFQyEdSaTFIjdw+8eA+TCiqYVAoDpGyOl1YaLoOXInLVw5
         vRLw==
X-Gm-Message-State: APjAAAUnwOk6KCMbcv7BLJ1JVq8Ck7HIpSuKlTjQ4nHWcVfMyIR4Cr/V
        yVCziegAOSUG809+dY2ew2M=
X-Google-Smtp-Source: APXvYqxrWpkYGkK3p5y4f4zsKW2hPcHrmE2jQ9thcb+X3PPKcxO/98zEN+u0GqAcUsv7hVw6awBuZQ==
X-Received: by 2002:a17:90a:b10a:: with SMTP id z10mr34398757pjq.115.1577549956816;
        Sat, 28 Dec 2019 08:19:16 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id h26sm48304883pfr.9.2019.12.28.08.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 08:19:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        heiko.carstens@de.ibm.com, mark.rutland@arm.com,
        paulmck@kernel.org, schwidefsky@de.ibm.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] stop_machine: Make stop_cpus static
Date:   Sat, 28 Dec 2019 16:19:12 +0000
Message-Id: <20191228161912.24082-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function stop_cpus() is only used internally by the
stop_machine for stop multiple cpus.

Make it static.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/stop_machine.h | 9 ---------
 kernel/stop_machine.c        | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 648298f877da..76d8b09384a7 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -32,7 +32,6 @@ int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
 int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *arg);
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			 struct cpu_stop_work *work_buf);
-int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
@@ -81,14 +80,6 @@ static inline bool stop_one_cpu_nowait(unsigned int cpu,
 	return false;
 }
 
-static inline int stop_cpus(const struct cpumask *cpumask,
-			    cpu_stop_fn_t fn, void *arg)
-{
-	if (cpumask_test_cpu(raw_smp_processor_id(), cpumask))
-		return stop_one_cpu(raw_smp_processor_id(), fn, arg);
-	return -ENOENT;
-}
-
 #endif	/* CONFIG_SMP */
 
 /*
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 5d68ec4c4015..865bb0228ab6 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -442,7 +442,7 @@ static int __stop_cpus(const struct cpumask *cpumask,
  * @cpumask were offline; otherwise, 0 if all executions of @fn
  * returned 0, any non zero return value if any returned non zero.
  */
-int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
+static int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
 {
 	int ret;
 
-- 
2.17.1

