Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC49C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFFC21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hfIRCE1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfGBJKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:10:11 -0400
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:43396
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbfGBJKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG1XeOdLg0fdLJ+hXZFLe7lkX1Od/+Pmk+XeSS4KQAY=;
 b=hfIRCE1BLK8H8L47MX4Orm97Tm1yqFikrZA1ii9v8H75iGJVHbwWUPprze13W0UBHNnb/3dNx60PaHCU0lsOcN24NfqVeQqrpRjDaWNxqXBanuWAv9CDXEfbEPzp174tniTQMkRv14JE+u715QcP4ZrGnEHCrquYJ9MYhTJC0E4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 09:10:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 09:10:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND V4 1/5] clocksource: timer-of: Support getting
 clock frequency from DT
Thread-Topic: [PATCH RESEND V4 1/5] clocksource: timer-of: Support getting
 clock frequency from DT
Thread-Index: AQHVMKzI5vm2kro3VEayuYp4cUHC7Ka2+NMAgAAMX4CAAASnAIAAAF5Q
Date:   Tue, 2 Jul 2019 09:10:07 +0000
Message-ID: <DB3PR0402MB3916D80505D5C5CBA82348B3F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190702075513.17451-1-Anson.Huang@nxp.com>
 <c7ff76e5-d73d-e71e-c3f4-445bdd2c5b93@linaro.org>
 <DB3PR0402MB39166F04BAF9BA9D6C75B3A8F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <0540a255-93e5-d68f-5bf5-31f9043fb3ad@linaro.org>
In-Reply-To: <0540a255-93e5-d68f-5bf5-31f9043fb3ad@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16ebaffd-2291-4342-30d6-08d6fecd13b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-antispam-prvs: <DB3PR0402MB38987E89B608892C1ABC2128F5F80@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(2501003)(476003)(14444005)(74316002)(7416002)(11346002)(7736002)(256004)(66066001)(76116006)(229853002)(478600001)(68736007)(52536014)(2906002)(486006)(2201001)(33656002)(86362001)(66556008)(64756008)(66446008)(4744005)(66946007)(73956011)(446003)(44832011)(9686003)(76176011)(5660300002)(3846002)(102836004)(53936002)(8676002)(99286004)(7696005)(14454004)(6436002)(26005)(6506007)(4326008)(110136005)(25786009)(71190400001)(53546011)(316002)(6116002)(6246003)(305945005)(71200400001)(81156014)(66476007)(186003)(8936002)(55016002)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tb5hT/ZL3yOxxbTzKJVyxbsjZiH3xMFxnFx/ScIz41w1w1kWG3oxQoC7K7KLLdu+FlQ8BqbRNubfYpQtqsDDFfUzj3urWNJzj592+Q69b5UVXSDMiNtFKz+paN3xfaBd9ljznJE4qE+qj1aIv/47/4nzxveeuarWY627hUGDpKmSpKoNC1CAJ63L3o/eMGc6PgcdQpExB2Mdz2Abeww6XKjEUnA+EIyGUhz9xcf0LNr/iQ93u29XOhNw+dEXzXyGKSTTk/RUyWaATU16QsmXCqRPuoAMadbfm20L/XGXZ3TB3O1B6YAS4p01HrqIO/LBYCUgqgO2rYqWVo4yu85HZAtHtXOmdvs5DQ2PJ9w7u0zPUxR22msAEOFts5PKgiwTI15qnt5fGqbmg77HEpCpL44tlIB5d375AYNatH/LCho=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ebaffd-2291-4342-30d6-08d6fecd13b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 09:10:07.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IE9uIDAyLzA3LzIwMTkgMTE6MDMsIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+IEhpLCBEYW5pZWwNCj4gPg0KPiA+PiBIaSBBbnNvbiwNCj4gPj4NCj4gPj4gd2h5IGRpZCB5
b3UgcmVzZW5kIHRoZSBzZXJpZXM/DQo+ID4NCj4gPiBQcmV2aW91cyBwYXRjaCBzZXJpZXMgaGFz
IGJ1aWxkIHdhcm5pbmcgYW5kIEkgZGlkIE5PVCBub3RpY2UsIHNvcnJ5DQo+ID4gZm9yIHRoYXQs
DQo+ID4NCj4gPiBkcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW9mLmM6IEluIGZ1bmN0aW9uIOKA
mHRpbWVyX29mX2luaXTigJk6DQo+ID4gZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1vZi5jOjE4
NTozMDogd2FybmluZzogc3VnZ2VzdCBwYXJlbnRoZXNlcw0KPiBhcm91bmQgY29tcGFyaXNvbiBp
biBvcGVyYW5kIG9mIOKAmCbigJkgWy1XcGFyZW50aGVzZXNdDQo+ID4gICBpZiAodG8tPmZsYWdz
ICYgY2xvY2tfZmxhZ3MgPT0gY2xvY2tfZmxhZ3MpDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXg0KPiA+DQo+ID4gc28gSSByZXNlbmQgdGhlIHBhdGNoIHNlcmllcyB3aXRoIGJl
bG93LCBzb3JyeSBmb3IgbWlzc2luZyBtZW50aW9uIG9mIHRoZQ0KPiBjaGFuZ2VzIGluIHJlc2Vu
dCBwYXRjaCBzZXJpZXMuDQo+ID4NCj4gPiAgKwlpZiAoKHRvLT5mbGFncyAmIGNsb2NrX2ZsYWdz
KSA9PSBjbG9ja19mbGFncykNCj4gPg0KPiA+IFNvcnJ5IGZvciBtYWlsIHN0b3JtLi4uDQo+IA0K
PiBObyBwcm9ibGVtIGF0IGFsbCwgSSBwcmVmZXIgdGhpcyBjYXVnaHQgYW5kIGZpeGVkIGVhcmx5
IDopDQo+IA0KPiBOZXh0IHRpbWUganVzdCBzZW5kIGEgVjUgYmVjYXVzZSAncmVzZW5kJyBtZWFu
cyB0aGVyZSBpcyBubyBjaGFuZ2UgYnV0DQo+IHRoZXJlIHdhcyBhIHByb2JsZW0gd2l0aCB0aGUg
ZW1haWwgKGNvdWxkIGJlIGFsc28gaW50ZXJwcmV0ZWQgYXMgYSBnZW50bGUNCj4gcGluZykuDQoN
Ck9LLCB3aWxsIGtlZXAgaXQgaW4gbWluZCwgdGhhbmtzIGZvciBzaGFyaW5nIHVzZWZ1bCBleHBl
cmllbmNlIQ0KDQpUaGFua3MsDQpBbnNvbg0KDQo=
