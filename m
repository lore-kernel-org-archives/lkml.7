Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465FCC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E235214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XRJadQsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGINLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:11:22 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:52807
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfGINLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:11:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MddU5tcfgLI71q6MDqG63BkdBsY/xGsYYQaNAq0Yx88xMd88SHr23GFaOx8bQAat1eEAgluD1eETFYwSuBya4PPXGEqVZf11aR71Kiu9ZBCkWDrvzWmjpDRZfIOuWHOT9j8RkyL71fT1asIFyg8WTSR8mBy0qt6LXh+th9JF3yncdhsvNQvFcGe/90b8w5SLMh36vjIzcpp6vh1TY7+Ms32CFj3ClJQnVUzP5bK6705lLQJj8bqo88G03kp/P42W6D8ucUAb8wsLX0d7J5UMyQ0Q+4hqOCBaXTBiOl8uy8LWVIuckPLg0oZbuhmIr1OJWTXLS7MbVn+46gBxQoRwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1liw2Tl7zU7fv06PLAcVr9WitN7z/8VMqlXkpTrmfw=;
 b=DeFEKBx/VPWi6ygGI5MAi1TFhVD3858BCNrju12pJ3/axcHsz+qSRAqKg51ZX48jxw7O16BUAKYR2k+mHPfiINhfqwTkZLQFzDToLmsYKdKJCUxJuWTY4NiSKa68cn6KdZPy1hE3P2AS2tAqHv68wlXZzYKK/dsNEg+im3DLvYlkSiLnmYRLMlaI8FUvcwOO2ZJBm3PKcgblcbWVpSRhKsc14FdCf2gGXpjMwRzx6XELz9FnSPYUk+lykRbD0bJhWiuXSFXK92ulh3i6uYdWVczBJAW/YZbNTEZ9oeSpMOsOi+1gKpk+RGscMjeRkAIqHjQ6FCEBc8gtKle1Gum2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1liw2Tl7zU7fv06PLAcVr9WitN7z/8VMqlXkpTrmfw=;
 b=XRJadQsKRhChvjE1rlZWYt7eISZdCGS7+2WE2yDTZx/IRS8l1pD66IyJybx5zVh3NeJwHEXHd6mW26wgtwMUFuHn9ivgVlIOKvDQsf9yC6WJtFWNeocyLsxQN2yqebWdi1KCm+5HmlYaPK38rQIp3azmHfslFwOlu/YXXVrxAq8=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3252.eurprd05.prod.outlook.com (10.171.186.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Tue, 9 Jul 2019 13:11:13 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::ecbf:4002:63f2:43fb]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::ecbf:4002:63f2:43fb%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 13:11:13 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        asahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVNgam1ySKRGHBz0+LGfGH8/fuJ6bB3PCAgAAD4QCAAFsTAIAAB52A
Date:   Tue, 9 Jul 2019 13:11:13 +0000
Message-ID: <20190709131111.GR7034@mtr-leonro.mtl.com>
References: <20190709133019.25a8cd27@canb.auug.org.au>
 <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
 <20190709071758.GI7034@mtr-leonro.mtl.com>
 <20190709224356.325065d1@canb.auug.org.au>
In-Reply-To: <20190709224356.325065d1@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:206:2::35) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90912484-1c65-41e8-fdcd-08d7046eeb20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3252;
x-ms-traffictypediagnostic: AM4PR05MB3252:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM4PR05MB325200F601A1CC921BCBF312B0F10@AM4PR05MB3252.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(66946007)(73956011)(6486002)(66066001)(66476007)(66556008)(64756008)(66446008)(71190400001)(71200400001)(6436002)(229853002)(14454004)(33656002)(1076003)(2906002)(25786009)(99286004)(53936002)(52116002)(6116002)(3846002)(4326008)(7736002)(81156014)(8676002)(81166006)(6246003)(305945005)(5660300002)(9686003)(6306002)(6512007)(966005)(256004)(6916009)(186003)(76176011)(386003)(6506007)(26005)(478600001)(102836004)(486006)(476003)(4744005)(11346002)(446003)(316002)(68736007)(54906003)(86362001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3252;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xV1EVDl5jAcnKjgSQVaRXoOScjtkjQq4vyQSh3B7pPeQuO9++1f7R3emh0lRhVbjxMWe4UWDEMA1+s+78uYg6u1eFWonq0A0NogUEvVDSt8VIDv5m4TQDuU1uo3JEh4i/ESOl0wYxm0OHpnhce39bcLsFpAclqORtfYNaPhfxYxSfw5hk3Q9CqJ5/ZcjcOgU8jopF90g1ni7105Tc8v/sGJGh6koAwDOibhfAJAf8436LPEOTYck7zsDFfsGccwjBBMlf5RFOk/zg1V2sCzl8iPLoXPLHPpMwi3yZwKo1cLLeh2b1s3I4rj3VPY0pSmzvpNaRvvQ8+8HqkyseOP56JovcI6YtuzF7vwXi7fT/WLxPoKwHT2u/Pvj6jR27bEGVY5QXZsunztunlmoLKtilMBgGEWk8oy/tVUX2itUjYo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC5B24E98E65174CACBF6C660498E4E3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90912484-1c65-41e8-fdcd-08d7046eeb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 13:11:13.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:43:56PM +1000, Stephen Rothwell wrote:
> Hi Leon,
>
> On Tue, 9 Jul 2019 07:18:00 +0000 Leon Romanovsky <leonro@mellanox.com> w=
rote:
> >
> > For some reason, I wasn't in initial email report, can you please check=
 why?
>
> Sorry about that, I manually grab email addresses from SOB lines in
> commits I am reporting and managed to miss yours this time.  I might
> try to script this up.

Maybe it will help,
https://github.com/rleon/x-tools/blob/master/x-fp#L141
This is how I'm generating CC-list for patches.

Thanks

>
> --
> Cheers,
> Stephen Rothwell


