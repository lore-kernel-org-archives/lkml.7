Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF7FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DE92082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfDJSjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:39:01 -0400
Received: from mail-oln040092070040.outbound.protection.outlook.com ([40.92.70.40]:61924
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727583AbfDJSjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:39:00 -0400
Received: from DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (10.152.20.60) by DB5EUR03HT120.eop-EUR03.prod.protection.outlook.com
 (10.152.21.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Wed, 10 Apr
 2019 18:38:53 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.20.60) by
 DB5EUR03FT062.mail.protection.outlook.com (10.152.20.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Wed, 10 Apr 2019 18:38:53 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::c89:4e52:34c1:7009]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::c89:4e52:34c1:7009%5]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 18:38:53 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Doug Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
CC:     Tomasz Figa <tfiga@chromium.org>,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Ryan Case <ryandcase@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: rockchip: Fix video codec clocks on rk3288
Thread-Topic: [PATCH] clk: rockchip: Fix video codec clocks on rk3288
Thread-Index: AQHU5nomoS9eFvWRsEGSh6TEO1HQL6Y1m/eAgAAwWoA=
Date:   Wed, 10 Apr 2019 18:38:52 +0000
Message-ID: <AM3PR03MB09665B2755982816D2FC37E4AC2E0@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <20190329215455.159717-1-dianders@chromium.org>
 <CAD=FV=V22Z2ziNZs5syzd1wpT4AwpXtTHP52wKvN5drgf06Z8Q@mail.gmail.com>
