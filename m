Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84281ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497642086A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PJ1EnvjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbfJPDSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:18:35 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:6112
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfJPDSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:18:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWEiCsWj9PI1s9rxHNE8P6iyAu49rcskjGT9VFOIQxIK9guFIohml2mNCSNSvM2HDMTjgmzX1B/mU4VyswpJJb/OeqNWp8ZL5E9VAQhVXOrymCbCVtjrs6GQWi2a6pANPfrIJGIdKLWBxdhYmOM00Ysh++oCUz72rQihBX76Ex+4JJoAmkXChprHnNXQ1WDmEWQwxg5lvh27g//n4YgaH+WGfCnsIEcYgs/xreY6VedOUD47MeaO4Ejq2peEnNR7YMRzMHEU1qpx0my3JJsLiR3hVLU7E11AA+1ocCAc4z9UNNriciSQXzzSigcGkouJJC3PupGB8BlQqTZYFteQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmLYANrqFxZL3C+XrkoYUbvGjX+mu/OJEWhTu+otjEM=;
 b=iBFuc7boTEHv18cSdk7BMO6/yhIslHdEJ0wvbC1v/L/m1Ngt5z76d/CzWTjAEviUTns7knVqqROUFa0x5tF7ClcUPhf+p1m9HhTC/y0thiLMyNLeB02ariWXl6UeuXsLOFU1dtSBAiy5IoanyZB7Gs47DYq27XD39b7YsVQ3tJNusTrWLCUEmTXfBgbbIsmdfhjzw43dBBJK6TTr03CPD1LNhybqa5LUk1k9b/bDCy28zqTdtN0dBK9fVH4G6385BZbJk9sWIGJN2YEryP5DuEaHll9rhaqxbrb6l9ESqqG5ZoSbtDxM5QcBD9CBRLs4R6gPgASLoMpj9VahufWveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmLYANrqFxZL3C+XrkoYUbvGjX+mu/OJEWhTu+otjEM=;
 b=PJ1EnvjNOfC3ONJXcB5j2X5CIlDD1d6lM/geXXdzqs8PMxLTPCcDdnqnNIuDYudpwc4IdFf3rW0ZB5QeDnY5EUW9zPDJvRZN6XXLm9y+3hzQMM3PelMuVy7Bg6eCyCL/hE+Tn/jzZCq7zmU/v8H7z/O6lfokd62U5eBU1GYQLts=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB5944.eurprd04.prod.outlook.com (20.178.86.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 03:18:29 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::79b4:252:8bba:c88c]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::79b4:252:8bba:c88c%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 03:18:29 +0000
