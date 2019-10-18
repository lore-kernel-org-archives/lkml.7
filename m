Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0DCCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AABE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WBm+RP64";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WBm+RP64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502779AbfJRSmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:42:01 -0400
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:44803
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfJRSl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKiKGvUEeQKuI/myhpX1qfiB1ta7qzm+3umrb2aVzwM=;
 b=WBm+RP64aAvRK3xi3gSB8GI/G5Hbg8/6IfR8FGj3fbTtvGgou5YF2XXl5znmacBevekbK54Wnm79Cjknh30EfNnVTTbU10Gi6t/bLt73NXsYQemgsEekP4yleF20LE17VJc99+0et+z2RRt4jauu3iKYBu5g3qON2WSGGRKySNk=
Received: from DB7PR08CA0040.eurprd08.prod.outlook.com (2603:10a6:10:26::17)
 by VI1PR08MB4319.eurprd08.prod.outlook.com (2603:10a6:803:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Fri, 18 Oct
 2019 18:41:51 +0000
Received: from VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by DB7PR08CA0040.outlook.office365.com
 (2603:10a6:10:26::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Fri, 18 Oct 2019 18:41:51 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT063.mail.protection.outlook.com (10.152.18.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 18:41:49 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 18 Oct 2019 18:41:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f03efda94cfecb87
X-CR-MTA-TID: 64aa7808
Received: from 3bac919f61c3.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5E78617D-4262-43BF-86D1-0B8EEFC95CF7.1;
        Fri, 18 Oct 2019 18:41:27 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3bac919f61c3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 18:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdfZ7GYR3uwEpZinpNKIAeHXBwozmbyxwBspJpK3UH8zpGWQbXHJAKw6GWEZ8qIchiFIJOsShoTyHrlWmcxL6Twwv79sSi/Wg6OYZ8yZeE6jE7eTtxhUYKuf2uegJdJirGkFImJhn8lKqSartdWjzQg+o+8Jqc8ofnBxtaPH5ytRG/hUfbnB90Pp2kuFNonYK6LtmSc/7DkmqBF/DgCfxOV7fFfWV3uc/Rz4r0tgY1GwFSLsfGYsi9n3JUF6w8fR0FR0IBcR94zkATjObh6oeuKeIS4R3EmJJQCzIo7NP13bdNYWpUJCQxdpYVtHi+6XakyCInmgQLn4qEp2iZfZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKiKGvUEeQKuI/myhpX1qfiB1ta7qzm+3umrb2aVzwM=;
 b=d/PBIuOf9fXyMKkFPO9D10THur+usWvx6xBXEESwDnOJer3o3YJbeeowd2bv3UdCLF/zjWas0AI0phM9PjLkv2c8OXsJVW79bihvXNOwOiZgWPP05CxzOMBjAzgOQQ0JwDXbPKEcDOizYVxX0sNfFPLL+Vby4ooSnNUx6OnrrVMUU9cKmDgntQvCFvTCM/LLrR2GYniQ4+kIqc+q87fWCmnLkKDTULft/71VWYwUeTCOsehEBoNYNdkXZ6I/kI57hvluyUFlkMOILqeM+DU7nkrrEzyuI9XPgkx+IDR64n/qGZPDVyHlf0Txl/Cu1NKezprn0TIedaB4+kaK7CgyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKiKGvUEeQKuI/myhpX1qfiB1ta7qzm+3umrb2aVzwM=;
 b=WBm+RP64aAvRK3xi3gSB8GI/G5Hbg8/6IfR8FGj3fbTtvGgou5YF2XXl5znmacBevekbK54Wnm79Cjknh30EfNnVTTbU10Gi6t/bLt73NXsYQemgsEekP4yleF20LE17VJc99+0et+z2RRt4jauu3iKYBu5g3qON2WSGGRKySNk=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.215.213) by
 AM0PR08MB3011.eurprd08.prod.outlook.com (52.134.125.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 18:41:24 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::f009:c530:6569:cf6f]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::f009:c530:6569:cf6f%4]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 18:41:24 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     John Stultz <john.stultz@linaro.org>,
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
Thread-Index: AQHVZOOF+0BJBq1hEUK86gknnLECMKczS0sAgAfTZICAF6gMgIAADdeAgAc/QoCAA7QPgIABrHYAgAAEJoCAABjGgIAA2T6AgACS/YA=
Date:   Fri, 18 Oct 2019 18:41:24 +0000
Message-ID: <20191018184123.GA10634@arm.com>
References: <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
 <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
 <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
 <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:18c::21)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c9b89cd9-b22f-4bbe-f3a8-08d753fad635
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM0PR08MB3011:|AM0PR08MB3011:|VI1PR08MB4319:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB431953BC2F5CD957029B649DE46C0@VI1PR08MB4319.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(66446008)(64756008)(66556008)(66476007)(66946007)(54906003)(2616005)(316002)(446003)(37006003)(476003)(2906002)(6486002)(11346002)(3846002)(6116002)(99286004)(6862004)(186003)(4326008)(6436002)(86362001)(8936002)(44832011)(66066001)(256004)(14444005)(81156014)(8676002)(81166006)(6636002)(25786009)(486006)(6246003)(478600001)(229853002)(1076003)(305945005)(45080400002)(53546011)(6506007)(386003)(7416002)(6512007)(561944003)(5660300002)(52116002)(76176011)(33656002)(14454004)(7736002)(36756003)(71200400001)(71190400001)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3011;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BXI0O8Gu0sUw5+ERwlaW6h3uLF+TVCxnOcH+/zy43q4nV4+M8c8ku36k0Un9dOiF1GWvYC05Ed8JQ9miBzwlgPQQED9wWMjueuCJNfQtOA5JfyfAw1s5sZFmoWK9zK4ElpUlhiLmzMRr0/KxsLv23zY8x82n9yOA/f2YBzBYzCJATtZXVwMQ/EJoI8w4KbqxjHH/ts1ZKVkM+5xhy7sozDvQAF/gsGYNLYb1EE6g4KENjuImo0RfIth7mUtw3qc6zwwbqmwW3fDb+lhjXwhdccXs5lgzJfr8mq1Oy2UARixQJxDVwGNjKlNvtPsRJbuGWOo54+fCQ9nHknbaERibAqDKYNB+x0Wt/1+1oNMpsPn9NSjPqpOy3ZZgmwdvy5JC+0GibPGHb9YBjUpr39tcRas1NwYHpVrGwiLPiozEYzc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78D4CAEB9234634B94A2C5395A2F7577@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3011
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(26005)(8936002)(6506007)(2906002)(316002)(22756006)(46406003)(6246003)(386003)(102836004)(50466002)(81166006)(186003)(14454004)(53546011)(81156014)(107886003)(14444005)(6636002)(97756001)(8746002)(76176011)(356004)(5660300002)(561944003)(8676002)(33656002)(4326008)(25786009)(6862004)(6116002)(36906005)(99286004)(3846002)(37006003)(478600001)(86362001)(23726003)(11346002)(70586007)(6512007)(66066001)(45080400002)(1076003)(229853002)(6486002)(47776003)(54906003)(26826003)(2616005)(7736002)(63350400001)(446003)(126002)(76130400001)(305945005)(70206006)(476003)(336012)(36756003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4319;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8560c100-a46b-41bc-1b11-08d753fac721
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S65bCYUx9EvrH//+o46wEDoz+KcJxE9fKEFGr1MvyC4vOtHnmOy7MXm4mDvElgKvz7wxC7Ir4hP72TjMpp6nxV+ojFuVRQ/RnWQnaJiPNjEwWVtY88NeEjbzU42G/rOvVN4L594TvcHxh/0Hxhs4LnbfoBaFtCGPl5EipJWUN+m01390T7FidXh7YEnlnfTJeet2pey9WAEsFs2P4jxFyqnxknZFtBs89pzADFK2+Gs1Sovf7sGNeSgHBs8nzynZD+oDebzaCx1ibxnkU12V76b3lx5Qo4ESPACQii69kfJSNiBpv1jGDo1rEqMvzyo6vIO5kGfQ5/hq1pacA4lzOl0nxbl3wtZjPEnR7xDNB97cTre6tsLfGLfDSoavWxDmoSQucrFEGOZ3SIIizLInlkfVcQm1bCNHGovvqByctps=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 18:41:49.5592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b89cd9-b22f-4bbe-f3a8-08d753fad635
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 09:55:17AM +0000, Brian Starkey wrote:
> On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
> > On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote:
> > > On 10/17/19 3:14 PM, John Stultz wrote:
> > > > But if the objection stands, do you have a proposal for an alternat=
ive
> > > > way to enumerate a subset of CMA heaps?
> > > >
> > > When in staging ION had to reach into the CMA framework as the other
> > > direction would not be allowed, so cma_for_each_area() was added. If
> > > DMA-BUF heaps is not in staging then we can do the opposite, and have
> > > the CMA framework register heaps itself using our framework. That way
> > > the CMA system could decide what areas to export or not (maybe based =
on
> > > a DT property or similar).
> >=20
> > Ok. Though the CMA core doesn't have much sense of DT details either,
> > so it would probably have to be done in the reserved_mem logic, which
> > doesn't feel right to me.
> >=20
> > I'd probably guess we should have some sort of dt binding to describe
> > a dmabuf cma heap and from that node link to a CMA node via a
> > memory-region phandle. Along with maybe the default heap as well? Not
> > eager to get into another binding review cycle, and I'm not sure what
> > non-DT systems will do yet, but I'll take a shot at it and iterate.
> >=20
> > > The end result is the same so we can make this change later (it has t=
o
> > > come after DMA-BUF heaps is in anyway).
> >=20
> > Well, I'm hesitant to merge code that exposes all the CMA heaps and
> > then add patches that becomes more selective, should anyone depend on
> > the initial behavior. :/
>=20
> How about only auto-adding the system default CMA region (cma->name =3D=
=3D
> "reserved")?
>=20
> And/or the CMA auto-add could be behind a config option? It seems a
> shame to further delay this, and the CMA heap itself really is useful.
>
A bit of a detour, comming back to the issue why the following node
was not getting detected by the dma-buf heaps framework.

        reserved-memory {
                #address-cells =3D <2>;
                #size-cells =3D <2>;
                ranges;

                display_reserved: framebuffer@60000000 {
                        compatible =3D "shared-dma-pool";
                        linux,cma-default;
                        reusable; <<<<<<<<<<<<-----------This was missing i=
n our
earlier node
                        reg =3D <0 0x60000000 0 0x08000000>;
                };
=20
Quoting reserved-memory.txt :-
"The operating system can use the memory in this region with the limitation=
 that
 the device driver(s) owning the region need to be able to reclaim it back"

Thus as per my observation, without 'reusable', rmem_cma_setup()
returns -EINVAL and the reserved-memory is not added as a cma region.

With 'reusable', rmem_cma_setup() succeeds , but the kernel crashes as foll=
ows :-

[    0.450562] WARNING: CPU: 2 PID: 1 at mm/cma.c:110 cma_init_reserved_are=
as+0xec/0x22c
[    0.458415] Modules linked in:                                          =
                                                                  =20
[    0.461470] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc4-01377-g5=
1dbcf03884c-dirty #15                                             =20
[    0.470017] Hardware name: ARM Juno development board (r0) (DT)         =
                                                                  =20
[    0.475953] pstate: 80000005 (Nzcv daif -PAN -UAO)                      =
                                                                  =20
[    0.480755] pc : cma_init_reserved_areas+0xec/0x22c =20
[    0.485643] lr : cma_init_reserved_areas+0xe8/0x22c=20
<----snip register dump --->

[    0.600646] Unable to handle kernel paging request at virtual address ff=
ff7dffff800000
[    0.608591] Mem abort info:
[    0.611386]   ESR =3D 0x96000006
<---snip uninteresting bits --->
[    0.681069] pc : cma_init_reserved_areas+0x114/0x22c
[    0.686043] lr : cma_init_reserved_areas+0xe8/0x22c


I am looking into this now. My final objective is to get "/dev/dma_heap/fra=
mebuffer"
(as a cma heap).
Any leads?

> Cheers,
> -Brian
>=20
> >=20
> > So, <sigh>, I'll start on the rework for the CMA bits.
> >=20
> > That said, I'm definitely wanting to make some progress on this patch
> > series, so maybe we can still merge the core/helpers/system heap and
> > just hold the cma heap for a rework on the enumeration bits. That way
> > we can at least get other folks working on switching their vendor
> > heaps from ION.
> >=20
> > Sumit: Does that sound ok? Assuming no other objections, can you take
> > the v11 set minus the CMA heap patch?
> >=20
> > thanks
> > -john
