Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571BC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAF7217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S10PDyI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411856AbfIYGOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:14:40 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:34150
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404606AbfIYGOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:14:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKDK3UC++eWzCA8xg8JJYb/w2Xk/o+cP0ff/91YN+1eI9CWNfwP3xAKEudh1oUT8rjk4tPXi2spYeyaZnZfpC/oe8+4GYzEiANvrwiAjXoO8sFGocNMYwyd6MmbbOBED5PdDKl5BtTtskZIBGtCvWbDizDul3gQxD4POoJmF/JSJ+C8jjbLAyqcPCvMHTXWul11prsCQDiURToaOJsptGUJDpQSZqssNUbojL1KQ0cCrXebqem6cj39G+DonXJMu7edsBnUYn85Cx0Vrwi1wzZUZpeZkcEcvjwHisEUAXf1YNA9MfOgZ9FBk73LgqutEYhoNrfshdpstaBH8IT+NAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFFqjkSTwjWJ61G2p/Ns/OxWyB6zFWGzNWYZpu9nznk=;
 b=Aij/c5v5dCNbt8Tt4sEmUwhjB/fdHayD2EAwI+zAf4bXcWhHHwtKA2b8icZRAT/rwnVxCwT9zR1mhHHbOO03CSiDahv3+5BlxKLOJtA3AGA/t3qoBUnI3KIxu6WyKPQwkaplMwZi4rJDgRawtaNDi0fjbPFC63lAwjM9EpAjtaCjjXM/zvHRLdP3YhkrkjgUSBfIh8CnysXdbtonxdziS2dkhdjfdEiNNYfPlhMeIufpZj/IvyyELpAoJpkx1xepviS617ev5PRjmfLWGg1a+jNZU5p00LpUOoyAkvgO/B5a8IZe7GJ3s1Fw8BCFcq0MY1L9Bm8WeAVd+Qr43PVkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFFqjkSTwjWJ61G2p/Ns/OxWyB6zFWGzNWYZpu9nznk=;
 b=S10PDyI7YCAR4PxxQliKTCExL4i+UEoFomsWNGj2kI3ccX3NYeJd4VNOc7AH3RWyZ7CDpPXRVHcP8Nivou400pPzOgYOioqbKYUDU8aYEFOZG3dY0zw6I2RgmApdMXxQmSeiJGaQYWKQVWxQ8VYw1NuobEfOUgDAXCkYQpaKLBQ=
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com (20.179.24.74) by
 VI1PR04MB4270.eurprd04.prod.outlook.com (52.134.31.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 06:14:35 +0000
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::c887:7d43:1e17:9485]) by VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::c887:7d43:1e17:9485%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 06:14:35 +0000
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 4/5] dt-bindings: display: imx: add bindings for DCSS
Thread-Topic: Re: [PATCH 4/5] dt-bindings: display: imx: add bindings for DCSS
Thread-Index: AQHVc2iALMH+ZTgD6EK6yTZZJtKpAg==
Date:   Wed, 25 Sep 2019 06:14:34 +0000
Message-ID: <20190925061433.GA16686@fsr-ub1664-121>
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
 <1569248002-2485-5-git-send-email-laurentiu.palcu@nxp.com>
 <CAL_JsqK1egTpkqsgVUMUiYzKvVJ=nWtJu+OeujJotRCD9ADsnw@mail.gmail.com>
In-Reply-To: <CAL_JsqK1egTpkqsgVUMUiYzKvVJ=nWtJu+OeujJotRCD9ADsnw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.palcu@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7e88fe7-1cb8-41d3-2b44-08d7417fa331
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4270;
x-ms-traffictypediagnostic: VI1PR04MB4270:|VI1PR04MB4270:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB42709C77C7BD6966E5858437FF870@VI1PR04MB4270.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(52314003)(478600001)(966005)(71200400001)(71190400001)(5660300002)(3846002)(6116002)(1076003)(81156014)(81166006)(26005)(7416002)(7736002)(8936002)(305945005)(8676002)(45080400002)(66066001)(316002)(2906002)(14454004)(86362001)(54906003)(99286004)(25786009)(102836004)(44832011)(6512007)(9686003)(476003)(33716001)(256004)(446003)(33656002)(229853002)(6486002)(6436002)(6306002)(11346002)(66446008)(64756008)(66556008)(66476007)(4326008)(76116006)(91956017)(186003)(6246003)(6916009)(486006)(76176011)(53546011)(6506007)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4270;H:VI1PR04MB6237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Zp2xphtbR3Umwk5sHTwyIfeXBtZzn9hrl0gj2whMI8NJfvublIRnRw75w34IlqUXXQBxSENt1wvESitBrh545vk1fKCkZcywpq7MJkDS7iet+y/evsniXt9pOTeB7tUvdL50E2o5sabuBYfDoHg3TyA+pJykjtebqF8aQdqkcXSvaiDLkFgpcDg8hhDLVhGlPNJXRqRlQqSonjjF5kCjuefDRVmmP93JuIFWTLRkac3Cd2nVHdRjlOQXdz/Ek6zIkAb75MkGG2kfnQEeaWG4HlVn9vn+f70qXJPSfX1GcVIVJ1cJqYm9n2iqVI+XuS7ADqzEoGTJ453XZjf7u7AFZ3/bJMxbTqE2tSN8YU68B5yZYf92EZiOZKW+aBZCAAvvEclj2VTTLN1fVAt0eOgyn1mDzeJ9NGtfxnLaCVzrqFStPq6TxnL4gJahjxpsu0h4EMxZecdOjkKzSSoXO6LPw==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C68E1DEA7D81984A98B5320990996987@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e88fe7-1cb8-41d3-2b44-08d7417fa331
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 06:14:34.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzdu8ZmyCyuD0/aVGrKqMrcMdF1X2aCj+R19uN93QSR0fefFJbBgZ8g0kAdxg74wYma/gkMG8WvKbQx16BcUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 24, 2019 at 01:53:28PM -0500, Rob Herring wrote:
> On Mon, Sep 23, 2019 at 9:14 AM Laurentiu Palcu <laurentiu.palcu@nxp.com>=
 wrote:
> >
> > Add bindings for iMX8MQ Display Controller Subsystem.
> >
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > ---
> >  .../bindings/display/imx/nxp,imx8mq-dcss.yaml      | 86 ++++++++++++++=
++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,i=
mx8mq-dcss.yaml
>=20
> Fails to build with 'make dt_binding_check':

Must be because of the extra '0x' Stephen Boyd pointed out. Funny thing
is I ran:

make dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/display=
/imx/nxp,imx8mq-dcss.yaml

at my side, before sending out the patchset, and it passed. The command
also runs dt_binding_check, AFAIS:

  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
  CHKDT   Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yam=
l
  DTC     Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.exa=
mple.dt.yaml
  CHECK   Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.exa=
mple.dt.yaml

Not sure what I'm doing wrong when running it. I should've catched that. :/

Anyway, already fixed it and will be included in v2.

Thanks,
laurentiu


>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.ozlabs.org%2Fpatch%2F1166073%2F&amp;data=3D02%7C01%7Claurentiu.palcu%4=
0nxp.com%7Cf97847ce739b46fdb72308d74120858b%7C686ea1d3bc2b4c6fa92cd99c5c301=
635%7C0%7C0%7C637049480244424980&amp;sdata=3Dfjyq52livEnMAQYzVAGqO%2FOtmLS8=
3dungSvPqHYle10%3D&amp;reserved=3D0=
