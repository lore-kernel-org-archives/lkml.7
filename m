Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4BCC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F13D20851
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SfxFmR39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfETGCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:02:09 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:47870
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728619AbfETGCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izGjinr7pKrb/qL+eP2aMK3XxZzrnl7BtqT6bn9OMzo=;
 b=SfxFmR39kr7XlrxuC/DOTYyXs3NBDR5osI2hWcu2W5321hDrlKpQFIn0QwWTOBHp+vi1wbm5qK+NJerD2aA3MrxVV49vhacXBEL7u+6XnqQMB+6QNxYMXlQgUVhoWPulm8arZpM5FW87An8VkSDzxb1w4kuz+ym17RM1ZHhLD5Q=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4719.eurprd08.prod.outlook.com (10.255.115.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 06:02:04 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 06:02:04 +0000
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
Subject: Re: [v2] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Topic: [v2] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Index: AQHVDtGMYTV2kzYsOkmwOrRFiUsaNg==
Date:   Mon, 20 May 2019 06:02:04 +0000
Message-ID: <20190520060158.GA2547@james-ThinkStation-P300>
References: <1554971813-22049-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1554971813-22049-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07946016-880c-4ce9-6237-08d6dce8aecf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4719;
x-ms-traffictypediagnostic: VE1PR08MB4719:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB47192351F5CCCFB570830AA4B3060@VE1PR08MB4719.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(71200400001)(9686003)(71190400001)(6512007)(14444005)(256004)(6636002)(58126008)(26005)(229853002)(11346002)(476003)(2906002)(486006)(6486002)(54906003)(6436002)(6306002)(33716001)(53936002)(8936002)(6116002)(66066001)(66946007)(66476007)(7736002)(64756008)(3846002)(102836004)(305945005)(66556008)(55236004)(99286004)(52116002)(33656002)(316002)(6862004)(8676002)(6246003)(446003)(66446008)(73956011)(5660300002)(25786009)(4326008)(14454004)(86362001)(76176011)(186003)(81166006)(1076003)(386003)(6506007)(966005)(478600001)(81156014)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4719;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r6zUFDGEzwJvwIqgq+aKYrPWyX9e0Zyd/iLvLu1Kq+0roWMPkGSMUwMdFxgNiNFv4zMZVP8ZCXEogoAi/BYLG2wdZMyuUXy6SKaIt/Ex3eGCZaei/O/rMeXjKP2oSaPDRyfM/Akk8r9LJ08v8Kk64pTi9t3SjpsNZ92y5O41hgu0BwD39dHnKcYPeB3y0tVpgOUPICchc/+ugmYawuPJ3MgN5O+qbpsW1DgGedog4+5HnrYfYc3DFLtNnisE2dMMqgaiwA2bwh9q7ApnXIQ4rv3ebOFd4Id6KVrxS7f1ZW6vdsjzC9R0+9YRGQfphjRwGhda1lO1uJ0vx7lhAk2TT6bPIHOzAK998JEwTkTMXJKHhFmIubSbbwmP5KwUsbsCxxa6uGeXLCA2gPSl5eZC3vcoPRxtaz9RQcPQCtasFyU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D20C1DA5A994F84B8FE9744CA37FBE88@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07946016-880c-4ce9-6237-08d6dce8aecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 06:02:04.5412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:37:13AM +0000, Lowry Li (Arm Technology China) w=
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
> --=20
> 1.9.1
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
