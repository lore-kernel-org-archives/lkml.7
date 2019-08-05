Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADCBC19759
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B47220B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K4A4n8xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfHEBVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 21:21:09 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:22784
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbfHEBVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 21:21:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMQytuQC8j4YORt9KpjAlt58kZDdFJL9BVnAqsLWTpCcxEI1iE9jh4WLsZq+WG3+BAkVUM+Zfp9k1AAwhk9JPx+PWQ1yQHlrb2n5p9rbi02lpIThCuYSq9G4sVaA0C4RokfyiddnPcuFhizt1xUb4ZFQYKSdkfiY93wuRQulPOFBCc3qwjjR4GNXU2ckiIlppjT6ezX3cSok49zvHzF5cLt53VqlkjGX2k4mJ3KOvfDytmu+8WrURUNViBmDg+CuH515DV3IEaJjObl0r3Kz7KrJHjQYnDaEoaQmP1FAq2jqTcf+6klTnqzRbYqn2Kol8fN5t/CKZgtDb77qSDOzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//eIfGumUqGY4eS+WJUNWHG4yIQcggsiHZv79Ti0IXA=;
 b=ngYlFbC2wcl91dztVKfMieO3Rmm42B4eBMziJU2uiGhJJLy2Lu+PW9A2X0tfu+tRqVkTQuP3bldtj3SI807eE8qVnVPkQsGbUuezYonP8bfh13rAd4zl6nXVZwW7Fqigpkyd7QQ2fnLVmHoWOEVzwV583LYcX1M17WQQqm1v85v5YJt+XlffQewgej67q3mu5+wBoY8y93/njmEbddQNMjPo4ZodH8IgCodDBJHfTa+7cS/jJlq3Omd2Wc1pAuhUTx5mT/X1DODyL93DcF/f/WHqg32sg2Y1/NIY0WvysaorGUA55i5spRf4pxDN6A/ckGmJTVGlFiZmOqTr2r4NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//eIfGumUqGY4eS+WJUNWHG4yIQcggsiHZv79Ti0IXA=;
 b=K4A4n8xhcz5xoX6HcUzxk27hMhiF5SKektFdFNchUb9H3fSyLHPmnUKCnaCMyIKHEOBKDWxPsX5xyfLLjeo39rvSTv0vFI7zB2vap35dDXqjTjBFtbKLjz/8LKQlXKYPIvrVe/886dG3SPos4aj+oGWQJCA9rOirixYwvHcCVKw=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4208.namprd12.prod.outlook.com (10.255.224.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 01:21:06 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::bd9b:19ce:ef42:ab26]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::bd9b:19ce:ef42:ab26%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 01:21:06 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] drm/amd/powerplay: Zero initialize some variables
