Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC9C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE1720880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfDHWJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:09:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52259 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfDHWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:09:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so1041851wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 15:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMu642LOwNKEI7uhA0nV1KQTUuMvKmEA8qoBm47QQ4I=;
        b=GOGZ+VVxAmjCSdZYM+QtZPJ7zmhi77HKPHi2PSi03A3n6T7Wcbvs4YhvMgXdFwsrFq
         3gPwcv/vrX7j88aw8o02lZRZ+A962kfRuF3Ha6FvotAJOGzrBD8HnKmGrn8+vjoyr6yj
         gZ8UDaqcN0mkcnYA/U5v8v2ZKbcMYod1zcNXXwuOwFNEzfScpySgWmAqw9ajhuiSMHlC
         EGvshkio41wUx5XWCdP+NUUExshDASJqsxIuKopAX0RFZOWgCQwiH+cBBZLaWPddQrmA
         BwZDSKupNMyVrEiXtwzav4hzeNC7ePV5Q+y64JbVQrdbUhBktOSIDJKgHkVlYQXi4Uhr
         9OwQ==
X-Gm-Message-State: APjAAAXRtVavTx/9LIdd2fwiXU/VDFd27me0lXVSNfJ85OuzP52dO6ML
        BQE1qLVyBn+ZC0i5jhWn7J24xlBYXyQ=
X-Google-Smtp-Source: APXvYqwS1+/E73FlsmRjR/sFeVCLnC/Y5oCYYM47oEry67YFQmXmRY93uNoJXdZImVpVVKVlCXfaeQ==
X-Received: by 2002:a7b:c76c:: with SMTP id x12mr19504244wmk.97.1554761391162;
        Mon, 08 Apr 2019 15:09:51 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id k9sm42730894wru.55.2019.04.08.15.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 15:09:50 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 2/2] kernel: use sysctl shared variables for range check
Date:   Tue,  9 Apr 2019 00:09:25 +0200
Message-Id: <20190408220925.13077-3-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408220925.13077-1-mcroce@redhat.com>
References: <20190408220925.13077-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the shared variables for range check, instead of declaring a local one
in every source file.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 kernel/pid_namespace.c |   3 +-
 kernel/sysctl.c        | 193 ++++++++++++++++++++---------------------
 kernel/ucount.c        |   6 +-
 3 files changed, 98 insertions(+), 104 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index aa6e72fb7c08..ddbb51bc4968 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -290,14 +290,13 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 }
 
 extern int pid_max;
-static int zero = 0;
 static struct ctl_table pid_ns_ctl_table[] = {
 	{
 		.procname = "ns_last_pid",
 		.maxlen = sizeof(int),
 		.mode = 0666, /* permissions are checked in the handler */
 		.proc_handler = pid_ns_ctl_handler,
-		.extra1 = &zero,
+		.extra1 = (void *)&sysctl_zero,
 		.extra2 = &pid_max,
 	},
 	{ }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 553b19439714..d6f4b26951e1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -123,9 +123,6 @@ static int sixty = 60;
 #endif
 
 static int __maybe_unused neg_one = -1;
-
-static int zero;
-static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
@@ -388,8 +385,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_schedstats,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif /* CONFIG_SCHEDSTATS */
 #endif /* CONFIG_SMP */
@@ -421,7 +418,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "numa_balancing",
@@ -429,8 +426,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_numa_balancing,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
@@ -462,8 +459,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -473,7 +470,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 #endif
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
@@ -483,8 +480,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_energy_aware_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_PROVE_LOCKING
@@ -549,7 +546,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &neg_one,
-		.extra2		= &one,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_LATENCYTOP
@@ -683,8 +680,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_MODULES
@@ -702,8 +699,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_UEVENT_HELPER
@@ -862,7 +859,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &ten_thousand,
 	},
 	{
@@ -878,8 +875,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "kptr_restrict",
@@ -887,7 +884,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 #endif
@@ -912,8 +909,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "watchdog_thresh",
@@ -921,7 +918,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_watchdog_thresh,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &sixty,
 	},
 	{
@@ -930,8 +927,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= NMI_WATCHDOG_SYSCTL_PERM,
 		.proc_handler   = proc_nmi_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "watchdog_cpumask",
@@ -947,8 +944,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_soft_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "softlockup_panic",
@@ -956,8 +953,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #ifdef CONFIG_SMP
 	{
@@ -966,8 +963,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif /* CONFIG_SMP */
 #endif
@@ -978,8 +975,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #ifdef CONFIG_SMP
 	{
@@ -988,8 +985,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif /* CONFIG_SMP */
 #endif
@@ -1102,8 +1099,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "hung_task_check_count",
@@ -1111,7 +1108,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "hung_task_timeout_secs",
@@ -1188,7 +1185,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
 		.mode		= 0644,
 		.proc_handler	= perf_proc_update_handler,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "perf_cpu_time_max_percent",
@@ -1196,7 +1193,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
 		.mode		= 0644,
 		.proc_handler	= perf_cpu_time_max_percent_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1205,7 +1202,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_max_stack),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &six_hundred_forty_kb,
 	},
 	{
@@ -1214,7 +1211,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_thousand,
 	},
 #endif
@@ -1224,8 +1221,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	{
@@ -1234,8 +1231,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= timer_migration_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_BPF_SYSCALL
@@ -1246,8 +1243,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "bpf_stats_enabled",
@@ -1255,8 +1252,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_bpf_stats_enabled),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_bpf_stats,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
@@ -1266,8 +1263,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
@@ -1277,8 +1274,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= stack_erasing_sysctl,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{ }
@@ -1291,7 +1288,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_overcommit_memory),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -1300,7 +1297,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_oom),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -1337,7 +1334,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "dirty_background_ratio",
@@ -1345,7 +1342,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirty_background_ratio),
 		.mode		= 0644,
 		.proc_handler	= dirty_background_ratio_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1362,7 +1359,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_dirty_ratio),
 		.mode		= 0644,
 		.proc_handler	= dirty_ratio_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1386,7 +1383,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirty_expire_interval),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "dirtytime_expire_seconds",
