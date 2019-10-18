Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC549CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9774220640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XT6m/grw";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XT6m/grw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443182AbfJRS5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:57:51 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:23980
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfJRS5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYRKqjaac8RJ5BfUbH3QKR/LrWfycplJ9cHXAD53flk=;
 b=XT6m/grwtV1YJvSE7dBGKMnKZX+bnbv/sIYhVsDSE8yN2eZ1adJqg/0uJhwrFLPwbFwmB+fn9P1Y+SE8KYo21+65pdoFu3oBlvDeXb/d26Ozy9iJiA88QSFmO2Z0eSIJXcroKUzCwp9Lzho5s7sZGliGLGsrydZ7rew6Zcy2nlw=
Received: from DB6PR0801CA0062.eurprd08.prod.outlook.com (2603:10a6:4:2b::30)
 by DBBPR08MB4555.eurprd08.prod.outlook.com (2603:10a6:10:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Fri, 18 Oct
 2019 18:57:39 +0000
Received: from VE1EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by DB6PR0801CA0062.outlook.office365.com
 (2603:10a6:4:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 18 Oct 2019 18:57:39 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT040.mail.protection.outlook.com (10.152.18.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 18:57:37 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 18 Oct 2019 18:57:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d854c8622283f904
X-CR-MTA-TID: 64aa7808
Received: from 4ca6af9cd97e.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8C46B13C-AA42-4BBD-82B4-72C1D1A92CE1.1;
        Fri, 18 Oct 2019 18:57:26 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4ca6af9cd97e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 18:57:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj3LSgxAvIJ9+PxOVxaRoFqqkLStHj9XxcnAhzC40rPpc9+/oA/rJs1gf9dbXyN2t8JKgpjNW7CNipLwYFKYar0uwlH3Nzu0kQOrm91RRFHDuigRIvyjaeC3YfjgafRvLIYjUd3QI0b0I5vBpi6JceRc8hySR7iwdLgQAQSbdH4eBC+bIpl+YHoF/cnYVqxsNytXeIftXD/4DI3EQVVzunSvboxyou+iqP+6nr6mBOoTwwmoPsg7wApWuNwgO3ZyrPhH2c1YulV71f545iv9vSwkk6x2aWhzBu4jtY6WInT4ZULf/9VYxZBLgWYShdZabEODjwy4LqA/saNqIwkA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYRKqjaac8RJ5BfUbH3QKR/LrWfycplJ9cHXAD53flk=;
 b=QJDyk4K8zTxRSVweY1003KbZl8YAR11Dr1lSzw03tOs4trsNCEA22/ovqyI92xW1f1EqR9IZdQcxocaPcDLaXTG6uVQxoi9XdVkn2SIdunKY3V44jk/cKbbBJe8n1V3E8jNY4MkODb5raxQNvgj1XhQnMAWhqjBdzjC+Acul6supF2kmO3RGtYKBxbfrzE8W9862+GG1p5Z1ZQKMB44BigjSd+t+teOyCZiDxx3v7zBqL7AmwZUidJyAQEbh28gIzb0F95edPMX6YxOJUiOQZ+z5dcbdQJFCSHHj6Fg3+YS70dSaHC+zoVJuOa5A2rDfNtxMi1HkPnfocWqqlwqF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYRKqjaac8RJ5BfUbH3QKR/LrWfycplJ9cHXAD53flk=;
 b=XT6m/grwtV1YJvSE7dBGKMnKZX+bnbv/sIYhVsDSE8yN2eZ1adJqg/0uJhwrFLPwbFwmB+fn9P1Y+SE8KYo21+65pdoFu3oBlvDeXb/d26Ozy9iJiA88QSFmO2Z0eSIJXcroKUzCwp9Lzho5s7sZGliGLGsrydZ7rew6Zcy2nlw=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5366.eurprd08.prod.outlook.com (10.141.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Fri, 18 Oct 2019 18:57:24 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::84b1:861:46e8:7a4e]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::84b1:861:46e8:7a4e%4]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 18:57:24 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F. Davis" <afd@ti.com>, nd <nd@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Thread-Topic: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Thread-Index: AQHVZOOF+0BJBq1hEUK86gknnLECMKczS0sAgAfTZICAF6gMgIAADdeAgAc/QoCAA7QPgIABrHYAgAAEJoCAABjGgIAA2T6AgACS/YCAAAI7AIAAAj6A
Date:   Fri, 18 Oct 2019 18:57:24 +0000
Message-ID: <20191018185723.GA27993@arm.com>
References: <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
 <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
 <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
 <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
 <20191018184123.GA10634@arm.com>
 <CALAqxLXzOjyD1MpGeuZKLz+RNz1Utd8QpbvtSOodeqT-gCu6kA@mail.gmail.com>
In-Reply-To: <CALAqxLXzOjyD1MpGeuZKLz+RNz1Utd8QpbvtSOodeqT-gCu6kA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0373.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::25) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: cf389e75-128a-457f-f0bf-08d753fd0b14
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:|AM7PR08MB5366:|DBBPR08MB4555:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4555908570883E3B135108ABE46C0@DBBPR08MB4555.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(3846002)(6916009)(6116002)(1076003)(5660300002)(7416002)(7736002)(66446008)(66556008)(305945005)(66946007)(66476007)(64756008)(66066001)(86362001)(4326008)(229853002)(316002)(102836004)(54906003)(26005)(386003)(6506007)(53546011)(6486002)(14454004)(186003)(8936002)(6512007)(81166006)(8676002)(71190400001)(71200400001)(81156014)(99286004)(76176011)(256004)(14444005)(52116002)(44832011)(486006)(2616005)(25786009)(446003)(11346002)(6246003)(476003)(36756003)(33656002)(561944003)(2906002)(6436002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5366;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QARJO7cP97IdgYB536jf3jTgdZtHOn/EiNSf7Kh2JNE0VVotv5eq/UvsrsPYaXqXuIc2q0sgjomJm2fxxwSqX2xiUoO0btTLvdlCAj1r+yBZpGf+h7NkwmJGaeOj8hjbGq+si4DMZCynjEK1oJhkh7FWpARGOzzK7Osqcaa+4SzZRLiQgg+dnwVfY1mLxRMFMEpBJMf505O9zGwfBFPVhsBdhA2WuhBpUNHZ1gnHhwqeE7llngQvnkJaZBTOVkL72CK4LwgB0wwAFHYTd9Mu0pi4Sd3dBN7EffXVqjT2cMrM2GG0QnKir0rZV8OhdovIU6aLZOEz/pGe94BMp4dO6KpTIJyNIoJXP2gC3bFTGn/ugVVRCnCu/Z6VESac9EqBe5lyjv9dIlsIlDfkrFr57aizRUG8kXxmmSoqlg3ziIk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4E2AC8BAA4B7C4FBEFA11954460CCBD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(356004)(53546011)(76176011)(46406003)(14444005)(36906005)(97756001)(316002)(336012)(25786009)(26005)(5660300002)(54906003)(561944003)(6506007)(486006)(50466002)(386003)(478600001)(33656002)(26826003)(66066001)(6486002)(63350400001)(126002)(81166006)(81156014)(8676002)(86362001)(36756003)(102836004)(1076003)(107886003)(8746002)(6862004)(476003)(6246003)(22756006)(14454004)(6512007)(47776003)(2616005)(305945005)(8936002)(7736002)(70586007)(70206006)(229853002)(11346002)(446003)(186003)(99286004)(4326008)(23726003)(6116002)(76130400001)(2906002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4555;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 09b0b0dc-c150-42af-32bb-08d753fd0351
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lg/cBtnBrNO+/vp/dR34RfRfI7fwO/BSsTLSui8l3GinRPcIzlLlhEJnkr8XVlMt5Bm9U63BnFIdEkTvJs3DOWtSfy2WkSmohBAjBbGzS/T79U0G70zVvXgXztuByUF6mizlL2hJ8ZmqzHz3RAx0AY8aDe2kdeqCuze2Kf5FwyiZuwk7sHXe6ykn5h/6VVr3W/HCQqfaMvO13J3ZLhfXbaT3scmwQSErIrnAED3xZQbRF/OAtoMaAP8pvMFh2zEgxAmz1c/zb/zyOeijN/xWi2tozfWqdGDTiGCqMbEF2bKNDbZEysbbsjyR+fcucWS+/uihdx3DVNl83Zg2K7ZIHkjsCgnqcSw135cxsVSJFbPul/doAnzw3+e14J98RSMBXYE1/0n26y80WMIxZVlePrbRcK8x8RjfSDKXK4R6zKY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 18:57:37.1715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf389e75-128a-457f-f0bf-08d753fd0b14
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4555
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:49:22AM -0700, John Stultz wrote:
> On Fri, Oct 18, 2019 at 11:41 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
> > On Fri, Oct 18, 2019 at 09:55:17AM +0000, Brian Starkey wrote:
> > > On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
> > > > On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote=
:
> > > > > On 10/17/19 3:14 PM, John Stultz wrote:
> > > > > > But if the objection stands, do you have a proposal for an alte=
rnative
> > > > > > way to enumerate a subset of CMA heaps?
> > > > > >
> > > > > When in staging ION had to reach into the CMA framework as the ot=
her
> > > > > direction would not be allowed, so cma_for_each_area() was added.=
 If
> > > > > DMA-BUF heaps is not in staging then we can do the opposite, and =
have
> > > > > the CMA framework register heaps itself using our framework. That=
 way
> > > > > the CMA system could decide what areas to export or not (maybe ba=
sed on
> > > > > a DT property or similar).
> > > >
> > > > Ok. Though the CMA core doesn't have much sense of DT details eithe=
r,
> > > > so it would probably have to be done in the reserved_mem logic, whi=
ch
> > > > doesn't feel right to me.
> > > >
> > > > I'd probably guess we should have some sort of dt binding to descri=
be
> > > > a dmabuf cma heap and from that node link to a CMA node via a
> > > > memory-region phandle. Along with maybe the default heap as well? N=
ot
> > > > eager to get into another binding review cycle, and I'm not sure wh=
at
> > > > non-DT systems will do yet, but I'll take a shot at it and iterate.
> > > >
> > > > > The end result is the same so we can make this change later (it h=
as to
> > > > > come after DMA-BUF heaps is in anyway).
> > > >
> > > > Well, I'm hesitant to merge code that exposes all the CMA heaps and
> > > > then add patches that becomes more selective, should anyone depend =
on
> > > > the initial behavior. :/
> > >
> > > How about only auto-adding the system default CMA region (cma->name =
=3D=3D
> > > "reserved")?
> > >
> > > And/or the CMA auto-add could be behind a config option? It seems a
> > > shame to further delay this, and the CMA heap itself really is useful=
.
> > >
> > A bit of a detour, comming back to the issue why the following node
> > was not getting detected by the dma-buf heaps framework.
> >
> >         reserved-memory {
> >                 #address-cells =3D <2>;
> >                 #size-cells =3D <2>;
> >                 ranges;
> >
> >                 display_reserved: framebuffer@60000000 {
> >                         compatible =3D "shared-dma-pool";
> >                         linux,cma-default;
> >                         reusable; <<<<<<<<<<<<-----------This was missi=
ng in our
> > earlier node
> >                         reg =3D <0 0x60000000 0 0x08000000>;
> >                 };
>=20
> Right. It has to be a CMA region for us to expose it from the cma heap.
>=20
>=20
> > With 'reusable', rmem_cma_setup() succeeds , but the kernel crashes as =
follows :-
> >
> > [    0.450562] WARNING: CPU: 2 PID: 1 at mm/cma.c:110 cma_init_reserved=
_areas+0xec/0x22c
>=20
> Is the value 0x60000000 you're using something you just guessed at? It
> seems like the warning here is saying the pfn calculated from the base
> address isn't valid.
It is a valid memory region we use to allocate framebuffers.
>=20
> thanks
> -john
