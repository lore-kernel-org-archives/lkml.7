Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F0CC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACBC208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="S8QhF5Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfLKN2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:28:44 -0500
Received: from mail-eopbgr80104.outbound.protection.outlook.com ([40.107.8.104]:27150
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727477AbfLKN2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:28:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzO70vcgwCF41Eb3KWf/e7vjCkskQ4V4PzFc9+iIQOjolnaCGPCeGzGASYe87cQxFy7PkdlPWw6+1etuJZjL9f8wAG6a7USci+ESKAXdw4XIas/v+EZOIHxGe3N5EtqedH8Mr4y380lT/hDwsKESJMXazm3Jaw26Fnbib1ghOgQv9vXAHq63l4rOpjPAlD8wdZtmd+IHuvytaz8HLJ+Hr/Yl1LeJDnM64Etge0gEi6OtK2acX+OIQmW6z/tJM1l6IJD2Zeh+MQcF4HbFkYnF9psdwpFJWRrrxiHCE9Srzf9IlL16tIm4Utd/gmwrOb8+wpfdMkTObvMPRehgSsRuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fobG7iXK3Vnr71c7kmaI6NzpYuDTJLkcz2urF3IzLjU=;
 b=WqwnreWWlQnrBJeKZqJRtBaNwx82XQv9HB/RqLk7DjplD7XZ8SSGcV+0lIux4KbnKkZvlqdY1H7MAYyGVSaKGgqyJGyvJTFdO9HQcA4hHtqNnvgMCFoSP+zdHUOae6GWGDZ7eOy8oNS4kLYkNJdRvNoKxE5bBfkDH5YK/buhBjX7kpBzPf9/bK8yFkoqyQuMU5+19zAHUPoRB94BHYgeLSu5fdu5/+YZK4EyuEdvl0LlATu9xpuPFoa2h/GOltOE4bipcPni5i3xvBByEzgj0Kd1T7iYPAMLJSsY7Pfxggj4HSeSuQBpYc/1QlfAZviCWiq1KLz1iXFLWNpXmm5/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fobG7iXK3Vnr71c7kmaI6NzpYuDTJLkcz2urF3IzLjU=;
 b=S8QhF5CyTKNL9pfss6+YfhH/j+aARhqqsvWsQq1hQx+SRZ+fK/UANdiwzHqVH+bCeUCr/PeISCpvXfS8G1VPpWBPLsRi3MFQ7dym7vTMze6jESlUZBt20szUvl2Nxt47KoHG2Rwr68XehEG70SFSybyzP4e1yCxtzQqZp1Vzreg=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3451.eurprd02.prod.outlook.com (52.134.72.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 13:28:24 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::446e:c4f8:7e59:1c6d]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::446e:c4f8:7e59:1c6d%7]) with mapi id 15.20.2516.019; Wed, 11 Dec 2019
 13:28:24 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Topic: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Index: AQHVr11DyxIz9S+dLEWyrkArJlSyg6ezeYGA///8moCAADjaAIABIyyAgAAc2oA=
Date:   Wed, 11 Dec 2019 13:28:24 +0000
Message-ID: <b5ea01da-5345-05cf-9f89-b7123dbbb893@axentia.se>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-5-git-send-email-claudiu.beznea@microchip.com>
 <4c3ffc48-7aa5-1e48-b0e9-a50c4eea7c38@axentia.se>
 <5fbad2cd-0dbe-0be5-833a-f7a612d48012@microchip.com>
 <2272669c-38ee-1928-9563-46755574897c@axentia.se>
 <167cb87e-b189-71fd-0a79-adf89336d1f3@microchip.com>
In-Reply-To: <167cb87e-b189-71fd-0a79-adf89336d1f3@microchip.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0285.eurprd05.prod.outlook.com
 (2603:10a6:7:93::16) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10076e51-e796-4c5e-18c8-08d77e3dff8a
