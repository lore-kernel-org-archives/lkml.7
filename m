Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C98C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1487A206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rTKbWeNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfLIGkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:40:01 -0500
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:8326
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfLIGkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:40:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8UIoWpSyKpeWKzKQzWiB47vA+YwXF4wS5uD1Yvox+k/36YOpML0yKBligJ6YgTI8ou1gx5WRrukkw4r4UJckwWtmgfsnDnLb3EGepEar4XDTdteIDVwceYBvjxdGEILoUlzX2fKwPQulsJNMcSkN2yjFWV6/9QEwduuQSme28FeK80VX3VgMnWxjY/VovrwjqXeoeW4o8TykcIbeZ3ZZrQGbYRrC2j3U/tKUDg/6Jf3d1LXAHoOqzXT4dalZkF5OSEkfDKJJMM/DBybn2YGcgz26OvfEUnCLt2RD/nFtpV3pv1qt4xG1MpZDNkZ6o3OpLg9pZwgqzc+hWgsjNy2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1DanhQSvjnHPegfL3GNsxBImSD150IPCA5J9G4EhuI=;
 b=KDtBbyl4vVRfySFFL2kWrYZcdPRFrp1hwo291+58GT9c4JCa0B6Y/1Y5W+rigINKydnGrFi6fVPRjkbdgNC8EYi/bC2uuCn//j9LtCDMmKaoILj5iZo+gk5/IsJliNuRaI/E+6PBCidqBQ7WQmziSvsgY2BzyNTkSmiI2jGDPmpZyRPpqGBltx7BSMur4kdviDGLFZKKwodJIHSolAIz40fr70tMdnQvFlIpJjZrTdrVVQCUJYLeMwkimFkO+cxmNYqezlsNHmS1eqGvKwJ3FjvaFH0pJRyZ+PIgoZCJtg2M+HuBy9w+RtR42hwwOGlh/B/6srFNlALjjSkr7G1xEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1DanhQSvjnHPegfL3GNsxBImSD150IPCA5J9G4EhuI=;
 b=rTKbWeNU/KwUDs5I3n6LyptYxix+KH2DB5u6GNSHMUWdKcEt80+3gsfm3JFdezYr88/tQRHWHSP33Dg2EdDxdKo0DEGzpAQdyJaFCaANPldpPigxPgTYrRckDIyLYCnaGVWO/xPIUY/2u+eHzvmoC6zl3JQyD8jlxzd/koIUayg=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5566.eurprd04.prod.outlook.com (20.178.123.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 06:39:17 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ee:eaf7:d026:d205]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ee:eaf7:d026:d205%4]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 06:39:17 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [EXT] Re: [PATCH 1/4] arm64: dts: ls1028a: fix typo in TMU
 calibration data
Thread-Topic: [EXT] Re: [PATCH 1/4] arm64: dts: ls1028a: fix typo in TMU
 calibration data
Thread-Index: AQHVrllg8EILqHMQBEG1nZ5Tdx7CkaexVxbg
Date:   Mon, 9 Dec 2019 06:39:16 +0000
Message-ID: <VI1PR04MB433312937702E1BF2F966D11F3580@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20191123201317.25861-1-michael@walle.cc>
 <20191123201317.25861-2-michael@walle.cc> <20191209062436.GB3365@dragon>
