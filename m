Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA3BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A073520820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aRZ/FYDR";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aRZ/FYDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404564AbfIWClR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:41:17 -0400
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:42722
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727706AbfIWClR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4vsWcnDaPizo30FleE7OKqfrOqCMIvTuGtDMMTtdh0=;
 b=aRZ/FYDRIg936nZItrWwBWHatp9dy3oaC/wnFWO03E2Ag7iJ0WiDdcsbgc6fqQqTV/1JjhGKW7WZ52DdUnippjYXesZsVAfx5EhFX0OO6QUqKbleKyYKXgtVIHhTbDtqSoSVPVnTjX5GFCHSsyUQP9kbvpXeLMxHaQhbyXvdL5E=
Received: from VI1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::22) by DB8PR08MB3964.eurprd08.prod.outlook.com
 (2603:10a6:10:a4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Mon, 23 Sep
 2019 02:41:09 +0000
Received: from VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR0802CA0012.outlook.office365.com
 (2603:10a6:800:aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23 via Frontend
 Transport; Mon, 23 Sep 2019 02:41:09 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT026.mail.protection.outlook.com (10.152.18.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 02:41:07 +0000
Received: ("Tessian outbound d5a1f2820a4f:v31"); Mon, 23 Sep 2019 02:41:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1e0002bd0f0f5a53
X-CR-MTA-TID: 64aa7808
Received: from 0cd2d15c84c9.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 39B58A52-8A4C-45B1-91DF-AB308BBC81CB.1;
        Mon, 23 Sep 2019 02:40:57 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0cd2d15c84c9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Sep 2019 02:40:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuLSOHEWeS3+Fev0VspGyxiwmwZIXh8aaK66l4ARanXP8mza7+5S29p8dDTVb6cIXhbgjUqutL/qpBKxgqE6ObRx7dsRAnl5LDBC0xp/lF5QmdW08B6ppOmXHrAnZONWUuk7GmjV+CdexMlaVPnReSB1pQ/2S2IAVekMfkORtGkxMgT7rZ7PVFA+x+u6kvjF7dJQNi77iX0y//mk4kcJ7BBPw0fY0VUYY4V1mKMIgMrijNQTwQbN9iGa+0+2tjfJfKlfNJ5S/d/dYuzjpn2fthnv0I/xm5ALoHnid4HR7I0E+vAfQ4UtlcV9LB6xJQ5/yi2Aol5Z7icl2EPMtCN/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4vsWcnDaPizo30FleE7OKqfrOqCMIvTuGtDMMTtdh0=;
 b=YRt/TvCX2owXZRtexgqXS6i7qUAh0nFvEuE7TB6RSBhiAowtFCDozIF814JsoPqLpz2WDzgdqOk3SAzUH2hgUWceGymYk+RJLDo31QCLma6zvVMU9xVYED0fngMYuHEYsO9ccogLiatqLALjm6Xxc7sLUNIlxWJRJf8wpYpLmHAGaMZWhigSjiU3als+rI5anvAgHhAKDn7GAZVlTPv2UBkCIih0vYea8wh3i9p3fl6Q2tJytTpyS97fZUFNXQPNCIpsMC7WhUsofTiN7G5lE6aCToTUsK0cpHRJsuTlL41GCKAAL6cwgf7aneHIpGJQBD5Y09rYFG42ip8YWAM51g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4vsWcnDaPizo30FleE7OKqfrOqCMIvTuGtDMMTtdh0=;
 b=aRZ/FYDRIg936nZItrWwBWHatp9dy3oaC/wnFWO03E2Ag7iJ0WiDdcsbgc6fqQqTV/1JjhGKW7WZ52DdUnippjYXesZsVAfx5EhFX0OO6QUqKbleKyYKXgtVIHhTbDtqSoSVPVnTjX5GFCHSsyUQP9kbvpXeLMxHaQhbyXvdL5E=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4814.eurprd08.prod.outlook.com (10.255.115.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Mon, 23 Sep 2019 02:40:54 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 02:40:54 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Topic: [PATCH] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Index: AQHVb8WxZ1V2B5EmMkKFYK26VJ4Bb6c4kQ2A
Date:   Mon, 23 Sep 2019 02:40:54 +0000
Message-ID: <20190923024045.GA24909@jamwan02-TSP300>
References: <20190920151117.22725-1-mihail.atanassov@arm.com>
In-Reply-To: <20190920151117.22725-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 60fa2457-b67c-47e8-4691-08d73fcf7cbc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4814;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4814:|VE1PR08MB4814:|DB8PR08MB3964:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB3964EA20009CAFBF4A5C75ACB3850@DB8PR08MB3964.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(2906002)(33716001)(6116002)(3846002)(66066001)(25786009)(54906003)(316002)(58126008)(1076003)(4326008)(6246003)(14444005)(256004)(33656002)(9686003)(6512007)(305945005)(6636002)(86362001)(6862004)(229853002)(6436002)(52116002)(6486002)(7736002)(476003)(14454004)(5660300002)(386003)(6506007)(71190400001)(71200400001)(76176011)(26005)(186003)(102836004)(446003)(478600001)(55236004)(64756008)(66446008)(66946007)(11346002)(99286004)(486006)(8936002)(66476007)(81156014)(66556008)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4814;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: w8tUNRcn97rkSqk2cUvb3DI+9IYAWOwIebjwCowN4/DUXXsqFrl8Eo5mOuK47p4kv2u6nDJ65xkYZl9xOhbj/i3IgJYRH5vCR6G233jZ8CgjspdUDob+pYyj/Hm7staq/kAkv/VE4tmRxRUKll6dG1gmkTH5TbUasmwJej8VT8fKCZ855TdeAMtZbkXmVdjXXdRAc8URR94CEDGoC59b8A42pW6OGTAVSHmodRO5wgjG3XUHvRX51WmFgmBlJYDKPgkLvDcdqMLzv6i2zWpXFgobsacNDdoen/Amgezzz3gm7qqZCTFRtLd+9VdBj72S5yERFu8HBJPvv0XmKVyx5Clsz22htHPSVi/b990N5HPKIJ0A/KgGB2XMEN0HG7ITtRkBjtre05NjRYI/gJcYOBSxDlxYurQ9kdNczkxm9is=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <893F16B3898512429056213B6D6AC0F9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4814
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(346002)(39860400002)(376002)(189003)(199004)(126002)(476003)(86362001)(66066001)(46406003)(478600001)(356004)(4326008)(54906003)(6512007)(9686003)(81156014)(81166006)(5660300002)(7736002)(36906005)(1076003)(316002)(8746002)(102836004)(229853002)(6862004)(23726003)(58126008)(50466002)(2906002)(47776003)(26005)(305945005)(22756006)(3846002)(6116002)(186003)(336012)(446003)(486006)(70206006)(33656002)(14454004)(99286004)(70586007)(6486002)(6506007)(386003)(25786009)(33716001)(14444005)(6636002)(76130400001)(11346002)(6246003)(97756001)(63350400001)(26826003)(8936002)(8676002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB3964;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e80c1463-bb06-4729-7978-08d73fcf7443
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR08MB3964;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: R6urg+zDk+PFu6Lr3qWvf2t9vvgU+OHdh60LLs45EcnADtsrH5MXH73o/Vk2w5pB++DMzQMM6wSUxhZ1pdXxHZLHuerSqVWpSN9FcISSFB0T9Kbm01MwG4CXJAS5wKEH2JsSirYIeWbB3M+vkY+vaZkV1wFd3TBuywr+vd0ZPSBvpGIMVVDXPT10XT7XOCefY+fGVb1iLVqK1jTvxD5s7ICJLTVhoQOx7OOo+R4ZTDu7ii4DRVdeKDHSM/XSMBN2p2xw/4Uke/jeoYbVJ5dmtSJaxGE8ojGMHQagRRRbbutMrLaok94sJx4iLUn/NS4ProhYawVC5tyIsoS3bM8OphCA+CeO+4TV+k0aYofgnbEaHcnYht8pgE0Hi4FwmWaLxWYtePorhVY2vJ745Pi42OP/7Mn3HSV97W51or2E9eI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 02:41:07.8707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fa2457-b67c-47e8-4691-08d73fcf7cbc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail

On Fri, Sep 20, 2019 at 03:11:34PM +0000, Mihail Atanassov wrote:
> Fix both the string and the struct member being printed.
>=20
> Fixes: 264b9436d23b ("drm/komeda: Enable writeback split support")
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 950235af1e79..de64a6a9964e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -564,8 +564,8 @@ komeda_splitter_validate(struct komeda_splitter *spli=
tter,
>  	}
> =20
>  	if (!in_range(&splitter->vsize, dflow->in_h)) {
> -		DRM_DEBUG_ATOMIC("split in_in: %d exceed the acceptable range.\n",
> -				 dflow->in_w);
> +		DRM_DEBUG_ATOMIC("split in_h: %d exceed the acceptable range.\n",
> +				 dflow->in_h);


Thank you for the patch.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

>  		return -EINVAL;
>  	}
> =20
> --=20
> 2.23.0
