Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE6AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6337F2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qUcDrVbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfC0NVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:21 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:27108
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729844AbfC0NVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40SFnIjgxvNsiI+hPmydu4vsYSvQXaeVREae9BA1guk=;
 b=qUcDrVbwdOIPa/unlw95cgpd++wsVSUabOXqR1DNk40QlBuiVmY6WyIuAZx9oEtlddmdw0y6iWqjLZYBmDYvOHTuXm1pWCU42kNdAAT/L2lsihK0+0dE/JUViUjrPf57svLpghdSf56oW1/aQdcBy7VKMsW+x0TATUtVXK26hKQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5907.eurprd04.prod.outlook.com (20.178.202.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 13:21:11 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:21:11 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 3/7] smp: Poke the cores before requesting IPI
Thread-Topic: [RFC 3/7] smp: Poke the cores before requesting IPI
Thread-Index: AQHU5J/ysdAjuuc4sEaUwQd13R6FyA==
Date:   Wed, 27 Mar 2019 13:21:11 +0000
Message-ID: <1553692845-20983-4-git-send-email-abel.vesa@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0038.eurprd07.prod.outlook.com
 (2603:10a6:800:90::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c192940-a1a6-4210-a47b-08d6b2b71494
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5907;
x-ms-traffictypediagnostic: AM0PR04MB5907:
x-microsoft-antispam-prvs: <AM0PR04MB5907FB4CB288ACB4A9766727F6580@AM0PR04MB5907.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(25786009)(2906002)(26005)(386003)(54906003)(8676002)(68736007)(102836004)(6512007)(71200400001)(7416002)(71190400001)(446003)(5660300002)(8936002)(50226002)(4326008)(81166006)(2616005)(476003)(81156014)(44832011)(97736004)(11346002)(6116002)(3846002)(36756003)(105586002)(86362001)(106356001)(2501003)(6486002)(76176011)(6636002)(14454004)(478600001)(6506007)(316002)(52116002)(7736002)(186003)(53936002)(110136005)(6346003)(66066001)(99286004)(14444005)(256004)(486006)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5907;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LIXKcyLEH5DsJVfS9zvLh5/J5opTWB/PenemuARDTF+AmBO4Q4NCoYADb/NIyx+O8V/QgE5dRnXNNyf7EGffnfU+iviK/h9RiIikETHSl1fhftjZmLa0zXiL7Wr2Ll2Dum+hS8d9gHZuk/je5ELQ2qXO16GEquxZOFq7IMpZ3owDpSUNpD2HAHSqrFi76Kx8yTh9jmO5sLHHuVhUqc1GLgGkKOiraoA1raHF+IlymRs5/KKRXBHtRw5C0PqhpgDs3otPCiN46+pqmER7YKA4+yHdDmEg9B7veSU2deD2Z20ePlYR4zgC+o/JiED6mEjNkAVpCGfDAUbwRqDM4hMCupQthT7KN1v6yXC3JQm3uYXsKpOIx3hGYEedtDotw/0Bgf1yhSdPfC2TkI83vJDUrXp8m2uJEYf21PAgBOfxgxk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c192940-a1a6-4210-a47b-08d6b2b71494
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:21:11.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try poking the specified core(s) every time before requesting IPI,
this way allowing the cpuidle driver to do its magic for the current
idle state of the specified core(s), if there is such a need.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 kernel/irq_work.c            | 19 ++++++++++++++++---
 kernel/sched/core.c          | 16 +++++++++++-----
 kernel/smp.c                 | 10 +++++++++-
 kernel/time/tick-broadcast.c |  4 ++++
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 6b7cdf1..deca898 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/cpuidle.h>
 #include <asm/processor.h>
=20
=20
@@ -76,8 +77,12 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
=20
-	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
+	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu))) {
+		/* Poke the cpu through cpuidle first */
+		cpuidle_poke(cpumask_of(cpu));
+
 		arch_send_call_function_single_ipi(cpu);
+	}
=20
 #else /* #ifdef CONFIG_SMP */
 	irq_work_queue(work);
