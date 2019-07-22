Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4211C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0E421842
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ubc8wuAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfGVCPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:15:17 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:31717
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfGVCPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:15:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJFRj+lJcZ9LZ/d3V97BUKM4yeLncVnUY4ILFovEqAiez2krXXX+70ecknHcsVGv+u7Em6eIOkStHJnuZCoATCOIU0+MrY74tspb/R8Iat0mBnLY3zKWe6s6Js5lo95p3CikIqrB19v1+CJh5E6cl5PKHeCGN8Xdx0IKbWSwYwfHK8drN4QREsGfSXHwwOrH03/22Ns5Bma4TFZ2T/1WT1ZakoWCoAkwjkkim/DlkoYlmQEge1AHHDFYRv8pkBP4g3uVRz7LvGLwhwu37xNrQBvY0PNrSeW2w32sVgfia1AeqBbv9QHZ7lOjwaXfH2LYk7YOKgi2gT3FBpQYrmZ1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgHb+wEpLpELxsiMuCNsbGv/oXxbJJEAmGp263+hXzw=;
 b=Ysw/6VS7XbXdJpSHsusGTcGbhAyGIbOs7uWuevz4H0xj0A559CY86fduJI1yvCui+3Ub+SROEsYA9nMG5RMOy+iEXZYKEecaROLMITFnIV6vGa/Qo0T6NAc3qYYKZbb4xfrRbki5l2U1nbh23BBqBJ7I3zWHOztTIcPpHRDQ/By2uE1G64X+gCMFcwhFGO461XR82f5EhU2nh+vaPqc5tNDkShcF+VJxRF8elwXgKKYsHarHKQovAx2iGf43NFYa2Mz3Jmtw9Y/hMY/D+OQUjVZWUWt4R2+F7MjjZJDk8OAj+0aRnfbMxDzyBCZdEzYdre0/WPLHXy4+Thu1Ch0dxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgHb+wEpLpELxsiMuCNsbGv/oXxbJJEAmGp263+hXzw=;
 b=Ubc8wuAuN3v4RJ0rDcORxHMeh+HPEkaxDsRD+aE+U/KMUdVnXwnG0c+Eot4B1zFh+sKfFgdcwTXuyNSCbVke4IHajCcp9YffcnDLV7fi1U/POYhM0bbFX1Xs172vUJRWws6IC0TN8hr98xPVY5p+AmgGXH2syCHNY4rC01WDFQ4=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3367.eurprd04.prod.outlook.com (52.133.18.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 02:15:11 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::159f:a865:b9dc:4476]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::159f:a865:b9dc:4476%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 02:15:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "will@kernel.org" <will@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Thread-Topic: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Thread-Index: AQHVJ/+7WzrDWTethU+K40MoFm49OKaqFzaAgAABdQCAAADrQIAr+OGAgAAC+uA=
Date:   Mon, 22 Jul 2019 02:15:10 +0000
Message-ID: <AM6PR0402MB39113A76EE8A63F9C9F589C1F5C40@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190624022200.GN3800@dragon> <20190624022713.GO3800@dragon>
 <DB3PR0402MB39162662C69B45BDB948D002F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190722020026.GQ3738@dragon>
