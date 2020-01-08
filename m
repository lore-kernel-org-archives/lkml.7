Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEAC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07B120705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UuAjNeiP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UuAjNeiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgAHJ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:56:33 -0500
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:61510
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgAHJ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+w71O1B8I/FLxgtZh0WW0nnu8m6HWiI043KF8ePzeM=;
 b=UuAjNeiP++fnDhdYh9EspoOZyxeqR7eCcb9YW126YFIGJxRbhgcE1pDJ4GUKKSH3MYUmPpWh7a1Gj54TQD3Me5k55eLLelWt+6lvbx1u+z+kb0RGt6TefGXqMpaTiRQqWr/U3WjJqj5xzv3bc/68a3WvokZdoyFEaKYkrmFuhCg=
Received: from HE1PR08CA0069.eurprd08.prod.outlook.com (2603:10a6:7:2a::40) by
 VI1PR0801MB1904.eurprd08.prod.outlook.com (2603:10a6:800:81::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Wed, 8 Jan
 2020 09:56:26 +0000
Received: from VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by HE1PR08CA0069.outlook.office365.com
 (2603:10a6:7:2a::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend
 Transport; Wed, 8 Jan 2020 09:56:26 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT048.mail.protection.outlook.com (10.152.19.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 8 Jan 2020 09:56:25 +0000
Received: ("Tessian outbound ba41a0333779:v40"); Wed, 08 Jan 2020 09:56:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0f1338ad4cc7e510
X-CR-MTA-TID: 64aa7808
Received: from 5817b7abe1fc.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 58417BD4-60EF-4857-9F2B-D2060D145412.1;
        Wed, 08 Jan 2020 09:56:19 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5817b7abe1fc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jan 2020 09:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYLkg5Sxok6EmdjKMrAAWJN10ddHhmAJNDug2BRD4jHmOXg5d0Z/IuoxHUptUjyP27+jK7v0Vnx+zAM1XcIVqGkaoHRaWpwbt2VDnSGZqV3V5KmpjVH2yDsiz0SITHVGY047VYmizeyskEbcYDRyvTSj/zR9FCVPozFj97Ck0t/h+j95FFCqQvzu12ldFD7KP6vQWvATMlZL4lig5USOCXOsk/uSWQt2UvCbt2DzVljP4PaaM2WV/2xNcpiou5ZZISzb3ZBZpbJ7Mc2VRQWEMswZyEoi54zod7NEJdWyoo0FFrJwp8ZS8oQn6H/5Gx4LMEKSGt8K3PtftCJo+mXv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+w71O1B8I/FLxgtZh0WW0nnu8m6HWiI043KF8ePzeM=;
 b=jUgWw4X2nljniLEx/621j4gWD3SWV4U6YB4aagxKi8RUIhIr/wgjoiMaYIULb2cKQONYeGKk/gmLoghXtqTyJ0gHrYqAsJ5JoHyWQTOWWPvKAnhKEJJTllWfFcOB2OwnspTGPc56t/D8WVLNxt0jN81D/6X8uiFOZ9lNysYhrATboiEWH4ktgCXzhCEztTet04rf/5f8zHnSMwRrDTJXm+m6IDm1yWbRedehdJNHnJ7KicAOGhemEUtLyfWbexkk7VWABgqQB3u3AB7C3Zsl6BN/oyi8P8iQb+9JBSGuSoU653bP0+7MGz0o+lmXWNk1Ll/aF5MKbv7/6NpcCMhf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+w71O1B8I/FLxgtZh0WW0nnu8m6HWiI043KF8ePzeM=;
 b=UuAjNeiP++fnDhdYh9EspoOZyxeqR7eCcb9YW126YFIGJxRbhgcE1pDJ4GUKKSH3MYUmPpWh7a1Gj54TQD3Me5k55eLLelWt+6lvbx1u+z+kb0RGt6TefGXqMpaTiRQqWr/U3WjJqj5xzv3bc/68a3WvokZdoyFEaKYkrmFuhCg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4638.eurprd08.prod.outlook.com (10.255.27.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 09:56:17 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::5865:5862:26bf:84f0]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::5865:5862:26bf:84f0%7]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 09:56:17 +0000
Received: from localhost (113.29.88.7) by SN4PR0401CA0035.namprd04.prod.outlook.com (2603:10b6:803:2a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 09:56:16 +0000
From:   james qian wang <james.qian.wang@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Lowry Li <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: mark PM functions as __maybe_unused
Thread-Topic: [PATCH] drm/komeda: mark PM functions as __maybe_unused
Thread-Index: AQHVxaTpM196drNzoU+K8km25bMwD6fgiGmA
Date:   Wed, 8 Jan 2020 09:56:17 +0000
Message-ID: <20200108095609.GA23558@jamwan02-TSP300>
References: <20200107215327.1579195-1-arnd@arndb.de>
In-Reply-To: <20200107215327.1579195-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SN4PR0401CA0035.namprd04.prod.outlook.com
 (2603:10b6:803:2a::21) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bc5c1d5-7d02-434e-043f-08d79421067d
X-MS-TrafficTypeDiagnostic: VE1PR08MB4638:|VE1PR08MB4638:|VI1PR0801MB1904:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB19041F2DBE8D052453BD279AB33E0@VI1PR0801MB1904.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 02760F0D1C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(376002)(136003)(39860400002)(396003)(346002)(189003)(199004)(8936002)(9686003)(478600001)(5660300002)(956004)(6916009)(64756008)(6486002)(81166006)(2906002)(81156014)(8676002)(86362001)(4326008)(6496006)(52116002)(66446008)(55236004)(186003)(16526019)(1076003)(66946007)(66476007)(71200400001)(26005)(33716001)(54906003)(66556008)(33656002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4638;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: o7UR8rvTMYKozy4v4+ufH7yQJ9j29c9WkVxXtlzuML6KPUH4ML2XSI9kpwnHc6jIa9GGVc0fQSSHFEkkz7Jj792jfhqceykT19LehQeNlbRELbO2qBdJAtUBo8i0HNwTprz5kpLAyyCSUSYZ6ccv5lTaCon42prXpuIMrIs4FnhkO2zpErDHHF1zqApPL+0rDK0blr65XemtDOb2HXQNlqhU3UC4+04I0U54sJfrN4JI8jGzdM6OEAymJPaep2BbQk0tFmHCiasKBMvIGfIiM1F0ynvpE6bZ6mrBMg18VIDR8p7yVmmBvnGZisNDH6y/HX3pn18Mq65iBnOi+pSE+VkXZBGEd3jFLHaAO11wFlUzPIBuBYKihVelLY7BpNsCw4NaKma0Szmt/2nry617hhOQ6mYBhWXcM0aSaEjKbqUDeyyZnvONt0XtEgUjobs7
Content-Type: text/plain; charset="us-ascii"
Content-ID: <610660CE5AAB6A4D8861041D6FE3465B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4638
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(956004)(26826003)(6486002)(336012)(70206006)(186003)(70586007)(5660300002)(33716001)(54906003)(478600001)(33656002)(16526019)(9686003)(8676002)(81156014)(26005)(356004)(86362001)(316002)(4326008)(81166006)(36906005)(2906002)(6862004)(1076003)(8936002)(6496006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1904;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5440e4fa-c649-4d27-972d-08d79421013b
X-Forefront-PRVS: 02760F0D1C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0MC5rxMwIU9qYBsQQ5TqdnLQYMSTecuHXgv5/HdyegG17jbhIBu8jIx+8W6nFHTzG3gdsDbgCipc4NuYZ+NNAS4XOoC7AjvDuAOwPsroo6L7aMnkD3/YM0w3k8UT/JAG+05u3o0OMW9bWg+r3VOgirmCaMCqa/R1TwDQUPC7GTrX8IZb+9yAG3lmp3MGOtqC76SijZWeaZP0z2oAjc8v+95CcjxgUTJS5xaAewzTL7DXDqQGuBfBzPp9EeRp14zzGVFNK6Fv/9mmfo8Di/auJlgejyN0Cu6wbkPjpgO4+zIK4qBzhjtNVAVbRt4J11Kqn21YUu9NJFNJQIRQ+US7g2P0yL/GnFR34KtOCjrrqQdm9Al1KyG7dSqTncRiltWkjeqdAUO7ksPWmDm4LnP4uzlQXF2xlp+d243y/pmTK4SHcQZ5luhrC2lmjO0erfL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 09:56:25.8821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc5c1d5-7d02-434e-043f-08d79421067d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1904
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:53:19PM +0100, Arnd Bergmann wrote:
> Without this, we get a couple of warnings when CONFIG_PM
> is disabled:
>=20
> drivers/gpu/drm/arm/display/komeda/komeda_drv.c:156:12: error: 'komeda_rt=
_pm_resume' defined but not used [-Werror=3Dunused-function]
>  static int komeda_rt_pm_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/arm/display/komeda/komeda_drv.c:149:12: error: 'komeda_rt=
_pm_suspend' defined but not used [-Werror=3Dunused-function]
>  static int komeda_rt_pm_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~
>=20
> Fixes: efb465088518 ("drm/komeda: Add runtime_pm support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_drv.c
> index ea5cd1e17304..e7933930a657 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -146,14 +146,14 @@ static const struct of_device_id komeda_of_match[] =
=3D {
> =20
>  MODULE_DEVICE_TABLE(of, komeda_of_match);
> =20
> -static int komeda_rt_pm_suspend(struct device *dev)
> +static int __maybe_unused komeda_rt_pm_suspend(struct device *dev)
>  {
>  	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
> =20
>  	return komeda_dev_suspend(mdrv->mdev);
>  }
> =20
> -static int komeda_rt_pm_resume(struct device *dev)
> +static int __maybe_unused komeda_rt_pm_resume(struct device *dev)
>  {
>  	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
>

Hi Arnd:

Thank you for the patch.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

James
> --=20
> 2.20.0