@@ -99,11 +104,19 @@ bool irq_work_queue(struct irq_work *work)
 	/* If the work is "lazy", handle it from next tick if any */
 	if (work->flags & IRQ_WORK_LAZY) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
+		    tick_nohz_tick_stopped()) {
+			/* Poke the cpus through cpuidle first */
+			cpuidle_poke(cpumask_of(smp_processor_id()));
+
 			arch_irq_work_raise();
+		}
 	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list))) {
+			/* Poke the cpus through cpuidle first */
+			cpuidle_poke(cpumask_of(smp_processor_id()));
+
 			arch_irq_work_raise();
+		}
 	}
=20
 	preempt_enable();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48..7be9dba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -126,6 +126,12 @@ struct rq *task_rq_lock(struct task_struct *p, struct =
rq_flags *rf)
 	}
 }
=20
+static void smp_poke_and_send_reschedule(int cpu)
+{
+	cpuidle_poke(cpumask_of(cpu));
+	smp_send_reschedule(cpu);
+}
+
 /*
  * RQ-clock updating methods:
  */
@@ -511,7 +517,7 @@ void resched_curr(struct rq *rq)
 	}
=20
 	if (set_nr_and_not_polling(curr))
-		smp_send_reschedule(cpu);
+		smp_poke_and_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
 }
@@ -583,7 +589,7 @@ static void wake_up_idle_cpu(int cpu)
 		return;
=20
 	if (set_nr_and_not_polling(rq->idle))
-		smp_send_reschedule(cpu);
+		smp_poke_and_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
 }
@@ -1471,7 +1477,7 @@ void kick_process(struct task_struct *p)
 	preempt_disable();
 	cpu =3D task_cpu(p);
 	if ((cpu !=3D smp_processor_id()) && task_curr(p))
-		smp_send_reschedule(cpu);
+		smp_poke_and_send_reschedule(cpu);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kick_process);
@@ -1836,7 +1842,7 @@ static void ttwu_queue_remote(struct task_struct *p, =
int cpu, int wake_flags)
=20
 	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
-			smp_send_reschedule(cpu);
+			smp_poke_and_send_reschedule(cpu);
 		else
 			trace_sched_wake_idle_without_ipi(cpu);
 	}
@@ -1857,7 +1863,7 @@ void wake_up_if_idle(int cpu)
 	} else {
 		rq_lock_irqsave(rq, &rf);
 		if (is_idle_task(rq->curr))
-			smp_send_reschedule(cpu);
+			smp_poke_and_send_reschedule(cpu);
 		/* Else CPU is not idle, do nothing here: */
 		rq_unlock_irqrestore(rq, &rf);
 	}
diff --git a/kernel/smp.c b/kernel/smp.c
index f4cf1b0..f6b2ce7 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -17,6 +17,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/sched.h>
+#include <linux/cpuidle.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
=20
@@ -175,8 +176,12 @@ static int generic_exec_single(int cpu, call_single_da=
ta_t *csd,
 	 * locking and barrier primitives. Generic code isn't really
 	 * equipped to do the right thing...
 	 */
-	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
+	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu))) {
+		/* Poke the cpus through cpuidle first */
+		cpuidle_poke(cpumask_of(cpu));
+
 		arch_send_call_function_single_ipi(cpu);
+	}
=20
 	return 0;
 }
@@ -457,6 +462,9 @@ void smp_call_function_many(const struct cpumask *mask,
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
=20
+	/* Poke the cpus through cpuidle first */
+	cpuidle_poke(cfd->cpumask_ipi);
+
 	/* Send a message to all CPUs in the map */
 	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
=20
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 0283523..8bb7b2b 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/cpuidle.h>
=20
 #include "tick-internal.h"
=20
@@ -286,6 +287,9 @@ static bool tick_do_broadcast(struct cpumask *mask)
 	}
=20
 	if (!cpumask_empty(mask)) {
+		/* Poke the cpus through cpuidle first */
+		cpuidle_poke(mask);
+
 		/*
 		 * It might be necessary to actually check whether the devices
 		 * have different broadcast functions. For now, just use the
--=20
2.7.4

