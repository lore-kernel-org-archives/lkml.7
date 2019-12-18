Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0B921D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="PfZYClxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLRGXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:23:20 -0500
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:20496
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfLRGXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:23:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zcvgc+3Je49z+91Yb67ytrBPSQw3ia4hPHqWAQHJWpv93bR6O8LEN0o/70hru73ikGHpuFpy8+327Q0n2QEgiI7QnwPfCdZjDeFJsNEFyHaAWAByz/j2fn7+CkXCARibmbbul21ijbrLBpgIkVIae5MCScJIOkGroeIPy2PsvyQKpUts4ZkXFxudnyjGTJ7mB1LhoB2UKQwcRT1KYUlWhPeKjeY9LliT4IyusZ+9x0C1azXvj7jMnDYrIG9pu9D2GpAXdHJfIpwPDfHMUJBorNXoMynSsxMRTeBN4Ra0aOU+HMcxGcSwv3mdohomC63sihR2Q5EWmwyHr/BAL+EE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVFMYCjfmirfAAcyRjXfNs/7E+qJAMSbXMmCNKCrdIE=;
 b=dNGqpZSUa5aGGqVkElF6FqYETbarxTgtqgCv4BeMvNzLaVii6C7OTi6X6KUZIPvX6UwkyGPotsBU9i39zhVkKfDY9jJ2X1+EI+vN9Eakwpl5wDhsIj/1kdSacZcDrIIXXO3+I4RkCxrQJEQ/6dd1JJjT8wQ1QDLWehh6flGpYNZzwHodZPqk7pJsmpfBIvbfjCudTYoiu7f9cXyrYL5hDWHncUsP5eTIF2L8WoFkFIYIKO6/tGuycPjgJJAHfGhj4PhcTdILQ1ivdYZdQ5ANwFgh5meBkuFSHo+lg7868474mkip+GVkkhOftFQ2cHuM4QFuUsfmW3i8zImkLMWsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVFMYCjfmirfAAcyRjXfNs/7E+qJAMSbXMmCNKCrdIE=;
 b=PfZYClxec+8lrMTWucTTMSrgDpIpG0hZ9xUx4byB6un/yy7Io3CcqJuQXf58hgHn4mo8N7CV/xzevpsgjdcwIFl9bQOa0OYHZFsh1uQyycMPW4no9MEA1TgoYoEQQN2olgBDBKaSyL71GeJrIw3WViiZuKhM02JlSfNwqS16dEU=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB3909.namprd03.prod.outlook.com (20.177.124.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Wed, 18 Dec 2019 06:21:36 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 06:21:36 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v6] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVtWtmR90OKS0v9Um1jpVbBvlnOA==
Date:   Wed, 18 Dec 2019 06:21:35 +0000
Message-ID: <20191218140622.57bbaca5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::19) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e548014c-2484-46e1-c8a5-08d783828897
x-ms-traffictypediagnostic: BYAPR03MB3909:
x-microsoft-antispam-prvs: <BYAPR03MB390940BAFAA59720EB2E62F0ED530@BYAPR03MB3909.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(54534003)(52116002)(5660300002)(26005)(7416002)(86362001)(186003)(66946007)(64756008)(66476007)(316002)(81156014)(66556008)(4326008)(6506007)(81166006)(66446008)(71200400001)(6486002)(1076003)(2906002)(6512007)(8936002)(110136005)(54906003)(478600001)(9686003)(8676002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3909;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WLHUq2BTkx5vHX5LtOg5gt59+kRKt2CGibUe5bYtwXIeXK5aQ5H8CRRoqLXN8AuuboRZwUN8LDy/iapZOrzEjZDTq1NQvEfff09/vVnEDNSzy/GXFj/v711pEC10hg/AW+UuudNuuRMGo0GLTLMryPwhe5VinmQwqnYvoYebT1j4LqEI2jBbpjQ9I8Zu+Mr7uPRr2mUN3CtSh4Xn0h/ymqAelI+cWX00UUcFFAFVzpU80jrLsc9tj0UFe1JE6uAl0WfJFCGaxb6eG7FVJXpPJSGoaA/i9IC+jVtzEQAteVHan2iXFuoBJFLlT8TEEZ5k6rApL9suZJIrCq45Vejt6M8LuhJUu/U3AvPN7ll2MRWlOBMihOw6rqBZMXGBMUVlMmIkxecBlGdU9XFaK+XAGWQOTYhh+HHrntm/DVhwalm854o4CibZOqTZVwqeW2zvXHysmYQ3cJ3p9tqiBXpaqDP88nJhW9wglASO3GQrwX+hJts/+gAZYLHNwNJXxhQ1OjA3P5LP6um0kVvRdU3Eg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D0886A77B09D14889EAFB84B771BDAB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e548014c-2484-46e1-c8a5-08d783828897
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 06:21:35.9049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iIHKjh20d3VH1qJYYae01V1bkW19TQ097TACcYqrXh4zfhrKz/dPHFwHf78+yJWPV3dpGzZ8dACHxmenx6msQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3909
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
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
eliminates the need for a trap, as well as the need to emulate or
single-step instructions.

Changes since v5:
  - rebase v5.5-rc1
  - collect Acked-by and Reviewed-by tags

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
2.24.1