In-Reply-To: <20190722020026.GQ3738@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa4dd81c-1afe-47d7-d24d-08d70e4a6caf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3367;
x-ms-traffictypediagnostic: AM6PR0402MB3367:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR0402MB3367B67E3046CEBB6B2E96ECF5C40@AM6PR0402MB3367.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(189003)(199004)(13464003)(99286004)(66066001)(14444005)(256004)(316002)(14454004)(102836004)(44832011)(53546011)(7416002)(7696005)(6506007)(76176011)(4326008)(966005)(66946007)(5660300002)(76116006)(52536014)(6246003)(68736007)(229853002)(86362001)(66446008)(64756008)(66556008)(66476007)(54906003)(6116002)(3846002)(25786009)(9686003)(446003)(11346002)(6306002)(53936002)(55016002)(476003)(8676002)(81156014)(6916009)(2906002)(26005)(186003)(7736002)(8936002)(71200400001)(71190400001)(478600001)(6436002)(74316002)(486006)(33656002)(305945005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3367;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ys2IUNQaGeY2MY7kQ5SEMjuS5WZ/2MkVtAiHmKa5cdSOeHBdqrbIqrTMjhyehVz2FGyPhy+JU7KBKCo7PFMHHFbY/w2Xs0aGZirxj3kwmG6t4Bx6BtK0c6IBaP8gBpOlpjFCSG7bJxny4iBvw+UmiuEvuPVn5OWRURC1+QgymzH3kZ2j0MbthZf6Vz4qAdA/sxP7RNoHs3mMPJpmEq93vxvVCgZgivOKHf9lTfMv1cRQ9WLTSzPHZr8cBH7MicJ0iV9ZpbwfyPc9/XoGVvyMdBVhfw5x2VgNdfQyoLfBqaNjJNpdlK5au1APm/poh+EYIEjkN5G9o0ku/56bKYllcVAtqq07+0kEnaQG1OzKsc8aWL2yqz4gHDlOS6qmEkYAtwnKnY1rcspZ4208LPMX3QvemxL8FMOObbPbpUouVT8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4dd81c-1afe-47d7-d24d-08d70e4a6caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 02:15:10.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gT24gTW9uLCBKdW4gMjQsIDIwMTkgYXQgMDI6MzU6MTBBTSArMDAwMCwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gSGksIFNoYXduDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+DQo+ID4gPiBTZW50OiBNb25kYXksIEp1bmUgMjQsIDIwMTkgMTA6MjcgQU0NCj4gPiA+IFRv
OiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPiA+IENjOiBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+IFBlbmcN
Cj4gPiA+IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IGZlc3RldmFtQGdtYWlsLmNvbTsgSmFja3kg
QmFpDQo+ID4gPiA8cGluZy5iYWlAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBzYm95ZEBrZXJuZWwub3JnOw0KPiA+ID4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LQ0KPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
RGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsNCj4gPiA+IGxpbnV4LSBjbGtA
dmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgt
DQo+ID4gPiBpbXhAbnhwLmNvbT47IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgTGVvbmFyZCBDcmVz
dGV6DQo+ID4gPiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyB3aWxsQGtlcm5lbC5vcmc7IG10
dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzRdIGFybTY0OiBFbmFibGUgVElNRVJfSU1YX1NZU19DVFIgZm9yDQo+ID4g
PiBBUkNIX01YQyBwbGF0Zm9ybXMNCj4gPiA+DQo+ID4gPiBPbiBNb24sIEp1biAyNCwgMjAxOSBh
dCAxMDoyMjowMUFNICswODAwLCBTaGF3biBHdW8gd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgSnVu
IDIxLCAyMDE5IGF0IDAzOjA3OjE3UE0gKzA4MDAsIEFuc29uLkh1YW5nQG54cC5jb20NCj4gd3Jv
dGU6DQo+ID4gPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBBUkNIX01YQyBwbGF0Zm9ybXMgbmVlZHMgc3lzdGVtIGNvdW50
ZXIgYXMgYnJvYWRjYXN0IHRpbWVyIHRvDQo+ID4gPiA+ID4gc3VwcG9ydCBjcHVpZGxlLCBlbmFi
bGUgaXQgYnkgZGVmYXVsdC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ICBhcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zIHwgMSArDQo+ID4gPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMNCj4gPiA+ID4gPiBiL2FyY2gvYXJtNjQvS2Nv
bmZpZy5wbGF0Zm9ybXMgaW5kZXggNDc3OGM3Ny4uZjVlNjIzZiAxMDA2NDQNCj4gPiA+ID4gPiAt
LS0gYS9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zDQo+ID4gPiA+ID4gKysrIGIvYXJjaC9h
cm02NC9LY29uZmlnLnBsYXRmb3Jtcw0KPiA+ID4gPiA+IEBAIC0xNzMsNiArMTczLDcgQEAgY29u
ZmlnIEFSQ0hfTVhDDQo+ID4gPiA+ID4gIAlzZWxlY3QgUE0NCj4gPiA+ID4gPiAgCXNlbGVjdCBQ
TV9HRU5FUklDX0RPTUFJTlMNCj4gPiA+ID4gPiAgCXNlbGVjdCBTT0NfQlVTDQo+ID4gPiA+ID4g
KwlzZWxlY3QgVElNRVJfSU1YX1NZU19DVFINCj4gPiA+ID4NCj4gPiA+ID4gV2hlcmUgaXMgdGhh
dCBkcml2ZXI/DQo+ID4gPg0KPiA+ID4gT2theSwganVzdCBmb3VuZCBpdCBpbiB0aGUgbWFpbGJv
eC4gIFRoZXkgc2VlbSB0byBiZSBzZW50IGluIHRoZSB3cm9uZw0KPiBvcmRlci4NCj4gPiA+IFJl
YWxseSwgeW91IHNob3VsZCBzZW5kIHRoaXMgc2VyaWVzIG9ubHkgYWZ0ZXIgdGhlIGRyaXZlciBs
YW5kcyBvbiBtYWlubGluZS4NCj4gPg0KPiA+IE9LLCBqdXN0IG5vdGljZWQgdGhhdCBtYWlubGlu
ZSBkb2VzIE5PVCBoYXZlIGl0LCBzaW5jZSBJIGRpZCBpdCBiYXNlZCBvbiBuZXh0DQo+IHRyZWUu
DQo+ID4gSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2ggc2VyaWVzIGFmdGVyIHRoZSBzeXN0ZW0gY291
bnRlciBkcml2ZXIgbGFuZGluZyBvbg0KPiBtYWlubGluZS4NCj4gDQo+IEkganVzdCBwaWNrZWQg
dGhlIHNlcmllcyB1cCwgc28gbm8gbmVlZCB0byByZXNlbmQuDQoNClNvbWV0aGluZyBjaGFuZ2Vk
IGZvciB0aGlzIHNlcmllcywgdGhlIHN5c3RlbSBjb3VudGVyIGNsb2NrIHJlbGF0ZWQgaW1wbGVt
ZW50YXRpb24NCmFyZSBjaGFuZ2VkIGFmdGVyIHNvbWUgY29tbWVudHMgZnJvbSBtYWludGFpbmVy
LCBzbyBJIHRoaW5rIHlvdSBzaG91bGQgcGlja2VkIHVwDQpiZWxvdyBwYXRjaCBzZXJpZXMgaW5z
dGVhZCwgYW5kIGRyb3AgdGhpcyBzZXJpZXMsDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcGF0Y2gvMTEwMzc5NTMvDQoNCnRoYW5rcywNCkFuc29uDQogDQoNCg0K
