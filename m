Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D11C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4642245C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ifTEUPLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfKFBSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:18:21 -0500
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:30276
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730022AbfKFBSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 20:18:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsTRy0PmkL+AYGpEHWs1gHzxUw3kIQ4Fv26o1tLo5/+63GxmQ93Lfxl2euwItYpIH0tQ3LjpNKKee4rqI2HufR4JrkTUFG00j3RXrGDdYh6kgjMqq/7GEbS0SLuImCQDetnUoJ81eDfJ3228VAN2143M8omA7UXFH4yCwY3TBfbm0gcoy+tX8AIIJM3v9a0rwAZFgH6ciuN0Ioa3ooejSULeJ/R7tFSUhepVunll4MQEBzZoQHQWVWAi+yPecwzVrVOPmXznOKLWJA6pVT4rjVN20I7TeW+cCMkMRqFbls1vpPDEm8/Mc0LbJLB+wgZAZGeA15Sdj/7EbaTVbC7Bxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v0ETZoKv7r8OqNEEcZWbCbhQXD+oTMo8o9Ky7AAofE=;
 b=eg9uMpI2q9oVML03Kk5I5kXJjxl+JuYxkBzykJRWB20bOTnONiS93o3wFKhtFbDdTHTDpLhdiiq3l1bIzL6tqOUeTt+Us/6ZcHFvPDVXv9ZmLWLYbpkfkFWZZdNrCH4BysVBJF/lO+uU9XEL+2cHNSHp0mung/MBlDbbJzxnwicCJBbpgit7/NEredDz7ufJYzcCBz97Y7PXAoEZPFHSG53Rzzt4chtqZBl/w+JaVm5e16lFe4d8SAx+rqV3lACcdYb/b3VEyoki9s2WFt9kN0exWvnFTySDPUJ7hutK8BefiC6pwL8UJFECTVHqVMGoDzaxhgtoF4qliAQBdJRTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v0ETZoKv7r8OqNEEcZWbCbhQXD+oTMo8o9Ky7AAofE=;
 b=ifTEUPLPgpqO8utUSm7SN8ZqmaSH6OhJ5c74sBPDZbwN9puvCmvw2+pTAeWVmSvEU9N6dxV0JcNcKpGbCv0XQN26mAf20LzPr0B9Pzd+a5Tlfspr99+UlStllNbXrJp9iaS+jutNrc/96ZCKkSHKu3lR1gmkjzZLcSHjMoHXJno=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5619.eurprd04.prod.outlook.com (20.178.119.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 01:18:17 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:18:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] clk: imx: pll14xx: initialize flags to 0
Thread-Topic: [PATCH] clk: imx: pll14xx: initialize flags to 0
Thread-Index: AQHVk6mXpyRie0JbfEaM7Eg+PLW60ad8ilUAgADOL2A=
Date:   Wed, 6 Nov 2019 01:18:16 +0000
Message-ID: <AM0PR04MB4481DC8B916E01AFF2D4BA8788790@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1572938372-7006-1-git-send-email-peng.fan@nxp.com>
 <7966140a-7fec-0a8f-6ced-e4fbccef51da@pengutronix.de>
