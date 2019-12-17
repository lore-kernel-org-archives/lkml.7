Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001EDC2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF12421739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3lQx4of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLQHIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:08:40 -0500
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:25601
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfLQHIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:08:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxcaDC39eKJr4Rl3+3bARjOT2VRWdZrvp6dHICfXICJYPyTO21klAKPPWIi0jiXY8vzAPTMhO9BZ2bGPIF5t8YILoKblZlAj7GP+zpgCHWN7EekWSiBfpsloSXm3FL9bpigiiUe40lc/Iz7ZlQ/6mNUYfu7qps17LFTmDyKY55MgZNpYD0/eeMKZfZX1BAz1cDnygOhMyJmNei+iep25ubGGtNnKa0jitYG1CN/BEJSvU8KyPKaaXU6wHW3AnztGefMm8g5rOcX6GmG1sO8vBBxkPUIsX3Rst0mHqsdo3QbKXfxd1+ozW+1xiAp9++6GtD9i7wsH7K0G7RBAt2AmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olKIkkk/fxY/7s1bYWav+0NKZwg/GUSG98ZcOh+LKj8=;
 b=T21as9lUDkLRgQy1egk5aXHrfNuv7EQQxd5tAXqWV6IxyVovjZsosmwNqWisGbhFIKuYsRPS90qv7mVvuqveki6kvtHXMUFX53HBTfndw8cxnJRby3gMmYVzrjOeeaaMEJSl5qj+rWCSgDb0tQNoRhwf0ny43jfUi1ViWhpDGEwknNl4zCsfUHI7LHnD3vhj47vso2Fu68q+SJI6p/7+WZXclfHfGQy+aLLZ/Vd8ZR2mcgoe50rVaKIxwzOZXe9bBxHutk4r8eWTnO11ywjtKmpaVl0eF/nItfGl0IsDRDTr3Dk8tBF1RhrhC0z6ygh0eO/Wa3zUVCSJwQQu77W0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olKIkkk/fxY/7s1bYWav+0NKZwg/GUSG98ZcOh+LKj8=;
 b=T3lQx4of2QE2umdiVH6Yl5Ha/2ETftfm0oVgT/0wFWLtS+xQyU4vniulKcV9eJee7ZQwb8o21mQiGlNgCXsJhZMpizI42VMly1Xcg6d6jB6QukXGGR6SYx7wMldkTGa5cwBwzzgFW/MXt7ijxoeHV2dcUwDbeKPT6HtCdsF9180=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4108.eurprd04.prod.outlook.com (52.135.128.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 07:08:36 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::44f6:aaa4:b0f7:30c2]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::44f6:aaa4:b0f7:30c2%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 07:08:36 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [v11 2/2] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Topic: [EXT] Re: [v11 2/2] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Index: AQHVqz14Me+JXgsOdkiIZvy5xUXopKe3HZ4AgAAeLQCABeHMgIAA2lnw
Date:   Tue, 17 Dec 2019 07:08:36 +0000
Message-ID: <DB7PR04MB519563398D95F64E44E795CEE2500@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191205072653.34701-1-wen.he_1@nxp.com>
 <20191205072653.34701-2-wen.he_1@nxp.com>
 <20191212221817.B7FF1206DA@mail.kernel.org>
 <F2C21019-79F4-450F-A575-9621E5747C4E@walle.cc>
 <20191216175543.F2C60206B7@mail.kernel.org>
