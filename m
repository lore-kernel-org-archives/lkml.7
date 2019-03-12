Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EBCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFEE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JTOPvtve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCLWsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:48:22 -0400
Received: from mail-eopbgr710119.outbound.protection.outlook.com ([40.107.71.119]:25250
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbfCLWsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBnFoy60rp7QltYKlC+VqkE/2ivwPY0lggCXMngC8Oo=;
 b=JTOPvtvemHfMmWsb7uEATiueABtwTaBjV5Vzmkj+SmExzOo3sy5h6wQm5tvsyWmQ2GEULZlay2n15NPeCz+20gW856E4EAcwV1FzcBkh4dwTY9J/jv9QFOtUpsEDTuEiPgDKsyD8+4TnIARK8PJ6nh7aoN+OLmt6H9izD6Q17bY=
Received: from CY4PR2201MB1349.namprd22.prod.outlook.com (10.171.209.23) by
 CY4PR2201MB1720.namprd22.prod.outlook.com (10.165.90.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 22:48:13 +0000
Received: from CY4PR2201MB1349.namprd22.prod.outlook.com
 ([fe80::901a:e86:7fcf:8856]) by CY4PR2201MB1349.namprd22.prod.outlook.com
 ([fe80::901a:e86:7fcf:8856%3]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 22:48:13 +0000
From:   Hassan Naveed <hnaveed@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] MIPS: eBPF: Initial eBPF support for MIPS32
 architecture.
Thread-Topic: [PATCH v2 3/3] MIPS: eBPF: Initial eBPF support for MIPS32
 architecture.
Thread-Index: AQHU2SWseMNIwzbpm0W2ah2TnQcK0A==
Date:   Tue, 12 Mar 2019 22:48:12 +0000
Message-ID: <20190312224706.6121-3-hnaveed@wavecomp.com>
References: <20190312224706.6121-1-hnaveed@wavecomp.com>
In-Reply-To: <20190312224706.6121-1-hnaveed@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To CY4PR2201MB1349.namprd22.prod.outlook.com
 (2603:10b6:910:64::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hnaveed@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3838f10-02a3-41c3-1e7f-08d6a73ccea0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1720;
x-ms-traffictypediagnostic: CY4PR2201MB1720:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR2201MB1720;23:vngocXjo8IkyiQ+CI6zR5QCjpKF6If+mpc8mm?=
 =?iso-8859-1?Q?4CZxMqL/nRkb+RxJcOeFLigzHBrXi8GB2w5J/3mn59RKHMVNq+Wa7MAHBf?=
 =?iso-8859-1?Q?7LGjsYHRg1RnockuHbFBg5XPnPXX5U9jc/Ox7Fuk/F7n9qVU38dZb6M+b9?=
 =?iso-8859-1?Q?M2Xuj8+q272jxvIUjrlZSEp5wa0OtDYyrvQZrapQpikahT0FE0rE/sMN9P?=
 =?iso-8859-1?Q?FW+Anw5chYUgwX7csBwyOJAVcaUqxihrhtQq7GBLq/fmE3HO37QDDmKxNZ?=
 =?iso-8859-1?Q?z1CXOZ7oFBwdcyHSTPfzmYvM4QwYGxyeL/hmjV5OHtjWyuBZaAdoXZZTc4?=
 =?iso-8859-1?Q?MhqhiaURERi9i+gQp3rYk3HOiS2b9H4p385K0kb2r09fiw2mtlXq+WnI8E?=
 =?iso-8859-1?Q?V3H4/VE39d0FoiSodyBy1+vMAjLuWuoPxCtQhMVUhRuOqIHCCt1HhJSvHa?=
 =?iso-8859-1?Q?/jD4YslJsqSnQDL/Xb+of3wZ7RB4XWSs52/McltNhcgHYoipyInE1P0JWr?=
 =?iso-8859-1?Q?KyuLTNroAJ+pw7M93VKRQ8lJ2gMn2vCULXJ3CgMzYl7ztYqW4PUOBPILuJ?=
 =?iso-8859-1?Q?R79itz4hiewUUZuJ5cN1AG+O9JNpW2yT4k1xsrlZJRx5LxIAJih57R1L1k?=
 =?iso-8859-1?Q?jWAfHa/HUx15BSvp92d5rf4xRhEh16pEuwyfbQt6dSsCbTd3PdFqcUqlXP?=
 =?iso-8859-1?Q?cwlZ0mAiej1FCLrIajkDrbFdfrIroEnWnVkYP0HAzoozpg2gJUolmp+m1g?=
 =?iso-8859-1?Q?bBMWFHHpOR/ex4A+KPsdBeFJj8tHGoUHfNQAmyUsBCi4GsaqEaRs215K1Y?=
 =?iso-8859-1?Q?GQ0bAVqUOY+7vI9Q20pGJuN3xC5cLcWxxJZ/wPrCuiqpZb4awJ8HZMxont?=
 =?iso-8859-1?Q?4cJ0HFNQ9e7VC6Lk6aRpt7ynpawTfEUJxfn76sHRvyFJ6CQ6TyGICYJ2/1?=
 =?iso-8859-1?Q?dwbPm0gIMN0qWpjpCiJCA4Ziz/xCTkrH0lH2UcHsrKZ3IPtVuax7ij33ec?=
 =?iso-8859-1?Q?SV+YWSA959j4yVPr60Eekc1LcsnfMrg0FcTTVa9PBJA5pTpglPxSh8/Ica?=
 =?iso-8859-1?Q?fPhPOFrz6irFz5q21IdVore837/MU2VayDMAwNZZe6cjSkmYJbLR6Xa6vU?=
 =?iso-8859-1?Q?g7j1caoonNbJUro4TAgVFIBrvtwgaWzlrx79YuHUrZik+2wC8cPNP3zlte?=
 =?iso-8859-1?Q?WP2yrqPimUZE3sDE0TUX8d7aiciZWXY6pelSp2tOgBX775tvLraNl+kdkb?=
 =?iso-8859-1?Q?hZ1I3NNvqJXtZIww65hy33wqft0j60dtl+aUobPIrhlPYgq5LAbS2lI8yS?=
 =?iso-8859-1?Q?bpvFHSawNcH5DqwL5vj29pH1hdVHkS22TqN0opZ3VfGI6CGNVxA9nCwni5?=
 =?iso-8859-1?Q?fboDItT6+rMLAMDeuFSLGeO7c96d5knN+X/q2xE3pbCkpj0kZGf6sBF7iG?=
 =?iso-8859-1?Q?wc3aq8maM5R8fHM2BjNMips4q61LVun7X5febWj9RKOYiCpNwJErQ7U1Nz?=
 =?iso-8859-1?B?UT09?=
x-microsoft-antispam-prvs: <CY4PR2201MB17209E092FD8FF875ADDD91FD4490@CY4PR2201MB1720.namprd22.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39840400004)(366004)(396003)(24424003)(189003)(199004)(51234002)(66066001)(105586002)(99286004)(14444005)(26005)(53946003)(2906002)(53936002)(3846002)(86362001)(6116002)(36756003)(14454004)(71190400001)(71200400001)(50226002)(476003)(7736002)(305945005)(68736007)(478600001)(7416002)(30864003)(6506007)(386003)(186003)(6512007)(106356001)(6862004)(1076003)(97736004)(6486002)(5660300002)(25786009)(446003)(4326008)(2616005)(102836004)(8676002)(11346002)(37006003)(76176011)(316002)(81166006)(81156014)(6636002)(486006)(8936002)(52116002)(256004)(54906003)(6436002)(2004002)(579004)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1720;H:CY4PR2201MB1349.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q1iwCSkbEbX4I2gp371R3ZQj6OBdQhvP5m8jsUSnncfbsiL+86v1eZPNPm8BMv6hM8Q9l3X3OeVFbzoVadB4gUFqNiSRCX8vnZnCXUzKslHzgNRAxRUBwdrRA+TygCEOXyiAG0/PyVv2h2EabbaGUqs9x+Hp8OVwy84eHMKIDxAmyabLmKaC5XbjY+4gJLU87s5q5k6wEv3Ukl5rMA0DsuwPn4EO+hdFhPWs9tBxpROmQ0YxAmCtFXUqFHaiKUatVHvxSSR/gikg10fPCAEgM+0PPUjdpEFm07kECBnyWWMJfpJoUi7Vq6cTKS73rmzSg0MJ3mac9GfhdVOFnrM2wtOzd0LxgLSku6bYX5xPfOyrqduUA6hdPGpyPSPA6CkLX8S/C194dEY5FNUQNLsZtqGmmWpyPCoU9bF6efGfKqM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3838f10-02a3-41c3-1e7f-08d6a73ccea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 22:48:12.9973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently MIPS32 supports a JIT for classic BPF only, not extended BPF.
This patch adds JIT support for extended BPF on MIPS32, so code is
actually JIT'ed instead of being only interpreted. Instructions with
64-bit operands are not supported at this point.
We can delete classic BPF because the kernel will translate classic BPF
programs into extended BPF and JIT them, eliminating the need for
classic BPF.

Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
---
 arch/mips/Kconfig           |    3 +-
 arch/mips/net/Makefile      |    1 -
 arch/mips/net/bpf_jit.c     | 1270 -----------------------------------
 arch/mips/net/bpf_jit_asm.S |  285 --------
 arch/mips/net/ebpf_jit.c    |  113 ++--
 5 files changed, 70 insertions(+), 1602 deletions(-)
 delete mode 100644 arch/mips/net/bpf_jit.c
 delete mode 100644 arch/mips/net/bpf_jit_asm.S

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a84c24d894aa..ddf156075e04 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -43,8 +43,7 @@ config MIPS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
-	select HAVE_CBPF_JIT if (!64BIT && !CPU_MICROMIPS)
-	select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)
+	select HAVE_EBPF_JIT if (!CPU_MICROMIPS)
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
diff --git a/arch/mips/net/Makefile b/arch/mips/net/Makefile
index 47d678416715..72a78462f872 100644
--- a/arch/mips/net/Makefile
+++ b/arch/mips/net/Makefile
@@ -1,4 +1,3 @@
 # MIPS networking code
=20
-obj-$(CONFIG_MIPS_CBPF_JIT) +=3D bpf_jit.o bpf_jit_asm.o
 obj-$(CONFIG_MIPS_EBPF_JIT) +=3D ebpf_jit.o
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
deleted file mode 100644
index 3a0e34f4e615..000000000000
--- a/arch/mips/net/bpf_jit.c
+++ /dev/null
@@ -1,1270 +0,0 @@
-/*
- * Just-In-Time compiler for BPF filters on MIPS
- *
- * Copyright (c) 2014 Imagination Technologies Ltd.
- * Author: Markos Chandras <markos.chandras@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2 of the License.
- */
-
-#include <linux/bitops.h>
-#include <linux/compiler.h>
-#include <linux/errno.h>
-#include <linux/filter.h>
-#include <linux/if_vlan.h>
-#include <linux/moduleloader.h>
-#include <linux/netdevice.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <asm/asm.h>
-#include <asm/bitops.h>
-#include <asm/cacheflush.h>
-#include <asm/cpu-features.h>
-#include <asm/uasm.h>
-
-#include "bpf_jit.h"
-
-/* ABI
- * r_skb_hl	SKB header length
- * r_data	SKB data pointer
- * r_off	Offset
- * r_A		BPF register A
- * r_X		BPF register X
- * r_skb	*skb
- * r_M		*scratch memory
- * r_skb_len	SKB length
- *
- * On entry (*bpf_func)(*skb, *filter)
- * a0 =3D MIPS_R_A0 =3D skb;
- * a1 =3D MIPS_R_A1 =3D filter;
- *
- * Stack
- * ...
- * M[15]
- * M[14]
- * M[13]
- * ...
- * M[0] <-- r_M
- * saved reg k-1
- * saved reg k-2
- * ...
- * saved reg 0 <-- r_sp
- * <no argument area>
- *
- *                     Packet layout
- *
- * <--------------------- len ------------------------>
- * <--skb-len(r_skb_hl)-->< ----- skb->data_len ------>
- * ----------------------------------------------------
- * |                  skb->data                       |
- * ----------------------------------------------------
- */
-
-#define ptr typeof(unsigned long)
-
-#define SCRATCH_OFF(k)		(4 * (k))
-
-/* JIT flags */
-#define SEEN_CALL		(1 << BPF_MEMWORDS)
-#define SEEN_SREG_SFT		(BPF_MEMWORDS + 1)
-#define SEEN_SREG_BASE		(1 << SEEN_SREG_SFT)
-#define SEEN_SREG(x)		(SEEN_SREG_BASE << (x))
-#define SEEN_OFF		SEEN_SREG(2)
-#define SEEN_A			SEEN_SREG(3)
-#define SEEN_X			SEEN_SREG(4)
-#define SEEN_SKB		SEEN_SREG(5)
-#define SEEN_MEM		SEEN_SREG(6)
-/* SEEN_SK_DATA also implies skb_hl an skb_len */
-#define SEEN_SKB_DATA		(SEEN_SREG(7) | SEEN_SREG(1) | SEEN_SREG(0))
-
-/* Arguments used by JIT */
-#define ARGS_USED_BY_JIT	2 /* only applicable to 64-bit */
-
-#define SBIT(x)			(1 << (x)) /* Signed version of BIT() */
-
-/**
- * struct jit_ctx - JIT context
- * @skf:		The sk_filter
- * @prologue_bytes:	Number of bytes for prologue
- * @idx:		Instruction index
- * @flags:		JIT flags
- * @offsets:		Instruction offsets
- * @target:		Memory location for the compiled filter
- */
-struct jit_ctx {
-	const struct bpf_prog *skf;
-	unsigned int prologue_bytes;
-	u32 idx;
-	u32 flags;
-	u32 *offsets;
-	u32 *target;
-};
-
-
-static inline int optimize_div(u32 *k)
-{
-	/* power of 2 divides can be implemented with right shift */
-	if (!(*k & (*k-1))) {
-		*k =3D ilog2(*k);
-		return 1;
-	}
-
-	return 0;
-}
-
-static inline void emit_jit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx=
);
-
-/* Simply emit the instruction if the JIT memory space has been allocated =
*/
-#define emit_instr(ctx, func, ...)			\
-do {							\
-	if ((ctx)->target !=3D NULL) {			\
-		u32 *p =3D &(ctx)->target[ctx->idx];	\
-		uasm_i_##func(&p, ##__VA_ARGS__);	\
-	}						\
-	(ctx)->idx++;					\
-} while (0)
-
-/*
- * Similar to emit_instr but it must be used when we need to emit
- * 32-bit or 64-bit instructions
- */
-#define emit_long_instr(ctx, func, ...)			\
-do {							\
-	if ((ctx)->target !=3D NULL) {			\
-		u32 *p =3D &(ctx)->target[ctx->idx];	\
-		UASM_i_##func(&p, ##__VA_ARGS__);	\
-	}						\
-	(ctx)->idx++;					\
-} while (0)
-
-/* Determine if immediate is within the 16-bit signed range */
-static inline bool is_range16(s32 imm)
-{
-	return !(imm >=3D SBIT(15) || imm < -SBIT(15));
-}
-
-static inline void emit_addu(unsigned int dst, unsigned int src1,
-			     unsigned int src2, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, addu, dst, src1, src2);
-}
-
-static inline void emit_nop(struct jit_ctx *ctx)
-{
-	emit_instr(ctx, nop);
-}
-
-/* Load a u32 immediate to a register */
-static inline void emit_load_imm(unsigned int dst, u32 imm, struct jit_ctx=
 *ctx)