From:   Fancy Fang <chen.fang@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Thread-Topic: [PATCH v3] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Thread-Index: AQHVgwcPc0jqN29IB0OYPLGVX+dhGKdbCpHQgAGIAsA=
Date:   Wed, 16 Oct 2019 03:18:29 +0000
Message-ID: <AM6PR04MB49363E4BD4B48384A372DAFEF3920@AM6PR04MB4936.eurprd04.prod.outlook.com>
References: <20191015031501.2703-1-chen.fang@nxp.com>
 <DB3PR0402MB3916869C2A91293F0600CF34F5930@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916869C2A91293F0600CF34F5930@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chen.fang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a6ef955-7191-49b5-f36d-08d751e7845b
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM6PR04MB5944:|AM6PR04MB5944:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5944172B16D3A1AB9CB42BC6F3920@AM6PR04MB5944.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(54534003)(13464003)(199004)(189003)(446003)(76116006)(66446008)(7736002)(66066001)(86362001)(305945005)(66946007)(11346002)(74316002)(71200400001)(71190400001)(64756008)(8676002)(8936002)(81166006)(2201001)(186003)(66556008)(81156014)(102836004)(486006)(26005)(476003)(2906002)(33656002)(66476007)(6116002)(7696005)(5660300002)(54906003)(110136005)(99286004)(53546011)(316002)(14454004)(76176011)(6506007)(256004)(3846002)(52536014)(14444005)(2501003)(229853002)(9686003)(25786009)(6246003)(55016002)(4326008)(6436002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5944;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5E5TMq57FYk9QlKwnLQKDr2ylfn3ZHPfbkCE2bpL/Qkp23E3s4m60SlHV/q1f+vgWo4PTZdLleod48q7WNx6CWU5hKk7rj84OC8XCyllrgz9TLMt/ZsINtNeqBQtrlNLbcUBPhgeaeS4bE+HgVSlf2YpV2cXJUnMJVqz0gaP3/U5yHjqsw218N+R3QvaxOr8Me+dOK09V1EKTo1iEzY/G2HUcAclkE76/xDayuCQyl3oclGSPihr174cwtyMIIHWuz0uAELbN0ihwYnpSvRKThwls3c/DoNBxYe77cJdk/8dAvrXgH1ygo5s6lxA9CnJwRC/ahndad0sF5i42XE40fq+CgQs9yVgF1WwYqH8YkI8AYfBC6WC5ZHLYlzzo4wd3RicUe6JW92rudkNVvEstuL0Z1CywK3EZPbC+2d44c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6ef955-7191-49b5-f36d-08d751e7845b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 03:18:29.5428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +51k2KPPtBcjiwAd64z3LPbV3NvXhSMK3fxHlhtlFjgmffTgfKQ4CGmrrXlrSRoVdOujqjl7FAxeuZVoJFwdcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5zb24sDQoNClBsZWFzZSBzZWUgbXkgYmVsb3cgY29tbWVudHMuDQoNCkJlc3QgcmVnYXJk
cywNCkZhbmN5IEZhbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFuc29u
IEh1YW5nIA0KU2VudDogVHVlc2RheSwgT2N0b2JlciAxNSwgMjAxOSAxMToyOCBBTQ0KVG86IEZh
bmN5IEZhbmcgPGNoZW4uZmFuZ0BueHAuY29tPjsgc2JveWRAa2VybmVsLm9yZzsgc2hhd25ndW9A
a2VybmVsLm9yZw0KQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbXR1
cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NClN1YmplY3Q6IFJF
OiBbUEFUQ0ggdjNdIGNsazogaW14N3VscDogZG8gbm90IGV4cG9ydCBvdXQgSU1YN1VMUF9DTEtf
TUlQSV9QTEwgY2xvY2sNCg0KSGksIEZhbmN5DQoNCj4gU3ViamVjdDogW1BBVENIIHYzXSBjbGs6
IGlteDd1bHA6IGRvIG5vdCBleHBvcnQgb3V0IA0KPiBJTVg3VUxQX0NMS19NSVBJX1BMTCBjbG9j
aw0KPiANCj4gVGhlIG1pcGkgcGxsIGNsb2NrIGNvbWVzIGZyb20gdGhlIE1JUEkgUEhZIFBMTCBv
dXRwdXQsIHNvIGl0IHNob3VsZCANCj4gbm90IGJlIGEgZml4ZWQgY2xvY2suDQo+IA0KPiBNSVBJ
IFBIWSBQTEwgaXMgaW4gdGhlIE1JUEkgRFNJIHNwYWNlLCBhbmQgaXQgaXMgdXNlZCBhcyB0aGUg
Yml0IGNsb2NrIA0KPiBmb3IgdHJhbnNmZXJyaW5nIHRoZSBwaXhlbCBkYXRhIG91dCBhbmQgaXRz
IG91dHB1dCBjbG9jayBpcyBjb25maWd1cmVkIA0KPiBhY2NvcmRpbmcgdG8gdGhlIGRpc3BsYXkg
bW9kZS4NCj4gDQo+IFNvIGl0IHNob3VsZCBiZSB1c2VkIG9ubHkgZm9yIE1JUEkgRFNJIGFuZCBu
b3QgYmUgZXhwb3J0ZWQgb3V0IGZvciANCj4gb3RoZXIgdXNhZ2VzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRmFuY3kgRmFuZyA8Y2hlbi5mYW5nQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VMb2cg
djItPnYzOg0KPiAgKiBLZWVwICdJTVg3VUxQX0NMS19NSVBJX1BMTCcgbWFjcm8gZGVmaW5pdGlv
bi4NCj4gDQo+IENoYW5nZUxvZyB2MS0+djI6DQo+ICAqIEtlZXAgb3RoZXIgY2xvY2sgaW5kZXhl
cyB1bmNoYW5nZWQgYXMgU2hhd24gc3VnZ2VzdGVkLg0KPiANCj4gIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3dWxwLWNsb2NrLnR4dCB8IDEgLQ0KPiAgZHJpdmVy
cy9jbGsvaW14L2Nsay1pbXg3dWxwLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMyAr
LS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L2lteDd1bHAtY2xvY2sudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Nsb2NrL2lteDd1bHAtY2xvY2sudHh0DQo+IGluZGV4IGE0ZjhjZDQ3OGY5Mi4uOTNkODlhZGI3
YWZlIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xv
Y2svaW14N3VscC1jbG9jay50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Nsb2NrL2lteDd1bHAtY2xvY2sudHh0DQo+IEBAIC04Miw3ICs4Miw2IEBAIHBjYzI6
IHBjYzJANDAzZjAwMDAgew0KPiAgCQkgPCZzY2cxIElNWDdVTFBfQ0xLX0FQTExfUEZEMD4sDQo+
ICAJCSA8JnNjZzEgSU1YN1VMUF9DTEtfVVBMTD4sDQo+ICAJCSA8JnNjZzEgSU1YN1VMUF9DTEtf
U09TQ19CVVNfQ0xLPiwNCj4gLQkJIDwmc2NnMSBJTVg3VUxQX0NMS19NSVBJX1BMTD4sDQo+ICAJ
CSA8JnNjZzEgSU1YN1VMUF9DTEtfRklSQ19CVVNfQ0xLPiwNCj4gIAkJIDwmc2NnMSBJTVg3VUxQ
X0NMS19ST1NDPiwNCj4gIAkJIDwmc2NnMSBJTVg3VUxQX0NMS19TUExMX0JVU19DTEs+Ow0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg3dWxwLmMgDQo+IGIvZHJpdmVycy9j
bGsvaW14L2Nsay1pbXg3dWxwLmMgaW5kZXggMjAyMmQ5YmVhZDkxLi40NTliMTIwYjcxZDUgDQo+
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDd1bHAuYw0KPiArKysgYi9k
cml2ZXJzL2Nsay9pbXgvY2xrLWlteDd1bHAuYw0KPiBAQCAtMjgsNyArMjgsNyBAQCBzdGF0aWMg
Y29uc3QgY2hhciAqIGNvbnN0IHNjc19zZWxzW10JCT0NCj4geyAiZHVtbXkiLCAic29zYyIsICJz
aXJjIiwgImZpcmMiLCAiZHVtbQ0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBkZHJfc2Vs
c1tdCQk9IHsgImFwbGxfcGZkX3NlbCIsICJ1cGxsIiwgfTsNCj4gIHN0YXRpYyBjb25zdCBjaGFy
ICogY29uc3QgbmljX3NlbHNbXQkJPSB7ICJmaXJjIiwgImRkcl9jbGsiLCB9Ow0KPiAgc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdCBwZXJpcGhfcGxhdF9zZWxzW10JPSB7ICJkdW1teSIsICJuaWMx
X2J1c19jbGsiLA0KPiAibmljMV9jbGsiLCAiZGRyX2NsayIsICJhcGxsX3BmZDIiLCAiYXBsbF9w
ZmQxIiwgImFwbGxfcGZkMCIsICJ1cGxsIiwgfTsNCj4gLXN0YXRpYyBjb25zdCBjaGFyICogY29u
c3QgcGVyaXBoX2J1c19zZWxzW10JPSB7ICJkdW1teSIsICJzb3NjX2J1c19jbGsiLA0KPiAibXBs
bCIsICJmaXJjX2J1c19jbGsiLCAicm9zYyIsICJuaWMxX2J1c19jbGsiLCAibmljMV9jbGsiLCAN
Cj4gInNwbGxfYnVzX2NsayIsIH07DQo+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHBlcmlw
aF9idXNfc2Vsc1tdCT0geyAiZHVtbXkiLCAic29zY19idXNfY2xrIiwNCj4gImR1bW15IiwgImZp
cmNfYnVzX2NsayIsICJyb3NjIiwgIm5pYzFfYnVzX2NsayIsICJuaWMxX2NsayIsIA0KPiAic3Bs
bF9idXNfY2xrIiwgfTsNCg0KVGhlIHJlZmVyZW5jZSBtYW51YWwgZG9lcyBoYXZlIG1wbGwgYXMg
Y2xvY2sgb3B0aW9uLCBzbyBkbyB5b3UgbWVhbiBpdCB3aWxsIE5PVCBiZSBzdXBwb3J0ZWQgYW55
bW9yZSwgaXMgbXBsbCB1c2VkIGluc2lkZSBNSVBJIFBIWT8NCg0KW0ZGXSBZZXMuIFRoZSBtcGxs
IGNvbWVzIGZyb20gdGhlIE1JUEkgUEhZIFBMTCB3aGljaCBpcyBhbiBpbnRlcm5hbCBQTEwgY2xv
Y2sgaW4gTUlQSSBzcGFjZS4gQW5kIGJlc2lkZXMsIHRoaXMgY2xvY2sgZnJlcXVlbmN5IGNhbiBi
ZSBjaGFuZ2VkIG9yIGRpc2FibGVkIGR5bmFtaWNhbGx5IHdoZW4geW91IGNoYW5nZSBkaXNwbGF5
IG1vZGUgb3IgZGlzYWJsZSBkaXNwbGF5LiBTbyBpdCBzaG91bGQgbm90IGJlIHVzZWQgYXMgb3Ro
ZXIgcGVyaXBoZXJhbHMncyByb290IGNsb2NrLiBUaGlzIGlzIHdoeSBJIHdhbnQgdG8gaGlkZSB0
aGlzIG1wbGwgZnJvbSBvdGhlciBwZXJpcGhlcmFscyB0byBtYWtlIHRoaW5ncyBlYXNpZXIgdG8g
YmUgaGFuZGxlZC4NCg0KQW5zb24NCg0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBhcm1f
c2Vsc1tdCQk9IHsgImRpdmNvcmUiLCAiZHVtbXkiLA0KPiAiZHVtbXkiLCAiaHNydW5fZGl2Y29y
ZSIsIH07DQo+IA0KPiAgLyogdXNlZCBieSBzb3NjL3NpcmMvZmlyYy9kZHIvc3BsbC9hcGxsIGRp
dmlkZXJzICovIEBAIC03NSw3ICs3NSw2IEBAIA0KPiBzdGF0aWMgdm9pZCBfX2luaXQgaW14N3Vs
cF9jbGtfc2NnMV9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQo+ICAJY2xrc1tJTVg3VUxQ
X0NMS19TT1NDXQkJPQ0KPiBpbXhfb2J0YWluX2ZpeGVkX2Nsa19odyhucCwgInNvc2MiKTsNCj4g
IAljbGtzW0lNWDdVTFBfQ0xLX1NJUkNdCQk9DQo+IGlteF9vYnRhaW5fZml4ZWRfY2xrX2h3KG5w
LCAic2lyYyIpOw0KPiAgCWNsa3NbSU1YN1VMUF9DTEtfRklSQ10JCT0NCj4gaW14X29idGFpbl9m
aXhlZF9jbGtfaHcobnAsICJmaXJjIik7DQo+IC0JY2xrc1tJTVg3VUxQX0NMS19NSVBJX1BMTF0J
PSBpbXhfb2J0YWluX2ZpeGVkX2Nsa19odyhucCwNCj4gIm1wbGwiKTsNCj4gIAljbGtzW0lNWDdV
TFBfQ0xLX1VQTExdCQk9DQo+IGlteF9vYnRhaW5fZml4ZWRfY2xrX2h3KG5wLCAidXBsbCIpOw0K
PiANCj4gIAkvKiBTQ0cxICovDQo+IC0tDQo+IDIuMTcuMQ0KDQo=
