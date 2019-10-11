Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C55C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5116421835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="Yc1defxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfJKQ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:57:32 -0400
Received: from mail-eopbgr780043.outbound.protection.outlook.com ([40.107.78.43]:52613
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728461AbfJKQ5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRzdC1HObK8AFiisXT5eVtGOxthG9CrMuUqUBBdFTs52cKjH0qk6iTc1JyJpV005CNPaWGq7mrzafJbpl2CRO6yubw+IwJDgkgpB20Txm5X1LnvTKJtOQPP+x9SvqRu+IWh0WSSk78QUxCllKP08coF12QWIKgwndoK76psxAKkG9QFuAYs1W8jRYjE2v2Dm4KU0v9W9bDyvqGr7uFSO/5q08pYXvFXZUZXKIztxoqEu1I2VvDG7QwZNnOZn/KATVKByFlkhRvr9+4T0l1rV/dcSPHaDECtrBvjKKSrZRkv8Q5pTVFYxeq67b+6q+moYdhljjqCrrKlsv5egg9wANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYHMmMWG/tdVsF/XPXftZ8Pf04IYMukSB5KMVmm7Yp4=;
 b=UD0RZHqU6Zfv9lZdvU9G2e5fQeUG/kqCTKc35Vivs1B2uY2EGLyhhACOUYO/fHPFFuBrq0xcNvnAU/lM0QcOzo4C/aPg9RYVNGwdtNGlamAsaBl8l5BF3DLT0viljj1OSL0dQv5qTNg9i4VTw4ZPvyMK+B3ZfhjTRTb3PUt/6ort+kVHOBU3+UQ+1KCDhVhEE3AF77ta2KiMpf9YDZ5958NOlWxHCrcSNqvrXlW38z8ImGniuIA+gY6UO4QkKGcVRjWIwxVCyXkMc0vj6OH7dveSnt+kgdFj0atK8EgqI4jatkc5WpvVd25/873BP6EflnsBmVBcheuSpDnueJtqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYHMmMWG/tdVsF/XPXftZ8Pf04IYMukSB5KMVmm7Yp4=;
 b=Yc1defxelAGwjarnR5shdW3uAKSEih7mpiD6UeqAKTUh9YwPSIuky1NiNbKIkQdZ4Pyxy5HZEUpMRzv8y0BAb+6eKKKdFP5NdqzAlurSxAX/cOrXgWXEChZLgiIi3oCnNvib4KmjQLS+vOJYnc6MVzh7H9m0d6MtndtKAv2gGes=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4431.namprd11.prod.outlook.com (52.135.37.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Fri, 11 Oct 2019 16:57:29 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 16:57:29 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
Thread-Topic: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
Thread-Index: AQHVgFJI7oBgPIfynUuM0VKvgctb36dVqUeA
Date:   Fri, 11 Oct 2019 16:57:28 +0000
Message-ID: <8983882.YYcFGT5GfJ@pc-42>
References: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8390adf3-9916-44e5-0ae1-08d74e6c19b1
x-ms-traffictypediagnostic: MN2PR11MB4431:
x-microsoft-antispam-prvs: <MN2PR11MB4431ABDCEEE2BD91848792FC93970@MN2PR11MB4431.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39840400004)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(64756008)(91956017)(7736002)(446003)(5660300002)(11346002)(76116006)(4326008)(66946007)(66446008)(4744005)(81156014)(8676002)(486006)(14454004)(8936002)(66556008)(6246003)(33716001)(81166006)(99286004)(476003)(6436002)(256004)(66476007)(305945005)(71200400001)(71190400001)(6486002)(66066001)(316002)(478600001)(6506007)(9686003)(6512007)(26005)(186003)(3846002)(6116002)(54906003)(76176011)(25786009)(86362001)(2906002)(229853002)(6916009)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4431;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nj5VEewwEi3YBoFXok/oiBAjL4hr5Rvuw9SaolOhi2M1VTX7v9sa8ljffJHlpOv+7xZjkTGmH5OW2XqvBSJzgFiN12Bqg6K5g4mCVqEJbZwuyAJlG2hvacjZE4mW4z7ZeBA1FTEFO6/CZWN5NOW6+uyYG+gO+hl4sSCqdYasiWcQy4Ph7f6fxnOl63NNX/Wacobl6HOLPn2/l5HJt1xjs0qePo848dsVfQ1droDl70ZDKij/plGrYfw/UpUgvBdapZjlMw818I+LAeEJZW62Fg6zK5tUi39S0MANyFbZtgyJvuwJtHMK7vjVoOgKrScspBXdRHXperjJPM+vFvjk/cXUE7LDjVDuCWAetWIP0DKMO/8/r2sy1z4p7F9zQu7cAlngx+ko4I44EsS8f/6/GmZmZ/4skU/juQ6pZBeavws=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <562AF1E79216F040839C551244968015@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8390adf3-9916-44e5-0ae1-08d74e6c19b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 16:57:28.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrkRhKehuCym/DI6xold6ndjlq1gEqUwN2QnktFM1SnDMJaCmfiZfgagnF6847m6Sqn2ue8QlzLkT7hB9dQzpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4431
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 October 2019 18:38:17 CEST zhong jiang wrote:
> I hit the following error when compile the kernel.
>=20
> drivers/staging/wfx/main.o: In function `wfx_core_init':
> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: und=
efined reference to `sdio_register_driver'
> drivers/staging/wfx/main.o: In function `wfx_core_exit':
> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: und=
efined reference to `sdio_unregister_driver'
> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `s=
dio_register_driver'
> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `s=
dio_unregister_driver'

For information, I cannot reproduce your issue (it does not mean that
the issue does not exist). In add, if you obtain undefined references,
it should only happen when CONFIG_MMC is not defined.

Can you check that your Modules.symvers is up-to-date (by running a
'make modules') ?


--=20
J=E9r=F4me Pouiller

