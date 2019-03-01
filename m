Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DD92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CzQ6zYf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfCAW6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:58:15 -0500
Received: from mail-eopbgr690107.outbound.protection.outlook.com ([40.107.69.107]:60976
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbfCAW6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D0uQdkK/KTND7GsuRV58wX5LztBFCV+ZAvSqjr3hfo=;
 b=CzQ6zYf6Uj+UfuuZP0jZkbwtUx3zMuEYWabXuareGVj59M9afYQfSA8fct97TLEwQde6VZbNwSxbpzWcDw3wHcfImMbHQRXeoTcRcp+HDNnN0Isnssc0iPyxUcN1bkFYb9eMJ+h9+afmRAeEztIu64R6f+97MbWhiI0oQXdsMEs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1712.namprd22.prod.outlook.com (10.164.206.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Fri, 1 Mar 2019 22:58:10 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1665.017; Fri, 1 Mar 2019
 22:58:10 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] MIPS: eBPF: Fix icache flush end address
Thread-Topic: [PATCH] MIPS: eBPF: Fix icache flush end address
Thread-Index: AQHU0II9QjuLpQE7bEiWH3F6aW3bIQ==
Date:   Fri, 1 Mar 2019 22:58:09 +0000
Message-ID: <20190301225743.8632-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::45) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 505f46a1-6a24-4398-4409-08d69e995fd5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1712;
x-ms-traffictypediagnostic: MWHPR2201MB1712:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1712;23:Y6AUrjOfGAUrK1UqYhSj7607jP/rXXyft5Nxk?=
 =?iso-8859-1?Q?NryRb2AlPzWpVmZFGc6TkDwDJFBGqh9bInQeSDOo4pETWTldYMxSlSipWI?=
 =?iso-8859-1?Q?voYg6pvpUt/vp5WnmWYcRZqJGB/pzER9qT3wRvd4WDvXMLE7Wa5UBRKhqD?=
 =?iso-8859-1?Q?MuspVxp1LNg1xCLXstX0dzfdUTC0ifxqpVikW87TPP9PliT3JgSOHhxQqy?=
 =?iso-8859-1?Q?1wP0Sneg2bhExtPX/TUzTXZZOL3pEiVknomo+Bo+95Q7DE8Nbab2tRhgww?=
 =?iso-8859-1?Q?4RH0m41HAu1qWMw9OvjsLEojHGMXyZO/y8vvRyTg9jwqcWXxicFQ0hx3qm?=
 =?iso-8859-1?Q?qArDUERwsT6vYXVd8F8v8a5MDxRgEK9zcJjD1KVqxEeVBJeQ6R/5ml1QkB?=
 =?iso-8859-1?Q?b+TOaJOqKtNy6PHE4wZNa7WKA3lahhn04tIx7x3z+Z1W5UwozzSpea3Q2C?=
 =?iso-8859-1?Q?WLccSCBpGifSAIjzKg/GMnNNN9p0OPA12QXv3/NuCwopFhAC4dMuNaL/9F?=
 =?iso-8859-1?Q?SpBBP0ZkfE/qr3LdqEI3Zr6BCdQTbzY0uW1WeuqEfIHbobu/HVpxaznd9Q?=
 =?iso-8859-1?Q?ZucV6A63fIlL7YhU51CufqSmbt+k43CgaE9v5cAlYyysnDUOw05gfdCy4T?=
 =?iso-8859-1?Q?6WgHudCgliUqtf+qnvUltCY7e0tTutZDzk8/QNClvu4yp/VXGCUx6y55Ul?=
 =?iso-8859-1?Q?sWaTX+MLwdw72H6V0MnEq8E6yUH5qUTNe44JAxl+mYIXfHFEfO2AjcPVOn?=
 =?iso-8859-1?Q?l61r7f0N3RX/sB9+hWA3T9rMtCuFoCTvy8kDeUgnwZ703YW37YX6EVFP/p?=
 =?iso-8859-1?Q?7+mHAOPokffsjHXbDBOkfiNyPkG24Yaatgxzpr1mUMYGKlAc6rR924mLg2?=
 =?iso-8859-1?Q?ubCGzhWyN1H8CSG9cNEJNVNsnlsrWA2RPt26v5g7RWmvlxL5YQgp39NZA9?=
 =?iso-8859-1?Q?r7k4J7fFDHnSNeHIR7I49N5/xdQa4oh8VJlL1/1O9ZfjjykuzlbD1NgkLs?=
 =?iso-8859-1?Q?b4CACJtKwztqHjddz/17xzTjhlRqoLiZ5lozTv3zudz7eKf4TQG41vBy4y?=
 =?iso-8859-1?Q?7ySfNjUtkL1IwNDbO05GXnKagho3US7eXv1QT6QGo9Gs0HiY1RrlYWn0O0?=
 =?iso-8859-1?Q?uVL0TSh5CftckXWif1qy99O1mB5nzCMdBrXeDYcRwUooKCuGjAf8h/UpkU?=
 =?iso-8859-1?Q?sLB7lkbORrdkefluGBsgUk1GTtdkqCFTwPttBY8kkwVc+LPJKGU4rAmO/z?=
 =?iso-8859-1?Q?3HB/uWL/fyZ0FJv/rGovZ/1IlflE2LwTw4BQ733NrDVYVVB676N0s8xDEE?=
 =?iso-8859-1?Q?oj3s=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB171221E822570A57D075C2DEC1760@MWHPR2201MB1712.namprd22.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(316002)(6116002)(3846002)(99286004)(2201001)(1076003)(186003)(7736002)(5660300002)(2616005)(7416002)(105586002)(44832011)(14444005)(256004)(52116002)(486006)(386003)(6506007)(81166006)(81156014)(8676002)(476003)(305945005)(2906002)(97736004)(4326008)(54906003)(110136005)(42882007)(66066001)(6436002)(6486002)(26005)(53936002)(2501003)(71190400001)(71200400001)(478600001)(50226002)(8936002)(6512007)(25786009)(14454004)(102836004)(106356001)(36756003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1712;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 99p/MpIJjqXs5OAkrwpL2l5pRSXTEKHOPQP83798NaKVde059olqv8LAqHDRfkS5bGhPgRd/vJkIq58y9CIEZGIAEXJ+xIRHwzMbGv54S2pV3xlwy/miEcR5RwWJCHy4t0PMyCtQ546hfjMG0XG2eecfhq06kpRUgqBOjhB2vqaLwXNIcVDP+GbF/cg+BQ2siyynzGJyR36AzM9oUv92noYzNYng7sNEzv87PKo0SSOgtYdAC5kMxCdP2s0keXlVXM06GSXZYW0edNgUWgogUYplmn0qohZHG47k15JVw3p2Rqa7wTVWzBM0DWWfttE2ob6dsdlq+ApTOuBKsEcbCL8m8CumO7b94lf6XEt/ayrfLg99U9smTDe1RJsIGRFxcP/iVDUADVp8C/OH2Sq7H1wyEv/BBLIGEgEa1uF0nV4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505f46a1-6a24-4398-4409-08d69e995fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 22:58:10.0275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPS eBPF JIT calls flush_icache_range() in order to ensure the
icache observes the code that we just wrote. Unfortunately it gets the
end address calculation wrong due to some bad pointer arithmetic.

The struct jit_ctx target field is of type pointer to u32, and as such
adding one to it will increment the address being pointed to by 4 bytes.
Therefore in order to find the address of the end of the code we simply
need to add the number of 4 byte instructions emitted, but we mistakenly
add the number of instructions multiplied by 4. This results in the call
to flush_icache_range() operating on a memory region 4x larger than
intended, which is always wasteful and can cause crashes if we overrun
into an unmapped page.

Fix this by correcting the pointer arithmetic to remove the bogus
multiplication, and use braces to remove the need for a set of brackets
whilst also making it obvious that the target field is a pointer.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # v4.13+
---
 arch/mips/net/ebpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 76e9bf88d3b9..0effd3cba9a7 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -1819,7 +1819,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog =
*prog)
=20
 	/* Update the icache */
 	flush_icache_range((unsigned long)ctx.target,
-			   (unsigned long)(ctx.target + ctx.idx * sizeof(u32)));
+			   (unsigned long)&ctx.target[ctx.idx]);
=20
 	if (bpf_jit_enable > 1)
 		/* Dump JIT code */
--=20
2.21.0

