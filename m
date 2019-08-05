Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E84C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A48217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eGTrtY+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfHEEiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:38:06 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:49401
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfHEEiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd23NVKx7cDbYRak1zbr7KEEh/3maliFQuTyjQLmZib4HlmEVVsWKFztjfspvSqUIFaQMC0ZtK02Ph+ka/lzxugEh7rlOozTuhAEdSc1sMi9UDoLdNEaWWGMzVK1CuvkK0GIbaCsM2d2KNFlwDVAqJIdwxbA+9CVfw73XmJVwIQBwU2CeU33eCAeS/8QjoMbzsraTbbUe2MK8d5eC9aBHc7CFUbNOrHZY+n4KfPd/XC4E+qFYz3h+rOUvoOLNrGNYj3LoJlcb6xqpmWjGo50NGig1yPbIw3XILLS++MxheEzpB0xs+Ug/eQM8vK/Vp6oT+ZlpnEAW9rH/Ri9bei8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGm9qwKxbWy/x8EK8OcH3SFTISCiKNwgT0VpluwbUOU=;
 b=TU58vhZzealtubDbAdz0TYLbkjIWyzfBu30VTfB+0hIS6RbZbjUyaR8HBP4hWVnlOeTWPRNprhbJWVI9NPFRvzcrGsgyCDwnVMf/+pZQh8iVB0kZvp1qNKVuLQmJS9fz7kVVVwBlQ2X12PrNagYmna2P3Z/6HPlZW7McwNNxN7qFgbF6tj/XHUacQiuBmAkJDx2gk6QGzERz68IpUGqUtP8SZvx6tHDz/Bzk7FB16STOL6D7oWclDT3GGBNB/F26OcPZL5wlNdbYxVXk6aqxWmmqcwbEtGFnB7RVOmZmXSOZAYTzfDH8OzK5f3dHMy00FPixFecrHz9jws01qX9O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGm9qwKxbWy/x8EK8OcH3SFTISCiKNwgT0VpluwbUOU=;
 b=eGTrtY+VvanAfOZfPeUjBMC655eqhgUN0wygsMT3MWR+ji73S6L1fw8HeG9eR3wRcKR5LaGt4Zoa9YXAnG4SMMT0kY751ecU6La/vt4gATtiudgSeDwXCX8qOSsDgj+NUQ9UaCMJAgPxeSsT28wIvta3PUkAIxw709oNtX5AqR4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4708.eurprd04.prod.outlook.com (20.177.41.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 5 Aug 2019 04:38:02 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe%5]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 04:38:01 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v5 1/4] mailbox: imx: Fix Tx doorbell shutdown path
Thread-Topic: [PATCH v5 1/4] mailbox: imx: Fix Tx doorbell shutdown path
Thread-Index: AQHVSzvezKWv3EJXXkmBW/lAhGcXzabr9jwg
Date:   Mon, 5 Aug 2019 04:38:01 +0000
Message-ID: <AM0PR04MB42110CA7AD41C91EF763808B80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1564973491-18286-1-git-send-email-hongxing.zhu@nxp.com>
 <1564973491-18286-2-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1564973491-18286-2-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 559cfe55-22bb-4beb-6e2d-08d7195eb32d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4708;
