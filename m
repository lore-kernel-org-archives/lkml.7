Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C12C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 03:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6DD206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 03:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7Id+vXf6";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7Id+vXf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbfIZD0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 23:26:00 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:55779
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387423AbfIZD0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 23:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBIyBl2iC81d78tumwoJcMGRL/PdA5m1O7V2YMcHl8Y=;
 b=7Id+vXf66QBQVk9d1HEc7aetsm5ocfF+XFoRbdWlEMWSfyiU1YLxCeQyKYmzjE2leOXvBam6ODifWbYl+U19cNj0agyocx813LaRIpEwMAYvmKxs/c85vaEoY5YXCaKVJHxqKr3w/EBv1NBSANZXgY5tTb5B2I7Srpc+hBCd+dU=
Received: from AM6PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:20b:c0::14)
 by DBBPR08MB4379.eurprd08.prod.outlook.com (2603:10a6:10:cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Thu, 26 Sep
 2019 03:25:49 +0000
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by AM6PR08CA0026.outlook.office365.com
 (2603:10a6:20b:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 03:25:48 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT064.mail.protection.outlook.com (10.152.21.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 26 Sep 2019 03:25:47 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Thu, 26 Sep 2019 03:25:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d2ebba0cd6bf2ba4
X-CR-MTA-TID: 64aa7808
Received: from d5194bfeddec.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9E465989-A415-4CA7-9477-ED411E4F59EA.1;
        Thu, 26 Sep 2019 03:25:37 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2051.outbound.protection.outlook.com [104.47.4.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d5194bfeddec.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 26 Sep 2019 03:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG0McL/8ri2zDtuGYtqRCQq+aumBXjYlzVjMOy11owndEOlO+RxKqLHe4yKyDMe5RXQ0qMHy66QI6qXCWgNSMkP5RmAv7SaQMF5N/OXGN2jJ9DVoqgDIAp/N/QKB/GLZCtW7GXEMjmehO7rXBIteKWTpFEVbXaC4Ff4G5/RKs3E+zlL3B1W8OSgXCb6owStzuWdzelvVmgV/1CNexfID3AsUNpvqYPOdiC0k6Kw2qgjGcpFA7g07VaBfBLUif/YYi2r2AquyMcMVlzZoSabEXov1yTSFruDq6VAzNp0xGP0FIgXAu9VzVSX7ToctrjysmSz2/iYwLdBY3xzi0EEZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBIyBl2iC81d78tumwoJcMGRL/PdA5m1O7V2YMcHl8Y=;
 b=EF1roMgwEUoy/LkwqoTdpV4ldOk5Nr6jWMPUAtgBT4V4izG3edbr1Lc9/lOvysauleuXY3Qkl3gPBJstj5wQ6KWzQEWUS0+bo4HZijP5E4zVvI3+MsgHd1RNmq0sNPFU1wktIu3RBwKccEGzdbrPxcvPsJEKvcKpADNagajzfunrIedaxz6oi4k2CHa4aJjpzoquwW0X7DBUdgu/BGvoBXH1UN6QZSifXBczpwz4nmjxQ/qLHMntOPphtuN8kdyQZ9edznAbJaAJaVD/PXeanlyYP+hokHSGODzaB7Sn/j9ZnHcOkO/Ww4rL/quWtdLD20RgLa6pwFnu8vnpSWaTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBIyBl2iC81d78tumwoJcMGRL/PdA5m1O7V2YMcHl8Y=;
 b=7Id+vXf66QBQVk9d1HEc7aetsm5ocfF+XFoRbdWlEMWSfyiU1YLxCeQyKYmzjE2leOXvBam6ODifWbYl+U19cNj0agyocx813LaRIpEwMAYvmKxs/c85vaEoY5YXCaKVJHxqKr3w/EBv1NBSANZXgY5tTb5B2I7Srpc+hBCd+dU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4751.eurprd08.prod.outlook.com (10.255.113.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Thu, 26 Sep 2019 03:25:33 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 03:25:33 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: drm/komeda: Adds power management support
Thread-Topic: drm/komeda: Adds power management support
Thread-Index: AQHVdBoOCBLmYaWBFUSgxZGVp2Iz+A==
Date:   Thu, 26 Sep 2019 03:25:33 +0000
Message-ID: <20190926032526.GA5374@jamwan02-TSP300>
References: <20190923015908.26627-1-lowry.li@arm.com>
In-Reply-To: <20190923015908.26627-1-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:2e::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: baae15f7-cd68-466c-3d31-08d74231395e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4751;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4751:|VE1PR08MB4751:|DBBPR08MB4379:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4379F76606D33FD9C87BA96EB3860@DBBPR08MB4379.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4303;OLM:3968;
x-forefront-prvs: 0172F0EF77
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(6246003)(1076003)(102836004)(86362001)(256004)(99286004)(14444005)(5660300002)(33656002)(52116002)(6116002)(3846002)(76176011)(486006)(966005)(446003)(478600001)(11346002)(33716001)(476003)(2906002)(6506007)(386003)(14454004)(9686003)(6512007)(6306002)(186003)(66446008)(25786009)(66476007)(6636002)(64756008)(6862004)(54906003)(8676002)(58126008)(55236004)(66556008)(305945005)(7736002)(6486002)(66946007)(66066001)(71190400001)(229853002)(6436002)(71200400001)(4326008)(26005)(81166006)(81156014)(316002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4751;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: Cn1StOZiEwr69Ml/S6hKeQXh1xnqNi2hiO9s9ItHg82FpPd8FgKCq7/gQGA6I4p8OtKLIHzO1Qwk+Mi1qhnA+DDAa3g4u6uQKJ9y83kJYQ49AptyDjEAE+bKzZPmbBuNobJq23Nvsj1azK/uVvdjPL40hmg+fMZZGQ3RPFfb9xCc+10Pl6Z7suQLmaS7Sl/u9qTbdt9dPJPiiP01W1H/RiV+v3KcBGIfkdf/cbeiSvY6+Kbt1Qe681goAHcWdSwWLT2NIG3ur69vNoYcaFuq6bk0kVmH7e2l6sgRa5uhbL0vCv9mXKq8rnIaYB+cbLo+0D3TVh6OqHY47NtIVTiTFOqVbnDtWtldzt8vagztBO8u7kMBzaSB3buWYKxEy1sVlPaX6OhKf7bKeFe/5+wk4EFqtHfU8zVK/GTX9wvuWXRW0RrxFvKFQ7ZM3N/mB1iq6N47AJ5y6RjK6YbHUnJkvQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <749D52C9C4E423429C4D8095F1855F04@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4751
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(70206006)(8746002)(8936002)(54906003)(58126008)(186003)(126002)(316002)(86362001)(486006)(46406003)(26826003)(6512007)(9686003)(76130400001)(386003)(66066001)(6506007)(25786009)(478600001)(102836004)(23726003)(4326008)(22756006)(47776003)(7736002)(6862004)(26005)(6246003)(305945005)(99286004)(81166006)(8676002)(81156014)(97756001)(1076003)(6306002)(356004)(50466002)(76176011)(5660300002)(6636002)(446003)(6486002)(336012)(3846002)(14454004)(6116002)(476003)(11346002)(70586007)(33716001)(229853002)(63350400001)(14444005)(966005)(33656002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4379;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9a01d841-3a41-436a-bc86-08d7423130a6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DBBPR08MB4379;
NoDisclaimer: True
X-Forefront-PRVS: 0172F0EF77
X-Microsoft-Antispam-Message-Info: OxJzLX1hAGIqR4bNUGQRvbhwx3i2MlUEY4tKWwIw9MFrAQaWW8EyBVoJSfk0XFrSW3qS0bogdVwElJuL9Rlp+fGOLlb2WQZAxtNFf1TayadVo9q0GHBxQA/N9z6raUEdULaL/jYnMX7IhzcxrVf24CcKJcPktl/8HF2TCX10IaNyc9yNpqgl89EB40eTr6EZkoV2D8xBNs4j0Bk47KCJF+eQmf0luCNhirmkaq3xiLNmbt/ce9ralRjD18XeEoiM/bJh0zUsEufMFIY8i2cQhnwklTIKNVuXh7haON7/Yy4QjS7qFQKRNElwwG8OV1mmCVKA13NVrGvcmKhy1h5W8SeY8TM10rAPZRbfPBeEtB6LOSIFaa4XIUD3nCuR4rZqtb8a+C/mIYh4b0R9SC+jPeX17+aIPzuezY03QL07kIeOs1cwDZqcCmfEn33+JyvqqAdfMGY5EPbJScqpwsF5uQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 03:25:47.8852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baae15f7-cd68-466c-3d31-08d74231395e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 01:59:25AM +0000, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Adds system power management support in KMS kernel driver.
>=20
> Depends on:
> https://patchwork.freedesktop.org/series/62377/
>=20
> Changes since v1:
> Since we have unified mclk/pclk/pipeline->aclk to one mclk, which will
> be turned on/off when crtc atomic enable/disable, removed runtime power
> management.
> Removes run time get/put related flow.
> Adds to disable the aclk when register access finished.
>=20
> Changes since v2:
> Rebases to the drm-misc-next branch.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

will push it to drm-misc-next.

> ---
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  1 -
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 65 +++++++++++++++++--
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   | 30 ++++++++-
>  4 files changed, 91 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 38d5cb20e908..b47c0dabd0d1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -5,7 +5,6 @@
>   *
>   */
>  #include <linux/clk.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
> =20
>  #include <drm/drm_atomic.h>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index bee4633cdd9f..8a03324f02a5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -258,7 +258,7 @@ struct komeda_dev *komeda_dev_create(struct device *d=
ev)
>  			  product->product_id,
>  			  MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id));
>  		err =3D -ENODEV;
> -		goto err_cleanup;
> +		goto disable_clk;
>  	}
> =20
>  	DRM_INFO("Found ARM Mali-D%x version r%dp%d\n",
> @@ -271,19 +271,19 @@ struct komeda_dev *komeda_dev_create(struct device =
*dev)
>  	err =3D mdev->funcs->enum_resources(mdev);
>  	if (err) {
>  		DRM_ERROR("enumerate display resource failed.\n");
> -		goto err_cleanup;
> +		goto disable_clk;
>  	}
> =20
>  	err =3D komeda_parse_dt(dev, mdev);
>  	if (err) {
>  		DRM_ERROR("parse device tree failed.\n");
> -		goto err_cleanup;
> +		goto disable_clk;
>  	}
> =20
>  	err =3D komeda_assemble_pipelines(mdev);
>  	if (err) {
>  		DRM_ERROR("assemble display pipelines failed.\n");
> -		goto err_cleanup;
> +		goto disable_clk;
>  	}
> =20
>  	dev->dma_parms =3D &mdev->dma_parms;
> @@ -296,11 +296,14 @@ struct komeda_dev *komeda_dev_create(struct device =
*dev)
>  	if (mdev->iommu && mdev->funcs->connect_iommu) {
>  		err =3D mdev->funcs->connect_iommu(mdev);
>  		if (err) {
> +			DRM_ERROR("connect iommu failed.\n");
>  			mdev->iommu =3D NULL;
> -			goto err_cleanup;
> +			goto disable_clk;
>  		}
>  	}
> =20
> +	clk_disable_unprepare(mdev->aclk);
> +
>  	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
>  	if (err) {
>  		DRM_ERROR("create sysfs group failed.\n");
> @@ -313,6 +316,8 @@ struct komeda_dev *komeda_dev_create(struct device *d=
ev)
> =20
>  	return mdev;
> =20
> +disable_clk:
> +	clk_disable_unprepare(mdev->aclk);
>  err_cleanup:
>  	komeda_dev_destroy(mdev);
>  	return ERR_PTR(err);
> @@ -330,8 +335,12 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  	debugfs_remove_recursive(mdev->debugfs_root);
>  #endif
> =20
> +	if (mdev->aclk)
> +		clk_prepare_enable(mdev->aclk);
> +
>  	if (mdev->iommu && mdev->funcs->disconnect_iommu)
> -		mdev->funcs->disconnect_iommu(mdev);
> +		if (mdev->funcs->disconnect_iommu(mdev))
> +			DRM_ERROR("disconnect iommu failed.\n");
>  	mdev->iommu =3D NULL;
> =20
>  	for (i =3D 0; i < mdev->n_pipelines; i++) {
> @@ -359,3 +368,47 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
> =20
>  	devm_kfree(dev, mdev);
>  }
> +
> +int komeda_dev_resume(struct komeda_dev *mdev)
> +{
> +	int ret =3D 0;
> +
> +	clk_prepare_enable(mdev->aclk);
> +
> +	if (mdev->iommu && mdev->funcs->connect_iommu) {
> +		ret =3D mdev->funcs->connect_iommu(mdev);
> +		if (ret < 0) {
> +			DRM_ERROR("connect iommu failed.\n");
> +			goto disable_clk;
> +		}
> +	}
> +
> +	ret =3D mdev->funcs->enable_irq(mdev);
> +
> +disable_clk:
> +	clk_disable_unprepare(mdev->aclk);
> +
> +	return ret;
> +}
> +
> +int komeda_dev_suspend(struct komeda_dev *mdev)
> +{
> +	int ret =3D 0;
> +
> +	clk_prepare_enable(mdev->aclk);
> +
> +	if (mdev->iommu && mdev->funcs->disconnect_iommu) {
> +		ret =3D mdev->funcs->disconnect_iommu(mdev);
> +		if (ret < 0) {
> +			DRM_ERROR("disconnect iommu failed.\n");
> +			goto disable_clk;
> +		}
> +	}
> +
> +	ret =3D mdev->funcs->disable_irq(mdev);
> +
> +disable_clk:
> +	clk_disable_unprepare(mdev->aclk);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index 8acf8c0601cc..414200233b64 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -224,4 +224,7 @@ void komeda_print_events(struct komeda_events *evts);
>  static inline void komeda_print_events(struct komeda_events *evts) {}
>  #endif
> =20
> +int komeda_dev_resume(struct komeda_dev *mdev);
> +int komeda_dev_suspend(struct komeda_dev *mdev);
> +
>  #endif /*_KOMEDA_DEV_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_drv.c
> index 69ace6f9055d..d6c2222c5d33 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -8,6 +8,7 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/component.h>
> +#include <linux/pm_runtime.h>
>  #include <drm/drm_of.h>
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> @@ -136,13 +137,40 @@ static const struct of_device_id komeda_of_match[] =
=3D {
> =20
>  MODULE_DEVICE_TABLE(of, komeda_of_match);
> =20
> +static int __maybe_unused komeda_pm_suspend(struct device *dev)
> +{
> +	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
> +	struct drm_device *drm =3D &mdrv->kms->base;
> +	int res;
> +
> +	res =3D drm_mode_config_helper_suspend(drm);
> +
> +	komeda_dev_suspend(mdrv->mdev);
> +
> +	return res;
> +}
> +
> +static int __maybe_unused komeda_pm_resume(struct device *dev)
> +{
> +	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
> +	struct drm_device *drm =3D &mdrv->kms->base;
> +
> +	komeda_dev_resume(mdrv->mdev);
> +
> +	return drm_mode_config_helper_resume(drm);
> +}
> +
> +static const struct dev_pm_ops komeda_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(komeda_pm_suspend, komeda_pm_resume)
> +};
> +
>  static struct platform_driver komeda_platform_driver =3D {
>  	.probe	=3D komeda_platform_probe,
>  	.remove	=3D komeda_platform_remove,
>  	.driver	=3D {
>  		.name =3D "komeda",
>  		.of_match_table	=3D komeda_of_match,
> -		.pm =3D NULL,
> +		.pm =3D &komeda_pm_ops,
>  	},
>  };
> =20
