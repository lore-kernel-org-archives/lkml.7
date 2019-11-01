Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157F1CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE8F208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Xb/EI9q4";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Xb/EI9q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfKAHQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:16:26 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:6403
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729817AbfKAHQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rvl27dxvy+0NvLeGYi6v1yA/Q/mRy106n1p+mKxy/8=;
 b=Xb/EI9q4LOuRazAARseG0zsTW9OwnQZ28HOs6kCpQDDbabzUZQf2bGps7MvkmmXTaAjDh509bWx7HkMWejYWyGO5Dw8IU9FN0cdLS9X8QAxgnZLfy4srU1VgazVsxRHoxAHNKId8e/yK/uraRofJWkaULeIJPrWCr4sf1w7Yhf8=
Received: from VI1PR0802CA0037.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::23) by AM0PR08MB3699.eurprd08.prod.outlook.com
 (2603:10a6:208:10c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Fri, 1 Nov
 2019 07:16:21 +0000
Received: from DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by VI1PR0802CA0037.outlook.office365.com
 (2603:10a6:800:a9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 07:16:20 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT027.mail.protection.outlook.com (10.152.20.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 07:16:20 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Fri, 01 Nov 2019 07:16:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 83013ce34c001d37
X-CR-MTA-TID: 64aa7808
Received: from 27f1c32a6e83.2 (cr-mta-lb-1.cr-mta-net [104.47.8.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0223B255-40EA-4E6C-B3BB-4879E5D45889.1;
        Fri, 01 Nov 2019 07:16:15 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 27f1c32a6e83.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 01 Nov 2019 07:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJiC7GuOCePuuYxUz2f2NiAEVsgMQzIk8bslKDjhIxMIOM/vIOQral+BlUUfpGcf/+NJRp9/nejcfmdHQmZUnD9+xUvhyqRm0+he8mKnQXhyNHBziIoFA6QeoFt07u6/28DC/zz1g7mGl7UrttTHbesmQEw3lurnPLfBIIBfzKIftaiXL5Tqa/x6W/8XA1LKBLrBXLeWmPT+bFMtLJz4n07ymHmbDl+juNLfiuhtMRF7bLh0CxEmY+o4XG3PanI0C7iBeVtF0KacRCcvTVQoxf68ZXXZ0QWFuGZt7NtY5SBtT3uAxwsFBFLFwNdCszLVY3f5GuQGD+Kbf+/XQC9GMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rvl27dxvy+0NvLeGYi6v1yA/Q/mRy106n1p+mKxy/8=;
 b=OsV80p8fkWs6fV2qBuJgf/YrXQ+gfbNb3uy/McwHNUKYmPV7IKlh1AEqABii5gsiWwQBtE4r0EUs4hnflxJGcCMoM02AgpkRMkAOnSLBZZSkxXNmFjgP2MJoR5CWzqJ8kLW+pSnGp0gvHwcN1rfF4aB44MQUvt+rgtEx60YFyMBenoWrxW4lO+mKRHRHiAyjBiTTOMrWhm2kQLzpAd7dPkzGGAeLS6b2XyHmpRPAwSNF/HlKvHzl1CjHKi127jBggkQaCaQjSgeWtGCcyS7Ns6Z14zFnuO8S6vTtuhSWvWjlTDLasuXC5MYnSBPVsS15d6F5SrgDlcxN13WVbTkoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rvl27dxvy+0NvLeGYi6v1yA/Q/mRy106n1p+mKxy/8=;
 b=Xb/EI9q4LOuRazAARseG0zsTW9OwnQZ28HOs6kCpQDDbabzUZQf2bGps7MvkmmXTaAjDh509bWx7HkMWejYWyGO5Dw8IU9FN0cdLS9X8QAxgnZLfy4srU1VgazVsxRHoxAHNKId8e/yK/uraRofJWkaULeIJPrWCr4sf1w7Yhf8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4974.eurprd08.prod.outlook.com (10.255.158.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 07:16:13 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 07:16:13 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [2/5] drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
Thread-Topic: [2/5] drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
Thread-Index: AQHVkIQ++XeFcORrh0SX7O3y9pqBSA==
Date:   Fri, 1 Nov 2019 07:16:12 +0000
Message-ID: <20191101071605.GA30091@jamwan02-TSP300>
References: <20191021164654.9642-3-mihail.atanassov@arm.com>
In-Reply-To: <20191021164654.9642-3-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0023.apcprd03.prod.outlook.com
 (2603:1096:202::33) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 076ffceb-beed-4ac6-d6e9-08d75e9b6550
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:|VE1PR08MB4974:|AM0PR08MB3699:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB36998E49833BDFB44BB89F53B3620@AM0PR08MB3699.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1332;OLM:1332;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(25786009)(8936002)(6486002)(6246003)(81166006)(229853002)(14444005)(7736002)(71190400001)(476003)(478600001)(5660300002)(486006)(256004)(8676002)(2906002)(3846002)(71200400001)(305945005)(81156014)(6116002)(64756008)(55236004)(66446008)(102836004)(66066001)(66556008)(86362001)(6506007)(4326008)(186003)(6512007)(66476007)(6436002)(316002)(386003)(6862004)(76176011)(99286004)(26005)(54906003)(14454004)(52116002)(33716001)(9686003)(446003)(11346002)(1076003)(58126008)(6636002)(33656002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4974;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bSB5D2qXRDHJj4Kyt4Sni2GxGhGklJv5BkeS8455aPOg9WPOKg+Nq3QBDeg73XhUSbgRK+M4IxZNFOMDV4yYvAPEJ1t2b8yuKFqDZJE/CaFkfmTnZzLGJfMiEq9G38QL39nq8HOu8ec5vLkIWh5C2dcRJ80Ywc/7GVn1k+utwZx8TBgR/grzaoBBmg+KK7NZXbCEgeID9wC+h9EotBIV5MZX/f/b+Yuieg+iVjNruTVq1IWo/n61Jwjt1AAvHOEYDh4TNPvoygMeb7s/tv/RqlPRbtIFM9GL167cGawWyvmHtFSN8EgA7qsA8iEo76AlNFkgvFFLbSKKB0zbDKfmLiYNUAWyYbw6PajZbBmmJkkWIrNfDJAnkDqJ39Ny6fsetElIOD/sFTE91O26aaaPmqsoCIo7S0daHhQjmS0SjK+h7rOK2/n9kDOj1VvV1tEu
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6AF7F94864C66940BDE85813FB86B2FE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4974
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(396003)(136003)(346002)(39860400002)(1110001)(339900001)(189003)(199004)(446003)(476003)(6116002)(70586007)(3846002)(486006)(356004)(4326008)(23726003)(6512007)(6636002)(58126008)(25786009)(14454004)(126002)(11346002)(46406003)(8746002)(336012)(33656002)(9686003)(70206006)(99286004)(8936002)(76130400001)(478600001)(8676002)(6486002)(97756001)(33716001)(186003)(1076003)(102836004)(76176011)(86362001)(47776003)(6246003)(14444005)(386003)(229853002)(54906003)(5660300002)(6506007)(2906002)(107886003)(6862004)(26826003)(7736002)(305945005)(316002)(22756006)(81156014)(81166006)(105606002)(50466002)(66066001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3699;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7099d37a-0e75-4296-6899-08d75e9b6079
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tdnI4J5mUbt5r59nexKa+TZ+26YxnWambx7aEiS9Ukx32ppuR3P5pegxmoIa5YBo+DhnnoLIxzPc0VhtD9Tav7XblgNHjmBwFuSfb4SmrF65lTP7p2HlaOWHl8gC/0CP2xe2QndtC9cZUDFftfDUGI5/ArnmdD/gxfzupCoCZde43fPiJyEmW2nOy0bIBCGVf3Sam/uO1uowoxTyi3zoKP4XJ2s4NwPHSGtX47HCyM4pgSsRYVYzibc7fx1tfzmFYgj7DBacHg3s+swEh36ZdrUwMu1s1WRd2fpDOeMzhwCuueRhYQYd+pGaKRP8D8gkav28LTKqENl3WTl8RQKv8frOGJdNkfW3tFnqu3nYh6m4m3ZaTo8GJPvSqeMyipnD3zRo+ExxSShk/Gj/c7DYkSuL7BuxmbJU08gGxOOHTDpoUwr0IgO43cLImdQWPay
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 07:16:20.8422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076ffceb-beed-4ac6-d6e9-08d75e9b6550
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3699
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:47:19PM +0000, Mihail Atanassov wrote:
> Now that there's a debugfs node to control the same, remove the
> config option.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/Kconfig             | 6 ------
>  drivers/gpu/drm/arm/display/komeda/Makefile     | 5 ++---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 6 ------
>  3 files changed, 2 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/Kconfig b/drivers/gpu/drm/arm/di=
splay/Kconfig
> index e87ff8623076..cec0639e3aa1 100644
> --- a/drivers/gpu/drm/arm/display/Kconfig
> +++ b/drivers/gpu/drm/arm/display/Kconfig
> @@ -12,9 +12,3 @@ config DRM_KOMEDA
>  	  Processor driver. It supports the D71 variants of the hardware.
> =20
>  	  If compiled as a module it will be called komeda.
> -
> -config DRM_KOMEDA_ERROR_PRINT
> -	bool "Enable komeda error print"
> -	depends on DRM_KOMEDA
> -	help
> -	  Choose this option to enable error printing.
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/dr=
m/arm/display/komeda/Makefile
> index f095a1c68ac7..1931a7fa1a14 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -16,12 +16,11 @@ komeda-y :=3D \
>  	komeda_crtc.o \
>  	komeda_plane.o \
>  	komeda_wb_connector.o \
> -	komeda_private_obj.o
> +	komeda_private_obj.o \
> +	komeda_event.o
> =20
>  komeda-y +=3D \
>  	d71/d71_dev.o \
>  	d71/d71_component.o
> =20
> -komeda-$(CONFIG_DRM_KOMEDA_ERROR_PRINT) +=3D komeda_event.o
> -
>  obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index b5bd3d5898ee..831c375180f8 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -226,13 +226,7 @@ void komeda_dev_destroy(struct komeda_dev *mdev);
> =20
>  struct komeda_dev *dev_to_mdev(struct device *dev);
> =20
> -#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
>  void komeda_print_events(struct komeda_events *evts, struct drm_device *=
dev);
> -#else
> -static inline void komeda_print_events(struct komeda_events *evts,
> -				       struct drm_device *dev)
> -{}
> -#endif
>

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
>  int komeda_dev_resume(struct komeda_dev *mdev);
>  int komeda_dev_suspend(struct komeda_dev *mdev);
