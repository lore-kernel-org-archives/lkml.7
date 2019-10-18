Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B59CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3042064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AtkqG29f";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AtkqG29f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407906AbfJRJ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:56:21 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:8836
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389081AbfJRJ4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyaJO6jKZ3GV8Hn1DNpPCgvFwEUVizXoXW/B3c4db78=;
 b=AtkqG29fxmAN8m8/RckLFG/f3pmPicXxzHlrt4fVEoNVRoqHUPoRatOYjHTDsh9RGspU7J1yxSTdBFermmxVEZjGOfyBbZt1CQFIe7JNYJK3jiJGk/xMVjHrecRH//KkpDmQoJ3gsnyasju24YoBcHkrIQm2P2ezgmaC2sUuMbU=
Received: from VI1PR0802CA0014.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::24) by AM6SPR01MB0020.eurprd08.prod.outlook.com
 (2603:10a6:20b:1f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Fri, 18 Oct
 2019 09:55:33 +0000
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by VI1PR0802CA0014.outlook.office365.com
 (2603:10a6:800:aa::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 18 Oct 2019 09:55:32 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT013.mail.protection.outlook.com (10.152.16.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 09:55:30 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 18 Oct 2019 09:55:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6b9cf3b306bd601a
X-CR-MTA-TID: 64aa7808
Received: from ed6e6c079816.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F7E36C9B-4F94-468F-B6B9-DF353B6C64AA.1;
        Fri, 18 Oct 2019 09:55:19 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ed6e6c079816.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 09:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWqrY+Mma5yhKhmEa/BfBkdjlKeVrgNKNEb/jeOBFOrKEf1O+6SrhEFBBic7PV1+R/JN0zOW448r247jJli4wh9jCZZlBPGE1xccaEoRWshztjhhw0gMDKlVoSn/AQnTaJDl5PuuH3cXVpnZKTbr9NRYeHSytdN/UfaK7OPvR77+O/l+fPwzmqK7KIo6JTnRBck2Elb4lAXdRr2yTxW+5owl3si8xSuKaKm5lz/f52fvvfRVN9CQSBOK/nDqknraJqNwQ4eL2uPVoppEhO61iz5bdEpA3gjKv/6tIj1rOiiVkQ2rlYTesHmpBFil7rwpyZWdq6yAzfh8YDJaI3aiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyaJO6jKZ3GV8Hn1DNpPCgvFwEUVizXoXW/B3c4db78=;
 b=LykRYQVLsHENSsNwn7SYJ7+PtfnBmdImUK+nW7bXCQvgROewhKL8APgkBgSWo5HTB0R2VHLafTVim1UaIAsGGtCRm7cShm9rMokVDKBdadB2yV7yIUDv3e5cw/KL7FZaYShXjy8K9od+rGPr0Ec6BAex23DyC+k6PIk1ftR7Rf+Q8DnHWoL37bmfu5l/o14ApyfjrYZR7qDHZmLhWR3vpT49d6+rAYvjQlI41k/wVWLo/YmwgJnTxzj6vLpQAaKvKQLk1UibVO7ZbK3WGYV6bN0WuXrE142qo77pQKpD21yaJd/je7Rv9B1uDSh8U5zhpY+tQFt4cONrShc4o5I++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyaJO6jKZ3GV8Hn1DNpPCgvFwEUVizXoXW/B3c4db78=;
 b=AtkqG29fxmAN8m8/RckLFG/f3pmPicXxzHlrt4fVEoNVRoqHUPoRatOYjHTDsh9RGspU7J1yxSTdBFermmxVEZjGOfyBbZt1CQFIe7JNYJK3jiJGk/xMVjHrecRH//KkpDmQoJ3gsnyasju24YoBcHkrIQm2P2ezgmaC2sUuMbU=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB5271.eurprd08.prod.outlook.com (10.255.123.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 09:55:17 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 09:55:17 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     "Andrew F. Davis" <afd@ti.com>, nd <nd@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Thread-Topic: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Thread-Index: AQHVZOOE06vVhxy1kU6dQZ4T2LR+p6ddx+OAgAGsdgCAAAQmgIAAGMaAgADZPAA=
Date:   Fri, 18 Oct 2019 09:55:17 +0000
Message-ID: <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
 <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
 <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
 <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
In-Reply-To: <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::28) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b0aa5e44-3f91-474c-476f-08d753b14fc8
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB5271:|AM6PR08MB5271:|AM6SPR01MB0020:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6SPR01MB0020E8E208AB5DF6B1DC3135F06C0@AM6SPR01MB0020.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(9686003)(66446008)(7416002)(316002)(66066001)(256004)(71190400001)(4326008)(6916009)(6116002)(305945005)(7736002)(2906002)(6512007)(71200400001)(54906003)(446003)(102836004)(14454004)(476003)(486006)(186003)(478600001)(76176011)(26005)(3846002)(53546011)(6506007)(386003)(25786009)(44832011)(58126008)(11346002)(6246003)(66476007)(81156014)(5660300002)(1076003)(561944003)(229853002)(64756008)(81166006)(99286004)(66946007)(8936002)(6436002)(6486002)(86362001)(66556008)(52116002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5271;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MfEiwEg/pTkl6s8pKhrfTDBMhC7DRncF9QPBl1TyFK9HW1yuIcxTRKjF+jddqYbfhDuRxadfBrznWcUmC/dOgx85BZCwaOOxkDI7lEAeHIY16705Md2cerredkxszDMs5aV9GFk32QeTF2nrIWnRUU1v330PHZMOYfDyLbL2PN/L/V+Cga8p3tlhw6PmiDj2bfS39oDjtZvPGAQHfqq8sjEpC9ENg3LrSSryvHq4TIVOayfqPYtaYWk85FyKCcsJUv6yD9ilRvl0lmLFdCO/Y2hn7qMtWCC4Pc87jnBgrFhQMgPqkMcCiMjDIkYMssRvaF7nMYtChIV7tsCeEgYoJpNcBhTxtLaMo3owWugPgi8xIkUBKrx+mD3xspIjtUktraMulLuBxKLN7Y63djDM5GSoSnG1K9GPYHId9xVzMqM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2518C9FE01EAE4A9C3BE5F62A612E3D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5271
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(6506007)(386003)(46406003)(53546011)(99286004)(102836004)(186003)(5660300002)(97756001)(22756006)(76176011)(26005)(336012)(70586007)(70206006)(446003)(25786009)(11346002)(63350400001)(86362001)(356004)(476003)(81166006)(81156014)(486006)(126002)(9686003)(6512007)(76130400001)(54906003)(3846002)(36906005)(6862004)(478600001)(316002)(66066001)(47776003)(305945005)(7736002)(23726003)(14454004)(6116002)(4326008)(2906002)(26826003)(50466002)(1076003)(6246003)(8746002)(229853002)(6486002)(8936002)(58126008)(8676002)(561944003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6SPR01MB0020;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4a911976-8c78-4ead-c6a9-08d753b147c8
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GPx7U2MXxXWHTh+Zdqd4cayPndhD2YaeGWR7cMDjlDEHw+UARPxo5VrHESYafqWbNCpnJRpGWTAxdDP25kUdNoLB7ckX27+MBbC8y/uEOEeveY+TLCqfCzzFcIORXmTbzR0CCymwzRvrMDtou0/tgvVEl4Dt1zgIVDi/eoTLe8gureT8EOQTP6M645cvKA4CIAUnAWKgrfJi44JDfT35MRvPmplEBDTJJ9EV5m4P5u7L7cdiusRyzq96Z3Uem9E2PZT1fVRoHVPf7fI860bfGbG5ng7fgCERXA9Jwu/kxaERBMeAy/X42K7ozh8y+7vVK6peevEisO65TzP7NsMXiMfe6i3DAd3Ei6F6bB0jBoXJAdTt7gQoWW1bbek1A/F+ZVrNLcQvpQpe+JiSzRlIr6a+ecstR9TEjrnmfyZK9xjo6mEut3VvKkKS65WX2n9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 09:55:30.8486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0aa5e44-3f91-474c-476f-08d753b14fc8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
> On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote:
> > On 10/17/19 3:14 PM, John Stultz wrote:
> > > But if the objection stands, do you have a proposal for an alternativ=
e
> > > way to enumerate a subset of CMA heaps?
> > >
> > When in staging ION had to reach into the CMA framework as the other
> > direction would not be allowed, so cma_for_each_area() was added. If
> > DMA-BUF heaps is not in staging then we can do the opposite, and have
> > the CMA framework register heaps itself using our framework. That way
> > the CMA system could decide what areas to export or not (maybe based on
> > a DT property or similar).
>=20
> Ok. Though the CMA core doesn't have much sense of DT details either,
> so it would probably have to be done in the reserved_mem logic, which
> doesn't feel right to me.
>=20
> I'd probably guess we should have some sort of dt binding to describe
> a dmabuf cma heap and from that node link to a CMA node via a
> memory-region phandle. Along with maybe the default heap as well? Not
> eager to get into another binding review cycle, and I'm not sure what
> non-DT systems will do yet, but I'll take a shot at it and iterate.
>=20
> > The end result is the same so we can make this change later (it has to
> > come after DMA-BUF heaps is in anyway).
>=20
> Well, I'm hesitant to merge code that exposes all the CMA heaps and
> then add patches that becomes more selective, should anyone depend on
> the initial behavior. :/

How about only auto-adding the system default CMA region (cma->name =3D=3D
"reserved")?

And/or the CMA auto-add could be behind a config option? It seems a
shame to further delay this, and the CMA heap itself really is useful.

Cheers,
-Brian

>=20
> So, <sigh>, I'll start on the rework for the CMA bits.
>=20
> That said, I'm definitely wanting to make some progress on this patch
> series, so maybe we can still merge the core/helpers/system heap and
> just hold the cma heap for a rework on the enumeration bits. That way
> we can at least get other folks working on switching their vendor
> heaps from ION.
>=20
> Sumit: Does that sound ok? Assuming no other objections, can you take
> the v11 set minus the CMA heap patch?
>=20
> thanks
> -john
