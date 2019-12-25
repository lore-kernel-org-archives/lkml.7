Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0B92073B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ejx9dtWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfLYJoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 04:44:25 -0500
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:6043
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfLYJoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:44:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLMqYyVlQcRLt9oEkoLqgxe75M4Ny6KuVvqgdvn6frJfQTD0lZ+TbgV0echaNX8r6wfy42QZoSp3TVTaLqVy3T7w2qvDqk1ob0YgaC9iVfropQrPMWd+V18a1gV544doplK962AsEseeCBBxY/mdpMFkpBgV5/MDLX9pHpgdAtgvChvetEQMV3FTWNYuNUH6ymXPcmEZ3qjEGpmG4AuFeT0HOv0MdQUbjko4gOlaBY1dg/gPgbmY3STetIPRyMkokK/M9B30SYrCVcjiTxIXYnZbmNO8frRSor+W4M/DQHw2hr+aDBq0ign/0kfKL1CJ3vMm92DR1o94DNodew4V6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNFnhfAwfMMzPOlk3mgBi06/5bPmYts25Ajl13pw9z4=;
 b=bGr8OXOwnz13HwcuuuKp8AV3f2/oa52ztZTurnxyWd5OR+qyLIqHh6xxrwXCBOUjukEam9bL+CcBojd7Om74rGkjwqxa1cMiKKqPrOHcvKvyQ2kxcYlFOsB0LtMJ1/RpRw1J0s0qrxsSwwSuIHGuvmMvdmLKKtnFknv3Z6zzjDk23Zgz0zGtXma2VuD37ssFfJ1pB9f9V64vRpq+k60vjzUb4rkAmY4u89KBVyEPJybgnviGrQrHSiWwP38xg+VrIMKViLsSYYce73eF8DU34wf9F8wUhZBFq2yCvAjyrA1fcn6YPUX6Y0JzFGREfmW1xfCoIP+bLHtmWit3HAydeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNFnhfAwfMMzPOlk3mgBi06/5bPmYts25Ajl13pw9z4=;
 b=ejx9dtWAmEXsvBuryENM3mNIpi95nDCrB62JylZtN56J02jxf/BqmVLcJqGuw+o2h+GF/EF+orrF97lrkVlDcpfUUM11N67tRkHbYrsB5ur9O79IkZH0biiZl/bxaosPN0kpQ7yCRdaJzl2hCT1PO6Ug9bepy1QnODD5YUrncdc=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4213.namprd03.prod.outlook.com (20.177.185.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Wed, 25 Dec 2019 09:44:21 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 09:44:21 +0000
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0168.jpnprd01.prod.outlook.com (2603:1096:404:7e::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Wed, 25 Dec 2019 09:44:18 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVuwfioeAAP6kOPkCZLC/0/SnpxA==
Date:   Wed, 25 Dec 2019 09:44:21 +0000
Message-ID: <20191225173001.6c0e3fb2@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
In-Reply-To: <20191225172625.69811b3e@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::36) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4106d40f-e7a1-4485-4aa1-08d7891f0492
x-ms-traffictypediagnostic: BYAPR03MB4213:
x-microsoft-antispam-prvs: <BYAPR03MB421338EE77E4EA9C9CE481A6ED280@BYAPR03MB4213.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(9686003)(1076003)(5660300002)(86362001)(55016002)(6666004)(66476007)(956004)(66946007)(66556008)(64756008)(81156014)(8936002)(81166006)(8676002)(66446008)(16526019)(71200400001)(2906002)(26005)(186003)(52116002)(7696005)(7416002)(6506007)(4326008)(316002)(54906003)(110136005)(478600001)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4213;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qe5daeSEQp6IpLLal2rSFPFUy80TKDmRWbiDpnA6rvm3SwgYs9LI9732m9WsmOU9oodCMXErKEQXyRWb0iFceRp0zLPC9cJk5gkGArW7yAyvfp7GmGoVcxO0Vo274h4h3gLHqc0Uawat+z1DKys2J+wOz4q+FCmhDHKg8VkOtrRjvq850CdeyX1ElenhUP7PEY34cS+Yy4u+o+w3gimFhIEElKuYgCYkdcGXJv2HTsEn8H80i6skXm1Bvxf1C+OJmA3u7kCsISBvp7yglyCw03B2CItcdcG9vd+hZZ1t2/SlZSVEffiq5EzgGtVbO50vW0WiyYqFuio+NXxLx+UlaZUwFgWu3/+q73mwv0+tb/yiElcXThNR9NzvWO/WXH4l/ZbL5G3Am369PtzYLXfz5mxT2XxCwdMvrJGdzXROUGTVSHsqv8wBIoNRo+QeWTWhgp5pr54vx4cCSixLo58Zf/+XYlxMwUXNFyQqyxqs1Xkprm05nBCT6iYe+BQ/Ly+7A0eUL7246cw0gdJ0ZPwolLClxxXB52ndqIQET4m161c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8741C552ACA29C499EFE21A17323E8BC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4106d40f-e7a1-4485-4aa1-08d7891f0492
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 09:44:21.2570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qwq/ACW2b9vIAfuNX8IrzgOIYqXej80NUZiO0hnnmZB5GTqfcmUbvSEaf0eRdRj2uSbI1YIlyGIOGwFx2g6AeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
eliminates the need for a trap, as well as the need to emulate or
single-step instructions.

Tested on berlin arm64 platform.

~ # mount -t debugfs debugfs /sys/kernel/debug/
~ # cd /sys/kernel/debug/
/sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events

before the patch:

/sys/kernel/debug # cat kprobes/list
ffffff801009fe28  k  _do_fork+0x0    [DISABLED]

after the patch:

/sys/kernel/debug # cat kprobes/list
ffffff801009ff54  k  _do_fork+0x0    [DISABLED][FTRACE]

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/ftrace.h               |  1 +
 arch/arm64/kernel/probes/Makefile             |  1 +
 arch/arm64/kernel/probes/ftrace.c             | 78 +++++++++++++++++++
 5 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/probes/ftrace.c

diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.tx=
t b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 4fae0464ddff..f9dd9dd91e0c 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1b4476ddb83..92b9882889ac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -166,6 +166,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrac=
e.h
index 91fa4baa1a93..875aeb839654 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -20,6 +20,7 @@
=20
 /* The BL at the callsite's adjusted rec->ip */
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
+#define FTRACE_IP_EXTENSION	MCOUNT_INSN_SIZE
=20
 #define FTRACE_PLT_IDX		0
 #define FTRACE_REGS_PLT_IDX	1
diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/M=
akefile
index 8e4be92e25b1..4020cfc66564 100644
--- a/arch/arm64/kernel/probes/Makefile
+++ b/arch/arm64/kernel/probes/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_KPROBES)		+=3D kprobes.o decode-insn.o	\
 				   simulate-insn.o
 obj-$(CONFIG_UPROBES)		+=3D uprobes.o decode-insn.o	\
 				   simulate-insn.o
