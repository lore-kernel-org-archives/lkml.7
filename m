Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC83C06511
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1574421882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="cCPrx/rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfGDCE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:04:28 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:8679
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbfGDCE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5NSrvyjOVQzXwSu9Qc0KQYpIlpHnIc8wBSU2Q43Szc=;
 b=cCPrx/rVw72aGZvDseUk3d7awTxfIKy8CYAqcElx4UfLf4OoasBr/SbCS80s8Bf89EFwzUWDoJQQawwCdX1q4bgLmZreuRV4YnM96cOJMbG4ZuGp5K12b8MEpZjSlRvu44DL84vCCQmBbSgBPwzCSjHfRfKLZlfO08pZMJUGYF4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5390.eurprd05.prod.outlook.com (20.177.63.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 02:04:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 02:04:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xi Wang <wangxi11@huawei.com>, Lijun Ou <oulijun@huawei.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVL8OActCQCeCYN0akJ9eSFAjYnKa5uZGAgAAAfIA=
Date:   Thu, 4 Jul 2019 02:04:22 +0000
Message-ID: <20190704020418.GC32502@mellanox.com>
References: <20190701141431.5cba95c3@canb.auug.org.au>
 <20190704120235.5914499b@canb.auug.org.au>
In-Reply-To: <20190704120235.5914499b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:2d::39) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c3ff478-90b8-4fa0-f6bf-08d70023eec4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5390;
x-ms-traffictypediagnostic: VI1PR05MB5390:
x-microsoft-antispam-prvs: <VI1PR05MB5390331C66E7DE92F6F51DC8CFFA0@VI1PR05MB5390.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:63;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(53754006)(199004)(189003)(53936002)(86362001)(256004)(71190400001)(68736007)(478600001)(6916009)(8676002)(99286004)(5660300002)(25786009)(4326008)(14454004)(6512007)(71200400001)(2906002)(81156014)(81166006)(14444005)(2616005)(8936002)(6506007)(316002)(1076003)(6246003)(66946007)(7736002)(6486002)(66446008)(54906003)(229853002)(66556008)(64756008)(26005)(76176011)(66476007)(4744005)(73956011)(6436002)(11346002)(476003)(66066001)(446003)(33656002)(386003)(36756003)(3846002)(486006)(305945005)(52116002)(6116002)(102836004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5390;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jPimdWFbwg6WDCEJO6bD94UN1opGKPh34ZF15Klq/31ozGeTdz4xTIw1gZX4ng3zJfE8U8NZUEVCykIF8391Uv/+qrz0krqN81L8N16Zhbe8GDj4REjfbIRWqZMHvyHi+B7Nd23+BC8yu+8mHM+2lBb5XrXX3W4lPP5mWIeHrD/IrtCGEXC7nSvdmFE+iFjYgm1RKTPa+1Rly+0ajtSfsQBz5vscxA7QkHL0xE0OTmsu61myGhs+vAEChklCJaqIbQpQWOxCp6Rojty39flD2rGMII6ZC5ocG5M5gfZrkEs5/DCk41sYoZLMT34e57wXzK4Nex9XMfXhmmcJH4N6xu55lQjgtdFpqr2hjp8wwJkt+JuPNXicYUOA1Prg2JLlbSgaA1CI96gT/aievWR1ApgwTdSC2k75FV1k82UCnCk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3164893E7FC8D348A858F5D126C72AB9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3ff478-90b8-4fa0-f6bf-08d70023eec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 02:04:22.8873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5390
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

I have not got a fixing patch from HNS team.

At this late date I will revert the problematic HNS patch tomorrow.

Jason
