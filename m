Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74919C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0AA20815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CsU8OUcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfF0Anh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:43:37 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:33799
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728957AbfF0Ane (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL2i1QhlT2oXyWCFOtNQt8/8E/Bet3GmVszuUsuXWwU=;
 b=CsU8OUcDOKV2Wi3IHXy8bBa3ZmO71Hdt6KeeGNDXmK6ZGFqgRU96t/4mpdndY+17L2Ur+O+aZ3NsUHCyncZejrC+mWFTQI4dfcA3u3h9Z7KOndxN/zGmiIz1gtB2uDGSCW4k7G3xaeTtlY28z2vai6QBs8Hx9eRl4yociphMCLg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 00:43:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 00:43:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND V2 1/3] clocksource/drivers/sysctr: Add optional
 clock-frequency property
Thread-Topic: [PATCH RESEND V2 1/3] clocksource/drivers/sysctr: Add optional
 clock-frequency property
Thread-Index: AQHVKcBeREE6S4ew/U+TyYIcUsyobqas4eqAgABJq2CAAJdTAIAA60fw
Date:   Thu, 27 Jun 2019 00:43:30 +0000
Message-ID: <DB3PR0402MB3916ED4AB17B6DDD2248DD44F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190623123850.22584-1-Anson.Huang@nxp.com>
 <55abafbd-c010-32b5-6d76-26040830d5b0@linaro.org>
 <DB3PR0402MB3916AB9F2260B0E46CCDDEC0F5E20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <9c017ba9-ac6b-480b-d1f3-120289343101@linaro.org>
