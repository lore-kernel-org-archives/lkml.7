Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C2DC0651D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E85021850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="VQMwoiLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfGDMmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:42:20 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:25870
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727114AbfGDMmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9shR01KTqUYyl0aF1B8mufrpg694KSJIBErGdxzPYSo=;
 b=VQMwoiLvK3LzEfUER7euvkeAEqebGIyCjYFSgwNyJev6RXX9zk+nZbKBq48b1cZDk+xuG5AQ4mT5GuayWQKmtFMw4vs1ceux9hsOW2MH9kyA9tAjgpV2ohL4MqkgCcJCWMf6BuZi3+/9Tyn894uXWkMoeCFi+3ZHN5Eku9DalhE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6446.eurprd05.prod.outlook.com (20.179.28.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 12:42:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 12:42:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lianbo Jiang <lijiang@redhat.com>,
        Borislav Petkov <bp@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the hmm tree with the tip tree
Thread-Topic: linux-next: manual merge of the hmm tree with the tip tree
Thread-Index: AQHVMkdudqFPmulNwkKTbLz5IeYAFKa6Zz4A
Date:   Thu, 4 Jul 2019 12:42:16 +0000
Message-ID: <20190704124212.GH3401@mellanox.com>
References: <20190704190352.417a34d1@canb.auug.org.au>
In-Reply-To: <20190704190352.417a34d1@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:208:a8::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 497b0afd-5955-46ce-2a10-08d7007d0b8f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6446;
x-ms-traffictypediagnostic: VI1PR05MB6446:
x-microsoft-antispam-prvs: <VI1PR05MB644624A0D7F9388D079A3459CFFA0@VI1PR05MB6446.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(53754006)(68736007)(66946007)(6116002)(476003)(3846002)(36756003)(478600001)(256004)(1076003)(486006)(2616005)(66476007)(66066001)(66556008)(64756008)(8676002)(66446008)(33656002)(2906002)(73956011)(6486002)(71200400001)(7416002)(102836004)(86362001)(54906003)(53936002)(229853002)(4326008)(71190400001)(446003)(305945005)(316002)(6436002)(6506007)(386003)(186003)(5660300002)(6916009)(52116002)(14454004)(6512007)(99286004)(7736002)(81166006)(8936002)(26005)(6246003)(76176011)(11346002)(81156014)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6446;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: preLu1Qvwrlp5KTjJ9uO642pYwIO47rYVrHFOnMaKgcg8YmuFN66lcV5NlFC+1fwv/dti6V6P2CclgqkMl51huwc1JN+H2LjPw/VvVTDTJvicMGLRmhpZz+l4haE/FyoJjfcRqYn1NZJ0twQpLV8acbPwMB0WLomGYEggO1IcVwt31z+Gun0+D0o2i/zQ1tN852JFW2I7Xpg4dCkkn8KNTYv7f8snmjNR2D+N9efySeemmZyQCf+w68lqVXsuMGCjvBPH2rbtLFp9MrLkQBLHRgcr4bR+ruiNnzQwO+q/RFeEzCY2DVj+8ddMwtLLZcrzGMlIutmD/1JwB3jmDVaCKIn/qQF0U+3UWGR2aCuNzpyGJnuSbU4jcv+JiEp82SjMTSwRWtg1c8qsumR+SacvJMbtRA1hV+kT+ibW0WBtS0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D54A46D8B66EA4387EAE9BD499FD66C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497b0afd-5955-46ce-2a10-08d7007d0b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 12:42:16.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 07:03:52PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the hmm tree got a conflict in:
>=20
>   include/linux/ioport.h
>=20
> between commit:
>=20
>   ae9e13d621d6 ("x86/e820, ioport: Add a new I/O resource descriptor IORE=
S_DESC_RESERVED")
>   5da04cc86d12 ("x86/mm: Rework ioremap resource mapping determination")
>=20
> from the tip tree and commit:
>=20
>   25b2995a35b6 ("mm: remove MEMORY_DEVICE_PUBLIC support")
>=20
> from the hmm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc include/linux/ioport.h
> index 5db386cfc2d4,a02b290ca08a..000000000000
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@@ -133,16 -132,6 +133,15 @@@ enum=20
>   	IORES_DESC_PERSISTENT_MEMORY		=3D 4,
>   	IORES_DESC_PERSISTENT_MEMORY_LEGACY	=3D 5,
>   	IORES_DESC_DEVICE_PRIVATE_MEMORY	=3D 6,
> - 	IORES_DESC_DEVICE_PUBLIC_MEMORY		=3D 7,
> - 	IORES_DESC_RESERVED			=3D 8,
> ++	IORES_DESC_RESERVED			=3D 7,
>  +};
>  +
>  +/*
>  + * Flags controlling ioremap() behavior.
>  + */
>  +enum {
>  +	IORES_MAP_SYSTEM_RAM		=3D BIT(0),
>  +	IORES_MAP_ENCRYPTED		=3D BIT(1),
>   };
>  =20
>   /* helpers to define resources */

Looks OK to me, thanks

Jason
