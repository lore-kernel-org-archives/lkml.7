Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8817AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E61B21928
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="AKqekBve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436498AbfIWG6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:58:32 -0400
Received: from mail-eopbgr140104.outbound.protection.outlook.com ([40.107.14.104]:1792
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405033AbfIWG6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:58:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqHXjokuk78RrZ32nO2QcZY9maP2OO8RNIeFd70tC4+Dg85ZoUEBHdFKdexhR3FYMGtsObwxw2lhQbziEH5imc+565pZyVBWtg8RqOeUGDgB2MnGgMitPbh76Kx5bAeiyFN8f2fZMhylLSdU0y0mhz48mq2vJopWid8OC86OxgSat2Ro6w8aGdyR8K6xaB/0VGszEpA8aQ8Sqm6RxXFHam+8ccjhERkSM0Q4Dmmth0gX8zQBOszQrhGFJ+3cKswXLA4GJSoFV4w3E8dH4LKTULFDk8KO5Xlh+OBrEab/OquxLxK2jkNLF2c6w12Yz8uTVI5JIErNzSgZLcpMWT0viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMM3g0Bd70PmuHdtrqIlbaGL+CTziTGgjrOBmdOC2JM=;
 b=R2D9IWWfbfQ//Ic2HuSixukU4s1766Pk/ji5wE4cbyHYAEv0nWfExgX89B8b0N0nWaWq7YAgrBhL5It6xX5pRqWweHfOJLMg5t9020uAXmGBA7qQ21c7RdnYhM8EXtYYlH4gD4QE02YWtk2t8sxwLeYS6kxZQlkm8tbmhQJd+T4SU7weG+mXIiZlfUYSftI5hJ/h5u3CJdOYTqcjrOeur0Tuvv3FXo+JwBVFcEzqglzxOJk0CfWX+sPQfT26beYk8cvZM+R/p4K27cNSZVcsm+t67/AK8vJYpCO6qLRoD77qGsqbQCzSpSTEBX4S8qLRdRcSslM6MfBlfzyTmuGkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMM3g0Bd70PmuHdtrqIlbaGL+CTziTGgjrOBmdOC2JM=;
 b=AKqekBveH0LqwWSlSCcqTAGY1WFoomS0O7VLUDpmE5N8b4z8g/18dVp/IAI2RZj4I1OgzbxH1+z2+0NR3lwa5L12st+dud0nGHN8MnThnuGUyEfKFqL7R6yI3hMoWOtetXxjhgCP/CR0DtjRSkLs7wygGmEjRlZgh9UtIVZJ4NI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3998.eurprd05.prod.outlook.com (52.134.18.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Mon, 23 Sep 2019 06:58:28 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::1179:c881:a516:644d]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::1179:c881:a516:644d%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 06:58:28 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: regulator: add regulator-fixed-clock
 binding
Thread-Topic: [PATCH v2 3/3] dt-bindings: regulator: add regulator-fixed-clock
 binding
Thread-Index: AQHVZ5/14/SgXrjoXUmhwZqwM+HFaKcwWYmAgAiP0IA=
Date:   Mon, 23 Sep 2019 06:58:27 +0000
Message-ID: <8301e3026d583d8d05eb1e73535b9a733b9b25fd.camel@toradex.com>
References: <20190910062103.39641-1-philippe.schenker@toradex.com>
         <20190910062103.39641-4-philippe.schenker@toradex.com>
         <CAL_JsqLyawEariYuaHJ+Lyt1DhJe9fdAE88ANrhHAokWJhUOdw@mail.gmail.com>
In-Reply-To: <CAL_JsqLyawEariYuaHJ+Lyt1DhJe9fdAE88ANrhHAokWJhUOdw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7a46346-1a0c-4d12-9ad3-08d73ff36fd2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3998;
x-ms-traffictypediagnostic: VI1PR0502MB3998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB399868F5A83925140623475FF4850@VI1PR0502MB3998.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(199004)(189003)(2906002)(478600001)(86362001)(14454004)(25786009)(305945005)(2616005)(476003)(64756008)(66556008)(66476007)(102836004)(6506007)(53546011)(99286004)(7736002)(11346002)(486006)(36756003)(26005)(186003)(66946007)(76176011)(3846002)(6116002)(76116006)(91956017)(66446008)(66066001)(6512007)(446003)(118296001)(44832011)(6246003)(6486002)(229853002)(54906003)(4326008)(71200400001)(71190400001)(316002)(14444005)(8676002)(81156014)(81166006)(6436002)(5660300002)(256004)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3998;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m6PbiyXjzvmfq+0iXVrexOo7C6sqJG48zuBIqQDyHCgfbePRy6ehC4R5+xDlk3pmrws3N/DsrOuUMDb+hYPBOJTTrPL4YqFQD1HawNy1T2P1c+IO8A+8eVdkfAsmHw2zLzhtyBwPhWIgF+knuVguaG4ix3Rzf7obQv2tze7Iy3/3ELlIQ6ah88KryDxNI6w9TN4Sp92Zb8vxtO3yfgCD7dZLbOUfHXSl05DB4pjeQxdcuYX5QAYs+EK4bOrbZUZ+gOMUe/uhW+STVZPOUW+KDw+mJnZ619um4G+aDjsInHkcm/8eMO8Cc+AawWg33PsCzduHCTc8t8hf0l3pXpb7+Xf+9yizE2GXaGlnChdluKlyAHg1lgEKCDPRyBJJWohPKMInJD6eNol9ry4JAG1MICEPpD/Le+F0KszlgdaAlso=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5D67FBDC8FD04E80074638E0D29A0E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a46346-1a0c-4d12-9ad3-08d73ff36fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 06:58:27.9521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OEcSRRLoc7GKjCoGKnLo0smHNOZDBCOJdnTIkntZs3GkirERJUIm6d2FtVT8htLxXMqJkj2GDda5AhSQJ6IA/tkDQpRaSnGSpV1mR3c4RQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDE1OjEzIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBTZXAgMTAsIDIwMTkgYXQgMToyMSBBTSBQaGlsaXBwZSBTY2hlbmtlcg0KPiA8cGhp
bGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+IHdyb3RlOg0KPiA+IFRoaXMgYWRkcyB0aGUgZG9j
dW1lbnRhdGlvbiB0byB0aGUgY29tcGF0aWJsZSByZWd1bGF0b3ItZml4ZWQtY2xvY2suDQo+ID4g
VGhpcyBiaW5kaW5nIGlzIGEgc3BlY2lhbCBiaW5kaW5nIG9mIHJlZ3VsYXRvci1maXhlZCBhbmQg
YWRkcyB0aGUNCj4gPiBhYmlsaXR5IHRvIGFkZCBhIGNsb2NrIHRvIHJlZ3VsYXRvci1maXhlZCwg
c28gdGhlIHJlZ3VsYXRvciBjYW4gYmUNCj4gPiBlbmFibGVkIGFuZCBkaXNhYmxlZCB3aXRoIHRo
YXQgY2xvY2suIElmIHRoZSBzcGVjaWFsIGNvbXBhdGlibGUNCj4gPiByZWd1bGF0b3ItZml4ZWQt
Y2xvY2sgaXMgdXNlZCBpdCBpcyBtYW5kYXRvcnkgdG8gc3VwcGx5IGEgY2xvY2suDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRv
cmFkZXguY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4g
LSBDaGFuZ2Ugc2VsZWN0OiB0byBpZjoNCj4gPiAtIENoYW5nZSBpdGVtczogdG8gZW51bToNCj4g
PiAtIERlZmluZWQgaG93IG1hbnkgY2xvY2tzIHNob3VsZCBiZSBnaXZlbg0KPiA+IA0KPiA+ICAu
Li4vYmluZGluZ3MvcmVndWxhdG9yL2ZpeGVkLXJlZ3VsYXRvci55YW1sICAgfCAxOQ0KPiA+ICsr
KysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9maXhlZC0NCj4gPiByZWd1bGF0b3IueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvZml4ZWQtDQo+ID4gcmVn
dWxhdG9yLnlhbWwNCj4gPiBpbmRleCBhNjUwYjQ1NzA4NWQuLmE3ODE1MGM0N2FhMiAxMDA2NDQN
Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL2Zp
eGVkLQ0KPiA+IHJlZ3VsYXRvci55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9maXhlZC0NCj4gPiByZWd1bGF0b3IueWFtbA0KPiA+IEBA
IC0xOSw5ICsxOSwxOSBAQCBkZXNjcmlwdGlvbjoNCj4gPiAgYWxsT2Y6DQo+ID4gICAgLSAkcmVm
OiAicmVndWxhdG9yLnlhbWwjIg0KPiA+IA0KPiA+ICtpZjoNCj4gPiArICBwcm9wZXJ0aWVzOg0K
PiA+ICsgICAgY29tcGF0aWJsZToNCj4gPiArICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAg
Y29uc3Q6IHJlZ3VsYXRvci1maXhlZC1jbG9jaw0KPiA+ICsgIHJlcXVpcmVkOg0KPiA+ICsgICAg
LSBjbG9ja3MNCj4gPiArDQo+ID4gIHByb3BlcnRpZXM6DQo+ID4gICAgY29tcGF0aWJsZToNCj4g
PiAtICAgIGNvbnN0OiByZWd1bGF0b3ItZml4ZWQNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAg
IC0gY29uc3Q6IHJlZ3VsYXRvci1maXhlZA0KPiA+ICsgICAgICAtIGNvbnN0OiByZWd1bGF0b3It
Zml4ZWQtY2xvY2sNCj4gDQo+ICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGlzIGZhaWxpbmcuIFlv
dSBuZWVkIHRvIGRyb3AgJ2NvbnN0OiAnLiBQbGVhc2UNCj4gc2VuZCBhIHBhdGNoIHRvIGZpeCB0
aGlzLg0KPiANCj4gUm9iDQoNCkhpIFJvYiwgDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBv
dXQsIEkgd2Fzbid0IGF3YXJlIG9mIHRoYXQgYW5kIG9mICdtYWtlDQpkdF9iaW5kaW5nX2NoZWNr
Jy4gSSB3YXMgc2VhcmNoaW5nIGZvciBpdCwgYnV0IG5vdCBmaW5kaW5nIHRoYXQgb25lLA0KdGhh
bmtzIGZvciBtZW50aW9uaW5nIGl0LiBJIHdpbGwgaW1tZWRpYXRlbHkgcGF0Y2ggdGhhdCBhbmQg
c2VuZCBpdA0KcmlnaHQgYXdheS4NCg0KUGhpbGlwcGUNCg==
