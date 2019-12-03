Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C422AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8942071E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qEZL/Jq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCBJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:09:28 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:29344
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfLCBJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:09:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2NM4Q18+U6ML2fosbviXuV3I1kbw7Z8sMeLt1zepMRhjpQTEYYGpKEvIfVfIWufzF5ynx9vVi5DopnWDAQbZ/c34kEuciQQfXbDvmyEyQ4qJD8LLbNm04QarUPJ6yVCsgAbiZw+hKyLq9ghzquct1odOTjm1OISDOXqYgnBdC68u5Gooes7EVshjVqTYoobtDzmdY9G3fEkf8hb+ihl7W71W5HR9WpIlcYzrEenyeRAHi3hct3T6fgGBTrsiEuZMSVPpOzW3Yxbf9rDq7+36yNuaOQzqoQIEDkSJqN8vmnoO5NBMa6c4YoCIgAA+f140T6KqeTEBz8cEpCVNC2Zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlrGPbDjwjYFh5ed9OfJpmuV7eFiBxF2mk9g1RpC4o0=;
 b=WJRl4s8jfvgdBFCn+EIgw5XsGfBY216R3U9hW6kZRLTPBkGQyH18orv57wcl+vG0Ww6mAffW7EGWoVYWBYEZQV7GflgQ5uTxeTHppdiihPieefSnpYyCvdC0wpS6IgIOW7fnj04q4X7H7U4mSaU+87uHq2no/sMZ4g/9Wu1j7oJHOtWGyQfbYdNytmXLRyP7kc6tk0ig5jeZGt+LQlc86eLCjpwXI5YayCvr7AL9ZE0a5JNWt1y8IXPsmkwMy616lGMQ+8cGyk+w3dh3xpOX8Ny7szFhzdg9e61rbpnmABbVJynNEQt8ExZh6mkaQ8eM/Z6SaisYU9UBRd0gwwsLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlrGPbDjwjYFh5ed9OfJpmuV7eFiBxF2mk9g1RpC4o0=;
 b=qEZL/Jq6tGAFhKJB/i2VGz9Vg//IKn1T8APBoBiYIh6UFezb7fJjX6DULblceEm31C79IuR3WQHZSN9ssODqJSkAG8Xdna2+4iy+LrgsD4qfT9s07WuiCd2PsBM1YuM9yhhX9MaFabDWbYugD15O31TZBkxCG9Re5nF3diP2KP4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3660.eurprd04.prod.outlook.com (52.134.70.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 01:09:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 01:09:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx7ulp: Add cpu clock-frequency property
Thread-Topic: [PATCH] ARM: dts: imx7ulp: Add cpu clock-frequency property
Thread-Index: AQHVk3uAArm3im3y4kKhOJwaQWTXG6enBzSAgAC9zfA=
Date:   Tue, 3 Dec 2019 01:09:22 +0000
Message-ID: <DB3PR0402MB39164DF380E6B13558E758E7F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1572918578-13544-1-git-send-email-Anson.Huang@nxp.com>
 <20191202134748.GB21897@dragon>
