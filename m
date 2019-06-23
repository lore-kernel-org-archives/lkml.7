Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D00C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0C420665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HBMQulCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfFWMGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:06:03 -0400
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:10818
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbfFWMF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1mYwZ/p0MmFWjnqhhC3rRqQjbh/vXVamvZyev1QRGA=;
 b=HBMQulCu2I0mRvuW6UOW2psEFbSojvGLb2H0Y8A2pSvRgpZ6mX/SsQ5Ds4gjpdrRAKi8DploxBjA3/DyvboJQ7qop34bX5R0xu7pjz8AqvqRypO/eBu52EYACg0NHEzgfRLHuySbbsNwKEjroPp0tXon7Mhxn8ozCm7wlp+q97U=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Sun, 23 Jun 2019 12:05:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 12:05:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] clocksource/drivers/sysctr: Add an optional property
Thread-Topic: [PATCH 1/3] clocksource/drivers/sysctr: Add an optional property
Thread-Index: AQHVKAsVvJrYz1879kGVEJc1WrLeN6apEcoAgAAMJRCAAAFBgIAAB9Ug
Date:   Sun, 23 Jun 2019 12:05:55 +0000
Message-ID: <DB3PR0402MB39168010C09BDAE2BF27123CF5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190621082838.12630-1-Anson.Huang@nxp.com>
 <alpine.DEB.2.21.1906231232520.32342@nanos.tec.linutronix.de>
 <DB3PR0402MB3916B3B871FDEA9BFC960C67F5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <alpine.DEB.2.21.1906231331390.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906231331390.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8049e0d4-c6f9-46b7-153c-08d6f7d3252d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB36734C4A0C68C18797E59D8AF5E10@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(51914003)(189003)(199004)(68736007)(6306002)(76116006)(6916009)(66476007)(71200400001)(256004)(486006)(6116002)(71190400001)(3846002)(186003)(14454004)(26005)(66446008)(66556008)(99286004)(7696005)(66946007)(64756008)(44832011)(2906002)(476003)(73956011)(76176011)(11346002)(229853002)(446003)(54906003)(86362001)(45080400002)(8936002)(478600001)(6246003)(316002)(7736002)(305945005)(14444005)(53936002)(25786009)(74316002)(33656002)(6436002)(4326008)(9686003)(66066001)(52536014)(966005)(81166006)(7416002)(102836004)(5660300002)(55016002)(6506007)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FL4WYcBFUehXO/Tj+q1MtkoiMTL85BPAaSSvU0VLuzS/EqVXdUfxBXQxCylsn8QhJodVanZVJIYH82JsRc+vg0a2MCIk5OBfkiE9qrG96e7yL3Eyb20QjTsMVI5zYL/ATA2yjhJs3+y7/UiA6BFhgNV2WT9JCEuO2zQp8QMzgL87sX7dhchnzeyNNlwA+qs5ORAzj4MpOFIMyJvEYNDBmGP5cU2dehSziyUPPpYpb8uhgPnuzHor0UFJMO84r7TsdRZucIGbT3gbvv49VjZSj7kZNfeLZu0AEkXfV80hQz3HJ8w0nZ7dHO/0TgKC15nyd80/TYopF61TNwuuuAQYVVz/gDbc3+Lq4idV1sC3sbCKwhcM6Y12zZnZmMwxdEKfdR52UMK5hTMsxIaWtK/stLgX1EtuLeZ2Raw2TtsnHRk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8049e0d4-c6f9-46b7-153c-08d6f7d3252d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 12:05:55.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRob21hcw0KDQo+IEFuc29uLA0KPiANCj4gQTogQmVjYXVzZSBpdCBtZXNzZXMgdXAgdGhl
IG9yZGVyIGluIHdoaWNoIHBlb3BsZSBub3JtYWxseSByZWFkIHRleHQuDQo+IFE6IFdoeSBpcyB0
b3AtcG9zdGluZyBzdWNoIGEgYmFkIHRoaW5nPw0KPiBBOiBUb3AtcG9zdGluZy4NCj4gUTogV2hh
dCBpcyB0aGUgbW9zdCBhbm5veWluZyB0aGluZyBpbiBlLW1haWw/DQo+IA0KPiBBOiBOby4NCj4g
UTogU2hvdWxkIEkgaW5jbHVkZSBxdW90YXRpb25zIGFmdGVyIG15IHJlcGx5Pw0KPiANCj4gaHR0
cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0El
MkYlMkZkYXJpbmdmDQo+IGlyZWJhbGwubmV0JTJGMjAwNyUyRjA3JTJGb25fdG9wJmFtcDtkYXRh
PTAyJTdDMDElN0NhbnNvbi5odWFuZw0KPiAlNDBueHAuY29tJTdDNjU4ZDEyZTBkNjVhNDAxMDM0
ZDIwOGQ2ZjdjZWNjODYlN0M2ODZlYTFkM2JjMmI0YzYNCj4gZmE5MmNkOTljNWMzMDE2MzUlN0Mw
JTdDMSU3QzYzNjk2ODg2NDkwODMzODIzNiZhbXA7c2RhdGE9JTJGMCUNCj4gMkI5RElUMkhWdVZG
Z0x2aFc3UUZGTkFYclJxYmNUaTklMkJKY2FzZ092MDglM0QmYW1wO3Jlc2VydmVkPTANCj4gDQoN
ClRoYW5rcyBmb3IgdGhlc2UgaW5mby4NCg0KPiBPbiBTdW4sIDIzIEp1biAyMDE5LCBBbnNvbiBI
dWFuZyB3cm90ZToNCj4gDQo+ID4gSGksIFRob21hcw0KPiA+IAlUaGFua3MgZm9yIHRoZSB1c2Vm
dWwgY29tbWVudCwgSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2ggd2l0aA0KPiBpbXByb3ZlbWVudC4N
Cj4gPg0KPiA+IEFuc29uLg0KPiA+IA0KPiBBbHNvIHBsZWFzZSBmaXggeW91ciBtYWlsZXIgdG8g
Tk9UIGNvcHkgdGhlIGZ1bGwgbWFpbCBoZWFkZXIgaW50byB0aGUgcmVwbHkuDQo+IFRoYXQncyBh
YnNvbHV0ZWx5IHVzZWxlc3MuDQoNClN1cmUsIHRoYW5rcyBmb3IgcmVtaW5kZXIuDQoNCj4gDQo+
ID4gPg0KPiA+ID4gQW5zb24sDQo+ID4gPg0KPiA+ID4gT24gRnJpLCAyMSBKdW4gMjAxOSwgQW5z
b24uSHVhbmdAbnhwLmNvbSB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IFN1YmplY3QgOiBbUEFUQ0gg
MS8zXSBjbG9ja3NvdXJjZS9kcml2ZXJzL3N5c2N0cjogQWRkIGFuIG9wdGlvbmFsDQo+ID4gPiA+
IHByb3BlcnR5DQo+IA0KPiBBbmQgZmluYWxseSBwbGVhc2UgdHJpbSB5b3VyIHJlcGxpZXMsIHNv
IHRoZSB1bmludGVyZXN0aW5nIHBhcnRzIGFyZSBnb25lLg0KPg0KDQpPSy4NCg0KVGhhbmtzLA0K
QW5zb24uDQogDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo=
