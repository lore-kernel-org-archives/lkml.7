Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DCF206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CVAbY8bE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfCKSOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:14:06 -0400
Received: from mail-eopbgr730103.outbound.protection.outlook.com ([40.107.73.103]:59965
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbfCKSOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVavoyoiBTKfyONZTVhC0ubm20MocMkb06SU5qbG16g=;
 b=CVAbY8bEaGAqYjROBr14vyo86Tn9/ctzOTW79MkvADvgdsFMQ68U/SOc9WUqKNkThGc8PibQZNqG4DRzIUEm3GRpP2fXn55L62Yp+9Hz7LOy2gXuYfd3Q+oAhg99Gt//rYpV9yE5Qf28hw4+IxA2feedWvUKUfLJpgycqCwKy04=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1374.namprd22.prod.outlook.com (10.174.160.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Mon, 11 Mar 2019 18:14:01 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:14:01 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yifeng Li <tomli@tomli.me>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yifeng Li <tomli@tomli.me>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to
 "cascade"  irqaction.
Thread-Topic: [PATCH] mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to
 "cascade"  irqaction.
Thread-Index: AQHU2DY0omutCmrXsE2nUAWtbThm2A==
Date:   Mon, 11 Mar 2019 18:14:01 +0000
Message-ID: <MWHPR2201MB1277B26232DBDC311AEC16EEC1480@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190304220022.20682-1-tomli@tomli.me>
In-Reply-To: <20190304220022.20682-1-tomli@tomli.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be020e5a-161c-43ac-39c8-08d6a64d565d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1374;
x-ms-traffictypediagnostic: MWHPR2201MB1374:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1374;23:ohHNjrmKtDgPGhKcPO+ZKpZa952KncE7Ac0PN?=
 =?iso-8859-1?Q?8JIkdYHWiKskFMR2gVQdppz4Ya6z5QNftdgRD1420SPnz5dVcX6VTqU+zu?=
 =?iso-8859-1?Q?5yyWf3R+mj1GyDlKyveGadlGuIsjWJYog+jab19h1nWhdmVbdPUuMZPZ+Y?=
 =?iso-8859-1?Q?daplRW5GXaxvYHohR8HovKyYRBaF7f/sMQFIbeH4GxNUXglwBHy1VI/MF+?=
 =?iso-8859-1?Q?cobG0ijJNC6sJT4O37E2r1voupiyyfAPBPCyPxjLv7dQdqfD8rB1ZWOqKw?=
 =?iso-8859-1?Q?kqV4G7XVysX8KqXEwNgZD7xxDdl3sLZcEBDVw6yqs2jKyqpRzeJUyIwDev?=
 =?iso-8859-1?Q?P5SBNi6Pa7Bt8aAPJCTFO76dZnqnxu4f3WnUw+pg5hOb7oD7h/0ENzgf+Y?=
 =?iso-8859-1?Q?3ju4vN6CcT8tQaEJgHOPyhW4HibQzKRvyNSSkIk4dflEapls/21NwRSKPl?=
 =?iso-8859-1?Q?uS3o1eTkgHbkD+d4YHjNleIB78D1vQyRq2A0Q/B+EXqETriAjH43P+lPJo?=
 =?iso-8859-1?Q?/pu0yVOA8UBUYfI+K8JD14qvIQ9wRKmwD+5QJDcocLHzv7w4lxZb9kPJ9D?=
 =?iso-8859-1?Q?CwzA9cjeIaUgAEkk+aZAYWlwRrDqPbrCE1pgQDzJ6XobD32mRnbsW7jsmC?=
 =?iso-8859-1?Q?4XCT29sYfsbmy8+T02YxtbThdRPuRRAv+05WIp7GYP9ixZWTawT5FNMlyi?=
 =?iso-8859-1?Q?YXY9IA/96Onw/lqsN8cAG+k5AEB6rUqV89voKwK08br7Z2RKRonUnWv3Zy?=
 =?iso-8859-1?Q?P9tGmMN7hDFi+iC+OZbDdzdtl7fUmjDF1ReQuenFBbbnEjJXlB6OBoUu/K?=
 =?iso-8859-1?Q?/A9Pg8Yh11C0s1fkrkNgBMSF1tQsT/Me8j0bIxeZ/hH8jgGUvxTiDNVwgM?=
 =?iso-8859-1?Q?LwrCMfidi15zoxTpQ2X22LJQG1CcD/wOF8gySV5ZKPphCSwpxMhm2ssl/7?=
 =?iso-8859-1?Q?4pJgoMV/buT+s2RVmk37WSwOEx+wCAwhq0jFUFMr6D4c0VZZxzbnckVb9U?=
 =?iso-8859-1?Q?tgLd6B6BVd6XdGN7H7a5zhL2d9fdxRjsNqgTPb+kv7m+ULwTDmSx6U0yw+?=
 =?iso-8859-1?Q?2rD4iBIXpguKRkZPz27bFg5AI4miWlQQCHuCNen+k9jJDj6nXvMbpnu9uC?=
 =?iso-8859-1?Q?m/gJcvdryoRjBkEhHXDV7zWzde8bOkWLPl0VV945aDaZ9faVM87r2ZvGYp?=
 =?iso-8859-1?Q?tsKFMDPvkkmmYWx9wdw/jF7PgTRul/gQiySa1mhe45I9HYwkz5Lyi3b7JZ?=
 =?iso-8859-1?Q?JGydsxFEy+hn3xIPnhw/iGvoHXDolJT5vzghbMqVDEMEzFonAHfiBsJs57?=
 =?iso-8859-1?Q?5nMN/q2zORkZW7e8+GNpmVBfu8QAlSVtFUQv7VNjOavlT2P5grI4HRvqqa?=
 =?iso-8859-1?Q?MXGZGJjX1t0PmPWsBAY4p8s1Ym++p+WmB5b+z2o5mFA0pdBn5BQmUhfl+K?=
 =?iso-8859-1?Q?bkAqO+8J7o04N91E3OHmMQyxlgCpjPtx82nms?=
x-microsoft-antispam-prvs: <MWHPR2201MB137449A38FFCED3F55B3986EC1480@MWHPR2201MB1374.namprd22.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(346002)(39850400004)(376002)(136003)(189003)(199004)(2906002)(55016002)(26005)(186003)(42882007)(11346002)(486006)(52536013)(476003)(44832011)(8676002)(5660300002)(7736002)(305945005)(478600001)(33656002)(99286004)(97736004)(446003)(8936002)(52116002)(7696005)(76176011)(68736007)(81166006)(54906003)(81156014)(6246003)(74316002)(106356001)(105586002)(14454004)(102836004)(6116002)(3846002)(6436002)(14444005)(4326008)(25786009)(256004)(6506007)(386003)(6916009)(71190400001)(71200400001)(4744005)(316002)(66066001)(229853002)(53936002)(9686003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1374;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dgwPHCtcZTPWj+Aa2Ic0Mr+uoMVhpB5XS2azZtP8SQa41h/B0g5c9LqXjtEiq2CC/EaG5VIDtPyxMF0cXBFh9/pf7jaQqwhytIXCGy4232x8IYdJFnvE/csldsyK8e7s3Tt7rKRlFgcoSMl0TGH8ZfmVpb1xpuuGhjKNNhSmFCWsrRNBSjljsdwxz7xwisVD0mc/X2H3LTTP7gj6PDQnz6TbgpqxjXqpWjgW/5TvtzMLq2FvLMWKyDzKhPIlowgsq3ORuIJHMst4ndFP8i+AwIIZp2PZYvRrcD8Fo/igXEtH0HGBP8lf+J0ucbChYinURwHZJGAdvp1LPGQzkbOPviSsmkrZgXPtwRCT5/LyPVgYfXK2aHsZzjzAN8n0xMyqQKlo4h917O073WMCVgmmcTN4DN2qBy5RS+JUezxMfuw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be020e5a-161c-43ac-39c8-08d6a64d565d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:14:01.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yifeng Li wrote:
> Timekeeping IRQs from CS5536 MFGPT are routed to i8259, which then
> triggers the "cascade" IRQ on MIPS CPU. Without IRQF_NO_SUSPEND in
> cascade_irqaction, MFGPT interrupts will be masked in suspend mode,
> and the machine would be unable to resume once suspended.
>=20
> Previously, MIPS IRQs were not disabled properly, so the original
> code appeared to work. Commit a3e6c1eff5 (MIPS: IRQ: Fix disable_irq
> on CPU IRQs) uncovers the bug. To fix it, add IRQF_NO_SUSPEND to
> cascade_irqaction.
>=20
> This commit is functionally identical to 0add9c2f1cff ("MIPS:
> Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction"), but it forgot
> to apply the same fix to Loongson2.
>=20
> Signed-off-by: Yifeng Li <tomli@tomli.me>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