In-Reply-To: <20191202134748.GB21897@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79df1204-19db-430c-aac6-08d7778d6e95
x-ms-traffictypediagnostic: DB3PR0402MB3660:|DB3PR0402MB3660:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3660EDEEEDDFB99E92853F7BF5420@DB3PR0402MB3660.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(6116002)(71190400001)(478600001)(66066001)(74316002)(9686003)(33656002)(54906003)(7696005)(44832011)(14444005)(229853002)(4326008)(6436002)(86362001)(186003)(446003)(316002)(7736002)(25786009)(11346002)(305945005)(6506007)(3846002)(256004)(76116006)(5660300002)(55016002)(76176011)(14454004)(99286004)(71200400001)(52536014)(26005)(66946007)(102836004)(66476007)(66556008)(64756008)(66446008)(8676002)(81156014)(81166006)(6246003)(2906002)(6916009)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3660;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRRAga7zbonzYUQxKiiWXESrzRZV1IIydGzcAKawIA5jhEL8rNtZmiW6onMqTxi4EzPDPNTaSYT9ZVLsNabeIEhKe55WBizccAkdjLojltvWCLoaFbUENcaQLq0m6TM/PDr3tSEdKRiO80TLK3FvHv+qqedXyklQPVJKr9FQmpAdswiJqCVpZxARa/yy9qz4EYD1omoBZ+YzoFKlq9iZJOqejQUgPJA0jN4gGkUCEx4ZNSPA8YT01Y45NUpu7f7Jpap7hlu2pZ32mMK01VC1bTbCnKn9rUkhb11EM0yXqCL9gK2juLAX7Wa1F57j4bpG7VEBgnVO0U1phRyYtv2oJvqX+X2/xCCaqNBe5bMkj0dy3TVYvrqzTwgs+H3SLSqkq9dqVUytx/A9iT8O6m3xIm3YSq4F5iv3lblzL4M5PcZ9u/WRy7JfcTcqKIDkUojS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79df1204-19db-430c-aac6-08d7778d6e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 01:09:22.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SplTI36hhO0rIzdawBBipOVfjZcihOII+HYoerTErWHVv5pjAhmAKkL+xtxmj8nxnwTbg9fdLr46hFKFbipo+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogZHRzOiBpbXg3dWxwOiBBZGQgY3B1IGNsb2Nr
LWZyZXF1ZW5jeSBwcm9wZXJ0eQ0KPiANCj4gT24gVHVlLCBOb3YgMDUsIDIwMTkgYXQgMDk6NDk6
MzhBTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gQWRkICJjbG9jay1mcmVxdWVuY3ki
IHByb3BlcnR5IHRvIGF2b2lkIGJlbG93IHdhcm5pbmcgb24gaS5NWDdVTFA6DQo+ID4NCj4gPiBb
ICAgIDAuMDExNzYyXSAvY3B1cy9jcHVAMCBtaXNzaW5nIGNsb2NrLWZyZXF1ZW5jeSBwcm9wZXJ0
eQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaSB8IDEgKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDd1bHAuZHRzaSBpbmRleCBkMzdhMTkyLi44N2IyMjM3IDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDd1bHAuZHRzaQ0KPiA+IEBAIC00MSw2ICs0MSw3IEBADQo+ID4gIAkJCWNvbXBhdGlibGUg
PSAiYXJtLGNvcnRleC1hNyI7DQo+ID4gIAkJCWRldmljZV90eXBlID0gImNwdSI7DQo+ID4gIAkJ
CXJlZyA9IDwwPjsNCj4gPiArCQkJY2xvY2stZnJlcXVlbmN5ID0gPDUwMDIxMDUyNj47DQo+IA0K
PiBJIGNhbm5vdCBmaW5kIHRoZSBiaW5kaW5nIGRvYyBmb3IgdGhpcyBwcm9wZXJ0eS4gIFdoYXQg
aXMgdGhlIGRlZmluaXRpb24gb2YgaXQsDQo+IHRoZSBtYXhpbXVtIGZyZXF1ZW5jeSB0aGF0IHRo
ZSBjcHUgY291bGQgcG9zc2libHkgcnVuIGF0Pw0KDQoNClRoZSBjb2RlIGlzIGFzIGJlbG93LCBt
YXliZSB0aGUgcHJvcGVydHkgaXMgbWlzc2luZyBmcm9tIHRoZSBiZWdpbm5pbmcgb2YgdGhpcyBj
b2RlLA0KdGhpcyBwcm9wZXJ0eSBzaG91bGQgbWVhbiB0aGUgY3VycmVudCBmcmVxdWVuY3kgb2Yg
Q1BVIHJ1bm5pbmcgYXQgSSB0aGluazoNCg0KYXJjaC9hcm0va2VybmVsL3RvcG9sb2d5LmMNCg0K
MTIyICAgICAgICAgICAgICAgICByYXRlID0gb2ZfZ2V0X3Byb3BlcnR5KGNuLCAiY2xvY2stZnJl
cXVlbmN5IiwgJmxlbik7DQoxMjMgICAgICAgICAgICAgICAgIGlmICghcmF0ZSB8fCBsZW4gIT0g
NCkgew0KMTI0ICAgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiJXBPRiBtaXNzaW5nIGNs
b2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eVxuIiwgY24pOw0KMTI1ICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRpbnVlOw0KMTI2ICAgICAgICAgICAgICAgICB9DQoNClRoYW5rcywNCkFuc29uDQo=
