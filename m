Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2933BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC972173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="dyLArUxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbfCLWsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:48:11 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:7968
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfCLWsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=px6azOeF5G5eDzNqDiu6bgy7p14pfhXsTre46cURaas=;
 b=dyLArUxsRGUqhW+FluWa+TRP/2GXXOYUotGBp3BRe/kFsXjlpc6CGpmUrr27SksTzts3fiYYZYXBU+O/188rqmxrlHFdAeujFpFASW1cPnyKjz+5isC5xPi6v9l5sPwlbeBxvkJrxo7rVk8x4lEu2jCmAafh+1d9FZ5icxeqlm8=
Received: from CY4PR2201MB1349.namprd22.prod.outlook.com (10.171.209.23) by
 CY4PR2201MB1720.namprd22.prod.outlook.com (10.165.90.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 22:48:06 +0000
Received: from CY4PR2201MB1349.namprd22.prod.outlook.com
 ([fe80::901a:e86:7fcf:8856]) by CY4PR2201MB1349.namprd22.prod.outlook.com
 ([fe80::901a:e86:7fcf:8856%3]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 22:48:06 +0000
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
Subject: [PATCH v2 2/3] MIPS: eBPF: Provide eBPF support for MIPS64R6
Thread-Topic: [PATCH v2 2/3] MIPS: eBPF: Provide eBPF support for MIPS64R6
Thread-Index: AQHU2SWozNoTqPTzRU+UcrV5QYZ6oQ==
Date:   Tue, 12 Mar 2019 22:48:06 +0000
Message-ID: <20190312224706.6121-2-hnaveed@wavecomp.com>
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
x-ms-office365-filtering-correlation-id: 9ed2f9bb-472b-443e-8833-08d6a73cca98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1720;
x-ms-traffictypediagnostic: CY4PR2201MB1720:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR2201MB1720;23:tbFXCCHDCxxE2vv3XlursSWBiwm8RT8nhPm4F?=
 =?iso-8859-1?Q?RDRHhx/cpjgwkOienyUDW/ZVtVxZaB1MwIMPebl08U9aw6HMS/yPmgxrmi?=
 =?iso-8859-1?Q?8cFpoGnI+uWHUAbEveLN6lpEkzZQJ6PqEaiZ1rJ6f0Vmc7xOZpOr4gaWDT?=
 =?iso-8859-1?Q?2TfHrfEU5YkRF4zocbzI8ddExLoaVbZXeNZb9PEHyW0fRvEjl8R1S3rJ74?=
 =?iso-8859-1?Q?Ata9ywFopZTALNazNY0qDRG0kRtnRtiJEEkh6FXjfGjsCaIk6jvnmuvRFJ?=
 =?iso-8859-1?Q?U82JixyiOrAmpy/qLHIFsGIkGjtsyuFPnX7eNM9S2/PAnUE4Dr/eV6GEnL?=
 =?iso-8859-1?Q?QD9EvmiyOL54iklQZnhLQdxQ1Kl8QEJ6V6o7yrks1KOo2rgwOeuqSs2I/R?=
 =?iso-8859-1?Q?DyOuyfDFjok06CfJ3cFNVJvjK9R5MHLQ06MpktBtiOqi9NmRfPxqrQVNnE?=
 =?iso-8859-1?Q?fBe119XenLKnREyzQVlwF+KIbjsfuZsPYmNfzkkIrOthGxVugVKeJwTsRN?=
 =?iso-8859-1?Q?CVxYyM5CJuB1C2wLGBZ5yzVtQfecQ70JSlN4c4EGd7mt/d+1N6vUcc4w1M?=
 =?iso-8859-1?Q?ZdY0yiHY5xVSOqtWDC0g3Cm+xqSsWzzqGrvMoTv6vVHb2d48VqxbwQJgbc?=
 =?iso-8859-1?Q?u5bp6woPF74/zCjCzdarCr7eo702hT0i22gNiD44CfS7JsRxO2csyaIN9D?=
 =?iso-8859-1?Q?pgm3RbwVWyQgrE+YjVJQSFumcELUGT/Ey+l6luHBa6v9olNLugHz8QhLzK?=
 =?iso-8859-1?Q?AWWOwl8xZIsTumLbVLitDrk43GqhZy1hlED13b2T3SpL51flKQ3uTBAHge?=
 =?iso-8859-1?Q?Mwmc1OdpueXcuGw+o/ZVklzqxUOxyRBGiwYHuxzXsadA3imE7H4YjS+I5I?=
 =?iso-8859-1?Q?NKPQLQlCw5BoG0/UBuX5eKu9FyrU/fSiILi/O4W78wtCrbaChfacyMuEDp?=
 =?iso-8859-1?Q?LfCe2MAiDFmQPRdmAmiokSI/PlNMwMwd1j+dveNf+qB/HbFmV9GEsKeAFK?=
 =?iso-8859-1?Q?9/5DCi4nVRx9CZgvZ9H2BpX0cRe6cWqdP7DsuKBS0Y93c1Juw3lH+FCZ2M?=
 =?iso-8859-1?Q?ZDKuK0Y7jMbgC5FCBj8cSJlTusGvoDA0T4JyejL1cWgNFz0YJ001SrFKzr?=
 =?iso-8859-1?Q?GyqD6PjzdF/Ljg2qiUvsdIhdK++s6XJuv9mWqDYOVs5k7BU7jcw0lMG3NO?=
 =?iso-8859-1?Q?fIVNr/OHPVS2K3Sy73SfuQSqKvpS4VuqDqaP9x3djx1NcgIWnk/aDZd6zL?=
 =?iso-8859-1?Q?c6uNSz6n0Fi/KYNXsOvtO6+jzDPVT+tGRxHlTOIkBlaMtqD4zzv/UKuivb?=
 =?iso-8859-1?Q?GYswhNQEuSI4VlbqJHQBirisc?=
x-microsoft-antispam-prvs: <CY4PR2201MB172089548DA3B39C06F696A5D4490@CY4PR2201MB1720.namprd22.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39840400004)(366004)(396003)(189003)(199004)(66066001)(105586002)(99286004)(26005)(2906002)(53936002)(3846002)(86362001)(6116002)(36756003)(14454004)(71190400001)(71200400001)(50226002)(476003)(7736002)(305945005)(68736007)(478600001)(7416002)(6506007)(386003)(186003)(6512007)(106356001)(6862004)(1076003)(97736004)(6486002)(5660300002)(25786009)(446003)(4326008)(2616005)(102836004)(8676002)(11346002)(37006003)(76176011)(316002)(81166006)(81156014)(6636002)(486006)(8936002)(52116002)(256004)(54906003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1720;H:CY4PR2201MB1349.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Wets5094GrFD1lhj1WmJPUboP8bjgoacgZTbU8i0HW3JTf3hdBmd4Nl+aGl3KvJKFl6kZ3Um6UErbn5OKfb1iBInX+uQ0cpUsF0AyK3xvetH4ZZp2cu1hgLCoG1702fMCoU13OjjhwqpYZKAkpu18zAhPINiZzw9n+bTa/tofbvnLrbqLQgC3LWzirezl51u5Tab2fei0jG1VBhfV7poL7f2CTtR6hFnVUqanzbB1cCW4otdXkXJzb9j5tBuDEsm2k6KkjwIkx8TLecTwif9E6XR/92NrUB8p7tfg8XvQaNXEWUd+AsmPpu4c0JEZOE3gfU2FeMADXioG5P1dJWXe2p+ms6rLkVfobHJl+gXk4vHxzYHXYMPR2QNCZQWECsBObHzCIXypovL9OWHuIABeHOC7btusDVbs6PkNiX1jI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed2f9bb-472b-443e-8833-08d6a73cca98
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 22:48:06.1096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently eBPF support is available on MIPS64R2 only. Use MIPS64R6
variants of instructions like multiply, divide, movn, movz so eBPF
can run on the newer ISA. Also, we only need to check ISA revision
before JIT'ing code, because we know the CPU is running a 64-bit
kernel because eBPF JIT is only included in kernels with CONFIG_64BIT=3Dy
due to Kconfig dependencies.

Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
---
 arch/mips/net/ebpf_jit.c | 78 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 0effd3cba9a7..26eef9ad3896 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -22,6 +22,7 @@
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu-features.h>
+#include <asm/isa-rev.h>
 #include <asm/uasm.h>
=20
 /* Registers used by JIT */
@@ -677,8 +678,12 @@ static int build_one_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx,
 		if (insn->imm =3D=3D 1) /* Mult by 1 is a nop */
 			break;
 		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
-		emit_instr(ctx, dmultu, MIPS_R_AT, dst);
-		emit_instr(ctx, mflo, dst);
+		if (MIPS_ISA_REV >=3D 6) {
+			emit_instr(ctx, dmulu, dst, dst, MIPS_R_AT);
+		} else {
+			emit_instr(ctx, dmultu, MIPS_R_AT, dst);
+			emit_instr(ctx, mflo, dst);
+		}
 		break;
 	case BPF_ALU64 | BPF_NEG | BPF_K: /* ALU64_IMM */
 		dst =3D ebpf_to_mips_reg(ctx, insn, dst_reg);
@@ -700,8 +705,12 @@ static int build_one_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx,
 		if (insn->imm =3D=3D 1) /* Mult by 1 is a nop */
 			break;
 		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
-		emit_instr(ctx, multu, dst, MIPS_R_AT);
-		emit_instr(ctx, mflo, dst);
+		if (MIPS_ISA_REV >=3D 6) {
+			emit_instr(ctx, mulu, dst, dst, MIPS_R_AT);
+		} else {
+			emit_instr(ctx, multu, dst, MIPS_R_AT);
+			emit_instr(ctx, mflo, dst);
+		}
 		break;
 	case BPF_ALU | BPF_NEG | BPF_K: /* ALU_IMM */
 		dst =3D ebpf_to_mips_reg(ctx, insn, dst_reg);
@@ -732,6 +741,13 @@ static int build_one_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx,
 			break;
 		}
 		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+		if (MIPS_ISA_REV >=3D 6) {
+			if (bpf_op =3D=3D BPF_DIV)
+				emit_instr(ctx, divu_r6, dst, dst, MIPS_R_AT);
+			else
+				emit_instr(ctx, modu, dst, dst, MIPS_R_AT);
+			break;
+		}
 		emit_instr(ctx, divu, dst, MIPS_R_AT);
 		if (bpf_op =3D=3D BPF_DIV)
 			emit_instr(ctx, mflo, dst);
@@ -754,6 +770,13 @@ static int build_one_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx,
 			break;
 		}
 		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+		if (MIPS_ISA_REV >=3D 6) {
+			if (bpf_op =3D=3D BPF_DIV)
+				emit_instr(ctx, ddivu_r6, dst, dst, MIPS_R_AT);
+			else
+				emit_instr(ctx, modu, dst, dst, MIPS_R_AT);
+			break;
+		}
 		emit_instr(ctx, ddivu, dst, MIPS_R_AT);
 		if (bpf_op =3D=3D BPF_DIV)
 			emit_instr(ctx, mflo, dst);
