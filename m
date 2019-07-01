Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C538C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0885921721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ceu3NKwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfGARti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:49:38 -0400
Received: from mail-eopbgr700071.outbound.protection.outlook.com ([40.107.70.71]:17249
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727446AbfGARti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r4AxFYcFNtY8HmC6iyBN4XWX1u08kh3Kacovbkwmcw=;
 b=ceu3NKwhTfIqTC16sCdq82KZkTWtbRdDzOZqD3MH4SKsjjXznZEbuTg6QrDUsr7ZfxyNArfG9BFMVPr+JAbn0THFrUQ07LlsSsrjz3aXlQtBTyWOfsLUmFaySDqGH1RsSu12VYAtDFSnCIsrE9m4yo8Qt4gxDOe9CNdVb6uKvJk=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4437.namprd05.prod.outlook.com (52.135.203.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.14; Mon, 1 Jul 2019 17:49:35 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2052.010; Mon, 1 Jul 2019
 17:49:35 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/ldt: Initialize the context lock for init_mm
Thread-Topic: [PATCH] x86/ldt: Initialize the context lock for init_mm
Thread-Index: AQHVMDMsFZ2Oh1rNP0yNtHzPaQvKzqa2CkqA
Date:   Mon, 1 Jul 2019 17:49:35 +0000
Message-ID: <D552F5D9-26A0-4584-8CEA-6E6E321D63E6@vmware.com>
References: <20190701173354.2pe62hhliok2afea@linutronix.de>
In-Reply-To: <20190701173354.2pe62hhliok2afea@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 038ef42a-e921-494b-0df4-08d6fe4c7b47
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4437;
x-ms-traffictypediagnostic: BYAPR05MB4437:
x-microsoft-antispam-prvs: <BYAPR05MB44374A268E43F34D719C7512D0F90@BYAPR05MB4437.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(199004)(189003)(4326008)(14454004)(86362001)(26005)(36756003)(6486002)(68736007)(316002)(81166006)(71190400001)(102836004)(6506007)(8936002)(478600001)(6916009)(81156014)(2906002)(71200400001)(446003)(486006)(33656002)(53546011)(25786009)(256004)(186003)(8676002)(2616005)(476003)(14444005)(76116006)(6246003)(66556008)(64756008)(66446008)(5660300002)(66946007)(66476007)(6436002)(73956011)(6512007)(3846002)(305945005)(66066001)(6116002)(229853002)(99286004)(7736002)(76176011)(53936002)(54906003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4437;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 109UOjF7H1jDK8a8Itt9HFbVpsxHinKQ4FNSL5DpSVqQJfR0mh9nQ2XYiJsq6P4i9w/m6n1SaZlDb9jwY6VHBRqR7tYiWj184gJaSkErx/V/sjqm+ggEO40Rel1PLdMpjHGWULy9ir7FO6tXJAANrxQT5OyqxhYxQFzN5THf0Y8yEnYcjMEUwG25OxsHdNUeRS58AZVuMp6huYkFOBmIz1mlFtktsk5PhWGOS2rG2E9QA4ckC6UoKXCdvlnO2l9HeQyyPWKEu8+1xgvqBJ/oXbrWoB0e0VrsoE9G1GIejW1DOBx7PcRHohrMUv5IrGyKeoNNrFq74voyVsmpKC/gQ7BcQoKLVLuQYn2VU31s+EsLmd30JIMninXurao3ZCRG8vCOVmc3wRL3mdOWojzqqCgCQqSLXwMD/bxSCEMz4rA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <659F74EEF4D4E04784D1D61F162E2EA7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038ef42a-e921-494b-0df4-08d6fe4c7b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 17:49:35.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 1, 2019, at 10:33 AM, Sebastian Andrzej Siewior <bigeasy@linutroni=
x.de> wrote:
>=20
> The mutex mm->context->lock for init_mm is not initialized for init_mm.
> This wasn't a problem because it remained unused. This changed however
> since commit
> 	4fc19708b165c ("x86/alternatives: Initialize temporary mm for patching")
>=20
> Initialize the mutex for init_mm.
>=20
> Fixes: 4fc19708b165c ("x86/alternatives: Initialize temporary mm for patc=
hing")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>=20
> The rwsem `ldt_usr_sem' is also not initialized for init_mm. No idea if
> we want this.

I cannot see why not (but it would need to depend on CONFIG_MODIFY_LDT_SYSC=
ALL)

>=20
> arch/x86/include/asm/mmu.h | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 5ff3e8af2c205..e78c7db878018 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -59,6 +59,7 @@ typedef struct {
> #define INIT_MM_CONTEXT(mm)						\
> 	.context =3D {							\
> 		.ctx_id =3D 1,						\
> +		.lock =3D __MUTEX_INITIALIZER(mm.context.lock),		\

Sorry for my mistake. Thanks for fixing it up. I find it useful to know how
the problem was found or what the impact was - helps me sometimes to avoid
causing similar bugs in the future.

Reviewed-by: Nadav Amit <namit@vmware.com>=
