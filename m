Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693BFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2623220675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YOflaplv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCGM4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:56:11 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:52325
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbfCGM4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrYOTz04Z+eOGiCrRRBPIuX65VoO/KxhayLDi/Q9WU8=;
 b=YOflaplvo0vAAg9YVFjnM8nPNhTb/WAnPdMrrDaU4GuLvsmwzw5bRQKYxg7OTQp9IpbaNiEhZFNh4LMeLRcwpaELPpZ9rK4+s5c/YoBlwcEVrzzpiWluvqNy/gA9UoGz8dZf3DaD52AcBpzZGrZUdea0Jhmnn077C55b55qWzTE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Thu, 7 Mar 2019 12:56:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 12:56:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] clk: imx8mq: add hdmi_phy_27m clock as pll's
 reference clock
Thread-Topic: [PATCH 2/3] clk: imx8mq: add hdmi_phy_27m clock as pll's
 reference clock
Thread-Index: AQHU1JeWR8aGkQFpX0a5WAuTNkYI2aYAEvKAgAANbiA=
Date:   Thu, 7 Mar 2019 12:56:04 +0000
Message-ID: <DB3PR0402MB391694C610CA6B7027376E4CF54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
         <1551929772-22633-2-git-send-email-Anson.Huang@nxp.com>
 <1551960333.9298.37.camel@pengutronix.de>
