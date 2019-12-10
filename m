Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E94CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97472073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="M2Synzj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfLJOLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:11:46 -0500
Received: from mail-eopbgr10093.outbound.protection.outlook.com ([40.107.1.93]:16359
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbfLJOLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:11:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/gb4A0x5jrXXvFU7/2iRyVL0b+h0DBHJNLNUhH5bDJ3U0yFgoNeuQfpJ8h+/N9ZplyHAN0MxPi86esVfClCSfmh/jx7fHmKmtCMwqrdLz2nwSOLJKu/l+C7mDemyPyNKzPESYdXkmMqOHYaU9z2Hv/vlY1hJnchzRLAiy9+rAysqheoiOd3QrPBB89TFq60dJwcgKDiTnUzji5vHBiSXRvZCKUoy8N4ZZePcdCuDGHxglsrsOAikPPCM5jU5zJRxdRQSfUrsUwLYUpectrUK/B/8sd2PZfMQ0d0lOKyiB8givVPC39+3LnJtcc44qithFQEDUUuf6PTXHu2d/rM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvrvq8CaDXNQ9H+KopgVoVi5iINM1NaNrife4f9usCg=;
 b=MbmjK9FkTcjjT7JMN3zplyOHA/tP9jpWLdhLSDHfgKzV45xMTvcIyv3zvmm547rw+A0v6xrTyXBtB93Qih6Fom3HkJQ5lqeC3gol/40dDgR4MD1aIZkEEbhzw0SuIFuYcIWCnm9e/9QxUemxpT6u3JviY3mnVddrgpkf17iTDJ/w7dVls/9DEM+BvlcbJKKbq++Gl1t2dLx/Y3IS8u1igJ0tVmWMsqb4OtZ1+f+Jw1Zd2ie4qgp1edSgMHonQVs7lqrlJxzymr7kiVmPxT31vgLjPwVU0Ond3vniEqxKQ++5ZKgxUehoi3mA0/GQoD/HwMSfkolbSHRXzojA2Sguyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvrvq8CaDXNQ9H+KopgVoVi5iINM1NaNrife4f9usCg=;
 b=M2Synzj9fviy4cdNQtbHPsIsH5Ps9/Ou+uhHuAnHfUklim6uOvdh/CZ/BdvtCOd5XqR2ElqDwX/nd7pRyuOGMS+dfV+IEF6ceZkLuQRISVzxFlZAyvzenLlP9UpTSgHlfmpfUzpqMmLEnlMR6GORy2aPilMvpiB8XQgliqcSYmw=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3308.eurprd02.prod.outlook.com (52.134.66.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 10 Dec 2019 14:11:40 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::446e:c4f8:7e59:1c6d]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::446e:c4f8:7e59:1c6d%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 14:11:40 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Topic: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Index: AQHVr11DyxIz9S+dLEWyrkArJlSyg6ezaL2A
Date:   Tue, 10 Dec 2019 14:11:40 +0000
Message-ID: <4c3ffc48-7aa5-1e48-b0e9-a50c4eea7c38@axentia.se>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-5-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1575984287-26787-5-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0270.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::22) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e50c755-22b3-45c4-74b8-08d77d7ae08a
x-ms-traffictypediagnostic: DB3PR0202MB3308:
x-microsoft-antispam-prvs: <DB3PR0202MB3308F4AE247A89CE60F74E17BC5B0@DB3PR0202MB3308.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39830400003)(396003)(366004)(189003)(199004)(4326008)(81166006)(31686004)(81156014)(8676002)(6512007)(7416002)(6486002)(2906002)(64756008)(66446008)(36756003)(8936002)(186003)(66476007)(26005)(66946007)(5660300002)(66556008)(31696002)(53546011)(6506007)(86362001)(110136005)(508600001)(316002)(4001150100001)(2616005)(52116002)(54906003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3308;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4EvAuHaAQdvD6ziEE3XbKAt8mT4satyB9J1v7FnuVcKwoG+XHt2fUSvLdNMoIwk3BUpMKVIKpTvTV2CBPCNMyJFLzDXyRzsorlfrndXeE4SsCIxpEYtr28R9NkDzycyNsVqIKHBRkCJOy9h1sjX88HIHdzQ8U3YHa1orX8zuT+74rzbphxy/CUjnD6T/+4ZV3DgSJKlRg6K5lZa0NKX28jybLvAevI+S+egmJiHBH+cQHCerGaQ0z/LCNT3KCO8JFDQSsWpVqyvnlga8cfwbFmUTAMpsC2rwQ+rQIVXNDmHJ3p6xXdgWuLRhrJXadpfigX6UXH7k1snYz5GBDa38kcY0R1VWaitjCurAQcl3nJrM3e19px4Um633kmomfRkDS27ojF94LTaEVhvtFUdKAVdliuCy55gT4Qwv+toEzy6BFk5Mx4bpizsrnLYOMgk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <432D8DF437FB454DBA44BABA59C50F33@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e50c755-22b3-45c4-74b8-08d77d7ae08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 14:11:40.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32cSkY93M5SVwRzmoy+/2P6MBw12UNBPZq+16FWrHVdU6yPStdDObjOwTGWK6HRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMi0xMCAxNDoyNCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IFRoaXMgcmV2ZXJ0
cyBjb21taXQgZjZmN2FkMzIzNDYxM2Y2ZjdmMjdjMjUwMzZhYWYwNzhkZTA3ZTliMC4NCj4gKCJk
cm0vYXRtZWwtaGxjZGM6IGFsbG93IHNlbGVjdGluZyBhIGhpZ2hlciBwaXhlbC1jbG9jayB0aGFu
IHJlcXVlc3RlZCIpDQo+IGJlY2F1c2UgYWxsb3dpbmcgc2VsZWN0aW5nIGEgaGlnaGVyIHBpeGVs
IGNsb2NrIG1heSBvdmVyY2xvY2sNCj4gTENEIGRldmljZXMsIG5vdCBhbGwgb2YgdGhlbSBiZWlu
ZyBjYXBhYmxlIG9mIHRoaXMuDQoNCldpdGhvdXQgdGhpcyBwYXRjaCwgdGhlcmUgYXJlIHBhbmVs
cyB0aGF0IGFyZSAqc2V2ZXJseSogdW5kZXJjbG9ja2VkIChvbiB0aGUNCm1hZ25pdHVkZSBvZiA0
ME1IeiBpbnN0ZWFkIG9mIDY1TUh6IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQsIEkgZG9uJ3QgcmVt
ZW1iZXINCnRoZSBleGFjdCBmaWd1cmVzKS4gQW5kIHRoZXkgYXJlIG9mIGNvdXJzZSBub3QgY2Fw
YWJsZSBvZiB0aGF0LiBBbGwgcGFuZWxzDQpoYXZlICpzb21lKiBzbGFjayBhcyB0byB3aGF0IGZy
ZXF1ZW5jaWVzIGFyZSBzdXBwb3J0ZWQsIGFuZCB0aGUgcGF0Y2ggd2FzDQp3cml0dGVuIHVuZGVy
IHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHByZWZlcnJlZCBmcmVxdWVuY3kgb2YgdGhlIHBhbmVs
IHdhcw0KcmVxdWVzdGVkLCB3aGljaCBzaG91bGQgbGVhdmUgYXQgbGVhc3QgYSAqbGl0dGxlKiBo
ZWFkcm9vbS4NCg0KU28sIEknbSBjdXJpb3VzIGFzIHRvIHdoYXQgcGFuZWwgcmVncmVzc2VkLiBP
ciByYXRoZXIsIHdoYXQgcGl4ZWwtY2xvY2sgaXQgbmVlZHMNCmFuZCB3aGF0IGl0IGdldHMgd2l0
aC93aXRob3V0IHRoZSBwYXRjaD8NCg0KT3IgaXMgdGhlIHJldmVydCBiYXNlZCBvbiBzb21lIHRo
ZW9yeSBvZiBhIHBlcmNlaXZlZCByaXNrIG9mIHRvYXN0aW5nIGEgcGFuZWw/DQoNCkluIHNob3J0
LCB0aGlzIHJldmVydCByZWdyZXNzZXMgbXkgdXNlIGNhc2UgYW5kIEkgd291bGQgbGlrZSBhdCBs
ZWFzdCBhIGhvb2sgdG8NCnJlLWVuYWJsZSB0aGUgcmVtb3ZlZCBsb2dpYy4NCg0KQ2hlZXJzLA0K
UGV0ZXINCg0KPiBDYzogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4gU2lnbmVkLW9m
Zi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyB8IDEy
IC0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRj
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+IGlu
ZGV4IDcyMWZhODhiZjcxZC4uMWE3MGRmZjFhNDE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMNCj4gQEAgLTExNywxOCArMTE3LDYg
QEAgc3RhdGljIHZvaWQgYXRtZWxfaGxjZGNfY3J0Y19tb2RlX3NldF9ub2ZiKHN0cnVjdCBkcm1f
Y3J0YyAqYykNCj4gIAkJZGl2ID0gRElWX1JPVU5EX1VQKHByYXRlLCBtb2RlX3JhdGUpOw0KPiAg
CQlpZiAoQVRNRUxfSExDRENfQ0xLRElWKGRpdikgJiB+QVRNRUxfSExDRENfQ0xLRElWX01BU0sp
DQo+ICAJCQlkaXYgPSBBVE1FTF9ITENEQ19DTEtESVZfTUFTSzsNCj4gLQl9IGVsc2Ugew0KPiAt
CQlpbnQgZGl2X2xvdyA9IHByYXRlIC8gbW9kZV9yYXRlOw0KPiAtDQo+IC0JCWlmIChkaXZfbG93
ID49IDIgJiYNCj4gLQkJICAgICgocHJhdGUgLyBkaXZfbG93IC0gbW9kZV9yYXRlKSA8DQo+IC0J
CSAgICAgMTAgKiAobW9kZV9yYXRlIC0gcHJhdGUgLyBkaXYpKSkNCj4gLQkJCS8qDQo+IC0JCQkg
KiBBdCBsZWFzdCAxMCB0aW1lcyBiZXR0ZXIgd2hlbiB1c2luZyBhIGhpZ2hlcg0KPiAtCQkJICog
ZnJlcXVlbmN5IHRoYW4gcmVxdWVzdGVkLCBpbnN0ZWFkIG9mIGEgbG93ZXIuDQo+IC0JCQkgKiBT
bywgZ28gd2l0aCB0aGF0Lg0KPiAtCQkJICovDQo+IC0JCQlkaXYgPSBkaXZfbG93Ow0KPiAgCX0N
Cj4gIA0KPiAgCWNmZyB8PSBBVE1FTF9ITENEQ19DTEtESVYoZGl2KTsNCj4gDQoNCg==
