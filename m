Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC8C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7824A21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="geDPjQwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfHVDrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:47:23 -0400
Received: from mail-eopbgr810080.outbound.protection.outlook.com ([40.107.81.80]:55904
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729135AbfHVDrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CABafZ3ghswPVKIaYOzHAi9RMm8b3zVEJF30NtI9ztG7x37SlIHM5JW6/9j3T429l8z7dnPmJ/TC0RarBPyf7a8Z/tQrXYgGwDgoAZXOe+LFtaVsjD1T3dZ6TyjagISMWtXbbp9uRhB53ou1rVxunoUbjHRCW59CUg9qJTFLCUmG5zAtU51kyWbPC2AOKEb/56McHrfoW5asYGInpARDLYo1f441IC+0gkDelN682JwhHOlYBlMEGOdzT5VuLZchkSsM9LMRxKjK+mR3nEai9zq5X7mN5qqmXgZI4Fw9UzaEu9Ip35qeGmamagDbczwJacfWAOaTdpbClCUf3dXddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usdSeSuhasYXmm3QNXdqKWSUcRnKw2893WrYZKkVG9g=;
 b=mx0XaQBaiCBMuCwsCQvYyhx4t7GKcFLFoYP2GS6/NG55d3PBRqUidt5phpsDckAvttWb2BGrN4mHovmi/4FFWRrwzgnBp0Hq0u2AlTA9q3WJIIiQPTmN0bE1EtQgmTJyfPoTaoqK2SH5REnBsUxeuXDO1YG5XLCkfNAnfGzWs0l8NGE6slFuYVpPnG4C1I4hek913AHP7OfdcN0aBLGLgxEBaH/M0uvbbMGKSx9+1RUaUCZDtLKVc/9SLDvthY4FRN9GBj3VpIWmggPWJKQDy/DE3dwQrQtnMRll9cnoCfEmo8ABgxsMZL2DKrHlR21p7dLfyn52a/kPWlyNu08rLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usdSeSuhasYXmm3QNXdqKWSUcRnKw2893WrYZKkVG9g=;
 b=geDPjQwaMn6GTEgyvhEGmOltp9TIA7fvAG71r60yaIDtL5VYryY8ILtSDPKPKLVVhiEp4Y89ZUsICZep8GfFHzOvHOHI89q09V/4HTbQIYeAhzXyCxOjkn/AUxHTJFJBPjQ0uTP39/teOUns4D/qc+pHc6dUijweXjgP/Stpv54=
Received: from DM6PR03MB4778.namprd03.prod.outlook.com (20.179.105.26) by
 DM6PR03MB5036.namprd03.prod.outlook.com (10.141.162.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 03:45:39 +0000
Received: from DM6PR03MB4778.namprd03.prod.outlook.com
 ([fe80::16e:7410:d85f:ed8a]) by DM6PR03MB4778.namprd03.prod.outlook.com
 ([fe80::16e:7410:d85f:ed8a%7]) with mapi id 15.20.2157.022; Thu, 22 Aug 2019
 03:45:39 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v4] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVWJwQA6oCa6sgREe9v4FYsERl0w==
Date:   Thu, 22 Aug 2019 03:45:38 +0000
Message-ID: <20190822113421.52920377@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:404:28::27) To DM6PR03MB4778.namprd03.prod.outlook.com
 (2603:10b6:5:184::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a576ac20-4f76-4e9a-468a-08d726b3329e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR03MB5036;
x-ms-traffictypediagnostic: DM6PR03MB5036:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR03MB50365BC1BA18ADA24BB2B5B9EDA50@DM6PR03MB5036.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39850400004)(396003)(346002)(189003)(199004)(54534003)(70486001)(6306002)(6512007)(9686003)(8936002)(66066001)(117636001)(86362001)(478600001)(6436002)(6486002)(7416002)(8266002)(2906002)(6116002)(3846002)(81166006)(50226002)(8676002)(81156014)(316002)(4326008)(1076003)(14444005)(256004)(71200400001)(99286004)(52116002)(476003)(486006)(110136005)(54906003)(7736002)(305945005)(25786009)(66446008)(64756008)(66556008)(97876018)(26005)(386003)(6506007)(186003)(102836004)(66476007)(66946007)(966005)(53936002)(14454004)(71190400001)(5660300002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5036;H:DM6PR03MB4778.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zbkARI8DZa8D+GPXXm/YHcuw6AjlKe0qx5WQGe4OWTHQ+nK31GpqkRGx0vKIFstiLFiMr/oElLZzu0jHrqJPIVXk3nZn9IlY2t4lRpB99hCJz7A9pZ+zB+/rpjf3Au543czNAPMMgfaRGBYcOE6CDkjltZeoSlsUsFs4gERINgRwx0ieEy03sKATobQ9D3Tg7sw0ecw3eMYGnPnKbBhDxaJZVyNDj7CiWB3nNodsOGgrQqRAZDFJTmEWMZ8Ym/RV1HJ+ZzVveKakTUfkLVmFZ39QonoADEAO+kFpP3eyr0VMuzvsCnHF8FgXvpAF6Aiqyow/w9r46NjyWhHUMKwGG20hd1rFVtvpOptNYjtlZFkYBZ2vn4YYaKRAXzONUgnHZ0vLEKnQl7I6grqqtkNMDri4OUofrEQhMCT0WTgTR9Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C6EDF32F9D3EE49B3B4F56DC9A91833@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a576ac20-4f76-4e9a-468a-08d726b3329e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 03:45:38.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrT4hLLiwrhDf6hugZ02bNMrZJkR84ApAfp25i2dk/ZtTbCrHWgQWP9FJN62Af5sX1vrZqMcyRvZPk1CqiZ/tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5036
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
ffffff801009ff54  k  _do_fork+0x4    [DISABLED][FTRACE]

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
eliminates the need for a trap, as well as the need to emulate or
single-step instructions.

Applied after arm64 FTRACE_WITH_REGS:
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-August/674404.ht=
ml

Changes since v3:
  - move kprobe_lookup_name() and arch_kprobe_on_func_entry to ftrace.c sin=
ce
    we only want to choose the ftrace entry for KPROBES_ON_FTRACE.
  - only choose ftrace entry if (addr && !offset)

Changes since v2:
  - remove patch1, make it a single cleanup patch
  - remove "This patch" in the change log
  - implement arm64's kprobe_lookup_name() and arch_kprobe_on_func_entry in=
stead
    of patching the common kprobes code

Changes since v1:
  - make the kprobes/x86: use instruction_pointer and instruction_pointer_s=
et
    as patch1
  - add Masami's ACK to patch1
  - add some description about KPROBES_ON_FTRACE and why we need it on
    arm64
  - correct the log before the patch
  - remove the consolidation patch, make it as TODO
  - only adjust kprobe's addr when KPROBE_FLAG_FTRACE is set
  - if KPROBES_ON_FTRACE, ftrace_call_adjust() the kprobe's addr before
    calling ftrace_location()
  - update the kprobes-on-ftrace/arch-support.txt in doc


 .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/probes/Makefile             |  1 +
 arch/arm64/kernel/probes/ftrace.c             | 84 +++++++++++++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/probes/ftrace.c

diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.tx=
t b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 68f266944d5f..e8358a38981c 100644
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
index 663392d1eae2..928700f15e23 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -167,6 +167,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
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
index 000000000000..5989c57660f3
--- /dev/null
+++ b/arch/arm64/kernel/probes/ftrace.c
@@ -0,0 +1,84 @@
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
+/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+
+	/* Preempt is disabled by ftrace */
+	p =3D get_kprobe((kprobe_opcode_t *)ip);
+	if (unlikely(!p) || kprobe_disabled(p))
+		return;
+
+	kcb =3D get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		unsigned long orig_ip =3D instruction_pointer(regs);
+		/* Kprobe handler expects regs->pc =3D pc + 4 as breakpoint hit */
+		instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));
+
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
+kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
+{
+	unsigned long addr =3D kallsyms_lookup_name(name);
+
+	if (addr && !offset) {
+		unsigned long faddr;
+		/*
+		 * with -fpatchable-function-entry=3D2, the first 4 bytes is the
+		 * LR saver, then the actual call insn. So ftrace location is
+		 * always on the first 4 bytes offset.
+		 */
+		faddr =3D ftrace_location_range(addr,
+					      addr + AARCH64_INSN_SIZE);
+		if (faddr)
+			return (kprobe_opcode_t *)faddr;
+	}
+	return (kprobe_opcode_t *)addr;
+}
+
+bool arch_kprobe_on_func_entry(unsigned long offset)
+{
+	return offset <=3D AARCH64_INSN_SIZE;
+}
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.api.insn =3D NULL;
+	return 0;
+}
--=20
2.23.0.rc1

