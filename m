Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09719C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FAB2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AsWqpEmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfC2JLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:11:49 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:23193
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728703AbfC2JLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc/n0GuLrdWZhk0N0DmbO4QqkobKHMH4yWsTNOuqvw4=;
 b=AsWqpEmG15CtKdM9E6JZ7/ELOEhZdD7jH/djDPzx3bTWDXVsAAYrszr5AdsuieRMDeXYct2EBmFJjT7/bAkQA9hLI93VkdPv9ylU2tnCYcmDMlvwtAOXAtt4iyBhMvkAj2gM88Wm+jZlGVvT/yEGbizoVVE487TS9J2dfYPn59E=
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com (52.133.21.156) by
 AM6PR0402MB3591.eurprd04.prod.outlook.com (52.133.20.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Fri, 29 Mar 2019 09:11:39 +0000
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::3c73:ade7:32ad:3d99]) by AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::3c73:ade7:32ad:3d99%3]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 09:11:39 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Mircea Pop <mircea.pop@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Jun Li <jun.li@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Zening Wang <zening.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Leo Zhang <leo.zhang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: RE: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Thread-Topic: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Thread-Index: AQHU5J/uL6RBBX3AA0GxPKCBIrMc4KYfnrmAgAADs4CAAAJMgIAADy+AgAAUXQCAAR4xkIABbl6A
Date:   Fri, 29 Mar 2019 09:11:39 +0000
Message-ID: <AM6PR0402MB3573FF77D228F9F14BC54A9A8C5A0@AM6PR0402MB3573.eurprd04.prod.outlook.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
 <0ac4b527-2f79-4d21-7408-18c87cadb512@arm.com>
 <AM0PR04MB4211216AA60055524D1F46FC80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211216AA60055524D1F46FC80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82c8e031-79ab-4117-fc70-08d6b4268d77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3591;
