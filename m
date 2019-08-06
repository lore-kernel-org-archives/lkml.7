Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C4C0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0D92086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f/SpXEHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbfHFBzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 21:55:38 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:12769
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728922AbfHFBzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:55:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdVdKIXR1l/YAKrF/ehgAmjloJ/Ky6JjITkv85GVsauTSUoonNK9QzJZhbcVxVohU1cJksjU4m9A6rzs49uNHO327SL802AWIhS6l+pUGamBIQy0X2PSa637MqmtUHHxqLFzdAAkKCzOIK2Sexf7ajo9oEsqf2w2xHMZ4O6LfNT3b3a+aYbIrfE4czDVKDUtEb//YJcccSz8yAM3K3znlJAToWr8ZQTHlmXCURKOSLHcVT5znDCjY+gNUS0ZLd9t2Y86TDs/vvOqnFNsmeJo6xO238z6MbIoUlJxXoRW6xJAzaDTQWg4SR4//BmoSPYJBrh6eJGzJpk3r3Unsn++Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfkeCaQlWlgFserY3ZrBIfCH08boVsY4H7XHT04L0sU=;
 b=jDfKa01v/kQshBCLZApNQS4ZiidpER7qmyLmSFx6MR0osJL68vOmE2m7OYIjw+5qT/7YjsLrvUKovPTztgXrOTjLq0K8IDXlwRprozORe9emXNapmCwWPxykzG8fE4C78APx/qb0MBozDes3jr4lzs1jddPFLTT6dSrQAMTHICT6yEt70PzuP+Iv5dXBS4jtZGWGX1azwcgzsxeCi6c49c28UVVOs7/Wq3tjvXieFusgCMGfMV+bhGR52KkQcAXIuYgtGdVOKd7/j5gIhhMo5vDg1c+sVkG3JI9T9VyiJwZCGCkNIj/LZpP9gGDmiRxYj4/fEKaOi/nanxnNbSONgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfkeCaQlWlgFserY3ZrBIfCH08boVsY4H7XHT04L0sU=;
 b=f/SpXEHkJ012H5pboxSBdGB9/jn0Iag88a/1XbZOgGFidjUcBohk4xOG++ZpnyN0o21Oqauc1FS2KdlAGPEJQRGnJwtPjrfIefkAQnAhXib0sNz2QYNwcVk1ZpPn7vbMSKHuVdLM1FrhObgXxUnXkfmEKofZ8lE0xIy80nuhsWo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 01:55:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 01:55:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 1/5] clocksource: imx-sysctr: Add internal clock
 divider handle
Thread-Topic: [PATCH V5 1/5] clocksource: imx-sysctr: Add internal clock
 divider handle
