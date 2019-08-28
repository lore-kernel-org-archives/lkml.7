Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF62C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AB5208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qV/GynHF";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qV/GynHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfH1P6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:58:37 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:18510
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfH1P6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93unK/ykfx9sj9ufmO4dtMU8a+6HUj0AVW7MCTEcu1w=;
 b=qV/GynHFUxNQgHbBCLjPovrEVYzB9pAy4m78PBnlPtY0y/+1n3UYL7CgJzUujTX7W7BsrkYDdR1gta9zTNQTUXC3XNgevHdxB2kXs3BAubhHCFakH+8wbq6jkK7bV4msq+0Dc6ZLvGmQd2OCFxFMIJyyS08VJdqLvlnmOMYtYWo=
Received: from DB6PR0802CA0033.eurprd08.prod.outlook.com (2603:10a6:4:a3::19)
 by VI1PR0801MB1856.eurprd08.prod.outlook.com (2603:10a6:800:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Wed, 28 Aug
 2019 15:58:26 +0000
Received: from AM5EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by DB6PR0802CA0033.outlook.office365.com
 (2603:10a6:4:a3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.18 via Frontend
 Transport; Wed, 28 Aug 2019 15:58:26 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT042.mail.protection.outlook.com (10.152.17.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.13 via Frontend Transport; Wed, 28 Aug 2019 15:58:24 +0000
Received: ("Tessian outbound eec90fc31dfb:v27"); Wed, 28 Aug 2019 15:58:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0ae999a15fb73dcf
X-CR-MTA-TID: 64aa7808
Received: from f28fddc466e7.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E0489B90-4A2C-448A-89DA-398B96FAAC05.1;
        Wed, 28 Aug 2019 15:58:15 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f28fddc466e7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 28 Aug 2019 15:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM28+jiYOj323zil1qb8Vj6tM9gfTR8SRieJsbQwqVT9KAsp6Q5diEh5vxIvaE3lff2pql/xUR6KIRSBP5SBa/r78R1gd7ammJhqW5w9a/lUWH8s8p4v0w0XmNxNSEVPVvm//CQ33pG0Are3iO0i5pZLlxg0wtyGmCveIgGENTJFNxh7/CJDrU8Msyl7eiAL/gwEi4xBfJI3GuftEvPGhVBA+VtKNzmo5pVBbNFFzIA/Y5Acu3SM2GnhKzkvkAmar/3mFGpldW6Av0dmLxgHVdO5BKrx5SnkjuwJRiWMY/k/YAPLco2Yh++VkpGbi14cbJp3mYh3SMPOy/kOxL0FGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93unK/ykfx9sj9ufmO4dtMU8a+6HUj0AVW7MCTEcu1w=;
 b=gSPOapkVt3mzWukS4SXqgLomjkgfkCeDDHVJ4DB3hJZhg0yxQI5xXIZ9qYjsA4eKfYQ8B0+ukFCLDDgGTmazG0yzgoQ2aeNg9DrgALYw3wr1chzqi1VO4cLl4EbgZdmvoR4lXnwQkA77jZaZWvU3CA1W8W9Eu1ex9s3I2ghZrOJaNoTzKv+/u5/xzDq7+meRTeBeqTR1kmQhsXA3bXLzovsM9wU97zHXX7UCafJENx0YJgb9u+LfyQ7ZZfHXqk/aei4j6xhuVzCYH7jG64oX65pRvFYzrTijKZM1fSC6KlJa2Iznjf1JRKrEO0a3uuTj5ZkCQx7vvPfNvAh5/8Aqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93unK/ykfx9sj9ufmO4dtMU8a+6HUj0AVW7MCTEcu1w=;
 b=qV/GynHFUxNQgHbBCLjPovrEVYzB9pAy4m78PBnlPtY0y/+1n3UYL7CgJzUujTX7W7BsrkYDdR1gta9zTNQTUXC3XNgevHdxB2kXs3BAubhHCFakH+8wbq6jkK7bV4msq+0Dc6ZLvGmQd2OCFxFMIJyyS08VJdqLvlnmOMYtYWo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4941.eurprd08.prod.outlook.com (10.255.158.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 15:58:13 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::d9f5:7cb8:41e8:17af]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::d9f5:7cb8:41e8:17af%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 15:58:13 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
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
Thread-Index: AQHVXbFOPtkOyMBO7Em37TZu77ub2acQt18A
Date:   Wed, 28 Aug 2019 15:58:12 +0000
Message-ID: <20190828155806.GA7020@jamwan02-TSP300>
References: <20190828145945.15904-1-ayan.halder@arm.com>
In-Reply-To: <20190828145945.15904-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0214.apcprd02.prod.outlook.com
 (2603:1096:201:20::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 82dba240-7f8d-406e-00c9-08d72bd08f11
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4941;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4941:|VI1PR0801MB1856:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB185674A4B235074F7011ADBBB3A30@VI1PR0801MB1856.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:480;OLM:480;
x-forefront-prvs: 014304E855
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(346002)(396003)(136003)(376002)(199004)(189003)(2906002)(5660300002)(6486002)(71200400001)(1076003)(6862004)(6246003)(6506007)(99286004)(86362001)(256004)(476003)(5024004)(55236004)(486006)(14454004)(6436002)(386003)(14444005)(7736002)(446003)(11346002)(71190400001)(33716001)(6636002)(53936002)(186003)(64756008)(8676002)(102836004)(478600001)(229853002)(66066001)(26005)(66946007)(33656002)(81156014)(81166006)(6116002)(3846002)(9686003)(305945005)(58126008)(52116002)(66446008)(66556008)(8936002)(316002)(6512007)(76176011)(54906003)(4326008)(66476007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4941;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: RSMrLT8B3xilQ27XUZF0r2Bum5GQ7gIjpMOuti2yibhMmgqvx1r4B6xjz4jp7Ls2RqBuIRHix4yIIaR0GbObDZEDzfeMEZ4DZFdjLBSgE4i9wp+CSW9hJXmVCcKl/JHzn7wh01LCRPI6Ykd+6fIwfEKw9PkwinEQfjwUSGVekmwqOjlXt7J0Sy1lDzx157TzdXyTFhjanvYus60NQbzyvQU/x3GV/yjxfnmKprLrWL7oCx4f/RoXYNL43DAL9Y/j/n4I9TvIxlpok/75n00kgP0ZcAz13qtSByPt6vPiMv8Hu8uZuB3lw40sP669qkAIL4z8AKgdu9MttLKNsc2SL6okW3rX612GXywMxt88LH/j15B/WAgleFjsf8qOJcpp7vLXr+ksnIjVVv1KBl86UaJm+MjQdXhqcHQAdy3GdbU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FF1DCB4C259C34FB1CE18D447440577@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4941
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(26826003)(11346002)(6246003)(446003)(76176011)(6862004)(97756001)(25786009)(4326008)(63350400001)(5660300002)(356004)(99286004)(33656002)(6486002)(6506007)(50466002)(46406003)(316002)(9686003)(2906002)(6512007)(126002)(5024004)(14444005)(476003)(1076003)(63370400001)(486006)(66066001)(478600001)(186003)(8676002)(81156014)(76130400001)(54906003)(58126008)(47776003)(86362001)(81166006)(23726003)(33716001)(70206006)(26005)(70586007)(6116002)(14454004)(3846002)(22756006)(7736002)(305945005)(6636002)(8936002)(36906005)(229853002)(8746002)(102836004)(386003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1856;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7f83286c-c64c-452a-bd70-08d72bd087bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0801MB1856;
NoDisclaimer: True
X-Forefront-PRVS: 014304E855
X-Microsoft-Antispam-Message-Info: XemUlmrtLPu26zcB/ELLHhtfVYw01U0YbeXahe4GdOViFuEMRgqf4ULhXtdSF2bDexbdqCEC+hyZ6VTyAw37bYBnN9r+agoUlGyZb90fSDAYgKUUt2k6fOkmZRBF56K9KVJWL9KeKIdN1cSdDIg/vaeub5OOxYI5Zc3MXZAiRXkJyuzcWmASPAFIuCjbinA7fcnXs/vYQGolCOJV4HW/7Xjd+AYkwC4/9ChdV0KdqXIg1Jc8n53URirALUAR8BvwIxVd4p7edWfRXLlNlLef8GDbqip2S6SCB/y6j755EE4Kwd9b/eVh+y7lex15qI4kNIIyP4bZM2SD3T5RQdnmFAVoU9wxB/8aABhdttCKEh7XDYzAkck8SwweZ2DVnzlq3sHwoajAu6yHUDuZoTEk94gO4a4fA3lU62+LrlIwY5M=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2019 15:58:24.8902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dba240-7f8d-406e-00c9-08d72bd08f11
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:00:19PM +0000, Ayan Halder wrote:
> From: Ayan Halder <Ayan.Halder@arm.com>
>=20
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
> Changes from v1:-
> 1. Re-ordered the header files inclusion
> 2. Rebased on top of the latest drm-misc-fixes
>=20
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

> ---
>  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 1f0e3f4e8d74..69d9e26c60c8 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -14,8 +14,8 @@
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_irq.h>
> -#include <drm/drm_vblank.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_vblank.h>
> =20
>  #include "komeda_dev.h"
>  #include "komeda_framebuffer.h"
> @@ -306,11 +306,11 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
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
> @@ -318,15 +318,21 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
eda_dev *mdev)
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
>  	drm_kms_helper_poll_fini(drm);
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
> @@ -337,13 +343,14 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
>  	struct drm_device *drm =3D &kms->base;
>  	struct komeda_dev *mdev =3D drm->dev_private;
> =20
> -	drm->irq_enabled =3D false;
> -	mdev->funcs->disable_irq(mdev);
>  	drm_dev_unregister(drm);
>  	drm_kms_helper_poll_fini(drm);
> +	drm_atomic_helper_shutdown(drm);
> +	drm->irq_enabled =3D false;
> +	mdev->funcs->disable_irq(mdev);
>  	component_unbind_all(mdev->dev, drm);
> -	komeda_kms_cleanup_private_objs(kms);
>  	drm_mode_config_cleanup(drm);
> +	komeda_kms_cleanup_private_objs(kms);
>  	drm->dev_private =3D NULL;
>  	drm_dev_put(drm);
>  }
> --=20
> 2.21.0
