Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6CC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1890120873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hs0qhMps";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hs0qhMps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJOBQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 21:16:42 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:6464
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727011AbfJOBQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 21:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R64baFQcQ838p4yaTEUcAZXBkZ2XgADSSSx7UGhjfUw=;
 b=hs0qhMpsazSu4gHZDWUDDIawXyC0MYTHHCw9Gndj7xLN+PYMrVYIeYErklrA2OsFSEptBYOKT/pho7VyHPXlSCmbOI3oxJEK1xnx7RKf7g3lOIvKlUYoNeQEHqJcxJaaHULpvd6aZ1vHUHvRpgDjGhGj1LRQAVVUeBXoN7iEglQ=
Received: from HE1PR08CA0072.eurprd08.prod.outlook.com (2603:10a6:7:2a::43) by
 AM5PR0802MB2609.eurprd08.prod.outlook.com (2603:10a6:203:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Tue, 15 Oct
 2019 01:16:33 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by HE1PR08CA0072.outlook.office365.com
 (2603:10a6:7:2a::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 01:16:33 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 01:16:31 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 15 Oct 2019 01:16:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1c16bbc12033a55d
X-CR-MTA-TID: 64aa7808
Received: from 1b59f97714ad.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8FCCB7DF-5D7D-4AEE-B0A0-94F043E94065.1;
        Tue, 15 Oct 2019 01:16:19 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2059.outbound.protection.outlook.com [104.47.0.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1b59f97714ad.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 01:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eX9NDE/slbm96WQM+X9Qi7fb4I4HbO1yCoCozSSObbSOvGiBP6t8N8yweqm+oo2POJgCNwtAbgWjdifP8OWYvPSnfeZM1m6PBPeUzt9WOLIBb6fBdn6rp6YhueXxtqG5EPInvR8xyG7R/u6mVkKGEJ5p1MGEwIAvi4ys+yqQSYjsV9hEcjpBO1UpRJNpk/bwfUf1PmUpM0uSouxNEQS4gAIKruSXZEZrghpXdi7TuQVKlq7YY26eRyHuVrfIMJeEcsmDbUold2IXHskASuZZ0HQUQaKFb7K81mG0uNhEHCPoN8nZctaYIC0mWHDxdicfhCsfvooxD2iC0TpZ8e+ynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R64baFQcQ838p4yaTEUcAZXBkZ2XgADSSSx7UGhjfUw=;
 b=C5HqXGTutoKZxeFTOBX7mFrv51PXn60ySOUNDHo4ykw3petMnJ4YDLmMvj3xfbLwr/fXhWdOjPLvj4pwC3l/8WqLfGHvNr36eiOj+9rr50ZDlTnlHj8FDKR/g/+ftFAAFFMnLf2qtLHui8Lpuk/uPU1miDV44rSlE9tHN6+cRbma58HuS6Df4dW1BdvY+tTRIYmXbOKbmBtqJRNZXz8gY/q/ORcFXBTy2lqlRxByE0W8dsFh3QYMmQmFHxQnDsPlafPBUmW1kYNfOOOL60ouZ4QTsUMHOeKS7VxTUfqQuE0GgzreRf7bVMQeY88FuE6QoM5ieyQDA3QnZq7tay//4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R64baFQcQ838p4yaTEUcAZXBkZ2XgADSSSx7UGhjfUw=;
 b=hs0qhMpsazSu4gHZDWUDDIawXyC0MYTHHCw9Gndj7xLN+PYMrVYIeYErklrA2OsFSEptBYOKT/pho7VyHPXlSCmbOI3oxJEK1xnx7RKf7g3lOIvKlUYoNeQEHqJcxJaaHULpvd6aZ1vHUHvRpgDjGhGj1LRQAVVUeBXoN7iEglQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5069.eurprd08.prod.outlook.com (20.179.29.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 01:16:12 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 01:16:12 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
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
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/bDNAzoDxuLVU+by7UkFix6lKdaUJkAgACbswA=
Date:   Tue, 15 Oct 2019 01:16:11 +0000
Message-ID: <20191015011604.GA26941@jamwan02-TSP300>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
 <20191011054240.17782-2-james.qian.wang@arm.com>
 <CAKb7Uvik6MZSwCQ4QF7ed1wttfufbR-J4vNdOtYzM+1tqPE_vw@mail.gmail.com>
In-Reply-To: <CAKb7Uvik6MZSwCQ4QF7ed1wttfufbR-J4vNdOtYzM+1tqPE_vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::30) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7526533b-2b30-45b6-575c-08d7510d4fe4
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5069:|VE1PR08MB5069:|AM5PR0802MB2609:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26093975A0667036E087C28BB3930@AM5PR0802MB2609.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(39860400002)(366004)(396003)(346002)(136003)(199004)(189003)(99286004)(5660300002)(2171002)(229853002)(256004)(33716001)(25786009)(6916009)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6436002)(6512007)(9686003)(102836004)(476003)(6246003)(7736002)(316002)(86362001)(14454004)(478600001)(2906002)(81156014)(66066001)(446003)(26005)(6486002)(58126008)(8936002)(1076003)(386003)(6506007)(76176011)(33656002)(53546011)(305945005)(486006)(81166006)(11346002)(71200400001)(71190400001)(186003)(8676002)(52116002)(54906003)(4326008)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5069;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QLbnvuZPKzcbrV05OChcKT8XMrC2pLX044HjtKDzDxK2k7ALlmuzyvpiYG2MI0NlSag7saTt4kYyAmjnekJyEmUvmh26WkkwUfk4DEYpzVeHvomwC7N4VzJQgQgZfMxIsjnvdeSsn4ZhU8Wp7eWyPildLRzzQzF+4AvLzTD8kKWHpcOArK653yhA6K+fwVVjD1/Viq4Pg2w5heYNKCcgQR9uTyYXarSFu3mUb/lx9SiR6tP6RLlnMJFGlW05qxHRUz4S1zCwbWPBtNg7AEiHjyaHK9OWFoBqiqwsIFLYqqSkbaqkYRvVe5n35Su+rWZyECN4VyafSrb7WTM1IkL1lDl8PP0mgS9M5a/hZlh6dulpALI6fCw1yuDRNnywtsXH8aIdSGv/E+b6Wmn/fisfxECYIKVpdvB6uL7Cx444YdQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95A824C58CB2A045A31C89F1918849E5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5069
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(33656002)(356004)(76176011)(26005)(186003)(36906005)(70586007)(70206006)(2906002)(8676002)(97756001)(81166006)(76130400001)(6486002)(102836004)(53546011)(316002)(54906003)(81156014)(58126008)(4326008)(99286004)(386003)(6506007)(476003)(47776003)(126002)(86362001)(25786009)(486006)(305945005)(7736002)(66066001)(6246003)(446003)(11346002)(63350400001)(2171002)(8746002)(9686003)(33716001)(336012)(6862004)(8936002)(22756006)(6512007)(478600001)(26826003)(23726003)(46406003)(6116002)(14454004)(5660300002)(50466002)(229853002)(1076003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2609;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6497e44f-f088-4063-d62e-08d7510d4421
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcVtKqAxc2D9Lrwa53WJrszIcNWHD1uqUJXvc16rM581XevEQPmBrdkW/jFIeI5gRHJe38mqqW0nokAdkPNsaXg7qfo4rjBvliIKq06eZJpv4sSxwGzpzQqTjl7nYYk4rwu7op1VIjb2SGtlixFZJ7MxqJ4bZxNLeG+16J3JyOdw0EQsDWgBbWwNXXIr7r1fTvCv3El7QUl5VQ2uGzdUif8yXFDvwix+929t0KCReC52OcQXM16MOZICpsYR+TUA9lDopkPMFwvmNrxApezEuP65jbxrlwRA9UlC994ZXW63CqWtWQ3S6PmOVTjABYSBuU+veX8I0vMZMC66KzmRBrx9CxLSXcVyXGAfEsiQmRxDup/oGrIRlR5ygXZ+1M9rKH/xVLdEoSCoePoSOJpu2KfArQMY7mE/m+V8kSR63dI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 01:16:31.1973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7526533b-2b30-45b6-575c-08d7510d4fe4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:58:48AM -0400, Ilia Mirkin wrote:
> On Fri, Oct 11, 2019 at 1:43 AM james qian wang (Arm Technology China)
> <james.qian.wang@arm.com> wrote:
> >
> > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
> > convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
> > hardware.
> >
> > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
> >  include/drm/drm_color_mgmt.h     |  2 ++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_col=
or_mgmt.c
> > index 4ce5c6d8de99..3d533d0b45af 100644
> > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > @@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_input=
, uint32_t bit_precision)
> >  }
> >  EXPORT_SYMBOL(drm_color_lut_extract);
> >
> > +/**
> > + * drm_color_ctm_s31_32_to_qm_n
> > + *
> > + * @user_input: input value
> > + * @m: number of integer bits
>=20
> Is this the full 2's complement value? i.e. including the "sign" bit
> of the 2's complement representation? I'd kinda assume that m =3D 32, n
> =3D 0 would just get me the integer portion of this, for example.

@m doesn't include "sign-bit"

and for this conversion only support m <=3D 31, n <=3D 32.

> > + * @n: number of fractinal bits
>=20
> fractional

Thank you.
>=20
> > + *
> > + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
> > + */
> > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > +                                     uint32_t m, uint32_t n)
> > +{
> > +       u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> > +       bool negative =3D !!(user_input & BIT_ULL(63));
> > +       s64 val;
> > +
> > +       /* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */
>=20
> This implies that n =3D 32, m =3D 0 would actually yield a 33-bit 2's
> complement number. Is that what you meant?

Yes, since m doesn't include sign-bit So a Q0.32 is a 33bit value.

>=20
> > +       val =3D clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) - =
1);
>=20
> I'm going to play with numpy to convince myself that this is right
> (esp with the endpoints), but in the meanwhile, you probably want to
> use BIT_ULL in case n + m > 32 (I don't think that's the case with any
> current hardware though).

Yes, you are right, I need to use BIT_ULL, and Mihail also point this out.
This is function is drived from our internal s31_32_to_q2_14()

>=20
> > +
> > +       return negative ? 0ll - val : val;
>=20
> Why not just "negative ? -val : val"?

will correct it.

>=20
> > +}
> > +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> > +
> >  /**
> >   * drm_crtc_enable_color_mgmt - enable color management properties
> >   * @crtc: DRM CRTC
> > diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.=
h
> > index d1c662d92ab7..60fea5501886 100644
> > --- a/include/drm/drm_color_mgmt.h
> > +++ b/include/drm/drm_color_mgmt.h
> > @@ -30,6 +30,8 @@ struct drm_crtc;
> >  struct drm_plane;
> >
> >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_preci=
sion);
> > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > +                                     uint32_t m, uint32_t n);
> >
> >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> >                                 uint degamma_lut_size,
> > --
> > 2.20.1
> >
