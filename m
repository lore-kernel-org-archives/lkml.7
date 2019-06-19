Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC4C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366D320863
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="acv9vMYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfFSBGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:06:40 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:41985
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbfFSBGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9U4xhMMU3VSy50HjKqiiRKI9a4qqLovMcSnrh45ZjU=;
 b=acv9vMYDYtSBC+4r1albGfumoNDqk0Zxe6vHMCo/7xfTjeOxenu7z7FjPQkbA5ZDac2kWL6eEpYUs5GEzDOkHDSEbh/XNBnEmOmnYkDVz4UgOnOsALljgtfp9wzlRiuHKbbGhQB++Om+ycHS0ENSJTEpCb2G8XyE1BALsciebUs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Wed, 19 Jun 2019 01:06:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 01:06:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx: Add i.MX8MN SoC driver support
Thread-Topic: [PATCH] soc: imx: Add i.MX8MN SoC driver support
Thread-Index: AQHVH/Up3NdnX/doMEq9SuarUx0FjqahB/qAgAABlMCAAGHEgIAAytew
Date:   Wed, 19 Jun 2019 01:06:35 +0000
Message-ID: <DB3PR0402MB3916C448D65BE66950B16FABF5E50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190611013125.3434-1-Anson.Huang@nxp.com>
 <20190618070334.GD29881@dragon>
 <DB3PR0402MB391691EEF083BA6BEF445235F5EA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190618125902.GN29881@dragon>
