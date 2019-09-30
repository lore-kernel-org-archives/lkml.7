Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783C0C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BD5215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Bg9pmEQu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Bg9pmEQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfI3Nf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:35:56 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:39005
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730411AbfI3Nfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5jmlvwPkuFbr0EWMejam7XNhucxB12IcTSM91PwwgU=;
 b=Bg9pmEQugvcdriWPvMUlO2f5MO3meeztGrkVz/SOultGYEhtv02uY0KRd9jvWcBl/OgRt23/Lhtpm54/ckM2zSEP1Cxb5t2kAEyQAvSTV2qTR/RJthvSBiMFPZZlmnH03nl4AEQG24EQwMi3PPjDhhsm8YepsBuEuRRyynEBVak=
Received: from VI1PR08CA0225.eurprd08.prod.outlook.com (2603:10a6:802:15::34)
 by DB6PR0802MB2533.eurprd08.prod.outlook.com (2603:10a6:4:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 13:35:41 +0000
Received: from VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR08CA0225.outlook.office365.com
 (2603:10a6:802:15::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Mon, 30 Sep 2019 13:35:41 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT052.mail.protection.outlook.com (10.152.19.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 13:35:39 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 30 Sep 2019 13:35:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a9e45afd18e2b331
X-CR-MTA-TID: 64aa7808
Received: from 7731501daa42.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 439C5BA4-82AF-42B8-944A-F8B927D84136.1;
        Mon, 30 Sep 2019 13:35:26 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7731501daa42.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 13:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQYO4ehsxVlyRmfxZLIOmyP/cdJ7TQak0BgTwkWvJQGVRPKBn5pNThGqY2/G34NfQ3FE0KAYD76lePdSWhbidEVqqtbjFNORXQ3cLzO8enQnU0+6NELIeWR7bYfMLHecjcaNC+UoOkYMmH4wLtUlWqicHk0sknm431w826ESs5HGCQLb9KNAM7ZKub4EaPBVa6ufFQSZa0NHXcN2LZOUwtGYDhXXfyhMLflLGU74xAYXdvAAgqsOJnPlLyLl5lwNG1KLYlx31d3pZ/llhmM8Mv9BLLbNhZWOHPRo0tN/WB0A215RwXxe5i6m3670RcMoLHx7QereMIksCtm43kYdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5jmlvwPkuFbr0EWMejam7XNhucxB12IcTSM91PwwgU=;
 b=Sn5tLSooqiJZmmwE4HSk9xBOiDvTvYHSiw102vCW3896uCkYS135fkPHtdNQjyOXVVqOohuwplJ9DPfLpm/ulq7CQz/KPJeOVc/bi3dMiPU1YngkBk6bOimTNB+agKEZwaZGaa9WqRGrFGAFjH/qGp9d5pDw/iNDg0i8yDv+RxIar1/e7TTQapI644EYtU1hBUM32Bu9T74Z+eYroXKLyniIw6UXewgByTaXm3yshD5h2SVLXfh/cNnqSHglasY7OyF5T84/H2QX3oieWN14GMUdW+oXyVoHh1bKeq37zSGTJoFrpoDTWTcvDE8trVxmQEYFBxfJIKU+twaj3bCpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5jmlvwPkuFbr0EWMejam7XNhucxB12IcTSM91PwwgU=;
 b=Bg9pmEQugvcdriWPvMUlO2f5MO3meeztGrkVz/SOultGYEhtv02uY0KRd9jvWcBl/OgRt23/Lhtpm54/ckM2zSEP1Cxb5t2kAEyQAvSTV2qTR/RJthvSBiMFPZZlmnH03nl4AEQG24EQwMi3PPjDhhsm8YepsBuEuRRyynEBVak=
Received: from DB8PR08MB5354.eurprd08.prod.outlook.com (52.133.240.216) by
 DB8PR08MB5194.eurprd08.prod.outlook.com (10.255.18.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 13:35:23 +0000
Received: from DB8PR08MB5354.eurprd08.prod.outlook.com
 ([fe80::14ad:d417:d811:387]) by DB8PR08MB5354.eurprd08.prod.outlook.com
 ([fe80::14ad:d417:d811:387%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 13:35:23 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Qiang Yu <yuq825@gmail.com>
CC:     Daniel Vetter <daniel@ffwll.ch>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Raymond Smith <Raymond.Smith@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVKBsKBvRwqAaS30eXmbt21cTJQqamO1MAgART94CAAAdigIAAF3uAgAOs2ACAhgdkgIAQdTcA
Date:   Mon, 30 Sep 2019 13:35:23 +0000
Message-ID: <20190930133522.GA16273@arm.com>
References: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
 <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com>
 <20190624093233.73f3tcshewlbogli@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uG02qAqH8MMpE6kzRO99HTjnadTFDrY1vVr9RmAiFPvJA@mail.gmail.com>
 <20190624112301.dmczf2vofxnpzqqi@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uEotYyRaa4WqNKRGc0nfwcyGccRpX2YzZmETrPdgXkAKA@mail.gmail.com>
 <CAKGbVbvLv6MDYapr5Oo5ZvJh+GV3-LU_ok2a8tpYGWOpw8hBBA@mail.gmail.com>
In-Reply-To: <CAKGbVbvLv6MDYapr5Oo5ZvJh+GV3-LU_ok2a8tpYGWOpw8hBBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::15) To DB8PR08MB5354.eurprd08.prod.outlook.com
 (2603:10a6:10:114::24)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e229654d-2a12-49ff-623e-08d745ab1570
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DB8PR08MB5194:|DB8PR08MB5194:|DB6PR0802MB2533:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2533903EE169A00FF25FF179E4820@DB6PR0802MB2533.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(6486002)(486006)(6916009)(11346002)(33656002)(76176011)(476003)(66066001)(446003)(6436002)(6246003)(3846002)(6116002)(256004)(53546011)(44832011)(386003)(229853002)(6506007)(71200400001)(71190400001)(2616005)(8676002)(81156014)(4326008)(14444005)(1411001)(478600001)(99286004)(966005)(64756008)(36756003)(8936002)(25786009)(6306002)(86362001)(2906002)(316002)(587094005)(5660300002)(6512007)(54906003)(7736002)(66476007)(66446008)(102836004)(66946007)(52116002)(66556008)(186003)(305945005)(81166006)(14454004)(26005)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5194;H:DB8PR08MB5354.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MutUI6imcE5FVN8TMhmfMR97lJgr9oUH6ATZDGDZAHbOQc4wKHmJCrFGrqXwonDtTw6nQc7ImR/K8QxMW9e0nbrQb5Evd0LJ6QCdQbNBGuxCEggyxELBUI1onGE+GFRn9DMyFq8jn4bcewWnl6dqG67IwHUyOQhwpof4+NSxyGY3M2OzpchuCA15WyEe2jA3nXCjYcrxdJzmbE6V04WLWJioUYVEAN4LHLBDvSQ7r7/12picu8ekZHwdCObVO1dnVLa/90+l69qN8/OgKXNLUrEqrymxPW266ElAd8lxp2S6VSR0YC5bRm7JXqSg2mA873VVmPDqfo8z4rRDuypw2BwxsC9zb5t4Yf+mOwbs6wr9fqJhXBUSvqw9LGRc5P2GiAYtZ1fs+V3o9qyt85ZFzVNhLYWRORXe9SsYLx16J79bA7LfwPpfGkaGbPVkxD0NS1dAPUDatItsaUMRvGqFyQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7887580DC92394C923CCB570263C67D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5194
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(25786009)(36756003)(966005)(26826003)(23726003)(1076003)(6116002)(3846002)(478600001)(6862004)(6306002)(2906002)(6512007)(5660300002)(4326008)(7736002)(305945005)(587094005)(76130400001)(6486002)(229853002)(33656002)(70206006)(70586007)(356004)(6246003)(1411001)(8676002)(26005)(186003)(8936002)(53546011)(11346002)(446003)(486006)(47776003)(99286004)(54906003)(126002)(336012)(36906005)(316002)(81156014)(81166006)(476003)(76176011)(86362001)(2616005)(22756006)(8746002)(14454004)(63350400001)(97756001)(50466002)(386003)(14444005)(6506007)(102836004)(66066001)(46406003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2533;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7b3d0998-0288-4549-80f0-08d745ab0b69
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gA74ZRy3ynND3z/758D8HZy6W/zlniN4qT8oOPEDYVFeHHHi4JO5mDMsrvp21OvYypjpiZtflkesL/0pSOl+jB1eswIEa8w8osqm+DsKyFNxfaD5CB3rMm4vwtjBVzCOsMrn7UvqA5Yxt8kEP4R6m/YkoMW6YfSAboqqF53brGcjfMvEFKw3fHJv76RObz/qmj9WUZDnrCo5rgzRuzN6MW3AOLBrh73XWKvWdJyr/LB8nScfyW/X40MREYmwGpRFLc+Od+3X0Pw/PuH0cjsQkTr5PSNyWGNF1Qn+3v8XfiTGubsl5cEShHRe8jp9zCPhW29Zg1soIkKpGtBKpjPFz6+COsDPQeEwJsHH36o+TxJgUGUEotzJGX9Truqmy/M1PUk37ql/BPkjU9TNH0ry9dHiuJ3bZtYyMud6zsdxsKPq8AR/6lMSAjnTGbVhjpP6q5WFUo1D4ib2NjgKuI+6iQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 13:35:39.6304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e229654d-2a12-49ff-623e-08d745ab1570
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:15:41AM +0800, Qiang Yu wrote:
> Hi guys,
>=20
> I'd like to know the status of this patch? I expect a v2 adding some
> comments/macros about the high bit plan would be enough?
>=20
> @Raymond & @Brian do you still need another long process to send out a
> v2 patch? If so, I can help to prepare a v2 patch according to your
> previous mail.

Apologies for the long wait.
@Raymond has left the company, so now I will be looking into it. I
will respin the patch in a day or two.
=20
> Thanks,
> Qiang
>=20
> On Thu, Jun 27, 2019 at 3:30 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Mon, Jun 24, 2019 at 1:23 PM Brian Starkey <Brian.Starkey@arm.com> w=
rote:
> > >
> > > On Mon, Jun 24, 2019 at 11:58:59AM +0200, Daniel Vetter wrote:
> > > > On Mon, Jun 24, 2019 at 11:32 AM Brian Starkey <Brian.Starkey@arm.c=
om> wrote:
> > > > >
> > > > > Hi Daniel,
> > > > >
> > > > > On Fri, Jun 21, 2019 at 05:27:00PM +0200, Daniel Vetter wrote:
> > > > > > On Fri, Jun 21, 2019 at 12:21 PM Raymond Smith <Raymond.Smith@a=
rm.com> wrote:
> > > > > > >
> > > > > > > Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier=
 to
> > > > > > > denote the 16x16 block u-interleaved format used in Arm Utgar=
d and
> > > > > > > Midgard GPUs.
> > > > > > >
> > > > > > > Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> > > > > > > ---
> > > > > > >  include/uapi/drm/drm_fourcc.h | 10 ++++++++++
> > > > > > >  1 file changed, 10 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm=
/drm_fourcc.h
> > > > > > > index 3feeaa3..8ed7ecf 100644
> > > > > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > > > > @@ -743,6 +743,16 @@ extern "C" {
> > > > > > >  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> > > > > > >
> > > > > > >  /*
> > > > > > > + * Arm 16x16 Block U-Interleaved modifier
> > > > > > > + *
> > > > > > > + * This is used by Arm Mali Utgard and Midgard GPUs. It divi=
des the image
> > > > > > > + * into 16x16 pixel blocks. Blocks are stored linearly in or=
der, but pixels
> > > > > > > + * in the block are reordered.
> > > > > > > + */
> > > > > > > +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> > > > > > > +       fourcc_mod_code(ARM, ((1ULL << 55) | 1))
> > > > > >
> > > > > > This seems to be an extremely random pick for a new number. Wha=
t's the
> > > > > > thinking here? Aside from "doesnt match any of the afbc combos"=
 ofc.
> > > > > > If you're already up to having thrown away 55bits, then it's no=
t going
> > > > > > to last long really :-)
> > > > > >
> > > > > > I think a good idea would be to reserve a bunch of the high bit=
s as
> > > > > > some form of index (afbc would get index 0 for backwards compat=
). And
> > > > > > then the lower bits would be for free use for a given index/mod=
e. And
> > > > > > the first mode is probably an enumeration, where possible modes=
 simple
> > > > > > get enumerated without further flags or anything.
> > > > >
> > > > > Yup, that's the plan:
> > > > >
> > > > >         (0 << 55): AFBC
> > > > >         (1 << 55): This "non-category" for U-Interleaved
> > > > >         (1 << 54): Whatever the next category is
> > > > >         (3 << 54): Whatever comes after that
> > > > >         (1 << 53): Maybe we'll get here someday
> > > >
> > > > Uh, so the index would be encoded with least-significant bit first,
> > > > starting from bit55 downwards?
> > >
> > > Yeah.
> > >
> > > > Clever idea, but I think this needs a
> > > > macro (or at least a comment). Not sure there's a ready-made bitmas=
k
> > > > mirror function for this stuff, works case we can hand-code it and
> > > > extend every time we need one more bit encoded. Something like:
> > > >
> > > > MIRROR_U32((u & (BIT(0)) << 31 | (u & BIT(1) << 30 | ...)
> > > >
> > >
> > > Is it really worth it? People can just use the definitions as written
> > > in drm_fourcc.h. I agree that we should have the high bits described
> > > in a comment though.
> > >
> > > > And then shift that to the correct place. Probably want an
> > > >
> > > > ARM_MODIFIER_ENCODE(space_idx, flags) macro which assembles everyth=
ing.
> > > >
> > > > >         ...
> > > > >
> > > > > I didn't want to explicitly reserve some high bits, because we've=
 no
> > > > > idea how many to reserve. This way, we can assign exactly as many
> > > > > high bits as we need, when we need them. If any of the "modes" st=
art
> > > > > encroaching towards the high bits, we'll have to make a decision =
at
> > > > > that point.
> > > > >
> > > > > Also, this is the only U-Interleaved format (that I know of), so =
it's
> > > > > not worth calling bit 55 "The U-Interleaved bit" because that wou=
ld be
> > > > > a waste of space. It's more like the "misc" bit, but that's not a
> > > > > useful name to enshrine in UAPI.
> > > >
> > > > Yeah that's what I meant. Also better to explicitly reserve this, i=
.e.
> > > >
> > > > #define ARM_FBC_MODIFIER_SPACE 0
> > > > #define ARM_MISC_MODIFIER_SPACE 1
> > > >
> > > > and then encode with the mirror trickery.
> > > >
> > >
> > > I don't really see the value in that either, it's just giving
> > > userspace the opportunity to depend on more stuff: more future
> > > headaches. So long as the 64-bit values are stable, that should be
> > > enough.
> >
> > If you think you need to save the few bits this potentially saves you
> > over just encoding 8bit enum like in Qiang's original patch I think
> > you get to type a few macros and comments ...
> >
> > > > > Note that isn't the same as the "not-AFBC bit", because we may we=
ll
> > > > > have something in the future which is neither AFBC nor "misc".
> > > > >
> > > > > We've been very careful in our code to enforce all
> > > > > undefined/unrecognised bits to be zero, to ensure that this works=
.
> > > > >
> > > > > >
> > > > > > The other bit: Would be real good to define the format a bit mo=
re
> > > > > > precisely, including the layout within the tile.
> > > > >
> > > > > It's U-Interleaved, obviously ;-)
> > > >
> > > > :-) I mean full code exists in panfrost/lima, so this won't change
> > > > anything really ...
> > >
> > > Yeah, so for us to provide a more detailed description would require
> > > another lengthy loop through our legal approval process, and I'm not
> > > sure we can make a strong business case (which is what we need) for
> > > why this is needed.
> > >
> > > Of course, if someone happens to know the layout and wants to
> > > contribute to this file... Then I don't know how ack/r-b would work i=
n
> > > that case, but I imagine the subsystem maintainer(s) might take issue
> > > with us attempting to block that contribution.
> >
> > Well can't really take a modifier without knowing what it's for, I
> > guess this is up to lima/panfrost folks then to figure out :-P
> > -Daniel
> >
> > >
> > > Thanks,
> > > -Brian
> > >
> > > >
> > > > Cheers, Daniel
> > > >
> > > > >
> > > > > -Brian
> > > > >
> > > > > >
> > > > > > Also ofc needs acks from lima/panfrost people since I assume th=
ey'll
> > > > > > be using this, too.
> > > > > >
> > > > > > Thanks, Daniel
> > > > > >
> > > > > > > +
> > > > > > > +/*
> > > > > > >   * Allwinner tiled modifier
> > > > > > >   *
> > > > > > >   * This tiling mode is implemented by the VPU found on all A=
llwinner platforms,
> > > > > > > --
> > > > > > > 2.7.4
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Daniel Vetter
> > > > > > Software Engineer, Intel Corporation
> > > > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
