Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B462084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dR9fwfPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfCAQE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:04:57 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:5536
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727952AbfCAQE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbHiTLH9Ed6xA13K+CTP1WHWZIivfpgQA/WlVKcR854=;
 b=dR9fwfPVY5CEWNPqBvR995JGCEht7uHWMOJYqnOTRN5rXELOXIRjEAKw1A+LpaFFLAcBGXDaChu5hFe6t02ujCO9wMzzDLCMXgK8pGyIqtxP4cp0+r8riFRzZ9r7Y2C9hDxpO/2h1VwMxpuDPSFM6+Qaa6DVKu6D+sSta/HQr6w=
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com (10.165.82.137) by
 AM4SPR00MB270.eurprd05.prod.outlook.com (10.171.88.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 16:04:53 +0000
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::493b:13fd:1969:bb2b]) by AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::493b:13fd:1969:bb2b%6]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:04:53 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [RFC net-next 7/8] net/mlx5: Add devlink subdev life cycle
 command support
Thread-Topic: [RFC net-next 7/8] net/mlx5: Add devlink subdev life cycle
 command support
Thread-Index: AQHUz/D/0j5GnsC3gUeFWESuc/OY9KX2Xh0AgACSs1A=
Date:   Fri, 1 Mar 2019 16:04:53 +0000
Message-ID: <AM4PR0501MB2260B8942171C1F9494A05C9D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-8-git-send-email-parav@mellanox.com>
 <20190301071842.GB8975@kroah.com>
In-Reply-To: <20190301071842.GB8975@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cf2152c-2a8d-4993-1d9f-08d69e5fa42e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4SPR00MB270;
x-ms-traffictypediagnostic: AM4SPR00MB270:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM4SPR00MB270;23:73hmyqEH2YSq51jk1bkAce/ZB8DujBs9ycRLcXwBM?=
 =?us-ascii?Q?N4XjyHRsDaWjKr6n/YkJcOgCGwajunf1vf6TvSoiTJhArrjYco9u9LY5AUQG?=
 =?us-ascii?Q?0IU6l45mc4bHkkjaTPVs8CBKImEhadzA/SpCY+h9XX/LasOfnuCl2U2WGbAB?=
 =?us-ascii?Q?bk6xXlp5Hqhf3D+a+ibbxqQBVcHfRovjuZmXHjQ7/Np0zdVU/iz+dStZprKh?=
 =?us-ascii?Q?dvLdZclbGwHvUtI3Q9nCgs/AY7ax+AGrOM9cxD3lrsx4hKGpmGdl+VzdMUky?=
 =?us-ascii?Q?W5aXGteTka0ZLsvAmmAFlygSNmzGF/kYWySAtlHVRBixtqVIBc0eKPq9PETW?=
 =?us-ascii?Q?lCB6kTP77jlriXMkoiuexSeGjaynpSluuVyT8cy3r8WfdPLTNYXqjXjYOJIt?=
 =?us-ascii?Q?5lp+lcqMCxWARhG7eoaqudOIgU52fG2vaqlAU9WtQkZj76M01wQKKXx6Dnrb?=
 =?us-ascii?Q?nsjCDBYP+s7vyE4ur3avLKVLXHaORua4A/JJCpayvevG2TAiUZvNxcPrJFNO?=
 =?us-ascii?Q?xp0YzbfJJf3LheAjQJTMpIBKvYaoJjWJKbw35Ms88RvEfco5uM8jj/3Ce0i/?=
 =?us-ascii?Q?dqJMy+YOELX+nkfmIBp/C51e9ea9HtbRNETWaST0eosf7p0pk/Ay5Fl7EtTx?=
 =?us-ascii?Q?qZwpmg6Ulc2gnSboX6JWmYMwBnXeuO/24O2AS2/YCHaKF5ZFHsP+4WoQpj3e?=
 =?us-ascii?Q?wphcqqX0GlhZntJr+Rl/l3EboRmjrVoJcbuyEeCboRUCOoP9s32BJw8dYoC5?=
 =?us-ascii?Q?FsJLDv4pMounThQQhoSNK+a3/24L9oairQ4MwyhF4nk4NWpotHEMyBnBJ9dj?=
 =?us-ascii?Q?L42SZmJMDAA2SeDEYls1D4aT7AmUoQqblVR/6luoFFQsaivQTlUlZJf/57H0?=
 =?us-ascii?Q?Rj0xX2WCPBhcXRnUq7wQtKdKh8yobcjgkBKgnLxELMOeKsJlOxRHdnp2CR5T?=
 =?us-ascii?Q?Q/Ah7qQPGGqhhAzixY/GJqPHmhRRCWvyUunwSvHDsXVF58tDFvIcjUwnfaUC?=
 =?us-ascii?Q?3Ig+HJ+ky8WqUdiSUXmBw3YHljdotLs4PyptImkxhWBcaUgp26aRrZM6OyIN?=
 =?us-ascii?Q?SB2v+wQKkDjRyEwAJW5xLwsgQlvwyzBcuhlQXq5shngygsBsCr1oaYLjIZJL?=
 =?us-ascii?Q?+1P6KbyvXhiRqQsiy4p6SQWXX46ySGym7iRX8LV9lVww0Esyk4nQu+h2HXUK?=
 =?us-ascii?Q?aPNPaBfROWhl7PVkIk7BQWLE1PQNRIf1ayCEZ0I8jbqCDhlbYth4d2hDf2pA?=
 =?us-ascii?Q?NOsIanBSS+kHikcxKFQqavztAoU8b11xzCv/IaK4bkHxmv3N9DMPNIk8UQO8?=
 =?us-ascii?B?UT09?=
