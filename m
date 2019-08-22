Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DD7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45CE233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MAhzvRAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404476AbfHVRdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:33:22 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:35396
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389885AbfHVRdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:33:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFT3QhzDtfiQDg0ZtQMf0ZPnQ/fyLgVyyh9tgLD2qzAlWZQ+yDeJDUFU1Te23j3uhzSI2wN5rjw6B7pD0rj4gw/Ukr8Yiw28qq8R4s3thanp9en9GyhJh2liXDSC2cLYf+O54X09fLX5Zv6dQTivmWFFEYmp8TZIJMLgqE5v5f6ZEnBthmsivN+khbEXb2a6AO9eWgEPZt5om3qrbtMXNUN2xEvi4EY198qB6Bh0MuUK0sRrgHFzhAm9WrVNfrSBXnfUadM3kJVZFfCLCVN1nsvOyQwGpaY6uGuHbWoqO2lPJ/njsZMHyni4uXB0F25nZ8AoBYY4p24nceNzHqGUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMKQEEzf7CT5wF9y/GSJl1EPplWS2baUsomLh5eXA/s=;
 b=A67EMz8UiiNsCuKey6131lj1FsUXyiGee9YJ+/LVNtHO+uC1jOYE3rV8Iduionn18iehMOZfF8wQdZrL5dMGbNqySSsI8L2zD4PhNhRTsx3i+d71oCuaT5ncVBiMcftNgpnYtgUq2hJYjPFtgt3K9Y3YOzEAMqBMBiPpCqbm677duB9at85Xfd0Z0IPOQfZfryJ/CWCvUFA9v6encTpyvom1PJTEOEfPEhjF1HPHcjZpEzGK7lo0o5hL06XUJ3DdAbTsO7eSTYKBs2PGUeuuoSiCLlQHfxsc2wKysWni6hYjerPA7s/+hbNEYazxNnjuNzZN4iJk+Xm3fOXVF6I68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMKQEEzf7CT5wF9y/GSJl1EPplWS2baUsomLh5eXA/s=;
 b=MAhzvRAtxziTdALhkvADSrQ8uIu8CGFXIydG0ddoHU8GKK5GyhV6svRfhNFE4U9DbMHQvu+63cDFKTvTiqcS4TUeUYSMjQbXtv4vqpyc9pej6FjoWxVMfmoLxovzUlt+MQFv9obBPPJnXEmTS6UIKDVGi6sTOX1UF1jpxskiAQ4=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB7022.eurprd04.prod.outlook.com (10.186.157.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 17:33:13 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:33:13 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
CC:     Chris Healy <cphealy@gmail.com>, Peter Chen <peter.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH] ARM: imx: Drop imx_anatop_init()
Thread-Topic: [PATCH] ARM: imx: Drop imx_anatop_init()
Thread-Index: AQHVR8oGvyTNCOZoFU6BqtEMTuzaog==
Date:   Thu, 22 Aug 2019 17:33:13 +0000
Message-ID: <VI1PR04MB7023AE3910B261877892EEABEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20190731180131.8597-1-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f18ad444-36b1-47e0-3971-08d72726cf72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB7022;
x-ms-traffictypediagnostic: VI1PR04MB7022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB70221FF6F60576E579211724EEA50@VI1PR04MB7022.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(8936002)(66066001)(6436002)(8676002)(2906002)(81166006)(102836004)(486006)(476003)(186003)(26005)(446003)(44832011)(74316002)(52536014)(7736002)(5660300002)(6506007)(53546011)(91956017)(81156014)(76116006)(6116002)(3846002)(305945005)(33656002)(64756008)(9686003)(55016002)(4326008)(6246003)(7696005)(66476007)(66446008)(25786009)(66946007)(76176011)(71190400001)(71200400001)(256004)(14444005)(53936002)(54906003)(110136005)(478600001)(316002)(14454004)(99286004)(86362001)(229853002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7022;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hwD+IB1x77ZUy6cbWSQuHnIFMKcIBYxgTyGzsokVWuEFxj+6cB6Dd2pM4xSNlHfNVlIqDiugTcUPB3FajRocR+LLr9/+hSdErONrKUtH/55uv2aRJUa09azf/YydZWtWQ2hudAPwLAGVdN+naVxCBx/13yaphgaATja6yUoqaQgc5gFMsIW8vzDwfOyHM5zdAtA2eyQzRPfsRxsJ8ll8Hm2SS8vhWng2rjNcUSN/aYiqX60zhVyvZNp5lLQ3v61IRiyVH4PzDwSYKvhiccHB+YefSxgBJmvqJVstIf+oH70BJvL5VysMG8o7OUBuCxlKdDt+bxYR8GTN1AjIyuZWnMfM9XPHjfUnHEOx18Qpmqbco+2CaTTXCaxlw0LUG5zQK0et7+NXVjQzrIp42ijZFDIsEM2vkAYwTKAG1NoVwUE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18ad444-36b1-47e0-3971-08d72726cf72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:33:13.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGF811ej90jAp6yoNjfI31NWWJEVDIGLlyBQ8pay0k5nLcM+0Tsa1kr2uWwMnF3og03oIklEaDwo4IveaAd50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.2019 21:01, Andrey Smirnov wrote:=0A=
> With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger=0A=
> detect in mxs_phy_hw_init()") in tree all of the necessary charger=0A=
> setup is done by the USB PHY driver which covers all of the affected=0A=
> i.MX6 SoCs.=0A=
> =0A=
> NOTE: Imx_anatop_init() was also called for i.MX7D, but looking at its=0A=
> datasheet it appears to have a different USB PHY IP block, so=0A=
> executing i.MX6 charger disable configuration seems unnecessary.=0A=
> =0A=
> -void __init imx_anatop_init(void)=0A=
> -{=0A=
> -	anatop =3D syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");=0A=
> -	if (IS_ERR(anatop)) {=0A=
> -		pr_err("%s: failed to find imx6q-anatop regmap!\n", __func__);=0A=
> -		return;=0A=
> -	}=0A=
=0A=
This patch breaks suspend on imx6 in linux-next because the "anatop" =0A=
regmap is no longer initialized. This was found via bisect but =0A=
no_console_suspend prints a helpful stack anyway:=0A=
=0A=
(regmap_read) from [<c01226e4>] (imx_anatop_enable_weak2p5+0x28/0x70)=0A=
(imx_anatop_enable_weak2p5) from [<c0122744>] =0A=
(imx_anatop_pre_suspend+0x18/0x64)=0A=
(imx_anatop_pre_suspend) from [<c0124434>] (imx6q_pm_enter+0x60/0x16c)=0A=
(imx6q_pm_enter) from [<c018c8a4>] (suspend_devices_and_enter+0x7d4/0xcbc)=
=0A=
(suspend_devices_and_enter) from [<c018d544>] (pm_suspend+0x7b8/0x904)=0A=
(pm_suspend) from [<c018b1b4>] (state_store+0x68/0xc8)=0A=
=0A=
Minimal fix looks like this:=0A=
=0A=
--- arch/arm/mach-imx/anatop.c=0A=
+++ arch/arm/mach-imx/anatop.c=0A=
@@ -111,6 +111,12 @@ void __init imx_init_revision_from_anatop(void)=0A=
          digprog =3D readl_relaxed(anatop_base + offset);=0A=
          iounmap(anatop_base);=0A=
=0A=
+       anatop =3D syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");=
=0A=
+       if (IS_ERR(anatop)) {=0A=
+               pr_err("failed to find imx6q-anatop regmap!\n");=0A=
+               return;=0A=
+       }=0A=
=0A=
Since all SOCs that called imx_anatop_init also call =0A=
imx_init_revision_from_anatop this might be an acceptable solution, =0A=
unless there is some limitation preventing early regmap lookup.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
