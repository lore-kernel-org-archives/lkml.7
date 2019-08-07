Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F451C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8A214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="BTF6Qfq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfHGDVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:21:18 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:65454
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfHGDVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:21:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq7JNUVlhtPj1j7Sa8pa+otGg9qpqoXUuPJZmHnSgVKJkSSvWfWs65lDUy0AF7rJ2g50SgTm/BSr8D1ZLN4oBOHchGETnehXYbv1E7RauZfNuRYpXPO45HeNGc8jp+AukQ23njTl3X7O+c8EQy8Aq/UfvqfB8kopG1Qhn0D7er2B15QfOkgC9iNYRKEwEgqxfpz0BdXYzTC/Kh4hvmPXbJRplr51ZXxsByU47wlRvgB4/TWm/SDEIb6yryNsqX7RubhSfTOoHNUAdJn56XLrO9jJMLOfklhdIWEg0WHto7FD4OHE/n4fT1+VshUT1Q17iZorYWC4kGyCRZF5VUMD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RNGL38haLq9xZ5fbKBwegxXutRoBxKP/XZEJKWc4dQ=;
 b=JzPZWQJuUlqeebFHqDHQVx4M9ZPZwt+6l2Nv7+ECJeGvBHMPfIqnrNWGaan/kzhFjKs8f4VMTPHqeevta+XYWm/atJejfSWv/WQ/8QgEYyg9NhL3v57ypZ/m6kmmaF8PHvvJkz5uxyVVjGiYnt86SE5qK0u+6kPpXcYMp6VjLHspLaJNGwm7yxAR4wMUQI0rJVocpWxdEFeWs2xJbYXSQHCcMb/8Ce/x5NtUz2ufsntoH+Rl/C4CPYc/AJIelS/eTLzplfH++MwY7m1Z2+W3etW81sYGthPBM0jaQgnuMJaSd+6u4aWjlWgN186VMoQWZ9tqu3C8n3rW634uWBausA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RNGL38haLq9xZ5fbKBwegxXutRoBxKP/XZEJKWc4dQ=;
 b=BTF6Qfq7K7LNslqbyspGbm0ZuzuUFyb7SvMN9ThHzpri/K888qwF3zDNpdD/+6/vc/Qi+CnAzeftllgFdGZ8xdPM2Hs+DVARqWH6eQBS8rFALJtlBjENRdBsm3kylF3pCLnYkzUlnEPPwOWtWTF8jfW6pxFsWa14EN7J2rbyGY8=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3410.eurprd05.prod.outlook.com (10.171.187.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Wed, 7 Aug 2019 03:21:12 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::a1bc:70:4ca9:49f6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::a1bc:70:4ca9:49f6%7]) with mapi id 15.20.2157.011; Wed, 7 Aug 2019
 03:21:12 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] arch/microblaze: add support for get_user() of size 8
 bytes
Thread-Topic: [PATCH] arch/microblaze: add support for get_user() of size 8
 bytes
Thread-Index: AQHVTKduheAjE46eDEm4+HSiEFkSBKbvBPWA
Date:   Wed, 7 Aug 2019 03:21:11 +0000
Message-ID: <20190807032059.GC4832@mtr-leonro.mtl.com>
References: <a6f97040-b021-c787-65da-9a10b7597238@infradead.org>
In-Reply-To: <a6f97040-b021-c787-65da-9a10b7597238@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::28) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.115.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2553813c-ea16-4ce0-c41b-08d71ae64c08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3410;
x-ms-traffictypediagnostic: AM4PR05MB3410:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB34104121C639B06132ECD6F9B0D40@AM4PR05MB3410.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(476003)(486006)(256004)(8676002)(68736007)(1076003)(53936002)(6436002)(6512007)(9686003)(7736002)(86362001)(2906002)(229853002)(6486002)(6916009)(305945005)(81156014)(66066001)(5660300002)(102836004)(4326008)(14454004)(81166006)(11346002)(186003)(25786009)(6116002)(3846002)(99286004)(446003)(33656002)(52116002)(66946007)(64756008)(66476007)(66556008)(76176011)(66446008)(54906003)(386003)(478600001)(8936002)(6246003)(71200400001)(107886003)(316002)(26005)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3410;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GTKCP2HiNYuVstqSRRjgjxOu9Z/7LQA4HHfE0xZJD7j/6sjKkZ1yWzsnXWxDzeJ4zlwwq7VjvkBkmxNm6GAA8fy497wcXLc6R/9TIxQbT+QpN4bCIOK3Ro3yTl6dW05yI+E/+VwddrkZu/dC/ql0fgaR0SVTvtJ0Z++sOpDY3eFFE9mfg6/hzECMkzj3LflwnK5bqOf7zDh8mLvCkDGQ4ripVJEUVW9+2Uz760dkglnXJ/g9UYTF9GAawuXAYWcyf88yHVn4b9eG/F+n8xAYeLe8B4bVX45pi/fqjmCYCa4PBz8xx39Ypcp1fLz52vdibP49/gmjwX7pyU2Feie4eaOG53bsM7XJtivykWdY+KCzUkJGNgjNCsEX3Rh110jUFnXlm3xmWgOHYG/WWWxImF+kQzkdTGltVH4hwKZ9AmQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C56246925B349B4CB8EA9A6F82897A40@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2553813c-ea16-4ce0-c41b-08d71ae64c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 03:21:11.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyIUhWNlMViGIPkXlAXSYxY/Xqc+8lRcYR73RXuljXP0JrRKl4WZ2+juhCnjsxQB7fi4WWrry6OqqLu8uWO/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3410
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:36:37PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> arch/microblaze/ is missing support for get_user() of size 8 bytes,
> so add it by using __copy_from_user().
>
> Fixes these build errors:
>    drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
>    drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefine=
d reference to `__user_bad'
>    drivers/android/binder.o: In function `binder_thread_write':
>    drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference t=
o `__user_bad'
>    drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea7=
8): more undefined references to `__user_bad' follow
>
> 'make allmodconfig' now builds successfully for arch/microblaze/.
>
> Fixes: 538722ca3b76 ("microblaze: fix get_user/put_user side-effects")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Steven J. Magnani <steve@digidescorp.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/microblaze/include/asm/uaccess.h |    6 ++++++
>  1 file changed, 6 insertions(+)
>

Thanks, it works for us.
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
