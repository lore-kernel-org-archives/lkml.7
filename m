Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC7C5DF61
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3CC2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hbUraSic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfKHCUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:20:37 -0500
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:54054
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbfKHCUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:20:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjWkCgM+D8b8JLUKfmlEvjGABde5Q5K05vyTLnCB6GNGoqFBvKsaf39WjWn77l9pNRrV8u6jXwRbkoHW90e4HUWwjLx1tOxXQgCYKSIVb2eCr8XkHH0O9eifQ/V9YTzn+OaSaKgmgsmPxsK4rYGJhHboPGQ8KfsRveIU9jynNCBFAeFuH8QDzMKN2ZUwMZYlbL/K2iwDHSRqlPJ4+ZGb7UC43cCbB0LH7aCOW6SUvVz22PSE7lVPNYJ7UwHau0zSIQIrISUqyNIMyrHi9ulQHJCP0YT/N2Hi+RXlWqV0deMgOWigS4FV7KRM/0AQUUjEJH+wsjjitugsvm2OGs/PhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAgKRTPgik9+46XTamfN/wx0ZUAXk1NEl5TGkcZkY6A=;
 b=HH7YrY6+6m9YWAaSpDlRYgyh1MA/QQMr9rxtBeFYObhbJtIzc+UfQuZRf0LWPwyyQN1YhcpmKzKABAs7wVfAxDKJ0ifKUtoLNeK1rLP7PJ9+6fCUU0M4TFqO3ztxYbbbJZYfP/1OFUKSSlJZS83iPqYMDwKhAZB9jRSH+B/qtP8eiTYaYfx9oOzMM1z+4IZbWFNJpj44znGCgSRt2nfYAZxWD5STEochQOTd0Obh1DUNW5ekha2Fe6lm9NE0JSrILexQUcGrN8KOKiSIRi7ZxVbnexa35Ft/hntBAG9NFpsKfVyMVTuLI2rFXEmV1gL4VBTpjN1/U57hBUyn2BqMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAgKRTPgik9+46XTamfN/wx0ZUAXk1NEl5TGkcZkY6A=;
 b=hbUraSicUj/h1E27+dg4CGf5eQt7F7OPiBcDPD8MUxsXqTj9AIbvx1EwDm3fnLDwbQsztizo9UktAUmo5AXXblUNNLvz69LEdxnL6jmEiMsJQK+pn7edKx7tsJJgJMvV5ThKLycveIj+TxfJ8L7toWoVEbbC7/uPu4ATbQWC7t0=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB5260.eurprd04.prod.outlook.com (20.176.237.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 02:19:54 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::551e:2221:4f8d:a7b8]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::551e:2221:4f8d:a7b8%5]) with mapi id 15.20.2408.028; Fri, 8 Nov 2019
 02:19:53 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] RE: [v6 2/2] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Topic: [EXT] RE: [v6 2/2] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Index: AQHVk7lUTq986ApPnEC0F11XXes3P6d9E4EAgAH0e/CAAU4ZAIAAN7Sw
Date:   Fri, 8 Nov 2019 02:19:53 +0000
Message-ID: <DB7PR04MB51959C3CF461F68AE99FA728E27B0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191105090221.45381-1-wen.he_1@nxp.com>
 <20191105090221.45381-2-wen.he_1@nxp.com>
 <VE1PR04MB66879681CE5231F5C80F85148F7E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <DB7PR04MB51956205E7FE92C9EB00A882E2780@DB7PR04MB5195.eurprd04.prod.outlook.com>
 <20191107225745.1A01C2178F@mail.kernel.org>
