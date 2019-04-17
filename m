Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246FDC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4382075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qQr912Ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfDQDRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:17:15 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:30538
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbfDQDRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq4xTuW7dXUIAnggPINbbPayYqhJ7L8ro+e8mQ1cAIQ=;
 b=qQr912EwBI+eB+UJa4xLqFtpuhoxkv/H+I6EezqHg9RR1Yct0e0fyATKZLsPKX5R08bWSrov/shdf7iUY4gjy6xv013s5Ca2YTC8QDd/QrFLri1sLC+s9KGjdu+3HpOmSaRAAjYTdllFyrsvvRjQpqtxTsu+ZVwjDJR0ltb/1+8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.91.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Wed, 17 Apr 2019 03:17:11 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019
 03:17:11 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "eha@deif.com" <eha@deif.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Thread-Topic: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Thread-Index: AQHU9ME0meJbs59NTkCxa+Er7M94G6Y/rRyAgAABQ1A=
Date:   Wed, 17 Apr 2019 03:17:10 +0000
Message-ID: <AM0PR04MB42110D893D07DFECFE167F5580250@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 656128ee-7c68-4a15-eee0-08d6c2e32e62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4290;
x-ms-traffictypediagnostic: AM0PR04MB4290:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB42905EB1A58780103FCD47CC80250@AM0PR04MB4290.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(31014005)(199004)(11346002)(81166006)(86362001)(8676002)(25786009)(446003)(4326008)(8936002)(74316002)(486006)(44832011)(256004)(7416002)(33656002)(186003)(81156014)(2940100002)(105586002)(26005)(305945005)(2201001)(476003)(7736002)(2501003)(3846002)(6116002)(99286004)(9686003)(5660300002)(66066001)(229853002)(71190400001)(6246003)(106356001)(71200400001)(93156006)(53936002)(68736007)(55016002)(6506007)(52536014)(14454004)(102836004)(97736004)(110136005)(316002)(478600001)(7696005)(6436002)(76176011)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u6454qK2swX1tLegWTnsxDulIS4JtpCgiBiXfLJXZ4xJoOBg9sNIrbCyVttuzJBqtBNXECcMLyQTNwvMwBu1D5KWLm3c9eixgcMWiSBD39vJjxnwgHe/yXz7UO//b/yTit+UsDugkX0H1DGO3xYqDZ+4MlF8MTpigUg2JeRaQndrGd0BCtj4qq9pTB2/s530298JoWiFaLoWXd2DIJqH+kq19r1DS+z3Kp3jwx1Kw0vuJaVlYvnlVUamGSCqCkgnWT3fuBIhurPyNejGGFZn9w8zJ5Q2+CotnBHbqUeFydDFtCX+ohfLa1t71NviPaeAwRpVSl9/7QomVQ0JnSKsMepX3MbnKgC2UhiklgHDnG7oARJs5nXBYuA+Im9xW9BXA5JjG8QDUewtZHSjVgiak/XLRPjylwORS5jTtcGEMQ0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656128ee-7c68-4a15-eee0-08d6c2e32e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 03:17:10.9523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCg0KPiA+DQo+ID4gRml4ZXM6IDkwYWQyY2JlODhjMigiaTJjOiBpbXg6IHVzZSBjbGsg
bm90aWZpZXIgZm9yIHJhdGUgY2hhbmdlcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IA0KPiBQbGVhc2UgYWxzbyBwcm92aWRlIGhvdyB0
byByZXByb2R1Y2UgaXQuDQo+IEFuZCBpdCBzZWVtcyBub3QgYSBuZXcgaXNzdWUsIHNob3VsZCB3
ZSBDQyBzdGFibGU/DQoNCkJlc2lkZXMgYWJvdmUgY29tbWVudHM6DQoNClJldmlld2VkLWJ5OiBE
b25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hl
bmcNCg0KPiANCj4gUmVnYXJkcw0KPiBEb25nIEFpc2hlbmcNCj4gDQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQo+ID4gYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJj
LWlteC5jIGluZGV4DQo+ID4gYzBjMzA0My4uZmQ3MGIxMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQo+ID4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2ky
Yy1pbXguYw0KPiA+IEBAIC01MTUsOSArNTE1LDkgQEAgc3RhdGljIGludCBpMmNfaW14X2Nsa19u
b3RpZmllcl9jYWxsKHN0cnVjdA0KPiA+IG5vdGlmaWVyX2Jsb2NrICpuYiwNCj4gPiAgCQkJCSAg
ICAgdW5zaWduZWQgbG9uZyBhY3Rpb24sIHZvaWQgKmRhdGEpICB7DQo+ID4gIAlzdHJ1Y3QgY2xr
X25vdGlmaWVyX2RhdGEgKm5kYXRhID0gZGF0YTsNCj4gPiAtCXN0cnVjdCBpbXhfaTJjX3N0cnVj
dCAqaTJjX2lteCA9IGNvbnRhaW5lcl9vZigmbmRhdGEtPmNsaywNCj4gPiArCXN0cnVjdCBpbXhf
aTJjX3N0cnVjdCAqaTJjX2lteCA9IGNvbnRhaW5lcl9vZihuYiwNCj4gPiAgCQkJCQkJICAgICAg
c3RydWN0IGlteF9pMmNfc3RydWN0LA0KPiA+IC0JCQkJCQkgICAgICBjbGspOw0KPiA+ICsJCQkJ
CQkgICAgICBjbGtfY2hhbmdlX25iKTsNCj4gPg0KPiA+ICAJaWYgKGFjdGlvbiAmIFBPU1RfUkFU
RV9DSEFOR0UpDQo+ID4gIAkJaTJjX2lteF9zZXRfY2xrKGkyY19pbXgsIG5kYXRhLT5uZXdfcmF0
ZSk7DQo+ID4gLS0NCj4gPiAyLjcuNA0KDQo=
