Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA17AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC17F20645
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a7eXyNhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfEPLVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:21:15 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:14323
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbfEPLVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COEE6DCPcCYQJRjDL8XRhvHJvO2p5aylWaLGMYWJ1DA=;
 b=a7eXyNhNHCzMf9lhpNAh2I+VqOWg8+6t7d/1u3BV9TZwn0ysM8ExHW2F31jbaV8KLeusXQqXEX1xQ8CUQtsJgbxeUBWLSQzuNiqRLHtja/GdBqDbzWB0spqM7ny4dQgW+VmZ9+DRxccOUoFry8d28F5pqHDewg0lQEm/cyaLZsQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5364.eurprd04.prod.outlook.com (20.178.116.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Thu, 16 May 2019 11:21:10 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:21:10 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: RE: [PATCH V3 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Topic: [PATCH V3 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Index: AQHVCvNIwnz8O4Mu9kSxqaYPdjuNSKZtnDNQ
Date:   Thu, 16 May 2019 11:21:10 +0000
Message-ID: <AM0PR04MB42117D189498804D5E3A485F800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190515080703.19147-1-peng.fan@nxp.com>
 <20190515080703.19147-2-peng.fan@nxp.com>
In-Reply-To: <20190515080703.19147-2-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d05d3a5f-26af-4475-6396-08d6d9f09970
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5364;
x-ms-traffictypediagnostic: AM0PR04MB5364:
x-microsoft-antispam-prvs: <AM0PR04MB53640D889D20E1E9F7D43DBA800A0@AM0PR04MB5364.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:369;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(66066001)(6506007)(229853002)(68736007)(316002)(476003)(6116002)(86362001)(110136005)(54906003)(2906002)(76116006)(2201001)(14454004)(66946007)(3846002)(66476007)(73956011)(66556008)(102836004)(25786009)(52536014)(9686003)(4326008)(55016002)(2501003)(64756008)(76176011)(6436002)(66446008)(6246003)(305945005)(7736002)(53936002)(71190400001)(71200400001)(11346002)(486006)(44832011)(446003)(33656002)(81156014)(81166006)(186003)(7696005)(99286004)(8676002)(7416002)(26005)(5660300002)(256004)(14444005)(8936002)(4744005)(478600001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5364;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oyep6M8wnlH6+1xeRADM2qFdBJy80uh1ZC5rpweCnso1a4kUlmI/49mokOY7CN8zovhK192rEYcKoA1AsGVO0CHV7gtRt0vo5YIhFLTgSUDe6fKFbvYwmbG9XCzKOAy/vqTmN+LFUqhWyA0jD20CvZZtZsoDkCUpdJiraSExAvLH4qCwR+IEBqxsCBUFgWUt/6LBdBUTee0QWjBzqvQxtnMXQTK4RgE1HU3jxkB95E5wMxjQQ4AmALXFRaq1OjlgUrDzenjik8JP+TxxWNqn3E85An1hKzND7a0/jFB+PVcdUIikMFBVPjJb53ATycWX5Q/nj+HxJqxAXVUov+0QbcrHq6GCJA+I4FRdyI9NZBpC8U9T157AapzHJwv3QLA1xR3X07sIu1u34LrCQ2Z97KBcpwbv2nNUbekT4jiKH0Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05d3a5f-26af-4475-6396-08d6d9f09970
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:21:10.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5364
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAxNSwgMjAxOSAzOjUzIFBN
DQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgaS5NWDggbnZtZW0gb2NvdHAgZHJpdmVyIHRvIGFjY2Vz
cyBmdXNlIHZpYSBSUEMgdG8gaS5NWDgNCj4gc3lzdGVtIGNvbnRyb2xsZXIuDQo+IA0KPiBDYzog
U3Jpbml2YXMgS2FuZGFnYXRsYSA8c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3JnPg0KPiBD
YzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBDYzogU2FzY2hhIEhhdWVyIDxz
LmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtl
cm5lbEBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWls
LmNvbT4NCj4gQ2M6IE5YUCBMaW51eCBUZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gQ2M6IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5n
IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlz
aGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
