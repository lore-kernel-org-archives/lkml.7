Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649EEC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1630420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="JBBjJmmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfHSL2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:28:37 -0400
Received: from mail-eopbgr740054.outbound.protection.outlook.com ([40.107.74.54]:30087
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbfHSL2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:28:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqT8DvzqfLVkdUkYV0VZy3fdZ/z7gjtv7VsE0FdKi5TwzAjQI8vUe/9Y/P5J7PB+kHizBCQZnsNXd5+js73MycwHWhZLaFc6aGq/r0b+oJdQowaAQEIIXAKf2aHddWN+RiXxlXOfc8WOR6ptLWfGe/NRXWCu2pwn8DPT4fxogXNZF8ezeCgUqoRr6AoLh+OuM1e6xqACer5dF+/ViuxFVga9i2VQ8D367wQZY3T8HIrz2CdtD/MPpvGtbwyzSyCFmZ3QVwzpBV/8fTJBH9jpM0A/3fMOj3mAPpUpzoxIh2fkAbnokHVzkHtgLzY2gmhv1g+XMl4I8WBu+0zd5F93yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrgafeGsEjGX0fnvkALOHojmNJ2WtdrtZOfa8ffYHS4=;
 b=SXdvw8YlKjb6JR6wYAHY67ugMQkkRxJwQ2asdSncDKDhA6zqULx7dLMcTOmMEbO99wmtW0vkqvF7qabXGXF60ApiiM0z/6BiOynuwax0EkJIaAnOH2BI8uzy+seuKG7XuT954rFel8Bn8igXq8L4lIclF5e4w/g5xtBML7Ee/Xn18Bd0Lqate+ouA0bJ0D6VcF7IFMQe6yZJEHG8z+F0QsCFWX6wyGoYL5rU4eG3gQDGZJmGXM59yaPNiDyuijhnhl/yYyWPC2mIm6s0YIxpDDVB+Ygdb+kRHSZXhdU4jUIi2DbVQ+fmSIHsyidCjZbLNqyPRUUvajUyQTUG4xTfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrgafeGsEjGX0fnvkALOHojmNJ2WtdrtZOfa8ffYHS4=;
 b=JBBjJmmDl0drOik0hdOFMaGy2jOX3qed0//p+qeToIcf/TVAkzMLmxf8eEoHlrm7942q9RqA141V8T47s7IAfwKlmdN6o6032XbDgHmiPxEDMyT2XBFDjumlQztu9NOlzBWay14IvMMHUaE2cteAP+mWg+9Tj58pJSnjvNEG1Cs=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3528.namprd03.prod.outlook.com (52.135.213.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 11:28:27 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 11:28:27 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Torsten Duwe <duwe@suse.de>
Subject: [PATCH 2/3] arm64: implement ftrace with regs
Thread-Topic: [PATCH 2/3] arm64: implement ftrace with regs
Thread-Index: AQHVVoE4mavbCE9UtUy5RF2vspPVbg==
Date:   Mon, 19 Aug 2019 11:28:27 +0000
Message-ID: <20190819191722.0b029bd2@xhacker.debian>
References: <20190819191530.0f47b9b1@xhacker.debian>
In-Reply-To: <20190819191530.0f47b9b1@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0093.jpnprd01.prod.outlook.com
 (2603:1096:405:3::33) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10f78293-b720-4c99-20be-08d724985a79
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3528;
x-ms-traffictypediagnostic: BYAPR03MB3528:
x-microsoft-antispam-prvs: <BYAPR03MB3528B43C6D6D66F33E940A9DEDA80@BYAPR03MB3528.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(5660300002)(8936002)(50226002)(86362001)(30864003)(81156014)(81166006)(71200400001)(71190400001)(25786009)(486006)(476003)(8676002)(11346002)(14444005)(446003)(66446008)(64756008)(66556008)(66476007)(66946007)(1076003)(6512007)(66066001)(9686003)(26005)(6486002)(305945005)(99286004)(186003)(102836004)(2906002)(52116002)(54906003)(53936002)(3846002)(6116002)(316002)(256004)(4326008)(76176011)(14454004)(6506007)(386003)(6436002)(7736002)(478600001)(110136005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3528;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: duZNji8c5krqqgserN9NhUWkGzPY179n+18tbHQB5sCm3iJKz2le954aGbt94qRwyxNWe8QEvIaZQ+y3iBPjszYjMQ+Osf8F8VctVYjt6U7O18vGIm2X4e1l8WrFB9BSTZsV1QoKER3vnLAWOgx5rB5o/M5A+bnE+euAbYnKsugZQ9828cB6FDgCavqRznPjORXQIGm84zSF+UhJr6gZSaWENffhCTax3iwkq7MBLDxXHflv3qJv8dAdJZzkh7O9T3J1FK8TxX4DqPNZKbhR9V6FWXehJ6v18D1WAFJ0H2m9TbLwCrZaDt8Uv9OEtYyFBZ/mr9LIGHbO7W6b4Fl+2dOEo+MtllIMNtvAVEn7sIFRam2wL7XY7Ems+dpesvaFUIxvO5LlQ3i+QBjRXhJYEgpZmUcmvVouMa5MwXQOEZ8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A81E6768006B394396B3C924732D4762@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f78293-b720-4c99-20be-08d724985a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 11:28:27.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zr/+WmrDxiH88C+XC5OZkpelUkc0xTq8AfzBkBmcjS/4p6L1ablnox2hkkMs9Os+uSb6rpcOH7anCR4lGpWCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Torsten Duwe <duwe@suse.de>

Implement ftrace with regs, based on the new gcc flag
-fpatchable-function-entry (=3D2)

Now that gcc8 added 2 NOPs at the beginning of each function, replace
the first NOP thus generated with a quick LR saver (move it to scratch
reg x9), so the 2nd replacement insn, the call to ftrace, does not
clobber the value. Ftrace will then generate the standard stack
frames.

Note that patchable-function-entry in GCC disables IPA-RA, which means
ABI register calling conventions are obeyed and scratch registers such
as x9 are available.

Introduce and handle an ftrace_regs_trampoline for module PLTs, right
after ftrace_trampoline in an ftrace_trampolines[2] array, and double
the size of the corresponding special section.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/arm64/include/asm/ftrace.h  |  12 ++-
 arch/arm64/include/asm/module.h  |   3 +-
 arch/arm64/kernel/entry-ftrace.S | 125 ++++++++++++++++++++++++++--
 arch/arm64/kernel/ftrace.c       | 138 +++++++++++++++++++++++--------
 arch/arm64/kernel/module-plts.c  |   3 +-
 arch/arm64/kernel/module.c       |   2 +-
 6 files changed, 239 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrac=
e.h
index 5ab5200b2bdc..fde94a905b25 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -11,9 +11,12 @@
 #include <asm/insn.h>
=20
 #define HAVE_FUNCTION_GRAPH_FP_TEST
-#define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
=20
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
=20
@@ -30,6 +33,13 @@ extern void return_to_handler(void);
=20
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
+	/*
+	 * For -fpatchable-function-entry=3D2, there's first the
+	 * LR saver, and only then the actual call insn.
+	 * Advance addr accordingly.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		return (addr + AARCH64_INSN_SIZE);
 	/*
 	 * addr is the address of the mcount call instruction.
 	 * recordmcount does the necessary offset calculation.
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/modul=
e.h
index f80e13cbf8ec..5463a2cf0165 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -21,7 +21,8 @@ struct mod_arch_specific {
 	struct mod_plt_sec	init;
=20
 	/* for CONFIG_DYNAMIC_FTRACE */
-	struct plt_entry 	*ftrace_trampoline;
+	struct plt_entry	*ftrace_trampolines;
+#define MOD_ARCH_NR_FTRACE_TRAMPOLINES	2
 };
 #endif
=20
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftr=
ace.S
index 33d003d80121..4cfc0a886e4e 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
@@ -121,6 +122,7 @@ EXPORT_SYMBOL(_mcount)
 NOKPROBE(_mcount)
=20
 #else /* CONFIG_DYNAMIC_FTRACE */
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 /*
  * _mcount() is used to build the kernel with -pg option, but all the bran=
ch
  * instructions to _mcount() are replaced to NOP initially at kernel start=
 up,
@@ -160,11 +162,6 @@ GLOBAL(ftrace_graph_call)		// ftrace_graph_caller();
=20
 	mcount_exit
 ENDPROC(ftrace_caller)
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
-ENTRY(ftrace_stub)
-	ret
-ENDPROC(ftrace_stub)
=20
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
@@ -184,7 +181,125 @@ ENTRY(ftrace_graph_caller)
=20
 	mcount_exit
 ENDPROC(ftrace_graph_caller)
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+	.macro  ftrace_regs_entry, allregs=3D0
+	/* make room for pt_regs, plus a callee frame */
+	sub	sp, sp, #(S_FRAME_SIZE + 16)
+
+	/* save function arguments */
+	stp	x0, x1, [sp, #S_X0]
+	stp	x2, x3, [sp, #S_X2]
+	stp	x4, x5, [sp, #S_X4]
+	stp	x6, x7, [sp, #S_X6]
+	stp	x8, x9, [sp, #S_X8]
+
+	.if \allregs =3D=3D 1
+	stp	x10, x11, [sp, #S_X10]
+	stp	x12, x13, [sp, #S_X12]
+	stp	x14, x15, [sp, #S_X14]
+	stp	x16, x17, [sp, #S_X16]
+	stp	x18, x19, [sp, #S_X18]
+	stp	x20, x21, [sp, #S_X20]
+	stp	x22, x23, [sp, #S_X22]
+	stp	x24, x25, [sp, #S_X24]
+	stp	x26, x27, [sp, #S_X26]
+	.endif
+
+	/* Save fp and x28, which is used in this function. */
+	stp	x28, x29, [sp, #S_X28]
+
+	/* The stack pointer as it was on ftrace_caller entry... */
+	add	x28, sp, #(S_FRAME_SIZE + 16)
+	/* ...and the link Register at callee entry */
+	stp	x9, x28, [sp, #S_LR]	/* to pt_regs.r[30] and .sp */
=20
+	/* The program counter just after the ftrace call site */
+	str	lr, [sp, #S_PC]
+
+	/* Now fill in callee's preliminary stackframe. */
+	stp	x29, x9, [sp, #S_FRAME_SIZE]
+	/* Let FP point to it. */
+	add	x29, sp, #S_FRAME_SIZE
+
+	/* Our stackframe, stored inside pt_regs. */
+	stp	x29, x30, [sp, #S_STACKFRAME]
+	add	x29, sp, #S_STACKFRAME
+	.endm
+
+ENTRY(ftrace_regs_caller)
+	ftrace_regs_entry	1
+	b	ftrace_common
+ENDPROC(ftrace_regs_caller)
+
+ENTRY(ftrace_caller)
+	ftrace_regs_entry	0
+	b	ftrace_common
+ENDPROC(ftrace_caller)
+
+ENTRY(ftrace_common)
+
+	mov	x3, sp				/* pt_regs are @sp */
+	ldr_l	x2, function_trace_op, x0
+	mov	x1, x9				/* parent IP */
+	sub	x0, lr, #AARCH64_INSN_SIZE
+
+GLOBAL(ftrace_call)
+	bl	ftrace_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+GLOBAL(ftrace_graph_call)		// ftrace_graph_caller();
+	nop				// If enabled, this will be replaced
+					// "b ftrace_graph_caller"
+#endif
+
+/*
+ * GCC's patchable-function-entry implicitly disables IPA-RA,
+ * so all non-argument registers are either scratch / dead
+ * or callee-saved (within the ftrace framework). Function
+ * arguments of the call we are intercepting right now however
+ * need to be preserved in any case.
+ */
+ftrace_common_return:
+	/* restore function args */
+	ldp	x0, x1, [sp]
+	ldp	x2, x3, [sp, #S_X2]
+	ldp	x4, x5, [sp, #S_X4]
+	ldp	x6, x7, [sp, #S_X6]
+	ldr	x8, [sp, #S_X8]
+
+	/* restore fp and x28 */
+	ldp	x28, x29, [sp, #S_X28]
+
+	ldr	lr, [sp, #S_LR]
+	ldr	x9, [sp, #S_PC]
+	/* clean up both frames, ours and callee preliminary */
+	add	sp, sp, #S_FRAME_SIZE + 16
+
+	ret	x9
+ENDPROC(ftrace_common)
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ENTRY(ftrace_graph_caller)
+	ldr	x0, [sp, #S_PC]		   /* pc */
+	sub	x0, x0, #AARCH64_INSN_SIZE
+	add	x1, sp, #S_LR		   /* &lr */
+	ldr	x2, [sp, #S_FRAME_SIZE]	   /* fp */
+	bl	prepare_ftrace_return
+	b	ftrace_common_return
+ENDPROC(ftrace_graph_caller)
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+ENTRY(ftrace_stub)
+	ret
+ENDPROC(ftrace_stub)
+
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
  * void return_to_handler(void)
  *
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 171773257974..faf339e90319 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -62,6 +62,46 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
=20
+#ifdef CONFIG_ARM64_MODULE_PLTS
+static int install_ftrace_trampoline(struct module *mod, unsigned long *ad=
dr)
+{
+	struct plt_entry trampoline, *mod_trampoline;
+
+	/*
+	 * Iterate over
+	 * mod->arch.ftrace_trampolines[MOD_ARCH_NR_FTRACE_TRAMPOLINES]
+	 * The assignment to various ftrace functions happens here.
+	 */
+	if (*addr =3D=3D FTRACE_ADDR)
+		mod_trampoline =3D &mod->arch.ftrace_trampolines[0];
+	else if (*addr =3D=3D FTRACE_REGS_ADDR)
+		mod_trampoline =3D &mod->arch.ftrace_trampolines[1];
+	else
+		return -EINVAL;
+
+	trampoline =3D get_plt_entry(*addr, mod_trampoline);
+
+	/*
+	 * Note that PLTs are place relative, and plt_entries_equal()
+	 * checks whether they point to the same target. Here, we need
+	 * to check if the actual opcodes are in fact identical,
+	 * regardless of the offset in memory so use memcmp() instead.
+	 */
+	if (memcmp(mod_trampoline, &trampoline, sizeof(trampoline))) {
+		/* point the trampoline at our ftrace entry point */
+		module_disable_ro(mod);
+		*mod_trampoline =3D trampoline;
+		module_enable_ro(mod, true);
+
+		/* update trampoline before patching in the branch */
+		smp_wmb();
+	}
+	*addr =3D (unsigned long)(void *)mod_trampoline;
+
+	return 0;
+}
+#endif
+
 /*
  * Turn on the call to ftrace_caller() in instrumented function
  */
@@ -73,8 +113,8 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned lo=
ng addr)
=20
 	if (offset < -SZ_128M || offset >=3D SZ_128M) {
 #ifdef CONFIG_ARM64_MODULE_PLTS
-		struct plt_entry trampoline, *dst;
 		struct module *mod;
+		int ret;
=20
 		/*
 		 * On kernels that support module PLTs, the offset between the
@@ -93,40 +133,13 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned =
long addr)
 		if (WARN_ON(!mod))
 			return -EINVAL;
=20
-		/*
-		 * There is only one ftrace trampoline per module. For now,
-		 * this is not a problem since on arm64, all dynamic ftrace
-		 * invocations are routed via ftrace_caller(). This will need
-		 * to be revisited if support for multiple ftrace entry points
-		 * is added in the future, but for now, the pr_err() below
-		 * deals with a theoretical issue only.
-		 *
-		 * Note that PLTs are place relative, and plt_entries_equal()
-		 * checks whether they point to the same target. Here, we need
-		 * to check if the actual opcodes are in fact identical,
-		 * regardless of the offset in memory so use memcmp() instead.
-		 */
-		dst =3D mod->arch.ftrace_trampoline;
-		trampoline =3D get_plt_entry(addr, dst);
-		if (memcmp(dst, &trampoline, sizeof(trampoline))) {
-			if (plt_entry_is_initialized(dst)) {
-				pr_err("ftrace: far branches to multiple entry points unsupported insi=
de a single module\n");
-				return -EINVAL;
-			}
-
-			/* point the trampoline to our ftrace entry point */
-			module_disable_ro(mod);
-			*dst =3D trampoline;
-			module_enable_ro(mod, true);
-
-			/*
-			 * Ensure updated trampoline is visible to instruction
-			 * fetch before we patch in the branch.
-			 */
-			__flush_icache_range((unsigned long)&dst[0],
-					     (unsigned long)&dst[1]);
-		}
-		addr =3D (unsigned long)dst;
+		/* Check against our well-known list of ftrace entry points */
+		if (addr =3D=3D FTRACE_ADDR || addr =3D=3D FTRACE_REGS_ADDR) {
+			ret =3D install_ftrace_trampoline(mod, &addr);
+			if (ret < 0)
+				return ret;
+		} else
+			return -EINVAL;
 #else /* CONFIG_ARM64_MODULE_PLTS */
 		return -EINVAL;
 #endif /* CONFIG_ARM64_MODULE_PLTS */
@@ -138,6 +151,45 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned =
long addr)
 	return ftrace_modify_code(pc, old, new, true);
 }
=20
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+		       unsigned long addr)
+{
+	unsigned long pc =3D rec->ip;
+	u32 old, new;
+
+	old =3D aarch64_insn_gen_branch_imm(pc, old_addr,
+					  AARCH64_INSN_BRANCH_LINK);
+	new =3D aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+/*
+ * Ftrace with regs generates the tracer calls as close as possible to
+ * the function entry; no stack frame has been set up at that point.
+ * In order to make another call e.g to ftrace_caller, the LR must be
+ * saved from being overwritten.
+ * Between two functions, and with IPA-RA turned off, the scratch register=
s
+ * are available, so move the LR to x9 before calling into ftrace.
+ *
+ * This function is called once during kernel startup for each call site.
+ * The address passed is that of the actual branch, so patch in the LR sav=
er
+ * just before that.
+ */
+static int ftrace_setup_lr_saver(unsigned long addr)
+{
+	u32 old, new;
+
+	old =3D aarch64_insn_gen_nop();
+	/* "mov x9, lr" is officially aliased from "orr x9, xzr, lr". */
+	new =3D aarch64_insn_gen_logical_shifted_reg(AARCH64_INSN_REG_9,
+		AARCH64_INSN_REG_ZR, AARCH64_INSN_REG_LR, 0,
+		AARCH64_INSN_VARIANT_64BIT, AARCH64_INSN_LOGIC_ORR);
+	return ftrace_modify_code(addr - AARCH64_INSN_SIZE, old, new, true);
+}
+#endif
+
 /*
  * Turn off the call to ftrace_caller() in instrumented function
  */
@@ -196,6 +248,22 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftr=
ace *rec,
 	return ftrace_modify_code(pc, old, new, validate);
 }
=20
+int ftrace_call_init(struct module *mod, struct dyn_ftrace *rec)
+{
+	unsigned long pc =3D rec->ip;
+
+	/*
+	 * -fpatchable-function-entry=3D does not generate a profiling call
+	 *  initially; the NOPs are already there. So instead,
+	 *  put the LR saver there ahead of time, in order to avoid
+	 *  any race condition over patching 2 instructions.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		return ftrace_setup_lr_saver(pc);
+	else
+		return ftrace_make_nop(mod, rec, (unsigned long)_mcount);
+}
+
 void arch_ftrace_update_code(int command)
 {
 	command |=3D FTRACE_MAY_SLEEP;
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plt=
s.c
index 044c0ae4d6c8..acafb8a2244d 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -330,7 +330,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr =
*sechdrs,
 		tramp->sh_type =3D SHT_NOBITS;
 		tramp->sh_flags =3D SHF_EXECINSTR | SHF_ALLOC;
 		tramp->sh_addralign =3D __alignof__(struct plt_entry);
-		tramp->sh_size =3D sizeof(struct plt_entry);
+		tramp->sh_size =3D MOD_ARCH_NR_FTRACE_TRAMPOLINES
+				 * sizeof(struct plt_entry);
 	}
=20
 	return 0;
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 03ff15bffbb6..4e1d99805c5a 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -483,7 +483,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 #ifdef CONFIG_ARM64_MODULE_PLTS
 		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))
-			me->arch.ftrace_trampoline =3D (void *)s->sh_addr;
+			me->arch.ftrace_trampolines =3D (void *)s->sh_addr;
 #endif
 	}
=20
--=20
2.23.0.rc1

