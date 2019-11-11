Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2C8C17442
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49BB20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dZ1gsVyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKKCCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:02:17 -0500
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:17476
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbfKKCCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:02:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miwiTt5UqO3JbDUIqn4sBxdKzXCZeCig2tebBQrcm7r8IxY0k2JTz9fZgWx1lcChY4gZn8avRqzXrps2rVMNrjLPkG/jxJJ6wcbIBNSPVcIjaWCptidBEOH+xx16jUM65Sdemcy1kNOOkf79q0b5vWXuhuJyEbcvcbDdHRm7ZFfqQkThUOyCYN/ObMtaeaNKAeKxDvMNrQhVLBm4R9WArtAAc0Ks4/SJIpr4hiyD1domehayBXtCIh2d3HvB8w7fFqHC3l+175SQWGaUAnofXDgdoF752N6ANux9udQajLLuoJFjnr/CI3zGcwoYdE4pWq8QdDIF4n2E6iIGIy4Npw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcqyayxXPO6fZTGWkA7uPiSL45iH+cVneLYMXgBHU3M=;
 b=UKhv+UofjLTL+tJkLPfZ0dcGdXIJc5iYIC4LvoV9RAfZH8DeclL02TFqWHJPFrxrM1a0ivO21RWnCTwgJbjHFqODjDzBYMAZ39TWOcKpYHIDEfkkh4rQ4cbfbtEvb+F1ssqSXVkgsIluTdj7zeFW5WQH830+oy/I6Mq+cskmerXQ79u19lPrYZBlZILkK4uuepifj+4SdVhXuaLf5qTrwM14cKhHjXCZxXTexsTaqRwgwggBNPsG5N7aghMgSnE8hEpr6oCBGLEMilCfeBXX6L1/no956BBAt2riG5rrF2NUbzYk3tvkh+FNqJ2Fsa7s3ZIv3w1VWVb0iXibttrLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcqyayxXPO6fZTGWkA7uPiSL45iH+cVneLYMXgBHU3M=;
 b=dZ1gsVyNB7kwhIY1/O9JCA1oe5MvwjtRiUXOCC7U2GNkGTdboFZkgcqN1VvjYHFdsS1uGg1UPEeUQgyhu6Foi8iyAkpCiFhpWMbu/cL4UD3sQBbW9US+a+jV9xGhV+K7c8PkKRAbdO4BDYX+1sOeqXpC9HLrhaq6D2AmytBs6p0=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4265.eurprd04.prod.outlook.com (52.134.109.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 02:02:12 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::551e:2221:4f8d:a7b8]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::551e:2221:4f8d:a7b8%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 02:02:12 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
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
Thread-Index: AQHVk7lUTq986ApPnEC0F11XXes3P6d9E4EAgAH0e/CAAU4ZAIAAN7SwgAEujgCAA4QIYA==
Date:   Mon, 11 Nov 2019 02:02:12 +0000
Message-ID: <DB7PR04MB5195F74447DC13B2AD9238E7E2740@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191105090221.45381-1-wen.he_1@nxp.com>
 <20191105090221.45381-2-wen.he_1@nxp.com>
 <VE1PR04MB66879681CE5231F5C80F85148F7E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <DB7PR04MB51956205E7FE92C9EB00A882E2780@DB7PR04MB5195.eurprd04.prod.outlook.com>
 <20191107225745.1A01C2178F@mail.kernel.org>
 <DB7PR04MB51959C3CF461F68AE99FA728E27B0@DB7PR04MB5195.eurprd04.prod.outlook.com>
 <CADRPPNQ8zf_+205OK=g1FvKpjghFwuyBVW3Wy4zC8VMN2bLdhQ@mail.gmail.com>