-{
-	if (ctx->target !=3D NULL) {
-		/* addiu can only handle s16 */
-		if (!is_range16(imm)) {
-			u32 *p =3D &ctx->target[ctx->idx];
-			uasm_i_lui(&p, r_tmp_imm, (s32)imm >> 16);
-			p =3D &ctx->target[ctx->idx + 1];
-			uasm_i_ori(&p, dst, r_tmp_imm, imm & 0xffff);
-		} else {
-			u32 *p =3D &ctx->target[ctx->idx];
-			uasm_i_addiu(&p, dst, r_zero, imm);
-		}
-	}
-	ctx->idx++;
-
-	if (!is_range16(imm))
-		ctx->idx++;
-}
-
-static inline void emit_or(unsigned int dst, unsigned int src1,
-			   unsigned int src2, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, or, dst, src1, src2);
-}
-
-static inline void emit_ori(unsigned int dst, unsigned src, u32 imm,
-			    struct jit_ctx *ctx)
-{
-	if (imm >=3D BIT(16)) {
-		emit_load_imm(r_tmp, imm, ctx);
-		emit_or(dst, src, r_tmp, ctx);
-	} else {
-		emit_instr(ctx, ori, dst, src, imm);
-	}
-}
-
-static inline void emit_daddiu(unsigned int dst, unsigned int src,
-			       int imm, struct jit_ctx *ctx)
-{
-	/*
-	 * Only used for stack, so the imm is relatively small
-	 * and it fits in 15-bits
-	 */
-	emit_instr(ctx, daddiu, dst, src, imm);
-}
-
-static inline void emit_addiu(unsigned int dst, unsigned int src,
-			      u32 imm, struct jit_ctx *ctx)
-{
-	if (!is_range16(imm)) {
-		emit_load_imm(r_tmp, imm, ctx);
-		emit_addu(dst, r_tmp, src, ctx);
-	} else {
-		emit_instr(ctx, addiu, dst, src, imm);
-	}
-}
-
-static inline void emit_and(unsigned int dst, unsigned int src1,
-			    unsigned int src2, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, and, dst, src1, src2);
-}
-
-static inline void emit_andi(unsigned int dst, unsigned int src,
-			     u32 imm, struct jit_ctx *ctx)
-{
-	/* If imm does not fit in u16 then load it to register */
-	if (imm >=3D BIT(16)) {
-		emit_load_imm(r_tmp, imm, ctx);
-		emit_and(dst, src, r_tmp, ctx);
-	} else {
-		emit_instr(ctx, andi, dst, src, imm);
-	}
-}
-
-static inline void emit_xor(unsigned int dst, unsigned int src1,
-			    unsigned int src2, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, xor, dst, src1, src2);
-}
-
-static inline void emit_xori(ptr dst, ptr src, u32 imm, struct jit_ctx *ct=
x)
-{
-	/* If imm does not fit in u16 then load it to register */
-	if (imm >=3D BIT(16)) {
-		emit_load_imm(r_tmp, imm, ctx);
-		emit_xor(dst, src, r_tmp, ctx);
-	} else {
-		emit_instr(ctx, xori, dst, src, imm);
-	}
-}
-
-static inline void emit_stack_offset(int offset, struct jit_ctx *ctx)
-{
-	emit_long_instr(ctx, ADDIU, r_sp, r_sp, offset);
-}
-
-static inline void emit_subu(unsigned int dst, unsigned int src1,
-			     unsigned int src2, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, subu, dst, src1, src2);
-}
-
-static inline void emit_neg(unsigned int reg, struct jit_ctx *ctx)
-{
-	emit_subu(reg, r_zero, reg, ctx);
-}
-
-static inline void emit_sllv(unsigned int dst, unsigned int src,
-			     unsigned int sa, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, sllv, dst, src, sa);
-}
-
-static inline void emit_sll(unsigned int dst, unsigned int src,
-			    unsigned int sa, struct jit_ctx *ctx)
-{
-	/* sa is 5-bits long */
-	if (sa >=3D BIT(5))
-		/* Shifting >=3D 32 results in zero */
-		emit_jit_reg_move(dst, r_zero, ctx);
-	else
-		emit_instr(ctx, sll, dst, src, sa);
-}
-
-static inline void emit_srlv(unsigned int dst, unsigned int src,
-			     unsigned int sa, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, srlv, dst, src, sa);
-}
-
-static inline void emit_srl(unsigned int dst, unsigned int src,
-			    unsigned int sa, struct jit_ctx *ctx)
-{
-	/* sa is 5-bits long */
-	if (sa >=3D BIT(5))
-		/* Shifting >=3D 32 results in zero */
-		emit_jit_reg_move(dst, r_zero, ctx);
-	else
-		emit_instr(ctx, srl, dst, src, sa);
-}
-
-static inline void emit_slt(unsigned int dst, unsigned int src1,
-			    unsigned int src2, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, slt, dst, src1, src2);
-}
-
-static inline void emit_sltu(unsigned int dst, unsigned int src1,
-			     unsigned int src2, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, sltu, dst, src1, src2);
-}
-
-static inline void emit_sltiu(unsigned dst, unsigned int src,
-			      unsigned int imm, struct jit_ctx *ctx)
-{
-	/* 16 bit immediate */
-	if (!is_range16((s32)imm)) {
-		emit_load_imm(r_tmp, imm, ctx);
-		emit_sltu(dst, src, r_tmp, ctx);
-	} else {
-		emit_instr(ctx, sltiu, dst, src, imm);
-	}
-
-}
-
-/* Store register on the stack */
-static inline void emit_store_stack_reg(ptr reg, ptr base,
-					unsigned int offset,
-					struct jit_ctx *ctx)
-{
-	emit_long_instr(ctx, SW, reg, offset, base);
-}
-
-static inline void emit_store(ptr reg, ptr base, unsigned int offset,
-			      struct jit_ctx *ctx)
-{
-	emit_instr(ctx, sw, reg, offset, base);
-}
-
-static inline void emit_load_stack_reg(ptr reg, ptr base,
-				       unsigned int offset,
-				       struct jit_ctx *ctx)
-{
-	emit_long_instr(ctx, LW, reg, offset, base);
-}
-
-static inline void emit_load(unsigned int reg, unsigned int base,
-			     unsigned int offset, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, lw, reg, offset, base);
-}
-
-static inline void emit_load_byte(unsigned int reg, unsigned int base,
-				  unsigned int offset, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, lb, reg, offset, base);
-}
-
-static inline void emit_half_load(unsigned int reg, unsigned int base,
-				  unsigned int offset, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, lh, reg, offset, base);
-}
-
-static inline void emit_half_load_unsigned(unsigned int reg, unsigned int =
base,
-					   unsigned int offset, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, lhu, reg, offset, base);
-}
-
-static inline void emit_mul(unsigned int dst, unsigned int src1,
-			    unsigned int src2, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, mul, dst, src1, src2);
-}
-
-static inline void emit_div(unsigned int dst, unsigned int src,
-			    struct jit_ctx *ctx)
-{
-	if (ctx->target !=3D NULL) {
-		u32 *p =3D &ctx->target[ctx->idx];
-		uasm_i_divu(&p, dst, src);
-		p =3D &ctx->target[ctx->idx + 1];
-		uasm_i_mflo(&p, dst);
-	}
-	ctx->idx +=3D 2; /* 2 insts */
-}
-
-static inline void emit_mod(unsigned int dst, unsigned int src,
-			    struct jit_ctx *ctx)
-{
-	if (ctx->target !=3D NULL) {
-		u32 *p =3D &ctx->target[ctx->idx];
-		uasm_i_divu(&p, dst, src);
-		p =3D &ctx->target[ctx->idx + 1];
-		uasm_i_mfhi(&p, dst);
-	}
-	ctx->idx +=3D 2; /* 2 insts */
-}
-
-static inline void emit_dsll(unsigned int dst, unsigned int src,
-			     unsigned int sa, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, dsll, dst, src, sa);
-}
-
-static inline void emit_dsrl32(unsigned int dst, unsigned int src,
-			       unsigned int sa, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, dsrl32, dst, src, sa);
-}
-
-static inline void emit_wsbh(unsigned int dst, unsigned int src,
-			     struct jit_ctx *ctx)
-{
-	emit_instr(ctx, wsbh, dst, src);
-}
-
-/* load pointer to register */
-static inline void emit_load_ptr(unsigned int dst, unsigned int src,
-				     int imm, struct jit_ctx *ctx)
-{
-	/* src contains the base addr of the 32/64-pointer */
-	emit_long_instr(ctx, LW, dst, imm, src);
-}
-
-/* load a function pointer to register */
-static inline void emit_load_func(unsigned int reg, ptr imm,
-				  struct jit_ctx *ctx)
-{
-	if (IS_ENABLED(CONFIG_64BIT)) {
-		/* At this point imm is always 64-bit */
-		emit_load_imm(r_tmp, (u64)imm >> 32, ctx);
-		emit_dsll(r_tmp_imm, r_tmp, 16, ctx); /* left shift by 16 */
-		emit_ori(r_tmp, r_tmp_imm, (imm >> 16) & 0xffff, ctx);
-		emit_dsll(r_tmp_imm, r_tmp, 16, ctx); /* left shift by 16 */
-		emit_ori(reg, r_tmp_imm, imm & 0xffff, ctx);
-	} else {
-		emit_load_imm(reg, imm, ctx);
-	}
-}
-
-/* Move to real MIPS register */
-static inline void emit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx)
-{
-	emit_long_instr(ctx, ADDU, dst, src, r_zero);
-}
-
-/* Move to JIT (32-bit) register */
-static inline void emit_jit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx=
)
-{
-	emit_addu(dst, src, r_zero, ctx);
-}
-
-/* Compute the immediate value for PC-relative branches. */
-static inline u32 b_imm(unsigned int tgt, struct jit_ctx *ctx)
-{
-	if (ctx->target =3D=3D NULL)
-		return 0;
-
-	/*
-	 * We want a pc-relative branch. We only do forward branches
-	 * so tgt is always after pc. tgt is the instruction offset
-	 * we want to jump to.
-
-	 * Branch on MIPS:
-	 * I: target_offset <- sign_extend(offset)
-	 * I+1: PC +=3D target_offset (delay slot)
-	 *
-	 * ctx->idx currently points to the branch instruction
-	 * but the offset is added to the delay slot so we need
-	 * to subtract 4.
-	 */
-	return ctx->offsets[tgt] -
-		(ctx->idx * 4 - ctx->prologue_bytes) - 4;
-}
-
-static inline void emit_bcond(int cond, unsigned int reg1, unsigned int re=
g2,
-			     unsigned int imm, struct jit_ctx *ctx)
-{
-	if (ctx->target !=3D NULL) {
-		u32 *p =3D &ctx->target[ctx->idx];
-
-		switch (cond) {
-		case MIPS_COND_EQ:
-			uasm_i_beq(&p, reg1, reg2, imm);
-			break;
-		case MIPS_COND_NE:
-			uasm_i_bne(&p, reg1, reg2, imm);
-			break;
-		case MIPS_COND_ALL:
-			uasm_i_b(&p, imm);
-			break;
-		default:
-			pr_warn("%s: Unhandled branch conditional: %d\n",
-				__func__, cond);
-		}
-	}
-	ctx->idx++;
-}
-
-static inline void emit_b(unsigned int imm, struct jit_ctx *ctx)
-{
-	emit_bcond(MIPS_COND_ALL, r_zero, r_zero, imm, ctx);
-}
-
-static inline void emit_jalr(unsigned int link, unsigned int reg,
-			     struct jit_ctx *ctx)
-{
-	emit_instr(ctx, jalr, link, reg);
-}
-
-static inline void emit_jr(unsigned int reg, struct jit_ctx *ctx)
-{
-	emit_instr(ctx, jr, reg);
-}
-
-static inline u16 align_sp(unsigned int num)
-{
-	/* Double word alignment for 32-bit, quadword for 64-bit */
-	unsigned int align =3D IS_ENABLED(CONFIG_64BIT) ? 16 : 8;
-	num =3D (num + (align - 1)) & -align;
-	return num;
-}
-
-static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
-{
-	int i =3D 0, real_off =3D 0;
-	u32 sflags, tmp_flags;
-
-	/* Adjust the stack pointer */
-	if (offset)
-		emit_stack_offset(-align_sp(offset), ctx);
-
-	tmp_flags =3D sflags =3D ctx->flags >> SEEN_SREG_SFT;
-	/* sflags is essentially a bitmap */
-	while (tmp_flags) {
-		if ((sflags >> i) & 0x1) {
-			emit_store_stack_reg(MIPS_R_S0 + i, r_sp, real_off,
-					     ctx);
-			real_off +=3D SZREG;
-		}
-		i++;
-		tmp_flags >>=3D 1;
-	}
-
-	/* save return address */
-	if (ctx->flags & SEEN_CALL) {
-		emit_store_stack_reg(r_ra, r_sp, real_off, ctx);
-		real_off +=3D SZREG;
-	}
-
-	/* Setup r_M leaving the alignment gap if necessary */
-	if (ctx->flags & SEEN_MEM) {
-		if (real_off % (SZREG * 2))
-			real_off +=3D SZREG;
-		emit_long_instr(ctx, ADDIU, r_M, r_sp, real_off);
-	}
-}
-
-static void restore_bpf_jit_regs(struct jit_ctx *ctx,
-				 unsigned int offset)
-{
-	int i, real_off =3D 0;
-	u32 sflags, tmp_flags;
-
-	tmp_flags =3D sflags =3D ctx->flags >> SEEN_SREG_SFT;
-	/* sflags is a bitmap */
-	i =3D 0;
-	while (tmp_flags) {
-		if ((sflags >> i) & 0x1) {
-			emit_load_stack_reg(MIPS_R_S0 + i, r_sp, real_off,
-					    ctx);
-			real_off +=3D SZREG;
-		}
-		i++;
-		tmp_flags >>=3D 1;
-	}
-
-	/* restore return address */
-	if (ctx->flags & SEEN_CALL)
-		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
-
-	/* Restore the sp and discard the scrach memory */
-	if (offset)
-		emit_stack_offset(align_sp(offset), ctx);
-}
-
-static unsigned int get_stack_depth(struct jit_ctx *ctx)
-{
-	int sp_off =3D 0;
-
-
-	/* How may s* regs do we need to preserved? */
-	sp_off +=3D hweight32(ctx->flags >> SEEN_SREG_SFT) * SZREG;
-
-	if (ctx->flags & SEEN_MEM)
-		sp_off +=3D 4 * BPF_MEMWORDS; /* BPF_MEMWORDS are 32-bit */
-
-	if (ctx->flags & SEEN_CALL)
-		sp_off +=3D SZREG; /* Space for our ra register */
-
-	return sp_off;
-}
-
-static void build_prologue(struct jit_ctx *ctx)
-{
-	int sp_off;
-
-	/* Calculate the total offset for the stack pointer */
-	sp_off =3D get_stack_depth(ctx);
-	save_bpf_jit_regs(ctx, sp_off);
-
-	if (ctx->flags & SEEN_SKB)
-		emit_reg_move(r_skb, MIPS_R_A0, ctx);
-
-	if (ctx->flags & SEEN_SKB_DATA) {
-		/* Load packet length */
-		emit_load(r_skb_len, r_skb, offsetof(struct sk_buff, len),
-			  ctx);
-		emit_load(r_tmp, r_skb, offsetof(struct sk_buff, data_len),
-			  ctx);
-		/* Load the data pointer */
-		emit_load_ptr(r_skb_data, r_skb,
-			      offsetof(struct sk_buff, data), ctx);
-		/* Load the header length */
-		emit_subu(r_skb_hl, r_skb_len, r_tmp, ctx);
-	}
-
-	if (ctx->flags & SEEN_X)
-		emit_jit_reg_move(r_X, r_zero, ctx);
-
-	/*
-	 * Do not leak kernel data to userspace, we only need to clear
-	 * r_A if it is ever used.  In fact if it is never used, we
-	 * will not save/restore it, so clearing it in this case would
-	 * corrupt the state of the caller.
-	 */
-	if (bpf_needs_clear_a(&ctx->skf->insns[0]) &&
-	    (ctx->flags & SEEN_A))
-		emit_jit_reg_move(r_A, r_zero, ctx);
-}
-
-static void build_epilogue(struct jit_ctx *ctx)
-{
-	unsigned int sp_off;
-
-	/* Calculate the total offset for the stack pointer */
-
-	sp_off =3D get_stack_depth(ctx);
-	restore_bpf_jit_regs(ctx, sp_off);
-
-	/* Return */
-	emit_jr(r_ra, ctx);
-	emit_nop(ctx);
-}
-
-#define CHOOSE_LOAD_FUNC(K, func) \
-	((int)K < 0 ? ((int)K >=3D SKF_LL_OFF ? func##_negative : func) : \
-	 func##_positive)
-
-static int build_body(struct jit_ctx *ctx)
-{
-	const struct bpf_prog *prog =3D ctx->skf;
-	const struct sock_filter *inst;
-	unsigned int i, off, condt;
-	u32 k, b_off __maybe_unused;
-	u8 (*sk_load_func)(unsigned long *skb, int offset);
-
-	for (i =3D 0; i < prog->len; i++) {
-		u16 code;
-
-		inst =3D &(prog->insns[i]);
-		pr_debug("%s: code->0x%02x, jt->0x%x, jf->0x%x, k->0x%x\n",
-			 __func__, inst->code, inst->jt, inst->jf, inst->k);
-		k =3D inst->k;
-		code =3D bpf_anc_helper(inst);
-
-		if (ctx->target =3D=3D NULL)
-			ctx->offsets[i] =3D ctx->idx * 4;
-
-		switch (code) {
-		case BPF_LD | BPF_IMM:
-			/* A <- k =3D=3D> li r_A, k */
-			ctx->flags |=3D SEEN_A;
-			emit_load_imm(r_A, k, ctx);
-			break;
-		case BPF_LD | BPF_W | BPF_LEN:
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) !=3D 4);
-			/* A <- len =3D=3D> lw r_A, offset(skb) */
-			ctx->flags |=3D SEEN_SKB | SEEN_A;
-			off =3D offsetof(struct sk_buff, len);
-			emit_load(r_A, r_skb, off, ctx);
-			break;
-		case BPF_LD | BPF_MEM:
-			/* A <- M[k] =3D=3D> lw r_A, offset(M) */
-			ctx->flags |=3D SEEN_MEM | SEEN_A;
-			emit_load(r_A, r_M, SCRATCH_OFF(k), ctx);
-			break;
-		case BPF_LD | BPF_W | BPF_ABS:
-			/* A <- P[k:4] */
-			sk_load_func =3D CHOOSE_LOAD_FUNC(k, sk_load_word);
-			goto load;
-		case BPF_LD | BPF_H | BPF_ABS:
-			/* A <- P[k:2] */
-			sk_load_func =3D CHOOSE_LOAD_FUNC(k, sk_load_half);
-			goto load;
-		case BPF_LD | BPF_B | BPF_ABS:
-			/* A <- P[k:1] */
-			sk_load_func =3D CHOOSE_LOAD_FUNC(k, sk_load_byte);
-load:
-			emit_load_imm(r_off, k, ctx);
-load_common:
-			ctx->flags |=3D SEEN_CALL | SEEN_OFF |
-				SEEN_SKB | SEEN_A | SEEN_SKB_DATA;
-
-			emit_load_func(r_s0, (ptr)sk_load_func, ctx);
-			emit_reg_move(MIPS_R_A0, r_skb, ctx);
-			emit_jalr(MIPS_R_RA, r_s0, ctx);
-			/* Load second argument to delay slot */
-			emit_reg_move(MIPS_R_A1, r_off, ctx);
-			/* Check the error value */
-			emit_bcond(MIPS_COND_EQ, r_ret, 0, b_imm(i + 1, ctx),
-				   ctx);
-			/* Load return register on DS for failures */
-			emit_reg_move(r_ret, r_zero, ctx);
-			/* Return with error */
-			emit_b(b_imm(prog->len, ctx), ctx);
-			emit_nop(ctx);
-			break;
-		case BPF_LD | BPF_W | BPF_IND:
-			/* A <- P[X + k:4] */
-			sk_load_func =3D sk_load_word;
-			goto load_ind;
-		case BPF_LD | BPF_H | BPF_IND:
-			/* A <- P[X + k:2] */
-			sk_load_func =3D sk_load_half;
-			goto load_ind;
-		case BPF_LD | BPF_B | BPF_IND:
-			/* A <- P[X + k:1] */
-			sk_load_func =3D sk_load_byte;
-load_ind:
-			ctx->flags |=3D SEEN_OFF | SEEN_X;
-			emit_addiu(r_off, r_X, k, ctx);
-			goto load_common;
-		case BPF_LDX | BPF_IMM:
-			/* X <- k */
-			ctx->flags |=3D SEEN_X;
-			emit_load_imm(r_X, k, ctx);
-			break;
-		case BPF_LDX | BPF_MEM:
-			/* X <- M[k] */
-			ctx->flags |=3D SEEN_X | SEEN_MEM;
-			emit_load(r_X, r_M, SCRATCH_OFF(k), ctx);
-			break;
-		case BPF_LDX | BPF_W | BPF_LEN:
-			/* X <- len */
-			ctx->flags |=3D SEEN_X | SEEN_SKB;
-			off =3D offsetof(struct sk_buff, len);
-			emit_load(r_X, r_skb, off, ctx);
-			break;
-		case BPF_LDX | BPF_B | BPF_MSH:
-			/* X <- 4 * (P[k:1] & 0xf) */
-			ctx->flags |=3D SEEN_X | SEEN_CALL | SEEN_SKB;
-			/* Load offset to a1 */
-			emit_load_func(r_s0, (ptr)sk_load_byte, ctx);
-			/*
-			 * This may emit two instructions so it may not fit
-			 * in the delay slot. So use a0 in the delay slot.
-			 */
-			emit_load_imm(MIPS_R_A1, k, ctx);
-			emit_jalr(MIPS_R_RA, r_s0, ctx);
-			emit_reg_move(MIPS_R_A0, r_skb, ctx); /* delay slot */
-			/* Check the error value */
-			emit_bcond(MIPS_COND_NE, r_ret, 0,
-				   b_imm(prog->len, ctx), ctx);
-			emit_reg_move(r_ret, r_zero, ctx);
-			/* We are good */
-			/* X <- P[1:K] & 0xf */
-			emit_andi(r_X, r_A, 0xf, ctx);
-			/* X << 2 */
-			emit_b(b_imm(i + 1, ctx), ctx);
-			emit_sll(r_X, r_X, 2, ctx); /* delay slot */
-			break;
-		case BPF_ST:
-			/* M[k] <- A */
-			ctx->flags |=3D SEEN_MEM | SEEN_A;
-			emit_store(r_A, r_M, SCRATCH_OFF(k), ctx);
-			break;
-		case BPF_STX:
-			/* M[k] <- X */
-			ctx->flags |=3D SEEN_MEM | SEEN_X;
-			emit_store(r_X, r_M, SCRATCH_OFF(k), ctx);
-			break;
-		case BPF_ALU | BPF_ADD | BPF_K:
-			/* A +=3D K */
-			ctx->flags |=3D SEEN_A;
-			emit_addiu(r_A, r_A, k, ctx);
-			break;
-		case BPF_ALU | BPF_ADD | BPF_X:
-			/* A +=3D X */
-			ctx->flags |=3D SEEN_A | SEEN_X;
-			emit_addu(r_A, r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_SUB | BPF_K:
-			/* A -=3D K */
-			ctx->flags |=3D SEEN_A;
-			emit_addiu(r_A, r_A, -k, ctx);
-			break;
-		case BPF_ALU | BPF_SUB | BPF_X:
-			/* A -=3D X */
-			ctx->flags |=3D SEEN_A | SEEN_X;
-			emit_subu(r_A, r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_MUL | BPF_K:
-			/* A *=3D K */
-			/* Load K to scratch register before MUL */
-			ctx->flags |=3D SEEN_A;
-			emit_load_imm(r_s0, k, ctx);
-			emit_mul(r_A, r_A, r_s0, ctx);
-			break;
-		case BPF_ALU | BPF_MUL | BPF_X:
-			/* A *=3D X */
-			ctx->flags |=3D SEEN_A | SEEN_X;
-			emit_mul(r_A, r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_DIV | BPF_K:
-			/* A /=3D k */
-			if (k =3D=3D 1)
-				break;
-			if (optimize_div(&k)) {
-				ctx->flags |=3D SEEN_A;
-				emit_srl(r_A, r_A, k, ctx);
-				break;
-			}
-			ctx->flags |=3D SEEN_A;
-			emit_load_imm(r_s0, k, ctx);
-			emit_div(r_A, r_s0, ctx);
-			break;
-		case BPF_ALU | BPF_MOD | BPF_K:
-			/* A %=3D k */
-			if (k =3D=3D 1) {
-				ctx->flags |=3D SEEN_A;
-				emit_jit_reg_move(r_A, r_zero, ctx);
-			} else {
-				ctx->flags |=3D SEEN_A;
-				emit_load_imm(r_s0, k, ctx);
-				emit_mod(r_A, r_s0, ctx);
-			}
-			break;
-		case BPF_ALU | BPF_DIV | BPF_X:
-			/* A /=3D X */
-			ctx->flags |=3D SEEN_X | SEEN_A;
-			/* Check if r_X is zero */
-			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
-				   b_imm(prog->len, ctx), ctx);
-			emit_load_imm(r_ret, 0, ctx); /* delay slot */
-			emit_div(r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_MOD | BPF_X:
-			/* A %=3D X */
-			ctx->flags |=3D SEEN_X | SEEN_A;
-			/* Check if r_X is zero */
-			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
-				   b_imm(prog->len, ctx), ctx);
-			emit_load_imm(r_ret, 0, ctx); /* delay slot */
-			emit_mod(r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_OR | BPF_K:
-			/* A |=3D K */
-			ctx->flags |=3D SEEN_A;
-			emit_ori(r_A, r_A, k, ctx);
-			break;
-		case BPF_ALU | BPF_OR | BPF_X:
-			/* A |=3D X */
-			ctx->flags |=3D SEEN_A;
-			emit_ori(r_A, r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_XOR | BPF_K:
-			/* A ^=3D k */
-			ctx->flags |=3D SEEN_A;
-			emit_xori(r_A, r_A, k, ctx);
-			break;
-		case BPF_ANC | SKF_AD_ALU_XOR_X:
-		case BPF_ALU | BPF_XOR | BPF_X:
-			/* A ^=3D X */
-			ctx->flags |=3D SEEN_A;
-			emit_xor(r_A, r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_AND | BPF_K:
-			/* A &=3D K */
-			ctx->flags |=3D SEEN_A;
-			emit_andi(r_A, r_A, k, ctx);
-			break;
-		case BPF_ALU | BPF_AND | BPF_X:
-			/* A &=3D X */
-			ctx->flags |=3D SEEN_A | SEEN_X;
-			emit_and(r_A, r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_LSH | BPF_K:
-			/* A <<=3D K */
-			ctx->flags |=3D SEEN_A;
-			emit_sll(r_A, r_A, k, ctx);
-			break;
-		case BPF_ALU | BPF_LSH | BPF_X:
-			/* A <<=3D X */
-			ctx->flags |=3D SEEN_A | SEEN_X;
-			emit_sllv(r_A, r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_RSH | BPF_K:
-			/* A >>=3D K */
-			ctx->flags |=3D SEEN_A;
-			emit_srl(r_A, r_A, k, ctx);
-			break;
-		case BPF_ALU | BPF_RSH | BPF_X:
-			ctx->flags |=3D SEEN_A | SEEN_X;
-			emit_srlv(r_A, r_A, r_X, ctx);
-			break;
-		case BPF_ALU | BPF_NEG:
-			/* A =3D -A */
-			ctx->flags |=3D SEEN_A;
-			emit_neg(r_A, ctx);
-			break;
-		case BPF_JMP | BPF_JA:
-			/* pc +=3D K */
-			emit_b(b_imm(i + k + 1, ctx), ctx);
-			emit_nop(ctx);
-			break;
-		case BPF_JMP | BPF_JEQ | BPF_K:
-			/* pc +=3D ( A =3D=3D K ) ? pc->jt : pc->jf */
-			condt =3D MIPS_COND_EQ | MIPS_COND_K;
-			goto jmp_cmp;
-		case BPF_JMP | BPF_JEQ | BPF_X:
-			ctx->flags |=3D SEEN_X;
-			/* pc +=3D ( A =3D=3D X ) ? pc->jt : pc->jf */
-			condt =3D MIPS_COND_EQ | MIPS_COND_X;
-			goto jmp_cmp;
-		case BPF_JMP | BPF_JGE | BPF_K:
-			/* pc +=3D ( A >=3D K ) ? pc->jt : pc->jf */
-			condt =3D MIPS_COND_GE | MIPS_COND_K;
-			goto jmp_cmp;
-		case BPF_JMP | BPF_JGE | BPF_X:
-			ctx->flags |=3D SEEN_X;
-			/* pc +=3D ( A >=3D X ) ? pc->jt : pc->jf */
-			condt =3D MIPS_COND_GE | MIPS_COND_X;
-			goto jmp_cmp;
-		case BPF_JMP | BPF_JGT | BPF_K:
-			/* pc +=3D ( A > K ) ? pc->jt : pc->jf */
-			condt =3D MIPS_COND_GT | MIPS_COND_K;
-			goto jmp_cmp;
-		case BPF_JMP | BPF_JGT | BPF_X:
-			ctx->flags |=3D SEEN_X;
-			/* pc +=3D ( A > X ) ? pc->jt : pc->jf */
-			condt =3D MIPS_COND_GT | MIPS_COND_X;
-jmp_cmp:
-			/* Greater or Equal */
-			if ((condt & MIPS_COND_GE) ||
-			    (condt & MIPS_COND_GT)) {
-				if (condt & MIPS_COND_K) { /* K */
-					ctx->flags |=3D SEEN_A;
-					emit_sltiu(r_s0, r_A, k, ctx);
-				} else { /* X */
-					ctx->flags |=3D SEEN_A |
-						SEEN_X;
-					emit_sltu(r_s0, r_A, r_X, ctx);
-				}
-				/* A < (K|X) ? r_scrach =3D 1 */
-				b_off =3D b_imm(i + inst->jf + 1, ctx);
-				emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off,
-					   ctx);
-				emit_nop(ctx);
-				/* A > (K|X) ? scratch =3D 0 */
-				if (condt & MIPS_COND_GT) {
-					/* Checking for equality */
-					ctx->flags |=3D SEEN_A | SEEN_X;
-					if (condt & MIPS_COND_K)
-						emit_load_imm(r_s0, k, ctx);
-					else
-						emit_jit_reg_move(r_s0, r_X,
-								  ctx);
-					b_off =3D b_imm(i + inst->jf + 1, ctx);
-					emit_bcond(MIPS_COND_EQ, r_A, r_s0,
-						   b_off, ctx);
-					emit_nop(ctx);
-					/* Finally, A > K|X */
-					b_off =3D b_imm(i + inst->jt + 1, ctx);
-					emit_b(b_off, ctx);
-					emit_nop(ctx);
-				} else {
-					/* A >=3D (K|X) so jump */
-					b_off =3D b_imm(i + inst->jt + 1, ctx);
-					emit_b(b_off, ctx);
-					emit_nop(ctx);
-				}
-			} else {
-				/* A =3D=3D K|X */
-				if (condt & MIPS_COND_K) { /* K */
-					ctx->flags |=3D SEEN_A;
-					emit_load_imm(r_s0, k, ctx);
-					/* jump true */
-					b_off =3D b_imm(i + inst->jt + 1, ctx);
-					emit_bcond(MIPS_COND_EQ, r_A, r_s0,
-						   b_off, ctx);
-					emit_nop(ctx);
-					/* jump false */
-					b_off =3D b_imm(i + inst->jf + 1,
-						      ctx);
-					emit_bcond(MIPS_COND_NE, r_A, r_s0,
-						   b_off, ctx);
-					emit_nop(ctx);
-				} else { /* X */
-					/* jump true */
-					ctx->flags |=3D SEEN_A | SEEN_X;
-					b_off =3D b_imm(i + inst->jt + 1,
-						      ctx);
-					emit_bcond(MIPS_COND_EQ, r_A, r_X,
-						   b_off, ctx);
-					emit_nop(ctx);
-					/* jump false */
-					b_off =3D b_imm(i + inst->jf + 1, ctx);
-					emit_bcond(MIPS_COND_NE, r_A, r_X,
-						   b_off, ctx);
-					emit_nop(ctx);
-				}
-			}
-			break;
-		case BPF_JMP | BPF_JSET | BPF_K:
-			ctx->flags |=3D SEEN_A;
-			/* pc +=3D (A & K) ? pc -> jt : pc -> jf */
-			emit_load_imm(r_s1, k, ctx);
-			emit_and(r_s0, r_A, r_s1, ctx);
-			/* jump true */
-			b_off =3D b_imm(i + inst->jt + 1, ctx);
-			emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off, ctx);
-			emit_nop(ctx);
-			/* jump false */
-			b_off =3D b_imm(i + inst->jf + 1, ctx);
-			emit_b(b_off, ctx);
-			emit_nop(ctx);
-			break;
-		case BPF_JMP | BPF_JSET | BPF_X:
-			ctx->flags |=3D SEEN_X | SEEN_A;
-			/* pc +=3D (A & X) ? pc -> jt : pc -> jf */
-			emit_and(r_s0, r_A, r_X, ctx);
-			/* jump true */
-			b_off =3D b_imm(i + inst->jt + 1, ctx);
-			emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off, ctx);
-			emit_nop(ctx);
-			/* jump false */
-			b_off =3D b_imm(i + inst->jf + 1, ctx);
-			emit_b(b_off, ctx);
-			emit_nop(ctx);
-			break;
-		case BPF_RET | BPF_A:
-			ctx->flags |=3D SEEN_A;
-			if (i !=3D prog->len - 1)
-				/*
-				 * If this is not the last instruction
-				 * then jump to the epilogue
-				 */
-				emit_b(b_imm(prog->len, ctx), ctx);
-			emit_reg_move(r_ret, r_A, ctx); /* delay slot */
-			break;
-		case BPF_RET | BPF_K:
-			/*
-			 * It can emit two instructions so it does not fit on
-			 * the delay slot.
-			 */
-			emit_load_imm(r_ret, k, ctx);
-			if (i !=3D prog->len - 1) {
-				/*
-				 * If this is not the last instruction
-				 * then jump to the epilogue
-				 */
-				emit_b(b_imm(prog->len, ctx), ctx);
-				emit_nop(ctx);
-			}
-			break;
-		case BPF_MISC | BPF_TAX:
-			/* X =3D A */
-			ctx->flags |=3D SEEN_X | SEEN_A;
-			emit_jit_reg_move(r_X, r_A, ctx);
-			break;
-		case BPF_MISC | BPF_TXA:
-			/* A =3D X */
-			ctx->flags |=3D SEEN_A | SEEN_X;
-			emit_jit_reg_move(r_A, r_X, ctx);
-			break;
-		/* AUX */
-		case BPF_ANC | SKF_AD_PROTOCOL:
-			/* A =3D ntohs(skb->protocol */
-			ctx->flags |=3D SEEN_SKB | SEEN_OFF | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-						  protocol) !=3D 2);
-			off =3D offsetof(struct sk_buff, protocol);
-			emit_half_load(r_A, r_skb, off, ctx);
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-			/* This needs little endian fixup */
-			if (cpu_has_wsbh) {
-				/* R2 and later have the wsbh instruction */
-				emit_wsbh(r_A, r_A, ctx);
-			} else {
-				/* Get first byte */
-				emit_andi(r_tmp_imm, r_A, 0xff, ctx);
-				/* Shift it */
-				emit_sll(r_tmp, r_tmp_imm, 8, ctx);
-				/* Get second byte */
-				emit_srl(r_tmp_imm, r_A, 8, ctx);
-				emit_andi(r_tmp_imm, r_tmp_imm, 0xff, ctx);
-				/* Put everyting together in r_A */
-				emit_or(r_A, r_tmp, r_tmp_imm, ctx);
-			}
-#endif
-			break;
-		case BPF_ANC | SKF_AD_CPU:
-			ctx->flags |=3D SEEN_A | SEEN_OFF;
-			/* A =3D current_thread_info()->cpu */
-			BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info,
-						  cpu) !=3D 4);
-			off =3D offsetof(struct thread_info, cpu);
-			/* $28/gp points to the thread_info struct */
-			emit_load(r_A, 28, off, ctx);
-			break;
-		case BPF_ANC | SKF_AD_IFINDEX:
-			/* A =3D skb->dev->ifindex */
-		case BPF_ANC | SKF_AD_HATYPE:
-			/* A =3D skb->dev->type */
-			ctx->flags |=3D SEEN_SKB | SEEN_A;
-			off =3D offsetof(struct sk_buff, dev);
-			/* Load *dev pointer */
-			emit_load_ptr(r_s0, r_skb, off, ctx);
-			/* error (0) in the delay slot */
-			emit_bcond(MIPS_COND_EQ, r_s0, r_zero,
-				   b_imm(prog->len, ctx), ctx);
-			emit_reg_move(r_ret, r_zero, ctx);
-			if (code =3D=3D (BPF_ANC | SKF_AD_IFINDEX)) {
-				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, ifindex) !=3D 4);
-				off =3D offsetof(struct net_device, ifindex);
-				emit_load(r_A, r_s0, off, ctx);
-			} else { /* (code =3D=3D (BPF_ANC | SKF_AD_HATYPE) */
-				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, type) !=3D 2);
-				off =3D offsetof(struct net_device, type);
-				emit_half_load_unsigned(r_A, r_s0, off, ctx);
-			}
-			break;
-		case BPF_ANC | SKF_AD_MARK:
-			ctx->flags |=3D SEEN_SKB | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, mark) !=3D 4);
-			off =3D offsetof(struct sk_buff, mark);
-			emit_load(r_A, r_skb, off, ctx);
-			break;
-		case BPF_ANC | SKF_AD_RXHASH:
-			ctx->flags |=3D SEEN_SKB | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, hash) !=3D 4);
-			off =3D offsetof(struct sk_buff, hash);
-			emit_load(r_A, r_skb, off, ctx);
-			break;
-		case BPF_ANC | SKF_AD_VLAN_TAG:
-			ctx->flags |=3D SEEN_SKB | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-						  vlan_tci) !=3D 2);
-			off =3D offsetof(struct sk_buff, vlan_tci);
-			emit_half_load_unsigned(r_A, r_skb, off, ctx);
-			break;
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
-			ctx->flags |=3D SEEN_SKB | SEEN_A;
-			emit_load_byte(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET(), ctx);
-			if (PKT_VLAN_PRESENT_BIT)
-				emit_srl(r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
-			if (PKT_VLAN_PRESENT_BIT < 7)
-				emit_andi(r_A, r_A, 1, ctx);
-			break;
-		case BPF_ANC | SKF_AD_PKTTYPE:
-			ctx->flags |=3D SEEN_SKB;
-
-			emit_load_byte(r_tmp, r_skb, PKT_TYPE_OFFSET(), ctx);
-			/* Keep only the last 3 bits */
-			emit_andi(r_A, r_tmp, PKT_TYPE_MAX, ctx);
-#ifdef __BIG_ENDIAN_BITFIELD
-			/* Get the actual packet type to the lower 3 bits */
-			emit_srl(r_A, r_A, 5, ctx);
-#endif
-			break;
-		case BPF_ANC | SKF_AD_QUEUE:
-			ctx->flags |=3D SEEN_SKB | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-						  queue_mapping) !=3D 2);
-			BUILD_BUG_ON(offsetof(struct sk_buff,
-					      queue_mapping) > 0xff);
-			off =3D offsetof(struct sk_buff, queue_mapping);
-			emit_half_load_unsigned(r_A, r_skb, off, ctx);
-			break;
-		default:
-			pr_debug("%s: Unhandled opcode: 0x%02x\n", __FILE__,
-				 inst->code);
-			return -1;
-		}
-	}
-
-	/* compute offsets only during the first pass */
-	if (ctx->target =3D=3D NULL)
-		ctx->offsets[i] =3D ctx->idx * 4;
-
-	return 0;
-}
-
-void bpf_jit_compile(struct bpf_prog *fp)
-{
-	struct jit_ctx ctx;
-	unsigned int alloc_size, tmp_idx;
-
-	if (!bpf_jit_enable)
-		return;
-
-	memset(&ctx, 0, sizeof(ctx));
-
-	ctx.offsets =3D kcalloc(fp->len + 1, sizeof(*ctx.offsets), GFP_KERNEL);
-	if (ctx.offsets =3D=3D NULL)
-		return;
-
-	ctx.skf =3D fp;
-
-	if (build_body(&ctx))
-		goto out;
-
-	tmp_idx =3D ctx.idx;
-	build_prologue(&ctx);
-	ctx.prologue_bytes =3D (ctx.idx - tmp_idx) * 4;
-	/* just to complete the ctx.idx count */
-	build_epilogue(&ctx);
-
-	alloc_size =3D 4 * ctx.idx;
-	ctx.target =3D module_alloc(alloc_size);
-	if (ctx.target =3D=3D NULL)
-		goto out;
-
-	/* Clean it */
-	memset(ctx.target, 0, alloc_size);
-
-	ctx.idx =3D 0;
-
-	/* Generate the actual JIT code */
-	build_prologue(&ctx);
-	build_body(&ctx);
-	build_epilogue(&ctx);
-
-	/* Update the icache */
-	flush_icache_range((ptr)ctx.target, (ptr)(ctx.target + ctx.idx));
-
-	if (bpf_jit_enable > 1)
-		/* Dump JIT code */
-		bpf_jit_dump(fp->len, alloc_size, 2, ctx.target);
-
-	fp->bpf_func =3D (void *)ctx.target;
-	fp->jited =3D 1;
-
-out:
-	kfree(ctx.offsets);
-}
-
-void bpf_jit_free(struct bpf_prog *fp)
-{
-	if (fp->jited)
-		module_memfree(fp->bpf_func);
-
-	bpf_prog_unlock_free(fp);
-}
diff --git a/arch/mips/net/bpf_jit_asm.S b/arch/mips/net/bpf_jit_asm.S
deleted file mode 100644
index 57154c5883b6..000000000000
--- a/arch/mips/net/bpf_jit_asm.S
+++ /dev/null
@@ -1,285 +0,0 @@
-/*
- * bpf_jib_asm.S: Packet/header access helper functions for MIPS/MIPS64 BP=
F
- * compiler.
- *
- * Copyright (C) 2015 Imagination Technologies Ltd.
- * Author: Markos Chandras <markos.chandras@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2 of the License.
- */
-
-#include <asm/asm.h>
-#include <asm/isa-rev.h>
-#include <asm/regdef.h>
-#include "bpf_jit.h"
-
-/* ABI
- *
- * r_skb_hl	skb header length
- * r_skb_data	skb data
- * r_off(a1)	offset register
- * r_A		BPF register A
- * r_X		PF register X
- * r_skb(a0)	*skb
- * r_M		*scratch memory
- * r_skb_le	skb length
- * r_s0		Scratch register 0
- * r_s1		Scratch register 1
- *
- * On entry:
- * a0: *skb
- * a1: offset (imm or imm + X)
- *
- * All non-BPF-ABI registers are free for use. On return, we only
- * care about r_ret. The BPF-ABI registers are assumed to remain
- * unmodified during the entire filter operation.
- */
-
-#define skb	a0
-#define offset	a1
-#define SKF_LL_OFF  (-0x200000) /* Can't include linux/filter.h in assembl=
y */
-
-	/* We know better :) so prevent assembler reordering etc */
-	.set 	noreorder
-
-#define is_offset_negative(TYPE)				\
-	/* If offset is negative we have more work to do */	\
-	slti	t0, offset, 0;					\
-	bgtz	t0, bpf_slow_path_##TYPE##_neg;			\
-	/* Be careful what follows in DS. */
-
-#define is_offset_in_header(SIZE, TYPE)				\
-	/* Reading from header? */				\
-	addiu	$r_s0, $r_skb_hl, -SIZE;			\
-	slt	t0, $r_s0, offset;				\
-	bgtz	t0, bpf_slow_path_##TYPE;			\
-
-LEAF(sk_load_word)
-	is_offset_negative(word)
-FEXPORT(sk_load_word_positive)
-	is_offset_in_header(4, word)
-	/* Offset within header boundaries */
-	PTR_ADDU t1, $r_skb_data, offset
-	.set	reorder
-	lw	$r_A, 0(t1)
-	.set	noreorder
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-# if MIPS_ISA_REV >=3D 2
-	wsbh	t0, $r_A
-	rotr	$r_A, t0, 16
-# else
-	sll	t0, $r_A, 24
-	srl	t1, $r_A, 24
-	srl	t2, $r_A, 8
-	or	t0, t0, t1
-	andi	t2, t2, 0xff00
-	andi	t1, $r_A, 0xff00
-	or	t0, t0, t2
-	sll	t1, t1, 8
-	or	$r_A, t0, t1
-# endif
-#endif
-	jr	$r_ra
-	 move	$r_ret, zero
-	END(sk_load_word)
-
-LEAF(sk_load_half)
-	is_offset_negative(half)
-FEXPORT(sk_load_half_positive)
-	is_offset_in_header(2, half)
-	/* Offset within header boundaries */
-	PTR_ADDU t1, $r_skb_data, offset
-	lhu	$r_A, 0(t1)
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-# if MIPS_ISA_REV >=3D 2
-	wsbh	$r_A, $r_A
-# else
-	sll	t0, $r_A, 8
-	srl	t1, $r_A, 8
-	andi	t0, t0, 0xff00
-	or	$r_A, t0, t1
-# endif
-#endif
-	jr	$r_ra
-	 move	$r_ret, zero
-	END(sk_load_half)
-
-LEAF(sk_load_byte)
-	is_offset_negative(byte)
-FEXPORT(sk_load_byte_positive)
-	is_offset_in_header(1, byte)
-	/* Offset within header boundaries */
-	PTR_ADDU t1, $r_skb_data, offset
-	lbu	$r_A, 0(t1)
-	jr	$r_ra
-	 move	$r_ret, zero
-	END(sk_load_byte)
-
-/*
- * call skb_copy_bits:
- * (prototype in linux/skbuff.h)
- *
- * int skb_copy_bits(sk_buff *skb, int offset, void *to, int len)
- *
- * o32 mandates we leave 4 spaces for argument registers in case
- * the callee needs to use them. Even though we don't care about
- * the argument registers ourselves, we need to allocate that space
- * to remain ABI compliant since the callee may want to use that space.
- * We also allocate 2 more spaces for $r_ra and our return register (*to).
- *
- * n64 is a bit different. The *caller* will allocate the space to preserv=
e
- * the arguments. So in 64-bit kernels, we allocate the 4-arg space for no
- * good reason but it does not matter that much really.
- *
- * (void *to) is returned in r_s0
- *
- */
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-#define DS_OFFSET(SIZE) (4 * SZREG)
-#else
-#define DS_OFFSET(SIZE) ((4 * SZREG) + (4 - SIZE))
-#endif
-#define bpf_slow_path_common(SIZE)				\
-	/* Quick check. Are we within reasonable boundaries? */ \
-	LONG_ADDIU	$r_s1, $r_skb_len, -SIZE;		\
-	sltu		$r_s0, offset, $r_s1;			\
-	beqz		$r_s0, fault;				\
-	/* Load 4th argument in DS */				\
-	 LONG_ADDIU	a3, zero, SIZE;				\
-	PTR_ADDIU	$r_sp, $r_sp, -(6 * SZREG);		\
-	PTR_LA		t0, skb_copy_bits;			\
-	PTR_S		$r_ra, (5 * SZREG)($r_sp);		\
-	/* Assign low slot to a2 */				\
-	PTR_ADDIU	a2, $r_sp, DS_OFFSET(SIZE);		\
-	jalr		t0;					\
-	/* Reset our destination slot (DS but it's ok) */	\
-	 INT_S		zero, (4 * SZREG)($r_sp);		\
-	/*							\
-	 * skb_copy_bits returns 0 on success and -EFAULT	\
-	 * on error. Our data live in a2. Do not bother with	\
-	 * our data if an error has been returned.		\
-	 */							\
-	/* Restore our frame */					\
-	PTR_L		$r_ra, (5 * SZREG)($r_sp);		\
-	INT_L		$r_s0, (4 * SZREG)($r_sp);		\
-	bltz		v0, fault;				\
-	 PTR_ADDIU	$r_sp, $r_sp, 6 * SZREG;		\
-	move		$r_ret, zero;				\
-
-NESTED(bpf_slow_path_word, (6 * SZREG), $r_sp)
-	bpf_slow_path_common(4)
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-# if MIPS_ISA_REV >=3D 2
-	wsbh	t0, $r_s0
-	jr	$r_ra
-	 rotr	$r_A, t0, 16
-# else
-	sll	t0, $r_s0, 24
-	srl	t1, $r_s0, 24
-	srl	t2, $r_s0, 8
-	or	t0, t0, t1
-	andi	t2, t2, 0xff00
-	andi	t1, $r_s0, 0xff00
-	or	t0, t0, t2
-	sll	t1, t1, 8
-	jr	$r_ra
-	 or	$r_A, t0, t1
-# endif
-#else
-	jr	$r_ra
-	 move	$r_A, $r_s0
-#endif
-
-	END(bpf_slow_path_word)
-
-NESTED(bpf_slow_path_half, (6 * SZREG), $r_sp)
-	bpf_slow_path_common(2)
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-# if MIPS_ISA_REV >=3D 2
-	jr	$r_ra
-	 wsbh	$r_A, $r_s0
-# else
-	sll	t0, $r_s0, 8
-	andi	t1, $r_s0, 0xff00
-	andi	t0, t0, 0xff00
-	srl	t1, t1, 8
-	jr	$r_ra
-	 or	$r_A, t0, t1
-# endif
-#else
-	jr	$r_ra
-	 move	$r_A, $r_s0
-#endif
-
-	END(bpf_slow_path_half)
-
-NESTED(bpf_slow_path_byte, (6 * SZREG), $r_sp)
-	bpf_slow_path_common(1)
-	jr	$r_ra
-	 move	$r_A, $r_s0
-
-	END(bpf_slow_path_byte)
-
-/*
- * Negative entry points
- */
-	.macro bpf_is_end_of_data
-	li	t0, SKF_LL_OFF
-	/* Reading link layer data? */
-	slt	t1, offset, t0
-	bgtz	t1, fault
-	/* Be careful what follows in DS. */
-	.endm
-/*
- * call skb_copy_bits:
- * (prototype in linux/filter.h)
- *
- * void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
- *                                            int k, unsigned int size)
- *
- * see above (bpf_slow_path_common) for ABI restrictions
- */
-#define bpf_negative_common(SIZE)					\
-	PTR_ADDIU	$r_sp, $r_sp, -(6 * SZREG);			\
-	PTR_LA		t0, bpf_internal_load_pointer_neg_helper;	\
-	PTR_S		$r_ra, (5 * SZREG)($r_sp);			\
-	jalr		t0;						\
-	 li		a2, SIZE;					\
-	PTR_L		$r_ra, (5 * SZREG)($r_sp);			\
-	/* Check return pointer */					\
-	beqz		v0, fault;					\
-	 PTR_ADDIU	$r_sp, $r_sp, 6 * SZREG;			\
-	/* Preserve our pointer */					\
-	move		$r_s0, v0;					\
-	/* Set return value */						\
-	move		$r_ret, zero;					\
-
-bpf_slow_path_word_neg:
-	bpf_is_end_of_data
-NESTED(sk_load_word_negative, (6 * SZREG), $r_sp)
-	bpf_negative_common(4)
-	jr	$r_ra
-	 lw	$r_A, 0($r_s0)
-	END(sk_load_word_negative)
-
-bpf_slow_path_half_neg:
-	bpf_is_end_of_data
-NESTED(sk_load_half_negative, (6 * SZREG), $r_sp)
-	bpf_negative_common(2)
-	jr	$r_ra
-	 lhu	$r_A, 0($r_s0)
-	END(sk_load_half_negative)
-
-bpf_slow_path_byte_neg:
-	bpf_is_end_of_data
-NESTED(sk_load_byte_negative, (6 * SZREG), $r_sp)
-	bpf_negative_common(1)
-	jr	$r_ra
-	 lbu	$r_A, 0($r_s0)
-	END(sk_load_byte_negative)
-
-fault:
-	jr	$r_ra
-	 addiu $r_ret, zero, 1
diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 26eef9ad3896..3548a69c82f7 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -126,15 +126,21 @@ static enum reg_val_type get_reg_val_type(const struc=
t jit_ctx *ctx,
 }
