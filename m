Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EB2C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 01:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6643B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 01:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lh8huOGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbfGPBAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 21:00:08 -0400
Received: from mail-eopbgr820087.outbound.protection.outlook.com ([40.107.82.87]:7623
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731566AbfGPBAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 21:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdI6igq3l0lpcLKOFNVU7COigYP4MC6Q6cRiAA29sh1D5hPDf6HjxN9BeiXYEXj8oWPAsPqgI8XDi8fYaG6BMtQX0jYK8W0nuQKkRIrdO6ccrt8Ofb+yWTeIPIALwvJNvU98yOy83q7ppif3zPR4OlWtbkr12am1yrahUL9RLD9WZF6LyzC2zkSpOIshEBqK5p33y2yqAekBKB472Hv7Q2cGivIsd8FyWDb+sGvDQEpeJ7WpZE/BHO/x/A5ejd8C+WX4ql759Ykkz6U5Ht3KqMEJRT5FhMwPZ2ReCJ0p7mLU6c3QqOGYDHQqXYVEgbUDWikFkybvQJl1ARiJhuxtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ponYNR/SjVfpHOyAlaLaBWp3UZAlujOL61NwruHeF4Y=;
 b=jvmm8HOArWk2tYBgaF58Nf78bJYvUkk93uts8HfSKcsDtKQ2Ok669mY20gUGrPJuZmDEAgzg5jva7D2aosQosvryFcEXtLWtXob+ETyyqKKaLho8qWeJTZ8B//hwrOsdYIwRvLujH69GFLTUFj3DEFhbseXJhzB1JadcSIkiofkyo2er9rCji6IZqDpy8M8+rDBPPraaZKF7/4QLyHYv6PHRogtmBDm0SBwqMgmALbFK2NJCy8Vg3s93uMVVZwV1gztss3WnMkTFMTqT9TIvJ9s9JQzPJ2GwUJy0LarpLKNT90xwflaDyf+N04oOJbnSzB4mdJ4gLYJer3WHaJ62Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ponYNR/SjVfpHOyAlaLaBWp3UZAlujOL61NwruHeF4Y=;
 b=lh8huOGOAZxTqYwMCVKUfsoriPFnCY1et7IBz499+I0BeVrtH1u1fxoEN+81ZrX+3+BimqgNVBN3wxB1GZiTXnAiAa8+2cMLMjz/fyi39xcE8SupbHH2AaY1SL3ji+48w3zoPNrUt29kAMlGlIoi+ZG0emQ8BtK0ADVBuxEmm2c=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3726.namprd12.prod.outlook.com (10.255.236.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 01:00:02 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::9170:5b18:b195:24b1]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::9170:5b18:b195:24b1%3]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 01:00:02 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        Rex Zhu <rex.zhu@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
Subject: RE: [PATCH 6/7] drm/amd/powerplay: Use proper enums in
 vega20_print_clk_levels
Thread-Topic: [PATCH 6/7] drm/amd/powerplay: Use proper enums in
 vega20_print_clk_levels
Thread-Index: AQHVMiy+c88EcKEMTUmwHunc6S+NV6bLeiKAgABoggCAAJxnMA==
Date:   Tue, 16 Jul 2019 01:00:02 +0000
Message-ID: <MN2PR12MB3344EFEEA62F1FC0CE238F2CE4CE0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
 <20190704055217.45860-7-natechancellor@gmail.com>
 <CAK8P3a1e4xKTZc1Fcd9KLwaGG_wpcAnSNu7mrB6zw+aBJ0e0CA@mail.gmail.com>
 <20190715153932.GA41785@archlinux-threadripper>
In-Reply-To: <20190715153932.GA41785@archlinux-threadripper>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94e8122c-e187-4f62-40f1-08d70988eedf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3726;
x-ms-traffictypediagnostic: MN2PR12MB3726:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MN2PR12MB37264272F71652FCB599E40FE4CE0@MN2PR12MB3726.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:215;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(13464003)(5660300002)(256004)(52536014)(33656002)(3846002)(14444005)(4326008)(6116002)(53936002)(76176011)(6436002)(55016002)(229853002)(9686003)(186003)(26005)(53546011)(446003)(11346002)(6506007)(6306002)(99286004)(476003)(6246003)(102836004)(2906002)(7696005)(71190400001)(305945005)(71200400001)(486006)(7736002)(74316002)(25786009)(81156014)(81166006)(966005)(86362001)(478600001)(54906003)(8676002)(110136005)(68736007)(66066001)(8936002)(316002)(14454004)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3726;H:MN2PR12MB3344.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: paO9GgWtdmuPV4MKvAqjo4zGI2CG8PHjvONcqO0S0Z9JDv9It+HWyBhgCJclbhPoSRNAKFd+fv6XVQB7kuaFRC1oHiDC9lDIXc5xOq70HEV5Z65IFkyBFcxKTRPSmSKeAuBUbE0LELJ10BXxpD98kdHsFSJY5iWUn8Df3C8SZV+uRRT9yaHvp3MDIV0Hnfk3xv+Lvs8ejSvwb9JitOuysMjZuCIkUUoPC5A/E9mvi2ydViI9y0xg4SZYZl7dL05iUmMSpIMfaut90nVHhs94bCD/FNlJLSSnhOcWl1/OmdLbDOjvZospQkg1Sr6eCg4TSMweqhory1zt+AILQtKu/4dkjQWCuNLtSFOL1XnlTBtp7gj6DVxk44lgNGDc2kodkUyrK7+C++fwHb1GDHDoqGBFe+mwkBVKBoV9RUErXyQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e8122c-e187-4f62-40f1-08d70988eedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 01:00:02.1566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: equan@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!  This is reviewed-by: Evan Quan <evan.quan@amd.com>

