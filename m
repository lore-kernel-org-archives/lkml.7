Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16792C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF4320727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jrCTvTe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKRIPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:15:41 -0500
Received: from mail-eopbgr720064.outbound.protection.outlook.com ([40.107.72.64]:19799
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfKRIPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:15:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVn4yVq76ggkGxp8M+twEsohTiQMWGZSJ8BoRAtN60CDFlE8/Ty+xyQm7lsIKprnVwtleXyNTGcapfb/rx9+ZkzzwMzn6//K0POPqhQ32jsOf4/jRg3PRLkWYUNNJxGWq+9LfrSJxf+JQpVHQoSKGYmToPs58H46lrNz5TR7RE0A4z6VSuXgbO2/WCqu80QTQFZquZ8tH10qz8hgBsK/px88v25RTNgmXFoKfPmIitlanja5jLb6PwQqADuYnPQMeJe/27At+V0BcWwkFvmkDXPltXCkE/0TaEOu5f/a7OkBXKb+4QJK3/XuyX1f33jBoZfakekrsN/UQ0irFCxFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co0kwY1itMIE46cZm8A+BywABH6YDQFWwfxCH87UxaQ=;
 b=L3bDAHbkhKlr8AC1LY9rVpS6pXNeVvCY7tGAtu3uy+zFM7soY/JxASXt8zbKsclY84q1xywqhsbgkJBu6JGe+/SqZnqGgxeZ6uIBjox22g+U1UahwkvHGwcTjhSCVNfJEjstr61ctaQwlSVyC7+118QM3exQ32pL4uHnrTt0J5jBk1Feoy5opjcCANkr8FUxuPjzzEUW2s2KqgRna+KhCOikFkgNSSum8ohX3ex5LcUhOnHVOdbuJVK0u5h1bkhD4n6qBHSXBCPqFtXQ+KI8J/v4uwYgWI82zjcR+L1kxZ3GWnCM9AnAUW4dKgfXgJaVnwB5eKiVjFE+qLHj0VL/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co0kwY1itMIE46cZm8A+BywABH6YDQFWwfxCH87UxaQ=;
 b=jrCTvTe+p0nVGNZg60KikmBHz3VuxQ4W6RpyUL1D97bHyr9TzaIjZWKaz/mfzKS9H30hE9esqLoZ8qGQv8QgrS/3Ikis8LywZGfECOoXdRrJjxUf603VatWcD3wYQbLgh7paa3TC0uRXSIX7oDerqxEDqD2HMiuU0fAYiwVLl+E=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4206.namprd12.prod.outlook.com (52.135.49.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Mon, 18 Nov 2019 08:15:38 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 08:15:38 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Chen Wandun <chenwandun@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/powerplay: return errno code to caller when
 error occur
Thread-Topic: [PATCH v2] drm/amd/powerplay: return errno code to caller when
 error occur
Thread-Index: AQHVneW4BAJGGH03hUSa3MUMgxEJ0KeQlNEg
Date:   Mon, 18 Nov 2019 08:15:38 +0000
Message-ID: <MN2PR12MB3344BBBA7F72F9625D71329EE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
 <1574064214-109525-1-git-send-email-chenwandun@huawei.com>
In-Reply-To: <1574064214-109525-1-git-send-email-chenwandun@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc4c40a6-8c35-4659-930c-08d76bff7edf
x-ms-traffictypediagnostic: MN2PR12MB4206:|MN2PR12MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4206ADFF72893D44C227D727E44D0@MN2PR12MB4206.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(13464003)(199004)(189003)(6506007)(256004)(14444005)(478600001)(99286004)(7696005)(74316002)(9686003)(6246003)(53546011)(7736002)(26005)(305945005)(110136005)(2201001)(14454004)(76176011)(102836004)(66946007)(66446008)(64756008)(66556008)(66476007)(2501003)(8676002)(81166006)(446003)(66066001)(11346002)(86362001)(81156014)(33656002)(52536014)(6436002)(76116006)(229853002)(316002)(486006)(5660300002)(8936002)(186003)(71200400001)(6116002)(55016002)(3846002)(71190400001)(25786009)(2906002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4206;H:MN2PR12MB3344.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvBNAerKPvADkz0jJsMfNla91bLyDhfJLRlh87bI12VkHK2EU9sSmlZmrlV2NYgIDnuwBrT7tGsz/1dhk+WdeTJzlCR+CQF4KyBp1KWhNlRvjVuMA/Xu5nTUy/ZpHwpW5A21fzL1A3VBsHQlvBYW5SVjdEJScubweRKbcxJSkc5UbKbp8oYAtSbzwssvl2D43nRRwPym69HmHqBc4KJ3qfEqZKEc9VKYD90G6wcods8FmarXc18P808X2dAiVR/JI5+5Yl++0nv9IEY/ca4HH5cjpVlCW35Y+RrNwfq+cRLltUlSm9D6nOlaorI28LsiyAhdGkclf0FCv6XXOLH+qipKa4wcFwZueOPR+sYANwmLBY7elUnBqjsNHKXyjomX/MAgsuC2rj+zbznGcao4xlFbOoS8dBNgocJe4S6iG+vjFvUMJUbdug+tOGsIpjHR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4c40a6-8c35-4659-930c-08d76bff7edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:15:38.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94lW14cC3njVn1NMFiQbxgHFYiSrx1UqowZa+VG9ON1+FOVpz5bMWNHBFJe8jTo2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Chen Wandun <chenwandun@huawei.com>
> Sent: Monday, November 18, 2019 4:04 PM
> To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; dri-devel@lists.freedesktop.org
> Cc: chenwandun@huawei.com
> Subject: [PATCH v2] drm/amd/powerplay: return errno code to caller when
> error occur
>=20
> return errno code to caller when error occur, and meanwhile remove gcc '-
> Wunused-but-set-variable' warning.
>=20
> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In
> function vegam_populate_smc_boot_level:
> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:
> 6: warning: variable result set but not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> index 2068eb0..50896e9 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> @@ -1371,11 +1371,16 @@ static int vegam_populate_smc_boot_level(struct
> pp_hwmgr *hwmgr,
>  	result =3D phm_find_boot_level(&(data->dpm_table.sclk_table),
>  			data->vbios_boot_state.sclk_bootup_value,
>  			(uint32_t *)&(table->GraphicsBootLevel));
> +	if (result)
> +		return result;
>=20
>  	result =3D phm_find_boot_level(&(data->dpm_table.mclk_table),
>  			data->vbios_boot_state.mclk_bootup_value,
>  			(uint32_t *)&(table->MemoryBootLevel));
>=20
> +	if (result)
> +		return result;
> +
>  	table->BootVddc  =3D data->vbios_boot_state.vddc_bootup_value *
>  			VOLTAGE_SCALE;
>  	table->BootVddci =3D data->vbios_boot_state.vddci_bootup_value *
> --
> 2.7.4