In-Reply-To: <20191216175543.F2C60206B7@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ceb86b3-59ca-46ba-2ded-08d782bfef92
x-ms-traffictypediagnostic: DB7PR04MB4108:|DB7PR04MB4108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4108E15595460BB2141035BFE2500@DB7PR04MB4108.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(13464003)(4001150100001)(76116006)(55016002)(52536014)(64756008)(2906002)(66446008)(186003)(66556008)(66946007)(86362001)(66476007)(5660300002)(26005)(7696005)(6506007)(316002)(33656002)(71200400001)(478600001)(81156014)(81166006)(110136005)(9686003)(53546011)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4108;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VExrTyZ1WR4KDmASWA9QrWwRKaNTGpziHx0WuoZNbvKCJ/vqS5ZtyJwsdfRKla0d9AkcSXEpwZmz0AYtWrTk2XnhxjpA7GQPf2Bvz2WrSP2aads3eFWte3QmvwnSNJZZ/4y2+K/6gTZlS3EkNnXLe1eDUA6529lK2g4QZK8drd9AHNzJy2TYM2/RIpWLB78jcnt0ZQyxzp7hBMi+HitNTddnAmzmu2ij7uEy54vGUbDS5DSAFjzRsqLfeoFabHpj+CNflhkbFvzr2zfuE1YftjO1UDLWwlgDXFeH798I+ZptdoSv9lE+rXB6ivjcHCbRivL44BNLNEdpa7c4OGRqPcDo2XX+YB3BymrmaxjhBRI1izqLVcCyll9Q8lgt8P64smZb+aY0kBe1ywcz/kXsxWHD+L/Tb0W6N9rZVxis1J4fFadJpYJnbm6NkKiWWpX1BeD9l8OhHxDLbOK821l1aCYWYAinuQqFVqzpm1KhNt9tT78rDaaGHpc3bu4a5mDQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceb86b3-59ca-46ba-2ded-08d782bfef92
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 07:08:36.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NlWIGhg2jRTI1trkzcIQ/P8xf75c29U1e0TJduKmh/1cfYSt3n3N+Fq2jKs3EWchfzhGwNdCyQ+NxLzOPdDIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0MTLmnIgxN+aXpSAxOjU2DQo+IFRvOiBM
ZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFy
bS5jb20+Ow0KPiBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBN
aWNoYWVsIFdhbGxlDQo+IDxtaWNoYWVsQHdhbGxlLmNjPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz47IFdlbiBIZQ0KPiA8d2VuLmhlXzFAbnhwLmNvbT47IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbdjExIDIvMl0gY2xrOiBsczEw
MjhhOiBBZGQgY2xvY2sgZHJpdmVyIGZvciBEaXNwbGF5IG91dHB1dA0KPiBpbnRlcmZhY2UNCj4g
DQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gUXVvdGluZyBNaWNoYWVsIFdhbGxlICgyMDE5
LTEyLTEyIDE2OjA2OjE2KQ0KPiA+IEFtIDEyLiBEZXplbWJlciAyMDE5IDIzOjE4OjE2IE1FWiBz
Y2hyaWViIFN0ZXBoZW4gQm95ZA0KPiA8c2JveWRAa2VybmVsLm9yZz46DQo+ID4gPlF1b3Rpbmcg
V2VuIEhlICgyMDE5LTEyLTA0IDIzOjI2OjUzKQ0KPiA+ID4+IEFkZCBjbG9jayBkcml2ZXIgZm9y
IFFvcklRIExTMTAyOEEgRGlzcGxheSBvdXRwdXQgaW50ZXJmYWNlcyhMQ0QsDQo+ID4gPkRQSFkp
LA0KPiA+ID4+IGFzIGltcGxlbWVudGVkIGluIFRTTUMgQ0xOMjhIUE0gUExMLCB0aGlzIFBMTCBz
dXBwb3J0cyB0aGUNCj4gPiA+cHJvZ3JhbW1hYmxlDQo+ID4gPj4gaW50ZWdlciBkaXZpc2lvbiBh
bmQgcmFuZ2Ugb2YgdGhlIGRpc3BsYXkgb3V0cHV0IHBpeGVsIGNsb2NrJ3MNCj4gPiA+MjctNTk0
TUh6Lg0KPiA+ID4+DQo+ID4gPj4gU2lnbmVkLW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVfMUBueHAu
Y29tPg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUu
Y2M+DQo+ID4gPg0KPiA+ID5JcyBNaWNoYWVsIHRoZSBhdXRob3I/IFNvQiBjaGFpbiBpcyBiYWNr
d2FyZHMgaGVyZS4NCj4gPg0KPiA+IHRoZSBvcmlnaW5hbCBkcml2ZXIgd2FzIGZyb20gV2VuLiBJ
J3ZlIGp1c3Qgc3VwcGxpZWQgc29tZSBjb2RlIGFuZCB0aGUNCj4gPiB2Y28gZnJlcXVlbmN5IHN0
dWZmLiBzbyBpdHMgYmFzaWNhbGx5IGEgc29iIG9mIHVzIGJvdGguDQo+ID4NCj4gPiAtbWljaGFl
bA0KPiANCj4gT2suIFRoYXQncyBhIENvLWRldmVsb3BlZC1ieTogdGFnIHRoZW4uIFRoYW5rcyBm
b3IgbGV0dGluZyB1cyBrbm93Lg0KDQpUaGUgdjEyIHZlcnNpb24gcGF0Y2ggd2FzIHNlbnQgb3V0
Lg0KRG9lcyBuZWVkIEkgY2hhbmdlIHRoZSBhdXRob3Igc2lnbiB0byBiZWxvdz8NCg0KQ28tZGV2
ZWxvcGVkLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBXZW4g
SGUgPHdlbi5oZV8xQG54cC5jb20+DQpDby1kZXZlbG9wZWQtYnk6IE1pY2hhZWwgV2FsbGUgPG1p
Y2hhZWwuQHdhbGxlLmNjPg0KU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbC5A
d2FsbGUuY2M+DQpTaWduZWQtb2ZmLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQoNCkJl
c3QgUmVnYXJkcywNCldlbg0KDQoNCg==