=20
 /* Simply emit the instruction if the JIT memory space has been allocated =
*/
-#define emit_instr(ctx, func, ...)			\
-do {							\
-	if ((ctx)->target !=3D NULL) {			\
-		u32 *p =3D &(ctx)->target[ctx->idx];	\
-		uasm_i_##func(&p, ##__VA_ARGS__);	\
-	}						\
-	(ctx)->idx++;					\
+#define emit_instr_long(ctx, func64, func32, ...)		\
+do {								\
+	if ((ctx)->target !=3D NULL) {				\
+		u32 *p =3D &(ctx)->target[ctx->idx];		\
+		if (IS_ENABLED(CONFIG_64BIT))			\
+			uasm_i_##func64(&p, ##__VA_ARGS__);	\
+		else						\
+			uasm_i_##func32(&p, ##__VA_ARGS__);	\
+	}							\
+	(ctx)->idx++;						\
 } while (0)
=20
+#define emit_instr(ctx, func, ...)				\
+	emit_instr_long(ctx, func, func, ##__VA_ARGS__)
+
 static unsigned int j_target(struct jit_ctx *ctx, int target_idx)
 {
 	unsigned long target_va, base_va;
@@ -274,17 +280,17 @@ static int gen_int_prologue(struct jit_ctx *ctx)
 		 * If RA we are doing a function call and may need
 		 * extra 8-byte tmp area.
 		 */
-		stack_adjust +=3D 16;
+		stack_adjust +=3D 2 * sizeof(long);
 	if (ctx->flags & EBPF_SAVE_S0)
-		stack_adjust +=3D 8;
+		stack_adjust +=3D sizeof(long);
 	if (ctx->flags & EBPF_SAVE_S1)
-		stack_adjust +=3D 8;
+		stack_adjust +=3D sizeof(long);
 	if (ctx->flags & EBPF_SAVE_S2)
-		stack_adjust +=3D 8;
+		stack_adjust +=3D sizeof(long);
 	if (ctx->flags & EBPF_SAVE_S3)
-		stack_adjust +=3D 8;
+		stack_adjust +=3D sizeof(long);
 	if (ctx->flags & EBPF_SAVE_S4)
-		stack_adjust +=3D 8;
+		stack_adjust +=3D sizeof(long);
=20
 	BUILD_BUG_ON(MAX_BPF_STACK & 7);
 	locals_size =3D (ctx->flags & EBPF_SEEN_FP) ? MAX_BPF_STACK : 0;
@@ -298,41 +304,49 @@ static int gen_int_prologue(struct jit_ctx *ctx)
 	 * On tail call we skip this instruction, and the TCC is
 	 * passed in $v1 from the caller.
 	 */
-	emit_instr(ctx, daddiu, MIPS_R_V1, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
+	emit_instr(ctx, addiu, MIPS_R_V1, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
 	if (stack_adjust)
-		emit_instr(ctx, daddiu, MIPS_R_SP, MIPS_R_SP, -stack_adjust);
+		emit_instr_long(ctx, daddiu, addiu,
+					MIPS_R_SP, MIPS_R_SP, -stack_adjust);
 	else
 		return 0;
=20
-	store_offset =3D stack_adjust - 8;
+	store_offset =3D stack_adjust - sizeof(long);
=20
 	if (ctx->flags & EBPF_SAVE_RA) {
-		emit_instr(ctx, sd, MIPS_R_RA, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, sd, sw,
+					MIPS_R_RA, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S0) {
-		emit_instr(ctx, sd, MIPS_R_S0, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, sd, sw,
+					MIPS_R_S0, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S1) {
-		emit_instr(ctx, sd, MIPS_R_S1, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, sd, sw,
+					MIPS_R_S1, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S2) {
-		emit_instr(ctx, sd, MIPS_R_S2, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, sd, sw,
+					MIPS_R_S2, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S3) {
-		emit_instr(ctx, sd, MIPS_R_S3, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, sd, sw,
+					MIPS_R_S3, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S4) {
-		emit_instr(ctx, sd, MIPS_R_S4, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, sd, sw,
+					MIPS_R_S4, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
=20
 	if ((ctx->flags & EBPF_SEEN_TC) && !(ctx->flags & EBPF_TCC_IN_V1))
-		emit_instr(ctx, daddu, MIPS_R_S4, MIPS_R_V1, MIPS_R_ZERO);
+		emit_instr_long(ctx, daddu, addu,
+					MIPS_R_S4, MIPS_R_V1, MIPS_R_ZERO);
=20
 	return 0;
 }
@@ -341,7 +355,7 @@ static int build_int_epilogue(struct jit_ctx *ctx, int =
dest_reg)
 {
 	const struct bpf_prog *prog =3D ctx->skf;
 	int stack_adjust =3D ctx->stack_size;
-	int store_offset =3D stack_adjust - 8;
+	int store_offset =3D stack_adjust - sizeof(long);
 	enum reg_val_type td;
 	int r0 =3D MIPS_R_V0;
=20
@@ -353,33 +367,40 @@ static int build_int_epilogue(struct jit_ctx *ctx, in=
t dest_reg)
 	}
=20
 	if (ctx->flags & EBPF_SAVE_RA) {
-		emit_instr(ctx, ld, MIPS_R_RA, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, ld, lw,
+					MIPS_R_RA, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S0) {
-		emit_instr(ctx, ld, MIPS_R_S0, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, ld, lw,
+					MIPS_R_S0, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S1) {
-		emit_instr(ctx, ld, MIPS_R_S1, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, ld, lw,
+					MIPS_R_S1, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S2) {
-		emit_instr(ctx, ld, MIPS_R_S2, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, ld, lw,
+				MIPS_R_S2, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S3) {
-		emit_instr(ctx, ld, MIPS_R_S3, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, ld, lw,
+					MIPS_R_S3, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	if (ctx->flags & EBPF_SAVE_S4) {
-		emit_instr(ctx, ld, MIPS_R_S4, store_offset, MIPS_R_SP);
-		store_offset -=3D 8;
+		emit_instr_long(ctx, ld, lw,
+					MIPS_R_S4, store_offset, MIPS_R_SP);
+		store_offset -=3D sizeof(long);
 	}
 	emit_instr(ctx, jr, dest_reg);
=20
 	if (stack_adjust)
-		emit_instr(ctx, daddiu, MIPS_R_SP, MIPS_R_SP, stack_adjust);
+		emit_instr_long(ctx, daddiu, addiu,
+					MIPS_R_SP, MIPS_R_SP, stack_adjust);
 	else
 		emit_instr(ctx, nop);
=20
@@ -646,6 +667,10 @@ static int build_one_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx,
 	s64 t64s;
 	int bpf_op =3D BPF_OP(insn->code);
=20
+	if (IS_ENABLED(CONFIG_32BIT) && ((BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
+						|| (bpf_op =3D=3D BPF_DW)))
+		return -EINVAL;
+
 	switch (insn->code) {
 	case BPF_ALU64 | BPF_ADD | BPF_K: /* ALU64_IMM */
 	case BPF_ALU64 | BPF_SUB | BPF_K: /* ALU64_IMM */
@@ -1283,7 +1308,7 @@ static int build_one_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx,
=20
 	case BPF_JMP | BPF_CALL:
 		ctx->flags |=3D EBPF_SAVE_RA;
-		t64s =3D (s64)insn->imm + (s64)__bpf_call_base;
+		t64s =3D (s64)insn->imm + (long)__bpf_call_base;
 		emit_const_to_reg(ctx, MIPS_R_T9, (u64)t64s);
 		emit_instr(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
 		/* delay slot */
--=20
2.18.0

