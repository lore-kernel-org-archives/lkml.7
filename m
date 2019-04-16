Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2940BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D638A20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sLnIuXH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfDPDYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:24:33 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:5607
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbfDPDYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZx+OVCwcvKz8VKhxu8RcfRrPIDTw6PLVzvChQsHjT4=;
 b=sLnIuXH3sCUhHNZ2wlzfROo3QATv62tgrOmxDXc8ze7H0yhhHck/OODYLzVZ7Ws1+4HkPunWtbnkACp7bz0k8jRO7hXW1hGGkqqK4impi6CDXxMer9wH4K6PxNGAjNshEt51DXih2mBgj3FpMhWSK74wxT3XF+7TMVU2mNvCmw8=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3895.eurprd04.prod.outlook.com (52.133.29.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Tue, 16 Apr 2019 03:24:11 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2%6]) with mapi id 15.20.1792.020; Tue, 16 Apr 2019
 03:24:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Gross <andy.gross@linaro.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH RESEND V11 4/4] arm64: dts: imx: add i.MX8QXP
 thermal support
Thread-Topic: [EXT] Re: [PATCH RESEND V11 4/4] arm64: dts: imx: add i.MX8QXP
 thermal support
Thread-Index: AQHU73EX38xwvpned0+8yCJsz+NeAqY9sLwAgAB39XA=
Date:   Tue, 16 Apr 2019 03:24:11 +0000
Message-ID: <AM6PR0402MB391109A058632C7F3D54E39CF5240@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
 <1554881866-26333-4-git-send-email-Anson.Huang@nxp.com>
 <13bc5836-cc0e-82f7-60ef-3ef544aa8ec2@linaro.org>
