Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B533CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C4920663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="hmo550W/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfJNJx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:53:26 -0400
Received: from mail-eopbgr700073.outbound.protection.outlook.com ([40.107.70.73]:13313
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730740AbfJNJx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:53:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO4f1sYZm1+OQnkJiWtT7Bd4ZmhmrCZgQbJ5e+mvlP1imCuT0ZSln48+aGbqikQ+zaKyxe7+xITtttgViA44d05PkD3V2ZBL+8IC5pFY4CIIeOX3JXoZqs0wsoF+j9aGIG4nKrKZ1FEr9XZT08MDhAxSN+ivXUcKqKRRMibQViIlx9eXFPbOior1AaVL53TDNgHZi5cvdbSh5U0vPR/g/9y9aloBVPugkPj6XFk1kJ3mTIx0u/Y5wP7d4r0nw93cukSzj7hrmxb5wWZausYdHQwBJdIXHrBkcN9M9NnmY9a1ABwQkTBx74YBph0VVOQcMs/TE3T/Vr9Yy65CMUcMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+05AGm4PywWTu7smy3NpVfBM/tZ/OMAWEXhh4GbJs/U=;
 b=AUQAsR4nA+mMvuVKuHt7jUygtfkycGjIa44G0/Ekza2TwhjsR7ltS44BJYAfEt9EeqEnag/jCsNfsg5WCD8eI8crpqSy0s+QcPZKEMaQaCv2GX3UBD3ZcD0/56NxdPY7NZRTvx+V83J+gurrBPpf+LGIKuuOR1+RGUheuN9x+XPIIeZAHe+wDyZBOJ/Q02TZtHTH3IDAT/qjNGhjaqB1DbGUZucDY6nDE6kKoK5dFUYkXFEfk7eH7pRzMQROHZ49AGfHVNVdsHh0erGcs+1oFd2VHsO9I+LZsEfzMheTR1u0bMkRIxK62jriwrSIasZCFV/Pt0L/00EfLP3wEEPEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+05AGm4PywWTu7smy3NpVfBM/tZ/OMAWEXhh4GbJs/U=;
 b=hmo550W/whmp3AElG19FbePB2BlZq4itSUYR7hBuoSpb29VkuRvOJ2LMOWTe6N3NPzGObI7eAc60dc4r/ge3CQifvv7wHv/UyUms38WNvzsNERZom/6pRZy1prfHjlrA4mr/YPaK8frXD0Co0r22icBIZd6xgMD0SGDThEwzD4E=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3903.namprd11.prod.outlook.com (20.179.149.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Mon, 14 Oct 2019 09:53:21 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 09:53:21 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
Thread-Topic: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
Thread-Index: AQHVgFJI7oBgPIfynUuM0VKvgctb36dVqUeAgAClQYCAA5s9gA==
Date:   Mon, 14 Oct 2019 09:53:20 +0000
Message-ID: <2927969.oKuMf0pyRb@pc-42>
References: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com>
 <8983882.YYcFGT5GfJ@pc-42> <5DA13F17.6090409@huawei.com>
In-Reply-To: <5DA13F17.6090409@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20917279-004c-40fb-2f0b-08d7508c58e5
x-ms-traffictypediagnostic: MN2PR11MB3903:
x-microsoft-antispam-prvs: <MN2PR11MB390373874CDB2889E0DFC4CC93900@MN2PR11MB3903.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(366004)(346002)(376002)(39850400004)(51444003)(189003)(199004)(91956017)(33716001)(54906003)(66946007)(99286004)(76116006)(7736002)(26005)(86362001)(186003)(305945005)(71200400001)(5660300002)(66574012)(14454004)(66476007)(66556008)(64756008)(71190400001)(66066001)(66446008)(478600001)(6512007)(5024004)(316002)(53546011)(3846002)(6506007)(6116002)(8936002)(9686003)(2906002)(6916009)(256004)(446003)(11346002)(25786009)(476003)(6486002)(486006)(4326008)(102836004)(81156014)(6436002)(8676002)(6246003)(81166006)(229853002)(76176011)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3903;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dtkAu3Q3XzgmzmeErLUhfsrYoIAKwnUocb6RCYdlbrAkaqV0Np3TcBRJxmeBu50BXCZdY1EqUaqBTIfD/lHT6wEz0zhpJw7yxypPtmGEWfZicOxwD8J4v1lFDFfdtSARx3rYt/StnqPeHLDWgbTe4MUk/ytgyDqRb+QkCCywqlwB4upfLKPgwiuy8lsG+Gk4ARA9sGXr8IgwoQbFM9NE6aGyCWm1PDhuCxAZrZmmlIi9/zAPik8mLabbVYpXJVTIKqAEUKgoQlw+O+EwWnlDZCQl15bcaH6IKj2m9xygfGwlDDHIvU7+ISkjW8+W1qTVx103lYRROd3Lco1Y9RurF7oHheXfkW5lIhOqdyyRWmhTcdmBNjkymwNZnp9oueTnuxDtJkBoE5ZBg/vv7clt16dNBnJ1kBAwfBg6mm9jZzQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <60C64D228EA49F4DBA54A93860F3A0D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20917279-004c-40fb-2f0b-08d7508c58e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 09:53:20.9125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p56gV+BwkDyc/qXQXycfmtEdpUD4B3v6RDQnUTZxj0rWtfhmOoG5PklVtZ5pfzpPIViHvnzyBlhyjfd/fAKidg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 October 2019 04:48:55 CEST zhong jiang wrote:
> On 2019/10/12 0:57, Jerome Pouiller wrote:
> > On Friday 11 October 2019 18:38:17 CEST zhong jiang wrote:
> >> I hit the following error when compile the kernel.
> >>
> >> drivers/staging/wfx/main.o: In function `wfx_core_init':
> >> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: =
undefined reference to `sdio_register_driver'
> >> drivers/staging/wfx/main.o: In function `wfx_core_exit':
> >> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: =
undefined reference to `sdio_unregister_driver'
> >> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to=
 `sdio_register_driver'
> >> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to=
 `sdio_unregister_driver'
> > For information, I cannot reproduce your issue (it does not mean that
> > the issue does not exist). In add, if you obtain undefined references,
> > it should only happen when CONFIG_MMC is not defined.
> I attach the config,  you can test it and reproduce the issue.
>=20
> Thanks,
> zhogn jiang
> > Can you check that your Modules.symvers is up-to-date (by running a
> > 'make modules') ?
Hello Zhong,

Now, I see the problem. It happens when CONFIG_MMC=3Dm and CONFIG_WFX=3Dy
(if CONFIG_WFX=3Dm, it works).

I think the easiest way to solve problem is to disallow CONFIG_WFX=3Dy if=20
CONFIG_MMC=3Dm.

This solution impacts users who want to use SPI bus with configuration:
CONFIG_WFX=3Dy + CONFIG_SPI=3Dy + CONFIG_MMC=3Dm. However, I think this is =
a
twisted case. So, I think it won't be missed.

I think that patch below do the right thing:

-----8<----------8<----------------------8<-----------------

diff --git i/drivers/staging/wfx/Kconfig w/drivers/staging/wfx/Kconfig
index 9b8a1c7a9e90..833f3b05b6b4 100644
--- i/drivers/staging/wfx/Kconfig
+++ w/drivers/staging/wfx/Kconfig
@@ -1,7 +1,7 @@
 config WFX
        tristate "Silicon Labs wireless chips WF200 and further"
        depends on MAC80211
-       depends on (SPI || MMC)
+       depends on (MMC=3Dm && m) || MMC=3Dy || (SPI && MMC!=3Dm)
        help
          This is a driver for Silicons Labs WFxxx series (WF200 and furthe=
r)
          chipsets. This chip can be found on SPI or SDIO buses.


--=20
J=E9r=F4me Pouiller

