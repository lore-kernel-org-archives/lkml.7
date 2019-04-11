Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D012082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Uc+A9had"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDKRtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:49:33 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:30884
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbfDKRtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6k5iUR9VypqVahkX4FvGSzYKWYbiAHE/Ybb8K1vEEE=;
 b=Uc+A9hadv7wV0pBgTYo949qMzwOajR4ykZGOYK2/zvAIxtLlzuYc9VApPGlPosBtiRZ5bZOrm5xrNZw6cL78h/OcxFFMBIl/PdWhWBpQcHPaetlg7rElx+JzCU1hVVE+VBIKJElmxCnR3Ss+Ond4vB3xbSt4rRLwGzgL/ajZ5VQ=
Received: from AM0PR05MB6100.eurprd05.prod.outlook.com (20.178.119.209) by
 AM0PR05MB4532.eurprd05.prod.outlook.com (52.133.55.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Thu, 11 Apr 2019 17:49:29 +0000
Received: from AM0PR05MB6100.eurprd05.prod.outlook.com
 ([fe80::8c3:74d4:724a:9f35]) by AM0PR05MB6100.eurprd05.prod.outlook.com
 ([fe80::8c3:74d4:724a:9f35%4]) with mapi id 15.20.1792.016; Thu, 11 Apr 2019
 17:49:29 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Will Deacon <will.deacon@arm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Pavel Machek <pavel@ucw.cz>,
        Vadim Pasternak <vadimp@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bitops.h: sanitize rotate primitives
Thread-Topic: [PATCH] bitops.h: sanitize rotate primitives
Thread-Index: AQHU7+MNDQoRaJ8E+0e7bTtplwzN1aY3PggA
Date:   Thu, 11 Apr 2019 17:49:29 +0000
Message-ID: <20190411174926.GA18767@splinter>
References: <20190410211906.2190-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190410211906.2190-1-linux@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:203:69::16) To AM0PR05MB6100.eurprd05.prod.outlook.com
 (2603:10a6:208:12e::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3edd668f-fa7a-48af-1b87-08d6bea60b9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB4532;
x-ms-traffictypediagnostic: AM0PR05MB4532:
x-microsoft-antispam-prvs: <AM0PR05MB4532069CD23AFB81C55ED9F9BF2F0@AM0PR05MB4532.eurprd05.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(102836004)(33656002)(9686003)(6506007)(86362001)(6512007)(386003)(26005)(5660300002)(53936002)(71200400001)(71190400001)(186003)(33716001)(81156014)(446003)(476003)(11346002)(8676002)(81166006)(2906002)(486006)(8936002)(76176011)(14444005)(256004)(6116002)(3846002)(6916009)(6486002)(14454004)(6436002)(229853002)(106356001)(105586002)(7736002)(305945005)(52116002)(68736007)(6246003)(25786009)(316002)(54906003)(97736004)(478600001)(4326008)(66066001)(99286004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4532;H:AM0PR05MB6100.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YPno+uxjy/m7hS0RVLsKvQAYTtqIDNBLAfgWnJkdVhf1zXIK+plYgPJiRFIKbUaRe4T90fueuG5XsCTgVQG0RbeQ/CAnZ0vroeh9qtQdNDZyOEOj7zH/8ImF4u9YbzHBI0BOWBY+AWEyoWK1HrkSS3Wurxf8LtTLAQWLEWGADTPHbPii9q4gFDhc0U/luoXcvZofbLG5xuvQOQGokQxxUxpI/3n10N3UHwHK5D2mL24inHQz6XhhkDZZ6RqEH3hho9OhFsnqvY6t47vyznIeCddUuSxNePNvJzkh4VkcLIt75a4dgSNAz6iuX73SHcOruTAmxu7dFq06Ip9opEfzcN4MvyfPD4nQn2uFSW2YlCTwFChlCyjC2RUc7W0FRRoFuyHhI8l3kgOISubM+iSRWAxX9cqZePctW3FDtJkmq8I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD06B4CFB459A24EA6590266A1F3B3C2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edd668f-fa7a-48af-1b87-08d6bea60b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 17:49:29.1584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:19:06PM +0200, Rasmus Villemoes wrote:
> The ror32 implementation (word >> shift) | (word << (32 - shift) has
> undefined behaviour if shift is outside the [1, 31] range. Similarly
> for the 64 bit variants. Most callers pass a compile-time
> constant (naturally in that range), but there's an UBSAN report that
> these may actually be called with a shift count of 0.
>=20
> Instead of special-casing that, we can make them DTRT for all values
> of shift while also avoiding UB. For some reason, this was already
> partly done for rol32 (which was well-defined for [0, 31]). gcc 8
> recognizes these patterns as rotates, so for example
>=20
> __u32 rol32(__u32 word, unsigned int shift)
> {
> 	return (word << (shift & 31)) | (word >> ((-shift) & 31));
> }
>=20
> compiles to
>=20
> 0000000000000020 <rol32>:
>   20:   89 f8                   mov    %edi,%eax
>   22:   89 f1                   mov    %esi,%ecx
>   24:   d3 c0                   rol    %cl,%eax
>   26:   c3                      retq
>=20
> Older compilers unfortunately do not do as well, but this only affects
> the small minority of users that don't pass constants.
>=20
> Due to integer promotions, ro[lr]8 were already well-defined for
> shifts in [0, 8], and ro[lr]16 were mostly well-defined for shifts in
> [0, 16] (only mostly - u16 gets promoted to _signed_ int, so if bit 15
> is set, word << 16 is undefined). For consistency, update those as
> well.
>=20
> Reported-by: Ido Schimmel <idosch@mellanox.com>
> Cc: Vadim Pasternak <vadimp@mellanox.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Tested-by: Ido Schimmel <idosch@mellanox.com>

Thanks!