In-Reply-To: <13bc5836-cc0e-82f7-60ef-3ef544aa8ec2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48d8bfe7-b378-49f2-55b8-08d6c21afec2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3895;
x-ms-traffictypediagnostic: AM6PR0402MB3895:
x-ms-exchange-purlcount: 2
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB38959D9272975DAC5E6213E0F5240@AM6PR0402MB3895.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(13464003)(55016002)(106356001)(9686003)(6306002)(105586002)(53936002)(2501003)(6116002)(33656002)(3846002)(66066001)(68736007)(486006)(44832011)(110136005)(316002)(5660300002)(11346002)(446003)(52536014)(476003)(97736004)(71190400001)(71200400001)(14444005)(81166006)(99286004)(8936002)(81156014)(8676002)(7696005)(102836004)(229853002)(256004)(14454004)(478600001)(53546011)(6506007)(26005)(7736002)(4326008)(76176011)(6246003)(86362001)(2906002)(7416002)(186003)(2201001)(25786009)(74316002)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3895;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +/+X0/AN1tzJK8VDlT/yilGxgCXmXdIz4BRTHKxtc4qPuQVrTLLLiFoPaEYzzXgGmNykpMXslxcBpXZ+gDSRv8UviW1hrkJo/MhvAp89qaLX2ncOyPmn0uL1EPXhPURcDrAzYLz67jqEn74ylv6lz+fFNK+f5nYie0LTFZpYVJSpaH7SBvb5wJQVRfmOPi0/cqydcwJ5uPURL1lE63S0iFVUhS1VAJ5a9EEjW2yHm/zInEpgj+zq66mdq9K4UozK8JPm8VdJODpb6vsBCCUPfE/3XADthisiwrGhfG7a2TgdJaNxRjYq12ae9ziMSfBqDMn0Hcwq3ZFFa8dmt4k7Pz9Etgun8UIZ89sluk7+M6kSXwDNZb+5OmylMiImLzNkbLso/uQNY70jy6a16uzOLoKA6oStd0Zr0ralpR3ewQs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d8bfe7-b378-49f2-55b8-08d6c21afec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 03:24:11.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IA0KPiANCj4gT24gMTAvMDQvMjAxOSAwOTo0MywgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gQWRkIGkuTVg4UVhQIENQVSB0aGVybWFsIHpvbmUgc3VwcG9ydC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
PiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2UgVjEwOg0KPiA+ICAgICAgIC0gcmVtb3ZlIHByb3Bl
cnR5ICJpbXgsc2Vuc29yLXJlc291cmNlLWlkIiBhbmQgcHV0IEhXIHJlc291cmNlIElEDQo+IGlu
c2lkZSBlYWNoDQo+ID4gICAgICAgICB0aGVybWFsLXNlbnNvcnMnIHBoYW5kbGUgYXJndW1lbnQu
DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRz
aSB8IDMzDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gPiBpbmRleCA3MGVmM2RiLi5jYzFkODc3IDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRz
aQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0K
PiA+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dw
aW8uaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2Fy
bS1naWMuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BpbmN0cmwvcGFkcy1pbXg4cXhw
Lmg+DQo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy90aGVybWFsL3RoZXJtYWwuaD4NCj4gPg0K
PiA+ICAvIHsNCj4gPiAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPiA+IEBAIC0x
NDksNiArMTUwLDExIEBADQo+ID4gICAgICAgICAgICAgICBydGM6IHJ0YyB7DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2MtcnRjIjsNCj4gPiAg
ICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgdHNlbnM6IHRoZXJtYWwt
c2Vuc29yIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14
OHF4cC1zYy10aGVybWFsIiwgImZzbCxpbXgtc2MtdGhlcm1hbCI7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICN0aGVybWFsLXNlbnNvci1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAg
IH07DQo+ID4gICAgICAgfTsNCj4gPg0KPiA+ICAgICAgIHRpbWVyIHsNCj4gPiBAQCAtNDg0LDQg
KzQ5MCwzMSBAQA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZw
ZCBJTVhfU0NfUl9HUElPXzc+Ow0KPiA+ICAgICAgICAgICAgICAgfTsNCj4gPiAgICAgICB9Ow0K
PiA+ICsNCj4gPiArICAgICB0aGVybWFsX3pvbmVzOiB0aGVybWFsLXpvbmVzIHsNCj4gPiArICAg
ICAgICAgICAgIGNwdS10aGVybWFsMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBvbGxp
bmctZGVsYXktcGFzc2l2ZSA9IDwyNTA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBwb2xs
aW5nLWRlbGF5ID0gPDIwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB0aGVybWFsLXNl
bnNvcnMgPSA8JnRzZW5zIElNWF9TQ19SX1NZU1RFTT47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIHRyaXBzIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHVfYWxlcnQw
OiB0cmlwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZW1w
ZXJhdHVyZSA9IDwxMDcwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHR5cGUgPSAicGFzc2l2ZSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHVfY3JpdDA6
IHRyaXAxIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRlbXBl
cmF0dXJlID0gPDEyNzAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBoeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdHlwZSA9ICJjcml0aWNhbCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgY29vbGluZy1tYXBzIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtYXAwIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRy
aXAgPSA8JmNwdV9hbGVydDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29vbGluZy1kZXZpY2UgPQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8JkEzNV8wIFRIRVJNQUxfTk9fTElNSVQNCj4gPiArIFRIRVJNQUxf
Tk9fTElNSVQ+Ow0KPiANCj4gICAgICAgICA8JkEzNV8wIFRIRVJNQUxfTk9fTElNSVQgVEhFUk1B
TF9OT19MSU1JVD4sDQo+ICAgICAgICAgPCZBMzVfMSBUSEVSTUFMX05PX0xJTUlUIFRIRVJNQUxf
Tk9fTElNSVQ+LA0KPiAgICAgICAgIDwmQTM1XzIgVEhFUk1BTF9OT19MSU1JVCBUSEVSTUFMX05P
X0xJTUlUPiwNCj4gICAgICAgICA8JkEzNV8zIFRIRVJNQUxfTk9fTElNSVQgVEhFUk1BTF9OT19M
SU1JVD47DQo+IA0KDQpGaXggaXQgaW4gVjEyLCB0aGFua3MuDQoNCkFuc29uLg0KDQo+IA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIH07DQo+ID4gKyAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgIH07DQo+ID4gIH07DQo+ID4N
Cj4gDQo+IA0KPiAtLQ0KPiANCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBsaW5hcm8ub3JnJTJGJmFtcDtk
YXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0NmY2E4N2QNCj4gYWE1MjY5NDk1
ODZkMzYwOGQ2YzFkZWY0NjclN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3Qw0K
PiAwJTdDMCU3QzYzNjkwOTU2MDY1ODU4MjI2MCZhbXA7c2RhdGE9eko5cFpGVk45NFROM3RjaTRz
dXQ5QSUyQnoNCj4gYm5Ea2xaanh5OWR3RVhDc3NIayUzRCZhbXA7cmVzZXJ2ZWQ9MD4gTGluYXJv
Lm9yZyDilIIgT3BlbiBzb3VyY2UNCj4gc29mdHdhcmUgZm9yIEFSTSBTb0NzDQo+IA0KPiBGb2xs
b3cgTGluYXJvOg0KPiA8aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cuDQo+IGZhY2Vib29rLmNvbSUyRnBhZ2VzJTJGTGlu
YXJvJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0DQo+IDBueHAuY29tJTdDZmNhODdk
YWE1MjY5NDk1ODZkMzYwOGQ2YzFkZWY0NjclN0M2ODZlYTFkM2JjMmI0YzZmYTkNCj4gMmNkOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNjkwOTU2MDY1ODU4MjI2MCZhbXA7c2RhdGE9OFU5WlYzdUwN
Cj4gZE1melJpdHExY2w0dHZ4cEZha3hGTkdXMFREWjQyd0R1RWMlM0QmYW1wO3Jlc2VydmVkPTA+
IEZhY2Vib29rDQo+IHwNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGdHdpdHRlDQo+IHIuY29tJTJGJTIzISUyRmxpbmFy
b29yZyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuYw0KPiBvbSU3Q2ZjYTg3
ZGFhNTI2OTQ5NTg2ZDM2MDhkNmMxZGVmNDY3JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTkNCj4g
YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MDk1NjA2NTg1ODIyNjAmYW1wO3NkYXRhPWxKNXluZ01v
VzNFTEkNCj4geFlRYUFTQXR2R1hkTlZEeEg1QldvS1NMd1JMMG1NJTNEJmFtcDtyZXNlcnZlZD0w
PiBUd2l0dGVyIHwNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBsaW5hcm8ub3JnJTJGbGluYXJvLQ0KPiBi
bG9nJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0NmY2E4N2Rh
YTUyNg0KPiA5NDk1ODZkMzYwOGQ2YzFkZWY0NjclN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1
YzMwMTYzNSU3QzAlN0MNCj4gMCU3QzYzNjkwOTU2MDY1ODU4MjI2MCZhbXA7c2RhdGE9aEJUcGVC
U2c3SkdrMHFIYkM3REVwMkpnTjdzVnENCj4geWhDMnV6QkFHJTJCUDAxcyUzRCZhbXA7cmVzZXJ2
ZWQ9MD4gQmxvZw0KDQo=
