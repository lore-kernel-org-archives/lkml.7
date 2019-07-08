Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E301FC606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC4021670
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="OQ5V2vPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfGHOJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:09:07 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:52206
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfGHOJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHWLlOWTV5rb+bJl87/UrVVueRKAG5YzqZQQ452E6b8=;
 b=OQ5V2vPw3XGrZijBV/5ZNnCJsoqhJY2wwvXKs1oboE+aZKpYP+2dRQnB+kRaWJP1xk/Q+6UCOt+F1+SbrydKVYpooz0SH6DaYZuq9y7ci0swdj+okaEu0KRtTbFmYZ961glBP7IZBJxlr6cCizWSMWLM+COKv7rzS2MMqOwWS0c=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3311.eurprd05.prod.outlook.com (10.170.238.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 14:09:03 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 14:09:03 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bernard Metzler <bmt@zurich.ibm.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVNTnJQ7fo7962E0CZw92tCt9dBKbAwusA
Date:   Mon, 8 Jul 2019 14:09:02 +0000
Message-ID: <20190708140858.GC23966@mellanox.com>
References: <20190708130351.2141a39b@canb.auug.org.au>
In-Reply-To: <20190708130351.2141a39b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0017.prod.exchangelabs.com
 (2603:10b6:207:18::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dccafc6-e9fe-46e7-cb3d-08d703add487
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3311;
x-ms-traffictypediagnostic: VI1PR05MB3311:
x-microsoft-antispam-prvs: <VI1PR05MB3311659E74DF90DFC4D5C441CFF60@VI1PR05MB3311.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(53754006)(189003)(199004)(229853002)(68736007)(99286004)(305945005)(6116002)(33656002)(316002)(54906003)(386003)(3846002)(11346002)(4326008)(1076003)(6436002)(6486002)(53936002)(102836004)(446003)(7736002)(14444005)(256004)(110136005)(81156014)(476003)(14454004)(64756008)(478600001)(8676002)(66476007)(86362001)(6246003)(26005)(66946007)(81166006)(5660300002)(66556008)(73956011)(186003)(2616005)(66446008)(486006)(66066001)(52116002)(25786009)(6506007)(36756003)(76176011)(71190400001)(6512007)(8936002)(2906002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3311;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6A3hpSh0F6Wa97ab6AFWIedBy21uqogLmfTGHAOewAiwA5bnxlfE3R9s8MTD+d9wgK0MQBTpBgUONxgmCavGmuP6IFjEq3PJ+Te1QFFq+hov4keKdcvUqVARZu4iLBY6dRjyMHhfz38cHdWrmJLj9X289Ce9vfIBvKRMX6Ht6k80q+tq0Ob8hj+9Px3JeHom0Q747ReCcZze2i/L4+5wC8QdSaAwFIsjvdkEEZMo9KqSwckIwtjoje8Oo9OGKG3xkDLxnUMT8nA14YYx9GSYvYm/pkKiQUlcJmrDrh4F2zSg619EYM1j8etuODqua4n3zaE7925VlnU33qKSAFFoECqB2lxKWXUx4iWUXDjHFU2pmiFSAl9n9UaGJdV3GE7hm+9d1rM92z82bbOe71RRW1v3iFhQTJfGws404JSoO9I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B10E9A9134A884C865F5E3C3BB9D284@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dccafc6-e9fe-46e7-cb3d-08d703add487
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 14:09:02.8937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 01:03:51PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> In file included from include/asm-generic/percpu.h:7,
>                  from arch/x86/include/asm/percpu.h:544,
>                  from arch/x86/include/asm/preempt.h:6,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:51,
>                  from include/linux/seqlock.h:36,
>                  from include/linux/time.h:6,
>                  from include/linux/ktime.h:24,
>                  from include/linux/timer.h:6,
>                  from include/linux/netdevice.h:24,
>                  from drivers/infiniband/sw/siw/siw_main.c:8:
> include/linux/percpu-defs.h:92:33: warning: '__pcpu_unique_use_cnt' initi=
alized and declared 'extern'
>   extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;  \
>                                  ^~~~~~~~~~~~~~
> include/linux/percpu-defs.h:115:2: note: in expansion of macro 'DEFINE_PE=
R_CPU_SECTION'
>   DEFINE_PER_CPU_SECTION(type, name, "")
>   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro '=
DEFINE_PER_CPU'
>  static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
>         ^~~~~~~~~~~~~~
> include/linux/percpu-defs.h:93:26: error: redefinition of '__pcpu_unique_=
use_cnt'
>   __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;   \
>                           ^~~~~~~~~~~~~~
> include/linux/percpu-defs.h:115:2: note: in expansion of macro 'DEFINE_PE=
R_CPU_SECTION'
>   DEFINE_PER_CPU_SECTION(type, name, "")
>   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro '=
DEFINE_PER_CPU'
>  static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));

Bernard,=20

This looks like the wrong way to use DEFINE_PER_CPU these days. I'm
not sure why my compiles don't hit it, or why 0-day didn't say
something

Looking at the other atomic_t PER_CPU users they just rely on
automatic zero initialization, so this should just be:

  static DEFINE_PER_CPU(atomic_t, use_cnt);

?

Please confirm ASAP.

Jason
