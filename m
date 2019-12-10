Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC61DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64982077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hDWiG9NV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLJO7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:59:47 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48519 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfLJO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:59:47 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 7roWAOhkkK2F7v04El7QQMCEgRT9+xvYktYFbUDfyj5SVevskspWdtR5+sf1Xibh8b94bEU7zy
 /4OkI+DpROWAccKSdQoZ3lOpL+C3+0u8reMwpucAZ19J0FOcfHhYqeIjK35zheZ1TwEdvcjpRd
 BiGtxrJPvnOFeyzHu5uuTHHInQ9gyEyvyPmGonkJklqmAnT9W4A/uvCOEFKZg0xHlpGtlULGr7
 PpuqQoJwiy1YPP7FGZ2xFriiGDGbYCfBsAQ/JONTLXN0CtkCQP4mLFXkfrIKoURQmfEBQvxaSp
 dSY=
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="59858321"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2019 07:59:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 07:59:40 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 10 Dec 2019 07:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIwlj1rEfO/c5Mew/klr+ih3kLDtfHRNfNYOM1h/JsMaOqL0A3II+b3lp65gBVdQkXEccbZKhnNbyJW4OdOGJPPRsc1zy7oySqS42a12HCqPIFyaIESwQo8kTaQtPDBlEH/c0qAt8p32So9yMC3Fk/b+3rdMgcaPjVcHGFSrnRwEDLx5MaILrvamUcKsdsqpNrnCvKIGUwIw6AhmRL+XkHEjo+Y4uuP11mDVi5JyOFTNvKiKtRva73Bor7lWXMV0r9ZH3YNUL2K5qSJhhOmJGCXcSkagNnv9/VkB+R0yZDlviGk0XAaWuD0DMxP/03+lxqmBeelXpd/sQUUP/lWl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xanWn/6iTYztMNLTMXYbWTOedVTOOPlaQFk4RqIf2Ng=;
 b=ocmLWJ56subOZoXF+AMflcm0x94M9OnaIbO/ptxQRvjLzeg2CsEgUmt6ykV4z71S7Vc7O7FHGuzkT61BXiAD1iH8AYuN5sfQBicJ0XhXpitz32bgAzCmXMoIOikPtxPmTcBW6L61+Sb4DEFoFhbEbgwvMBh6HL7mwyiQjF+7g/m6TLp2ohPoSI7ootdo8RHuKv4WxnSLyKj/SbD+lUBF/MIEAl5CiKX1Crw/C3uimPj0aXZs9A8e/GHX0l6TXZl+MMsRygv2HihhlwWqY7boNx1VaUF4q799zCNQ+7/5EXRtgK/4bpq16G0vlwSpfaBtLKjV0evxUE+bEursNx1rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xanWn/6iTYztMNLTMXYbWTOedVTOOPlaQFk4RqIf2Ng=;
 b=hDWiG9NVHSt2QQKslgKXLcmE1GSwGLvoM3IKNC4b4IQFy4E2JqduvmFWazQnMbkdcVfxdd88oVZzY6i13uOAnkIow+gi6A5+kt8rWB7LkdvEwKbXYTy8ez2Ghc4Ge3uTzYH0ZAEsT25VS1m1ytiyxDfQpAaS3Z6pa/CsHzBKX4M=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 14:59:27 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2%6]) with mapi id 15.20.2538.012; Tue, 10 Dec 2019
 14:59:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <peda@axentia.se>, <sam@ravnborg.org>, <bbrezillon@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Topic: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Index: AQHVr11ICLJHO/IKjE+yoyNQ0RZUOKezaMEAgAANUIA=
Date:   Tue, 10 Dec 2019 14:59:27 +0000
Message-ID: <5fbad2cd-0dbe-0be5-833a-f7a612d48012@microchip.com>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-5-git-send-email-claudiu.beznea@microchip.com>
 <4c3ffc48-7aa5-1e48-b0e9-a50c4eea7c38@axentia.se>
