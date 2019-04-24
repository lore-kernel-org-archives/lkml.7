Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0FFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2133121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PQrBr63p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfDXMVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:21:50 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:59457 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfDXMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:21:50 -0400
X-IronPort-AV: E=Sophos;i="5.60,389,1549954800"; 
   d="scan'208";a="28983352"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Apr 2019 05:21:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 24 Apr 2019 05:21:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SmjRVDtAX8GkpaUxFNCFOPS/RaR8DqacR/1Lxq514Q=;
 b=PQrBr63ppqx3kaqX0Y2R7YYtDWLxYnAKu2ILWQIKIJRyFgbdthXPBPByF5PZAfqwkyJQQnM8f5zsPZ6tjLaHT2Zsu6khqF7I8m7k/iRhPOlT+6zw++aDXxlZqyafMRCCCE/NwZ2F0aMcTyHb3q9kdrKdTx4uGqjOQd9OK4r4FVs=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1459.namprd11.prod.outlook.com (10.172.21.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Wed, 24 Apr 2019 12:21:47 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::35b3:7af:7216:8808]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::35b3:7af:7216:8808%10]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 12:21:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: atmel-quadspi: fix crash while suspending
Thread-Topic: [PATCH] spi: atmel-quadspi: fix crash while suspending
Thread-Index: AQHU+n6cb7ejKkN0g0+RIq8NlPMpTaZLO4wA
Date:   Wed, 24 Apr 2019 12:21:47 +0000
Message-ID: <27e8b8f3-5d83-c78b-e1b4-d7c7a150bce1@microchip.com>
References: <1556097463-29672-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1556097463-29672-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0057.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::46) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2f0b403-a9e9-427b-03bf-08d6c8af6ba9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR11MB1459;
x-ms-traffictypediagnostic: BN6PR11MB1459:
x-microsoft-antispam-prvs: <BN6PR11MB1459721DB29244300C886F91F03C0@BN6PR11MB1459.namprd11.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(478600001)(186003)(476003)(6436002)(31686004)(486006)(72206003)(71200400001)(76176011)(71190400001)(6506007)(36756003)(11346002)(3846002)(52116002)(6116002)(7736002)(53546011)(2616005)(110136005)(54906003)(6246003)(316002)(305945005)(26005)(102836004)(386003)(68736007)(4326008)(14454004)(8676002)(256004)(14444005)(2501003)(2906002)(446003)(97736004)(229853002)(99286004)(66446008)(6512007)(8936002)(6636002)(25786009)(5660300002)(86362001)(81166006)(73956011)(81156014)(66476007)(64756008)(66556008)(6486002)(31696002)(66066001)(66946007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1459;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wc5XLnYObPuo/zxflNENpAwnjq0qirtRK89RzPIzvXzeVB1UiUfsTZfAHxDEvqEot1E1KTH6x5crhl8jciHW5xl8Ridyq/mzyFm1N6asUoxl86VS0vL0P3zq3j1VbkJbAomyBy9QmrtxHT8gVKFc4n2HRjnKCgSALloHCL4t9fYWp2YmiRsgiRIXDXHgIfuGHZZp9dR2eQ2DgrgPi8XSkRKbYfiocyaSIwWnjRis5oSI2ax2Fl+5F5xBMBentUHvQaMmbV+e67lyJfEGlXSnqTgmkQNH9vRgWG6i7PSy44YkulNfe/oFhjIyExAGo9YQNguUD/jEMZqFTMbxY2pdsU/Mp1LWJYOVwnLpcg6Ucwtt7kfDCCfp+YeI3buGOA8CoZ662sza2rEs45fDLczzK+cRZeRnlvIXDy1yJo946nI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF0874755D3DE74DA2FF098FFF56EC83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f0b403-a9e9-427b-03bf-08d6c8af6ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:21:47.4758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1459
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA0LzI0LzIwMTkgMTI6MTcgUE0sIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAu
Y29tPg0KPiANCj4gYXRtZWxfcXNwaSBvYmplY3RzIGFyZSBrZXB0IGluIHNwaV9jb250cm9sbGVy
IG9iamVjdHMsIHNvLCBmaXJzdCBnZXQNCj4gcG9pbnRlciB0byBzcGlfY29udHJvbGxlciBvYmpl
Y3QgYW5kIHRoZW4gZ2V0IGF0bWVsX3FzcGkgb2JqZWN0IGZyb20NCj4gc3BpX2NvbnRyb2xsZXIg
b2JqZWN0Lg0KPiANCj4gRml4ZXM6IDJkMzBhYzVlZDYzMyAoIm10ZDogc3BpLW5vcjogYXRtZWwt
cXVhZHNwaTogVXNlIHNwaS1tZW0gaW50ZXJmYWNlIGZvciBhdG1lbC1xdWFkc3BpIGRyaXZlciIp
DQo+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2No
aXAuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNy
b2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jIHwgNiAr
KysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jIGIvZHJpdmVy
cy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+IGluZGV4IGU1NDEwOTc1OWQzNC4uOWYyNGQ1ZjBiNDMx
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4gKysrIGIvZHJp
dmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+IEBAIC01NzAsNyArNTcwLDggQEAgc3RhdGljIGlu
dCBhdG1lbF9xc3BpX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+
ICBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGF0bWVsX3FzcGlfc3VzcGVuZChzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICB7DQo+IC0Jc3RydWN0IGF0bWVsX3FzcGkgKmFxID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+ICsJc3RydWN0IHNwaV9jb250cm9sbGVyICpjdHJsID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+ICsJc3RydWN0IGF0bWVsX3FzcGkgKmFxID0gc3BpX2NvbnRyb2xsZXJfZ2V0
X2RldmRhdGEoY3RybCk7DQo+ICANCj4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoYXEtPnFzcGlj
ayk7DQo+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGFxLT5wY2xrKTsNCj4gQEAgLTU4MCw3ICs1
ODEsOCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGF0bWVsX3FzcGlfc3VzcGVuZChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICANCj4gIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgYXRtZWxf
cXNwaV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAtCXN0cnVjdCBhdG1lbF9x
c3BpICphcSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXN0cnVjdCBzcGlfY29udHJvbGxl
ciAqY3RybCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXN0cnVjdCBhdG1lbF9xc3BpICph
cSA9IHNwaV9jb250cm9sbGVyX2dldF9kZXZkYXRhKGN0cmwpOw0KPiAgDQo+ICAJY2xrX3ByZXBh
cmVfZW5hYmxlKGFxLT5wY2xrKTsNCj4gIAljbGtfcHJlcGFyZV9lbmFibGUoYXEtPnFzcGljayk7
DQo+IA0K
