Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EC120640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RIrDxaN7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RIrDxaN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439856AbfJRSwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:52:09 -0400
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:55269
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfJRSwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHF+gAzf95UgWGG/O3ff0/g0s2gOsiAmeEV2+zePag4=;
 b=RIrDxaN7OGX/InSw7nnkb9Z1BF1HR2rsnYQvaalDA01emoVFgucUbGtizayC/ZLup8AvQHEs3nSXz3gWm7l2BF85nzIpYvv12edPRh3ynWmJ8A+PD2+gQxP0BVCkuIAZFZo428eQ3KQwtoKsV6G+1UvazsqAWqRStfVyAzzFjRc=
Received: from DB6PR0802CA0028.eurprd08.prod.outlook.com (2603:10a6:4:a3::14)
 by AM6PR08MB3574.eurprd08.prod.outlook.com (2603:10a6:20b:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Fri, 18 Oct
 2019 18:51:58 +0000
Received: from DB5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by DB6PR0802CA0028.outlook.office365.com
 (2603:10a6:4:a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 18 Oct 2019 18:51:58 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT022.mail.protection.outlook.com (10.152.20.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 18:51:57 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 18 Oct 2019 18:51:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4b47ee850cf6557d
X-CR-MTA-TID: 64aa7808
Received: from 580cf3fefe47.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1F3AB3C4-A1BC-45E6-A3BB-6977E5574D11.1;
        Fri, 18 Oct 2019 18:51:52 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 580cf3fefe47.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 18:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOZv1W+ch192xi7Wqh8O/Nh5ZveQYwQ9CdlBleBv/5g1a0Tuoyw3TQB3l/nCsqsN3ehPpPCo8cu1953OJ5Q+RaCfZ5Z2fXkKve+5I02IDUChrrtAsrZxNPo9IQm/9Mcc3b4ZiLP8rQR3g/GAwMIfjXlyIQ+lBU+AVuvvoCof15ECktCLE8rPcu+R9Z0fKe3A1zKBmjC8wRG9WKKvi6ya88R4vRjZbpSoEp3OkEPnNepsO0qbX4u4qVFnm5r3YlACM0byKv7rgK1SJX/mLmHu+bDsvnWgZ/ZUg6Iy66S8oorpUo3qZ13g05Wy2BhUdjwM5PVm1lqAszuzBMqLf9Lz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHF+gAzf95UgWGG/O3ff0/g0s2gOsiAmeEV2+zePag4=;
 b=Miwu6LBK86O9CnDF3ENMnLQqF+aqkO+ifpzy7hKAPRuewtEyEqlJEfr9HYBfltYIJqSLD46XllOTsofPYnJJZiGK34A474yynTGKrUaMV+27gxcEpnB8y6Dc5JdOPzMHEXefzmiMqwDSKbSaxTaKzeLQoQXl0GOdeiR239jiXDETFG17DuY2eRSW06yBvC9KpbZ3B7TQ/qUpQnGoDFfFEQRD1fKOGSpNAwyiEgAqw45+wsCzptFPa9VW1e4bzIdj3OC7B9ExJO76VGaZII6tAjCpm4x+T0N4f0D8B0VByvwUwckllabbYOT8pyT8ah5+iTosCr3QHTBvDrgZAoRUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHF+gAzf95UgWGG/O3ff0/g0s2gOsiAmeEV2+zePag4=;
 b=RIrDxaN7OGX/InSw7nnkb9Z1BF1HR2rsnYQvaalDA01emoVFgucUbGtizayC/ZLup8AvQHEs3nSXz3gWm7l2BF85nzIpYvv12edPRh3ynWmJ8A+PD2+gQxP0BVCkuIAZFZo428eQ3KQwtoKsV6G+1UvazsqAWqRStfVyAzzFjRc=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.215.213) by
 AM0PR08MB3778.eurprd08.prod.outlook.com (20.178.23.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 18:51:51 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::f009:c530:6569:cf6f]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::f009:c530:6569:cf6f%4]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 18:51:51 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>, nd <nd@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Thread-Topic: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Thread-Index: AQHVZOOF+0BJBq1hEUK86gknnLECMKczS0sAgAfTZICAF6gMgIAADdeAgAc/QoCAA7QPgIABrHYAgAAEJoCAABjGgIAA2T6AgACS/YCAAALsAA==
Date:   Fri, 18 Oct 2019 18:51:50 +0000
Message-ID: <20191018185150.GA27705@arm.com>
References: <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
 <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
 <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
 <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
 <20191018184123.GA10634@arm.com>
In-Reply-To: <20191018184123.GA10634@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::23) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:18c::21)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ae6e4cfd-e983-4825-837c-08d753fc40bf
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM0PR08MB3778:|AM0PR08MB3778:|AM6PR08MB3574:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB357461265DEBC26C4374EA18E46C0@AM6PR08MB3574.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(189003)(54906003)(45080400002)(486006)(478600001)(4326008)(446003)(11346002)(52116002)(76176011)(44832011)(6636002)(6862004)(2616005)(476003)(6246003)(25786009)(37006003)(5660300002)(36756003)(102836004)(1076003)(26005)(6512007)(2906002)(6306002)(99286004)(86362001)(6506007)(53546011)(186003)(386003)(561944003)(71190400001)(966005)(33656002)(66066001)(14454004)(66476007)(316002)(6116002)(3846002)(8936002)(81156014)(81166006)(256004)(66556008)(64756008)(66446008)(66946007)(14444005)(6436002)(229853002)(6486002)(7416002)(305945005)(71200400001)(7736002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3778;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PmH6xnQK0rK4/IMhAP1/4QoAxUiBC9Q77UVD24FmX9NmJF3XPwbqCvK2F3MHvxAuPhfNcY76cnBDWZzM2h6b40d3rfA8ewWgMhL11CWboxSFbcxiET8gytOGPGPO7sxNGZBYamZ1PMu0MsSbYgqWpLzNIVYSrNNZeYaJPQXGOaducB9lLgtdaA7UuduSj24ESD0m+G11rZwC0kO9O3gr0hXoaztYUaD4r/xhev0XQNPWt6fISfB7pDY1rZ88eXklOOa/pVz9AAJAsMmCwcWBxNpogBV2PjjMFHEu8DBX8AewkBTvJclHMb282XKM5cv05qIrcJL66LoeQYeh5QCJDXwwHprsFmahv+S+fCgqTNzLWM61gNMpLprObIlpiVzAjZxCX2Kn8UocTtwPj4PBVbsCQYEdadFPq1xhD/HL/tCz1oJdm0yXb1UQnhG+RPFxOd2rJxuryEtSzxmlC9y9ig==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <642C8E9FFFC88D46B6E706AB8CD6778A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3778
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(5660300002)(47776003)(1076003)(7736002)(99286004)(86362001)(14444005)(2906002)(6486002)(70206006)(229853002)(70586007)(6306002)(6512007)(76130400001)(46406003)(76176011)(97756001)(6862004)(305945005)(50466002)(107886003)(6246003)(3846002)(356004)(37006003)(6506007)(561944003)(53546011)(6636002)(66066001)(126002)(4326008)(63350400001)(486006)(6116002)(102836004)(81166006)(81156014)(478600001)(26826003)(22756006)(316002)(33656002)(26005)(476003)(8936002)(8746002)(966005)(8676002)(45080400002)(54906003)(186003)(446003)(25786009)(336012)(36756003)(386003)(2616005)(11346002)(23726003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3574;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: abf5f33f-28a5-4914-8ffe-08d753fc3c77
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw+q+jLTO7eWdiPM/TPdUiErmVBBQ648umzHp7hauZh81aYe6nCfo0uLGXoGcBjXQVpSchQotabLL4VXyMM2rQTu8orc8UA6FUcmBJhVl6HdIsu3zq4inxKBaUaMnPozNhRqortduXb5k5IhREeVjKHsadqfuYznrpM1PZpa5tzv48pDeGfgb+/arWFDFO9+uaHjC6xhqBiy8OEvl7vTtDAcT37Pxzcf6K/mqXJFOuMjsUe+6kesCE9to5KhelHN6goRTeTbYI/3hNEjAVgnyJG7eu7QTDqXJAuJM3xHJIZGvOsNENBCvBeiwtpQaaOsbdRj3rvcwZHpCqbJAd3xramq3Llj3BCw2UH0gllyWYZmpgLOHce+L4sNRUvMGdE+DhjOKJcbIXYwl+Qcv4Vuj9LZa+tolY3nxG6nzEP8AcLXqn2UnsbDmNjUMUxM5FILULBID6ophTjpfQd2wGZOkB9CdAl4FjNcKq1lpwf3b3U=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 18:51:57.8850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6e4cfd-e983-4825-837c-08d753fc40bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++ john.stultz@linaro.org (Sorry, somehow I am missing your email while
sending. :( )
On Fri, Oct 18, 2019 at 06:41:24PM +0000, Ayan Halder wrote:
> On Fri, Oct 18, 2019 at 09:55:17AM +0000, Brian Starkey wrote:
> > On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
> > > On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote:
> > > > On 10/17/19 3:14 PM, John Stultz wrote:
> > > > > But if the objection stands, do you have a proposal for an altern=
ative
> > > > > way to enumerate a subset of CMA heaps?
> > > > >
> > > > When in staging ION had to reach into the CMA framework as the othe=
r
> > > > direction would not be allowed, so cma_for_each_area() was added. I=
f
> > > > DMA-BUF heaps is not in staging then we can do the opposite, and ha=
ve
> > > > the CMA framework register heaps itself using our framework. That w=
ay
> > > > the CMA system could decide what areas to export or not (maybe base=
d on
> > > > a DT property or similar).
> > >=20
> > > Ok. Though the CMA core doesn't have much sense of DT details either,
> > > so it would probably have to be done in the reserved_mem logic, which
> > > doesn't feel right to me.
> > >=20
> > > I'd probably guess we should have some sort of dt binding to describe
> > > a dmabuf cma heap and from that node link to a CMA node via a
> > > memory-region phandle. Along with maybe the default heap as well? Not
> > > eager to get into another binding review cycle, and I'm not sure what
> > > non-DT systems will do yet, but I'll take a shot at it and iterate.
> > >=20
> > > > The end result is the same so we can make this change later (it has=
 to
> > > > come after DMA-BUF heaps is in anyway).
> > >=20
> > > Well, I'm hesitant to merge code that exposes all the CMA heaps and
> > > then add patches that becomes more selective, should anyone depend on
> > > the initial behavior. :/
> >=20
> > How about only auto-adding the system default CMA region (cma->name =3D=
=3D
> > "reserved")?
> >=20
> > And/or the CMA auto-add could be behind a config option? It seems a
> > shame to further delay this, and the CMA heap itself really is useful.
> >
> A bit of a detour, comming back to the issue why the following node
> was not getting detected by the dma-buf heaps framework.
>=20
>         reserved-memory {
>                 #address-cells =3D <2>;
>                 #size-cells =3D <2>;
>                 ranges;
>=20
>                 display_reserved: framebuffer@60000000 {
>                         compatible =3D "shared-dma-pool";
>                         linux,cma-default;
>                         reusable; <<<<<<<<<<<<-----------This was missing=
 in our
> earlier node
>                         reg =3D <0 0x60000000 0 0x08000000>;
>                 };
> =20
> Quoting reserved-memory.txt :-
> "The operating system can use the memory in this region with the limitati=
on that
>  the device driver(s) owning the region need to be able to reclaim it bac=
k"
>=20
> Thus as per my observation, without 'reusable', rmem_cma_setup()
> returns -EINVAL and the reserved-memory is not added as a cma region.
>=20
> With 'reusable', rmem_cma_setup() succeeds , but the kernel crashes as fo=
llows :-
>=20
> [    0.450562] WARNING: CPU: 2 PID: 1 at mm/cma.c:110 cma_init_reserved_a=
reas+0xec/0x22c
> [    0.458415] Modules linked in:                                        =
                                                                    =20
> [    0.461470] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc4-01377-=
g51dbcf03884c-dirty #15                                             =20
> [    0.470017] Hardware name: ARM Juno development board (r0) (DT)       =
                                                                    =20
> [    0.475953] pstate: 80000005 (Nzcv daif -PAN -UAO)                    =
                                                                    =20
> [    0.480755] pc : cma_init_reserved_areas+0xec/0x22c =20
> [    0.485643] lr : cma_init_reserved_areas+0xe8/0x22c=20
> <----snip register dump --->
>=20
> [    0.600646] Unable to handle kernel paging request at virtual address =
ffff7dffff800000
> [    0.608591] Mem abort info:
> [    0.611386]   ESR =3D 0x96000006
> <---snip uninteresting bits --->
> [    0.681069] pc : cma_init_reserved_areas+0x114/0x22c
> [    0.686043] lr : cma_init_reserved_areas+0xe8/0x22c
>=20
>=20
> I am looking into this now. My final objective is to get "/dev/dma_heap/f=
ramebuffer"
> (as a cma heap).
> Any leads?
>=20
> > Cheers,
> > -Brian
> >=20
> > >=20
> > > So, <sigh>, I'll start on the rework for the CMA bits.
> > >=20
> > > That said, I'm definitely wanting to make some progress on this patch
> > > series, so maybe we can still merge the core/helpers/system heap and
> > > just hold the cma heap for a rework on the enumeration bits. That way
> > > we can at least get other folks working on switching their vendor
> > > heaps from ION.
> > >=20
> > > Sumit: Does that sound ok? Assuming no other objections, can you take
> > > the v11 set minus the CMA heap patch?
> > >=20
> > > thanks
> > > -john
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
