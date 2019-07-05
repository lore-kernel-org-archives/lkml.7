Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E05AC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4F421852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="WfGwnsre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfGEPrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:47:21 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:22918
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727708AbfGEPrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxxJg4MIQ+kXyl/JgM+TzdLaXplemI/Hm2Vm6B9MMgg=;
 b=WfGwnsreFN2W6n4FYF56NOwkTFfhAVZd+oWsfT5Qq2/xWDoyXSG3m+py4VJ3TcOdHOcJHwUv4hA4GBgEVO6Ciu7ih4RDE4H9GDsJUw5ttiwWJzNJae1wQW/xh8uGJzID3UaGRWgzybPvPq4H4HHXn6k+WvHp6Xj476t+7h80V1o=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4157.eurprd05.prod.outlook.com (10.171.182.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 15:47:17 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.019; Fri, 5 Jul 2019
 15:47:17 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Thread-Topic: [PATCH v3 0/4] Devmap cleanups + arm64 support
Thread-Index: AQHVK/HAM2r3dJ5EjUuvQfApLyHQmKat3lEAgAA0MoCAAAH5AIAAxnaAgAwArgCAABJ8AIAADxQAgAAJ3QCAATLjgA==
Date:   Fri, 5 Jul 2019 15:47:16 +0000
Message-ID: <20190705154713.GF31525@mellanox.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
 <20190626073533.GA24199@infradead.org>
 <20190626123139.GB20635@lakrids.cambridge.arm.com>
 <20190626153829.GA22138@infradead.org> <20190626154532.GA3088@mellanox.com>
 <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
 <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
 <20190704195934.GA23542@mellanox.com>
 <20190704135332.234891ac6ce641bf29913d06@linux-foundation.org>
 <20190704212850.GB23542@mellanox.com>
In-Reply-To: <20190704212850.GB23542@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0037.prod.exchangelabs.com
 (2603:10b6:208:25::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bae908f3-8803-4511-a3c6-08d701600e6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4157;
x-ms-traffictypediagnostic: VI1PR05MB4157:
x-microsoft-antispam-prvs: <VI1PR05MB4157E5DC3835CEF64F122137CFF50@VI1PR05MB4157.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(66446008)(66556008)(64756008)(66476007)(66946007)(73956011)(6246003)(68736007)(36756003)(53936002)(71190400001)(71200400001)(6436002)(14444005)(256004)(11346002)(476003)(2616005)(6512007)(1076003)(5660300002)(446003)(86362001)(486006)(54906003)(386003)(7416002)(81156014)(25786009)(3846002)(6116002)(102836004)(6916009)(8676002)(14454004)(33656002)(99286004)(76176011)(229853002)(66066001)(6486002)(52116002)(6506007)(2906002)(4326008)(305945005)(316002)(81166006)(8936002)(26005)(478600001)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4157;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0/6Z+Bfs/UvVgFelpooJC+yb5+DJ55uzjAsttdFZPI8cmBLjPsYzungODysy6hjpr18R6P/3meVc8KOhdZPgJQuMVBtFQhczTA7Wdw7H4ZRKu/96B68qJD0sh0DxxBqfEeWFvkJxTJJqFKvuDMKq0wjmLja3Vm+NJ7Ouxioy3/qDjdAxJdeTQYdXC2AlwmlMXWSGB4LnDfjhwQJpmqu9KjANmkqfmxLRUwhcbufFnCWYtpUD8UXRCOIVr4szwSklgvYs1PDp6uv6Uq/qSgcPzFrFVjm007CKBefMP70suVIsSGomXML1Mb1DTvgLDHBx4NtifsL0MerLiwoBZV7m6p2ERH9Onfx+XqZ2kLG0IaW5wP9fW/iRteoSGvBkdwXs/cinq6QhFaVAiZjbVBjukBjNIY3mcqMGq/JE8lwioio=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <447BAA9C69B30443BF5B2CEE61EC6F33@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae908f3-8803-4511-a3c6-08d701600e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 15:47:16.9430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 06:28:50PM -0300, Jason Gunthorpe wrote:

> > It's a large patchset and it appears to be mainly (entirely?) code
> > cleanups.  I don't think such material would be appropriate for a late
> > -rc7 merge even if it didn't conflict with lots of other higher
> > priority pending functional changes and fixes!
>=20
> I see your other email you resolved the conflicts - so please let me
> know if you want to proceed with dropping CH's series or not, I'll
> make a special effort to get that change into tomorrows linux-next if
> you want (it is already 6pm here)

I spent some time this morning looking at the various conflicts, and I
think Dan is right, they are mangable. In the sense we can forward a
merge resolution to Linus and it is not completely crazy. Most hunks
are the usual mechanical sort of conflicts.

Like Stephen, only two small conflict hunks in the memremap.c give me
any pause, and I'm confident with CH and Dan's help it can be resolved
robustly. If Linus doesn't like it then we fall back to dropping CH's
series.

So, here is a fourth idea..

We remove hmm.git entirely from your workflow (ie you revert commit
"cc5dfd59e375f Merge branch 'hmm-devmem-cleanup.4' into rdma.git hmm"
in your local version of linux-next) and I will send hmm.git to Linus
after Dan's patches and others are merged by you to Linus. With Dan
and CH's help I will forward the reviewed conflict resolution.

This will not disturb the -mm patch workflow at all, and you can put
everything back the way it was on July 3.

What do you think about this?

Jason
