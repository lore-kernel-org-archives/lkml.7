Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE90CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4D42184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eyPGqJ8z";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eyPGqJ8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbfJVNvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:51:32 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:44598
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731035AbfJVNvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl6X8MBpd147JJY8zyoeciaOv4ES9FSJZk+oR1c3SN4=;
 b=eyPGqJ8z5y5Oy2rWd7x94qGgaSdXuG9NahqX4Dq6RcI7zNgTqs7k+0X9Vn/6dNJJkQPYaAK8VtAqw6a8zQAXnC0cPZVtqra/79gufThfR8mfEJKmQ3/+UwjJIrvpqbDuO/kXP7g8/K5/7GWRkzhMxi9sgwxutWs6DaWjplQP1xI=
Received: from VI1PR08CA0227.eurprd08.prod.outlook.com (2603:10a6:802:15::36)
 by AM0PR08MB3202.eurprd08.prod.outlook.com (2603:10a6:208:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Tue, 22 Oct
 2019 13:51:20 +0000
Received: from DB5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR08CA0227.outlook.office365.com
 (2603:10a6:802:15::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.22 via Frontend
 Transport; Tue, 22 Oct 2019 13:51:20 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT047.mail.protection.outlook.com (10.152.21.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Tue, 22 Oct 2019 13:51:19 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Tue, 22 Oct 2019 13:51:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 716af3ad6767d287
X-CR-MTA-TID: 64aa7808
Received: from 43e3bae5bf38.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 460E82E8-FAEA-48EF-B79D-177777FEF318.1;
        Tue, 22 Oct 2019 13:51:08 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2054.outbound.protection.outlook.com [104.47.6.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 43e3bae5bf38.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Oct 2019 13:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ngr1D9427FlvxyCeni4Wa2uZfcuEhI0kipdSlYanjcs4RdWyMYcgKP2ngJ9FeGfn+OOh0AYwaCEzG9werl3Ytl5/ZuhW/Zg2FA0mghxdiBMwKmjCVPh3jkceMXSciCIs6FIK2za6ZKbW0xxH3fsuL6OjuT3/8LnaKwMIDDWdQRQjYIuc1oAd6/8WkJ6LXkuwTEBfUmnqxmpeCZgH2s5a+cE+jkzDmidq1GyR9QumUnQzcHLibAN8cdyRZz/CWhbDQqMZHeJHYimFTOqDWDwz1iQg4cUi+Tb/ABM7vTbZEfjVJWBagE47zEErK/2sXcGRBEbjOJpcn4hRmMfvaOZ2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl6X8MBpd147JJY8zyoeciaOv4ES9FSJZk+oR1c3SN4=;
 b=fD+osRX6DRwXvFj2PFxxaVBzMKtCnTsFW7MPvprJScqqWx8+9Fr68fXvfp9dMw2XLtkOCCzSXZANu2ONACuHxu+NzfosowEyriLL1qBmABfhq+VmAbed4wZc4kIpzINr+P0ohF7LAUYGY87KxVXS5S/+SlWZ6GQQ18I4nD5OI+3C5wtxFL4CDuTuOiMoqqzdYiR7aVF4EZd1+RSOanYRcor6BbCpyFwFmV6NmZvURrzqZ61Zt7Hmex7vHwhsYFS/li5Zzb2QPrDkBhUv73A7O7UWMhCTLxWMtHsKgebdqlGcjAOAfMWhy1ZJoJjrEBI0SCYGjjFVau5T7mDqrXMhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl6X8MBpd147JJY8zyoeciaOv4ES9FSJZk+oR1c3SN4=;
 b=eyPGqJ8z5y5Oy2rWd7x94qGgaSdXuG9NahqX4Dq6RcI7zNgTqs7k+0X9Vn/6dNJJkQPYaAK8VtAqw6a8zQAXnC0cPZVtqra/79gufThfR8mfEJKmQ3/+UwjJIrvpqbDuO/kXP7g8/K5/7GWRkzhMxi9sgwxutWs6DaWjplQP1xI=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5349.eurprd08.prod.outlook.com (10.141.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 13:51:06 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::84b1:861:46e8:7a4e]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::84b1:861:46e8:7a4e%4]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 13:51:06 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     "Andrew F. Davis" <afd@ti.com>,
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
Thread-Index: AQHVZOOF+0BJBq1hEUK86gknnLECMKczS0sAgAfTZICAF6gMgIAADdeAgAc/QoCAA7QPgIABrHYAgAAEJoCAABjGgIAA2T6AgACS/YCAAAI7AIAAAj6AgAE6D4CAAtsXgIAB3pmA
Date:   Tue, 22 Oct 2019 13:51:05 +0000
Message-ID: <20191022135105.GA7518@arm.com>
References: <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
 <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
 <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
 <20191018184123.GA10634@arm.com>
 <CALAqxLXzOjyD1MpGeuZKLz+RNz1Utd8QpbvtSOodeqT-gCu6kA@mail.gmail.com>
 <20191018185723.GA27993@arm.com>
 <2c60496c-d536-05e7-bbf6-ca718b8142bd@ti.com>
 <20191021091806.v2buuugck5maxah5@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191021091806.v2buuugck5maxah5@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a30d6c6-b5df-4115-4b85-08d756f6ea9e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5349:|AM7PR08MB5349:|AM0PR08MB3202:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB32025468B5B832B2A2B23C5FE4680@AM0PR08MB3202.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01986AE76B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(14454004)(6512007)(81156014)(99286004)(478600001)(256004)(8676002)(81166006)(6636002)(76176011)(14444005)(52116002)(71200400001)(71190400001)(6486002)(25786009)(6436002)(476003)(2906002)(11346002)(26005)(8936002)(54906003)(486006)(7736002)(446003)(2616005)(1076003)(86362001)(4326008)(44832011)(6862004)(6246003)(305945005)(102836004)(186003)(7416002)(6506007)(386003)(5660300002)(53546011)(229853002)(316002)(561944003)(66446008)(64756008)(66556008)(66476007)(6116002)(33656002)(37006003)(66946007)(3846002)(36756003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5349;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0Cee1stLAKypen2mRMXEp/B4ebj5lQIXdRjNnBVQKlqr8tulXmYmhkSPibfABLTQSoLO1IQPx84LzCQlHh55xFrtRS6ZxQpHVadNTZqrCA/oSkz7hKgKUj4/NoKTNHKNtmBVcZ39RNOUudSBUbxSYsH43JbbiYeh6iguQYqhH3QQtbcwkl3UUBrbO/ihtuNslFjUxa+ztPEqjz73wXEV1dBDkC3Jwk5wohSUftmkJjcFBzohwg4hbq9XnsBJZd1ub7tVQvZIwAwXcCrxlQJXbT6fQBwpoHc0Vi160hldIKHHg17pVP0+zqpOb3ax/ZIeqR3HhOJNpXzawi+tLdQLmda18snCJs5B50o+92AXC2JVm+iQxvkbkcaoU8a+AYB4fK0rH+VfEpDPcdEsERxNYb3DMXnc0AbphVB+GQ8DyvEj1TC83ptMzxoQSnBWpmK+
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2880F88B2E4DD347A7C1285C32C5B3A3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5349
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(46406003)(2906002)(336012)(305945005)(6246003)(6116002)(186003)(86362001)(66066001)(476003)(23726003)(3846002)(126002)(6862004)(36756003)(107886003)(37006003)(54906003)(63350400001)(4326008)(47776003)(76176011)(11346002)(5660300002)(316002)(7736002)(70586007)(25786009)(70206006)(446003)(2616005)(6636002)(81166006)(50466002)(14444005)(81156014)(8746002)(356004)(229853002)(478600001)(26826003)(6506007)(561944003)(6486002)(8936002)(22756006)(99286004)(33656002)(8676002)(486006)(386003)(6512007)(76130400001)(26005)(97756001)(53546011)(1076003)(102836004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3202;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d8e75423-87fb-4903-6c72-08d756f6e27e
NoDisclaimer: True
X-Forefront-PRVS: 01986AE76B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2WiBbs+s5XBWzA3KQG4/cgl2+2lhKqteXMfoY88yoRz5WXUK974CCsf3FVb7GIJFDXnTEuJ3f0eBkrU4Xjz233zqzXpNk/AzpPTjcKOYM4ij+XsWQT0j/8Z5iVGkDaX9pSmh+20F9A2kONvcqzY6fs4kq1oZAeaZ5GMOZhcbVQA1PiLc53fsvJHIf9wvH7asYzPTuk7SV5JUepY0rLxzCaR4lkv24YRVfG4aIKW3Qo3PANZkOaQhjknhxWSQP8MEfAPbthUpKkOSt2yxxi4p0HNvaOcXEOpeKIPzRZfc+Xba5uAGpnotWEdpMP/CVfStpIt56N0UrAk7c6GXE5aEp1FLafPgESmpXmk66/rGZpehtT3iJrXM+qnBiQlCIvxJiasPs9iuHL5/29nVZCw1+TtodWwgrEzffMNSyvsY5KmMJ+gH5ZsQqNGYcK88Y9v
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 13:51:19.3870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a30d6c6-b5df-4115-4b85-08d756f6ea9e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:18:07AM +0000, Brian Starkey wrote:
> On Sat, Oct 19, 2019 at 09:41:27AM -0400, Andrew F. Davis wrote:
> > On 10/18/19 2:57 PM, Ayan Halder wrote:
> > > On Fri, Oct 18, 2019 at 11:49:22AM -0700, John Stultz wrote:
> > >> On Fri, Oct 18, 2019 at 11:41 AM Ayan Halder <Ayan.Halder@arm.com> w=
rote:
> > >>> On Fri, Oct 18, 2019 at 09:55:17AM +0000, Brian Starkey wrote:
> > >>>> On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
> > >>>>> On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wro=
te:
> > >>>>>> On 10/17/19 3:14 PM, John Stultz wrote:
> > >>>>>>> But if the objection stands, do you have a proposal for an alte=
rnative
> > >>>>>>> way to enumerate a subset of CMA heaps?
> > >>>>>>>
> > >>>>>> When in staging ION had to reach into the CMA framework as the o=
ther
> > >>>>>> direction would not be allowed, so cma_for_each_area() was added=
. If
> > >>>>>> DMA-BUF heaps is not in staging then we can do the opposite, and=
 have
> > >>>>>> the CMA framework register heaps itself using our framework. Tha=
t way
> > >>>>>> the CMA system could decide what areas to export or not (maybe b=
ased on
> > >>>>>> a DT property or similar).
> > >>>>>
> > >>>>> Ok. Though the CMA core doesn't have much sense of DT details eit=
her,
> > >>>>> so it would probably have to be done in the reserved_mem logic, w=
hich
> > >>>>> doesn't feel right to me.
> > >>>>>
> > >>>>> I'd probably guess we should have some sort of dt binding to desc=
ribe
> > >>>>> a dmabuf cma heap and from that node link to a CMA node via a
> > >>>>> memory-region phandle. Along with maybe the default heap as well?=
 Not
> > >>>>> eager to get into another binding review cycle, and I'm not sure =
what
> > >>>>> non-DT systems will do yet, but I'll take a shot at it and iterat=
e.
> > >>>>>
> > >>>>>> The end result is the same so we can make this change later (it =
has to
> > >>>>>> come after DMA-BUF heaps is in anyway).
> > >>>>>
> > >>>>> Well, I'm hesitant to merge code that exposes all the CMA heaps a=
nd
> > >>>>> then add patches that becomes more selective, should anyone depen=
d on
> > >>>>> the initial behavior. :/
> > >>>>
> > >>>> How about only auto-adding the system default CMA region (cma->nam=
e =3D=3D
> > >>>> "reserved")?
> > >>>>
> > >>>> And/or the CMA auto-add could be behind a config option? It seems =
a
> > >>>> shame to further delay this, and the CMA heap itself really is use=
ful.
> > >>>>
> > >>> A bit of a detour, comming back to the issue why the following node
> > >>> was not getting detected by the dma-buf heaps framework.
> > >>>
> > >>>         reserved-memory {
> > >>>                 #address-cells =3D <2>;
> > >>>                 #size-cells =3D <2>;
> > >>>                 ranges;
> > >>>
> > >>>                 display_reserved: framebuffer@60000000 {
> > >>>                         compatible =3D "shared-dma-pool";
> > >>>                         linux,cma-default;
> > >>>                         reusable; <<<<<<<<<<<<-----------This was m=
issing in our
> > >>> earlier node
> > >>>                         reg =3D <0 0x60000000 0 0x08000000>;
> > >>>                 };
> > >>
> > >> Right. It has to be a CMA region for us to expose it from the cma he=
ap.
> > >>
> > >>
> > >>> With 'reusable', rmem_cma_setup() succeeds , but the kernel crashes=
 as follows :-
> > >>>
> > >>> [    0.450562] WARNING: CPU: 2 PID: 1 at mm/cma.c:110 cma_init_rese=
rved_areas+0xec/0x22c
> > >>
> > >> Is the value 0x60000000 you're using something you just guessed at? =
It
> > >> seems like the warning here is saying the pfn calculated from the ba=
se
> > >> address isn't valid.
> > > It is a valid memory region we use to allocate framebuffers.
> >=20
> >=20
> > But does it have a valid kernel virtual mapping? Most ARM systems (just
> > assuming you are working on ARM :)) that I'm familiar with have the DRA=
M
> > space starting at 0x80000000 and so don't start having valid pfns until
> > that point. Is this address you are reserving an SRAM?
> >=20
>=20
> Yeah, I think you've got it.
>=20
> This region is DRAM on an FPGA expansion tile, but as you have noticed
> its "below" the start of main RAM, and I expect it's not in any of the
> declared /memory/ nodes.
>=20
> When "reusable" isn't there, I think we'll end up going the coherent.c
> route, with dma_init_coherent_memory() setting up some pages.
>=20
> If "reusable" is there, then I think we'll end up in contiguous.c and
> that expects us to already have pages.
>=20
> So, @Ayan, you could perhaps try adding this region as a /memory/ node
> as-well, which should mean the kernel sets up some pages for it as
> normal memory. But, I have some ancient recollection that the arm64
> kernel couldn't handle system RAM at addresses below 0x80000000 or
> something. That might be different now, I'm talking about several
> years ago.
>
Thanks a lot for your suggestions.

I added the following node in the dts.

       memory@60000000 {
               device_type =3D "memory";
               reg =3D <0 0x60000000 0 0x08000000>;
       };

And kept the 'reusable' property in
        display_reserved:framebuffer@60000000 {...};

Now the kernel boots fine. I am able to get
/dev/dma_heap/framebuffer\@60000000 . :)

> Thanks,
> -Brian
>=20
> > Andrew
> >=20
> >=20
> > >>
> > >> thanks
> > >> -john
