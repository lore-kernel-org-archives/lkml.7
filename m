Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527ADC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AABC2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLQCmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:42:37 -0500
Received: from mail-oln040092254074.outbound.protection.outlook.com ([40.92.254.74]:29408
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfLQCmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:42:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhquw/iHIfsHw/okLLJ8Pb2A23398bCZ9QIgXKwdjUcW1nzN1OEtcFq5tSdPScbIS5Yr4yDi0w0HOoIWuf3nQUR01S0FKm/hTfKHgX+lxanqs1U2227iQWKFQO+n0AnCouWtN1FR5TQIy4FJZluTXI1uASopCzz+uK/9N/4ZiH5MLilocW3IzsXK84mxiiFC8RAQHnw9SC8+iCQ5rxRORCSKpQ9CYXRH7zutSqbBFshOevUPONfez7FMO1ylEW9uVyIZwQXSy9XY8nJz/FUzxnnEG4Vk3b681yfz7mvDOskhIopg+H28slnIpPp8LJNjaV0inzVZagbImA6O7A+5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQXjcNa6Yuagh1GUmgqAK2YyqqMK2ln0VBQtCX13fBI=;
 b=UeT9h6YQJd4SS0lXY0/qYtDg+fgrnei+hEhRAzKtRGzbqOo5mRbD9oZW4YSHStKWZdD2V3biR8ck8wKrSAEQEamNLKWkxyWvQotQvUVxSuJIV6Iw+m2A3phEB54xdr4sH5+C5uEZyv3yJ9hcmO/LCZDL9AB9F0hurCosEcMBWxseFhPUXPU2YB+DfN0VyFU6F8D73pl6JkyB5rSq50BrfMNJmQC3UlqyNgMxlZOaWoeeVFmwlnErbgzKdfFJ57irQf4Ail0SUOVtfhTLvCn4gI1EwjBxCmzd/X3JFIehgAc14j4anX1CbujGFX9dQHhHdDchDcGucWjNoncXMZ13XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT047.eop-APC01.prod.protection.outlook.com
 (10.152.250.59) by SG2APC01HT102.eop-APC01.prod.protection.outlook.com
 (10.152.250.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Tue, 17 Dec
 2019 02:42:29 +0000
Received: from HK0PR02MB3780.apcprd02.prod.outlook.com (10.152.250.52) by
 SG2APC01FT047.mail.protection.outlook.com (10.152.251.172) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15 via Frontend Transport; Tue, 17 Dec 2019 02:42:29 +0000
Received: from HK0PR02MB3780.apcprd02.prod.outlook.com
 ([fe80::f9fe:75e6:97e3:32b1]) by HK0PR02MB3780.apcprd02.prod.outlook.com
 ([fe80::f9fe:75e6:97e3:32b1%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 02:42:29 +0000
From:   Changwei Ge <gechangwei@live.cn>
To:     Kai Li <li.kai4@h3c.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
CC:     "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] ocfs2: call journal flush to mark journal as empty
 after journal recovery when mount
Thread-Topic: [PATCH v3] ocfs2: call journal flush to mark journal as empty
 after journal recovery when mount
Thread-Index: AQHVtIOg7mvueyH/WkWp6F8/7rwu8w==
Date:   Tue, 17 Dec 2019 02:42:29 +0000
Message-ID: <HK0PR02MB37808FEC666656B329EE3F16D5500@HK0PR02MB3780.apcprd02.prod.outlook.com>
References: <20191217020140.2197-1-li.kai4@h3c.com>
In-Reply-To: <20191217020140.2197-1-li.kai4@h3c.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To HK0PR02MB3780.apcprd02.prod.outlook.com
 (2603:1096:203:9c::13)
x-incomingtopheadermarker: OriginalChecksum:DD74FB08DD9B6CAC3AB08DE87E3B6DF4CF0C2BA6827D04769E6AE30019BEFBFA;UpperCasedChecksum:B12ED80864B74BFC72F3EE01C020120F6BEF64AAB1DE798203A5EE9E3158CD53;SizeAsReceived:7600;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [YuUPditvN9a9IHaRimivIMHiqtF+ewBn]
x-microsoft-original-message-id: <bf5e1834-9f60-4c14-217d-8051f18469aa@live.cn>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 4a22b7f4-f405-4d71-7ba5-08d7829ac261
x-ms-traffictypediagnostic: SG2APC01HT102:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3kpn/B/7ojWoZgdwfsK3ax6wdZNe8hjY7rz5Smj8j+FGz3enCmixs7MpmKSrBcRzHqKxCDR0c4WHTxZbyHyFiJ1tArVQIeKZ9qqSwICLj0QApJx2umjEnT3tM/KRirPyV7NAh3so4KGvCUvfU9L+0yjvJ2zqvEpfLF+7SH54btVSEOxqpS25JTnMRaTMQZHF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6E7D46BB163B8488055A1509520FF9D@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a22b7f4-f405-4d71-7ba5-08d7829ac261
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 02:42:29.7935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IENoYW5nd2VpIEdlIDxnZWNoYW5nd2VpQGxpdmUuY24+DQoNCk9uIDEyLzE3
LzE5IDEwOjAxIEFNLCBLYWkgTGkgd3JvdGU6DQo+IElmIGpvdXJuYWwgaXMgZGlydHkgd2hlbiBt
b3VudCwgaXQgd2lsbCBiZSByZXBsYXllZCBidXQgamJkMiBzYg0KPiBsb2cgdGFpbCBjYW5ub3Qg
YmUgdXBkYXRlZCB0byBtYXJrIGEgbmV3IHN0YXJ0IGJlY2F1c2UNCj4gam91cm5hbC0+al9mbGFn
IGhhcyBhbHJlYWR5IGJlZW4gc2V0IHdpdGggSkJEMl9BQk9SVCBmaXJzdA0KPiBpbiBqb3VybmFs
X2luaXRfY29tbW9uLiBXaGVuIGEgbmV3IHRyYW5zYWN0aW9uIGlzIGNvbW1pdHRlZCwgaXQNCj4g
d2lsbCBiZSByZWNvcmVkIGluIGJsb2NrIDEgZmlyc3Qoam91cm5hbC0+al90YWlsIGlzIHNldCB0
byAxIGluDQo+IGpvdXJuYWxfcmVzZXQpLklmIGVtZXJnZW5jeSByZXN0YXJ0IGhhcHBlbnMgYWdh
aW4gYmVmb3JlIGpvdXJuYWwNCj4gc3VwZXIgYmxvY2sgaXMgdXBkYXRlZCB1bmZvcnR1bmF0ZWx5
LCB0aGUgbmV3IHJlY29yZGVkIHRyYW5zIHdpbGwNCj4gbm90IGJlIHJlcGxheWVkIGluIHRoZSBu
ZXh0IG1vdW50Lg0KPiANCj4gVGhlIGZvbGxvd2luZyBzdGVwcyBkZXNjcmliZSB0aGlzIHByb2Nl
ZHVyZSBpbiBkZXRhaWwuDQo+IDEuIG1vdW50IGFuZCB0b3VjaCBzb21lIGZpbGVzDQo+IDIuIHRo
ZXNlIHRyYW5zYWN0aW9ucyBhcmUgY29tbWl0dGVkIHRvIGpvdXJuYWwgYXJlYSBidXQgbm90IGNo
ZWNrcG9pbnRlZA0KPiAzLiBlbWVyZ2VuY3kgcmVzdGFydA0KPiA0LiBtb3VudCBhZ2FpbiBhbmQg
aXRzIGpvdXJuYWxzIGFyZSByZXBsYXllZA0KPiA1LiBqb3VybmFsIHN1cGVyIGJsb2NrJ3MgZmly
c3Qgc19zdGFydCBpcyAxLCBidXQgaXRzIHNfc2VxIGlzIG5vdCB1cGRhdGVkDQo+IDYuIHRvdWNo
IGEgbmV3IGZpbGUgYW5kIGl0cyB0cmFucyBpcyBjb21taXR0ZWQgYnV0IG5vdCBjaGVja3BvaW50
ZWQNCj4gNy4gZW1lcmdlbmN5IHJlc3RhcnQgYWdhaW4NCj4gOC4gbW91bnQgYW5kIGpvdXJuYWwg
aXMgZGlydHksIGJ1dCB0cmFucyBjb21taXR0ZWQgaW4gNiB3aWxsIG5vdCBiZQ0KPiByZXBsYXll
ZC4NCj4gDQo+IFRoaXMgZXhjZXB0aW9uIGhhcHBlbnMgZWFzaWx5IHdoZW4gdGhpcyBsdW4gaXMg
dXNlZCBieSBvbmx5IG9uZSBub2RlLiBJZiBpdA0KPiBpcyB1c2VkIGJ5IG11bHRpLW5vZGVzLCBv
dGhlciBub2RlIHdpbGwgcmVwbGF5IGl0cyBqb3VybmFsIGFuZCBpdHMNCj4gam91cm5hbCBzdXBl
ciBibG9jayB3aWxsIGJlIHVwZGF0ZWQgYWZ0ZXIgcmVjb3ZlcnkgbGlrZSB3aGF0IHRoaXMgcGF0
Y2gNCj4gZG9lcy4NCj4gDQo+IG9jZnMyX3JlY292ZXJfbm9kZS0+b2NmczJfcmVwbGF5X2pvdXJu
YWwuDQo+IA0KPiBUaGUgZm9sbG93aW5nIGpiZDIgam91cm5hbCBjYW4gYmUgZ2VuZXJhdGVkIGJ5
IHRvdWNoaW5nIGEgbmV3IGZpbGUgYWZ0ZXINCj4gam91cm5hbCBpcyByZXBsYXllZCwgYW5kIHNl
cSAxNSBpcyB0aGUgZmlyc3QgdmFsaWQgY29tbWl0LCBidXQgZmlyc3Qgc2VxDQo+IGlzIDEzIGlu
IGpvdXJuYWwgc3VwZXIgYmxvY2suDQo+IGxvZ2R1bXA6DQo+IEJsb2NrIDA6IEpvdXJuYWwgU3Vw
ZXJibG9jaw0KPiBTZXE6IDAgICBUeXBlOiA0IChKQkQyX1NVUEVSQkxPQ0tfVjIpDQo+IEJsb2Nr
c2l6ZTogNDA5NiAgIFRvdGFsIEJsb2NrczogMzI3NjggICBGaXJzdCBCbG9jazogMQ0KPiBGaXJz
dCBDb21taXQgSUQ6IDEzICAgU3RhcnQgTG9nIEJsa251bTogMQ0KPiBFcnJvcjogMA0KPiBGZWF0
dXJlIENvbXBhdDogMA0KPiBGZWF0dXJlIEluY29tcGF0OiAyIGJsb2NrNjQNCj4gRmVhdHVyZSBS
TyBjb21wYXQ6IDANCj4gSm91cm5hbCBVVUlEOiA0RUQzODIyQzU0Mjk0NDY3QTRGOEU4N0QyQkE0
QkMzNg0KPiBGUyBTaGFyZSBDbnQ6IDEgICBEeW5hbWljIFN1cGVyYmxrIEJsa251bTogMA0KPiBQ
ZXIgVHhuIEJsb2NrIExpbWl0ICAgIEpvdXJuYWw6IDAgICAgRGF0YTogMA0KPiANCj4gQmxvY2sg
MTogSm91cm5hbCBDb21taXQgQmxvY2sNCj4gU2VxOiAxNCAgIFR5cGU6IDIgKEpCRDJfQ09NTUlU
X0JMT0NLKQ0KPiANCj4gQmxvY2sgMjogSm91cm5hbCBEZXNjcmlwdG9yDQo+IFNlcTogMTUgICBU
eXBlOiAxIChKQkQyX0RFU0NSSVBUT1JfQkxPQ0spDQo+IE5vLiBCbG9ja251bSAgICAgICAgRmxh
Z3MNCj4gICAwLiA1ODcgICAgICAgICAgICAgbm9uZQ0KPiBVVUlEOiAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMA0KPiAgIDEuIDgyNTc3OTIgICAgICAgICBKQkQyX0ZMQUdfU0FNRV9V
VUlEDQo+ICAgMi4gNjE5ICAgICAgICAgICAgIEpCRDJfRkxBR19TQU1FX1VVSUQNCj4gICAzLiAy
NDc3Mjg2NCAgICAgICAgSkJEMl9GTEFHX1NBTUVfVVVJRA0KPiAgIDQuIDgyNTc4MDIgICAgICAg
ICBKQkQyX0ZMQUdfU0FNRV9VVUlEDQo+ICAgNS4gNTEzICAgICAgICAgICAgIEpCRDJfRkxBR19T
QU1FX1VVSUQgSkJEMl9GTEFHX0xBU1RfVEFHDQo+IC4uLg0KPiBCbG9jayA3OiBJbm9kZQ0KPiBJ
bm9kZTogODI1NzgwMiAgIE1vZGU6IDA2NDAgICBHZW5lcmF0aW9uOiA1NzE1NzY0MSAoMHgzNjgy
ODA5KQ0KPiBGUyBHZW5lcmF0aW9uOiAyODM5NzczMTEwICgweGE5NDM3ZmI2KQ0KPiBDUkMzMjog
MDAwMDAwMDAgICBFQ0M6IDAwMDANCj4gVHlwZTogUmVndWxhciAgIEF0dHI6IDB4MCAgIEZsYWdz
OiBWYWxpZA0KPiBEeW5hbWljIEZlYXR1cmVzOiAoMHgxKSBJbmxpbmVEYXRhDQo+IFVzZXI6IDAg
KHJvb3QpICAgR3JvdXA6IDAgKHJvb3QpICAgU2l6ZTogNw0KPiBMaW5rczogMSAgIENsdXN0ZXJz
OiAwDQo+IGN0aW1lOiAweDVkZTVkODcwIDB4MTExMDRjNjEgLS0gVHVlIERlYyAgMyAxMTozNzoy
MC4yODYyODA4MDEgMjAxOQ0KPiBhdGltZTogMHg1ZGU1ZDg3MCAweDExMzE4MWExIC0tIFR1ZSBE
ZWMgIDMgMTE6Mzc6MjAuMjg4NDU3MTIxIDIwMTkNCj4gbXRpbWU6IDB4NWRlNWQ4NzAgMHgxMTEw
NGM2MSAtLSBUdWUgRGVjICAzIDExOjM3OjIwLjI4NjI4MDgwMSAyMDE5DQo+IGR0aW1lOiAweDAg
LS0gVGh1IEphbiAgMSAwODowMDowMCAxOTcwDQo+IC4uLg0KPiBCbG9jayA5OiBKb3VybmFsIENv
bW1pdCBCbG9jaw0KPiBTZXE6IDE1ICAgVHlwZTogMiAoSkJEMl9DT01NSVRfQkxPQ0spDQo+IA0K
PiBUaGUgZm9sbG93aW5nIGlzIGpvdXJhbmwgcmVjb3ZlcnkgbG9nIHdoZW4gcmVjb3ZlcmluZyB0
aGUgdXBwZXIgamJkMg0KPiBqb3VybmFsIHdoZW4gbW91bnQgYWdhaW4uDQo+IHN5c2xvZzoNCj4g
WyAyMjY1LjY0ODYyMl0gb2NmczI6IEZpbGUgc3lzdGVtIG9uIGRldmljZSAoMjUyLDEpIHdhcyBu
b3QgdW5tb3VudGVkIGNsZWFubHksIHJlY292ZXJpbmcgaXQuDQo+IFsgMjI2NS42NDk2OTVdIGZz
L2piZDIvcmVjb3ZlcnkuYzooZG9fb25lX3Bhc3MsIDQ0OSk6IFN0YXJ0aW5nIHJlY292ZXJ5IHBh
c3MgMA0KPiBbIDIyNjUuNjUwNDA3XSBmcy9qYmQyL3JlY292ZXJ5LmM6KGRvX29uZV9wYXNzLCA0
NDkpOiBTdGFydGluZyByZWNvdmVyeSBwYXNzIDENCj4gWyAyMjY1LjY1MDQwOV0gZnMvamJkMi9y
ZWNvdmVyeS5jOihkb19vbmVfcGFzcywgNDQ5KTogU3RhcnRpbmcgcmVjb3ZlcnkgcGFzcyAyDQo+
IFsgMjI2NS42NTA0MTBdIGZzL2piZDIvcmVjb3ZlcnkuYzooamJkMl9qb3VybmFsX3JlY292ZXIs
IDI3OCk6IEpCRDI6IHJlY292ZXJ5LCBleGl0IHN0YXR1cyAwLCByZWNvdmVyZWQgdHJhbnNhY3Rp
b25zIDEzIHRvIDEzDQo+IA0KPiBEdWUgdG8gZmlyc3QgY29tbWl0IHNlcSAxMyByZWNvcmRlZCBp
biBqb3VybmFsIHN1cGVyIGlzIG5vdCBjb25zaXN0ZW50DQo+IHdpdGggdGhlIHZhbHVlIHJlY29y
ZGVkIGluIGJsb2NrIDEoc2VxIGlzIDE0KSwgam91cm5hbCByZWNvdmVyeSB3aWxsIGJlDQo+IHRl
cm1pbmF0ZWQgYmVmb3JlIHNlcSAxNSBldmVuIHRob3VnaCBpdCBpcyBhbiB1bmJyb2tlbiBjb21t
aXQsIGlub2RlDQo+IDgyNTc4MDIgaXMgYSBuZXcgZmlsZSBhbmQgaXQgd2lsbCBiZSBsb3N0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogS2FpIExpIDxsaS5rYWk0QGgzYy5jb20+DQo+IC0tLQ0KPiAg
IGZzL29jZnMyL2pvdXJuYWwuYyB8IDggKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvb2NmczIvam91cm5hbC5jIGIvZnMv
b2NmczIvam91cm5hbC5jDQo+IGluZGV4IDFhZmU1N2Y0MjVhMC4uNjhiYTM1NGNmMzYxIDEwMDY0
NA0KPiAtLS0gYS9mcy9vY2ZzMi9qb3VybmFsLmMNCj4gKysrIGIvZnMvb2NmczIvam91cm5hbC5j
DQo+IEBAIC0xMDY2LDYgKzEwNjYsMTQgQEAgaW50IG9jZnMyX2pvdXJuYWxfbG9hZChzdHJ1Y3Qg
b2NmczJfam91cm5hbCAqam91cm5hbCwgaW50IGxvY2FsLCBpbnQgcmVwbGF5ZWQpDQo+ICAgDQo+
ICAgCW9jZnMyX2NsZWFyX2pvdXJuYWxfZXJyb3Iob3NiLT5zYiwgam91cm5hbC0+al9qb3VybmFs
LCBvc2ItPnNsb3RfbnVtKTsNCj4gICANCj4gKwlpZiAocmVwbGF5ZWQpIHsNCj4gKwkJamJkMl9q
b3VybmFsX2xvY2tfdXBkYXRlcyhqb3VybmFsLT5qX2pvdXJuYWwpOw0KPiArCQlzdGF0dXMgPSBq
YmQyX2pvdXJuYWxfZmx1c2goam91cm5hbC0+al9qb3VybmFsKTsNCj4gKwkJamJkMl9qb3VybmFs
X3VubG9ja191cGRhdGVzKGpvdXJuYWwtPmpfam91cm5hbCk7DQo+ICsJCWlmIChzdGF0dXMgPCAw
KQ0KPiArCQkJbWxvZ19lcnJubyhzdGF0dXMpOw0KPiArCX0NCj4gKw0KPiAgIAlzdGF0dXMgPSBv
Y2ZzMl9qb3VybmFsX3RvZ2dsZV9kaXJ0eShvc2IsIDEsIHJlcGxheWVkKTsNCj4gICAJaWYgKHN0
YXR1cyA8IDApIHsNCj4gICAJCW1sb2dfZXJybm8oc3RhdHVzKTsNCj4gDQo=
