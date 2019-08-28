Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214CDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A2E2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Z38YO9SO";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Z38YO9SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfH1Rfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:35:34 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:36814
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbfH1Rfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qdkevifMfV+b5NbBlWel2GHSpSNDJM3viovPfVmkuc=;
 b=Z38YO9SOdq0gyyQMDLhOMGNNU8Ua27CRzzw7URRQdArzbmtX15yFLpTcTGKLQj0suRj5YBPLtWPDGr37bV4A3ll5gly9O9ZqxGpc0QLkY8u6myOwohg/GRKte9rU83zwafLJQQTM1wWBs6NvGs1wc6LWHXM+Brllw8nP//csJgM=
Received: from HE1PR08CA0064.eurprd08.prod.outlook.com (2603:10a6:7:2a::35) by
 VE1PR08MB4958.eurprd08.prod.outlook.com (2603:10a6:803:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Wed, 28 Aug
 2019 17:35:21 +0000
Received: from VE1EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by HE1PR08CA0064.outlook.office365.com
 (2603:10a6:7:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.14 via Frontend
 Transport; Wed, 28 Aug 2019 17:35:21 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT015.mail.protection.outlook.com (10.152.18.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Wed, 28 Aug 2019 17:35:18 +0000
Received: ("Tessian outbound d33df262a6a7:v27"); Wed, 28 Aug 2019 17:35:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ff02e6fc9ca3fa80
X-CR-MTA-TID: 64aa7808
Received: from 556320bb45eb.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9D76D364-2A04-4506-9C16-3753AA8D3AFE.1;
        Wed, 28 Aug 2019 17:35:08 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 556320bb45eb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2019 17:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njW2fldL+V7Yt71ZfbsEec1T0BiQsIdRWLp3UyHU91HRrkzJE4EBiFgevdB+fJsuQpuCbnzhBHTe/oiVmQb+2vY2ditCzf4jYMjTbOZJ1F4R87yNc3iDdPdrwPLoMFY8N44L1HuCqig7iHUX+qUnOYplSx/jkL8sDjOytYQjjWsVQZnD1tbw+94NlRnZX3fVfyGgfIfNiguRZlXdB0Rqqy8Udj3ygXci2uK7+9MP2wRh1UiIVGSwninpGzL+vPQkezWyzCzI9jfKrZrQkhmVVxhQfhTwHLnj6GC86V1nIZAijys7RLkxjzTt57iflEkksqB40u896r5dB2WGZjyoyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qdkevifMfV+b5NbBlWel2GHSpSNDJM3viovPfVmkuc=;
 b=h9hIQQkiYoultgePxvD6hi3QiW4MRnFLKCt5mjvUy1tT3rk79AH5/aAK/TQSXFT0H4aoG72xIn3fbjeLh+WTCLMrVudQq5i0TJoEag36FE08+Tn68a+RlmLRQCBx+T7AQdfY9Z/j+ZDG1x6bFxYCiWuF4rdarMQKBd2w7r5wWDCtu3iyUpq5oLBUnxnpd9TZTJeizi3jEnb+7JDxT4U1Lf4pHctUdtFIhgPAPZHZ1yVGX167V1rvsQQF7MbekQJ/kAkMqRgwoaKUS0HtdewyHqvIMXnEwKw2oxME/ebbwwip6qnjLQzrZZa3i7VPeY+GaZFFofUMi+FP91b4NMMqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qdkevifMfV+b5NbBlWel2GHSpSNDJM3viovPfVmkuc=;
 b=Z38YO9SOdq0gyyQMDLhOMGNNU8Ua27CRzzw7URRQdArzbmtX15yFLpTcTGKLQj0suRj5YBPLtWPDGr37bV4A3ll5gly9O9ZqxGpc0QLkY8u6myOwohg/GRKte9rU83zwafLJQQTM1wWBs6NvGs1wc6LWHXM+Brllw8nP//csJgM=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.212.135) by
 AM0PR08MB5044.eurprd08.prod.outlook.com (20.179.39.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Wed, 28 Aug 2019 17:35:05 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::1de:178b:2ca:42e5]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::1de:178b:2ca:42e5%2]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 17:35:05 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH v2] drm/komeda: Reordered the komeda's de-init functions
Thread-Topic: [PATCH v2] drm/komeda: Reordered the komeda's de-init functions
Thread-Index: AQHVXbFOPtkOyMBO7Em37TZu77ub2acQt18AgAAbGAA=
Date:   Wed, 28 Aug 2019 17:35:04 +0000
Message-ID: <20190828173504.GA21758@arm.com>
References: <20190828145945.15904-1-ayan.halder@arm.com>
 <20190828155806.GA7020@jamwan02-TSP300>
In-Reply-To: <20190828155806.GA7020@jamwan02-TSP300>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::29) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: da2da4e3-a49b-4dc5-49f0-08d72bde1885
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB5044;
X-MS-TrafficTypeDiagnostic: AM0PR08MB5044:|VE1PR08MB4958:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4958ABDDC99DE843E472C48BE4A30@VE1PR08MB4958.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:480;OLM:480;
x-forefront-prvs: 014304E855
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(478600001)(2906002)(4326008)(1076003)(8936002)(14444005)(186003)(256004)(102836004)(6486002)(476003)(6512007)(44832011)(66066001)(76176011)(5024004)(305945005)(446003)(6246003)(37006003)(8676002)(66556008)(26005)(66446008)(6116002)(64756008)(66476007)(6436002)(66946007)(316002)(14454004)(71200400001)(25786009)(52116002)(54906003)(7736002)(81156014)(33656002)(81166006)(71190400001)(86362001)(486006)(6862004)(3846002)(6506007)(5660300002)(2616005)(99286004)(11346002)(6636002)(229853002)(386003)(53936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5044;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: x2Rip5b0M2bNurK6+zyh9o5kUlrC6B0HyNE+5n1jdXZ0d1lOmWGlw1atYs1ncrImYf2hQzK72uFbt22Ji8HMRUq6zEF6PhuKjK7HCwmWpJDQmNk1dk5QLN8JbDx4fzqBR74XrxwNx4GB1zaAYopnvdNc4dcCUk/B9nOTfrbu5KJ7hF4dD0jUcUJWcpQsakImmDBbZeeYvZHge0Jsjf0u/xQsj8EGWw6ivy/aN4jIQ8om7eIgILyDuZSb3D10cbQfJIVDOyFm0mR8LNB3Ry8Jnua2CWkYhrVBXdHZXX/uhPmmMy7mi3gTlT+xGo1gxZaws0tdkfQfeKGq069wwYWhCelZwQ21JmNa27yIDXUImwKi+5pRUr0po/ysPWq8hxWyRr3p+5uU1EPvlRhWb8NAmJ3NbdmTKrvzGVx0d53tQKE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96B089E83AC54C42A5115C3580979B48@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5044
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(199004)(189003)(26005)(478600001)(5024004)(102836004)(14444005)(386003)(76176011)(186003)(229853002)(50466002)(66066001)(47776003)(86362001)(6506007)(26826003)(99286004)(81166006)(37006003)(81156014)(6636002)(305945005)(8936002)(3846002)(97756001)(6862004)(70586007)(8676002)(1076003)(6486002)(25786009)(8746002)(6116002)(2616005)(476003)(22756006)(14454004)(126002)(23726003)(63370400001)(63350400001)(36756003)(486006)(336012)(36906005)(7736002)(5660300002)(316002)(46406003)(76130400001)(2906002)(70206006)(33656002)(4326008)(356004)(446003)(11346002)(54906003)(6246003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4958;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4949fa36-80ca-49cc-bbcc-08d72bde0ffc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4958;
NoDisclaimer: True
X-Forefront-PRVS: 014304E855
X-Microsoft-Antispam-Message-Info: vBoF1lYXIDTiyp/Xjw1/UcHB5QT6YgePPi6xDFINSrvKMMNOO6njv76xfvHSRxtCBqvO96FMfCOkWP6JNVPzdF1LGM9yTygs8cMyBLF23ThASMs3nYEx4OpOzDBAUVfhBBrlIHTEeT8U3i5331b2qII8NFNm4WrXKqWLXO51LJj6KSL17ohgHMHGv8PPVsFysw0d7CVTrvErrK+bk7Ig4muGgRH0ESQxYlyxT/kN4XS+huLX8Y5t4foaREAgoq6XmiLXxP3su3hRRrNNDx/kpwcY1s6wXijr4Az5v5LvMWKUvrP9n+x7Y2w2sEBpJbQtf5yE1IXznjz1AmnlAuZRKSP+t2eeOf38zmArf08E6dhXxKDv++/em8rG7eKWZkp6HZjXdtgv6XmVxWlCw2rNWLyDHe9Uik/jXduXmGrMIZQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2019 17:35:18.8685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2da4e3-a49b-4dc5-49f0-08d72bde1885
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4958
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:58:12PM +0000, james qian wang (Arm Technology C=
hina) wrote:
> On Wed, Aug 28, 2019 at 03:00:19PM +0000, Ayan Halder wrote:
> > From: Ayan Halder <Ayan.Halder@arm.com>
> >=20
> > The de-init routine should be doing the following in order:-
> > 1. Unregister the drm device
> > 2. Shut down the crtcs - failing to do this might cause a connector lea=
kage
> > See the 'commit 109c4d18e574 ("drm/arm/malidp: Ensure that the crtcs ar=
e
> > shutdown before removing any encoder/connector")'
> > 3. Disable the interrupts
> > 4. Unbind the components
> > 5. Free up DRM mode_config info
> >=20
> > Changes from v1:-
> > 1. Re-ordered the header files inclusion
> > 2. Rebased on top of the latest drm-misc-fixes
> >=20
> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
>=20
> Looks good to me.
>=20
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
>
Pushed to drm-misc-fixes - 6978bce054247e4cfccdf689ce263e076499f905
=20
> > ---
> >  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 23 ++++++++++++-------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 1f0e3f4e8d74..69d9e26c60c8 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -14,8 +14,8 @@
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_irq.h>
> > -#include <drm/drm_vblank.h>
> >  #include <drm/drm_probe_helper.h>
> > +#include <drm/drm_vblank.h>
> > =20
> >  #include "komeda_dev.h"
> >  #include "komeda_framebuffer.h"
> > @@ -306,11 +306,11 @@ struct komeda_kms_dev *komeda_kms_attach(struct k=
omeda_dev *mdev)
> >  			       komeda_kms_irq_handler, IRQF_SHARED,
> >  			       drm->driver->name, drm);
> >  	if (err)
> > -		goto cleanup_mode_config;
> > +		goto free_component_binding;
> > =20
> >  	err =3D mdev->funcs->enable_irq(mdev);
> >  	if (err)
> > -		goto cleanup_mode_config;
> > +		goto free_component_binding;
> > =20
> >  	drm->irq_enabled =3D true;
> > =20
> > @@ -318,15 +318,21 @@ struct komeda_kms_dev *komeda_kms_attach(struct k=
omeda_dev *mdev)
> > =20
> >  	err =3D drm_dev_register(drm, 0);
> >  	if (err)
> > -		goto cleanup_mode_config;
> > +		goto free_interrupts;
> > =20
> >  	return kms;
> > =20
> > -cleanup_mode_config:
> > +free_interrupts:
> >  	drm_kms_helper_poll_fini(drm);
> >  	drm->irq_enabled =3D false;
> > +	mdev->funcs->disable_irq(mdev);
> > +free_component_binding:
> > +	component_unbind_all(mdev->dev, drm);
> > +cleanup_mode_config:
> >  	drm_mode_config_cleanup(drm);
> >  	komeda_kms_cleanup_private_objs(kms);
> > +	drm->dev_private =3D NULL;
> > +	drm_dev_put(drm);
> >  free_kms:
> >  	kfree(kms);
> >  	return ERR_PTR(err);
> > @@ -337,13 +343,14 @@ void komeda_kms_detach(struct komeda_kms_dev *kms=
)
> >  	struct drm_device *drm =3D &kms->base;
> >  	struct komeda_dev *mdev =3D drm->dev_private;
> > =20
> > -	drm->irq_enabled =3D false;
> > -	mdev->funcs->disable_irq(mdev);
> >  	drm_dev_unregister(drm);
> >  	drm_kms_helper_poll_fini(drm);
> > +	drm_atomic_helper_shutdown(drm);
> > +	drm->irq_enabled =3D false;
> > +	mdev->funcs->disable_irq(mdev);
> >  	component_unbind_all(mdev->dev, drm);
> > -	komeda_kms_cleanup_private_objs(kms);
> >  	drm_mode_config_cleanup(drm);
> > +	komeda_kms_cleanup_private_objs(kms);
> >  	drm->dev_private =3D NULL;
> >  	drm_dev_put(drm);
> >  }
> > --=20
> > 2.21.0