+obj-$(CONFIG_KPROBES_ON_FTRACE)	+=3D ftrace.o
diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/f=
trace.c
new file mode 100644
index 000000000000..0643aa2dacdb
--- /dev/null
+++ b/arch/arm64/kernel/probes/ftrace.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Dynamic Ftrace based Kprobes Optimization
+ *
+ * Copyright (C) Hitachi Ltd., 2012
+ * Copyright (C) 2019 Jisheng Zhang <jszhang@kernel.org>
+ *		      Synaptics Incorporated
+ */
+
+#include <linux/kprobes.h>
+
+/*
+ * In arm64 FTRACE_WITH_REGS implementation, we patch two nop instructions=
:
+ * the lr saver and bl ftrace-entry. Both these instructions are claimed
+ * by ftrace and we should allow probing on either instruction.
+ */
+int arch_check_ftrace_location(struct kprobe *p)
+{
+	if (ftrace_location((unsigned long)p->addr))
+		p->flags |=3D KPROBE_FLAG_FTRACE;
+	return 0;
+}
+
+/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	bool lr_saver =3D false;
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+
+	/* Preempt is disabled by ftrace */
+	p =3D get_kprobe((kprobe_opcode_t *)ip);
+	if (!p) {
+		p =3D get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
+		if (unlikely(!p) || kprobe_disabled(p))
+			return;
+		lr_saver =3D true;
+	}
+
+	kcb =3D get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		unsigned long orig_ip =3D instruction_pointer(regs);
+
+		if (lr_saver)
+			ip -=3D MCOUNT_INSN_SIZE;
+		instruction_pointer_set(regs, ip);
+		__this_cpu_write(current_kprobe, p);
+		kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+			/*
+			 * Emulate singlestep (and also recover regs->pc)
+			 * as if there is a nop
+			 */
+			instruction_pointer_set(regs,
+				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+			instruction_pointer_set(regs, orig_ip);
+		}
+		/*
+		 * If pre_handler returns !0, it changes regs->pc. We have to
+		 * skip emulating post_handler.
+		 */
+		__this_cpu_write(current_kprobe, NULL);
+	}
+}
+NOKPROBE_SYMBOL(kprobe_ftrace_handler);
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.api.insn =3D NULL;
+	return 0;
+}
--=20
2.24.1

