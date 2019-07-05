Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08063C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32FF21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lak1gVQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfGENPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:15:36 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:42790
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727609AbfGENPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/4kgRACFfZy09xQrYtXc9T2T1sSalDFNr1RDrSEfts=;
 b=lak1gVQAV8A4GHvg/TG3YN9r86EaOMsuEPvIbJeFn1EFoIQH0HyJlurvK/QyFhmE4y/cmUH9qLCASsLKl5bgCiQUf/bGId91uARMGSetKE/WnyGVomryVWnevBljYNn2gOp4kdnx5r9NaKcfQcZoslRzUqq6voesIpBlor7e9zg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6815.eurprd05.prod.outlook.com (10.186.162.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 13:15:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.019; Fri, 5 Jul 2019
 13:15:31 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xi Wang <wangxi11@huawei.com>, Lijun Ou <oulijun@huawei.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVL8OActCQCeCYN0akJ9eSFAjYnKa5uZGAgAJOTAA=
Date:   Fri, 5 Jul 2019 13:15:31 +0000
Message-ID: <20190705131520.GD31525@mellanox.com>
References: <20190701141431.5cba95c3@canb.auug.org.au>
 <20190704120235.5914499b@canb.auug.org.au>
In-Reply-To: <20190704120235.5914499b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1bec85b-bf7f-430a-f8f7-08d7014adaf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6815;
x-ms-traffictypediagnostic: VI1PR05MB6815:
x-microsoft-antispam-prvs: <VI1PR05MB681584296378251A5A8F2CE6CFF50@VI1PR05MB6815.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:69;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(189003)(199004)(53754006)(14454004)(4326008)(6916009)(54906003)(486006)(3846002)(66066001)(446003)(6436002)(8936002)(5660300002)(1076003)(6116002)(6512007)(316002)(71190400001)(71200400001)(53936002)(476003)(2616005)(4744005)(11346002)(229853002)(6486002)(99286004)(7736002)(186003)(26005)(6506007)(33656002)(102836004)(386003)(52116002)(6246003)(81156014)(8676002)(68736007)(81166006)(478600001)(66446008)(66476007)(36756003)(14444005)(66556008)(256004)(66946007)(64756008)(73956011)(305945005)(76176011)(2906002)(86362001)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6815;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lMyewOmfVlZWEKn6pSKluDZw86PQdnzdq29UfyZf0m2OMm1T9VfpJsu1M9p3yxxIppRcWXZJU//iDJVOKBOEUdvjFZlHsPcssO1c5Ree+LMBhhYIsIpwiKRbY6nQX5ta99I9JiCRmd2DRyEZ0Zi1ff0Bn0Y66kFRTsbIIpNCh3iPyW1B96pI1IpmsXVpTgpbSh34BvZkXVEE71C6YiYZn+5ocKZ1T5whoAARJP7f3KpNByUY0uT/6/uUlNLC5b592/PRrscxK6Bnlt6XHZa/1LKIXa7ZEclSQNVd7BpYrZrGDQQtnF1Phk6/cX95QYMJ4NQ4sDcKUGQ39RJ055FZIAkAdGFbZAdRhqQRDDABS97QRuT5iBmjv8uNl4t20ndkpkR+PpjiAsbNkCG0pIb4wphvtTiW5++aA2fHGV3xHxk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B0BCA509A633D43BAB88035D9FB41FF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bec85b-bf7f-430a-f8f7-08d7014adaf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 13:15:31.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:02:35PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Mon, 1 Jul 2019 14:14:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > Hi all,
> >=20
> > After merging the rdma tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns=
/hns_roce_ah.o
> > see include/linux/module.h for more information
> 	.
> 	.
> 	.
> > ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_sr=
q.ko] undefined!
> 	.
> 	.
> 	.
> > ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns-roce-hw-=
v1.ko] undefined!
> >=20
> > Presumably caused by commit
> >=20
> >   e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
> >=20
> > I have used the rdma tree from next-20190628 for today.
>=20
> I am still getting these errors/warnings.

It should be fixed now

Regards,
Jason
