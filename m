Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2BDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6772D218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WhhWpk0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfIQIZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:25:59 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:40579
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728364AbfIQIZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZwvSjt4n+qvFO+NWUp0rLwE33AAlSi74/hAELk998T0tW6ybj5GNGz8bH9Cz99rGGB+/EzrWa7/nkubxi/lL9R9EDJT1mbLBm0/TZeWqlum6gW6sRmO4PfpnqYQxKVJJSOTUbjb3ZHfnpJ7ibng/rGIBGBU3qyOZKm16Uj/ijLZbbNM1k23dpUYT5hwtlAsnUnnMPg5TWSwOiIhXiBjxqFwSRTm32YFAqmoOsnJpjJkSN9o5giilePgVoVMSH1fLtH7ygwqFF5uTgxXipbvZG85vwSQ3cZ3WCJ9j2R4tvlT11a9u8ZlvEWrotXgCbJj7yAk3YyhMXfeQd46KwhihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQQ6JTmI7svK116YU17b2hhsHV14tM0ReFjJhpbvEug=;
 b=Wf/Z5iSpHbl3zXrg+GD31XE1mRIGSYIPrKRUY7khR2bQkLORPETXNsUpuPFbcwP2C8inz528z+ZknyLGZ+WFJWYtOc7qwO/9Rupt1qmikVwpS0rljebn9Gu4eWi/CkYn1tIv2bsQ7QX5uSVmx9TMwrvWANkl/xzSLcI8tzuLu9wXw6rWIxU37MpqszAQSalD9liWLQWCeqm9H58ip6rEQxWGQYCv0fUdKbvcEZ5NxzelTldk1kGVuwbVQAbcw+alonvpEBFPZRyj/2mIX4MS07O1v8H5F/xrSkG4bCUrohWfxYLHm9DPJg3WRZGRXR0MMEGlAcrmTbXJ7SGAWkesAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQQ6JTmI7svK116YU17b2hhsHV14tM0ReFjJhpbvEug=;
 b=WhhWpk0Q86Z4Lpp+/OyNHtxt+Ob+iJwJaQ5Z7Iedvwg7nmam5irUYQAz4aBCPRjEG7/VWCbZrfQDQvgPI0sG0+/3KybWQXULu9RvIOnsFEuaLZu2HbQ6Ffu9ajE11dx9QUE97RHZAhl53IixFBybszQsemHcHykoA/5w5znQbXU=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB5546.eurprd04.prod.outlook.com (20.178.107.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.16; Tue, 17 Sep 2019 08:25:55 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa%5]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 08:25:55 +0000
From:   Biwen Li <biwen.li@nxp.com>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] devicetree: property-units: Add kohms unit
Thread-Topic: [EXT] Re: [PATCH] devicetree: property-units: Add kohms unit
Thread-Index: AQHVbS80z66smK3rv0SY+lUFtqLi0qcvhsKAgAAArgA=
Date:   Tue, 17 Sep 2019 08:25:55 +0000
Message-ID: <DB7PR04MB4490DD5F5A87EB796DE2A7A28F8F0@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190917075850.40039-1-biwen.li@nxp.com>
 <CAMuHMdUWue6-51Za7vejk=QkhV80iBXdc1E+6aTmQsvpB5AP-A@mail.gmail.com>
