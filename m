Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ACAC004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CCE2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T4b7i5aF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfD2LaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:30:07 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:13038
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727914AbfD2LaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuAPYH8onV8p+o4fwQ4cbwM57P+pq8KZDTReELUQ8xg=;
 b=T4b7i5aFZLq8+ZRqWZrE1zs/UF85GAhdgXzFxofxE0+oFUY+Yt9ebGf9HxWvNl7altWwxEGJL+eI3gf15lsGIu6W3J33UEB/wASo4y876YK1RV3DVkC/ruAMjJi0KR9tFj/mr3n0ZoUvPNDZVG03qrKmiJSbtTYyIOU5OvfCkZM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5955.eurprd04.prod.outlook.com (20.178.112.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 11:28:21 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 11:28:21 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx: add fractional-N pll support to pllv4
Thread-Topic: [PATCH] clk: imx: add fractional-N pll support to pllv4
Thread-Index: AQHU/jo/D2ZwDi5WREOeVbOKgmEXYaZS+19A
Date:   Mon, 29 Apr 2019 11:28:21 +0000
Message-ID: <AM0PR04MB4211D3F29BCA3727E799005F80390@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556507637-22847-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1556507637-22847-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3be9bbf-0288-458a-83a6-08d6cc95c934
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5955;
x-ms-traffictypediagnostic: AM0PR04MB5955:
x-microsoft-antispam-prvs: <AM0PR04MB595598056691505BEF31D68C80390@AM0PR04MB5955.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(26005)(86362001)(6436002)(186003)(476003)(7696005)(11346002)(99286004)(229853002)(486006)(74316002)(71200400001)(6506007)(316002)(33656002)(55016002)(97736004)(256004)(9686003)(8936002)(44832011)(71190400001)(305945005)(68736007)(102836004)(7736002)(2201001)(2501003)(73956011)(66476007)(6116002)(76116006)(66066001)(446003)(25786009)(66446008)(3846002)(64756008)(66556008)(81166006)(4326008)(2906002)(66946007)(110136005)(81156014)(6246003)(52536014)(14454004)(76176011)(53936002)(478600001)(8676002)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5955;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0bG7w104ECuOkT4DOz574ISk7hnNW1HpyKlAcDbt9Q9klsuSrcL8K8aytoRD3cyNs6Ua03AsixWg67J2wQ4xRK5rveocUP7Qmb2CUHMsWyLXaEzKvHSP2fZ8B5uGoubIy415l1kQGXW+WeWdSw6Nft6QeAlRWcFEmV529JIFoC+erkn1eAIlH7idcApvoa/a41zVJaaCYeuSuMnHuZb3ozhsIK7wzYAPn8QwDQzays93NrCmD+94mahpYO81k7tFGioyVFyOH2/QESkCie7btn70VfCPzV3w7LlgHRk4FSY12irohN3KNipVnFeQM3eN9EkVcq4m+/V/W9bYHaL0UtTIuGSbyugT9g3V/CuYdlgLzcDgaKnnp52NFl9a5cPBCcZqUaD0Yjo+Ib3+Q8hwynkVD8quLUU8TyVEBNB/D8U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3be9bbf-0288-458a-83a6-08d6cc95c934
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 11:28:21.6418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5955
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBNb25kYXksIEFwcmlsIDI5LCAyMDE5IDExOjE5
IEFNDQo+IA0KDQpjbGs6IGlteDogcGxsdjQ6IGFkZCBmcmFjdGlvbmFsLU4gcGxsIHN1cHBvcnQN
Cg0KPiBUaGUgcGxsdjQgc3VwcG9ydHMgZnJhY3Rpb25hbC1OIGZ1bmN0aW9uLCB0aGUgZm9ybXVs
YSBpczoNCj4gDQo+IFBMTCBvdXRwdXQgZnJlcSA9IGlucHV0ICogKG11bHQgKyBudW0vZGVub20p
LA0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIGZyYWN0aW9uYWwtTiBmdW5jdGlvbiBzdXBwb3J0LCBp
bmNsdWRpbmcgY2xvY2sgcm91bmQgcmF0ZSwNCj4gY2FsY3VsYXRlIHJhdGUgYW5kIHNldCByYXRl
LCB3aXRoIHRoaXMgcGF0Y2gsIHRoZSBjbG9jayByYXRlIG9mIEFQTEwgaW4gY2xvY2sgdHJlZQ0K
PiBpcyBtb3JlIGFjY3VyYXRlIHRoYW4gYmVmb3JlOg0KPiANCj4gV2l0aG91dCBmcmFjdGlvbjoN
Cj4gYXBsbF9wcmVfc2VsICAgICAgICAgICAgICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDEg
ICAgMjQwMDAwMDANCj4gMCAgICAgMCAgNTAwMDANCj4gICAgYXBsbF9wcmVfZGl2ICAgICAgICAg
ICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDIgICAgMjQwMDAwMDANCj4gMCAgICAgMCAgNTAw
MDANCj4gICAgICAgYXBsbCAgICAgICAgICAgICAgICAgICAgICAgIDEgICAgICAgIDEgICAgICAg
IDIgICA1MjgwMDAwMDANCj4gMCAgICAgMCAgNTAwMDANCj4gICAgICAgICAgYXBsbF9wZmQzICAg
ICAgICAgICAgICAgIDAgICAgICAgIDAgICAgICAgIDAgICA3OTIwMDAwMDANCj4gMCAgICAgMCAg
NTAwMDANCj4gICAgICAgICAgYXBsbF9wZmQyICAgICAgICAgICAgICAgIDAgICAgICAgIDAgICAg
ICAgIDAgICAzMzk0Mjg1NzENCj4gMCAgICAgMCAgNTAwMDANCj4gICAgICAgICAgYXBsbF9wZmQx
ICAgICAgICAgICAgICAgIDAgICAgICAgIDAgICAgICAgIDAgICAzNTIwMDAwMDANCj4gMCAgICAg
MCAgNTAwMDANCj4gICAgICAgICAgICAgdXNkaGMwICAgICAgICAgICAgICAgIDAgICAgICAgIDAg
ICAgICAgIDAgICAzNTIwMDAwMDANCj4gMCAgICAgMCAgNTAwMDANCj4gICAgICAgICAgYXBsbF9w
ZmQwICAgICAgICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDEgICAzNTIwMDAwMDANCj4gMCAg
ICAgMCAgNTAwMDANCj4gDQo+IFdpdGggZnJhY3Rpb246DQo+IGFwbGxfcHJlX3NlbCAgICAgICAg
ICAgICAgICAgICAgICAxICAgICAgICAxICAgICAgICAxICAgIDI0MDAwMDAwDQo+IDAgICAgIDAg
IDUwMDAwDQo+ICAgIGFwbGxfcHJlX2RpdiAgICAgICAgICAgICAgICAgICAxICAgICAgICAxICAg
ICAgICAyICAgIDI0MDAwMDAwDQo+IDAgICAgIDAgIDUwMDAwDQo+ICAgICAgIGFwbGwgICAgICAg
ICAgICAgICAgICAgICAgICAxICAgICAgICAxICAgICAgICAyICAgNTI5MjAwMDAwDQo+IDAgICAg
IDAgIDUwMDAwDQo+ICAgICAgICAgIGFwbGxfcGZkMyAgICAgICAgICAgICAgICAwICAgICAgICAw
ICAgICAgICAwICAgNzkzODAwMDAwDQo+IDAgICAgIDAgIDUwMDAwDQo+ICAgICAgICAgIGFwbGxf
cGZkMiAgICAgICAgICAgICAgICAwICAgICAgICAwICAgICAgICAwICAgMzQwMjAwMDAwDQo+IDAg
ICAgIDAgIDUwMDAwDQo+ICAgICAgICAgIGFwbGxfcGZkMSAgICAgICAgICAgICAgICAwICAgICAg
ICAwICAgICAgICAwICAgMzUyODAwMDAwDQo+IDAgICAgIDAgIDUwMDAwDQo+ICAgICAgICAgICAg
IHVzZGhjMCAgICAgICAgICAgICAgICAwICAgICAgICAwICAgICAgICAwICAgMzUyODAwMDAwDQo+
IDAgICAgIDAgIDUwMDAwDQo+ICAgICAgICAgIGFwbGxfcGZkMCAgICAgICAgICAgICAgICAxICAg
ICAgICAxICAgICAgICAxICAgMzUyODAwMDAwDQo+IDAgICAgIDAgIDUwMDAwDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2Nsay9pbXgvY2xrLXBsbHY0LmMgfCA2OA0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MCBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9j
bGstcGxsdjQuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstcGxsdjQuYyBpbmRleA0KPiBkMzhiYzlm
Li40Y2VkNWNhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHY0LmMNCj4g
KysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2NC5jDQo+IEBAIC02NCwxMyArNjQsMTggQEAg
c3RhdGljIHVuc2lnbmVkIGxvbmcgY2xrX3BsbHY0X3JlY2FsY19yYXRlKHN0cnVjdA0KPiBjbGtf
aHcgKmh3LA0KPiAgCQkJCQkgICB1bnNpZ25lZCBsb25nIHBhcmVudF9yYXRlKQ0KPiAgew0KPiAg
CXN0cnVjdCBjbGtfcGxsdjQgKnBsbCA9IHRvX2Nsa19wbGx2NChodyk7DQo+IC0JdTMyIGRpdjsN
Cj4gKwl1MzIgbXVsdCA9IHJlYWRsX3JlbGF4ZWQocGxsLT5iYXNlICsgUExMX0NGR19PRkZTRVQp
Ow0KPiArCXUzMiBtZm4gPSByZWFkbF9yZWxheGVkKHBsbC0+YmFzZSArIFBMTF9OVU1fT0ZGU0VU
KTsNCj4gKwl1MzIgbWZkID0gcmVhZGxfcmVsYXhlZChwbGwtPmJhc2UgKyBQTExfREVOT01fT0ZG
U0VUKTsNCg0KTml0cGljazoNCldlIHVzdWFsbHkgZG9uJ3Qgd3JpdGUgY29kZSBsaWtlIHRoaXMu
DQpIb3cgYWJvdXQgc2VwYXJhdGUgdGhlIGFzc2lnbm1lbnQgZnJvbSBkZWNsYXJhdGlvbj8NCg0K
PiArCXU2NCB0ZW1wNjQgPSBwYXJlbnRfcmF0ZTsNCj4gDQo+IC0JZGl2ID0gcmVhZGxfcmVsYXhl
ZChwbGwtPmJhc2UgKyBQTExfQ0ZHX09GRlNFVCk7DQo+IC0JZGl2ICY9IEJNX1BMTF9NVUxUOw0K
PiAtCWRpdiA+Pj0gQlBfUExMX01VTFQ7DQo+ICsJbXVsdCAmPSBCTV9QTExfTVVMVDsNCj4gKwlt
dWx0ID4+PSBCUF9QTExfTVVMVDsNCj4gDQo+IC0JcmV0dXJuIHBhcmVudF9yYXRlICogZGl2Ow0K
PiArCXRlbXA2NCAqPSBtZm47DQo+ICsJZG9fZGl2KHRlbXA2NCwgbWZkKTsNCj4gKw0KPiArCXJl
dHVybiAocGFyZW50X3JhdGUgKiBtdWx0KSArICh1MzIpdGVtcDY0Ow0KPiAgfQ0KPiANCj4gIHN0
YXRpYyBsb25nIGNsa19wbGx2NF9yb3VuZF9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25l
ZCBsb25nIHJhdGUsIEBADQo+IC03OCwxNCArODMsNDcgQEAgc3RhdGljIGxvbmcgY2xrX3BsbHY0
X3JvdW5kX3JhdGUoc3RydWN0IGNsa19odyAqaHcsDQo+IHVuc2lnbmVkIGxvbmcgcmF0ZSwgIHsN
Cj4gIAl1bnNpZ25lZCBsb25nIHBhcmVudF9yYXRlID0gKnByYXRlOw0KPiAgCXVuc2lnbmVkIGxv
bmcgcm91bmRfcmF0ZSwgaTsNCj4gKwlib29sIGZvdW5kID0gZmFsc2U7DQo+ICsJdTMyIG1mbiwg
bWZkID0gMTAwMDAwMDsNCj4gKwl1MzIgbWF4X21mZCA9IDB4M0ZGRkZGRkY7DQoNClBsZWFzZSBr
ZWVwIHNvcnQgZnJvbSBsb25nIHRvIHNob3J0Lg0KQW5kIHRoZSBtdWx0aSBNYXhfbWZkIGRlZmlu
aXRpb25zIGNvdWxkIGJlIG1vdmUgb3V0IHRoZSBmdW5jdGlvbiBhbmQNCkRlZmluZWQgdXNlIG1h
Y3JvLg0KDQo+ICsJdTY0IHRlbXA2NDsNCj4gDQo+ICAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJ
WkUocGxsdjRfbXVsdF90YWJsZSk7IGkrKykgew0KPiAgCQlyb3VuZF9yYXRlID0gcGFyZW50X3Jh
dGUgKiBwbGx2NF9tdWx0X3RhYmxlW2ldOw0KPiAtCQlpZiAocmF0ZSA+PSByb3VuZF9yYXRlKQ0K
PiAtCQkJcmV0dXJuIHJvdW5kX3JhdGU7DQo+ICsJCWlmIChyYXRlID49IHJvdW5kX3JhdGUpIHsN
Cj4gKwkJCWZvdW5kID0gdHJ1ZTsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+
ICsJaWYgKCFmb3VuZCkgew0KPiArCQlwcl93YXJuKCIlczogdW5hYmxlIHRvIHJvdW5kIHJhdGUg
JWx1LCBwYXJlbnQgcmF0ZSAlbHVcbiIsDQo+ICsJCQljbGtfaHdfZ2V0X25hbWUoaHcpLCByYXRl
LCBwYXJlbnRfcmF0ZSk7DQo+ICsJCXJldHVybiAwOw0KPiAgCX0NCj4gDQo+IC0JcmV0dXJuIHJv
dW5kX3JhdGU7DQo+ICsJaWYgKHBhcmVudF9yYXRlIDw9IG1heF9tZmQpDQo+ICsJCW1mZCA9IHBh
cmVudF9yYXRlOw0KPiArDQo+ICsJdGVtcDY0ID0gKHU2NCkocmF0ZSAtIHJvdW5kX3JhdGUpOw0K
PiArCXRlbXA2NCAqPSBtZmQ7DQo+ICsJZG9fZGl2KHRlbXA2NCwgcGFyZW50X3JhdGUpOw0KPiAr
CW1mbiA9IHRlbXA2NDsNCj4gKw0KPiArCS8qDQo+ICsJICogTk9URTogVGhlIHZhbHVlIG9mIG51
bWVyYXRvciBtdXN0IGFsd2F5cyBiZSBjb25maWd1cmVkIHRvIGJlDQo+ICsJICogbGVzcyB0aGFu
IHRoZSB2YWx1ZSBvZiB0aGUgZGVub21pbmF0b3IuIElmIHdlIGNhbid0IGdldCBhIHByb3Blcg0K
PiArCSAqIHBhaXIgb2YgbWZuL21mZCwgd2Ugc2ltcGx5IHJldHVybiB0aGUgcm91bmRfcmF0ZSB3
aXRob3V0IHVzaW5nDQo+ICsJICogdGhlIGZyYWMgcGFydC4NCj4gKwkgKi8NCj4gKwlpZiAobWZu
ID49IG1mZCkNCj4gKwkJcmV0dXJuIHJvdW5kX3JhdGU7DQo+ICsNCj4gKwl0ZW1wNjQgPSAodTY0
KXBhcmVudF9yYXRlOw0KPiArCXRlbXA2NCAqPSBtZm47DQo+ICsJZG9fZGl2KHRlbXA2NCwgbWZk
KTsNCj4gKw0KPiArCXJldHVybiByb3VuZF9yYXRlICsgKHUzMil0ZW1wNjQ7DQo+ICB9DQo+IA0K
PiAgc3RhdGljIGJvb2wgY2xrX3BsbHY0X2lzX3ZhbGlkX211bHQodW5zaWduZWQgaW50IG11bHQp
IEBAIC0xMDYsMTcgKzE0NCwzMQ0KPiBAQCBzdGF0aWMgaW50IGNsa19wbGx2NF9zZXRfcmF0ZShz
dHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRlLCAgew0KPiAgCXN0cnVjdCBjbGtf
cGxsdjQgKnBsbCA9IHRvX2Nsa19wbGx2NChodyk7DQo+ICAJdTMyIHZhbCwgbXVsdDsNCj4gKwl1
MzIgbWZuLCBtZmQgPSAxMDAwMDAwOw0KPiArCXUzMiBtYXhfbWZkID0gMHgzRkZGRkZGRjsNCg0K
RGl0dG8NCg0KT3RoZXJ3aXNlOg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5k
b25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+ICsJdTY0IHRlbXA2NDsN
Cj4gDQo+ICAJbXVsdCA9IHJhdGUgLyBwYXJlbnRfcmF0ZTsNCj4gDQo+ICAJaWYgKCFjbGtfcGxs
djRfaXNfdmFsaWRfbXVsdChtdWx0KSkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiArCWlm
IChwYXJlbnRfcmF0ZSA8PSBtYXhfbWZkKQ0KPiArCQltZmQgPSBwYXJlbnRfcmF0ZTsNCj4gKw0K
PiArCXRlbXA2NCA9ICh1NjQpKHJhdGUgLSBtdWx0ICogcGFyZW50X3JhdGUpOw0KPiArCXRlbXA2
NCAqPSBtZmQ7DQo+ICsJZG9fZGl2KHRlbXA2NCwgcGFyZW50X3JhdGUpOw0KPiArCW1mbiA9IHRl
bXA2NDsNCj4gKw0KPiAgCXZhbCA9IHJlYWRsX3JlbGF4ZWQocGxsLT5iYXNlICsgUExMX0NGR19P
RkZTRVQpOw0KPiAgCXZhbCAmPSB+Qk1fUExMX01VTFQ7DQo+ICAJdmFsIHw9IG11bHQgPDwgQlBf
UExMX01VTFQ7DQo+ICAJd3JpdGVsX3JlbGF4ZWQodmFsLCBwbGwtPmJhc2UgKyBQTExfQ0ZHX09G
RlNFVCk7DQo+IA0KPiArCXdyaXRlbF9yZWxheGVkKG1mbiwgcGxsLT5iYXNlICsgUExMX05VTV9P
RkZTRVQpOw0KPiArCXdyaXRlbF9yZWxheGVkKG1mZCwgcGxsLT5iYXNlICsgUExMX0RFTk9NX09G
RlNFVCk7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC0tDQo+IDIuNy40DQoNCg==
