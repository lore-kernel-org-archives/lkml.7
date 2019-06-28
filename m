Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012BCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1ABA2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F0oCbKl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfF1G73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:59:29 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:1265
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfF1G72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:59:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=DPg05ow4Cc4F+wX7Y9WRFgbq8bEVw+GAQdMN4c4mJUku4TNd7TLMToCICjYOSJURPSFywzuQLAknDuKVqSHM2i8R9Dwlz8RRxdUl3KeAu1xbIzQHrOVcGUcjtvx28u72M9iEiCBTHzRlZ1CJUda+iIcuMTiMq2SnjHqUhemqsng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng7sYhThv2TVOJv4+Z4iNZX0IpyCAVu3J1Is4KBaFUU=;
 b=cRACF9qVhDLeBGrSCJjTeJDLB9vb7SPuf2i27aONaiP+9YhazE+t663EjkMqbHQWXjtjgDpoTaZ2TGn2XGwoPjJg3zZg8bUOjNZsy+QgmwbviFmivIRJvIt9WENKQ+mMvB1GYcaCz0AL+pOkIcdKYVGxqS3PB7eXP2bCVoBbg2Y=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng7sYhThv2TVOJv4+Z4iNZX0IpyCAVu3J1Is4KBaFUU=;
 b=F0oCbKl5BJV2GA5i48N5I06EeeCeyQByoSuPmtFKqw+cK3wkYFRvPVk9fukT+dNe4+no62WHqNaXVEWj1C8Y3NkwGgYxEDypCkxXMfNdqwgF3F43lca5Xlh11zHrZDfq5qxy8mSpmLUhP4pR4uQoJNW948Ihyi3oEOX/VSeC1EM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 06:59:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 06:59:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mq: Correct OPP table according to
 latest datasheet
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mq: Correct OPP table according to
 latest datasheet
