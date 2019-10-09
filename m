Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E54C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002F120B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JmIbiyiN";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JmIbiyiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfJIFyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 01:54:37 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:47535
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbfJIFyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 01:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs57qjC/o2vUL4xzoPCGby3uSI6yE0u1KgaASApH3zA=;
 b=JmIbiyiN283QcXiMce8l/Mf2mlgiLR34N3PTgPBMTvMNUMRsz/rgjZ8hD4M//7uLlsn5vfBQDlUA5+DkVKomzNJPZ/FoW/4Uq0HfeNhIaBECrKVQdhoYEVdhwMFRRqT7wWNdxLWjGSrPQ6RKnFIWpqwah5Y1dbqtMBR28TyqSn0=
Received: from AM6PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:20b:c0::14)
 by VI1PR08MB3856.eurprd08.prod.outlook.com (2603:10a6:803:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 9 Oct
 2019 05:54:29 +0000
Received: from VE1EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by AM6PR08CA0026.outlook.office365.com
 (2603:10a6:20b:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 9 Oct 2019 05:54:29 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT040.mail.protection.outlook.com (10.152.18.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 9 Oct 2019 05:54:27 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Wed, 09 Oct 2019 05:54:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2f801ab74e46cdbb
X-CR-MTA-TID: 64aa7808
Received: from 2524e65c3e20.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 310EAD6E-9982-4FA6-973A-D9322ECE0F24.1;
        Wed, 09 Oct 2019 05:54:18 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2524e65c3e20.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 09 Oct 2019 05:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxvttFIJcrCPYuALLunSVoyjMMJAjr3AyUYI0MdQUiGh16Gh3gjb+F77RBThTu6Pz45sQi5COSJmdbeoUUixFfTtNZ7NX0Zd8ApdRkxncwAwstjTfpoJOTLfeCbPhQ6tVEXr8kNneSxhCVycuA6sgGgHqANuhYNhIhcQ1ZOtelBLTmIZeRP54PWAt/KNQgjfvjmYAiRhZMCR9KuwqLf/NBXvZnyHCsYqWBV3G77YmgxnQhyQXfdkB7mMr5suluZVI2XGo4fo4rcf3M6yZ3MLScYiMaosm4BIq39fzZfW4tnEnZQIS2hh/9JvdfPWmeZFkuSjw78h4TomLulN93l7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs57qjC/o2vUL4xzoPCGby3uSI6yE0u1KgaASApH3zA=;
 b=d5kGLauWTp30vFmjuDbWSHwoOm99J8jVTZNkxKh43DKXRqq/cbOmM5o9iCBcchFfc321U2uNf+4S6I2uWqpkprgFbyWTy0oXgMwuKgA4Uyoj+gW7cqmMM5dcNsEKRJ9df57bn9+uffXmbQU7DKlBsG5rx7vuHdNHAP0G/aqj66IDIKJ/jeL4yrp4jadlvw1pA5aRA/K5Sx6KmLVfCgoKnQtUbXE593KiDw8dAgiZCv+1DW3OzCjZWQ8BddYylRq1m2dQrU0ADY33cFNrbm0o0MatKWqP+MAqNMlFT1i5tbjRKyozbf8daQ0lPt8iZrJ/SIzkJRSVIxz7mPtOrBMOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs57qjC/o2vUL4xzoPCGby3uSI6yE0u1KgaASApH3zA=;
 b=JmIbiyiN283QcXiMce8l/Mf2mlgiLR34N3PTgPBMTvMNUMRsz/rgjZ8hD4M//7uLlsn5vfBQDlUA5+DkVKomzNJPZ/FoW/4Uq0HfeNhIaBECrKVQdhoYEVdhwMFRRqT7wWNdxLWjGSrPQ6RKnFIWpqwah5Y1dbqtMBR28TyqSn0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5245.eurprd08.prod.outlook.com (20.179.31.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 05:54:15 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2305.023; Wed, 9 Oct 2019
 05:54:15 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVfmX7+sBzYHhR8EiYyRUjNjETpw==
Date:   Wed, 9 Oct 2019 05:54:15 +0000
Message-ID: <20191009055407.GA3082@jamwan02-TSP300>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
In-Reply-To: <20191004143418.53039-4-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 62ddde36-cd9a-4c55-dfb0-08d74c7d251f
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5245:|VE1PR08MB5245:|VI1PR08MB3856:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3856CAA3BAEDA757B05CDF8BB3950@VI1PR08MB3856.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1060;OLM:1060;
x-forefront-prvs: 018577E36E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(366004)(376002)(396003)(39860400002)(136003)(199004)(189003)(33716001)(54906003)(81156014)(81166006)(99286004)(8676002)(25786009)(8936002)(71190400001)(71200400001)(86362001)(5024004)(256004)(14454004)(14444005)(33656002)(316002)(58126008)(478600001)(4326008)(6862004)(5660300002)(6246003)(1076003)(30864003)(486006)(476003)(6512007)(66556008)(66476007)(64756008)(66946007)(6486002)(6636002)(2906002)(7736002)(66066001)(305945005)(66446008)(6436002)(229853002)(9686003)(6116002)(3846002)(26005)(186003)(76176011)(52116002)(102836004)(386003)(6506007)(55236004)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5245;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gOekTMqfOQ/DS4WgsHQxywjCboVD+82WS8P0JHVNtZSutl4xLNIet6fwisKLoXlF4fDUHKyf9SuSeCDiF5wnqS3crO7sr2lmSxsUR8AFZq9uMiLkQHXzKYpEJwcFF+b7ZMKdqOYWsrGiLdmvZSL+dsb2pkWSnXFpYzxNlP132tQXY/lXx/14TfW68i3Tv/GYjKgU3F4UfLUlLvDKLR3C0Cd42vcVIM0TNwoxE2OTxjMJzJQjVgIvWvH1IdUJHW6k6LsayROcvvG+eI1yNojQ1W95feAJexqYq5TrEG3MSAVawM8mEKK9jfir7qKVu/83/Qo7Lxt0BveLUdPQ6FII67CBWfl2qwH7tlPqm1LbzYghYWL5CiJswTPCYSx9VeELT+MQQuQLDgZNZVVR4630jyQOKWxY+Xj1ZyTxh3TCPsQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6636E9631376EA46B83E0EA87169D253@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5245
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(47776003)(316002)(5660300002)(14454004)(58126008)(186003)(1076003)(26826003)(36906005)(2906002)(66066001)(22756006)(97756001)(50466002)(6636002)(70206006)(478600001)(386003)(102836004)(76176011)(3846002)(6506007)(23726003)(6116002)(99286004)(54906003)(33656002)(70586007)(30864003)(26005)(14444005)(5024004)(6862004)(8676002)(8746002)(8936002)(63350400001)(81166006)(81156014)(356004)(11346002)(126002)(476003)(86362001)(6246003)(446003)(7736002)(107886003)(336012)(229853002)(4326008)(25786009)(46406003)(486006)(6486002)(9686003)(6512007)(305945005)(33716001)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3856;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e7318fbb-8286-4b33-65a4-08d74c7d1e0e
NoDisclaimer: True
X-Forefront-PRVS: 018577E36E
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgYm2+CLEKyqju3UJs71LQOiq5Klq5yDqUcS+5CIMt/+PTHqI0UoHyACgPh8MOICPDmSMTNc1Ki2F5ePZU77W99DSi64tI1KFdCYyhYp2Ch7RVqbC7SAF7ttk9dTpQz+UmJvjTczKRNuqzlgpRE5RQ0ZGdtn4TxbouLaTo4yHz3YO0UsqBT/aNhfpKVwuyCdvQWJwO8lZuxA1YtEIhWdyhPc37STOFvXUZgarrnXKbO8uzWAaQFdfjRD0e5ZjUO6+5Ml36YXmvdwMwem44m+di/nHmEVrwuOwjjTVXenI9Wg4yfvwjZIp786VgAi1BjI6lS3qs6/nMN4pzAhVt6sWjXhnhoBGLq9zrItZqAeYVNVpED6WQRC5FyHoQOlUgQsudlo+1etLgvPF0A4hneVrR6ONr/2a/CmIdRB+/s5VgI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 05:54:27.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ddde36-cd9a-4c55-dfb0-08d74c7d251f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:34:42PM +0000, Mihail Atanassov wrote:
> To support transmitters other than the tda998x, we need to allow
> non-component framework bridges to be attached to a dummy drm_encoder in
> our driver.
>=20
> For the existing supported encoder (tda998x), keep the behaviour as-is,
> since there's no way to unbind if a drm_bridge module goes away under
> our feet.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   |   5 +
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  58 ++++++--
>  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 133 +++++++++++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |   5 +
>  4 files changed, 187 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index e392b8ffc372..64d2902e2e0c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -176,6 +176,11 @@ struct komeda_dev {
> =20
>  	/** @irq: irq number */
>  	int irq;
> +	/** @has_components:
> +	 *
> +	 * if true, use the component framework to bind/unbind driver
> +	 */
> +	bool has_components;
> =20
>  	/** @lock: used to protect dpmode */
>  	struct mutex lock;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_drv.c
> index 9ed25ffe0e22..34cfc6a4c3e4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -10,6 +10,8 @@
>  #include <linux/component.h>
>  #include <linux/pm_runtime.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_encoder.h>
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> =20
> @@ -69,18 +71,35 @@ static int compare_of(struct device *dev, void *data)
>  	return dev->of_node =3D=3D data;
>  }
> =20
> -static void komeda_add_slave(struct device *master,
> -			     struct component_match **match,
> -			     struct device_node *np,
> -			     u32 port, u32 endpoint)
> +static int komeda_add_slave(struct device *master,
> +			    struct komeda_drv *mdrv,
> +			    struct component_match **match,
> +			    struct device_node *np,
> +			    u32 port, u32 endpoint)
>  {
>  	struct device_node *remote;
> +	struct drm_bridge *bridge;
> +	int ret =3D 0;
> =20
>  	remote =3D of_graph_get_remote_node(np, port, endpoint);
> -	if (remote) {
> +	if (!remote)
> +		return 0;
> +
> +	if (komeda_remote_device_is_component(np, port, endpoint)) {
> +		mdrv->mdev.has_components =3D true;
>  		drm_of_component_match_add(master, match, compare_of, remote);
> -		of_node_put(remote);
> +		goto exit;
> +	}
> +
> +	bridge =3D of_drm_find_bridge(remote);
> +	if (!bridge) {
> +		ret =3D -EPROBE_DEFER;
> +		goto exit;
>  	}
> +
> +exit:
> +	of_node_put(remote);
> +	return ret;
>  }
> =20
>  static int komeda_platform_probe(struct platform_device *pdev)
> @@ -89,6 +108,7 @@ static int komeda_platform_probe(struct platform_devic=
e *pdev)
>  	struct component_match *match =3D NULL;
>  	struct device_node *child;
>  	struct komeda_drv *mdrv;
> +	int ret;
> =20
>  	if (!dev->of_node)
>  		return -ENODEV;
> @@ -101,14 +121,27 @@ static int komeda_platform_probe(struct platform_de=
vice *pdev)
>  		if (of_node_cmp(child->name, "pipeline") !=3D 0)
>  			continue;
> =20
> -		/* add connector */
> -		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 0);
> -		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 1);
> +		/* attach any remote devices if present */
> +		ret =3D komeda_add_slave(dev, mdrv, &match, child,
> +				       KOMEDA_OF_PORT_OUTPUT, 0);
> +		if (ret)
> +			goto free_mdrv;
> +		ret =3D komeda_add_slave(dev, mdrv, &match, child,
> +				       KOMEDA_OF_PORT_OUTPUT, 1);
> +		if (ret)
> +			goto free_mdrv;
>  	}
> =20
>  	dev_set_drvdata(dev, mdrv);
> =20
> -	return component_master_add_with_match(dev, &komeda_master_ops, match);
> +	return mdrv->mdev.has_components
> +		? component_master_add_with_match(
> +			dev, &komeda_master_ops, match)
> +		: komeda_bind(dev);
> +
> +free_mdrv:
> +	devm_kfree(dev, mdrv);
> +	return ret;
>  }
> =20
>  static int komeda_platform_remove(struct platform_device *pdev)
> @@ -116,7 +149,10 @@ static int komeda_platform_remove(struct platform_de=
vice *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
> =20
> -	component_master_del(dev, &komeda_master_ops);
> +	if (mdrv->mdev.has_components)
> +		component_master_del(dev, &komeda_master_ops);
> +	else
> +		komeda_unbind(dev);
> =20
>  	dev_set_drvdata(dev, NULL);
>  	devm_kfree(dev, mdrv);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 03dcf1d7688f..6eb52d1b20a0 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/component.h>
>  #include <linux/interrupt.h>
> +#include <linux/of_graph.h>
> =20
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -14,6 +15,8 @@
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_irq.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_of.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
> =20
> @@ -267,6 +270,130 @@ static void komeda_kms_mode_config_init(struct kome=
da_kms_dev *kms,
>  	config->helper_private =3D &komeda_mode_config_helpers;
>  }
> =20
> +static void komeda_encoder_destroy(struct drm_encoder *encoder)
> +{
> +	drm_encoder_cleanup(encoder);
> +}
> +
> +static const struct drm_encoder_funcs komeda_dummy_enc_funcs =3D {
> +	.destroy =3D komeda_encoder_destroy,
> +};
> +
> +bool komeda_remote_device_is_component(struct device_node *local,
> +				       u32 port, u32 endpoint)
> +{
> +	struct device_node *remote;
> +	char const * const component_devices[] =3D {
> +		"nxp,tda998x",

I really don't think put this dummy_encoder into komeda is a good
idea.

And I suggest to seperate this dummy_encoder to a individual module
which will build the drm_ridge to a standard drm encoder and component
based module, which will be enable by DT, totally transparent for komeda.

BTW:
I really don't like such logic: distingush the SYSTEM configuration
by check the connected device name, it's hard to maintain and code
sharing, and that's why NOW we have the device-tree.

Thanks
James

> +	};
> +	int i;
> +	bool ret =3D false;
> +
> +	remote =3D of_graph_get_remote_node(local, port, endpoint);
> +	if (!remote)
> +		return false;
> +
> +	/* Coprocessor endpoints are always component based. */
> +	if (port !=3D KOMEDA_OF_PORT_OUTPUT) {
> +		ret =3D true;
> +		goto exit;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(component_devices); ++i) {
> +		if (of_device_is_compatible(remote, component_devices[i])) {
> +			ret =3D true;
> +			goto exit;
> +		}
> +	}
> +
> +exit:
> +	of_node_put(remote);
> +	return ret;
> +}
> +
> +static int komeda_encoder_attach_bridge(struct komeda_dev *mdev,
> +					struct komeda_kms_dev *kms,
> +					struct drm_encoder *encoder,
> +					struct device_node *np)
> +{
> +	struct device_node *remote;
> +	struct drm_bridge *bridge;
> +	u32 crtcs =3D 0;
> +	int ret =3D 0;
> +
> +	if (komeda_remote_device_is_component(np, KOMEDA_OF_PORT_OUTPUT, 0))
> +		return 0;
> +
> +	remote =3D of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
> +	if (!remote)
> +		return 0;
> +
> +	bridge =3D of_drm_find_bridge(remote);
> +	if (!bridge) {
> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	crtcs =3D drm_of_find_possible_crtcs(&kms->base, remote);
> +
> +	encoder->possible_crtcs =3D crtcs ? crtcs : 1;
> +
> +	ret =3D drm_encoder_init(&kms->base, encoder,
> +			       &komeda_dummy_enc_funcs, DRM_MODE_ENCODER_TMDS,
> +			       NULL);
> +	if (ret)
> +		goto exit;
> +
> +	ret =3D drm_bridge_attach(encoder, bridge, NULL);
> +	if (ret)
> +		goto exit;
> +
> +exit:
> +	of_node_put(remote);
> +	return ret;
> +}
> +
> +static int komeda_encoder_attach_bridges(struct komeda_kms_dev *kms,
> +					 struct komeda_dev *mdev)
> +{
> +	int i, err;
> +
> +	for (i =3D 0; i < kms->n_crtcs; i++) {
> +		err =3D komeda_encoder_attach_bridge(
> +			mdev, kms,
> +			&kms->encoders[i], mdev->pipelines[i]->of_node);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int komeda_kms_attach_external(struct komeda_kms_dev *kms,
> +				      struct komeda_dev *mdev)
> +{
> +	int err;
> +
> +	if (mdev->has_components) {
> +		err =3D component_bind_all(mdev->dev, kms);
> +		if (err)
> +			return err;
> +	}
> +
> +	err =3D komeda_encoder_attach_bridges(kms, mdev);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void komeda_kms_detach_external(struct komeda_dev *mdev,
> +				       struct drm_device *drm)
> +{
> +	if (mdev->has_components)
> +		component_unbind_all(mdev->dev, drm);
> +}
> +
>  int komeda_kms_init(struct komeda_kms_dev *kms, struct komeda_dev *mdev)
>  {
>  	struct drm_device *drm;
> @@ -301,7 +428,7 @@ int komeda_kms_init(struct komeda_kms_dev *kms, struc=
t komeda_dev *mdev)
>  	if (err)
>  		goto cleanup_mode_config;
> =20
> -	err =3D component_bind_all(mdev->dev, kms);
> +	err =3D komeda_kms_attach_external(kms, mdev);
>  	if (err)
>  		goto cleanup_mode_config;
> =20
> @@ -332,7 +459,7 @@ int komeda_kms_init(struct komeda_kms_dev *kms, struc=
t komeda_dev *mdev)
>  	drm->irq_enabled =3D false;
>  	mdev->funcs->disable_irq(mdev);
>  free_component_binding:
> -	component_unbind_all(mdev->dev, drm);
> +	komeda_kms_detach_external(mdev, drm);
>  cleanup_mode_config:
>  	drm_mode_config_cleanup(drm);
>  	komeda_kms_cleanup_private_objs(kms);
> @@ -351,7 +478,7 @@ void komeda_kms_fini(struct komeda_kms_dev *kms)
>  	drm_atomic_helper_shutdown(drm);
>  	drm->irq_enabled =3D false;
>  	mdev->funcs->disable_irq(mdev);
> -	component_unbind_all(mdev->dev, drm);
> +	komeda_kms_detach_external(mdev, drm);
>  	drm_mode_config_cleanup(drm);
>  	komeda_kms_cleanup_private_objs(kms);
>  	drm->dev_private =3D NULL;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index e81ceb298034..c2856e19d092 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -12,6 +12,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_device.h>
> +#include <drm/drm_encoder.h>
>  #include <drm/drm_writeback.h>
>  #include <drm/drm_print.h>
> =20
> @@ -123,6 +124,7 @@ struct komeda_kms_dev {
>  	int n_crtcs;
>  	/** @crtcs: crtcs list */
>  	struct komeda_crtc crtcs[KOMEDA_MAX_PIPELINES];
> +	struct drm_encoder encoders[KOMEDA_MAX_PIPELINES];
>  };
> =20
>  #define to_kplane(p)	container_of(p, struct komeda_plane, base)
> @@ -184,4 +186,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *k=
crtc,
>  int komeda_kms_init(struct komeda_kms_dev *kms, struct komeda_dev *mdev)=
;
>  void komeda_kms_fini(struct komeda_kms_dev *kms);
> =20
> +bool komeda_remote_device_is_component(struct device_node *local,
> +				       u32 port, u32 endpoint);
> +
>  #endif /*_KOMEDA_KMS_H_*/
