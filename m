Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2A3C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47682075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZu8LgeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgAIIUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:20:41 -0500
Received: from mail-db8eur05on2047.outbound.protection.outlook.com ([40.107.20.47]:26009
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728331AbgAIIUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:20:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlSmpeFF5ckBEz9xAOgS3CIztpAAZ1Jx0w+iF+HqUU7V71lZ8VONHFVpOnsi1q1kvpv6rOcuKSPx3YIkjU4DSPHztqnkDSS1H6yohTaT399JLegUFmnG53QravutNEAyhaaJtTcUmo15UK74OUGE5+sUk/BrbVGvnJyG92eEFNXzAYNxOlKPk6HdSPwvntSx0l1gPH8uCW0hDSI6Fjau98qaHWcjEJKwDnDbzisJWCe7/r9JFztcArHLdP3jtGx8eF0rXiVcIALneNOeFM5m/yjbBTp1VVjk8dkix6ofMh1wY8ivIXPGM4wmbV4L2OUvZSu5Ur40pdjtTkHhMIqcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/RlDsNBIbovVw78AZrEWsHUv0BHUUi0PAnQAQ1O3Yo=;
 b=BrXqZAjruzsFjlBWXUp4wpXRCTmRtnkGnr8StFxJt9JhjNrl3XqHjf1IjS4OL9sYj7QDT3Xd18fLGX7mNTvsoFpB17u2bJgpD3okKy4/nrYfNcvVKvxsbiAEkwpbkoGSPW5fZWLLjEHXPFdkp439yFkU6NeT2jFHcBLh6Ai7ac2xUsyI3tQRuO4hDHlCzCUJ3mE3731SaFsATmt7Yh3zH4G1nobLyYvqbnuld4L3GbJCGROc/1c5CpznmPxzlOLHKuAvr2erqR24wissE3merdAfb5Qaude9nz+piIc0tIJQpGTC+Fv7x3KfJMdAxfJycyOxMarjh1kKXj3ka94YPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/RlDsNBIbovVw78AZrEWsHUv0BHUUi0PAnQAQ1O3Yo=;
 b=AZu8LgeDcT1bTZO3bILew6E65MusLMuyzIBiFcUquyOyJnm3W0mi2qN9+crRidXb0AMYy4zrh71dMGB2RxM7DqRjAe+VyCcZRaT1WPDx18q8OSMdNE2x8fgyjzcB8D+NzA2hokHTR9eOKCzlFYGGdQr4axN6yjKTV/t1KKu0F6o=
Received: from VI1PR04MB4496.eurprd04.prod.outlook.com (20.177.54.92) by
 VI1PR04MB3229.eurprd04.prod.outlook.com (10.170.231.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 08:20:38 +0000
Received: from VI1PR04MB4496.eurprd04.prod.outlook.com
 ([fe80::25c7:9207:684a:5e2b]) by VI1PR04MB4496.eurprd04.prod.outlook.com
 ([fe80::25c7:9207:684a:5e2b%6]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 08:20:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH] ARM: imx: use of_root to simplify code
Thread-Topic: [PATCH] ARM: imx: use of_root to simplify code
Thread-Index: AQHVvvAOkP5pfM/SI0ufVklMt6+KwqfiDDEAgAAAu+A=
Date:   Thu, 9 Jan 2020 08:20:38 +0000
Message-ID: <VI1PR04MB4496D19E97406E9AC71BAE9F88390@VI1PR04MB4496.eurprd04.prod.outlook.com>
References: <1577696316-27635-1-git-send-email-peng.fan@nxp.com>
 <20200109081603.GI4456@T480>
In-Reply-To: <20200109081603.GI4456@T480>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f73319ba-d399-491b-44d0-08d794dccef4
x-ms-traffictypediagnostic: VI1PR04MB3229:|VI1PR04MB3229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3229CBD636A1F5E9259B8B9388390@VI1PR04MB3229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(189003)(199004)(2906002)(26005)(76116006)(66556008)(66476007)(8676002)(64756008)(66446008)(186003)(55016002)(81166006)(966005)(8936002)(9686003)(478600001)(81156014)(71200400001)(316002)(33656002)(6506007)(54906003)(110136005)(86362001)(4326008)(66946007)(7696005)(5660300002)(44832011)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3229;H:VI1PR04MB4496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ckQkR1zCHVklCswp+AqTiJRs2SRSJ/q2r4zNeF6HWSrhw8WQaOAzTjoHwJoJOw8li72dvAw+HFPHPkke5rgw+fDzv/WmxTGVlYMlBvj/XrJv6zC2T6zmX6XKdil5XF3lpYwxbuPLs4orcm+PGdsSY3Yq0aHhDllkeVL4iA5RBH71PIZ/sAUhJh05Q2G7qezcEgA2zZdGF4ClcTXD4+Mh8UJrVtLyiMvTUMxOBO9Elr9r4B6GNs7UjRqOvlwrNGaDt4LwKeqC8wnE1cWc2qEPN20YbQ3gvbRu8PKu/e/w1XAfxYoieP/K3O+fhmN6MSGnBgT8wywZmRD3VVgG6x0om6U1VoU8reRpcyGWa55ida0ZDJkg2uUJppUOhj/ea5KHd17Q6dkfK/9yW0Iuii8Q4Yi8rmSL7znyuHtgoKBqQJySjGnwCSF8BmGVLFqg9U+9rnC3sm2pFitXDwxts3mbwQP/YyFGWYZAO3TfPALMnEH7805MclBwyAF2BAL0G+ks3OdIaNpMOUHvNi4ou8mmIw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73319ba-d399-491b-44d0-08d794dccef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 08:20:38.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZHAcOgyDtcgF+jr6C/2isYjgKFsZDU/SQ/z8W5JWxSQ32WXGKnsBZTQ+ryeh5DdTgxiLi4v5NdCiRVt+vLm3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob

Hi Shawn,

> Subject: Re: [PATCH] ARM: imx: use of_root to simplify code
>=20
> On Mon, Dec 30, 2019 at 09:03:51AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > start_kernel
> >      |->setup_arch
> >      |       |->unflatten_device_tree->of_root ready
> >      |
> >      |->do_initcalls
> >            |->customize_machine
> >                        |->init_machine
> >                               |->imx_soc_device_init
> >
> > When imx_soc_device_init, of_root is ready, so we could directly use it=
.
>=20
> IMO, of_root is something for OF core code, not really for platform.

From below link, I see powerpc and some driver use of_root directly.
https://elixir.bootlin.com/linux/v5.5-rc5/ident/of_root

of_root is exported as a symbol. Rob, could you please clarify whether
platform code could use of_root directly?

Thanks,
Peng.

>=20
> Shawn
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  Tested on i.MX7D-SDB
> >
> >  arch/arm/mach-imx/cpu.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c index
> > 06f8d64b65af..77319b359070 100644
> > --- a/arch/arm/mach-imx/cpu.c
> > +++ b/arch/arm/mach-imx/cpu.c
> > @@ -88,7 +88,6 @@ struct device * __init imx_soc_device_init(void)
> >  	struct soc_device_attribute *soc_dev_attr;
> >  	const char *ocotp_compat =3D NULL;
> >  	struct soc_device *soc_dev;
> > -	struct device_node *root;
> >  	struct regmap *ocotp =3D NULL;
> >  	const char *soc_id;
> >  	u64 soc_uid =3D 0;
> > @@ -101,9 +100,7 @@ struct device * __init imx_soc_device_init(void)
> >
> >  	soc_dev_attr->family =3D "Freescale i.MX";
> >
> > -	root =3D of_find_node_by_path("/");
> > -	ret =3D of_property_read_string(root, "model", &soc_dev_attr->machine=
);
> > -	of_node_put(root);
> > +	ret =3D of_property_read_string(of_root, "model",
> > +&soc_dev_attr->machine);
> >  	if (ret)
> >  		goto free_soc;
> >
> > --
> > 2.16.4
> >
