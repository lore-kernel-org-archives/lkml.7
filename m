Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFB6ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597B320640
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IhnF+al6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfJHIBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:01:39 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:56646
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730209AbfJHIBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:01:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIefr91/RSxFbBIbPEGa0r+se4lDPrOtgst46w/Phrcq/ZR8UXXdkKjkBkZBI9FDCv7Pw9smkWsuQ5oXSQMAwOKuqZPmwisx9GHQjMNLOrK3xhezzPNB0tr8sGwzWZrhUn6l4lkOosySROM0MzwnFcCnENCZr4iKG/WNai2ike+h+qOOnUsy/PJBMjy2Uf3rWEAlzmppZEpHftKJw1JMxfKwNX4NpDUPIb/0oSsALoiJCrVQlybJEoLSbWMXzjUhUvzIy0bSecZPNWKu1D+0ox0MCT1X4qpmFOUemNsWWdsiDZbKJ2w8cOiLdmjDsalcKS4Sk9nAdVZmfYSc81EXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM7QX7imgimnVbgWWr50R0hlf2OTQPRTNZddCEFI0PE=;
 b=RAMzocQIFZzKb8qdbhxxCkl9rFRUjXzEx91fmplAQldnpqd0FAaStAcloQX32or+E9R9uI6FiFxV+43LYyLwgSUGC/nRwOalkovI9VKZMOfngBug3Msh9Hk+pMipU08dAA98MtEi5OR/HCq/mJ3GvzWrhlQdkOyTyrax/nSoeBgMW6WfQiUQ1NC4BajVr7rpN+cQsjnVI3sSLnP9/C1jHj3yHK/Mq1ZHGqHCO1haUPDNdyluFEYb7BUbnd+xfVk/ER+w42OtLXOe78b+3zsLkVlb5WyafHPyN0gyqGDEnd4Y6Vt+TaxKBlANEOcSrvs7EKPjSCECCZCqsG9XoNQatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM7QX7imgimnVbgWWr50R0hlf2OTQPRTNZddCEFI0PE=;
 b=IhnF+al6qI/ydni9CYAGLdK0jGzq+Tg7uQN4i7uOJ+6XoSXuqXUMu0mCKYMkDXbDXDpjl+nVbtMjrsdXSoJGiHUoRcufMiS5JTEwi0oCeWi12APG2wmnG1UIq17G38G3YXW9sIsZvrgLrVR2Lbyd+s18HJCrKOS/tBx4Dfv3Rd4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.22; Tue, 8 Oct 2019 08:01:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.016; Tue, 8 Oct 2019
 08:01:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] clk: imx: clk-pll14xx: Make two variables static
