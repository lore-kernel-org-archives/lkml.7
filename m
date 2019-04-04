Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E944DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DA42082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjeas8Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfDDMH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:07:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33318 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDMHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:07:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so1096106plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wuNi3fqQOIOEnEta16uX3p0vIkpp0Kua2RmpVYh4mmQ=;
        b=Gjeas8Zdgmn5QvIOcTGFgqrfK/qDxur5nhzr4bLEBNY85SY17ve2wxxjTsMMGfmfIW
         XKZHX0Q+wv/T/v/FhPx5Ib7/xzRhMYIXeBaK+pSd9F76aGEPmKiRciJZkHigBO2CnUYH
         6k13FQ54x4uuEr6Z3cmAlXbZsWUFUBLjnwI+KV6VRp29o3eQvS3d59cNKVus8nCIaZq8
         hC2YpNEwEycXYOk9ZgHnJtLjRbcEX9RIAIvEIJBGSBDx5g3Zw9My54P3AFgw/dUfnqi9
         sPPPuGaauyW0ZDT19go3atxGZzhd07vtdlqcM8+qETgY04vTYo5r9IBnLj2CzBy3R4c2
         7KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wuNi3fqQOIOEnEta16uX3p0vIkpp0Kua2RmpVYh4mmQ=;
        b=Z668JIjlFUHw/KimRV7dctMoLtxemUQTrNw+B/h5xH/rE5QqqcxRRal/IF3YPKz9RU
         98shSyL3+I2nwN670LcFuzI8yhBXDQTQ+e27cKyb9jthK2/BbwNFWjIdNBqXQVdZ2uYI
         diAzfqS9kDVfokBnLJHkzPTbIiFyjVINCKEEBjIFzshiMVZ1w5VmQ6qv8ONWCuTgkRVl
         Hq5CIWImYiCQujCFDhYhQtv1mOTPm9ZrXnmnbOfGT9WsOyeq517zofE3zq1AzFog8T0c
         YywTMRq73+GHdXgo52aABtsJ6LqYVJ9F+khbcKf9nMse66pKWk6x7zbuSiS+cBSOsIhx
         1sog==
X-Gm-Message-State: APjAAAXiN6UM/tbmV1HuHcNyV03/xgcQ389PSpwJtS0BBuXAqDfLbZmF
        75jJN5ouYWAronpt+8ciGDR78nU6kk8=
X-Google-Smtp-Source: APXvYqz/hU0sj7JJPBywoViPaCl+IySB8tG+VuvYz3AK0U51pdB2jZxxBJqgRLkpMlTr8rO9A1h8lg==
X-Received: by 2002:a17:902:2b87:: with SMTP id l7mr6101212plb.38.1554379642984;
        Thu, 04 Apr 2019 05:07:22 -0700 (PDT)
Received: from bobo.local0.net (193-116-89-42.tpgi.com.au. [193.116.89.42])
        by smtp.gmail.com with ESMTPSA id j22sm24720668pfn.129.2019.04.04.05.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:07:22 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec freeze
Date:   Thu,  4 Apr 2019 22:07:02 +1000
Message-Id: <20190404120704.18479-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404120704.18479-1-npiggin@gmail.com>
References: <20190404120704.18479-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch chooses a housekeeping CPU to be the primary when disabling
CPUs for suspend / kexec freeze. This should not have any effect until
a later change because CPU0 is always a housekeeping CPU.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/cpu.h |  2 +-
 kernel/cpu.c        | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..b11c94d88953 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -134,7 +134,7 @@ static inline void put_online_cpus(void) { cpus_read_unlock(); }
 extern int freeze_secondary_cpus(int primary);
 static inline int disable_nonboot_cpus(void)
 {
-	return freeze_secondary_cpus(0);
+	return freeze_secondary_cpus(-1);
 }
 extern void enable_nonboot_cpus(void);
 #else /* !CONFIG_PM_SLEEP_SMP */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6754f3ecfd94..d1bf6e2b4752 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -9,6 +9,7 @@
 #include <linux/notifier.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/hotplug.h>
+#include <linux/sched/isolation.h>
 #include <linux/sched/task.h>
 #include <linux/sched/smt.h>
 #include <linux/unistd.h>
@@ -1199,8 +1200,15 @@ int freeze_secondary_cpus(int primary)
 	int cpu, error = 0;
 
 	cpu_maps_update_begin();
-	if (!cpu_online(primary))
+	if (primary == -1) {
 		primary = cpumask_first(cpu_online_mask);
+		if (!housekeeping_cpu(primary, HK_FLAG_TIMER))
+			primary = housekeeping_any_cpu(HK_FLAG_TIMER);
+	} else {
+		if (!cpu_online(primary))
+			primary = cpumask_first(cpu_online_mask);
+	}
+
 	/*
 	 * We take down all of the non-boot CPUs in one shot to avoid races
 	 * with the userspace trying to use the CPU hotplug at the same time
-- 
2.20.1

