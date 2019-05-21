Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E92C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4452173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qetYA4F6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfEUFnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:43:49 -0400
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:23361
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfEUFnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g920yChoOtfQrD5RIxogV0JduC5vC6Bu98z+iEgYWy8=;
 b=qetYA4F63wjXsVEcbgl+ud4RbjwOXJRnjHX4Gz7f7LRz5FqQe6yVW1Eab8baKmD0aA6GlrJgZKqrp/huev9Tt/141xzQ9Xvbrk5N22YJY5VozjwFGEWUPo8bamudFjrlA8oprs77VE11JpvTDzFkXAlh0ewpViXSkOr6W/1Y/TQ=
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com (20.177.32.218) by
 AM6PR04MB6533.eurprd04.prod.outlook.com (20.179.246.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 05:43:33 +0000
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::a553:1f09:952e:9483]) by AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::a553:1f09:952e:9483%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 05:43:33 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Andy Tang <andy.tang@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v4] clk: qoriq: add support for lx2160a
Thread-Topic: [PATCH v4] clk: qoriq: add support for lx2160a
Thread-Index: AQHU+/zGE8MPZcMnA0GP8h3OejDbYKZ1N2hw
Date:   Tue, 21 May 2019 05:43:33 +0000
Message-ID: <AM6PR04MB4789787C4AB0613B1CF53DBCF3070@AM6PR04MB4789.eurprd04.prod.outlook.com>
References: <1556261624-20504-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1556261624-20504-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08f9aad2-5086-4f62-fc24-08d6ddaf4309
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6533;
x-ms-traffictypediagnostic: AM6PR04MB6533:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM6PR04MB65332B39412A8C4D188B9E9AF3070@AM6PR04MB6533.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:108;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(13464003)(189003)(199004)(110136005)(54906003)(478600001)(102836004)(305945005)(7736002)(4326008)(99286004)(6116002)(86362001)(6436002)(6506007)(486006)(2501003)(44832011)(53546011)(3846002)(76176011)(6246003)(2201001)(7696005)(229853002)(966005)(76116006)(476003)(8936002)(11346002)(66066001)(446003)(66946007)(73956011)(66446008)(81166006)(66556008)(186003)(81156014)(8676002)(33656002)(74316002)(26005)(66476007)(53936002)(64756008)(68736007)(2906002)(52536014)(5660300002)(256004)(55016002)(6306002)(71200400001)(71190400001)(14444005)(25786009)(316002)(9686003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6533;H:AM6PR04MB4789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YNuzIUoy+P8aNd735e+DwkpU4uVgkqD19iAgTVNgQtRlSuDsMsXvR7bFdcb2veF1J9TpGdpvUimfCfF18W0VgAdYJuDtlke+FbAN73xrTBdR+Y+jNKdp8iXBvKDWE99/JYtaqxBHbaBI1BYnmuuUBGspxFidGFCmwh9y6KkGzMBwEnQ1lHsJoYBDNK8KgBWShAHUOoAIjv38jmQFcOGrjw8xEUN+8wncfrvL6edtQO4yDJLtgwBfwZvoe6S3DYlhJ+zoECeMryP7TkjPspI8lm8qYlILptnTbPyx0vyrz0id7eXFv4Y35nSb2H2Lrgwj5xK8zWOWm2Ko/mig5QEDo5FLHkhQ6QK2A/Kri11/BEBzF3Mf5gJkKlVwtkK3NfUfH1Ta0h40O+Ic8NuhqjwO4TxMYk5UL0W12KGf1c3/G+I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f9aad2-5086-4f62-fc24-08d6ddaf4309
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 05:43:33.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU3RlcGhlbiwgDQpJIGhhdmUgaW5jb3Jwb3JhdGVkIHJldmlldyBjb21tZW50cyBmcm9t
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA5MTcxNzEvDQoNCkEgZ2VudGxl
IHJlbWluZGVyIHRvIGFwcGx5IHRoZSBwYXRjaCBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3BhdGNoLzEwOTE4NDA3Ly4NCg0KUmVnYXJkcywNClZhYmhhdg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNv
bT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAyNiwgMjAxOSAxMjoyNCBQTQ0KPiBUbzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
c2JveWRAa2VybmVsLm9yZzsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IFZhYmhhdiBTaGFybWEN
Cj4gPHZhYmhhdi5zaGFybWFAbnhwLmNvbT47IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+
OyBZb2dlc2gNCj4gTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIHY0XSBjbGs6IHFvcmlxOiBhZGQgc3VwcG9ydCBmb3IgbHgyMTYwYQ0K
PiANCj4gQWRkIGNsb2NrZ2VuIHN1cHBvcnQgYW5kIGNvbmZpZ3VyYXRpb24gZm9yIE5YUCBTb0Mg
bHgyMTYwYSB3aXRoDQo+IGNvbXBhdGlibGUgcHJvcGVydHkgYXMgImZzbCxseDIxNjBhLWNsb2Nr
Z2VuIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRhbmcgWXVhbnRpYW4gPGFuZHkudGFuZ0BueHAu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZb2dlc2ggR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54
cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhw
LmNvbT4NCj4gQWNrZWQtYnk6IFNjb3R0IFdvb2QgPG9zc0BidXNlcnJvci5uZXQ+DQo+IEFja2Vk
LWJ5OiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IEFja2VkLWJ5OiBWaXJlc2gg
S3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gQ2hhbmdlcyBmb3IgdjQ6
DQo+IC0gSW5jb3Jwb3JhdGVkIHJldmlldyBjb21tZW50cyBmcm9tIFN0ZXBoZW4gQm95ZA0KPiAN
Cj4gQ2hhbmdlcyBmb3IgdjM6DQo+IC0gSW5jb3Jwb3JhdGVkIHJldmlldyBjb21tZW50cyBvZiBS
YWZhZWwgSi4gV3lzb2NraQ0KPiAtIFVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UNCj4gDQo+IENoYW5n
ZXMgZm9yIHYyOg0KPiAtIFN1YmplY3QgbGluZSB1cGRhdGVkDQo+IA0KPiAgZHJpdmVycy9jbGsv
Y2xrLXFvcmlxLmMgfCAxMiArKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgYi9k
cml2ZXJzL2Nsay9jbGstcW9yaXEuYyBpbmRleA0KPiAzZDUxZDdjLi4xYTE1MjAxIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9jbGst
cW9yaXEuYw0KPiBAQCAtNTcwLDYgKzU3MCwxNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsb2Nr
Z2VuX2NoaXBpbmZvIGNoaXBpbmZvW10gPSB7DQo+ICAJCS5mbGFncyA9IENHX1ZFUjMgfCBDR19M
SVRUTEVfRU5ESUFOLA0KPiAgCX0sDQo+ICAJew0KPiArCQkuY29tcGF0ID0gImZzbCxseDIxNjBh
LWNsb2NrZ2VuIiwNCj4gKwkJLmNtdXhfZ3JvdXBzID0gew0KPiArCQkJJmNsb2NrZ2VuMl9jbXV4
X2NnYTEyLCAmY2xvY2tnZW4yX2NtdXhfY2diDQo+ICsJCX0sDQo+ICsJCS5jbXV4X3RvX2dyb3Vw
ID0gew0KPiArCQkJMCwgMCwgMCwgMCwgMSwgMSwgMSwgMSwgLTENCj4gKwkJfSwNCj4gKwkJLnBs
bF9tYXNrID0gMHgzNywNCj4gKwkJLmZsYWdzID0gQ0dfVkVSMyB8IENHX0xJVFRMRV9FTkRJQU4s
DQo+ICsJfSwNCj4gKwl7DQo+ICAJCS5jb21wYXQgPSAiZnNsLHAyMDQxLWNsb2NrZ2VuIiwNCj4g
IAkJLmd1dHNfY29tcGF0ID0gImZzbCxxb3JpcS1kZXZpY2UtY29uZmlnLTEuMCIsDQo+ICAJCS5p
bml0X3BlcmlwaCA9IHAyMDQxX2luaXRfcGVyaXBoLA0KPiBAQCAtMTQyNyw2ICsxNDM4LDcgQEAg
Q0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHMxMDQzYSwNCj4gImZzbCxsczEwNDNhLWNs
b2NrZ2VuIiwgY2xvY2tnZW5faW5pdCk7DQo+IENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2Vu
X2xzMTA0NmEsICJmc2wsbHMxMDQ2YS1jbG9ja2dlbiIsDQo+IGNsb2NrZ2VuX2luaXQpOyAgQ0xL
X09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHMxMDg4YSwgImZzbCxsczEwODhhLQ0KPiBjbG9j
a2dlbiIsIGNsb2NrZ2VuX2luaXQpOyAgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHMy
MDgwYSwNCj4gImZzbCxsczIwODBhLWNsb2NrZ2VuIiwgY2xvY2tnZW5faW5pdCk7DQo+ICtDTEtf
T0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9seDIxNjBhLCAiZnNsLGx4MjE2MGEtY2xvY2tnZW4i
LA0KPiArY2xvY2tnZW5faW5pdCk7DQo+ICBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9w
MjA0MSwgImZzbCxwMjA0MS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KPiBDTEtfT0ZfREVD
TEFSRShxb3JpcV9jbG9ja2dlbl9wMzA0MSwgImZzbCxwMzA0MS1jbG9ja2dlbiIsIGNsb2NrZ2Vu
X2luaXQpOw0KPiBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9wNDA4MCwgImZzbCxwNDA4
MC1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KPiAtLQ0KPiAyLjcuNA0KDQo=
