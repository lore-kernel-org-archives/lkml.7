Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F66C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29777208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="NRD5a4F2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfH3ENM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:13:12 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:52094
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfH3ENM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjsyikWdZd75+0/4d2TIISmio4SB40ycT4T4zimkXpJ9Qa6/vrfuhYqlfztMYRLXjsNvCZIjElAVbcnOyA6gV0g8Q7kzASIGM+vsqubHA5WNlQIKcoAefwlcT5Z8rc9B890AjYED9vyRPBzOKUgWD/1GPyXT7Udq4+EEDmspw0nFn7nU0c6WWkAVn+G2rPpBHPmKNVim0Oh/1Hikte3XidxuKrMwAYL7i2Crv870tReScPsJsg3Y8mlp4HJ/EJDxbfHqwCn9yIc9SCFdJn/6ETNCxfC4ido4/qj35u+nBb7Jbvh3eLxUIBebZgK9ZD8PwqHrPJ7ywPMrQ0GNm9Dwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jr3jgf62/aVZqKHX8F648j4zqkoxDB7/xY3vAuL7xc=;
 b=hbyiwpBKnFqYC5VesjIMBn0mRugvMW0lpwFA8MyFvL/8jsau1cyTXd6x4RPYn9GXkHF3rnvmRTQ6M/TWblMvurJYdDjPyd0Mbr1g11LumJAw9hVn9uhgUESxEzwAogV20mzqAUldXjKIq/esTAIAzQfff/XD4mlSLOag2+mD3OwL6eZBHDSJEF5IO9P97bt7rvEBGCGrqgMOc5vv/4K84aoYeIb2lzKkdtIqDMo0mJSaSMUHomAhqPAW7L8cvKQONkr8M/O3j2qHRSV0MqovGfPoUzj5BKa10WDglLnFkn+xcW9Su9Zb1zGt3XGMWVjHEecJNbF9XY0S3Tjd3dxiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jr3jgf62/aVZqKHX8F648j4zqkoxDB7/xY3vAuL7xc=;
 b=NRD5a4F2KwkX0qZrYSMOkzktGVZ094PJ1Ym8APfdnRpvzl4purvFmK2f4SfH2zIhZKjT/FRdzXlgfURhM9ZmGS5aloYJ2pXJVoDZ0PVxocGlO8ABbLOGghMIMoSNIhYMLsvqGicZ8w8hyWm6g5ccqmbzNCCAzTfzoocNNtdXp54=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4579.eurprd05.prod.outlook.com (52.133.59.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 04:13:08 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::216f:f548:1db0:41ea]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::216f:f548:1db0:41ea%6]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 04:13:08 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [PATCH internal net-next 0/2] Minor refactor in devlink
Thread-Topic: [PATCH internal net-next 0/2] Minor refactor in devlink
Thread-Index: AQHVXujt/gPRfY70+kuNzFmwjbDaJqcTFHNQ
Date:   Fri, 30 Aug 2019 04:13:07 +0000
Message-ID: <AM0PR05MB48666EF55831C8A90858FECBD1BD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20190830041035.60581-1-parav@mellanox.com>
In-Reply-To: <20190830041035.60581-1-parav@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.18.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13bf66b1-7113-43ec-1184-08d72d005d1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB4579;
x-ms-traffictypediagnostic: AM0PR05MB4579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4579E3B53D3DE14E61821F3BD1BD0@AM0PR05MB4579.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(13464003)(7736002)(102836004)(229853002)(9456002)(86362001)(110136005)(8936002)(6436002)(55236004)(6506007)(81156014)(26005)(76176011)(2501003)(33656002)(14454004)(8676002)(99286004)(9686003)(52536014)(5660300002)(81166006)(55016002)(6636002)(25786009)(6116002)(7696005)(305945005)(478600001)(3846002)(316002)(4744005)(66476007)(64756008)(66556008)(71200400001)(66946007)(76116006)(53546011)(256004)(53936002)(186003)(74316002)(66446008)(66066001)(2906002)(11346002)(476003)(6246003)(486006)(71190400001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4579;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D4JlTxDgpwIAe5muRRjh+l0D1+9dNi1+yzsKKRsKbLxH5cn5LdmJHYkm5TLBrdKkdyDgHoMJzZtOneQVdlL4qcLAFLwUbJ8eTa3GwgPIL7DimBdzU4nG+samFM+TDojl7HhPemqFwwjg1uemm7EbXOeLmaz8ahv9C4tpDEf0hKbCYv37sjjZhUgutzOeeNT7kx22n989NFyXGZ7ex2JdP8K4abA6KDgk/7A6g94yhooG8D3ODdw/YT1anwPR5QKTGgTr5dXZ12wHV+Ad0UhfLeHM4dTHuJUyHO+n6JCMFea2YndHsu8Yh0Scxz+5m8Myght/y56zL/X5z4iEsUYA8bFg1jNWJMr5PmKhCP5OGM61178VPIZ0wQF9B9uPfAxEBLGNCQvBy7mJ06fMlv+IFUsVCgbgeklBT4KW6E7jz74=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bf66b1-7113-43ec-1184-08d72d005d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 04:13:08.0001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRSmz/s6aUjDIXCYlBfLJe9ttoO+xJdiiFUkstE835Mb4/WVC42dxU1zVQc3/EeioHUMIHrYKm7jEw/vgCH57Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Parav Pandit
> Sent: Friday, August 30, 2019 9:41 AM
> To: linux-kernel@vger.kernel.org; Jiri Pirko <jiri@mellanox.com>
> Cc: Parav Pandit <parav@mellanox.com>
> Subject: [PATCH internal net-next 0/2] Minor refactor in devlink
>=20
> Two minor refactors in devlink.
>=20
> Patch-1 Explicitly defines devlink port index as unsigned int
> Patch-2 Uses switch-case to handle different port flavours attributes
>=20
> Parav Pandit (2):
>   devlink: Make port index data type as unsigned int
>   devlink: Use switch-case instead of if-else
>=20
>  include/net/devlink.h |  2 +-
>  net/core/devlink.c    | 44 ++++++++++++++++++++++++-------------------
>  2 files changed, 26 insertions(+), 20 deletions(-)
>=20
> --
> 2.19.2

I am sorry for noise.
By mistake send to wrong list.
