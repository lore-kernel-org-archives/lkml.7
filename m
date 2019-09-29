Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC794C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DDA218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sBs8dYRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfI3MSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:18:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45316 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfI3MSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:18:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UC8lFD186153;
        Mon, 30 Sep 2019 12:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=ok7TwckJtagMaTdSnPLHiT1FwV6KoE8abg0uZFfBZOg=;
 b=sBs8dYRsEv+nvg0WQV7EHqa4qRzaYsTdya87rOdvIgz+nWTixBsisLisrQNMp/SMLFVE
 3y6uMMCDpD+pxS/5ik5BtI+3nsia283zURAC4N8agXBmaBf4pvSzQE/fhldronXOVcXg
 YZyLQDzEr+WRLYyHUFWhb1vN5IzynQDKmyKQxSnSZn73cHiLr/khEcdbAG82g0bVKrCe
 ijynTO+ofODHNBCGh7wSg7t1vItRi6mTctwLZ1Ue2JFnytbHfPAwRCrcc9Lagm7e1APr
 SDcnCiTF5S0Jv6RF5qWwca+jd6x9ztl0xRiYad/Q6DM6g4KnxC/IohHV38Ty3C+CohF0 aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2va05reny9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 12:16:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UC8sKj152652;
        Mon, 30 Sep 2019 12:16:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vahngjd9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 12:16:35 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8UCGUaX023518;
        Mon, 30 Sep 2019 12:16:30 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 05:16:29 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/3] KVM: X86: Add "nopvspin" parameter to disable PV spinlocks
Date:   Sun, 29 Sep 2019 20:21:04 +0800
Message-Id: <1569759666-26904-2-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9395 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909300130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9395 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909300130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases where a guest tries to switch spinlocks to bare metal
behavior (e.g. by setting "xen_nopvspin" on XEN platform and
"hv_nopvspin" on HYPER_V).

That feature is missed on KVM, add a new parameter "nopvspin" to disable
PV spinlocks for KVM guest.

This new parameter is also intended to replace "xen_nopvspin" and
"hv_nopvspin" in the future.

The global variable pvspin isn't defined as __initdata as it's used at
runtime by XEN guest.

Refactor the print stuff with pr_* which is preferred.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/x86/include/asm/qspinlock.h                |  1 +
 arch/x86/kernel/kvm.c                           | 27 ++++++++++++++++---------
 kernel/locking/qspinlock.c                      |  7 +++++++
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7ac2f3..4b956d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5330,6 +5330,10 @@
 			as generic guest with no PV drivers. Currently support
 			XEN HVM, KVM, HYPER_V and VMWARE guest.
 
+	nopvspin	[X86,KVM] Disables the qspinlock slow path
+			using PV optimizations which allow the hypervisor to
+			'idle' the guest on lock contention.
+
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 444d6fd..34a4484 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -32,6 +32,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
+extern bool pvspin;
 
 #define	queued_spin_unlock queued_spin_unlock
 /**
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index e820568..7b8cf0d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -7,6 +7,8 @@
  *   Authors: Anthony Liguori <aliguori@us.ibm.com>
  */
 
+#define pr_fmt(fmt) "KVM: " fmt
+
 #include <linux/context_tracking.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -286,7 +288,7 @@ static void kvm_register_steal_time(void)
 		return;
 
 	wrmsrl(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
-	pr_info("kvm-stealtime: cpu %d, msr %llx\n",
+	pr_info("stealtime: cpu %d, msr %llx\n",
 		cpu, (unsigned long long) slow_virt_to_phys(st));
 }
 
@@ -321,7 +323,7 @@ static void kvm_guest_cpu_init(void)
 
 		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
 		__this_cpu_write(apf_reason.enabled, 1);
-		printk(KERN_INFO"KVM setup async PF for cpu %d\n",
+		pr_info("setup async PF for cpu %d\n",
 		       smp_processor_id());
 	}
 
@@ -347,7 +349,7 @@ static void kvm_pv_disable_apf(void)
 	wrmsrl(MSR_KVM_ASYNC_PF_EN, 0);
 	__this_cpu_write(apf_reason.enabled, 0);
 
-	printk(KERN_INFO"Unregister pv shared memory for cpu %d\n",
+	pr_info("Unregister pv shared memory for cpu %d\n",
 	       smp_processor_id());
 }
 
@@ -509,7 +511,7 @@ static void kvm_setup_pv_ipi(void)
 {
 	apic->send_IPI_mask = kvm_send_ipi_mask;
 	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
-	pr_info("KVM setup pv IPIs\n");
+	pr_info("setup pv IPIs\n");
 }
 
 static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
@@ -639,11 +641,11 @@ static void __init kvm_guest_init(void)
 	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		smp_ops.send_call_func_ipi = kvm_smp_send_call_func_ipi;
-		pr_info("KVM setup pv sched yield\n");
+		pr_info("setup pv sched yield\n");
 	}
 	if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/kvm:online",
 				      kvm_cpu_online, kvm_cpu_down_prepare) < 0)
-		pr_err("kvm_guest: Failed to install cpu hotplug callbacks\n");
+		pr_err("failed to install cpu hotplug callbacks\n");
 #else
 	sev_map_percpu_data();
 	kvm_guest_cpu_init();
@@ -746,7 +748,7 @@ static __init int kvm_setup_pv_tlb_flush(void)
 			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
 				GFP_KERNEL, cpu_to_node(cpu));
 		}
-		pr_info("KVM setup pv remote TLB flush\n");
+		pr_info("setup pv remote TLB flush\n");
 	}
 
 	return 0;
@@ -842,6 +844,13 @@ void __init kvm_spinlock_init(void)
 	if (num_possible_cpus() == 1)
 		return;
 
+	if (!pvspin) {
+		pr_info("PV spinlocks disabled\n");
+		static_branch_disable(&virt_spin_lock_key);
+		return;
+	}
+	pr_info("PV spinlocks enabled\n");
+
 	__pv_init_lock_hash();
 	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
 	pv_ops.lock.queued_spin_unlock =
@@ -872,8 +881,8 @@ static void kvm_enable_host_haltpoll(void *i)
 void arch_haltpoll_enable(unsigned int cpu)
 {
 	if (!kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL)) {
-		pr_err_once("kvm: host does not support poll control\n");
-		pr_err_once("kvm: host upgrade recommended\n");
+		pr_err_once("host does not support poll control\n");
+		pr_err_once("host upgrade recommended\n");
 		return;
 	}
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2473f10..945b510 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -580,4 +580,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 #include "qspinlock_paravirt.h"
 #include "qspinlock.c"
 
+bool pvspin = true;
+static __init int parse_nopvspin(char *arg)
+{
+	pvspin = false;
+	return 0;
+}
+early_param("nopvspin", parse_nopvspin);
 #endif
-- 
1.8.3.1

