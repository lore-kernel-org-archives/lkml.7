Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02A2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85580216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Wm7aDHMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfHTDyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:54:23 -0400
Received: from mail-eopbgr710044.outbound.protection.outlook.com ([40.107.71.44]:2304
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728777AbfHTDyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1XdVSOvaXIQubruidpCcfxKTSG4Ubrm0475d8ZVb0PV/NmedUJ8IJvZeBpICbx2cgHJfRkA8ein7F+t6E2HMY6zW+rRqC01NRKyUm6FiZdNF5GwJXG6blNssXWq+4J/MfS6JeFOVEeGZ3cHkKeciVDOp5MU1Hm9vM7miYpgHXkotqvatecsNlBxyoYmnSs44SKrTgVGFAKbDvmt4uZkKJRfrTuDIJjkvkxua446EJSLhrBxlQmdW6PKIXzEiaVCFLggayFho6s7+cWv6uIgo6Zvy96bFKBPnuDkWHKP6MYULFVvi5UfMaWiyiIkZuJ2xOBQz4dDVeYMvr1P1riCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErXupsvfk+tkZsOGpLtm1FI/DiDjRBvF0nj30oUOZh0=;
 b=A0QJFpLUhs6zJvu7JVcG78kl2d1SDtC4G+y26CNJufUVLN8C3Euweg34lXTMB9uhPpl0um9kyB7X3T9+DsjkPxgyXAQGcf98jBvCKGduqbG+mTmJ4+hXFQ9YXxmuO3MClamW/tKkLgruCXjZKW2gyoTTsCyC6AhemVo2IpQr/usDTZMtE+Y6F1rIhj4Rr/OZF8UX+VdTrw62LVLhh3bksoE0/Zc6+GCvsTJ60J5XeQF5EQufpJase8zUTvuaQZZ349iZzKlGBuJAb5CRBLIHbzjZ8vX2zPfYZ7B3u+1tvTvF1uq/3nDNbGke3w5lqAJa+n4h6yyy/+juR4Hm+pu74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErXupsvfk+tkZsOGpLtm1FI/DiDjRBvF0nj30oUOZh0=;
 b=Wm7aDHMd1+sNydYOYpMVF+PWWvzZ9lyDguNk5ABmA8m6RSHLsLWgbpmuu5iMbA0IHSWsQWnhI/rdgMuyXyg5gbDqhooLv/Tr9A0B+uffZLYVqnmuyf2FZIkeaNjParVO8D/Q5PVERVD/R/JJJe+JYFjS6IQ7oKrQvTyC97/S5mg=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4870.namprd03.prod.outlook.com (20.179.93.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Tue, 20 Aug 2019 03:54:20 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 03:54:20 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH v2 3/3] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVVwryjSNW9eV9u0mDAvz7yXMGOw==
Date:   Tue, 20 Aug 2019 03:54:20 +0000
Message-ID: <20190820114314.685a3239@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
In-Reply-To: <20190820113928.1971900c@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR06CA0027.apcprd06.prod.outlook.com
 (2603:1096:404:2e::15) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cf07ffa-c85f-46fb-5508-08d72522145e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4870;
x-ms-traffictypediagnostic: BYAPR03MB4870:
x-microsoft-antispam-prvs: <BYAPR03MB48707CF25317210EB816843BEDAB0@BYAPR03MB4870.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6116002)(6486002)(3846002)(53936002)(76176011)(2906002)(6436002)(86362001)(1076003)(64756008)(71190400001)(6512007)(110136005)(9686003)(6506007)(71200400001)(54906003)(66066001)(5660300002)(4326008)(14454004)(316002)(52116002)(66556008)(476003)(7736002)(99286004)(446003)(2501003)(486006)(386003)(8676002)(14444005)(81166006)(66946007)(256004)(478600001)(50226002)(102836004)(8936002)(26005)(305945005)(66446008)(66476007)(7416002)(186003)(11346002)(25786009)(81156014)(921003)(39210200001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4870;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aCiZWPwy8Jwdi/+8CSI+xJM9idFvTBdYY4HlzBQTf8HwUnS/c4nJpic5UAvYidiJ6dtg4XAdC2K7Gd0LNqQFfQ4jgQS+31sJxp23Qva49gPylD2dTWoSPr2gg5qUlQcMR97ECGzM22nQnXyUrc+aDYK+DHrkaOl03hY29WpfiwtLc1F83yU30RzioHt75JvaXN5ADv9p/N+iNCT5VOAi23KHLuszvh8qaJdq+ALd/Z7zs37vSRzqTYUPP8H9eHB8rtAN+sJORY/TRKvdkmUlSIyjwp/qdjgMUvtHrmEweSNP3qR7PJJPsWidlwPWScegHfwDUYqZyMkB5QSWMN/muCpZCpBnmzS5RUJkqOJgrymiivETL8HyKWkjXvOTvGxZJwMiMG5HP2FkYNnkljePAj0JMgLz9pydgcVDsKhYAto=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <758C392CCF526742B344A76B55289EB3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf07ffa-c85f-46fb-5508-08d72522145e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 03:54:20.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAcL2sqKhRE5cmCP02pDSD1yfO3F+kGxqmameVtbPHlnLTImORFfR/k7vWwSSIv5o1KHH5PMynr1R/LnJg29iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
eliminates the need for a trap, as well as the need to emulate or
single-step instructions.

This patch implements KPROBES_ON_FTRACE for arm64.

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
 .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/probes/Makefile             |  1 +
 arch/arm64/kernel/probes/ftrace.c             | 60 +++++++++++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)
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
index 000000000000..52901ffff570
--- /dev/null
+++ b/arch/arm64/kernel/probes/ftrace.c
@@ -0,0 +1,60 @@
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
+		/* Kprobe handler expects regs->pc =3D pc + 1 as breakpoint hit */
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
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.api.insn =3D NULL;
+	return 0;
+}
--=20
2.23.0.rc1

