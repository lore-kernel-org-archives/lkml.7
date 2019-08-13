Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106DF206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="irMxefLC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="irMxefLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfHMOFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:05:12 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:25420
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729435AbfHMOFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vLk9AtWwNFzBHxzwhCrC14Lwh9uUx56lA5pGpSAJVI=;
 b=irMxefLC7OUYqynZGpd2zRGlmpce3XIVFVvaQKlOb77epgsasYfhSxWoUvLPBC7rWc7QEvioZ2jr9z1ADHK73iZmBj1ZuvINyjDSoaMo9r6KZkvxssIjOHDaZRIQiBPRuROLaBFbSLxQcBrbLwmEBbtcTS0mfqMUiNck3Eg3AlQ=
Received: from VI1PR08CA0176.eurprd08.prod.outlook.com (2603:10a6:800:d1::30)
 by AM6PR08MB4952.eurprd08.prod.outlook.com (2603:10a6:20b:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.20; Tue, 13 Aug
 2019 14:05:05 +0000
Received: from VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0176.outlook.office365.com
 (2603:10a6:800:d1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Tue, 13 Aug 2019 14:05:05 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT028.mail.protection.outlook.com (10.152.18.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.18 via Frontend Transport; Tue, 13 Aug 2019 14:05:03 +0000
Received: ("Tessian outbound a1fd2c3cfdb0:v26"); Tue, 13 Aug 2019 14:05:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bd824af295dc71e5
X-CR-MTA-TID: 64aa7808
Received: from bd4cb8a1f8c9.2 (cr-mta-lb-1.cr-mta-net [104.47.8.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A377E8B0-1233-454E-95A0-12427C3ABE1E.1;
        Tue, 13 Aug 2019 14:04:55 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bd4cb8a1f8c9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 13 Aug 2019 14:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMeye8J69U4GWfr7Vhk78tUAVnOnK3bep/oTkbe6DQ4klDmmhYsf6mBiFkwnsUDIvfkTSvYiw+65m8H4BSIzG/qQOfNwRP7agKIms8JDYDNi/aB9I0bxxBBLeg99jkg6y2iwrMqRZvMaVntQblgSbCfXAeqHKxDz/V3YVctffkucmtU8e0Mw5xOF/MO2ADnQ8DVyMD9dhMFAequGGUyg1O2VBzaA0S/R7ZDZSmYZQJ69cayT0eEasp67mrd0DzPHPhlgmt5EknFU/V+4RreMwhxa8aIoRvTYV+LRVD2Zca8QLc7IWfJIoEJXuqqJbB/QMomRlYUvfmBMW5IqzswsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vLk9AtWwNFzBHxzwhCrC14Lwh9uUx56lA5pGpSAJVI=;
 b=FCLnL+1fTT8wrEkJJNqN/Krd8n9MWDRSn1S8O2/pCUu4AQGxf+cnWs+OSV09CDbjVIHLzVskoqcvouFFvbkAYAnbGSL+NgAzAk2G9hFUXzLKGa0QgaBCFgWFGCL4mCf5m9LS9ns/NSbwj+y1D4JUZRkXEwjKBC3AXdoE3UjcOyhiP87Z1lgkpQdQCG4jzRV/vevBH1LFvPd0d48zQSKA0RzYBFdibb3Rx0sloT1CipWZxfeVi1/FnTC5ASI26c6D8i4KQ9oSDNAM+ISKy+M2UMWbdnOLT4MQCk7y1hO1pGY3yOz9FV2yKTQHFdmqVLNW3dWNp8u8WKkpSA3QL65roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vLk9AtWwNFzBHxzwhCrC14Lwh9uUx56lA5pGpSAJVI=;
 b=irMxefLC7OUYqynZGpd2zRGlmpce3XIVFVvaQKlOb77epgsasYfhSxWoUvLPBC7rWc7QEvioZ2jr9z1ADHK73iZmBj1ZuvINyjDSoaMo9r6KZkvxssIjOHDaZRIQiBPRuROLaBFbSLxQcBrbLwmEBbtcTS0mfqMUiNck3Eg3AlQ=
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) by
 DB8PR08MB5323.eurprd08.prod.outlook.com (10.255.185.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 14:04:54 +0000
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::f558:a6c5:f71c:491]) by DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::f558:a6c5:f71c:491%5]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 14:04:54 +0000
From:   Steve Capper <Steve.Capper@arm.com>
To:     Will Deacon <will@kernel.org>
CC:     Qian Cai <cai@lca.pw>, Catalin Marinas <Catalin.Marinas@arm.com>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: "arm64/for-next/core" causes boot panic
Thread-Topic: "arm64/for-next/core" causes boot panic
Thread-Index: AQHVUVgl/V1eSqMRPUyufGDCtItMGqb4yNmAgAAgpgCAABL2AIAAIQEA
Date:   Tue, 13 Aug 2019 14:04:54 +0000
Message-ID: <20190813140451.GA24579@capper-ampere.manchester.arm.com>
References: <1565646695.8572.6.camel@lca.pw>
 <20190813090200.h2rz4xphgnb5j5bc@willie-the-truck>
 <20190813105852.ovk5gtzddwlsm4ly@willie-the-truck>
 <20190813120643.25y5px4andu6cfwp@willie-the-truck>
In-Reply-To: <20190813120643.25y5px4andu6cfwp@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: LO2P265CA0384.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::36) To DB8PR08MB4105.eurprd08.prod.outlook.com
 (2603:10a6:10:b0::12)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 774b6f02-0f9d-4789-94f4-08d71ff73d36
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR08MB5323;
X-MS-TrafficTypeDiagnostic: DB8PR08MB5323:|AM6PR08MB4952:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4952CF1A0A0A6C954BD34DCC81D20@AM6PR08MB4952.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(189003)(199004)(229853002)(6246003)(26005)(76176011)(102836004)(11346002)(53936002)(446003)(6916009)(52116002)(386003)(6506007)(486006)(44832011)(14454004)(476003)(66066001)(81166006)(81156014)(478600001)(8676002)(4326008)(6436002)(6486002)(256004)(6116002)(316002)(2906002)(71200400001)(1076003)(58126008)(71190400001)(5660300002)(6512007)(8936002)(305945005)(54906003)(186003)(33656002)(86362001)(64756008)(66446008)(66946007)(66476007)(99286004)(7736002)(25786009)(3846002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5323;H:DB8PR08MB4105.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: BzASKppWwbJh0SqsW25L0/ttEAd2UWBoMkk/hlENXjtbM7IydycQyVUitq9q0ev6O612jD5DRWYTi6K5wxIyYpNN4WBLvUCDCdQsEOb2G1m9GuKyVFoJ8d1stVXTJJyDrEThRMBuPvayeSZ6fxqwJBHO7ldAZfW3Elmcq585s+KP6AD5uFyFpclXdvoP9FvMxBjO3NSYKs1AmWuq76dG83R7cS9UOiIEZjylIqaWly0Gnauh33t5F61XdSbRYSSp+lfrhuHR2wZRoRY7Do7yBJz2EAnrcD9I5bM/nAIcKdHk1OQTCkpatK2qgLLFd55OICGKGVaizPYAm1X/YjGpWlhPabq+5Km3Lj5SkF1CDA72+POzt2l3yegegzDvlhjNH0hR16KU6DEISSl7KhaTq/wifZcVgogVGKDOiaYm8sY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0AEF819D177F3A4E9D18A324B2CFC708@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5323
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(199004)(189003)(36906005)(356004)(305945005)(1076003)(5660300002)(76130400001)(33656002)(86362001)(99286004)(6512007)(316002)(97756001)(54906003)(58126008)(7736002)(8746002)(6486002)(8936002)(126002)(25786009)(46406003)(8676002)(2906002)(4326008)(6862004)(70206006)(186003)(336012)(81156014)(63350400001)(446003)(11346002)(63370400001)(50466002)(476003)(486006)(26005)(76176011)(6506007)(102836004)(14454004)(386003)(6116002)(229853002)(81166006)(70586007)(3846002)(6246003)(478600001)(26826003)(47776003)(66066001)(22756006)(23726003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4952;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5d9165b1-339e-4f82-eaef-08d71ff73729
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR08MB4952;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: VOTlmhTKHm8niILG4lh09LewromLjpuaGkYSZME2/nA6cheGJLq9cIGiNLcxBO4pX9p5sSNwtecwqb9ryPLWuAjyIBCjNW9eUYhkfUNevfEEsFj5EkrgTJl2YhfTNJPiOxB9uP+wHOzb25eGWWq9wOg1wyvbKpsr3fnnkMSNfFCaIzX6vQlwOozkAyOfnOtZpAwPBkQhP2L+fSTrod3BLPFGRmEsMq1aZprpa/vNVzrPxEdv3yKB79JlHUs+8D4sfExIMmWsx8qyKG685Ju7cns09hwdJvA92c4ftrOmmFgGy61oWWwpf7r0UZDe0s+7Pzr6iNYFKfdFtoBir0h5ssZ65uOYujHJ5Ll/KIQkwrjIiAZ1OmEeroMK0esiN5jMo9fnhowPYD+tea/D3Gw7pscySY/7s/HW6O7M1qfI/MU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 14:05:03.9253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 774b6f02-0f9d-4789-94f4-08d71ff73d36
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, Aug 13, 2019 at 01:06:44PM +0100, Will Deacon wrote:
> [+Steve]
>=20
> On Tue, Aug 13, 2019 at 11:58:52AM +0100, Will Deacon wrote:
> > On Tue, Aug 13, 2019 at 10:02:01AM +0100, Will Deacon wrote:
> > > On Mon, Aug 12, 2019 at 05:51:35PM -0400, Qian Cai wrote:
> > > > Booting today's linux-next on an arm64 server triggers a panic with
> > > > CONFIG_KASAN_SW_TAGS=3Dy pointing to this line,
> > >=20
> > > Is this the only change on top of defconfig? If not, please can you s=
hare
> > > your full .config?
> > >=20
> > > > kfree()->virt_to_head_page()->compound_head()
> > > >=20
> > > > unsigned long head =3D READ_ONCE(page->compound_head);
> > > >=20
> > > > The bisect so far indicates one of those could be bad,
> > >=20
> > > I guess that means the issue is reproducible on the arm64 for-next/co=
re
> > > branch. Once I have your .config, I'll give it a go.
> >=20
> > FWIW, I've managed to reproduce this using defconfig + SW_TAGS on
> > for-next/core, so I'll keep investigating.

I've installed clang-8 and enabled CONFIG_KASAN_SW_TAGS and was able to
reproduce the problem quite rapidly. Many apologies for missing this
before in my testing.

>=20
> Right, hacky diff below seems to resolve this, so I'll split this up into
> some proper patches as there is more than one bug here.
>=20
> Thanks,
>=20
> Will
>=20
> --->8
>=20
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/mem=
ory.h
FWIW, this fixed the crashes I experienced, I'll run some additional
tests.

Cheers,
--=20
Steve