In-Reply-To: <20191209062436.GB3365@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b664a2e9-9d10-4931-7cdf-08d77c728384
x-ms-traffictypediagnostic: VI1PR04MB5566:|VI1PR04MB5566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB556646D86958AFBED890BED6F3580@VI1PR04MB5566.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(13464003)(189003)(199004)(66946007)(81166006)(81156014)(99286004)(8676002)(229853002)(5660300002)(33656002)(52536014)(66556008)(66476007)(55016002)(64756008)(44832011)(8936002)(66446008)(7696005)(102836004)(76176011)(26005)(6506007)(478600001)(74316002)(186003)(9686003)(53546011)(305945005)(86362001)(76116006)(110136005)(4326008)(54906003)(71200400001)(71190400001)(316002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5566;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xzcd8P2x7KjbHqfO1avhDuOlLtEELFX+00AdzY979llcsaJp6mAjck1+qD/Nav7Jfr6MK7UtE01l9X/n/pA9ESaf5ul29F+IsnCp1BcbOUbqxzu7tdBOF0ocTKLNeHdLhP8OcuMZMpm6Uxbbbu+ldN4qIG36LvuYsprwxHF19LX3uGsVo+rVaym1vw/oPA0rzzlsDGq0armZEle/HRXkB29b+xHWw69uc6gK9cEleCUX11qlDHGxePyFTdM8z5509Iz6ku1Wq01iK1TmgC+xnCny3zWkm3RFmrwVj2NxUrDgk0WWSHFYmcGUS5angHv1iDDQ3jHaTtT0fhgelsLoDx2R48WKWo51Gu+wE3RwfUfX8vja8zWh+DwPMOEiiVnyzsfZoK/0xM/E9lY1wNGSuYTVoHky6J+XiIxQJB60yT52qQBu6l6A7x7eDEe4GIvd2TYYCg9f+K2UDPV8gCNfEjy3zifECUWQzKjTiQT2f3pCSY0fFqPpmmb0eJNbsxo
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b664a2e9-9d10-4931-7cdf-08d77c728384
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 06:39:16.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKSbi4+mxUJ6V7LcwH1wjM/pn/rAnoH55MmP171IyOPlY7GfaFgMDTe+dYv+IMkU45erTOiHR8F0M1HkUpaVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOoxMtTCOcjVIDE0OjI1DQo+
IFRvOiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPjsgQW5keSBUYW5nIDxhbmR5LnRh
bmdAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRA
a2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+DQo+IFN1Ympl
Y3Q6IFtFWFRdIFJlOiBbUEFUQ0ggMS80XSBhcm02NDogZHRzOiBsczEwMjhhOiBmaXggdHlwbyBp
biBUTVUNCj4gY2FsaWJyYXRpb24gZGF0YQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0K
PiArIFl1YW50aWFuIFRhbmcsIHdobyBpcyB0aGUgYXV0aG9yIG9mIGV4aXN0aW5nIGNvZGUuDQo+
IA0KPiBPbiBTYXQsIE5vdiAyMywgMjAxOSBhdCAwOToxMzoxNFBNICswMTAwLCBNaWNoYWVsIFdh
bGxlIHdyb3RlOg0KPiA+IFRoaXMgd2FzIHRlc3RlZCBvbiBhIGN1c3RvbSBib2FyZC4NCj4gDQo+
IENhbiB5b3UgYWRkIG1vcmUgaW5mbyBhYm91dCB3aHkgdGhpcyBpcyBhbiBlcnJvciBhbmQgaG93
IGl0IGlzIGJlaW5nDQo+IGlkZW50aWZpZWQ/DQoNCkkgYW0gbm90IHN1cmUgaG93IE1pY2hhZWwg
ZmlndXJlZCBvdXQgdGhpcyBlcnJvciBidXQgaGUvc2hlIGlzIGNvcnJlY3QuDQpJIG11c3QgaGF2
ZSBtYWRlIGEgbWlzdGFrZSB3aGVuIHNlbmRpbmcgdGhlc2UgZGF0YSBvdXQuDQoNClRoYW5rcyBT
aGF3biBhbmQgTWljaGFlbC4NCg0KQWNrZWQtYnk6IFRhbmcgWXVhbnRpYW4gPGFuZHkudGFuZ0Bu
eHAuY29tPg0KDQpCUiwNCkFuZHkNCj4gDQo+IFNoYXduDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4gPiAtLS0NCj4gPiAgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaSB8IDIgKy0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRz
aQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0K
PiA+IGluZGV4IGRjNzU1MzRhNDc1NC4uZjJlNzFmZDU3YjIwIDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQo+ID4gQEAgLTU3
Myw3ICs1NzMsNyBAQA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDB4MDAwMTAwMDQNCj4gMHgwMDAwMDAzZA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMTAwMDUNCj4gMHgwMDAwMDA0NQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMTAwMDYNCj4g
MHgwMDAwMDA0ZA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4MDAwMTAwMDcNCj4gMHgwMDAwMDA0NQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMTAwMDcNCj4gMHgwMDAwMDA1NQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMTAwMDgNCj4gMHgw
MDAwMDA1ZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDB4MDAwMTAwMDkNCj4gMHgwMDAwMDA2Ng0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDB4MDAwMTAwMGENCj4gMHgwMDAwMDA2ZQ0KPiA+IC0tDQo+ID4g
Mi4yMC4xDQo+ID4NCg==
