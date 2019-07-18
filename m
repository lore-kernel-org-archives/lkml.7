Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F2C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F92A21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TZiUg1BT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391848AbfGRDOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:14:36 -0400
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:56546
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391798AbfGRDOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:14:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuIuNLsjDm+7FwkEKuZWPbk9PpSQp1WlWItBqXSnXazAK7Ce1szASyCpOOqMQHF0jaxc7ClC4hLHId8gv6s5VxKSc6RumCeqRHqjdTuv90ja47AV9GuesYOBPx4H4EtUTRI32vZ73FQZiL8VWczxTrQeY8U36JCJ0BsTC8HVqCOMtfE1XI2cqU/JfKRfN+TZJ6L0+zoPTqU4w5YorCYaVnHtB/i2ckb9qsm6XLZKYD85VBuBrjkWdXUPanI7ypodsVed7iQPRQXNgZdNJiyzDxME99dLmX97NY59mKO1DQHusqAPHYr1ChyuLj/aZ+EAa5eVs783nKIXwQ1cC/RWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muio833KGlXf3ibEAXtE4ndo33kPW1fPTw+jUlKlo9E=;
 b=bC16HO+8lrVEGiGR3KbEoywJXpw/RlV7hX4E4SaRJY83u9+QBK2ngUUnss90ETG8sZA8zQbXwF2cAM8TXxK6WCuw8tWxFCnGRrT3rxf5asSjMao+KZ0yscFfOnYW1KOLj/Tr5E6uDcaeZsjHYOcqheoGOAMbhwwN2U6qfnoblxe+gobvz8P2SjfMaF62W0tWZIHbIk68B+EWCuHRZG7Q+mygF6dw1Cszf1ranmSLiRY12B1D2jcpafE/4GxoYiBwQZ8nS02r/Uai3W5+RU24Fh5/mVF5QHj1+052eUNrHO4yQpKOSbeH9L10tzOL6+N30TlHcFBAyRu2MmiJhgJ/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muio833KGlXf3ibEAXtE4ndo33kPW1fPTw+jUlKlo9E=;
 b=TZiUg1BTNzFKx81XIbEi1CCJt7PZZgNVSTfCHV4yeMf2SuY6tFVcGc4ugFz8LJtNFx2n7ACdNWj3cX2CynolcF2BqV1kLCVVguv1j98nH3Y028HV4bGVg2zg4O1nA7K/ZwzXKccz96j7Xww1EyyGKgP+lCgLPogdVA1ER/a6LJk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5619.eurprd04.prod.outlook.com (20.178.119.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 03:14:30 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 03:14:30 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH 1/3] firmware: imx: scu-pid: Rename mu PD range to mu_a
Thread-Topic: [PATCH 1/3] firmware: imx: scu-pid: Rename mu PD range to mu_a
Thread-Index: AQHVMdIf6uyShto060i5mFTuNuExjabPydsQ
Date:   Thu, 18 Jul 2019 03:14:30 +0000
Message-ID: <AM0PR04MB421177AA3F09411E19F23B8980C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190703190404.21136-1-daniel.baluta@nxp.com>
 <20190703190404.21136-2-daniel.baluta@nxp.com>