In-Reply-To: <CAD=FV=V22Z2ziNZs5syzd1wpT4AwpXtTHP52wKvN5drgf06Z8Q@mail.gmail.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0181.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::29) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:9A80DC33085167426D554C10F32300CF669974193FB14F2304B808DC5A07921A;UpperCasedChecksum:10D4D1FC8AC30B819F735BDE5214F8CECC772B24E50AA895123BCC4E16226FEE;SizeAsReceived:8090;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [oDh2yREvbAQzgzkSJG6wAV44JGxB0K5r]
x-microsoft-original-message-id: <a394b664-a8bb-3a00-0632-629227aacb52@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT120;
x-ms-traffictypediagnostic: DB5EUR03HT120:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-message-info: W9OY4DRsN5QzQbex3a3ayL5GzqpCU8yYfh7e6Lsx8ttqb0kjEUebEoL3ynond0mfNY16q85D6oTKy0FY+hGz43C3cOYsQRL6npR/YAMOpw4vColnDR7fhmZ2NPoDTqDYaKvjdrPCsT3JbQ9z85L6TON9YWJ8VrpqNHTh1IYMv/oOgQcZJgD1HwegUhfOajyO
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2F0DD6E8F33E84C932599DB5F0FF22E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eeb3d1a-0987-4bbd-751b-08d6bde3c764
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 18:38:52.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0xMCAxNzo0NSwgRG91ZyBBbmRlcnNvbiB3cm90ZToNCj4gSGksDQo+DQo+IE9u
IEZyaSwgTWFyIDI5LCAyMDE5IGF0IDI6NTUgUE0gRG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRlcnNA
Y2hyb21pdW0ub3JnPiB3cm90ZToNCj4+IEl0IGFwcGVhcnMgdGhhdCB0aGVyZSBpcyBhIHR5cG8g
aW4gdGhlIHJrMzI4OCBUUk0uICBGb3INCj4+IEdSRl9TT0NfQ09OMFs3XSBpdCBzYXlzIHRoYXQg
MCBtZWFucyAidmVwdSIgYW5kIDEgbWVhbnMgInZkcHUiLiAgSXQncw0KPj4gdGhlIG90aGVyIHdh
eSBhcm91bmQuDQo+Pg0KPj4gSG93IGRvIEkga25vdz8gIEhlcmUncyBteSBldmlkZW5jZToNCj4+
DQo+PiAxLiBQcmlvciB0byBjb21taXQgNGQzZTg0Zjk5NjI4ICgiY2xrOiByb2NrY2hpcDogZGVz
Y3JpYmUgYWNsa192Y29kZWMNCj4+ICAgIHVzaW5nIHRoZSBuZXcgbXV4Z3JmIHR5cGUgb24gcmsz
Mjg4Iikgd2UgYWx3YXlzIHByZXRlbmRlZCB0aGF0IHdlDQo+PiAgICB3ZXJlIHVzaW5nICJhY2xr
X3ZkcHUiIGFuZCB0aGUgY29tbWVudCBpbiB0aGUgY29kZSBzYWlkIHRoYXQgdGhpcw0KPj4gICAg
bWF0Y2hlZCB0aGUgZGVmYXVsdCBzZXR0aW5nIGluIHRoZSBzeXN0ZW0uICBJbiBmYWN0IHRoZSBk
ZWZhdWx0DQo+PiAgICBzZXR0aW5nIGlzIDAgYWNjb3JkaW5nIHRvIHRoZSBUUk0gYW5kIGFjY29y
ZGluZyB0byByZWFkaW5nIG1lbW9yeQ0KPj4gICAgYXQgYm9vdHVwLiAgSW4gYWRkaXRpb24gcmsz
Mjg4LWJhc2VkIENocm9tZWJvb2tzIHJhbiBsaWtlIHRoaXMgYW5kDQo+PiAgICB0aGUgdmlkZW8g
Y29kZWNzIHdvcmtlZC4NCj4+IDIuIFdpdGggdGhlIGV4aXN0aW5nIGNsb2NrIGNvZGUgaWYgeW91
IGJvb3QgdXAgYW5kIHRyeSB0byBlbmFibGUgdGhlDQo+PiAgICBuZXcgVklERU9fUk9DS0NISVBf
VlBVIGFzIGEgbW9kdWxlIChhbmQgd2l0aG91dCAiY2xrX2lnbm9yZV91bnVzZWQiDQo+PiAgICBv
biB0aGUgY29tbWFuZCBsaW5lKSwgeW91IGdldCBlcnJvcnMgbGlrZSAiZmFpbGVkIHRvIGdldCBh
Y2sgb24NCj4+ICAgIGRvbWFpbiAncGRfdmlkZW8nLCB2YWw9MHg4MDIwOCIuICBBZnRlciBmbGlw
cGluZyB2ZXB1L3ZkcHUgdGhpbmdzDQo+PiAgICBpbml0IE9LLg0KPj4gMy4gSWYgSSBleHBvcnQg
YW5kIGFkZCBib3RoIHRoZSB2ZXB1IGFuZCB2ZHB1IHRvIHRoZSBsaXN0IG9mIGNsb2Nrcw0KPj4g
ICAgZm9yIFJLMzI4OF9QRF9WSURFTyBJIGNhbiBnZXQgcGFzdCB0aGUgcG93ZXIgZG9tYWluIGVy
cm9ycywgYnV0IG5vdw0KPj4gICAgSSBmcmVlemUgd2hlbiB0aGUgdnB1X21tdSBnZXRzIGluaXR0
ZWQuDQo+PiA0LiBJZiBJIGp1c3QgbWFyayB0aGUgInZkcHUiIGFzIElHTk9SRV9VTlVTRUQgdGhl
biBldmVyeXRoaW5nIGJvb3RzIHVwDQo+PiAgICBhbmQgcHJvYmVzIE9LIHNob3dpbmcgdGhhdCBz
b21laG93IHRoZSAidmRwdSIgd2FzIGltcG9ydGFudCB0byBrZWVwDQo+PiAgICBlbmFibGVkLiAg
VGhpcyBpcyBiZWNhdXNlIHdlIHdlcmUgYWN0dWFsbHkgdXNpbmcgaXQgYXMgYSBwYXJlbnQuDQo+
PiA1LiBBZnRlciB0aGlzIGNoYW5nZSBJIGNhbiBoYWNrICJhY2xrX3Zjb2RlY19wcmUiIHRvIHBh
cmVudCBmcm9tDQo+PiAgICAiYWNsa192ZXB1IiB1c2luZyBhc3NpZ25lZC1jbG9ja3MgYW5kIHRo
ZSB2aWRlbyBjb2RlYyBzdGlsbCBwcm9iZXMNCj4+ICAgIE9LLg0KPj4NCj4+IEZpeGVzOiA0ZDNl
ODRmOTk2MjggKCJjbGs6IHJvY2tjaGlwOiBkZXNjcmliZSBhY2xrX3Zjb2RlYyB1c2luZyB0aGUg
bmV3IG11eGdyZiB0eXBlIG9uIHJrMzI4OCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBEb3VnbGFzIEFu
ZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+DQo+PiAtLS0NCj4+IEkgY3VycmVudGx5IGhh
dmUgbm8gd2F5IHRvIHRlc3QgdGhlIEpQRUcgbWVtMm1lbSBkcml2ZXIsIHNvIGhvcGVmdWxseQ0K
Pj4gb3RoZXJzIGNhbiB0ZXN0IHRoaXMgYW5kIG1ha2Ugc3VyZSBpdCdzIGhhcHB5IGZvciB0aGVt
LiAgSSdtIGp1c3QNCj4+IGhhcHB5IG5vdCB0byBnZXQgc3RyYW5nZSBlcnJvcnMgYXQgYm9vdCBh
bnltb3JlLg0KPj4NCj4+ICBkcml2ZXJzL2Nsay9yb2NrY2hpcC9jbGstcmszMjg4LmMgfCAyICst
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IEFu
eSB0aG91Z2h0cyBhYm91dCB0aGlzIHBhdGNoPyAgSSdtIDk5LjklIGNlcnRhaW4gaXQncyBjb3Jy
ZWN0IGFuZA0KPiBpdCdkIGJlIG5pY2UgdG8gZ2V0IGl0IGxhbmRlZC4gIEhlaWtvOiBJIGFzc3Vt
ZSB5b3UncmUgc3RpbGwNCj4gY29sbGVjdGluZyBSb2NrY2hpcCBjbG9jayBwYXRjaGVzIGFuZCB3
b3VsZCBiZSB0aGUgb25lIHRvIGFwcGx5IGl0IGFuZA0KPiAoYXQgc29tZSBwb2ludCkgc2VuZCBh
IHB1bGwgcmVxdWVzdCB0byB0aGUgY2xvY2sgdHJlZT8NCj4NCj4gLURvdWcNCg0KVGhpcyBjbGsg
Zml4IGlzIG5lZWRlZCB0byBtYWtlIE1QRUctMiBkZWNvZGluZyB3b3JrIG9uIG15IFJLMzI4OCBU
aW5rZXIgQm9hcmQgdXNpbmcgdGhlDQpyb2NrY2hpcCB2cHUgcGF0Y2hzZXQgYW5kIGEgcGF0Y2gg
dG8gYWRkIFJLMzI4OCBzcGVjaWZpYyBNUEVHLTIgY29kZSBbMV0uDQoNCkFsc28gbm90ZSB0aGF0
IHRoZSBzYW1lIGNoYW5nZSB3YXMgc3VnZ2VzdGVkIGluIGEgcHJldmlvdXMgcGF0Y2ggWzJdIGZy
b20gYnkgYXlha2EuDQoNCklmIHBvc3NpYmxlIHBsZWFzZSBhbHNvIGFkZCB0aGUgQ0xLX1NFVF9S
QVRFX1BBUkVOVCBjaGFuZ2UgZnJvbSBbM10gaW4gYSBwb3NzaWJsZSB2MiwNCnRoYXQgZml4ZXMg
YXNzaWduaW5nIHRoZSBhY2xrX3Zjb2RlYyBjbGsgdG8gNDAwTWh6IGluIHRoZSByb2NrY2hpcCB2
cHUgZHJpdmVyLg0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL0t3aWJvby9saW51eC1yb2NrY2hp
cC9jb21taXQvMWY3ODA5M2UwNWM3MzYwNTE1YTE4NWY0OGI3YzVjYjhiYTFlM2UxNQ0KWzJdIGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTcyNTU1My8NClszXSBodHRwczovL2dp
dGh1Yi5jb20vS3dpYm9vL2xpbnV4LXJvY2tjaGlwL2NvbW1pdC85MjE2ZGEzZjE1MjFhMGJlNTg4
OTIzNWFiZTdmYTA5M2E0ODk0MTYwDQoNClJlZ2FyZHMsDQpKb25hcw0KDQo=
