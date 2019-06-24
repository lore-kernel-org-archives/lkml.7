Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3003FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD98220657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UQPdlxK5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="eZ1/DzwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfFXR6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:58:38 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:44050 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbfFXR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:58:38 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 514E5C003A;
        Mon, 24 Jun 2019 17:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561399117; bh=IBCBUkoA5vcG/XCiA9ipnWbgZX2OIC1EnYYIsJRQQgM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UQPdlxK5TQRK7go1DDhD/LHVaPYEnhdgV800qqv/lfI/o+G2DUSkTtbwKX0KLfLSB
         mqQnle7gXEP1q2LIkdY9ZOc4BvJTUR8bvxxOYpkTf2T9QQXjDl4csT2SxiZSP76Fob
         iM1dXugTF02H6yjUC3XIdoLSQ1YD/Hom8gtsk20gjXAHOyOPQREU5nYNkqEwDvmInh
         +iwGn+a3No6l4gJVY7A7ZvKMQvikbMyD8n8SzL/Ejor2yvXBRvSQ/5vWq1B/zr+EEh
         ZfZ+oniKqbTsEqk4gjpm8UseqlmADObrB+u4YKhvkWyPJD6/lXUdeR+XTZpmISFcN8
         FUkeTkUtig9sg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5C993A0093;
        Mon, 24 Jun 2019 17:58:29 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 24 Jun 2019 10:58:29 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 24 Jun 2019 10:58:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBCBUkoA5vcG/XCiA9ipnWbgZX2OIC1EnYYIsJRQQgM=;
 b=eZ1/DzwHnBm/IusH/FwO5m0AD8NAgpfO4sDNmguNwrGLyGmG2rm96LYTpQCmrB+Yg/C7Z1NLibN1LgKX4z6rbAkUDYxg2r1qgP0EV2tJJ+z7d4tHtiiXibNqWuZsvEfbUEd2N6CxWi9EXbVBZUP+1ODz3r6oYGfjjBL1G/79O0U=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2750.namprd12.prod.outlook.com (52.135.107.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 17:58:26 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::bd34:8d2b:911e:e495]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::bd34:8d2b:911e:e495%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 17:58:26 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "marex@denx.de" <marex@denx.de>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: add support for sst26wf016, sst26wf032
 memory
Thread-Topic: [PATCH] mtd: spi-nor: add support for sst26wf016, sst26wf032
 memory
Thread-Index: AQHVHUfTQkQ8QEh2e0ePTmIyAmvCNKanjTUAgAOlAgA=
Date:   Mon, 24 Jun 2019 17:58:25 +0000
Message-ID: <305636da161f6c204e39936696301c226c1c95f9.camel@synopsys.com>
References: <20190607154308.20899-1-Eugeniy.Paltsev@synopsys.com>
         <aab6510e-9608-584e-1556-613bb0be482e@microchip.com>
