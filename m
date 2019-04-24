Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6C0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A1218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pNTPcMDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfDXKAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:00:31 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:59506
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDXKAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHQL2y0BDW791862m53Pr9fkQIZ//kg+GVuv1mxYyFw=;
 b=pNTPcMDw53xz6oxTX1bjDR3V1Mx7eW2LSYCEuNMukWt/S6bzZKMhZkr172cvJ7TX6D7x+7GBLQOFOkGWVBrDDhGea312ZrUeZf9l9T7F/qLGOaSid/OaDPMAXJfErk22TjzD73IbcfPC+z34q5erOsaRlbtIJXF3Hc1eXBhaiHY=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4372.eurprd04.prod.outlook.com (52.135.149.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Wed, 24 Apr 2019 10:00:28 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::a1d7:51b5:9893:dcee]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::a1d7:51b5:9893:dcee%2]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 10:00:27 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Yue Haibing <yuehaibing@huawei.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] soc: imx: Fix build error without CONFIG_SOC_BUS
Thread-Topic: [PATCH v2] soc: imx: Fix build error without CONFIG_SOC_BUS
Thread-Index: AQHU+n5V1uzI2qbZiESwH7JXPIfB8A==
Date:   Wed, 24 Apr 2019 10:00:27 +0000
Message-ID: <AM0PR04MB6434954C235A54191D008A61EE3C0@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190424075946.23124-1-yuehaibing@huawei.com>
 <20190424091517.41428-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7495368c-a4c6-466e-cf80-08d6c89badba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4372;
x-ms-traffictypediagnostic: AM0PR04MB4372:
x-microsoft-antispam-prvs: <AM0PR04MB43724C765FD7B1F13BE8D11FEE3C0@AM0PR04MB4372.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(6116002)(478600001)(5660300002)(2501003)(52536014)(71200400001)(3846002)(102836004)(76176011)(6506007)(14454004)(8936002)(64756008)(8676002)(4744005)(86362001)(305945005)(7736002)(76116006)(53546011)(91956017)(66446008)(66946007)(66556008)(97736004)(73956011)(66476007)(81166006)(81156014)(7696005)(7416002)(229853002)(74316002)(99286004)(71190400001)(55016002)(186003)(66066001)(446003)(6436002)(4326008)(2906002)(6246003)(53936002)(256004)(33656002)(68736007)(44832011)(2201001)(25786009)(26005)(486006)(110136005)(54906003)(476003)(9686003)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4372;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r5vkp9URbQ3GTVbpC9XWyuloTD/HqsI3jU+Q+k46dK4tsFTG1XiQsai1//cntJ8mdF2NZQGPkLGaYQcdVbYlLQ9NdG6AZdAfvsf5+Xej/1PM1MpEaVfNJ4TgAZHkqWUnpp4vYp3WPko/3FZDP2UFYcN3lqQ39L7HklMrSiF1Vsybby4DOsUtZgbgRzQDvHs3sUb1FKEc2uei1VdPc08ZUxmoChaPPYPno++iLkkOeXL0+837Z4dl9kMP/vkeWMC2Wi74hI3kgkHKAoPt8nsGEPN+fEWJePCiWb9x9Glb4D3OGylG/Y5lG2rs/s/NUhUPkFfr15/a9tBZILCmSlEi5bXW4l8hhk/+GxzcMwvdoZiCi7gIt4e0TsIJMVBEooreFY4p01B7iPJOz5xW4KgNtt29ddAzv3iXDOv1DcNsgsQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7495368c-a4c6-466e-cf80-08d6c89badba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 10:00:27.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.2019 12:16, Yue Haibing wrote:=0A=
> From: YueHaibing <yuehaibing@huawei.com>=0A=
> =0A=
> During randconfig builds, I occasionally run into an invalid configuratio=
n=0A=
> =0A=
> drivers/soc/imx/soc-imx8.o: In function `imx8_soc_init':=0A=
> soc-imx8.c:(.init.text+0x144): undefined reference to `soc_device_registe=
r'=0A=
> =0A=
> while CONFIG_SOC_BUS is not set, the building failed like this. This patc=
h=0A=
> selects SOC_BUS to fix it.=0A=
> =0A=
> Reported-by: Hulk Robot <hulkci@huawei.com>=0A=
> Fixes: a7e26f356ca1 ("soc: imx: Add generic i.MX8 SoC driver")=0A=
> Suggested-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
