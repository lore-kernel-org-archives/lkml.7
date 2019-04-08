Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99945208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JrLzMurT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDHHbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:31:46 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:63446
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbfDHHbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUUv9BNJOzBYOl9wbGfu8k0s3qm9PLlrOD1FWwnx8WE=;
 b=JrLzMurTFwMgYOUEzAJxCg6Z9hL/i+cwc7dC7X9z0YiJ3rZni/7xXFYtcLYtK8qp0LiCZsKYTdSglKy6WDQe7fQr8KdNxXEbO8ShNLjH6aU/ZKDzEmNHukyjbdF3Ao/xbYqVoNIbReMDGv1mk7weuWYK+6YdoVksOYLSOs6igqA=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB2008.eurprd08.prod.outlook.com (10.168.86.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 07:31:41 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::e47e:4064:53b5:86dc]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::e47e:4064:53b5:86dc%11]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 07:31:41 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [RFC,v2] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Topic: [RFC,v2] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Index: AQHU7d0bWE8jSepnPEOjZfOUt6kavQ==
Date:   Mon, 8 Apr 2019 07:31:41 +0000
Message-ID: <20190408073134.GA1371@james-ThinkStation-P300>
References: <1554372474-3594-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1554372474-3594-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b0de686-93ec-4006-e99f-08d6bbf43e0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0801MB2008;
x-ms-traffictypediagnostic: DB6PR0801MB2008:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB2008D6E8767A71CE165D3E1BB32C0@DB6PR0801MB2008.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(6486002)(25786009)(11346002)(54906003)(6246003)(256004)(186003)(229853002)(53936002)(446003)(476003)(14454004)(33656002)(478600001)(58126008)(52116002)(14444005)(6512007)(9686003)(6306002)(486006)(102836004)(55236004)(316002)(86362001)(386003)(6506007)(33716001)(6862004)(1076003)(4326008)(26005)(76176011)(2906002)(6636002)(6116002)(7736002)(3846002)(97736004)(99286004)(8936002)(6436002)(305945005)(966005)(8676002)(5660300002)(71200400001)(71190400001)(105586002)(106356001)(81156014)(81166006)(68736007)(66066001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB2008;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RZB0iWW543to3eOmd71bcNFJey9bj60sG6UGzbOLOdcHSMyaMpBKzG1bbXlG+ubWfjxCCZqkGGW8sjUp+V+Mr4mJdHY0dW+9XxnhEqPmRjEB5+1awfVc1tF32r86NTpo7ISfzmYy4WHJWx98pYHD47bI4tlqdOIkQygG1KlGSI3tX+SO+Qc4L02ZQrIZpfGVACWIij9yFyEU1eGgwAXjbkPCpdesXu7ZMPO60UMjD2Cp0INFqp+gT6XEHDohK5IdH7Jjw2H1xtPW1oQQvwjMcQoE2mcgLNgpczMq1bNkwybykp6qTsMCLpb+nLTR0CgqFpAU5kn86MMVKGG155OZcjLJPOnRfaWOlf/PPtu/ci05nUw9+/BNwQn++YxlFng4OSBCrsOjrH6JWdNQTO5uubwjozFtnyU23eAXqR8ETQI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F2B81554C5E314DB04AF3FB0552B446@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0de686-93ec-4006-e99f-08d6bbf43e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 07:31:41.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:08:04AM +0000, Lowry Li (Arm Technology China) w=
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

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
