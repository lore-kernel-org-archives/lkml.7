Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA3FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247A420880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ajdxZxAn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="OfMgbTAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDHLkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:40:08 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:34108 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHLkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:40:07 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 47FC610C1495;
        Mon,  8 Apr 2019 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554723607; bh=vcVhQrgnpqdVA4tlvFOIXZcCMD9yfr5ujzFS6DGu8Kc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ajdxZxAn4PMOfjYjwFrBfB/+CcwsfUT74v2B+8W4c8LZ4y2I3Uu9BnjEgq0FeRTDf
         K3i0F5e60QJAj8ELl7W6lKCPJZYwU6Hz5hqumTb6mmqdNBFYYwzpXy1mUuKv02HGnH
         44MCW9b4IC1v6IoG/NZJKK7xKxM6CM7yatij93z7W6107CySPZqLLyJIvU36FyYiyZ
         /N7Amd9/cu1VEiTC74umO0BEf81YLUjqWUYek4TujJPlpva5XwRUhmlezta9GgSTcJ
         MF4YodKv/ZGEjML1SzLJ9PwzxmKAUvu5l/VLrvmtnZcrS+OIopsY+nNyS2Sc6+H78w
         4KQDN3PaMEFvg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DB023A009F;
        Mon,  8 Apr 2019 11:40:06 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 8 Apr 2019 04:40:05 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 8 Apr 2019 04:40:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcVhQrgnpqdVA4tlvFOIXZcCMD9yfr5ujzFS6DGu8Kc=;
 b=OfMgbTAzFoJ+0Djm7xkKIORPjoAVxaiADfpnYhDRSFhl1dvsMiRn/CIzgf/Xl+tNI/l9kqcY+e0hy6m9cHAwqYaRfIEI4/EIwmxu0YrdpG+jOOu9y3y0Z6J2bdpq19OC3XCcmiugjrgTTOtcFcBFDyXH9xYqy2DHLaFasOqZst8=
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com (10.172.116.10) by
 CY4PR1201MB0168.namprd12.prod.outlook.com (10.172.78.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Mon, 8 Apr 2019 11:40:01 +0000
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::1466:86ac:f4fd:6767]) by CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::1466:86ac:f4fd:6767%5]) with mapi id 15.20.1771.019; Mon, 8 Apr 2019
 11:40:01 +0000
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>
CC:     Joao Pinto <joao.pinto@synopsys.com>,
        "nelson.costa@synopsys.com" <nelson.costa@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        "eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        "jose.abreu@synopsys.com" <jose.abreu@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
