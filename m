Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DDC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5918A20651
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P6MTzGn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfEEGcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 02:32:33 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:6741
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfEEGcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 02:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvCLbovyrtXbhBwylybs9/WOyi1tEma+jWqgLTlf+xc=;
 b=P6MTzGn5o4gnj8zrwlAgkEnrm+MNFAbXTrG4juQ30j5dNbKfDw45fGb1dpxwtG7CHyingp7bH0ZTGEyQfa4P9l/JP5P78O8gZODaC1EpkW7KLLHjUFr56/FGPn4y1i70FA50N40YSN0xqq2FG94ZniC4nXSQIf56piHqk3bstrE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4196.eurprd04.prod.outlook.com (52.134.90.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Sun, 5 May 2019 06:32:21 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 06:32:21 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "pp@emlix.com" <pp@emlix.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "robh@kernel.org" <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "stefan@agner.ch" <stefan@agner.ch>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] clk: imx: Add common API for masking MMDC handshake
Thread-Topic: [PATCH 1/2] clk: imx: Add common API for masking MMDC handshake
Thread-Index: AQHVAwpmnCdleDO3TECDUWrDtJQRdKZcEfNg
Date:   Sun, 5 May 2019 06:32:21 +0000
Message-ID: <AM0PR04MB42111E93D8F3C867CA49CC4280370@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557036830-13567-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557036830-13567-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c10e469-88b5-4f97-a225-08d6d1236ddc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4196;
x-ms-traffictypediagnostic: AM0PR04MB4196:
x-microsoft-antispam-prvs: <AM0PR04MB419602F0AF2956654CF4308980370@AM0PR04MB4196.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(66066001)(6246003)(4744005)(53936002)(14454004)(66556008)(4326008)(7416002)(2501003)(44832011)(26005)(186003)(476003)(2201001)(7736002)(486006)(305945005)(316002)(81166006)(2906002)(76116006)(81156014)(66476007)(66446008)(73956011)(9686003)(8676002)(66946007)(8936002)(64756008)(5660300002)(6436002)(86362001)(55016002)(229853002)(52536014)(68736007)(71200400001)(71190400001)(53546011)(6506007)(7696005)(76176011)(256004)(102836004)(33656002)(99286004)(6116002)(446003)(3846002)(11346002)(110136005)(478600001)(74316002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4196;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 75MZNZTJC0oRR0rNu4i2eEyrb6v9ry7X/mc9gwWj8cWrqXTvJ0t1pD26pKvwgoHWBLXPniSFx6QVRoWXMM7bceiUszDw447JZophY9tpyyfsAd+gEDOcO5XPJUBV91xcn9e38SoGlGRRKXYDG1pae5FuRPUUHxN5rf/y4ZXbXgWKBEG32J1RZSskg7iF4Xa4dsqofVpze8N+3EbqPQ0XlHLI9+UMqrvKAj7IC7kirpxbkWs/PMuRLM9h78LpVDpo450aclHjOcEUVUduUY9RNvC+OWEkukI5D2oHXSz814WahpPltjts8L+6PmZUIJDWQJSdR6kgLz7wCnrBUzdntJ4/cb+Qortww/4hOkJEf8XhwukdV2/4hh26e+CDfOLKYAQZR2dgiV85LHNE+f2pcQ+y7E8r/GLbeTmV52/jbmg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c10e469-88b5-4f97-a225-08d6d1236ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 06:32:21.5391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBTdW5kYXksIE1heSA1LCAyMDE5IDI6MTkgUE0N
Cj4gU3ViamVjdDogW1BBVENIIDEvMl0gY2xrOiBpbXg6IEFkZCBjb21tb24gQVBJIGZvciBtYXNr
aW5nIE1NREMgaGFuZHNoYWtlDQo+IA0KPiBBbGwgaS5NWDYgU29DcyBuZWVkIHRvIG1hc2sgdW51
c2VkIE1NREMgY2hhbm5lbCdzIGhhbmRzaGFrZSBmb3IgbG93DQo+IHBvd2VyIG1vZGVzLCB0aGlz
IHBhdGNoIHByb3ZpZGVzIGNvbW1vbiBBUEkgZm9yIG1hc2tpbmcgdGhlIE1NREMNCj4gY2hhbm5l
bCBwYXNzZWQgZnJvbSBjYWxsZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8
QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVu
Zy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo=
