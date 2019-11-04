Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC850CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7992E20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="L4cY8HfC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="L4cY8HfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfKDRoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:44:09 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:54990
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728012AbfKDRoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcVtBvQCtFbUqgEC4H2aJKM4AdSlID3VL+7XCiA8FAg=;
 b=L4cY8HfCjZbcbpjipyn+lJ3WVCEaKG8BOANNuADG0vqbF8xuW/Czm1HhOaj2BykGMagt8sRFEWM26XMBQQWtJ8VUq8OBwj5oj9XIClqPODaPENUc7ndk4z6f0fzkk7iy2Zo74XPkORGBrN2esbCZHgldCmQIBJKHhwj+mjUi4Fk=
Received: from VI1PR0802CA0027.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::13) by AM6PR08MB4787.eurprd08.prod.outlook.com
 (2603:10a6:20b:c9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 17:43:59 +0000
Received: from DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by VI1PR0802CA0027.outlook.office365.com
 (2603:10a6:800:a9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 17:43:59 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT023.mail.protection.outlook.com (10.152.20.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Mon, 4 Nov 2019 17:43:58 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Mon, 04 Nov 2019 17:43:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dfdf986618b3fef9
X-CR-MTA-TID: 64aa7808
Received: from 29bfcbd2ad7b.2 (cr-mta-lb-1.cr-mta-net [104.47.12.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 92DA7124-E5F3-43DC-A178-6ECDE44F9952.1;
        Mon, 04 Nov 2019 17:43:52 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 29bfcbd2ad7b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 04 Nov 2019 17:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVedKjW5Ntc5maBcEMImOfwTSFE9WGCOphB1RLwceGTS8fqcUi/kJWvLo6NQCbOKj9m2M6ed/dk9fZv+aI1tZz6GLpVmlk2WIRwa5t0037UD0ZNH/iSdX0vaUQSSpmvSxz73WCl8QAqhIExoTPAqywePY96fKS2+W/1LclH3OadAZxMC7UD+32tYZuYUSe1aKAdYn16OGkKyAKo+5RVps/EiBLYr/K9rzCUfOU0Vy+Nuq/XPqdJ2MpW8fvmwUYRumhPVSHc7gksTkv61/6zeBnzTtQnHFKIgVGUr7njFxGiJ321wQHlgmy270V1Xq4/aH5wYEVUuTIe3408dyUgE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcVtBvQCtFbUqgEC4H2aJKM4AdSlID3VL+7XCiA8FAg=;
 b=l01nb1wG8AEzkNAjYcM1KJJ766sHiZNHTTZiZvz77xisrJrrDmGUBNzvL99pFEFewy5/29fHLs+SmnpKu9LoRB3IJiggXADqZCzh1QRwtCPUMgIwp617iiJtVqMhOrdZ+tNAtgMJnAyyYhjXRGF5Seumb7QUJ509VDnnbWfpHKtT9xAto2Qwe7AuE8RtDSk1FA9evPgZcdFu8BxcQG3aWGzsNeTnYGJD4rznCK4cksYluKhnSn9gjWMnbVqw7c7MMe/rQTJW0peH9m+fMJP7HnCwRC1PCfIm6aX5HrWHhOhJcSkWdTXFJ4WD0qVshIw0zwPIISeU1D2YBeUmQsJhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcVtBvQCtFbUqgEC4H2aJKM4AdSlID3VL+7XCiA8FAg=;
 b=L4cY8HfCjZbcbpjipyn+lJ3WVCEaKG8BOANNuADG0vqbF8xuW/Czm1HhOaj2BykGMagt8sRFEWM26XMBQQWtJ8VUq8OBwj5oj9XIClqPODaPENUc7ndk4z6f0fzkk7iy2Zo74XPkORGBrN2esbCZHgldCmQIBJKHhwj+mjUi4Fk=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3190.eurprd08.prod.outlook.com (52.135.164.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 17:43:51 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::6804:f05f:47c0:d9e]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::6804:f05f:47c0:d9e%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 17:43:51 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Dave Airlie <airlied@gmail.com>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
Thread-Topic: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
Thread-Index: AQHVkP1N8JZOPDbdaESLvvbvV23eEqd60gMAgABuHYCAAAywgA==
Date:   Mon, 4 Nov 2019 17:43:51 +0000
Message-ID: <20191104174341.m6hjzog2vibc3ek3@DESKTOP-E1NTVVP.localdomain>
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-2-john.stultz@linaro.org>
 <20191104102410.66wlyoln5ahlgkem@DESKTOP-E1NTVVP.localdomain>
 <CAPM=9tydXxV-6++HkkA+JX9GPWE1sN_8CGVCVn-Mwfgfzcn=hg@mail.gmail.com>
In-Reply-To: <CAPM=9tydXxV-6++HkkA+JX9GPWE1sN_8CGVCVn-Mwfgfzcn=hg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.51]
x-clientproxiedby: DM5PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:4:4b::33) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4887350d-1df5-4245-1dd3-08d7614e927e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3190:|AM6PR08MB3190:|AM6PR08MB4787:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB478743164ED1B3BA21775D50F07F0@AM6PR08MB4787.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 0211965D06
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(99286004)(66946007)(6916009)(446003)(66476007)(64756008)(66556008)(6512007)(54906003)(86362001)(6246003)(6506007)(486006)(44832011)(305945005)(71190400001)(386003)(71200400001)(478600001)(186003)(6436002)(26005)(7736002)(4326008)(2906002)(3846002)(81156014)(81166006)(14454004)(8676002)(1411001)(76176011)(14444005)(1076003)(476003)(25786009)(7416002)(9686003)(66446008)(58126008)(11346002)(316002)(8936002)(102836004)(6486002)(229853002)(52116002)(66066001)(256004)(5660300002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3190;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: k+ncSp4ZXizGB7xEPil0t4W40NpcqwECtS4c930ret+J2RvYVEMBwXMx18//tlG0ua9IbwcjkOc/8X1m0ufhyVDA/gYDfmY3bIoVlCAMVRtexqY4FfS4iHlSv1KOYPh7u28+PHvzPGNPhvmwa/TAAoamyJQ9m8XvXpNOEI+1LBeIlXFKf2Nmnf98JSxyg3iWQa5lPjgAoSGeZpXRVrVhkd02Rtc8GUklv+SQWwhYJ+1lmuT2KdbWx5JlyqFBCbdVvOKyrN8CTADOpW8SiSygnacvk/KLftZtqlHE/Gxd3qSbpqHKJOFl50i0Yf0Xyp04nKEbYBi7z/exKdq3tWl79QEmNEpiNlQQq1SSMUnCCllPJbRW5Vu4GnxAY1D1vC/ernltUqubjEqrrDWzMrB2sQXzuyiGzvO3bR4Jd7+1/LPy+hbEMo3DZPQWWN7u5ClK
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4653010D2069741BCCD1D0A03675369@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3190
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(1110001)(339900001)(189003)(199004)(54906003)(6862004)(1411001)(6246003)(336012)(102836004)(11346002)(76130400001)(476003)(1076003)(126002)(5660300002)(22756006)(14444005)(4326008)(105606002)(46406003)(446003)(66066001)(6506007)(47776003)(2906002)(7736002)(23726003)(26826003)(478600001)(25786009)(305945005)(3846002)(6116002)(186003)(386003)(76176011)(229853002)(6486002)(486006)(97756001)(8676002)(8746002)(356004)(81166006)(81156014)(8936002)(316002)(70586007)(50466002)(70206006)(99286004)(26005)(9686003)(14454004)(86362001)(6512007)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4787;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 075c4fbb-b71c-43c6-3291-08d7614e8da3
NoDisclaimer: True
X-Forefront-PRVS: 0211965D06
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9kUHrZ07hto9gaRfhT0Q05G/ngVl5GkTqHzihuA/B9yVNDFurVf81K4SKIbpx0LBEKesgw/+anKYviMMBqc5k2HZPtVV5JYk21fuD4zQQstjSqQYbGARomDuI9O0p9uaxkS1/dfeMLyBuZhx5Hn+WgFIk9C3z/svxfpCamshwH3nKpq+PcxXBDzbZSWFmZpyomyuOE+aQ/YMicTu3jat+Q7POnQ92jKCADyrSbSrYLzu9O2FbCT111L+ujFdK/+6rPSSmICEUAC5bsigqTK/HxeEXqoWLSkNxEmq66I2unfMMwC9M9g9OQEg3Z4u/Z80D21EyC45DWKXpFOctBjDcuZ3w0W4NYUlinmDpX3bgmrlKEdwkL3nGzNpe7heKv6i/tutFPFNeb3x8i2ZfKWkliQiLbHTtrhmuG5A19Os1+gFRth4Yh7WypU2ZX5wUY3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 17:43:58.8786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4887350d-1df5-4245-1dd3-08d7614e927e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, Nov 05, 2019 at 02:58:17AM +1000, Dave Airlie wrote:
> On Mon, 4 Nov 2019 at 20:24, Brian Starkey <Brian.Starkey@arm.com> wrote:
> >
> > Hi John,
> >
> > On Fri, Nov 01, 2019 at 09:42:34PM +0000, John Stultz wrote:
> > > From: "Andrew F. Davis" <afd@ti.com>
> > >
> > > This framework allows a unified userspace interface for dma-buf
> > > exporters, allowing userland to allocate specific types of memory
> > > for use in dma-buf sharing.
> > >
> > > Each heap is given its own device node, which a user can allocate
> > > a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
> > >
> > > Additionally should the interface grow in the future, we have a
> > > DMA_HEAP_IOC_GET_FEATURES ioctl which can return future feature
> > > flags.
> >
> > The userspace patch doesn't use this - and there's no indication of
> > what it's intended to allow in the future. I missed the discussion
> > about it, do you have a link?
> >
> > I thought the preferred approach was to add the new ioctl only when we
> > need it, and new userspace on old kernels will get "ENOSYS" to know
> > that the kernel doesn't support it.
>=20
> This works once, expand the interface 3 or 4 times with no features
> ioctl, and you start being hostile to userspace, which feature does
> ENOSYS mean isn't supported etc.

Sorry, perhaps I wasn't clear (or I misunderstand what you're saying
about working only once). I'm not against adding a get_features ioctl,
I just don't see why we'd add it before we have any features?

When we gain the first "feature", can't we add the get_features ioctl
then? For Future SW that knows about Future features, "ENOSYS" will
always mean "no features". If it doesn't get ENOSYS, then it can use
the ioctl to find out what features it has.

Otherwise we're adding an ioctl which doesn't do anything, based on
the assumption that in the future it _will_ do something... but we
don't know that that is yet... but we're pretty sure whatever it will
do can be described with a u64?

Why not wait until we know what we want it for, and then implement it
with an interface which we know is appropriate at that time?

>=20
> Next userspace starts to rely on kernel version, but then someone
> backports a feature, down the rabbit hole we go.
>=20

I suppose that adding the feature ioctl later would mean that it might
be possible to backport a feature without also backporting the ioctl,
depending on how the patches are split up. I think it would be pretty
hard to do accidentally though.

Thanks,
-Brian

> Be nice to userspace give them a features ioctl they can use to figure
> out in advance which of the 4 uapis the kernel supports.
>=20
> Dave.