Thread-Topic: [PATCH] drm/amd/powerplay: Zero initialize some variables
Thread-Index: AQHVSwR3BVBtbsqdn0qOQ80AgffoNqbrwc9Q
Date:   Mon, 5 Aug 2019 01:21:06 +0000
Message-ID: <MN2PR12MB3344B936DC2DBD85443C6AC7E4DA0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20190804203713.13724-1-natechancellor@gmail.com>
In-Reply-To: <20190804203713.13724-1-natechancellor@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d641ff65-0108-4a77-f91b-08d7194330b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB4208;
x-ms-traffictypediagnostic: MN2PR12MB4208:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR12MB420862FCBC030A25B98CF4F0E4DA0@MN2PR12MB4208.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(13464003)(6636002)(305945005)(68736007)(6506007)(102836004)(53546011)(76176011)(186003)(26005)(33656002)(8936002)(81166006)(81156014)(8676002)(486006)(446003)(11346002)(476003)(14444005)(110136005)(54906003)(7696005)(5660300002)(99286004)(14454004)(966005)(256004)(3846002)(6116002)(7736002)(316002)(71200400001)(71190400001)(2906002)(52536014)(74316002)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(478600001)(6246003)(25786009)(4326008)(86362001)(229853002)(6306002)(9686003)(6436002)(55016002)(53936002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4208;H:MN2PR12MB3344.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PCxYWwZaQcgzMm1pp9eEwQJd8E+IQUOx54dc8fvHOAT4SoxPoZuYt1yLeGxaeRZVgquq87+43HCxRU7hwqEHpNVwldIR163u68cWF170ey7zMWFsL2lrGh2ygwrkuLmVwP42O1GAy7ox3lc4Hl64L8P+mDAwZkbALhXsaSRcacilCSud6PvtWvBEGGmlI+75r1vgCJgPNqOG0L5dGXfVPCRrrc9xCbhkiE98fULEDMoeQ4duJF0D/RA9RUr+lUBqWIfxIKqoL8LepB1rXScTaCzVrSnttwSR67jY0arjKdbediuczH0Nec9t6mvS5pyuOqon1fbbrwtORH6Rtpt3OPiijfnv15CPhplMFyPP7CLJKMguZHND1gaNkSCP5Huig984WrvokNEKRYX8PoKmyu/FJJ/uJMafHOK/UN+vqR4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d641ff65-0108-4a77-f91b-08d7194330b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 01:21:06.4738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: equan@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nathan. The patch is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Nathan Chancellor <natechancellor@gmail.com>
> Sent: Monday, August 05, 2019 4:37 AM
> To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux=
-
> kernel@vger.kernel.org; clang-built-linux@googlegroups.com; Nathan
> Chancellor <natechancellor@gmail.com>
> Subject: [PATCH] drm/amd/powerplay: Zero initialize some variables
>=20
> Clang warns (only Navi warning shown but Arcturus warns as well):
>=20
> drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1534:4: warning:
> variable 'asic_default_power_limit' is used uninitialized whenever '?:'
> condition is false [-Wsometimes-uninitialized]
>                         smu_read_smc_arg(smu, &asic_default_power_limit);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:588:3:
> note:
> expanded from macro 'smu_read_smc_arg'
>         ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu),
> (arg)) : 0)
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1550:30: note:
> uninitialized use occurs here
>                 smu->default_power_limit =3D asic_default_power_limit;
>                                            ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1534:4: note:
> remove the '?:' if its condition is always true
>                         smu_read_smc_arg(smu, &asic_default_power_limit);
>                         ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:588:3:
> note:
> expanded from macro 'smu_read_smc_arg'
>         ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu),
> (arg)) : 0)
>          ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1517:35: note:
> initialize the variable 'asic_default_power_limit' to silence this warnin=
g
>         uint32_t asic_default_power_limit;
>                                          ^
>                                           =3D 0
> 1 warning generated.
>=20
> As the code is currently written, if read_smc_arg were ever NULL, arg wou=
ld
> fail to be initialized but the code would continue executing as normal
> because the return value would just be zero.
>=20
> There are a few different possible solutions to resolve this class of war=
nings
> which have appeared in these drivers before:
>=20
> 1. Assume the function pointer will never be NULL and eliminate the
>    wrapper macros.
>=20
> 2. Have the wrapper macros initialize arg when the function pointer is
>    NULL.
>=20
> 3. Have the wrapper macros return an error code instead of 0 when the
>    function pointer is NULL so that the callsites can properly bail out
>    before arg can be used.
>=20
> 4. Initialize arg at the top of its function.
>=20
> Number four is the path of least resistance right now as every other chan=
ge
> will be driver wide so do that here. I only make the comment now as food =
for
> thought.
>=20
> Fixes: b4af964e75c4 ("drm/amd/powerplay: make power limit retrieval as
> asic specific")
> Link: https://github.com/ClangBuiltLinux/linux/issues/627
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 215f7173fca8..b92eded7374f 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -1326,7 +1326,7 @@ static int arcturus_get_power_limit(struct
> smu_context *smu,
>  				     bool asic_default)
>  {
>  	PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> -	uint32_t asic_default_power_limit;
> +	uint32_t asic_default_power_limit =3D 0;
>  	int ret =3D 0;
>  	int power_src;
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 106352a4fb82..d844bc8411aa 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1514,7 +1514,7 @@ static int navi10_get_power_limit(struct
> smu_context *smu,
>  				     bool asic_default)
>  {
>  	PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> -	uint32_t asic_default_power_limit;
> +	uint32_t asic_default_power_limit =3D 0;
>  	int ret =3D 0;
>  	int power_src;
>=20
> --
> 2.23.0.rc1

