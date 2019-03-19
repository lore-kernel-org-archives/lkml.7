Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E2FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8992D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a/EtY8FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCSOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:34:59 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:47245
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbfCSOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYbZ+Wp9XWZpDkS9Cp0sRE7mlUvDuFfKitTj6R7kKNQ=;
 b=a/EtY8FSy81XkTuoHhBdS21bRy/faubW/BOjcrAEcHi+Dn2snOBtjRH94vlrlvKma/fQrIJt6ZnIEKmrA9mMqp62RYUlZ9mmPryNMpiUIYnAq+nDyXdKqsjXfvGPg7LWA+l/D2p60GctckUtuB0PRwI5hCgiGd+6boNWhnGjpm8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4017.eurprd04.prod.outlook.com (52.134.92.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 14:34:55 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 14:34:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Eric Nelson <eric@nelint.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     Anson Huang <anson.huang@nxp.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>
Subject: RE: [V2 1/2] clk: imx6q: remove unsupported pll4_audio_div
Thread-Topic: [V2 1/2] clk: imx6q: remove unsupported pll4_audio_div
Thread-Index: AQHU2CPGsb93fBEbMEW1mRpkDpfVDKYG52eAgAr5pICAAS7uYA==
Date:   Tue, 19 Mar 2019 14:34:51 +0000
Message-ID: <AM0PR04MB4211767C2F7ABF4A9A8EC3CC80400@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1552304271.2453.12.camel@pengutronix.de>
 <1552319997-24622-1-git-send-email-eric@nelint.com>
 <1552319997-24622-2-git-send-email-eric@nelint.com>
 <0cf890a4-20b0-13ce-14d3-06f7c3227655@nelint.com>
 <155294070124.20095.17167777488324467790@swboyd.mtv.corp.google.com>
In-Reply-To: <155294070124.20095.17167777488324467790@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3a140e8-4503-43b2-1bc9-08d6ac780db2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4017;
x-ms-traffictypediagnostic: AM0PR04MB4017:
x-microsoft-antispam-prvs: <AM0PR04MB4017A6B5BA9AB8CB41EDD2EE80400@AM0PR04MB4017.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(366004)(39860400002)(189003)(199004)(5660300002)(229853002)(93886005)(7736002)(305945005)(33656002)(86362001)(25786009)(66066001)(81166006)(14444005)(97736004)(256004)(186003)(6246003)(3846002)(8676002)(52536014)(71190400001)(2906002)(74316002)(8936002)(71200400001)(26005)(6666004)(6116002)(2501003)(486006)(4326008)(11346002)(76176011)(446003)(102836004)(476003)(6506007)(44832011)(105586002)(106356001)(81156014)(2201001)(7416002)(53936002)(9686003)(55016002)(68736007)(7696005)(6636002)(99286004)(110136005)(14454004)(316002)(478600001)(6436002)(54906003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4017;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +JiqB9mHv94fdrToyYHnrIUeeQBM38h+2tIXPNUmDThZQYQzk5D1oM//1lYc/rLWC7hVMX7WeeOXM0vN5nRiTrkldvperabWFVQZNQTIHwxzaZxMMl8oefQC3nQTRkstWCRq8+zySEpUoH1F5lJqnP/NBvdhOYKzVHU8fxqaNrZEXRp+2es5r+J74QrV40S4voPtXrLdd7IxwLjOQ5+iUGDhmb8OVr5O8cERg3MRLPWhE9F7mpW5z0p7J4aNmfXeJ5XeUAQJTZSRBIXuDwECKFTKtkRGlgfHSxSgrbM8Vw6m85ExBRelc+JEReXwc3LtNF1gaoBVpxKyUvmKF4K4CT+tfidxe2Q/sG1m4CxLtmXp/TcPfKD3xfJ6SUDEbFkr/kbpooygMS94hJVsY5aDuQjvL4MLZX89vUSyFKJbg/A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a140e8-4503-43b2-1bc9-08d6ac780db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 14:34:52.0785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiANCj4gUXVv
dGluZyBFcmljIE5lbHNvbiAoMjAxOS0wMy0xMSAxMzo0ODo1NSkNCj4gPiAgPiBPbiBNYXJjaCAx
MSwgMjAxOSwgNjozNSBwLm0uIFVUQywgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiA+ID4gUXVvdGlu
ZyBFcmljIE5lbHNvbiAoMjAxOS0wMy0xMSAwODo1OTo1NikNCj4gPiA+PiArICoNCj4gPiA+PiAr
ICogUmVuYW1lZCB0byBfQlJPS0VOIHRvIHByZXZlbnQgaW5hZHZlcnRlbnQgdXNlLA0KPiA+ID4+
ICsgKiBidXQgcmVzZXJ2ZWQgdGhlIGFycmF5IHNsb3QgdG8gbWFpbnRhaW4gRFQgYmluYXJ5DQo+
ID4gPj4gKyAqIGNvbXBhdGliaWxpdHkuDQo+ID4gPj4gKyAqLw0KPiA+ID4+ICsjZGVmaW5lIElN
WDZRRExfQ0xLX1BMTDRfQVVESU9fRElWX0JST0tFTiAgICAgIDIwMw0KPiA+ID4NCj4gPiA+IEJ1
dCBpdCBicmVha3MgdGhlIGJ1aWxkLiBJIGRvbid0IGdldCBpdC4gSnVzdCBhZGQgYSBjb21tZW50
DQo+ID4gPiBpbmRpY2F0aW5nIGl0IHNob3VsZG4ndCBiZSB1c2VkPyBUaGF0IGJyZWFrcyB0aGUg
Y3Jvc3MtdHJlZQ0KPiA+ID4gZGVwZW5kZW5jeSBjaGFpbiBhbmQgbGV0cyBjbGsgdHJlZSBtZXJn
ZSB0aGUgY2xrIGRyaXZlciBwYXJ0IGFuZCBhcm0tc29jDQo+IG1lcmdlIHRoZSBkdHMgcGFydC4N
Cj4gPiBUaGUgZGV2aWNlIHRyZWUgdXBkYXRlIGFsc28gcmVxdWlyZXMgdGhlIHVwZGF0ZSB0byBj
bGstaW14NnEuYyBmb3INCj4gPiBwcm9wZXIgcnVuLXRpbWUgb3BlcmF0aW9uLCBzbyBJIGRvbid0
IHNlZSBob3cgdGhlc2UgdHdvIHBhcnRzIGNhbiBiZQ0KPiA+IHNlcGFyYXRlZC4NCj4gPg0KPiA+
IEkgdGhvdWdodCBhYm91dCBsZWF2aW5nIHRoZSBQTEw0X0FVRElPX0RJViBjbG9jayBpbiBwbGFj
ZSBidXQgdHVybmluZw0KPiA+IGl0IGludG8gYSBkdW1teSAocGxhY2Vob2xkZXIpLCBidXQgdGhh
dCBtaWdodCBsZWFkIG90aGVycyBkb3duIHRoZQ0KPiA+IGxvbmcgcGF0aCBJIHRyYXZlcnNlZCBi
ZWZvcmUgSSBmb3VuZCBvdXQgdGhhdCBteSBtYW51YWwgd2FzIG9sZCBhbmQNCj4gPiB0aGUgY2xv
Y2sgZGlkbid0IGZ1bmN0aW9uLg0KPiANCj4gSSdtIG5vdCBzdWdnZXN0aW5nIHRoYXQgaXQncyBs
ZWZ0IGFzIGEgZHVtbXkgZm9yZXZlciwganVzdCB1bnRpbCB0aGUgb3RoZXIgdHJlZXMNCj4gY2Fu
IG1lcmdlIHRoZWlyIHBhcnRzIG9mIHRoaXMgc2VyaWVzIGFuZCBzbyB0aGF0IHRoZXNlIHBhdGNo
ZXMgY2FuIGJlIGFwcGxpZWQgaW4NCj4gb3JkZXIgdGhhdCB0aGV5J3JlIHNlbnQuIFJpZ2h0IG5v
dywgdGhlIGtidWlsZCByb2JvdCBmYWlscyBvbiB0aGlzIHBhdGNoIHNlcmllcw0KPiBiZWNhdXNl
IHRoaXMgcGF0Y2ggaW50ZW50aW9uYWxseSBicmVha3MgdGhlIGJ1aWxkLiBQbGVhc2UgZG9uJ3Qg
ZG8gdGhhdC4gU2VuZA0KPiBwYXRjaCBzZXJpZXMgdGhhdCBhcmUgYmlzZWN0YWJsZSBzbyB0aGF0
IHRoZSBidWlsZCBkb2Vzbid0IGJyZWFrIGluIHRoZSBtaWRkbGUuDQoNCkEgZ3JlcCBzaG93cyB0
aGVyZSdyZSBzdGlsbCBtYW55IHVzZXJzIG9mIGl0Lg0KJCBncmVwIC1ybiBJTVg2UURMX0NMS19Q
TEw0X0FVRElPX0RJViBhcmNoL2FybS9ib290L2R0cy8qLmR0cyoNCmFyY2gvYXJtL2Jvb3QvZHRz
L2lteDZxLWNtLWZ4Ni5kdHM6NDUxOgkJCTwmY2xrcyBJTVg2UURMX0NMS19QTEw0X0FVRElPX0RJ
Vj47DQphcmNoL2FybS9ib290L2R0cy9pbXg2cS1jbS1meDYuZHRzOjQ1MjoJYXNzaWduZWQtY2xv
Y2stcGFyZW50cyA9IDwmY2xrcyBJTVg2UURMX0NMS19QTEw0X0FVRElPX0RJVj47DQphcmNoL2Fy
bS9ib290L2R0cy9pbXg2cWRsLXNhYnJlYXV0by5kdHNpOjI4NzoJYXNzaWduZWQtY2xvY2stcGFy
ZW50cyA9IDwmY2xrcyBJTVg2UURMX0NMS19QTEw0X0FVRElPX0RJVj47DQphcmNoL2FybS9ib290
L2R0cy9pbXg2cWRsLXNhYnJlYXV0by5kdHNpLm9yaWc6MTI3Oglhc3NpZ25lZC1jbG9jay1wYXJl
bnRzID0gPCZjbGtzIElNWDZRRExfQ0xLX1BMTDRfQVVESU9fRElWPjsNCmFyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZxLW5vdmVuYS5kdHM6NDIxOgkJCQkJIDwmY2xrcyBJTVg2UURMX0NMS19QTEw0X0FV
RElPX0RJVj4sDQoNCldlIHByb2JhYmx5IG5lZWQgdG8gZml4IHRob3NlIGRldmljZSB0cmVlcyBm
aXJzdCBhbmQgdGhlbiBjYW4gbWFyayBpdCBhcyBCUk9LRU4NCmFuZCByZW1vdmUgZnJvbSB0aGUg
ZHJpdmVyIHN1cHBvcnQuDQoNCkNvcHkgTlhQIGF1ZGlvIGd1eXMgdG8gZG91YmxlIGNoZWNrIGlm
IHRoZSBpc3N1ZSBleGlzdHMgb24gdGhlIGRvd25zdHJlYW0gdHJlZQ0KYXMgSSBzYXcgdGhlIHNp
bWlsYXIgY29kZSB0aGVyZS4NCg0KU2hlbmdqaXUsDQpDYW4geW91IGhlbHAgY2hlY2sgaXQ/DQoN
ClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
