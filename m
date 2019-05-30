Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E61C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19B025D12
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ibTaG1qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfE3Ptg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:49:36 -0400
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:51524
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbfE3Ptc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4VhIAMP+vYb+hX1wa84OBgkG1r0ptiv6LE3EMVT/A8=;
 b=ibTaG1qkyX1q/WC9GufXcj5fQ9YrBrvprCTD5LAO1Wc2FHhWIZoUParniw8vwjBcrytDod1DCmH0fV1Yp9uIvowVzkvQiu9UI7/N13K89YE56yGABhvIv10Rr2IEECHUZeTgynr+DAAkIDYMTJ5g7EgXLRUUlpYR19XxfwK5j1k=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5038.eurprd05.prod.outlook.com (20.177.52.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 30 May 2019 15:49:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1943.016; Thu, 30 May 2019
 15:49:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuehaibing <yuehaibing@huawei.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>
CC:     "bskeggs@redhat.com" <bskeggs@redhat.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] drm/nouveau: Fix DEVICE_PRIVATE dependencies
Thread-Topic: [PATCH] drm/nouveau: Fix DEVICE_PRIVATE dependencies
Thread-Index: AQHU9Smp7DtPqq1csU6J+upeBQ7IX6aEDxgAgAAFFYA=
Date:   Thu, 30 May 2019 15:49:27 +0000
Message-ID: <20190530154923.GJ13461@mellanox.com>
References: <20190417142632.12992-1-yuehaibing@huawei.com>
 <583de550-d816-f619-d402-688c87c86fe3@huawei.com>
In-Reply-To: <583de550-d816-f619-d402-688c87c86fe3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0010.namprd15.prod.outlook.com
 (2603:10b6:207:17::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb64e4a5-1883-4fa3-abde-08d6e516657f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5038;
x-ms-traffictypediagnostic: VI1PR05MB5038:
x-microsoft-antispam-prvs: <VI1PR05MB5038A0DBC9732A6345508206CF180@VI1PR05MB5038.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(366004)(376002)(189003)(199004)(53754006)(6486002)(110136005)(446003)(486006)(66446008)(53936002)(86362001)(14454004)(6512007)(478600001)(54906003)(7416002)(7736002)(81156014)(26005)(186003)(1076003)(8936002)(8676002)(4326008)(6436002)(3846002)(305945005)(33656002)(66556008)(5660300002)(6116002)(64756008)(81166006)(2616005)(73956011)(66476007)(2906002)(25786009)(102836004)(36756003)(71200400001)(71190400001)(66066001)(256004)(76176011)(99286004)(316002)(386003)(229853002)(68736007)(66946007)(14444005)(53546011)(6246003)(52116002)(11346002)(6506007)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5038;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mD+yXMynfy4cxpwEDWUiTZK3y7e3HTcdtyeyxxhGMJYJCRoGQjggi/MVCYWDaEZhTs6JRyaO65Im0wo83Z7roj+akgVuSIaSi/tUocwZyEnlBMIhH+kT540cISNX7AQnsgvYJxOWqxXlHrvHnDs+oNoF+mLvxbpKeoChDYV/HwBsqbk8TOgVfqHsmDPMhu6nXgF85ULOdp+55FuClaG6W9OBO40IuayZ60NDABOdE2ofDNbpHDLNr7SOhbnZXe4wQC2qSZ/6BrKjUsHVNxQBIo+HyQFVZGCs6lhpfcAKMCwljEFtq957iVez48KViXGjvLMCslgwnV1JN2Bh7tLJATJGvN0Wg3jzvcoPxTJWizt1z7WllEXvcnqizgfXvP4Dlzc9QgcNgtOaNRsA/V/msr+SYHruZjBesDW69tYjOxs=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <56987BA9B86175409FE65B63660189BB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb64e4a5-1883-4fa3-abde-08d6e516657f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 15:49:27.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 30, 2019 at 11:31:12PM +0800, Yuehaibing wrote:
> Hi all,
>=20
> Friendly ping:
>=20
> Who can take this?
>=20
> On 2019/4/17 22:26, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> >=20
> > During randconfig builds, I occasionally run into an invalid configurat=
ion
> >=20
> > WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
> >   Depends on [n]: ARCH_HAS_HMM_DEVICE [=3Dn] && ZONE_DEVICE [=3Dn]
> >   Selected by [y]:
> >   - DRM_NOUVEAU_SVM [=3Dy] && HAS_IOMEM [=3Dy] && ARCH_HAS_HMM [=3Dy] &=
& DRM_NOUVEAU [=3Dy] && STAGING [=3Dy]
> >=20
> > mm/memory.o: In function `do_swap_page':
> > memory.c:(.text+0x2754): undefined reference to `device_private_entry_f=
ault'
> >=20
> > commit 5da25090ab04 ("mm/hmm: kconfig split HMM address space mirroring=
 from device memory")
> > split CONFIG_DEVICE_PRIVATE dependencies from
> > ARCH_HAS_HMM to ARCH_HAS_HMM_DEVICE and ZONE_DEVICE,
> > so enable DRM_NOUVEAU_SVM will trigger this warning,
> > cause building failed.
> >=20
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 5da25090ab04 ("mm/hmm: kconfig split HMM address space mirroring=
 from device memory")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >  drivers/gpu/drm/nouveau/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/=
Kconfig
> > index 00cd9ab..99e30c1 100644
> > +++ b/drivers/gpu/drm/nouveau/Kconfig
> > @@ -74,7 +74,8 @@ config DRM_NOUVEAU_BACKLIGHT
> > =20
> >  config DRM_NOUVEAU_SVM
> >  	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
> > -	depends on ARCH_HAS_HMM
> > +	depends on ARCH_HAS_HMM_DEVICE
> > +	depends on ZONE_DEVICE
> >  	depends on DRM_NOUVEAU
> >  	depends on STAGING
> >  	select HMM_MIRROR
> >=20

I'm expecting to take a patch like this into the new hmm git tree once
Jerome sends his Final Solution for the kconfig problems.

Maybe it is this patch, Jerome??

Regards,
Jason=20
