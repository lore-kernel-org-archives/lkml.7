Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C631C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155D92085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Poso5qek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfFRCE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:04:29 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:42308
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfFRCE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1gPkWf2OhZMHMJItTPjZUV5e5pbdgyMURS4PMZLy8Q=;
 b=Poso5qek5EBM1UgnJ7sFj6HQha370kKF+kRChK89cioEjZaiLGbZN8TfUqxQeQ41OKRtwzmEPifgV9dq6Whng0JM3Pg5PnGC3jyu+63DB995z8U/Mf8s6g+g6daVq0DZf6D4J6FgAJ0RjyUNBu99YJB0nlRbB1x0MyRgJjBZpE0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4688.eurprd08.prod.outlook.com (10.255.115.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Tue, 18 Jun 2019 02:04:25 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 02:04:25 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: fix size_t format string
Thread-Topic: [PATCH] drm/komeda: fix size_t format string
Thread-Index: AQHVJXojg0qTn3QqBEKaMAcl4INAHA==
Date:   Tue, 18 Jun 2019 02:04:25 +0000
Message-ID: <20190618020419.GA32081@james-ThinkStation-P300>
References: <20190617125002.1312331-1-arnd@arndb.de>
In-Reply-To: <20190617125002.1312331-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0037.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::25) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1ab9b1a-21f3-443d-914e-08d6f391499a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4688;
x-ms-traffictypediagnostic: VE1PR08MB4688:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4688D013A228CCC1665BE020B3EA0@VE1PR08MB4688.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(76176011)(25786009)(33716001)(478600001)(6246003)(99286004)(52116002)(256004)(58126008)(476003)(316002)(54906003)(229853002)(6486002)(11346002)(486006)(33656002)(1076003)(6436002)(14444005)(446003)(4326008)(6506007)(26005)(5660300002)(66066001)(6512007)(9686003)(66476007)(66446008)(66556008)(64756008)(81166006)(53936002)(71200400001)(71190400001)(8936002)(81156014)(3846002)(6116002)(386003)(86362001)(55236004)(186003)(8676002)(102836004)(66946007)(68736007)(14454004)(6916009)(2906002)(305945005)(73956011)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4688;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 362ea+5iBYmi2FARug+F/Kfuc+PjmZjN2uxZjoe/U5gBT0Ca7PsMc8A0QCwBnFmKn+Tyk/IyBo5LfTpTybq66Udgteq9STH17XlU96YMIBk/SdfyGL3LhJLyySCvzCK1mVLIUVQ9qpVPLe1w0QEWmXQQPKjKe910wVnWmq4Kl8MT+z5LV53WtdO+vSJT2ehQ49MGm7n32nuE2pkgPRAPa4ibnsuEmDjejQ3K2FoyCDLC2+rdd4VTT6QEitQhtUXvo/k8Et2BX2Zvt2aJbv4+ucUJnSBkUbC3GEtw/a71gmjkHFK/wXQ2JyOmfIZVQLMHftiKluCLtZuF136WPPDbAnquP+v3KLuvu9UCsWWox/vQ0nGylmH5+O8DQBCtk9W2KejA6qxabMvo9T4U/cNjAyT4Hsivw85+zSPWIxsrHBg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0DC416FE603794797027DA83D782A1C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ab9b1a-21f3-443d-914e-08d6f391499a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 02:04:25.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:49:18PM +0200, Arnd Bergmann wrote:
> The debug output uses the wrong format string for printing a size_t:
>=20
> In file included from include/drm/drm_mm.h:49,
>                  from include/drm/drm_vma_manager.h:26,
>                  from include/drm/drm_gem.h:40,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_framebuff=
er.c:9:
> drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c: In function 'kom=
eda_fb_afbc_size_check':
> drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c:96:17: error: for=
mat '%lx' expects argument of type 'long unsigned int', but argument 3 has =
type 'size_t' {aka 'unsigned int'} [-Werror=3Dformat=3D]
>    DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.=
\n",
>=20
> This is harmless in the kernel as size_t and long are always the same
> width, but it's always better to use the correct format string
> to shut up the warning.
>=20
> Fixes: 9ccf536e53cb ("drm/komeda: Added AFBC support for komeda driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index abc8c0ccc053..58ff34e718d0 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -93,7 +93,7 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct=
 drm_file *file,
>  			       AFBC_SUPERBLK_ALIGNMENT);
>  	min_size =3D kfb->afbc_size + fb->offsets[0];
>  	if (min_size > obj->size) {
> -		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.=
\n",
> +		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%zx. min_size 0x%x.=
\n",
>  			      obj->size, min_size);
>  		goto check_failed;
>  	}
> @@ -137,7 +137,7 @@ komeda_fb_none_afbc_size_check(struct komeda_dev *mde=
v, struct komeda_fb *kfb,
>  		min_size =3D komeda_fb_get_pixel_addr(kfb, 0, fb->height, i)
>  			 - to_drm_gem_cma_obj(obj)->paddr;
>  		if (obj->size < min_size) {
> -			DRM_DEBUG_KMS("The fb->obj[%d] size: %ld lower than the minimum requi=
rement: %d.\n",
> +			DRM_DEBUG_KMS("The fb->obj[%d] size: %zd lower than the minimum requi=
rement: %d.\n",
>  				      i, obj->size, min_size);
>  			return -EINVAL;
>  		}
> --=20
> 2.20.0


Hi Arnd:

Thank you for the patch.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