@@ -1394,7 +1391,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirtytime_expire_interval),
 		.mode		= 0644,
 		.proc_handler	= dirtytime_interval_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "swappiness",
@@ -1402,7 +1399,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_swappiness),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 #ifdef CONFIG_HUGETLB_PAGE
@@ -1427,8 +1424,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen			= sizeof(int),
 		.mode			= 0644,
 		.proc_handler	= sysctl_vm_numa_stat_handler,
-		.extra1			= &zero,
-		.extra2			= &one,
+		.extra1			= (void *)&sysctl_zero,
+		.extra2			= (void *)&sysctl_one,
 	},
 #endif
 	 {
@@ -1459,7 +1456,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &four,
 	},
 #ifdef CONFIG_COMPACTION
@@ -1485,8 +1482,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 
 #endif /* CONFIG_COMPACTION */
@@ -1496,7 +1493,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(min_free_kbytes),
 		.mode		= 0644,
 		.proc_handler	= min_free_kbytes_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "watermark_boost_factor",
@@ -1504,7 +1501,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(watermark_boost_factor),
 		.mode		= 0644,
 		.proc_handler	= watermark_boost_factor_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "watermark_scale_factor",
@@ -1512,7 +1509,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(watermark_scale_factor),
 		.mode		= 0644,
 		.proc_handler	= watermark_scale_factor_sysctl_handler,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &one_thousand,
 	},
 	{
@@ -1521,7 +1518,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(percpu_pagelist_fraction),
 		.mode		= 0644,
 		.proc_handler	= percpu_pagelist_fraction_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #ifdef CONFIG_MMU
 	{
@@ -1530,7 +1527,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_max_map_count),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #else
 	{
@@ -1539,7 +1536,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_nr_trim_pages),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #endif
 	{
@@ -1555,7 +1552,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(block_dump),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "vfs_cache_pressure",
@@ -1563,7 +1560,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_vfs_cache_pressure),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 	{
@@ -1572,7 +1569,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_legacy_va_layout),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #endif
 #ifdef CONFIG_NUMA
@@ -1582,7 +1579,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(node_reclaim_mode),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "min_unmapped_ratio",
@@ -1590,7 +1587,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_min_unmapped_ratio),
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1599,7 +1596,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_min_slab_ratio),
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 #endif
@@ -1650,7 +1647,7 @@ static struct ctl_table vm_table[] = {
 #endif
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #endif
 #ifdef CONFIG_HIGHMEM
@@ -1660,8 +1657,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_highmem_is_dirtyable),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_MEMORY_FAILURE
@@ -1671,8 +1668,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_memory_failure_early_kill),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "memory_failure_recovery",
@@ -1680,8 +1677,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_memory_failure_recovery),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{
@@ -1853,8 +1850,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "protected_hardlinks",
@@ -1862,8 +1859,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "protected_fifos",
@@ -1871,7 +1868,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -1880,7 +1877,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -1889,7 +1886,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_coredump,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
@@ -1926,7 +1923,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 	{ }
 };
@@ -1948,8 +1945,8 @@ static struct ctl_table debug_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_kprobes_optimization_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{ }
diff --git a/kernel/ucount.c b/kernel/ucount.c
index f48d1b6376a4..ba7b8282d299 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -57,16 +57,14 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-static int zero = 0;
-static int int_max = INT_MAX;
 #define UCOUNT_ENTRY(name)				\
 	{						\
 		.procname	= name,			\
 		.maxlen		= sizeof(int),		\
 		.mode		= 0644,			\
 		.proc_handler	= proc_dointvec_minmax,	\
-		.extra1		= &zero,		\
-		.extra2		= &int_max,		\
+		.extra1		= (void *)&sysctl_zero,		\
+		.extra2		= (void *)&sysctl_int_max,	\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
-- 
2.21.0

