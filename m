Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F0CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F3920640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DH/Ov/Jb";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DH/Ov/Jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfJUJgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:36:03 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:35590
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfJUJgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rAK0qrWsQJfVzaeV5IOCPL0Lc3OpotsBHL35RbbrTk=;
 b=DH/Ov/JbGdxj430612TQuf+JLFya30EhGzcT2oPKXgdgAB1McE9K4FMYo+QGSGJgPGNU3D+UttICB+sSgYuqEFrg6nV+AgjCkcDpNYdUDtrgifHDzHb2zOH+F0mP2SaIXCgEI9dTI+B0NFlnwLAQ6HYFIu1Hg/Gmdpk5ARmZ0kQ=
Received: from VI1PR08CA0110.eurprd08.prod.outlook.com (2603:10a6:800:d4::12)
 by AM6PR08MB4359.eurprd08.prod.outlook.com (2603:10a6:20b:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Mon, 21 Oct
 2019 09:35:57 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0110.outlook.office365.com
 (2603:10a6:800:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 09:35:57 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 09:35:56 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Mon, 21 Oct 2019 09:35:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bf1f4b46523fda7b
X-CR-MTA-TID: 64aa7808
Received: from e9272839d8bd.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A72AB2B4-4951-4FBA-A50E-3435E7CAC6AB.1;
        Mon, 21 Oct 2019 09:35:48 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e9272839d8bd.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 09:35:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abzsq8HoMVWdPo2jRUdmRNmqUMAk4EUAbnEeMbQ5sw2AjamK3m3Av/tD17uMyltD5WERT4Ju2edQU3t2Y5t+KauveyzdEUm9+Jcgar/aokfY2Qkh13INUa8WbQELcOW6b5iqNzCZJEOdgvUOSmMAYfZ4fsR++MhdcOLbE11blEYnZd7FEKCNMeW9eCe5VeWen/NnLrsVjnX2cQxYsxn09emFNvxt8BSUojCU+A7fHic3nHwlSlyuH489Ueg6fNNC7JoKBySMZPoUbC4zngD5+4gxBmMFlvRsnAw4rT4iSrFKq0eS14sGjnhTePU5IIpbDj1ajB9k1a8oBDC+QwOisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rAK0qrWsQJfVzaeV5IOCPL0Lc3OpotsBHL35RbbrTk=;
 b=Ry0Z8NkMTohuN+Z8xwWLyzIWr26iwwA4/05rAZH2yirItAf/gLZeG+LCz/uzrpRLC+DAoFpDZgwB4mLHRZtbobmkkUUljGRe6pzVVJOehCa3s1oqtdBNxTbvB1TghfkOVES1wDwAaF5eOe4U/FHffpt+tMobndgtyV6X34K1tIjaHCNE6rcr8v/NokfcmNsuIQdzYBzgUReHE4lg5DQFvXz+UHgHhGHLYZ32zWBNyalg5OaV3a0kLWkBFUXwtFplIqWfPtCLNOime1ixU1R+FMMyw/EwEnl8zfDvFGa7op4MSo52oTH6eQOZoicxjib8wNYq+9mDLi1PCbG2jSOC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rAK0qrWsQJfVzaeV5IOCPL0Lc3OpotsBHL35RbbrTk=;
 b=DH/Ov/JbGdxj430612TQuf+JLFya30EhGzcT2oPKXgdgAB1McE9K4FMYo+QGSGJgPGNU3D+UttICB+sSgYuqEFrg6nV+AgjCkcDpNYdUDtrgifHDzHb2zOH+F0mP2SaIXCgEI9dTI+B0NFlnwLAQ6HYFIu1Hg/Gmdpk5ARmZ0kQ=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3461.eurprd08.prod.outlook.com (20.177.113.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 21 Oct 2019 09:35:47 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 09:35:47 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v12 1/5] dma-buf: Add dma-buf heaps framework
Thread-Topic: [PATCH v12 1/5] dma-buf: Add dma-buf heaps framework
Thread-Index: AQHVhXQuL0D7Z4fi0UChemDv0BA9l6dgQKQAgAB3rACABCKcAA==
Date:   Mon, 21 Oct 2019 09:35:47 +0000
Message-ID: <20191021093546.m5hgpjadtpu7d4km@DESKTOP-E1NTVVP.localdomain>
References: <20191018052323.21659-1-john.stultz@linaro.org>
 <20191018052323.21659-2-john.stultz@linaro.org>
 <20191018111832.o7wx3x54jm3ic6cq@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLUVLP0ujB0SHyWHMncRMHkBvVj1+CpBgGUD8Xg3RexQ8w@mail.gmail.com>
In-Reply-To: <CALAqxLUVLP0ujB0SHyWHMncRMHkBvVj1+CpBgGUD8Xg3RexQ8w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LNXP265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::23) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4a5820e8-a51a-47fb-0cf4-08d7560a12e1
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3461:|AM6PR08MB3461:|AM6PR08MB4359:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB435950C5CF7E427304C6D366F0690@AM6PR08MB4359.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(26005)(53546011)(186003)(44832011)(99286004)(446003)(52116002)(76176011)(6506007)(476003)(386003)(102836004)(486006)(14454004)(25786009)(11346002)(86362001)(478600001)(6916009)(7416002)(7736002)(305945005)(2906002)(3846002)(6116002)(6436002)(5660300002)(9686003)(6246003)(6512007)(71200400001)(71190400001)(6486002)(66556008)(66446008)(58126008)(316002)(54906003)(4326008)(66066001)(14444005)(256004)(1076003)(81166006)(81156014)(8676002)(66946007)(66476007)(8936002)(229853002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3461;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rV/hhwpAN/K0cl9qaj4ztqsuPxt6ReqFp2cAgM2GOOyTbcXD6/OVZ1MgxVa0XUzQQLwFLTWSkw9PTi26m/NPxp1MZd+zn85BX5+4+kO9oeSBBgf6l54O3J7t+V91I4ChG7DIKYv9a+CwFTS6481xl/FR4tAR5DxxW54Qc5j2zChqYp3I2XQ5bsJDru0jeAjzQLTSENFYc/YHu7D2nIB79Stl40RN0ksnYiu0AvrThGGa29168QxKjJ9mEDHnOpm4enbtRfpzlBhtb1j72SCmq5HN5jDC7lCRL+OOuJHHx2OZPyBmRzf0IpM69OO7USIs4SdwdStWWY1ySDxK46xqHCikixsYodfparcBQQ58B9if6ZmEX4G4JlbLoWDIr1bg91szNN40SZC1LAH2rh6wPwyVfPHhxWd05JSP3nNSNJ825i0kYRvUdlPRdv496Rc7
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBF6FB093390EE4A8C2F9994C62124D3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3461
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(14454004)(478600001)(186003)(46406003)(25786009)(102836004)(6246003)(26005)(53546011)(97756001)(6506007)(386003)(76130400001)(66066001)(305945005)(86362001)(70206006)(26826003)(6862004)(76176011)(70586007)(99286004)(47776003)(7736002)(4326008)(3846002)(6116002)(81166006)(81156014)(1076003)(36906005)(6512007)(8936002)(9686003)(14444005)(58126008)(11346002)(356004)(229853002)(54906003)(316002)(6486002)(126002)(50466002)(476003)(8676002)(63350400001)(5660300002)(23726003)(8746002)(486006)(22756006)(336012)(446003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4359;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f30ad39a-47bf-4626-b00e-08d7560a0d50
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymmtu7NgCd+bTgaIw/EB4fpC4HQ9JtSDkLcmNezBcPFB4Pafd86gb7Ojgm5oYsvDHs0yvGNsaZLURJv0zGVTPmPLqi0yrO9LUcPFf1f52x5x6bu+QAwc3vjxDepfwkl7IQBu6Vxo/p/EdDw5iVINyWkUYk2zM8wSni+Oh5S+qHsYI5aH0RpXYhfTL/Zi/WYPp3Mmswg+WU8lbfi8OAh813seC5UjJDo0XV/KadrIKsG8wgX57I5R9TMUND3bOzrcmYnPC69z5jjS0iJbxVPEYtHmvVspHx74QWDxw1Wn2zUHAmopxiay4Rbilrky+KLh4I7D6vbcfmQlR1u3LJ3tWrSzFTlVDVumQYcU+dAEyoqC5wCddmhp6LeDCY/BzXU9SlbMWLBkHOwwx73dgmi2sZNbcH75i2nTiSzwfIV+aFcDbVR0ElO26iL50fmfV543
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 09:35:56.1534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5820e8-a51a-47fb-0cf4-08d7560a12e1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:26:52AM -0700, John Stultz wrote:
> On Fri, Oct 18, 2019 at 4:18 AM Brian Starkey <Brian.Starkey@arm.com> wro=
te:
> > On Fri, Oct 18, 2019 at 05:23:19AM +0000, John Stultz wrote:
> >
> > As in v3:
> >
> >  * Avoid EXPORT_SYMBOL until we finalize modules (suggested by
> >    Brian)
>=20
> Heh. I guess it has been awhile.  :)
>=20
> > Did something change in that regard? I still think letting modules
> > register heaps without a way to remove them is a recipe for issues.
>=20
> So yea, in recent months, work around Android with their GKI effort
> has made it necessary for ION heaps to be loadable from modules. I had
> some patches in WIP tree to enable this, and in the rework I did
> yesterday for the CMA module trivially collided with parts, and
> forgetting the discussion back in v3, I figured I'd just fold those
> bits in before I resubmitted for v12.

Ah yes, I can see that would be needed.

>=20
> If it's an issue, I can pull it out, but I'm going to be submitting
> module enablement for review as soon as the core bits are queued, as
> its going to be important to support for Android to switch to this
> from ION.
>=20

I don't know how to decide if it's an issue. My understanding is that
if you rmmod something which has exported buffers, various Bad Things
might happen; I believe including data leaks, corruption or crashing
the kernel. There's probably plenty of scope for that with dma-buf
exporters already, so it's not exactly "new" but it is a bit
unfortunate.

If "people" are OK with adding new code which has the same issue, then
I'm not going to make any more of a fuss, because perfection is the
enemy of progress. Perhaps an obvious comment pointing out the issue
would be prudent, though - as a reminder to people that add heaps from
their code (and wonder why there's no "dma_heap_remove" function).

Cheers,
-Brian

> thanks
> -john
