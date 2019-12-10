Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBAC2BD09
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405C120726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rp0DRbOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfLJC0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:26:52 -0500
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:2711
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbfLJC0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:26:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXNlkRvz5BE1J7dz10M+uEWCa7ZjKWAgrRt37myXbKHX/0UK0vtja5e97AaGpZOwrQAiUh0eCH/AAwX9cqNo9IpVXt9xSJQHGti2qYHTJFBRwHvRBP4M01YAjXjHJ8aO5GbUmc+CyCkO50vYKRAJIabmM08B8N49a2M7PoqY164wxUD0kJj1owT6wzmM0qWsmURqppoyHkOfqSOKr3mZtjzNqEnXnB0djXdJqgOhFLszwUTUsFAENfvnndartB064pt64XWMPC6Bkd2fHrIzb5NiyHJmMrU5ZXsMjnlxoYtRoAsTSZ5gSAhNfiFtcTFoCa9WYdEzSX5LcYHKx0cuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TigtWHE4TpJALLyyi4xRM1Q6S6cSsRg1hfFOrKTUCrg=;
 b=cMEvdNGZtivrTr1GdcY+n/0+YaEB8l/dv6GhRTEkO0tQoEGKlr0cGC6WafA0XngAXj20QPGy25Ht6FIA/gT3hzIynONZc2uliF/69Q97ldOoIZ+e8IWaAsu6wtEK6iv3cjByVYJ3XFhfmSLZRQWLASYYCMzdpS8XXhEJcN4AD06nyq2WUKlZcgKSXmy7ULef9KT16GU5BpjB1cjt4YKGcsPWyoHr/CIr6pKqjzX5VnTKzwiYBxIBaiqHt42SlPP32aJv6Zt77VOe69WvpkD3BEnyt7/j6glTtqqU/llTd9PANDi+gEmnv3m5zPu4EQtRZ9OEUAobaRUFayM43BnyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TigtWHE4TpJALLyyi4xRM1Q6S6cSsRg1hfFOrKTUCrg=;
 b=rp0DRbOIPHpd6B/9gpTbwiyxMRyFy0s6pJ6QCpmrHC/IU8z+ExMWzuuHz7LvRoykAzDgVFOCaRYGXy/vWoAtzyJi8GXHWy+SczBZzHdWksihjyz8usFGfYxSy0Sv/EJ7sS9kLe4/iIGZECHwZJwcsmF+UT7BAdfWlBbginh3ifI=
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com (52.133.12.32) by
 VI1PR04MB7166.eurprd04.prod.outlook.com (10.186.156.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 02:26:47 +0000
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::20fe:3e38:4eec:ea03]) by VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::20fe:3e38:4eec:ea03%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 02:26:47 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Andy Tang <andy.tang@nxp.com>,
        "michael@walle.cc" <michael@walle.cc>
