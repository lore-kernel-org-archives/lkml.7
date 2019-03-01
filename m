Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE000C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9754E218FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ueA10F47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfCAFkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:40:03 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:40867
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfCAFkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6DoDDzM4ypRDGXPiRs+E0wG6nF7Na0rzz7TT63Sw1c=;
 b=ueA10F47hW7xR6xrDQUoUsD+itKRcb6zoOeunxXmWf3QBDdv7QtHwFOuga8+SdEgaiYyntCKuw0+oTfIbBOKAwZzqOURRGkKGhBKTSjXkbP6bbVmN6uG9K2ucUxSWK3EMlJ7xof7ZGHkoVVvtV1DiFWiT87kDjSZHZPFifO9i9E=
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com (10.165.82.137) by
 AM4PR0501MB2707.eurprd05.prod.outlook.com (10.172.215.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Fri, 1 Mar 2019 05:39:59 +0000
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::493b:13fd:1969:bb2b]) by AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::493b:13fd:1969:bb2b%6]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 05:39:59 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [PATCH net-next 0/8] Introducing subdev bus and devlink extension
Thread-Topic: [PATCH net-next 0/8] Introducing subdev bus and devlink
 extension
Thread-Index: AQHUz/C0a2hcjLhI7EO5esgfL97LIqX2QiuA
Date:   Fri, 1 Mar 2019 05:39:59 +0000
Message-ID: <AM4PR0501MB2260A76C5C6954C439A06F3CD1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
References: <1551418547-12736-1-git-send-email-parav@mellanox.com>
In-Reply-To: <1551418547-12736-1-git-send-email-parav@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eddbace8-1924-4e84-d571-08d69e085804
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2707;
x-ms-traffictypediagnostic: AM4PR0501MB2707:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM4PR0501MB2707;23:aJGBEClLX3Hc50ikAO9Tzoy+o0g6Aok/BZ2MwkR?=
 =?us-ascii?Q?RTZEf0Hnc1WdMdetwtmMseOLRmqJB3jGh/BOHIaRUOXxE87d+pS7tVn8m4P8?=
 =?us-ascii?Q?doU1rIoPMD8lsjc2+SIxaMNhgeSsqfq+UTXewYsc8OIwpvoKQ9rCs1/2cuta?=
 =?us-ascii?Q?95KfIaSZtDi7Sg52gsV6NL2m9/l2yj1z/3GCptaKF5cPyA2KMzp+4tITaRMW?=
 =?us-ascii?Q?GQlklIVenrHOsetFiuxab7JCrbiOmy3p/J0QcCRGo98FDWrwE/licN1vofGd?=
 =?us-ascii?Q?qe1IfjpVrUftzwcWvU6LAmtT9QQjRwSoKub8NuTwMLURTQo0WGAGhvn3Qfqy?=
 =?us-ascii?Q?bqYndmu9HIH9UxTme3g4PAldCZa/vEIJ9ZYhHt908uAVPx0EC7XQoX2s/mmm?=
 =?us-ascii?Q?RpnXVx3TJ7r/cR/Q6zbiOPXGQwgp0fPsQ/7XMahB2B5bYGLBqK8HTuKVE/0U?=
 =?us-ascii?Q?Bs0oyZgqQxmJ28l+FiF14Tztc879mqrWuC80YSIeSkpEACl9NbV9ft0LyGll?=
 =?us-ascii?Q?WjOA3FB3hyU6kMLPdSqjwUUxAz4MmSPABy1tpUUMraOsN7NSRiJwxxi9gk5f?=
 =?us-ascii?Q?yrKv0P7Nsjnqkqt8lgRWoGp2ASa4kgChoNPyIv57nAa3Ek1iC6OGaVVI5iNL?=
 =?us-ascii?Q?kXMq0FzgTfxNl2dR/H2lBIlIhBdCUdw65ukL898TWpMoNEKTSlxPyW7pF9mf?=
 =?us-ascii?Q?nKqS132w89iK/GOPR6Ce2CcKhg72cCjUVjBQsyJc+DQ4aYgaxJlNoqqD6Fe/?=
 =?us-ascii?Q?ch1l4+1UUYjDLMnM5oJVBG4NTJ+TuBe2Lb4lNoJf5bhOhJkIXsKctmRg9BEu?=
 =?us-ascii?Q?1Oi6DdXDTl9nSa47bVpRnDYbeR8qJHBJNStNeDoz2nAvTZjfWkvrk37519z5?=
 =?us-ascii?Q?5yMFz3jcpIEf2tgR7u3c+ZJeCBr8gtYIFHhcwO7Dtuc8WowYmQ8OtIUY8Rqp?=
 =?us-ascii?Q?bGiJVsQCyc+I0EiQsV8bVy3t81Xn6npf22/IFpJVLPnblWFCiSmY9fBImRxi?=
 =?us-ascii?Q?6TrDIresEVuIH9gH0q0npJN0uB3bEP89508w9CGGdi6ATIq9Ozr4WnefQDf+?=
 =?us-ascii?Q?LORwUH90V/OU2LpTmcIda0r+4jqcCMFZUZltCfWRK+jt3O86kV/eF8sCqSRY?=
 =?us-ascii?Q?llZXFk35GiqHjETGlOXok1zJmHhRzeTiDn52fbnL7YId+vngMWCK3v+toNeD?=
 =?us-ascii?Q?IELD2ZSRgKhmAHgCroWunEchPwaE6vGK5vcaxQL7M7H0vRK1OQ0c4HiXK+AS?=
 =?us-ascii?Q?HOZJ+5/b+OuOrrPNzCBkL1s8tSNlbd/SoJPdGpp6JhykMNcMmIn+J9OCDaSt?=
 =?us-ascii?Q?fDyrC1a9R6XLhL6QBhK4MhtQ=3D?=