Thread-Index: AQHVLWLGC+RlanjcBUWXXhB78aHmNqawoHUw
Date:   Fri, 28 Jun 2019 06:59:22 +0000
Message-ID: <DB3PR0402MB39166309D463520DE5C129C8F5FC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190628032800.8428-1-Anson.Huang@nxp.com>
 <VI1PR04MB50553915C0D978A8019BDC5CEEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
 <DB3PR0402MB39161C60DC780B693933F9EAF5FC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <VI1PR04MB505542FB866BC18A27D22B90EEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB505542FB866BC18A27D22B90EEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a4362ab-3205-469b-deba-08d6fb962680
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3642;
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-microsoft-antispam-prvs: <DB3PR0402MB3642AD5B60D201655E0CD0AEF5FC0@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(13464003)(446003)(9686003)(73956011)(110136005)(54906003)(44832011)(66476007)(66446008)(11346002)(64756008)(76116006)(7416002)(53936002)(81156014)(8936002)(4326008)(3846002)(81166006)(25786009)(68736007)(6116002)(86362001)(476003)(486006)(478600001)(66556008)(26005)(8676002)(6436002)(229853002)(55016002)(53546011)(102836004)(6506007)(186003)(33656002)(2906002)(5660300002)(76176011)(71190400001)(71200400001)(52536014)(7696005)(66946007)(74316002)(2501003)(66066001)(256004)(7736002)(14444005)(6246003)(14454004)(316002)(99286004)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TnuAsgFIFQrnoJs+/442c3OXG5903S+a95/0C04fRs40fNySAOycJr75NkuoPbPwd7TIDcscFtWQh+XO2zkg4svHKZXva9Ff0m2pF05PqomoiNEnHGJ0oXlXu+drbktTce/uW69DxuO7pgUqKQo5Ob9kkDn1z64d3aTdqFoS/BCDO1JAorjd/4KVEF1o0Vvgy4sS65gJAOpO8XtagQ3Jy25B5IVQm1pOQq8lQJgvLaHMYn8GIrAHrIagjEjn018HH+opOMvwiGRZqqats0nV+FYQFg84DlahcDM9UJGRxj0zojcB0Kt7cMUZO1hIjPkgYRN8m3WJ38GjKtV+5aYTn/KJpwfo7T0h3ynShWHotwmZ5i+bzcGtGTnQYmRIVrQjgVGOuOWAfytmW2/sjZ+vsptnxdFSjPEkImvijE70ywQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4362ab-3205-469b-deba-08d6fb962680
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 06:59:22.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbmFyZCBDcmVzdGV6
DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyOCwgMjAxOSAyOjQ1IFBNDQo+IFRvOiBBbnNvbiBIdWFu
ZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47DQo+
IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgr
ZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiB2aXJl
c2gua3VtYXJAbGluYXJvLm9yZzsgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29t
PjsgQWJlbA0KPiBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT47IGFuZHJldy5zbWlybm92QGdtYWls
LmNvbTsNCj4gY2NhaW9uZUBiYXlsaWJyZS5jb207IGFuZ3VzQGFra2VhLmNhOyBhZ3hAc2lneGNw
dS5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1s
aW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0g
YXJtNjQ6IGR0czogaW14OG1xOiBDb3JyZWN0IE9QUCB0YWJsZSBhY2NvcmRpbmcgdG8NCj4gbGF0
ZXN0IGRhdGFzaGVldA0KPiANCj4gT24gNi8yOC8yMDE5IDk6MTYgQU0sIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+PiBGcm9tOiBMZW9uYXJkIENyZXN0ZXoNCj4gPj4+IEZyb206IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+Pj4NCj4gPj4+IEFjY29yZGluZyB0byBsYXRlc3Qg
ZGF0YXNoZWV0IChSZXYuMSwgMTAvMjAxOCkgZnJvbSBiZWxvdyBsaW5rcywgaW4NCj4gPj4+IHRo
ZSBjb25zdW1lciBkYXRhc2hlZXQsIDEuNUdIeiBpcyBtZW50aW9uZWQgYXMgaGlnaGVzdCBvcHAg
YnV0DQo+ID4+PiBkZXBlbmRzIG9uIHNwZWVkIGdyYWRpbmcgZnVzZSwgYW5kIGluIHRoZSBpbmR1
c3RyaWFsIGRhdGFzaGVldCwNCj4gPj4+IDEuM0dIeiBpcyBtZW50aW9uZWQgYXMgaGlnaGVzdCBv
cHAgYnV0IGRlcGVuZHMgb24gc3BlZWQgZ3JhZGluZw0KPiA+Pj4gZnVzZS4gMS41R0h6IGFuZCAx
LjNHSHogb3BwIHVzZSBzYW1lIHZvbHRhZ2UsIHNvIG5vIG5lZWQgZm9yDQo+ID4+PiBjb25zdW1l
ciBwYXJ0IHRvIHN1cHBvcnQgMS4zR0h6IG9wcCwgd2l0aCBzYW1lIHZvbHRhZ2UsIENQVSBzaG91
bGQNCj4gPj4+IHJ1biBhdCBoaWdoZXN0IGZyZXF1ZW5jeSBpbiBvcmRlciB0byBnbyBpbnRvIGlk
bGUgYXMgcXVpY2sgYXMgcG9zc2libGUsIHRoaXMNCj4gY2FuIHNhdmUgcG93ZXIuDQo+ID4+DQo+
ID4+IEkgbG9va2VkIGF0IHRoZSBzYW1lIGRhdGFzaGVldHMgYW5kIGl0J3Mgbm90IGNsZWFyIHRv
IG1lIHRoYXQgMS4zIEdoeg0KPiA+PiBzaG91bGQgYmUgZGlzYWxsb3dlZCBmb3IgY29uc3VtZXIg
cGFydHMuIFBvd2VyIGNvbnN1bXB0aW9uIGluY3JlYXNlcw0KPiA+PiB3aXRoIGJvdGggdm9sdGFn
ZSBhbmQgZnJlcXVlbmN5IHNvIGhhdmluZyB0d28gT1BQcyB3aXRoIHNhbWUgdm9sdGFnZQ0KPiA+
PiBkb2VzIG1ha2Ugc2Vuc2UuDQo+ID4NCj4gPiBUaGUgY29uc3VtZXIgcGFydCBkYXRhc2hlZXQg
ZG9lcyBOT1QgbWVudGlvbiAxLjNHSHogYXQgYWxsLCBzbw0KPiA+IGNvbnN1bWVyIHBhcnQgT05M
WSBzdXBwb3J0IDFHSHovMS41R0h6LCBhbmQgaW5kdXN0cmlhbCBwYXJ0IE9OTFkNCj4gPiBzdXBw
b3J0IDgwME1Iei8xLjNHSHosIHRoaXMgaXMgd2hhdCB3ZSBkaWQgaW4gb3VyIGludGVybmFsIHRy
ZWUgYW5kDQo+ID4gTlBJIHJlbGVhc2UsIHNvIGJldHRlciB0byBtYWtlIHRoZW0gYWxpZ25lZCwg
b3RoZXJ3aXNlLCB3ZSBoYXZlIHRvIGNoYW5nZQ0KPiBpdCB3aGVuIGtlcm5lbCB1cGdyYWRlLg0K
PiANCj4gRGF0YXNoZWV0IHNlZW1zIGFtYmlndW91czogaXQgbWVudGlvbnMgIm1heCBmcmVxIGZv
ciB2b2x0IiBzbyBteQ0KPiB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgYW55IGxvd2VyIGZyZXFzIHNo
b3VsZCBhbHNvIHdvcmsgYXQgdGhhdCB2b2x0YWdlLg0KPiANCj4gVGhpcyBhbHNvIHNlZW1zIHRv
IGJlIHRoZSB1bmRlcnN0YW5kaW5nIGJlaGluZCBjb21taXQgOGNmZDgxM2M3MzA3DQo+ICgiYXJt
NjQ6IGR0czogaW14OG1xOiBmaXggaGlnaGVyIENQVSBvcGVyYXRpbmcgcG9pbnQiKSBieSBMdWNh
cy4gDQo+IA0KPiBPbiBkYXRhc2hlZXQgcGFnZSA3IGl0IG1lbnRpb25zIHRoYXQgcHJvZHVjdCBj
b2RlIGNhbiBoYXZlICJKWiIgb3IgIkhaIg0KPiBmb3IgMS4zR2h6IG9yIDEuNUdoei4gQXJlIHlv
dSBzYXlpbmcgdGhhdCBvbmx5IGluZHVzdHJpYWwgcGFydHMgY2FuIGJlICJKWiI/DQoNCklmIHRh
a2UgYSBsb29rIGF0IHBhZ2UgNiB0YWJsZTIsIGluZHVzdHJpYWwgZGF0YXNoZWV0IE9OTFkgaGFz
ICJIWiIsIGFuZCBjb25zdW1lcg0KRGF0YXNoZWV0IE9OTFkgaGFzICJKWiIuIEFuZCB5ZXMsIHRo
YXQgaXMgbXkgdW5kZXJzdGFuZGluZy4NCg0KQW5kIGNvbnNpZGVyaW5nIG91ciBydWxlLCBJIGRv
bid0IHRoaW5rIGlzIGJlbmVmaXQgZm9yIGNvbnN1bWVyIHBhcnQgdG8gcnVuIDEuM0dIei4NCg0K
PiANCj4gPj4+ICAgIAkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8MTUwMDAwMDAwMD47DQo+ID4+PiAg
ICAJCQlvcHAtbWljcm92b2x0ID0gPDEwMDAwMDA+Ow0KPiA+Pj4gICAgCQkJLyogQ29uc3VtZXIg
b25seSBidXQgcmVseSBvbiBzcGVlZCBncmFkaW5nICovDQo+ID4+PiAtCQkJb3BwLXN1cHBvcnRl
ZC1odyA9IDwweDg+LCA8MHg3PjsNCj4gPj4+ICsJCQlvcHAtc3VwcG9ydGVkLWh3ID0gPDB4OD4s
IDwweDM+Ow0KPiA+Pg0KPiA+PiBJZiB5b3UgZG9uJ3Qgd2FudCB0byByZWx5IG9uIHRoZSBmYWN0
IHRoYXQgb25seSBjb25zdW1lciBwYXJ0cyBzaG91bGQNCj4gPj4gYmUgZnVzZWQgZm9yIDEuNSBH
aHogdGhlbiBwbGVhc2UgZGVsZXRlIHRoZSBjb21tZW50Lg0KPiA+DQo+ID4gRG9uJ3QgcXVpdGUg
dW5kZXJzdGFuZCwgMS41R0h6IGlzIGluZGVlZCBjb25zdW1lciBPTkxZLCBidXQgaWYgdGhlDQo+
ID4gY29uc3VtZXIgcGFydCBpcyBmdXNlZCB0byAxR0h6LCB0aGVuIDEuNUdIeiBpcyBhbHNvIE5P
VCBhdmFpbGFibGUsIHNvDQo+ID4gaXQgYWxzbyByZWx5IG9uIHNwZWVkIGdyYWRpbmcuIFNvIGtl
ZXAgdGhlIGNvbW1lbnQgdGhlcmUgaXMgT0s/DQo+IA0KPiBXaGF0IEkgbWVhbnQgd2l0aCB0aGF0
IGNvbW1lbnQgaXMgdGhhdCAxLjVHaHogaXMgb25seSBtZW50aW9uZWQgZm9yDQo+IGNvbnN1bWVy
IHBhcnRzIGJ1dCBpbnN0ZWFkIG9mIGV4cGxpY2l0bHkgYmFubmluZyBpdCBvbiBpbmR1c3RyaWFs
IHBhcnRzIHdlIHJlbHkNCj4gb24gTUZHIG5ldmVyIGZ1c2luZyBpbmR1c3RyaWFsIHBhcnRzIGZv
ciAxLjVHaHouDQo+IA0KPiBOb3cgeW91J3JlIGV4cGxpY2l0bHkgYmFubmluZyBpdCBvbiBpbmR1
c3RyaWFsIHBhcnRzLg0KDQpZZXMsIGluZHVzdHJpYWwgcGFydHMgbmV2ZXIgc3VwcG9ydCB1cCB0
byAxLjVHSHosIHNvIGV4cGxpY2l0bHkgYmFubmluZyBpdCBpcyBqdXN0IE9LLg0KVGhlIHNwZWVk
IGdyYWRpbmcgZnVzZSBhbmQgbWFya2V0IHNlZ21lbnQgZnVzZSBhcmUgYWN0dWFsbHkgaGFzIHNv
bWUgb3ZlcmxhcCwNCndlIGJldHRlciB0byBpbXBsZW1lbnQgYm90aCBvZiB0aGVtLg0KDQo+IA0K
PiBUaGlzIGNvbW1lbnQgaXMgaW5kZWVkIGNvbmZ1c2luZyBzbyBiZXR0ZXIgdG8ganVzdCByZW1v
dmUgYWxsIGluc3RhbmNlcy4NCg0KSSBhZ3JlZSB0byByZW1vdmUgdGhvc2UgY29tbWVudHMsIG5v
IG5lZWQgdG8gbGV0IGl0IGludHJvZHVjZSBhbnkgY29uZnVzaW9uLg0KDQpBbnNvbi4NCg==
