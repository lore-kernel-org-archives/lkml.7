Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760A220865
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfKYL2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:28:16 -0500
Received: from foss.arm.com ([217.140.110.172]:48980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbfKYL2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:28:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB8131B;
        Mon, 25 Nov 2019 03:28:13 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7CC03F52E;
        Mon, 25 Nov 2019 03:28:11 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] x86: Replace cpu_up/down with devcie_online/offline
Date:   Mon, 25 Nov 2019 11:27:45 +0000
Message-Id: <20191125112754.25223-6-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125112754.25223-1-qais.yousef@arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/topology.c | 4 ++--
 arch/x86/mm/mmio-mod.c     | 8 ++++++--
 arch/x86/xen/smp.c         | 4 +++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index be5bc2e47c71..3b253088615e 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -69,7 +69,7 @@ int _debug_hotplug_cpu(int cpu, int action)
 
 	switch (action) {
 	case 0:
-		ret = cpu_down(cpu);
+		ret = device_offline(get_cpu_device(cpu));
 		if (!ret) {
 			pr_info("DEBUG_HOTPLUG_CPU0: CPU %u is now offline\n", cpu);
 			dev->offline = true;
@@ -78,7 +78,7 @@ int _debug_hotplug_cpu(int cpu, int action)
 			pr_debug("Can't offline CPU%d.\n", cpu);
 		break;
 	case 1:
-		ret = cpu_up(cpu);
+		ret = device_online(get_cpu_device(cpu));
 		if (!ret) {
 			dev->offline = false;
 			kobject_uevent(&dev->kobj, KOBJ_ONLINE);
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index b8ef8557d4b3..7ec7d05335ce 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -385,13 +385,15 @@ static void enter_uniprocessor(void)
 		pr_notice("Disabling non-boot CPUs...\n");
 	put_online_cpus();
 
+	lock_device_hotplug();
 	for_each_cpu(cpu, downed_cpus) {
-		err = cpu_down(cpu);
+		err = device_offline(get_cpu_device(cpu));
 		if (!err)
 			pr_info("CPU%d is down.\n", cpu);
 		else
 			pr_err("Error taking CPU%d down: %d\n", cpu, err);
 	}
+	unlock_device_hotplug();
 out:
 	if (num_online_cpus() > 1)
 		pr_warning("multiple CPUs still online, may miss events.\n");
@@ -405,13 +407,15 @@ static void leave_uniprocessor(void)
 	if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
 		return;
 	pr_notice("Re-enabling CPUs...\n");
+	lock_device_hotplug();
 	for_each_cpu(cpu, downed_cpus) {
-		err = cpu_up(cpu);
+		err = device_online(get_cpu_device(cpu));
 		if (!err)
 			pr_info("enabled CPU%d.\n", cpu);
 		else
 			pr_err("cannot re-enable CPU%d: %d\n", cpu, err);
 	}
+	unlock_device_hotplug();
 }
 
 #else /* !CONFIG_HOTPLUG_CPU */
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 7a43b2ae19f1..aaa31100a31e 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -128,11 +128,12 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 	if (xen_have_vcpu_info_placement)
 		return;
 
+	lock_device_hotplug();
 	for_each_online_cpu(cpu) {
 		if (xen_vcpu_nr(cpu) < MAX_VIRT_CPUS)
 			continue;
 
-		rc = cpu_down(cpu);
+		rc = device_offline(get_cpu_device(cpu));
 
 		if (rc == 0) {
 			/*
@@ -145,6 +146,7 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 				__func__, cpu, rc);
 		}
 	}
+	unlock_device_hotplug();
 	WARN(count, "%s: brought %d CPUs offline\n", __func__, count);
 }
 
-- 
2.17.1

