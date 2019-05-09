Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D87C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03622216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sb0IrlLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfEIR0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35336 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfEIR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:26:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJSjx169527;
        Thu, 9 May 2019 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=MX9dv0NPMRnpuOl3rTjmwHelV02ePW2ATwYcVL+LHbQ=;
 b=Sb0IrlLE3JgnmhnTHhBFroebbxxZ25AboDrUPvKSYzIkmhsokEx522XlFxDQqi2yKZeJ
 ld4UdiVo+2PLp+oOImwR9x8GjQzMRRk9iYaaGNlF5BBrhDks1U10NFMWMwPE6MkB+Ed1
 OL6dqVGhfRFH2QkgMn70IQEO1ln0owsVx6pVmuxger5NVudJylPdn1iwDAzn+3MYFRwz
 ft1gpNVARaOb7/RLXN8T+ye2jUFBOHnnha/bFkqsmGSqGiWwHyYnlTY1gDbRIZkWLUXM
 G5Movzi7EUXWLpRxh5n49bjhJVnxf6DaRMRJluLYrD7nezC/vYbV85LOK3MkzcrNRKBQ Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2s94b14e37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HNxXW109619;
        Thu, 9 May 2019 17:25:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2sagyvcg5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HPgv9013341;
        Thu, 9 May 2019 17:25:42 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:42 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 09/16] xen/evtchn: support evtchn in xenhost_t
Date:   Thu,  9 May 2019 10:25:33 -0700
Message-Id: <20190509172540.12398-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509172540.12398-1-ankur.a.arora@oracle.com>
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Largely mechanical patch that adds a new param, xenhost_t * to the
evtchn interfaces. The evtchn port instead of being domain unique, is
now scoped to xenhost_t.

As part of upcall handling we now look at all the xenhosts and, for
evtchn_2l, the xenhost's shared_info and vcpu_info. Other than this
event handling is largley unchanged.

Note that the IPI, timer, VIRQ, FUNCTION, PMU etc vectors remain
attached to xh_default. Only interdomain evtchns are allowable as
xh_remote.

TODO:
  - to minimize the changes, evtchn FIFO is disabled for now.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/pci/xen.c                         |  16 +-
 arch/x86/xen/enlighten_hvm.c               |   2 +-
 arch/x86/xen/irq.c                         |   2 +-
 arch/x86/xen/smp.c                         |  16 +-
 arch/x86/xen/smp_pv.c                      |   4 +-
 arch/x86/xen/time.c                        |   5 +-
 arch/x86/xen/xen-ops.h                     |   1 +
 arch/x86/xen/xenhost.c                     |  16 +
 drivers/block/xen-blkback/xenbus.c         |   2 +-
 drivers/block/xen-blkfront.c               |   2 +-
 drivers/input/misc/xen-kbdfront.c          |   2 +-
 drivers/net/xen-netback/interface.c        |   8 +-
 drivers/net/xen-netfront.c                 |   6 +-
 drivers/pci/xen-pcifront.c                 |   2 +-
 drivers/xen/acpi.c                         |   2 +
 drivers/xen/balloon.c                      |   2 +-
 drivers/xen/events/Makefile                |   1 -
 drivers/xen/events/events_2l.c             | 188 +++++-----
 drivers/xen/events/events_base.c           | 379 ++++++++++++---------
 drivers/xen/events/events_fifo.c           |   2 +-
 drivers/xen/events/events_internal.h       |  78 ++---
 drivers/xen/evtchn.c                       |  22 +-
 drivers/xen/fallback.c                     |   1 +
 drivers/xen/gntalloc.c                     |   8 +-
 drivers/xen/gntdev.c                       |   8 +-
 drivers/xen/mcelog.c                       |   2 +-
 drivers/xen/pcpu.c                         |   2 +-
 drivers/xen/preempt.c                      |   1 +
 drivers/xen/privcmd.c                      |   1 +
 drivers/xen/sys-hypervisor.c               |   2 +-
 drivers/xen/time.c                         |   2 +-
 drivers/xen/xen-pciback/xenbus.c           |   2 +-
 drivers/xen/xen-scsiback.c                 |   5 +-
 drivers/xen/xenbus/xenbus_client.c         |   2 +-
 drivers/xen/xenbus/xenbus_comms.c          |   6 +-
 drivers/xen/xenbus/xenbus_probe.c          |   1 +
 drivers/xen/xenbus/xenbus_probe_backend.c  |   1 +
 drivers/xen/xenbus/xenbus_probe_frontend.c |   1 +
 drivers/xen/xenbus/xenbus_xs.c             |   1 +
 include/xen/events.h                       |  45 +--
 include/xen/xenhost.h                      |  17 +
 41 files changed, 483 insertions(+), 383 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index d1a3b9f08289..9aa591b5fa3b 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -19,6 +19,8 @@
 #include <asm/pci_x86.h>
 
 #include <asm/xen/hypervisor.h>
+#include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 
 #include <xen/features.h>
 #include <xen/events.h>
@@ -46,7 +48,7 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
 	if (gsi < nr_legacy_irqs())
 		share = 0;
 
