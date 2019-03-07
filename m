Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FDF20652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="l9NpEofO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfCGPka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:40:30 -0500
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:36174
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbfCGPka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzdXqmV2i1glLOF8RY/cLRoEbPIPYaQ6BfRhN5L2cmQ=;
 b=l9NpEofOhvtKsCCiz51ybU129vFLzyYtFCdehAoZ7ELOswohyUbJ8IdG/ZwYFZut1DTFxIyZIrDkL8zWT7LOmva+ZjmYKpLcYSHS8ghw1eCX4r6zLsWOV2J8J/DJqSrWfjrcco3Hg9U3W4WH36GJ9QherLqKTNI3/sTKpAl7wM8=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6SPR00MB11.eurprd05.prod.outlook.com (10.169.210.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Thu, 7 Mar 2019 15:40:24 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%9]) with mapi id 15.20.1686.016; Thu, 7 Mar 2019
 15:40:24 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Topic: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Index: AQHU1IFjo1AIqyRPikaxzNyP0OOhK6X/X/kAgAAN6YCAAFa0AIAAfZIAgAAM+QA=
Date:   Thu, 7 Mar 2019 15:40:23 +0000
Message-ID: <20190307154020.GN1789@mtr-leonro.mtl.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <20190307072428.GJ1789@mtr-leonro.mtl.com>
 <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org>
In-Reply-To: <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::34) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57386934-306a-4ac4-2387-08d6a313369c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6SPR00MB11;
x-ms-traffictypediagnostic: DB6SPR00MB11:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6SPR00MB11;23:9AgRCNnVMTZOflil5L7XMZJi/mmbvyaKqW4Rkpnwxd?=
 =?us-ascii?Q?8UsRxE1Di6Ir+yvAJu+ebfBw3N40D7LDvkpVWO4+/Ng7h2UUOhsgOkm9c+JS?=
 =?us-ascii?Q?IXkoIlsRVAEYRfG88ZgQwTqjv02t5OmaI07DlCXtaFl+8jNaoxdafz0PvRZK?=
 =?us-ascii?Q?Wr8Vyc89gKoS3nByKF3SHpHebWZYgeElYr52jx7QtHChjc4cw6Vo2m9KDHVV?=
 =?us-ascii?Q?nrRZe/R6M3EXMTS4oz+TDT0ur0cTAslG01v6C40W2GYgzCBRMV7+8YSsioff?=
 =?us-ascii?Q?7vInOFUMTvqFK5KB+7MuI3Sx3WpirY1iBwBDIhXcYERtjA4t98wL5tu+dMdB?=
 =?us-ascii?Q?sAqjRrXUewZBH0HrEaex9itQKWyh3U9c3+41hmv83IObus24MBpHYslzIQ+A?=
 =?us-ascii?Q?+h7Rkro7eq8J6KCQV1KMtpAO54RTN68ZaN82aO84Vgy/I+/YO3fvFnJaLQoe?=
 =?us-ascii?Q?FziFibGM7vBM12HLc37IeQvTCn4QHDeITcXklBRPWNJflfS5uYyk91lBPoMi?=
 =?us-ascii?Q?Qhypz1ouEThXoNnrJlevlg8tZPrnke8QT/0wGRKcrGKUszoLEKV0iNPWVOza?=
 =?us-ascii?Q?4p9n7urcmNXjFw58Xy9cKy0arATCLJeaE5JqmBjeDHfzDXTWC+yZl6k28uTB?=
 =?us-ascii?Q?VsuLlzOdPXuLoVkbgazAXozZdB4aE8fGdqI8N1cusS1vjFjLdLw5Cy8D2Yg0?=
 =?us-ascii?Q?SX52F7EUlyz3DFqiTk0lReyq6st3DjsvMIEX1KcGUkvYqbBKn7EQK+z2w23q?=
 =?us-ascii?Q?vZhny4LtaWHk5lVE3gI2oV8pnqfiHYm7uwXqRNNW457qj5AhahdtDzgr6qjz?=
 =?us-ascii?Q?kBREm3xgAd41ob1lERw53E43FKjn3sOslwttOB++9Ue5mlOSPrjQzGbcoqdI?=
 =?us-ascii?Q?mC04LR048/AuJixITm43LL+BBs0b6V4U808HRk72mWQKzmxqXh7vOiAJxPnw?=
 =?us-ascii?Q?goRw84YXyCVD3MHMKE8gYbWxzewPoa7zmiA0kG/NXE//StzUlDX7qDqVw9lL?=
 =?us-ascii?Q?DGI9VvoC4rQbGbAaqV84uMC3tsRLOj85B1vSUzzYZoZ+BzkGuJPWt5U0tapt?=
 =?us-ascii?Q?QOufnvK3oD3w2RR6fCFgateWRTgUy3UFy6dDWjfQp1krbzz5rmm/kdSH5VLA?=
 =?us-ascii?Q?sel4spK3ukGnhSIltpTfAvLDE2XrMlINbDIMRVCQOPbKYd5Fcz27IPnnRtqi?=
 =?us-ascii?Q?++u6KgzKnT+YdzI/Ri/0DYzrTIOtX1MgkONQllPCaBnHx688KWs5rzrFXMt6?=
 =?us-ascii?Q?D0xZuSxx8kI3E4CmdwLeD/UBjPkIe2QSoAPsUsGlHuQu/pgwnERIn+LZ2WBE?=
 =?us-ascii?Q?oUaHm9YLgUpGWBy+KBx0c=3D?=