In-Reply-To: <9c017ba9-ac6b-480b-d1f3-120289343101@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6df2f74e-c017-4256-5822-08d6fa987a2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3755EC739580460A5EF20D77F5FD0@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(102836004)(2201001)(316002)(86362001)(66556008)(8936002)(7736002)(2906002)(76176011)(305945005)(11346002)(53546011)(7416002)(4326008)(26005)(68736007)(229853002)(186003)(6306002)(6436002)(7696005)(6506007)(74316002)(9686003)(478600001)(6246003)(966005)(53936002)(2501003)(81166006)(73956011)(66476007)(476003)(55016002)(99286004)(25786009)(5660300002)(76116006)(66066001)(44832011)(486006)(8676002)(71190400001)(71200400001)(64756008)(33656002)(3846002)(81156014)(66946007)(256004)(110136005)(52536014)(66446008)(6116002)(14454004)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D6BFPssxfyfnJK+jYqgVzova5NKWj9zVRtGF962LNLmVBeavfKw1KhHqbbDsbFtDNgcP4BmaOLqL8ybixP3/eHkvCNg7xURAuyQfrNXAQosT1ESSndVCvu0JHp8jcNH9EDFCW0hsVmE1QGQJCezPfi6JCcUlPeMmtDaF4vJXYROrLJSbtkTNw48KYqd2k5qrNx4T/a4cw14GmlF9r8dA67U/jUERZSr1ScNt+0dYx03UTP0hJ1BOn4V47ZD+dPMZ/Q/TpRTYA4hjvLnJpE9kEWKnAotxYkcQdxhK4zNgARgnoJ7DRa133fPffeJPrSJyCtZOzVN7dxACM2IUtFIS4e+LwJtxWOqu8dlG5f/l5CqIy0TcCnFQLq8GALv8kJpVS98ToHVG6uJjCN1nv+SyOKDT8zGocATirfFIKshgTaM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df2f74e-c017-4256-5822-08d6fa987a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 00:43:30.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IE9uIDI2LzA2LzIwMTkgMDM6NDIsIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+IEhpLCBEYW5pZWwNCj4gPg0KPiA+PiBPbiAyMy8wNi8yMDE5IDE0OjM4LCBBbnNvbi5IdWFu
Z0BueHAuY29tIHdyb3RlOg0KPiA+Pj4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54
cC5jb20+DQo+ID4+Pg0KPiA+Pj4gU3lzdGVtcyB3aGljaCB1c2UgcGxhdGZvcm0gZHJpdmVyIG1v
ZGVsIGZvciBjbG9jayBkcml2ZXIgcmVxdWlyZSB0aGUNCj4gPj4+IGNsb2NrIGZyZXF1ZW5jeSB0
byBiZSBzdXBwbGllZCB2aWEgZGV2aWNlIHRyZWUgd2hlbiBzeXN0ZW0gY291bnRlcg0KPiA+Pj4g
ZHJpdmVyIGlzIGVuYWJsZWQuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBpcyBuZWNlc3NhcnkgYXMgaW4g
dGhlIHBsYXRmb3JtIGRyaXZlciBtb2RlbCB0aGUgb2ZfY2xrDQo+ID4+PiBvcGVyYXRpb25zIGRv
IG5vdCB3b3JrIGNvcnJlY3RseSBiZWNhdXNlIHN5c3RlbSBjb3VudGVyIGRyaXZlciBpcw0KPiA+
Pj4gaW5pdGlhbGl6ZWQgaW4gZWFybHkgcGhhc2Ugb2Ygc3lzdGVtIGJvb3QgdXAsIGFuZCBjbG9j
ayBkcml2ZXIgdXNpbmcNCj4gPj4+IHBsYXRmb3JtIGRyaXZlciBtb2RlbCBpcyBOT1QgcmVhZHkg
YXQgdGhhdCB0aW1lLCBpdCB3aWxsIGNhdXNlDQo+ID4+PiBzeXN0ZW0gY291bnRlciBkcml2ZXIg
aW5pdGlhbGl6YXRpb24gZmFpbGVkLg0KPiA+Pj4NCj4gPj4+IEFkZCB0aGUgb3B0aW5hbCBjbG9j
ay1mcmVxdWVuY3kgdG8gdGhlIGRldmljZSB0cmVlIGJpbmRpbmdzIG9mIHRoZQ0KPiA+Pj4gTlhQ
IHN5c3RlbSBjb3VudGVyLCBzbyB0aGUgZnJlcXVlbmN5IGNhbiBiZSBoYW5kZWQgaW4gYW5kIHRo
ZSBvZl9jbGsNCj4gPj4+IG9wZXJhdGlvbnMgY2FuIGJlIHNraXBwZWQuDQo+ID4+DQo+ID4+IElz
bid0IGl0IHBvc3NpYmxlIHRvIGNyZWF0ZSBhIGZpeGVkLWNsb2NrIGFuZCByZWZlciB0byBpdD8g
U28gbm8gbmVlZA0KPiA+PiB0byBjcmVhdGUgYSBzcGVjaWZpYyBhY3Rpb24gYmVmb3JlIGNhbGxp
bmcgdGltZXJfb2ZfaW5pdCgpID8NCj4gPj4NCj4gPg0KPiA+IEFzIHRoZSBjbG9jayBtdXN0IGJl
IHJlYWR5IGJlZm9yZSB0aGUgVElNRVJfT0ZfREVDTEFSRSwgc28gYWRkaW5nIGENCj4gPiBDTEtf
T0ZfREVDTEFSRV9EUklWRVIgaW4gY2xvY2sgZHJpdmVyIHRvIE9OTFkgcmVnaXN0ZXIgYSBmaXhl
ZC1jbG9jaz8NCj4gPiBUaGUgc3lzdGVtIGNvdW50ZXIncyBmcmVxdWVuY3kgYXJlIGRpZmZlcmVu
dCBvbiBkaWZmZXJlbnQgcGxhdGZvcm1zLA0KPiA+IHNvIGFkZGluZyBmaXhlZCBjbG9jayBpbiBz
eXN0ZW0gY291bnRlciBkcml2ZXIgaXMgTk9UIGEgZ29vZCBpZGVhLA0KPiA+IE9OTFkgdGhlIERU
IG5vZGUgb3IgdGhlIGNsb2NrIGRyaXZlciBjYW4gY3JlYXRlIHRoaXMgZml4ZWQgY2xvY2sgYWNj
b3JkaW5nIHRvDQo+IHBsYXRmb3JtcywgY2FuIHlvdSBhZHZpc2Ugd2hlcmUgdG8gY3JlYXRlIHRo
aXMgZml4ZWQgY2xvY2sgaXMgYmV0dGVyPw0KPiANCj4gQ2FuIHlvdSBwb2ludCBtZSB0byBhIERU
IHdpdGggdGhlICJueHAsc3lzY3RyLXRpbWVyIiA/DQoNClRoZSBEVCBub2RlIG9mIHN5c3RlbSBj
b3VudGVyIGlzIG5ldyBhZGRlZCBpbiAzLzMgb2YgdGhpcyBwYXRjaCBzZXJpZXMsIGFsc28gY2Fu
IGJlIGZvdW5kDQpmcm9tIGJlbG93IGxpbms6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3BhdGNoLzExMDExNzAzLw0KDQp0aGFua3MsDQpBbnNvbg0KDQo=
