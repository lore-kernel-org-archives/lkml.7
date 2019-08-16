Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A313C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6472133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="i6JVWC6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfHPGpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:45:00 -0400
Received: from mail-eopbgr50110.outbound.protection.outlook.com ([40.107.5.110]:5803
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfHPGpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSJOyKXW8W/0LxHTuJy1X25mMr0nH0nSwCU1qI2KflrJNIg5n8L1GYAhYAII1UA71p7L/L8Mb3QlsGjvrZhviviagE5fm9mF7mnDttZPdwHR/55C+y5HhaAO75F1iqnfQxTg7E/lwg/2k9+knGKz/+tASVgAn55dJT8m3K/oL9XQZxz2br2r0p8JVpItYx96D6COZCFzIF2VvrqRAO2d/NR8bfDozAkbLQqhK7iLLMYTStjThSgMP2lHbj34/+WBLWXPdR5/TvKP1i6MZnDDzw4x1QRf8C4l2rI/CHoIcB73eXHG3G/4nUdZ+q3X89CxJymxcxJPCpt8/oWPq8KqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/ndeGuK7k85sPRcBHpcAyIusszWqt3Y/uJib4XAaDM=;
 b=MvmoQ8WFNuiyVcltEwckFqT9RQf9sqNtbqqSGTTMw0m43Qke6V0UaGs/bWqgRXRzS1sBWoL96la2WSmJaPjPG7TBMRvus6h2bNefc018Pk6E0Em2Riy95XnM4Nps6QLkc1N+MvT4viTTl5pcQPmAXk0PDxeK+XUMBdAmsu3XY0LlYdza1cs6yDdB2O24KMgP9dfZRyfbiquBFfGLq9Jtjz3zfLI0vrSdG/Y4uVKyWym+JEap5gc/tDdlXrCfHqCTp3F3eSZdxIncfG2rcsOPLzCNh/3hzYzEFvY0Hb5sQ76wbfEn0PkEbI3jnj5UONIMEINuhzqyiDq/zqJ5ZOcBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/ndeGuK7k85sPRcBHpcAyIusszWqt3Y/uJib4XAaDM=;
 b=i6JVWC6DfD8Og8UDlhIOeL+xuolerLJO6Fcil12XvJ6dmNG8PxqITFKjdYvWoKUNGXCJdzeeLJiFol995bVHUaDeLLYxunsrJaF2cFlru+60CaI7c6xi7yABlnu1JqmlsLgiLTlJAYeEfciCe+V0ktqY8O8sxhDQK4MPiDCyhms=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3695.eurprd05.prod.outlook.com (52.134.8.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 16 Aug 2019 06:44:56 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 06:44:56 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
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
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v4 21/21] ARM: dts: imx6qdl-colibri.dtsi: UHS-I support
 for v1.1a hw
Thread-Topic: [PATCH v4 21/21] ARM: dts: imx6qdl-colibri.dtsi: UHS-I support
 for v1.1a hw
Thread-Index: AQHVURlGJmcIK6KxnkK60xS6fTE6Vab9WgYA
Date:   Fri, 16 Aug 2019 06:44:56 +0000
Message-ID: <dd03b626b6d13a10f6e6c644d446c3a51e6b7875.camel@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
         <20190812142105.1995-22-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-22-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f6e8fcb-f194-4801-cc10-08d722154027
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3695;
x-ms-traffictypediagnostic: VI1PR0502MB3695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB36950D9767FDAFA6707EC945F4AF0@VI1PR0502MB3695.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39840400004)(376002)(346002)(136003)(396003)(189003)(199004)(86362001)(2201001)(2501003)(36756003)(66066001)(118296001)(53936002)(81156014)(476003)(8936002)(8676002)(6246003)(44832011)(14444005)(256004)(14454004)(4326008)(11346002)(486006)(2616005)(5660300002)(2906002)(7736002)(66556008)(66446008)(91956017)(76116006)(66946007)(305945005)(66476007)(7416002)(64756008)(25786009)(446003)(3846002)(6116002)(54906003)(110136005)(81166006)(316002)(76176011)(99286004)(6486002)(6436002)(186003)(229853002)(478600001)(26005)(71200400001)(71190400001)(6512007)(6506007)(102836004)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3695;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AnapPyQA7CWO7jaUyJ4JGmJK7s39AheUkBSCatLVdM7F6UE3PKx8BMLuYQC/60sJizFRYhSL9S+uTXKQBlE0vmfQPY9sIwbJ2q2+gDtlGPQwFPIPMD5lVGQnDo0ZBvCTIiWMHJMOtOZb0BGNwSJdyhX1wK94weHWhTGAsYZiCGv1sMCG1BmMwlf43hODUISfiyLoecv3njHcd+9c52pHnoXkIWl7Zu60o6bURyXaDnoWwdyt3fpxF7o5mpIToiGuKAYpiQ5gnk3LcIeRRcgIVvPJ446pibAibn3q88miVIZElioTkLhXnYQhAKhcEwzTaYbqK6mqreSXDtN53EaCzHf9g4N8U9GWD/jDMkgpSC2BV4bxjbVE4KCbssUKxvAaHgX4iaWmv2R/7CAwMew6Xr5xySs9ugzXfwr8tYT9csc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D5BD576719C47468937C3ECEB1A4888@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6e8fcb-f194-4801-cc10-08d722154027
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 06:44:56.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2L+f7WVhrhf01B5FrfRNuM5AO62QqWLNJS7Kpi49wekiAfjsbpBtGRu8y8cQ+XvJNeFoumdVWKAXMwUXrn+wB3Cmo7h6ER63HkOqKUPNmiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTEyIGF0IDE0OjIxICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+DQo+IA0K
PiBQcm92aWRlIHByb3BlciBjb25maWd1cmF0aW9uIGZvciBWR0VOMywgdG8gbWFrZSBzdXJlIGl0
J3MgaXMgYWx3YXlzDQo+IHBvd2VyZWQNCj4gd2hpY2ggYWxsb3dzIHRoYXQgcmFpbCB0byBiZSBh
dXRvbWF0aWNhbGx5IHN3aXRjaGVkIHRvIDEuOCB2b2x0cw0KPiBmb3IgcHJvcGVyIFVIUy1JIG9w
ZXJhdGlvbi4gQnkgZGVmYXVsdCBpdCdzIGRpc2FibGVkLg0KPiANCj4gV2l0aCBVSFMtSSBlbmFi
bGVkOg0KPiBbICAxMDQuMTUzODk4XSBtbWMxOiBuZXcgdWx0cmEgaGlnaCBzcGVlZCBTRFIxMDQg
U0RIQyBjYXJkIGF0IGFkZHJlc3MNCj4gNTliNA0KPiBbICAxMDQuMTY2MjAyXSBtbWNibGsxOiBt
bWMxOjU5YjQgVVNEMDAgMTUuMCBHaUINCj4gWyAgMTA0LjE3MzkyM10gIG1tY2JsazE6IHAxDQo+
IA0KPiByb290QGNvbGlicmktaW14Njp+IyBoZHBhcm0gLXQgL2Rldi9tbWNibGsxDQo+IC9kZXYv
bW1jYmxrMToNCj4gVGltaW5nIGJ1ZmZlcmVkIGRpc2sgcmVhZHM6IDIyNiBNQiBpbiAgMy4wMSBz
ZWNvbmRzID0gIDc1LjAxIE1CL3NlYw0KPiANCj4gU2lnbmVkLW9mZi1ieTogSWdvciBPcGFuaXVr
IDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNj
aGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCg0KUGxlYXNlIGlnbm9yZSB0
aGlzIHBhdGNoLiBUaGVyZSB3YXMgYSBtaXN1bmRlcnN0YW5kaW5nIGFuZCB0aGlzIG9uZQ0Kc2hv
dWxkbid0IGdvIGludG8gbWFpbmxpbmUuIFNvcnJ5IGZvciB0aGF0IQ0KPiANCj4gLS0tDQo+IA0K
PiBDaGFuZ2VzIGluIHY0Og0KPiAtIE5ldyBwYXRjaCBhcyBvZiB0aGUgcmVjb21tZW5kYXRpb24g
ZnJvbSBNYXJjZWwgb24gTUwNCj4gDQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBp
biB2MjogTm9uZQ0KPiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNp
IHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MzkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZxZGwtY29saWJyaS5kdHNpDQo+IGluZGV4IDlhNjNkZWJhYjBiNS4uMDI0MTYxM2I1ZTJi
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0K
PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0KPiBAQCAtMjI2
LDcgKzIyNiwxMiBAQA0KPiAgCQkJCXJlZ3VsYXRvci1hbHdheXMtb247DQo+ICAJCQl9Ow0KPiAg
DQo+IC0JCQkvKiB2Z2VuMzogdW51c2VkICovDQo+ICsJCQl2Z2VuM19yZWc6IHZnZW4zIHsNCj4g
KwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gKwkJCQlyZWd1bGF0
b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gKwkJCQlyZWd1bGF0b3ItYm9vdC1vbjsN
Cj4gKwkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiArCQkJfTsNCj4gIA0KPiAgCQkJdmdlbjRf
cmVnOiB2Z2VuNCB7DQo+ICAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47
DQo+IEBAIC0zOTQsMTMgKzM5OSwyMSBAQA0KPiAgDQo+ICAvKiBDb2xpYnJpIE1NQyAqLw0KPiAg
JnVzZGhjMSB7DQo+IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiLCAic3RhdGVfMTAwbWh6IiwgInN0YXRlXzIwMG1oeiI7DQo+ICAJcGlu
Y3RybC0wID0gPCZwaW5jdHJsX3VzZGhjMSAmcGluY3RybF9tbWNfY2Q+Ow0KPiArCXBpbmN0cmwt
MSA9IDwmcGluY3RybF91c2RoYzFfMTAwbWh6ICZwaW5jdHJsX21tY19jZD47DQo+ICsJcGluY3Ry
bC0yID0gPCZwaW5jdHJsX3VzZGhjMV8yMDBtaHogJnBpbmN0cmxfbW1jX2NkPjsNCj4gKwl2cW1t
Yy1zdXBwbHkgPSA8JnZnZW4zX3JlZz47DQo+ICsJc2QtdWhzLXNkcjEyOw0KPiArCXNkLXVocy1z
ZHIyNTsNCj4gKwlzZC11aHMtc2RyNTA7DQo+ICsJc2QtdWhzLXNkcjEwNDsNCj4gKwlsYWJlbCA9
ICJNTUMxIjsNCj4gIAljZC1ncGlvcyA9IDwmZ3BpbzIgNSBHUElPX0FDVElWRV9MT1c+OyAvKiBN
TUNEICovDQo+ICAJZGlzYWJsZS13cDsNCj4gLQl2cW1tYy1zdXBwbHkgPSA8JnJlZ19tb2R1bGVf
M3YzPjsNCj4gKwllbmFibGUtc2Rpby13YWtldXA7DQo+ICsJa2VlcC1wb3dlci1pbi1zdXNwZW5k
Ow0KPiAgCWJ1cy13aWR0aCA9IDw0PjsNCj4gLQluby0xLTgtdjsNCj4gIAlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPiAgfTsNCj4gIA0KPiBAQCAtNzA2LDYgKzcxOSwyOCBAQA0KPiAgCQk+Ow0KPiAg
CX07DQo+ICANCj4gKwlwaW5jdHJsX3VzZGhjMV8xMDBtaHo6IHVzZGhjMWdycDEwMG1oeiB7DQo+
ICsJCWZzbCxwaW5zID0gPA0KPiArCQkJTVg2UURMX1BBRF9TRDFfQ01EX19TRDFfQ01EICAgIDB4
MTcwYjENCj4gKwkJCU1YNlFETF9QQURfU0QxX0NMS19fU0QxX0NMSyAgICAweDEwMGIxDQo+ICsJ
CQlNWDZRRExfUEFEX1NEMV9EQVQwX19TRDFfREFUQTAgMHgxNzBiMQ0KPiArCQkJTVg2UURMX1BB
RF9TRDFfREFUMV9fU0QxX0RBVEExIDB4MTcwYjENCj4gKwkJCU1YNlFETF9QQURfU0QxX0RBVDJf
X1NEMV9EQVRBMiAweDE3MGIxDQo+ICsJCQlNWDZRRExfUEFEX1NEMV9EQVQzX19TRDFfREFUQTMg
MHgxNzBiMQ0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gKwlwaW5jdHJsX3VzZGhjMV8yMDBtaHo6
IHVzZGhjMWdycDIwMG1oeiB7DQo+ICsJCWZzbCxwaW5zID0gPA0KPiArCQkJTVg2UURMX1BBRF9T
RDFfQ01EX19TRDFfQ01EICAgIDB4MTcwZjENCj4gKwkJCU1YNlFETF9QQURfU0QxX0NMS19fU0Qx
X0NMSyAgICAweDEwMGYxDQo+ICsJCQlNWDZRRExfUEFEX1NEMV9EQVQwX19TRDFfREFUQTAgMHgx
NzBmMQ0KPiArCQkJTVg2UURMX1BBRF9TRDFfREFUMV9fU0QxX0RBVEExIDB4MTcwZjENCj4gKwkJ
CU1YNlFETF9QQURfU0QxX0RBVDJfX1NEMV9EQVRBMiAweDE3MGYxDQo+ICsJCQlNWDZRRExfUEFE
X1NEMV9EQVQzX19TRDFfREFUQTMgMHgxNzBmMQ0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gIAlw
aW5jdHJsX3VzZGhjMzogdXNkaGMzZ3JwIHsNCj4gIAkJZnNsLHBpbnMgPSA8DQo+ICAJCQlNWDZR
RExfUEFEX1NEM19DTURfX1NEM19DTUQJMHgxNzA1OQ0KPiAtLSANCj4gMi4yMi4wDQo+IA0K
