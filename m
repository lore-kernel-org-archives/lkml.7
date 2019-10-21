Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5CFCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D6620659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wfNfsFI0";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wfNfsFI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfJUJSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:18:32 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:15686
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727154AbfJUJSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bVTZpYM9yLx/bzDzCEuoQcIPT5HKjy7OtR5DvjhQxQ=;
 b=wfNfsFI0+ikkCvq8Uuoh+XCtiRx3+PyX35RMj/KMlWvjVRLxo4DK6ogs8SnLj88y9c+xMG2h2OZClU24uDwAJ0n1n6PSG4/IW2j1VgFHzNQq+8a+AtfaacQihS6kMIp36FJDttWtSPF5UuxWbn65EcB2EjSE+t0ddWpliMq6QpY=
Received: from VI1PR08CA0135.eurprd08.prod.outlook.com (2603:10a6:800:d5::13)
 by VI1PR08MB4367.eurprd08.prod.outlook.com (2603:10a6:803:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Mon, 21 Oct
 2019 09:18:20 +0000
Received: from AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0135.outlook.office365.com
 (2603:10a6:800:d5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 09:18:20 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT040.mail.protection.outlook.com (10.152.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 09:18:18 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Mon, 21 Oct 2019 09:18:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 639a4823cea47f54
X-CR-MTA-TID: 64aa7808
Received: from c2e11027cb6c.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CB7DDA56-75A2-4779-8D32-AEE5385FA42E.1;
        Mon, 21 Oct 2019 09:18:09 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c2e11027cb6c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 21 Oct 2019 09:18:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYFDeE444yUtGlgtfSZ29cuBpo//Njj8AB7IHhqbzdvpdW7kunBPcLMEjYpQDWVHTl0ywXy9GeDzo5ONLBmwolX64Highr1s2lJ5GEm6g51sjHUZP51vRH3vgJ7TIHHmH6U3S/hhmi0R72ObS2YBpVTvYZnVTjBVcidyrQAnvXyirJSIm0Po6OuptcAOjZzWSp27Xkd0CegIT+QuBNMvqBLsu1HGy5hCpa6gq72z9mV7q1xUmbYVvfdzuS7uJKReB43hYCxQMgbzFmytELQGCjJO4AxyfHJ07CFaMBuphx1jO1akjjj/8oO/G/OTiibeb6ugdn4niTMqMblg3KdWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bVTZpYM9yLx/bzDzCEuoQcIPT5HKjy7OtR5DvjhQxQ=;
 b=bHLWmeP550h4ygy1YiK8IQN8vVF0Ivo2ST13UnJ7WvUz+H52TIscZcKiZIT5ZNl+4jlxJwpP9vbTaAwCggSJqc47GyI2eKmlov8Ib5azwEFaTDiJmJlo049+KrQqOFe3mNwLl1s7sByydO1pSk9DXHl0RM6EiO/xkmVfPOAPxTddqG5lJXO00XVyRA/JCv1E+M6ySIcpCbBizPb6bA8Jbd16qQqa3e/0uFNjj0IZpwTFT3OeiDHRV+N66xhIubiJIa/lDb4Xr2EZoD+LKGCATFzX1w+iGHeUDfUpG0Ay6ivEFWGvdc91AZp6QQfYLswbfgv2DBZkd8sDid/HlBu1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bVTZpYM9yLx/bzDzCEuoQcIPT5HKjy7OtR5DvjhQxQ=;
 b=wfNfsFI0+ikkCvq8Uuoh+XCtiRx3+PyX35RMj/KMlWvjVRLxo4DK6ogs8SnLj88y9c+xMG2h2OZClU24uDwAJ0n1n6PSG4/IW2j1VgFHzNQq+8a+AtfaacQihS6kMIp36FJDttWtSPF5UuxWbn65EcB2EjSE+t0ddWpliMq6QpY=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3525.eurprd08.prod.outlook.com (20.177.115.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Mon, 21 Oct 2019 09:18:08 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 09:18:08 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Ayan Halder <Ayan.Halder@arm.com>,
        John Stultz <john.stultz@linaro.org>, nd <nd@arm.com>,
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
Thread-Index: AQHVZOOE06vVhxy1kU6dQZ4T2LR+p6ddx+OAgAGsdgCAAAQmgIAAGMaAgADZPACAAJMAAIAAAjoAgAACPwCAAToOgIAC2xUA
Date:   Mon, 21 Oct 2019 09:18:07 +0000
Message-ID: <20191021091806.v2buuugck5maxah5@DESKTOP-E1NTVVP.localdomain>
References: <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
 <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
 <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
 <20191018184123.GA10634@arm.com>
 <CALAqxLXzOjyD1MpGeuZKLz+RNz1Utd8QpbvtSOodeqT-gCu6kA@mail.gmail.com>
 <20191018185723.GA27993@arm.com>
 <2c60496c-d536-05e7-bbf6-ca718b8142bd@ti.com>
In-Reply-To: <2c60496c-d536-05e7-bbf6-ca718b8142bd@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LNXP265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::34) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f4983e4b-77bf-4a59-2ccd-08d756079cb8
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3525:|AM6PR08MB3525:|VI1PR08MB4367:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4367C16535AEAFBF9739F7ADF0690@VI1PR08MB4367.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(7416002)(8936002)(86362001)(478600001)(9686003)(6512007)(256004)(66946007)(44832011)(66066001)(14444005)(99286004)(6246003)(561944003)(26005)(3846002)(6116002)(2906002)(1076003)(229853002)(71200400001)(71190400001)(6436002)(66446008)(66476007)(6916009)(64756008)(66556008)(4326008)(6486002)(7736002)(476003)(305945005)(102836004)(58126008)(316002)(81166006)(81156014)(14454004)(52116002)(8676002)(386003)(6506007)(53546011)(76176011)(446003)(5660300002)(54906003)(486006)(186003)(11346002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3525;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uup2dbjxtD/8zUIk4LVn0i4eF76auvFiBucQtjsWyNsdaLJt8gnmCbuXxjIoVaSWXRcKBaBFB+WwDUaop+odJR8flqa8JkeivgqbIO5+VcyRmP8jn0XphFgraDXYKKHZqdtBkXTdLDZvectnPMLt26YvcirrTsvTF/QBSkVJHP2W9K2YP6I+elRjF/LtAlyasXiRbLnNR+aYLBnffuiZgvkHlZqkYxC0vCrcStknqpp/LdtJ6lpN9HqNmdjjJ6K7BlbsRZi68ZXJd0KPIeOmjiN8XHIAZHmu8wZJes663LZk9rePg8BeamcN9uY76N1DCk2NnqjimuTldVKt2ArKRwt7KUiYMIjNpnVzvH5SX7ofATEP1ZHQqARV8J7ow7dBCXNMvfNZtbUAKGPfQFz0wNeo2UMrNQxq92P6D4qQUbv6mIfXtMDTxT4pbSK86P2S
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53269AB746B4B841A88527E6E90F7700@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3525
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(561944003)(1076003)(70586007)(3846002)(8746002)(478600001)(99286004)(22756006)(356004)(14454004)(316002)(46406003)(9686003)(6512007)(229853002)(81166006)(5660300002)(26826003)(8936002)(81156014)(6486002)(76130400001)(58126008)(8676002)(47776003)(97756001)(23726003)(66066001)(36906005)(486006)(70206006)(2906002)(54906003)(6116002)(476003)(63350400001)(4326008)(76176011)(126002)(386003)(7736002)(25786009)(305945005)(102836004)(186003)(26005)(50466002)(6246003)(107886003)(6862004)(14444005)(446003)(11346002)(86362001)(53546011)(336012)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4367;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1dfdd2fa-9b8b-40c1-4f32-08d756079606
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWDts4bDurcF1sKWxROCemp10esaLI+SGot1xAe0MJdT3DgMCyvNmizCriEkEhlKN0Xf0P+m4GDAqGP4LKdv08zB7qORlNs0nHP03fVHo9q8m5Ks14MZkDFw4JKKPfJAUXnjfusEn4T2OiDf5rqi+tOKe2I4T0gy/pEOuhICTCB/1PKKz7YtwodwDdkjyWiaGqr8GlSTwtKV1lJzjkAgWsXON8GXwbUyc+DG3XiHGNyu5gXqHn+dVe0+iXkiFmWdliIa8f8LdRfvmUhWRHUgB9Zp8HBCKvj2HicK/M9nrmJJx/IOMyFSL/QcKG8u5tqAnyybnQXbi5vyfyh1LEjQL2USve351Lld8flXuTWiVtae4lMOwQmnuzkoEWoeW8bOev+9IfSQK7/uFnogBdYeW5PWRXXkFFRdqmr2VjXMEN0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 09:18:18.9729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4983e4b-77bf-4a59-2ccd-08d756079cb8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 09:41:27AM -0400, Andrew F. Davis wrote:
> On 10/18/19 2:57 PM, Ayan Halder wrote:
> > On Fri, Oct 18, 2019 at 11:49:22AM -0700, John Stultz wrote:
> >> On Fri, Oct 18, 2019 at 11:41 AM Ayan Halder <Ayan.Halder@arm.com> wro=
te:
> >>> On Fri, Oct 18, 2019 at 09:55:17AM +0000, Brian Starkey wrote:
> >>>> On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
> >>>>> On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote=
:
> >>>>>> On 10/17/19 3:14 PM, John Stultz wrote:
> >>>>>>> But if the objection stands, do you have a proposal for an altern=
ative
> >>>>>>> way to enumerate a subset of CMA heaps?
> >>>>>>>
> >>>>>> When in staging ION had to reach into the CMA framework as the oth=
er
> >>>>>> direction would not be allowed, so cma_for_each_area() was added. =
If
> >>>>>> DMA-BUF heaps is not in staging then we can do the opposite, and h=
ave
> >>>>>> the CMA framework register heaps itself using our framework. That =
way
> >>>>>> the CMA system could decide what areas to export or not (maybe bas=
ed on
> >>>>>> a DT property or similar).
> >>>>>
> >>>>> Ok. Though the CMA core doesn't have much sense of DT details eithe=
r,
> >>>>> so it would probably have to be done in the reserved_mem logic, whi=
ch
> >>>>> doesn't feel right to me.
> >>>>>
> >>>>> I'd probably guess we should have some sort of dt binding to descri=
be
> >>>>> a dmabuf cma heap and from that node link to a CMA node via a
> >>>>> memory-region phandle. Along with maybe the default heap as well? N=
ot
> >>>>> eager to get into another binding review cycle, and I'm not sure wh=
at
> >>>>> non-DT systems will do yet, but I'll take a shot at it and iterate.
> >>>>>
> >>>>>> The end result is the same so we can make this change later (it ha=
s to
> >>>>>> come after DMA-BUF heaps is in anyway).
> >>>>>
> >>>>> Well, I'm hesitant to merge code that exposes all the CMA heaps and
> >>>>> then add patches that becomes more selective, should anyone depend =
on
> >>>>> the initial behavior. :/
> >>>>
> >>>> How about only auto-adding the system default CMA region (cma->name =
=3D=3D
> >>>> "reserved")?
> >>>>
> >>>> And/or the CMA auto-add could be behind a config option? It seems a
> >>>> shame to further delay this, and the CMA heap itself really is usefu=
l.
> >>>>
> >>> A bit of a detour, comming back to the issue why the following node
> >>> was not getting detected by the dma-buf heaps framework.
> >>>
> >>>         reserved-memory {
> >>>                 #address-cells =3D <2>;
> >>>                 #size-cells =3D <2>;
> >>>                 ranges;
> >>>
> >>>                 display_reserved: framebuffer@60000000 {
> >>>                         compatible =3D "shared-dma-pool";
> >>>                         linux,cma-default;
> >>>                         reusable; <<<<<<<<<<<<-----------This was mis=
sing in our
> >>> earlier node
> >>>                         reg =3D <0 0x60000000 0 0x08000000>;
> >>>                 };
> >>
> >> Right. It has to be a CMA region for us to expose it from the cma heap=
.
> >>
> >>
> >>> With 'reusable', rmem_cma_setup() succeeds , but the kernel crashes a=
s follows :-
> >>>
> >>> [    0.450562] WARNING: CPU: 2 PID: 1 at mm/cma.c:110 cma_init_reserv=
ed_areas+0xec/0x22c
> >>
> >> Is the value 0x60000000 you're using something you just guessed at? It
> >> seems like the warning here is saying the pfn calculated from the base
> >> address isn't valid.
> > It is a valid memory region we use to allocate framebuffers.
>=20
>=20
> But does it have a valid kernel virtual mapping? Most ARM systems (just
> assuming you are working on ARM :)) that I'm familiar with have the DRAM
> space starting at 0x80000000 and so don't start having valid pfns until
> that point. Is this address you are reserving an SRAM?
>=20

Yeah, I think you've got it.

This region is DRAM on an FPGA expansion tile, but as you have noticed
its "below" the start of main RAM, and I expect it's not in any of the
declared /memory/ nodes.

When "reusable" isn't there, I think we'll end up going the coherent.c
route, with dma_init_coherent_memory() setting up some pages.

If "reusable" is there, then I think we'll end up in contiguous.c and
that expects us to already have pages.

So, @Ayan, you could perhaps try adding this region as a /memory/ node
as-well, which should mean the kernel sets up some pages for it as
normal memory. But, I have some ancient recollection that the arm64
kernel couldn't handle system RAM at addresses below 0x80000000 or
something. That might be different now, I'm talking about several
years ago.

Thanks,
-Brian

> Andrew
>=20
>=20
> >>
> >> thanks
> >> -john
