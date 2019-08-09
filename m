Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8BBC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07B020C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Lo4YPI+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407403AbfHIPzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:55:39 -0400
Received: from mail-eopbgr130131.outbound.protection.outlook.com ([40.107.13.131]:54694
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406394AbfHIPzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:55:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtVSQqBPoO+G+YYTCRMX1tkQeZZ9Ack+zvrpIh+Eob5eWHgkIwqv4YaJyIAV/zdPUUVBHhyXTsxnUFSs8CNZh/WBAbV6r4MER957mKjoXVB6Uy2pPrJxRHVtX+5VXr43dU9RQ2XfliB4imnJy0HujXr6sOXvxfdomsoFQ4/AyIvZYZ48dvUP7vCfsdahaszU7x9aZK/Sht+ExIEG8GPYdxBl27vK9HzWjE5N+eZkprvoOiIwaZIDGn5jBNRxhuYSt5T0IWFwawjtA9z4XJHISitkAuIVokzl7H22sMZnWO1QC9AVl8YZn4WZ6tx1KpUnBiQAN97qgDA1pQEJyvcFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMIQ3LKlVpwZwW25lvNlrrC/nb/SfcrvPV/wOxbiCVk=;
 b=TcpA+B5uqamYdkoIvfdVUeImFcQJhyi1QMLrsLyr0MaWBBFEXMNJnC26cYbucy0akmrGGc6aU/x1flISh7Orj7nkwBF4kipNQtqNW+xW4LZJavq9OPb9C8AVlW/jKUP+qCs1FxnzS65DRg7+cpuCQDHGChmGmvvSbYfPMJs3NzKExhYOSathqcDsJqJ7mKcnabdHjdYiowS8K/GCXf1RF7S4MFfl04Lbm3uPhX8HPVgkCdc2jMTCkdlk7Kd0rU6IiDJzosHlh213ew0ruJu6Ytz103Vn/IZ4G5At15dXcKX5vrCOkxINe4x19o92gFjuBCW10no4cKFTkqyKUHMTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMIQ3LKlVpwZwW25lvNlrrC/nb/SfcrvPV/wOxbiCVk=;
 b=Lo4YPI+err8OSPVXrccUjrvEoz+0WVOkW1+uct0eA2k9aesDTkiqqclumWtPk8hsZTL3LUsXHKkewm618bIEMmlLDhF1UFtdpkwUHrthiy0KPNmRd7qujJ4Us98FIGdeL8oP9n14OGNGhaAqNKTh0TuPv1KK4AFRCDxRaBauI1M=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB6752.eurprd05.prod.outlook.com (10.186.160.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 9 Aug 2019 15:54:53 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:54:53 +0000
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
Subject: Re: [PATCH v3 20/21] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Topic: [PATCH v3 20/21] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Index: AQHVTPnbX5TuINx5REGgBdWJDofJzaby+52A
Date:   Fri, 9 Aug 2019 15:54:53 +0000
Message-ID: <c3eb930aa727067e3d5bbc62523feb6b032244c0.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-21-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-21-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f71fcf0b-d995-471d-8722-08d71ce1eb50
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6752;
x-ms-traffictypediagnostic: VI1PR05MB6752:
x-microsoft-antispam-prvs: <VI1PR05MB67520FB7EBCC510EEB243D48FBD60@VI1PR05MB6752.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(189003)(199004)(99286004)(2906002)(478600001)(316002)(71190400001)(305945005)(2201001)(5660300002)(110136005)(118296001)(54906003)(7736002)(64756008)(66946007)(66556008)(66446008)(229853002)(6512007)(66476007)(6486002)(53936002)(6436002)(36756003)(256004)(14444005)(71200400001)(91956017)(76116006)(6506007)(186003)(86362001)(102836004)(4326008)(76176011)(2501003)(446003)(25786009)(6116002)(14454004)(6246003)(46003)(44832011)(11346002)(2616005)(476003)(486006)(7416002)(8936002)(81166006)(8676002)(81156014)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6752;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: duNSDpQAtODwuiaaEMNZ8FyyC80rfG82hbmJkiMeWhA6VIMYy3UR1ucFlx7H1LYSCw+n/5BHmCzl/vHEgNCEjftCIgSKiPOWb6nCq7Vsj5wa+77stb3sGq/AkYxd93S2UHt7u24mF0tk4O9yHl6EN/6oZNsi+9Bz7NwtvmTGT3bpzV2S05FN8icysCp+DX8avQ++uTkzmO2ZrJRObn2e401NfOcM6w+uFjOiAq3Rsy+bGnHFWJNUC9T10DNkD1GD3PA+8BQIa63IKP/NOAXVrY98XsdGtUpm2UwkInbXliBabf3m1jl3HVnQXpgPxlVF4exfx5vivbj9xbsZz1H4UlrDvXWV/pA+qyT3awjO7dpW9nychVWNDF1iB5y9Pun9My0D+7GN8w9+6OAFkIF1bwhshPZOLHN2FTWbhPmWc1k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F14F17A2735E34D8E74A7B44EB49797@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71fcf0b-d995-471d-8722-08d71ce1eb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:54:53.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhREyP9VWeDGaom3WXq9DanPvF2hpl1JtlUtrsWy8gnAbeQOonoHQzrZ1YSp3iSRlxNbbmOaXrb3kbSwduKHVnZmRRlK9UzZB4W2/HYbnz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcGUNCg0KT24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBw
ZSBTY2hlbmtlciB3cm90ZToNCj4gVGhpcyBhZGRzIHRoZSBjb21tb24gdG91Y2hzY3JlZW4gdGhh
dCBpcyB1c2VkIHdpdGggVG9yYWRleCdzDQo+IEV2YWwgQm9hcmRzLg0KDQpJcyB0aGF0IHJlYWxs
eSBFdmFsIEJvYXJkIHNwZWNpZmljPw0KDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVu
a2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gDQo+IC0tLQ0KPiANCj4gQ2hh
bmdlcyBpbiB2MzogTm9uZQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFJlbW92ZWQgZjA3MTBhLCB0
aGF0IGlzIGRvd25zdHJlYW0gb25seQ0KPiAtIENoYW5nZWQgdG8gZ2VuZXJpYyBub2RlIG5hbWUN
Cj4gLSBCZXR0ZXIgY29tbWVudA0KPiANCj4gIC4uLi9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xp
YnJpLWV2YWwtdjMuZHRzaSB8IDI0DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZ1bGwtY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gaW5kZXggZDNjNDgwOWYxNDBlLi43OGU3
NGJmZWNhMWIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJy
aS1ldmFsLXYzLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJp
LWV2YWwtdjMuZHRzaQ0KPiBAQCAtMTEyLDYgKzExMiwyMSBAQA0KPiAgJmkyYzEgew0KPiAgCXN0
YXR1cyA9ICJva2F5IjsNCj4gIA0KPiArCS8qDQo+ICsJICogVG91Y2hzY3JlZW4gaXMgdXNpbmcg
U09ESU1NIDI4LzMwLCBhbHNvIHVzZWQgZm9yIFBXTTxCPiwNCj4gUFdNPEM+LA0KPiArCSAqIGFr
YSBwd20yLCBwd20zLiBzbyBpZiB5b3UgZW5hYmxlIHRvdWNoc2NyZWVuLCBkaXNhYmxlIHRoZQ0K
PiBwd21zDQo+ICsJICovDQo+ICsJdG91Y2hzY3JlZW5ANGEgew0KPiArCQljb21wYXRpYmxlID0g
ImF0bWVsLG1heHRvdWNoIjsNCj4gKwkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwkJ
cGluY3RybC0wID0gPCZwaW5jdHJsX2dwaW90b3VjaD47DQo+ICsJCXJlZyA9IDwweDRhPjsNCj4g
KwkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzQ+Ow0KPiArCQlpbnRlcnJ1cHRzID0gPDE2IElS
UV9UWVBFX0VER0VfRkFMTElORz47CS8qIFNPRElNTSAyOA0KPiAqLw0KPiArCQlyZXNldC1ncGlv
cyA9IDwmZ3BpbzIgNSBHUElPX0FDVElWRV9ISUdIPjsJLyoNCj4gU09ESU1NIDMwICovDQo+ICsJ
CXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJfTsNCj4gKw0KPiAgCS8qIE00MVQwTTYgcmVhbCB0
aW1lIGNsb2NrIG9uIGNhcnJpZXIgYm9hcmQgKi8NCj4gIAltNDF0MG02OiBydGNANjggew0KPiAg
CQljb21wYXRpYmxlID0gInN0LG00MXQwIjsNCj4gQEAgLTE4OCwzICsyMDMsMTIgQEANCj4gIAlz
ZC11aHMtc2RyMTA0Ow0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIH07DQo+ICsNCj4gKyZpb211
eGMgew0KPiArCXBpbmN0cmxfZ3Bpb3RvdWNoOiB0b3VjaGdwaW9zIHsNCj4gKwkJZnNsLHBpbnMg
PSA8DQo+ICsJCQlNWDZVTF9QQURfTkFORF9EUVNfX0dQSU80X0lPMTYJCTB4NzQNCj4gKwkJCU1Y
NlVMX1BBRF9FTkVUMV9UWF9FTl9fR1BJTzJfSU8wNQkweDE0DQo+ICsJCT47DQo+ICsJfTsNCj4g
K307DQoNCkkgZ3Vlc3MgdGhhdCBjb3VsZCBhbHNvIGJlIG1vdmVkIHRvIHRoZSBtb2R1bGUncyBk
dHNpIGZvciBhbnkgY2FycmllciBib2FyZCB0byBwb3RlbnRpYWxseSBwcm9maXQgZnJvbS4NCg0K
Q2hlZXJzDQoNCk1hcmNlbA0K
