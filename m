Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E13C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12003214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="lpsGzkoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436835AbfHIPsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:48:51 -0400
Received: from mail-eopbgr130094.outbound.protection.outlook.com ([40.107.13.94]:53406
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436655AbfHIPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:48:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWBqmsscbyyRhmqwfRDZ+n3YGLuHFXajkzIPEvSl3jcxVOKqemf3B7y5Sv0k7FFtt7FeJJ1iAdbCPdbdBTmtyrGqHKUc1R5PvIAD6ZelNRs4LSS1XV8jp6f2R+0EMpMU/0V6VbkMQTcklXpZuQ1+Z8RTUx2QsUigPLzhr3HlPtiU5S527+zMFRje7miRBXQW3aM0kzt/Szt2TZCjZItytErIQUdb6V++rsI345NFdVfSC6yvR05ni7QGVMkHcXKp1iakMKRYSFX0NnZEKNbdWBZjXtdeOKGeDRVbnR3ecn+ApO86/iyK1TTNjvF2VUsenkq0RXfyhFSde7w1kQz1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk3EHF8ZsDq16yKTuHEuQANryO0CrTvFdSbKDaVqN5o=;
 b=LD8cnlUdJrz5wr4P5NUH4FML+PN0Unx+jP7Kx3V6GUO1kVl7a9AGZSRbgueo+EqyZ4cFERhuXW2RiMHUaXJATX/TAfFt93GkqeOuNGvvFgUgrFHfHD3u2ASnrzsXk08EfQTriKPYpmnGZ8BelMdxbj1VV2ECRmzpymWTw8UuAvltyKttu7s/tr3/mHO68iAYTMW4YeL77A78BlbNu06B3V+coXXtUZEiKj5Az3d6Pf1FJ1ZQirX5i2xRq2zScr6YJE1DoXMIkyC/BTMj16FSvJqbwQVzK3dWg/MomtglqogMzoSfKZTz0PjttxfioIqxVwvFh8NNWakQVta/+shYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk3EHF8ZsDq16yKTuHEuQANryO0CrTvFdSbKDaVqN5o=;
 b=lpsGzkoU3OHsXE6LKSlfOvZF21kPAuH830wPFa81nrmMV6uZKxyWXgky0VpyFprxlXekznzqUzCxxEDlCEmFCDrjAtG/bxAr0O8GJC1xdvdgPWrbbmEFMPaPmZ+n2pHNXS7LFqE7QJTpqWEbIugbXX0oJpYFZ7id2Usif4wXDbE=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB6752.eurprd05.prod.outlook.com (10.186.160.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 9 Aug 2019 15:48:46 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:48:46 +0000
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
Subject: Re: [PATCH v3 18/21] ARM: dts: imx6ull-colibri: Add general wakeup
 key used on Colibri
Thread-Topic: [PATCH v3 18/21] ARM: dts: imx6ull-colibri: Add general wakeup
 key used on Colibri
Thread-Index: AQHVTPnYiUb0/9FBFESOnjeVxQTgsaby+eaA
Date:   Fri, 9 Aug 2019 15:48:46 +0000
Message-ID: <a6f9f8d870fc6dfa408e3c3417bcc04e37ed2417.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-19-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-19-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e92166f8-89dd-4e98-c54c-08d71ce1108a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6752;
x-ms-traffictypediagnostic: VI1PR05MB6752:
x-microsoft-antispam-prvs: <VI1PR05MB675249EC419ED9F5A5522D60FBD60@VI1PR05MB6752.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(366004)(39850400004)(376002)(199004)(189003)(86362001)(4326008)(102836004)(186003)(76176011)(2501003)(6506007)(446003)(486006)(476003)(2616005)(11346002)(44832011)(7416002)(46003)(81156014)(8676002)(8936002)(81166006)(6116002)(25786009)(14454004)(6246003)(118296001)(54906003)(110136005)(7736002)(99286004)(316002)(478600001)(2906002)(2201001)(5660300002)(71190400001)(305945005)(71200400001)(256004)(76116006)(91956017)(229853002)(6512007)(66556008)(66946007)(64756008)(66446008)(36756003)(6436002)(6486002)(66476007)(53936002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6752;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DrkZJaIveiU33+aadxpbh+XCIU0lv+tgFgkQlOIYWxBBbVydT6rikoe9IRDopkaGrUT5C+dfZNA219YmY/7ZxriLhlyASG3NkStFOz62IwWS3fJIvC3gUgd18J/AJRvFDKVaKSyok2akZj2/9cAGqkKXDj7A9ySRpRiq/faRPVsklOber+CeYioZ/JmfdtF68l9jZECY8y54xjOVQDqkiobPvhIwhaDtstJTr+O6Z+HxO3F/jFkRY3DWG/DbK+M1OvJbO2YLtbJWLDZQO88uZ8dsJXocKQFLuA+jZHtZjpkhz9xQraIzk2XYpYiYrqtvC57GU9QCUWymiybmPSy9aqwYiL272ZYUTfU9bKfrRQD24K8G0wynaggELUsftBqzSGSdJh+O9HlF4jaJOBdJXRy0J1IyIIbxcgeNo9rzjnw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07359E6F6703474DA5B286CB329F8648@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92166f8-89dd-4e98-c54c-08d71ce1108a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:48:46.5274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQX2mVTh8FKyR/SLgqUPn3h4MFgoEsT+ShdpKeDr207zoCNIbk7zVU+59nnFEbHzdPE9Lz7U75CVTBrne1qjSqhaIutfprHO+PyUlE/XoBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gVGhpcyBhZGRzIHRoZSBwb3NzaWJpbGl0eSB0byB3YWtlIHRoZSBtb2R1bGUgd2l0aCBh
biBleHRlcm5hbCBzaWduYWwNCj4gYXMgZGVmaW5lZCBpbiB0aGUgQ29saWJyaSBzdGFuZGFyZA0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2Vy
QHRvcmFkZXguY29tPg0KDQpBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2ls
ZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOiBOb25lDQo+IENo
YW5nZXMgaW4gdjI6IE5vbmUNCj4gDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGli
cmktZXZhbC12My5kdHNpIHwgMTQgKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwt
Y29saWJyaS1ldmFsLXYzLmR0c2kNCj4gaW5kZXggM2JlZTM3Yzc1YWE2Li5kM2M0ODA5ZjE0MGUg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ldmFsLXYz
LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMu
ZHRzaQ0KPiBAQCAtOCw2ICs4LDIwIEBADQo+ICAJCXN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1
MjAwbjgiOw0KPiAgCX07DQo+ICANCj4gKwlncGlvLWtleXMgew0KPiArCQljb21wYXRpYmxlID0g
ImdwaW8ta2V5cyI7DQo+ICsJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJCXBpbmN0
cmwtMCA9IDwmcGluY3RybF9zbnZzX2dwaW9rZXlzPjsNCj4gKw0KPiArCQlwb3dlciB7DQo+ICsJ
CQlsYWJlbCA9ICJXYWtlLVVwIjsNCj4gKwkJCWdwaW9zID0gPCZncGlvNSAxIEdQSU9fQUNUSVZF
X0hJR0g+Ow0KPiArCQkJbGludXgsY29kZSA9IDxLRVlfV0FLRVVQPjsNCj4gKwkJCWRlYm91bmNl
LWludGVydmFsID0gPDEwPjsNCj4gKwkJCXdha2V1cC1zb3VyY2U7DQo+ICsJCX07DQo+ICsJfTsN
Cj4gKw0KPiAgCS8qIGZpeGVkIGNyeXN0YWwgZGVkaWNhdGVkIHRvIG1jcDI1MTUgKi8NCj4gIAlj
bGsxNm06IGNsazE2bSB7DQo+ICAJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0K