-	rc = xen_bind_pirq_gsi_to_irq(gsi, pirq, share, "pcifront");
+	rc = xen_bind_pirq_gsi_to_irq(xh_default, gsi, pirq, share, "pcifront");
 	if (rc < 0) {
 		dev_warn(&dev->dev, "Xen PCI: failed to bind GSI%d (PIRQ%d) to IRQ: %d\n",
 			 gsi, pirq, rc);
@@ -96,7 +98,7 @@ static int xen_register_pirq(u32 gsi, int gsi_override, int triggering,
 	if (gsi_override >= 0)
 		gsi = gsi_override;
 
-	irq = xen_bind_pirq_gsi_to_irq(gsi, map_irq.pirq, shareable, name);
+	irq = xen_bind_pirq_gsi_to_irq(xh_default, gsi, map_irq.pirq, shareable, name);
 	if (irq < 0)
 		goto out;
 
@@ -180,7 +182,7 @@ static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		goto error;
 	i = 0;
 	for_each_pci_msi_entry(msidesc, dev) {
-		irq = xen_bind_pirq_msi_to_irq(dev, msidesc, v[i],
+		irq = xen_bind_pirq_msi_to_irq(xh_default, dev, msidesc, v[i],
 					       (type == PCI_CAP_ID_MSI) ? nvec : 1,
 					       (type == PCI_CAP_ID_MSIX) ?
 					       "pcifront-msi-x" :
@@ -234,7 +236,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return 1;
 
 	for_each_pci_msi_entry(msidesc, dev) {
-		pirq = xen_allocate_pirq_msi(dev, msidesc);
+		pirq = xen_allocate_pirq_msi(xh_default, dev, msidesc);
 		if (pirq < 0) {
 			irq = -ENODEV;
 			goto error;
@@ -242,7 +244,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		xen_msi_compose_msg(dev, pirq, &msg);
 		__pci_write_msi_msg(msidesc, &msg);
 		dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
-		irq = xen_bind_pirq_msi_to_irq(dev, msidesc, pirq,
+		irq = xen_bind_pirq_msi_to_irq(xh_default, dev, msidesc, pirq,
 					       (type == PCI_CAP_ID_MSI) ? nvec : 1,
 					       (type == PCI_CAP_ID_MSIX) ?
 					       "msi-x" : "msi",
@@ -337,7 +339,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 			goto out;
 		}
 
-		ret = xen_bind_pirq_msi_to_irq(dev, msidesc, map_irq.pirq,
+		ret = xen_bind_pirq_msi_to_irq(xh_default, dev, msidesc, map_irq.pirq,
 		                               (type == PCI_CAP_ID_MSI) ? nvec : 1,
 		                               (type == PCI_CAP_ID_MSIX) ? "msi-x" : "msi",
 		                               domid);
@@ -496,7 +498,7 @@ int __init pci_xen_initial_domain(void)
 	}
 	if (0 == nr_ioapics) {
 		for (irq = 0; irq < nr_legacy_irqs(); irq++)
-			xen_bind_pirq_gsi_to_irq(irq, irq, 0, "xt-pic");
+			xen_bind_pirq_gsi_to_irq(xh_default, irq, irq, 0, "xt-pic");
 	}
 	return 0;
 }
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index c1981a3e4989..efe483ceeb9a 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -266,7 +266,7 @@ static void __init xen_hvm_guest_init(void)
 	xen_hvm_smp_init();
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm, xen_cpu_dead_hvm));
 	xen_unplug_emulated_devices();
-	x86_init.irqs.intr_init = xen_init_IRQ;
+	x86_init.irqs.intr_init = xenhost_init_IRQ;
 	xen_hvm_init_time_ops();
 	xen_hvm_init_mmu_ops();
 
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index f760a6abfb1e..3267c3505a64 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -170,5 +170,5 @@ static const struct pv_irq_ops xen_irq_ops __initconst = {
 void __init xen_init_irq_ops(void)
 {
 	pv_ops.irq = xen_irq_ops;
-	x86_init.irqs.intr_init = xen_init_IRQ;
+	x86_init.irqs.intr_init = xenhost_init_IRQ;
 }
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 867524be0065..c186d868dc5c 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -66,7 +66,7 @@ int xen_smp_intr_init(unsigned int cpu)
 	char *resched_name, *callfunc_name, *debug_name;
 
 	resched_name = kasprintf(GFP_KERNEL, "resched%d", cpu);
-	rc = bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
+	rc = bind_ipi_to_irqhandler(xh_default, XEN_RESCHEDULE_VECTOR,
 				    cpu,
 				    xen_reschedule_interrupt,
 				    IRQF_PERCPU|IRQF_NOBALANCING,
@@ -78,7 +78,7 @@ int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_resched_irq, cpu).name = resched_name;
 
 	callfunc_name = kasprintf(GFP_KERNEL, "callfunc%d", cpu);
-	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_VECTOR,
+	rc = bind_ipi_to_irqhandler(xh_default, XEN_CALL_FUNCTION_VECTOR,
 				    cpu,
 				    xen_call_function_interrupt,
 				    IRQF_PERCPU|IRQF_NOBALANCING,
@@ -90,7 +90,7 @@ int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_callfunc_irq, cpu).name = callfunc_name;
 
 	debug_name = kasprintf(GFP_KERNEL, "debug%d", cpu);
-	rc = bind_virq_to_irqhandler(VIRQ_DEBUG, cpu, xen_debug_interrupt,
+	rc = bind_virq_to_irqhandler(xh_default, VIRQ_DEBUG, cpu, xen_debug_interrupt,
 				     IRQF_PERCPU | IRQF_NOBALANCING,
 				     debug_name, NULL);
 	if (rc < 0)
@@ -99,7 +99,7 @@ int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_debug_irq, cpu).name = debug_name;
 
 	callfunc_name = kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
-	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
+	rc = bind_ipi_to_irqhandler(xh_default, XEN_CALL_FUNCTION_SINGLE_VECTOR,
 				    cpu,
 				    xen_call_function_single_interrupt,
 				    IRQF_PERCPU|IRQF_NOBALANCING,
@@ -155,7 +155,7 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 
 void xen_smp_send_reschedule(int cpu)
 {
-	xen_send_IPI_one(cpu, XEN_RESCHEDULE_VECTOR);
+	xen_send_IPI_one(xh_default, cpu, XEN_RESCHEDULE_VECTOR);
 }
 
 static void __xen_send_IPI_mask(const struct cpumask *mask,
@@ -164,7 +164,7 @@ static void __xen_send_IPI_mask(const struct cpumask *mask,
 	unsigned cpu;
 
 	for_each_cpu_and(cpu, mask, cpu_online_mask)
-		xen_send_IPI_one(cpu, vector);
+		xen_send_IPI_one(xh_default, cpu, vector);
 }
 
 void xen_smp_send_call_function_ipi(const struct cpumask *mask)
@@ -242,7 +242,7 @@ void xen_send_IPI_self(int vector)
 	int xen_vector = xen_map_vector(vector);
 
 	if (xen_vector >= 0)
-		xen_send_IPI_one(smp_processor_id(), xen_vector);
+		xen_send_IPI_one(xh_default, smp_processor_id(), xen_vector);
 }
 
 void xen_send_IPI_mask_allbutself(const struct cpumask *mask,
@@ -259,7 +259,7 @@ void xen_send_IPI_mask_allbutself(const struct cpumask *mask,
 		if (this_cpu == cpu)
 			continue;
 
-		xen_send_IPI_one(cpu, xen_vector);
+		xen_send_IPI_one(xh_default, cpu, xen_vector);
 	}
 }
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index f4ea9eac8b6a..f8292be25d52 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -116,7 +116,7 @@ int xen_smp_intr_init_pv(unsigned int cpu)
 	char *callfunc_name, *pmu_name;
 
 	callfunc_name = kasprintf(GFP_KERNEL, "irqwork%d", cpu);
-	rc = bind_ipi_to_irqhandler(XEN_IRQ_WORK_VECTOR,
+	rc = bind_ipi_to_irqhandler(xh_default, XEN_IRQ_WORK_VECTOR,
 				    cpu,
 				    xen_irq_work_interrupt,
 				    IRQF_PERCPU|IRQF_NOBALANCING,
@@ -129,7 +129,7 @@ int xen_smp_intr_init_pv(unsigned int cpu)
 
 	if (is_xen_pmu(cpu)) {
 		pmu_name = kasprintf(GFP_KERNEL, "pmu%d", cpu);
-		rc = bind_virq_to_irqhandler(VIRQ_XENPMU, cpu,
+		rc = bind_virq_to_irqhandler(xh_default, VIRQ_XENPMU, cpu,
 					     xen_pmu_irq_handler,
 					     IRQF_PERCPU|IRQF_NOBALANCING,
 					     pmu_name, NULL);
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 217bc4de07ee..2f7ff3272d5d 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -340,11 +340,12 @@ void xen_setup_timer(int cpu)
 
 	snprintf(xevt->name, sizeof(xevt->name), "timer%d", cpu);
 
-	irq = bind_virq_to_irqhandler(VIRQ_TIMER, cpu, xen_timer_interrupt,
+	irq = bind_virq_to_irqhandler(xh_default,
+				      VIRQ_TIMER, cpu, xen_timer_interrupt,
 				      IRQF_PERCPU|IRQF_NOBALANCING|IRQF_TIMER|
 				      IRQF_FORCE_RESUME|IRQF_EARLY_RESUME,
 				      xevt->name, NULL);
-	(void)xen_set_irq_priority(irq, XEN_IRQ_PRIORITY_MAX);
+	(void)xen_set_irq_priority(xh_default, irq, XEN_IRQ_PRIORITY_MAX);
 
 	memcpy(evt, xen_clockevent, sizeof(*evt));
 
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 96fd7edea7e9..4619808f1640 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -78,6 +78,7 @@ extern int xen_have_vcpu_info_placement;
 int xen_vcpu_setup(xenhost_t *xh, int cpu);
 void xen_vcpu_info_reset(xenhost_t *xh, int cpu);
 void xen_setup_vcpu_info_placement(void);
+void xenhost_init_IRQ(void);
 
 #ifdef CONFIG_SMP
 void xen_smp_init(void);
diff --git a/arch/x86/xen/xenhost.c b/arch/x86/xen/xenhost.c
index 3d8ccef89dcd..3bbfd0654833 100644
--- a/arch/x86/xen/xenhost.c
+++ b/arch/x86/xen/xenhost.c
@@ -2,6 +2,7 @@
 #include <linux/bug.h>
 #include <xen/xen.h>
 #include <xen/xenhost.h>
+#include <xen/events.h>
 #include "xen-ops.h"
 
 /*
@@ -84,3 +85,18 @@ void __xenhost_unregister(enum xenhost_type type)
 			BUG();
 	}
 }
+
+void xenhost_init_IRQ(void)
+{
+	xenhost_t **xh;
+	/*
+	 * xenhost_init_IRQ is called via x86_init.irq.intr_init().
+	 * For xenhost_r1 and xenhost_r2, the underlying state is
+	 * ready so we can go ahead and init both the variants.
+	 *
+	 * xenhost_r0, might be implemented via a loadable module
+	 * so that would do this initialization explicitly.
+	 */
+	for_each_xenhost(xh)
+		xen_init_IRQ(*xh);
+}
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e72c39..beea4272cfd3 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -228,7 +228,7 @@ static int xen_blkif_map(struct xen_blkif_ring *ring, grant_ref_t *gref,
 		BUG();
 	}
 
-	err = bind_interdomain_evtchn_to_irqhandler(blkif->domid, evtchn,
+	err = bind_interdomain_evtchn_to_irqhandler(xh_default, blkif->domid, evtchn,
 						    xen_blkif_be_int, 0,
 						    "blkif-backend", ring);
 	if (err < 0) {
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 0ed4b200fa58..a06716424023 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1700,7 +1700,7 @@ static int setup_blkring(struct xenbus_device *dev,
 	if (err)
 		goto fail;
 
-	err = bind_evtchn_to_irqhandler(rinfo->evtchn, blkif_interrupt, 0,
+	err = bind_evtchn_to_irqhandler(xh_default, rinfo->evtchn, blkif_interrupt, 0,
 					"blkif", rinfo);
 	if (err <= 0) {
 		xenbus_dev_fatal(dev, err,
diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 24bc5c5d876f..47c6e499fe31 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -435,7 +435,7 @@ static int xenkbd_connect_backend(struct xenbus_device *dev,
 	ret = xenbus_alloc_evtchn(dev, &evtchn);
 	if (ret)
 		goto error_grant;
-	ret = bind_evtchn_to_irqhandler(evtchn, input_handler,
+	ret = bind_evtchn_to_irqhandler(xh_default, evtchn, input_handler,
 					0, dev->devicetype, info);
 	if (ret < 0) {
 		xenbus_dev_fatal(dev, ret, "bind_evtchn_to_irqhandler");
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 182d6770f102..53d4e6351f1e 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -588,7 +588,7 @@ int xenvif_connect_ctrl(struct xenvif *vif, grant_ref_t ring_ref,
 	shared = (struct xen_netif_ctrl_sring *)addr;
 	BACK_RING_INIT(&vif->ctrl, shared, XEN_PAGE_SIZE);
 
-	err = bind_interdomain_evtchn_to_irq(vif->domid, evtchn);
+	err = bind_interdomain_evtchn_to_irq(xh_default, vif->domid, evtchn);
 	if (err < 0)
 		goto err_unmap;
 
@@ -646,7 +646,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 
 	if (tx_evtchn == rx_evtchn) {
 		/* feature-split-event-channels == 0 */
-		err = bind_interdomain_evtchn_to_irqhandler(
+		err = bind_interdomain_evtchn_to_irqhandler(xh_default,
 			queue->vif->domid, tx_evtchn, xenvif_interrupt, 0,
 			queue->name, queue);
 		if (err < 0)
@@ -657,7 +657,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 		/* feature-split-event-channels == 1 */
 		snprintf(queue->tx_irq_name, sizeof(queue->tx_irq_name),
 			 "%s-tx", queue->name);
-		err = bind_interdomain_evtchn_to_irqhandler(
+		err = bind_interdomain_evtchn_to_irqhandler(xh_default,
 			queue->vif->domid, tx_evtchn, xenvif_tx_interrupt, 0,
 			queue->tx_irq_name, queue);
 		if (err < 0)
@@ -667,7 +667,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 
 		snprintf(queue->rx_irq_name, sizeof(queue->rx_irq_name),
 			 "%s-rx", queue->name);
-		err = bind_interdomain_evtchn_to_irqhandler(
+		err = bind_interdomain_evtchn_to_irqhandler(xh_default,
 			queue->vif->domid, rx_evtchn, xenvif_rx_interrupt, 0,
 			queue->rx_irq_name, queue);
 		if (err < 0)
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index c914c24f880b..1cd0a2d2ba54 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1468,7 +1468,7 @@ static int setup_netfront_single(struct netfront_queue *queue)
 	if (err < 0)
 		goto fail;
 
-	err = bind_evtchn_to_irqhandler(queue->tx_evtchn,
+	err = bind_evtchn_to_irqhandler(xh_default, queue->tx_evtchn,
 					xennet_interrupt,
 					0, queue->info->netdev->name, queue);
 	if (err < 0)
@@ -1498,7 +1498,7 @@ static int setup_netfront_split(struct netfront_queue *queue)
 
 	snprintf(queue->tx_irq_name, sizeof(queue->tx_irq_name),
 		 "%s-tx", queue->name);
-	err = bind_evtchn_to_irqhandler(queue->tx_evtchn,
+	err = bind_evtchn_to_irqhandler(xh_default, queue->tx_evtchn,
 					xennet_tx_interrupt,
 					0, queue->tx_irq_name, queue);
 	if (err < 0)
@@ -1507,7 +1507,7 @@ static int setup_netfront_split(struct netfront_queue *queue)
 
 	snprintf(queue->rx_irq_name, sizeof(queue->rx_irq_name),
 		 "%s-rx", queue->name);
-	err = bind_evtchn_to_irqhandler(queue->rx_evtchn,
+	err = bind_evtchn_to_irqhandler(xh_default, queue->rx_evtchn,
 					xennet_rx_interrupt,
 					0, queue->rx_irq_name, queue);
 	if (err < 0)
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index eba6e33147a2..f894290e8b3a 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -800,7 +800,7 @@ static int pcifront_publish_info(struct pcifront_device *pdev)
 	if (err)
 		goto out;
 
-	err = bind_evtchn_to_irqhandler(pdev->evtchn, pcifront_handler_aer,
+	err = bind_evtchn_to_irqhandler(xh_default, pdev->evtchn, pcifront_handler_aer,
 		0, "pcifront", pdev);
 
 	if (err < 0)
diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
index 6893c79fd2a1..a959fce175f8 100644
--- a/drivers/xen/acpi.c
+++ b/drivers/xen/acpi.c
@@ -30,6 +30,8 @@
  * IN THE SOFTWARE.
  */
 
+#include <linux/types.h>
+#include <xen/interface/xen.h>
 #include <xen/acpi.h>
 #include <xen/interface/platform.h>
 #include <asm/xen/hypercall.h>
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index ceb5048de9a7..5ef4d6ad920d 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -62,11 +62,11 @@
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
 
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
 #include <xen/xen.h>
-#include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
 #include <xen/balloon.h>
 #include <xen/features.h>
diff --git a/drivers/xen/events/Makefile b/drivers/xen/events/Makefile
index 62be55cd981d..08179fe04612 100644
--- a/drivers/xen/events/Makefile
+++ b/drivers/xen/events/Makefile
@@ -2,4 +2,3 @@ obj-y += events.o
 
 events-y += events_base.o
 events-y += events_2l.o
-events-y += events_fifo.o
diff --git a/drivers/xen/events/events_2l.c b/drivers/xen/events/events_2l.c
index f09dbe4e9c33..c69d7a5b3dff 100644
--- a/drivers/xen/events/events_2l.c
+++ b/drivers/xen/events/events_2l.c
@@ -40,50 +40,52 @@
 
 #define EVTCHN_MASK_SIZE (EVTCHN_2L_NR_CHANNELS/BITS_PER_EVTCHN_WORD)
 
-static DEFINE_PER_CPU(xen_ulong_t [EVTCHN_MASK_SIZE], cpu_evtchn_mask);
+static DEFINE_PER_CPU(xen_ulong_t [2][EVTCHN_MASK_SIZE], cpu_evtchn_mask);
 
-static unsigned evtchn_2l_max_channels(void)
+static unsigned evtchn_2l_max_channels(xenhost_t *xh)
 {
 	return EVTCHN_2L_NR_CHANNELS;
 }
 
 static void evtchn_2l_bind_to_cpu(struct irq_info *info, unsigned cpu)
 {
-	clear_bit(info->evtchn, BM(per_cpu(cpu_evtchn_mask, info->cpu)));
-	set_bit(info->evtchn, BM(per_cpu(cpu_evtchn_mask, cpu)));
+	clear_bit(info->evtchn,
+		BM(per_cpu(cpu_evtchn_mask, info->cpu))[info->xh - xenhosts]);
+	set_bit(info->evtchn,
+		BM(per_cpu(cpu_evtchn_mask, cpu))[info->xh - xenhosts]);
 }
 
-static void evtchn_2l_clear_pending(unsigned port)
+static void evtchn_2l_clear_pending(xenhost_t *xh, unsigned port)
 {
 	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	sync_clear_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static void evtchn_2l_set_pending(unsigned port)
+static void evtchn_2l_set_pending(xenhost_t *xh, unsigned port)
 {
 	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	sync_set_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static bool evtchn_2l_is_pending(unsigned port)
+static bool evtchn_2l_is_pending(xenhost_t *xh, unsigned port)
 {
-	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
+	struct shared_info *s = xh->HYPERVISOR_shared_info;
 	return sync_test_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static bool evtchn_2l_test_and_set_mask(unsigned port)
+static bool evtchn_2l_test_and_set_mask(xenhost_t *xh, unsigned port)
 {
-	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
+	struct shared_info *s = xh->HYPERVISOR_shared_info;
 	return sync_test_and_set_bit(port, BM(&s->evtchn_mask[0]));
 }
 
-static void evtchn_2l_mask(unsigned port)
+static void evtchn_2l_mask(xenhost_t *xh, unsigned port)
 {
 	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	sync_set_bit(port, BM(&s->evtchn_mask[0]));
 }
 
-static void evtchn_2l_unmask(unsigned port)
+static void evtchn_2l_unmask(xenhost_t *xh, unsigned port)
 {
 	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	unsigned int cpu = get_cpu();
@@ -91,7 +93,7 @@ static void evtchn_2l_unmask(unsigned port)
 
 	BUG_ON(!irqs_disabled());
 
-	if (unlikely((cpu != cpu_from_evtchn(port))))
+	if (unlikely((cpu != cpu_from_evtchn(xh, port))))
 		do_hypercall = 1;
 	else {
 		/*
@@ -116,9 +118,9 @@ static void evtchn_2l_unmask(unsigned port)
 	 * their own implementation of irq_enable). */
 	if (do_hypercall) {
 		struct evtchn_unmask unmask = { .port = port };
-		(void)HYPERVISOR_event_channel_op(EVTCHNOP_unmask, &unmask);
+		(void)hypervisor_event_channel_op(xh, EVTCHNOP_unmask, &unmask);
 	} else {
-		struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
+		struct vcpu_info *vcpu_info = xh->xen_vcpu[cpu];
 
 		/*
 		 * The following is basically the equivalent of
@@ -134,8 +136,8 @@ static void evtchn_2l_unmask(unsigned port)
 	put_cpu();
 }
 
-static DEFINE_PER_CPU(unsigned int, current_word_idx);
-static DEFINE_PER_CPU(unsigned int, current_bit_idx);
+static DEFINE_PER_CPU(unsigned int [2], current_word_idx);
+static DEFINE_PER_CPU(unsigned int [2], current_bit_idx);
 
 /*
  * Mask out the i least significant bits of w
@@ -143,11 +145,12 @@ static DEFINE_PER_CPU(unsigned int, current_bit_idx);
 #define MASK_LSBS(w, i) (w & ((~((xen_ulong_t)0UL)) << i))
 
 static inline xen_ulong_t active_evtchns(unsigned int cpu,
+					 xenhost_t *xh,
 					 struct shared_info *sh,
 					 unsigned int idx)
 {
 	return sh->evtchn_pending[idx] &
-		per_cpu(cpu_evtchn_mask, cpu)[idx] &
+		per_cpu(cpu_evtchn_mask, cpu)[xh - xenhosts][idx] &
 		~sh->evtchn_mask[idx];
 }
 
@@ -159,7 +162,7 @@ static inline xen_ulong_t active_evtchns(unsigned int cpu,
  * a bitset of words which contain pending event bits.  The second
  * level is a bitset of pending events themselves.
  */
-static void evtchn_2l_handle_events(unsigned cpu)
+static void evtchn_2l_handle_events(xenhost_t *xh, unsigned cpu)
 {
 	int irq;
 	xen_ulong_t pending_words;
@@ -167,8 +170,8 @@ static void evtchn_2l_handle_events(unsigned cpu)
 	int start_word_idx, start_bit_idx;
 	int word_idx, bit_idx;
 	int i;
-	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
-	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
+	struct shared_info *s = xh->HYPERVISOR_shared_info;
+	struct vcpu_info *vcpu_info = xh->xen_vcpu[cpu];
 
 	/* Timer interrupt has highest priority. */
 	irq = irq_from_virq(cpu, VIRQ_TIMER);
@@ -176,7 +179,7 @@ static void evtchn_2l_handle_events(unsigned cpu)
 		unsigned int evtchn = evtchn_from_irq(irq);
 		word_idx = evtchn / BITS_PER_LONG;
 		bit_idx = evtchn % BITS_PER_LONG;
-		if (active_evtchns(cpu, s, word_idx) & (1ULL << bit_idx))
+		if (active_evtchns(cpu, xh, s, word_idx) & (1ULL << bit_idx))
 			generic_handle_irq(irq);
 	}
 
@@ -187,8 +190,8 @@ static void evtchn_2l_handle_events(unsigned cpu)
 	 */
 	pending_words = xchg_xen_ulong(&vcpu_info->evtchn_pending_sel, 0);
 
-	start_word_idx = __this_cpu_read(current_word_idx);
-	start_bit_idx = __this_cpu_read(current_bit_idx);
+	start_word_idx = __this_cpu_read(current_word_idx[xh - xenhosts]);
+	start_bit_idx = __this_cpu_read(current_bit_idx[xh - xenhosts]);
 
 	word_idx = start_word_idx;
 
@@ -207,7 +210,7 @@ static void evtchn_2l_handle_events(unsigned cpu)
 		}
 		word_idx = EVTCHN_FIRST_BIT(words);
 
-		pending_bits = active_evtchns(cpu, s, word_idx);
+		pending_bits = active_evtchns(cpu, xh, s, word_idx);
 		bit_idx = 0; /* usually scan entire word from start */
 		/*
 		 * We scan the starting word in two parts.
@@ -240,7 +243,7 @@ static void evtchn_2l_handle_events(unsigned cpu)
 
 			/* Process port. */
 			port = (word_idx * BITS_PER_EVTCHN_WORD) + bit_idx;
-			irq = get_evtchn_to_irq(port);
+			irq = get_evtchn_to_irq(xh, port);
 
 			if (irq != -1)
 				generic_handle_irq(irq);
@@ -248,10 +251,10 @@ static void evtchn_2l_handle_events(unsigned cpu)
 			bit_idx = (bit_idx + 1) % BITS_PER_EVTCHN_WORD;
 
 			/* Next caller starts at last processed + 1 */
-			__this_cpu_write(current_word_idx,
+			__this_cpu_write(current_word_idx[xh - xenhosts],
 					 bit_idx ? word_idx :
 					 (word_idx+1) % BITS_PER_EVTCHN_WORD);
-			__this_cpu_write(current_bit_idx, bit_idx);
+			__this_cpu_write(current_bit_idx[xh - xenhosts], bit_idx);
 		} while (bit_idx != 0);
 
 		/* Scan start_l1i twice; all others once. */
@@ -266,78 +269,81 @@ irqreturn_t xen_debug_interrupt(int irq, void *dev_id)
 {
 	struct shared_info *sh = xh_default->HYPERVISOR_shared_info;
 	int cpu = smp_processor_id();
-	xen_ulong_t *cpu_evtchn = per_cpu(cpu_evtchn_mask, cpu);
+	xen_ulong_t *cpu_evtchn;
 	int i;
 	unsigned long flags;
 	static DEFINE_SPINLOCK(debug_lock);
 	struct vcpu_info *v;
+	xenhost_t **xh;
 
 	spin_lock_irqsave(&debug_lock, flags);
 
 	printk("\nvcpu %d\n  ", cpu);
 
-	for_each_online_cpu(i) {
-		int pending;
-		v = per_cpu(xen_vcpu, i);
-		pending = (get_irq_regs() && i == cpu)
-			? xen_irqs_disabled(get_irq_regs())
-			: v->evtchn_upcall_mask;
-		printk("%d: masked=%d pending=%d event_sel %0*"PRI_xen_ulong"\n  ", i,
-		       pending, v->evtchn_upcall_pending,
-		       (int)(sizeof(v->evtchn_pending_sel)*2),
-		       v->evtchn_pending_sel);
-	}
-	v = per_cpu(xen_vcpu, cpu);
+	for_each_xenhost(xh) {
+		cpu_evtchn = per_cpu(cpu_evtchn_mask, cpu)[(*xh) - xenhosts];
+		for_each_online_cpu(i) {
+			int pending;
+			v = (*xh)->xen_vcpu[i];
+			pending = (get_irq_regs() && i == cpu)
+				? xen_irqs_disabled(get_irq_regs())
+				: v->evtchn_upcall_mask;
+			printk("%d: masked=%d pending=%d event_sel %0*"PRI_xen_ulong"\n  ", i,
+			       pending, v->evtchn_upcall_pending,
+			       (int)(sizeof(v->evtchn_pending_sel)*2),
+			       v->evtchn_pending_sel);
+		}
+		v = (*xh)->xen_vcpu[cpu];
 
-	printk("\npending:\n   ");
-	for (i = ARRAY_SIZE(sh->evtchn_pending)-1; i >= 0; i--)
-		printk("%0*"PRI_xen_ulong"%s",
-		       (int)sizeof(sh->evtchn_pending[0])*2,
-		       sh->evtchn_pending[i],
-		       i % 8 == 0 ? "\n   " : " ");
-	printk("\nglobal mask:\n   ");
-	for (i = ARRAY_SIZE(sh->evtchn_mask)-1; i >= 0; i--)
-		printk("%0*"PRI_xen_ulong"%s",
-		       (int)(sizeof(sh->evtchn_mask[0])*2),
-		       sh->evtchn_mask[i],
-		       i % 8 == 0 ? "\n   " : " ");
+		printk("\npending:\n   ");
+		for (i = ARRAY_SIZE(sh->evtchn_pending)-1; i >= 0; i--)
+			printk("%0*"PRI_xen_ulong"%s",
+			       (int)sizeof(sh->evtchn_pending[0])*2,
+			       sh->evtchn_pending[i],
+			       i % 8 == 0 ? "\n   " : " ");
+		printk("\nglobal mask:\n   ");
+		for (i = ARRAY_SIZE(sh->evtchn_mask)-1; i >= 0; i--)
+			printk("%0*"PRI_xen_ulong"%s",
+			       (int)(sizeof(sh->evtchn_mask[0])*2),
+			       sh->evtchn_mask[i],
+			       i % 8 == 0 ? "\n   " : " ");
 
-	printk("\nglobally unmasked:\n   ");
-	for (i = ARRAY_SIZE(sh->evtchn_mask)-1; i >= 0; i--)
-		printk("%0*"PRI_xen_ulong"%s",
-		       (int)(sizeof(sh->evtchn_mask[0])*2),
-		       sh->evtchn_pending[i] & ~sh->evtchn_mask[i],
-		       i % 8 == 0 ? "\n   " : " ");
+		printk("\nglobally unmasked:\n   ");
+		for (i = ARRAY_SIZE(sh->evtchn_mask)-1; i >= 0; i--)
+			printk("%0*"PRI_xen_ulong"%s",
+			       (int)(sizeof(sh->evtchn_mask[0])*2),
+			       sh->evtchn_pending[i] & ~sh->evtchn_mask[i],
+			       i % 8 == 0 ? "\n   " : " ");
+		printk("\nlocal cpu%d mask:\n   ", cpu);
+		for (i = (EVTCHN_2L_NR_CHANNELS/BITS_PER_EVTCHN_WORD)-1; i >= 0; i--)
+			printk("%0*"PRI_xen_ulong"%s", (int)(sizeof(cpu_evtchn[0])*2),
+			       cpu_evtchn[i],
+			       i % 8 == 0 ? "\n   " : " ");
 
-	printk("\nlocal cpu%d mask:\n   ", cpu);
-	for (i = (EVTCHN_2L_NR_CHANNELS/BITS_PER_EVTCHN_WORD)-1; i >= 0; i--)
-		printk("%0*"PRI_xen_ulong"%s", (int)(sizeof(cpu_evtchn[0])*2),
-		       cpu_evtchn[i],
-		       i % 8 == 0 ? "\n   " : " ");
+		printk("\nlocally unmasked:\n   ");
+		for (i = ARRAY_SIZE(sh->evtchn_mask)-1; i >= 0; i--) {
+			xen_ulong_t pending = sh->evtchn_pending[i]
+				& ~sh->evtchn_mask[i]
+				& cpu_evtchn[i];
+			printk("%0*"PRI_xen_ulong"%s",
+			       (int)(sizeof(sh->evtchn_mask[0])*2),
+			       pending, i % 8 == 0 ? "\n   " : " ");
+		}
 
-	printk("\nlocally unmasked:\n   ");
-	for (i = ARRAY_SIZE(sh->evtchn_mask)-1; i >= 0; i--) {
-		xen_ulong_t pending = sh->evtchn_pending[i]
-			& ~sh->evtchn_mask[i]
-			& cpu_evtchn[i];
-		printk("%0*"PRI_xen_ulong"%s",
-		       (int)(sizeof(sh->evtchn_mask[0])*2),
-		       pending, i % 8 == 0 ? "\n   " : " ");
-	}
-
-	printk("\npending list:\n");
-	for (i = 0; i < EVTCHN_2L_NR_CHANNELS; i++) {
-		if (sync_test_bit(i, BM(sh->evtchn_pending))) {
-			int word_idx = i / BITS_PER_EVTCHN_WORD;
-			printk("  %d: event %d -> irq %d%s%s%s\n",
-			       cpu_from_evtchn(i), i,
-			       get_evtchn_to_irq(i),
-			       sync_test_bit(word_idx, BM(&v->evtchn_pending_sel))
-			       ? "" : " l2-clear",
-			       !sync_test_bit(i, BM(sh->evtchn_mask))
-			       ? "" : " globally-masked",
-			       sync_test_bit(i, BM(cpu_evtchn))
-			       ? "" : " locally-masked");
+		printk("\npending list:\n");
+		for (i = 0; i < EVTCHN_2L_NR_CHANNELS; i++) {
+			if (sync_test_bit(i, BM(sh->evtchn_pending))) {
+				int word_idx = i / BITS_PER_EVTCHN_WORD;
+				printk("  %d: event %d -> irq %d%s%s%s\n",
+				       cpu_from_evtchn(*xh, i), i,
+				       get_evtchn_to_irq(*xh, i),
+				       sync_test_bit(word_idx, BM(&v->evtchn_pending_sel))
+				       ? "" : " l2-clear",
+				       !sync_test_bit(i, BM(sh->evtchn_mask))
+				       ? "" : " globally-masked",
+				       sync_test_bit(i, BM(cpu_evtchn))
+				       ? "" : " locally-masked");
+			}
 		}
 	}
 
@@ -346,12 +352,12 @@ irqreturn_t xen_debug_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void evtchn_2l_resume(void)
+static void evtchn_2l_resume(xenhost_t *xh)
 {
 	int i;
 
 	for_each_online_cpu(i)
-		memset(per_cpu(cpu_evtchn_mask, i), 0, sizeof(xen_ulong_t) *
+		memset(per_cpu(cpu_evtchn_mask, i)[xh - xenhosts], 0, sizeof(xen_ulong_t) *
 				EVTCHN_2L_NR_CHANNELS/BITS_PER_EVTCHN_WORD);
 }
 
@@ -369,8 +375,8 @@ static const struct evtchn_ops evtchn_ops_2l = {
 	.resume	           = evtchn_2l_resume,
 };
 
-void __init xen_evtchn_2l_init(void)
+void xen_evtchn_2l_init(xenhost_t *xh)
 {
 	pr_info("Using 2-level ABI\n");
-	evtchn_ops = &evtchn_ops_2l;
+	xh->evtchn_ops = &evtchn_ops_2l;
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index ae497876fe41..99b6b2c57d23 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -77,15 +77,14 @@ static DEFINE_PER_CPU(int [NR_VIRQS], virq_to_irq) = {[0 ... NR_VIRQS-1] = -1};
 /* IRQ <-> IPI mapping */
 static DEFINE_PER_CPU(int [XEN_NR_IPIS], ipi_to_irq) = {[0 ... XEN_NR_IPIS-1] = -1};
 
-int **evtchn_to_irq;
 #ifdef CONFIG_X86
 static unsigned long *pirq_eoi_map;
 #endif
 static bool (*pirq_needs_eoi)(unsigned irq);
 
-#define EVTCHN_ROW(e)  (e / (PAGE_SIZE/sizeof(**evtchn_to_irq)))
-#define EVTCHN_COL(e)  (e % (PAGE_SIZE/sizeof(**evtchn_to_irq)))
-#define EVTCHN_PER_ROW (PAGE_SIZE / sizeof(**evtchn_to_irq))
+#define EVTCHN_ROW(xh, e)  (e / (PAGE_SIZE/sizeof(**((xh)->evtchn_to_irq))))
+#define EVTCHN_COL(xh, e)  (e % (PAGE_SIZE/sizeof(**((xh)->evtchn_to_irq))))
+#define EVTCHN_PER_ROW(xh) (PAGE_SIZE / sizeof(**((xh)->evtchn_to_irq)))
 
 /* Xen will never allocate port zero for any purpose. */
 #define VALID_EVTCHN(chn)	((chn) != 0)
@@ -96,59 +95,62 @@ static struct irq_chip xen_pirq_chip;
 static void enable_dynirq(struct irq_data *data);
 static void disable_dynirq(struct irq_data *data);
 
-static void clear_evtchn_to_irq_row(unsigned row)
+static void clear_evtchn_to_irq_row(xenhost_t *xh, unsigned row)
 {
 	unsigned col;
 
-	for (col = 0; col < EVTCHN_PER_ROW; col++)
-		evtchn_to_irq[row][col] = -1;
+	for (col = 0; col < EVTCHN_PER_ROW(xh); col++)
+		xh->evtchn_to_irq[row][col] = -1;
 }
 
 static void clear_evtchn_to_irq_all(void)
 {
 	unsigned row;
+	xenhost_t **xh;
 
-	for (row = 0; row < EVTCHN_ROW(xen_evtchn_max_channels()); row++) {
-		if (evtchn_to_irq[row] == NULL)
-			continue;
-		clear_evtchn_to_irq_row(row);
+	for_each_xenhost(xh) {
+		for (row = 0; row < EVTCHN_ROW(*xh, xen_evtchn_max_channels(*xh)); row++) {
+			if ((*xh)->evtchn_to_irq[row] == NULL)
+				continue;
+			clear_evtchn_to_irq_row(*xh, row);
+		}
 	}
 }
 
-static int set_evtchn_to_irq(unsigned evtchn, unsigned irq)
+static int set_evtchn_to_irq(xenhost_t *xh, unsigned evtchn, unsigned irq)
 {
 	unsigned row;
 	unsigned col;
 
-	if (evtchn >= xen_evtchn_max_channels())
+	if (evtchn >= xen_evtchn_max_channels(xh))
 		return -EINVAL;
 
-	row = EVTCHN_ROW(evtchn);
-	col = EVTCHN_COL(evtchn);
+	row = EVTCHN_ROW(xh, evtchn);
+	col = EVTCHN_COL(xh, evtchn);
 
-	if (evtchn_to_irq[row] == NULL) {
+	if (xh->evtchn_to_irq[row] == NULL) {
 		/* Unallocated irq entries return -1 anyway */
 		if (irq == -1)
 			return 0;
 
-		evtchn_to_irq[row] = (int *)get_zeroed_page(GFP_KERNEL);
-		if (evtchn_to_irq[row] == NULL)
+		xh->evtchn_to_irq[row] = (int *)get_zeroed_page(GFP_KERNEL);
+		if (xh->evtchn_to_irq[row] == NULL)
 			return -ENOMEM;
 
-		clear_evtchn_to_irq_row(row);
+		clear_evtchn_to_irq_row(xh, row);
 	}
 
-	evtchn_to_irq[row][col] = irq;
+	xh->evtchn_to_irq[row][col] = irq;
 	return 0;
 }
 
-int get_evtchn_to_irq(unsigned evtchn)
+int get_evtchn_to_irq(xenhost_t *xh, unsigned evtchn)
 {
-	if (evtchn >= xen_evtchn_max_channels())
+	if (evtchn >= xen_evtchn_max_channels(xh))
 		return -1;
-	if (evtchn_to_irq[EVTCHN_ROW(evtchn)] == NULL)
+	if (xh->evtchn_to_irq[EVTCHN_ROW(xh, evtchn)] == NULL)
 		return -1;
-	return evtchn_to_irq[EVTCHN_ROW(evtchn)][EVTCHN_COL(evtchn)];
+	return xh->evtchn_to_irq[EVTCHN_ROW(xh, evtchn)][EVTCHN_COL(xh, evtchn)];
 }
 
 /* Get info for IRQ */
@@ -159,6 +161,7 @@ struct irq_info *info_for_irq(unsigned irq)
 
 /* Constructors for packed IRQ information. */
 static int xen_irq_info_common_setup(struct irq_info *info,
+				     xenhost_t *xh,
 				     unsigned irq,
 				     enum xen_irq_type type,
 				     unsigned evtchn,
@@ -173,7 +176,7 @@ static int xen_irq_info_common_setup(struct irq_info *info,
 	info->evtchn = evtchn;
 	info->cpu = cpu;
 
-	ret = set_evtchn_to_irq(evtchn, irq);
+	ret = set_evtchn_to_irq(xh, evtchn, irq);
 	if (ret < 0)
 		return ret;
 
@@ -182,29 +185,34 @@ static int xen_irq_info_common_setup(struct irq_info *info,
 	return xen_evtchn_port_setup(info);
 }
 
-static int xen_irq_info_evtchn_setup(unsigned irq,
+static int xen_irq_info_evtchn_setup(xenhost_t *xh,
+				     unsigned irq,
 				     unsigned evtchn)
 {
 	struct irq_info *info = info_for_irq(irq);
 
-	return xen_irq_info_common_setup(info, irq, IRQT_EVTCHN, evtchn, 0);
+	return xen_irq_info_common_setup(info, xh, irq, IRQT_EVTCHN, evtchn, 0);
 }
 
-static int xen_irq_info_ipi_setup(unsigned cpu,
+static int xen_irq_info_ipi_setup(xenhost_t *xh,
+				  unsigned cpu,
 				  unsigned irq,
 				  unsigned evtchn,
 				  enum ipi_vector ipi)
 {
 	struct irq_info *info = info_for_irq(irq);
 
+	BUG_ON(xh->type != xenhost_r1);
+
 	info->u.ipi = ipi;
 
 	per_cpu(ipi_to_irq, cpu)[ipi] = irq;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_IPI, evtchn, 0);
+	return xen_irq_info_common_setup(info, xh, irq, IRQT_IPI, evtchn, 0);
 }
 
-static int xen_irq_info_virq_setup(unsigned cpu,
+static int xen_irq_info_virq_setup(xenhost_t *xh,
+				   unsigned cpu,
 				   unsigned irq,
 				   unsigned evtchn,
 				   unsigned virq)
@@ -215,10 +223,11 @@ static int xen_irq_info_virq_setup(unsigned cpu,
 
 	per_cpu(virq_to_irq, cpu)[virq] = irq;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_VIRQ, evtchn, 0);
+	return xen_irq_info_common_setup(info, xh, irq, IRQT_VIRQ, evtchn, 0);
 }
 
-static int xen_irq_info_pirq_setup(unsigned irq,
+static int xen_irq_info_pirq_setup(xenhost_t *xh,
+				   unsigned irq,
 				   unsigned evtchn,
 				   unsigned pirq,
 				   unsigned gsi,
@@ -232,12 +241,12 @@ static int xen_irq_info_pirq_setup(unsigned irq,
 	info->u.pirq.domid = domid;
 	info->u.pirq.flags = flags;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_PIRQ, evtchn, 0);
+	return xen_irq_info_common_setup(info, xh, irq, IRQT_PIRQ, evtchn, 0);
 }
 
 static void xen_irq_info_cleanup(struct irq_info *info)
 {
-	set_evtchn_to_irq(info->evtchn, -1);
+	set_evtchn_to_irq(info->xh, info->evtchn, -1);
 	info->evtchn = 0;
 }
 
@@ -252,9 +261,9 @@ unsigned int evtchn_from_irq(unsigned irq)
 	return info_for_irq(irq)->evtchn;
 }
 
-unsigned irq_from_evtchn(unsigned int evtchn)
+unsigned irq_from_evtchn(xenhost_t *xh, unsigned int evtchn)
 {
-	return get_evtchn_to_irq(evtchn);
+	return get_evtchn_to_irq(xh, evtchn);
 }
 EXPORT_SYMBOL_GPL(irq_from_evtchn);
 
@@ -303,9 +312,9 @@ unsigned cpu_from_irq(unsigned irq)
 	return info_for_irq(irq)->cpu;
 }
 
-unsigned int cpu_from_evtchn(unsigned int evtchn)
+unsigned int cpu_from_evtchn(xenhost_t *xh, unsigned int evtchn)
 {
-	int irq = get_evtchn_to_irq(evtchn);
+	int irq = get_evtchn_to_irq(xh, evtchn);
 	unsigned ret = 0;
 
 	if (irq != -1)
@@ -329,9 +338,9 @@ static bool pirq_needs_eoi_flag(unsigned irq)
 	return info->u.pirq.flags & PIRQ_NEEDS_EOI;
 }
 
-static void bind_evtchn_to_cpu(unsigned int chn, unsigned int cpu)
+static void bind_evtchn_to_cpu(xenhost_t *xh, unsigned int chn, unsigned int cpu)
 {
-	int irq = get_evtchn_to_irq(chn);
+	int irq = get_evtchn_to_irq(xh, chn);
 	struct irq_info *info = info_for_irq(irq);
 
 	BUG_ON(irq == -1);
@@ -356,11 +365,11 @@ void notify_remote_via_irq(int irq)
 	int evtchn = evtchn_from_irq(irq);
 
 	if (VALID_EVTCHN(evtchn))
-		notify_remote_via_evtchn(evtchn);
+		notify_remote_via_evtchn(info_for_irq(irq)->xh, evtchn);
 }
 EXPORT_SYMBOL_GPL(notify_remote_via_irq);
 
-static void xen_irq_init(unsigned irq)
+static void xen_irq_init(xenhost_t *xh, unsigned irq)
 {
 	struct irq_info *info;
 #ifdef CONFIG_SMP
@@ -374,31 +383,32 @@ static void xen_irq_init(unsigned irq)
 
 	info->type = IRQT_UNBOUND;
 	info->refcnt = -1;
+	info->xh = xh;
 
 	irq_set_handler_data(irq, info);
 
 	list_add_tail(&info->list, &xen_irq_list_head);
 }
 
-static int __must_check xen_allocate_irqs_dynamic(int nvec)
+static int __must_check xen_allocate_irqs_dynamic(xenhost_t *xh, int nvec)
 {
 	int i, irq = irq_alloc_descs(-1, 0, nvec, -1);
 
 	if (irq >= 0) {
 		for (i = 0; i < nvec; i++)
-			xen_irq_init(irq + i);
+			xen_irq_init(xh, irq + i);
 	}
 
 	return irq;
 }
 
-static inline int __must_check xen_allocate_irq_dynamic(void)
+static inline int __must_check xen_allocate_irq_dynamic(xenhost_t *xh)
 {
 
-	return xen_allocate_irqs_dynamic(1);
+	return xen_allocate_irqs_dynamic(xh, 1);
 }
 
-static int __must_check xen_allocate_irq_gsi(unsigned gsi)
+static int __must_check xen_allocate_irq_gsi(xenhost_t *xh, unsigned gsi)
 {
 	int irq;
 
@@ -409,7 +419,7 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
 	 * space.
 	 */
 	if (xen_pv_domain() && !xen_initial_domain())
-		return xen_allocate_irq_dynamic();
+		return xen_allocate_irq_dynamic(xh);
 
 	/* Legacy IRQ descriptors are already allocated by the arch. */
 	if (gsi < nr_legacy_irqs())
@@ -417,7 +427,7 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
 	else
 		irq = irq_alloc_desc_at(gsi, -1);
 
-	xen_irq_init(irq);
+	xen_irq_init(xh, irq);
 
 	return irq;
 }
@@ -444,12 +454,12 @@ static void xen_free_irq(unsigned irq)
 	irq_free_desc(irq);
 }
 
-static void xen_evtchn_close(unsigned int port)
+static void xen_evtchn_close(xenhost_t *xh, unsigned int port)
 {
 	struct evtchn_close close;
 
 	close.port = port;
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
+	if (hypervisor_event_channel_op(xh, EVTCHNOP_close, &close) != 0)
 		BUG();
 }
 
@@ -473,6 +483,7 @@ static void eoi_pirq(struct irq_data *data)
 {
 	int evtchn = evtchn_from_irq(data->irq);
 	struct physdev_eoi eoi = { .irq = pirq_from_irq(data->irq) };
+	xenhost_t *xh = info_for_irq(data->irq)->xh;
 	int rc = 0;
 
 	if (!VALID_EVTCHN(evtchn))
@@ -480,16 +491,16 @@ static void eoi_pirq(struct irq_data *data)
 
 	if (unlikely(irqd_is_setaffinity_pending(data)) &&
 	    likely(!irqd_irq_disabled(data))) {
-		int masked = test_and_set_mask(evtchn);
+		int masked = test_and_set_mask(xh, evtchn);
 
-		clear_evtchn(evtchn);
+		clear_evtchn(xh, evtchn);
 
 		irq_move_masked_irq(data);
 
 		if (!masked)
-			unmask_evtchn(evtchn);
+			unmask_evtchn(xh, evtchn);
 	} else
-		clear_evtchn(evtchn);
+		clear_evtchn(xh, evtchn);
 
 	if (pirq_needs_eoi(data->irq)) {
 		rc = HYPERVISOR_physdev_op(PHYSDEVOP_eoi, &eoi);
@@ -519,7 +530,7 @@ static unsigned int __startup_pirq(unsigned int irq)
 	/* NB. We are happy to share unless we are probing. */
 	bind_pirq.flags = info->u.pirq.flags & PIRQ_SHAREABLE ?
 					BIND_PIRQ__WILL_SHARE : 0;
-	rc = HYPERVISOR_event_channel_op(EVTCHNOP_bind_pirq, &bind_pirq);
+	rc = hypervisor_event_channel_op(info->xh, EVTCHNOP_bind_pirq, &bind_pirq);
 	if (rc != 0) {
 		pr_warn("Failed to obtain physical IRQ %d\n", irq);
 		return 0;
@@ -528,26 +539,26 @@ static unsigned int __startup_pirq(unsigned int irq)
 
 	pirq_query_unmask(irq);
 
-	rc = set_evtchn_to_irq(evtchn, irq);
+	rc = set_evtchn_to_irq(info->xh, evtchn, irq);
 	if (rc)
 		goto err;
 
 	info->evtchn = evtchn;
-	bind_evtchn_to_cpu(evtchn, 0);
+	bind_evtchn_to_cpu(info->xh, evtchn, 0);
 
 	rc = xen_evtchn_port_setup(info);
 	if (rc)
 		goto err;
 
 out:
-	unmask_evtchn(evtchn);
+	unmask_evtchn(info->xh, evtchn);
 	eoi_pirq(irq_get_irq_data(irq));
 
 	return 0;
 
 err:
 	pr_err("irq%d: Failed to set port to irq mapping (%d)\n", irq, rc);
-	xen_evtchn_close(evtchn);
+	xen_evtchn_close(info->xh, evtchn);
 	return 0;
 }
 
@@ -567,8 +578,8 @@ static void shutdown_pirq(struct irq_data *data)
 	if (!VALID_EVTCHN(evtchn))
 		return;
 
-	mask_evtchn(evtchn);
-	xen_evtchn_close(evtchn);
+	mask_evtchn(info->xh, evtchn);
+	xen_evtchn_close(info->xh, evtchn);
 	xen_irq_info_cleanup(info);
 }
 
@@ -612,7 +623,7 @@ static void __unbind_from_irq(unsigned int irq)
 	if (VALID_EVTCHN(evtchn)) {
 		unsigned int cpu = cpu_from_irq(irq);
 
-		xen_evtchn_close(evtchn);
+		xen_evtchn_close(info->xh, evtchn);
 
 		switch (type_from_irq(irq)) {
 		case IRQT_VIRQ:
@@ -641,13 +652,15 @@ static void __unbind_from_irq(unsigned int irq)
  * Shareable implies level triggered, not shareable implies edge
  * triggered here.
  */
-int xen_bind_pirq_gsi_to_irq(unsigned gsi,
+int xen_bind_pirq_gsi_to_irq(xenhost_t *xh, unsigned gsi,
 			     unsigned pirq, int shareable, char *name)
 {
 	int irq = -1;
 	struct physdev_irq irq_op;
 	int ret;
 
+	BUG_ON(xh->type != xenhost_r1);
+
 	mutex_lock(&irq_mapping_update_lock);
 
 	irq = xen_irq_from_gsi(gsi);
@@ -657,7 +670,7 @@ int xen_bind_pirq_gsi_to_irq(unsigned gsi,
 		goto out;
 	}
 
-	irq = xen_allocate_irq_gsi(gsi);
+	irq = xen_allocate_irq_gsi(xh, gsi);
 	if (irq < 0)
 		goto out;
 
@@ -668,13 +681,13 @@ int xen_bind_pirq_gsi_to_irq(unsigned gsi,
 	 * driver provides a PCI bus that does the call to do exactly
 	 * this in the priv domain. */
 	if (xen_initial_domain() &&
-	    HYPERVISOR_physdev_op(PHYSDEVOP_alloc_irq_vector, &irq_op)) {
+	    hypervisor_physdev_op(xh, PHYSDEVOP_alloc_irq_vector, &irq_op)) {
 		xen_free_irq(irq);
 		irq = -ENOSPC;
 		goto out;
 	}
 
-	ret = xen_irq_info_pirq_setup(irq, 0, pirq, gsi, DOMID_SELF,
+	ret = xen_irq_info_pirq_setup(xh, irq, 0, pirq, gsi, DOMID_SELF,
 			       shareable ? PIRQ_SHAREABLE : 0);
 	if (ret < 0) {
 		__unbind_from_irq(irq);
@@ -712,13 +725,13 @@ int xen_bind_pirq_gsi_to_irq(unsigned gsi,
 }
 
 #ifdef CONFIG_PCI_MSI
-int xen_allocate_pirq_msi(struct pci_dev *dev, struct msi_desc *msidesc)
+int xen_allocate_pirq_msi(xenhost_t *xh, struct pci_dev *dev, struct msi_desc *msidesc)
 {
 	int rc;
 	struct physdev_get_free_pirq op_get_free_pirq;
 
 	op_get_free_pirq.type = MAP_PIRQ_TYPE_MSI;
-	rc = HYPERVISOR_physdev_op(PHYSDEVOP_get_free_pirq, &op_get_free_pirq);
+	rc = hypervisor_physdev_op(xh, PHYSDEVOP_get_free_pirq, &op_get_free_pirq);
 
 	WARN_ONCE(rc == -ENOSYS,
 		  "hypervisor does not support the PHYSDEVOP_get_free_pirq interface\n");
@@ -726,21 +739,21 @@ int xen_allocate_pirq_msi(struct pci_dev *dev, struct msi_desc *msidesc)
 	return rc ? -1 : op_get_free_pirq.pirq;
 }
 
-int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
+int xen_bind_pirq_msi_to_irq(xenhost_t *xh, struct pci_dev *dev, struct msi_desc *msidesc,
 			     int pirq, int nvec, const char *name, domid_t domid)
 {
 	int i, irq, ret;
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = xen_allocate_irqs_dynamic(nvec);
+	irq = xen_allocate_irqs_dynamic(xh, nvec);
 	if (irq < 0)
 		goto out;
 
 	for (i = 0; i < nvec; i++) {
 		irq_set_chip_and_handler_name(irq + i, &xen_pirq_chip, handle_edge_irq, name);
 
-		ret = xen_irq_info_pirq_setup(irq + i, 0, pirq + i, 0, domid,
+		ret = xen_irq_info_pirq_setup(xh, irq + i, 0, pirq + i, 0, domid,
 					      i == 0 ? 0 : PIRQ_MSI_GROUP);
 		if (ret < 0)
 			goto error_irq;
@@ -776,7 +789,7 @@ int xen_destroy_irq(int irq)
 	if (xen_initial_domain() && !(info->u.pirq.flags & PIRQ_MSI_GROUP)) {
 		unmap_irq.pirq = info->u.pirq.pirq;
 		unmap_irq.domid = info->u.pirq.domid;
-		rc = HYPERVISOR_physdev_op(PHYSDEVOP_unmap_pirq, &unmap_irq);
+		rc = hypervisor_physdev_op(info->xh, PHYSDEVOP_unmap_pirq, &unmap_irq);
 		/* If another domain quits without making the pci_disable_msix
 		 * call, the Xen hypervisor takes care of freeing the PIRQs
 		 * (free_domain_pirqs).
@@ -826,34 +839,34 @@ int xen_pirq_from_irq(unsigned irq)
 }
 EXPORT_SYMBOL_GPL(xen_pirq_from_irq);
 
-int bind_evtchn_to_irq(unsigned int evtchn)
+int bind_evtchn_to_irq(xenhost_t *xh, unsigned int evtchn)
 {
 	int irq;
 	int ret;
 
-	if (evtchn >= xen_evtchn_max_channels())
+	if (evtchn >= xen_evtchn_max_channels(xh))
 		return -ENOMEM;
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = get_evtchn_to_irq(evtchn);
+	irq = get_evtchn_to_irq(xh, evtchn);
 
 	if (irq == -1) {
-		irq = xen_allocate_irq_dynamic();
+		irq = xen_allocate_irq_dynamic(xh);
 		if (irq < 0)
 			goto out;
 
 		irq_set_chip_and_handler_name(irq, &xen_dynamic_chip,
 					      handle_edge_irq, "event");
 
-		ret = xen_irq_info_evtchn_setup(irq, evtchn);
+		ret = xen_irq_info_evtchn_setup(xh, irq, evtchn);
 		if (ret < 0) {
 			__unbind_from_irq(irq);
 			irq = ret;
 			goto out;
 		}
 		/* New interdomain events are bound to VCPU 0. */
-		bind_evtchn_to_cpu(evtchn, 0);
+		bind_evtchn_to_cpu(xh, evtchn, 0);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_EVTCHN);
@@ -866,37 +879,39 @@ int bind_evtchn_to_irq(unsigned int evtchn)
 }
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
 
-static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
+static int bind_ipi_to_irq(xenhost_t *xh, unsigned int ipi, unsigned int cpu)
 {
 	struct evtchn_bind_ipi bind_ipi;
 	int evtchn, irq;
 	int ret;
 
+	BUG_ON(xh->type == xenhost_r2);
+
 	mutex_lock(&irq_mapping_update_lock);
 
 	irq = per_cpu(ipi_to_irq, cpu)[ipi];
 
 	if (irq == -1) {
-		irq = xen_allocate_irq_dynamic();
+		irq = xen_allocate_irq_dynamic(xh);
 		if (irq < 0)
 			goto out;
 
 		irq_set_chip_and_handler_name(irq, &xen_percpu_chip,
 					      handle_percpu_irq, "ipi");
 
-		bind_ipi.vcpu = xen_vcpu_nr(xh_default, cpu);
-		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_ipi,
+		bind_ipi.vcpu = xen_vcpu_nr(xh, cpu);
+		if (hypervisor_event_channel_op(xh, EVTCHNOP_bind_ipi,
 						&bind_ipi) != 0)
 			BUG();
 		evtchn = bind_ipi.port;
 
-		ret = xen_irq_info_ipi_setup(cpu, irq, evtchn, ipi);
+		ret = xen_irq_info_ipi_setup(xh, cpu, irq, evtchn, ipi);
 		if (ret < 0) {
 			__unbind_from_irq(irq);
 			irq = ret;
 			goto out;
 		}
-		bind_evtchn_to_cpu(evtchn, cpu);
+		bind_evtchn_to_cpu(xh, evtchn, cpu);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_IPI);
@@ -907,7 +922,7 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 	return irq;
 }
 
-int bind_interdomain_evtchn_to_irq(unsigned int remote_domain,
+int bind_interdomain_evtchn_to_irq(xenhost_t *xh, unsigned int remote_domain,
 				   unsigned int remote_port)
 {
 	struct evtchn_bind_interdomain bind_interdomain;
@@ -916,28 +931,28 @@ int bind_interdomain_evtchn_to_irq(unsigned int remote_domain,
 	bind_interdomain.remote_dom  = remote_domain;
 	bind_interdomain.remote_port = remote_port;
 
-	err = HYPERVISOR_event_channel_op(EVTCHNOP_bind_interdomain,
+	err = hypervisor_event_channel_op(xh, EVTCHNOP_bind_interdomain,
 					  &bind_interdomain);
 
-	return err ? : bind_evtchn_to_irq(bind_interdomain.local_port);
+	return err ? : bind_evtchn_to_irq(xh, bind_interdomain.local_port);
 }
 EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq);
 
-static int find_virq(unsigned int virq, unsigned int cpu)
+static int find_virq(xenhost_t *xh, unsigned int virq, unsigned int cpu)
 {
 	struct evtchn_status status;
 	int port, rc = -ENOENT;
 
 	memset(&status, 0, sizeof(status));
-	for (port = 0; port < xen_evtchn_max_channels(); port++) {
+	for (port = 0; port < xen_evtchn_max_channels(xh); port++) {
 		status.dom = DOMID_SELF;
 		status.port = port;
-		rc = HYPERVISOR_event_channel_op(EVTCHNOP_status, &status);
+		rc = hypervisor_event_channel_op(xh, EVTCHNOP_status, &status);
 		if (rc < 0)
 			continue;
 		if (status.status != EVTCHNSTAT_virq)
 			continue;
-		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(xh_default, cpu)) {
+		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(xh, cpu)) {
 			rc = port;
 			break;
 		}
@@ -952,13 +967,13 @@ static int find_virq(unsigned int virq, unsigned int cpu)
  * hypervisor ABI. Use xen_evtchn_max_channels() for the maximum
  * supported.
  */
-unsigned xen_evtchn_nr_channels(void)
+unsigned xen_evtchn_nr_channels(xenhost_t *xh)
 {
-        return evtchn_ops->nr_channels();
+        return evtchn_ops->nr_channels(xh);
 }
 EXPORT_SYMBOL_GPL(xen_evtchn_nr_channels);
 
-int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
+int bind_virq_to_irq(xenhost_t *xh, unsigned int virq, unsigned int cpu, bool percpu)
 {
 	struct evtchn_bind_virq bind_virq;
 	int evtchn, irq, ret;
@@ -968,7 +983,7 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 	irq = per_cpu(virq_to_irq, cpu)[virq];
 
 	if (irq == -1) {
-		irq = xen_allocate_irq_dynamic();
+		irq = xen_allocate_irq_dynamic(xh);
 		if (irq < 0)
 			goto out;
 
@@ -980,26 +995,26 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 						      handle_edge_irq, "virq");
 
 		bind_virq.virq = virq;
-		bind_virq.vcpu = xen_vcpu_nr(xh_default, cpu);
-		ret = HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq,
+		bind_virq.vcpu = xen_vcpu_nr(xh, cpu);
+		ret = hypervisor_event_channel_op(xh, EVTCHNOP_bind_virq,
 						&bind_virq);
 		if (ret == 0)
 			evtchn = bind_virq.port;
 		else {
 			if (ret == -EEXIST)
-				ret = find_virq(virq, cpu);
+				ret = find_virq(xh, virq, cpu);
 			BUG_ON(ret < 0);
 			evtchn = ret;
 		}
 
-		ret = xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
+		ret = xen_irq_info_virq_setup(xh, cpu, irq, evtchn, virq);
 		if (ret < 0) {
 			__unbind_from_irq(irq);
 			irq = ret;
 			goto out;
 		}
 
-		bind_evtchn_to_cpu(evtchn, cpu);
+		bind_evtchn_to_cpu(xh, evtchn, cpu);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_VIRQ);
@@ -1018,14 +1033,15 @@ static void unbind_from_irq(unsigned int irq)
 	mutex_unlock(&irq_mapping_update_lock);
 }
 
-int bind_evtchn_to_irqhandler(unsigned int evtchn,
+int bind_evtchn_to_irqhandler(xenhost_t *xh,
+			      unsigned int evtchn,
 			      irq_handler_t handler,
 			      unsigned long irqflags,
 			      const char *devname, void *dev_id)
 {
 	int irq, retval;
 
-	irq = bind_evtchn_to_irq(evtchn);
+	irq = bind_evtchn_to_irq(xh, evtchn);
 	if (irq < 0)
 		return irq;
 	retval = request_irq(irq, handler, irqflags, devname, dev_id);
@@ -1038,7 +1054,8 @@ int bind_evtchn_to_irqhandler(unsigned int evtchn,
 }
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irqhandler);
 
-int bind_interdomain_evtchn_to_irqhandler(unsigned int remote_domain,
+int bind_interdomain_evtchn_to_irqhandler(xenhost_t *xh,
+					  unsigned int remote_domain,
 					  unsigned int remote_port,
 					  irq_handler_t handler,
 					  unsigned long irqflags,
@@ -1047,7 +1064,7 @@ int bind_interdomain_evtchn_to_irqhandler(unsigned int remote_domain,
 {
 	int irq, retval;
 
-	irq = bind_interdomain_evtchn_to_irq(remote_domain, remote_port);
+	irq = bind_interdomain_evtchn_to_irq(xh, remote_domain, remote_port);
 	if (irq < 0)
 		return irq;
 
@@ -1061,13 +1078,14 @@ int bind_interdomain_evtchn_to_irqhandler(unsigned int remote_domain,
 }
 EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irqhandler);
 
-int bind_virq_to_irqhandler(unsigned int virq, unsigned int cpu,
+int bind_virq_to_irqhandler(xenhost_t *xh,
+			    unsigned int virq, unsigned int cpu,
 			    irq_handler_t handler,
 			    unsigned long irqflags, const char *devname, void *dev_id)
 {
 	int irq, retval;
 
-	irq = bind_virq_to_irq(virq, cpu, irqflags & IRQF_PERCPU);
+	irq = bind_virq_to_irq(xh, virq, cpu, irqflags & IRQF_PERCPU);
 	if (irq < 0)
 		return irq;
 	retval = request_irq(irq, handler, irqflags, devname, dev_id);
@@ -1080,7 +1098,8 @@ int bind_virq_to_irqhandler(unsigned int virq, unsigned int cpu,
 }
 EXPORT_SYMBOL_GPL(bind_virq_to_irqhandler);
 
-int bind_ipi_to_irqhandler(enum ipi_vector ipi,
+int bind_ipi_to_irqhandler(xenhost_t *xh,
+			   enum ipi_vector ipi,
 			   unsigned int cpu,
 			   irq_handler_t handler,
 			   unsigned long irqflags,
@@ -1089,7 +1108,7 @@ int bind_ipi_to_irqhandler(enum ipi_vector ipi,
 {
 	int irq, retval;
 
-	irq = bind_ipi_to_irq(ipi, cpu);
+	irq = bind_ipi_to_irq(xh, ipi, cpu);
 	if (irq < 0)
 		return irq;
 
@@ -1119,21 +1138,21 @@ EXPORT_SYMBOL_GPL(unbind_from_irqhandler);
  * @irq:irq bound to an event channel.
  * @priority: priority between XEN_IRQ_PRIORITY_MAX and XEN_IRQ_PRIORITY_MIN.
  */
-int xen_set_irq_priority(unsigned irq, unsigned priority)
+int xen_set_irq_priority(xenhost_t *xh, unsigned irq, unsigned priority)
 {
 	struct evtchn_set_priority set_priority;
 
 	set_priority.port = evtchn_from_irq(irq);
 	set_priority.priority = priority;
 
-	return HYPERVISOR_event_channel_op(EVTCHNOP_set_priority,
+	return hypervisor_event_channel_op(xh, EVTCHNOP_set_priority,
 					   &set_priority);
 }
 EXPORT_SYMBOL_GPL(xen_set_irq_priority);
 
-int evtchn_make_refcounted(unsigned int evtchn)
+int evtchn_make_refcounted(xenhost_t *xh, unsigned int evtchn)
 {
-	int irq = get_evtchn_to_irq(evtchn);
+	int irq = get_evtchn_to_irq(xh, evtchn);
 	struct irq_info *info;
 
 	if (irq == -1)
@@ -1152,18 +1171,18 @@ int evtchn_make_refcounted(unsigned int evtchn)
 }
 EXPORT_SYMBOL_GPL(evtchn_make_refcounted);
 
-int evtchn_get(unsigned int evtchn)
+int evtchn_get(xenhost_t *xh, unsigned int evtchn)
 {
 	int irq;
 	struct irq_info *info;
 	int err = -ENOENT;
 
-	if (evtchn >= xen_evtchn_max_channels())
+	if (evtchn >= xen_evtchn_max_channels(xh))
 		return -EINVAL;
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = get_evtchn_to_irq(evtchn);
+	irq = get_evtchn_to_irq(xh, evtchn);
 	if (irq == -1)
 		goto done;
 
@@ -1185,22 +1204,22 @@ int evtchn_get(unsigned int evtchn)
 }
 EXPORT_SYMBOL_GPL(evtchn_get);
 
-void evtchn_put(unsigned int evtchn)
+void evtchn_put(xenhost_t *xh, unsigned int evtchn)
 {
-	int irq = get_evtchn_to_irq(evtchn);
+	int irq = get_evtchn_to_irq(xh, evtchn);
 	if (WARN_ON(irq == -1))
 		return;
 	unbind_from_irq(irq);
 }
 EXPORT_SYMBOL_GPL(evtchn_put);
 
-void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector)
+void xen_send_IPI_one(xenhost_t *xh, unsigned int cpu, enum ipi_vector vector)
 {
 	int irq;
 
 #ifdef CONFIG_X86
 	if (unlikely(vector == XEN_NMI_VECTOR)) {
-		int rc =  HYPERVISOR_vcpu_op(VCPUOP_send_nmi, xen_vcpu_nr(xh_default, cpu),
+		int rc =  hypervisor_vcpu_op(xh, VCPUOP_send_nmi, xen_vcpu_nr(xh, cpu),
 					     NULL);
 		if (rc < 0)
 			printk(KERN_WARNING "Sending nmi to CPU%d failed (rc:%d)\n", cpu, rc);
@@ -1216,23 +1235,26 @@ static DEFINE_PER_CPU(unsigned, xed_nesting_count);
 
 static void __xen_evtchn_do_upcall(void)
 {
-	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
 	int cpu = get_cpu();
 	unsigned count;
+	xenhost_t **xh;
 
-	do {
-		vcpu_info->evtchn_upcall_pending = 0;
+	for_each_xenhost(xh) {
+		struct vcpu_info *vcpu_info = (*xh)->xen_vcpu[cpu];
+		do {
+			vcpu_info->evtchn_upcall_pending = 0;
 
-		if (__this_cpu_inc_return(xed_nesting_count) - 1)
-			goto out;
+			if (__this_cpu_inc_return(xed_nesting_count) - 1)
+				goto out;
 
-		xen_evtchn_handle_events(cpu);
+			xen_evtchn_handle_events(*xh, cpu);
 
-		BUG_ON(!irqs_disabled());
+			BUG_ON(!irqs_disabled());
 
-		count = __this_cpu_read(xed_nesting_count);
-		__this_cpu_write(xed_nesting_count, 0);
-	} while (count != 1 || vcpu_info->evtchn_upcall_pending);
+			count = __this_cpu_read(xed_nesting_count);
+			__this_cpu_write(xed_nesting_count, 0);
+		} while (count != 1 || vcpu_info->evtchn_upcall_pending);
+	}
 
 out:
 
@@ -1275,16 +1297,16 @@ void rebind_evtchn_irq(int evtchn, int irq)
 	mutex_lock(&irq_mapping_update_lock);
 
 	/* After resume the irq<->evtchn mappings are all cleared out */
-	BUG_ON(get_evtchn_to_irq(evtchn) != -1);
+	BUG_ON(get_evtchn_to_irq(info->xh, evtchn) != -1);
 	/* Expect irq to have been bound before,
 	   so there should be a proper type */
 	BUG_ON(info->type == IRQT_UNBOUND);
 
-	(void)xen_irq_info_evtchn_setup(irq, evtchn);
+	(void)xen_irq_info_evtchn_setup(info->xh, irq, evtchn);
 
 	mutex_unlock(&irq_mapping_update_lock);
 
-        bind_evtchn_to_cpu(evtchn, info->cpu);
+        bind_evtchn_to_cpu(info->xh, evtchn, info->cpu);
 	/* This will be deferred until interrupt is processed */
 	irq_set_affinity(irq, cpumask_of(info->cpu));
 
@@ -1293,7 +1315,7 @@ void rebind_evtchn_irq(int evtchn, int irq)
 }
 
 /* Rebind an evtchn so that it gets delivered to a specific cpu */
-int xen_rebind_evtchn_to_cpu(int evtchn, unsigned tcpu)
+int xen_rebind_evtchn_to_cpu(xenhost_t *xh, int evtchn, unsigned tcpu)
 {
 	struct evtchn_bind_vcpu bind_vcpu;
 	int masked;
@@ -1306,24 +1328,24 @@ int xen_rebind_evtchn_to_cpu(int evtchn, unsigned tcpu)
 
 	/* Send future instances of this interrupt to other vcpu. */
 	bind_vcpu.port = evtchn;
-	bind_vcpu.vcpu = xen_vcpu_nr(xh_default, tcpu);
+	bind_vcpu.vcpu = xen_vcpu_nr(xh, tcpu);
 
 	/*
 	 * Mask the event while changing the VCPU binding to prevent
 	 * it being delivered on an unexpected VCPU.
 	 */
-	masked = test_and_set_mask(evtchn);
+	masked = test_and_set_mask(xh, evtchn);
 
 	/*
 	 * If this fails, it usually just indicates that we're dealing with a
 	 * virq or IPI channel, which don't actually need to be rebound. Ignore
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
-		bind_evtchn_to_cpu(evtchn, tcpu);
+	if (hypervisor_event_channel_op(xh, EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
+		bind_evtchn_to_cpu(xh, evtchn, tcpu);
 
 	if (!masked)
-		unmask_evtchn(evtchn);
+		unmask_evtchn(xh, evtchn);
 
 	return 0;
 }
@@ -1333,7 +1355,10 @@ static int set_affinity_irq(struct irq_data *data, const struct cpumask *dest,
 			    bool force)
 {
 	unsigned tcpu = cpumask_first_and(dest, cpu_online_mask);
-	int ret = xen_rebind_evtchn_to_cpu(evtchn_from_irq(data->irq), tcpu);
+	xenhost_t *xh = info_for_irq(data->irq)->xh;
+	int ret;
+
+	ret = xen_rebind_evtchn_to_cpu(xh, evtchn_from_irq(data->irq), tcpu);
 
 	if (!ret)
 		irq_data_update_effective_affinity(data, cpumask_of(tcpu));
@@ -1344,38 +1369,41 @@ static int set_affinity_irq(struct irq_data *data, const struct cpumask *dest,
 static void enable_dynirq(struct irq_data *data)
 {
 	int evtchn = evtchn_from_irq(data->irq);
+	xenhost_t *xh = info_for_irq(data->irq)->xh;
 
 	if (VALID_EVTCHN(evtchn))
-		unmask_evtchn(evtchn);
+		unmask_evtchn(xh, evtchn);
 }
 
 static void disable_dynirq(struct irq_data *data)
 {
 	int evtchn = evtchn_from_irq(data->irq);
+	xenhost_t *xh = info_for_irq(data->irq)->xh;
 
 	if (VALID_EVTCHN(evtchn))
-		mask_evtchn(evtchn);
+		mask_evtchn(xh, evtchn);
 }
 
 static void ack_dynirq(struct irq_data *data)
 {
 	int evtchn = evtchn_from_irq(data->irq);
+	xenhost_t *xh = info_for_irq(data->irq)->xh;
 
 	if (!VALID_EVTCHN(evtchn))
 		return;
 
 	if (unlikely(irqd_is_setaffinity_pending(data)) &&
 	    likely(!irqd_irq_disabled(data))) {
-		int masked = test_and_set_mask(evtchn);
+		int masked = test_and_set_mask(xh, evtchn);
 
-		clear_evtchn(evtchn);
+		clear_evtchn(xh, evtchn);
 
 		irq_move_masked_irq(data);
 
 		if (!masked)
-			unmask_evtchn(evtchn);
+			unmask_evtchn(xh, evtchn);
 	} else
-		clear_evtchn(evtchn);
+		clear_evtchn(xh, evtchn);
 }
 
 static void mask_ack_dynirq(struct irq_data *data)
@@ -1387,15 +1415,16 @@ static void mask_ack_dynirq(struct irq_data *data)
 static int retrigger_dynirq(struct irq_data *data)
 {
 	unsigned int evtchn = evtchn_from_irq(data->irq);
+	xenhost_t *xh = info_for_irq(data->irq)->xh;
 	int masked;
 
 	if (!VALID_EVTCHN(evtchn))
 		return 0;
 
-	masked = test_and_set_mask(evtchn);
-	set_evtchn(evtchn);
+	masked = test_and_set_mask(xh, evtchn);
+	set_evtchn(xh, evtchn);
 	if (!masked)
-		unmask_evtchn(evtchn);
+		unmask_evtchn(xh, evtchn);
 
 	return 1;
 }
@@ -1442,24 +1471,26 @@ static void restore_cpu_virqs(unsigned int cpu)
 {
 	struct evtchn_bind_virq bind_virq;
 	int virq, irq, evtchn;
+	xenhost_t *xh;
 
 	for (virq = 0; virq < NR_VIRQS; virq++) {
 		if ((irq = per_cpu(virq_to_irq, cpu)[virq]) == -1)
 			continue;
+		xh = info_for_irq(irq)->xh;
 
 		BUG_ON(virq_from_irq(irq) != virq);
 
 		/* Get a new binding from Xen. */
 		bind_virq.virq = virq;
 		bind_virq.vcpu = xen_vcpu_nr(xh_default, cpu);
-		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq,
+		if (hypervisor_event_channel_op(xh, EVTCHNOP_bind_virq,
 						&bind_virq) != 0)
 			BUG();
 		evtchn = bind_virq.port;
 
 		/* Record the new mapping. */
-		(void)xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
-		bind_evtchn_to_cpu(evtchn, cpu);
+		(void)xen_irq_info_virq_setup(xh, cpu, irq, evtchn, virq);
+		bind_evtchn_to_cpu(xh, evtchn, cpu);
 	}
 }
 
@@ -1467,23 +1498,25 @@ static void restore_cpu_ipis(unsigned int cpu)
 {
 	struct evtchn_bind_ipi bind_ipi;
 	int ipi, irq, evtchn;
+	xenhost_t *xh;
 
 	for (ipi = 0; ipi < XEN_NR_IPIS; ipi++) {
 		if ((irq = per_cpu(ipi_to_irq, cpu)[ipi]) == -1)
 			continue;
+		xh = info_for_irq(irq)->xh;
 
 		BUG_ON(ipi_from_irq(irq) != ipi);
 
 		/* Get a new binding from Xen. */
-		bind_ipi.vcpu = xen_vcpu_nr(xh_default, cpu);
-		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_ipi,
+		bind_ipi.vcpu = xen_vcpu_nr(xh, cpu);
+		if (hypervisor_event_channel_op(xh, EVTCHNOP_bind_ipi,
 						&bind_ipi) != 0)
 			BUG();
 		evtchn = bind_ipi.port;
 
 		/* Record the new mapping. */
-		(void)xen_irq_info_ipi_setup(cpu, irq, evtchn, ipi);
-		bind_evtchn_to_cpu(evtchn, cpu);
+		(void)xen_irq_info_ipi_setup(xh, cpu, irq, evtchn, ipi);
+		bind_evtchn_to_cpu(xh, evtchn, cpu);
 	}
 }
 
@@ -1491,26 +1524,29 @@ static void restore_cpu_ipis(unsigned int cpu)
 void xen_clear_irq_pending(int irq)
 {
 	int evtchn = evtchn_from_irq(irq);
+	xenhost_t *xh = info_for_irq(irq)->xh;
 
 	if (VALID_EVTCHN(evtchn))
-		clear_evtchn(evtchn);
+		clear_evtchn(xh, evtchn);
 }
 EXPORT_SYMBOL(xen_clear_irq_pending);
 void xen_set_irq_pending(int irq)
 {
 	int evtchn = evtchn_from_irq(irq);
+	xenhost_t *xh = info_for_irq(irq)->xh;
 
 	if (VALID_EVTCHN(evtchn))
-		set_evtchn(evtchn);
+		set_evtchn(xh, evtchn);
 }
 
 bool xen_test_irq_pending(int irq)
 {
 	int evtchn = evtchn_from_irq(irq);
+	xenhost_t *xh = info_for_irq(irq)->xh;
 	bool ret = false;
 
 	if (VALID_EVTCHN(evtchn))
-		ret = test_evtchn(evtchn);
+		ret = test_evtchn(xh, evtchn);
 
 	return ret;
 }
@@ -1520,10 +1556,13 @@ bool xen_test_irq_pending(int irq)
 void xen_poll_irq_timeout(int irq, u64 timeout)
 {
 	evtchn_port_t evtchn = evtchn_from_irq(irq);
+	xenhost_t *xh = info_for_irq(irq)->xh;
 
 	if (VALID_EVTCHN(evtchn)) {
 		struct sched_poll poll;
 
+		BUG_ON(xh->type != xenhost_r1);
+
 		poll.nr_ports = 1;
 		poll.timeout = timeout;
 		set_xen_guest_handle(poll.ports, &evtchn);
@@ -1665,26 +1704,30 @@ void xen_callback_vector(void) {}
 static bool fifo_events = true;
 module_param(fifo_events, bool, 0);
 
-void __init xen_init_IRQ(void)
+void xen_init_IRQ(xenhost_t *xh)
 {
 	int ret = -EINVAL;
 	unsigned int evtchn;
 
-	if (fifo_events)
-		ret = xen_evtchn_fifo_init();
 	if (ret < 0)
-		xen_evtchn_2l_init();
+		xen_evtchn_2l_init(xh);
 
-	evtchn_to_irq = kcalloc(EVTCHN_ROW(xen_evtchn_max_channels()),
-				sizeof(*evtchn_to_irq), GFP_KERNEL);
-	BUG_ON(!evtchn_to_irq);
+	xh->evtchn_to_irq = kcalloc(EVTCHN_ROW(xh, xen_evtchn_max_channels(xh)),
+				sizeof(*(xh->evtchn_to_irq)), GFP_KERNEL);
+	BUG_ON(!xh->evtchn_to_irq);
 
 	/* No event channels are 'live' right now. */
-	for (evtchn = 0; evtchn < xen_evtchn_nr_channels(); evtchn++)
-		mask_evtchn(evtchn);
+	for (evtchn = 0; evtchn < xen_evtchn_nr_channels(xh); evtchn++)
+		mask_evtchn(xh, evtchn);
 
 	pirq_needs_eoi = pirq_needs_eoi_flag;
 
+	/*
+	 * Callback vectors, HW irqs are only for xenhost_r1
+	 */
+	if (xh->type != xenhost_r1)
+		return;
+
 #ifdef CONFIG_X86
 	if (xen_pv_domain()) {
 		irq_ctx_init(smp_processor_id());
diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index eed766219dd0..38ce98f96fbb 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -324,7 +324,7 @@ static void consume_one_event(unsigned cpu,
 	q->head[priority] = head;
 }
 
-static void __evtchn_fifo_handle_events(unsigned cpu, bool drop)
+static void __evtchn_fifo_handle_events(xenhost_t *xh, unsigned cpu, bool drop)
 {
 	struct evtchn_fifo_control_block *control_block;
 	unsigned long ready;
diff --git a/drivers/xen/events/events_internal.h b/drivers/xen/events/events_internal.h
index 50c2050a1e32..9293c2593846 100644
--- a/drivers/xen/events/events_internal.h
+++ b/drivers/xen/events/events_internal.h
@@ -21,6 +21,7 @@ enum xen_irq_type {
 /*
  * Packed IRQ information:
  * type - enum xen_irq_type
+ * xh - xenhost_t *
  * event channel - irq->event channel mapping
  * cpu - cpu this event channel is bound to
  * index - type-specific information:
@@ -32,6 +33,7 @@ enum xen_irq_type {
  */
 struct irq_info {
 	struct list_head list;
+	xenhost_t *xh;
 	int refcnt;
 	enum xen_irq_type type;	/* type */
 	unsigned irq;
@@ -56,35 +58,32 @@ struct irq_info {
 #define PIRQ_MSI_GROUP	(1 << 2)
 
 struct evtchn_ops {
-	unsigned (*max_channels)(void);
-	unsigned (*nr_channels)(void);
+	unsigned (*max_channels)(xenhost_t *xh);
+	unsigned (*nr_channels)(xenhost_t *xh);
 
 	int (*setup)(struct irq_info *info);
 	void (*bind_to_cpu)(struct irq_info *info, unsigned cpu);
 
-	void (*clear_pending)(unsigned port);
-	void (*set_pending)(unsigned port);
-	bool (*is_pending)(unsigned port);
-	bool (*test_and_set_mask)(unsigned port);
-	void (*mask)(unsigned port);
-	void (*unmask)(unsigned port);
+	void (*clear_pending)(xenhost_t *xh, unsigned port);
+	void (*set_pending)(xenhost_t *xh, unsigned port);
+	bool (*is_pending)(xenhost_t *xh, unsigned port);
+	bool (*test_and_set_mask)(xenhost_t *xh, unsigned port);
+	void (*mask)(xenhost_t *xh, unsigned port);
+	void (*unmask)(xenhost_t *xh, unsigned port);
 
-	void (*handle_events)(unsigned cpu);
-	void (*resume)(void);
+	void (*handle_events)(xenhost_t *xh, unsigned cpu);
+	void (*resume)(xenhost_t *xh);
 };
 
-extern const struct evtchn_ops *evtchn_ops;
-
-extern int **evtchn_to_irq;
-int get_evtchn_to_irq(unsigned int evtchn);
+int get_evtchn_to_irq(xenhost_t *xh, unsigned int evtchn);
 
 struct irq_info *info_for_irq(unsigned irq);
 unsigned cpu_from_irq(unsigned irq);
-unsigned cpu_from_evtchn(unsigned int evtchn);
+unsigned cpu_from_evtchn(xenhost_t *xh, unsigned int evtchn);
 
-static inline unsigned xen_evtchn_max_channels(void)
+static inline unsigned xen_evtchn_max_channels(xenhost_t *xh)
 {
-	return evtchn_ops->max_channels();
+	return xh->evtchn_ops->max_channels(xh);
 }
 
 /*
@@ -93,59 +92,62 @@ static inline unsigned xen_evtchn_max_channels(void)
  */
 static inline int xen_evtchn_port_setup(struct irq_info *info)
 {
-	if (evtchn_ops->setup)
-		return evtchn_ops->setup(info);
+	if (info->xh->evtchn_ops->setup)
+		return info->xh->evtchn_ops->setup(info);
 	return 0;
 }
 
 static inline void xen_evtchn_port_bind_to_cpu(struct irq_info *info,
 					       unsigned cpu)
 {
-	evtchn_ops->bind_to_cpu(info, cpu);
+	info->xh->evtchn_ops->bind_to_cpu(info, cpu);
 }
 
-static inline void clear_evtchn(unsigned port)
+static inline void clear_evtchn(xenhost_t *xh, unsigned port)
 {
-	evtchn_ops->clear_pending(port);
+	xh->evtchn_ops->clear_pending(xh, port);
 }
 
-static inline void set_evtchn(unsigned port)
+static inline void set_evtchn(xenhost_t *xh, unsigned port)
 {
-	evtchn_ops->set_pending(port);
+	xh->evtchn_ops->set_pending(xh, port);
 }
 
-static inline bool test_evtchn(unsigned port)
+static inline bool test_evtchn(xenhost_t *xh, unsigned port)
 {
-	return evtchn_ops->is_pending(port);
+	return xh->evtchn_ops->is_pending(xh, port);
 }
 
-static inline bool test_and_set_mask(unsigned port)
+static inline bool test_and_set_mask(xenhost_t *xh, unsigned port)
 {
-	return evtchn_ops->test_and_set_mask(port);
+	return xh->evtchn_ops->test_and_set_mask(xh, port);
 }
 
-static inline void mask_evtchn(unsigned port)
+static inline void mask_evtchn(xenhost_t *xh, unsigned port)
 {
-	return evtchn_ops->mask(port);
+	return xh->evtchn_ops->mask(xh, port);
 }
 
-static inline void unmask_evtchn(unsigned port)
+static inline void unmask_evtchn(xenhost_t *xh, unsigned port)
 {
-	return evtchn_ops->unmask(port);
+	return xh->evtchn_ops->unmask(xh, port);
 }
 
-static inline void xen_evtchn_handle_events(unsigned cpu)
+static inline void xen_evtchn_handle_events(xenhost_t *xh, unsigned cpu)
 {
-	return evtchn_ops->handle_events(cpu);
+	return xh->evtchn_ops->handle_events(xh, cpu);
 }
 
 static inline void xen_evtchn_resume(void)
 {
-	if (evtchn_ops->resume)
-		evtchn_ops->resume();
+	xenhost_t **xh;
+
+	for_each_xenhost(xh)
+		if ((*xh)->evtchn_ops->resume)
+			(*xh)->evtchn_ops->resume(*xh);
 }
 
-void xen_evtchn_2l_init(void);
-int xen_evtchn_fifo_init(void);
+void xen_evtchn_2l_init(xenhost_t *xh);
+int xen_evtchn_fifo_init(xenhost_t *xh);
 
 #endif /* #ifndef __EVENTS_INTERNAL_H__ */
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 66622109f2be..b868816874fd 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -292,7 +292,7 @@ static ssize_t evtchn_write(struct file *file, const char __user *buf,
 		evtchn = find_evtchn(u, port);
 		if (evtchn && !evtchn->enabled) {
 			evtchn->enabled = true;
-			enable_irq(irq_from_evtchn(port));
+			enable_irq(irq_from_evtchn(xh_default, port));
 		}
 	}
 
@@ -392,18 +392,18 @@ static int evtchn_bind_to_user(struct per_user_data *u, int port)
 	if (rc < 0)
 		goto err;
 
-	rc = bind_evtchn_to_irqhandler(port, evtchn_interrupt, 0,
+	rc = bind_evtchn_to_irqhandler(xh_default, port, evtchn_interrupt, 0,
 				       u->name, evtchn);
 	if (rc < 0)
 		goto err;
 
-	rc = evtchn_make_refcounted(port);
+	rc = evtchn_make_refcounted(xh_default, port);
 	return rc;
 
 err:
 	/* bind failed, should close the port now */
 	close.port = port;
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
+	if (hypervisor_event_channel_op(xh_default, EVTCHNOP_close, &close) != 0)
 		BUG();
 	del_evtchn(u, evtchn);
 	return rc;
@@ -412,7 +412,7 @@ static int evtchn_bind_to_user(struct per_user_data *u, int port)
 static void evtchn_unbind_from_user(struct per_user_data *u,
 				    struct user_evtchn *evtchn)
 {
-	int irq = irq_from_evtchn(evtchn->port);
+	int irq = irq_from_evtchn(xh_default, evtchn->port);
 
 	BUG_ON(irq < 0);
 
@@ -429,7 +429,7 @@ static void evtchn_bind_interdom_next_vcpu(int evtchn)
 	struct irq_desc *desc;
 	unsigned long flags;
 
-	irq = irq_from_evtchn(evtchn);
+	irq = irq_from_evtchn(xh_default, evtchn);
 	desc = irq_to_desc(irq);
 
 	if (!desc)
@@ -447,7 +447,7 @@ static void evtchn_bind_interdom_next_vcpu(int evtchn)
 	this_cpu_write(bind_last_selected_cpu, selected_cpu);
 
 	/* unmask expects irqs to be disabled */
-	xen_rebind_evtchn_to_cpu(evtchn, selected_cpu);
+	xen_rebind_evtchn_to_cpu(xh_default, evtchn, selected_cpu);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -549,7 +549,7 @@ static long evtchn_ioctl(struct file *file,
 			break;
 
 		rc = -EINVAL;
-		if (unbind.port >= xen_evtchn_nr_channels())
+		if (unbind.port >= xen_evtchn_nr_channels(xh_default))
 			break;
 
 		rc = -ENOTCONN;
@@ -557,7 +557,7 @@ static long evtchn_ioctl(struct file *file,
 		if (!evtchn)
 			break;
 
-		disable_irq(irq_from_evtchn(unbind.port));
+		disable_irq(irq_from_evtchn(xh_default, unbind.port));
 		evtchn_unbind_from_user(u, evtchn);
 		rc = 0;
 		break;
@@ -574,7 +574,7 @@ static long evtchn_ioctl(struct file *file,
 		rc = -ENOTCONN;
 		evtchn = find_evtchn(u, notify.port);
 		if (evtchn) {
-			notify_remote_via_evtchn(notify.port);
+			notify_remote_via_evtchn(xh_default, notify.port);
 			rc = 0;
 		}
 		break;
@@ -676,7 +676,7 @@ static int evtchn_release(struct inode *inode, struct file *filp)
 		struct user_evtchn *evtchn;
 
 		evtchn = rb_entry(node, struct user_evtchn, node);
-		disable_irq(irq_from_evtchn(evtchn->port));
+		disable_irq(irq_from_evtchn(xh_default, evtchn->port));
 		evtchn_unbind_from_user(u, evtchn);
 	}
 
diff --git a/drivers/xen/fallback.c b/drivers/xen/fallback.c
index ae81cf75ae5f..9f54fb8cf96d 100644
--- a/drivers/xen/fallback.c
+++ b/drivers/xen/fallback.c
@@ -2,6 +2,7 @@
 #include <linux/string.h>
 #include <linux/bug.h>
 #include <linux/export.h>
+#include <xen/interface/xen.h>
 #include <asm/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index 3fa40c723e8e..e07823886fa8 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -189,8 +189,8 @@ static void __del_gref(struct gntalloc_gref *gref)
 		kunmap(gref->page);
 	}
 	if (gref->notify.flags & UNMAP_NOTIFY_SEND_EVENT) {
-		notify_remote_via_evtchn(gref->notify.event);
-		evtchn_put(gref->notify.event);
+		notify_remote_via_evtchn(xh_default, gref->notify.event);
+		evtchn_put(xh_default, gref->notify.event);
 	}
 
 	gref->notify.flags = 0;
@@ -418,14 +418,14 @@ static long gntalloc_ioctl_unmap_notify(struct gntalloc_file_private_data *priv,
 	 * reference to that event channel.
 	 */
 	if (op.action & UNMAP_NOTIFY_SEND_EVENT) {
-		if (evtchn_get(op.event_channel_port)) {
+		if (evtchn_get(xh_default, op.event_channel_port)) {
 			rc = -EINVAL;
 			goto unlock_out;
 		}
 	}
 
 	if (gref->notify.flags & UNMAP_NOTIFY_SEND_EVENT)
-		evtchn_put(gref->notify.event);
+		evtchn_put(xh_default, gref->notify.event);
 
 	gref->notify.flags = op.action;
 	gref->notify.pgoff = pgoff;
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5efc5eee9544..0f0c951cd5b1 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -247,8 +247,8 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
 	atomic_sub(map->count, &pages_mapped);
 
 	if (map->notify.flags & UNMAP_NOTIFY_SEND_EVENT) {
-		notify_remote_via_evtchn(map->notify.event);
-		evtchn_put(map->notify.event);
+		notify_remote_via_evtchn(xh_default, map->notify.event);
+		evtchn_put(xh_default, map->notify.event);
 	}
 
 	if (populate_freeable_maps && priv) {
@@ -790,7 +790,7 @@ static long gntdev_ioctl_notify(struct gntdev_priv *priv, void __user *u)
 	 * reference to that event channel.
 	 */
 	if (op.action & UNMAP_NOTIFY_SEND_EVENT) {
-		if (evtchn_get(op.event_channel_port))
+		if (evtchn_get(xh_default, op.event_channel_port))
 			return -EINVAL;
 	}
 
@@ -829,7 +829,7 @@ static long gntdev_ioctl_notify(struct gntdev_priv *priv, void __user *u)
 
 	/* Drop the reference to the event channel we did not save in the map */
 	if (out_flags & UNMAP_NOTIFY_SEND_EVENT)
-		evtchn_put(out_event);
+		evtchn_put(xh_default, out_event);
 
 	return rc;
 }
diff --git a/drivers/xen/mcelog.c b/drivers/xen/mcelog.c
index b8bf61abb65b..45be85960f53 100644
--- a/drivers/xen/mcelog.c
+++ b/drivers/xen/mcelog.c
@@ -378,7 +378,7 @@ static int bind_virq_for_mce(void)
 		return ret;
 	}
 
-	ret  = bind_virq_to_irqhandler(VIRQ_MCA, 0,
+	ret  = bind_virq_to_irqhandler(xh_default, VIRQ_MCA, 0,
 				       xen_mce_interrupt, 0, "mce", NULL);
 	if (ret < 0) {
 		pr_err("Failed to bind virq\n");
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index cdc6daa7a9f6..d0807f8fbd8b 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -387,7 +387,7 @@ static int __init xen_pcpu_init(void)
 	if (!xen_initial_domain())
 		return -ENODEV;
 
-	irq = bind_virq_to_irqhandler(VIRQ_PCPU_STATE, 0,
+	irq = bind_virq_to_irqhandler(xh_default, VIRQ_PCPU_STATE, 0,
 				      xen_pcpu_interrupt, 0,
 				      "xen-pcpu", NULL);
 	if (irq < 0) {
diff --git a/drivers/xen/preempt.c b/drivers/xen/preempt.c
index 08cb419eb4e6..b5f16a98414b 100644
--- a/drivers/xen/preempt.c
+++ b/drivers/xen/preempt.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/sched.h>
+#include <xen/interface/xen.h>
 #include <xen/xen-ops.h>
 
 #ifndef CONFIG_PREEMPT
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b24ddac1604b..b5541f862720 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -27,6 +27,7 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 9d314bba7c4e..005a898e7a23 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -13,12 +13,12 @@
 #include <linux/kobject.h>
 #include <linux/err.h>
 
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
 #include <xen/xen.h>
 #include <xen/xenbus.h>
-#include <xen/interface/xen.h>
 #include <xen/interface/version.h>
 #ifdef CONFIG_XEN_HAVE_VPMU
 #include <xen/interface/xenpmu.h>
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index feee74bbab0a..73916766dcac 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -8,13 +8,13 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 
+#include <xen/interface/xen.h>
 #include <asm/paravirt.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
 #include <xen/events.h>
 #include <xen/features.h>
-#include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
 #include <xen/xen-ops.h>
 
diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index 581c4e1a8b82..b95dd65f3872 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -123,7 +123,7 @@ static int xen_pcibk_do_attach(struct xen_pcibk_device *pdev, int gnt_ref,
 
 	pdev->sh_info = vaddr;
 
-	err = bind_interdomain_evtchn_to_irqhandler(
+	err = bind_interdomain_evtchn_to_irqhandler(xh_default,
 		pdev->xdev->otherend_id, remote_evtchn, xen_pcibk_handle_event,
 		0, DRV_NAME, pdev);
 	if (err < 0) {
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index c9e23a126218..8702b1ac92a8 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -54,8 +54,9 @@
 #include <target/target_core_base.h>
 #include <target/target_core_fabric.h>
 
+
+#include <xen/interface/xen.h>
 #include <asm/hypervisor.h>
-
 #include <xen/xen.h>
 #include <xen/balloon.h>
 #include <xen/events.h>
@@ -829,7 +830,7 @@ static int scsiback_init_sring(struct vscsibk_info *info, grant_ref_t ring_ref,
 	sring = (struct vscsiif_sring *)area;
 	BACK_RING_INIT(&info->ring, sring, PAGE_SIZE);
 
-	err = bind_interdomain_evtchn_to_irq(info->domid, evtchn);
+	err = bind_interdomain_evtchn_to_irq(xh_default, info->domid, evtchn);
 	if (err < 0)
 		goto unmap_page;
 
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index e17ca8156171..f0cf47765726 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -36,9 +36,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/export.h>
-#include <asm/xen/hypervisor.h>
 #include <xen/page.h>
 #include <xen/interface/xen.h>
+#include <asm/xen/hypervisor.h>
 #include <xen/interface/event_channel.h>
 #include <xen/balloon.h>
 #include <xen/events.h>
diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index d239fc3c5e3d..acbc366c1717 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -151,7 +151,7 @@ static int xb_write(const void *data, unsigned int len)
 
 		/* Implies mb(): other side will see the updated producer. */
 		if (prod <= intf->req_cons)
-			notify_remote_via_evtchn(xen_store_evtchn);
+			notify_remote_via_evtchn(xh_default, xen_store_evtchn);
 	}
 
 	return bytes;
@@ -204,7 +204,7 @@ static int xb_read(void *data, unsigned int len)
 
 		/* Implies mb(): other side will see the updated consumer. */
 		if (intf->rsp_prod - cons >= XENSTORE_RING_SIZE)
-			notify_remote_via_evtchn(xen_store_evtchn);
+			notify_remote_via_evtchn(xh_default, xen_store_evtchn);
 	}
 
 	return bytes;
@@ -461,7 +461,7 @@ int xb_init_comms(void)
 	} else {
 		int err;
 
-		err = bind_evtchn_to_irqhandler(xen_store_evtchn, wake_waiting,
+		err = bind_evtchn_to_irqhandler(xh_default, xen_store_evtchn, wake_waiting,
 						0, "xenbus", &xb_waitq);
 		if (err < 0) {
 			pr_err("request irq failed %i\n", err);
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5b471889d723..049bd511f36e 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -52,6 +52,7 @@
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 
 #include <xen/xen.h>
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4faf44c..d3c53a9db5e3 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -48,6 +48,7 @@
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/hypervisor.h>
 #include <xen/xenbus.h>
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index 07896f4b2736..3edab7cc03c3 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -19,6 +19,7 @@
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <xen/xenbus.h>
 #include <xen/events.h>
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3236d1b1fa01..74c2b9416b88 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -46,6 +46,7 @@
 #include <linux/reboot.h>
 #include <linux/rwsem.h>
 #include <linux/mutex.h>
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <xen/xenbus.h>
 #include <xen/xen.h>
diff --git a/include/xen/events.h b/include/xen/events.h
index a48897199975..138dbbbefc6d 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -11,27 +11,30 @@
 #include <asm/xen/hypercall.h>
 #include <asm/xen/events.h>
 
-unsigned xen_evtchn_nr_channels(void);
+unsigned xen_evtchn_nr_channels(xenhost_t *xh);
 
-int bind_evtchn_to_irq(unsigned int evtchn);
-int bind_evtchn_to_irqhandler(unsigned int evtchn,
+int bind_evtchn_to_irq(xenhost_t *xh, unsigned int evtchn);
+int bind_evtchn_to_irqhandler(xenhost_t *xh, unsigned int evtchn,
 			      irq_handler_t handler,
 			      unsigned long irqflags, const char *devname,
 			      void *dev_id);
-int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu);
-int bind_virq_to_irqhandler(unsigned int virq, unsigned int cpu,
+int bind_virq_to_irq(xenhost_t *xh, unsigned int virq, unsigned int cpu, bool percpu);
+int bind_virq_to_irqhandler(xenhost_t *xh, unsigned int virq, unsigned int cpu,
 			    irq_handler_t handler,
 			    unsigned long irqflags, const char *devname,
 			    void *dev_id);
-int bind_ipi_to_irqhandler(enum ipi_vector ipi,
+int bind_ipi_to_irqhandler(xenhost_t *xh,
+			   enum ipi_vector ipi,
 			   unsigned int cpu,
 			   irq_handler_t handler,
 			   unsigned long irqflags,
 			   const char *devname,
 			   void *dev_id);
-int bind_interdomain_evtchn_to_irq(unsigned int remote_domain,
+int bind_interdomain_evtchn_to_irq(xenhost_t *xh,
+				   unsigned int remote_domain,
 				   unsigned int remote_port);
-int bind_interdomain_evtchn_to_irqhandler(unsigned int remote_domain,
+int bind_interdomain_evtchn_to_irqhandler(xenhost_t *xh,
+					  unsigned int remote_domain,
 					  unsigned int remote_port,
 					  irq_handler_t handler,
 					  unsigned long irqflags,
@@ -48,23 +51,23 @@ void unbind_from_irqhandler(unsigned int irq, void *dev_id);
 #define XEN_IRQ_PRIORITY_MAX     EVTCHN_FIFO_PRIORITY_MAX
 #define XEN_IRQ_PRIORITY_DEFAULT EVTCHN_FIFO_PRIORITY_DEFAULT
 #define XEN_IRQ_PRIORITY_MIN     EVTCHN_FIFO_PRIORITY_MIN
-int xen_set_irq_priority(unsigned irq, unsigned priority);
+int xen_set_irq_priority(xenhost_t *xh, unsigned irq, unsigned priority);
 
 /*
  * Allow extra references to event channels exposed to userspace by evtchn
  */
-int evtchn_make_refcounted(unsigned int evtchn);
-int evtchn_get(unsigned int evtchn);
-void evtchn_put(unsigned int evtchn);
+int evtchn_make_refcounted(xenhost_t *xh, unsigned int evtchn);
+int evtchn_get(xenhost_t *xh, unsigned int evtchn);
+void evtchn_put(xenhost_t *xh, unsigned int evtchn);
 
-void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector);
+void xen_send_IPI_one(xenhost_t *xh, unsigned int cpu, enum ipi_vector vector);
 void rebind_evtchn_irq(int evtchn, int irq);
-int xen_rebind_evtchn_to_cpu(int evtchn, unsigned tcpu);
+int xen_rebind_evtchn_to_cpu(xenhost_t *xh, int evtchn, unsigned tcpu);
 
-static inline void notify_remote_via_evtchn(int port)
+static inline void notify_remote_via_evtchn(xenhost_t *xh, int port)
 {
 	struct evtchn_send send = { .port = port };
-	(void)HYPERVISOR_event_channel_op(EVTCHNOP_send, &send);
+	(void)hypervisor_event_channel_op(xh, EVTCHNOP_send, &send);
 }
 
 void notify_remote_via_irq(int irq);
@@ -85,7 +88,7 @@ void xen_poll_irq(int irq);
 void xen_poll_irq_timeout(int irq, u64 timeout);
 
 /* Determine the IRQ which is bound to an event channel */
-unsigned irq_from_evtchn(unsigned int evtchn);
+unsigned irq_from_evtchn(xenhost_t *xh,unsigned int evtchn);
 int irq_from_virq(unsigned int cpu, unsigned int virq);
 unsigned int evtchn_from_irq(unsigned irq);
 
@@ -101,14 +104,14 @@ void xen_evtchn_do_upcall(struct pt_regs *regs);
 void xen_hvm_evtchn_do_upcall(void);
 
 /* Bind a pirq for a physical interrupt to an irq. */
-int xen_bind_pirq_gsi_to_irq(unsigned gsi,
+int xen_bind_pirq_gsi_to_irq(xenhost_t *xh, unsigned gsi,
 			     unsigned pirq, int shareable, char *name);
 
 #ifdef CONFIG_PCI_MSI
 /* Allocate a pirq for a MSI style physical interrupt. */
-int xen_allocate_pirq_msi(struct pci_dev *dev, struct msi_desc *msidesc);
+int xen_allocate_pirq_msi(xenhost_t *xh, struct pci_dev *dev, struct msi_desc *msidesc);
 /* Bind an PSI pirq to an irq. */
-int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
+int xen_bind_pirq_msi_to_irq(xenhost_t *xh, struct pci_dev *dev, struct msi_desc *msidesc,
 			     int pirq, int nvec, const char *name, domid_t domid);
 #endif
 
@@ -128,5 +131,5 @@ int xen_irq_from_gsi(unsigned gsi);
 int xen_test_irq_shared(int irq);
 
 /* initialize Xen IRQ subsystem */
-void xen_init_IRQ(void);
+void xen_init_IRQ(xenhost_t *xh);
 #endif	/* _XEN_EVENTS_H */
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index f6092a8987f1..c9dabf739ff8 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -112,6 +112,23 @@ typedef struct {
 		 */
 		uint32_t xen_vcpu_id[NR_CPUS];
 	};
+
+	/*
+	 * evtchn: get init'd via x86_init.irqs.intr_init (xen_init_IRQ()).
+	 *
+	 * The common functionality for xenhost_* provided by xen_init_IRQ()
+	 * is the mapping between evtchn <-> irq.
+	 *
+	 * For all three of xenhost_r0/r1 and r2, post-init the evtchn logic
+	 * should just work using the evtchn_to_irq mapping and the vcpu_info,
+	 * shared_info state.
+	 * (Plus some state private to evtchn_2l/evtchn_fifo which for now
+	 * is defined locally.)
+	 */
+	struct {
+		const struct evtchn_ops *evtchn_ops;
+		int **evtchn_to_irq;
+	};
 } xenhost_t;
 
 typedef struct xenhost_ops {
-- 
2.20.1

