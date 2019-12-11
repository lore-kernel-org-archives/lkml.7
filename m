Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0FAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E783520836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vduw1Tja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfLKTCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:02:10 -0500
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:22754
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfLKTCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:02:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO5ul/z7UV5tEe0otCSUvNVV/L8RP92eLMATc91Tk6pYHzpAeT9SsPfopWi+139GgMTQVN33J1mEjb5Ptu/Eko18UWIznOcFqMr43OqU3uzLXq0wo1JxNcAdz8OJeh2h+6BFWj/aA6CEnjQnUcFIczuFo0P2sQU/QkiPbRwX86E6Hk3xurS2KaFVhnk3oRccQlQdFUoTviByli8RAkXaBTDbp2NXxEKr4m8Uw3DMx+oXQ4JzliPp8OR7uhbtU5q8t/3/vlxYWLAQpI921NlCINJJKzN1fHH6M2eB65IQffLYuv+gDEj4FVXzNONzlMUZ0lmqgL4xGokMNL5GnyHk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p84eRk741lz7IGIYwArEn8coPP4VtOUYtZcFlNjYRk8=;
 b=KQG/KHiFfqQr3YoK2vHV9wz953uNEJJ6pflnrxBoo2XnckVu+9M1+Vw6PGPuGmxZMVuCgjJV4JZWqVmbAhWyyssH2Vx8+iaNFIJ0qkn57vKb6DYJEF3n+SjMCv6kqpKmcTwDYG2Y8VF3Wpgs0mahAi/bfW8cgAnjQ3pZIKyvC7Riuy+oFw4GBRRRrmNdxf+rlAKDf1tp/f6fW1oMhPXLRNfsjmv2V87osGgt2gTlF7wMORuP8vpfu3PgE3Bb0hAHZ5PVEfLZnHtqZicKiR2KUVov/suJ3f5WI2MKcLlMdQtK+//z6d8QbhNeqJECzOwdgzsP/hDJeICh29b9ZJKWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p84eRk741lz7IGIYwArEn8coPP4VtOUYtZcFlNjYRk8=;
 b=Vduw1TjamA13D316vU8slDzmRtxAUG/sCdRY4tSAzUZDrumTpucNicId4GSyCdw4YgqEFLTCIVKfHj25kZhT3VW8MrJmVapkhmZfswSl22/6YE83qb/c4FV1BYZMIBqSArROISnNZ42blKiZZP8vajuirqsf40iOLvvXdPR5ncc=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4639.eurprd04.prod.outlook.com (20.177.56.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 19:02:01 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2538.016; Wed, 11 Dec 2019
 19:02:01 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kusanagi Kouichi <slash@ac.auone-net.jp>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Explicitly restore
 CONFIG_DEBUG_FS
Thread-Topic: [PATCH] ARM: imx_v6_v7_defconfig: Explicitly restore
 CONFIG_DEBUG_FS
Thread-Index: AQHVr4AXFWCYT7RQ1UiK+6Snv+c69A==
Date:   Wed, 11 Dec 2019 19:02:01 +0000
Message-ID: <VI1PR04MB702329852A1DEF9B87414E5DEE5A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <41ed3514ffb9a858445150a91933b96e12086d73.1575998907.git.leonard.crestez@nxp.com>
 <20191210204544.GA4078779@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e242d44d-d912-4c77-7421-08d77e6c9af1
x-ms-traffictypediagnostic: VI1PR04MB4639:|VI1PR04MB4639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB46393D38430711391EAF1A44EE5A0@VI1PR04MB4639.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(199004)(189003)(66476007)(2906002)(110136005)(64756008)(8676002)(66446008)(66946007)(186003)(478600001)(91956017)(316002)(71200400001)(66556008)(54906003)(4326008)(76116006)(33656002)(44832011)(6506007)(966005)(53546011)(9686003)(81166006)(26005)(86362001)(8936002)(55016002)(5660300002)(7696005)(52536014)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4639;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2FA0upkxzgQTiQ4CM59LBjlTpIBYewK1ISTjBhl6T+KReeFlr1yUyO1U294xUi3k+J0evIP1rEDgZ/lJ/SX4DiXreTkc7EVHqNF2bD0FmEPQstTENd5X5RktVKKyyQFjT+aoIG+XBY2N64Ys584xMXHSvCxdWS3VPxVFi6CDT+hsH69bA+hRCxGUIFfm62H97tukjHRktiNNXr7mTI1RsYXiHQgdJWdM03p/id+DgZ5EEnsO4W332MVLLNgOk1tV4zmr4Tq8/Nvc12tPgDZG94V7bK8SyorCth4IqXn0DUjmNNiKW17+9ZJjwlGdk1WcBeYFYJwf6CNB7Tw3Fn5p5ifS6GnYHHLe1fWlpedNqjDz2M3QF7zD35zuPI1SPsfLk2xE3DG9PHN0hTY6fxR/QDY0YctNVEjjsSX4DerZF+GqY52KYfxmyd4Bmz5VJE+V1jonL2RpDKyjEkFnIvxvyJrMqRet7fAjP64kYzIcB8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e242d44d-d912-4c77-7421-08d77e6c9af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 19:02:01.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90KwEqTshu0yTwDWdLcAXhtJ4o7qZK9BxiMQNAHQzCloP62gUYVkak0NXVntjw161E1KxYYh6a6YuaCx7jNgDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.2019 22:45, Greg Kroah-Hartman wrote:=0A=
> On Tue, Dec 10, 2019 at 07:34:20PM +0200, Leonard Crestez wrote:=0A=
>> This is currently off and that's not desirable: default imx config is=0A=
>> meant to be generally useful for development and debugging.=0A=
>>=0A=
>> Running git bisect between v5.4 and v5.5-rc1 finds this started from=0A=
>> commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS dependency")=
=0A=
>>=0A=
>> Explicit CONFIG_DEBUG_FS=3Dy was earlier removed by=0A=
>> commit c29d541f590c ("ARM: imx_v6_v7_defconfig: Remove unneeded options"=
)=0A=
>>=0A=
>> A very similar fix was required before:=0A=
>> commit 7e9eb6268809 ("ARM: imx_v6_v7_defconfig: Explicitly restore CONFI=
G_DEBUG_FS")=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   arch/arm/configs/imx_v6_v7_defconfig | 1 +=0A=
>>   1 file changed, 1 insertion(+)=0A=
>>=0A=
>> Any suggestions to prevent such unexpected kconfig changes in the=0A=
>> future? It might make sense for DEBUG_FS to be "default y".=0A=
> =0A=
> What?  No, no system functionality should _EVER_ be dependant on debugfs=
=0A=
> being enabled at all.=0A=
> =0A=
> If your kernel code requires this, then you are doing something really=0A=
> really really wrong.=0A=
> =0A=
> Now if you just want to have a nice debugging system, then sure, enable=
=0A=
> the option, but it is not anything that should ever be required by any=0A=
> working system.=0A=
=0A=
I just want a nice debugging system, my concern is that kconfig rule =0A=
adjustments sometimes unexpectedly break this. This issues apparently =0A=
also affected shmobile: https://patchwork.kernel.org/patch/11278961/=0A=
=0A=
Config options which can be manually controlled but are also "selected" =0A=
from a whole bunch of places can get lost after savedefconfig=0A=
=0A=
Would it be reasonable to make all users "depend on" rather than =0A=
"select" DEBUG_FS?=0A=
=0A=
Or perhaps DEBUG_FS could be "default y if DEBUG_KERNEL"?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
