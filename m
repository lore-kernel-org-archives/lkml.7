Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5E2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C321206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Oe8jrIvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbfHVL0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:26:43 -0400
Received: from mail-eopbgr820073.outbound.protection.outlook.com ([40.107.82.73]:36249
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726844AbfHVL0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:26:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXzCEcMXWVCflBwb0xOcijwzvOvdIWhkcCzOhshyWsi2ipQMX+Mqckv1DOWZrn5uVTJz3FVdGfw/nc9RJUXDEjy/p+ZOdxRZkNO9a0DuTBi0iK9rw4PtPN3Umusk+9WnzLMxjMqpzS7m90D6UG6V8cm5X319BF/5ipXt4Pg86i14fA/6R/wb9bTJCOxrU2R2Xr4OSkc5eEmf44l8MM0JtjRN7+/CUtsXf2QUkEH5CvnwcPqBzRmRM0zvw9gJOl7e8wiym2fXGGS8MQQ8nesRzmVdJSW+NyG4thYWf3nMSrn+YUQ2eqGTZ32omjjWgcChB4jK1eYVfZMFwPEurNbcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcjbILoY7sYjfBigPOGHQdUPdtDPCvhFQwihX65ed/Q=;
 b=BKOblla9lc/dd98QnGlWm80eLXH7d+nX9PqF/Voqcwlm3WD6efLKK9OB5BAj1590SR76uh+/MdOfM5aYwmoVR/s2Yu1s/K7ci9SaFY94iAoruOdwYaRmKfOep3IGcsbF2fCD9muGNxmV94M+Yw4nUV+S3bfS2HYdfNikzmPt+6nVVqFTf8rGzyWfRFOmjeWsO/M7uyElfQhLlX+s52wLSaCM5Bf4oInvmKJ0SagQb4Va7Ys17ydDWZQthFs6oYGRFBY2CJ6DXLrljN3hTwdY0WMcg7cEBCVTwQlWzE7EZ/gE1uaNKxsxubZ0eyBMngDqnBZ6tn00KCPKCSMykMhdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcjbILoY7sYjfBigPOGHQdUPdtDPCvhFQwihX65ed/Q=;
 b=Oe8jrIvKoUcuy2QoATNnPccwa+P3+gJX64GP+QH9+QPpHuYnX6CPfgobUmYhGVUmdtKXvf1s/Fkyafyv9eiqlaAivBEE9Pny6T81UALnKFrymbOgBrZ6ZxS8Nb8M3w3nI2ixUlyDOQ2wntBiV6Mj8fhEj30wSyc//PAedCIxnNo=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3895.namprd03.prod.outlook.com (20.177.124.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 11:25:00 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 11:25:00 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v5] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVWNw8B9jpjP9XI02aOFdGy0xKpw==
Date:   Thu, 22 Aug 2019 11:25:00 +0000
Message-ID: <20190822191351.3796aca8@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0001.jpnprd01.prod.outlook.com (2603:1096:404::13)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfa4a9a0-8708-4dc3-5a44-08d726f35e9c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB3895;
x-ms-traffictypediagnostic: BYAPR03MB3895:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR03MB3895ADE1617378FFD48C1503EDA50@BYAPR03MB3895.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(376002)(396003)(54534003)(189003)(199004)(50226002)(305945005)(6436002)(99286004)(110136005)(102836004)(316002)(386003)(54906003)(14454004)(5660300002)(478600001)(7416002)(6506007)(256004)(66066001)(6486002)(966005)(8936002)(476003)(53936002)(14444005)(3846002)(6116002)(1076003)(6306002)(9686003)(6512007)(81166006)(71200400001)(81156014)(71190400001)(486006)(186003)(26005)(7736002)(8676002)(25786009)(4326008)(66476007)(66556008)(66446008)(66946007)(64756008)(86362001)(52116002)(2906002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3895;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mq4RkuDdwASWxp1ognYDuftlQnyC5TU3U12FewHKmlbztnqrxdMzo1bVjoSufMU1kaOxjSGFD79imBE3WF0f4KWkRijxOyARs6EPVqb/jptLPNBV5/HVuK4/H9cF0OxRQ0JfdeTJVbQPl8mCa+CTp0xsqxcw1Ll+DeRHnedv0FV+hIocHUTsg+UfSOvLTwuQnIhm9Z3uP3WrrvmF9MnkP6E/Fp6KLUKCdueGaU1JZTjw77fKrpdB2RkR430wd5HHnhtW4oQefy4PaTAApTdVopsBlcJTUa1jXuLeFny9669gL7bp29/ggMoGKxvDgEvRZ6/HXyGKbaom/MjbaJQD67DhhDEtgkz4jcZuzv3+PoOcn4mznNwNRsjJ59Izw81t+964tcAMifSTvFCcdGeM8CgJB2XCjCynn2kxNDELCwo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <538610905093B748B9C9D95A36273D2E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa4a9a0-8708-4dc3-5a44-08d726f35e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 11:25:00.5116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0BqU98EQeq+bKT3l97RaMTJaRP6k9iNX9c197gQ7+c/KJK7vWzBH8w+wdPKKg3HcNP0MgLudLtLHdIrRXrBag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3895
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

Changes since v4:
  - correct reg->pc: probed on foo, then pre_handler see foo+0x4, while
    post_handler see foo+0x8

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
 arch/arm64/kernel/probes/ftrace.c             | 83 +++++++++++++++++++
 4 files changed, 86 insertions(+), 1 deletion(-)
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
index 000000000000..9f80905f02fa
--- /dev/null
+++ b/arch/arm64/kernel/probes/ftrace.c
@@ -0,0 +1,83 @@
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
+
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