Thread-Index: AQHVNupa/BF0ohbs50COjHmVK/z9Babthhpw
Date:   Tue, 6 Aug 2019 01:55:32 +0000
Message-ID: <DB3PR0402MB3916B06E8907604A71169063F5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190710063056.35689-1-Anson.Huang@nxp.com>
In-Reply-To: <20190710063056.35689-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94f5b32b-3ce9-448f-f2e2-08d71a112ad4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-microsoft-antispam-prvs: <DB3PR0402MB3852CCEEEA3DCE61CD03316FF5D50@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(99286004)(8936002)(110136005)(7736002)(81166006)(33656002)(81156014)(8676002)(305945005)(229853002)(316002)(2201001)(6116002)(3846002)(256004)(4326008)(6246003)(2906002)(478600001)(25786009)(2501003)(7696005)(76176011)(5660300002)(66066001)(71200400001)(52536014)(55016002)(476003)(26005)(68736007)(486006)(186003)(102836004)(71190400001)(9686003)(446003)(11346002)(74316002)(53936002)(6436002)(66946007)(66556008)(64756008)(6506007)(86362001)(7416002)(66476007)(76116006)(14454004)(66446008)(44832011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lp+9fGIieLJmvfMNYjldcpoVy6NLdrsyGTwKFWFD927dN8361QgYAwHiSqOVKOEbg+0UsPMAh3Sz8tlxGCB5aHNqNTvmWz3APkUD/VlVmRq2Rps/AqFjQSpbgCrTWN91jkQ72cUWy63TBfBhCTqpejA2Mz0Wtyigbc/osc7Fqk30DWGJzffJh9ESiXaZxkN8Ei71tNTYWI5jXhFPOlpPe8VvY8t8N5WUr84yr4sSppU/F/SbDFLBqrw6VwJFcqVXk7TNkqNcM+y3EUwE9U86W1IlpnPk/lWAf7qL1yEEvsQu3412J6dr82Di8s7HRwddRLVtfTVwGlGtq/5BLegRB4VnqCZwGtZeM13HcGIgvictzlqHKnphovp9h/MA/Oyi3jXXa2nQr3TsRhpvl7VeDfDNx+n6wW7FDhljFdTWEIE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f5b32b-3ce9-448f-f2e2-08d71a112ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 01:55:33.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNv
bT4NCj4gDQo+IFRoZSBzeXN0ZW0gY291bnRlciBibG9jayBndWlkZSBzdGF0ZXMgdGhhdCB0aGUg
YmFzZSBjbG9jayBpcyBpbnRlcm5hbGx5IGRpdmlkZWQNCj4gYnkgMyBiZWZvcmUgdXNlLCB0aGF0
IG1lYW5zIHRoZSBjbG9jayBpbnB1dCBvZiBzeXN0ZW0gY291bnRlciBkZWZpbmVkIGluIERUDQo+
IHNob3VsZCBiZSBiYXNlIGNsb2NrIHdoaWNoIGlzIG5vcm1hbGx5IGZyb20gT1NDLCBhbmQgdGhl
biBpbnRlcm5hbGx5IGRpdmlkZWQNCj4gYnkgMyBiZWZvcmUgdXNlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2Vz
IHNpbmNlIFY0Og0KPiAJLSB0byBzb2x2ZSB0aGUgY2xvY2sgZHJpdmVyIHByb2JlZCBhZnRlciBz
eXN0ZW0gY291bnRlciBkcml2ZXIgaXNzdWUsDQo+IG5vdyB3ZSBjYW4gZWFzaWx5IHN3aXRjaCB0
bw0KPiAJICB1c2UgZml4ZWQgY2xvY2sgZGVmaW5lZCBpbiBEVCBhbmQgZ2V0IGl0cyByYXRlLCB0
aGVuIGRpdmlkZWQgYnkgMyB0bw0KPiBnZXQgcmVhbCBjbG9jayByYXRlIGZvcg0KPiAJICBzeXN0
ZW0gY291bnRlciBkcml2ZXIsIG5vIG5lZWQgdG8gYWRkICJjbG9jay1mcmVxdWVuY3kiIHByb3Bl
cnR5IGluDQo+IERULg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItaW14LXN5
c2N0ci5jIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItaW14LXN5c2N0ci5jDQo+
IGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgtc3lzY3RyLmMNCj4gaW5kZXggZmQ3ZDY4
MC4uYjdjODBhMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgt
c3lzY3RyLmMNCj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgtc3lzY3RyLmMN
Cj4gQEAgLTIwLDYgKzIwLDggQEANCj4gICNkZWZpbmUgU1lTX0NUUl9FTgkJMHgxDQo+ICAjZGVm
aW5lIFNZU19DVFJfSVJRX01BU0sJMHgyDQo+IA0KPiArI2RlZmluZSBTWVNfQ1RSX0NMS19ESVYJ
CTB4Mw0KPiArDQo+ICBzdGF0aWMgdm9pZCBfX2lvbWVtICpzeXNfY3RyX2Jhc2U7DQo+ICBzdGF0
aWMgdTMyIGNtcGNyOw0KPiANCj4gQEAgLTEzNCw2ICsxMzYsOSBAQCBzdGF0aWMgaW50IF9faW5p
dCBzeXNjdHJfdGltZXJfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUNCj4gKm5wKQ0KPiAgCWlmIChy
ZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiArCS8qIHN5c3RlbSBjb3VudGVyIGNsb2NrIGlz
IGRpdmlkZWQgYnkgMyBpbnRlcm5hbGx5ICovDQo+ICsJdG9fc3lzY3RyLm9mX2Nsay5yYXRlIC89
IFNZU19DVFJfQ0xLX0RJVjsNCj4gKw0KPiAgCXN5c19jdHJfYmFzZSA9IHRpbWVyX29mX2Jhc2Uo
JnRvX3N5c2N0cik7DQo+ICAJY21wY3IgPSByZWFkbChzeXNfY3RyX2Jhc2UgKyBDTVBDUik7DQo+
ICAJY21wY3IgJj0gflNZU19DVFJfRU47DQo+IC0tDQo+IDIuNy40DQoNCg==
