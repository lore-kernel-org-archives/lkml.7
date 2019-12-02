Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3046BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F7C20748
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="47kEleDO";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="47kEleDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLBLIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:08:10 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:51198
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727308AbfLBLIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x46SGUYbChbNZhOioJboUKiksWbe8CeM3LF8dtiTIHM=;
 b=47kEleDOnZl1xQYHfg8t/7nLaVacARRyJskW3Fc3m84lTAoh5DHHCvqniVTTKP2PcAYHoeZVDelrsL2eqYz0QxuQjGZM3CwHzKuGF9rbhkP0bAMM26LxCpIlI/x3jJV53MttuX3qG5NooUjpB5JabiJ/2UGLeJsx7gdv7Ijt1uU=
Received: from VI1PR08CA0140.eurprd08.prod.outlook.com (2603:10a6:800:d5::18)
 by VI1PR0802MB2445.eurprd08.prod.outlook.com (2603:10a6:800:bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Mon, 2 Dec
 2019 11:08:04 +0000
Received: from VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by VI1PR08CA0140.outlook.office365.com
 (2603:10a6:800:d5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19 via Frontend
 Transport; Mon, 2 Dec 2019 11:08:03 +0000
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
 15.20.2495.18 via Frontend Transport; Mon, 2 Dec 2019 11:08:03 +0000
Received: ("Tessian outbound 92d30e517f5d:v37"); Mon, 02 Dec 2019 11:08:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 91a759785ff5d9df
X-CR-MTA-TID: 64aa7808
Received: from bf2ae185c3a3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 11DDD53B-265F-49F8-B565-DB949433867F.1;
        Mon, 02 Dec 2019 11:07:57 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bf2ae185c3a3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 02 Dec 2019 11:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTHL0G0eX0WrqbuQ3vz48vKdG145SPo64Y5aYKkQKBgNrtzMqChyDJmWkgsaHMXNkWo937TWG2SzPxYN4PV+T3XD0pEz2yaz/ZI95Zuc6IHjFxlFAuit/eEfcHWlpVegCMS9zmBUzaYKN+QDM8N5GQSfq0Y0XkmEAS24kEOYEHzp6VRT7/9XNO9elEenADfS4o4WDhK5U5/SOIN6GJl/RNnTL+7uhcjDtqE0ivvKqBFBeaiiZQ3vkjvgztzcW10Yh8nPuUCRC1eRD/QGuw1VcvsM6mhL/PxrwvhgG6qPtm913Y/Hb0CX2ZM1ELmb8uDjI6ZWc1mmnst1/kMUXEQFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x46SGUYbChbNZhOioJboUKiksWbe8CeM3LF8dtiTIHM=;
 b=cKGKM4AWGSZX59wWJYXIyyegWgGMQ8zVCS7evV040NVXJFmymapT8bHrzirP6QDfMsCsQ3NgS2q2zCh4CauEo57y89q4a5LD2JuLA6DK6va/V2Gd865QPPhq0CFhZSVmu5Cu7SNCmGbuglw9Znhqw3lnLlnkfNi7mLQhoWKOpdk62ZTBnwnDdUgzkPDxAlQ7irBAFdmxXlyNWsCtZA18X8P79/YW6rGOumdJNPEzMtAkEQWjrpgiSS7fMQX7ksEKRlQiMtk4os8egMUVN1SKeq9FrSyXR1tln+g/48+/oektqYXKLbMtAUZdpXzFM2FbFDWsuv+gHtF2HfwOyeVbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x46SGUYbChbNZhOioJboUKiksWbe8CeM3LF8dtiTIHM=;
 b=47kEleDOnZl1xQYHfg8t/7nLaVacARRyJskW3Fc3m84lTAoh5DHHCvqniVTTKP2PcAYHoeZVDelrsL2eqYz0QxuQjGZM3CwHzKuGF9rbhkP0bAMM26LxCpIlI/x3jJV53MttuX3qG5NooUjpB5JabiJ/2UGLeJsx7gdv7Ijt1uU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3280.eurprd08.prod.outlook.com (52.134.30.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 11:07:54 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 11:07:54 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 1/2] drm/komeda: Update the chip identify
Thread-Topic: [PATCH v2 1/2] drm/komeda: Update the chip identify
Thread-Index: AQHVoEQrMqZJ0HCZ4UqX8rLOYPxJhaemu7gA
Date:   Mon, 2 Dec 2019 11:07:54 +0000
Message-ID: <5936016.qkgZygMIky@e123338-lin>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
 <20191121081717.29518-2-james.qian.wang@arm.com>
In-Reply-To: <20191121081717.29518-2-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8411c0e-5884-4543-5a2c-08d77717e6f5
X-MS-TrafficTypeDiagnostic: VI1PR08MB3280:|VI1PR08MB3280:|VI1PR0802MB2445:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2445E0C0049A5AF4ABB901848F430@VI1PR0802MB2445.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:4941;
x-forefront-prvs: 0239D46DB6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(6486002)(15650500001)(316002)(54906003)(2906002)(305945005)(8936002)(33716001)(7736002)(25786009)(81166006)(3846002)(26005)(99286004)(8676002)(6116002)(81156014)(66066001)(14444005)(256004)(11346002)(446003)(4326008)(6436002)(6246003)(71200400001)(71190400001)(6636002)(6862004)(186003)(478600001)(229853002)(86362001)(966005)(66446008)(66556008)(66476007)(66946007)(76176011)(52116002)(386003)(6506007)(64756008)(102836004)(5660300002)(6306002)(6512007)(9686003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3280;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MaZEKlblcXxKIbSngSZ/FSHkuQTjraWzROO0yO5NuHtCqo0qqaCnHrne8LJ+c/LTl5YV/JwyM90Ks1fc+hffUePwOxLN23/QmuED7OklFd1I8WLL51rP6XXJHbp/PDghAxXiNM9ifed3pb01OUsYnUt3ftneEeCq1bX0XBbXhmEWZKpiri9a3OCCxvQp0/CWeHpNP4cAgBWR3FnFff43FWDkF76Vg4l6WmtvxeabiA7e2uGtZjZIUl+Ms0HQSg6tc3EyJvSrThdvyVrShVu0kKhLIttt5v0RQLantUHbLpFYWow9YVgnCQDoLyx9/DHw3kihrLsg0HFctx6RbT9Sy1NzvmpMdp6HPyxtLzxj5yJdXln5Bxcd0IxDFH5MLrr39DMrqlD8ZXROnsgohKdK8olFirfZO89tw82inj+t3axORt6BFpw5HP92PBey9oYeab32vXbe0KPsKmSkXqXdUkm0NZZl6A3HOd0Qz8iPGzM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D5F7CD1749ACA428CFCB36AE835F99C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3280
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(70586007)(2906002)(66066001)(6246003)(86362001)(46406003)(26826003)(81166006)(6862004)(356004)(106002)(81156014)(7736002)(4326008)(305945005)(8936002)(316002)(8746002)(6636002)(6486002)(6306002)(446003)(6512007)(25786009)(15650500001)(54906003)(186003)(102836004)(26005)(478600001)(336012)(50466002)(22756006)(47776003)(966005)(76130400001)(11346002)(14444005)(386003)(76176011)(9686003)(6506007)(36906005)(33716001)(6116002)(99286004)(3846002)(8676002)(23726003)(97756001)(14454004)(5660300002)(229853002)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2445;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2ba07f93-b31d-4438-6f9a-08d77717e156
NoDisclaimer: True
X-Forefront-PRVS: 0239D46DB6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8jKow6ZAoyL6RWC1Fa+DXlhWzLLyG1o6o3lsCLzqSnC5MwRLKONuc850WrYIWaFWFAZsCOLdwnRarc+1KDKECEW6Z4EJYLWwa2gnSJvsnJq2gVMzDz0Bbbm6lWupQiU7VDWBXEoTmaxbvw79U1MfbJrEZpm0uMjMQvoy7T9QYsQ74VB6/r2uvm5H2lMxKCgRdGAusDgkGJORD+IeN4U1o5J8MXWvf9b+T+RL+oOqf790FnlmrC6jZp78Zpcw787m6TNZ05ZbfiIDJTav7LWOmaWj/dVnw2HqNSFCs2sGmRBi6L2EEVJWFVFWVkUOn+H54JhzQuUqchY/KBuxvy/JyZLfC+DZuC2cNR0yBYf1njeMJRpZR7Q2zWBVzBWVouvyovv0UcxhCST8fd9SxATRACRTtm402DeX3HRPsShxSfdmFHejEQ1yyI/mtRy6fzqAXbIHGPOui4QfuXSryQTHQ+EmNP1oyrUhc1xxxSgme8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 11:08:03.7575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8411c0e-5884-4543-5a2c-08d77717e6f5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 November 2019 08:17:39 GMT james qian wang (Arm Technology =
China) wrote:
> 1. Drop komeda-CORE product id comparison and put it into the d71_identif=
y
> 2. Update pipeline node DT-binding:
>    (a). Skip the needless pipeline DT node.
>    (b). Return fail if the essential pipeline DT node is missing.
>=20
> With these changes, for one family chips no need to change the DT.
>=20
> v2: Rebase
>=20
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 27 +++++++--
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 60 ++++++++++---------
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   | 14 +----
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  9 +--
>  4 files changed, 58 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index 822b23a1ce75..9b3bf353b6cc 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -594,10 +594,27 @@ static const struct komeda_dev_funcs d71_chip_funcs=
 =3D {
>  const struct komeda_dev_funcs *
>  d71_identify(u32 __iomem *reg_base, struct komeda_chip_info *chip)
>  {
> -	chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
> -	chip->core_id	=3D malidp_read32(reg_base, GLB_CORE_ID);
> -	chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
> -	chip->bus_width	=3D D71_BUS_WIDTH_16_BYTES;
> +	const struct komeda_dev_funcs *funcs;
> +	u32 product_id;
> =20
> -	return &d71_chip_funcs;
> +	chip->core_id =3D malidp_read32(reg_base, GLB_CORE_ID);
> +
> +	product_id =3D MALIDP_CORE_ID_PRODUCT_ID(chip->core_id);
> +
> +	switch (product_id) {
> +	case MALIDP_D71_PRODUCT_ID:
> +		funcs =3D &d71_chip_funcs;
> +		break;
> +	default:
> +		funcs =3D NULL;

[bikeshed] I'd just 'return NULL;' after printing the error...

> +		DRM_ERROR("Unsupported product: 0x%x\n", product_id);
> +	}
> +
> +	if (funcs) {

... and save myself the branch and indent level here.

> +		chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
> +		chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
> +		chip->bus_width	=3D D71_BUS_WIDTH_16_BYTES;
> +	}
> +
> +	return funcs;
>  }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 4dd4699d4e3d..8e0bce46555b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -116,22 +116,14 @@ static struct attribute_group komeda_sysfs_attr_gro=
up =3D {
>  	.attrs =3D komeda_sysfs_entries,
>  };
> =20
> -static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_n=
ode *np)
> +static int komeda_parse_pipe_dt(struct komeda_pipeline *pipe)
>  {
> -	struct komeda_pipeline *pipe;
> +	struct device_node *np =3D pipe->of_node;
>  	struct clk *clk;
> -	u32 pipe_id;
> -	int ret =3D 0;
> -
> -	ret =3D of_property_read_u32(np, "reg", &pipe_id);
> -	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
> -		return -EINVAL;
> -
> -	pipe =3D mdev->pipelines[pipe_id];
> =20
>  	clk =3D of_clk_get_by_name(np, "pxclk");
>  	if (IS_ERR(clk)) {
> -		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe_id);
> +		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe->id);
>  		return PTR_ERR(clk);
>  	}
>  	pipe->pxlclk =3D clk;
> @@ -145,7 +137,6 @@ static int komeda_parse_pipe_dt(struct komeda_dev *md=
ev, struct device_node *np)
>  		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
> =20
>  	pipe->dual_link =3D pipe->of_output_links[0] && pipe->of_output_links[1=
];
> -	pipe->of_node =3D of_node_get(np);
> =20
>  	return 0;
>  }
> @@ -154,7 +145,9 @@ static int komeda_parse_dt(struct device *dev, struct=
 komeda_dev *mdev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct device_node *child, *np =3D dev->of_node;
> -	int ret;
> +	struct komeda_pipeline *pipe;
> +	u32 pipe_id =3D U32_MAX;
> +	int ret =3D -1;
> =20
>  	mdev->irq  =3D platform_get_irq(pdev, 0);
>  	if (mdev->irq < 0) {
> @@ -169,31 +162,44 @@ static int komeda_parse_dt(struct device *dev, stru=
ct komeda_dev *mdev)
>  	ret =3D 0;
> =20
>  	for_each_available_child_of_node(np, child) {
> -		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
> -			ret =3D komeda_parse_pipe_dt(mdev, child);
> -			if (ret) {
> -				DRM_ERROR("parse pipeline dt error!\n");
> -				of_node_put(child);
> -				break;
> +		if (of_node_name_eq(child, "pipeline")) {
> +			of_property_read_u32(child, "reg", &pipe_id);
> +			if (pipe_id >=3D mdev->n_pipelines) {
> +				DRM_WARN("Skip the redundant DT node: pipeline-%u.\n",
> +					 pipe_id);
> +				continue;
>  			}
> +			mdev->pipelines[pipe_id]->of_node =3D of_node_get(child);
>  		}
>  	}
> =20
> +	for (pipe_id =3D 0; pipe_id < mdev->n_pipelines; pipe_id++) {
> +		pipe =3D mdev->pipelines[pipe_id];
> +
> +		if (!pipe->of_node) {
> +			DRM_ERROR("Omit DT node for pipeline-%d.\n", pipe->id);

[nit] "Omit DT node" doesn't sound like an error condition. How about:

"pipeline-%d doesn't have a DT node."

> +			return -EINVAL;
> +		}
> +		ret =3D komeda_parse_pipe_dt(pipe);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master",

Looks like this isn't based off drm-misc-next, and is instead based on
https://patchwork.freedesktop.org/patch/341867/

>  						   &mdev->side_by_side_master);
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  struct komeda_dev *komeda_dev_create(struct device *dev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
> -	const struct komeda_product_data *product;
> +	komeda_identify_func komeda_identify;
>  	struct komeda_dev *mdev;
>  	int err =3D 0;
> =20
> -	product =3D of_device_get_match_data(dev);
> -	if (!product)
> +	komeda_identify =3D of_device_get_match_data(dev);
> +	if (!komeda_identify)
>  		return ERR_PTR(-ENODEV);
> =20
>  	mdev =3D devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
> @@ -221,11 +227,9 @@ struct komeda_dev *komeda_dev_create(struct device *=
dev)
> =20
>  	clk_prepare_enable(mdev->aclk);
> =20
> -	mdev->funcs =3D product->identify(mdev->reg_base, &mdev->chip);
> -	if (!komeda_product_match(mdev, product->product_id)) {
> -		DRM_ERROR("DT configured %x mismatch with real HW %x.\n",
> -			  product->product_id,
> -			  MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id));
> +	mdev->funcs =3D komeda_identify(mdev->reg_base, &mdev->chip);
> +	if (!mdev->funcs) {
> +		DRM_ERROR("Failed to identify the HW.\n");
>  		err =3D -ENODEV;
>  		goto disable_clk;
>  	}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index 471604b42431..dacdb00153e9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -58,11 +58,6 @@
>  			    | KOMEDA_EVENT_MODE \
>  			    )
> =20
> -/* malidp device id */
> -enum {
> -	MALI_D71 =3D 0,
> -};
> -
>  /* pipeline DT ports */
>  enum {
>  	KOMEDA_OF_PORT_OUTPUT		=3D 0,
> @@ -76,12 +71,6 @@ struct komeda_chip_info {
>  	u32 bus_width;
>  };
> =20
> -struct komeda_product_data {
> -	u32 product_id;
> -	const struct komeda_dev_funcs *(*identify)(u32 __iomem *reg,
> -					     struct komeda_chip_info *info);
> -};
> -
>  struct komeda_dev;
> =20
>  struct komeda_events {
> @@ -243,6 +232,9 @@ komeda_product_match(struct komeda_dev *mdev, u32 tar=
get)
>  	return MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id) =3D=3D target;
>  }
> =20
> +typedef const struct komeda_dev_funcs *
> +(*komeda_identify_func)(u32 __iomem *reg, struct komeda_chip_info *chip)=
;
> +
>  const struct komeda_dev_funcs *
>  d71_identify(u32 __iomem *reg, struct komeda_chip_info *chip);
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_drv.c
> index d6c2222c5d33..b7a1097c45c4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -123,15 +123,8 @@ static int komeda_platform_remove(struct platform_de=
vice *pdev)
>  	return 0;
>  }
> =20
> -static const struct komeda_product_data komeda_products[] =3D {
> -	[MALI_D71] =3D {
> -		.product_id =3D MALIDP_D71_PRODUCT_ID,
> -		.identify =3D d71_identify,
> -	},
> -};
> -
>  static const struct of_device_id komeda_of_match[] =3D {
> -	{ .compatible =3D "arm,mali-d71", .data =3D &komeda_products[MALI_D71],=
 },
> +	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
>  	{},
>  };
> =20
>=20

With the above two fixed (i.e. feel free to ignore the bikeshed),
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

--=20
Mihail



