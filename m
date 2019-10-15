Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C01AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B61121848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Yw85uTVb";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Yw85uTVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfJOIWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:22:05 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:62201
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfJOIWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KqGS/9jDGD5S5GB01ncOxdpbQBMNXMP+sPAqaNJ3I4=;
 b=Yw85uTVbE6kkldgqklJMK21MQXSSGYyJvasmzaJ6naszuX5JUYBIDj5LusShd0znp4HHMF57djP+KQ4/drhBHP7V3pYy/8yvZJOr0QudP9mme2H8qgpw/0LKg6lFM04L4jsxE4LZ0kMbHZ4pGHx5nawZfCShYDnsYZD73Sx3IZA=
Received: from HE1PR0802CA0017.eurprd08.prod.outlook.com (2603:10a6:3:bd::27)
 by DB6PR08MB2869.eurprd08.prod.outlook.com (2603:10a6:6:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22; Tue, 15 Oct
 2019 08:21:58 +0000
Received: from AM5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by HE1PR0802CA0017.outlook.office365.com
 (2603:10a6:3:bd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Tue, 15 Oct 2019 08:21:57 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT039.mail.protection.outlook.com (10.152.17.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 08:21:56 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Tue, 15 Oct 2019 08:21:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: caca5d509e512c11
X-CR-MTA-TID: 64aa7808
Received: from 31a7e0264fbc.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D3100901-9DF4-41AB-B43F-E002B54BCE40.1;
        Tue, 15 Oct 2019 08:21:46 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 31a7e0264fbc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 08:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFXHUZBboN3/U+86pAInPpUKTarUTnyRNq7RPK5om/Iv7aw9UadYKhe+x9BV9DSW4GYTEK16/O9tMrMzgSbE1567qEAadxoeMTLIRQ/9zLCfySilBnCIZgsi+eQX9kYxMkIfUNuyS0SRhfdIk41n9aO3NgGBRNZBEDept0D36gIhbbyuvxMj4nGgIodrGE2kfjaitjm6awT4w5Kv1GMJPDAzm0ty3ebloDgJsgv5vueeIjQfb5IE0vWWSN6uia4cuP0paMLRJdR00T6Wl8TlybFtbOVIszz2UPnQvL/AkrXQdvFrSiy2YjJXm+QnBOSS8kGuvVun3L2Jl+pq4jZfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KqGS/9jDGD5S5GB01ncOxdpbQBMNXMP+sPAqaNJ3I4=;
 b=KJMXh7L91y54Rf75yF72tsepkA8mjftAwMIItnLRu+rKbg8yhdFeUhe9gk5u3m7R6Ruea9TM6IC+azJwAfplfMvUF1vMvUP+ft3YjKVrsnmNXZs3v4fGRJakncKnt/u+agBohBv6XkzU5m1q4NCRmo592m6jjjd6A4h1IXp3hwDhcKgeM0A4hGl6HOYi5DMMKk89A5cverx0ctrQ+YdD/r65AmhPukj0o54aD4uTWX2TxWNNHuiIx5HGU76xm2wRnsl4kqev3MJc7IGypZThGNAz9S28GevE6DFezqXHO1PlTnoe0jUPoWPnmi7Hlz2j0z+Wa2/3wPX4XaReuw3vbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KqGS/9jDGD5S5GB01ncOxdpbQBMNXMP+sPAqaNJ3I4=;
 b=Yw85uTVbE6kkldgqklJMK21MQXSSGYyJvasmzaJ6naszuX5JUYBIDj5LusShd0znp4HHMF57djP+KQ4/drhBHP7V3pYy/8yvZJOr0QudP9mme2H8qgpw/0LKg6lFM04L4jsxE4LZ0kMbHZ4pGHx5nawZfCShYDnsYZD73Sx3IZA=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB5312.eurprd08.prod.outlook.com (52.133.247.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 08:21:44 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:21:44 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Ilia Mirkin <imirkin@alum.mit.edu>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/bJ+/P3cfPDu0GaOed3595gHKdaUJkAgACbvICAAHbjAA==
Date:   Tue, 15 Oct 2019 08:21:44 +0000
Message-ID: <1687889.77CWzybTeB@e123338-lin>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
 <CAKb7Uvik6MZSwCQ4QF7ed1wttfufbR-J4vNdOtYzM+1tqPE_vw@mail.gmail.com>
 <20191015011604.GA26941@jamwan02-TSP300>
In-Reply-To: <20191015011604.GA26941@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.49]
x-clientproxiedby: AM4PR0501CA0045.eurprd05.prod.outlook.com
 (2603:10a6:200:68::13) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4e403d74-7289-4c60-f551-08d75148be4a
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB5312:|VI1PR08MB5312:|DB6PR08MB2869:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB28697B73F2E83F6F4EFCAD828F930@DB6PR08MB2869.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(478600001)(305945005)(81166006)(4326008)(446003)(6636002)(71200400001)(71190400001)(6436002)(256004)(11346002)(8676002)(102836004)(81156014)(5660300002)(476003)(14454004)(66476007)(66946007)(316002)(6246003)(6116002)(486006)(3846002)(86362001)(33716001)(6862004)(66446008)(64756008)(66556008)(66066001)(186003)(26005)(7736002)(6512007)(52116002)(99286004)(54906003)(76176011)(6506007)(53546011)(386003)(2906002)(229853002)(8936002)(6486002)(25786009)(9686003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5312;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oVIXCaNiKPa916v2vYOXZdXgY+uULCoOefNN8/uTMDCfv2zk4+Sqr6jsmkuqavaFqyUGb929ObjgemdmuCqAh0h+Hf2vlhhrMnOQvP6UON37Ybt3e8zNxY3gPDPG6sxjMnWnH0r1OC6kpyKuxS+q15OAw3vlSlg0mtG2bb/xzbZTNvzKwksl9DL/ZeIanV42xn39+DhQkVU36nCKcsIpXF5xwAUEtXjN4umqHGxQDpNQmLdEVcjjlpQpTefw/1sm3+meZPhbwCaYq6x4BCtTYn2mb6cdEF74+RFtNo5t/OWpXG/BYS/5jHAoTobWE/Ulpa1sueiMRzqsWCauX8Ne4q7CZavbIogWRhhP9NmXIa1JX84W6kgg4vCW3PtyhnNQtHQzCJ/xmVdE9BZTSKJ5GevXcMhYBVgHXlRtW46LEzo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <512DA533B7A2F848B9F76B640ABD4FA3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5312
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(6486002)(102836004)(22756006)(76176011)(53546011)(8746002)(86362001)(46406003)(63350400001)(9686003)(6512007)(446003)(229853002)(97756001)(36906005)(99286004)(386003)(6506007)(316002)(54906003)(66066001)(26005)(5660300002)(26826003)(478600001)(8936002)(47776003)(6636002)(186003)(23726003)(6116002)(81166006)(81156014)(476003)(76130400001)(3846002)(6246003)(14454004)(8676002)(486006)(70586007)(33716001)(356004)(336012)(2906002)(4326008)(25786009)(50466002)(11346002)(126002)(6862004)(305945005)(70206006)(7736002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2869;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: da66d652-d6a5-4b35-ad4a-08d75148b6b1
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFrheUceUilcgozlhpoL08iRnewjPfYnNdJsYPoXeVty/SlJOyJ7xSGcxnswnScck+Giw7/8P0THoLUpHFPpR4+z+W0RpMJCp0wfJ0HicgiI/4ydhax7WpqiMcf7HktG4g6L/BE6nat+AT8SyyQJonZNa26zSk4+nztc9ObKq27cSx+/eZiJKatXhNpRGWMmDw7RvIDjPkzJchqMHssC1J47gGllatJFM6aay023zro3og1gF3UcpiG32nkleSoVc8NJ8TgG+BfnGVw5hj4Ya7RUb19z0RkxQSjduJyik0qQ7oCuvdfXeMgjQzIpOgnTvoNeD3KRQUXDSzlARu819zu+yqvHgb/1qhblWMU0JeIOpNe1KdQYJ185940cZeOn7K2gRBSr1nseyTp253N0++5R9cRK9DIqYNI91s3Odwk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 08:21:56.7662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e403d74-7289-4c60-f551-08d75148be4a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2869
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 15 October 2019 02:16:11 BST james qian wang (Arm Technology Ch=
ina) wrote:
> On Mon, Oct 14, 2019 at 11:58:48AM -0400, Ilia Mirkin wrote:
> > On Fri, Oct 11, 2019 at 1:43 AM james qian wang (Arm Technology China)
> > <james.qian.wang@arm.com> wrote:
> > >
> > > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver t=
o
> > > convert S31.32 sign-magnitude to Qm.n 2's complement that supported b=
y
> > > hardware.
> > >
> > > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wan=
g@arm.com>
> > > ---
> > >  drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
> > >  include/drm/drm_color_mgmt.h     |  2 ++
> > >  2 files changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_c=
olor_mgmt.c
> > > index 4ce5c6d8de99..3d533d0b45af 100644
> > > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > > @@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_inp=
ut, uint32_t bit_precision)
> > >  }
> > >  EXPORT_SYMBOL(drm_color_lut_extract);
> > >
> > > +/**
> > > + * drm_color_ctm_s31_32_to_qm_n
> > > + *
> > > + * @user_input: input value
> > > + * @m: number of integer bits
> >=20
> > Is this the full 2's complement value? i.e. including the "sign" bit
> > of the 2's complement representation? I'd kinda assume that m =3D 32, n
> > =3D 0 would just get me the integer portion of this, for example.
>=20
> @m doesn't include "sign-bit"
>=20
> and for this conversion only support m <=3D 31, n <=3D 32.
>=20
> > > + * @n: number of fractinal bits
> >=20
> > fractional
>=20
> Thank you.
> >=20
> > > + *
> > > + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
> > > + */
> > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > +                                     uint32_t m, uint32_t n)
> > > +{
> > > +       u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> > > +       bool negative =3D !!(user_input & BIT_ULL(63));
> > > +       s64 val;
> > > +
> > > +       /* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] *=
/
> >=20
> > This implies that n =3D 32, m =3D 0 would actually yield a 33-bit 2's
> > complement number. Is that what you meant?
>=20
> Yes, since m doesn't include sign-bit So a Q0.32 is a 33bit value.
>=20

I gotta say this would be quite confusing. There is no sign bit in 2's
complement, per se. The MSbit just has a negative weight. Q16.16 is a
32-bit value, so Q0.32 should also be a 32-bit value with weights
-2^-1, +2^-2, etc.

Best to follow what Wikipedia says, right :).

> >=20
> > > +       val =3D clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) =
- 1);
> >=20
> > I'm going to play with numpy to convince myself that this is right
> > (esp with the endpoints), but in the meanwhile, you probably want to
> > use BIT_ULL in case n + m > 32 (I don't think that's the case with any
> > current hardware though).
>=20
> Yes, you are right, I need to use BIT_ULL, and Mihail also point this out=
.
> This is function is drived from our internal s31_32_to_q2_14()
>=20
> >=20
> > > +
> > > +       return negative ? 0ll - val : val;
> >=20
> > Why not just "negative ? -val : val"?
>=20
> will correct it.
>=20
> >=20
> > > +}
> > > +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> > > +
> > >  /**
> > >   * drm_crtc_enable_color_mgmt - enable color management properties
> > >   * @crtc: DRM CRTC
> > > diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgm=
t.h
> > > index d1c662d92ab7..60fea5501886 100644
> > > --- a/include/drm/drm_color_mgmt.h
> > > +++ b/include/drm/drm_color_mgmt.h
> > > @@ -30,6 +30,8 @@ struct drm_crtc;
> > >  struct drm_plane;
> > >
> > >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_pre=
cision);
> > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > +                                     uint32_t m, uint32_t n);
> > >
> > >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> > >                                 uint degamma_lut_size,
> > > --
> > > 2.20.1
> > >
>=20


--=20
Mihail



