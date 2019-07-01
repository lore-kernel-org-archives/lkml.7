Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AE7C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E12A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="m3zHg+Xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfGAXKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 19:10:44 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:37406
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfGAXKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 19:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBQNw1wABUNAaUxOF7dAFZr3renLsUCBb/+lhNxWbcQ=;
 b=m3zHg+Xy0xSEkkqJo+SIYo9C8wy+nPsJNJyTKm9CSgUzvGFh4EQYVTwy2vzX0oSUrwa8AO65N2q78QJlW1M2O/OOZVX2gbKSgWS1Qaewb5PEFrW9GR/F4CQS0MLuhPgY6yf2gumnGQRmFYni9ZKV6s8c6yNzzulQBhum3Pdnps0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5695.eurprd05.prod.outlook.com (20.178.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 23:10:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 23:10:40 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Yang <Philip.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: linux-next: build failure after merge of the hmm tree
Thread-Topic: linux-next: build failure after merge of the hmm tree
Thread-Index: AQHVMADFlVCZuQtgG0K1dqA/V+XsLaa2ZF8A
Date:   Mon, 1 Jul 2019 23:10:40 +0000
Message-ID: <20190701231036.GC23718@mellanox.com>
References: <20190701213304.34eeaef8@canb.auug.org.au>
In-Reply-To: <20190701213304.34eeaef8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:208:fc::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f86c71f-9989-4bfc-672a-08d6fe7955a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5695;
x-ms-traffictypediagnostic: VI1PR05MB5695:
x-microsoft-antispam-prvs: <VI1PR05MB5695D45FB5894D118E6B6702CFF90@VI1PR05MB5695.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(53754006)(102836004)(386003)(6506007)(76176011)(25786009)(8936002)(4326008)(476003)(2616005)(486006)(186003)(5660300002)(14454004)(54906003)(316002)(11346002)(26005)(6116002)(2906002)(68736007)(3846002)(52116002)(99286004)(66476007)(73956011)(66556008)(33656002)(7736002)(8676002)(6246003)(64756008)(256004)(36756003)(478600001)(66946007)(86362001)(53936002)(6512007)(66446008)(81166006)(81156014)(71200400001)(6486002)(229853002)(71190400001)(6436002)(1076003)(305945005)(446003)(6916009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5695;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lCOCP/963DaWTbtI+uY9+nj8dJ/ioTxDE5tMwx0eL8vVw0Lxx7vgoXN1elaG2+POxUKmuSDPbkhvB2oSCit3UejjmHs23GNdCJrhqxS5wrNK/qu5wiEyhdFuB3aWUv5t0lwcbSqmVcMbrITrlpRmbt5TT6YmftWyWL3N+vx4M7vyDvQ+jZGEkFUSycX8R+m9BCLv8enGmphYVWZvxFbiZPckslmBb5d/vtefULRTXxNdsXLSpX9vCnotKWAw48rQf0gJZ+SVEXF2xZxcI89BBIxzPSotjmEpCLCH3+ngC4r1kxdddZqWnvP6V3beXT5r6Egmdatl1ERrMaTu4TiN4m5xFJbiUozUCuSWTjy6t0EuSjqSbYoow9p4IkeSPh0kPIC9+qRTVE608CUvZLVPgybH8+ghwRbdSZwZX7Pbxo0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89A8AB12ACF07449851614D76275C3DA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f86c71f-9989-4bfc-672a-08d6fe7955a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 23:10:40.3440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:33:04PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the hmm tree, today's linux-next build (x86_64 allmodconfig=
)
> failed like this:
>=20
> mm/hmm.c: In function 'hmm_get_or_create':
> mm/hmm.c:50:2: error: implicit declaration of function 'lockdep_assert_he=
ld_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=3Dimplicit=
-function-declaration]
>   lockdep_assert_held_exclusive(&mm->mmap_sem);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   lockdep_assert_held_once
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function 'amdgpu_ttm_tt_get_u=
ser_pages':
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:778:28: error: passing argument 2=
 of 'hmm_range_register' from incompatible pointer type [-Werror=3Dincompat=
ible-pointer-types]
>   hmm_range_register(range, mm, start,
>                             ^~
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:35:
> include/linux/hmm.h:464:29: note: expected 'struct hmm_mirror *' but argu=
ment is of type 'struct mm_struct *'
>           struct hmm_mirror *mirror,
>           ~~~~~~~~~~~~~~~~~~~^~~~~~
>=20
> Caused by commit
>=20
>   e36acfe6c86d ("mm/hmm: Use hmm_mirror not mm as an argument for hmm_ran=
ge_register")
>=20
> interacting with commit
>=20
>   66c45500bfdc ("drm/amdgpu: use new HMM APIs and helpers")
>=20
> from the drm tree.
>=20
> All I could do for now was to mark the AMDGPU driver broken.  Please
> submit a merge for for me (and later Linus) to use.

This is expected, the AMD guys have the resolution for this from when
they tested hmm.git..

I think we are going to have to merge hmm.git into the amdgpu tree and
push the resolution forward, as it looks kind of complicated to shift
onto Linus or DRM.

Probably amdgpu needs to gain a few patches making the hmm_mirror
visible to amdgpu_ttm.c and then the merge resolution will be simple?

AMD/DRM we have a few days left to decide on how best to handle the
conflict, thanks.

Regards,
Jason
