Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F12EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E41208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="AS0DVPai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436632AbfHIPf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:35:27 -0400
Received: from mail-eopbgr10100.outbound.protection.outlook.com ([40.107.1.100]:13454
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406607AbfHIPf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcs77kLXzz5pNGW4mbVXY+NMUPcagWfj4cfVuvfzzySEcIzDqSBz5b6kv1Xjr0dccJJiuFZ7q47bknuvIJWj8EDynqd0hxWF830jeGg0V+tT5RiA6qT3bTtETWitqeCs9FDpKXm221dKbdXE8HuWUcI9bC5T6DdEvpZOTLBJn19RDaCu1oCwRZm5Z2W/2tHz83GuIpItIrj1A5UqrvQi2T9i+kIE0pVP8ZueihEwSIdjeobSbVE9FOYc2YdUKlIC//KlpZPU6yNn20FxKZW9A5SgeaACq8QatanQHaNHI+DT6ygQJ1OgCf7mTf2l5w1GHm3QTuifZRLt631qxu1LAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fus1xpv+pdnahuQCa4w81wMKvSS0NLtupueKWJf6tsU=;
 b=g9oWaR+O5ODCDSKWmcvq9aZ7Tr9+vJRpYNpi4nNKX4aFaBjyNbnfx3wYP+lSmQ6joP1uAYdIJXsuJezxPRDEEPX0Z7tc32QYUvEze6wlqEEUKpcrnOTJV1NnJdIKHV9k2aY0m8tL//5LexetblVMIWxN/dNDjOmlP+t4z0NAJa1qpDaR8aAMiE79gmGopB7SDvrwfb3RKewsDa48z98qS91vcqWTmC5cURH+77SO3zwgsulUYfu+vLgH1+rVxVOJ/8hrqU22juW3k8pdMBiOFnBe+nXATPZtcyfdXMIbD8Lmqxu2cgQMnn2q1QKb1jKqP5Pa779WuIOqPDx52OdTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fus1xpv+pdnahuQCa4w81wMKvSS0NLtupueKWJf6tsU=;
 b=AS0DVPaiQ0xJldCT579vsLScJid9baotHZRducOgyM+eFh8J98NjEl1fkatxsS83rcFxj2+F+5VV5cuQmmtSXjRdbRxnQ1j8F0YwhmDfDbSg4+rui++YtV3LKGp6DWjD14POOylT/7L1YwEeJPHJaDmLIOVkotBo7+B/wuqmqsc=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB4909.eurprd05.prod.outlook.com (20.177.51.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 9 Aug 2019 15:35:20 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:35:20 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 12/21] ARM: dts: imx6-apalis: Add touchscreens used on
 Toradex eval boards
Thread-Topic: [PATCH v3 12/21] ARM: dts: imx6-apalis: Add touchscreens used on
 Toradex eval boards
Thread-Index: AQHVTPnRZ2IxbStZgES4tR0yMF4TW6by9iWA
Date:   Fri, 9 Aug 2019 15:35:20 +0000
Message-ID: <e8bba2172801ca926a556e828dc08292a07f5704.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-13-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-13-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 718fabf7-6505-4dea-5285-08d71cdf2feb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4909;
x-ms-traffictypediagnostic: VI1PR05MB4909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB490957E0D5BB1FADABF7EE75FBD60@VI1PR05MB4909.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(199004)(189003)(186003)(14444005)(256004)(6506007)(446003)(11346002)(102836004)(6116002)(46003)(76176011)(2616005)(118296001)(478600001)(476003)(44832011)(71200400001)(71190400001)(66446008)(8936002)(66476007)(66556008)(486006)(66946007)(64756008)(2906002)(91956017)(76116006)(2501003)(25786009)(4326008)(53936002)(6512007)(86362001)(2201001)(305945005)(99286004)(7736002)(14454004)(7416002)(6436002)(36756003)(6486002)(5660300002)(110136005)(316002)(6246003)(54906003)(229853002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4909;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nqKAd0xk7keIp8cPSWVAFKDYLrOhB9U+VdOjN6J+B5BHK2/wlW4RbO11X1JmrluAp18E0FkWvODn7GxVaDGO7MOqveTRrWJ2GLs2JzkK42W/jbw/eyRT4AmFnKNszlwFG1QDGK1kDiaO+bbix73VmQigygqM1Jm9dx0Fgu9WpLfsuypXCv8/vNzQi3XnxkRc/6Jn91539w9aYE7+OGFl+cyHcObztBsHOvvyfqZZFYQJCqEh4AwMQnqQ3kaAIbZZLUObtmube33J4eujB0XpLZMzWnpQhlg75XkAqTx74AmA0NiHSQmMHySth7usvsQV95ABNvL5qGzr0524FNj6CQz4Sl6zi3wTyE5dbd7PxlMEwtXit9Fn+yd4+a1HgF9K5vuYCPqVXkalV2GZ2UXhyT/N3YGnCFMFNKvDHypfPQ0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D22C3F5D34AF6A48ABB2B25F40AF38C6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718fabf7-6505-4dea-5285-08d71cdf2feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:35:20.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyqGKTFY6AYjH9k+kSEROPkCEf8QjogsCnK4ObynaiO4hwq8fBA4Zweu9Uj3T1AfZbhZCzeXQUjKXfO+C6Qt+0dyynY8HSSCsqlMOJWJlCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcGUNCg0KT24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBw
ZSBTY2hlbmtlciB3cm90ZToNCj4gVGhpcyBjb21taXQgYWRkcyB0aGUgdG91Y2hzY3JlZW5zIGZy
b20gVG9yYWRleCBzbyBvbmUgY2FuIGVuYWJsZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBo
aWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gDQo+IC0t
LQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBGaXggY29tbWl0IHRpdGxlIHRvICIuLi5pbXg2
LWFwYWxpczouLi4iDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIERlbGV0ZWQgdG91Y2hyZXZv
bHV0aW9uIGRvd25zdHJlYW0gc3R1ZmYNCj4gLSBVc2UgZ2VuZXJpYyBub2RlIG5hbWUNCj4gLSBQ
dXQgYSBiZXR0ZXIgY29tbWVudCBpbiB0aGVyZQ0KPiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZkbC1jb2xpYnJpLWV2YWwtdjMuZHRzICB8IDMxDQo+ICsrKysrKysrKysrKysrKysrKysNCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1ldmFsLmR0cyAgICAgICB8IDEzICsrKysr
KysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFsaXMtaXhvcmEtdjEuMS5kdHMgfCAx
MyArKysrKysrKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEtYXBhbGlzLWl4b3JhLmR0cyAg
ICAgIHwgMTMgKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC1jb2xpYnJpLWV2YWwt
djMuZHRzDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12My5kdHMN
Cj4gaW5kZXggOWE1ZDZjOTRjY2E0Li43NjNmYjVlOTBiZDMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZkbC1jb2xpYnJpLWV2YWwtdjMuZHRzDQo+ICsrKyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZkbC1jb2xpYnJpLWV2YWwtdjMuZHRzDQo+IEBAIC0xNjgsNiArMTY4LDIx
IEBADQo+ICAmaTJjMyB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgDQo+ICsJLyoNCj4gKwkg
KiBUb3VjaHNjcmVlbiBpcyB1c2luZyBTT0RJTU0gMjgvMzAsIGFsc28gdXNlZCBmb3IgUFdNPEI+
LA0KPiBQV008Qz4sDQo+ICsJICogYWthIHB3bTIsIHB3bTMuIHNvIGlmIHlvdSBlbmFibGUgdG91
Y2hzY3JlZW4sIGRpc2FibGUgdGhlDQo+IHB3bXMNCj4gKwkgKi8NCj4gKwl0b3VjaHNjcmVlbkA0
YSB7DQo+ICsJCWNvbXBhdGlibGUgPSAiYXRtZWwsbWF4dG91Y2giOw0KPiArCQlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPiArCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcGNhcF8xPjsNCj4g
KwkJcmVnID0gPDB4NGE+Ow0KPiArCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvMT47DQo+ICsJ
CWludGVycnVwdHMgPSA8OSBJUlFfVFlQRV9FREdFX0ZBTExJTkc+OwkJLyoNCj4gU09ESU1NIDI4
ICovDQo+ICsJCXJlc2V0LWdwaW9zID0gPCZncGlvMiAxMCBHUElPX0FDVElWRV9ISUdIPjsJLyoN
Cj4gU09ESU1NIDMwICovDQo+ICsJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJfTsNCj4gKw0K
PiAgCS8qIE00MVQwTTYgcmVhbCB0aW1lIGNsb2NrIG9uIGNhcnJpZXIgYm9hcmQgKi8NCj4gIAly
dGNfaTJjOiBydGNANjggew0KPiAgCQljb21wYXRpYmxlID0gInN0LG00MXQwIjsNCj4gQEAgLTE3
NSw2ICsxOTAsMjIgQEANCj4gIAl9Ow0KPiAgfTsNCj4gIA0KPiArJmlvbXV4YyB7DQo+ICsJcGlu
Y3RybF9wY2FwXzE6IHBjYXAtMSB7DQo+ICsJCWZzbCxwaW5zID0gPA0KPiArCQkJTVg2UURMX1BB
RF9HUElPXzlfX0dQSU8xX0lPMDkJMHgxYjBiMCAvKg0KPiBTT0RJTU0gMjggKi8NCj4gKwkJCU1Y
NlFETF9QQURfU0Q0X0RBVDJfX0dQSU8yX0lPMTAJMHgxYjBiMCAvKg0KPiBTT0RJTU0gMzAgKi8N
Cj4gKwkJPjsNCj4gKwl9Ow0KDQpXaGF0IGV4YWN0bHkgYXJlIHRoZSBhYm92ZSB3aGljaCBnZXQg
dXNlZCBmdXJ0aGVyIHVwIHZzLiB0aGUgYmVsb3cNCndoaWNoIGRvIG5vdCBzZWVtIHRvIGdldCB1
c2VkIGFueXdoZXJlPw0KDQo+ICsJcGluY3RybF9teHRfdHM6IG14dC10cyB7DQo+ICsJCWZzbCxw
aW5zID0gPA0KPiArCQkJTVg2UURMX1BBRF9FSU1fQ1MxX19HUElPMl9JTzI0CTB4MTMwYjAgLyoN
Cj4gU09ESU1NIDEwNyAqLw0KPiArCQkJTVg2UURMX1BBRF9TRDJfREFUMV9fR1BJTzFfSU8xNAkw
eDEzMGIwIC8qDQo+IFNPRElNTSAxMDYgKi8NCj4gKwkJPjsNCj4gKwl9Ow0KPiArfTsNCj4gKw0K
PiAgJmlwdTFfZGkwX2Rpc3AwIHsNCj4gIAlyZW1vdGUtZW5kcG9pbnQgPSA8JmxjZF9kaXNwbGF5
X2luPjsNCj4gIH07DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFs
aXMtZXZhbC5kdHMNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFsaXMtZXZhbC5kdHMN
Cj4gaW5kZXggMGVkZDMwNDNkOWMxLi40NjY1ZTE1YjE5NmQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1ldmFsLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2cS1hcGFsaXMtZXZhbC5kdHMNCj4gQEAgLTE2Nyw2ICsxNjcsMTkgQEANCj4gICZp
MmMxIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICANCj4gKwkvKg0KPiArCSAqIFRvdWNoc2Ny
ZWVuIGlzIHVzaW5nIFNPRElNTSAyOC8zMCwgYWxzbyB1c2VkIGZvciBQV008Qj4sDQo+IFBXTTxD
PiwNCj4gKwkgKiBha2EgcHdtMiwgcHdtMy4gc28gaWYgeW91IGVuYWJsZSB0b3VjaHNjcmVlbiwg
ZGlzYWJsZSB0aGUNCj4gcHdtcw0KPiArCSAqLw0KPiArCXRvdWNoc2NyZWVuQDRhIHsNCj4gKwkJ
Y29tcGF0aWJsZSA9ICJhdG1lbCxtYXh0b3VjaCI7DQo+ICsJCXJlZyA9IDwweDRhPjsNCj4gKwkJ
aW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzY+Ow0KPiArCQlpbnRlcnJ1cHRzID0gPDEwIElSUV9U
WVBFX0VER0VfRkFMTElORz47DQo+ICsJCXJlc2V0LWdwaW9zID0gPCZncGlvNiA5IEdQSU9fQUNU
SVZFX0hJR0g+OyAvKiBTT0RJTU0gMTMNCj4gKi8NCg0KV291bGRuJ3QgYWJvdmUgdHdvIHBpbnMg
YWxzbyBuZWVkIHJlc3AuIHBpbmN0cmwgZW50cmllcz8NCg0KPiArCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiArCX07DQo+ICsNCj4gIAlwY2llLXN3aXRjaEA1OCB7DQo+ICAJCWNvbXBhdGlibGUg
PSAicGx4LHBleDg2MDUiOw0KPiAgCQlyZWcgPSA8MHg1OD47DQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9pbXg2cS1hcGFsaXMtaXhvcmEtdjEuMS5kdHMNCj4gYi9hcmNoL2FybS9i
b290L2R0cy9pbXg2cS1hcGFsaXMtaXhvcmEtdjEuMS5kdHMNCj4gaW5kZXggYjk0YmI2ODdiZTZi
Li5hM2ZhMDRhOTdkODEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFw
YWxpcy1peG9yYS12MS4xLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFs
aXMtaXhvcmEtdjEuMS5kdHMNCj4gQEAgLTE3Miw2ICsxNzIsMTkgQEANCj4gICZpMmMxIHsNCj4g
IAlzdGF0dXMgPSAib2theSI7DQo+ICANCj4gKwkvKg0KPiArCSAqIFRvdWNoc2NyZWVuIGlzIHVz
aW5nIFNPRElNTSAyOC8zMCwgYWxzbyB1c2VkIGZvciBQV008Qj4sDQo+IFBXTTxDPiwNCj4gKwkg
KiBha2EgcHdtMiwgcHdtMy4gc28gaWYgeW91IGVuYWJsZSB0b3VjaHNjcmVlbiwgZGlzYWJsZSB0
aGUNCj4gcHdtcw0KPiArCSAqLw0KPiArCXRvdWNoc2NyZWVuQDRhIHsNCj4gKwkJY29tcGF0aWJs
ZSA9ICJhdG1lbCxtYXh0b3VjaCI7DQo+ICsJCXJlZyA9IDwweDRhPjsNCj4gKwkJaW50ZXJydXB0
LXBhcmVudCA9IDwmZ3BpbzY+Ow0KPiArCQlpbnRlcnJ1cHRzID0gPDEwIElSUV9UWVBFX0VER0Vf
RkFMTElORz47DQo+ICsJCXJlc2V0LWdwaW9zID0gPCZncGlvNiA5IEdQSU9fQUNUSVZFX0hJR0g+
OyAvKiBTT0RJTU0gMTMNCj4gKi8NCg0KRGl0dG8uDQoNCj4gKwkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gKwl9Ow0KPiArDQo+ICAJLyogTTQxVDBNNiByZWFsIHRpbWUgY2xvY2sgb24gY2Fycmll
ciBib2FyZCAqLw0KPiAgCXJ0Y19pMmM6IHJ0Y0A2OCB7DQo+ICAJCWNvbXBhdGlibGUgPSAic3Qs
bTQxdDAiOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEtYXBhbGlzLWl4
b3JhLmR0cw0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS5kdHMNCj4g
aW5kZXggMzAyZmQ2YWRjOGE3Li41YmE0OWQwZjQ4ODAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnEtYXBhbGlzLWl4b3JhLmR0cw0KPiBAQCAtMTcxLDYgKzE3MSwxOSBAQA0KPiAgJmky
YzEgew0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIA0KPiArCS8qDQo+ICsJICogVG91Y2hzY3Jl
ZW4gaXMgdXNpbmcgU09ESU1NIDI4LzMwLCBhbHNvIHVzZWQgZm9yIFBXTTxCPiwNCj4gUFdNPEM+
LA0KPiArCSAqIGFrYSBwd20yLCBwd20zLiBzbyBpZiB5b3UgZW5hYmxlIHRvdWNoc2NyZWVuLCBk
aXNhYmxlIHRoZQ0KPiBwd21zDQo+ICsJICovDQo+ICsJdG91Y2hzY3JlZW5ANGEgew0KPiArCQlj
b21wYXRpYmxlID0gImF0bWVsLG1heHRvdWNoIjsNCj4gKwkJcmVnID0gPDB4NGE+Ow0KPiArCQlp
bnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvNj47DQo+ICsJCWludGVycnVwdHMgPSA8MTAgSVJRX1RZ
UEVfRURHRV9GQUxMSU5HPjsNCj4gKwkJcmVzZXQtZ3Bpb3MgPSA8JmdwaW82IDkgR1BJT19BQ1RJ
VkVfSElHSD47IC8qIFNPRElNTSAxMw0KPiAqLw0KDQpEaXR0by4NCg0KPiArCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KPiArCX07DQo+ICsNCj4gIAllZXByb21ANTAgew0KPiAgCQljb21wYXRpYmxl
ID0gImF0bWVsLDI0YzAyIjsNCj4gIAkJcmVnID0gPDB4NTA+Ow0KDQpDaGVlcnMNCg0KTWFyY2Vs
DQo=
