Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ACEC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2075820673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="LkO6drc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfJKPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:55:18 -0400
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:11616
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbfJKPzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:55:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3zwxaLnqmVHElxPvdV9NIeAKVaWN3ZWN0wkPUbOooEVnwlkT0unqK8NmyQ/51dZvlvvkm4QJTGgAWzQ6oxMVc7y08KoDfX8OgRjkar/2mX2wqFZW9/T1thv+hg4iZ1lMvAGgmvzi8NtHGg4rlcJHkNv3FAjrTLJ0p2ZWqBwnbfdSErTyabqx0oBKiYQj4dsZsN/lMlpO1GINml6r+O8BZJBQPB3BprwHQYThkg7GYcbgS2N2RnDiwrcQCc2CmpgnUkxI0tnoCb5kXujxE5+Ve5toxSrc15Yf+uI04TlT8IVHKO+hjSxBRoEv12pKKBOIK9kzZosOeLtOuktyMWvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li0w+uSpYpmR2c3XL5t93NlqQixtZbw36KcqeoXhmQA=;
 b=BivkJUytS25NYcMeR5li8nri5SzNgimE00XlbHZ/XGhwZWb8Q3DOKw4Ms1tc6Jwa4NytFi8wDfYNhK6fv3qnwpZ4aLKYSBKXrGJSIsMdD2ZPlISSfTr07kWvzFnoCxocI/OHQQljcfc87G0GUedqfQe05hLEs2C9ynm/h1X211Tta6LKMI//GcuJbufqGK4fTSmFNzYx3VkesoJhd3tPuQDuDULvUIHZ0M7eSkHrOh9hZz3CqK0AxFOAFsoLqi+GzqqrWgK3RFVMG9zR2Iijw48zpdPiNKVmLEQaFUMtvsCASlLCwOZ6Db0BaJaasF3qz8zWQfr2UlzGfFDHxxnt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li0w+uSpYpmR2c3XL5t93NlqQixtZbw36KcqeoXhmQA=;
 b=LkO6drc//QdHDpoMMYgNgT7wSU2qhShrg6Akr7luTANlG0ZEb/qkm/5QwGRAMUSGjFJGFsE5eDDSQ5KTvKq/CS2vYkIDFEjeIncu8AeYjaV85V//nVFB049rtYcSGCxG57z2ge1dJ1EX2jN55vZ4Ewnrn4Jltw94qbjdyNGjtS4=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3631.namprd11.prod.outlook.com (20.178.251.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 11 Oct 2019 15:55:14 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 15:55:14 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
Thread-Topic: [PATCH] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
Thread-Index: AQHVf+DaxlKENNqV0UK69LaFcVpmvadU2EGAgABG9ACAAAZhAIAAchYAgAABG4A=
Date:   Fri, 11 Oct 2019 15:55:14 +0000
Message-ID: <25343442.QKQdTnp5z4@pc-42>
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com>
 <20191011090256.GC1076760@kroah.com> <5DA0A4F4.4050103@huawei.com>
In-Reply-To: <5DA0A4F4.4050103@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6beaf1bc-2f01-4055-42ae-08d74e6367a3
x-ms-traffictypediagnostic: MN2PR11MB3631:
x-microsoft-antispam-prvs: <MN2PR11MB36319D44893311B7512F3D7E93970@MN2PR11MB3631.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(346002)(376002)(39850400004)(366004)(199004)(189003)(305945005)(71190400001)(478600001)(71200400001)(7736002)(6116002)(8676002)(3846002)(54906003)(316002)(6246003)(2906002)(33716001)(25786009)(76116006)(6916009)(26005)(91956017)(64756008)(66446008)(186003)(66946007)(66476007)(66556008)(476003)(102836004)(86362001)(5660300002)(6506007)(6486002)(6512007)(11346002)(8936002)(4326008)(229853002)(76176011)(486006)(446003)(9686003)(99286004)(256004)(14454004)(81156014)(81166006)(6436002)(66066001)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3631;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1eMGhx3kmam8SFAB5SbGaEAfDZSuOZ0GGN82EFFw4RDnzIE6k1BYh3C807vAy4e5h0HJj+j93Spz3E2+6kWVisl2SDnXstuFAPaL7JDdnVnNPQZXppaC0eSRnsoi+Oj5Qd2kKIuSTGce021nCDkpf6hKsrKxWM3CegE5RaAv4b99HuKU0yLXDf4bD4vGbN+7j1NStuRtC+5lt0GLD6HPjQmlyyMRELThi6XumpbKD0wHtb9DwF1HXy9a7dlWw9Q0JHAX2V4hyCIgBsFOxjzZb4iBcMRc6ijtd0Q3dHReW/RwNOnLXz4IMj48434P4NCz3N9gxNkPON78AqUXwtLKF5BhWjrojMYw/xbx8VhIOgGW5e0JJiYimthdbX0D7WuJ6nyEinWOs9JIULjk3LKKzsKNlDpbfcl9Gamgxn1z2A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B3F9255740D2D846BF850F7099619AF3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6beaf1bc-2f01-4055-42ae-08d74e6367a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 15:55:14.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERmu3h7lXD6HoUMb0uyyfiq0M42H0lEPrH+MObL/DA7w4GlcCFS0se4hNf+Fr/I00gP3PHHrhtQsqG+I7DVD6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 October 2019 17:51:29 CEST zhong jiang wrote:
[...]
> How about the following patch ?
>=20
> diff --git a/drivers/staging/wfx/Makefile b/drivers/staging/wfx/Makefile
> index 0d9c1ed..77d68b7 100644
> --- a/drivers/staging/wfx/Makefile
> +++ b/drivers/staging/wfx/Makefile
> @@ -19,6 +19,6 @@ wfx-y :=3D \
>         sta.o \
>         debug.o
>  wfx-$(CONFIG_SPI) +=3D bus_spi.o
> -wfx-$(subst m,y,$(CONFIG_MMC)) +=3D bus_sdio.o
> +wfx-$(CONFIG_MMC) +=3D bus_sdio.o
>=20
>  obj-$(CONFIG_WFX) +=3D wfx.o
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index d2508bc..26720a4 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -484,16 +484,19 @@ static int __init wfx_core_init(void)
>=20
>         if (IS_ENABLED(CONFIG_SPI))
>                 ret =3D spi_register_driver(&wfx_spi_driver);
> -       if (IS_ENABLED(CONFIG_MMC) && !ret)
> +#ifdef CONFIG_MMC
> +       if (!ret)
>                 ret =3D sdio_register_driver(&wfx_sdio_driver);
> +#endif
>         return ret;
>  }
>  module_init(wfx_core_init);
>=20
>  static void __exit wfx_core_exit(void)
>  {
> -       if (IS_ENABLED(CONFIG_MMC))
> -               sdio_unregister_driver(&wfx_sdio_driver);
> +#ifdef CONFIG_MMC
> +       sdio_unregister_driver(&wfx_sdio_driver);
> +#endif
>         if (IS_ENABLED(CONFIG_SPI))
>                 spi_unregister_driver(&wfx_spi_driver);
>  }
Hello zhong,

Can you also check the case where CONFIG_SPI is not set?

Thank you,

--=20
J=E9r=F4me Pouiller