x-microsoft-antispam-prvs: <AM4SPR00MB270BB357F948D8E42FF1211D1760@AM4SPR00MB270.eurprd05.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(13464003)(68736007)(11346002)(256004)(478600001)(52536013)(446003)(8936002)(71190400001)(74316002)(2906002)(25786009)(6916009)(105586002)(316002)(54906003)(71200400001)(66066001)(106356001)(476003)(486006)(8676002)(81166006)(81156014)(107886003)(3846002)(9686003)(99286004)(7736002)(55016002)(4326008)(76176011)(6506007)(86362001)(53936002)(102836004)(97736004)(14454004)(53546011)(7696005)(5660300002)(26005)(186003)(6436002)(305945005)(6116002)(4744005)(6246003)(229853002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4SPR00MB270;H:AM4PR0501MB2260.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xTswVFfV/+RNItPYfq/h4cOUkNYCXsPtgrk0EFtajFxoyJYS3GdGUWGp5I9hJc1I8ikmkmK2GH/WedeMDS1ybpkUFbtjl1JByUQ1mUBeJDomWmaWQERniDkH91PC0/oKGqDBKd2Xc523oBBV6VxTAITYaYlGUorRo8M2ue/wksBRG+qatHM/qbfTtbLyTAsHWG0zlLp68r/xYIFLX2ef7EmY/MvOCRuxBIc6c+MqiSj7H2kaTvP+/IZXggcTqxzEYVxYavOw9Vo5gpAqK1Y4QlY3eyYQi9UVMPEwGPt96d5OC4rJ/vHf9zwhDKjIuo9AWQNDE/xHTQvCU6R4bLfMJHh+4OCxHT0m1xd6kaPm55Bs1MDSOB8ihg8JO1Kd4sWVnFF4e3QXUqCSoqKW0E8nFua1F49QLd87EF+7SDzj9Os=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf2152c-2a8d-4993-1d9f-08d69e5fa42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:04:53.1009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4SPR00MB270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, March 1, 2019 1:19 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> <jiri@mellanox.com>
> Subject: Re: [RFC net-next 7/8] net/mlx5: Add devlink subdev life cycle
> command support
>=20
> On Thu, Feb 28, 2019 at 11:37:51PM -0600, Parav Pandit wrote:
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/subdev.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>=20
> For new stuff, just use GPL-2.0, no need to keep the mistake of the Linux=
-
> OpenIB license around :)
>=20
Oh yes. my copy paste error and ignorance of openib carry forward.
Checkpatch did actually complain but didn't realize that it may be for Open=
IB.
Will fix this.

> thanks,
>=20
> greg k-h
