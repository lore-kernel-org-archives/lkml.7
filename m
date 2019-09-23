Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14381C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED4120830
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EfOwJX/0";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EfOwJX/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404746AbfIWCmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:42:06 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:13254
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728877AbfIWCmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2DgwLJCXbGTdeksmaGP+tN0dRypjhhWSxtmJqV+b9I=;
 b=EfOwJX/0utets6xELeKyd2pnpsM9ZSFppdzrPVurmLW9D6oH2i6P7a5OI8QnMnMctbw4+I2q1J1c1W8pAWrqRDM3Cft8TMhv4/sgWNQv/7wwcSpTMM4DDA2uTps38aEyDQ6nAaK/feGXCcqswGVsCrTBDvoTRwHjNwE1LeT0cEY=
Received: from VI1PR08CA0168.eurprd08.prod.outlook.com (2603:10a6:800:d1::22)
 by DB7PR08MB3274.eurprd08.prod.outlook.com (2603:10a6:5:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Mon, 23 Sep
 2019 02:41:57 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by VI1PR08CA0168.outlook.office365.com
 (2603:10a6:800:d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22 via Frontend
 Transport; Mon, 23 Sep 2019 02:41:57 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 02:41:55 +0000
Received: ("Tessian outbound 5061e1b5386c:v31"); Mon, 23 Sep 2019 02:41:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c50fe50f55d8d82d
X-CR-MTA-TID: 64aa7808
Received: from b834343a3516.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 107CE416-B58F-48F5-A6CF-438BEAB61C3E.1;
        Mon, 23 Sep 2019 02:41:45 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b834343a3516.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Sep 2019 02:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIcRSkXooMEMGldwle5rCEZi/epFX3PSUk8Te1aYmsXHmIti1igzWmoJM0U1IGR3CzF31Gaeq+sz6SJP32/kZ6+TIIR9I4n9mIywqEYij2WFUHWup55rE2eRi56H9b9p5jhtncCmIIXOZBpAQXrD/s9wgR2Wj7EwTWXaPpgA0Yk7r5YIZVKVB8lPIGURtNT7VsBAF0QipIjdIm2l99JVyECdAtRgFkYKsxVheW756kFZzpalnIh8xXmIVvM1XZ75vS5xOsyJ55zh3KX18X4O8qZVxrk0fEhEPJnPCzfkDnc5g07C5VbvJVUIXtntxQDI/wfZUKJRTa7fE8VGxyxZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2DgwLJCXbGTdeksmaGP+tN0dRypjhhWSxtmJqV+b9I=;
 b=F+l10KV/UI0ItidqO5OHJJdOhpoK26Zaw0rndsoKzj7Hh7SasHmzUKPckOEA+7LijiIMlwraRGFgYpN6kBCifmn7Q9G2tZgmPRuiCCmKJpA0bIabFcFF0VCPGzq4oEa+04ZocUy5FbZCDDNJEH09E2cqB2IwVZ5j42CFkx2NHCezxZCXAESApUkK/saMfP1xilnUQP6+O+lGz9BPsWuQ6wKFPtAGHkfrLGGVzUvUvg3Y/lCMtg+zl1L4k3klHunsP3UDzPkyaMmjmZfmU7NqbKEcOhtgFqksUmDrapgBJiL4ggxd2VHtXKAhotLRj0IYpri8nVn0Z22cRUGbfwJs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2DgwLJCXbGTdeksmaGP+tN0dRypjhhWSxtmJqV+b9I=;
 b=EfOwJX/0utets6xELeKyd2pnpsM9ZSFppdzrPVurmLW9D6oH2i6P7a5OI8QnMnMctbw4+I2q1J1c1W8pAWrqRDM3Cft8TMhv4/sgWNQv/7wwcSpTMM4DDA2uTps38aEyDQ6nAaK/feGXCcqswGVsCrTBDvoTRwHjNwE1LeT0cEY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4814.eurprd08.prod.outlook.com (10.255.115.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Mon, 23 Sep 2019 02:41:44 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 02:41:44 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/komeda: Use IRQ_RETVAL shorthand in d71_irq_handler
Thread-Topic: [PATCH] drm/komeda: Use IRQ_RETVAL shorthand in d71_irq_handler
Thread-Index: AQHVb8XpefZcvGvZNkuWrwlyThjxiKc4kUoA
Date:   Mon, 23 Sep 2019 02:41:44 +0000
Message-ID: <20190923024136.GB24909@jamwan02-TSP300>
References: <20190920151247.25128-1-mihail.atanassov@arm.com>
In-Reply-To: <20190920151247.25128-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 534127f2-f02e-4674-1fea-08d73fcf9949
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4814;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4814:|VE1PR08MB4814:|DB7PR08MB3274:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB32744BC2E7AB3A1B477017EAB3850@DB7PR08MB3274.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(71200400001)(71190400001)(76176011)(7736002)(6436002)(229853002)(6486002)(52116002)(386003)(5660300002)(6506007)(14454004)(476003)(8676002)(81166006)(66476007)(66556008)(81156014)(55236004)(478600001)(186003)(26005)(446003)(102836004)(486006)(99286004)(8936002)(66446008)(64756008)(66946007)(11346002)(25786009)(6116002)(3846002)(33716001)(58126008)(1076003)(54906003)(316002)(2906002)(66066001)(6636002)(86362001)(6862004)(256004)(14444005)(6246003)(4326008)(305945005)(33656002)(6512007)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4814;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: Z4vWH7NSW9aK3+y6nSq7BiHbQnWaX2TioNaSBYo+uCvvznEq/ryTKx8AClQNdiPG4wiECm+11fcaBuDiBgBjN6jA8x0b622wicGPq0ahvdNsY2ZWvwOj8BrIjoAevfDIm3auPT/LPlOiVgFCUS/waksbfMLGw2SUOo1wGL8kgXHrz7SGq6iLUjk+x+spoRDeFC0iZVY2ua+bnvQ9e0wtjhkZDnsJ4fpReT5ecHhvW902gHtgFrV6S0ZWiW9Hqa0fQq9wn05GqqR39nA/OCoVDA4F0XGtl7R3sGEiRp+MHdikjBFL48fVvubzoeh7pqEDfEpkyDk/h9Fio2unbHUXmVfAQFlHkzjhj4q0f+CXmOGC2iwkwPSA7biJ2RjGKhpXalavxuk31tvEk+1A+MonyVClzHr7XLD1IOz7MOmWip4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30E3520BCE9D264C90B981147FEADACC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4814
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(376002)(39850400004)(346002)(189003)(199004)(186003)(81156014)(81166006)(76130400001)(229853002)(50466002)(33716001)(54906003)(4326008)(8676002)(33656002)(70206006)(63350400001)(22756006)(11346002)(446003)(26826003)(476003)(47776003)(14454004)(99286004)(6862004)(26005)(76176011)(66066001)(70586007)(486006)(316002)(8746002)(478600001)(58126008)(25786009)(8936002)(336012)(46406003)(356004)(7736002)(126002)(6246003)(5660300002)(305945005)(6116002)(6512007)(86362001)(6636002)(1076003)(386003)(6486002)(3846002)(102836004)(14444005)(23726003)(6506007)(97756001)(9686003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3274;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5c528f7d-0035-44a6-3902-08d73fcf9248
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3274;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: yYhGRuO8fWKb6PHfxWH006f4RJwdq/N/qSZJJToqR+/l2BCIHIkzkr+qV1BSEs68CGkemb4S7ADOo8OImAeqzg2ZMhBMnWsFXQYCwGEIGtTi+anQfULpiq/dk0l3LWAu7lpvBvA8cd2d06/p99KQdkRwjnVlUtuJgepQGZaPg3e+w0Km3GKPZQeZhbWp9WS8s5AhL0f73OBL/s0TkHB7CIC4KedLpvBpHwzZ9uc/UEp3vFLkGtMAWReoYigAzh8TdPqbKWAEG62W8V4M9QpA7lE8AhrhajWE15E2gDHf8D3Q9P8COGusyxgWRslJ2sAVCyUR62x1XzydLCTuvtBfZ7GXgrhsyJ8Gdl/huxiptIRmt50j4O4kfKv70lwuSuKUxF7rY+Neu1TNT1xYOVV0KkJMdng14lH7sMIjp2wXII0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 02:41:55.8214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 534127f2-f02e-4674-1fea-08d73fcf9949
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 03:13:08PM +0000, Mihail Atanassov wrote:
> No change in behaviour; IRQ_RETVAL is about twice as popular as
> manually writing out the ternary.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index d567ab7ed314..1b42095969e7 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -195,7 +195,7 @@ d71_irq_handler(struct komeda_dev *mdev, struct komed=
a_events *evts)
>  	if (gcu_status & GLB_IRQ_STATUS_PIPE1)
>  		evts->pipes[1] |=3D get_pipeline_event(d71->pipes[1], gcu_status);
> =20
> -	return gcu_status ? IRQ_HANDLED : IRQ_NONE;
> +	return IRQ_RETVAL(gcu_status);

Hi Mihail:

Thank you for the patch.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

>  }
> =20
>  #define ENABLED_GCU_IRQS	(GCU_IRQ_CVAL0 | GCU_IRQ_CVAL1 | \
> --=20
> 2.23.0
