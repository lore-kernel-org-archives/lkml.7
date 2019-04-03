Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C02C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D32720830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="M7x0ya0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDCKFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:05:05 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:49434 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfDCKFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:05:04 -0400
X-IronPort-AV: E=Sophos;i="5.60,304,1549954800"; 
   d="scan'208";a="30723823"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Apr 2019 03:05:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 3 Apr 2019 03:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4BpX9pZUZgxhoecPHl76wzUMl1IRA410YCs9pO9Cbc=;
 b=M7x0ya0zY1OTEYqeMSMiiN7QoGpjktNNxzlmKos+GHqFH1MXTxwhe5c2rqYFipfDZHZxf2MwlPxIZVPTniJKGFanQYbiDxSrzEPKrgnTIR6f9pPFJkE5abZvHz5xINR+8W7pqR5kmhu4J1+YdCZcERLq36AlGfRbT/A+P1hVT/Q=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1791.namprd11.prod.outlook.com (10.175.53.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Wed, 3 Apr 2019 10:05:00 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6%2]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 10:05:00 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <vkoul@kernel.org>
CC:     <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dmaengine: at_xdmac: enhance channel errors handling
 in tasklet
Thread-Topic: [PATCH 2/3] dmaengine: at_xdmac: enhance channel errors handling
 in tasklet
Thread-Index: AQHU6gSyTEx6kp6OEUC3zdFi9URd3Q==
Date:   Wed, 3 Apr 2019 10:05:00 +0000
Message-ID: <1cdc51b6-3b0b-ee17-855a-ebd3896059ba@microchip.com>
References: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
 <ad6c3c705fbef7ba4a1b762b39b0b8e04c10b632.1549364323.git.nicolas.ferre@microchip.com>
 <20190211115834.GS4296@vkoul-mobl>
