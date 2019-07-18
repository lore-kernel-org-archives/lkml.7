Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B474CC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A7204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k42+sIev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389569AbfGRDEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:04:00 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:43396
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389530AbfGRDD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:03:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb0Pb0QxbgD6yvL4nVH/xhERNW2Gt2sCLvZg7s3Jd/18UNq98erjyvWtXelbZ6NOHxvu0FTDQURulcVE3Ttn3gnVoDPswzZyi0teMRStI2h3G1lwQBNuBhvoaUMHhRmPZj4B0jji06e7xPGlfiYx3awjt1BEIvCbWlPdIOJv/sjwNe08ApaZM032gDS12ZSdvfspSCdwGFwEE4txf1/oTIxyx/ncftxouFxmAh15oVEg7QDt8PDotkGI8S4h1qkxyFfwCGzK6M8TY2Mk1JpNm9iTsX8woxah4ix1jhaLu9YqrCE1SpGaOZMSS+O2tqzdrOGzb46usRxvRY4Hbfzepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/Zq7FZcArI3xMGNsJveRQuo4z77ICHqcqo69PcaFv4=;
 b=Zbi5b+uKNKBCohPiLn2MnNHbkZqD1L4gYloFPy6OMjntG1vnam/q5QCY8Yl3vmD6/k7dh/RauRGM9L1XAivgVS9uIT1HFVkXX4Ai17M0ekQMu+OX8eJOWnZYsa89JqD5oveIRmr1iX5K6raPivDDuPAoto0XWTqBXTu/S6xPg99tkuPlTOP5LtIW4ToxKMeZmwGQNiog9R8/n2qDeMcrDerB6MCr67bnyyovIO57ori4GWwbM37G/YmlmpsbUqvSdbAL+rmtCKGhhErnb+wl3Vyk+Fzu/7ov7a0YuVYp0Kz6vTf742vpDZtimpFK92Ne2jyIYrC/T5ij72nMYOMJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/Zq7FZcArI3xMGNsJveRQuo4z77ICHqcqo69PcaFv4=;
 b=k42+sIevQZvZOX8lzMDSD9zOv0GAF9VjZOObIr7Z+w0yHYfgaF8QCeneQU6dRqvh/VFR0fNPSs5y8hsA/zRLi99rebiArJ1RsNO9NyFQVATnRY04EiHfxQdwJzromZc8/da+Pj5b8yEnCgplpEenpx3R7naBV9PqxY25plH6HCo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6212.eurprd04.prod.outlook.com (20.179.35.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 03:03:53 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 03:03:53 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Darshak Patel <Darshak.patel@einfochips.com>,
        Kinjan Patel <Kinjan.patel@einfochips.com>,
        Prajose John <Prajose.john@einfochips.com>
Subject: RE: [PATCH 3/3] arm64: dts: freescale: Add support for i.MX8QXP AI_ML
 board
Thread-Topic: [PATCH 3/3] arm64: dts: freescale: Add support for i.MX8QXP
 AI_ML board
Thread-Index: AQHVPGZyIR348aAD1EKdeUBRiwSuo6bOm9pAgAASkICAAQKbwA==
Date:   Thu, 18 Jul 2019 03:03:53 +0000
Message-ID: <AM0PR04MB4211DB3B62D728BA2C70DEA280C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
 <20190717061039.9271-4-manivannan.sadhasivam@linaro.org>
 <AM0PR04MB42116A61D7E32E6BA36D1CBA80C90@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20190717113435.GA32330@Mani-XPS-13-9360>
In-Reply-To: <20190717113435.GA32330@Mani-XPS-13-9360>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1833a256-edd1-4056-7c2d-08d70b2c90d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6212;
x-ms-traffictypediagnostic: AM0PR04MB6212:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB6212EA613CF37768D04F097180C80@AM0PR04MB6212.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(446003)(186003)(66946007)(8676002)(6916009)(7696005)(316002)(86362001)(52536014)(4326008)(229853002)(76116006)(99286004)(66476007)(6436002)(66556008)(66446008)(5660300002)(68736007)(64756008)(26005)(71190400001)(2906002)(71200400001)(6506007)(256004)(54906003)(478600001)(74316002)(9686003)(6246003)(7736002)(305945005)(55016002)(81156014)(53936002)(66066001)(81166006)(33656002)(14454004)(11346002)(76176011)(6116002)(8936002)(25786009)(3846002)(486006)(4744005)(476003)(7416002)(44832011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6212;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k5vmkhRvmsWCncInNg5Fk/sjFSRmrEowKZHE7C3Cjh484AXoxSe+z2JbrHw0JuDfZza60B3u1dfZeIWVlztaU0aJtsR6AkXXziCmCbH2SCJgyD4ozn/3QSehScbcONWZYjgroD8+muBr3lZ5L/0TKFQ3urdZVMVJ92xQWqDuq5AnZFScygGLGXlUj9t6IVIj7Bj8B4syKI686oWl4njsQd3640Ji2MiLYhTGe6Vy7F9kc5d2XYLoXQkQ63bYjdGz9XmlRYhYQSkZLCoawTuRChC8k38OQ0GI/6W488eCcXQsAZYmRDk6a3o0oU4SzIFQUEKQJ/jaKRXSlenpeUrpeyyyLGV5QFZnkk3a03yRt7oUUzyyOu1Vk46181MbWZS+6UK5knsJYRm7jMHbxDe7fN3PAB7AHIglcThHBmc0ZpQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1833a256-edd1-4056-7c2d-08d70b2c90d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 03:03:53.1844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gKyZhZG1hX2xwdWFydDEgew0KPiA+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQi
Ow0KPiA+ID4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfbHB1YXJ0MT47DQo+ID4gPiArCXN0YXR1
cyA9ICJva2F5IjsNCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gKy8qIERlYnVnICovDQo+ID4g
PiArJmFkbWFfbHB1YXJ0MiB7DQo+ID4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+
ID4gPiArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9scHVhcnQyPjsNCj4gPiA+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4gPiArLyogUENJLUUgKi8NCj4gPg0KPiA+
IEEgYml0IGNvbmZ1c2luZyBmb3IgdGhlIGNvbW1lbnRzLi4uDQo+ID4NCj4gDQo+IEhtbS4gSG93
IGFib3V0LCAiUENJLUUgVUFSVCI/DQo+IA0KDQpJdCBzZWVtcyB0byBiZSByZWxhdGVkIHRvIHlv
dXIgYm9hcmQuIFNvIHVwIHRvIHlvdS4NCkknbSBmaW5lIHdpdGggaXQuDQoNClJlZ2FyZHMNCkFp
c2hlbmcNCg==
