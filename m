Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE7C46482
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451E421850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gwCHyEMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfGDN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:28:45 -0400
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:54181
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbfGDN2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sveIOb5v7YWPwLy8dsYWPdpgDk7JWL+plSAuIau1bk=;
 b=gwCHyEMYYQu6MtjbUO+ULoGeEr4TDylVcJ+lpZApX7HMEaTYvMBXfRphO2zQRoIuRkEZpNaMvGYQpwqJ7WFkcw3P5gZOYlCWqDkIuKQRXBz0qgPZh0mkgWootTQzegl7nlRMotGuw250E7BtYIHJZh9QlfuPiRvtUd1N1elqlgM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5486.eurprd05.prod.outlook.com (20.177.63.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 13:28:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 13:28:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Topic: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Thread-Index: AQHVMlcIUr9ppS/jrECG60Qeg/CcSKa6auGAgAABpoCAAAePAA==
Date:   Thu, 4 Jul 2019 13:28:41 +0000
Message-ID: <20190704132836.GM3401@mellanox.com>
References: <20190704205536.32740b34@canb.auug.org.au>
 <20190704125539.GL3401@mellanox.com>
 <20190704230133.1fe67031@canb.auug.org.au>
In-Reply-To: <20190704230133.1fe67031@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:160::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f37b1ecc-e391-405f-a7bc-08d700838755
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5486;
x-ms-traffictypediagnostic: VI1PR05MB5486:
x-microsoft-antispam-prvs: <VI1PR05MB5486FE3A7F488320C2796B85CFFA0@VI1PR05MB5486.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(316002)(6512007)(14454004)(71200400001)(71190400001)(33656002)(6916009)(6246003)(6486002)(1076003)(229853002)(53936002)(6436002)(186003)(68736007)(256004)(36756003)(4326008)(25786009)(6506007)(26005)(386003)(102836004)(2906002)(66946007)(86362001)(486006)(66066001)(76176011)(2616005)(8676002)(81156014)(81166006)(476003)(8936002)(478600001)(446003)(305945005)(7736002)(5660300002)(66446008)(11346002)(64756008)(66556008)(66476007)(3846002)(6116002)(54906003)(73956011)(52116002)(4744005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5486;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DnWroG2zlCahoIC3wMv6mRnwANKvALelje0BA/WVXeugvnWJbx/BCl1RZkO3ZY0XsoSb0EF7CuYKdC7KuMaKWkR+H19tDj+K6xGPNdMVDjTeZmNO9UoEw2kPV1cZZ0JuvM7sSWyr1v6LFcDzIGmnEoOL+sz3QgJVYqbju+RqimDk6q43w1J1dFxe7aVSgMvy2CWKyVE5dLcfOEtOlNEuscq3tkeup3iHO8jNORF+8toAFfUaatJywi42NRLOvMFGmpzrrMamRsHf2IDt8ZsJqnvcWrIdVYJdUM/tyOBGdDg6w5GHj5jNrjx4/JYtdmDxDNYe6Yb8iHp5AY13i8EGEoSjhizzS4RkHE8I8eXJBcvMWl3OaxdsSO8xkDwd97AEvSRw+ddVJiQjmyJuvxcvm9WIwOUuF63gZxNLwhs6KpI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96CCF74E85EB624594ECE7364C971F97@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37b1ecc-e391-405f-a7bc-08d700838755
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 13:28:41.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 11:01:33PM +1000, Stephen Rothwell wrote:
> Hi Jason,
>=20
> On Thu, 4 Jul 2019 12:55:43 +0000 Jason Gunthorpe <jgg@mellanox.com> wrot=
e:
> >
> > On Thu, Jul 04, 2019 at 08:55:36PM +1000, Stephen Rothwell wrote:
> > >=20
> > > Today's linux-next merge of the akpm-current tree got a conflict in:
> > >=20
> > >   mm/memory_hotplug.c
> > >=20
> > > between commit:
> > >=20
> > >   514caf23a70f ("memremap: replace the altmap_valid field with a PGMA=
P_ALTMAP_VALID flag")
> > >=20
> > > from the hmm tree and commit:
> > >=20
> > >   db30f881e2d7 ("mm/hotplug: kill is_dev_zone() usage in __remove_pag=
es()") =20
> >=20
> > There must be another commit involved for the 'unsigned long nr,
> > start_sec, end_sec;' lines..
>=20
> Yeah, there was, but that didn't actually create a conflict.  That hunk
> is only there because I removed the initialisation of map_offset.

BTW, do you use a script to get these conflicting patch commit ID
automatically? It is so helpful to have them.

Jason
