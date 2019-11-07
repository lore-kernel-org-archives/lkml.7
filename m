Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A1C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBD220673
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="N/fe8xy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKGIVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:21:47 -0500
Received: from mail-eopbgr820073.outbound.protection.outlook.com ([40.107.82.73]:11533
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbfKGIVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:21:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nb5m3Zljd22tmtXjNLlboss3HLkfaS/GRpBzKFRRkodzt+1pzxmMi1xrw1GdXhdhfuYPghC/rL/aLQt+9ko3uGP05/9mrCrcCbvd4GZSK5ji54Gkil1hBWq+dBe5w0kc4iVNpB7DuOjsHvn2mIobS5V3wyfHq2CRSAjZOaSn0nnpeS9oErCMGtTvy5kOGUWOjP8MJHvyZx218AXrGeiTB60fggHytZeXHZwK0FjNf/BQ/3pOqmY/yKNrWepAMvGpFRuSVU03yOVfRZdg0wK9HbHn3zntuEWbNKueEklMja/p4s7SVLroJ9qiUkWjCO+Dww0E1RWEYIMvR+d1nAcomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8Ts2d8pHRDLT0IACX/DY/FykRL/kw6c8+nK82VL1xo=;
 b=Ez+i/azMC18RldXSgwBTZ0c3gdjGbrSg9hfssNvhHta6ox6tuALvdv1De6QJE/TYkeAqtQ1j0U73KvfI1+8/XjV0UwZ0QFOTgH3Lxu0SKBvA7ov50aNXz7MV6K/AkbM7KO7dfoLCr83IgE353lVkuiJs+Y0nn9R6tMxTjZziuOf5BXL7uCnNFKYQnXKnBSUcjfocPY2TtQ/fRGgdgtvAh14DRli+6wkkXh/SNd1TojoD4seStqKKwt0x/SjGOS/8fUIjZ6c9logxumNqaLWsCGSo5Jln4uA3Zp61TfBkJ2TGsfxpEUP8DzNlZac12pNBHF0DfvQsZovPL4UE64H2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8Ts2d8pHRDLT0IACX/DY/FykRL/kw6c8+nK82VL1xo=;
 b=N/fe8xy7yeMqYLSD9LyS2Sj8ejGYEVeJkYm9w+HaOGd62WUtipW+hYr7Ee863heJvx7MoJIcMG4rEb1aHxjOaDg+Fq+ytYx5q5hfqlzxrm7LvFJ5YhSQJQUDgKYmZmuGBumUpgtJKOc6LZ5QravCwBrbw9sf5Nmfm/25KsiQ3jA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4711.namprd03.prod.outlook.com (20.179.94.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 08:21:42 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a8f6:f5d6:f438:ec61]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a8f6:f5d6:f438:ec61%3]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 08:21:42 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3] ARM: ftrace: remove mcount(),ftrace_caller_old()
 and  ftrace_call_old()
Thread-Topic: [PATCH RESEND v3] ARM: ftrace: remove
 mcount(),ftrace_caller_old() and  ftrace_call_old()
Thread-Index: AQHVlURih9isV5S0iUaVIqdw6yr7Aw==
Date:   Thu, 7 Nov 2019 08:21:42 +0000
Message-ID: <20191107160840.7bd821dc@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::30) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c50b14fd-81cb-4cd1-9ebb-08d7635b8535
x-ms-traffictypediagnostic: BYAPR03MB4711:
x-microsoft-antispam-prvs: <BYAPR03MB471190299CAD4CDD7F477F97ED780@BYAPR03MB4711.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39850400004)(199004)(189003)(4326008)(8936002)(66476007)(256004)(86362001)(66066001)(66446008)(64756008)(66556008)(81166006)(5660300002)(66946007)(305945005)(7736002)(1076003)(6116002)(14454004)(2906002)(8676002)(3846002)(81156014)(50226002)(102836004)(25786009)(54906003)(52116002)(71200400001)(71190400001)(6506007)(186003)(386003)(99286004)(26005)(478600001)(486006)(476003)(110136005)(316002)(6436002)(9686003)(6486002)(6512007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4711;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rwE6uvJnadQhfygeQAKGhH3/IQ5ku2ppobxV36FBIFECmbAxctNv3+aPdq37f49/9X4FI1zRZ2lG0tMlWvHJ5eBDng8MmIBjwvuJz4HLTSc2fkWHjjTxOKaI0uhv5nmYuyZGHwBOKreTEFfMZ5+pU0QSz3SpbUQIN6ztoXfjE4jvF0lqAULwByXbpF7NE8MExoqQFg+scRvYM6Q+y6xxy4DJK4matntcegTCDRz19f8QVoNzt6m4QpgL+9kzUiLSKV1Mli0tMZgeH12E0Oq84apliuCWyOGGzbGeJX5o6/yZIxBIaNv+mvkGSDp9DkAAjSm+OKzOfRrJo0aKy3xjjHPbOPz645AQrtjNY2J7F5j9G6wy3AtWSn8SPgWzXaEjrPAmHhgA6w2xJj0UJe9GkP++xrrvS54aU+tXBDE9fRCBjGpd51UOXZCwNoIYXzzt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B95173C301D7DD48A4B341BCE1200C8F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50b14fd-81cb-4cd1-9ebb-08d7635b8535
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 08:21:42.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9AKEZR2ayLyrgYiZ6Ihw0UqLv/Rgk+SXTXRLd/Xjpm+0Tw0NWgqXsRyBx/2IkPn2YUO60paAk8w1hploCjRKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d3c61619568c ("ARM: 8788/1: ftrace: remove old mcount support")
removed the old mcount support, but forget to remove these three
declarations. This patch removes them.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Changes since v2:
  - really remove mcount() declaration too. I made a mistake when sending o=
ut v2

Changes since v1:
  - remove mcount() declaration too

 arch/arm/include/asm/ftrace.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 18b0197f2384..48ec1d0337da 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -11,7 +11,6 @@
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
=20
 #ifndef __ASSEMBLY__
-extern void mcount(void);
 extern void __gnu_mcount_nc(void);
=20
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -23,9 +22,6 @@ static inline unsigned long ftrace_call_adjust(unsigned l=
ong addr)
 	/* With Thumb-2, the recorded addresses have the lsb set */
 	return addr & ~1;
 }
-
-extern void ftrace_caller_old(void);
-extern void ftrace_call_old(void);
 #endif
=20
 #endif
--=20
2.23.0.rc1

