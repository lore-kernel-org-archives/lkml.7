Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CDBC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69DD208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="a/oW8uBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFNAYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:24:10 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:9298
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfFNAYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAImgzXnowv6qDhqtjF71NCMmyzHuhDMrZiDcAdDS44=;
 b=a/oW8uBQB1y3cJMNZOZdFMpTw65gCxejE6t7g+GQEdfiSVYl1g8e8O5bHmyvzR8MZ92W7Mmg4v5Oc4coEY3Q4BrvBplxJWJ6MjIbCpx6OaxRXpxCgRflLiNiy0z8dnm0tP+93f3cg0vF5uKtJHuApzN0nnJsFquSZRVE0sdmPAM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4320.eurprd05.prod.outlook.com (52.133.12.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 00:24:05 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 00:24:05 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/nouveau/dmem: missing mutex_lock in error path
Thread-Topic: [PATCH] drm/nouveau/dmem: missing mutex_lock in error path
Thread-Index: AQHVIkXN8eYXmKvfbEike7oriK2vlaaaSl+A
Date:   Fri, 14 Jun 2019 00:24:04 +0000
Message-ID: <20190614002359.GI22062@mellanox.com>
References: <20190614001121.23950-1-rcampbell@nvidia.com>
In-Reply-To: <20190614001121.23950-1-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bb8361b-ff68-4286-7658-08d6f05e9b95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4320;
x-ms-traffictypediagnostic: VI1PR05MB4320:
x-microsoft-antispam-prvs: <VI1PR05MB4320DD8E3FB7FDC1A1C21F98CFEE0@VI1PR05MB4320.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(366004)(39860400002)(199004)(189003)(6506007)(386003)(68736007)(305945005)(54906003)(8936002)(86362001)(81166006)(81156014)(25786009)(8676002)(2906002)(102836004)(7736002)(26005)(186003)(4326008)(3846002)(6116002)(486006)(478600001)(6246003)(6916009)(446003)(11346002)(53936002)(1076003)(76176011)(476003)(2616005)(6436002)(6512007)(52116002)(99286004)(14454004)(64756008)(66556008)(66446008)(66476007)(5660300002)(316002)(73956011)(6486002)(66946007)(71190400001)(71200400001)(33656002)(4744005)(66066001)(229853002)(36756003)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4320;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OH4rhpR5cFF4RnjFeJHTsT/RtqndUbX2mQZUNK2YZeLkTeXw2JdfEoDUDFNkchTzWJxAbjI8Ihv2SjWcNQ0+xjahfkTPm3W3JL2UlSE1+7dRxv5r12z7wySspEoqd3dyLlF33mZI8D1a4hOJ0D7iZ12wvQdEe1va21K8F53LxuNzKWFnx13TOOKvCDhMibYwlRWtNOA593YlS91DjVPjKjCsM4Lyagvz2vRjndxjSTG6K4F/Fz2qe38uDpVaFfTkoqLXQTopAUV2Snyqe3VbZlPTHDkuX6Mt0+X5/9BAjrqKC3Cuoorc65sGvTZ0dH6PGyy6z+MzHW5VTwZocCRE7jDgFdqvY880t071cAhndTqUxdunJ+XKXTcgY89wrGOmy1UCmLBBRwaefWHgNF1bxjIYfZzKiASkzYLVGh4vydM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <563E69CBF7DBDB4381F3D484B873273B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb8361b-ff68-4286-7658-08d6f05e9b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 00:24:04.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 05:11:21PM -0700, Ralph Campbell wrote:
> In nouveau_dmem_pages_alloc(), the drm->dmem->mutex is unlocked before
> calling nouveau_dmem_chunk_alloc().
> Reacquire the lock before continuing to the next page.
>=20
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>=20
> I found this while testing Jason Gunthorpe's hmm tree but this is
> independant of those changes. I guess it could go through
> David Airlie's tree for nouveau or Jason's tree.

This seems like a bad enough bug to send it into -rc?

It probably should go through the normal nouveau channels, thanks

Jason
