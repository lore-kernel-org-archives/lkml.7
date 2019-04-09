Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2424C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C4C213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fjahxyfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDIDgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:36:03 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:9542
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbfDIDgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiboL5DFU1frlvmKdtgzRMcGtQOUNZRuntmlCvjbNaQ=;
 b=fjahxyfHYd9unyZgrHVSnbrjJ3QFjdmPxgwictRblDdciy7VqhS4JDql0vtMJsQQjre2xqK3FUurdcLwsjLromnyXuZ90cDn40z8la5JEpsTM8/V2CICjVrMVIo0p3pTsU+RDfUEt1N1gT1pHCCMdLSTDO4fTmM8ypH/SW0YyoI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5252.eurprd04.prod.outlook.com (20.177.42.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 03:35:59 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 03:35:59 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V6 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHU7n4FMdKcp4NQJ0ukn8zURCHpWaYzKXfggAADpACAAABHMA==
Date:   Tue, 9 Apr 2019 03:35:59 +0000
Message-ID: <AM0PR04MB4211677CFB66218EEAC0DE20802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
 <1554777487-31075-4-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211CEA77AB034B5DCF71FE2802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916E7D387D5FA74CFB719C6F52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916E7D387D5FA74CFB719C6F52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2eaa99d-18ef-40ae-1057-08d6bc9c7b7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5252;
x-ms-traffictypediagnostic: AM0PR04MB5252:
x-microsoft-antispam-prvs: <AM0PR04MB5252CC99334B10AA10D5079E802D0@AM0PR04MB5252.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(86362001)(68736007)(229853002)(6506007)(4744005)(66066001)(6436002)(478600001)(6116002)(71190400001)(4326008)(3846002)(186003)(25786009)(9686003)(2906002)(106356001)(102836004)(97736004)(26005)(53936002)(105586002)(6246003)(71200400001)(2201001)(5660300002)(81166006)(8676002)(55016002)(110136005)(76176011)(11346002)(52536014)(305945005)(476003)(446003)(74316002)(7736002)(316002)(33656002)(256004)(81156014)(7696005)(2501003)(99286004)(93886005)(44832011)(486006)(14454004)(7416002)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5252;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5nAaJhxwmSUGmfC6Djqk2nXJRCYh0SzAUm4fGMUkilB83of4vX9mwfX62Mv7p+1qMsuht/BmxSZeHNbaufTTjC7R6JCWxpZ28NwBeqtojUAuPqSJtGEkAgIC3EEu5Cg+VrIkJvXRjXxiIOg6ekaEkYNPuZlcnxLXA2kBPoknkcSxhU+8OY8gONaXq/a4ZwqCtRogT9XYhBgLC5WIiOttOMh2gv3hLDV2WB5hKIfdZtSJzCa4pBGZ7Pw2hCkIpfyA4o1Tf/ZiAcRhN/U+VWBvBvcfVxn/0OSeyyR7srw5iTjRnxH0a5NQmrNj2TwDOeUNbjnT63ohuo+jc63lIqGlxBfAGgozWMbxKOOJr3z3w0/5UBkjr/3wlFiBRz9j/ZYtBYVYIZ/Cb4D88ca92kcdzIACTH09wNDzAsoaDP9cOBM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eaa99d-18ef-40ae-1057-08d6bc9c7b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 03:35:59.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCg0KPiA+ID4gK3N0YXRpYyBpbnQgaW14X3NjX3J0Y19hbGFybV9pcnFfZW5hYmxlKHN0
cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQNCj4gPiA+ICtpbnQNCj4gPiA+ICtlbmFibGUpIHsN
Cj4gPiA+ICsJaW14X3NjdV9pcnFfZW5hYmxlKFNDX0lSUV9HUk9VUF9SVEMsIFNDX0lSUV9SVEMs
IGVuYWJsZSk7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gK30NCj4gPiA+ICsN
Cj4gPiA+ICtzdGF0aWMgaW50IGlteF9zY19ydGNfcmVhZF9hbGFybShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdA0KPiA+ID4gK3J0Y193a2Fscm0NCj4gPiA+ICsqYWxybSkgew0KPiA+DQo+ID4g
SSBzdGlsbCB0aGluayBoZXJlIG5lZWRzIGEgZG9jIGV4cGxhaW4gd2h5IG5lZWRzIHRoaXMgYW5k
IHdoeSBpdCdzDQo+ID4gc2FmZSB0byBkbyB0aGF0Lg0KPiANCj4gSSB3aWxsIGFkZCBhIGNvbW1l
bnQgaGVyZSwgZm9yIHRoZSBkb2MsIGl0IHNob3VsZCBiZSBhbm90aGVyIHRvcGljIG9mIFJUQw0K
PiBmcmFtZXdvcmssIHdlIGNhbiBkbyBpdCBsYXRlci4NCg0KSSdtIGZpbmUgd2l0aCBpdC4NCkJU
VywgZG9uJ3QgbWlzcyB0aGUgbmV4dCBtaW5vciBjb21tZW50cyB3aGVuIHlvdSByZXNlbmQuDQoN
ClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+ID4gPiArCS5zZXRfYWxhcm0gPSBpbXhfc2NfcnRj
X3NldF9hbGFybSwNCj4gPiA+ICsJLmFsYXJtX2lycV9lbmFibGUgPSBpbXhfc2NfcnRjX2FsYXJt
X2lycV9lbmFibGUsIH07DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBpbXhfc2NfcnRjX2Fs
YXJtX3NjX25vdGlmeShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLA0KPiA+ID4gKwkJCQkJdW5z
aWduZWQgbG9uZyBldmVudCwgdm9pZCAqZ3JvdXApDQo+ID4NCj4gPiBOb3QgbmVjZXNzYXJ5IHRv
IGhhdmUgc3VjaCBhIGxvbmcgZnVuY3Rpb24gbmFtZS4NCj4gPiBJbXhfc2NfcnRjX2FsYXJtX25v
dGlmeSgpIHNob3VsZCBiZSBvaw0KPiA+DQoNCg==
