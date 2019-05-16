Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BE3C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AE92087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a/HmuR66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEPJmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:42:53 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:41280
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727188AbfEPJmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8KTdczLXNWYSO7xpZlQ9lFBTzLj23Vyy/Q4XE+Zr+c=;
 b=a/HmuR66i9ntsY9cb0b+u7QhikhFECAjc4nwobOGp4vDVqHD422NxLs2Dkd3WX0xtqSOMpc90r/sGwvjehrTapI3a64Q7mZQuaIaBoXkjgjTCNry8Os5mLu9bSPE2m3KEplb+cnUYh7MXlzCJOM6Y0wAThpzf/I76nDiKK+15Zc=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB5284.eurprd04.prod.outlook.com (20.177.41.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Thu, 16 May 2019 09:42:46 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1878.028; Thu, 16 May 2019
 09:42:46 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
CC:     Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required
 pixel clock rate
Thread-Topic: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required
 pixel clock rate
Thread-Index: AQHVCsfKc9H8v6XkZkyzoxWRKfwkRaZsbagAgAEP0WA=
Date:   Thu, 16 May 2019 09:42:46 +0000
Message-ID: <AM0PR04MB4865435E9FA2D61E2D9A238EE20A0@AM0PR04MB4865.eurprd04.prod.outlook.com>
References: <20190515024348.43642-1-wen.he_1@nxp.com>
 <3f87b2a7-c7e8-0597-2f62-d421aa6ccaa5@arm.com>
In-Reply-To: <3f87b2a7-c7e8-0597-2f62-d421aa6ccaa5@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 300d9a26-d9e1-4f98-ffe4-08d6d9e2da56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5284;
x-ms-traffictypediagnostic: AM0PR04MB5284:
x-microsoft-antispam-prvs: <AM0PR04MB5284631FD058CA91A30C5E53E20A0@AM0PR04MB5284.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(13464003)(256004)(71190400001)(9686003)(71200400001)(316002)(55016002)(74316002)(6436002)(66066001)(53936002)(4326008)(8936002)(305945005)(81166006)(81156014)(110136005)(8676002)(7736002)(2201001)(6246003)(2501003)(229853002)(86362001)(3846002)(6116002)(2906002)(7696005)(52536014)(14454004)(446003)(25786009)(476003)(11346002)(486006)(33656002)(66476007)(5660300002)(68736007)(186003)(26005)(66446008)(64756008)(66946007)(66556008)(73956011)(478600001)(53546011)(6506007)(102836004)(99286004)(76116006)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5284;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yXBTN5KNzPbZTSx7c6uJs0M4sgPyAVwAYaF7dnDPY76K5i1wlsZPj4x21bIy4TYEklo4rE7EHAr+1WYalGUiaN2itf+1Bl9jlW7slGNZQw53lis5ndBhUPdhI4jziaMIjI7iroo3NsvPCsak2mbSQDCJU4qKjdpBAVAyeUWgyiDgt26YpwUJtp19+/ES8UmbjweLE6tASU9jsgP6yOYJYLCKpBSZJvE2eUmDLdgHEOh2o1JeuiBzW/Rpta922rxGIF5dQL0etghpQ1v1NI9UT0tV6HKZIZ4+V4XzHvdZFqADV/kXv+a154bpF9tFBqLuXOG9GNEDybdo33xEIdkdhpXxMUxVVW3IrjDlP9iuXEutcyz76qgqAU2y3+f0w+I2xbtncTaSCWDZ9KIdjRu2xZTLtIwkCPPvIs6lz9l69OQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300d9a26-d9e1-4f98-ffe4-08d6d9e2da56
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 09:42:46.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5284
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDIwMTnlubQ15pyIMTbml6UgMTox
NA0KPiBUbzogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGl2aXUuZHVkYXVA
YXJtLmNvbQ0KPiBDYzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFtF
WFRdIFJlOiBbdjFdIGRybS9hcm0vbWFsaS1kcDogRGlzYWJsZSBjaGVja2luZyBmb3IgcmVxdWly
ZWQgcGl4ZWwNCj4gY2xvY2sgcmF0ZQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBP
biAxNS8wNS8yMDE5IDAzOjQyLCBXZW4gSGUgd3JvdGU6DQo+ID4gRGlzYWJsZSBjaGVja2luZyBm
b3IgcmVxdWlyZWQgcGl4ZWwgY2xvY2sgcmF0ZSBpZiBBUkNIX0xBWUVSU0NQQUUgaXMNCj4gPiBl
bmFibGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24gV2FuZyA8YWxpc29uLndhbmdA
bnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gY2hhbmdlIGluIGRlc2NyaXB0aW9uOg0KPiA+ICAgICAgIC0gVGhpcyBjaGVj
ayB0aGF0IG9ubHkgc3VwcG9ydGVkIG9uZSBwaXhlbCBjbG9jayByZXF1aXJlZCBjbG9jayByYXRl
DQo+ID4gICAgICAgY29tcGFyZSB3aXRoIGR0cyBub2RlIHZhbHVlLiBidXQgd2UgaGF2ZSBzdXBw
b3J0cyA0IHBpeGVsIGNsb2NrDQo+ID4gICAgICAgZm9yIGxzMTAyOGEgYm9hcmQuDQo+ID4gICBk
cml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9jcnRjLmMgfCAyICsrDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FybS9tYWxpZHBfY3J0Yy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9j
cnRjLmMNCj4gPiBpbmRleCA1NmFhZDI4ODY2NmUuLmJiNzkyMjNkOTk4MSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9jcnRjLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYXJtL21hbGlkcF9jcnRjLmMNCj4gPiBAQCAtMzYsMTEgKzM2LDEzIEBAIHN0YXRp
YyBlbnVtIGRybV9tb2RlX3N0YXR1cw0KPiA+IG1hbGlkcF9jcnRjX21vZGVfdmFsaWQoc3RydWN0
IGRybV9jcnRjICpjcnRjLA0KPiA+DQo+ID4gICAgICAgaWYgKHJlcV9yYXRlKSB7DQo+ID4gICAg
ICAgICAgICAgICByYXRlID0gY2xrX3JvdW5kX3JhdGUoaHdkZXYtPnB4bGNsaywgcmVxX3JhdGUp
Ow0KPiA+ICsjaWZuZGVmIENPTkZJR19BUkNIX0xBWUVSU0NBUEUNCj4gDQo+IFdoYXQgYWJvdXQg
bXVsdGlwbGF0Zm9ybSBidWlsZHM/IFRoZSBrZXJuZWwgY29uZmlnIGRvZXNuJ3QgdGVsbCB5b3Ug
d2hhdA0KPiBoYXJkd2FyZSB5b3UncmUgYWN0dWFsbHkgcnVubmluZyBvbi4NCj4gDQoNCkhpIFJv
YmluLA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQoNCkluIGZhY3QsIE9ubHkgb25lIHBsYXRm
b3JtIGludGVncmF0ZXMgdGhpcyBJUCB3aGVuIENPTkZJR19BUkNIX0xBWUVSU0NBUEUgaXMgc2V0
Lg0KQWx0aG91Z2ggdGhpcyBhcmUgbm90IGdvb2Qgd2F5cywgYnV0IEkgdGhpbmsgaXQgd29uJ3Qg
YmUgYSBwcm9ibGVtIHVuZGVyIG11bHRpcGxhdGZvcm0gYnVpbGRzLg0KDQpCZXN0IFJlZ2FyZHMs
DQpXZW4NCg0KPiBSb2Jpbi4NCj4gDQo+ID4gICAgICAgICAgICAgICBpZiAocmF0ZSAhPSByZXFf
cmF0ZSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUdfRFJJVkVSKCJweGxj
bGsgZG9lc24ndCBzdXBwb3J0ICVsZA0KPiBIelxuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXFfcmF0ZSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBNT0RFX05PQ0xPQ0s7DQo+ID4gICAgICAgICAgICAgICB9DQo+ID4gKyNlbmRpZg0K
PiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIHJldHVybiBNT0RFX09LOw0KPiA+DQo=