@@ -819,11 +842,23 @@ static int build_one_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx,
 			emit_instr(ctx, and, dst, dst, src);
 			break;
 		case BPF_MUL:
-			emit_instr(ctx, dmultu, dst, src);
-			emit_instr(ctx, mflo, dst);
+			if (MIPS_ISA_REV >=3D 6) {
+				emit_instr(ctx, dmulu, dst, dst, src);
+			} else {
+				emit_instr(ctx, dmultu, dst, src);
+				emit_instr(ctx, mflo, dst);
+			}
 			break;
 		case BPF_DIV:
 		case BPF_MOD:
+			if (MIPS_ISA_REV >=3D 6) {
+				if (bpf_op =3D=3D BPF_DIV)
+					emit_instr(ctx, ddivu_r6,
+							dst, dst, src);
+				else
+					emit_instr(ctx, modu, dst, dst, src);
+				break;
+			}
 			emit_instr(ctx, ddivu, dst, src);
 			if (bpf_op =3D=3D BPF_DIV)
 				emit_instr(ctx, mflo, dst);
@@ -903,6 +938,13 @@ static int build_one_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx,
 			break;
 		case BPF_DIV:
 		case BPF_MOD:
+			if (MIPS_ISA_REV >=3D 6) {
+				if (bpf_op =3D=3D BPF_DIV)
+					emit_instr(ctx, divu_r6, dst, dst, src);
+				else
+					emit_instr(ctx, modu, dst, dst, src);
+				break;
+			}
 			emit_instr(ctx, divu, dst, src);
 			if (bpf_op =3D=3D BPF_DIV)
 				emit_instr(ctx, mflo, dst);
