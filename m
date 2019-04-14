Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE32C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 06:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB9920850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 06:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="JkxzeHl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfDNG5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 02:57:18 -0400
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:49799
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbfDNG5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 02:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhqNQ+1Z1kahGIO+uyaV8/ry/9Z5ItZXH4kcRtyofX4=;
 b=JkxzeHl1nzpwPZizacrOXtC5oMsyqd5/cfH8lYZFmC5LTJrzxEHeXiLNXgC9FkS15j4d2f6QenG/vGvi+hFQ7O9S0t46JVv2fgMnudFz5Wmnl+X+oDqaSQKG91oMQ+3A9PiQXYQqQZPDO0fda1pYs0WXH0suOQ9aUX0egBFOwys=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2584.eurprd05.prod.outlook.com (10.168.74.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Sun, 14 Apr 2019 06:57:12 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::6ca8:55cc:a7c3:e214]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::6ca8:55cc:a7c3:e214%11]) with mapi id 15.20.1771.021; Sun, 14 Apr
 2019 06:57:12 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     "jglisse@redhat.com" <jglisse@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: kconfig split HMM address space mirroring from
 device memory
Thread-Topic: [PATCH] mm/hmm: kconfig split HMM address space mirroring from
 device memory
Thread-Index: AQHU8JDkrzI6G0Gpw0yAwni5wA6t66Y7PWyA
Date:   Sun, 14 Apr 2019 06:57:12 +0000
Message-ID: <20190414065709.GH3201@mtr-leonro.mtl.com>
References: <20190411180326.18958-1-jglisse@redhat.com>
In-Reply-To: <20190411180326.18958-1-jglisse@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0057.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::34) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d850f72-b763-42e9-7e05-08d6c0a66b94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0501MB2584;
x-ms-traffictypediagnostic: DB6PR0501MB2584:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB6PR0501MB2584F6D3A48A2D41769D88ECB02A0@DB6PR0501MB2584.eurprd05.prod.outlook.com>
x-forefront-prvs: 00073DB75F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39850400004)(136003)(376002)(199004)(189003)(6916009)(54906003)(186003)(229853002)(26005)(1076003)(2351001)(476003)(8676002)(99286004)(966005)(97736004)(71200400001)(71190400001)(486006)(8936002)(316002)(81166006)(86362001)(446003)(105586002)(1730700003)(4326008)(6116002)(33656002)(106356001)(66066001)(305945005)(81156014)(256004)(6246003)(5660300002)(5640700003)(3846002)(102836004)(52116002)(6506007)(386003)(2501003)(9686003)(478600001)(6512007)(7736002)(11346002)(53936002)(76176011)(4744005)(2906002)(14454004)(6486002)(6306002)(6436002)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2584;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ggm67+okBOKDBVNC8n3ekiLvs8SHaI2cKQ4FnIebO81391dbej6wB05PZI0qmWFDBbAoM8yKUFYoCYrWZP1fkxCXx2JgWokypALopkrS06fPTxZYe/gAF2VupPZiZf4m6Zu2hp0HZiI5LzOs9qwn2UdZM1YA6gkNPSfpjTjwhkdvnWKyf2tjZpnF1itpGO4FE7yXXzn/CXfI7KakMHiR6676PIaHy16jqHGyQtfFYvBvsBJHfrDtvG/7BUviZVmEuVvOW0EcNKv9byfiDQ6IFOKBdiqwaR6jzxsnmuUy12v39ajfCQ6pv+3jnHUmxHRa8nvGjkelEOKYGT+1TG6zDvlb6BRNaPbd6b/dnbxlnnZG7Z8WZKsRj+4cBLEuTeKlG6fOow2vuIcaHjmYoKe4ID/LUOdDTL7E+0MF/VhNYPY=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E8288B126A81F146A172D7ABA61B34D6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d850f72-b763-42e9-7e05-08d6c0a66b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2019 06:57:12.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 02:03:26PM -0400, jglisse@redhat.com wrote:
> From: J=E9r=F4me Glisse <jglisse@redhat.com>
>
> To allow building device driver that only care about address space
> mirroring (like RDMA ODP) on platform that do not have all the pre-
> requisite for HMM device memory (like ZONE_DEVICE on ARM) split the
> HMM_MIRROR option dependency from the HMM_DEVICE dependency.
>
> Signed-off-by: J=E9r=F4me Glisse <jglisse@redhat.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/Kconfig | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>

Thanks,

It gave me an option simply enable HMM_MIRROR without too much hassle as
it was before and compile your v3 [1].

Tested-by: Leon Romanovsky <leonro@mellanox.com>

[1] https://patchwork.kernel.org/patch/10894281/
