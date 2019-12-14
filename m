Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D8C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 19:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D982073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 19:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT1l4Jpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfLNTvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 14:51:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39742 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 14:51:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so1280353pga.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tDaF7izt0L7igfa3lW48weTP83g/s2HX6u5IMVIrd+o=;
        b=uT1l4JpvwnXYDh9QLBKOkzHjEyKwFTtdyjXvp38rzhl/nm6CkZtAYnEtXTOSShGIKq
         JJSi9KMXJmSpvEu1YhS2UFAwlqShZ9PsnS4e+5TFSdr2x9Zw2k+ZS9S9P6p4eZGfjbLH
         C8I2KONF71mBr9upH/4i5aLqLPth3/mRVty6HjH/S8vm0LZYGQzlLkhANbXSw/irdDoU
         pBiYURXS756awwJ65Oxd+T1GT5KvbwG7Fp4QQAFfh8XjdcSaF9D5MJmmDHhoZQM9bfAY
         jjdDN58qnWYRXIf55MXamqhLeIExDHe1o3WSyxvlXFGiHKqmSou//XTPz3EyBJHlXj8h
         47nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tDaF7izt0L7igfa3lW48weTP83g/s2HX6u5IMVIrd+o=;
        b=EBdp4oGF17CL1Sj8H2Cpt5VTTcEn3LI0wkUtKZiSf2GGKznZAVdK2fX/6/4yYqo/v5
         JUes6UICtCOSoQZX+z4t6K8+yyUqyy0K/MmZq4YuoK6nDlRjCRF6yMKKr/qt1vW5QiCO
         luRJsCig3e05nqe2stnTbGj3XYA4X9LlknvNDIusfCPkDPt8h15qavYijwvE8ITTCFr1
         MhaHX6qNOQbwsLruvRvmRKLF1syt6e63G6/KFfCAg6TAL/QJW5reDi2o/A/Fy1mXUHoU
         fFWi0weLkl1sFBS+vGVRyFs7qxfJlhYAJPF7ajq5DrpSIqAGqBH/YeSNY/vxiBGh6w/t
         bKrQ==
X-Gm-Message-State: APjAAAUb0v44sqPEPmEorCxnxzMYaFqF7aXWK4TA92qNdvJYlWZgUpby
        9I7S5ETILa8dbuEpXYWSpO4=
X-Google-Smtp-Source: APXvYqyTIFXpoecTesFuwxPi+0SZbo2TU5fh45dSfRFDa6AKO6UlbkTeRsDTEh52XdX7sWgK7qytTg==
X-Received: by 2002:a63:111e:: with SMTP id g30mr7372264pgl.251.1576353070559;
        Sat, 14 Dec 2019 11:51:10 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id 67sm16516182pfw.82.2019.12.14.11.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Dec 2019 11:51:09 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tglx@linutronix.de, heiko.carstens@de.ibm.com,
        peterz@infradead.org, bhelgaas@google.com, schwidefsky@de.ibm.com,
        mark.rutland@arm.com, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] stop_machine: remove try_stop_cpus helper
Date:   Sat, 14 Dec 2019 19:51:07 +0000
Message-Id: <20191214195107.26480-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_stop_cpus is not used after this:

commit c190c3b16c0f ("rcu: Switch synchronize_sched_expedited() to
stop_one_cpu()")

So remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/stop_machine.h |  7 -------
 kernel/stop_machine.c        | 30 ------------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index f9a0c6189852..648298f877da 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -33,7 +33,6 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			 struct cpu_stop_work *work_buf);
 int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
-int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
@@ -90,12 +89,6 @@ static inline int stop_cpus(const struct cpumask *cpumask,
 	return -ENOENT;
 }
 
-static inline int try_stop_cpus(const struct cpumask *cpumask,
-				cpu_stop_fn_t fn, void *arg)
-{
-	return stop_cpus(cpumask, fn, arg);
-}
-
 #endif	/* CONFIG_SMP */
 
 /*
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 1fe34a9fabc2..5d68ec4c4015 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -453,36 +453,6 @@ int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
 	return ret;
 }
 
-/**
- * try_stop_cpus - try to stop multiple cpus
- * @cpumask: cpus to stop
- * @fn: function to execute
- * @arg: argument to @fn
- *
- * Identical to stop_cpus() except that it fails with -EAGAIN if
- * someone else is already using the facility.
- *
- * CONTEXT:
- * Might sleep.
- *
- * RETURNS:
- * -EAGAIN if someone else is already stopping cpus, -ENOENT if
- * @fn(@arg) was not executed at all because all cpus in @cpumask were
- * offline; otherwise, 0 if all executions of @fn returned 0, any non
- * zero return value if any returned non zero.
- */
-int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
-{
-	int ret;
-
-	/* static works are used, process one request at a time */
-	if (!mutex_trylock(&stop_cpus_mutex))
-		return -EAGAIN;
-	ret = __stop_cpus(cpumask, fn, arg);
-	mutex_unlock(&stop_cpus_mutex);
-	return ret;
-}
-
 static int cpu_stop_should_run(unsigned int cpu)
 {
 	struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
-- 
2.17.1

