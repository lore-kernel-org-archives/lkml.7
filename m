Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03052C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C178721734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JCy2BBi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAFIgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:36:41 -0500
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:6063
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbgAFIgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:36:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LONHVDrLGxxQrCJOLHnTv5rknIenK0Ckn+kO2legzOhuRqVg/pgMc/Ffuqehc0+mnuSpsRKwlSWHd4OGn4notwFbodhw/9GQlqpzFtCzAmTJiVwAyqJdIZc+kYY//a0hhLEBeSIgnTX4GC5Yv2WW4fcAqFMi1dTYM/Rik8MstfM/ajq6VSexBmvxj1726XGJ9kaD5atJdYzwuuLclX9NCsmiAETuu8vVS7tHostu+/PUuRfvmc2F1jTOJDOma8ClUiueOVywGUBJHxCB3KOU+8mp505BNYIfHdFHetC8StTbIdkJcr8hPFUusoW9Rbi9LT4h93izwABAaR+27zrv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wnBFIoLe2qdHjMMhjq4vSZtCdvozGVje0XO32Qs3q0=;
 b=gRK6dmPL2/qNr76kmzfgN4GyZ70D4VVjwzW3hrfw6IKyr8VVU/qnxjeF5FAIDjM++ConMKkIxUNKwm8qjgLVUlGAfmMNuUCTqGcDPCSRtklJamgJi3ciC/yg84YpBr4PuCL6/E5TOFzPQX6eZFgad5981EMcp6Tn/cRUlYsBPjRX/NLPk/bGKtGrD82FJysBYrsjZzR8lxvFPqqTX093xQ1q5q+360GbLpS46VMG4Xn7N1OXGDNG3CklE/bToAx4+l6rvyXLMXvY5RCZGPBTGvnDpM+lG5R/BzIyIWjfHV01bz2MkS1pFqngjRIC9ILo3VpS9ZtctIiPIf26q0//4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wnBFIoLe2qdHjMMhjq4vSZtCdvozGVje0XO32Qs3q0=;
 b=JCy2BBi4NR4XkLc6olelYdnJPLZSLMxD3NK7CH6+gn1AFSVLwkPDi6+oO06c01PhCvE0tdyZp9ZJOBTCHL4ExSSpkUQDrq6YkGAu6hKT4UpFk5XizV3yX544DQDuguoZbdnUMg515Qu8Pj9hUxGr/Bc3gtAXOPc16qZOEkukOpg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3817.eurprd04.prod.outlook.com (52.134.73.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.14; Mon, 6 Jan 2020 08:36:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 08:36:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>, Jacky Bai <ping.bai@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will@kernel.org" <will@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] clk: imx: Add support for i.MX8MP clock driver
Thread-Topic: [PATCH 2/3] clk: imx: Add support for i.MX8MP clock driver
Thread-Index: AQHVvFuWiN3d+7pKeE+rF1Aj40+sqqfdAdWAgABZqkA=
Date:   Mon, 6 Jan 2020 08:36:34 +0000
Message-ID: <DB3PR0402MB39164DCE1E5A819A5A614E86F53C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1577412748-28213-1-git-send-email-Anson.Huang@nxp.com>
 <1577412748-28213-2-git-send-email-Anson.Huang@nxp.com>
 <20200106025914.A180E206F0@mail.kernel.org>
In-Reply-To: <20200106025914.A180E206F0@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 048d59f9-074f-4307-472e-08d792838986
x-ms-traffictypediagnostic: DB3PR0402MB3817:|DB3PR0402MB3817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38179633D2F7367B40CA4E27F53C0@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(52536014)(81166006)(66946007)(81156014)(2906002)(8676002)(76116006)(86362001)(316002)(44832011)(110136005)(5660300002)(186003)(7696005)(26005)(6506007)(7416002)(33656002)(8936002)(4326008)(4001150100001)(71200400001)(9686003)(66556008)(64756008)(66476007)(66446008)(55016002)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3817;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bn6/bRuQkl8a/tJXxN3scuwTytHoPgTZow5LWJBSUCKIYGOem4suuf2hruToY4hUrQrmEaec8sdIkx0P6eLjXfnvJF9gvbj97DNp1NwMiMK+VldKSOXBa7M9xikWMeI63RhAAuu8yFs3ItWhWvuTfVVUVeX+67RLV44Ckdnr+d/70R6vMjzasmdCIp7MshEue6/6LTNlsAv1vUQ0hwPLe8UVdubeA7u5Foi1ehjpIDmlmLcDxv/nco7msw/g1lQZABZFahh2aMWqnd7zUxkp28WhgcdReMItO69j6UobkpiaCUXDGKLCMl5PObgvf+U+SUOyNlQ/ly28P6g33oQav2NOgRA/CdN8/0kfXFGSJY7LVIMQnEgzJvWSWXYs4OeZP/f4+Mjhsd/ETXHyD0taMtmnVtHpu/bvXfGWWY/recLR98iVlK3kR8s3G2yOn8MW80rkRliFAoBHzuKwhCCGIjAg5VwoP4jOkVorFKF81lYr7hSMZEZ+WclP8lC5HYoJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048d59f9-074f-4307-472e-08d792838986
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 08:36:34.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w033Ys/c2MzoGfDd3bZGNG8Aaw0fNmaHgflmdIorFR+7B331rLDOxILvH+qMmAPvpDV+Th4uzQLaCS6kjf48Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gY2xrOiBpbXg6IEFkZCBz
dXBwb3J0IGZvciBpLk1YOE1QIGNsb2NrIGRyaXZlcg0KPiANCj4gUXVvdGluZyBBbnNvbiBIdWFu
ZyAoMjAxOS0xMi0yNiAxODoxMjoyNykNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14
L2Nsay1pbXg4bXAuYw0KPiA+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAuYyBuZXcgZmls
ZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+IDAwMDAwMDAuLjdmMGQ0ODINCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAuYw0KPiA+IEBAIC0wLDAg
KzEsNzY3IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4g
Ky8qDQo+ID4gKyAqIENvcHlyaWdodCAyMDE5IE5YUC4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svaW14OG1wLWNsb2NrLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9jbGsuaD4NCj4gDQo+IFBsZWFzZSBpbmNsdWRlIGNsay1wcm92aWRlci5oIGFzIHRo
aXMgaXMgYSBjbGsgcHJvdmlkZXIuIElmIHBvc3NpYmxlLCBkb24ndCBpbmNsdWRlDQo+IGNsay5o
IGFzIHRoaXMgc2hvdWxkbid0IGJlIGEgY29uc3VtZXIuDQoNClRoZSByZWFzb24gb2YgaW5jbHVk
aW5nIGNsay5oIGlzIHRvIGNhbGwgb2ZfY2xrX2dldF9ieV9uYW1lKCkgdG8gZ2V0IHNvbWUgY2xv
Y2tzIGZyb20gRFQsIGN1cnJlbnRseSBvbiBpLk1YOE0NCnNlcmllcyBTb0MsIHdlIHN0aWxsIE5P
VCBzd2l0Y2ggdG8gaHcgYmFzZWQgY2xvY2ssIHNvIHNvbWUgaHcgYmFzZWQgY2xvY2sgQVBJcyBp
cyBOT1QgYWJsZSB0byBiZSB1c2VkLg0KDQo+IA0KPiA+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiANCj4gSXMgdGhpcyBpbmNsdWRlIHVz
ZWQ/DQoNCldpbGwgcmVtb3ZlIGl0IGluIFYyLg0KDQo+IA0KPiA+ICsjaW5jbHVkZSA8bGludXgv
b2ZfYWRkcmVzcy5oPg0KPiANCj4gSXMgdGhpcyBpbmNsdWRlIHVzZWQ/DQoNCkl0IGlzIHVzZWQg
Ynkgb2ZfaW9tYXAgZm9yIGFuYXRvcF9iYXNlIGJlbG93Ow0KDQo+IA0KPiA+ICsjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0K
PiA+ICsNCj4gPiArI2luY2x1ZGUgImNsay5oIg0KPiA+ICsNCj4gPiArc3RhdGljIHUzMiBzaGFy
ZV9jb3VudF9uYW5kOw0KPiA+ICtzdGF0aWMgdTMyIHNoYXJlX2NvdW50X21lZGlhOw0KPiA+ICsN
Cj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKnBsbF9yZWZfc2Vsc1tdID0geyAib3NjXzI0bSIsICJk
dW1teSIsICJkdW1teSIsDQo+ID4gKyJkdW1teSIsIH07DQo+IA0KPiBJcyBpdCBwb3NzaWJsZSB0
byBtYWtlIHRoZXNlIGNvbnN0IGNoYXIgKiBjb25zdCBmb29bXSBhcnJheXM/DQoNCldpbGwgIGlt
cHJvdmUgaXQgaW4gVjIuDQoNCj4gDQo+ID4gK3N0YXRpYyBjb25zdCBjaGFyICphdWRpb19wbGwx
X2J5cGFzc19zZWxzW10gPSB7ImF1ZGlvX3BsbDEiLA0KPiA+ICsiYXVkaW9fcGxsMV9yZWZfc2Vs
IiwgfTsgc3RhdGljIGNvbnN0IGNoYXIgKmF1ZGlvX3BsbDJfYnlwYXNzX3NlbHNbXQ0KPiA+ICs9
IHsiYXVkaW9fcGxsMiIsICJhdWRpb19wbGwyX3JlZl9zZWwiLCB9OyBzdGF0aWMgY29uc3QgY2hh
cg0KPiA+ICsqdmlkZW9fcGxsMV9ieXBhc3Nfc2Vsc1tdID0geyJ2aWRlb19wbGwxIiwgInZpZGVv
X3BsbDFfcmVmX3NlbCIsIH07DQo+IFsuLi5dDQo+ID4gKyAgICAgICBjbGtfc2V0X3BhcmVudChj
bGtzW0lNWDhNUF9BVURJT19QTEwxX0JZUEFTU10sDQo+IGNsa3NbSU1YOE1QX0FVRElPX1BMTDFd
KTsNCj4gPiArICAgICAgIGNsa19zZXRfcGFyZW50KGNsa3NbSU1YOE1QX0FVRElPX1BMTDJfQllQ
QVNTXSwNCj4gY2xrc1tJTVg4TVBfQVVESU9fUExMMl0pOw0KPiA+ICsgICAgICAgY2xrX3NldF9w
YXJlbnQoY2xrc1tJTVg4TVBfVklERU9fUExMMV9CWVBBU1NdLA0KPiBjbGtzW0lNWDhNUF9WSURF
T19QTEwxXSk7DQo+ID4gKyAgICAgICBjbGtfc2V0X3BhcmVudChjbGtzW0lNWDhNUF9EUkFNX1BM
TF9CWVBBU1NdLA0KPiBjbGtzW0lNWDhNUF9EUkFNX1BMTF0pOw0KPiA+ICsgICAgICAgY2xrX3Nl
dF9wYXJlbnQoY2xrc1tJTVg4TVBfR1BVX1BMTF9CWVBBU1NdLA0KPiBjbGtzW0lNWDhNUF9HUFVf
UExMXSk7DQo+ID4gKyAgICAgICBjbGtfc2V0X3BhcmVudChjbGtzW0lNWDhNUF9WUFVfUExMX0JZ
UEFTU10sDQo+IGNsa3NbSU1YOE1QX1ZQVV9QTExdKTsNCj4gPiArICAgICAgIGNsa19zZXRfcGFy
ZW50KGNsa3NbSU1YOE1QX0FSTV9QTExfQllQQVNTXSwNCj4gY2xrc1tJTVg4TVBfQVJNX1BMTF0p
Ow0KPiA+ICsgICAgICAgY2xrX3NldF9wYXJlbnQoY2xrc1tJTVg4TVBfU1lTX1BMTDFfQllQQVNT
XSwNCj4gY2xrc1tJTVg4TVBfU1lTX1BMTDFdKTsNCj4gPiArICAgICAgIGNsa19zZXRfcGFyZW50
KGNsa3NbSU1YOE1QX1NZU19QTEwyX0JZUEFTU10sDQo+IGNsa3NbSU1YOE1QX1NZU19QTEwyXSk7
DQo+ID4gKyAgICAgICBjbGtfc2V0X3BhcmVudChjbGtzW0lNWDhNUF9TWVNfUExMM19CWVBBU1Nd
LA0KPiA+ICsgY2xrc1tJTVg4TVBfU1lTX1BMTDNdKTsNCj4gDQo+IFRoZXNlIGNhbid0IGJlIGRv
bmUgd2l0aCBhc3NpZ25lZC1jbG9jay1wYXJlbnRzIHByb3BlcnRpZXMgaW4gRFQ/DQoNCkFoLCB5
ZXMsIHdpbGwgcmVtb3ZlIHRoZW0gYW5kIHB1dCB0aGVtIGluIERUIGlzIG5lY2Vzc2FyeS4NCg0K
PiANCj4gPiArDQo+ID4gKyAgICAgICBjbGtzW0lNWDhNUF9BVURJT19QTEwxX09VVF0gPSBpbXhf
Y2xrX2dhdGUoImF1ZGlvX3BsbDFfb3V0IiwNCj4gImF1ZGlvX3BsbDFfYnlwYXNzIiwgYmFzZSwg
MTMpOw0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfQVVESU9fUExMMl9PVVRdID0gaW14X2Nsa19n
YXRlKCJhdWRpb19wbGwyX291dCIsDQo+ICJhdWRpb19wbGwyX2J5cGFzcyIsIGJhc2UgKyAweDE0
LCAxMyk7DQo+ID4gKyAgICAgICBjbGtzW0lNWDhNUF9WSURFT19QTEwxX09VVF0gPSBpbXhfY2xr
X2dhdGUoInZpZGVvX3BsbDFfb3V0IiwNCj4gInZpZGVvX3BsbDFfYnlwYXNzIiwgYmFzZSArIDB4
MjgsIDEzKTsNCj4gPiArICAgICAgIGNsa3NbSU1YOE1QX0RSQU1fUExMX09VVF0gPSBpbXhfY2xr
X2dhdGUoImRyYW1fcGxsX291dCIsDQo+ICJkcmFtX3BsbF9ieXBhc3MiLCBiYXNlICsgMHg1MCwg
MTMpOw0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfR1BVX1BMTF9PVVRdID0gaW14X2Nsa19nYXRl
KCJncHVfcGxsX291dCIsDQo+ICJncHVfcGxsX2J5cGFzcyIsIGJhc2UgKyAweDY0LCAxMSk7DQo+
ID4gKyAgICAgICBjbGtzW0lNWDhNUF9WUFVfUExMX09VVF0gPSBpbXhfY2xrX2dhdGUoInZwdV9w
bGxfb3V0IiwNCj4gInZwdV9wbGxfYnlwYXNzIiwgYmFzZSArIDB4NzQsIDExKTsNCj4gPiArICAg
ICAgIGNsa3NbSU1YOE1QX0FSTV9QTExfT1VUXSA9IGlteF9jbGtfZ2F0ZSgiYXJtX3BsbF9vdXQi
LA0KPiAiYXJtX3BsbF9ieXBhc3MiLCBiYXNlICsgMHg4NCwgMTEpOw0KPiA+ICsgICAgICAgY2xr
c1tJTVg4TVBfU1lTX1BMTDFfT1VUXSA9IGlteF9jbGtfZ2F0ZSgic3lzX3BsbDFfb3V0IiwNCj4g
InN5c19wbGwxX2J5cGFzcyIsIGJhc2UgKyAweDk0LCAxMSk7DQo+ID4gKyAgICAgICBjbGtzW0lN
WDhNUF9TWVNfUExMMl9PVVRdID0gaW14X2Nsa19nYXRlKCJzeXNfcGxsMl9vdXQiLA0KPiAic3lz
X3BsbDJfYnlwYXNzIiwgYmFzZSArIDB4MTA0LCAxMSk7DQo+ID4gKyAgICAgICBjbGtzW0lNWDhN
UF9TWVNfUExMM19PVVRdID0gaW14X2Nsa19nYXRlKCJzeXNfcGxsM19vdXQiLA0KPiA+ICsgInN5
c19wbGwzX2J5cGFzcyIsIGJhc2UgKyAweDExNCwgMTEpOw0KPiANCj4gQW55IHJlYXNvbiB3aHkg
d2UgY2FuJ3QgZ2V0IGJhY2sgY2xrX2h3IHBvaW50ZXJzIGluc3RlYWQgYW5kIHJlZ2lzdGVyIGEg
aHcNCj4gYmFzZWQgcHJvdmlkZXI/DQoNCkJlY2F1c2UgaS5NWDhNIHNlcmllcyBTb0NzIGFyZSBz
dGlsbCBOT1QgdXNpbmcgaHcgYmFzZWQgY2xvY2sgaW1wbGVtZW50YXRpb24sIHNvbWUgb2YNCnRo
ZSBBUElzIGFyZSBzaGFyZWQsIGxpa2UgaW14X2Nsa19wbGwxNHh4KCkgYW5kIGlteDhtX2Nsa19j
b21wb3NpdGUoKSBldGMuLCBzbyBJIHRoaW5rIGl0IGlzDQpiZXR0ZXIgdG8ga2VlcCB0aGVtKGku
TVg4TVEvaS5NWDhNTS9pLk1YOE1OL2kuTVg4TVApIGFsaWduZWQsIGFuZCBJIHdpbGwgZmluZCBh
IGNoYW5jZSBzb29uDQp0byBkbyBhIHBhdGNoIHNlcmllcyB0byBzd2l0Y2ggYWxsIG9mIHRoZW0g
dG8gaHcgYmFzZWQgY2xvY2ssIGRvZXMgaXQgbWFrZSBzZW5zZSB0byB5b3U/IA0KDQo+IA0KPiA+
ICsNCj4gPiArICAgICAgIGNsa3NbSU1YOE1QX1NZU19QTEwxXzQwTV0gPSBpbXhfY2xrX2ZpeGVk
X2ZhY3Rvcigic3lzX3BsbDFfNDBtIiwNCj4gInN5c19wbGwxX291dCIsIDEsIDIwKTsNCj4gPiAr
ICAgICAgIGNsa3NbSU1YOE1QX1NZU19QTEwxXzgwTV0gPSBpbXhfY2xrX2ZpeGVkX2ZhY3Rvcigi
c3lzX3BsbDFfODBtIiwNCj4gInN5c19wbGwxX291dCIsIDEsIDEwKTsNCj4gPiArICAgICAgIGNs
a3NbSU1YOE1QX1NZU19QTEwxXzEwME1dID0NCj4gaW14X2Nsa19maXhlZF9mYWN0b3IoInN5c19w
bGwxXzEwMG0iLCAic3lzX3BsbDFfb3V0IiwgMSwgOCk7DQo+ID4gKyAgICAgICBjbGtzW0lNWDhN
UF9TWVNfUExMMV8xMzNNXSA9DQo+IGlteF9jbGtfZml4ZWRfZmFjdG9yKCJzeXNfcGxsMV8xMzNt
IiwgInN5c19wbGwxX291dCIsIDEsIDYpOw0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfU1lTX1BM
TDFfMTYwTV0gPQ0KPiBpbXhfY2xrX2ZpeGVkX2ZhY3Rvcigic3lzX3BsbDFfMTYwbSIsICJzeXNf
cGxsMV9vdXQiLCAxLCA1KTsNCj4gPiArICAgICAgIGNsa3NbSU1YOE1QX1NZU19QTEwxXzIwME1d
ID0NCj4gaW14X2Nsa19maXhlZF9mYWN0b3IoInN5c19wbGwxXzIwMG0iLCAic3lzX3BsbDFfb3V0
IiwgMSwgNCk7DQo+ID4gKyAgICAgICBjbGtzW0lNWDhNUF9TWVNfUExMMV8yNjZNXSA9DQo+IGlt
eF9jbGtfZml4ZWRfZmFjdG9yKCJzeXNfcGxsMV8yNjZtIiwgInN5c19wbGwxX291dCIsIDEsIDMp
Ow0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfU1lTX1BMTDFfNDAwTV0gPQ0KPiBpbXhfY2xrX2Zp
eGVkX2ZhY3Rvcigic3lzX3BsbDFfNDAwbSIsICJzeXNfcGxsMV9vdXQiLCAxLCAyKTsNCj4gPiAr
ICAgICAgIGNsa3NbSU1YOE1QX1NZU19QTEwxXzgwME1dID0NCj4gPiArIGlteF9jbGtfZml4ZWRf
ZmFjdG9yKCJzeXNfcGxsMV84MDBtIiwgInN5c19wbGwxX291dCIsIDEsIDEpOw0KPiA+ICsNCj4g
PiArICAgICAgIGNsa3NbSU1YOE1QX1NZU19QTEwyXzUwTV0gPSBpbXhfY2xrX2ZpeGVkX2ZhY3Rv
cigic3lzX3BsbDJfNTBtIiwNCj4gInN5c19wbGwyX291dCIsIDEsIDIwKTsNCj4gPiArICAgICAg
IGNsa3NbSU1YOE1QX1NZU19QTEwyXzEwME1dID0NCj4gaW14X2Nsa19maXhlZF9mYWN0b3IoInN5
c19wbGwyXzEwMG0iLCAic3lzX3BsbDJfb3V0IiwgMSwgMTApOw0KPiA+ICsgICAgICAgY2xrc1tJ
TVg4TVBfU1lTX1BMTDJfMTI1TV0gPQ0KPiBpbXhfY2xrX2ZpeGVkX2ZhY3Rvcigic3lzX3BsbDJf
MTI1bSIsICJzeXNfcGxsMl9vdXQiLCAxLCA4KTsNCj4gPiArICAgICAgIGNsa3NbSU1YOE1QX1NZ
U19QTEwyXzE2Nk1dID0NCj4gaW14X2Nsa19maXhlZF9mYWN0b3IoInN5c19wbGwyXzE2Nm0iLCAi
c3lzX3BsbDJfb3V0IiwgMSwgNik7DQo+ID4gKyAgICAgICBjbGtzW0lNWDhNUF9TWVNfUExMMl8y
MDBNXSA9DQo+IGlteF9jbGtfZml4ZWRfZmFjdG9yKCJzeXNfcGxsMl8yMDBtIiwgInN5c19wbGwy
X291dCIsIDEsIDUpOw0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfU1lTX1BMTDJfMjUwTV0gPQ0K
PiBpbXhfY2xrX2ZpeGVkX2ZhY3Rvcigic3lzX3BsbDJfMjUwbSIsICJzeXNfcGxsMl9vdXQiLCAx
LCA0KTsNCj4gPiArICAgICAgIGNsa3NbSU1YOE1QX1NZU19QTEwyXzMzM01dID0NCj4gaW14X2Ns
a19maXhlZF9mYWN0b3IoInN5c19wbGwyXzMzM20iLCAic3lzX3BsbDJfb3V0IiwgMSwgMyk7DQo+
ID4gKyAgICAgICBjbGtzW0lNWDhNUF9TWVNfUExMMl81MDBNXSA9DQo+IGlteF9jbGtfZml4ZWRf
ZmFjdG9yKCJzeXNfcGxsMl81MDBtIiwgInN5c19wbGwyX291dCIsIDEsIDIpOw0KPiA+ICsgICAg
ICAgY2xrc1tJTVg4TVBfU1lTX1BMTDJfMTAwME1dID0NCj4gPiArIGlteF9jbGtfZml4ZWRfZmFj
dG9yKCJzeXNfcGxsMl8xMDAwbSIsICJzeXNfcGxsMl9vdXQiLCAxLCAxKTsNCj4gPiArDQo+ID4g
KyAgICAgICBucCA9IGRldi0+b2Zfbm9kZTsNCj4gPiArICAgICAgIGJhc2UgPSBkZXZtX3BsYXRm
b3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ID4gKyAgICAgICBpZiAoV0FSTl9PTihJ
U19FUlIoYmFzZSkpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoYmFzZSk7
DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gdW5yZWdpc3Rlcl9jbGtzOw0KPiANCj4gV2h5IG5v
dCBpb3JlbWFwIGZpcnN0IHNvIHdlIGRvbid0IGhhdmUgdG8gdW53aW5kIGNsayByZWdpc3RyYXRp
b24gb24gZmFpbHVyZT8NCg0KWWVzLCBJIHdpbGwgZG8gaXQgaW4gVjIuDQoNCj4gDQo+ID4gKyAg
ICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfQ0xLX0E1M19TUkNdID0gaW14
X2Nsa19tdXgyKCJhcm1fYTUzX3NyYyIsIGJhc2UgKw0KPiAweDgwMDAsIDI0LCAzLCBpbXg4bXBf
YTUzX3NlbHMsIEFSUkFZX1NJWkUoaW14OG1wX2E1M19zZWxzKSk7DQo+ID4gKyAgICAgICBjbGtz
W0lNWDhNUF9DTEtfTTdfU1JDXSA9IGlteF9jbGtfbXV4MigiYXJtX203X3NyYyIsIGJhc2UgKw0K
PiAweDgwODAsIDI0LCAzLCBpbXg4bXBfbTdfc2VscywgQVJSQVlfU0laRShpbXg4bXBfbTdfc2Vs
cykpOw0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfQ0xLX01MX1NSQ10gPSBpbXhfY2xrX211eDIo
Im1sX3NyYyIsIGJhc2UgKyAweDgxMDAsDQo+IDI0LCAzLCBpbXg4bXBfbWxfc2VscywgQVJSQVlf
U0laRShpbXg4bXBfbWxfc2VscykpOw0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfQ0xLX0dQVTNE
X0NPUkVfU1JDXSA9DQo+IGlteF9jbGtfbXV4MigiZ3B1M2RfY29yZV9zcmMiLCBiYXNlICsgMHg4
MTgwLCAyNCwgMywNCj4gaW14OG1wX2dwdTNkX2NvcmVfc2VscywgQVJSQVlfU0laRShpbXg4bXBf
Z3B1M2RfY29yZV9zZWxzKSk7DQo+ID4gKyAgICAgICBjbGtzW0lNWDhNUF9DTEtfR1BVM0RfU0hB
REVSX1NSQ10gPQ0KPiBpbXhfY2xrX211eDIoImdwdTNkX3NoYWRlcl9zcmMiLCBiYXNlICsgMHg4
MjAwLCAyNCwgMywNCj4gaW14OG1wX2dwdTNkX3NoYWRlcl9zZWxzLCBBUlJBWV9TSVpFKGlteDht
cF9ncHUzZF9zaGFkZXJfc2VscykpOw0KPiA+ICsgICAgICAgY2xrc1tJTVg4TVBfQ0xLX0dQVTJE
X1NSQ10gPSBpbXhfY2xrX211eDIoImdwdTJkX3NyYyIsIGJhc2UgKw0KPiAweDgyODAsIDI0LCAz
LCBpbXg4bXBfZ3B1MmRfc2VscywgQVJSQVlfU0laRShpbXg4bXBfZ3B1MmRfc2VscykpOw0KPiA+
ICsgICAgICAgY2xrc1tJTVg4TVBfQ0xLX0FVRElPX0FYSV9TUkNdID0gaW14X2Nsa19tdXgyKCJh
dWRpb19heGlfc3JjIiwNCj4gPiArIGJhc2UgKyAweDgzMDAsIDI0LCAzLCBpbXg4bXBfYXVkaW9f
YXhpX3NlbHMsDQo+ID4gKyBBUlJBWV9TSVpFKGlteDhtcF9hdWRpb19heGlfc2VscykpOw0KPiBb
Li4uXQ0KPiA+ICsNCj4gPiArICAgICAgIGlteF9yZWdpc3Rlcl91YXJ0X2Nsb2Nrcyh1YXJ0X2Ns
a3MpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArdW5yZWdpc3Rl
cl9jbGtzOg0KPiA+ICsgICAgICAgaW14X3VucmVnaXN0ZXJfY2xvY2tzKGNsa3MsIEFSUkFZX1NJ
WkUoY2xrcykpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteDhtcF9jbGtfb2ZfbWF0
Y2hbXSA9IHsNCj4gPiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1jY20iIH0s
DQo+ID4gKyAgICAgICB7IC8qIFNlbnRpbmVsICovIH0sDQo+IA0KPiBQbGVhc2UgZHJvcCB0aGUg
Y29tbWEgYWZ0ZXIgc2VudGluZWwgc28gdGhhdCBub3RoaW5nIGNhbiBnbyBhZnRlciBpdC4NCg0K
V2lsbCBkbyBpdCBpbiBWMi4NCg0KVGhhbmtzLA0KQW5zb24NCg==