In-Reply-To: <7966140a-7fec-0a8f-6ced-e4fbccef51da@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe1d5e94-8b93-43e5-b219-08d7625733f7
x-ms-traffictypediagnostic: AM0PR04MB5619:|AM0PR04MB5619:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5619C0B75898759A1452BAD588790@AM0PR04MB5619.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(54906003)(110136005)(6436002)(316002)(966005)(6246003)(186003)(2501003)(478600001)(14454004)(45080400002)(71200400001)(446003)(11346002)(86362001)(71190400001)(44832011)(25786009)(8936002)(486006)(2201001)(74316002)(305945005)(8676002)(7736002)(476003)(81156014)(6636002)(81166006)(7696005)(53546011)(5660300002)(6306002)(76176011)(76116006)(99286004)(26005)(14444005)(256004)(102836004)(33656002)(66476007)(6116002)(2906002)(3846002)(4326008)(66556008)(64756008)(66446008)(229853002)(9686003)(66066001)(55016002)(66946007)(6506007)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5619;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SV9CdZRpivAwklmjw2gB9bypLLXO0QEVSruuh11hm1f9PlWnVUm4MWIxkeBUVYfCBw70RMH2Jpc4fhKP89+xDDezd6Jt/yqETdhyLcpcYzmmAjwzIOXvZiopS8LpObAcbJiUg0MyxEDL9Iv8NNRjSLmqqGoja7r/FjFY1reIPaVCTSIxOVle3ddxwzGMSxHXwY/VLM0P3wkY0loIE8UwXxJ3ni6Mgk/y50ORPtEOJP5cTdViTZIWEBdzZ3hAixd+a32q1l16oeL30mBnVI6CCi0jeCEEWZbpxK70DBBKGqbtJo26eMMyTGDDqsXqyfXNHzEti0x9yZ2uuSlJB7sxlvkXcjZSsiJRVV4zGqLYi8VRJFGhK22PW/YKKNCyHtaYKw7SLadShvrRmsdZN8qv2mvg2xhJLtrJts81RS6obLVhuHlfS6I6Plk0KB0WjO3KzLx5vj41EopwE2h/aiiTggZSufcsPhO43UhKhrmloZA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1d5e94-8b93-43e5-b219-08d7625733f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:18:16.9382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUQQHoe9/4AsKorGSlYOBy0vJRJtDHMEqO13scnyx66bOCG2i1H6nbdhZLgT6yCYHeD+pKOhWLONTNj34N4BRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDogcGxsMTR4eDogaW5pdGlhbGl6ZSBmbGFn
cyB0byAwDQo+IA0KPiBIZWxsbyBQZW5nLA0KPiANCj4gT24gMTEvNS8xOSA4OjIxIEFNLCBQZW5n
IEZhbiB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0K
PiA+IGluaXQuZmxhZ3MgaXMgaW5pdGlhbGl6ZWQgd2l0aCB2YWx1ZSBmcm9tIHBsbF9jbGstPmZs
YWdzLCBob3dldmVyDQo+ID4gaW14XzE0NDN4X3BsbCBhbmQgaW14XzE0MTZ4X3BsbCBhcmUgbm90
IHN0YXRpYyBzdHJ1Y3R1cmUsDQo+IA0KPiBUaGV5IGRvbid0IGhhdmUgYSBzdGF0aWMgaW4gZnJv
bnQgb2YgdGhlbSwgYnV0IHRoZXkgc3RpbGwgaGF2ZSBzdGF0aWMgc3RvcmFnZQ0KPiBkdXJhdGlv
bi4NCg0KWWVzLiBJIGFtIHdyb25nLg0KDQo+IA0KPiA+IHNvIGZsYWdzDQo+ID4gbWlnaHQgYmUg
cmFuZG9tIHZhbHVlLiBTbyBsZXQncyBpbml0aWFsaXplIGZsYWdzIGFzIDAgbm93Lg0KPiANCj4g
SSBmYWlsIHRvIHNlZSBob3cuIE1lbWJlcnMgbm90IGxpc3RlZCBpbiB0aGUgeyBpbml0aWFsaXpl
ci1saXN0IH0gYXJlIGltcGxpY2l0bHkNCj4gaW5pdGlhbGl6ZWQgYXMgaWYgdGhleSB3ZXJlIHN0
YXRpYyBvYmplY3RzLCBzbyBmbGFncyBzaG91bGQgYWxyZWFkeSBiZSB6ZXJvLg0KDQpVbmRlcnN0
YW5kLg0KDQo+IA0KPiAoSSBhc3N1bWVkIHRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gU2hhd24ncyBp
bXgtY2xrLTUuNSB0YWcpDQoNClllcy4NCg0KRHJvcCB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQpQ
ZW5nLg0KDQo+IA0KPiBDaGVlcnMNCj4gQWhtYWQNCj4gDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Y2xrL2lteC9jbGstcGxsMTR4eC5jIHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1wbGwx
NHh4LmMNCj4gPiBiL2RyaXZlcnMvY2xrL2lteC9jbGstcGxsMTR4eC5jIGluZGV4IGZhNzZlMDQy
NTFjNC4uYTdmMWMxYWJlNjY0DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14
L2Nsay1wbGwxNHh4LmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbDE0eHguYw0K
PiA+IEBAIC02NSwxMiArNjUsMTQgQEAgc3RydWN0IGlteF9wbGwxNHh4X2NsayBpbXhfMTQ0M3hf
cGxsID0gew0KPiA+ICAJLnR5cGUgPSBQTExfMTQ0M1gsDQo+ID4gIAkucmF0ZV90YWJsZSA9IGlt
eF9wbGwxNDQzeF90YmwsDQo+ID4gIAkucmF0ZV9jb3VudCA9IEFSUkFZX1NJWkUoaW14X3BsbDE0
NDN4X3RibCksDQo+ID4gKwkuZmxhZ3MgPSAwLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBp
bXhfcGxsMTR4eF9jbGsgaW14XzE0MTZ4X3BsbCA9IHsNCj4gPiAgCS50eXBlID0gUExMXzE0MTZY
LA0KPiA+ICAJLnJhdGVfdGFibGUgPSBpbXhfcGxsMTQxNnhfdGJsLA0KPiA+ICAJLnJhdGVfY291
bnQgPSBBUlJBWV9TSVpFKGlteF9wbGwxNDE2eF90YmwpLA0KPiA+ICsJLmZsYWdzID0gMCwNCj4g
PiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wbGwxNHh4X3JhdGVfdGFi
bGUgKmlteF9nZXRfcGxsX3NldHRpbmdzKA0KPiA+DQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBl
LksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiB8DQo+IEluZHVzdHJpYWwgTGludXgg
U29sdXRpb25zICAgICAgICAgICAgICAgICB8DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3LnANCj4gZW5ndXRyb25p
eC5kZSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDcGVuZy5mYW4lNDBueHAuY29tJTdDZDE5ZjZmNw0K
PiA2ZjQ5ZTQwZWQ1MTYxMDhkNzYxZWZmODhkJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlN0MNCj4gMCU3QzElN0M2MzcwODU1NTU2MDQ3OTczMDAmYW1wO3NkYXRhPU1WVXZJUFVG
cGtoTGo2S0RzMVphMnNCVQ0KPiBGTlBNcld2Uzl2QTlCdXhxUTNrJTNEJmFtcDtyZXNlcnZlZD0w
ICB8DQo+IFBlaW5lciBTdHIuIDYtOCwgMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSB8IFBob25l
OiArNDktNTEyMS0yMDY5MTctMA0KPiB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAy
Njg2ICAgICAgICAgICB8IEZheDoNCj4gKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0K