In-Reply-To: <20190618125902.GN29881@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b9e14f1-6d3d-4c98-da2c-08d6f452607e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB3659F63A5B3D0E6080E4C823F5E50@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(366004)(376002)(13464003)(199004)(189003)(476003)(74316002)(4326008)(256004)(25786009)(26005)(44832011)(11346002)(33656002)(305945005)(186003)(446003)(71200400001)(6116002)(2906002)(486006)(9686003)(53936002)(7736002)(68736007)(3846002)(6436002)(229853002)(55016002)(71190400001)(99286004)(102836004)(53546011)(8936002)(14454004)(81156014)(7696005)(76176011)(6246003)(8676002)(81166006)(6506007)(73956011)(316002)(478600001)(54906003)(6916009)(52536014)(86362001)(5660300002)(64756008)(76116006)(66446008)(66476007)(14444005)(66066001)(66946007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fv97dHADr6roZFPNEmQ8W+WqIRKCvHzjst7iWJldTBHxKP8TR6iiQ9eRv8x+ty5AgOalyaDfSVb33H+YtS/xmjZUv2Y9SMFrVvHk+xXaNtEsM0ZKHJ5BR7LXY57i3FB9akKTUS1x83HBt8AceM7T81p6Iyo4wIe8BCl7d/V3p5cGBC0vLgJPOqoF055gCUbb6hWHYEyv2dkeQDCEpciWCJVb5D7AY2onR+X/tYeOvC8XaGbmP1srbhY6GcT2P2cCOgH5MEv7/xGUAx7tISZWSUB0qbQ9kiYr5ink4vnXLphXA95GNtxLforzPl3OUzeIson++dLtGp7Fnq1A9mXXwM9Won3Op5kGx0KEVQnhcdfCfyX6TxAoYxliY/K/f7CMbcerT8kXV2qupthpWNW467IwmMwDNY56eHHAd72kov0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9e14f1-6d3d-4c98-da2c-08d6f452607e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 01:06:35.9397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDE4LCAyMDE5
IDg6NTkgUE0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzog
cy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207DQo+IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZzsNCj4gQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gc29jOiBpbXg6IEFkZCBpLk1YOE1OIFNvQyBkcml2ZXIgc3VwcG9ydA0K
PiANCj4gT24gVHVlLCBKdW4gMTgsIDIwMTkgYXQgMDg6MjQ6NTlBTSArMDAwMCwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gSGksIFNoYXduDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+ID4g
PiBTZW50OiBUdWVzZGF5LCBKdW5lIDE4LCAyMDE5IDM6MDQgUE0NCj4gPiA+IFRvOiBBbnNvbiBI
dWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPiA+IENjOiBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBmZXN0ZXZhbUBnbWFpbC5jb207IExl
b25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Ow0KPiA+ID4gdmlyZXNoLmt1
bWFyQGxpbmFyby5vcmc7IEFiZWwgVmVzYSA8YWJlbC52ZXNhQG54cC5jb20+Ow0KPiA+ID4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIHNvYzogaW14OiBBZGQgaS5NWDhNTiBTb0MgZHJpdmVyIHN1cHBv
cnQNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIEp1biAxMSwgMjAxOSBhdCAwOTozMToyNUFNICswODAw
LCBBbnNvbi5IdWFuZ0BueHAuY29tDQo+IHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBwYXRjaCBhZGRz
IGkuTVg4TU4gU29DIGRyaXZlciBzdXBwb3J0Og0KPiA+ID4gPg0KPiA+ID4gPiByb290QGlteDht
bmV2azp+IyBjYXQgL3N5cy9kZXZpY2VzL3NvYzAvZmFtaWx5IEZyZWVzY2FsZSBpLk1YDQo+ID4g
PiA+DQo+ID4gPiA+IHJvb3RAaW14OG1uZXZrOn4jIGNhdCAvc3lzL2RldmljZXMvc29jMC9tYWNo
aW5lIE5YUCBpLk1YOE1OYW5vDQo+ID4gPiBERFI0DQo+ID4gPiA+IEVWSyBib2FyZA0KPiA+ID4g
Pg0KPiA+ID4gPiByb290QGlteDhtbmV2azp+IyBjYXQgL3N5cy9kZXZpY2VzL3NvYzAvc29jX2lk
IGkuTVg4TU4NCj4gPiA+ID4NCj4gPiA+ID4gcm9vdEBpbXg4bW5ldms6fiMgY2F0IC9zeXMvZGV2
aWNlcy9zb2MwL3JldmlzaW9uDQo+ID4gPiA+IDEuMA0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+
ID4gPiA+ICBkcml2ZXJzL3NvYy9pbXgvc29jLWlteDguYyB8IDEzICsrKysrKysrKysrKy0NCj4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDguYw0K
PiA+ID4gPiBiL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OC5jIGluZGV4IDM4NDJkMDkuLjAyMzA5
YTIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OC5jDQo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OC5jDQo+ID4gPiA+IEBAIC01NSw3ICs1
NSwxMiBAQCBzdGF0aWMgdTMyIF9faW5pdCBpbXg4bW1fc29jX3JldmlzaW9uKHZvaWQpDQo+ID4g
PiA+ICAJdm9pZCBfX2lvbWVtICphbmF0b3BfYmFzZTsNCj4gPiA+ID4gIAl1MzIgcmV2Ow0KPiA+
ID4gPg0KPiA+ID4gPiAtCW5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwg
ImZzbCxpbXg4bW0tYW5hdG9wIik7DQo+ID4gPiA+ICsJaWYgKG9mX21hY2hpbmVfaXNfY29tcGF0
aWJsZSgiZnNsLGlteDhtbSIpKQ0KPiA+ID4gPiArCQlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9u
b2RlKE5VTEwsIE5VTEwsICJmc2wsaW14OG1tLQ0KPiA+ID4gYW5hdG9wIik7DQo+ID4gPiA+ICsJ
ZWxzZSBpZiAob2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14OG1uIikpDQo+ID4gPiA+
ICsJCW5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgImZzbCxpbXg4bW4t
DQo+ID4gPiBhbmF0b3AiKTsNCj4gPiA+DQo+ID4gPiBDYW4gd2UgaGF2ZSB0aGlzIGFuYXRvcCBj
b21wYXRpYmxlIGluIGlteDhfc29jX2RhdGEsIHNvIHRoYXQgd2UgbWF5DQo+ID4gPiBzYXZlIHRo
ZSBjYWxsIHRvIG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgpPw0KPiA+DQo+ID4gRG8geW91IG1l
YW4gYWRkaW5nIGEgdmFyaWFibGUgbGlrZSAiIGNvbnN0IGNoYXIgKmFuYXRvcF9jb21wYXQgIiBp
bg0KPiA+IGlteDhfc29jX2RhdGUgc3RydWN0dXJlLCB0aGVuIGluaXRpYWxpemUgaXQgYWNjb3Jk
aW5nIHRvIFNvQyB0eXBlLCBhbmQNCj4gPiBpbiBpbXg4bW1fc29jX3JldmlzaW9uKCksIGdldCB0
byBzb2NfZGF0YSdzIGFuYXRpb19jb21wYXQgdG8gZmluZCB0aGUNCj4gPiBhbmF0b3Agbm9kZT8g
SWYgeWVzLCB3ZSBoYXZlIHRvIGFkZCBzb21lIGNvZGUgdG8gZ2V0IHRoZSBzb2NfZGF0YSBpbiB0
aGlzDQo+IGZ1bmN0aW9uLCBvciBtYXliZSB3ZSBjYW4gcGFzcyBhbmF0b3AgY29tcGF0aWJsZSBu
YW1lIGFzIC5zb2NfcmV2aXNpb24ncw0KPiBwYXJhbWV0ZXI/DQo+ID4NCj4gPiBzdGF0aWMgY29u
c3Qgc3RydWN0IGlteDhfc29jX2RhdGEgaW14OG1uX3NvY19kYXRhID0gew0KPiA+ICAgICAgICAg
IC5uYW1lID0gImkuTVg4TU4iLA0KPiA+ICAgICAgICAgIC5zb2NfcmV2aXNpb24gPSBpbXg4bW1f
c29jX3JldmlzaW9uLA0KPiA+ICAgICAgICAgIC5hbmF0b3BfY29tcGF0ID0gImZzbCxpbXg4bW4t
YW5hdG9wIiwgfTsNCj4gDQo+IE9rYXksIGp1c3QgcmVhbGl6ZWQgdGhhdCB3ZSBvbmx5IHdhbnQg
dG8gaGFuZGxlIGlteDhtbiB3aXRoIGlteDhtbQ0KPiBmdW5jdGlvbi4gIEl0IG1ha2VzIGxlc3Mg
c2Vuc2UgdG8gYWRkIGFuYXRvcCBjb21wYXRpYmxlIGludG8gaW14OF9zb2NfZGF0YQ0KPiBqdXN0
IGZvciB0aGF0Lg0KPiANCj4gU28gaXQgbG9va3MgbGlrZSB0aGF0IGlteDhtbiBpcyBoaWdobHkg
Y29tcGF0aWJsZSB3aXRoIGlteDhtbSwgaW5jbHVkaW5nDQo+IGFuYXRvcCBibG9jaz8gIElmIHRo
YXQncyB0aGUgY2FzZSwgbWF5YmUgd2UgY2FuIGhhdmUgY29tcGF0aWJsZSBvZiBpbXg4bW4NCj4g
YW5hdG9wIGxpa2UgYmVsb3csIHNvIHRoYXQgd2UgY2FuIHNhdmUgYWJvdmUgY2hhbmdlcz8NCj4g
DQo+IAljb21wYXRpYmxlID0gImZzbCxpbXg4bW4tYW5hdG9wIiwgImZzbCxpbXg4bW0tYW5hdG9w
IjsNCg0KTWFrZSBzZW5zZSwgSSBqdXN0IHNlbnQgb3V0IFYyIHdpdGggdGhpcyBhcHByb2FjaCwg
YW5kIHdpbGwgYWRkIHRoZSAiZnNsLGlteDhtbS1hbmF0b3AiDQphcyBpLk1YOE1OIEFOQVRPUCBm
YWxsYmFjayBjb21wYXRpYmxlIHdoZW4gSSBuZWVkIHRvIHJlc2VuZCB0aGUgaS5NWDhNTiBEVCBw
YXRjaCBzZXJpZXMuDQoNClRoYW5rcywNCkFuc29uDQoNCj4gDQo+IFNoYXduDQo=
