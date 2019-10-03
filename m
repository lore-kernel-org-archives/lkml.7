Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4505C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F100222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lFIsUPcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfJCCl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 22:41:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37980 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfJCCl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 22:41:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so732194pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 19:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ik2FpcEJAsoEvjrY43tv4BSijy6cgxBkC74pPVSQvc=;
        b=lFIsUPcb41NKPdp4EgmWrADZYfKQQsZ+7y5rYs528l8YyBmRWhsZy8D03K+dIHFstB
         f0ANfEdlaIy9MVtRqB7KCQiWx9euBclylhrjzh07/1MPALgdNoN2r/DBgJqnVTM6eKfa
         Lr3ULr3sLy3/T45rX1AVyYGKnNbF1meCPSVjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ik2FpcEJAsoEvjrY43tv4BSijy6cgxBkC74pPVSQvc=;
        b=hytLtP7H+isEyc7e7mo7ZJ2PvPjDRNzgSKUMkjeyEjsttWPb8jhJOtFNh4vyAOZJS+
         FRsI/nhVLTOxWyimsHrHjmY0qldL9WQ0khAVJcPZdS6jf2eLfP9lCVPjZhichzVQUaoj
         Tul2a2Wh8sGNLQawDQUE+qzLb2JACXtx+wFEl60J4Big8ltK3OUAeYb4wZpTmQOP2muG
         jAMRFJwLcq+A13TGNlbZIIEc5WV6CIuD+RLxSY5yI+FQ3qa+15FIvyIZmkDm6uouwuNJ
         5GwZDf95WFDg+bu6XS4ASc901iFFxgAmX58Axw3CnNoZgVH1O9XQl2wy7d1iyIMlRR4D
         vMZA==
X-Gm-Message-State: APjAAAXj4A1IbiP0KqmsJ5yViamHQ5N7Q0VaE4dK+o/MfSRrK87oqwTZ
        WGQw7rre66aUet5kNSpm2OyfWw==
X-Google-Smtp-Source: APXvYqxJVgDreArUVY03HVqiDLVC5vH8pPyk7nTuF4POPhIr0JYAUyImOqHc9nQTHShRhq3wpa/DGg==
X-Received: by 2002:a17:90a:a6e:: with SMTP id o101mr8071533pjo.71.1570070485018;
        Wed, 02 Oct 2019 19:41:25 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id y10sm754646pfe.148.2019.10.02.19.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 19:41:24 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] reboot: hotplug cpus in migrate_to_reboot_cpu()
Date:   Thu,  3 Oct 2019 10:41:01 +0800
Message-Id: <20191003024101.57700-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently system reboots use arch specific codes (eg. smp_send_stop) to
offline non reboot cpus. Some arch like arm64, arm, and x86... set offline
masks to cpu without really offlining them. Thus it causes some race
condition and kernel warning comes out sometimes when system reboots. We
can do cpu hotplug in migrate_to_reboot_cpu() to avoid this issue.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
kernel warnings at reboot:
[1] https://lore.kernel.org/lkml/20190820100843.3028-1-hsinyi@chromium.org/
[2] https://lore.kernel.org/lkml/20190727164450.GA11726@roeck-us.net/
---
 kernel/cpu.c    | 35 +++++++++++++++++++++++++++++++++++
 kernel/reboot.c | 18 ------------------
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index fc28e17940e0..2f4d51fe91e3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -31,6 +31,7 @@
 #include <linux/relay.h>
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/reboot.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1366,6 +1367,40 @@ int __boot_cpu_id;
 
 #endif /* CONFIG_SMP */
 
+void migrate_to_reboot_cpu(void)
+{
+	/* The boot cpu is always logical cpu 0 */
+	int cpu = reboot_cpu;
+
+	/* Make certain the cpu I'm about to reboot on is online */
+	if (!cpu_online(cpu))
+		cpu = cpumask_first(cpu_online_mask);
+
+	/* Prevent races with other tasks migrating this task */
+	current->flags |= PF_NO_SETAFFINITY;
+
+	/* Make certain I only run on the appropriate processor */
+	set_cpus_allowed_ptr(current, cpumask_of(cpu));
+
+	/* Hotplug other cpus if possible */
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		int i, err;
+
+		cpu_maps_update_begin();
+
+		for_each_online_cpu(i) {
+			if (i == cpu)
+				continue;
+			err = _cpu_down(i, 0, CPUHP_OFFLINE);
+			if (err)
+				pr_info("Failed to offline cpu %d\n", i);
+		}
+		cpu_hotplug_disabled++;
+
+		cpu_maps_update_done();
+	}
+}
+
 /* Boot processor state steps */
 static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_OFFLINE] = {
diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b7f1b4..f0046be34a60 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -215,24 +215,6 @@ void do_kernel_restart(char *cmd)
 	atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
 }
 
-void migrate_to_reboot_cpu(void)
-{
-	/* The boot cpu is always logical cpu 0 */
-	int cpu = reboot_cpu;
-
-	cpu_hotplug_disable();
-
-	/* Make certain the cpu I'm about to reboot on is online */
-	if (!cpu_online(cpu))
-		cpu = cpumask_first(cpu_online_mask);
-
-	/* Prevent races with other tasks migrating this task */
-	current->flags |= PF_NO_SETAFFINITY;
-
-	/* Make certain I only run on the appropriate processor */
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-}
-
 /**
  *	kernel_restart - reboot the system
  *	@cmd: pointer to buffer containing command to execute for restart
-- 
2.23.0.444.g18eeb5a265-goog