In-Reply-To: <1551960333.9298.37.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eadafd57-e28b-4976-a8a5-08d6a2fc427a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3770;
x-ms-traffictypediagnostic: DB3PR0402MB3770:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM3NzA7MjM6NDBOMEtDQ1hXTy9NbklrMnVjMXBnZTR2?=
 =?utf-8?B?UUpBZVc2ajl1WWpPSnVNRElQcnVsY2l1UjE0MHJSNFFObGZpdHNURThPSzNp?=
 =?utf-8?B?QWpHTjgybVR0bU41MXdnK1lRb003RXpmNjB6aWVoSGNuQmpkMVlpdHJNV1hq?=
 =?utf-8?B?V3h5Q0Zjam1SZGVoWitGQ3NWMi9yWUQ3bFBQS1dCWmF0L2hIN1k1RHQzUWJT?=
 =?utf-8?B?Vy9QRnRsa0w0NlFzZ2kvS1AweVRnYnltMVBmcnkrUHg4UzZLazI5aVJyZW4z?=
 =?utf-8?B?azNJcXk3TDJ6TWF4SzhmeENiSFRrL2wyN0txRWxKK21hRnYyMzZxYzQ0Um5r?=
 =?utf-8?B?dEF6MVF6QVNheUl1KzM1V20rOXRUa0Y4eGxiR2tnV0hNUC9TUmJUeTAvU2ho?=
 =?utf-8?B?SUxZNG92ckhKS09mSW9BNUwwcWJwVDZNLy9pZ2Yra2dUbzYwZ0J3L0RJRWJJ?=
 =?utf-8?B?U3dQY29pMW54Sm0valYxMzNIc2FOOUhlaS9rbm53Z2N4c082NG5idjZHK29n?=
 =?utf-8?B?Qm4wbTNDRUpwdjhQNlBiY05BRzFFZ1hLS29WZVB0ZkpvV01jV0JieHZYeHVi?=
 =?utf-8?B?SEg4cXFoV1VzdFZ5TWZ4SzFWL2xrUUFvb3YzWU5hOHMyU3V6bld1bU5HQnZB?=
 =?utf-8?B?ejVrZW5WQW9OZWJ6d1FIcS9GRWp4bjhOdGZyV2srZXh0dGdnNlBuZk1vTVBO?=
 =?utf-8?B?UFYwUlIzdldDZU0vMVdncEFDVVlCS1Y0elZqTHJwbmVqNWtTMHVYYUxGZVNJ?=
 =?utf-8?B?SEYrOUtGRTF4NlFiM3BnRG53QUc2dnpxU1hRNk5aSHFrZndqV2JxdnFvNXBn?=
 =?utf-8?B?dG5Jektib3QzV0pDa1Z3eGwzVHRhWm5FRTFJQjBPVE8vaCtOZFVzZUtjbXRs?=
 =?utf-8?B?UnlWcmJ1N3VpZG5WMUlRMnM0NTRBa3FFS3dvR1E1ejBDU2djME5HQUFxY3Z1?=
 =?utf-8?B?ZUNLeFRFdFExVkdLZFhLVmFPK3htVW55Rzl0U2F0WHAyTS9zZ0tHRTlMTVN4?=
 =?utf-8?B?MUdXdDBRVFpZME9WT25WY1ErbUlvVnhENGpjNkdoSXRIVXc3cXlEdUJCclpx?=
 =?utf-8?B?NzBmSG5HSGI5TTZnUDZwTFRueHNoZE45b1JwQUJhUXZSenA4ZUtUNVQ4RUFp?=
 =?utf-8?B?OHNiNm1HTGhOY1JDdEFMT3loUnRvaEtCa1cwNjhGemZUTSt2QXZrb2hOeTNh?=
 =?utf-8?B?OHRYNTl5MUMrd0hlZURzaUdNYlBwdnNDOExhcTQvNE9VN3lWNGp6V29CWCtB?=
 =?utf-8?B?Z2tYaGp6azRPakxjYUdlYUF0MExFQTJvWkQ5VTJJSU83YVFOWUNkaTJUaC84?=
 =?utf-8?B?djhQZXFPMzJtbXdITUcrQ0UwUFhqait6VThESk9DdzA2SFBUZ1NTRDZxaS92?=
 =?utf-8?B?aVBuWU94b2xXdUxXMThrQUZGTFJNUFJXdkczSEhZVzhqWkZpQUxjQ0RzS1VL?=
 =?utf-8?B?ZDBLdWNRU2s0T25lWk9CZEJML0FKQVVPZ3lQSG1WNGNpVmZSa3REMTR6ZGxM?=
 =?utf-8?B?dWp6bkREeUpwM081YUtqeTNDTEdMUUJrckJaN1RpdWNhRzNucjZJK1E2WGVR?=
 =?utf-8?B?eHd0RWNFWlNtM3BwNE5pQStZcVNMaEljWVZYZGgvV3BwVks3N2F4Yk1VU0px?=
 =?utf-8?B?OE1zVzk3ZkhJSVZ1SUV1S29ZcG5PVk5aVVdRemlTN3BlR1BhbGdvaG45bzJl?=
 =?utf-8?B?bkZaSjBlMjVHN3NveVhNVGxpa2MwTE1vSlpnRlp3d1hMdCtvcWppOFdmU3lX?=
 =?utf-8?B?RzBWS21NV1BIUmkwY0QyMXYzOHYyR09nM1A2ZTZBbFpxcWd1V2YvVnFCdVhG?=
 =?utf-8?B?bGxvazkyUTh4d05zQjFDQzNyM25WdUZXYkxibmE1dmJsVjZzNkwzTkJkbTlu?=
 =?utf-8?Q?MzYKLsBLa2Wd0=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3770543F0458AC8649D7D5F8F54C0@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(13464003)(189003)(199004)(52536013)(106356001)(76176011)(256004)(7696005)(305945005)(7736002)(74316002)(316002)(68736007)(53546011)(478600001)(6246003)(110136005)(14444005)(6506007)(14454004)(81166006)(81156014)(5660300002)(25786009)(476003)(33656002)(446003)(8676002)(4326008)(99286004)(53936002)(8936002)(86362001)(486006)(55016002)(44832011)(2201001)(6116002)(2906002)(66066001)(2501003)(9686003)(3846002)(6436002)(71200400001)(186003)(71190400001)(97736004)(26005)(11346002)(105586002)(229853002)(7416002)(102836004)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QGD1t901B2dsufZVLrOyMJ0uVmsLjoVrzp2hAE3ZnkO6BzCUUnrx0ErdP5N7/JdX3gmKLASmg+g4p3uh+svzHV2CdRbnEBlY9zzOcLKqjhI5InTYaav64VplY8Q/6VQRY+lI9ko49VS+SIC/INAklDMntsfJgEJRq97urIS8hBouLu91aUQm8Z5CfwaRTGTr8aJ4Dpo5AP1qk4N1zhbia8g9nO45hk44lNzSOvpKDWDXZvyJT4+r69/YU+MEPnJbUDwS+s7PMW5O0To4vVpN/rqPPgfIhEDbJ1mWdRcIPUS2YzIP+azkwOLnkuDcJSsbcL+VMIkj7S849kRYJg1GKY5gTRklAbgiTfn8STvzou+g8jEOIGCARhNvlXg7cDheZftPvwvqltF1RbO1RjOYVXfI/o3hTnDh82zk2/lmQBE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadafd57-e28b-4976-a8a5-08d6a2fc427a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 12:56:04.9316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1Y2FzDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjYXMgU3RhY2ggW21haWx0bzpsLnN0YWNoQHBlbmd1
dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE55bm0M+aciDfml6UgMjA6MDYNCj4gVG86IEFuc29uIEh1
YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtDQo+
IDxmYWJpby5lc3RldmFtQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsg
QWJlbCBWZXNhDQo+IDxhYmVsLnZlc2FAbnhwLmNvbT47IGFneEBzaWd4Y3B1Lm9yZzsgbGludXgt
YXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDIvM10gY2xrOiBpbXg4bXE6IGFkZCBoZG1pX3BoeV8yN20gY2xvY2sg
YXMgcGxsJ3MNCj4gcmVmZXJlbmNlIGNsb2NrDQo+IA0KPiBBbSBEb25uZXJzdGFnLCBkZW4gMDcu
MDMuMjAxOSwgMDM6NDEgKzAwMDAgc2NocmllYiBBbnNvbiBIdWFuZzoNCj4gPiBUaGVyZSBpcyBh
bm90aGVyIDI3TUh6IE9TQyBpbnNpZGUgaS5NWDhNUSdzIGRpc3BsYXkgYmxvY2sgYW5kIGl0IGNh
bg0KPiA+IGJlIG9uZSBvZiByZWZlcmVuY2UgY2xvY2tzIG9mIGFsbCBQTExzLCBhZGQgaXQgaW50
byBjbG9jayB0cmVlIGFuZA0KPiA+IGFsc28gYWRkIGl0IGFzIFBMTCdzIHJlZmVyZW5jZSBjbG9j
ay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYyB8IDMgKyst
DQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYw0KPiA+IGIv
ZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYyBpbmRleCBhOWIzODg4Li5iYjFiZjliIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1xLmMNCj4gPiArKysgYi9kcml2
ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jDQo+ID4gQEAgLTI2LDcgKzI2LDcgQEAgc3RhdGljIHUz
MiBzaGFyZV9jb3VudF9uYW5kOw0KPiA+DQo+ID4gwqBzdGF0aWMgc3RydWN0IGNsayAqY2xrc1tJ
TVg4TVFfQ0xLX0VORF07DQo+ID4NCj4gPiAtc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBwbGxf
cmVmX3NlbHNbXSA9IHsgIm9zY18yNW0iLCAib3NjXzI3bSIsDQo+ID4gImR1bW15IiwgImR1bW15
IiwgfTsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBwbGxfcmVmX3NlbHNbXSA9IHsg
Im9zY18yNW0iLCAib3NjXzI3bSIsDQo+ID4gKyJvc2NfaGRtaV9waHlfMjdtIiwgImR1bW15Iiwg
fTsNCj4gPiDCoHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgYXJtX3BsbF9ieXBhc3Nfc2Vsc1td
ID0geyJhcm1fcGxsIiwNCj4gPiAiYXJtX3BsbF9yZWZfc2VsIiwgfTsNCj4gPiDCoHN0YXRpYyBj
b25zdCBjaGFyICogY29uc3QgZ3B1X3BsbF9ieXBhc3Nfc2Vsc1tdID0geyJncHVfcGxsIiwNCj4g
PiAiZ3B1X3BsbF9yZWZfc2VsIiwgfTsNCj4gPiDCoHN0YXRpYyBjb25zdCBjaGFyICogY29uc3Qg
dnB1X3BsbF9ieXBhc3Nfc2Vsc1tdID0geyJ2cHVfcGxsIiwNCj4gPiAidnB1X3BsbF9yZWZfc2Vs
IiwgfTsgQEAgLTI4MSw2ICsyODEsNyBAQCBzdGF0aWMgaW50DQo+IGlteDhtcV9jbG9ja3NfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiDCoAljbGtzW0lNWDhNUV9DTEtf
MzJLXSA9IG9mX2Nsa19nZXRfYnlfbmFtZShucCwgImNraWwiKTsNCj4gPiDCoAljbGtzW0lNWDhN
UV9DTEtfMjVNXSA9IG9mX2Nsa19nZXRfYnlfbmFtZShucCwgIm9zY18yNW0iKTsNCj4gPiDCoAlj
bGtzW0lNWDhNUV9DTEtfMjdNXSA9IG9mX2Nsa19nZXRfYnlfbmFtZShucCwgIm9zY18yN20iKTsN
Cj4gPiArCWNsa3NbSU1YOE1RX0NMS19IRE1JX1BIWV8yN01dID0gb2ZfY2xrX2dldF9ieV9uYW1l
KG5wLA0KPiA+ICsib3NjX2hkbWlfcGh5XzI3bSIpOw0KPiANCj4gVGhpcyBpcyBub3QgYWNjZXB0
YWJsZS4gVGhpcyBhZGRzIGEgbmV3IHJlcXVpcmVkIGNsb2NrIGlucHV0LCB3aXRob3V0DQo+IGJv
dGhlcmluZyB0byBhZGQgdGhlIGNvcnJlc3BvbmRpbmcgYmluZGluZyBpbmZvcm1hdGlvbiBvciB0
aGlua2luZyBhYm91dA0KPiBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eS4gQXQgdGhpcyBwb2ludCB0
aGVyZSBhcmUgZXhpc3RpbmcgRFRzIG91dCB0aGVyZSwgd2hpY2gNCj4gZG9uJ3QgcHJvdmlkZSB0
aGlzIHJlcXVpcmVkIGNsb2NrLCB3aGljaCB3aWxsIGNhdXNlIGEgZnVsbCBib290IHJlZ3Jlc3Np
b24uIFRoaXMNCj4gY2FuIG9ubHkgYmUgYW4gb3B0aW9uYWwgY2xvY2sgaW5wdXQgYXQgdGhpcyBw
b2ludC4NCg0KV2hhdCBkbyB5b3UgdGhpbmsgaWYgd2UgZG9uJ3QgZ2V0IHN1Y2ggY2xvY2sgZnJv
bSBEVD8gSnVzdCByZWdpc3RlciB0aGlzIGZpeGVkIGNsb2NrDQppbiBjbG9jayBkcml2ZXIgZGly
ZWN0bHksIHRoZW4gdGhlcmUgd2lsbCBiZSBubyBkZXBlbmRlbmN5IG9mIERULg0KDQpBbnNvbi4N
Cg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4gwqAJY2xrc1tJTVg4TVFfQ0xLX0VY
VDFdID0gb2ZfY2xrX2dldF9ieV9uYW1lKG5wLCAiY2xrX2V4dDEiKTsNCj4gPiDCoAljbGtzW0lN
WDhNUV9DTEtfRVhUMl0gPSBvZl9jbGtfZ2V0X2J5X25hbWUobnAsICJjbGtfZXh0MiIpOw0KPiA+
IMKgCWNsa3NbSU1YOE1RX0NMS19FWFQzXSA9IG9mX2Nsa19nZXRfYnlfbmFtZShucCwgImNsa19l
eHQzIik7DQo=
