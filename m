Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B83C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812302177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qEqTzKoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCLWsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:48:05 -0400
Received: from mail-eopbgr710110.outbound.protection.outlook.com ([40.107.71.110]:15791
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfCLWsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaC39nyU4VQXEQdJG/aJJ6wroTL3ep8bl4h7w1+e3Ak=;
 b=qEqTzKoIl8oSTvlCaqJT2V5wX2Ki6mY0JSjHpDlfCR/E3yTrVrHpFSy4kRO3GD2g9liegWgjy0etMcGIkSfWZQwy4qW/jSNZDKMJUfxavVx7SczrULe2AJ2niNjyXSx2Nw5ULPIte4ryvwNC0g8Loy44P889pOh7fIyAsvYSlfE=
Received: from CY4PR2201MB1349.namprd22.prod.outlook.com (10.171.209.23) by
 CY4PR2201MB1720.namprd22.prod.outlook.com (10.165.90.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 22:47:57 +0000
Received: from CY4PR2201MB1349.namprd22.prod.outlook.com
 ([fe80::901a:e86:7fcf:8856]) by CY4PR2201MB1349.namprd22.prod.outlook.com
 ([fe80::901a:e86:7fcf:8856%3]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 22:47:57 +0000
From:   Hassan Naveed <hnaveed@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] MIPS: uasm: Add div, mul and sel instructions for
 mipsr6
Thread-Topic: [PATCH v2 1/3] MIPS: uasm: Add div, mul and sel instructions for
 mipsr6
Thread-Index: AQHU2SWi6IUcisfWHES08Ee4dq1ljw==
Date:   Tue, 12 Mar 2019 22:47:56 +0000
Message-ID: <20190312224706.6121-1-hnaveed@wavecomp.com>
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
x-ms-office365-filtering-correlation-id: 1e54b07c-4c6d-4785-9757-08d6a73cc4ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1720;
x-ms-traffictypediagnostic: CY4PR2201MB1720:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR2201MB1720;23:jm+FhB+QNxxRY9pkCPuHHuN4yPwVoW+2olMYW?=
 =?iso-8859-1?Q?SkHDu+mGjq1odyDFMP2JWS5/JMDWnrdgFEaIF1XTiKC3RcHMT3lFj4BsAf?=
 =?iso-8859-1?Q?4jak0zYqhesiVOi9qGMWr6i/ohpywnhNREtuhQW1QMWiVHFDtIF5LcDLOn?=
 =?iso-8859-1?Q?GNG8gi79lLa/ihWY1jEpRpCSw50LMj7o51DWu8XOJHOi/sPT0ijoyonD7h?=
 =?iso-8859-1?Q?BZhEdHKyK+qjISejz2Ybk1bxDLcTtf5i16PdsuaLWIJ1fJ77ugDeOX7I9v?=
 =?iso-8859-1?Q?n5q6HImb284xAb4SLCZTn4GwI7T3rE8IxFoyoPaj/Xtfv9JhhujrTzzdJ4?=
 =?iso-8859-1?Q?LSiZ1+w3RWtdkJlYOdybTmMtMUR2Mop1mTirBBGbXaFqe8HiLJwTY/unnQ?=
 =?iso-8859-1?Q?Pde7+T0ZWgPbPGgjv8rtgMrtKVyqMeVJnpnmokpy+JB8Si++Kj6KLe1tMw?=
 =?iso-8859-1?Q?MaRg5OwbJXIGXPI7A8YD0JMbYMRXy8rUTsMRdtP2iq3jmfTamw8uScTVBA?=
 =?iso-8859-1?Q?Z9SBpxMOoQWFSMZ9Fi6qUDV4Ke5/NTCArShqebAdmzVj4jn8Th5RIGS8CO?=
 =?iso-8859-1?Q?/14gf7RCHlb9BLq/jIxxUGGBON6QAxCsp5w9qtJwGSQEOub6UIbE1xmDSN?=
 =?iso-8859-1?Q?+IqdL1Q49l8jPWSkitVC5o/TEIt+SJGjvcWjTcI5vLILGAUOp7kIw2gwS9?=
 =?iso-8859-1?Q?h/UeTKjpuiXJ8BjYdzteEJdvJ0z5zxWj5bP1s/W27cg0e7W8JvrSZJAyZJ?=
 =?iso-8859-1?Q?ENkftcCOfKfA0k8zGgODzSOVAlWrC6/OJrVCSeU3BfjvYir9T+Yzcqd1uh?=
 =?iso-8859-1?Q?QYouONE5aF66RvB5A5ufu9RTVQLAxk3CdN+5n0se2iC3uapvjJ7zJLIFP3?=
 =?iso-8859-1?Q?pJ/izskGnkAqBNBPDNf8WDBXwN0EBUFktL8Pe4BgJnEYel7sJLQS6gkgr7?=
 =?iso-8859-1?Q?1nMQ2Gjs9Ak2U0YLnV3vB+mzVclVdIcNNb18P35MucUMHMkOgx6vFwG7n8?=
 =?iso-8859-1?Q?rYz3Bqmr7hIdYyxCidoWoFIlVtqLKRMHqhBiv0GlqpfsX1MjMx+h935NYM?=
 =?iso-8859-1?Q?vyLuDrSKSJNYP0e5RePu6STUUdl7XPaRZdALQHNEUmbgXtlqTUnS97gkaO?=
 =?iso-8859-1?Q?fNguOtgKEv47sUUt9givt3J1MyqztLqVbfyWdUYUX5spalk5lR+By8Aou8?=
 =?iso-8859-1?Q?AUlc+jAPUX7BDsemarFmoyrqSoUq34zS+6F4RuHcXMK5ZWYwjV2t9RRqy+?=
 =?iso-8859-1?Q?J8I4aFgQBTBBuUuOiGJ?=
x-microsoft-antispam-prvs: <CY4PR2201MB1720435822BAF1BD3592FA7BD4490@CY4PR2201MB1720.namprd22.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39840400004)(366004)(396003)(189003)(199004)(66066001)(105586002)(99286004)(26005)(2906002)(53936002)(3846002)(86362001)(6116002)(36756003)(14454004)(71190400001)(71200400001)(50226002)(476003)(7736002)(305945005)(68736007)(478600001)(7416002)(6506007)(386003)(186003)(6512007)(106356001)(6862004)(1076003)(97736004)(6486002)(5660300002)(25786009)(4326008)(2616005)(102836004)(8676002)(37006003)(316002)(81166006)(81156014)(6636002)(486006)(8936002)(52116002)(256004)(54906003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1720;H:CY4PR2201MB1349.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U5HX/ZKLK/1vSFaTkl75keHoDmsAaWaDtnUz794gwzXZzA4wg86vl6jfI3ZCVa9tH5NyAiYCy1n97hUPH0YLwemAMHRaVO2vi1TJH1UQfYIAma8bMd3FwULv/mp59CI/1x9976GX/Wb3FIrbifAx5000CnPa7cJ83pgLoca3yBQeb9shJ5nB/SA77yld3f88Sagbsuj2tUkgX0cqVifwCYEdQVv6/XW1+pShsnhwHEmQaunsTcYOtANSCIG67t7urZ/m8erRGW4gNiWiI9LqRx0rEWXGdihxxmRG7FKgQu4FGSFuHvnDSwTBwIGFeBr4AK+oZBvLntfOLRjr0g6voJxgTTN8/CQw+am/YTkC+8pz9Hieolzql8murz8q4Zpg6EGcbg3t4DqZi4ikQsWmRXjIxAV+A9Ed487Zmn1a84I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e54b07c-4c6d-4785-9757-08d6a73cc4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 22:47:56.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following instructions for use by eBPF on mipsr6:
insn_ddivu_r6, insn_divu_r6, insn_dmodu, insn_dmulu, insn_modu,
insn_mulu, insn_seleqz, insn_selnez

Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/include/asm/uasm.h      |  8 +++++++
 arch/mips/include/uapi/asm/inst.h |  6 ++---
 arch/mips/mm/uasm-mips.c          | 14 +++++++++++
 arch/mips/mm/uasm.c               | 39 +++++++++++++++++++------------
 4 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index b1990dd75f27..f7effca791a5 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -86,14 +86,18 @@ Ip_u2u1(_ctcmsa);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
 Ip_u1u2(_ddivu);
+Ip_u3u1u2(_ddivu_r6);
 Ip_u1(_di);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
 Ip_u2u1msbu3(_dinsu);
 Ip_u1u2(_divu);
+Ip_u3u1u2(_divu_r6);
 Ip_u1u2u3(_dmfc0);
+Ip_u3u1u2(_dmodu);
 Ip_u1u2u3(_dmtc0);
 Ip_u1u2(_dmultu);
+Ip_u3u1u2(_dmulu);
 Ip_u2u1u3(_drotr);
 Ip_u2u1u3(_drotr32);
 Ip_u2u1(_dsbh);
@@ -131,6 +135,7 @@ Ip_u1u2u3(_mfc0);
 Ip_u1u2u3(_mfhc0);
 Ip_u1(_mfhi);
 Ip_u1(_mflo);
+Ip_u3u1u2(_modu);
 Ip_u3u1u2(_movn);
 Ip_u3u1u2(_movz);
 Ip_u1u2u3(_mtc0);
@@ -139,6 +144,7 @@ Ip_u1(_mthi);
 Ip_u1(_mtlo);
 Ip_u3u1u2(_mul);
 Ip_u1u2(_multu);
+Ip_u3u1u2(_mulu);
 Ip_u3u1u2(_nor);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
@@ -149,6 +155,8 @@ Ip_u2s3u1(_sb);
 Ip_u2s3u1(_sc);
 Ip_u2s3u1(_scd);
 Ip_u2s3u1(_sd);
+Ip_u3u1u2(_seleqz);
+Ip_u3u1u2(_selnez);
 Ip_u2s3u1(_sh);
 Ip_u2u1u3(_sll);
 Ip_u3u2u1(_sllv);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm=
/inst.h
index 40fbb5dd66df..eaa3a80affdf 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -55,9 +55,9 @@ enum spec_op {
 	spec3_unused_op, spec4_unused_op, slt_op, sltu_op,
 	dadd_op, daddu_op, dsub_op, dsubu_op,
 	tge_op, tgeu_op, tlt_op, tltu_op,
-	teq_op, spec5_unused_op, tne_op, spec6_unused_op,
-	dsll_op, spec7_unused_op, dsrl_op, dsra_op,
-	dsll32_op, spec8_unused_op, dsrl32_op, dsra32_op
+	teq_op, seleqz_op, tne_op, selnez_op,
+	dsll_op, spec5_unused_op, dsrl_op, dsra_op,
+	dsll32_op, spec6_unused_op, dsrl32_op, dsra32_op
 };
=20
 /*
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 6abe40fc413d..7154a1d99aad 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -76,14 +76,22 @@ static const struct insn insn_table[insn_invalid] =3D {
 	[insn_daddiu]	=3D {M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_daddu]	=3D {M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD},
 	[insn_ddivu]	=3D {M(spec_op, 0, 0, 0, 0, ddivu_op), RS | RT},
+	[insn_ddivu_r6]	=3D {M(spec_op, 0, 0, 0, ddivu_ddivu6_op, ddivu_op),
+				RS | RT | RD},
 	[insn_di]	=3D {M(cop0_op, mfmc0_op, 0, 12, 0, 0), RT},
 	[insn_dins]	=3D {M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE},
 	[insn_dinsm]	=3D {M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE},
 	[insn_dinsu]	=3D {M(spec3_op, 0, 0, 0, 0, dinsu_op), RS | RT | RD | RE},
 	[insn_divu]	=3D {M(spec_op, 0, 0, 0, 0, divu_op), RS | RT},
+	[insn_divu_r6]	=3D {M(spec_op, 0, 0, 0, divu_divu6_op, divu_op),
+				RS | RT | RD},
 	[insn_dmfc0]	=3D {M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
+	[insn_dmodu]	=3D {M(spec_op, 0, 0, 0, ddivu_dmodu_op, ddivu_op),
+				RS | RT | RD},
 	[insn_dmtc0]	=3D {M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
 	[insn_dmultu]	=3D {M(spec_op, 0, 0, 0, 0, dmultu_op), RS | RT},
+	[insn_dmulu]	=3D {M(spec_op, 0, 0, 0, dmult_dmul_op, dmultu_op),
+				RS | RT | RD},
 	[insn_drotr]	=3D {M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE},
 	[insn_drotr32]	=3D {M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE},
 	[insn_dsbh]	=3D {M(spec3_op, 0, 0, 0, dsbh_op, dbshfl_op), RT | RD},
@@ -132,12 +140,16 @@ static const struct insn insn_table[insn_invalid] =3D=
 {
 	[insn_mfhc0]	=3D {M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mfhi]	=3D {M(spec_op, 0, 0, 0, 0, mfhi_op), RD},
 	[insn_mflo]	=3D {M(spec_op, 0, 0, 0, 0, mflo_op), RD},
+	[insn_modu]	=3D {M(spec_op, 0, 0, 0, divu_modu_op, divu_op),
+				RS | RT | RD},
 	[insn_movn]	=3D {M(spec_op, 0, 0, 0, 0, movn_op), RS | RT | RD},
 	[insn_movz]	=3D {M(spec_op, 0, 0, 0, 0, movz_op), RS | RT | RD},
 	[insn_mtc0]	=3D {M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mthc0]	=3D {M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mthi]	=3D {M(spec_op, 0, 0, 0, 0, mthi_op), RS},
 	[insn_mtlo]	=3D {M(spec_op, 0, 0, 0, 0, mtlo_op), RS},
+	[insn_mulu]	=3D {M(spec_op, 0, 0, 0, multu_mulu_op, multu_op),
+				RS | RT | RD},
 #ifndef CONFIG_CPU_MIPSR6
 	[insn_mul]	=3D {M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
 #else
@@ -163,6 +175,8 @@ static const struct insn insn_table[insn_invalid] =3D {
 	[insn_scd]	=3D {M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9},
 #endif
 	[insn_sd]	=3D {M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_seleqz]	=3D {M(spec_op, 0, 0, 0, 0, seleqz_op), RS | RT | RD},
+	[insn_selnez]	=3D {M(spec_op, 0, 0, 0, 0, selnez_op), RS | RT | RD},
 	[insn_sh]	=3D {M(sh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_sll]	=3D {M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE},
 	[insn_sllv]	=3D {M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD},
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 45b6264ff308..c56f129c9a4b 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -50,21 +50,22 @@ enum opcode {
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bgtz, insn_blez,
 	insn_bltz, insn_bltzl, insn_bne, insn_break, insn_cache, insn_cfc1,
 	insn_cfcmsa, insn_ctc1, insn_ctcmsa, insn_daddiu, insn_daddu, insn_ddivu,
-	insn_di, insn_dins, insn_dinsm, insn_dinsu, insn_divu, insn_dmfc0,
-	insn_dmtc0, insn_dmultu, insn_drotr, insn_drotr32, insn_dsbh, insn_dshd,
-	insn_dsll, insn_dsll32, insn_dsllv, insn_dsra, insn_dsra32, insn_dsrav,
-	insn_dsrl, insn_dsrl32, insn_dsrlv, insn_dsubu, insn_eret, insn_ext,
-	insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_lb, insn_lbu,
-	insn_ld, insn_lddir, insn_ldpte, insn_ldx, insn_lh, insn_lhu,
-	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwu, insn_lwx, insn_mfc0,
-	insn_mfhc0, insn_mfhi, insn_mflo, insn_movn, insn_movz, insn_mtc0,
-	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_nor,
-	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb,
-	insn_sc, insn_scd, insn_sd, insn_sh, insn_sll, insn_sllv,
-	insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra, insn_srav,
-	insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall,
-	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh,
-	insn_xor, insn_xori, insn_yield,
+	insn_ddivu_r6, insn_di, insn_dins, insn_dinsm, insn_dinsu, insn_divu,
+	insn_divu_r6, insn_dmfc0, insn_dmodu, insn_dmtc0, insn_dmultu,
+	insn_dmulu, insn_drotr, insn_drotr32, insn_dsbh, insn_dshd, insn_dsll,
+	insn_dsll32, insn_dsllv, insn_dsra, insn_dsra32, insn_dsrav, insn_dsrl,
+	insn_dsrl32, insn_dsrlv, insn_dsubu, insn_eret, insn_ext, insn_ins,
+	insn_j, insn_jal, insn_jalr, insn_jr, insn_lb, insn_lbu, insn_ld,
+	insn_lddir, insn_ldpte, insn_ldx, insn_lh, insn_lhu, insn_ll, insn_lld,
+	insn_lui, insn_lw, insn_lwu, insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi,
+	insn_mflo, insn_modu, insn_movn, insn_movz, insn_mtc0, insn_mthc0,
+	insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu, insn_nor,
+	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb, insn_sc,
+	insn_scd, insn_seleqz, insn_selnez, insn_sd, insn_sh, insn_sll,
+	insn_sllv, insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra,
+	insn_srav, insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync,
+	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait,
+	insn_wsbh, insn_xor, insn_xori, insn_yield,
 	insn_invalid /* insn_invalid must be last */
 };
=20
@@ -287,13 +288,17 @@ I_u2u1(_cfcmsa)
 I_u1u2(_ctc1)
 I_u2u1(_ctcmsa)
 I_u1u2(_ddivu)
+I_u3u1u2(_ddivu_r6)
 I_u1u2u3(_dmfc0)
+I_u3u1u2(_dmodu)
 I_u1u2u3(_dmtc0)
 I_u1u2(_dmultu)
+I_u3u1u2(_dmulu)
 I_u2u1s3(_daddiu)
 I_u3u1u2(_daddu)
 I_u1(_di);
 I_u1u2(_divu)
+I_u3u1u2(_divu_r6)
 I_u2u1(_dsbh);
 I_u2u1(_dshd);
 I_u2u1u3(_dsll)
@@ -327,6 +332,7 @@ I_u2s3u1(_lw)
 I_u2s3u1(_lwu)
 I_u1u2u3(_mfc0)
 I_u1u2u3(_mfhc0)
+I_u3u1u2(_modu)
 I_u3u1u2(_movn)
 I_u3u1u2(_movz)
 I_u1(_mfhi)
@@ -337,6 +343,7 @@ I_u1(_mthi)
 I_u1(_mtlo)
 I_u3u1u2(_mul)
 I_u1u2(_multu)
+I_u3u1u2(_mulu)
 I_u3u1u2(_nor)
 I_u3u1u2(_or)
 I_u2u1u3(_ori)
@@ -345,6 +352,8 @@ I_u2s3u1(_sb)
 I_u2s3u1(_sc)
 I_u2s3u1(_scd)
 I_u2s3u1(_sd)
+I_u3u1u2(_seleqz)
+I_u3u1u2(_selnez)
 I_u2s3u1(_sh)
 I_u2u1u3(_sll)
 I_u3u2u1(_sllv)
--=20
2.18.0

