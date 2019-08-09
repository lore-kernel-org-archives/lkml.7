Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B3C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0496E208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="F612fisj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407279AbfHIPCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:02:37 -0400
Received: from mail-eopbgr60135.outbound.protection.outlook.com ([40.107.6.135]:13385
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407113AbfHIPCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:02:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcEqBs+/71DBinDHecibDcFMuHC2l+DIo/fUSzcP1W0xuPq3s5jIJDXwEQYcEgYvmJHRWcJWDIvx7v5sIIqb8so/bUtLhrNCSlk27yR6uDIF68jXCiRdRamRTAtNt90kZA5GySUn9kiCP97Ix6UJCesOiBlStfGAf6Rt4krko3AHVIvdggEVVt+NTfjGpma+kdSP/nxjZjYQbrIPxOEpg4+XxdVyhKh+0ZFoU7u5pXPlUuBgglZqZHv3/jiZtKPirtj5LjroHtgZtjGrhOxeHEowcHu4TkxgYFPHrt9cG8Q8Bkmd36OXuBpQBWo0qlN8OR24kX3/Zo5D3Y20wHUkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O60uK62WHuee4hk9iz6nVOVFuWUS3MaIRFhpxdQ4Z88=;
 b=T+hCg3Yv2Vz0osTDu9EoVSFTXZl29+6/a2Axgay/jFp43LNLlf0u7HYJTSPNR8l/8tHX6Vy5MdexZnOCyPBuMEoOAP/PuNYfslMf6CXZYBRXZ1KYvIKoX72BOTbtzpqVKaMQp5qZWLBDLPDffgkk/NrLoXgMcR6fA5ivDpSyCCjWObQbiP0zkqrGch/7Ic0PoBb0HiroT/vvzPd4c9bSyDiE6iInI0HV2EzBbB/dGH5bkyEKK7vF31rftv7AyyKFfZiL43ha9eFlMtBlPWZ7q8qMm+2Lcj0TXZ98cevIPjEkCSXtZ+NzWoNxHmgJpBhhyNc8ZULa8emLBdz0YOaoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O60uK62WHuee4hk9iz6nVOVFuWUS3MaIRFhpxdQ4Z88=;
 b=F612fisjz4prR1797TemJlehsXYnEhnBTFPCacZVhvA5T6pMB69Dt/8Mcm3XhC3eQFAYlHc2qr55PgRN212el8T/F68cgs84yMXKcnVBDLynYl+E4LvgNBbYxq2FIpxMr9L+1gYcjBgjFnAJGQoSnTrep33Yd9Il9qZJKeLqoIw=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB5647.eurprd05.prod.outlook.com (20.178.120.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 9 Aug 2019 15:02:31 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:02:31 +0000
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
Subject: Re: [PATCH v3 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to can
 interfaces
Thread-Topic: [PATCH v3 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to
 can interfaces
Thread-Index: AQHVTPnPmra6ZluMjkW28s0c1K5lX6by7PoA
Date:   Fri, 9 Aug 2019 15:02:31 +0000
Message-ID: <b84b451cf39db49188b45882a5c61a65da03eb2e.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-12-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-12-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54c6b61b-4518-43c9-5667-08d71cda9a72
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5647;
x-ms-traffictypediagnostic: VI1PR05MB5647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB564725831553B93205D116F4FBD60@VI1PR05MB5647.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(189003)(199004)(53936002)(316002)(66946007)(6246003)(6436002)(86362001)(81166006)(81156014)(8676002)(4326008)(71190400001)(66446008)(229853002)(64756008)(7736002)(66476007)(305945005)(2201001)(91956017)(76116006)(36756003)(66556008)(6506007)(6486002)(102836004)(186003)(118296001)(110136005)(8936002)(76176011)(2616005)(71200400001)(11346002)(446003)(486006)(44832011)(476003)(14454004)(46003)(2501003)(54906003)(5660300002)(7416002)(6512007)(14444005)(256004)(25786009)(2906002)(99286004)(478600001)(6116002)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5647;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CDh9H/y/4CO4+lJFLCEzxERj1pcgsVd4acl2EjXMb023v4BThhiS1hXJUoO2t2qSbVuf/OBjMFm53MrDNGZTt89lD9K7ftu8tfeRk18D2XIadLAfIqVC/Tb4f3Vj3B/5UQnjVffFBj9xS6G7KK5DtV96K6K/5xfEGr1RCzXVIP8vJf7kXRpOivzS4uHr9juhRPd52j/Rr69f0xRa4fCap5kXI+LA++6LbFL5WN8kB9mKg/20MlFniCoR8GZlywjjXgGndmiWn2Dh6fWF1n7GzHSDSVRAK/GOJvQQGoAVNPbYOJin0CHlSzIS9RwKY7HbUeupQPMjD6m5CqFqLdFHt4+p9F+6PqGR7KnCXfV98uS2T5kn9FOkU+OnY0Z8PnYYA7iwdKnbNJCiOAnabsXIfxghkfQJGO5/17+doYRkNsk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C54E04AC58AC69479C00A40BCBAB2527@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c6b61b-4518-43c9-5667-08d71cda9a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:02:31.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8q1dbmk//vILHN1EHWOYZfz1PijjQ8+rShoUebxIx9ZCGvtVIp2W+Ak8gNkW6S3/RFn5E7uzQDGy/ZWKCeh0czfYwOeE5M6FVGYGe+kqSQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gVGhpcyBwYXRjaCBwcmVwYXJlcyB0aGUgZGV2aWNldHJlZSBmb3IgdGhlIG5ldyBJeG9y
YSBWMS4yIHdoZXJlIHdlDQo+IGFyZQ0KPiBhYmxlIHRvIHR1cm4gb2ZmIHRoZSBzdXBwbHkgb2Yg
dGhlIGNhbiB0cmFuc2NlaXZlci4gVGhpcyBpbXBsaWVzIHRvDQo+IHVzZQ0KPiBhIHNsZWVwIHN0
YXRlIG9uIHRyYW5zbWlzc2lvbiBwaW5zIGluIG9yZGVyIHRvIHByZXZlbnQgYmFja2ZlZWRpbmcu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5r
ZXJAdG9yYWRleC5jb20+DQoNCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3
aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4g
Q2hhbmdlcyBpbiB2MjoNCj4gLSBDaGFuZ2VkIGNvbW1pdCB0aXRsZSB0byAnLi4uaW14NnFkbC1h
cGFsaXM6Li4uJw0KPiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kg
fCAyNyArKysrKysrKysrKysrKysrKysrKystLQ0KPiAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnFkbC1hcGFsaXMuZHRzaQ0KPiBpbmRleCA3YzRhZDU0MWMzZjUuLjU5ZWQyZTRhMWZkMSAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcGFsaXMuZHRzaQ0KPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNpDQo+IEBAIC0xNDgsMTQg
KzE0OCwxNiBAQA0KPiAgfTsNCj4gIA0KPiAgJmNhbjEgew0KPiAtCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+IC0JcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhjYW4xPjsNCj4gKwlwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiLCAic2xlZXAiOw0KPiArCXBpbmN0cmwtMCA9IDwmcGluY3Ry
bF9mbGV4Y2FuMV9kZWZhdWx0PjsNCj4gKwlwaW5jdHJsLTEgPSA8JnBpbmN0cmxfZmxleGNhbjFf
c2xlZXA+Ow0KPiAgCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICB9Ow0KPiAgDQo+ICAmY2FuMiB7
DQo+IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gLQlwaW5jdHJsLTAgPSA8JnBpbmN0
cmxfZmxleGNhbjI+Ow0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQo+
ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhjYW4yX2RlZmF1bHQ+Ow0KPiArCXBpbmN0cmwt
MSA9IDwmcGluY3RybF9mbGV4Y2FuMl9zbGVlcD47DQo+ICAJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gIH07DQo+ICANCj4gQEAgLTU5OSwxOSArNjAxLDMyIEBADQo+ICAJCT47DQo+ICAJfTsNCj4g
IA0KPiAtCXBpbmN0cmxfZmxleGNhbjE6IGZsZXhjYW4xZ3JwIHsNCj4gKwlwaW5jdHJsX2ZsZXhj
YW4xX2RlZmF1bHQ6IGZsZXhjYW4xZGVmZ3JwIHsNCj4gIAkJZnNsLHBpbnMgPSA8DQo+ICAJCQlN
WDZRRExfUEFEX0dQSU9fN19fRkxFWENBTjFfVFggMHgxYjBiMA0KPiAgCQkJTVg2UURMX1BBRF9H
UElPXzhfX0ZMRVhDQU4xX1JYIDB4MWIwYjANCj4gIAkJPjsNCj4gIAl9Ow0KPiAgDQo+IC0JcGlu
Y3RybF9mbGV4Y2FuMjogZmxleGNhbjJncnAgew0KPiArCXBpbmN0cmxfZmxleGNhbjFfc2xlZXA6
IGZsZXhjYW4xc2xwZ3JwIHsNCj4gKwkJZnNsLHBpbnMgPSA8DQo+ICsJCQlNWDZRRExfUEFEX0dQ
SU9fN19fR1BJTzFfSU8wNyAweDANCj4gKwkJCU1YNlFETF9QQURfR1BJT184X19HUElPMV9JTzA4
IDB4MA0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gKwlwaW5jdHJsX2ZsZXhjYW4yX2RlZmF1bHQ6
IGZsZXhjYW4yZGVmZ3JwIHsNCj4gIAkJZnNsLHBpbnMgPSA8DQo+ICAJCQlNWDZRRExfUEFEX0tF
WV9DT0w0X19GTEVYQ0FOMl9UWCAweDFiMGIwDQo+ICAJCQlNWDZRRExfUEFEX0tFWV9ST1c0X19G
TEVYQ0FOMl9SWCAweDFiMGIwDQo+ICAJCT47DQo+ICAJfTsNCj4gKwlwaW5jdHJsX2ZsZXhjYW4y
X3NsZWVwOiBmbGV4Y2FuMnNscGdycCB7DQo+ICsJCWZzbCxwaW5zID0gPA0KPiArCQkJTVg2UURM
X1BBRF9LRVlfQ09MNF9fR1BJTzRfSU8xNCAweDANCj4gKwkJCU1YNlFETF9QQURfS0VZX1JPVzRf
X0dQSU80X0lPMTUgMHgwDQo+ICsJCT47DQo+ICsJfTsNCj4gIA0KPiAgCXBpbmN0cmxfZ3Bpb19i
bF9vbjogZ3Bpb2Jsb24gew0KPiAgCQlmc2wscGlucyA9IDwNCg==