Subject: Re: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Thread-Topic: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Thread-Index: AQHU7fZSnbQvj+gxfk+DCceWR2xQe6YyI6sA
Date:   Mon, 8 Apr 2019 11:40:00 +0000
Message-ID: <1554723600.2797.58.camel@synopsys.com>
References: <33ed7b90da8439aecb3544c3ff7dcfb511e03b8e.1554457026.git.vitor.soares@synopsys.com>
In-Reply-To: <33ed7b90da8439aecb3544c3ff7dcfb511e03b8e.1554457026.git.vitor.soares@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87e11aef-523a-4c9c-679c-08d6bc16ef60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR1201MB0168;
x-ms-traffictypediagnostic: CY4PR1201MB0168:
x-microsoft-antispam-prvs: <CY4PR1201MB016810316EA8C7CCB1E69CD4DE2C0@CY4PR1201MB0168.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(366004)(346002)(136003)(189003)(199004)(6636002)(14454004)(25786009)(6246003)(66066001)(4326008)(103116003)(36756003)(229853002)(105586002)(106356001)(107886003)(86362001)(6486002)(6512007)(53936002)(6436002)(7736002)(305945005)(2501003)(2906002)(99286004)(186003)(3846002)(110136005)(316002)(54906003)(478600001)(6116002)(68736007)(11346002)(71190400001)(71200400001)(14444005)(256004)(476003)(2616005)(6506007)(26005)(81166006)(102836004)(8936002)(8676002)(486006)(97736004)(446003)(81156014)(76176011)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0168;H:CY4PR1201MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6liOhdJX8u5VIjV8s09uxbfGFX0WYlou8mzMwblebbv9ByCGusXxwSYqoHKu0/ICF2tVKi0renN/NJ2e9PgI2a0gJ1mlao3d40nOsbdhPNYOcyW9bfYExVM671+xcs5Xwlbya6vulPUFUmBzg95eII64FOd7pD2xQ9/+WwD4SyspaRoyecZJmsrIsbgBNHYgXl+X8pgMbjbR5uWkk5bI/gpB+1MtXs+z9Z+jbNo4+uKK58APmkWjC/E17wO13+HfbbUZoCiD6mittMj4cJn7/qVN7MrmcInhvkFiF3+O1ctJFnFhQfcX26lzmDhabXzpYPpOSjLV2hxiMvW0eMlLSEG5kMYIosZ8pUZUdmhCOKTU10X+ROMpETQ420TnayxYhZppnwcUT5NSXwKyujRKvo4GyFWeFUBksYNzmCynBe0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C58E6E71E76864C9EDFC30EDD2031CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e11aef-523a-4c9c-679c-08d6bc16ef60
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 11:40:00.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0168
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml0b3IsDQoNCk9uIE1vbiwgMjAxOS0wNC0wOCBhdCAxMjozMSArMDIwMCwgVml0b3IgU29h
cmVzIHdyb3RlOg0KPiBTb21lIGN1c3RvbSBJUC1ibG9jayBjb25uZWN0ZWQgdG8gQVJDIEFYUzEw
eCBib2FyZCBuZWVkIGFzc2VydCBhbmQNCj4gZGVhc3NlcnQgZnVuY3Rpb25zIHRvIGNvbnRyb2wg
cmVzZXQgc2lnbmFsIG9mIHNlbGVjdGVkIHBlcmlwaGVyYWxzLg0KPiANCj4gVGhpcyBwYXRjaCBp
bXByb3ZlIEFYUzEweCByZXNldCBkcml2ZXIgYnkgYWRkaW5nIGFzc2VydCBhbmQgZGVhc3NlcnQN
Cj4gY2FsbGJhY2tzLg0KDQoNCkluIHRoZSBBWFMxMHggcmVzZXQgZHJpdmVyIG9ubHkgJ3Jlc2V0
JyBjYWxsYmFjayBpcyBpbnRlbnRpb25hbGx5IGltcGxlbWVudGVkLg0KQVhTMTB4IGlzIEZQR0Eg
YmFzZWQgYm9hcmRzIGFuZCB3aXRoIG91ciBkZWZhdWx0IGZpcm13YXJlIEFYUzEweCByZXNldCBy
ZWdpc3RlciBpcyBpbXBsZW1lbnRlZCBhcyBzZWxmLWRlYXNzZXJ0ZWQuDQoNCkRvIHlvdSBoYXZl
IHNvbWVob3cgbW9kaWZpZWQgQVhTMTB4IGZpcm13YXJlIHdoZXJlIHJlc2V0IHJlZ2lzdGVyIGlz
IG5vdCBzZWxmLWRlYXNzZXJ0ZWQ/DQpJbiB0aGF0IGNhc2UgInNpbXBsZS1yZXNldCIgZHJpdmVy
IHdpbGwgYmUgc3VpdGFibGUgZm9yIHlvdSwgSSBndWVzcy4NCk90aGVyd2lzZSB0aGlzIGltcGxl
bWVudGF0aW9uIGlzIGluY29ycmVjdCAtIHRoZXJlIHNob3VsZCBiZSBubyAnYXNzZXJ0JyBmb3Ig
cmVzZXQgY29udHJvbGxlciB3aXRoIHNlbGYtZGVhc3NlcnRlZCBsb2dpYy4NCg0KDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBWaXRvciBTb2FyZXMgPHZpdG9yLnNvYXJlc0BzeW5vcHN5cy5jb20+DQo+
IA0KPiBDYzogRXVnZW5peSBQYWx0c2V2IDxldWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPg0K
PiBDYzogQWxleGV5IEJyb2RraW4gPGFicm9ka2luQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IEpvYW8g
UGludG8gPGpwaW50b0BzeW5vcHN5cy5jb20+DQo+IENjOiBKb3NlIEFicmV1IDxqb3NlLmFicmV1
QHN5bm9wc3lzLmNvbT4NCj4gQ2M6IEx1aXMgT2xpdmVpcmEgPGxvbGl2ZWlAc3lub3BzeXMuY29t
Pg0KPiBDYzogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+
DQo+IENjOiBOZWxzb24gQ29zdGEgPG5lbHNvbi5jb3N0YUBzeW5vcHN5cy5jb20+DQo+IENjOiBQ
ZWRybyBTb3VzYSA8cGVkcm9tLnNvdXNhQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IFBoaWxpcHAgWmFi
ZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9yZXNldC9yZXNl
dC1heHMxMHguYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWF4czEweC5jIGIvZHJpdmVycy9yZXNldC9yZXNldC1h
eHMxMHguYw0KPiBpbmRleCBhODU0ZWY0MS4uMTJkYWM4YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9yZXNldC9yZXNldC1heHMxMHguYw0KPiArKysgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWF4czEw
eC5jDQo+IEBAIC0zNyw4ICszNywzNiBAQCBzdGF0aWMgaW50IGF4czEweF9yZXNldF9yZXNldChz
dHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiAgDQo+ICtzdGF0aWMgaW50IGF4czEweF9yZXNldF9hc3NlcnQoc3RydWN0IHJlc2V0X2NvbnRy
b2xsZXJfZGV2ICpyY2RldiwNCj4gKwkJCSAgICAgICB1bnNpZ25lZCBsb25nIGlkKQ0KPiArew0K
PiArCXN0cnVjdCBheHMxMHhfcnN0ICpyc3QgPSB0b19heHMxMHhfcnN0KHJjZGV2KTsNCj4gKwl1
bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJnJzdC0+bG9j
aywgZmxhZ3MpOw0KPiArCXdyaXRlbChyZWFkbChyc3QtPnJlZ3NfcnN0KSAmIH5CSVQoaWQpLCBy
c3QtPnJlZ3NfcnN0KTsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZyc3QtPmxvY2ssIGZs
YWdzKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGF4czEw
eF9yZXNldF9kZWFzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiAr
CQkJCSB1bnNpZ25lZCBsb25nIGlkKQ0KPiArew0KPiArCXN0cnVjdCBheHMxMHhfcnN0ICpyc3Qg
PSB0b19heHMxMHhfcnN0KHJjZGV2KTsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArDQo+
ICsJc3Bpbl9sb2NrX2lycXNhdmUoJnJzdC0+bG9jaywgZmxhZ3MpOw0KPiArCXdyaXRlbChyZWFk
bChyc3QtPnJlZ3NfcnN0KSB8IEJJVChpZCksIHJzdC0+cmVnc19yc3QpOw0KPiArCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJnJzdC0+bG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVzZXRfY29udHJvbF9vcHMgYXhzMTB4
X3Jlc2V0X29wcyA9IHsNCj4gLQkucmVzZXQJPSBheHMxMHhfcmVzZXRfcmVzZXQsDQo+ICsJLnJl
c2V0CQk9IGF4czEweF9yZXNldF9yZXNldCwNCj4gKwkuYXNzZXJ0CQk9IGF4czEweF9yZXNldF9h
c3NlcnQsDQo+ICsJLmRlYXNzZXJ0CT0gYXhzMTB4X3Jlc2V0X2RlYXNzZXJ0LA0KPiAgfTsNCj4g
IA0KPiAgc3RhdGljIGludCBheHMxMHhfcmVzZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