Subject: RE: [EXT] [PATCH v2 2/5] arm64: dts: ls1028a: add missing sai nodes
Thread-Topic: [EXT] [PATCH v2 2/5] arm64: dts: ls1028a: add missing sai nodes
Thread-Index: AdWvAUNxyDzwioZqREGIPwh3YLp5fQ==
Date:   Tue, 10 Dec 2019 02:26:47 +0000
Message-ID: <VI1PR04MB40627593238918331ACB38E4F45B0@VI1PR04MB4062.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alison.wang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85312601-cbad-4fbf-84ee-08d77d186847
x-ms-traffictypediagnostic: VI1PR04MB7166:|VI1PR04MB7166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7166A9F2786B51505A9E1F17F45B0@VI1PR04MB7166.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(13464003)(189003)(199004)(316002)(52536014)(305945005)(55016002)(9686003)(8936002)(2906002)(44832011)(33656002)(81156014)(4326008)(81166006)(76116006)(186003)(6506007)(53546011)(66476007)(8676002)(66446008)(64756008)(478600001)(110136005)(229853002)(86362001)(26005)(54906003)(7696005)(71190400001)(66556008)(66946007)(5660300002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7166;H:VI1PR04MB4062.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8+FIZlN/9pTo69zhw3aXYSLJppPRunH1ROlr+l9cHeOGMNi3pKOaxd/rOrpYL8bmfc2GidkQASqc1LuUToICooGZKRRqusMqbb+DCTSMaM/Ny5AQkLohqk/UQCyUuP6PO/s122wbXbJtMfwnlkyh59pmgMdNbKO9Y/oVhFUDf/PSl6aOFEkDi3lWjRCLW9v0w7orB/6/RLKutK8Hllg42VEaWGyXy6bFFnRoP98eQwRYfefYCExIpw08pJ+GXF4BlZpFHdLy54LpEBVJqkSd0A5dy7LAPUYtf7QFL62a9z2nY72kYm5ND78EkzWfDR5bRFY09DHELGgGE935NaBqLUm6CpCkcBo3KDaWgqCLDmBl6f58QHMOlgaLV2qxDYb5Qb7b3PNK+YlPxf31E5t6Swu2A0dgExJFD5uxqGjL6xZK0Bxzf0ACwy/8U5Fd5K2lKs2AMQsngDCoz6WKoFTvJZEhT5EzhdiZhVdpBudwmOyv7rS5CkDZGfIzuQ0yVZ9
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85312601-cbad-4fbf-84ee-08d77d186847
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 02:26:47.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+BvKSEm9/PKeB+mhXy7gNsl6EAKixe27kOemBkvhTdOAiDw5N+fjF12wlEbmWSDPfhrDaSYK0hIzSErU36I1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IEFsaXNvbiBXYW5nIDxhbGlzb24ud2FuZ0BueHAuY29tPg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpBbGlzb24gV2FuZw0KDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBG
cm9tOiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiA+IFNlbnQ6IDIwMTnE6jEy
1MIxMMjVIDc6NDQNCj4gPiBUbzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1
dGxhbmQNCj4gPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtl
cm5lbC5vcmc+OyBMZW8gTGkNCj4gPiA8bGVveWFuZy5saUBueHAuY29tPjsgQW5keSBUYW5nIDxh
bmR5LnRhbmdAbnhwLmNvbT47IE1pY2hhZWwgV2FsbGUNCj4gPiA8bWljaGFlbEB3YWxsZS5jYz4N
Cj4gPiBTdWJqZWN0OiBbRVhUXSBbUEFUQ0ggdjIgMi81XSBhcm02NDogZHRzOiBsczEwMjhhOiBh
ZGQgbWlzc2luZyBzYWkNCj4gPiBub2Rlcw0KPiA+DQo+ID4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+
ID4NCj4gPiBUaGUgTFMxMDI4QSBoYXMgc2l4IFNBSSBjb3Jlcy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+ID4gLS0tDQo+ID4gIC4u
Li9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaSB8IDQyDQo+ID4gKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
czEwMjhhLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEw
MjhhLmR0c2kNCj4gPiBpbmRleCAwNjA4MmM5MzI1MzEuLjdhNTUzMTRlOWM4ZCAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQo+
ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0K
PiA+IEBAIC01NDUsNiArNTQ1LDIwIEBADQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPg0KPiA+ICsgICAg
ICAgICAgICAgICBzYWkzOiBhdWRpby1jb250cm9sbGVyQGYxMjAwMDAgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICNzb3VuZC1kYWktY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsdmY2MTAtc2FpIjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ZjEyMDAwMCAweDAgMHgxMDAwMD47DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDgzDQo+ID4gSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZj
bG9ja2dlbiA0IDE+LCA8JmNsb2NrZ2VuIDQgMT4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPCZjbG9ja2dlbiA0IDE+LCA8JmNsb2NrZ2VuIDQgMT47DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsyIiwN
Cj4gPiAibWNsazMiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRtYS1uYW1lcyA9ICJ0
eCIsICJyeCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZG1hcyA9IDwmZWRtYTAgMSA4
PiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZlZG1hMCAxIDc+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKyAgICAg
ICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICBzYWk0OiBhdWRpby1jb250
cm9sbGVyQGYxMzAwMDAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICNzb3VuZC1kYWkt
Y2VsbHMgPSA8MD47DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJm
c2wsdmY2MTAtc2FpIjsgQEAgLTU1OSw2DQo+ID4gKzU3MywzNCBAQA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gICAgICAgICAgICAgICAgIH07
DQo+ID4NCj4gPiArICAgICAgICAgICAgICAgc2FpNTogYXVkaW8tY29udHJvbGxlckBmMTQwMDAw
IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjc291bmQtZGFpLWNlbGxzID0gPDA+Ow0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLHZmNjEwLXNhaSI7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweGYxNDAwMDAgMHgwIDB4
MTAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQ
SSA4NA0KPiA+IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGNsb2NrcyA9IDwmY2xvY2tnZW4gNCAxPiwgPCZjbG9ja2dlbiA0IDE+LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xvY2tnZW4gNCAxPiwgPCZjbG9ja2dlbiA0
IDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImJ1cyIsICJt
Y2xrMSIsICJtY2xrMiIsDQo+ID4gIm1jbGszIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBkbWEtbmFtZXMgPSAidHgiLCAicngiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRt
YXMgPSA8JmVkbWEwIDEgMTI+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
JmVkbWEwIDEgMTE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAg
ICBzYWk2OiBhdWRpby1jb250cm9sbGVyQGYxNTAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICNzb3VuZC1kYWktY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJmc2wsdmY2MTAtc2FpIjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8MHgwIDB4ZjE1MDAwMCAweDAgMHgxMDAwMD47DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDg0DQo+ID4gSVJRX1RZUEVfTEVWRUxf
SElHSD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbG9ja2dlbiA0
IDE+LCA8JmNsb2NrZ2VuIDQgMT4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPCZjbG9ja2dlbiA0IDE+LCA8JmNsb2NrZ2VuIDQgMT47DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsyIiwNCj4gPiAibWNs
azMiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRtYS1uYW1lcyA9ICJ0eCIsICJyeCI7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZG1hcyA9IDwmZWRtYTAgMSAxND4sDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmZWRtYTAgMSAxMz47DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArICAgICAgICAgICAg
ICAgfTsNCj4gPiArDQo+ID4gICAgICAgICAgICAgICAgIHRtdTogdG11QDFmODAwMDAgew0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLHFvcmlxLXRtdSI7DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDFmODAwMDAgMHgwIDB4MTAw
MDA+Ow0KPiA+IC0tDQo+ID4gMi4yMC4xDQoNCg==
