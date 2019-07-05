Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1831C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E3621738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="VVinr73D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGEPBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:01:35 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:45985
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfGEPBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sud4g8V7nXK6+qiPEvdZUh3NyHaw0SoGZ8dlZb6bmFY=;
 b=VVinr73DGYrp0WeiA49oThNmRLNNoZTwp/7fwSCATAvoy4yysoPTppYug7kzXRnpqtZXlPxilEzAQOiHdOx+MdlIfd6c9kQ8DNeaD9VZUEMY3rNjUp5rDNCQtjR5XhD1NaJ+o5eM2e+tpqOGbkHuU6uM/h3ByxGJ2Rdq6uizaPM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6605.eurprd05.prod.outlook.com (20.178.126.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 15:01:30 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.019; Fri, 5 Jul 2019
 15:01:30 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bodong Wang <bodong@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: linux-next: Fixes tag needs some work in the rdma tree
Thread-Topic: linux-next: Fixes tag needs some work in the rdma tree
Thread-Index: AQHVM0HvDu3OpQiGgkWyNyW5+uDa4qa8HoOA
Date:   Fri, 5 Jul 2019 15:01:30 +0000
Message-ID: <20190705150125.GE31525@mellanox.com>
References: <20190706005705.2e6c268c@canb.auug.org.au>
In-Reply-To: <20190706005705.2e6c268c@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0009.prod.exchangelabs.com
 (2603:10b6:207:18::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f0bdf01-edb6-44c5-ed4f-08d70159a969
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6605;
x-ms-traffictypediagnostic: VI1PR05MB6605:
x-microsoft-antispam-prvs: <VI1PR05MB6605C7EA5F9B5D2914B1DC96CFF50@VI1PR05MB6605.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:177;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(53754006)(189003)(199004)(36756003)(6512007)(256004)(66066001)(2616005)(2906002)(6506007)(386003)(186003)(26005)(476003)(305945005)(6916009)(446003)(486006)(5660300002)(107886003)(229853002)(68736007)(4326008)(4744005)(102836004)(54906003)(6486002)(11346002)(81156014)(81166006)(7736002)(316002)(8676002)(3846002)(66946007)(73956011)(66476007)(64756008)(66446008)(66556008)(53936002)(6246003)(478600001)(52116002)(6116002)(76176011)(71200400001)(71190400001)(14454004)(25786009)(6436002)(1076003)(99286004)(8936002)(86362001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6605;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4VLOyVtNvdI+VzUK2NCdmiEF0tp/KedR4bQihsSOocFoInMfN9FgA/6Aq8DY7DYAXqfUGOp/+hSdBCUYVzK7YaxBS8oYclghSGV4C18iBuZ48z2YiIwzlMrRhKYm7Jz1fco8b7slIfchnWtZgX7482/ZajsuiMtGjTwz6/MYHJJgt+MzcBRU3XloA/GpkgwVmPgnc5lNIlpncThJBsDFawD+HX7T8Ayt3Ywzv6LdFbMJDam6TTz01qHS7guBxbBCrVAoAW7WYPCG1h8r3ETxz6En07otl2Opr+Ae/hysHtJKJEd0eYR3zlAMSUOWOJCigDcYUcvcraZ72p8fmub0Cf03QbK9CMxECnOLUTmJk6cCbBAx9EkGckZWFNxSL51OBbHtXTBb8gaNXvELq0KdRDCXJ4qAbG1ra0dVof5U3Cc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF71CFB7FD7E11499FE7F0067510B70F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0bdf01-edb6-44c5-ed4f-08d70159a969
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 15:01:30.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 12:57:05AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> In commit
>=20
>   16fff98a7e82 ("net/mlx5: E-Switch, Reg/unreg function changed event at =
correct stage")
>=20
> Fixes tag
>=20
>   Fixes: 61fc880839e6 ("net/mlx5: E-Switch, Handle representors creation =
in handler context")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Did you mean
>=20
> Fixes: ac35dcd6e4bd ("net/mlx5: E-Switch, Handle representors creation in=
 handler context")

You are correct, unfortunately the trees can't be rebased at this
point to fix it.

Thanks,
Jason
