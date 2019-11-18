Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0329DC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B624420727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ngwcYycY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKRGvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:51:02 -0500
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:27873
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726455AbfKRGvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:51:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV23dj1Ggr6ntbkdFJXnGGp3zb18PupoK9gOHd1vZqOGHB5k8DVxBXT6EBF2iLBGTQPvwDeOkrPOdIFcna11grd3JBpBPptlOtxs03Il/6YhUMKGZsvWEojP0Fay9lUYRbeUWKXIZfMQJtM1Jss+72xJdxvRcnRdmOUJ4UG+g+gIvWF8zmm4PSY3FcDGLgLq4FLJul5jJezgowCU7OiOhRK6j6/PGdGvowzn4560SHNBoxHLtI39K7jiQFM1dTWEqc8yHKS2SBBWH6HPk2rXqZygO4yMe7eJL7fo6C/iQ/qtoDH6zUpA/akNbeguhqsdXT/YrTo7+kUX/x/cFnPl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EzFrPcg+GyZUIjMtBwMcwwPeisOBWhjTTH6teWPvGw=;
 b=ekLzgbYQqg86OGjIcxJcPP1nRhytJ6UZEpGzWqCgl23Iqp+V7ujr6vRcXqxwERyKxEnTtfbLxsqDB/AI0JITEyAieEA+tu+g0KDvt4HctdKoYrSRS34WHg0v3FGaQpb4xqdJxsVu/AoF8MAbDcwf6GjOQ/Ku85bw4vR1ntO+D30p08Je9hbj3L6mhrzoTa+fFf40kQgky60i1UU7fzjWzqjgkC2TV6nuJM/pvT7gejpFKIntkkZVEMuwK81DuG/bwfagFES0qZIfm8aAIsJdb0o4YmMr6pOnKz+vzoexmwAns2kpC69KsuPhPZcn6erKc8ij/DlkPLqsAqrFAdR00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EzFrPcg+GyZUIjMtBwMcwwPeisOBWhjTTH6teWPvGw=;
 b=ngwcYycY7J7pW6XFpkiJ8RomolIbEe7spkl4WW69NMPQEkygZ+jeLsLg5QyWpUK28lPycTTMrWZcPQbY4AOWW93ZWxP8hbTmqZYXdq7LKNawZ4N+4qGS9iiJZvb/Ob4lrMEOOKmB8BuRrJjjAg1d/Q9f0g/C5VSFqImGyoSEXqM=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3615.namprd12.prod.outlook.com (20.178.242.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Mon, 18 Nov 2019 06:50:59 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 06:50:59 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Chen Wandun <chenwandun@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/powerplay: remove variable 'result' set but not
 used
Thread-Topic: [PATCH] drm/amd/powerplay: remove variable 'result' set but not
 used
Thread-Index: AQHVnC8Oclf/tFGPi0+u1HbEf6MU6aeQgDVw
Date:   Mon, 18 Nov 2019 06:50:58 +0000
Message-ID: <MN2PR12MB3344A9DA952F41ADDAD6142AE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
In-Reply-To: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3470124-9819-4839-1066-08d76bf3ab3c
x-ms-traffictypediagnostic: MN2PR12MB3615:|MN2PR12MB3615:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB361583EA28DF3BE59D456DCCE44D0@MN2PR12MB3615.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(13464003)(229853002)(99286004)(81166006)(316002)(6116002)(5660300002)(110136005)(52536014)(2906002)(478600001)(25786009)(305945005)(3846002)(14444005)(486006)(256004)(33656002)(74316002)(2501003)(476003)(446003)(76116006)(11346002)(66066001)(53546011)(6506007)(71200400001)(6436002)(76176011)(7696005)(71190400001)(8676002)(6246003)(26005)(2201001)(7736002)(14454004)(186003)(64756008)(66556008)(66946007)(66446008)(66476007)(86362001)(81156014)(102836004)(19627235002)(8936002)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3615;H:MN2PR12MB3344.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eH1OxXICGa53dCidScnpA17a+izYkDaMQU2acCfNA48NRQ13QzGEZI7O8IUjam8Iue/Ejlj4mx3jMn66CB22aIE7Q2ZGCyBLwQOguKcoRoieKguejNF7B1sapiwNys06Vl48Ixyj1WdKUDnhT8J7vBzl3EEMMJhAJdfXKHF+1wNo0WF/Y7Yj9jS+luzPRoXAw/m3c6EBBF7KfKe6/lPHXVzEmOuaG4HzudsP+arXpVLnFxYTrQ2n/K5+zD2K1b7vYAU6DMA8WiVRC/67LyD5MI1WZvQPQHFJX4hJ9H/Yc5XOj9YlG7Nwqwefpk5fXpHc9BToslVsWv67DiimNvmHslXs4BOX03ikFG02pm6xCfVlXZ9jr7ILKdOEHWn9QA6W/FaFLAnq+3L+X5KKINdk7Hg81snw7dO9wTEWRL94aabhS61/p4wmE38ZQW25nQJT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3470124-9819-4839-1066-08d76bf3ab3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 06:50:58.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSxKlKz8ZbtcqC/XEYrbWk7uRBCA/uHChUNJ8zufZTB5B1ScX+vUcPZn/47g08m5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. But it's better to return the 'result' out on 'result !=3D 0'.

Regards,
Evan
-----Original Message-----
From: Chen Wandun <chenwandun@huawei.com>=20
Sent: Saturday, November 16, 2019 11:43 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; li=
nux-kernel@vger.kernel.org
Cc: chenwandun@huawei.com
Subject: [PATCH] drm/amd/powerplay: remove variable 'result' set but not us=
ed

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In function =
vegam_populate_smc_boot_level:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:6: warni=
ng: variable result set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 2068eb0..fad78bf 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1361,20 +1361,19 @@ static int vegam_populate_smc_uvd_level(struct pp_h=
wmgr *hwmgr,
 static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 		struct SMU75_Discrete_DpmTable *table)
 {
-	int result =3D 0;
 	struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
=20
 	table->GraphicsBootLevel =3D 0;
 	table->MemoryBootLevel =3D 0;
=20
 	/* find boot level from dpm table */
-	result =3D phm_find_boot_level(&(data->dpm_table.sclk_table),
-			data->vbios_boot_state.sclk_bootup_value,
-			(uint32_t *)&(table->GraphicsBootLevel));
+	phm_find_boot_level(&(data->dpm_table.sclk_table),
+			    data->vbios_boot_state.sclk_bootup_value,
+			    (uint32_t *)&(table->GraphicsBootLevel));
=20
-	result =3D phm_find_boot_level(&(data->dpm_table.mclk_table),
-			data->vbios_boot_state.mclk_bootup_value,
-			(uint32_t *)&(table->MemoryBootLevel));
+	phm_find_boot_level(&(data->dpm_table.mclk_table),
+			    data->vbios_boot_state.mclk_bootup_value,
+			    (uint32_t *)&(table->MemoryBootLevel));
=20
 	table->BootVddc  =3D data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
--=20
2.7.4

