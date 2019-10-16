Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5691CC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189092168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3thg8Yaa";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3thg8Yaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404085AbfJPIXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:23:21 -0400
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:45635
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388263AbfJPIXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZbofYpIDbV28hSpTOVjYlizA67F1XAVucWkprlnXVk=;
 b=3thg8Yaaur1/xi+m0yeUN6lTh5meMhUtQJG4lqkR39bP33nhCuTvHYpmkOjAPiAS3uN8rTs7eNgi9AMYJtBk1GJDxAdTUGYzNK23BKLuvd54ZatFQAQP9ZiFCyWKb0HDgqVE0y5xSqlleg5yyZOw6wseTPcoCxHuaiO2iA1hVNg=
Received: from HE1PR0802CA0021.eurprd08.prod.outlook.com (2603:10a6:3:bd::31)
 by VI1PR0801MB2031.eurprd08.prod.outlook.com (2603:10a6:800:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 16 Oct
 2019 08:23:14 +0000
Received: from DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by HE1PR0802CA0021.outlook.office365.com
 (2603:10a6:3:bd::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 08:23:13 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT058.mail.protection.outlook.com (10.152.20.255) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 08:23:12 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Wed, 16 Oct 2019 08:23:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 39db470f410efa4d
X-CR-MTA-TID: 64aa7808
Received: from 84e95bfba6bf.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E98B294B-E23E-4045-9D39-6504C6096F75.1;
        Wed, 16 Oct 2019 08:23:04 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 84e95bfba6bf.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 08:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFX9VY4C0huG5Qo8oq/tz0A/iy6fnRkVZtEmucfJZVPzS61VjUR8dJnPbVFpT9+KsricGgro8p1F5X6IoFiva4RYD+TyVYJwHkq0rfUtybNw6Wa9fUn+nZ7TeEfIg/yrlde6JR/wXSm5xEaS/plwwyqZl4zBmIu3UMgWf1TZraNl0I85yStHu1aSKzysdfHlu6kxqXFMWiJpc/4Xml+B1R0/H2+SMpJZgW3kzElakRUQsyTE385qfWF7QQvX8xAq25uHUVpujmK2oxzQmsAPgsiOUMVdyYhw6VmTJKwiiYf/gqZvzGtryw5AUFOkTsnOBca0PWuLe3jx1QbsK5tt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZbofYpIDbV28hSpTOVjYlizA67F1XAVucWkprlnXVk=;
 b=bQqL/8D4YCWlGEuBFluCRCaWvK1HFdkhsQmu/jbYwNdrtA0ALGCv7TWxlbhyKHiBMxjQC2jFU6ZlF64HLVnEi7SJBTLHKaMI+W+eynSxq0DRXM2SedpjkLTxfzJzBQUH4fdGLkN4uquawFtckKw0iA5ONETdhWQ3Snsim2tpneUeob6XNW/jRVMhfZBQ9QmZURCcZ5mY5rN5OHVickC73Mr1NWtTNB/JAqH7EFRdpSCjCgQqqTiVsEcU4hU9GAcOVZd+GryA11y9n+kNnnzq7v7f3EOm0EwVy2f720tbqKVranGXuHtpYChyr0pt1SK3mH1oDQeV+j/b7phnavKHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZbofYpIDbV28hSpTOVjYlizA67F1XAVucWkprlnXVk=;
 b=3thg8Yaaur1/xi+m0yeUN6lTh5meMhUtQJG4lqkR39bP33nhCuTvHYpmkOjAPiAS3uN8rTs7eNgi9AMYJtBk1GJDxAdTUGYzNK23BKLuvd54ZatFQAQP9ZiFCyWKb0HDgqVE0y5xSqlleg5yyZOw6wseTPcoCxHuaiO2iA1hVNg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5088.eurprd08.prod.outlook.com (10.255.158.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 08:23:03 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 08:23:03 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [v2] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Topic: [v2] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Index: AQHVg/rtmkxsWyZ8v0y88TcuY0W0UQ==
Date:   Wed, 16 Oct 2019 08:23:03 +0000
Message-ID: <20191016082255.GA18768@jamwan02-TSP300>
References: <20190930122231.33029-1-mihail.atanassov@arm.com>
In-Reply-To: <20190930122231.33029-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b99fdb83-50e3-4e76-59a5-08d7521215d8
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5088:|VE1PR08MB5088:|VI1PR0801MB2031:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2031795F3E3C92D9527864DAB3920@VI1PR0801MB2031.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:5797;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(64756008)(386003)(55236004)(66446008)(102836004)(66066001)(6506007)(33716001)(26005)(14444005)(71190400001)(25786009)(256004)(14454004)(186003)(71200400001)(11346002)(446003)(476003)(33656002)(5660300002)(486006)(2906002)(66946007)(66476007)(66556008)(229853002)(9686003)(86362001)(1076003)(6246003)(478600001)(4326008)(6486002)(7736002)(54906003)(58126008)(316002)(8676002)(305945005)(6862004)(81156014)(52116002)(76176011)(6512007)(8936002)(3846002)(6116002)(6636002)(99286004)(6436002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5088;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: h+5X2EOJHF+qY6OSItPbuTngr4dd+QeyaoW9AEfCWRuOTvmhvXbN6Z4NtBJ3H0jiiY79qWJVxmp623ZLdni6SXiTgdNsFH2PJ009z55yBf3leagOCJFVy6VWpHaDzF6HgfW0ASL/KwOEC6vSyvYItoJsiEmBTX7VFwlzW/jdYsqGkn5DGF1xDvMwNR0ICtqo1gGLKqKVXb7UMiOxSMDESaebYVSLdxPPhfU1iLcpUPrkfr9yeBgxMGZo8M8Bj/RLyNZV6WhRMzZvgRikp+/EKO/w/+YXq7Ww7ZROh3qOvaGAv4X9qI/9R0o9zS4K/AngByKr6prsveajnR8nkYRD+MLtngy8XzrJuD05l4unsz8JEmv/JygvCwECXnvMA30cMQSwOHG1JUesgWfSo9bae6nonO7NFgTDfG1wEE5O4ss=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29C5E991405FA343889E64DAC9A0060F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5088
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(66066001)(6862004)(4326008)(446003)(8676002)(33656002)(5660300002)(336012)(63350400001)(14454004)(6116002)(33716001)(81156014)(81166006)(3846002)(99286004)(11346002)(47776003)(6506007)(102836004)(386003)(8746002)(8936002)(76176011)(23726003)(6636002)(186003)(26005)(126002)(6246003)(9686003)(476003)(6512007)(486006)(70586007)(305945005)(22756006)(7736002)(86362001)(6486002)(50466002)(478600001)(70206006)(1076003)(46406003)(97756001)(316002)(229853002)(2906002)(25786009)(58126008)(14444005)(54906003)(26826003)(356004)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB2031;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 61267cee-ef87-48f1-8cf4-08d752121011
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYB4SoER2+DD073EAbp3xWm4c1cWOapOF0uak/eDcz6c1z5EehTrw90qsv3TQxeDBI3AY47vEVj24PZtuA2YexYwedFS6GG2zEt03mWBxFUJu3JPWlbUVyMyqq5vnE38XtJCGgUhPA+XWJ9o36tBDKnZjJH0R12UUdMWyEs9QKLga6VWlGcdkt7BOKxFjrBkUX2z7TJ9ZyJW1urMyMaD+XjNBNtZThu0n5AX3vPgGgXJEuq+zVUvJQO5IfrWlzHWfizyAHeGY701aurhEQRklrylZZ/qVlJ1FItF9GJm34pv3VgXi+Cdk4SNYPdi/sMvLWItpswh/9+ghKymFErixjk9NAvegS79Eo/SRWIw+mPdP+By+LqdX9eT1ayy69YV28yBS8RRdpYWobVuJWlzyKMUeZIk/gTIFbVrseZyl30=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 08:23:12.5083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99fdb83-50e3-4e76-59a5-08d7521215d8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 12:23:07PM +0000, Mihail Atanassov wrote:
> Fix both the string and the struct member being printed.
>=20
> Changes since v1:
>  - Now with a bonus grammar fix, too.
>=20
> Fixes: 264b9436d23b ("drm/komeda: Enable writeback split support")
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 950235af1e79..2b624bfe1751 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -564,8 +564,8 @@ komeda_splitter_validate(struct komeda_splitter *spli=
tter,
>  	}
> =20
>  	if (!in_range(&splitter->vsize, dflow->in_h)) {
> -		DRM_DEBUG_ATOMIC("split in_in: %d exceed the acceptable range.\n",
> -				 dflow->in_w);
> +		DRM_DEBUG_ATOMIC("split in_h: %d exceeds the acceptable range.\n",
> +				 dflow->in_h);

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
>  		return -EINVAL;
>  	}
> =20
