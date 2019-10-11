Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51E0C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CEF20679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="XVwp0zjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfJKIkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:40:12 -0400
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:56648
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfJKIkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:40:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfwSucUD8bEATgxsXxWifFS55z2d1G1nHgmffVBN0P6TF4o48intvjXscYwqzSWfFaHE4wiE4LUpajnmmF0rMllPz6bFebRMzyyxLl0i+sdURV7uJnCnGtOLoYXaEML3WIqWfoQGoHW9nLH+2gG99H9iFZahVdWzqsT4sFkHyA+gRy1z8L/HZv7T7xQuC5J70bcHqoQ+4X3gAhq1DwFsOQbpp8/zulYeCkvBkXid/+Lz1fZnoB/uT/zYwqiFdI1nLeO2Xj8UDAEZXGhSax0nIDBhJT1236JqgSf4F298rB6PJjIFLkqrYWJFoW9Epw2llwRWw9cQ8HsW4iM9XLVuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aF7r0v8y2riA0+XMoaVU+3F9r+eZHhTCnkpQrSEM2k=;
 b=Y0S0CKbVw1gNvg483znWoGfU9vjkf9iIuVVqhajZZlTXoFUvS1D8doObkps2giyKatfHs9GJw0EBLn5Qm1jRnGUqg0gHGE8axq3Eg8ObGEfiQSLtOVS5ZNTurxN1/aK1uE9Rq2AUSGw8psAxnCJbiwOOBcuQH0M8ADuOKRZq4+eemtuz48bCBIFKu2R3SV7h5r70Wj6XeTcDyTXg2Jy891EG7CTkCO5lz28v4J6M5SlaWZfUfTloD+jLLk7IGomsFTgSR42td4tI4qHhPyzhVUYtC0OufgGT662g3D6IYS+3Mh4cB5DhyKb5Q/Tzayzbm4jnW+T8kmQAtLd7O/MvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aF7r0v8y2riA0+XMoaVU+3F9r+eZHhTCnkpQrSEM2k=;
 b=XVwp0zjIg2xJt6TulM0iInAh3wwjGJGwhbCsCBSH1+NqIRQLBEysOIGU8zgu2rYVYSqqaUOUUM2oIYq/f9Rq27DMHCWO4z6Mh00rsMUWDkytcnM2pewdK8FIv0iY9Px+6Xc9LwEaVjX/zXQD4H8+W56VzjTpRV5x5NmPbAiuqbU=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4510.namprd11.prod.outlook.com (52.135.36.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 11 Oct 2019 08:40:08 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 08:40:08 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     zhong jiang <zhongjiang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
Thread-Topic: [PATCH] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
Thread-Index: AQHVf+DaxlKENNqV0UK69LaFcVpmvadU2EGAgABG9AA=
Date:   Fri, 11 Oct 2019 08:40:08 +0000
Message-ID: <3864047.FfxYVOUlJ1@pc-42>
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com>
 <20191011042609.GB938845@kroah.com>
In-Reply-To: <20191011042609.GB938845@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 606cc717-78d8-4fa5-8f65-08d74e269f5a
x-ms-traffictypediagnostic: MN2PR11MB4510:
x-microsoft-antispam-prvs: <MN2PR11MB451027F133265326BE2EBDD793970@MN2PR11MB4510.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39850400004)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(54906003)(99286004)(256004)(3846002)(6436002)(2906002)(5024004)(229853002)(102836004)(86362001)(66556008)(66476007)(76176011)(66446008)(64756008)(6486002)(91956017)(6506007)(76116006)(66946007)(6246003)(66066001)(26005)(476003)(33716001)(4326008)(8676002)(81166006)(81156014)(6116002)(486006)(316002)(478600001)(8936002)(5660300002)(14454004)(71190400001)(71200400001)(305945005)(7736002)(6512007)(11346002)(9686003)(6916009)(446003)(25786009)(186003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4510;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGep/yvU5s6MByU/T5cWJ1vENOAarztgr3olULjw1RpQ0KbuOd8Ed/NVgzDee0QeMWTjTu3XlMpkhzfa9+uNeEwXFU22x/brBfoBmOFTu4lfXhNXoWBPvd6JD9RWYz9fzk96op+8bJHwYYrmTzuoSC2qnK0QA/EAgUishSXBWrSAY7TOPO6T2BzFmPlN8YuKZAwNUwhI6gWJ1/nYJ8jtTO1Rwi6P1Qed6DCw8td5pCNl2361JC3nPeSUFvdhiMIutIL0UBrgzcMiD2dKExah/0ad3dRQrwsdkTdxiXcqeaqfhWxq4nfFRg1KxH41b7WdwB0+yYL9YAc8sGv8Pdom3a7aHopyD+MeB/s7zN95qNCCJaglpdknSGCBUJsVnox2QK9aM7eWM8pwsefbcgO2Md371A0mXG1X1fIbGy47aoU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F73D7F8B23800F48BE574A21484DD401@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606cc717-78d8-4fa5-8f65-08d74e269f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 08:40:08.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZfmHcqjiuWxKSjwkA++topHRDUAkvyTb9bD4KtqR4gM7X6/NJ22uWhROcDsk0KZl276BU49IHGRi6migMpEpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 October 2019 06:26:16 CEST Greg KH wrote:
> CAUTION: This email originated from outside of the organization. Do not=20
click links or open attachments unless you recognize the sender and know th=
e=20
content is safe.
>=20
>=20
> On Fri, Oct 11, 2019 at 11:02:19AM +0800, zhong jiang wrote:
> > I hit the following error when compile the kernel.
> >
> > drivers/staging/wfx/main.o: In function `wfx_core_init':
> > /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488:=20
undefined reference to `sdio_register_driver'
> > drivers/staging/wfx/main.o: In function `wfx_core_exit':
> > /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496:=20
undefined reference to `sdio_unregister_driver'
> > drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to=
=20
`sdio_register_driver'
> > drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to=
=20
`sdio_unregister_driver'
> >
> > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> > ---
> >  drivers/staging/wfx/Kconfig  | 3 ++-
> >  drivers/staging/wfx/Makefile | 5 +++--
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/wfx/Kconfig b/drivers/staging/wfx/Kconfig
> > index 9b8a1c7..4d045513 100644
> > --- a/drivers/staging/wfx/Kconfig
> > +++ b/drivers/staging/wfx/Kconfig
> > @@ -1,7 +1,8 @@
> >  config WFX
> >       tristate "Silicon Labs wireless chips WF200 and further"
> >       depends on MAC80211
> > -     depends on (SPI || MMC)
> > +     depends on SPI
> > +     select MMC
>=20
> How about:
>         depends on (SPI && MMC)

I dislike to force user to enable both buses while only one of them is=20
sufficient. I would prefer to keep current dependencies and to add
#ifdef around problematic functions.

(I though I had a test of compilation w/o MMC nor SPI, but I realize
that it did not work)


--=20
J=E9r=F4me Pouiller