@@ -1006,8 +1048,15 @@ static int build_one_insn(const struct bpf_insn *ins=
n, struct jit_ctx *ctx,
 			emit_instr(ctx, dsubu, MIPS_R_T8, dst, src);
 			emit_instr(ctx, sltu, MIPS_R_AT, dst, src);
 			/* SP known to be non-zero, movz becomes boolean not */
-			emit_instr(ctx, movz, MIPS_R_T9, MIPS_R_SP, MIPS_R_T8);
-			emit_instr(ctx, movn, MIPS_R_T9, MIPS_R_ZERO, MIPS_R_T8);
+			if (MIPS_ISA_REV >=3D 6) {
+				emit_instr(ctx, seleqz, MIPS_R_T9,
+						MIPS_R_SP, MIPS_R_T8);
+			} else {
+				emit_instr(ctx, movz, MIPS_R_T9,
+						MIPS_R_SP, MIPS_R_T8);
+				emit_instr(ctx, movn, MIPS_R_T9,
+						MIPS_R_ZERO, MIPS_R_T8);
+			}
 			emit_instr(ctx, or, MIPS_R_AT, MIPS_R_T9, MIPS_R_AT);
 			cmp_eq =3D bpf_op =3D=3D BPF_JGT;
 			dst =3D MIPS_R_AT;
@@ -1366,6 +1415,17 @@ static int build_one_insn(const struct bpf_insn *ins=
n, struct jit_ctx *ctx,
 		if (src < 0)
 			return src;
 		if (BPF_MODE(insn->code) =3D=3D BPF_XADD) {
+			/*
+			 * If mem_off does not fit within the 9 bit ll/sc
+			 * instruction immediate field, use a temp reg.
+			 */
+			if (MIPS_ISA_REV >=3D 6 &&
+			    (mem_off >=3D BIT(8) || mem_off < -BIT(8))) {
+				emit_instr(ctx, daddiu, MIPS_R_T6,
+						dst, mem_off);
+				mem_off =3D 0;
+				dst =3D MIPS_R_T6;
+			}
 			switch (BPF_SIZE(insn->code)) {
 			case BPF_W:
 				if (get_reg_val_type(ctx, this_idx, insn->src_reg) =3D=3D REG_32BIT) {
@@ -1720,7 +1780,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog =
*prog)
 	unsigned int image_size;
 	u8 *image_ptr;
=20
-	if (!prog->jit_requested || !cpu_has_mips64r2)
+	if (!prog->jit_requested || MIPS_ISA_REV < 2)
 		return prog;
=20
 	tmp =3D bpf_jit_blind_constants(prog);
--=20
2.18.0

