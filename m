Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907A5C4649C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6907B2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ijn2Dr1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfGEMIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:08:21 -0400
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:11013
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728062AbfGEMIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGlvA7FgqK09URYM58QpPTFUvEoaN+MgYZY1Jmr97H8=;
 b=Ijn2Dr1caO5gYyhN1Ug+bB4QcDV8TtZsKINcMcUfeGCjUtiiLBbwuAhh1mGuoe2PtoYH5l5wrR0VpVMrhE2I1UIEotSKkcY1fbnBCrCPaBavtFFQgvlfV7TDpQWXjD6HtMSJKH38pY9GMeOd6AZ24n3YogvkLK4fYkRR9+Vhduc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4237.eurprd05.prod.outlook.com (52.133.12.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 12:08:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.019; Fri, 5 Jul 2019
 12:08:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Topic: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Index: AQHVMlcIUr9ppS/jrECG60Qeg/CcSKa6auGAgAABpoCAAAePAIAAgGYAgAAnm4CAANPaAA==
Date:   Fri, 5 Jul 2019 12:08:15 +0000
Message-ID: <20190705120810.GA31525@mellanox.com>
References: <20190704205536.32740b34@canb.auug.org.au>
 <20190704125539.GL3401@mellanox.com>
 <20190704230133.1fe67031@canb.auug.org.au>
 <20190704132836.GM3401@mellanox.com>
 <20190705070810.1e01ea9d@canb.auug.org.au>
 <CAPcyv4hHC3s3nePSSHaKkFFbxuABZE3GLa7Li=0j6Z45ERrPEg@mail.gmail.com>
In-Reply-To: <CAPcyv4hHC3s3nePSSHaKkFFbxuABZE3GLa7Li=0j6Z45ERrPEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db553e17-b266-48a5-9f5a-08d7014175aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4237;
x-ms-traffictypediagnostic: VI1PR05MB4237:
x-microsoft-antispam-prvs: <VI1PR05MB4237C7941EA29F9A09E129AFCFF50@VI1PR05MB4237.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(25786009)(478600001)(54906003)(76176011)(68736007)(6512007)(102836004)(229853002)(73956011)(66556008)(99286004)(52116002)(6436002)(6506007)(386003)(66476007)(6916009)(64756008)(6246003)(66946007)(316002)(5660300002)(26005)(66446008)(6486002)(53936002)(6116002)(81156014)(446003)(11346002)(2616005)(486006)(305945005)(2906002)(36756003)(33656002)(66066001)(86362001)(4326008)(81166006)(8936002)(1076003)(3846002)(476003)(256004)(14444005)(71200400001)(71190400001)(7736002)(14454004)(4744005)(8676002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4237;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Db0uhIH5tpJ1rI2Skn5k0yK6DImvUA8DjUZVfd/etopNxVFCZVfxQfydv1k2kXNAv6j4SQAee4XlsYzUZcJ3TFgBKELXUpzWEA95kQlZwn8ZRt8cagtUl1FgBtN9GfSbNXQEmu551Zs1GvricR8bQez+etpO2Sk5fXqqOQv5Z12Q6QMQUwaovA+Re9u8Gl0LRqKMHmhJfWk42FdTYxSvbBW9lUsSa1iKPWQorqcTHxP61RswZej5cGI3MhObYD7ZNvE3DQhjpW4APC1JbUVQuVhdRuY0mS8ATHxvI2TPorBhM/3hdpKOJzC8UKmta2SFL1qqFSozPu64hiAAXKR5Z8rlDc6u/X/QwstuX4ro72Y4w2Icy1ZouzcFFOWlIZPjqY0V45+OdeLV0XR76j+XysN1QgBH8g1L0Qr4L7yFCXE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <481B889E1B2A1747B6060686C6BC8474@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db553e17-b266-48a5-9f5a-08d7014175aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 12:08:15.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 04:29:55PM -0700, Dan Williams wrote:
> Guys, Andrew has kicked the subsection patches out of -mm because of
> the merge conflicts. Can we hold off on the hmm cleanups for this
> cycle?

I agree with you we should prioritize your subsection patches over
CH's cleanup if we cannot have both.

As I said, I'll drop CH's at Andrews request, but I do not want to
make any changes without being aligned with him.

Jason