Thread-Topic: [PATCH -next] clk: imx: clk-pll14xx: Make two variables static
Thread-Index: AQHVfajsFBVx9df7zE2zExgzoz0oladQYR3w
Date:   Tue, 8 Oct 2019 08:01:35 +0000
Message-ID: <DB3PR0402MB39167DC3767F8EBD53D7FAF0F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20191008071908.24568-1-yuehaibing@huawei.com>
In-Reply-To: <20191008071908.24568-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fd07922-b4f5-4e1b-2465-08d74bc5bdc3
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3770:|DB3PR0402MB3770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3770404C69BD4349293A6235F59A0@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:58;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(33656002)(256004)(66066001)(2501003)(76116006)(6436002)(8936002)(66946007)(99286004)(66446008)(476003)(14444005)(7696005)(44832011)(86362001)(229853002)(486006)(6636002)(25786009)(66556008)(66476007)(64756008)(6246003)(2201001)(76176011)(9686003)(74316002)(54906003)(110136005)(102836004)(7736002)(446003)(316002)(5660300002)(4326008)(305945005)(81156014)(81166006)(26005)(71200400001)(52536014)(71190400001)(186003)(2906002)(55016002)(8676002)(14454004)(11346002)(478600001)(3846002)(6116002)(6506007)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ek5zK++7ULOmQDyc5e3u69NyUKLNzSlo5wLuFSVnblp/o2dzHjCxlnM4t8SAHA9MOp8WF1wBjKiObpXChk5Oo0ItS1lcLnaPQ7hqOPl4oNHJlvo9OTVmud1PQAkZ5/zIJLv7uLE5tleMzZPrQATfN65NEl0NUnmsSLM6il79mTNnO+4qy5haiZVJS2Bk8D2ECdzjs0ayeH58qdOlYeM4Nvq9JFLq0jCCmIs/cY2yZAm0YRoDEtHX9kKB8iEuFjHoCfN9ZouCeVHwyy9egOM4DGn1lpuvXiPohb1gooxvCxWtmtT0QFc+NPqVbvgyZ7IrhvkUHU1F6WTbtOzqt8UzfjxK2Y+cTKFfv4O61paVvM+ecE/psPBqe2zkthnsnMVg9WSGD/aReJyK67/GUNjNzONxnigemeDi5uzGi0WvL4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd07922-b4f5-4e1b-2465-08d74bc5bdc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:01:35.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DU9uj4fNVLxn1ZBwJVgV957jwGfCRKYdO81H1j5U7pawp0sF/7FgR97ndAdmgjOrzL8IhJBTbdnck8KFs1FDQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQo+IEZpeCBzcGFyc2Ugd2FybmluZ3M6DQo+IA0KPiBkcml2ZXJzL2Nsay9pbXgvY2xr
LXBsbDE0eHguYzo0NDozNzoNCj4gIHdhcm5pbmc6IHN5bWJvbCAnaW14X3BsbDE0MTZ4X3RibCcg
d2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4gZHJpdmVycy9jbGsvaW14
L2Nsay1wbGwxNHh4LmM6NTc6Mzc6DQo+ICB3YXJuaW5nOiBzeW1ib2wgJ2lteF9wbGwxNDQzeF90
YmwnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IA0KPiBSZXBvcnRl
ZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFl1
ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KDQpJIGRpZCBOT1Qgc2VlIHRoaXMgd2FybmluZyBv
biBteSBzaWRlLCBkaWQgeW91IGVuYWJsZSBhbnkgc3BlY2lhbCBjb21waWxlIG9wdGlvbj8NCg0K
QW5zb24NCg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGstcGxsMTR4eC5jIHwgNCArKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstcGxsMTR4eC5jIGIvZHJpdmVycy9j
bGsvaW14L2Nsay1wbGwxNHh4LmMgaW5kZXgNCj4gN2ZhYWQ2MC4uNWM0NTgxOSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1wbGwxNHh4LmMNCj4gKysrIGIvZHJpdmVycy9jbGsv
aW14L2Nsay1wbGwxNHh4LmMNCj4gQEAgLTQxLDcgKzQxLDcgQEAgc3RydWN0IGNsa19wbGwxNHh4
IHsNCj4gDQo+ICAjZGVmaW5lIHRvX2Nsa19wbGwxNHh4KF9odykgY29udGFpbmVyX29mKF9odywg
c3RydWN0IGNsa19wbGwxNHh4LCBodykNCj4gDQo+IC1jb25zdCBzdHJ1Y3QgaW14X3BsbDE0eHhf
cmF0ZV90YWJsZSBpbXhfcGxsMTQxNnhfdGJsW10gPSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGlteF9wbGwxNHh4X3JhdGVfdGFibGUgaW14X3BsbDE0MTZ4X3RibFtdID0gew0KPiAgCVBMTF8x
NDE2WF9SQVRFKDE4MDAwMDAwMDBVLCAyMjUsIDMsIDApLA0KPiAgCVBMTF8xNDE2WF9SQVRFKDE2
MDAwMDAwMDBVLCAyMDAsIDMsIDApLA0KPiAgCVBMTF8xNDE2WF9SQVRFKDE1MDAwMDAwMDBVLCAz
NzUsIDMsIDEpLCBAQCAtNTQsNyArNTQsNyBAQA0KPiBjb25zdCBzdHJ1Y3QgaW14X3BsbDE0eHhf
cmF0ZV90YWJsZSBpbXhfcGxsMTQxNnhfdGJsW10gPSB7DQo+ICAJUExMXzE0MTZYX1JBVEUoNjAw
MDAwMDAwVSwgIDMwMCwgMywgMiksICB9Ow0KPiANCj4gLWNvbnN0IHN0cnVjdCBpbXhfcGxsMTR4
eF9yYXRlX3RhYmxlIGlteF9wbGwxNDQzeF90YmxbXSA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgaW14X3BsbDE0eHhfcmF0ZV90YWJsZSBpbXhfcGxsMTQ0M3hfdGJsW10gPSB7DQo+ICAJUExM
XzE0NDNYX1JBVEUoNjUwMDAwMDAwVSwgMzI1LCAzLCAyLCAwKSwNCj4gIAlQTExfMTQ0M1hfUkFU
RSg1OTQwMDAwMDBVLCAxOTgsIDIsIDIsIDApLA0KPiAgCVBMTF8xNDQzWF9SQVRFKDM5MzIxNjAw
MFUsIDI2MiwgMiwgMywgOTQzNyksDQo+IC0tDQo+IDIuNy40DQo+IA0KDQo=
