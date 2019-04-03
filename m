Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BEEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF0321473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IDBwSGok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfDCHie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:38:34 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:9445
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbfDCHic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do7IhXquNXyTOHVIjdKBffrN/LZi3sPRhjpn27sR8Bs=;
 b=IDBwSGok0SxayYQC6vwAkDf0LZ4nE+O6CrVn/Fk5Kr7f3RcnIkf83Qycbij++UMx0YhaD0wvevnTTDrAOgY7vcDGMApoqgL+WedxfSwnGg0GXlLdmJ2rWPZ4sDKbiQ0MrP/5Z52RGhxN5dUf1vQkSE7Dj+cA5i3ZuS1dBzFrjPk=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4976.eurprd04.prod.outlook.com (20.177.49.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Wed, 3 Apr 2019 07:38:25 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23%2]) with mapi id 15.20.1750.014; Wed, 3 Apr 2019
 07:38:25 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Igor Plyatov <plyatov@gmail.com>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: Issues with i.MX SPI DMA transfers
Thread-Topic: Issues with i.MX SPI DMA transfers
Thread-Index: AQHU5MQedyysM/Gs0UKoyWKgyiIok6YgnCuAgAADPICAACYCkIAAHYGAgAEpjtCABnMWgIAAEhKQgABAWQCAAT6NAA==
Date:   Wed, 3 Apr 2019 07:38:24 +0000
Message-ID: <VI1PR04MB4543DEA3C0CED159C472E85F89570@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
 <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <197990d4-b1e2-8db9-0cb7-87b860f23bd7@gmail.com>