x-microsoft-antispam-prvs: <AM4PR0501MB27079E9ED623AF2259E6F2CCD1760@AM4PR0501MB2707.eurprd05.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(13464003)(476003)(86362001)(71200400001)(256004)(71190400001)(105586002)(97736004)(66066001)(6346003)(446003)(11346002)(53546011)(106356001)(6506007)(186003)(102836004)(8676002)(81166006)(26005)(81156014)(8936002)(53936002)(74316002)(25786009)(486006)(33656002)(3846002)(7736002)(2906002)(316002)(55016002)(99286004)(5660300002)(68736007)(9686003)(6636002)(6436002)(4744005)(478600001)(7696005)(2201001)(2501003)(110136005)(305945005)(76176011)(14454004)(229853002)(52536013)(6246003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2707;H:AM4PR0501MB2260.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: THue9/Z/petSN9iyySfdjnE5HwXvYIVz0iGMdT/PnPx0DfYEQw1BQl+Fbn74rOQn2GV3aYomApo2T0I90yt/7mtBN1EVxqEnHLWhKqxgfMckO/3JhGs6mvzcqXR6IH7kX/Ozk+NB2b0sCdGNgcso9hj9lrxdIxThpqHccKDxHhqhq7LhS+y3Yv2xpvKGHqAODSmW9EZopbwERTQRAzTYn551LQVR4Q6NE1O/sHS/ivU1XmBkUtkUGlwGLlSnjBq/y4pV4YBcAJWtX3agwkHedklbD5jw5IL2zjClZB2UxMMKqtSb8jBYF7SAZzCzAvrLS7/OocQDlkp+2ZCW5kTZy3kRYLMjmxDfCAprPLZaDiSL0iOZcDfsl+uRvlmq3xETl1MzK/DsBV5ZRqIrDo6FfqLOydx79LMkaygTIaDETSY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddbace8-1924-4e84-d571-08d69e085804
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 05:39:59.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Parav Pandit <parav@mellanox.com>
> Sent: Thursday, February 28, 2019 11:36 PM
> To: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net;
> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
> Cc: Parav Pandit <parav@mellanox.com>
> Subject: [PATCH net-next 0/8] Introducing subdev bus and devlink extensio=
n

Please discard this one email which was sent out as PATCH.
Sending it RFC shortly.

