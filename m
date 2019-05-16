Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648BEC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3DC20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9L5nYSOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfEPMsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:48:50 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:12934
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbfEPMst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Mh+pJchuWpD0gBWCZ3eBM52avQiZjs5b28rDJxWEtU=;
 b=9L5nYSOPBHXgvvyGuTayiqnj5P9AsN9kwM5rzvwCANj/Zehl5fuJXUHIft9xXKDOgz/blP1aptY5muj+Q5hUvdunDuK7I8ZlsDVAr6sGdFexAFZ1aHVldY9JSE29bUUOUo3tWyDDkLdVOxDthAbzEYTyOGIa3PL6HzAMJC+/N28=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3875.eurprd08.prod.outlook.com (20.178.23.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 12:48:41 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::edcb:1ae:f84c:422a]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::edcb:1ae:f84c:422a%2]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 12:48:40 +0000
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
Subject: Re: [RFC PATCH v2] drm/komeda: fixing of DMA mapping sg segment
 warning
Thread-Topic: [RFC PATCH v2] drm/komeda: fixing of DMA mapping sg segment
 warning
Thread-Index: AQHU6s5KQMOVm+DvoUynXnNB4vwxrKZt9cIA
Date:   Thu, 16 May 2019 12:48:40 +0000
Message-ID: <20190516124840.GB1372@arm.com>
References: <1554372474-3594-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1554372474-3594-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::14) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 865b16bc-2545-41c5-4403-08d6d9fcd27e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3875;
x-ms-traffictypediagnostic: AM0PR08MB3875:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3875AC1DC0C04B798C2C72CDE40A0@AM0PR08MB3875.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(6246003)(6486002)(229853002)(36756003)(6862004)(53936002)(1076003)(2906002)(305945005)(8936002)(6306002)(6512007)(4326008)(6436002)(3846002)(81156014)(6636002)(86362001)(25786009)(71200400001)(71190400001)(68736007)(81166006)(8676002)(66946007)(66556008)(66476007)(73956011)(66446008)(64756008)(5660300002)(76176011)(44832011)(486006)(478600001)(316002)(99286004)(37006003)(2616005)(26005)(386003)(72206003)(6506007)(14454004)(54906003)(7736002)(11346002)(102836004)(14444005)(256004)(446003)(966005)(66066001)(6116002)(476003)(33656002)(52116002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3875;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xBgPsWbqzODh/pz67yTc3sboZ9bAUn1sbvz2iLjcbWqsqj5BcBIuz3JVVhXqOFfUya0leF/g50tyI+iyHCV1onCvPrsUwbPjTFxklQ7dN5sVUoEgC9MlWtiDWMNMf9oZJ+C4vDDQ3i3TVkEgad1CTR+eCp/V/CqRZmDTkMO3V5mwvihuCf8Jh4c1rSO3xEES5eu6NtYbA4Z7l8mq3lLFfV/JNHnZRdXWW0diPw+rkjD8LLJOk6ybO9APfSemwyEzaNZDLhtsEq5Br+ZLcOUVmEjc12RIbOYzhyqIJRTy9upguYH2O/5WOuaqtoVnoCmxMBvHCGdj9Ovmcej3utYCsCBOHxcIA74vUTs1xV0aHMKTG85BuQm5kKt0Ry4u7kPmAvABvrL1EfMIeyklh1hN1IPTrI4RLf9ZeFOZs1Idnsk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <866B84B82452A74C8215892894D68D1B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865b16bc-2545-41c5-4403-08d6d9fcd27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 12:48:40.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3875
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:08:04AM +0100, Lowry Li (Arm Technology China) w=
rote:
> Fixing the DMA mapping sg segment warning, which shows "DMA-API: mapping
> sg segment longer than device claims to support [len=3D921600] [max=3D655=
36]".
> Fixed by setting the max segment size at Komeda driver.
>=20
> This patch depends on:
> - https://patchwork.freedesktop.org/series/54448/
> - https://patchwork.freedesktop.org/series/54449/
> - https://patchwork.freedesktop.org/series/54450/
> - https://patchwork.freedesktop.org/series/58976/
>=20
> Changes since v1:
> - Adds member description
> - Adds patch denpendency in the comment
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 4 ++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 2 ++
>  2 files changed, 6 insertions(+)
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
> index 29e03c4..83ace71 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -149,6 +149,8 @@ struct komeda_dev {
>  	struct device *dev;
>  	/** @reg_base: the base address of komeda io space */
>  	u32 __iomem   *reg_base;
> +	/** @dma_parms: the dma parameters of komeda */
> +	struct device_dma_parameters dma_parms;
> =20
>  	/** @chip: the basic chip information */
>  	struct komeda_chip_info chip;
> --=20
> 1.9.1

lgtm
Reviewed-by: Ayan Kumar Halder <ayan.halder@arm.com>