In-Reply-To: <197990d4-b1e2-8db9-0cb7-87b860f23bd7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc0ccef-be6d-49d4-ffd8-08d6b8075b24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4976;
x-ms-traffictypediagnostic: VI1PR04MB4976:
x-microsoft-antispam-prvs: <VI1PR04MB4976002FCEDE1B5EA1AA7E8089570@VI1PR04MB4976.eurprd04.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(13464003)(45904002)(3846002)(7696005)(5024004)(74316002)(33656002)(86362001)(52536014)(6916009)(26005)(7736002)(54906003)(256004)(106356001)(71190400001)(71200400001)(446003)(9686003)(4326008)(8676002)(81156014)(478600001)(55016002)(68736007)(8936002)(6246003)(186003)(81166006)(25786009)(97736004)(105586002)(486006)(7416002)(53936002)(76176011)(476003)(229853002)(53546011)(14454004)(6506007)(102836004)(6436002)(11346002)(99286004)(66066001)(93886005)(6116002)(1411001)(2906002)(316002)(305945005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4976;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /86/yjswOqyx8vYcK1wCxxOPX7/lJvaqI06GQMlIRH0iKewEipPJt0qTrQ9a5tmCeSfkEd0FGBPXakbQKg/T89VlK3Ix5JG1dybcmDMfEsUC4uMuuhHy5syALwxr7Haeg9qwgjoC+XEfGNoNBShzATpNjKmirEKbB3sEQ4RdUafl4TK9yLjK/bbsMabn3ByA3AuhyEXQiKyz2usqgdmwIH1AXOTwMG4q/VgxXHJKTqrVdJfw91njgROy3c7FfbXD1Ll8VReHs4k+njgiuAP0azZ7Zc4BwXzMC0Z/C+EacldNP6kL0rFGjlcYzFWzwjCP942Asealg9YcL3EEI4CpqvtsIjitTHR4uH5O/MdHGhjXYi2jjVRfIT+9CWzXlO74qC/XaihHHgeiND1Yrxem/2XvM9PwEC3+Sma0E+FP4FU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc0ccef-be6d-49d4-ffd8-08d6b8075b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 07:38:25.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4976
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZ29yIFBseWF0b3YgPHBseWF0
b3ZAZ21haWwuY29tPg0KPiBTZW50OiAyMDE55bm0NOaciDLml6UgMjA6MTUNCj4gVG86IFJvYmlu
IEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gQ2M6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXNwaUB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBGYWJpbyBF
c3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgTWFyayBCcm93biA8
YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgVmlub2Qg
S291bCA8dmtvdWxAa2VybmVsLm9yZz47IERhbiBXaWxsaWFtcw0KPiA8ZGFuLmoud2lsbGlhbXNA
aW50ZWwuY29tPjsgQW5keSBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPjsgSGFuIFh1DQo+IDxo
YW4ueHVAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IElzc3VlcyB3aXRoIGkuTVggU1BJIERNQSB0cmFuc2ZlcnMNCj4gDQo+IERlYXIg
Um9iaW4sDQo+IA0KPiA+PiBub3cgSSBoYXZlIHJldmVydGVkIHBhdGNoIGFkMGQ5MmQ3YmE2YS4N
Cj4gPj4gUGF0Y2hlcyAwMDAxLWRtYS1lbmdpbmUtaW14LXNkbWEtYWRkLW1jdV8yX2Vjc3BpLXNj
cmlwdC5wYXRjaCBhbmQNCj4gPj4gMDAwMi1zcGktc3BpLWlteC1maXgtRVJSMDA5MTY1LnBhdGNo
IGFyZSBhcHBsaWVkLg0KPiA+Pg0KPiA+Pg0KPiA+PiBLZXJuZWwgbG9nIHNob3cgbWVzc2FnZXMN
Cj4gPj4NCj4gPj4gW8KgwqAgMjkuMjAyNjM5XSBpbXgtc2RtYSAyMGVjMDAwLnNkbWE6IGxvYWRl
ZCBmaXJtd2FyZSAzLjMgWw0KPiA+PiAyOS4yMzg1OTVdIHNwaV9pbXggMjAwODAwMC5zcGk6IHBy
b2JlZCBbwqDCoCAyOS4yNDI4MDJdIHNwaV9pbXgNCj4gPj4gMjAwYzAwMC5zcGk6IHByb2JlZCBb
wqDCoCAyOS4yNDUyMTddIHNwaV9pbXggMjAxODAwMC5zcGk6IHByb2JlZA0KPiA+Pg0KPiA+PiBT
UEkgRE1BIHRyYW5zZmVycyBzdGlsbCBub3Qgd29yay4NCj4gPj4NCj4gPj4gSWYgSSB0ZXN0IDMy
IGJ5dGUgdHJhbnNmZXJzLCB0aGVuIHRoZXkgd29yayBmaW5lLiBCdXQgNjQgYnl0ZQ0KPiA+PiB0
cmFuc2ZlcnMgZmFpbHMgYWx3YXlzIGFuZCBJIHNlZSBlcnJvciBtZXNzYWdlcw0KPiA+Pg0KPiA+
PiByb290QGNyNzp+IyBzcGlkZXZfdGVzdCAtRCAvZGV2L3NwaWRldjQuMSAtcyAxMjAwMDAwIC1i
IDggLVMgNjQgLUkgMQ0KPiA+PiAtbCBzcGkgbW9kZTogMHgyMCBiaXRzIHBlciB3b3JkOiA4IG1h
eCBzcGVlZDogMTIwMDAwMCBIeiAoMTIwMCBLSHopIFsNCj4gPj4gNDIzLjY4NjczNl0gc3BpX21h
c3RlciBzcGk0OiBJL08gRXJyb3IgaW4gRE1BIFJYIFvCoCA0MjMuNjkxMzkyXQ0KPiA+PiBzcGlk
ZXYgc3BpNC4xOiBTUEkgdHJhbnNmZXIgZmFpbGVkOiAtMTEwIFvCoCA0MjMuNjk2MzgyXSBzcGlf
bWFzdGVyDQo+ID4+IHNwaTQ6IGZhaWxlZCB0byB0cmFuc2ZlciBvbmUgbWVzc2FnZSBmcm9tIHF1
ZXVlIGNhbid0IHNlbmQgc3BpDQo+ID4+IG1lc3NhZ2U6IENvbm5lY3Rpb24gdGltZWQgb3V0IEFi
b3J0ZWQgKGNvcmUgZHVtcGVkKQ0KPiA+Pg0KPiA+PiBJIHN1cHBvc2UsIHRyYW5zZmVycyBzaG9y
dGVyIHRoZW4gNjQgYnl0ZXMgbWFkZSB3aXRoIGhlbHAgb2YgUElPLg0KPiA+Pg0KPiA+PiBSb2Jp
biwgaXMgdGhlcmUgYW55IGNoYW5jZSBmb3IgeW91IHRvIGZpbmQgc29tZSB0aW1lIGFuZCBsb29r
IGF0IHRoaXMNCj4gPj4gaXNzdWUgYWdhaW4/DQo+ID4gSSBoYXZlIHF1aWNrIHRlc3Qgd2l0aCBz
cGlkZXZfdGVzdCBsb29wYmFjaywgYnV0IGRpZG4ndCBtZWV0IHlvdXINCj4gPiBlcnJvciwgSXMg
eW91ciBjb2RlIHRoZSBhbG1vc3QgbGF0ZXN0IGNvZGUgaW4gbGludXgtbmV4dCBhcyBtaW5lPw0K
PiA+DQo+ID4gcm9vdEBpbXg2cXBkbHNvbG94On4jIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIHwgZ3Jl
cCBzZG1hDQo+ID4gICA0ODogICAgICAgICAzNyAgICAgICBHUEMgICAyIExldmVsICAgICBzZG1h
DQo+ID4gICAtbHRAaW14NnFwZGxzb2xveDp+IyAuL3NwaWRldl90ZXN0IC1EIC9kZXYvc3BpZGV2
MC4wIC1zIDEyMDAwMDAgLWIgOA0KPiA+IC1TIDY0IC1JIDEgLWwgc3BpIG1vZGU6IDB4MjAgYml0
cyBwZXIgd29yZDogOCBtYXggc3BlZWQ6IDEyMDAwMDAgSHoNCj4gPiAoMTIwMCBLSHopIHJvb3RA
aW14NnFwZGxzb2xveDp+IyBjYXQgL3Byb2MvaW50ZXJydXB0cyB8IGdyZXAgc2RtYQ0KPiA+ICAg
NDg6ICAgICAgICAgNDMgICAgICAgR1BDICAgMiBMZXZlbCAgICAgc2RtYQ0KPiA+IC4vc3BpZGV2
X3Rlc3QgLUQgL2Rldi9zcGlkZXYwLjAgLXMgMTIwMDAwMCAtYiA4IC1TIDUxMiAtSSAxIC1sIHNw
aQ0KPiA+IG1vZGU6IDB4MjAgYml0cyBwZXIgd29yZDogOCBtYXggc3BlZWQ6IDEyMDAwMDAgSHog
KDEyMDAgS0h6KQ0KPiA+IHRvdGFsOiB0eCAwLjVLQiwgcnggMC41S0INCj4gDQo+IA0KPiBNeSBw
cmV2aW91cyB0ZXN0IHJlc3VsdHMgYmFzZWQgb24ga2VybmVsIGZyb20gIm1haW4iIGJyYW5jaCBv
Zg0KPiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFs
ZHMvbGludXguZ2l0Lg0KPiANCj4gTm93IEkgaGF2ZSB0ZXN0ZWQga2VybmVsIGZyb20gIm1haW4i
IGJyYW5jaCBvZg0KPiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvbmV4dC9saW51eC1uZXh0LmdpdC4NCj4gDQo+IEl0cyBsYXRlc3QgY29tbWl0IGlzIDA1ZDA4
ZTI5OTVjYmU2ZWZkYjk5MzQ4MmVlMGQzOGE3NzA0MDg2MWEuDQo+IA0KPiBBZGRpdGlvbmFsbHks
IEkgaGF2ZSByZXZlcnRlZCBwYXRjaCBhZDBkOTJkN2JhNmEgYW5kIGFwcGx5IHlvdXJzIHBhdGNo
ZXMNCj4gMDAwMS1kbWEtZW5naW5lLWlteC1zZG1hLWFkZC1tY3VfMl9lY3NwaS1zY3JpcHQucGF0
Y2ggYW5kDQo+IDAwMDItc3BpLXNwaS1pbXgtZml4LUVSUjAwOTE2NS5wYXRjaC4NCj4gDQo+IERp
ZmZlcmVuY2UgYmV0d2VlbiAwNWQwOGUyOTk1Y2JlNmVmZGI5OTM0ODJlZTBkMzhhNzcwNDA4NjFh
IGFuZA0KPiBjdXJyZW50IHN0YXRlIG9mIGRyaXZlcnMgYXR0YWNoZWQgYXMgc3BpLWFuZC1zZG1h
LWRyaXZlcnMuZGlmZi4NCj4gDQo+IFNQSSBkcml2ZXIgc3RpbGwgbm90IHdvcmsuIEl0IGhhcyBz
YW1lIHJlc3VsdCBhcyBmcm9tIG15IHByZXZpb3VzIGVtYWlsLg0KPiANCj4gTG9va3MgYXMgeW91
IHVzZSBlaXRoZXIgZGlmZmVyZW50IEdJVCBicmFuY2ggb2Yga2VybmVsIG9yIHlvdSBoYXZlIGZv
cmdldCB0byBzYXkNCj4gbWUgYWJvdXQgc29tZSBwYXRjaC4NClRoZSBzYW1lIGJhc2UgYXMgeW91
ciBzaWRlIGNvbW1pdCAnMDVkMDhlMjk5NWNiZTZlZmRiOTkzNDgyZWUwZDM4YTc3MDQwODYxYSAn
IGFuZA0Kc2FtZSBkaWZmLCBidXQgZGlkIHlvdSByZXZlcnQgYW5vdGhlciBzZG1hIHBhdGNoIGFi
b3V0ICJjbGtfcmF0aW8iIHdoaWNoIGJyb2tlIHNkbWEgYmFzaWMNCmZ1bmN0aW9uIG9uIG5vbi1p
Lm14OG0gY2hpcHM/DQoNCmNvbW1pdCAyNWFhYTc1ZGYxZTY1OTkwMWQ3NzA4NWJjZGQyNWVhYWJm
MjY1Njg4DQpBdXRob3I6IEFuZ3VzIEFpbnNsaWUgKFB1cmlzbSkgPGFuZ3VzQGFra2VhLmNhPg0K
RGF0ZTogICBNb24gSmFuIDI4IDA5OjAzOjIxIDIwMTkgLTA3MDANCg0KICAgIGRtYWVuZ2luZTog
aW14LXNkbWE6IGFkZCBjbG9jayByYXRpbyAxOjEgY2hlY2sNCg0KICAgIE9uIGkubXg4IG1zY2Fs
ZSBCMCBjaGlwLCBBSEIvU0RNQSBjbG9jayByYXRpbyAyOjEgY2FuJ3QgYmUgc3VwcG9ydHRlZCwN
CiAgICBzaW5jZSBTRE1BIGNsb2NrIHJhdGlvIGhhcyB0byBiZSBpbmNyZWFzZWQgdG8gMjUwTWh6
LCBBSEIgY2FuJ3QgcmVhY2gNCiAgICB0byA1MDBNaHosIHNvIHVzZSAxOjEgaW5zdGVhZC4NCj4g
DQo+IEJlc3Qgd2lzaGVzLg0KPiANCj4gLS0NCj4gDQo+IElnb3IgUGx5YXRvdg0KDQo=
