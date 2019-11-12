Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174E7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AA12084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKLKuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:50:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33276 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfKLKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:50:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUTkJ-0008AZ-Hy; Tue, 12 Nov 2019 11:50:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1BC081C0357;
        Tue, 12 Nov 2019 11:50:03 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:50:02 -0000
From:   "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/hyperv] x86/hyperv: Micro-optimize send_ipi_one()
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191027151938.7296-1-vkuznets@redhat.com>
References: <20191027151938.7296-1-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <157355580264.29376.16644467726067576044.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/hyperv branch of tip:

Commit-ID:     b264f57fde0c686c5c1dfdd0c21992c49196bb87
Gitweb:        https://git.kernel.org/tip/b264f57fde0c686c5c1dfdd0c21992c49196bb87
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Sun, 27 Oct 2019 16:19:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Nov 2019 11:44:20 +01:00

x86/hyperv: Micro-optimize send_ipi_one()

When sending an IPI to a single CPU there is no need to deal with cpumasks.

With 2 CPU guest on WS2019 a minor (like 3%, 8043 -> 7761 CPU cycles)
improvement with smp_call_function_single() loop benchmark can be seeb. The
optimization, however, is tiny and straitforward. Also, send_ipi_one() is
important for PV spinlock kick.

Switching to the regular APIC IPI send for CPU > 64 case does not make
sense as it is twice as expesive (12650 CPU cycles for __send_ipi_mask_ex()
call, 26000 for orig_apic.send_IPI(cpu, vector)).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Link: https://lkml.kernel.org/r/20191027151938.7296-1-vkuznets@redhat.com

---
 arch/x86/hyperv/hv_apic.c           | 16 +++++++++++++---
 arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 5c056b8..86c8674 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -194,10 +194,20 @@ do_ex_hypercall:
 
 static bool __send_ipi_one(int cpu, int vector)
 {
-	struct cpumask mask = CPU_MASK_NONE;
+	int vp = hv_cpu_number_to_vp_number(cpu);
 
-	cpumask_set_cpu(cpu, &mask);
-	return __send_ipi_mask(&mask, vector);
+	trace_hyperv_send_ipi_one(cpu, vector);
+
+	if (!hv_hypercall_pg || (vp == VP_INVAL))
+		return false;
+
+	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
+		return false;
+
+	if (vp >= 64)
+		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
+
+	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
 }
 
 static void hv_send_ipi(int cpu, int vector)
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index ace464f..4d705cb 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -71,6 +71,21 @@ TRACE_EVENT(hyperv_send_ipi_mask,
 		      __entry->ncpus, __entry->vector)
 	);
 
+TRACE_EVENT(hyperv_send_ipi_one,
+	    TP_PROTO(int cpu,
+		     int vector),
+	    TP_ARGS(cpu, vector),
+	    TP_STRUCT__entry(
+		    __field(int, cpu)
+		    __field(int, vector)
+		    ),
+	    TP_fast_assign(__entry->cpu = cpu;
+			   __entry->vector = vector;
+		    ),
+	    TP_printk("cpu %d vector %x",
+		      __entry->cpu, __entry->vector)
+	);
+
 #endif /* CONFIG_HYPERV */
 
 #undef TRACE_INCLUDE_PATH
