Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E2C21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GWc0dEtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfD3BpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:45:04 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:10816
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729238AbfD3BpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr/9iXhE0xFHe64EPQfqjQMQ3omKvCH1XiAsXkPYBok=;
 b=GWc0dEtEp7hvHIY4LWxG159EmxvyNUL8RPFRi5wJCqrTGJwXizbMSwcYss6BSx0jMgWlfcOIJwUQaepHUf3QYgY26+eS2e28pxKIsrj8fwbA2dG2WnN7Lm7L050+/JIgEW1u4jRzg5IC71XFQOAM0CWctryC0K400gV6uAkN9TI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 01:44:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 01:44:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: linux-next: build warning after merge of the clk tree
Thread-Topic: linux-next: build warning after merge of the clk tree
Thread-Index: AQHU/upr9yUn43McwUSQoMyNM4mZ0KZT7lcA
Date:   Tue, 30 Apr 2019 01:44:58 +0000
Message-ID: <DB3PR0402MB3916B4CE00494BE730C07047F53A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190430101939.76dc077c@canb.auug.org.au>
In-Reply-To: <20190430101939.76dc077c@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e601f39-0d58-4adf-bf21-08d6cd0d7402
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-antispam-prvs: <DB3PR0402MB377235D065C9D7884B8A90DCF53A0@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:23;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(53754006)(13464003)(26005)(486006)(305945005)(2906002)(7736002)(14444005)(53936002)(53546011)(6506007)(71200400001)(71190400001)(256004)(186003)(11346002)(446003)(478600001)(44832011)(25786009)(14454004)(4326008)(74316002)(6246003)(476003)(102836004)(8676002)(76176011)(316002)(7696005)(81166006)(66066001)(81156014)(5660300002)(6436002)(229853002)(33656002)(3846002)(97736004)(99286004)(52536014)(54906003)(68736007)(73956011)(86362001)(110136005)(66946007)(66446008)(6116002)(66476007)(64756008)(9686003)(8936002)(66556008)(76116006)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Ne6XSmIAwIcncJTQ2mYNm9zcZp60ix+KAEWTNNv5vXkfUz6Q2cm1ROD2kEEAHm/E+WMZ5DNFdSmiTFnUnzTguTcnWLFS7G/NfMIyXKnFcdlzCtq61tD6lX4t/NGaSSW+cHsrhWeYFfmqDmiIaxAPQPbdn8OkBnr7x3bGnbjv8jxAijjc8Qe4GVGskQu8ct+hQMpSCK9/Be8PAqofrEctGzK55Yn4KWk8qrX1qNx1TEJoNqzmo9eblzd5t1V2XYFH97Ld51PBmaM04PwKPyOYj9Bqdzos4m/Q1quET2RAEohFg75uAajcIrJ9SKkRtOgbvdxCgkz1/NmOG8bVt/AJRc0yS+dd/vTSKUjZX5ji/VBliDBQhbf9s+kbLzN2aTOe0h+saJ4AvTigSG7yZplWj83pegu1gaRdDjMq4lChpA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e601f39-0d58-4adf-bf21-08d6cd0d7402
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 01:44:58.3339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen
	Thanks for notice.
	As it is intentional, I will send out a patch to add "/* fall through */" =
to avoid this build warning,

Anson.

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Tuesday, April 30, 2019 8:20 AM
> To: Mike Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Ma=
iling
> List <linux-kernel@vger.kernel.org>; Anson Huang <anson.huang@nxp.com>;
> Gustavo A. R. Silva <gustavo@embeddedor.com>; Kees Cook
> <keescook@chromium.org>
> Subject: linux-next: build warning after merge of the clk tree
>=20
> Hi all,
>=20
> After merging the clk tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> drivers/clk/imx/clk-pllv3.c:453:21: warning: this statement may fall thro=
ugh [-
> Wimplicit-fallthrough=3D]
>    pll->denom_offset =3D PLL_IMX7_DENOM_OFFSET;
>                      ^
> drivers/clk/imx/clk-pllv3.c:454:2: note: here
>   case IMX_PLLV3_AV:
>   ^~~~
>=20
> Introduced by commit
>=20
>   01d0a541ff4b ("clk: imx: correct i.MX7D AV PLL num/denom offset")
>=20
> I get this warning because I am building with -Wimplicit-fallthrough in
> attempt to catch new additions early.  The gcc warning can be turned off =
by
> adding a /* fall through */ comment at the point the fall through happens
> (assuming that the fall through is intentional).
>=20
> --
> Cheers,
> Stephen Rothwell
