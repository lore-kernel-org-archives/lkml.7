Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F7C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 05:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAC220848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 05:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n5uXhLly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEPFu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 01:50:26 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:15008
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbfEPFu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 01:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea7s7gV++ju0odhg74nZ2Is4HRr9jlcD4nSEDbl05YI=;
 b=n5uXhLlyY/esrbWTrMqsjbg/pQot7odyIsKdKqltbF6WhAf3OKVxxdscqX3JP+PoBsJf+hucZDDvxmD2cagmvvz9DLpVO0CAeIQzV0azPhORZJ7NFO0Lg4im0QFZMSzrjBQJQ6n1X3c/tlhzujRN0cajZBLHCAtL+SQvC9LbtKo=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6557.eurprd04.prod.outlook.com (20.179.234.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 05:50:22 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 05:50:22 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs42xx8: Add reset gpio handling
Thread-Topic: [PATCH] ASoC: cs42xx8: Add reset gpio handling
Thread-Index: AdULqw8bAAGC7faUTbaffmppV3l1ug==
Date:   Thu, 16 May 2019 05:50:22 +0000
Message-ID: <VE1PR04MB64791493BF55A587AD10B267E30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fae456c-2a09-417e-8466-08d6d9c262b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6557;
x-ms-traffictypediagnostic: VE1PR04MB6557:
x-microsoft-antispam-prvs: <VE1PR04MB6557262E417B86038A9C027FE30A0@VE1PR04MB6557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(6506007)(229853002)(9686003)(26005)(4326008)(55016002)(186003)(6116002)(68736007)(486006)(8676002)(316002)(2906002)(81166006)(33656002)(52536014)(3846002)(81156014)(256004)(102836004)(6916009)(14444005)(71190400001)(8936002)(71200400001)(66066001)(478600001)(99286004)(66946007)(76116006)(73956011)(5660300002)(7696005)(66556008)(53936002)(64756008)(66446008)(66476007)(476003)(54906003)(14454004)(6436002)(74316002)(4744005)(305945005)(6246003)(25786009)(86362001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6557;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WpW20+S1PHDW7fbJeXsEb65ZddGH161kdOeA8mdOXLREYjBqtK6dkTZ6VxcCczAdOe2q1rar8bgaQrqqh+sfitQYPbmKMWPUKJyxFDeTONvUIXhJl759zOwfL1YnVxgCIxDfoOa1FQKebkB13UxA9OVIQ4T8Y4lhJ8G6FwUgs/ZctNkUTDwFqNCsoKMZvPxHJvknKtTArA0lnfEBJTs2zLZMbXsvl3SCLc02ji1fVYnTcq8WKyi4/mPVECq00CEum7549eaSWN5gU8E8Pb1SfmZ6JcmqRdAu7EH/4MyO+Bnlfk1yArZ5N50eWxZvPHZGkBYqVEtDTIch8kQIvufvf7HgR8QfNJMsTqlkGIXb1UoSPMw67N0AAfcM77eoK4U+QezqlLNoYdQaWmPUCr4sdVbegYHNWJ6HRmM1q7GZFyI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fae456c-2a09-417e-8466-08d6d9c262b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 05:50:22.1298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

>=20
> On Mon, Apr 29, 2019 at 10:46:03AM +0000, S.j. Wang wrote:
>=20
> > +	cs42xx8->gpio_reset =3D of_get_named_gpio(dev->of_node, "gpio-
> reset", 0);
> > +	if (gpio_is_valid(cs42xx8->gpio_reset)) {
> > +		ret =3D devm_gpio_request_one(dev, cs42xx8->gpio_reset,
> > +				GPIOF_OUT_INIT_LOW, "cs42xx8 reset");
>=20
> You should just be able to request the GPIO by name without going
> through of_get_named_gpio() using devm_gpio_get().
>=20
Will send v2.

> > @@ -559,6 +577,7 @@ static int cs42xx8_runtime_resume(struct device
> > *dev)
> >
> >  	regcache_cache_only(cs42xx8->regmap, false);
> >
> > +	regcache_mark_dirty(cs42xx8->regmap);
> >  	ret =3D regcache_sync(cs42xx8->regmap);
> >  	if (ret) {
> >  		dev_err(dev, "failed to sync regmap: %d\n", ret);
>=20
> This looks like an unrelated bugfix.

Will separate it to another patch.

Best regards
Wang shengjiu
