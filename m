Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F95FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2636220863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="y/wmPrtT";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="y/wmPrtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfI0IBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:01:20 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:16195
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfI0IBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1sA10AyaPQvn9XPc6osOWXJrAfOx+pwz17+I99VABs=;
 b=y/wmPrtT7kTSRWEiIzestk/JAOPp0AYxTv1ITeQsIRbY7lljA1VA6JMoXuNj4jumFr1ee6If94hUk2JtN8iXW2b1FyWsDTDcylUrrl33yLCCOWAFnFLKTvRktH5eBho2VyVR5N8bFJJiKteV20fTu/wp8TRGO2IPDg7I3KSZsJo=
Received: from VI1PR08CA0201.eurprd08.prod.outlook.com (2603:10a6:800:d2::31)
 by HE1PR0801MB2010.eurprd08.prod.outlook.com (2603:10a6:3:4b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Fri, 27 Sep
 2019 08:00:56 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR08CA0201.outlook.office365.com
 (2603:10a6:800:d2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Fri, 27 Sep 2019 08:00:56 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 27 Sep 2019 08:00:55 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 27 Sep 2019 08:00:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fc0bf1ef410da805
X-CR-MTA-TID: 64aa7808
Received: from 802805e51fe9.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C724573F-EFC6-4777-B68E-36ACCC09E132.1;
        Fri, 27 Sep 2019 08:00:43 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 802805e51fe9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 27 Sep 2019 08:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNnZW83sTRK+IEUMTTQf4g17ij8CeI9nut6g4LR8QaDLOFFttkixSiw9anTj1Ki2JEMWt1NgaV8NcJdyHqvpOUCXrcRbizgSRgyOI4qpEv/2Va94enV4YA43IQnwTTMt1oWtJhLX72uh4rlThqz9JIQh2AuRthkO+tP1olUTDz9I1i7Vq4csKJK6S9QVn2cUl0t7fiFuvaW+e/NtmvD8O6wtcuziVn8xeFx72rLQCU6Zfoql0iFKCbTEke5cPO71Rqcqv4HCohYe5PDAVNSIsuCpFSHT27+84KClQ2PpmdlKQqXPTLHLSExaIkdeczsZivAhz8X2VY7E1KKivQgdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1sA10AyaPQvn9XPc6osOWXJrAfOx+pwz17+I99VABs=;
 b=E8kSlPArGUcHpq+R5nWocDoLkCcUvQ4kXt5l9rcfBMJLhHyVdXeACKoVMaHfuvfl8XrHAjJDE7wONU8CG2yqQtsr62bq6q1qY1WZ7zB5nGpF5jLo8kkOfs4O4MreVYPsrqglQmrBUbD6eLXFZzDyebZRo8mHJU28UkY5l8FcyJcdDreM1m+6vcwWxxOI9C+SvVOMfq/pwhIA8bJID/5gXokyzYBlwK38FMKlTw4AT1jNxavfX/faZS7q5BWg2Z6fgJ4po48vM7r1tPtR0D3LjjWqhLwJ0GHgQzyboUhL8Y1q9DQWxhOqtvm1VV6YAVq2FNQx+3scfIyvABpq3RSutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1sA10AyaPQvn9XPc6osOWXJrAfOx+pwz17+I99VABs=;
 b=y/wmPrtT7kTSRWEiIzestk/JAOPp0AYxTv1ITeQsIRbY7lljA1VA6JMoXuNj4jumFr1ee6If94hUk2JtN8iXW2b1FyWsDTDcylUrrl33yLCCOWAFnFLKTvRktH5eBho2VyVR5N8bFJJiKteV20fTu/wp8TRGO2IPDg7I3KSZsJo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4784.eurprd08.prod.outlook.com (10.255.115.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 27 Sep 2019 08:00:41 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 08:00:41 +0000
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
Subject: Re: drm/komeda: SW workaround for D71 doesn't flush shadow registers
Thread-Topic: drm/komeda: SW workaround for D71 doesn't flush shadow registers
Thread-Index: AQHVdQmoRrQhG6IH5UCJnSs7567ZNQ==
Date:   Fri, 27 Sep 2019 08:00:41 +0000
Message-ID: <20190927080034.GA23652@jamwan02-TSP300>
References: <20190906071750.4563-1-lowry.li@arm.com>
In-Reply-To: <20190906071750.4563-1-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0036.apcprd03.prod.outlook.com
 (2603:1096:203:2f::24) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d23bbdbf-2e45-4ec1-ce10-08d74320d2d3
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4784:|VE1PR08MB4784:|HE1PR0801MB2010:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB201088DB91F0B14956CD1085B3810@HE1PR0801MB2010.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:883;OLM:883;
x-forefront-prvs: 0173C6D4D5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(305945005)(8936002)(8676002)(6486002)(66446008)(14454004)(7736002)(446003)(54906003)(11346002)(476003)(6636002)(58126008)(81156014)(81166006)(229853002)(64756008)(2906002)(6116002)(3846002)(33716001)(6512007)(9686003)(6436002)(66946007)(66476007)(66556008)(486006)(478600001)(316002)(66066001)(1076003)(5660300002)(14444005)(52116002)(186003)(25786009)(26005)(76176011)(6246003)(256004)(99286004)(6862004)(86362001)(102836004)(6506007)(386003)(4326008)(71200400001)(71190400001)(55236004)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4784;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: k4h88B27UymX/X1ru4WImtiATyuKwjOvozLT2G019kixkSk/KyALSz5KDc8pSqdiWslY/xYaEd2phJhg3+0G73PVBh+nwxP8L+Wh2fUqMqbU4S6dKeM8EdivhgI03Ftli7kmIwGJ8Ljdb1X5WYAVmf0kvMESvGwZEu9jo3wWgqgKRtsJiT94zEZnylj6WRTmEe7w+B2cRtZDEGrPiHXWCS7hBcbPw5as+akccjThA5X3id7NXAKqqy7eqOWMHzQDMfBbacsx0b3JKpyY00JPpiMBcKmEH/J4F9L8IFsk1MaSZAnt3srv/0lCctFiInpv7aZrhAQLIE9g9fD6H0U6ApasTA1SPlb0i/jd1rbWQLrBbs6UZLeJfROuloLHTSiuT2h3169gTUtLaZkgQh7CJeaO/J+gbK/HUnmvIEN+5jE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <796F5E2AED0D0B41BFBD9F370FF6AE2F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4784
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(126002)(70586007)(14444005)(6636002)(26826003)(26005)(9686003)(23726003)(6512007)(47776003)(305945005)(8746002)(66066001)(3846002)(99286004)(81156014)(478600001)(7736002)(8676002)(4326008)(25786009)(97756001)(6116002)(186003)(58126008)(6506007)(14454004)(386003)(102836004)(229853002)(2906002)(50466002)(81166006)(8936002)(54906003)(6486002)(446003)(63350400001)(11346002)(486006)(76130400001)(356004)(33656002)(336012)(316002)(1076003)(6862004)(22756006)(5660300002)(476003)(33716001)(46406003)(70206006)(86362001)(6246003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB2010;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 843a8219-870c-42d9-f8a0-08d74320caa2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0801MB2010;
NoDisclaimer: True
X-Forefront-PRVS: 0173C6D4D5
X-Microsoft-Antispam-Message-Info: Vn4pxXm+x0qnhnX7bj8Y+6BqjcCr5G9zKyE/CqddLjAIFkGFAYD1guw0UXUmWHE0JRGJM0dJ17/pQX3gWC+oFIR0ycwzJ1t6HZ+pz3sAt9pH9WdhmIG1Ghe6Oitm0OFjs1Uu9Hzvba5inzlX9k78b/MePETtXghscQXUoacBAs4ROrL3F5DlEunC8xzWV8WJ58WuCkFK2gVa0kgiJkBF9nw163fNeaxopT61jt0jeSpACevTfcJ/7LztRq4oFCwwPBcgEKDngZMCuJWOxN5p5c1lAVDTNbQXPQiZ6jHWnC9iKN4RuSLTWFQS2OOyieW+KlqLOwLE0eAbPfH3XYxrBpwdXT/p5mM1V4te1GgTHo1CAXA7SqkyzHiSNrQswEklV2U+KnEDmX8ps8yPMFvHmKTsI99lT4UhslNAgdRqZl0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2019 08:00:55.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23bbdbf-2e45-4ec1-ce10-08d74320d2d3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 07:18:06AM +0000, Lowry Li (Arm Technology China) w=
rote:
> This is a SW workaround for shadow un-flushed when together with the
> DOU Timing-disable.
>=20
> D71 HW doesn't update shadow registers when display output is turned
> off. So when we disable all pipeline components together with display
> output disabling by one flush or one operation, the disable operation
> updated registers will not be flushed or valid in HW, which may lead
> problem. To workaround this problem, introduce a two phase disable for
> pipeline disable.
>=20
> Phase1: Disable components with display is on and flush it, this phase
>         for flushing or validating the shadow registers.
> Phase2: Turn-off display output.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 16 ++++
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 73 ++++++++++++-------
>  .../drm/arm/display/komeda/komeda_pipeline.h  | 14 +++-
>  .../display/komeda/komeda_pipeline_state.c    | 30 +++++++-
>  4 files changed, 103 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index 2151cb3f9e68..e74069ef3b7b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -487,6 +487,22 @@ static int d71_enum_resources(struct komeda_dev *mde=
v)
>  			err =3D PTR_ERR(pipe);
>  			goto err_cleanup;
>  		}
> +
> +		/* D71 HW doesn't update shadow registers when display output
> +		 * is turning off, so when we disable all pipeline components
> +		 * together with display output disable by one flush or one
> +		 * operation, the disable operation updated registers will not
> +		 * be flush to or valid in HW, which may leads problem.
> +		 * To workaround this problem, introduce a two phase disable.
> +		 * Phase1: Disabling components with display is on to make sure
> +		 *	   the disable can be flushed to HW.
> +		 * Phase2: Only turn-off display output.
> +		 */
> +		value =3D KOMEDA_PIPELINE_IMPROCS |
> +			BIT(KOMEDA_COMPONENT_TIMING_CTRLR);
> +
> +		pipe->standalone_disabled_comps =3D value;
> +
>  		d71->pipes[i] =3D to_d71_pipeline(pipe);
>  	}
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 3155bb17ea1b..c0c803d56d5c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -280,20 +280,53 @@ komeda_crtc_atomic_enable(struct drm_crtc *crtc,
>  	komeda_crtc_do_flush(crtc, old);
>  }
> =20
> +static void
> +komeda_crtc_flush_and_wait_for_flip_done(struct komeda_crtc *kcrtc,
> +					 struct completion *input_flip_done)
> +{
> +	struct drm_device *drm =3D kcrtc->base.dev;
> +	struct komeda_dev *mdev =3D kcrtc->master->mdev;
> +	struct completion *flip_done;
> +	struct completion temp;
> +	int timeout;
> +
> +	/* if caller doesn't send a flip_done, use a private flip_done */
> +	if (input_flip_done) {
> +		flip_done =3D input_flip_done;
> +	} else {
> +		init_completion(&temp);
> +		kcrtc->disable_done =3D &temp;
> +		flip_done =3D &temp;
> +	}
> +
> +	mdev->funcs->flush(mdev, kcrtc->master->id, 0);
> +
> +	/* wait the flip take affect.*/
> +	timeout =3D wait_for_completion_timeout(flip_done, HZ);
> +	if (timeout =3D=3D 0) {
> +		DRM_ERROR("wait pipe%d flip done timeout\n", kcrtc->master->id);
> +		if (!input_flip_done) {
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&drm->event_lock, flags);
> +			kcrtc->disable_done =3D NULL;
> +			spin_unlock_irqrestore(&drm->event_lock, flags);
> +		}
> +	}
> +}
> +
>  static void
>  komeda_crtc_atomic_disable(struct drm_crtc *crtc,
>  			   struct drm_crtc_state *old)
>  {
>  	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
>  	struct komeda_crtc_state *old_st =3D to_kcrtc_st(old);
> -	struct komeda_dev *mdev =3D crtc->dev->dev_private;
>  	struct komeda_pipeline *master =3D kcrtc->master;
>  	struct komeda_pipeline *slave  =3D kcrtc->slave;
>  	struct completion *disable_done =3D &crtc->state->commit->flip_done;
> -	struct completion temp;
> -	int timeout;
> +	bool needs_phase2 =3D false;
> =20
> -	DRM_DEBUG_ATOMIC("CRTC%d_DISABLE: active_pipes: 0x%x, affected: 0x%x.\n=
",
> +	DRM_DEBUG_ATOMIC("CRTC%d_DISABLE: active_pipes: 0x%x, affected: 0x%x\n"=
,
>  			 drm_crtc_index(crtc),
>  			 old_st->active_pipes, old_st->affected_pipes);
> =20
> @@ -301,7 +334,7 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
>  		komeda_pipeline_disable(slave, old->state);
> =20
>  	if (has_bit(master->id, old_st->active_pipes))
> -		komeda_pipeline_disable(master, old->state);
> +		needs_phase2 =3D komeda_pipeline_disable(master, old->state);
> =20
>  	/* crtc_disable has two scenarios according to the state->active switch=
.
>  	 * 1. active -> inactive
> @@ -320,30 +353,20 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
>  	 *    That's also the reason why skip modeset commit in
>  	 *    komeda_crtc_atomic_flush()
>  	 */
> -	if (crtc->state->active) {
> -		struct komeda_pipeline_state *pipe_st;
> -		/* clear the old active_comps to zero */
> -		pipe_st =3D komeda_pipeline_get_old_state(master, old->state);
> -		pipe_st->active_comps =3D 0;
> +	disable_done =3D (needs_phase2 || crtc->state->active) ?
> +		       NULL : &crtc->state->commit->flip_done;
> =20
> -		init_completion(&temp);
> -		kcrtc->disable_done =3D &temp;
> -		disable_done =3D &temp;
> -	}
> +	/* wait phase 1 disable done */
> +	komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);
> =20
> -	mdev->funcs->flush(mdev, master->id, 0);
> +	/* phase 2 */
> +	if (needs_phase2) {
> +		komeda_pipeline_disable(kcrtc->master, old->state);
> =20
> -	/* wait the disable take affect.*/
> -	timeout =3D wait_for_completion_timeout(disable_done, HZ);
> -	if (timeout =3D=3D 0) {
> -		DRM_ERROR("disable pipeline%d timeout.\n", kcrtc->master->id);
> -		if (crtc->state->active) {
> -			unsigned long flags;
> +		disable_done =3D crtc->state->active ?
> +			       NULL : &crtc->state->commit->flip_done;
> =20
> -			spin_lock_irqsave(&crtc->dev->event_lock, flags);
> -			kcrtc->disable_done =3D NULL;
> -			spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> -		}
> +		komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);
>  	}
> =20
>  	drm_crtc_vblank_off(crtc);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index 4eac23ef56c1..2afd07579138 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -496,6 +496,18 @@ struct komeda_pipeline {
>  	int id;
>  	/** @avail_comps: available components mask of pipeline */
>  	u32 avail_comps;
> +	/**
> +	 * @standalone_disabled_comps:
> +	 *
> +	 * When disable the pipeline, some components can not be disabled
> +	 * together with others, but need a sparated and standalone disable.
> +	 * The standalone_disabled_comps are the components which need to be
> +	 * disabled standalone, and this concept also introduce concept of
> +	 * two phase.
> +	 * phase 1: for disabling the common components.
> +	 * phase 2: for disabling the standalong_disabled_comps.
> +	 */
> +	u32 standalone_disabled_comps;
>  	/** @n_layers: the number of layer on @layers */
>  	int n_layers;
>  	/** @layers: the pipeline layers */
> @@ -674,7 +686,7 @@ int komeda_release_unclaimed_resources(struct komeda_=
pipeline *pipe,
>  struct komeda_pipeline_state *
>  komeda_pipeline_get_old_state(struct komeda_pipeline *pipe,
>  			      struct drm_atomic_state *state);
> -void komeda_pipeline_disable(struct komeda_pipeline *pipe,
> +bool komeda_pipeline_disable(struct komeda_pipeline *pipe,
>  			     struct drm_atomic_state *old_state);
>  void komeda_pipeline_update(struct komeda_pipeline *pipe,
>  			    struct drm_atomic_state *old_state);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index f2c5d6c8f508..7699322949bb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -1899,7 +1899,17 @@ int komeda_release_unclaimed_resources(struct kome=
da_pipeline *pipe,
>  	return 0;
>  }
> =20
> -void komeda_pipeline_disable(struct komeda_pipeline *pipe,
> +/* Since standalong disabled components must be disabled separately and =
in the
> + * last, So a complete disable operation may needs to call pipeline_disa=
ble
> + * twice (two phase disabling).
> + * Phase 1: disable the common components, flush it.
> + * Phase 2: disable the standalone disabled components, flush it.
> + *
> + * RETURNS:
> + * true: disable is not complete, needs a phase 2 disable.
> + * false: disable is complete.
> + */
> +bool komeda_pipeline_disable(struct komeda_pipeline *pipe,
>  			     struct drm_atomic_state *old_state)
>  {
>  	struct komeda_pipeline_state *old;
> @@ -1909,9 +1919,14 @@ void komeda_pipeline_disable(struct komeda_pipelin=
e *pipe,
> =20
>  	old =3D komeda_pipeline_get_old_state(pipe, old_state);
> =20
> -	disabling_comps =3D old->active_comps;
> -	DRM_DEBUG_ATOMIC("PIPE%d: disabling_comps: 0x%x.\n",
> -			 pipe->id, disabling_comps);
> +	disabling_comps =3D old->active_comps &
> +			  (~pipe->standalone_disabled_comps);
> +	if (!disabling_comps)
> +		disabling_comps =3D old->active_comps &
> +				  pipe->standalone_disabled_comps;
> +
> +	DRM_DEBUG_ATOMIC("PIPE%d: active_comps: 0x%x, disabling_comps: 0x%x.\n"=
,
> +			 pipe->id, old->active_comps, disabling_comps);
> =20
>  	dp_for_each_set_bit(id, disabling_comps) {
>  		c =3D komeda_pipeline_get_component(pipe, id);
> @@ -1929,6 +1944,13 @@ void komeda_pipeline_disable(struct komeda_pipelin=
e *pipe,
> =20
>  		c->funcs->disable(c);
>  	}
> +
> +	/* Update the pipeline state, if there are components that are still
> +	 * active, return true for calling the phase 2 disable.
> +	 */
> +	old->active_comps &=3D ~disabling_comps;
> +
> +	return old->active_comps ? true : false;
>  }
>

Looks good it me.

will push it to drm-misc-next

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

>  void komeda_pipeline_update(struct komeda_pipeline *pipe,
