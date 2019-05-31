Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AE226E93
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="a7egaLOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfEaTvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:51:49 -0400
Received: from mail-eopbgr770089.outbound.protection.outlook.com ([40.107.77.89]:36741
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbfEaTvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/cGAMvhRe3DX4Z097orKMHDXrlzraUENiWr6IumeO4=;
 b=a7egaLOL/uTo3ybDQ719VyHQrInaHn3x+r7ubt3kTuEwJNP3oycO+7RNn7RxjF/j6SL4BGATV+iq83jrx2GuutBML48SQ+GrMSDmsIcp90sh4UXB5Vl8QKszcrSN+hoegVTtB4QyLFsgdD4hbsB0//3YJnT7W48cr+HeXGwko1U=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6694.namprd05.prod.outlook.com (20.178.235.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Fri, 31 May 2019 19:51:45 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 19:51:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Matt Mullins <mmullins@fb.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Douglas Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/kgdb: return 0 from kgdb_arch_set_breakpoint
Thread-Topic: [PATCH] x86/kgdb: return 0 from kgdb_arch_set_breakpoint
Thread-Index: AQHVF+nqHaBESOu01Eao/K0uaC2yhaaFpLcA
Date:   Fri, 31 May 2019 19:51:44 +0000
Message-ID: <F51E9CDD-6936-46B8-967D-13F6BFEF8CE0@vmware.com>
References: <20190531194755.6320-1-mmullins@fb.com>
In-Reply-To: <20190531194755.6320-1-mmullins@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7171af25-0e5e-4530-499b-08d6e60168fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB6694;
x-ms-traffictypediagnostic: BYAPR05MB6694:
x-microsoft-antispam-prvs: <BYAPR05MB66942F0A007348B553EA90C1D0190@BYAPR05MB6694.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(11346002)(486006)(446003)(53546011)(76176011)(229853002)(66066001)(476003)(7416002)(81156014)(6506007)(6512007)(14454004)(8676002)(2616005)(8936002)(81166006)(53936002)(36756003)(86362001)(478600001)(7736002)(102836004)(186003)(6436002)(305945005)(6116002)(3846002)(82746002)(6486002)(83716004)(71200400001)(26005)(71190400001)(14444005)(256004)(6916009)(54906003)(25786009)(5660300002)(66946007)(33656002)(99286004)(6246003)(66446008)(76116006)(66556008)(68736007)(4326008)(73956011)(2906002)(316002)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6694;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yTLq37VXBqd+lOou7r1HWeYc0qDbXtuU+C7GC7awMli7OTUpyOKhnbMjXgJZhUnuRhA0m04Jv/n8taCsqI7l3e39UGuT8ABX8EcdTBA6y2thG0bxjU6CSAbwKPSurhFEIpDkPLggzRyd+hUCd/xxcfklSmcVj/FGATQdG2VWqzuETNPu0IC9652v/qv8wBcyxr3zyjIdeSRrd/WpgjmgU15P9rSZoFuQDl173LMCUrEidayOp0Q6o+tWdr3CD51B3QoGLJpJuu6jDHV4nayRL7w4aT9X72OwifkDO1xY0wTeO1PUtoZFKaqIY2tfPwLVOo3Nbi/cjLfv9h3GcfQ7eUogpWfjVyi0KTaazu8S6T6oWnRzNaVbd0jhl+rSMc62oafWeOdzXZYczx5CStQ/LLoW1ZEn6RAwxGddwHuie88=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67A289241FE6E5448742D8623564083E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7171af25-0e5e-4530-499b-08d6e60168fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 19:51:44.9225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 31, 2019, at 12:47 PM, Matt Mullins <mmullins@fb.com> wrote:
>=20
> err must be nonzero in order to reach text_poke(), which caused kgdb to
> fail to set breakpoints:
>=20
> 	(gdb) break __x64_sys_sync
> 	Breakpoint 1 at 0xffffffff81288910: file ../fs/sync.c, line 124.
> 	(gdb) c
> 	Continuing.
> 	Warning:
> 	Cannot insert breakpoint 1.
> 	Cannot access memory at address 0xffffffff81288910
>=20
> 	Command aborted.
>=20
> Fixes: 86a22057127d ("x86/kgdb: Avoid redundant comparison of patched cod=
e")
> Signed-off-by: Matt Mullins <mmullins@fb.com>
> ---
> arch/x86/kernel/kgdb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 9a8c1648fc9a..6690c5652aeb 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -758,7 +758,7 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
> 		       BREAK_INSTR_SIZE);
> 	bpt->type =3D BP_POKE_BREAKPOINT;
>=20
> -	return err;
> +	return 0;
> }
>=20
> int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
> --=20
> 2.17.1

My bad. Thanks for fixing it.

Reviewed-by: Nadav Amit <namit@vmware.com>

