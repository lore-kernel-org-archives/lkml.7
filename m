Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E521DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4B32166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TOU0VTjD";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TOU0VTjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbfHWKm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:42:26 -0400
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:65253
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388655AbfHWKm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm1fGWizb/ofhSVFvcrNodhdKBtKzz4hQln2RMmx7rM=;
 b=TOU0VTjDXXJn9qs6Fo+WpW9BjFb5q6o9/XeLsUpTUxDc2XvrFeQAnQYosObdH0Ujsl+fmylJ6NReOOE630uHOQWAn6DONRZcT5fZzYm6xKxgrjS3P6mCbshvM81l9n9pHqZeSnhu0VgjYLF0CUbgopIJjwoa+wt3+C5E89YbJPM=
Received: from VI1PR08CA0172.eurprd08.prod.outlook.com (2603:10a6:800:d1::26)
 by VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Fri, 23 Aug
 2019 10:42:20 +0000
Received: from DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR08CA0172.outlook.office365.com
 (2603:10a6:800:d1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.15 via Frontend
 Transport; Fri, 23 Aug 2019 10:42:20 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT017.mail.protection.outlook.com (10.152.20.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.13 via Frontend Transport; Fri, 23 Aug 2019 10:42:18 +0000
Received: ("Tessian outbound 3aa685aedf5f:v27"); Fri, 23 Aug 2019 10:42:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: adf5da64737cd5b5
X-CR-MTA-TID: 64aa7808
Received: from f6e400b0c469.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A1ECB646-8F0F-4708-ABAE-CF45FA30FBB2.1;
        Fri, 23 Aug 2019 10:42:07 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2051.outbound.protection.outlook.com [104.47.4.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f6e400b0c469.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 23 Aug 2019 10:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju5GJDjQZCu5iKyaZjE0GsJwjhfJxnUy7IG0uWDwr/WJ8/GLnYD4P6kC55EkyzyKdSsSbrRCEpq8jVU2ULAIcpikP5FtjXkGXY+QLNZM+dFl8vU4/Wj+WJ3gJPAJSfrxIFlfNG1dxtSVXlmHtOy04483lX4ZhbaaZ+4GcDlFnbLwYfi30QQt+5upZqZPFjHpcd3qnM2+3g23ZzOAuIBc72NputUhorYUoMoJdfO+mKYMM3Z4g0xAwaW23O0QSoJGojUytXT0VVxDXwYMmrrantMFcGE2ZkCEU+gNRL5TrqaV9ErggAE0/11Gk+8MvL37ikcFs1jtmSdSDCnlnCHecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm1fGWizb/ofhSVFvcrNodhdKBtKzz4hQln2RMmx7rM=;
 b=QMr4gZHEeclGQQXkIdgk8ELSz6K2NdmhNnCzoBfx5k4MriZy71R9E7Jz/bcfsx4EyUJFfO2Tcruht/g36Qbx0s4JpeDgfUZX9Chq03eFS9wOzue0EhP8xlNLqCORyggsBMuUyGOCkpWVFAumz9P7SxGSL/VYL4F5EbECsel95T2ogRm/mtzUiD8vhJUuBgbWnFhMt+geIWxpaZDAcT1PwUmcCaeucdTQq0KQIn3rbHjMApGs/9sEY8I+dLSaM3i0V0MkZ5TAsziSzyzMEkGoXFYla+GO1hRBoX4eeAcJTX1znjHR0IHtxxjY2Iq/LoRTdbyDjig7LpNW0fslGD0gxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm1fGWizb/ofhSVFvcrNodhdKBtKzz4hQln2RMmx7rM=;
 b=TOU0VTjDXXJn9qs6Fo+WpW9BjFb5q6o9/XeLsUpTUxDc2XvrFeQAnQYosObdH0Ujsl+fmylJ6NReOOE630uHOQWAn6DONRZcT5fZzYm6xKxgrjS3P6mCbshvM81l9n9pHqZeSnhu0VgjYLF0CUbgopIJjwoa+wt3+C5E89YbJPM=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3021.eurprd08.prod.outlook.com (52.133.14.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 10:42:04 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 10:42:04 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Reordered the komeda's de-init functions
Thread-Topic: [PATCH] drm/komeda: Reordered the komeda's de-init functions
Thread-Index: AQHVV38sxxLTSIs2FkGlnIkeXiN2EqcIj86A
Date:   Fri, 23 Aug 2019 10:42:04 +0000
Message-ID: <8379636.aKIvcsjXCK@e123338-lin>
References: <20190820174606.1133-1-ayan.halder@arm.com>
In-Reply-To: <20190820174606.1133-1-ayan.halder@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: eb37b8be-44e4-4e9f-1498-08d727b6924b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3021;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3021:|VE1PR08MB4959:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4959285432A0ADEBBC66E4AE8FA40@VE1PR08MB4959.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:101;OLM:101;
x-forefront-prvs: 0138CD935C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(486006)(14444005)(5024004)(305945005)(66446008)(256004)(102836004)(478600001)(66066001)(52116002)(66946007)(66476007)(6246003)(66556008)(64756008)(99286004)(71190400001)(229853002)(7736002)(71200400001)(6862004)(33716001)(76176011)(5660300002)(476003)(81156014)(8676002)(81166006)(9686003)(6512007)(25786009)(6436002)(6116002)(14454004)(3846002)(446003)(2906002)(54906003)(186003)(53936002)(316002)(8936002)(26005)(4326008)(6506007)(386003)(86362001)(6636002)(11346002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3021;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: B7IDKeYZ/rKx2ReyszoQGajjB/t4KXyiaLzXtdxOqyPAr1zSgqNFdv6rtjxl774DXMgCzkiXC/72mzYpU2HMkvdI2P5a5F9sr1uI1sizi5LUX6AHFCiH6stqO4Lw6DpL64KBb+Xyt7rNDCPsPbWgbjKvWMda6T55UAS7ZqHgl0SaRUVgz+tytReee31mrQ1CJPwH6VMfWyCa1BiPq/fJ5bWyzt36DrVAN6TtjLCmeitrMY68HYrdgN1cC5maWFDRtzgtRZCBcgOX8HbIW65yWjEeycFvxjqda8tiTGCLsLYKsVVt5P48qMPq6pkvzS3uLGnbKRy/kxUQGlO/awm7VnWYr1CUhNr/bQUt41k0TjOCTM/UJodfGJIXvLbrz233FVY0xz/TvU4o5+TL3zrOV+fm2MuT2sB9mlXSEM7X+J4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D84151055F5D94C9E17C14BD66C5492@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3021
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(199004)(189003)(76176011)(26826003)(102836004)(6636002)(50466002)(6512007)(9686003)(386003)(6506007)(14454004)(33716001)(47776003)(66066001)(486006)(356004)(6486002)(229853002)(478600001)(446003)(476003)(11346002)(126002)(25786009)(6116002)(14444005)(5024004)(8676002)(23726003)(86362001)(22756006)(63370400001)(46406003)(336012)(5660300002)(6246003)(6862004)(316002)(63350400001)(8936002)(305945005)(70206006)(2906002)(70586007)(4326008)(54906003)(8746002)(76130400001)(81166006)(81156014)(3846002)(7736002)(99286004)(26005)(97756001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4959;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d588bd01-5e90-47a3-0e5c-08d727b6899a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VE1PR08MB4959;
NoDisclaimer: True
X-Forefront-PRVS: 0138CD935C
X-Microsoft-Antispam-Message-Info: lqvUATxfo5GEbTT2kOl037VnEqA5DgPH+AFGCUcblC0sIHFOShEFt/jNIFeJ/XqwoL33U6tRFf/RIWN8OCMIS4LZgZt+1GsiHfJQIDSo76NWkpCwnV8jadkdssK8d0KVp9iSqhr4dbfzvarr1j0zVjL7oGA3dgZDHIMudfyA8rB1VuKUtFNVhx6o1B0eiVKX2WwBpG9ihmsn6D5d+RTdjMKVRYh33VLeyGpyzEmilEXbaKRhYNFYKfyTIK5PZ+mz9rx/PMcsNx0iirILc2FwhMUwFM9DjMgBs5LEF5Hr6FmViKFbZI0d6FLQ4DBN6VB6NRkO4SG11cxcz0LJOaL0GRjBliFj5WI67cuOCJxoUJl/penSyH2BwiV1sKQdIEedoCA03orYDkWCgxDGJXAZaWvdXVQAzpIyOyC7dhUgLho=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2019 10:42:18.7589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb37b8be-44e4-4e9f-1498-08d727b6924b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 20 August 2019 18:46:19 BST Ayan Halder wrote:
> The de-init routine should be doing the following in order:-
> 1. Unregister the drm device
> 2. Shut down the crtcs - failing to do this might cause a connector leaka=
ge
> See the 'commit 109c4d18e574 ("drm/arm/malidp: Ensure that the crtcs are
> shutdown before removing any encoder/connector")'
> 3. Disable the interrupts
> 4. Unbind the components
> 5. Free up DRM mode_config info
>=20
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 89191a555c84..e219d1b67100 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -13,6 +13,7 @@
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_probe_helper.h>
Can we keep the include list in alphabetical order?
>  #include <drm/drm_irq.h>
>  #include <drm/drm_vblank.h>
> =20
> @@ -304,24 +305,30 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
eda_dev *mdev)
>  			       komeda_kms_irq_handler, IRQF_SHARED,
>  			       drm->driver->name, drm);
>  	if (err)
> -		goto cleanup_mode_config;
> +		goto free_component_binding;
> =20
>  	err =3D mdev->funcs->enable_irq(mdev);
>  	if (err)
> -		goto cleanup_mode_config;
> +		goto free_component_binding;
> =20
>  	drm->irq_enabled =3D true;
> =20
>  	err =3D drm_dev_register(drm, 0);
>  	if (err)
> -		goto cleanup_mode_config;
> +		goto free_interrupts;
> =20
>  	return kms;
> =20
> -cleanup_mode_config:
> +free_interrupts:
>  	drm->irq_enabled =3D false;
> +	mdev->funcs->disable_irq(mdev);
> +free_component_binding:
> +	component_unbind_all(mdev->dev, drm);
> +cleanup_mode_config:
>  	drm_mode_config_cleanup(drm);
>  	komeda_kms_cleanup_private_objs(kms);
> +	drm->dev_private =3D NULL;
> +	drm_dev_put(drm);
>  free_kms:
>  	kfree(kms);
>  	return ERR_PTR(err);
> @@ -332,12 +339,13 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
>  	struct drm_device *drm =3D &kms->base;
>  	struct komeda_dev *mdev =3D drm->dev_private;
> =20
> +	drm_dev_unregister(drm);
> +	drm_atomic_helper_shutdown(drm);
>  	drm->irq_enabled =3D false;
>  	mdev->funcs->disable_irq(mdev);
> -	drm_dev_unregister(drm);
>  	component_unbind_all(mdev->dev, drm);
> -	komeda_kms_cleanup_private_objs(kms);
>  	drm_mode_config_cleanup(drm);
> +	komeda_kms_cleanup_private_objs(kms);
>  	drm->dev_private =3D NULL;
>  	drm_dev_put(drm);
>  }
>=20

Thanks. See my include order comment above, with that fixed:

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

--=20
Mihail