In-Reply-To: <4c3ffc48-7aa5-1e48-b0e9-a50c4eea7c38@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:5b::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191210165919625
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a640e656-4db3-4a8f-bc62-08d77d818d83
x-ms-traffictypediagnostic: DM6PR11MB3131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3131144BB573F8B249368331875B0@DM6PR11MB3131.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(52116002)(186003)(36756003)(2616005)(66446008)(64756008)(66476007)(66556008)(54906003)(478600001)(71200400001)(316002)(5660300002)(110136005)(66946007)(6506007)(31696002)(86362001)(53546011)(31686004)(4001150100001)(6486002)(26005)(2906002)(4326008)(8936002)(6512007)(8676002)(7416002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3131;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKeENpO2+WW08vUOP3lK9gK+Fq5DR/eV4Vs+13ZKdCWnDdc9BjW+UIjhu9RdA/nL/lb2eVzPH8B1F1X7AcrAcqn5xHsRlfT6bG6aOyFb/zFgAWwoRU/x6XnPOVUqbB4gkWl2DUVFUtCd5cAaK/SxXYU22pFlZWUUh5GAXYOZA4pguwsafrNSu1l2RxXiFma+oUS8JRefGwqvuUC+KpCCF2dWW+LCN3ENVMDHgwdji0gCvrfIBfJoLvCY7Kk3XmJZahD4qkChuvGntzYbyLB/SzCy2kshMRW9JKk/i/WN7qYnSjewffQ1H8lR1hi46XgJeHmWK6QbuzWATZPRMwZ1twA9MKZH5pNkwsXy8bqrYa8ZxMasgrszXSrxV8ehPM1+M0tn0ZpXczXeHdCjpQ2DQfHFIu0ZaR1QokHNbTfOVlXeRKWOo9+l80Sm9he78qhm
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D14EA4E3298C047A1E4CAA6748AAF3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a640e656-4db3-4a8f-bc62-08d77d818d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 14:59:27.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVQKx4QjGYqDvmzur9cGSbH9MuGBoR9+q9DscqQ0Q8NjHDpCpJSTTNH2wo9gs8RI6fEGam8Fe2AvKKDhSBRrN8KQWzAvvjHQ3DYaj292VPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLjEyLjIwMTkgMTY6MTEsIFBldGVyIFJvc2luIHdyb3RlOg0KPiBPbiAyMDE5LTEy
LTEwIDE0OjI0LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQg
ZjZmN2FkMzIzNDYxM2Y2ZjdmMjdjMjUwMzZhYWYwNzhkZTA3ZTliMC4NCj4+ICgiZHJtL2F0bWVs
LWhsY2RjOiBhbGxvdyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwtY2xvY2sgdGhhbiByZXF1ZXN0
ZWQiKQ0KPj4gYmVjYXVzZSBhbGxvd2luZyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwgY2xvY2sg
bWF5IG92ZXJjbG9jaw0KPj4gTENEIGRldmljZXMsIG5vdCBhbGwgb2YgdGhlbSBiZWluZyBjYXBh
YmxlIG9mIHRoaXMuDQo+IA0KPiBXaXRob3V0IHRoaXMgcGF0Y2gsIHRoZXJlIGFyZSBwYW5lbHMg
dGhhdCBhcmUgKnNldmVybHkqIHVuZGVyY2xvY2tlZCAob24gdGhlDQo+IG1hZ25pdHVkZSBvZiA0
ME1IeiBpbnN0ZWFkIG9mIDY1TUh6IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQsIEkgZG9uJ3QgcmVt
ZW1iZXINCj4gdGhlIGV4YWN0IGZpZ3VyZXMpLiANCg0KV2l0aCBwYXRjaCB0aGF0IHN3aXRjaGVz
IGJ5IGRlZmF1bHQgdG8gMnhzeXN0ZW0gY2xvY2sgZm9yIHBpeGVsIGNsb2NrLCBpZg0KdXNpbmcg
MTMzTUh6IHN5c3RlbSBjbG9jayAoYXMgeW91IHNwZWNpZmllZCBpbiB0aGUgcGF0Y2ggSSBwcm9w
b3NlZCBmb3INCnJldmVydCBoZXJlKSB0aGF0IHdvdWxkIGdvLCB3aXRob3V0IHRoaXMgcGF0Y2gg
YXQgNTNNSHogaWYgNjVNSHogaXMNCnJlcXVlc3RlZC4gQ29ycmVjdCBtZSBpZiBJJ20gd3Jvbmcu
DQoNCj4gQW5kIHRoZXkgYXJlIG9mIGNvdXJzZSBub3QgY2FwYWJsZSBvZiB0aGF0LiBBbGwgcGFu
ZWxzDQo+IGhhdmUgKnNvbWUqIHNsYWNrIGFzIHRvIHdoYXQgZnJlcXVlbmNpZXMgYXJlIHN1cHBv
cnRlZCwgYW5kIHRoZSBwYXRjaCB3YXMNCj4gd3JpdHRlbiB1bmRlciB0aGUgYXNzdW1wdGlvbiB0
aGF0IHRoZSBwcmVmZXJyZWQgZnJlcXVlbmN5IG9mIHRoZSBwYW5lbCB3YXMNCj4gcmVxdWVzdGVk
LCB3aGljaCBzaG91bGQgbGVhdmUgYXQgbGVhc3QgYSAqbGl0dGxlKiBoZWFkcm9vbS4NCg0KSSBz
ZWUsIGJ1dCBmcm9tIG15IHBvaW50IG9mIHZpZXcsIHRoZSB1cHBlciBsYXllcnMgc2hvdWxkIGRl
Y2lkZSB3aGF0DQpmcmVxdWVuY3kgc2V0dGluZ3Mgc2hvdWxkIGJlIGRvbmUgb24gdGhlIExDRCBj
b250cm9sbGVyIGFuZCBub3QgbGV0IHRoaXMgYXQNCiB0aGUgZHJpdmVyJ3MgbGF0aXR1ZGUuDQoN
Cj4gDQo+IFNvLCBJJ20gY3VyaW91cyBhcyB0byB3aGF0IHBhbmVsIHJlZ3Jlc3NlZC4gT3IgcmF0
aGVyLCB3aGF0IHBpeGVsLWNsb2NrIGl0IG5lZWRzDQo+IGFuZCB3aGF0IGl0IGdldHMgd2l0aC93
aXRob3V0IHRoZSBwYXRjaD8NCg0KSSBoYXZlIDIgdXNlIGNhc2VzOg0KMS8gc3lzdGVtIGNsb2Nr
ID0gMjAwTUh6IGFuZCByZXF1ZXN0ZWQgcGl4ZWwgY2xvY2sgKG1vZGVfcmF0ZSkgfjcxTUh6LiBX
aXRoDQp0aGUgcmV2ZXJ0ZWQgcGF0Y2ggdGhlIHJlc3VsdGVkIGNvbXB1dGVkIHBpeGVsIGNsb2Nr
IHdvdWxkIGJlIDgwTUh6Lg0KUHJldmlvdXNseSBpdCB3YXMgYXQgNjZNSHoNCjIvIHN5c3RlbSBj
bG9jayA9IDEzM01IeiBhbmQgdGhlIHJlcXVlc3RlZCBwaXhlbCBjbG9jayAobW9kZV9yYXRlKSA2
ME1Iei4NCldpdGggdGhlIHJldmVydGVkIHBhdGNoIHRoZSBjb21wdXRlZCBwaXhlbCBjbG9jayB3
b3VsZCBiZSA2Nk1Iei4NCg0KSSB0b29rIGludG8gYWNjb3VudCB0aGUgcGF0Y2ggdGhhdCB1c2Vz
IGJ5IGRlZmF1bHQgMnhzeXN0ZW0gY2xvY2sgYXMgcGl4ZWwNCmNsb2NrIChhbmQgdGhpcyB3YXMg
b24gYSBzeXN0ZW0gdGhhdCBzdXBwb3J0ZWQgaXQpLg0KDQo+IA0KPiBPciBpcyB0aGUgcmV2ZXJ0
IGJhc2VkIG9uIHNvbWUgdGhlb3J5IG9mIGEgcGVyY2VpdmVkIHJpc2sgb2YgdG9hc3RpbmcgYSBw
YW5lbD8NCg0KSXQncyBiYXNlZCBvbiB0aGUgdXNlIGNhc2VzIEkgbWVudGlvbmVkIGFib3ZlLg0K
DQo+IA0KPiBJbiBzaG9ydCwgdGhpcyByZXZlcnQgcmVncmVzc2VzIG15IHVzZSBjYXNlIGFuZCBJ
IHdvdWxkIGxpa2UgYXQgbGVhc3QgYSBob29rIHRvDQo+IHJlLWVuYWJsZSB0aGUgcmVtb3ZlZCBs
b2dpYy4NCg0KSSBzZWUsIGJ1dCwgRk1QT1YsIHlvdSBoYXZlIHRvIHRha2UgaW50byBhY2NvdW50
IHRoYXQgc29tZSBvZiB0aGUgZGV2aWNlcw0KZG9uJ3Qgc3VwcG9ydCBpdC4NCg0KVGhhbmsgeW91
LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gQ2hlZXJzLA0KPiBQZXRlcg0KPiANCj4+IENjOiBQ
ZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBC
ZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJz
L2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jIHwgMTIgLS0tLS0tLS0tLS0t
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jIGIvZHJpdmVy
cy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KPj4gaW5kZXggNzIxZmE4
OGJmNzFkLi4xYTcwZGZmMWE0MTcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXRt
ZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYXRt
ZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+PiBAQCAtMTE3LDE4ICsxMTcsNiBAQCBzdGF0
aWMgdm9pZCBhdG1lbF9obGNkY19jcnRjX21vZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpj
KQ0KPj4gICAgICAgICAgICAgICBkaXYgPSBESVZfUk9VTkRfVVAocHJhdGUsIG1vZGVfcmF0ZSk7
DQo+PiAgICAgICAgICAgICAgIGlmIChBVE1FTF9ITENEQ19DTEtESVYoZGl2KSAmIH5BVE1FTF9I
TENEQ19DTEtESVZfTUFTSykNCj4+ICAgICAgICAgICAgICAgICAgICAgICBkaXYgPSBBVE1FTF9I
TENEQ19DTEtESVZfTUFTSzsNCj4+IC0gICAgIH0gZWxzZSB7DQo+PiAtICAgICAgICAgICAgIGlu
dCBkaXZfbG93ID0gcHJhdGUgLyBtb2RlX3JhdGU7DQo+PiAtDQo+PiAtICAgICAgICAgICAgIGlm
IChkaXZfbG93ID49IDIgJiYNCj4+IC0gICAgICAgICAgICAgICAgICgocHJhdGUgLyBkaXZfbG93
IC0gbW9kZV9yYXRlKSA8DQo+PiAtICAgICAgICAgICAgICAgICAgMTAgKiAobW9kZV9yYXRlIC0g
cHJhdGUgLyBkaXYpKSkNCj4+IC0gICAgICAgICAgICAgICAgICAgICAvKg0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAqIEF0IGxlYXN0IDEwIHRpbWVzIGJldHRlciB3aGVuIHVzaW5nIGEgaGln
aGVyDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICogZnJlcXVlbmN5IHRoYW4gcmVxdWVzdGVk
LCBpbnN0ZWFkIG9mIGEgbG93ZXIuDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICogU28sIGdv
IHdpdGggdGhhdC4NCj4+IC0gICAgICAgICAgICAgICAgICAgICAgKi8NCj4+IC0gICAgICAgICAg
ICAgICAgICAgICBkaXYgPSBkaXZfbG93Ow0KPj4gICAgICAgfQ0KPj4NCj4+ICAgICAgIGNmZyB8
PSBBVE1FTF9ITENEQ19DTEtESVYoZGl2KTsNCj4+DQo+IA0K
