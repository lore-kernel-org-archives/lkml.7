Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9FEC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA882082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437976AbfFLKMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:12:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437611AbfFLKMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:12:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96C5DAF81;
        Wed, 12 Jun 2019 10:12:31 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/xen: disable nosmt in Xen guests
Date:   Wed, 12 Jun 2019 12:12:28 +0200
Message-Id: <20190612101228.23898-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a Xen guest selecting "nosmt" either via command line
or implicitly via default settings makes no sense, as the guest has no
clue about the real system topology it is running on. With Xen it is
the hypervisor's job to ensure the proper bug mitigations are active
regarding smt settings.

So when running as a Xen guest set cpu_smt_control to "not supported"
in order to avoid disabling random vcpus.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten.c     | 8 ++++++++
 arch/x86/xen/enlighten_hvm.c | 2 ++
 arch/x86/xen/enlighten_pv.c  | 2 ++
 arch/x86/xen/xen-ops.h       | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 750f46ad018a..312b73698d0c 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -345,3 +345,11 @@ void xen_arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
+
+void __init xen_disable_nosmt(void)
+{
+#ifdef CONFIG_HOTPLUG_SMT
+	/* Don't allow SMT disabling in Xen guests. */
+	cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+#endif
+}
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 0e75642d42a3..7c62662cd2ca 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -116,6 +116,8 @@ static void __init init_hvm_pv_info(void)
 		this_cpu_write(xen_vcpu_id, ebx);
 	else
 		this_cpu_write(xen_vcpu_id, smp_processor_id());
+
+	xen_disable_nosmt();
 }
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4722ba2966ac..dcfec65bca60 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -131,6 +131,8 @@ static void __init xen_pv_init_platform(void)
 
 	/* pvclock is in shared info area */
 	xen_init_time_ops();
+
+	xen_disable_nosmt();
 }
 
 static void __init xen_pv_guest_late_init(void)
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 2f111f47ba98..63a31b9d7217 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -161,4 +161,6 @@ void xen_hvm_post_suspend(int suspend_cancelled);
 static inline void xen_hvm_post_suspend(int suspend_cancelled) {}
 #endif
 
+void __init xen_disable_nosmt(void);
+
 #endif /* XEN_OPS_H */
-- 
2.16.4

