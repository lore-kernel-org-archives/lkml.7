Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819002173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CEQt0Uqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfC2Q0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:26:48 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:44115
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728720AbfC2Q0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1IKNWyqSrCE2riswiY06UURKICUokgMC6nq8HSjU74=;
 b=CEQt0Uqwo26FjwmfOpo3rm/Ko0YnRgDUHWcdX+C64lzuEZ574QfIIZh6LkrBrTSr6OIO3nOw5eAULGrq/rTiUBqnNdRb84P1rZn63W9Bj79w401n3r9LHRbU94fJ1S7aGkLtzJr8NNUHfCqhGQD3PJhC9qPCi0l7f+hRoHewL5E=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB5076.eurprd08.prod.outlook.com (10.255.29.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Fri, 29 Mar 2019 16:26:41 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c%4]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 16:26:41 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC PATCH] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Topic: [RFC PATCH] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Index: AQHU5Tdaj2sOzmoqEEaVRCerOJix/6YizfEA
Date:   Fri, 29 Mar 2019 16:26:41 +0000
Message-ID: <20190329162640.GB8314@arm.com>
References: <1553757859-13506-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1553757859-13506-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e66dc1-94ca-466d-db64-08d6b4635326
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB5076;
x-ms-traffictypediagnostic: AM0PR08MB5076:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB5076AF2909D79F3553C3BB28E45A0@AM0PR08MB5076.eurprd08.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(106356001)(33656002)(81166006)(386003)(476003)(14444005)(81156014)(105586002)(8936002)(256004)(3846002)(8676002)(26005)(25786009)(44832011)(68736007)(2906002)(486006)(6486002)(11346002)(37006003)(316002)(53936002)(6436002)(6512007)(6306002)(54906003)(86362001)(6246003)(99286004)(6636002)(305945005)(71190400001)(72206003)(71200400001)(478600001)(5660300002)(446003)(229853002)(2616005)(7736002)(4326008)(6862004)(97736004)(36756003)(76176011)(52116002)(966005)(186003)(66066001)(102836004)(14454004)(6506007)(1076003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5076;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RQNte740bDyZN5a3FF5OTifBoMftWaamImBb2W2llSCc/j/9xuXxM8iNM18tWx2fSWJZqtdVjthkunVHrvu/MsLOkmh2d07CGlIYt6kGMf1gY8P1jdLR1WiCb3kpeJ0UWwOdUElPKz+V5ulsvNGzIjnyPzzRRjozu5VTxe2xIR+XISBIjLcY/2mWHdwvc2/7l8O850HLrQwY7ZWEYbG4cmmSh25lGBA9gxmKrDJf/+bYn6C5K49WPz6jHoNI58OvYtLgUGY8UWUWq1oKv3nKZFfU5nv5bO0GVpBKu/80U/+e+rPDz5lF5lQoZPq3k0B6AdOq8E5cQct+G7dcL9cawFoUyOAQdNlBAmwuetiujht+VePuqAyeeMqUYJsga5hevb9Kf0azFDmLflrTLforO4IAh7YowU7rtKOAh0s2yv8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D20EC5A20FD7B409C5D4ADBE9FE35A1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e66dc1-94ca-466d-db64-08d6b4635326
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 16:26:41.1402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:25:00AM +0000, Lowry Li (Arm Technology China) w=
rote:
> Fixing the DMA mapping sg segment warning, which shows "DMA-API: mapping
> sg segment longer than device claims to support [len=3D921600] [max=3D655=
36]".
> Fixed by setting the max segment size at Komeda driver.
>=20
> Signed-off-by: Lowry Li <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 4 ++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 7f25e6a..b4902ae 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -8,6 +8,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
> +#include <linux/dma-iommu.h>
>  #ifdef CONFIG_DEBUG_FS
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> @@ -245,6 +246,9 @@ struct komeda_dev *komeda_dev_create(struct device *d=
ev)
>  		goto err_cleanup;
>  	}
> =20
> +	dev->dma_parms =3D &mdev->dma_parms;
> +	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
> +
>  	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
>  	if (err) {
>  		DRM_ERROR("create sysfs group failed.\n");
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index 0c3e32b..d8cfa92 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -146,6 +146,7 @@ enum {
>   */
>  struct komeda_dev {
>  	struct device *dev;
> +	struct device_dma_parameters dma_parms;
>  	u32 __iomem   *reg_base;
> =20
>  	struct komeda_chip_info chip;
> --=20
Please rebase and test your patches on drm-misc-next.=20
https://drm.pages.freedesktop.org/maintainer-tools/repositories.html
> 1.9.1