x-microsoft-antispam-prvs: <DB6SPR00MB11D2C11E418B85AA459490B04C0@DB6SPR00MB11.eurprd05.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(86362001)(71200400001)(71190400001)(97736004)(256004)(66066001)(305945005)(7736002)(8936002)(8676002)(81166006)(81156014)(476003)(26005)(11346002)(93886005)(6306002)(446003)(54906003)(486006)(186003)(53936002)(5660300002)(229853002)(6512007)(9686003)(6436002)(6506007)(386003)(53546011)(102836004)(6486002)(76176011)(52116002)(6916009)(6246003)(4326008)(25786009)(316002)(2906002)(99286004)(478600001)(14454004)(966005)(33656002)(1076003)(105586002)(3846002)(4744005)(6116002)(106356001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6SPR00MB11;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R2p6nb4e82jL6RPA+vhIOuh4v5CSdI4iVHhhwGDn5wsxVO1sDdUBgQCaXKnp/25o+hbuW3faT+8QchVfn+xJfFayZhneKXncAZ2tuX3CJCXYztQwjxfxxFR7FAPHvdb8T5kmGPKCNzD8Hi5VxJ509tf0EfX0mXm2j9CY10tZIKbE9pRLSUply20LKQlo9X5JXrt6ARddlO0oQ/Ct7wWuoomEk2zjUayIReGcmUNj8fl4A1SbiYPj4TrSYspuWOT/IDKzCMUdg8u0W5Ywam1Jo1wtJY/7Fu5ah3V/Y4zBoraSbVcMNu4Ap/3s/gSF0c7PhnSewI+reKAbc9sgoEJ1EsLuNARQxGVBsi0W/IF5Yo8d/RSTAcbGxo/NjTG68wBmdw0G1+MAwUpLa5fSRh579lyqWzajhuiJuOG3EQX44Pw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85B98162D3863444929A31A9450182D7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57386934-306a-4ac4-2387-08d6a313369c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 15:40:23.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6SPR00MB11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 06:53:54AM -0800, Bart Van Assche wrote:
> On 3/6/19 11:24 PM, Leon Romanovsky wrote:
> > My simple patch passes too :).
>
> Can you repost your patch?

https://patchwork.kernel.org/patch/10841079/

As Rasmus wrote, the thing is to avoid a < 0 check. In my patch,
I converted a <=3D 0 to !(a > 0 || a =3D=3D 0) expression.

Thanks

>
> Thanks,
>
> Bart.
