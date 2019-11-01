Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD07CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5F0208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Fs/TA/K7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Fs/TA/K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfKAHUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:20:32 -0400
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:37889
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730027AbfKAHUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7tgfNcvMTJSUlC2av04KA56U74yCuZ43fPHwfPy420=;
 b=Fs/TA/K7Vsxubf9C5DiuNRuav1xHmRltru576tHrlscdOP/QQMosfRRoGw29JA3bPhksbxXL02STwnJ4QClIBAzgtDoT0KSFkGHtyctDdwgpzWmERMXkbmeEQj8ZJmcu2LIoMdOBuJv3BJ3REkfl/rLoA0l9z+Tc3x5bostd/OU=
Received: from DB7PR08CA0040.eurprd08.prod.outlook.com (2603:10a6:10:26::17)
 by DB8PR08MB4969.eurprd08.prod.outlook.com (2603:10a6:10:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 07:18:41 +0000
Received: from AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by DB7PR08CA0040.outlook.office365.com
 (2603:10a6:10:26::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 07:18:41 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT055.mail.protection.outlook.com (10.152.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 07:18:41 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Fri, 01 Nov 2019 07:18:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c07eaf8f2f6095a5
X-CR-MTA-TID: 64aa7808
Received: from cd2dd2e60d57.2 (cr-mta-lb-1.cr-mta-net [104.47.8.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A330D3CA-9389-4193-88B2-EAA5558E3056.1;
        Fri, 01 Nov 2019 07:18:35 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cd2dd2e60d57.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 01 Nov 2019 07:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX6w4rW1bW9rmA1YUORawO12lT14+RyTGlnN3mEqJrDmYNmqTqEnoBkZSa9/U9Hk4SkR+cIuZCBOCoYunaUggr+unuFZBe3GBsaLIak0cNQXHFjSYuURYHnhdxvN0RyQ7FsNkW2h4TrEkmg6etd1bVA12ZN1RSIBwRM6Rx1vleK2lfWjzEfo/qDub4vOxdz7zIpKkbi3Vrijpl3H3NMqw4Zwah8D/SrmV4eSleuGk03ZbYgm92IctAgbNypHizu049nFRtgAcK1hLtQHBSexO1o0UAaNkYaOAinZXBNrHuVaQNEU5QgikUPAjxCNnpaBU/cGNEM+CNmZJZ9UakgCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7tgfNcvMTJSUlC2av04KA56U74yCuZ43fPHwfPy420=;
 b=ZBzEwv39/o0OkRUMxvaBncwzh6bXAA/r0ylKWNa6Px29Fv962z7i7e299IMO0mekwhkQubJggK6X0aif+yyXRrmb4Xtot5NZ29CmFrZI1jq8UkQat8hAJ1j7HXxH/bB4cWxKJaYRM3+ZyhhE6z0XruGzv7J2sTXHE4IQi5ABqe8keMQlgtrzEiziqqArvOWJVuvopub34dclS+GliPAz4sl8KPIB8g/7a13A7euIcUolvZGSUy87XJvLMmipt0lDwNR4qyO+SzvLC1pwh7LwosJ85WJuoYIt2uR3rEcU1hmqEPrpv4XRmXD/Gn6oqy/1VmTVYjc7+GdHGho0ROh5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7tgfNcvMTJSUlC2av04KA56U74yCuZ43fPHwfPy420=;
 b=Fs/TA/K7Vsxubf9C5DiuNRuav1xHmRltru576tHrlscdOP/QQMosfRRoGw29JA3bPhksbxXL02STwnJ4QClIBAzgtDoT0KSFkGHtyctDdwgpzWmERMXkbmeEQj8ZJmcu2LIoMdOBuJv3BJ3REkfl/rLoA0l9z+Tc3x5bostd/OU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4974.eurprd08.prod.outlook.com (10.255.158.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 07:18:33 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 07:18:33 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [5/5] drm/komeda: add rate limiting disable to err_verbosity
Thread-Topic: [5/5] drm/komeda: add rate limiting disable to err_verbosity
Thread-Index: AQHVkISRRCz1CF9z1ky/sUvh1HNVPQ==
Date:   Fri, 1 Nov 2019 07:18:33 +0000
Message-ID: <20191101071825.GA30377@jamwan02-TSP300>
References: <20191021164654.9642-6-mihail.atanassov@arm.com>
In-Reply-To: <20191021164654.9642-6-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7922448c-3cb7-4a2d-aa8f-08d75e9bb8ef
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:|VE1PR08MB4974:|DB8PR08MB4969:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB496936F0FB2F7A4722E41E89B3620@DB8PR08MB4969.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3826;OLM:3826;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(25786009)(8936002)(6486002)(6246003)(81166006)(229853002)(14444005)(7736002)(71190400001)(476003)(478600001)(5660300002)(486006)(256004)(8676002)(2906002)(3846002)(71200400001)(305945005)(81156014)(6116002)(64756008)(55236004)(66446008)(102836004)(66066001)(66556008)(86362001)(6506007)(4326008)(186003)(6512007)(66476007)(6436002)(316002)(386003)(6862004)(76176011)(99286004)(26005)(54906003)(14454004)(52116002)(33716001)(9686003)(446003)(11346002)(1076003)(58126008)(6636002)(33656002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4974;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lnvYV7sz7Q95/VZca0JzdjAkF9PHDuQM4eInHxz1MmbPv6UIqEsL8Yj1GgBZXJUZEEViDbeiR4pIPfy4YfYRrQbZgJmrvfJCXE0LKsdpRtPAXbHREZtQn0p2gk8ER9WV687qHXzl5xfwi/J6CwJcSn/AnMP4ncOQUmnSFd5py7uodba74yUvBxB5MxLgjHTpB540X7oKLzM4ZDXWVNeLuaCrUMFpG7IDPIYSFg0+WDMXhuozmk01rGX7XbUYdDi2XByLknadVKIN8k8eM7v+dEbdpbOo/k+9aNV05jOlvH1q3rAnhvYaqk0R9OKElK6VnN7ePjN9m9VveF1ND7HHAuWLmi6YcXyPgXbsmhMvCMz0pDmi4b7Xcn9uUdnTf+LfhwqBumO1Vs068dD33/0sx9RRAEGis+hYmLOkS0JEWkRZvdoz9GMIUJAK7tTgR1RZ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD4F2FDEF7E9A94EBE9D640ABDF4B4C9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4974
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(396003)(376002)(39860400002)(136003)(1110001)(339900001)(189003)(199004)(4326008)(99286004)(229853002)(6636002)(9686003)(8746002)(70206006)(26005)(23726003)(70586007)(5660300002)(14454004)(33716001)(8676002)(22756006)(47776003)(3846002)(6512007)(86362001)(356004)(478600001)(33656002)(76130400001)(305945005)(386003)(46406003)(7736002)(6506007)(26826003)(97756001)(6116002)(66066001)(25786009)(76176011)(336012)(6246003)(105606002)(50466002)(6862004)(316002)(107886003)(14444005)(11346002)(446003)(1076003)(8936002)(186003)(2906002)(6486002)(81166006)(102836004)(81156014)(126002)(36906005)(476003)(486006)(58126008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4969;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0903dcab-3482-4dce-1b97-08d75e9bb444
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJXRtZ6K6bwDOaEcyV5LL0Y3G81X70mgMTLnIQZPiZQ6IO2rBP3TQ4rcVbrKWlZLDtUZnMk9/kaLRM5nXd5aNWb9c3RzcwWUQ7YXwd2EXoV8U56UUfPxZA8uu1OTce/rvF2uDHHN7mKE/qgIRznUjXUiqfateMRW+zoGjP/NJWWhYZaojGmaUcDv2RShl5tZ1ExT8kkv4V0p9OZf2ADxsFqE7qd3oerclIyeIMzTpDvbb0TCv0kdI4rMVfO0KULuEk1L8rG0iSaTws1hRUMBCtpN7m8Q2s9vPSKB5YMeeKgUARmaDZjK96XN6F5IaSVVIdpLrOTN4hH4O62/burmDMCRvQVmsEIuJPDxxG8ymdGB4YHeyvMdhLiHOS9G9NzrCfhs4oeUnl2CgMFCJeVwx/bEULulC7bumCtldjNg517/b6WqGvq5ZVQ/J3KEcDPw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 07:18:41.1230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7922448c-3cb7-4a2d-aa8f-08d75e9bb8ef
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:47:35PM +0000, Mihail Atanassov wrote:
> It's possible to get multiple events in a single frame/flip, so add an
> option to print them all.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 2 ++
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index d9fc9c48859a..15f52e304c08 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -224,6 +224,8 @@ struct komeda_dev {
>  #define KOMEDA_DEV_PRINT_INFO_EVENTS BIT(2)
>  	/* Dump DRM state on an error or warning event. */
>  #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
> +	/* Disable rate limiting of event prints (normally one per commit) */
> +#define KOMEDA_DEV_PRINT_DISABLE_RATELIMIT BIT(12)
>  };
> =20
>  static inline bool
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_event.c
> index bf88463bb4d9..86e33fed8a91 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -119,7 +119,8 @@ void komeda_print_events(struct komeda_events *evts, =
struct drm_device *dev)
>  	/* reduce the same msg print, only print the first evt for one frame */
>  	if (evts->global || is_new_frame(evts))
>  		en_print =3D true;
> -	if (!en_print)
> +	if (!(err_verbosity & KOMEDA_DEV_PRINT_DISABLE_RATELIMIT)
> +	    && !en_print)
>  		return;
> =20
>  	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