In-Reply-To: <CADRPPNQ8zf_+205OK=g1FvKpjghFwuyBVW3Wy4zC8VMN2bLdhQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56fb2fe1-dc7b-4dee-4168-08d7664b2b07
x-ms-traffictypediagnostic: DB7PR04MB4265:|DB7PR04MB4265:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4265D3892BF970EE9328CAA4E2740@DB7PR04MB4265.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(13464003)(54906003)(6116002)(3846002)(2906002)(66476007)(66556008)(66446008)(316002)(66946007)(64756008)(76116006)(99286004)(14454004)(25786009)(33656002)(81166006)(8936002)(81156014)(8676002)(478600001)(6636002)(6436002)(446003)(11346002)(476003)(26005)(4326008)(229853002)(102836004)(14444005)(256004)(186003)(7696005)(66066001)(6506007)(53546011)(76176011)(71190400001)(71200400001)(305945005)(74316002)(7736002)(52536014)(86362001)(6246003)(5660300002)(486006)(55016002)(9686003)(6862004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4265;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDzRJ+F158c4U+LRX8WoysJH1pDiZ5TBI/CfPUWf3i18xnCG9Xfx7sEhURELY90PJrhpYMah5EgrDgIJKb1LFqGaVSIpAt4rcY0Ps7Qb7C9cRTkD1Ug+y2EwkWi8V1NyjTeG28QbOzw7Vbg2LrevGyW627646+mi/3Btg9+FFqum+axKOBbbXXNiiXpcuGKeyEi3tgQmF+fKt8lSBWpfU5n4U0Q5iyQY8w58AWSwkwFsQxGAxbPUqYAAX/yk43QJHSlLsiRGRgS5Gpxzr3XMuqqMr9XhLPXXQ0fJK4ymCKSbeQgVdo6AzjBnaMhaaJvGQL/0IbgUgRFURzHIFMTXKkGTroXHCH1b8tDfGmAm2/uiFYLcs5WZIVuP0p5oNrIfHdiflF92X7BUZ1gA9XnwEB3oaenOsx5pg14XPuiN/Ccz6E8K5ibnFUFkd9TLHAct
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fb2fe1-dc7b-4dee-4168-08d7664b2b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 02:02:12.5021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmQf4KazjEXCcV6WhwHuEizk7XL1QQsVZLfjSfwEqOngJYv1VLBAIr3mqhHx7cNicsNtyn9cDXF0wLBQZlvsMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4265
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgWWFuZyA8bGVveWFu
Zy5saUBueHAuY29tPg0KPiBTZW50OiAyMDE55bm0MTHmnIg55pelIDQ6MjANCj4gVG86IFdlbiBI
ZSA8d2VuLmhlXzFAbnhwLmNvbT4NCj4gQ2M6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9y
Zz47IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNaWNoYWVsIFR1cnF1
ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+Ow0KPiBSb2IgSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWNsa0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWRldmVsQGxpbnV4Lm54ZGkubnhwLmNvbTsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUkU6IFt2NiAyLzJdIGNs
azogbHMxMDI4YTogQWRkIGNsb2NrIGRyaXZlciBmb3IgRGlzcGxheSBvdXRwdXQNCj4gaW50ZXJm
YWNlDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIFRodSwgTm92IDcsIDIwMTkg
YXQgODoyMSBQTSBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4g
Pg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFN0ZXBoZW4g
Qm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMTnlubQxMeaciDjml6UgNjo1
OA0KPiA+ID4gVG86IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgTWFyayBSdXRsYW5kDQo+
ID4gPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8bXR1cnF1
ZXR0ZUBiYXlsaWJyZS5jb20+Ow0KPiA+ID4gUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9y
Zz47IFdlbiBIZSA8d2VuLmhlXzFAbnhwLmNvbT47DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWRldmVsQGxp
bnV4Lm54ZGkubnhwLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3Vi
amVjdDogW0VYVF0gUkU6IFt2NiAyLzJdIGNsazogbHMxMDI4YTogQWRkIGNsb2NrIGRyaXZlciBm
b3INCj4gPiA+IERpc3BsYXkgb3V0cHV0IGludGVyZmFjZQ0KPiA+ID4NCj4gPiA+IENhdXRpb246
IEVYVCBFbWFpbA0KPiA+ID4NCj4gPiA+IFF1b3RpbmcgV2VuIEhlICgyMDE5LTExLTA2IDE5OjEz
OjQ4KQ0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL01ha2Vm
aWxlIGIvZHJpdmVycy9jbGsvTWFrZWZpbGUgaW5kZXgNCj4gPiA+ID4gPiA+IDAxMzhmYjE0ZTZm
OC4uZDIzYjc0NjRhYmE4IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvTWFr
ZWZpbGUNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL01ha2VmaWxlDQo+ID4gPiA+ID4g
PiBAQCAtNDUsNiArNDUsNyBAQCBvYmotJChDT05GSUdfQ09NTU9OX0NMS19PWE5BUykNCj4gPiA+
ICs9DQo+ID4gPiA+ID4gPiBjbGstb3huYXMubw0KPiA+ID4gPiA+ID4gIG9iai0kKENPTkZJR19D
T01NT05fQ0xLX1BBTE1BUykgICAgICAgICAgICArPQ0KPiBjbGstcGFsbWFzLm8NCj4gPiA+ID4g
PiA+ICBvYmotJChDT05GSUdfQ09NTU9OX0NMS19QV00pICAgICAgICAgICAgICAgKz0NCj4gY2xr
LXB3bS5vDQo+ID4gPiA+ID4gPiAgb2JqLSQoQ09ORklHX0NMS19RT1JJUSkgICAgICAgICAgICAg
ICAgICAgICs9IGNsay1xb3JpcS5vDQo+ID4gPiA+ID4gPiArb2JqLSQoQ09ORklHX0NMS19MUzEw
MjhBX1BMTERJRykgICArPSBjbGstcGxsZGlnLm8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdyb25n
IG9yZGVyaW5nLiAgVGhpcyBzZWN0aW9uIG9mIE1ha2VmaWxlIHJlcXVpcmVzIG9yZGVyaW5nIGJ5
DQo+ID4gPiA+ID4gZHJpdmVyIGZpbGUNCj4gPiA+ID4gPiBuYW1lOg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gIyBoYXJkd2FyZSBzcGVjaWZpYyBjbG9jayB0eXBlcw0KPiA+ID4gPiA+ICMgcGxlYXNl
IGtlZXAgdGhpcyBzZWN0aW9uIHNvcnRlZCBsZXhpY29ncmFwaGljYWxseSBieSBmaWxlIHBhdGgN
Cj4gPiA+ID4gPiBuYW1lDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSGkgTGVvLA0KPiA+
ID4gPg0KPiA+ID4gPiBTdGVwaGVuIG9uY2Ugc3VnZ2VzdCB0aGUgS2NvbmZpZyB2YXJpYWJsZSBu
YW1lIHNob3VsZCBiZSBnaXZlbiBhDQo+ID4gPiA+IG1vcmUgc3BlY2lmaWMgbmFtZSBsaWtlIENM
S19MUzEwMjhBX1BMTERJRywgc28gSSBoYXZlIHRvIGNoYW5nZWQgaXQuDQo+ID4gPiA+DQo+ID4g
PiA+IEhpIFN0ZXBoZW4sDQo+ID4gPiA+DQo+ID4gPiA+IEhvdyBkbyB5b3UgdGhpbms/DQo+ID4g
PiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IENvbmZpZyBuYW1lIGxvb2tzIGZpbmUgdG8gbWUsIGJ1
dCB5b3UgaGF2ZW4ndCBzb3J0ZWQgdGhpcyBiYXNlZCBvbg0KPiA+ID4gdGhlIGZpbGUgbmFtZSwg
aS5lLiBjbGstcGxsZGlnLm8sIHNvIHBsZWFzZSBpbnNlcnQgdGhpcyBpbiB0aGUgcmlnaHQgcGxh
Y2UgaW4gdGhpcw0KPiBmaWxlLg0KPiA+DQo+ID4gV293LCBVbmRlcnN0YW5kIG5vdy4uDQo+ID4N
Cj4gPiBTaG91bGQgYmUgc29ydCB0aGlzIGZpbGUgbGlrZSBiZWxvdywgcmlnaHQ/DQo+ID4gb2Jq
LSQoQ09ORklHX0NPTU1PTl9DTEtfUFdNKSAgICs9IGNsay1wd20ubw0KPiA+IG9iai0kKENPTkZJ
R19DTEtfTFMxMDI4QV9QTExESUcpICAgKz0gY2xrLXBsbGRpZy5vDQo+ID4gb2JqLSQoQ09ORklH
X0NMS19RT1JJUSkgICAgICAgICAgICs9IGNsay1xb3JpcS5vDQo+IA0KPiBOby4gIFRoZSBjb3Jy
ZWN0IG9yZGVyIHNob3VsZCBiZToNCj4gY2xrLXBsbGRpZy5vDQo+IGNsay1wd20ubw0KPiBjbGst
cW9yaXEubw0KDQpVbmRlcnN0YW5kLCBJIHdpbGwgc2VuZCBuZXh0IHZlcnNpb24gcGF0Y2guDQoN
ClRoYW5rcyAmJiBCZXN0IFJlZ2FyZHMsDQpXZW4NCg0KPiANCj4gUmVnYXJkcywNCj4gTGVvDQo=
