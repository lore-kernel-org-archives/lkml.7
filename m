Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818B3C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F18D20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="NdFuRavX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbfGWPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:18:53 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:1664
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728591AbfGWPSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:18:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njLfxdbQ2bOWUoWIcgWED+xXVmIsiOTGy/HCHyFkA251i7DHSEhUfA2ds4SWommNXw281OdOd2GNF7kE7d4Hb4MUxSdiTz7GkXqPgrEgP4ikpSZH5vZABd+bcvmPQSMQm/syDu+s4UuTGBZj3ZiRdGcqPsw+ZHLNLtExaaq3TINRVB2EjhkKCWQtOYijQ1C7pavGE6fV319dcHjHT74S0sDB0Uuhce2Z5/3gZDDPV/MHvif6U2gcmZ+Jft8/IaRW73V1toCUT/dPvabawsztPC6oGXX2AVt9J8bGiu89kyy2gJ0InCzfuQfQ2dMfYTgF6L74X03PvuGK3iA65NAbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VENW3byoNhHMP2GFW56MvPx/nwt1jcNE3YR8qDxw4pE=;
 b=iRBQjI+bnm//M7Db3xWoKphCFaI2iMKQ9T4IxppJ9ADWRX0JdYf9OL/+vW4fUW3BYCCMAAgRfRJCaZYAbDUfvqIDFAQjzwulWND0WxsbE3LFmtPUkQ0jr3q+9dBBFp8ae+RSdOxR0zfber9jwFtfGIHFgptms8ExZSUXEICcl8BkqQxXrYiKorpuG7YnOZQ18TU1LknFGMdCzCkkl4I7AzOrNyc562jFwMEbfiJG+wx6EDEe5dU2OJDsD8w5yt7NywNJRsrab3tOwHJumq8p+m2c+5OZLZ3rSvCIqqFF8qfhFoGbDYQVjmtV9SBT0tEveN/CYAoZp603dwHZ1NWDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VENW3byoNhHMP2GFW56MvPx/nwt1jcNE3YR8qDxw4pE=;
 b=NdFuRavXZS+NSMUta79Yf1lm+1J5GYaQfYxQhM6CMZ8i4/BuKiI6AgsmR7b+UDqUy3+iZqvm/QZI8k0Edhw2YxnyqYhbaJDQjRPfGv8s98MRAJAOzT6vNhEyNaxYyPTQEXhhnzAXFpjXjNLMerbcJbk+MXkjExA8F6PjU34pn28=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Tue, 23 Jul 2019 15:18:49 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 15:18:49 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] nouveau: return -EBUSY when
 hmm_range_wait_until_valid fails
Thread-Topic: [PATCH 5/6] nouveau: return -EBUSY when
 hmm_range_wait_until_valid fails
Thread-Index: AQHVQHIWAA6a741P4kaCXdSsPfFvyKbYUvMA
Date:   Tue, 23 Jul 2019 15:18:49 +0000
Message-ID: <20190723151846.GM15331@mellanox.com>
References: <20190722094426.18563-1-hch@lst.de>
 <20190722094426.18563-6-hch@lst.de>
In-Reply-To: <20190722094426.18563-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:c0::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7040cd6-682a-46d5-76cb-08d70f811049
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3279;
x-ms-traffictypediagnostic: VI1PR05MB3279:
x-microsoft-antispam-prvs: <VI1PR05MB32791EF833AB7C7297170B8DCFC70@VI1PR05MB3279.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(8936002)(5660300002)(11346002)(81166006)(476003)(316002)(66066001)(33656002)(478600001)(305945005)(76176011)(54906003)(68736007)(36756003)(8676002)(7736002)(81156014)(99286004)(102836004)(2616005)(86362001)(6506007)(25786009)(386003)(26005)(186003)(446003)(6436002)(52116002)(6486002)(229853002)(4744005)(6116002)(3846002)(486006)(1076003)(6512007)(2906002)(256004)(66446008)(53936002)(6246003)(71200400001)(14444005)(14454004)(4326008)(64756008)(66556008)(66476007)(66946007)(6916009)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3279;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JfBmTD9q6uXParqZi+aVhS4o2+5jjCiKGeNSTX0ZzoIN8go6hy07el3TzKvxXAAq5IWqVmhvzfbU9UzShK21v7oz+13LE4JsjzS6cb18mvPRPszxDaJ4Jpd7JGjBXEO6hNKaYUckO/UEuO9igiDshJ/1HZsqlY3lid6/OK9m6yO41JCHPzFcRxdDVgJMJ78AgaU3t1QzOd8A+j5o/JOsYoufNDbpIYENk1EXCumD1eODiwLFEshdiK4vjIitiinLJrOHDjaXGUx/3rCofhnSuM8dHgjqYyzePXd7Nmh/iXZyHl5UlBMkfQsp7NzZX1XeLJM5guKW5b0DMWSsmFbhwAocVk1PQylWnAFmBpn95rx3Yl1peZCJEWKyH25RcSm6aGrQ1Yxh7eDiM4gvYaA/b3aTNCZywZnQCL+T4vdRnjU=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <AABBB57195659D4A90E8BFD5BD00F6C6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7040cd6-682a-46d5-76cb-08d70f811049
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 15:18:49.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:44:25AM +0200, Christoph Hellwig wrote:
> -EAGAIN has a magic meaning for non-blocking faults, so don't overload
> it.  Given that the caller doesn't check for specific error codes this
> change is purely cosmetic.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Agree

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
