Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE6EC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE55214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XdV7sSlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfGIMdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:33:01 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:53571
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfGIMdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:33:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/BL0v6xhfL3iKyD0ro2usGuoe2ot5zH0vzTzQ9t+jsxud79xWIJOGmOQhdNq7XBr6lEJjJ8L8kxv9eBmYZYAGjMplQR/8BBvIDSGMB8jYaeQdMpdtWp+Nnoo8yMYW+uh+4aqEYKKlayExL4yB5Fc1O4ogCWbf3D5qFoNQUNsse5xxKt510Yl1iOQWunQu1LmHPry2taqzEDMA41bA9Thog2aGU62kYipt1W6Uc5zTFtSKixjlLczcxuEWQnU6iVAFaKCR56J0OPAstjs8rI0WgdocVZfoKdNOKNnRxcukm4enxVzWJjWtEjbnUEYo9uv+S0BWtofSxKDNiyIQUjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjFfj90INbQ4kWYmZ3+Z58P2+OBk32BPDKQHMwgMQO0=;
 b=QFBOxnBQXIwMb8/04gKjMzMEHu8tHERntF8szTcbKuWt297NZW/7I7n0F2opdVEGhKdurxS8LFkHfWSFObYYhXoXScRk77C6+9p65mGGQVxXPJG2pPgbqIUGifSnSrWe+CdjvyAtyLnVk8q15pR0VbxqOiAdlDEAflfN+m6tiKhQsRvxnovCxHlt9sgGbtzp0TQ35dub7OMrRUv/vl2wNnhI6jR68/mKjNovao2H7jVqvw65p+mMgOEgtQH7mR0tfLhoaCXruhl4QiHf+Uyz/4sYCwG1uX+GPeXrzajFcpF1TEvzf2wnOTgm2aAKkEWCPhse4v9c3NbzNiDE7oNxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjFfj90INbQ4kWYmZ3+Z58P2+OBk32BPDKQHMwgMQO0=;
 b=XdV7sSlOVuiqqIe8fxQ9SwSnrV+QD3E1AN358ULbT4Ifel3irTt5JeP7oDA4ohyDBMNgbeciWYCMRrRHz3sV6jEBtTInGZSQsSSZKPESeNvaD00C59G1La9fdfdYeWccor7ZP8Z0gqpob3grGJUvXrnNosHTb2iyED6Lh1f2jLw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5984.eurprd05.prod.outlook.com (20.178.127.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Tue, 9 Jul 2019 12:32:54 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 12:32:54 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the hmm tree
Thread-Topic: linux-next: build failure after merge of the hmm tree
Thread-Index: AQHVL/1llyAK+KM7wk6DgNO5k5IMqqbBeI+AgADMTQA=
Date:   Tue, 9 Jul 2019 12:32:54 +0000
Message-ID: <20190709123250.GF3436@mellanox.com>
References: <20190701210853.0c72240b@canb.auug.org.au>
 <20190709102137.421d1dd1@canb.auug.org.au>
In-Reply-To: <20190709102137.421d1dd1@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:208:160::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff82d768-028f-425f-6c16-08d704699092
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5984;
x-ms-traffictypediagnostic: VI1PR05MB5984:
x-microsoft-antispam-prvs: <VI1PR05MB5984C5B2C4827EC85BA1EDAECFF10@VI1PR05MB5984.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(43544003)(53434003)(189003)(199004)(53754006)(486006)(81166006)(6436002)(11346002)(2616005)(81156014)(7736002)(6116002)(3846002)(446003)(229853002)(33656002)(6916009)(8676002)(6486002)(478600001)(14444005)(256004)(6246003)(316002)(36756003)(25786009)(476003)(54906003)(86362001)(6512007)(8936002)(53936002)(76176011)(99286004)(71190400001)(5660300002)(52116002)(1076003)(73956011)(66476007)(26005)(66446008)(64756008)(66946007)(4326008)(102836004)(305945005)(386003)(186003)(66066001)(68736007)(6506007)(66556008)(53546011)(14454004)(71200400001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5984;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e/7VdZV5vB/6lr9eKDa/9R9CZ1KYS/BJN4jZZGBZCNc8T8Nf3jHmLq7OlvDuWguuU1UtKaMnV1Wr6gUXi4gK7hjJNjtWNbEboto5i6kXMmBs1j74MnlnovUvJddvfpDm9AwvC41aEDUiznO1Vebbm6Nwb2lAHO4NRARXnfEIcYBebRY4+WK4XdV+DESitcVkPkiTjl/QXlXV0gKFZvoit7EOW9c+cwPBKE17sz2KRzAXc1Cc8BL3GhhQBMkdeGNYF+OPd0LLfMNFdHKX7jROMBhtlo5Vu9yY+/mtwiCxaTLP9O5MJwDgXe1HNmEIn34ZqOONrx4TGnGlwCHxeXTNWYGMAse5AvkrD98qpVTD+5d0bUHfzmlptyPVjhTpeoor3I+r1CylUyg5ekbS1gSqwWIBRUtaN16vlPNj+DtoETk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <282AF135E21D614296B5EABDB7547021@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff82d768-028f-425f-6c16-08d704699092
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 12:32:54.1935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:21:37AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Mon, 1 Jul 2019 21:08:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > After merging the hmm tree, today's linux-next build (x86_64 allmodconf=
ig)
> > failed like this:
> >=20
> > mm/hmm.c: In function 'hmm_get_or_create':
> > mm/hmm.c:50:2: error: implicit declaration of function 'lockdep_assert_=
held_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=3Dimplic=
it-function-declaration]
> >   lockdep_assert_held_exclusive(&mm->mmap_sem);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   lockdep_assert_held_once
> >=20
> > Caused by commit
> >=20
> >   8a9320b7ec5d ("mm/hmm: Simplify hmm_get_or_create and make it reliabl=
e")
> >=20
> > interacting with commit
> >=20
> >   9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive(=
) -> lockdep_assert_held_write()")
> >=20
> > from the tip tree.
> >=20
> > I have added the following merge fix.
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 1 Jul 2019 21:05:59 +1000
> > Subject: [PATCH] mm/hmm: fixup for "locking/lockdep: Rename
> >  lockdep_assert_held_exclusive() -> lockdep_assert_held_write()"
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >  mm/hmm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index c1bdcef403ee..2ddbd589b207 100644
> > +++ b/mm/hmm.c
> > @@ -47,7 +47,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct=
 *mm)
> >  {
> >  	struct hmm *hmm;
> > =20
> > -	lockdep_assert_held_exclusive(&mm->mmap_sem);
> > +	lockdep_assert_held_write(&mm->mmap_sem);
> > =20
> >  	/* Abuse the page_table_lock to also protect mm->hmm. */
> >  	spin_lock(&mm->page_table_lock);
> > @@ -248,7 +248,7 @@ static const struct mmu_notifier_ops hmm_mmu_notifi=
er_ops =3D {
> >   */
> >  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *m=
m)
> >  {
> > -	lockdep_assert_held_exclusive(&mm->mmap_sem);
> > +	lockdep_assert_held_write(&mm->mmap_sem);
> > =20
> >  	/* Sanity check */
> >  	if (!mm || !mirror || !mirror->ops)
>=20
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.

Ingo already sent the PR to Linus with the function rename, so I will
take care of it.

Thanks,
Jason
