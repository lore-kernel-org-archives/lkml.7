Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F26C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A072087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aiqcbv0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfEPKGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:06:38 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:20998
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfEPKGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5vBga45MYiqdpNu7zWqidi/XNYLU95cZZEPhk9WmO0=;
 b=aiqcbv0Z+2WvwEz3JGM2xtnR+B+92AbYcPHK3Su7+vlWZUUKzChDlOyCw+s3iP5WBiGENcKdxcZ9VmpjfzIzJ0DZesvSWoEG0L38f2BLEnahI8a9H7iohH41sgYrgG1HrTw12CM21DwOWPI0Y1Idnu+y41H7HH63gAtX9dOY294=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4947.eurprd04.prod.outlook.com (20.177.40.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 10:06:34 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 10:06:34 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V3 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVC5bqk1P5MqRzRU2gqcSUyb18Bw==
Date:   Thu, 16 May 2019 10:06:34 +0000
Message-ID: <AM0PR04MB6434E01AD0A18405A9E0DDF8EE0A0@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <1557976777-8304-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 341301dc-2b6c-4a33-fb56-08d6d9e62d3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4947;
x-ms-traffictypediagnostic: AM0PR04MB4947:
x-microsoft-antispam-prvs: <AM0PR04MB49477F0C70A62999B4BCCABDEE0A0@AM0PR04MB4947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(366004)(199004)(189003)(2906002)(5660300002)(446003)(6436002)(74316002)(476003)(7416002)(71200400001)(6246003)(316002)(55016002)(53936002)(14454004)(9686003)(71190400001)(86362001)(4326008)(25786009)(44832011)(305945005)(229853002)(486006)(256004)(6116002)(3846002)(73956011)(8676002)(81156014)(8936002)(26005)(81166006)(68736007)(2501003)(6506007)(99286004)(7696005)(76176011)(53546011)(102836004)(66066001)(66946007)(66476007)(186003)(33656002)(52536014)(54906003)(110136005)(7736002)(66556008)(91956017)(478600001)(64756008)(76116006)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4947;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NK78dy9QOveRvtdyRBZ5mkr3oJhFX0/Ybyz6HvkgdI2u7tA4lJldjYKl/l1/b5IK6CoCgI5v4wBClZIx7blgC/0MOPbCCxPOfxJvspa4l3rzoeEMP1NL958MIrCFVduSMrSAKtKD0T/0Cq7q7UBc96U3rWXp35yZIoCtwLGMvMvSv+nQ06vBBBe1mioyQfUIyyTb7hQ908CavBU+gKhPXE5qxp2E58f6l8qIZkbsLWE3bR0VZd8xqoPaHJorTPOwzecAx/HjMtQ3j2rY3DuXoAyG2TyPb4yC3SKgsdBPQ/HigbDOYtgi0Z7dd2PHETdrhBnPxdoH5kMJ+ZyAGiPqhIKfo1eViCHMJ20NlYP3YP0wywQLLrw/dHoymW1nErSJtf0ja9EGpqFhL67mIHM8mJQn/gOZmp5W9mWqZzQsnWc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341301dc-2b6c-4a33-fb56-08d6d9e62d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 10:06:34.3525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.2019 06:24, Anson Huang wrote:=0A=
> Add i.MX SCU SoC info driver to support i.MX8QXP SoC, introduce=0A=
> driver dependency into Kconfig as CONFIG_IMX_SCU must be=0A=
> selected to support i.MX SCU SoC driver, also need to use=0A=
> platform driver model to make sure IMX_SCU driver is probed=0A=
> before i.MX SCU SoC driver.=0A=
=0A=
> +#define imx_scu_revision(soc_rev) \=0A=
> +	soc_rev ? \=0A=
> +	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : =
\=0A=
> +	"unknown"=0A=
=0A=
> +	id =3D of_match_node(imx_scu_soc_match, pdev->dev.of_node);=0A=
> +	data =3D id->data;=0A=
> +	if (data) {=0A=
> +		soc_dev_attr->soc_id =3D data->name;=0A=
> +		if (data->soc_revision)=0A=
> +			soc_rev =3D data->soc_revision();=0A=
> +	}=0A=
> +=0A=
> +	soc_dev_attr->revision =3D imx_scu_revision(soc_rev);=0A=
> +	if (!soc_dev_attr->revision)=0A=
> +		return -ENODEV;=0A=
=0A=
The imx_scu_revision macro returns either kasprintf or "unknown", never =0A=
NULL. So it's not clear what this return -ENODEV does exactly.=0A=
=0A=
It makes more sense to return -ENODEV if get_soc_revision fails, so =0A=
maybe check "soc_rev !=3D 0" instead?=0A=
=0A=
If you really want to check the kasprintf result then you should return =0A=
-ENOMEM for it. It would be clearer if you dropped the imx_scu_revision =0A=
revision macro and open-coded instead.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