Regards
Evan
> -----Original Message-----
> From: Nathan Chancellor <natechancellor@gmail.com>
> Sent: Monday, July 15, 2019 11:40 PM
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
> Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Rex Zhu <rex.zhu@amd.com>;
> Quan, Evan <Evan.Quan@amd.com>; David Airlie <airlied@linux.ie>; Daniel
> Vetter <daniel@ffwll.ch>; amd-gfx list <amd-gfx@lists.freedesktop.org>; d=
ri-
> devel <dri-devel@lists.freedesktop.org>; Linux Kernel Mailing List <linux=
-
> kernel@vger.kernel.org>; clang-built-linux <clang-built-
> linux@googlegroups.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
> Subject: Re: [PATCH 6/7] drm/amd/powerplay: Use proper enums in
> vega20_print_clk_levels
>=20
> On Mon, Jul 15, 2019 at 11:25:29AM +0200, Arnd Bergmann wrote:
> > On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > clang warns:
> > >
> > > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39:
> warning:
> > > implicit conversion from enumeration type 'PPCLK_e' to different
> > > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> > >                 ret =3D smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &=
now);
> > >
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1016:39:
> warning:
> > > implicit conversion from enumeration type 'PPCLK_e' to different
> > > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> > >                 ret =3D smu_get_current_clk_freq(smu, PPCLK_FCLK, &no=
w);
> > >
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> > > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1031:39:
> warning:
> > > implicit conversion from enumeration type 'PPCLK_e' to different
> > > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> > >                 ret =3D smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, =
&now);
> > >
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> > >
> > > The values are mapped one to one in vega20_get_smu_clk_index so just
> > > use the proper enums here.
> > >
> > > Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get
> > > socclk, fclk, dcefclk")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/587
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> >
> > Adding Kevin Wang for further review, as he sent a related patch in
> > d36893362d22 ("drm/amd/powerplay: fix smu clock type change miss
> > error")
> >
> > I assume this one is still required as it triggers the same warning.
> > Kevin, can you have a look?
> >
> >       Arnd
>=20
> Indeed, this one and https://github.com/ClangBuiltLinux/linux/issues/586
> are still outstanding.
>=20
> https://patchwork.freedesktop.org/patch/315581/
>=20
> Cheers,
> Nathan
>=20
> >
> > >  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > > b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > > index 0f14fe14ecd8..e62dd6919b24 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > > @@ -992,7 +992,7 @@ static int vega20_print_clk_levels(struct
> smu_context *smu,
> > >                 break;
> > >
> > >         case SMU_SOCCLK:
> > > -               ret =3D smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &=
now);
> > > +               ret =3D smu_get_current_clk_freq(smu, SMU_SOCCLK,
> > > + &now);
> > >                 if (ret) {
> > >                         pr_err("Attempt to get current socclk Failed!=
");
> > >                         return ret;
> > > @@ -1013,7 +1013,7 @@ static int vega20_print_clk_levels(struct
> smu_context *smu,
> > >                 break;
> > >
> > >         case SMU_FCLK:
> > > -               ret =3D smu_get_current_clk_freq(smu, PPCLK_FCLK, &no=
w);
> > > +               ret =3D smu_get_current_clk_freq(smu, SMU_FCLK, &now)=
;
> > >                 if (ret) {
> > >                         pr_err("Attempt to get current fclk Failed!")=
;
> > >                         return ret;
> > > @@ -1028,7 +1028,7 @@ static int vega20_print_clk_levels(struct
> smu_context *smu,
> > >                 break;
> > >
> > >         case SMU_DCEFCLK:
> > > -               ret =3D smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, =
&now);
> > > +               ret =3D smu_get_current_clk_freq(smu, SMU_DCEFCLK,
> > > + &now);
> > >                 if (ret) {
> > >                         pr_err("Attempt to get current dcefclk Failed=
!");
> > >                         return ret;
