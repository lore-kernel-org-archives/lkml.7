Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C743DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A39206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EqBeXVJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfJIX2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:28:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42373 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbfJIX2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:28:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so1802701pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdRaqwSSOVOif0Za6BOtA/6jl6KJr7o8HDuMwuwTmDU=;
        b=EqBeXVJ2xurtmThotzdiZDoOsOSg0Hiws3LQsV+w8T/wnHH2kReN3bxh0ndjX7G7EJ
         2BYjsWWG+DIsoGQ9PxtZWVbY0d4ovBwZAbniCsJC//LqauJv0Vp5Qm4ruP2vc+3ULyno
         a9+zebdMpBIKpsHJI+Z3OpCZoVF3SsLIi090M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdRaqwSSOVOif0Za6BOtA/6jl6KJr7o8HDuMwuwTmDU=;
        b=JNbvd9+SeFy58jNdHdIbhJ75OxZzpYxsaA1bjC9DLUYbtXbWtXUUmwdODNDbG2+VrW
         zAD/OYKey5Q85zTZWMOYsKA9AQVJnotrSCTEcB4dLhKxNcsLvqzh3ZJ2b8VZrAKjKcZL
         QuA7yl9wPRvG/URYbCSIANntgzX7KJmSyknolo2qc1fnsz9oGZyzAXKn6ZGhJeeYEUEY
         23Ayzn5tDtiVr/g6rIYqIwKOHtdZceB6yibAN9SCrDvromAmTFuT8tSTsbALhpjqly/3
         rvQM0zChbjwemc2sAqBMMoilMEeYDLpRR5ltG5PilqmX43BEjQm/oVKUnlnePqljOmEp
         JA/g==
X-Gm-Message-State: APjAAAWkU3f7tVjM9Lo80gYYtUeXwpeaMnm4RhQNUVz0ax0PNwttpVBA
        ziuNpQ350WiwZnQCgTXGd+2L2w==
X-Google-Smtp-Source: APXvYqx01VvaYWM+Sf5XKBqF4Gkqq8akeAG4w2IRQQ0RTuqpP6P7g9b1gkXgSatA3L5YueX0103oXg==
X-Received: by 2002:a17:902:36a:: with SMTP id 97mr5822401pld.83.1570663712306;
        Wed, 09 Oct 2019 16:28:32 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id m2sm3218069pff.154.2019.10.09.16.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:28:31 -0700 (PDT)
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
Subject: [PATCH RFC v2] reboot: hotplug cpus in migrate_to_reboot_cpu()
Date:   Thu, 10 Oct 2019 07:26:55 +0800
Message-Id: <20191009232655.48583-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently system reboots would use arch specific codes (eg. smp_send_stop)
to offline non reboot cpus. Some arch like arm64, arm, and x86... would set
offline masks to cpu without really offline them. Thus causing some race
condition and kernel warning comes out sometimes when system reboots. We
can do cpu hotplug in migrate_to_reboot_cpu() to avoid this issue.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
change log:
v1 --> v2:
Call hotplug function in #ifdef CONFIG instead of IS_ENABLED.
(Reported-by: kbuild test robot <lkp@intel.com>)

kernel warnings at reboot:
[1] https://lore.kernel.org/lkml/20190820100843.3028-1-hsinyi@chromium.org/
[2] https://lore.kernel.org/lkml/20190727164450.GA11726@roeck-us.net/
---
 include/linux/cpu.h |  1 +
 kernel/cpu.c        | 17 +++++++++++++++++
 kernel/reboot.c     |  8 ++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d0633ebdaa9c..20a4036f24ad 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -113,6 +113,7 @@ extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int cpu_down(unsigned int cpu);
+extern void offline_secondary_cpus(int primary);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index fc28e17940e0..00b2be6a662d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1058,6 +1058,23 @@ int cpu_down(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpu_down);
 
+void offline_secondary_cpus(int primary)
+{
+	int i, err;
+
+	cpu_maps_update_begin();
+
+	for_each_online_cpu(i) {
+		if (i == primary)
+			continue;
+		err = _cpu_down(i, 0, CPUHP_OFFLINE);
+		if (err)
+			pr_warn("Failed to offline cpu %d\n", i);
+	}
+	cpu_hotplug_disabled++;
+
+	cpu_maps_update_done();
+}
 #else
 #define takedown_cpu		NULL
 #endif /*CONFIG_HOTPLUG_CPU*/
diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b7f1b4..fdf6730f8a64 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt)	"reboot: " fmt
 
+#include <linux/cpu.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -220,8 +221,6 @@ void migrate_to_reboot_cpu(void)
 	/* The boot cpu is always logical cpu 0 */
 	int cpu = reboot_cpu;
 
-	cpu_hotplug_disable();
-
 	/* Make certain the cpu I'm about to reboot on is online */
 	if (!cpu_online(cpu))
 		cpu = cpumask_first(cpu_online_mask);
@@ -231,6 +230,11 @@ void migrate_to_reboot_cpu(void)
 
 	/* Make certain I only run on the appropriate processor */
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
+
+	/* Hotplug other cpus if possible */
+#ifdef CONFIG_HOTPLUG_CPU
+	offline_secondary_cpus(cpu);
+#endif
 }
 
 /**
-- 
2.23.0.700.g56cf767bdb-goog