In-Reply-To: <aab6510e-9608-584e-1556-613bb0be482e@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4467e569-7a96-48d9-a46d-08d6f8cd8e81
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2750;
x-ms-traffictypediagnostic: SN6PR12MB2750:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2750D644ED0A64D15BA85CBBDEE00@SN6PR12MB2750.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39850400004)(189003)(199004)(71200400001)(71190400001)(25786009)(486006)(76116006)(91956017)(186003)(2906002)(66446008)(66476007)(66556008)(64756008)(73956011)(11346002)(66946007)(6436002)(6512007)(26005)(14454004)(53936002)(54906003)(7736002)(110136005)(6486002)(6306002)(229853002)(316002)(66066001)(5660300002)(305945005)(14444005)(256004)(4326008)(8936002)(966005)(86362001)(6116002)(3846002)(6246003)(81156014)(81166006)(2501003)(8676002)(102836004)(36756003)(7416002)(118296001)(2616005)(2201001)(68736007)(446003)(99286004)(76176011)(6506007)(53546011)(476003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2750;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ucXdIsm2xlNHntSkf/7wq9XYvdtSnB4jmTZO/m55JOezUGVNMhAGH2ZKAHhOrJv1UqoBepZfCVydpIVY7z4b0QKdAIaQlkmT+8+WCCVO9YIpKRz9Je3odi1BCzJdVJmt2QJ+rVzhHlWifodhDdTWuaZl3vf8yVHghnmt39T4M6cyrwEkgwwneuaSv3lDfV+liRc3kzKvJaftFL0puSuDP8O8uwt5IGdCub/5WW6NMMonA9v7EkPdT6vc/rOiZ0KF7lMvD8+jKBDOYGADpYh42HU3oXdUt8iMEEve3AZQxpgqDObHG68vPOEUHgvIN2BbG9g9muagO0HC7Cfr0OByPyKat5EiE9QzdwRKLxbbhuCpxqEfGyvhAY+RMqYq+o/57aCNUTQCwVd/BhUqUXwh42xlueVrcp2EwnYGL5fyLIc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1770C5AE373E74180E078B9DCBA2C07@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4467e569-7a96-48d9-a46d-08d6f8cd8e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 17:58:26.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCk9uIFNhdCwgMjAxOS0wNi0yMiBhdCAxMDoxOCArMDAwMCwgVHVkb3IuQW1i
YXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBIaSwgRXVnZW5peSwNCj4gDQo+IE9uIDA2LzA3
LzIwMTkgMDY6NDMgUE0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gPiBFeHRlcm5hbCBFLU1h
aWwNCj4gPiANCj4gPiANCj4gPiBUaGlzIGNvbW1pdCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBTU1Qg
c3N0MjZ3ZjAxNiBhbmQgc3N0MjZ3ZjAzMg0KPiA+IGZsYXNoIG1lbW9yeSBJQy4NCj4gDQo+IFBs
ZWFzZSBzcGVjaWZ5IGlmIHlvdSB0ZXN0ZWQgYm90aCBmbGFzaGVzLCB3aXRoIDEtMS0xLCAxLTEt
MiBhbmQgMS0xLTQgcmVhZHMuDQo+IExldCB1cyBrbm93IHdoaWNoIGNvbnRyb2xsZXIgeW91IHVz
ZWQuIEkgYXNrIGZvciB0aGVzZSB0byBiZSBzdXJlIHRoYXQgd2UgZG9uJ3QNCj4gYWRkIGZsYXNo
ZXMgdGhhdCBhcmUgYnJva2VuIGZyb20gZGF5IG9uZS4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
RXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210
ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ID4g
aW5kZXggNzMxNzJkN2Y1MTJiLi4yMjQyNzU0NjFhMmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3Nw
aS1ub3IuYw0KPiA+IEBAIC0xOTQ1LDYgKzE5NDUsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZs
YXNoX2luZm8gc3BpX25vcl9pZHNbXSA9IHsNCj4gPiAgCXsgInNzdDI1d2YwNDBiIiwgSU5GTygw
eDYyMTYxMywgMCwgNjQgKiAxMDI0LCAgOCwgU0VDVF80SykgfSwNCj4gPiAgCXsgInNzdDI1d2Yw
NDAiLCAgSU5GTygweGJmMjUwNCwgMCwgNjQgKiAxMDI0LCAgOCwgU0VDVF80SyB8IFNTVF9XUklU
RSkgfSwNCj4gPiAgCXsgInNzdDI1d2YwODAiLCAgSU5GTygweGJmMjUwNSwgMCwgNjQgKiAxMDI0
LCAxNiwgU0VDVF80SyB8IFNTVF9XUklURSkgfSwNCj4gPiArCXsgInNzdDI2d2YwMTYiLCAgSU5G
TygweGJmMjY1MSwgMCwgNjQgKiAxMDI0LCAzMiwgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFE
IHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+IA0KPiBJIGNvbmZpcm0gdGhhdCB0aGUgYWJvdmUg
aXMgY29ycmVjdC4NCj4gDQo+ID4gKwl7ICJzc3QyNndmMDMyIiwgIElORk8oMHhiZjI2MjIsIDAs
IDY0ICogMTAyNCwgNjQsIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVB
RF9SRUFEKSB9LA0KPiANCj4gVGhlcmUgYXJlIHNzdDI2d2YwMzIgZmxhc2hlcyB0aGF0IGRvbid0
IHN1cHBvcnQgU1BJTk9SX09QX1JFQURfMV8xXzIgKDB4M2IpIGFuZA0KPiBTUElOT1JfT1BfUkVB
RF8xXzFfNCAoMHg2YiksIGNoZWNrDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0zQV9fcGRmMS5hbGxkYXRhc2hlZXQuY29tX2RhdGFzaGVldC0yRHBk
Zl92aWV3XzM5MjA2M19TU1RfU1NUMjZXRjAzMi5odG1sJmQ9RHdJR2FRJmM9RFBMNl9YXzZKa1hG
eDdBWFdxQjB0ZyZyPVpsSk4xTXJpUFVUa0JLQ3JQU3g2N0dtYXBsRVVHY0FFazl5UHRDTGRVWEkm
bT1ZS09BRmhUc21jeFZOT215NkRPNjdXWVpZZG82eFlhN29qZWJJQlUtSy1jJnM9azJ5UnFXbFhC
bGxmRzJSMkh2cVR3QWpHWUNtdmpHbTl0bVZZeHpEZ193QSZlPSAuDQo+IFlvdQ0KPiBjYW4ndCBh
ZGQgU1BJX05PUl9EVUFMX1JFQUQgYW5kIFNQSV9OT1JfUVVBRF9SRUFEIGlmIDB4M2IgYW5kIDB4
NmIgY29tbWFuZHMgYXJlDQo+IG5vdCBzdXBwb3J0ZWQuIENoZWNrIHNwaV9ub3JfaW5pdF9wYXJh
bXMoKS4NCg0KWWVwLCB0aGFua3MgZm9yIHBvaW50aW5nLg0KV2UgYXJlIHVzaW5nICdzc3QyNndm
MDE2Yicgb24gSFNESyBkZXZib2FyZC4gSSBhZGRlZCAnc3N0MjZ3ZjAzMicgdG8gbWFrZSBmbGFz
aCB1cGdyYWRlIGVhc2llciwNCmJ1dCBJIGRvbid0IGNoZWNrIGNhcmVmdWxseSBlbm91Z2ggdGhh
dCBpdCBoYXMgY29tcGxldGVseSBkaWZmZXJlbnQgY29udHJvbCBsb2dpYyBhbmQgbm90IG9ubHkg
c2l6ZS4NCkknZCBiZXR0ZXIgZHJvcCAnc3N0MjZ3ZjAzMicgaW4gdjIgcGF0Y2ggcmVzcGluIGFz
IHVudGVzdGVkLiANCg0KSW4gdGhpcyBzZXR1cCB3ZSB1c2UgInNucHMsZHctYXBiLXNzaSIgU1BJ
IGNvbnRyb2xsZXIgYW5kIHdlIGRvbid0IHVzZSBkdWFsL3F1YWQgSU8uIFNob3VsZCBJDQpkcm9w
IChTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEKSBmb3IgInNzdDI2d2YwMTYi
IGluIHYyIHJlc3Bpbj8NCg0KPiANCj4gQ2hlZXJzLA0KPiB0YQ0KLS0gDQogRXVnZW5peSBQYWx0
c2V2DQo=
