Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A299C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAC12084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LPGA0H2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEOJxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:53:37 -0400
Received: from mail-eopbgr820085.outbound.protection.outlook.com ([40.107.82.85]:44000
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfEOJxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or52atg8YJnOTTBGFPQiFNxPXaFfve+O3QanFTK33VE=;
 b=LPGA0H2QgVlutUBy48zTaj3to2bhXS8SoQr3yl9BWkj7wTqZIUt+CTwlUnpqzMK4fiprmSuvXd9895dVavsMEhvVWFaTcYAQtDIut5MaRSMHASHtFzHpGDzdjenyKkhrqa0jpvfBaS/hFsZ6XTx8EFHdBMjs7WAF48qwhfTHL4g=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3647.namprd12.prod.outlook.com (20.178.241.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Wed, 15 May 2019 09:53:34 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::2918:1f51:2768:efc0]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::2918:1f51:2768:efc0%3]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 09:53:34 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
CC:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Gao, Likun" <Likun.Gao@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/powerplay: fix locking in
 smu_feature_set_supported()
Thread-Topic: [PATCH] drm/amd/powerplay: fix locking in
 smu_feature_set_supported()
Thread-Index: AQHVCwPOpB/hJLSRrUiLtn9T08l916Zr8bjw
Date:   Wed, 15 May 2019 09:53:33 +0000
Message-ID: <MN2PR12MB33099BF7946484E6AE1F75F5EC090@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20190515095130.GF3409@mwanda>
In-Reply-To: <20190515095130.GF3409@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7dcbf1f-96d1-4da5-9e6a-08d6d91b31b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3647;
x-ms-traffictypediagnostic: MN2PR12MB3647:
x-microsoft-antispam-prvs: <MN2PR12MB364730FBD7903C81C0FF29F6EC090@MN2PR12MB3647.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(136003)(376002)(189003)(199004)(13464003)(74316002)(25786009)(478600001)(6246003)(68736007)(53936002)(86362001)(99286004)(6636002)(66066001)(71200400001)(71190400001)(54906003)(72206003)(305945005)(110136005)(7736002)(14444005)(76176011)(256004)(7696005)(52536014)(446003)(26005)(186003)(11346002)(14454004)(486006)(476003)(66476007)(66556008)(64756008)(66446008)(66946007)(73956011)(8676002)(55016002)(81156014)(8936002)(316002)(6506007)(102836004)(53546011)(9686003)(81166006)(5660300002)(229853002)(4326008)(6116002)(3846002)(2906002)(76116006)(33656002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3647;H:MN2PR12MB3309.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tak69VBt5fKPVC92dIaWuSQRgSJKy8YsWB6/0DRZ6DgBY0ywYlTM0ISM2t5HVHda6wWqId7foMbQPWBQAllHmwk9mUFp5q/XJv4r0By9BJ/ScxUYT6S8p83iSfEh3U9J1IlU0UMJMOzLVMQFCifaOP1ELb1b8Oxwurn4vXEiLWe16S/NOzSLQCckuY2ugnqKpaEfrNus4SHZjaCwWrtqlwcMgoF3daaH1xjoNRy7b8JTlXb8j73K9lClObfpfQYgGhgM4IaWEAUVdGT7pdXq9YS3dMN2Fp7G5Nr2hG2zLvJP1CsCbDMN0mrOpnL89gqKh3NRknixGDYQW2HsgRXpiYYiaSPRV4YXq6p5ujYq9SLow3+OCQppi5+bxNyeSwGIrX1Re+N64CCoeu7HrYZgph6p0qJLk/Eh4Ga5wCMt9lE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dcbf1f-96d1-4da5-9e6a-08d6d91b31b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 09:53:33.9403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, May 15, 2019 5:52 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang)
> <Kevin1.Wang@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
> <daniel@ffwll.ch>; Huang, Ray <Ray.Huang@amd.com>; Gao, Likun
> <Likun.Gao@amd.com>; Gui, Jack <Jack.Gui@amd.com>; amd-
> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] drm/amd/powerplay: fix locking in
> smu_feature_set_supported()
>=20
> There is a typo so the code unlocks twice instead of taking the lock and =
then
> releasing it.
>=20
> Fixes: f14a323db5b0 ("drm/amd/powerplay: implement update enabled
> feature state to smc for smu11")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20

Thanks!
Reviewed-by: Huang Rui <ray.huang@amd.com>

Will apply it.

---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 52d919a8b70a..85ac29af5363 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -310,7 +310,7 @@ int smu_feature_set_supported(struct smu_context
> *smu, int feature_id,
>=20
>         WARN_ON(feature_id > feature->feature_num);
>=20
> -       mutex_unlock(&feature->mutex);
> +       mutex_lock(&feature->mutex);
>         if (enable)
>                 test_and_set_bit(feature_id, feature->supported);
>         else
> --
> 2.20.1