In-Reply-To: <20190211115834.GS4296@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0467.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::23) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90fe0bfb-8ee6-4fb3-5e0a-08d6b81bd534
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1791;
x-ms-traffictypediagnostic: MWHPR11MB1791:
x-microsoft-antispam-prvs: <MWHPR11MB1791AE2D52318D5D1F380DD3E0570@MWHPR11MB1791.namprd11.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(31686004)(6116002)(53546011)(72206003)(446003)(5660300002)(31696002)(8676002)(6916009)(81156014)(68736007)(4326008)(81166006)(6246003)(2906002)(14454004)(6512007)(478600001)(486006)(99286004)(53936002)(105586002)(26005)(256004)(7736002)(305945005)(186003)(6486002)(14444005)(386003)(36756003)(102836004)(106356001)(6506007)(6436002)(8936002)(54906003)(229853002)(66066001)(316002)(97736004)(25786009)(71200400001)(2616005)(11346002)(52116002)(476003)(76176011)(71190400001)(3846002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1791;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jk8pS2TLuSV4GHvOs0eVFu3FLVM4y1TUaFEDgyqFbOsRvfr1H5xWJ0EY+SqAtp0ywtGfnh2RFWyQTVZL2k+0TW46zUw42pvLJQVmvjcG4qKQZfAEyMOFlzc0b5biKMbd2HS/iXbSzp5q0v31iMinpEa5hVDbeV+izbWRRIkeMhyao2mk7beFgnjcoSmG5zK6/Bmvluw3osBHrPyAZEwSof8OGzoQB9kZ/9HqHbq3c4heAluPOpsmKwFALPEoLAkzxUBBQmccAIplFXWL3G2uVnD5IU+oXgotf4z+ZUd+3Q3p5eTYdXx2YW8EObVkj+AimAN5V45o76VhNAjXAy8aC4CD6+Rd9HD+Wtku6IfWN9cjvd3p46aRj93LPgZ+Q4RgP1oVkZJGVQzWNI5x6jAUCHMQlDlqhOOA71qfD0ByOug=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3D5CA283514A54C99B5638E5303B4A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fe0bfb-8ee6-4fb3-5e0a-08d6b81bd534
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 10:05:00.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1791
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vmlub2QsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcsIEknbSBwcmVwYXJpbmcgdjIuDQoNCk9u
IDExLzAyLzIwMTkgYXQgMTI6NTgsIFZpbm9kIEtvdWwgd3JvdGU6DQo+IE9uIDA1LTAyLTE5LCAx
MjowMywgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4+IENvbXBsZW1lbnQgdGhlIGlkZW50aWZpY2F0
aW9uIG9mIGVycm9ycyB3aXRoIHN0b3BpbmcgdGhlIGNoYW5uZWwgYW5kDQo+PiBkdW1waW5nIHRo
ZSBkZXNjcmlwdG9yIHRoYXQgbGVkIHRvIHRoZSBlcnJvciBjYXNlLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4+IC0t
LQ0KPj4gICBkcml2ZXJzL2RtYS9hdF94ZG1hYy5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9hdF94
ZG1hYy5jIGIvZHJpdmVycy9kbWEvYXRfeGRtYWMuYw0KPj4gaW5kZXggMzdhMjY5NDIwNDM1Li5l
YzdhMjlkOGU0NDggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+PiAr
KysgYi9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+PiBAQCAtMTU3NSw2ICsxNTc1LDQxIEBAIHN0
YXRpYyB2b2lkIGF0X3hkbWFjX2hhbmRsZV9jeWNsaWMoc3RydWN0IGF0X3hkbWFjX2NoYW4gKmF0
Y2hhbikNCj4+ICAgCQlkbWFlbmdpbmVfZGVzY19nZXRfY2FsbGJhY2tfaW52b2tlKHR4ZCwgTlVM
TCk7DQo+PiAgIH0NCj4+ICAgDQo+PiArc3RhdGljIHZvaWQgYXRfeGRtYWNfaGFuZGxlX2Vycm9y
KHN0cnVjdCBhdF94ZG1hY19jaGFuICphdGNoYW4pDQo+PiArew0KPj4gKwlzdHJ1Y3QgYXRfeGRt
YWMJCSphdHhkbWFjID0gdG9fYXRfeGRtYWMoYXRjaGFuLT5jaGFuLmRldmljZSk7DQo+PiArCXN0
cnVjdCBhdF94ZG1hY19kZXNjCSpiYWRfZGVzYzsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogVGhl
IGRlc2NyaXB0b3IgY3VycmVudGx5IGF0IHRoZSBoZWFkIG9mIHRoZSBhY3RpdmUgbGlzdCBpcw0K
Pj4gKwkgKiBicm9rZWQuIFNpbmNlIHdlIGRvbid0IGhhdmUgYW55IHdheSB0byByZXBvcnQgZXJy
b3JzLCB3ZSdsbA0KPiANCj4gWW91IG1lYW50IGJvcmtlZCBvciBicm9rZW4uLi4NCg0KQnJva2Vu
DQoNCj4gDQo+PiArCSAqIGp1c3QgaGF2ZSB0byBzY3JlYW0gbG91ZGx5IGFuZCB0cnkgdG8gY2Fy
cnkgb24uDQo+IA0KPiBzaG91bGQgd2UgY2Fycnkgb24gb3IgYWJvcnQuLj8NCg0KQ2hhbmdlZCBp
bjoNCg0KICAqIGp1c3QgaGF2ZSB0byBzY3JlYW0gbG91ZGx5IGFuZCB0cnkgdG8gY29udGludWUg
d2l0aCBvdGhlcg0KICAqIGRlc2NyaXB0b3JzIHF1ZXVlZCAoaWYgYW55KS4NCg0KPj4gKwkgKi8N
Cj4+ICsJaWYgKGF0Y2hhbi0+aXJxX3N0YXR1cyAmIEFUX1hETUFDX0NJU19SQkVJUykNCj4+ICsJ
CWRldl9lcnIoY2hhbjJkZXYoJmF0Y2hhbi0+Y2hhbiksICJyZWFkIGJ1cyBlcnJvciEhISIpOw0K
Pj4gKwlpZiAoYXRjaGFuLT5pcnFfc3RhdHVzICYgQVRfWERNQUNfQ0lTX1dCRUlTKQ0KPj4gKwkJ
ZGV2X2VycihjaGFuMmRldigmYXRjaGFuLT5jaGFuKSwgIndyaXRlIGJ1cyBlcnJvciEhISIpOw0K
Pj4gKwlpZiAoYXRjaGFuLT5pcnFfc3RhdHVzICYgQVRfWERNQUNfQ0lTX1JPSVMpDQo+PiArCQlk
ZXZfZXJyKGNoYW4yZGV2KCZhdGNoYW4tPmNoYW4pLCAicmVxdWVzdCBvdmVyZmxvdyBlcnJvciEh
ISIpOw0KPj4gKw0KPj4gKwlzcGluX2xvY2tfYmgoJmF0Y2hhbi0+bG9jayk7DQo+PiArCS8qIENo
YW5uZWwgbXVzdCBiZSBkaXNhYmxlZCBmaXJzdCBhcyBpdCdzIG5vdCBkb25lIGF1dG9tYXRpY2Fs
bHkgKi8NCj4+ICsJYXRfeGRtYWNfd3JpdGUoYXR4ZG1hYywgQVRfWERNQUNfR0QsIGF0Y2hhbi0+
bWFzayk7DQo+PiArCXdoaWxlIChhdF94ZG1hY19yZWFkKGF0eGRtYWMsIEFUX1hETUFDX0dTKSAm
IGF0Y2hhbi0+bWFzaykNCj4+ICsJCWNwdV9yZWxheCgpOw0KPj4gKwliYWRfZGVzYyA9IGxpc3Rf
Zmlyc3RfZW50cnkoJmF0Y2hhbi0+eGZlcnNfbGlzdCwNCj4+ICsJCQkJICAgIHN0cnVjdCBhdF94
ZG1hY19kZXNjLA0KPj4gKwkJCQkgICAgeGZlcl9ub2RlKTsNCj4+ICsJc3Bpbl91bmxvY2tfYmgo
JmF0Y2hhbi0+bG9jayk7DQo+PiArCS8qIFByaW50IGJhZCBkZXNjcmlwdG9yJ3MgZGV0YWlscyBp
ZiBuZWVkZWQgKi8NCj4gDQo+IFdlbGwgdGhpcyBpcyBub3QgZ3JlYXQgdG8gbG9vayBhbmQgcmVh
ZCBhdCwgcGxlYXNlIGRvIGNvbnNpZGVyIGFkZGluZw0KPiBlbXB0eSBsaW5lIGJlZm9yZSBjb21t
ZW50cyBvciBsb2dpY2FsIGJsb2Nrcy4uDQoNClRydWUsIGluZGVlZC4NCg0KPj4gKwlkZXZfZGJn
KGNoYW4yZGV2KCZhdGNoYW4tPmNoYW4pLA0KPj4gKwkJICIlczogbGxkOiBtYnJfc2E9JXBhZCwg
bWJyX2RhPSVwYWQsIG1icl91YmM9MHglMDh4XG4iLA0KPj4gKwkJIF9fZnVuY19fLCAmYmFkX2Rl
c2MtPmxsZC5tYnJfc2EsICZiYWRfZGVzYy0+bGxkLm1icl9kYSwNCj4+ICsJCSBiYWRfZGVzYy0+
bGxkLm1icl91YmMpOw0KPiANCj4gbm90IGRldl9lcnI/DQoNCldlbGwsIHdlIGhhdmUgdGhlIGRl
dl9lcnIgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZnVuY3Rpb24sIEkgdGhpbmsgaXQncyANCmVu
b3VnaDogdGhpcyBpcyByZWFsbHkgZGVidWdnaW5nIGluZm9ybWF0aW9uIHRoYXQgbmVlZHMgdG8g
YmUgYWN0aXZhdGVkIA0KdG8gdHJhY2sgdGhlIERNQSBjb25maWd1cmF0aW9uIGJ1ZzogaXQncyBu
b3QgbWVhbnQgZm9yIHByb2R1Y3Rpb24uDQoNCj4+ICsNCj4+ICsJLyogVGhlbiBjb250aW51ZSB3
aXRoIHVzdWFsIGRlc2NyaXB0b3IgbWFuYWdlbWVudCAqLw0KPj4gK30NCj4+ICsNCj4+ICAgc3Rh
dGljIHZvaWQgYXRfeGRtYWNfdGFza2xldCh1bnNpZ25lZCBsb25nIGRhdGEpDQo+PiAgIHsNCj4+
ICAgCXN0cnVjdCBhdF94ZG1hY19jaGFuCSphdGNoYW4gPSAoc3RydWN0IGF0X3hkbWFjX2NoYW4g
KilkYXRhOw0KPj4gQEAgLTE1OTQsMTIgKzE2MjksOCBAQCBzdGF0aWMgdm9pZCBhdF94ZG1hY190
YXNrbGV0KHVuc2lnbmVkIGxvbmcgZGF0YSkNCj4+ICAgCQkgICB8fCAoYXRjaGFuLT5pcnFfc3Rh
dHVzICYgZXJyb3JfbWFzaykpIHsNCj4+ICAgCQlzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2NyaXB0
b3IgICp0eGQ7DQo+PiAgIA0KPj4gLQkJaWYgKGF0Y2hhbi0+aXJxX3N0YXR1cyAmIEFUX1hETUFD
X0NJU19SQkVJUykNCj4+IC0JCQlkZXZfZXJyKGNoYW4yZGV2KCZhdGNoYW4tPmNoYW4pLCAicmVh
ZCBidXMgZXJyb3IhISEiKTsNCj4+IC0JCWlmIChhdGNoYW4tPmlycV9zdGF0dXMgJiBBVF9YRE1B
Q19DSVNfV0JFSVMpDQo+PiAtCQkJZGV2X2VycihjaGFuMmRldigmYXRjaGFuLT5jaGFuKSwgIndy
aXRlIGJ1cyBlcnJvciEhISIpOw0KPj4gLQkJaWYgKGF0Y2hhbi0+aXJxX3N0YXR1cyAmIEFUX1hE
TUFDX0NJU19ST0lTKQ0KPj4gLQkJCWRldl9lcnIoY2hhbjJkZXYoJmF0Y2hhbi0+Y2hhbiksICJy
ZXF1ZXN0IG92ZXJmbG93IGVycm9yISEhIik7DQo+PiArCQlpZiAoYXRjaGFuLT5pcnFfc3RhdHVz
ICYgZXJyb3JfbWFzaykNCj4+ICsJCQlhdF94ZG1hY19oYW5kbGVfZXJyb3IoYXRjaGFuKTsNCj4+
ICAgDQo+PiAgIAkJc3Bpbl9sb2NrKCZhdGNoYW4tPmxvY2spOw0KPj4gICAJCWRlc2MgPSBsaXN0
X2ZpcnN0X2VudHJ5KCZhdGNoYW4tPnhmZXJzX2xpc3QsDQo+PiAtLSANCj4+IDIuMTcuMQ0KPiAN
Cg0KDQotLSANCk5pY29sYXMgRmVycmUNCg==
