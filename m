Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AB3C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6254E21019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bokmo687"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409134AbfFLNyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:54:05 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:49498 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFLNyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:54:03 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,366,1557212400"; 
   d="scan'208";a="37039095"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2019 06:54:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Jun 2019 06:54:02 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 12 Jun 2019 06:54:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnNLn3CW9ykh9R4zF5eVc1KF76yYbo4kZxsDaoYrigA=;
 b=bokmo68782eR0Lq6aufuL9AYoNflrVnVnDhEJSl9yoODny1WY8VjiJU5LUG/EMT84xoQgK7ciBkNluCp6PRY0KusbFs183MJWXRZuPGSF68CWMXHUgpq+NLwV3i/e7YrcRKMpTGLcn5s8yT0sVG16wRXod0GsXkzAlhODIFCiXw=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1488.namprd11.prod.outlook.com (10.172.54.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 13:54:00 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::7534:63dc:8504:c2b3]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::7534:63dc:8504:c2b3%6]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 13:54:00 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Codrin.Ciubotariu@microchip.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: generated: Truncate divisor to
 GENERATED_MAX_DIV + 1
Thread-Topic: [PATCH] clk: at91: generated: Truncate divisor to
 GENERATED_MAX_DIV + 1
Thread-Index: AQHVISZJ7NNF73bMSUil2V7eUlzrig==
Date:   Wed, 12 Jun 2019 13:54:00 +0000
Message-ID: <7306f2c5-e035-31d1-194e-6b4afb6a61c1@microchip.com>
References: <20190610151712.16572-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190610151712.16572-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0131.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::23) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c93b44fc-1f9c-4a81-9ad0-08d6ef3d6bef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1488;
x-ms-traffictypediagnostic: MWHPR11MB1488:
x-microsoft-antispam-prvs: <MWHPR11MB1488F6D232BFFE5F1E125E50E0EC0@MWHPR11MB1488.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(25786009)(99286004)(86362001)(53936002)(4326008)(66946007)(73956011)(66556008)(66476007)(66446008)(64756008)(52116002)(2201001)(31696002)(8676002)(305945005)(2906002)(6246003)(81156014)(81166006)(76176011)(66066001)(7736002)(486006)(8936002)(229853002)(5660300002)(476003)(53546011)(446003)(6116002)(2616005)(186003)(11346002)(71200400001)(6512007)(3846002)(102836004)(6506007)(386003)(71190400001)(6436002)(478600001)(68736007)(31686004)(54906003)(72206003)(110136005)(316002)(26005)(6486002)(2501003)(6636002)(36756003)(256004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1488;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LK+XVXvpfl9ZUGoRsmWu2Yeo87RmJ2sAogy2KxoczxmP8mGJYl+z3VBnf5OqV84kpnutToTzH/ifECP1bQ7WkCiOqbnfBIc+t2BXPND9RgJ6LCc15Qe4JIEfkPc1odpPY4fODnBudk5AeXjfATIdWOIi+n8Acpkfcl9opZ+SwOv5wvQ34qme8EJpmUD2nzyWGAjr+g2nUXsjyrlW1ri2oUzdUaFWzvY0aI+xkvxt9kC3KfUtdLacJ4UAxQrVe1iAhj7wODBKPWedRPH+0vQUv6zW8/S+gB4Bz0+RY+MFJggmMOJMqqmSLFTw/DIxnGzuP4lfY7X9Insgpn2xLshqwocEei8K8nVsZSt0R1TqRejs8guhX3/99ugJSle6vWot5LknLqjjyJXmgRSgPI26tvM0JnZFgCpwEIy0WkI0UD4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEBC4BE6DE7E3F4396522FBC19CC6B7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c93b44fc-1f9c-4a81-9ad0-08d6ef3d6bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 13:54:00.6045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nicolas.ferre@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMDYvMjAxOSBhdCAxNzoyMCwgQ29kcmluIENpdWJvdGFyaXUgLSBNMTk5NDAgd3JvdGU6
DQo+IEZyb206IENvZHJpbiBDaXVib3Rhcml1IDxjb2RyaW4uY2l1Ym90YXJpdUBtaWNyb2NoaXAu
Y29tPg0KPiANCj4gSW4gY2xrX2dlbmVyYXRlZF9kZXRlcm1pbmVfcmF0ZSgpLCBpZiB0aGUgZGl2
aXNvciBpcyBncmVhdGVyIHRoYW4NCj4gR0VORVJBVEVEX01BWF9ESVYgKyAxLCB0aGVuIHRoZSB3
cm9uZyBiZXN0X3JhdGUgd2lsbCBiZSByZXR1cm5lZC4NCj4gSWYgY2xrX2dlbmVyYXRlZF9zZXRf
cmF0ZSgpIHdpbGwgYmUgY2FsbGVkIGxhdGVyIHdpdGggdGhpcyB3cm9uZw0KPiByYXRlLCBpdCB3
aWxsIHJldHVybiAtRUlOVkFMLCBzbyB0aGUgZ2VuZXJhdGVkIGNsb2NrIHdvbid0IGNoYW5nZQ0K
PiBpdHMgdmFsdWUuIERvIG5vIGxldCB0aGUgZGl2aXNvciBiZSBncmVhdGVyIHRoYW4gR0VORVJB
VEVEX01BWF9ESVYgKyAxLg0KPiANCj4gRml4ZXM6IDhjN2FhNjMyODk0NyAoImNsazogYXQ5MTog
Y2xrLWdlbmVyYXRlZDogcmVtb3ZlIHVzZWxlc3MgZGl2aXNvciBsb29wIikNCj4gU2lnbmVkLW9m
Zi1ieTogQ29kcmluIENpdWJvdGFyaXUgPGNvZHJpbi5jaXVib3Rhcml1QG1pY3JvY2hpcC5jb20+
DQoNClllczoNCkFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hp
cC5jb20+DQoNClRoYW5rcyBmb3IgaGF2aW5nIGZpeGVkIHRoaXMgQ29kcmluLiBCZXN0IHJlZ2Fy
ZHMsDQogICBOaWNvbGFzDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJh
dGVkLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jIGIvZHJpdmVycy9j
bGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMNCj4gaW5kZXggNWYxODg0Nzk2NWMxLi4yOTBjZmZlMzVk
ZWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jDQo+ICsr
KyBiL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jDQo+IEBAIC0xNDYsNiArMTQ2LDgg
QEAgc3RhdGljIGludCBjbGtfZ2VuZXJhdGVkX2RldGVybWluZV9yYXRlKHN0cnVjdCBjbGtfaHcg
Kmh3LA0KPiAgIAkJCWNvbnRpbnVlOw0KPiAgIA0KPiAgIAkJZGl2ID0gRElWX1JPVU5EX0NMT1NF
U1QocGFyZW50X3JhdGUsIHJlcS0+cmF0ZSk7DQo+ICsJCWlmIChkaXYgPiBHRU5FUkFURURfTUFY
X0RJViArIDEpDQo+ICsJCQlkaXYgPSBHRU5FUkFURURfTUFYX0RJViArIDE7DQo+ICAgDQo+ICAg
CQljbGtfZ2VuZXJhdGVkX2Jlc3RfZGlmZihyZXEsIHBhcmVudCwgcGFyZW50X3JhdGUsIGRpdiwN
Cj4gICAJCQkJCSZiZXN0X2RpZmYsICZiZXN0X3JhdGUpOw0KPiANCg0KDQotLSANCk5pY29sYXMg
RmVycmUNCg==