x-ms-traffictypediagnostic: DB3PR0202MB3451:
x-microsoft-antispam-prvs: <DB3PR0202MB34519BCF7196AC79E6F700C9BC5A0@DB3PR0202MB3451.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39830400003)(376002)(199004)(189003)(7416002)(81166006)(81156014)(6486002)(66446008)(64756008)(6512007)(66946007)(4001150100001)(31686004)(66476007)(66556008)(8676002)(5660300002)(2906002)(186003)(2616005)(36756003)(8936002)(6506007)(71200400001)(52116002)(110136005)(54906003)(316002)(86362001)(53546011)(26005)(31696002)(4326008)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3451;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1DeSgWEvYFuSFysNUIoAfzx9XIYylvJD9zTflE7YSxgU5G+gJhapKXqSdzZXnzfTswxlDfF9Lh5eQaS2jCDNZsWygZygVpe7WzU0BdlApl3V2+KB+qddD6Q9u9FzBuQDALn/0PEogtVy0SiTz0PQNAsGLgvmHigCt9lPz3RTtvuO8YRMXfUyrFyvqonwI0fUgipr5DHdc15Rin8v1XxOf0rik1oQk495OXlXd5pB7kB5DeUMDWp8kAlwkhW/ejXpPUCYTP5MTwcHp+KOhr7ZvSFYuQNWRNvtymv5LGlbZ9IlCJqen4pchUsEjLR4ckrnc4Uphuq2uu2/P4yK7ik9mXvysAuoqWnUwPvIg99b8IsPkJwwKIMcGmshZ9kNwSkDCVQQxrikPaU85LzY4+2fz1sTlHACtFcAHyGlDN2jnL1RX9IZnPx4Fq/fP/rfJ31S
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA23D3E9801C6479DB9954F58F85094@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 10076e51-e796-4c5e-18c8-08d77e3dff8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 13:28:24.3048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sk7yPS9LhC1PGTHv8YujCt8ZuUvCQEegprgQ65677S4Nb4s6Z9uc/DdZyYHcMaR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMi0xMSAxMjo0NSwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4gDQo+IA0KPiBPbiAxMC4xMi4yMDE5IDE5OjIyLCBQZXRlciBSb3NpbiB3cm90ZToNCj4+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4NCj4+IE9uIDIwMTktMTItMTAgMTU6
NTksIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9u
IDEwLjEyLjIwMTkgMTY6MTEsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4+PiBPbiAyMDE5LTEyLTEw
IDE0OjI0LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+Pj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQg
ZjZmN2FkMzIzNDYxM2Y2ZjdmMjdjMjUwMzZhYWYwNzhkZTA3ZTliMC4NCj4+Pj4+ICgiZHJtL2F0
bWVsLWhsY2RjOiBhbGxvdyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwtY2xvY2sgdGhhbiByZXF1
ZXN0ZWQiKQ0KPj4+Pj4gYmVjYXVzZSBhbGxvd2luZyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwg
Y2xvY2sgbWF5IG92ZXJjbG9jaw0KPj4+Pj4gTENEIGRldmljZXMsIG5vdCBhbGwgb2YgdGhlbSBi
ZWluZyBjYXBhYmxlIG9mIHRoaXMuDQo+Pj4+DQo+Pj4+IFdpdGhvdXQgdGhpcyBwYXRjaCwgdGhl
cmUgYXJlIHBhbmVscyB0aGF0IGFyZSAqc2V2ZXJseSogdW5kZXJjbG9ja2VkIChvbiB0aGUNCj4+
Pj4gbWFnbml0dWRlIG9mIDQwTUh6IGluc3RlYWQgb2YgNjVNSHogb3Igc29tZXRoaW5nIGxpa2Ug
dGhhdCwgSSBkb24ndCByZW1lbWJlcg0KPj4+PiB0aGUgZXhhY3QgZmlndXJlcykuDQo+Pj4NCj4+
PiBXaXRoIHBhdGNoIHRoYXQgc3dpdGNoZXMgYnkgZGVmYXVsdCB0byAyeHN5c3RlbSBjbG9jayBm
b3IgcGl4ZWwgY2xvY2ssIGlmDQo+Pj4gdXNpbmcgMTMzTUh6IHN5c3RlbSBjbG9jayAoYXMgeW91
IHNwZWNpZmllZCBpbiB0aGUgcGF0Y2ggSSBwcm9wb3NlZCBmb3INCj4+PiByZXZlcnQgaGVyZSkg
dGhhdCB3b3VsZCBnbywgd2l0aG91dCB0aGlzIHBhdGNoIGF0IDUzTUh6IGlmIDY1TUh6IGlzDQo+
Pj4gcmVxdWVzdGVkLiBDb3JyZWN0IG1lIGlmIEknbSB3cm9uZy4NCj4+DQo+PiBJdCBtaWdodCBo
YXZlIGJlZW4gNTNNSHosIHdoYXRldmVyIGl0IHdhcyBpdCB3YXMgdG9vIGxvdyBmb3IgdGhpbmdz
IHRvIHdvcmsuDQo+Pg0KPj4+PiBBbmQgdGhleSBhcmUgb2YgY291cnNlIG5vdCBjYXBhYmxlIG9m
IHRoYXQuIEFsbCBwYW5lbHMNCj4+Pj4gaGF2ZSAqc29tZSogc2xhY2sgYXMgdG8gd2hhdCBmcmVx
dWVuY2llcyBhcmUgc3VwcG9ydGVkLCBhbmQgdGhlIHBhdGNoIHdhcw0KPj4+PiB3cml0dGVuIHVu
ZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHByZWZlcnJlZCBmcmVxdWVuY3kgb2YgdGhlIHBh
bmVsIHdhcw0KPj4+PiByZXF1ZXN0ZWQsIHdoaWNoIHNob3VsZCBsZWF2ZSBhdCBsZWFzdCBhICps
aXR0bGUqIGhlYWRyb29tLg0KPj4+DQo+Pj4gSSBzZWUsIGJ1dCBmcm9tIG15IHBvaW50IG9mIHZp
ZXcsIHRoZSB1cHBlciBsYXllcnMgc2hvdWxkIGRlY2lkZSB3aGF0DQo+Pj4gZnJlcXVlbmN5IHNl
dHRpbmdzIHNob3VsZCBiZSBkb25lIG9uIHRoZSBMQ0QgY29udHJvbGxlciBhbmQgbm90IGxldCB0
aGlzIGF0DQo+Pj4gIHRoZSBkcml2ZXIncyBsYXRpdHVkZS4NCj4+DQo+PiBSaWdodCwgYnV0IHRo
ZSB1cHBlciBsYXllcnMgZG8gbm90IHN1cHBvcnQgbmVnb3RpYXRpbmcgYSBmcmVxdWVuY3kgZnJv
bQ0KPj4gcmFuZ2VzLiBBdCBsZWFzdCB0aGUgZGlkbid0IHdoZW4gdGhlIHBhdGNoIHdhcyB3cml0
dGVuLCBhbmQgaW1wbGVtZW50aW5nDQo+PiAqdGhhdCogc2VlbWVkIGxpa2UgYSBodWdlIHVuZGVy
dGFraW5nLg0KPj4NCj4+Pj4NCj4+Pj4gU28sIEknbSBjdXJpb3VzIGFzIHRvIHdoYXQgcGFuZWwg
cmVncmVzc2VkLiBPciByYXRoZXIsIHdoYXQgcGl4ZWwtY2xvY2sgaXQgbmVlZHMNCj4+Pj4gYW5k
IHdoYXQgaXQgZ2V0cyB3aXRoL3dpdGhvdXQgdGhlIHBhdGNoPw0KPj4+DQo+Pj4gSSBoYXZlIDIg
dXNlIGNhc2VzOg0KPj4+IDEvIHN5c3RlbSBjbG9jayA9IDIwME1IeiBhbmQgcmVxdWVzdGVkIHBp
eGVsIGNsb2NrIChtb2RlX3JhdGUpIH43MU1Iei4gV2l0aA0KPj4+IHRoZSByZXZlcnRlZCBwYXRj
aCB0aGUgcmVzdWx0ZWQgY29tcHV0ZWQgcGl4ZWwgY2xvY2sgd291bGQgYmUgODBNSHouDQo+Pj4g
UHJldmlvdXNseSBpdCB3YXMgYXQgNjZNSHoNCj4+DQo+PiBJIGRvbid0IHNlZSBob3cgdGhhdCdz
IHBvc3NpYmxlLg0KPj4NCj4+IFtkb2luZyBzb21lIGNhbGN1bGF0aW9uIGJ5IGhhbmRdDQo+Pg0K
Pj4gQXJyZ2guICpibHVzaCoNCj4+DQo+PiBUaGUgY29kZSBkb2VzIG5vdCBkbyB3aGF0IEkgaW50
ZW5kZWQgZm9yIGl0IHRvIGRvLg0KPj4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRoaXMgaW5zdGVhZCBv
ZiByZXZlcnRpbmc/DQo+Pg0KPj4gQ2hlZXJzLA0KPj4gUGV0ZXINCj4+DQo+PiBGcm9tIGIzZTg2
ZDU1YjhkMTA3YTVjMDdlOThmODc5YzY3ZjY3MTIwYzg3YTYgTW9uIFNlcCAxNyAwMDowMDowMCAy
MDAxDQo+PiBGcm9tOiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4gRGF0ZTogVHVl
LCAxMCBEZWMgMjAxOSAxODoxMToyOCArMDEwMA0KPj4gU3ViamVjdDogW1BBVENIXSBkcm0vYXRt
ZWwtaGxjZGM6IHByZWZlciBhIGxvd2VyIHBpeGVsLWNsb2NrIHRoYW4gcmVxdWVzdGVkDQo+Pg0K
Pj4gVGhlIGludGVudGlvbiB3YXMgdG8gb25seSBzZWxlY3QgYSBoaWdoZXIgcGl4ZWwtY2xvY2sg
cmF0ZSB0aGFuIHRoZQ0KPj4gcmVxdWVzdGVkLCBpZiBhIHNsaWdodCBvdmVyY2xvY2tpbmcgd291
bGQgcmVzdWx0IGluIGEgcmF0ZSBzaWduaWZpY2FudGx5DQo+PiBjbG9zZXIgdG8gdGhlIHJlcXVl
c3RlZCByYXRlIHRoYW4gaWYgdGhlIGNvbnNlcnZhdGl2ZSBsb3dlciBwaXhlbC1jbG9jaw0KPj4g
cmF0ZSBpcyBzZWxlY3RlZC4gVGhlIGZpeGVkIHBhdGNoIGhhcyB0aGUgbG9naWMgdGhlIG90aGVy
IHdheSBhcm91bmQgYW5kDQo+PiBhY3R1YWxseSBwcmVmZXJzIHRoZSBoaWdoZXIgZnJlcXVlbmN5
LiBGaXggdGhhdC4NCj4+DQo+PiBGaXhlczogZjZmN2FkMzIzNDYxICgiZHJtL2F0bWVsLWhsY2Rj
OiBhbGxvdyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwtY2xvY2sgdGhhbiByZXF1ZXN0ZWQiKQ0K
Pj4gUmVwb3J0ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4+
IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMg
fCA0ICsrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRt
ZWxfaGxjZGNfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2Rj
X2NydGMuYw0KPj4gaW5kZXggOWUzNGJjZTA4OWQwLi4wMzY5MTg0NWQzN2EgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+PiBA
QCAtMTIwLDggKzEyMCw4IEBAIHN0YXRpYyB2b2lkIGF0bWVsX2hsY2RjX2NydGNfbW9kZV9zZXRf
bm9mYihzdHJ1Y3QgZHJtX2NydGMgKmMpDQo+PiAgICAgICAgICAgICAgICAgaW50IGRpdl9sb3cg
PSBwcmF0ZSAvIG1vZGVfcmF0ZTsNCj4+DQo+PiAgICAgICAgICAgICAgICAgaWYgKGRpdl9sb3cg
Pj0gMiAmJg0KPj4gLSAgICAgICAgICAgICAgICAgICAoKHByYXRlIC8gZGl2X2xvdyAtIG1vZGVf
cmF0ZSkgPA0KPj4gLSAgICAgICAgICAgICAgICAgICAgMTAgKiAobW9kZV9yYXRlIC0gcHJhdGUg
LyBkaXYpKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgKDEwICogKHByYXRlIC8gZGl2X2xvdyAt
IG1vZGVfcmF0ZSkgPA0KPj4gKyAgICAgICAgICAgICAgICAgICAgKG1vZGVfcmF0ZSAtIHByYXRl
IC8gZGl2KSkpDQo+IA0KPiBJIHRlc3RlZCBpdCBvbiBteSBzZXR1cCAoSSBoYXZlIG9ubHkgb25l
IG9mIHRob3NlIHNwZWNpZmllZCBhYm92ZSkgYW5kIGl0DQo+IGlzIE9LLiBEb2luZyBzb21lIG1h
dGggZm9yIHRoZSBvdGhlciBzZXR1cCBpdCBzaG91bGQgYWxzbyBiZSBPSy4NCg0KR2xhZCB0byBo
ZWFyIGl0LCBhbmQgdGhhbmtzIGZvciB0ZXN0aW5nL3ZlcmlmeWluZyENCg0KPiBBcyBhIHdob2xl
LCBJJ20gT0sgd2l0aCB0aGlzIGF0IHRoZSBtb21lbnQgKGxldCdzIGhvcGUgaXQgd2lsbCB3b3Jr
IGZvciBhbGwNCj4gdXNlLWNhc2VzKSBidXQgc3RpbGwgSSBhbSBub3QgT0sgd2l0aCBzZWxlY3Rp
bmcgaGVyZSwgaW4gdGhlIGRyaXZlciwNCj4gc29tZXRoaW5nIHRoYXQgbWlnaHQgd29yay4NCg0K
VGhlIGRyaXZlciBoYXMgdG8gc2VsZWN0ICpzb21ldGhpbmcqLiBJZiBpdCBjYW4gZGVsaXZlciB0
aGUgZXhhY3QgcmVxdWVzdGVkDQpmcmVxdWVuY3ksIGZpbmUuIE90aGVyd2lzZT8gV2hhdCBzaG91
bGQgaXQgZG8/IEJhaWwgb3V0PyBXaHkgaXMgNTNNSHogYmV0dGVyDQphbmQgbW9yZSBsaWtlbHkg
dG8gcHJvZHVjZSBhIHBpY3R1cmUgdGhhbiA2Nk1Ieiwgd2hlbiA2NU1IeiBpcyByZXF1ZXN0ZWQ/
DQpUaGF0J3Mgb2YgY291cnNlIGFuIGltcG9zc2libGUgcXVlc3Rpb24gZm9yIHRoZSBkcml2ZXIg
dG8gYW5zd2VyLg0KDQpTbywgaWYgeW91IGFyZSBub3Qgb2sgd2l0aCB0aGF0LCB5b3UgbmVlZCB0
byBpbXBsZW1lbnQgc29tZXRoaW5nIHRoYXQgdXNlcw0KdGhlIG1pbi9tYXggZmllbGRzIGZyb20g
dGhlIHZhcmlvdXMgZmllbGRzIGluc2lkZSBzdHJ1Y3QgZGlzcGxheV90aW1pbmcNCmluc3RlYWQg
b2Ygb25seSBsb29raW5nIGF0IHRoZSB0eXAgZmllbGQuIEUuZy4gdGhlIHBhbmVsX2x2ZHMgZHJp
dmVyIGNhbGxzDQp2aWRlb21vZGVfZnJvbV90aW1pbmdzKCkgYW5kIHRoZSByZXN1bHQgaXMgYSBz
aW5nbGUgcG9zc2libGUgbW9kZSB3aXRoIG9ubHkNCnRoZSB0eXBpY2FsIHRpbWluZ3MsIHdpdGgg
bm8gbmVnb3RpYXRpb24gb2YgdGhlIGJlc3Qgb3B0aW9uIHdpdGhpbiB0aGUNCmdpdmVuIHJhbmdl
cyB3aXRoIHRoZSBvdGhlciBkcml2ZXJzIGludm9sdmVkIHdpdGggdGhlIHBpcGUuIEkgdGhpbmsg
dGhlDQpwYW5lbC1zaW1wbGUgZHJpdmVyIGFsc28gbWFrZXMgdGhpcyBvbmUtc2lkZWQgZGVjaXNp
b24gb2Ygb25seSBtYWtpbmcgdXNlDQpvZiB0aGUgdHlwIGZpZWxkIGZvciBlYWNoIGdpdmVuIHRp
bWluZyByYW5nZS4gSGF2aW5nIGRhYmJsZWQgYSBiaXQgaW4gd2hhdA0KdGhlIHNvdW5kIHN0YWNr
IGRvZXMgdG8gbmVnb3RpYXRlIHRoZSBzYW1wbGUgcmF0ZSwgc2FtcGxlIGZvcm1hdCBhbmQNCmNo
YW5uZWwgY291bnQgZXRjLCBJIGNhbiBvbmx5IHByZWRpY3QgdGhhdCByZXRyb2ZpdHRpbmcgc29t
ZXRoaW5nIGxpa2UgdGhhdA0KZm9yIHZpZGVvIG1vZGVzIHdpbGwgYmUgLi4uIGludGVyZXN0aW5n
LiBXaGljaCBpcyBwcm9iYWJseSB3aHkgaXQncyBub3QNCmRvbmUgYXQgYWxsLCBhdCBsZWFzdCBu
b3QgaW4gdGhlIGdlbmVyYWwgY2FzZS4NCg0KQW5kIHllcywgSSBhZ3JlZSwgdGhlIGN1cnJlbnQg
bWVjaGFuaWNzIGFyZSBsZXNzIHRoYW4gaWRlYWwuIEJ1dCBJIGhhdmUgbm8NCnRpbWUgdG8gZG8g
YW55dGhpbmcgYWJvdXQgaXQuDQoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgQWx0aG91
Z2ggSSBhbSBub3QgZmFtaWxpYXIgd2l0aCBob3cgb3RoZXIgRFJNDQo+IGRyaXZlcnMgYXJlIGhh
bmRsaW5nIHRoaXMga2luZCBvZiBzY2VuYXJpb3MuIE1heWJlIHlvdSBhbmQvb3Igb3RoZXIgRFJN
DQo+IGd1eXMga25vd3MgbW9yZSBhYm91dCBpdC4NCg0KSSBkb24ndCBrbm93IChhbmQgSSBtZWFu
IGl0IGxpdGVyYWxseSksIGJ1dCBtYXliZSB0aGVzZSBjaGlwcyBhcmUgc3BlY2lhbA0KYXMgdGhl
eSB0eXBpY2FsbHkgZW5kIHVwIHdpdGggdmVyeSBzbWFsbCBkaXZpZGVycyBhbmQgdGh1cyBsYXJn
ZSBmcmVxdWVuY3kNCnN0ZXBzPyBCVFcsIEkgZG8gbm90IGNvbnNpZGVyIG15c2VsZiBhIERSTSBn
dXksIEkgaGF2ZSBvbmx5IHRyaWVkIHRvDQpmaXggdGhhdCB3aGljaCBkaWQgbm90IHdvcmsgb3V0
IGZvciBvdXIgbmVlZHMuLi4NCg0KPiBKdXN0IGFzIGEgbm90aWNlLCBpdCBtYXkgd29ydGggYWRk
aW5nIGEgcHJpbnQgbWVzc2FnZSBzYXlpbmcgd2hhdCB3YXMNCj4gZnJlcXVlbmN5IHdhcyByZXF1
ZXN0ZWQgYW5kIHdoYXQgZnJlcXVlbmN5IGhhcyBiZWVuIHNldHVwIGJ5IGRyaXZlci4NCg0KSSBo
YXZlIG5vIHByb2JsZW0gd2l0aCB0aGF0Lg0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+IA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgLyoNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAqIEF0
IGxlYXN0IDEwIHRpbWVzIGJldHRlciB3aGVuIHVzaW5nIGEgaGlnaGVyDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgKiBmcmVxdWVuY3kgdGhhbiByZXF1ZXN0ZWQsIGluc3RlYWQgb2YgYSBs
b3dlci4NCj4+IC0tDQo+PiAyLjIwLjENCj4+DQoNCg==
