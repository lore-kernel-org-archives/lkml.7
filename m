Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CCDC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C741B2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VWHSb85x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfEUMqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:46:22 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:41956
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbfEUMqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCjIquD9DNq8D+A3/WjkFMtjQubFKnvBsIiNQxx7ZmM=;
 b=VWHSb85x/an56akxcZYhaYtCvSJCFvJ6wE6bZhM0XF/W0BQlvVVPkIsrOdf29UukuStNg48T06omb1wMfaZyutPcdu7hRxKklLVb0dnhAvgm9drenHcnU2LdTQLvv1QWaWN02gaSWnrYkb1KsFtzMA6lRx9UXxPebwD1X2HlGXI=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB3664.eurprd04.prod.outlook.com (52.134.15.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 12:45:36 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::2417:67da:c1aa:29f3]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::2417:67da:c1aa:29f3%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 12:45:36 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v4 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Topic: [PATCH v4 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Index: AQHVD6VyGxyzK/K+Ck6OWhJMa/LQ6aZ1WusAgAAZ3gCAAAsDgIAAAf1Q
Date:   Tue, 21 May 2019 12:45:36 +0000
Message-ID: <VI1PR0402MB3519E48F01380A3DE9FEC01487070@VI1PR0402MB3519.eurprd04.prod.outlook.com>
References: <20190521072355.12928-1-ping.bai@nxp.com>
 <20190521072355.12928-2-ping.bai@nxp.com>
 <5823cd07-312b-600c-1b78-dc5bff2a12eb@linaro.org>
 <VI1PR0402MB3519B14C5AF93F246907F03A87070@VI1PR0402MB3519.eurprd04.prod.outlook.com>
 <bc03b0c8-52cf-58e1-e7b3-bb1f2345c05b@linaro.org>
In-Reply-To: <bc03b0c8-52cf-58e1-e7b3-bb1f2345c05b@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-originating-ip: [117.81.146.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f959f2e-5d57-47f2-5755-08d6ddea38e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3664;
x-ms-traffictypediagnostic: VI1PR0402MB3664:
x-microsoft-antispam-prvs: <VI1PR0402MB3664C559FE13D67D3D985F3C87070@VI1PR0402MB3664.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(13464003)(446003)(11346002)(6116002)(476003)(478600001)(3846002)(99286004)(14454004)(66946007)(6636002)(2906002)(33656002)(81156014)(81166006)(8676002)(486006)(2501003)(8936002)(7696005)(66066001)(66446008)(52536014)(71200400001)(71190400001)(6246003)(9686003)(316002)(229853002)(76176011)(74316002)(68736007)(102836004)(256004)(53936002)(14444005)(5660300002)(54906003)(7736002)(110136005)(66556008)(86362001)(53546011)(6506007)(64756008)(26005)(186003)(76116006)(55016002)(73956011)(25786009)(66476007)(4326008)(6436002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3664;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mGCKtR/TED+94kIAvEB/+z5pfvucuoO/caAKeHAxNW6vX7W7H50AVXxmNs+8Aw7YJi11F2GOODYa19B5NtOc/+kI7pNNQYCuNGSFksWtpqQ1AR3SqVmW1OurUNuJeh6xnS8mR7nZAW+c/udn+j3ceLqHiA+m99TxFG7tOe0HEOGWunSfO6vhDusSiNc6IGRyaypO9Pd3VVyoeJw/p1lwHaMvqnUhqk/P7QlT/bG21f4eppwoXm+xeDfO7KSFB2zYLT4EEYRkj0wfoD3pCvqB9BNVdZ5d7ULp47WWev6006atVBtZ0aifmPw+XmaoriQu+LeQX5ErJhtq78412AnKDeOp6o3OYSVsYT0HREwmhgo79ntfyvXhn9gympTm1ydx5JM9FDlLFmIaCD19rRHKsFeYbF7Ha+/cytDH23Epf58=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f959f2e-5d57-47f2-5755-08d6ddea38e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 12:45:36.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIExlemNhbm8g
W21haWx0bzpkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBNYXkg
MjEsIDIwMTkgODoyMCBQTQ0KPiBUbzogSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgdGds
eEBsaW51dHJvbml4LmRlOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBBaXNoZW5nIERvbmcNCj4gPGFpc2hlbmcuZG9uZ0Bu
eHAuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi8yXSBkcml2ZXI6IGNsb2Nrc291cmNlOiBBZGQgbnhwIHN5
c3RlbSBjb3VudGVyIHRpbWVyDQo+IGRyaXZlciBzdXBwb3J0DQo+IA0KPiBPbiAyMS8wNS8yMDE5
IDE0OjAxLCBKYWNreSBCYWkgd3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogRGFuaWVsIExlemNhbm8gW21haWx0bzpkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnXQ0KPiA+PiBTZW50OiBUdWVzZGF5LCBNYXkgMjEsIDIwMTkgNjowOCBQTQ0KPiA+
PiBUbzogSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOw0K
PiA+PiByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiA+PiBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjQgMi8yXSBkcml2ZXI6IGNsb2Nrc291cmNlOiBBZGQgbnhwIHN5c3Rl
bQ0KPiA+PiBjb3VudGVyIHRpbWVyIGRyaXZlciBzdXBwb3J0DQo+ID4+DQo+ID4+IE9uIDIxLzA1
LzIwMTkgMDk6MTgsIEphY2t5IEJhaSB3cm90ZToNCj4gPj4+IEZyb206IEJhaSBQaW5nIDxwaW5n
LmJhaUBueHAuY29tPg0KPiA+Pj4NCj4gPj4+IFRoZSBzeXN0ZW0gY291bnRlciAoc3lzX2N0cikg
aXMgYSBwcm9ncmFtbWFibGUgc3lzdGVtIGNvdW50ZXIgd2hpY2gNCj4gPj4+IHByb3ZpZGVzIGEg
c2hhcmVkIHRpbWUgYmFzZSB0byB0aGUgQ29ydGV4IEExNSwgQTcsIEE1MyBldGMgY29yZXMuDQo+
ID4+PiBJdCBpcyBpbnRlbmRlZCBmb3IgdXNlIGluIGFwcGxpY2F0aW9ucyB3aGVyZSB0aGUgY291
bnRlciBpcyBhbHdheXMNCj4gPj4+IHBvd2VyZWQgb24gYW5kIHN1cHBvcnRzIG11bHRpcGxlLCB1
bnJlbGF0ZWQgY2xvY2tzLiBUaGUgc3lzX2N0cg0KPiA+Pj4gaGFyZHdhcmUNCj4gPj4+IHN1cHBv
cnRzOg0KPiA+Pj4gIC0gNTYtYml0IGNvdW50ZXIgd2lkdGggKHJvbGwtb3ZlciB0aW1lIGdyZWF0
ZXIgdGhhbiA0MCB5ZWFycykNCj4gPj4NCj4gPj4gVGhlIGJlbmVmaXQgb2YgdXNpbmcgbW9yZSB0
aGFuIDMyYml0cyBvbiBhIDMyYml0cyBzeXN0ZW0gaXMgbm90IHByb3Zlbi4NCj4gPj4NCj4gPg0K
PiA+IEl0IGlzIG1haW5seSB1c2VkIG9uIDY0Yml0IEFSTXY4IHN5c3RlbS4NCj4gDQo+IE9oLCBv
ay4gRmFpciBlbm91Z2guDQo+IA0KPiA+DQo+ID4+IFRoZSBmdW5jdGlvbiB0byByZWFkIGFuZCBi
dWlsZCB0aGUgNTZiaXRzIHZhbHVlIGNhbiBoYXZlIGEgdmVyeQ0KPiA+PiBzaWduaWZpY2FudCBp
bXBhY3Qgb24gdGhlIHBlcmZvcm1hbmNlIG9mIHlvdXIgcGxhdGZvcm0uDQo+ID4+DQo+ID4+IFVz
aW5nIGEgMzJiaXRzIGNvdW50ZXIgY2FuIGJlIGVub3VnaCBpZiBpdCBkb2VzIG5vdCB3cmFwIHRv
byBmYXN0Lg0KPiA+Pg0KPiA+PiBDYW4geW91IGNvbnNpZGVyIGEgMzIgYml0cyBjb3VudGVyID8N
Cj4gPg0KPiA+IHRoaXMgY291bnRlciBpcyBBUk12OCBhcmNoIHRpbWVyJ3MgY291bnRlciBzb3Vy
Y2UuIEFzIGl0IGFsc28gaGFzDQo+ID4gdGltZXIgZnVuY3Rpb24sIHNvIEkgY2hvb3NlIGl0IHRv
IGFjdCBhcyBhIGJyb2FkY2FzdCB0aW1lciBmb3IgY3B1aWRsZS4gVGhlDQo+IHRpbWVyIGludGVy
cnVwdCBjYW4gb25seSBiZSB0cmlnZ2VyZWQgd2hlbiAnY29tcGFyZVs1NTowXSA8PSBjb3VudGVy
WzU1OjBdJy4NCj4gPiBTbyB5b3UgbWVhbiB0aGF0IG9ubHkgdXNlIHRoZSBsb3dlciAzMmJpdCB0
byBpbXBsZW1lbnQgdGhpcyB0aW1lcj8gSWYgc28sIEkNCj4gY2FuIGNoYW5nZSB0byB1c2Ugb25s
eSB0aGUgbG93ZXIgMzJiaXQuDQo+IA0KPiBJTU8gaXQgaXMgcHJlZmVyYWJsZSBidXQgeW91IGRl
Y2lkZSAocHJvYmFibHkgY29tcGFyZSB3aXRoIGhvdyBsb25nIGl0IHRha2VzDQo+IHRvIHdyYXAg
d2hlbiAzMmJpdHMpLg0KPiANCg0KTm9ybWFsbHksIGl0IGlzIGRyaXZlbiBieSBmaXhlZCA4TUh6
IGNsb2NrLiAzMmJpdCBoYXMgcmlzaywgd2hlbiB0aGUgbG93ZXIgMzJiaXQgd3JhcHBlZCwNCnRo
ZW4gdGhlICdjb3VudGVyIHZhbHVlID49IGNvbXBhcmUgdmFsdWUnIGlzIHRydWUgaWYgb25seSB1
c2UgMzJiaXQgZm9yIHRpbWVyLCB0aGVuIElSUSB3aWxsDQpQZW5kaW5nIGFsbCB0aGUgdGltZS4g
SSB3aWxsIGtlZXAgdXNlIHRoZSB3aG9sZSA1NmJpdC4NCg0KPiANCj4gDQoNCg==