In-Reply-To: <20191107225745.1A01C2178F@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17a8ff8d-6a22-4543-a7bb-08d763f22456
x-ms-traffictypediagnostic: DB7PR04MB5260:|DB7PR04MB5260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5260DF7A6065F5728E780AA9E27B0@DB7PR04MB5260.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(13464003)(189003)(199004)(66476007)(33656002)(66946007)(26005)(76176011)(25786009)(476003)(6506007)(186003)(66066001)(7696005)(7736002)(305945005)(14454004)(256004)(486006)(446003)(2906002)(76116006)(8936002)(6436002)(2201001)(71200400001)(110136005)(8676002)(86362001)(9686003)(11346002)(74316002)(53546011)(55016002)(316002)(102836004)(71190400001)(6116002)(52536014)(64756008)(66556008)(478600001)(66446008)(99286004)(81156014)(81166006)(5660300002)(229853002)(3846002)(2501003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5260;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xKezhI9zc1P7XWzs0YBXQNM3+P0t+Exs8TbJntnU8CseBey0ovzWRMzmttxsp9K5h1n7rf1uZJ4lo5elvlDt7PPYk5rWoZ71tjLbwdzdiuNfG+g/mMxrLDg/o0zL530LK5Oq6WbFfjs80//8KfJB8jwz0UGObCgBg23CsNVBWmBzH89uqwu1qq21OvS4QMwVNUFmtS7uvbCQfsVc+OAFYt93OZ1U+be/cAPmcHpm3Jb6XI4AQzpI1noqJk9gSfgUR+r0g+okyt/l28oRNs/S/hWprtUvkLVU08h7wBAgAHOfa3uov6859CRjFmJjDcTclqYgkYRTV2Iqy0Um/7ClQ8FBoMuF08j9+53zZx8R0Eq7urUlgrKuGuInNHsTW6DQz8qWdFs96+5AVQfdc1ubwtEXxZai/mAK3n0KuK6+cWlwiKgGzLNJzOmgE3coSWn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a8ff8d-6a22-4543-a7bb-08d763f22456
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 02:19:53.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +v/ZSlAUZYD+IQJeAozWDelO0veFVlT8z5JBg+HCcdyaS6nWXJy/K8mbX9t0zXMf6QkVhr8oJ2+yuw8XYDNQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0MTHmnIg45pelIDY6NTgNCj4gVG86IExl
byBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJt
LmNvbT47DQo+IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT47IFJv
YiBIZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBXZW4gSGUgPHdlbi5oZV8xQG54cC5j
b20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtZGV2ZWxAbGludXgubnhkaS5ueHAuY29tOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJFOiBbdjYgMi8yXSBjbGs6IGxzMTAyOGE6
IEFkZCBjbG9jayBkcml2ZXIgZm9yIERpc3BsYXkgb3V0cHV0DQo+IGludGVyZmFjZQ0KPiANCj4g
Q2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBRdW90aW5nIFdlbiBIZSAoMjAxOS0xMS0wNiAxOTox
Mzo0OCkNCj4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvTWFrZWZpbGUgYi9k
cml2ZXJzL2Nsay9NYWtlZmlsZSBpbmRleA0KPiA+ID4gPiAwMTM4ZmIxNGU2ZjguLmQyM2I3NDY0
YWJhOCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvTWFrZWZpbGUNCj4gPiA+ID4g
KysrIGIvZHJpdmVycy9jbGsvTWFrZWZpbGUNCj4gPiA+ID4gQEAgLTQ1LDYgKzQ1LDcgQEAgb2Jq
LSQoQ09ORklHX0NPTU1PTl9DTEtfT1hOQVMpDQo+ICs9DQo+ID4gPiA+IGNsay1veG5hcy5vDQo+
ID4gPiA+ICBvYmotJChDT05GSUdfQ09NTU9OX0NMS19QQUxNQVMpICAgICAgICAgICAgKz0gY2xr
LXBhbG1hcy5vDQo+ID4gPiA+ICBvYmotJChDT05GSUdfQ09NTU9OX0NMS19QV00pICAgICAgICAg
ICAgICAgKz0gY2xrLXB3bS5vDQo+ID4gPiA+ICBvYmotJChDT05GSUdfQ0xLX1FPUklRKSAgICAg
ICAgICAgICAgICAgICAgKz0gY2xrLXFvcmlxLm8NCj4gPiA+ID4gK29iai0kKENPTkZJR19DTEtf
TFMxMDI4QV9QTExESUcpICAgKz0gY2xrLXBsbGRpZy5vDQo+ID4gPg0KPiA+ID4gV3Jvbmcgb3Jk
ZXJpbmcuICBUaGlzIHNlY3Rpb24gb2YgTWFrZWZpbGUgcmVxdWlyZXMgb3JkZXJpbmcgYnkNCj4g
PiA+IGRyaXZlciBmaWxlDQo+ID4gPiBuYW1lOg0KPiA+ID4NCj4gPiA+ICMgaGFyZHdhcmUgc3Bl
Y2lmaWMgY2xvY2sgdHlwZXMNCj4gPiA+ICMgcGxlYXNlIGtlZXAgdGhpcyBzZWN0aW9uIHNvcnRl
ZCBsZXhpY29ncmFwaGljYWxseSBieSBmaWxlIHBhdGgNCj4gPiA+IG5hbWUNCj4gPiA+DQo+ID4N
Cj4gPiBIaSBMZW8sDQo+ID4NCj4gPiBTdGVwaGVuIG9uY2Ugc3VnZ2VzdCB0aGUgS2NvbmZpZyB2
YXJpYWJsZSBuYW1lIHNob3VsZCBiZSBnaXZlbiBhIG1vcmUNCj4gPiBzcGVjaWZpYyBuYW1lIGxp
a2UgQ0xLX0xTMTAyOEFfUExMRElHLCBzbyBJIGhhdmUgdG8gY2hhbmdlZCBpdC4NCj4gPg0KPiA+
IEhpIFN0ZXBoZW4sDQo+ID4NCj4gPiBIb3cgZG8geW91IHRoaW5rPw0KPiA+DQo+IA0KPiANCj4g
Q29uZmlnIG5hbWUgbG9va3MgZmluZSB0byBtZSwgYnV0IHlvdSBoYXZlbid0IHNvcnRlZCB0aGlz
IGJhc2VkIG9uIHRoZSBmaWxlDQo+IG5hbWUsIGkuZS4gY2xrLXBsbGRpZy5vLCBzbyBwbGVhc2Ug
aW5zZXJ0IHRoaXMgaW4gdGhlIHJpZ2h0IHBsYWNlIGluIHRoaXMgZmlsZS4NCg0KV293LCBVbmRl
cnN0YW5kIG5vdy4uIA0KDQpTaG91bGQgYmUgc29ydCB0aGlzIGZpbGUgbGlrZSBiZWxvdywgcmln
aHQ/DQpvYmotJChDT05GSUdfQ09NTU9OX0NMS19QV00pICAgKz0gY2xrLXB3bS5vDQpvYmotJChD
T05GSUdfQ0xLX0xTMTAyOEFfUExMRElHKSAgICs9IGNsay1wbGxkaWcubw0Kb2JqLSQoQ09ORklH
X0NMS19RT1JJUSkgICAgICAgICAgICs9IGNsay1xb3JpcS5vDQoNCkJlc3QgUmVnYXJkcywNCldl
bg0KDQo=