In-Reply-To: <CAMuHMdUWue6-51Za7vejk=QkhV80iBXdc1E+6aTmQsvpB5AP-A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biwen.li@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68328355-28d2-4ae3-4d73-08d73b48a926
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR04MB5546;
x-ms-traffictypediagnostic: DB7PR04MB5546:
x-microsoft-antispam-prvs: <DB7PR04MB55468B6CDC14D1801B0C4D4D8F8F0@DB7PR04MB5546.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(54906003)(81166006)(99286004)(52536014)(81156014)(446003)(6246003)(478600001)(11346002)(71190400001)(186003)(53546011)(6506007)(4326008)(102836004)(7696005)(6116002)(66066001)(25786009)(3846002)(71200400001)(2906002)(316002)(476003)(486006)(5660300002)(66476007)(33656002)(44832011)(66556008)(66946007)(76116006)(66446008)(64756008)(8936002)(26005)(14454004)(76176011)(9686003)(6436002)(7736002)(74316002)(305945005)(229853002)(55016002)(86362001)(8676002)(6916009)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5546;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6COlNuCGhXn+U4Fta8wttS9vDWYK5GhG8dhzatNVlcUoTmFhiTjg8o2/UCvhVg+QO3vw1XFEhUx1vFoKLCmXJoCglEDlWh1x1RxDKtsbcSfnPP3V9NMLV5fBgj1qNxn165pBQuCRifB+dkwremdarHqLw1299uySTSBjminKkMXROcc8OZVHAJjIThD1axjhCbi6Uqee3jqAtGMgUOqohKRe8dnpf8kN1p1d4C6ZfSkBOMJ+5wtQqZIepyoGwqGj4TeMSE17ckeiPNKofT2nBALOUpfUqdIbnqaf2vvyQuFzuezvfhI1UPSjEJbEYiuFcVMFaHF7qQUn3StQFwJRzqo0SSWwVrxnznS6HtkeW3+7Zz4Rrr3G1XYq/CHPR6mRLNvHp8YxpIMeqQehg5Y5Tx5y3AIXJf8WUXsBW7Ru5+8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68328355-28d2-4ae3-4d73-08d73b48a926
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 08:25:55.6998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/rDM0uGvOnQfGocQf8vnJxgtgQuKRQPdYQ6AyTpGcLCILExZmoEM0lGkqSjZicm7QqituuWJyu9sjn3YTLCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBIaSBCaXdlbiwNCj4gDQo+IE9uIFR1ZSwg
U2VwIDE3LCAyMDE5IGF0IDEwOjA5IEFNIEJpd2VuIExpIDxiaXdlbi5saUBueHAuY29tPiB3cm90
ZToNCj4gPiBUaGUgcGF0Y2ggYWRkcyBrb2htcyB1bml0DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBCaXdlbiBMaSA8Yml3ZW4ubGlAbnhwLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRj
aCENCj4gDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Byb3Bl
cnR5LXVuaXRzLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wcm9wZXJ0eS11bml0cy50eHQNCj4gPiBAQCAtMjcsNiArMjcsNyBAQCBFbGVjdHJpY2l0eQ0K
PiA+ICAtbWljcm9hbXAgICAgICA6IG1pY3JvYW1wZXJlDQo+ID4gIC1taWNyb2FtcC1ob3VycyA6
IG1pY3JvYW1wZXJlIGhvdXINCj4gPiAgLW9obXMgICAgICAgICAgOiBvaG0NCj4gPiArLWtvaG1z
ICAgICAgICAgOiBraWxvb2htDQo+ID4gIC1taWNyby1vaG1zICAgIDogbWljcm9vaG0NCj4gPiAg
LW1pY3Jvd2F0dC1ob3VyczogbWljcm93YXR0IGhvdXINCj4gPiAgLW1pY3Jvdm9sdCAgICAgOiBt
aWNyb3ZvbHQNCj4gDQo+IFdoYXQncyB5b3VyIHJhdGlvbmFsZSBmb3IgYWRkaW5nICJrb2htcyI/
DQo+IERvIHlvdSBuZWVkIHRvIHNwZWNpZnkgcmVzaXN0YW5jZSB2YWx1ZXMgdGhhdCBkbyBub3Qg
Zml0IGluIDMyLWJpdCwgYW5kIHRodXMNCjMyLWJpdCBpcyBlbm91Z2gsIEkgaGF2ZSB0aHJlZSB2
YWx1ZXMsIDYwIGtvaG0sIDEwMCBrb2htIGFuZCA1MDAga29obQ0KPiBjYW5ub3QgYmUgc3BlY2lm
aWVkIHVzaW5nICJvaG1zIj8NCklmIHJlcGxhY2Ugd2l0aCBvaG1zLCB0aGUgdmFsdWUgaXMgYXMg
Zm9sbG93czoNCjYwMDAwIG9obSwgMTAwMDAwIG9obSwgNTAwMDAwIG9obS4NCkl0J3Mgc28gbG9u
ZyBmb3IgZXZlcnlvbmUuDQoNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAt
LSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0NCj4gZ2VlcnRAbGludXgtbTY4
ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVv
cGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQgd2hlbg0KPiBJJ20gdGFsa2luZyB0byBq
b3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0
Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
