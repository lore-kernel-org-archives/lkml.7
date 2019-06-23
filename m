Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B0FC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4194E204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G+nxvAoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfFWLbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:31:55 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:60646
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbfFWLbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EplJru0wFtHv+mbG+DF8WGbTP6D78s2RG9xU26rbYT0=;
 b=G+nxvAoQEBhrLnOZOejjBQ9Izgd9TzDeIAoHjcyCv0yhFd28PfPxpbGwY5dsROtxTNiiJgjBw4b+gIqEF4hDv+rBt/HiatRyudroTs2W5iVot5fZzIAXeISoCnMPabGZx3KNG2pF39ZMZDhgkROqLXE7F0FhO10GcInzybQrm9A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Sun, 23 Jun 2019 11:31:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 11:31:12 +0000
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
Thread-Index: AQHVKAsVvJrYz1879kGVEJc1WrLeN6apEcoAgAAMJRA=
Date:   Sun, 23 Jun 2019 11:31:12 +0000
Message-ID: <DB3PR0402MB3916B3B871FDEA9BFC960C67F5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190621082838.12630-1-Anson.Huang@nxp.com>
 <alpine.DEB.2.21.1906231232520.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906231232520.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 315213db-9f76-49bd-337a-08d6f7ce4b90
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-microsoft-antispam-prvs: <DB3PR0402MB378759EB1DB2E34534F7D03EF5E10@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(51914003)(54534003)(13464003)(189003)(199004)(8936002)(3846002)(55016002)(102836004)(53936002)(7696005)(8676002)(6506007)(81166006)(81156014)(316002)(99286004)(6246003)(26005)(33656002)(6916009)(476003)(44832011)(11346002)(446003)(486006)(7416002)(2906002)(186003)(54906003)(256004)(9686003)(305945005)(7736002)(66946007)(229853002)(74316002)(86362001)(53546011)(14454004)(76176011)(6116002)(14444005)(478600001)(71200400001)(5660300002)(66066001)(25786009)(52536014)(68736007)(66556008)(71190400001)(4326008)(64756008)(66476007)(76116006)(73956011)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x5AQcBaneek9R+GZEnFtUEeGPZcOHRBz4MV3cqZJE7ENwmRJ/mEO+2kV3RFWDB7Ia73hQg/TEqlT52jssF1qNZx8WZUlBCiuc2MIXzM4DQJ8+AKGOFIgWbpRKKneWoqmECJtFn92qpwh1pIl86hSq7OFfqCuA/fdJJ9r9i7kc3RXOqYtPJ4izYFmnRMl/ZJW2HyauEyQiE8VMiYxEui64re/9iABlz8UF9MKmmx6hWhFW+jNTZ5srHiTkNTj0CDGwjIupNUKeRZMwozoxTmh+U4MA/T9j/VsbqBlv3aQSa9N/exUrifRW0Caso1kHynTrOXP43975tej2CGkvjIg3uFCdBsIvHFSJYFP2pOOknmm5yquv61PYAvH3O78bPQAEtH+lQNv3604nkLP9p4wfimcBnMZcN/dQOYmCAMBEYs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315213db-9f76-49bd-337a-08d6f7ce4b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 11:31:12.1719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRob21hcw0KCVRoYW5rcyBmb3IgdGhlIHVzZWZ1bCBjb21tZW50LCBJIHdpbGwgcmVzZW5k
IHRoZSBwYXRjaCB3aXRoIGltcHJvdmVtZW50Lg0KDQpBbnNvbi4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5k
ZT4NCj4gU2VudDogU3VuZGF5LCBKdW5lIDIzLCAyMDE5IDY6NDcgUE0NCj4gVG86IEFuc29uIEh1
YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogZGFuaWVsLmxlemNhbm9AbGluYXJvLm9y
Zzsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gc2hhd25ndW9A
a2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRl
Ow0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IEFiZWwgVmVz
YQ0KPiA8YWJlbC52ZXNhQG54cC5jb20+OyBjY2Fpb25lQGJheWxpYnJlLmNvbTsgYW5ndXNAYWtr
ZWEuY2E7DQo+IGFuZHJldy5zbWlybm92QGdtYWlsLmNvbTsgYWd4QHNpZ3hjcHUub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBjbG9ja3NvdXJj
ZS9kcml2ZXJzL3N5c2N0cjogQWRkIGFuIG9wdGlvbmFsDQo+IHByb3BlcnR5DQo+IA0KPiBBbnNv
biwNCj4gDQo+IE9uIEZyaSwgMjEgSnVuIDIwMTksIEFuc29uLkh1YW5nQG54cC5jb20gd3JvdGU6
DQo+IA0KPiA+IFN1YmplY3QgOiBbUEFUQ0ggMS8zXSBjbG9ja3NvdXJjZS9kcml2ZXJzL3N5c2N0
cjogQWRkIGFuIG9wdGlvbmFsDQo+ID4gcHJvcGVydHkNCj4gDQo+IFRoYXQgc3ViamVjdCBsaW5l
IGlzIG5vdCByZWFsbHkgaW5mb3JtYXRpdmUuIEZyb20gRG9jdW1lbnRhdGlvbjoNCj4gDQo+ICAg
ICAgVGhlIGBgc3VtbWFyeSBwaHJhc2VgYCBpbiB0aGUgZW1haWwncyBTdWJqZWN0IHNob3VsZCBj
b25jaXNlbHkNCj4gICAgICBkZXNjcmliZSB0aGUgcGF0Y2ggd2hpY2ggdGhhdCBlbWFpbCBjb250
YWlucy4NCj4gDQo+IFRoYXQgbWVhbnMgdGhhdCBpdCBzaG91bGQgdGVsbCB3aGljaCBwcm9wZXJ0
eSBpdCBhZGRzIHNvIGl0J3MgaW1tZWRpYXRlbHkgY2xlYXINCj4gd2hhdCB0aGlzIGlzIGFib3V0
LiBTb21ldGhpbmcgbGlrZToNCj4gDQo+ICBTdWJqZWN0OiBjbG9ja3NvdXJjZS9kcml2ZXJzL3N5
c2N0cjogQWRkIG9wdGlvbmFsIGNsb2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eQ0KPiANCj4gSG1tPw0K
PiANCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPg0KPiA+
IFRoaXMgcGF0Y2ggYWRkcyBhbiBvcHRpb25hbCBwcm9wZXJ0eSAiY2xvY2stZnJlcXVlbmN5IiB0
byBwYXNzDQo+IA0KPiBQbGVhc2UgcmVhZCBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGlu
Zy1wYXRjaGVzLnJzdCBhbmQgc2VhcmNoIGZvcg0KPiAnVGhpcyBwYXRjaCcNCj4gDQo+ID4gdGhl
IHN5c3RlbSBjb3VudGVyIGZyZXF1ZW5jeSB2YWx1ZSB0byBrZXJuZWwgc3lzdGVtIGNvdW50ZXIg
ZHJpdmVyIGFuZA0KPiA+IGluZGljYXRlIHRoZSBkcml2ZXIgdG8gc2tpcCBvZl9jbGsgb3BlcmF0
aW9ucywgdGhpcyBpcyB0byBzdXBwb3J0DQo+ID4gdGhvc2UgcGxhdGZvcm1zIHVzaW5nIHBsYXRm
b3JtIGRyaXZlciBtb2RlbCBmb3IgY2xvY2sgZHJpdmVyLg0KPiANCj4gVGhhdCBzZW50ZW5jZSBk
b2VzIG5vdCBwYXJzZS4gUGxlYXNlIHN0cnVjdHVyZSB5b3VyIGNoYW5nZWxvZyBpbiB0aGUNCj4g
Zm9sbG93aW5nIG9yZGVyOg0KPiANCj4gICAgMSkgQ29udGV4dCBvciBwcm9ibGVtDQo+IA0KPiAg
ICAyKSBEZXRhaWxlZCBhbmFseXNpcyAoaWYgYXBwbGljYWJsZSBhbmQgbmVjZXNzYXJ5KQ0KPiAN
Cj4gICAgMykgU2hvcnQgZGVzY3JpcHRpb24gb2YgdGhlIHNvbHV0aW9uICh0aGUgcmVzdCBpcyBv
YnZpb3VzIGZyb20gdGhlIHBhdGNoDQo+ICAgICAgIGl0c2VsZikuDQo+IA0KPiBTbyBzb21ldGhp
bmcgbGlrZSB0aGlzIChhc3N1bWVkIEkgZGVjb2RlZCB0aGUgYWJvdmUgY29ycmVjdGx5KToNCj4g
DQo+ICAgIFN5c3RlbXMgd2hpY2ggdXNlIHRoZSBzeXN0ZW0gY291bnRlciB3aXRoIHRoZSBwbGF0
Zm9ybSBkcml2ZXIgbW9kZWwNCj4gICAgcmVxdWlyZSB0aGUgY2xvY2sgZnJlcXVlbmN5IHRvIGJl
IHN1cHBsaWVkIHZpYSBkZXZpY2UgdHJlZS4NCj4gDQo+ICAgIFRoaXMgaXMgbmVjZXNzYXJ5IGFz
IGluIHRoZSBwbGF0Zm9ybSBkcml2ZXIgbW9kZWwgdGhlIG9mX2NsayBvcGVyYXRpb25zDQo+ICAg
IGRvIG5vdCB3b3JrIGNvcnJlY3RseSBiZWNhdXNlIExFTkdIVFkgRVhQTEFOQVRJT04gV0hZIC4u
Lg0KPiANCj4gICAgQWRkIHRoZSBvcHRpbmFsIGNsb2NrLWZyZXF1ZW5jeSB0byB0aGUgZGV2aWNl
IHRyZWUgYmluZGluZ3Mgb2YgdGhlIE5YUA0KPiAgICBzeXN0ZW0gY291bnRlciBzbyB0aGUgZnJl
cXVlbmN5IGNhbiBiZSBoYW5kZWQgaW4gYW5kIHRoZSBvZl9jbGsNCj4gICAgb3BlcmF0aW9ucyBj
YW4gYmUgc2tpcHBlZC4NCj4gDQo+IFRoZSBpbXBvcnRhbnQgcGFydCBpcyB0aGUgbWlzc2luZyBM
RU5HVEhZIEVYUExBTkFUSU9OIFdIWS4gSSBjYW4ndCBmaWxsDQo+IHRoYXQgaW4gYmVjYXVzZSB5
b3UgZGlkIG5vdCBwcm92aWRlIHRoYXQgaW5mb3JtYXRpb24uDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiAJdGdseA0K