In-Reply-To: <20190703190404.21136-2-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4febe400-5b13-47f9-b726-08d70b2e0cb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB5619;
x-ms-traffictypediagnostic: AM0PR04MB5619:
x-microsoft-antispam-prvs: <AM0PR04MB561941D5B5311831F76D248B80C80@AM0PR04MB5619.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(53936002)(66066001)(86362001)(71190400001)(71200400001)(53546011)(6436002)(52536014)(6246003)(7736002)(6506007)(4326008)(66446008)(25786009)(256004)(76116006)(478600001)(486006)(64756008)(7696005)(102836004)(66556008)(66476007)(5660300002)(9686003)(55016002)(44832011)(229853002)(68736007)(14444005)(66946007)(54906003)(316002)(305945005)(74316002)(11346002)(476003)(8676002)(446003)(8936002)(81156014)(81166006)(110136005)(6116002)(99286004)(26005)(2906002)(76176011)(3846002)(33656002)(14454004)(2501003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5619;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /BCF/grJ5c0Xi+Uv+nIfXsGY0fveLKoxD3cKbQ1X/ROk7WI+APay5igLVZRqLjzg6b+sdjsG63Ir1Lcq/2CiSPldmqXXSSgA2mt/kOC/G5A8uHCijGtD9W+DjaAwCPZXzgZ6kkLKoaJxXJR4xUcuBl9Ta4Hu9R7JEGRmQBvKYahYtDKY8KNL1f6Hlq2BmVVZORddwv+5XWMuGrScrfpzrTeIVc3YOcu0+N/gXi4HJgCnc8l0Erog605Xd1tjPVpIPdoMt808Op6LBAxvgW6i+WQ2QC1ZELXwMwAIqW5IJaMD6j1SR0YF2h1FFIFCcE9Z0czdts3c00GZ1k/SrKkazO5YEwRyYp7Nikts9gG+ae6bYvzKte+EhECyw/siOW2L3bETqmMGFezZc8mcgNObnGRWkKmuPd0mo4PztBORwOc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4febe400-5b13-47f9-b726-08d70b2e0cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 03:14:30.4616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdWx5IDQsIDIwMTkgMzowNCBBTQ0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8zXSBmaXJt
d2FyZTogaW14OiBzY3UtcGlkOiBSZW5hbWUgbXUgUEQgcmFuZ2UgdG8gbXVfYQ0KDQpzL3BpZC9w
ZA0KDQo+IA0KPiBUaGUgTWVzc2FnaW5nIFVuaXQgbW9kdWxlIGVuYWJsZXMgdHdvIHByb2Nlc3Nv
cnMgd2l0aGluIHRoZSBTb0MgdG8NCj4gY29tbXVuaWNhdGUgYW5kIGNvb3JkaW5hdGUgYnkgcGFz
c2luZyBtZXNzYWdlcyB0aHJvdWdoIHRoZSBNVSBpbnRlcmZhY2UuDQo+IA0KPiBNVXMgaGF2ZSAy
IOKAnHNpZGVz4oCdIHdpdGggaW5kZXBlbmRlbnQgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlcy4gUmVu
YW1lIG11DQo+IFBEIHJhbmdlIHRvIG11X2EgYmVjYXVzZSBpdCdzIGFjdHVhbGx5IHNpZGUgQSBv
ZiBNVXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRh
QG54cC5jb20+DQoNCk90aGVyd2lzZToNCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlz
aGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGRyaXZl
cnMvZmlybXdhcmUvaW14L3NjdS1wZC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJt
d2FyZS9pbXgvc2N1LXBkLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYw0KPiBpbmRl
eCA0ODBjZWM2OWUyYzkuLjk1MGQzMDIzODE4NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJt
d2FyZS9pbXgvc2N1LXBkLmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMN
Cj4gQEAgLTkyLDcgKzkyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfc2NfcGRfcmFuZ2UN
Cj4gaW14OHF4cF9zY3VfcGRfcmFuZ2VzW10gPSB7DQo+ICAJeyAiZ3B0IiwgSU1YX1NDX1JfR1BU
XzAsIDUsIHRydWUsIDAgfSwNCj4gIAl7ICJrcHAiLCBJTVhfU0NfUl9LUFAsIDEsIGZhbHNlLCAw
IH0sDQo+ICAJeyAiZnNwaSIsIElNWF9TQ19SX0ZTUElfMCwgMiwgdHJ1ZSwgMCB9LA0KPiAtCXsg
Im11IiwgSU1YX1NDX1JfTVVfMEEsIDE0LCB0cnVlLCAwIH0sDQo+ICsJeyAibXVfYSIsIElNWF9T
Q19SX01VXzBBLCAxNCwgdHJ1ZSwgMCB9LA0KPiANCj4gIAkvKiBDT05OIFNTICovDQo+ICAJeyAi
dXNiIiwgSU1YX1NDX1JfVVNCXzAsIDIsIHRydWUsIDAgfSwNCj4gLS0NCj4gMi4xNy4xDQoNCg==