x-ms-traffictypediagnostic: AM6PR0402MB3591:
x-microsoft-antispam-prvs: <AM6PR0402MB35917ED240F42377E56A0F638C5A0@AM6PR0402MB3591.eurprd04.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(13464003)(14454004)(478600001)(316002)(186003)(6636002)(476003)(52536014)(7416002)(110136005)(229853002)(446003)(54906003)(81156014)(81166006)(71190400001)(486006)(71200400001)(8676002)(2501003)(74316002)(305945005)(26005)(68736007)(33656002)(5660300002)(9686003)(3846002)(2906002)(7736002)(93886005)(6116002)(6246003)(7696005)(4326008)(99286004)(6506007)(53546011)(25786009)(256004)(106356001)(53936002)(14444005)(86362001)(11346002)(102836004)(6436002)(66066001)(8936002)(105586002)(97736004)(55016002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3591;H:AM6PR0402MB3573.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZJkxTBnzcxB3Nz9pdMc52pP8ryBQTpclFk39hGUCVZ8DHcICtSlsLIx6XCVqAdtsFQ6sn2fiT4GX1n8MCi3SdbuTpm89AHAE+4Zp/CWRzJsm9hjQ59AA2k8agEepJc3RWIMfuLBNX1flXxIeRaSjszW4Fh3qqoW7VyqNN7VU0+Ih9skHXdYNERAPMJ3XFzJUOud45bEegVWQg6okz8TmwM3WTddt2q2hB3hS3I7slIOWEOe/WLeki3bJteFTfpLyVaaqvSsrDf9JQEMwz7KQuANvshxn8w+iFFhVXAXnRgf6MKCWfEPhucHtpXXIQcdMMIOAey0SN6kSDM7uEklKsgnTNMtDLgwP3/5Sn0QLPmdRIvC0FOBS14WtnFiNjBzDygZ4ZRch5zYioyacsA88EicOOK0SvPvjf6M2L8V7tIA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c8e031-79ab-4117-fc70-08d6b4268d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 09:11:39.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3591
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+
IFNlbnQ6IDIwMTnlubQz5pyIMjjml6UgMTk6MjENCj4gVG86IE1hcmMgWnluZ2llciA8bWFyYy56
eW5naWVyQGFybS5jb20+OyBMZW9uYXJkIENyZXN0ZXoNCj4gPGxlb25hcmQuY3Jlc3RlekBueHAu
Y29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgUmljaGFyZCBaaHUNCj4gPGhvbmd4aW5nLnpo
dUBueHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPg0KPiBDYzogRmFiaW8gRXN0
ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgQ29zbWluIFNhbW9pbGENCj4gPGNvc21pbi5z
YW1vaWxhQG54cC5jb20+OyBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyBNaXJjZWEg
UG9wDQo+IDxtaXJjZWEucG9wQG54cC5jb20+OyBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRh
QG54cC5jb20+Ow0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9y
ZzsgUm9iZXJ0IENoaXJhcw0KPiA8cm9iZXJ0LmNoaXJhc0BueHAuY29tPjsgQW5zb24gSHVhbmcg
PGFuc29uLmh1YW5nQG54cC5jb20+OyBKdW4gTGkNCj4gPGp1bi5saUBueHAuY29tPjsgQWJlbCBW
ZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT47IHJvYmhAa2VybmVsLm9yZzsNCj4gWmVuaW5nIFdhbmcg
PHplbmluZy53YW5nQG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsN
Cj4gQk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPjsgSG9yaWEgR2VhbnRhDQo+IDxob3Jp
YS5nZWFudGFAbnhwLmNvbT47IFBldGVyIENoZW4gPHBldGVyLmNoZW5AbnhwLmNvbT47IEpvYWtp
bSBaaGFuZw0KPiA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyByandAcmp3eXNvY2tpLm5ldDsg
TGVvIFpoYW5nDQo+IDxsZW8uemhhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53
YW5nQG54cC5jb20+Ow0KPiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgUmFuamFuaQ0KPiBWYWlkeWFuYXRoYW4gPHJhbmphbmku
dmFpZHlhbmF0aGFuQG54cC5jb20+OyBIYW4gWHUgPGhhbi54dUBueHAuY29tPjsNCj4gd2lsbC5k
ZWFjb25AYXJtLmNvbTsgSXVsaWFuYSBQcm9kYW4gPGl1bGlhbmEucHJvZGFuQG54cC5jb20+Ow0K
PiBzdWRlZXAuaG9sbGFAYXJtLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IFBlbmcgRmFu
DQo+IDxwZW5nLmZhbkBueHAuY29tPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBWaW9yZWwgU3Vt
YW4NCj4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0KPiBTdWJqZWN0OiBSRTogW1JGQyAwLzddIGNw
dWlkbGU6IEFkZCBwb2tpbmcgbWVjaGFuaXNtIHRvIHN1cHBvcnQgbm9uLUlQSQ0KPiB3YWtldXAN
Cj4gDQo+ID4gRnJvbTogTWFyYyBaeW5naWVyIFttYWlsdG86bWFyYy56eW5naWVyQGFybS5jb21d
DQo+ID4gU2VudDogVGh1cnNkYXksIE1hcmNoIDI4LCAyMDE5IDI6MTMgQU0gT24gMjcvMDMvMjAx
OSAxNzowMCwgTGVvbmFyZA0KPiA+IENyZXN0ZXogd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMTkt
MDMtMjcgYXQgMTc6MDYgKzAxMDAsIEx1Y2FzIFN0YWNoIHdyb3RlOg0KPiA+ID4+IEFtIE1pdHR3
b2NoLCBkZW4gMjcuMDMuMjAxOSwgMTU6NTcgKzAwMDAgc2NocmllYiBNYXJjIFp5bmdpZXI6DQo+
ID4gPj4+IE9uIDI3LzAzLzIwMTkgMTU6NDQsIEx1Y2FzIFN0YWNoIHdyb3RlOg0KPiA+ID4+Pj4g
QW0gTWl0dHdvY2gsIGRlbiAyNy4wMy4yMDE5LCAxMzoyMSArMDAwMCBzY2hyaWViIEFiZWwgVmVz
YToNCj4gPiA+Pj4+PiBUaGlzIHdvcmsgaXMgYSB3b3JrYXJvdW5kIEknbSBsb29raW5nIGludG8g
KG1vcmUgYXMgYSBiYWNrZ3JvdW5kDQo+ID4gPj4+Pj4gdGFzaykgaW4gb3JkZXIgdG8gYWRkIHN1
cHBvcnQgZm9yIGNwdWlkbGUgb24gaS5NWDhNUSBiYXNlZA0KPiBwbGF0Zm9ybXMuDQo+ID4gPj4+
Pj4NCj4gPiA+Pj4+PiBUaGUgbWFpbiBpZGVhIGhlcmUgaXMgZ2V0dGluZyBhcm91bmQgdGhlIG1p
c3NpbmcgR0lDDQo+ID4gPj4+Pj4gd2FrZV9yZXF1ZXN0IHNpZ25hbCAoZHVlIHRvIGludGVncmF0
aW9uIGRlc2lnbiBpc3N1ZSkgYnkgd2FraW5nDQo+ID4gPj4+Pj4gdXAgYSBlYWNoIGluZGl2aWR1
YWwgY29yZSB0aHJvdWdoIHNvbWUgZGVkaWNhdGVkIFNXIHBvd2VyLXVwDQo+ID4gPj4+Pj4gYml0
cyBpbnNpZGUgdGhlIHBvd2VyIGNvbnRyb2xsZXIgKEdQQykgcmlnaHQgYmVmb3JlIGV2ZXJ5IElQ
SSBpcw0KPiA+ID4+Pj4+IHJlcXVlc3RlZCBmb3IgdGhhdCBlYWNoDQo+ID4gaW5kaXZpZHVhbCBj
b3JlLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IEp1c3QgYSBnZW5lcmFsIGNvbW1lbnQsIHdpdGhvdXQg
Z29pbmcgaW50byB0aGUgZGV0YWlscyBvZiB0aGlzIHNlcmllczoNCj4gPiA+Pj4+IHRoaXMgaXNz
dWUgaXMgbm90IG9ubHkgYWZmZWN0aW5nIElQSXMsIGJ1dCBhbHNvIE1TSXMgdGVybWluYXRlZA0K
PiA+ID4+Pj4gYXQgdGhlIEdJQy4gQ3VycmVudGx5IE1TSXMgYXJlIHRlcm1pbmF0ZWQgYXQgdGhl
IFBDSWUgY29yZSwgYnV0DQo+ID4gPj4+PiB0ZXJtaW5hdGluZyB0aGVtIGF0IHRoZSBHSUMgaXMg
Y2xlYXJseSBwcmVmZXJhYmxlLCBhcyB0aGlzIGFsbG93cw0KPiA+ID4+Pj4gYXNzaWduaW5nIENQ
VSBhZmZpbml0eSB0byBpbmRpdmlkdWFsIE1TSXMgYW5kIGxvd2VycyBJUlEgc2VydmljZQ0KPiBv
dmVyaGVhZC4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBJJ20gbm90IHN1cmUgd2hhdCB0aGUgY29uc2Vx
dWVuY2VzIGFyZSBmb3IgdXBzdHJlYW0gTGludXggc3VwcG9ydA0KPiA+ID4+Pj4geWV0LCBidXQg
d2Ugc2hvdWxkIGtlZXAgaW4gbWluZCB0aGF0IGhhdmluZyBhIHdvcmthcm91bmQgZm9yIElQSXMN
Cj4gPiA+Pj4+IGlzIG9ubHkgc29sdmluZyBwYXJ0IG9mIHRoZSBpc3N1ZS4NCj4gPiA+Pj4NCj4g
PiA+Pj4gSWYgdGhpcyBlcnJhdHVtIGlzIGFmZmVjdGluZyBtb3JlIHRoYW4ganVzdCBJUElzLCB0
aGVuIGluZGVlZCBJDQo+ID4gPj4+IGRvbid0IHNlZSBob3cgdGhpcyBwYXRjaCBzZXJpZXMgc29s
dmVzIGFueXRoaW5nLg0KPiA+ID4+Pg0KPiA+ID4+PiBCdXQgdGhlIGVycmF0dW0gZG9jdW1lbnRh
dGlvbiBzZWVtcyB0byBpbXBseSB0aGF0IG9ubHkgU0dJcyBhcmUNCj4gPiA+Pj4gYWZmZWN0ZWQs
IGFuZCBnb2VzIGFzIGZhciBhcyBzdWdnZXN0aW5nIHRvIHVzZSBhbiBleHRlcm5hbA0KPiA+ID4+
PiBpbnRlcnJ1cHQgd291bGQgc29sdmUgaXQuIEhvdyBjb21lcyB0aGlzIGlzIG5vdCB0aGUgY2Fz
ZT8gT3IgaXMgaXQNCj4gPiA+Pj4gdGhhdCBhbnl0aGluZyBkaXJlY3RseSByb3V0ZWQgdG8gYSBy
ZWRpc3RyaWJ1dG9yIGlzIGFsc28gYWZmZWN0ZWQ/DQo+ID4gPj4+IFRoaXMgd291bGQgYnJlYWsg
TFBJcyAoYW5kIHRodXMgTVNJcykgYW5kIFBQSXMgKHRoZSBDUFUgdGltZXIsIGFtb25nDQo+IG90
aGVycykuDQo+ID4gPj4+DQo+ID4gPj4+IFdoYXQgaXMgdGhlICpleGFjdCogc3RhdHVzIG9mIHRo
aXMgdGhpbmc/IEkgaGF2ZSB0aGUgdWdseSBmZWVsaW5nDQo+ID4gPj4+IHRoYXQgdGhlIHRydWUg
d29ya2Fyb3VuZCBpcyBqdXN0IHRvIGRpc2FibGUgY3B1aWRsZS4NCj4gPiA+Pg0KPiA+ID4+IEFz
IGZhciBhcyBJIHVuZGVyc3RhbmQgdGhlIGVycmF0dW0sIHRoZSBiYXNpYyBpc3N1ZSBpcyB0aGF0
IHRoZSBHSUMNCj4gPiA+PiB3YWtlX3JlcXVlc3Qgc2lnbmFscyBhcmUgbm90IGNvbm5lY3RlZCB0
byB0aGUgR1BDICh0aGUNCj4gPiA+PiBDUFUvcGVyaXBoZXJhbCBwb3dlciBzZXF1ZW5jZXIpLiBU
aGUgU1BJcyBhcmUgcm91dGVkIHRocm91Z2ggdGhlDQo+ID4gPj4gR1BDIGFuZCB0aHVzIGFyZSB2
aXNpYmxlIGFzIHdha2V1cCBzb3VyY2VzLCB3aGljaCBpcyB3aHkgdGhlDQo+ID4gPj4gd29ya2Fy
b3VuZCBvZiB1c2luZyBhbiBleHRlcm5hbCBTUEkgYXMgd2FrZXVwIHRyaWdnZXIgZm9yIHRoZSBJ
UEkgd29ya3MuDQo+ID4gPg0KPiA+ID4gV2UgaGFkIGEga2VybmVsIHdvcmthcm91bmQgZm9yIElQ
SXMgaW4gb3VyIGludGVybmFsIHRyZWUgZm9yIGEgbG9uZw0KPiA+ID4gdGltZSBhbmQgSSBkb24n
dCB0aGluayB3ZSBkbyBhbnl0aGluZyBzcGVjaWFsIGZvciBQQ0kuIERvZXMgUENJIE1TSQ0KPiA+
ID4gcmVhbGx5IGJ5cGFzcyB0aGUgR1BDIG9uIDhtcT8NCj4gPg0KPiA+IElmIHlvdSBoYXZlIGFu
IElUUywgY2VydGFpbmx5LiBJZiB5b3UgZG9uJ3QsIGl0IGRlcGVuZHMuIE1TSXMgY2FuIGhpdA0K
PiA+IHRoZSBkaXN0cmlidXRvcidzIE1CSSByZWdpc3RlcnMgYW5kIGdlbmVyYXRlIG5vbi13aXJl
ZCBTUElzLCB3aGljaCBJDQo+ID4gYXNzdW1lIHdpbGwgYnlwYXNzIHRoZSBHUEMgYWx0b2dldGhl
ci4NCj4gPg0KPiANCj4gUmljaGFyZCAmIEphY2t5LA0KPiANCj4gQ2FuIHlvdSBkb3VibGUgY2hl
Y2sgaWYgdGhpcyBpc3N1ZSBhZmZlY3QgUENJIE1TSSBmdW5jdGlvbj8NCj4gDQpbUmljaGFyZCBa
aHVdIEdJQyBWMyBoYXMgdGhlIElUUy9MUElzIGZlYXR1cmVzLiBUaGF0IGNhbiBiZSB1c2VkIGJ5
IFBDSWUgTVNJIGZ1bmN0aW9ucy4NCkJUVywgdGhlIFBDSWUgTVNJIElUUyBtb2RlIGlzIG5vdCBl
bmFibGVkIGluIHZlbmRvciB0cmVlLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4g
UmVnYXJkcw0KPiBEb25nIEFpc2hlbmcNCj4gDQo+ID4gPiBBZGRpbmcgUmljaGFyZC9KYWNreSwg
dGhleSBtaWdodCBrbm93IGFib3V0IHRoaXMuDQo+ID4gPg0KPiA+ID4gVGhpcyBzZWVtcyBsaWtl
IHNvbWV0aGluZyBvZiBhIGNvcm5lciBjYXNlIHRvIG1lLCBkb24ndCBtYW55IGlteA0KPiA+ID4g
Ym9hcmRzIHNoaXAgd2l0aG91dCBQQ0k7IGVzcGVjaWFsbHkgZm9yIGxvdy1wb3dlciBzY2VuYXJp
b3M/IElmDQo+ID4gPiByZXF1aXJlZCBpdCBtaWdodCBiZSByZWFzb25hYmxlIHRvIGFkZCBhbiBh
ZGRpdGlvbmFsIHdvcmthcm91bmQgdG8NCj4gPiA+IGRpc2FibGUgYWxsIGNwdWlkbGUgaWYgcGNp
IG1zaXMgYXJlIHVzZWQuDQo+ID4NCj4gPiBFc3RhYmxpc2hpbmcgYSBsaW5rIGJldHdlZW4gY3B1
aWRsZSBhbmQgUENJIGluIHRoZSBrZXJuZWwgd291bGQgYmUNCj4gPiBwcmV0dHkgaW52YXNpdmUs
IGFuZCB0aGF0IHdvdWxkIGNvbWUgb24gdG9wIG9mIHdoYXQgdGhpcyBzZXJpZXMgYWxzbw0KPiBt
YW5kYXRlcy4NCj4gPg0KPiA+IEF0IHRoYXQgbGV2ZWwgb2YgYXBwYXJlbnQgYnJva2VubmVzcywg
aXQgaXMgZmFyIHNhZmVyIHRvIGdldCBjcHVpZGxlDQo+ID4gb3V0IG9mIHRoZSBwaWN0dXJlIGFs
dG9nZXRoZXIsIGFuZCBJJ2QgcmF0aGVyIHNlZSB0aGVzZSBwYXRjaGVzIGluIGEgdmVuZG9yDQo+
IHRyZWUgKGZvciBvbmNlKS4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPg0KPiA+IAlNLg0KPiA+IC0t
DQo+ID4gSmF6eiBpcyBub3QgZGVhZC4gSXQganVzdCBzbWVsbHMgZnVubnkuLi4NCg==