x-ms-traffictypediagnostic: AM0PR04MB4708:
x-microsoft-antispam-prvs: <AM0PR04MB4708CCA41973650DCE9B7E7B80DA0@AM0PR04MB4708.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(51234002)(6436002)(5660300002)(9686003)(2501003)(81166006)(44832011)(26005)(486006)(14454004)(11346002)(186003)(6506007)(52536014)(66446008)(8676002)(110136005)(66946007)(53936002)(6636002)(55016002)(305945005)(4326008)(71190400001)(45080400002)(66476007)(76116006)(64756008)(8936002)(54906003)(66556008)(99286004)(86362001)(256004)(66066001)(229853002)(25786009)(68736007)(71200400001)(6246003)(2906002)(102836004)(316002)(446003)(7696005)(81156014)(74316002)(2201001)(14444005)(7736002)(33656002)(76176011)(478600001)(6116002)(3846002)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4708;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: APi9qBQaA/cRK14SD9xqHhaFOzrcGpI1+wEFklSORn9YILkkD5F4yM0q1XMTv3L/HPmfaB9L59Z5NWRvgFAe/SHw7Jcby+FCMTSsrZYP3W9xL1EUSea/gktVz8aSyyDWDsvTboZ26In1XvJPcb6KKUcCDzf76M7q1ffvQ1MLLQgDeFLntHvT2GQXkSmuCvhZxh29u7NvJQfGgl5ZlEoHUwwcADGpFYGeHcU/0jnR5JLslb+Sb700w16l2ttO3L6oCRQ+RG2+bDNbiVjZqCpuNWrz6JyRXNNzKF14PUj2CKgnOLZmWFoM7o2YMKLI/aD4gmBSjmRx6OJT5W5yI3kaBsWnHKsbQLpMToJ8v74Z6fq67vhsJnqgsplMt+RRpHSTAXY2oQyriai1OTM1qziWLiwnzod575SpmPQSkLWDCdE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559cfe55-22bb-4beb-6e2d-08d7195eb32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 04:38:01.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgQXVndXN0IDUsIDIwMTkgMTA6NTEgQU0NCj4gDQo+IFR4IGRvb3JiZWxsIGlzIGhhbmRsZWQg
YnkgdHhkYl90YXNrbGV0IGFuZCBkb2Vzbid0IGhhdmUgYW4gYXNzb2NpYXRlZCBJUlEuDQo+IA0K
PiBBbnlob3csIGlteF9tdV9zaHV0ZG93biBpZ25vcmVzIHRoaXMgYW5kIHRyaWVzIHRvIGZyZWUg
YW4gSVJRIHRoYXQgd2Fzbid0DQo+IHJlcXVlc3RlZCBmb3IgVHggREIgcmVzdWx0aW5nIGluIHRo
ZSBmb2xsb3dpbmcgd2FybmluZzoNCj4gDQo+IFsgICAgMS45Njc2NDRdIFRyeWluZyB0byBmcmVl
IGFscmVhZHktZnJlZSBJUlEgMjYNCj4gWyAgICAxLjk3MjEwOF0gV0FSTklORzogQ1BVOiAyIFBJ
RDogMTU3IGF0IGtlcm5lbC9pcnEvbWFuYWdlLmM6MTcwOA0KPiBfX2ZyZWVfaXJxKzB4YzAvMHgz
NTgNCj4gWyAgICAxLjk4MDAyNF0gTW9kdWxlcyBsaW5rZWQgaW46DQo+IFsgICAgMS45ODMwODhd
IENQVTogMiBQSUQ6IDE1NyBDb21tOiBrd29ya2VyLzI6MSBUYWludGVkOiBHDQo+IFsgICAgMS45
OTM1MjRdIEhhcmR3YXJlIG5hbWU6IEZyZWVzY2FsZSBpLk1YOFFYUCBNRUsgKERUKQ0KPiBbICAg
IDEuOTk4NjY4XSBXb3JrcXVldWU6IGV2ZW50cyBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMNCj4g
WyAgICAyLjAwMzgxMl0gcHN0YXRlOiA2MDAwMDA4NSAoblpDdiBkYUlmIC1QQU4gLVVBTykNCj4g
WyAgICAyLjAwODYwN10gcGMgOiBfX2ZyZWVfaXJxKzB4YzAvMHgzNTgNCj4gWyAgICAyLjAxMjM2
NF0gbHIgOiBfX2ZyZWVfaXJxKzB4YzAvMHgzNTgNCj4gWyAgICAyLjAxNjExMV0gc3AgOiBmZmZm
MDAwMDExNzliN2UwDQo+IFsgICAgMi4wMTk0MjJdIHgyOTogZmZmZjAwMDAxMTc5YjdlMCB4Mjg6
IDAwMDAwMDAwMDAwMDAwMTgNCj4gWyAgICAyLjAyNDczNl0geDI3OiBmZmZmMDAwMDExMjMzMDAw
IHgyNjogMDAwMDAwMDAwMDAwMDAwNA0KPiBbICAgIDIuMDMwMDUzXSB4MjU6IDAwMDAwMDAwMDAw
MDAwMWEgeDI0OiBmZmZmODAwODNiZWM3NGQ0DQo+IFsgICAgMi4wMzUzNjldIHgyMzogMDAwMDAw
MDAwMDAwMDAwMCB4MjI6IGZmZmY4MDA4M2JlYzc1ODgNCj4gWyAgICAyLjA0MDY4Nl0geDIxOiBm
ZmZmODAwODNiMWZlOGQ4IHgyMDogZmZmZjgwMDgzYmVjNzQwMA0KPiBbICAgIDIuMDQ2MDAzXSB4
MTk6IDAwMDAwMDAwMDAwMDAwMDAgeDE4OiBmZmZmZmZmZmZmZmZmZmZmDQo+IFsgICAgMi4wNTEz
MjBdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgICAy
LjA1NjYzN10geDE1OiBmZmZmMDAwMDExMTI5NmM4IHgxNDogZmZmZjAwMDA5MTc5YjUxNw0KPiBb
ICAgIDIuMDYxOTUzXSB4MTM6IGZmZmYwMDAwMTE3OWI1MjUgeDEyOiBmZmZmMDAwMDExMTQyMDAw
DQo+IFsgICAgMi4wNjcyNzBdIHgxMTogZmZmZjAwMDAxMTEyOWYyMCB4MTA6IGZmZmYwMDAwMTA1
ZGE5NzANCj4gWyAgICAyLjA3MjU4N10geDkgOiAwMDAwMDAwMGZmZmZmZmQwIHg4IDogMDAwMDAw
MDAwMDAwMDE5NA0KPiBbICAgIDIuMDc3OTAzXSB4NyA6IDYxMjA2NTY1NzI2NjIwNmYgeDYgOiBm
ZmZmMDAwMDExMWU3YjA5DQo+IFsgICAgMi4wODMyMjBdIHg1IDogMDAwMDAwMDAwMDAwMDAwMyB4
NCA6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgICAyLjA4ODUzN10geDMgOiAwMDAwMDAwMDAwMDAw
MDAwIHgyIDogMDAwMDAwMDBmZmZmZmZmZg0KPiBbICAgIDIuMDkzODU0XSB4MSA6IDI4YjcwZjBh
MmI2MGE1MDAgeDAgOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICAgMi4wOTkxNzNdIENhbGwgdHJh
Y2U6DQo+IFsgICAgMi4xMDE2MThdICBfX2ZyZWVfaXJxKzB4YzAvMHgzNTgNCj4gWyAgICAyLjEw
NTAyMV0gIGZyZWVfaXJxKzB4MzgvMHg5OA0KPiBbICAgIDIuMTA4MTcwXSAgaW14X211X3NodXRk
b3duKzB4OTAvMHhiMA0KPiBbICAgIDIuMTExOTIxXSAgbWJveF9mcmVlX2NoYW5uZWwucGFydC4y
KzB4MjQvMHhiOA0KPiBbICAgIDIuMTE2NDUzXSAgbWJveF9mcmVlX2NoYW5uZWwrMHgxOC8weDI4
DQo+IA0KPiBUaGlzIGJ1ZyBpcyBwcmVzZW50IGZyb20gdGhlIGJlZ2lubmluZyBvZiB0aW1lcy4N
Cj4gDQo+IENjOiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KDQpJIHRoaW5r
IHlvdSBzaG91bGQga2VlcCB0aGUgb3JpZ2luYWwgYXV0aG9yIGFuZCBGaXhlcyB0YWcuDQpPdGhl
cndpc2U6DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4N
Cg0KUmVnYXJkcw0KQWlzaGVuZw0K
