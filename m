Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A285BC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5953121537
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lK04Va+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfFWMY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:24:27 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:12703
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfFWMY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbPrApaPO1J8+RuUsUfkGpPn4x1KcDxkk/WnZ3tI+Qk=;
 b=lK04Va+zi6g5aM+LcTScYPPrR71zuUu0/yRrtmnfpe+lT6/AW2dfDRst8nFFKPyJJcIAp4kXv1ylBAVRkpRy02rGYeVBq7iDxQxLFjEzmnXCmTET/ZtRvxJhFyYFgyXYcl8bXn7H6vhCc+93S0s4jXVRBSXC0YVSRWK0hH6wUO0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3786.eurprd04.prod.outlook.com (52.134.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sun, 23 Jun 2019 12:24:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 12:24:15 +0000
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
Subject: RE: [PATCH V2 2/3] clocksource: imx-sysctr: Add of_clk skip option
Thread-Topic: [PATCH V2 2/3] clocksource: imx-sysctr: Add of_clk skip option
Thread-Index: AQHVKbuWNWrHQhlrtkONmwA387ffcaapJ8uAgAABY9A=
Date:   Sun, 23 Jun 2019 12:24:15 +0000
Message-ID: <DB3PR0402MB3916EF5948655AE1373E0AF9F5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190623120434.19556-1-Anson.Huang@nxp.com>
 <20190623120434.19556-2-Anson.Huang@nxp.com>
 <alpine.DEB.2.21.1906231413110.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906231413110.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a28c3474-ce7a-4895-6e18-08d6f7d5b52b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3786;
x-ms-traffictypediagnostic: DB3PR0402MB3786:
x-microsoft-antispam-prvs: <DB3PR0402MB378663CF37E034B4375B38D7F5E10@DB3PR0402MB3786.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(54534003)(189003)(199004)(186003)(102836004)(229853002)(4326008)(86362001)(5660300002)(71200400001)(6916009)(26005)(478600001)(71190400001)(25786009)(73956011)(52536014)(66446008)(66556008)(14454004)(7416002)(66476007)(66946007)(76116006)(64756008)(81166006)(33656002)(7696005)(68736007)(81156014)(6506007)(486006)(44832011)(9686003)(476003)(256004)(6116002)(14444005)(11346002)(446003)(305945005)(74316002)(7736002)(3846002)(53936002)(2906002)(8936002)(316002)(99286004)(6246003)(55016002)(76176011)(66066001)(54906003)(8676002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3786;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NR3WsAjgzO64Z0QYiwy3JYp3jichEB0d6vK1Wk3jRxIo3L4VGQIMoFlsBQLV5EhHRzsVJ2jSe6j9vlShfFkcPZoJw4rQtLkgXZtYRA0luw2v+aypP9COhnY3aymdhHiUhxh3wNzkEvVZDmk2/x7GTpVx0FwBOrABnhx3jbpbQtYsKajaWf3FeMK1chBQSvBewam+gXnyPrybISAi8pci1ZkBs4HwxcLvifzg4RlWSkkPref2wphZ88omnqWB2kepwcmDBOuVrW7qEklFp6PDC6bCUE32lPbqxLYbdMXlH9jTSWm8Fp0GWTLrbyrIu7YePA5B1zNWw9sDns/aJJTShD48EUY+lK4O9klNMx6UaKLOuRfF0U8TfrSwwnuqW4PJOIFr4RXywbT91qCbvA9/okDBG2KPrcwgjKHh7mRhBjs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28c3474-ce7a-4895-6e18-08d6f7d5b52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 12:24:15.7981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRob21hcw0KDQo+IE9uIFN1biwgMjMgSnVuIDIwMTksIEFuc29uLkh1YW5nQG54cC5jb20g
d3JvdGU6DQo+IA0KPiBBZ2FpbiB0aGUgc2hvcnQgc3VtbWFyeSBjb3VsZCBiZSBtb3JlIGluZm9y
bWF0aXZlLiBJbnN0ZWFkIG9mICdBZGQgZm9vJw0KPiB5b3UgY291bGQgc2F5Og0KPiANCj4gICAg
IC4uLi4uOiBNYWtlIHRpbWVyIHdvcmsgd2l0aCBwbGF0Zm9ybSBkcml2ZXIgbW9kZWwNCj4gDQo+
IFRoYXQgc3VtcyB1cCB0aGUgcmVhbCBtZWF0IG9mIHRoZSBwYXRjaC4gJ0FkZCBzb21lIG9wdGlv
bicgaXMgcHJldHR5DQo+IHVuaW5mb3JtYXRpdmUuDQoNCk1ha2VzIHNlbnNlLg0KDQo+IA0KPiA+
IE9uIHNvbWUgaS5NWDhNIHBsYXRmb3JtcywgY2xvY2sgZHJpdmVyIHVzZXMgcGxhdGZvcm0gZHJp
dmVyIG1vZGVsIGFuZA0KPiA+IGl0IGlzIE5PVCByZWFkeSBkdXJpbmcgdGltZXIgaW5pdGlhbGl6
YXRpb24gcGhhc2UsIHRoZSBjbG9jaw0KPiA+IG9wZXJhdGlvbnMgd2lsbCBmYWlsIGFuZCBzeXN0
ZW0gY291bnRlciBkcml2ZXIgd2lsbCBmYWlsIHRvby4gQXMgYWxsDQo+ID4gdGhlIGkuTVg4TSBw
bGF0Zm9ybXMnIHN5c3RlbSBjb3VudGVyIGNsb2NrIGFyZSBmcm9tIE9TQyB3aGljaCBpcw0KPiA+
IGFsd2F5cyBlbmFibGVkLCBzbyBpdCBpcyBubyBuZWVkIHRvIGVuYWJsZSBjbG9jayBmb3Igc3lz
dGVtIGNvdW50ZXINCj4gPiBkcml2ZXIsIHRoZSBPTkxZIHRoaW5nIGlzIHRvIHBhc3MgY2xvY2sg
ZnJlcXVlbmNlIHRvIGRyaXZlci4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhbiBvcHRpb24g
b2Ygc2tpcHBpbmcgb2ZfY2xrIG9wZXJhdGlvbiBmb3Igc3lzdGVtDQo+ID4gY291bnRlciBkcml2
ZXIsIGFuIG9wdGlvbmFsIHByb3BlcnR5ICJjbG9jay1mcmVxdWVuY3kiDQo+ID4gaXMgaW50cm9k
dWNlZCB0byBwYXNzIHRoZSBmcmVxdWVuY3kgdmFsdWUgdG8gc3lzdGVtIGNvdW50ZXIgZHJpdmVy
IGFuZA0KPiA+IGluZGljYXRlIGRyaXZlciB0byBza2lwIG9mX2NsayBvcGVyYXRpb25zLg0KPiAN
Cj4gVGhlIGNvbW1lbnRzIHRvIHRoZSBjaGFuZ2Vsb2cgb2YgcGF0Y2ggMSBhcHBseSBoZXJlIGFz
IHdlbGwgOikNCj4gDQo+IEhpbnQ6ICdUaGlzIHBhdGNoJw0KDQpPb3BzLi4uZGlkIE5PVCBub3Rp
Y2UgdGhhdCwgSSB3aWxsIHJlc2VuZCB0aGUgVjIgcGF0Y2ggc2VyaWVzIGFzIHRoZXkgYXJlIGFj
dHVhbGx5DQpzaW1pbGFyIGlzc3Vlcy4NCg0KVGhhbmtzLA0KQW5zb24NCg0KPiANCj4gVGhhbmtz
LA0KPiANCj4gCXRnbHgNCj4gDQoNCg==
