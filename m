Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDFDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFCB208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YCOylojY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfG3SC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:02:56 -0400
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:35204
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728234AbfG3SC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:02:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrutM+iHJB9jHdnnSd0r70zPglkgLyoBYC90vZccbpJkHArsK7yYBLqLr/c4rz/9lri1+61A2T0SWIru3RjmqYWCoFjGncmr5Z52d4GUT5vfFy8cvHBuL8qJheD4x/Wq/1gVUwkJ/4jFvraB00MUXH6d5i9g5CBVOm1zUt1JDEcc9WGl9GqQNJJbxI4VecEQQFQoNSQnuHxITDnqytXYvsRSJUPtDdmvhIPr+q7C8fNDQRlFMLjvU/UvXz3Nc+nM4M63y4ZgzHjCr2gcxiGe+MM4e7pOronR6NejLkVvOpZR/+6/3xFlSByUlT4BMLFVWbMhOnIWerh8RhneHKNsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU7QXpoWkU/mAmBMVHE04HkSslwitrq0gukekU5gI5A=;
 b=ZHCypFovxDjlgwCI+qKzpekTZNhNQWMXg136WdTB5TF2eHSSCJFMqEtn9DoX1joSxTi4m2wUVgDsgTa+o/qSsoxSH6h7oJ2Seno5nFIuoJdnhxWOKjf7V66ao+qde8yVAfi7Ru3hr4y4dSZZ4KfLeaStLN+qeYuehJlvdibBT7EzDNwqxNCnkqRVllu8JiMxFnaX2zRgetmzQ3xLEFlzb4zevrBF1D/K/SJrOr0nFsBAvy88kY3D11vEnQE8Wirv3NvuiqkDOnsbAfCU+BNeGCqFwTMzCG9Gc+OYoSBsk11ank2KNCnnHToK9FNX+VsJ8kwZLwcCux77k+jVwH1h1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU7QXpoWkU/mAmBMVHE04HkSslwitrq0gukekU5gI5A=;
 b=YCOylojYtDyxNhNVrJk8NW1AqeRL/+Nuq2oFq9nDtYR7RTB2D2BQl8SCicOLJeeZlUjm8Hzoc1fC+rF5lWdxWT0s4lYDITBymNSPj06JVHOFP4O5zDge5SoYchcj/P2dRqLGOqUN3a8q22y+RWz8m+bz9GN0SXgRJbB+46PJwkg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5728.eurprd05.prod.outlook.com (20.178.121.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 18:02:53 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 18:02:53 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/13] mm: cleanup the hmm_vma_walk_hugetlb_entry stub
Thread-Topic: [PATCH 12/13] mm: cleanup the hmm_vma_walk_hugetlb_entry stub
Thread-Index: AQHVRpsH3arHPNDuEUqTx9EEJPBdwKbjdMcA
Date:   Tue, 30 Jul 2019 18:02:52 +0000
Message-ID: <20190730180247.GQ24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-13-hch@lst.de>
In-Reply-To: <20190730055203.28467-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6539de2c-fded-4047-877e-08d715182442
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5728;
x-ms-traffictypediagnostic: VI1PR05MB5728:
x-microsoft-antispam-prvs: <VI1PR05MB5728B65C2DA5BA7A5472F8DACFDC0@VI1PR05MB5728.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(6116002)(3846002)(68736007)(2616005)(71200400001)(71190400001)(2906002)(11346002)(14454004)(386003)(102836004)(26005)(446003)(486006)(256004)(305945005)(6506007)(5660300002)(476003)(52116002)(186003)(76176011)(7736002)(66066001)(86362001)(81156014)(6916009)(6486002)(6512007)(6436002)(25786009)(4326008)(36756003)(7416002)(4744005)(99286004)(66946007)(478600001)(1076003)(8676002)(81166006)(8936002)(316002)(54906003)(66476007)(33656002)(66446008)(66556008)(64756008)(6246003)(53936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5728;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C/ks47PRQnThPeuchvfvHLJvxrN1CNZZ1k8z7mZJ3afqvlrSMLtWwSaVNoKNQkqCT8rkHKrcV9lDre4DgLQXxeBjlmx+uxpveQTy9l9bnPGx9EqUqlt8ik+M1XNO/Q7CDGbak/BhJNMYceY10pCJefD6lJQm9FLP3q2+sInXVpVj5ndmyOduMjm7IHSyzrCZcLdT5VfPENi7Riwevj9WgajLt9nOfnnLIr51cVU4D3wST/XIGe8ouz30g0pbSQ70TzIJf75/7aPQdCbSSrJbh+JAc9GKL4MqoufOFsNUIdBn/qhrjJMxnTdbGH9s0LSp7zMSWefgCkaRbM5F+gwR8yDXNaUsuXM+rzECslcUWSSPEDTl5Iy/213WCiy7DyLI2UJmrpDqWCczRZrFoRv/SlgdldNHsg0XZjwQvGtDtUo=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <981A0DE32A12614DB8B2019E51F413F2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6539de2c-fded-4047-877e-08d715182442
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 18:02:52.9621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:52:02AM +0300, Christoph Hellwig wrote:
> Stub out the whole function and assign NULL to the .hugetlb_entry method
> if CONFIG_HUGETLB_PAGE is not set, as the method won't ever be called in
> that case.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
