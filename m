Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C205C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A6520820
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Ielp269I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436521AbfHIOsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:48:36 -0400
Received: from mail-eopbgr50134.outbound.protection.outlook.com ([40.107.5.134]:1668
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfHIOsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:48:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCibxWQhuloydEW3K43vw301mt2zgIoe85/9N/HWbV1zh6cBFvX8xqXSA7sYWZuR8Llx2sQIn8bqUKQLn/znuo5hUs5V7Os1vdZcHJj/12TEtM1SqRWxu3X/wGHIDd04R1Y2iFoxMR1kk0TElr9NrhnWp5gVt5p304KN0ww7sCbDtmCo0YQFUJPwK4pBrRSVzEr4VROujlGfp9yM+R2Cdj7hsFC6pIXOsTNCwQAwmGZ+eczQsucWv63WwZwFLBybh7YgpsQQGsC9RVWMIpv5G2bhkgBzxZyVTT3PwM3fdlzk2src8pvIeDe9GQiV6IWeYAMowAFkbyiIq6PQo9z+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fEu4TrVetBR4Aku4P4GNY01STF5i6Wm/Pgzu8ndS4o=;
 b=WDgGaYp9knV7MnGfRtT2DHPMDfMW8Ks3tKsB/8gGLkgBqjkXvAsMUdCOvJsHwanuI2hFiXgEN6Bl8FswIrLOZka+MtxgTLbXFPeTTuk3Hn9OdFDnMXJHe+ykUURWfvVN0/rhfr3SeIGHnPsJ9RvFkZ41HMpa7eTmrUFJ4wRF0zqJfrPtv5cDxlYWzVqgMaA8Uh9QEYI/aF+R4G8HoE/vLYBIQdcKA+vf7P18kurUvnSfYZD2M0k2hVQA5Jg+jsDGdJJlbh4WMYgjxqoFskDMI4aGYpOf/3SUIxUIEUwEKVtb03lwGD4spDBx/EKcEyOGTZCLFin5ng4c5HUwlFwRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fEu4TrVetBR4Aku4P4GNY01STF5i6Wm/Pgzu8ndS4o=;
 b=Ielp269IzjyOsR9ZzwsJ1Zb4eGOKwkusyi4ZEbP8aFjK5BQMIAC1VRzFSiOp6OcNkZjVaI4UJyCLagqUg+kbU5yYEWrgqrgwjsFHBSBPjuAeniwLX56KASRNQfXm40/kvDlkIZ7HzLHEO0dKAdWFqD0JQFgw5kj5Ew6OqzEs6F0=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB4399.eurprd05.prod.outlook.com (52.133.13.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Fri, 9 Aug 2019 14:48:31 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:48:31 +0000
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
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Topic: [PATCH v3 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Index: AQHVTPnK4ID+C8bQBUi3/2iU3N+GM6by6REA
Date:   Fri, 9 Aug 2019 14:48:31 +0000
Message-ID: <56f8b3c5be728af014388bb04cb372619dd8d440.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-8-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-8-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2840345e-26bc-47c7-b470-08d71cd8a5ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4399;
x-ms-traffictypediagnostic: VI1PR05MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4399A08BA090A61F46D666CBFBD60@VI1PR05MB4399.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(346002)(136003)(376002)(396003)(39850400004)(366004)(199004)(189003)(99286004)(71200400001)(86362001)(316002)(11346002)(2616005)(102836004)(8936002)(476003)(71190400001)(486006)(561944003)(6486002)(186003)(5660300002)(44832011)(76176011)(446003)(46003)(2501003)(2201001)(256004)(14444005)(2906002)(6246003)(6506007)(229853002)(478600001)(66556008)(6116002)(6436002)(7736002)(4326008)(53936002)(76116006)(66476007)(110136005)(66946007)(8676002)(91956017)(66446008)(81166006)(54906003)(64756008)(81156014)(118296001)(36756003)(7416002)(25786009)(305945005)(6512007)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4399;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8w8YmeCWbjyRkecalqzkyNLREvOTwUcf2twd87ohgpFhh8W3kmkMP25skL2UlTNmoiuQHkRl6jWDBwBPDc1TwnT7bTPXea6rxW4XQO6uvaWPrm8w1o6pRjZJ7FdWX2zALxAB7hagBnI51gV0Mait3sO8vku35Mp29Nn4Fn5lKjH0osio8+hy+FO7woTr6QOsN3lDoRQ7Q6jWuxofW+SQ6BMhGKyh5xDuTJZFf1R/APeIZPn/QWH9URbwoGlYByQIQyYBhyTy0BETbV0rfOHxu9B6ZWfnPbdzLD+rFFO5cgc8CWSFHPsZ+FoioCoUIJmATUs9DZuRHMwF228jWZ3ThI+UPkVwArCZSAjUoqJE5ovn+p7GP5BXwH1j3WvMuaJ9J/MWW4u67uz6cqFf8tu//+xVj0Os9daqOOuFzivpkuU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FE5F5AF4B177649BE50971E59338C67@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2840345e-26bc-47c7-b470-08d71cd8a5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:48:31.2593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pk0bm/le2sYmgeJUzcFP0GU2vlYkyppLyRZF2U2RY2yL7GqOSEb37HemSP/xiAKSVW2yI+vLjxgJ3sredFg14LqpXgBB+bCC3M92JTopXfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogU3RlZmFuIEFnbmVyIDxzdGVmYW4uYWduZXJAdG9yYWRleC5jb20+DQo+IA0K
PiBBZGQgcGlubXV4aW5nIGFuZCBkbyBub3Qgc3BlY2lmeSB2b2x0YWdlIHJlc3RyaWN0aW9ucyBm
b3IgdGhlIHVzZGhjDQo+IGluc3RhbmNlIGF2YWlsYWJsZSBvbiB0aGUgbW9kdWxlcyBlZGdlIGNv
bm5lY3Rvci4gVGhpcyBhbGxvd3MgdG8gdXNlDQo+IFNELWNhcmRzIHdpdGggaGlnaGVyIHRyYW5z
ZmVyIG1vZGVzIGlmIHN1cHBvcnRlZCBieSB0aGUgY2Fycmllcg0KPiBib2FyZC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFN0ZWZhbiBBZ25lciA8c3RlZmFuLmFnbmVyQHRvcmFkZXguY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRl
eC5jb20+DQoNCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3Jh
ZGV4LmNvbT4NCg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gQWRkIG5ldyBjb21t
aXQgbWVzc2FnZSBmcm9tIFN0ZWZhbidzIHByb3Bvc2FsIG9uIE1MDQo+IA0KPiBDaGFuZ2VzIGlu
IHYyOiBOb25lDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kgfCAy
MyArKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5k
dHNpDQo+IGluZGV4IDE2ZDFhMWVkMWFmZi4uNjdmNWUwYzg3ZmRjIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiBAQCAtMzI2LDcgKzMyNiw2IEBADQo+ICAmdXNkaGMx
IHsNCj4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCXBpbmN0cmwtMCA9IDwmcGlu
Y3RybF91c2RoYzEgJnBpbmN0cmxfY2RfdXNkaGMxPjsNCj4gLQluby0xLTgtdjsNCj4gIAljZC1n
cGlvcyA9IDwmZ3BpbzEgMCBHUElPX0FDVElWRV9MT1c+Ow0KPiAgCWRpc2FibGUtd3A7DQo+ICAJ
dnFtbWMtc3VwcGx5ID0gPCZyZWdfTERPMj47DQo+IEBAIC02NzEsNiArNjcwLDI4IEBADQo+ICAJ
CT47DQo+ICAJfTsNCj4gIA0KPiArCXBpbmN0cmxfdXNkaGMxXzEwMG1oejogdXNkaGMxZ3JwXzEw
MG1oeiB7DQo+ICsJCWZzbCxwaW5zID0gPA0KPiArCQkJTVg3RF9QQURfU0QxX0NNRF9fU0QxX0NN
RAkweDVhDQo+ICsJCQlNWDdEX1BBRF9TRDFfQ0xLX19TRDFfQ0xLCTB4MWENCj4gKwkJCU1YN0Rf
UEFEX1NEMV9EQVRBMF9fU0QxX0RBVEEwCTB4NWENCj4gKwkJCU1YN0RfUEFEX1NEMV9EQVRBMV9f
U0QxX0RBVEExCTB4NWENCj4gKwkJCU1YN0RfUEFEX1NEMV9EQVRBMl9fU0QxX0RBVEEyCTB4NWEN
Cj4gKwkJCU1YN0RfUEFEX1NEMV9EQVRBM19fU0QxX0RBVEEzCTB4NWENCj4gKwkJPjsNCj4gKwl9
Ow0KPiArDQo+ICsJcGluY3RybF91c2RoYzFfMjAwbWh6OiB1c2RoYzFncnBfMjAwbWh6IHsNCj4g
KwkJZnNsLHBpbnMgPSA8DQo+ICsJCQlNWDdEX1BBRF9TRDFfQ01EX19TRDFfQ01ECTB4NWINCj4g
KwkJCU1YN0RfUEFEX1NEMV9DTEtfX1NEMV9DTEsJMHgxYg0KPiArCQkJTVg3RF9QQURfU0QxX0RB
VEEwX19TRDFfREFUQTAJMHg1Yg0KPiArCQkJTVg3RF9QQURfU0QxX0RBVEExX19TRDFfREFUQTEJ
MHg1Yg0KPiArCQkJTVg3RF9QQURfU0QxX0RBVEEyX19TRDFfREFUQTIJMHg1Yg0KPiArCQkJTVg3
RF9QQURfU0QxX0RBVEEzX19TRDFfREFUQTMJMHg1Yg0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4g
IAlwaW5jdHJsX3VzZGhjMzogdXNkaGMzZ3JwIHsNCj4gIAkJZnNsLHBpbnMgPSA8DQo+ICAJCQlN
WDdEX1BBRF9TRDNfQ01EX19TRDNfQ01ECQkweDU5DQo=
