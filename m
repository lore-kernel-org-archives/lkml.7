Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E06C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DF620665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DLqNi2Yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfFYGf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:35:27 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:37487
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729447AbfFYGf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNbgyYm86Mle4x+n8YRt60o5KnH8vOwSDuohCoWoF2s=;
 b=DLqNi2YhCExB648altaNJh0HQ3Vc0Ez4TUEsAC2+A1z9mGZ8IHV87ObMFx9bb+75pvTn8cuEtfufnnkbvRqkR7I/vrF3jsP6B5bfjODnxbVyOdUTveU/JR71m4O+f3ntbHiRPEbBgU/lKeL6I8f2jyQnd67F+jwigPyJaNeOaMo=
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.123.141) by
 VI1PR04MB4799.eurprd04.prod.outlook.com (20.177.48.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 06:35:23 +0000
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3d8f:3ac3:c34e:eb7b]) by VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3d8f:3ac3:c34e:eb7b%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 06:35:23 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [EXT] Re: [PATCH v3 2/2] drm/panel: Add support for Raydium
 RM67191 panel driver
Thread-Topic: [EXT] Re: [PATCH v3 2/2] drm/panel: Add support for Raydium
 RM67191 panel driver
Thread-Index: AQHVJ2xXDzcS3eCEpkyDS1SMgLl/7qamJDGAgAROTwCAAI4HAIAA8PQA
Date:   Tue, 25 Jun 2019 06:35:22 +0000
Message-ID: <1561444522.9328.90.camel@nxp.com>
References: <1561037428-13855-1-git-send-email-robert.chiras@nxp.com>
         <1561037428-13855-3-git-send-email-robert.chiras@nxp.com>
         <CAOMZO5DS2v15h9E=qKg2vKuFkBSQQwdBHA5Th5mZ+ca6DWgQsw@mail.gmail.com>
         <1561362278.9328.83.camel@nxp.com>
         <CAOMZO5CVPJqE0dR2PZvKem4WHztvTF=FT9K1x-b7TduH-yYb7A@mail.gmail.com>
In-Reply-To: <CAOMZO5CVPJqE0dR2PZvKem4WHztvTF=FT9K1x-b7TduH-yYb7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3fb85f4-d266-4e4a-2e87-08d6f9374d06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4799;
x-ms-traffictypediagnostic: VI1PR04MB4799:
x-microsoft-antispam-prvs: <VI1PR04MB47994461DB49AB8700E170A2E3E30@VI1PR04MB4799.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(6512007)(53936002)(66946007)(11346002)(476003)(8936002)(2906002)(44832011)(2616005)(86362001)(446003)(6246003)(305945005)(102836004)(6916009)(486006)(1411001)(7736002)(6506007)(8676002)(5660300002)(71200400001)(71190400001)(6486002)(26005)(186003)(53546011)(68736007)(36756003)(3846002)(54906003)(6116002)(103116003)(7416002)(99286004)(81156014)(81166006)(1730700003)(229853002)(6436002)(2501003)(66066001)(478600001)(2351001)(14454004)(25786009)(5640700003)(76116006)(316002)(73956011)(4326008)(14444005)(66446008)(1361003)(66476007)(66556008)(64756008)(50226002)(76176011)(256004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4799;H:VI1PR04MB5967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KSbTiO8TIHync7dhdIzFlNiq9GdKcqNeIa4cZjeYyE3aFeDycyUzPBPVcyqKrUB0gIiYs1pu4mt1VYZkjTQa/sqjR/OFfUrk9hUICUNe2UoqS4ljQMqMdJD94GLwTE3LzZ0NxDl5OmmASAN40y8Lqk/i1dFGv4OS788GmKQM8F3PpkplcH8q9pl5lE8ABLXr7q689bBYcv6cJJxDJs2zrvdasdwcVTgvBr4Fs85Fh4OCWrGfIHgFiXgXHbUFuY+TXwY7l+m4wMGrj4Yj8H+i1p14zbHWzN4dvI3xSvNH2esm2QxRSDY7aen8R5MssoG3YPZb7I2ydkPzWebKfhaCzZbeWdfE8IeW8MK+Z77FFG1f5agTrDIc6h6KXNrq9NoJLSA4B/8ZKm+KBzRTsLncvvOQjWLOYLYbcVRsMUOsdl4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69D73729C5F450408E57281FD899F24F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fb85f4-d266-4e4a-2e87-08d6f9374d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 06:35:22.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: robert.chiras@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTHUsIDIwMTktMDYtMjQgYXQgMTM6MTIgLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+
IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gSGkgUm9iZXJ0LA0KPiANCj4gT24gTW9uLCBKdW4g
MjQsIDIwMTkgYXQgNDo0NCBBTSBSb2JlcnQgQ2hpcmFzIDxyb2JlcnQuY2hpcmFzQG54cC5jb20+
DQo+IHdyb3RlOg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gWW91IGRpZCBub3QgaGFuZGxlIHRo
ZSAicG93ZXIiIHJlZ3VsYXRvci4NCj4gPiBUaGVyZSBpcyBubyBuZWVkIGZvciBhIHBvd2VyIHJl
Z3VsYXRvci4NCj4gSSBhbSBzdXJlIHRoZSBwYW5lbCByZXF1aXJlcyBwb3dlciB0byBiZSBhcHBs
aWVkIHNvIHRoYXQgaXQgY2FuIHdvcmsNCj4gOi0pDQpZZXMsIG9mIGNvdXJzZSB0aGVyZSBhcmUg
cG93ZXIgbGluZXMgdG8gdGhlIHBhbmVsLiBJIHdpbGwgYWRkIHRoZW0gdG8NCnRoZSBuZXh0IHJl
dmlzaW9uLg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gQ2FuJ3QgeW91IHNpbXBseSByZW1vdmUg
dGhlbT8NCj4gPiBUaGUgcmVzZXQgZ3BpbyBwaW4gaXMgc2hhcmVkIGJldHdlZW4gdGhlIERTSSBk
aXNwbGF5IGNvbnRyb2xsZXIgYW5kDQo+IExvb2tpbmcgYXQgdGhlIGlteDhtcS1ldmsgc2NoZW1h
dGljcyBpdCBpcyBub3QgY2xlYXIgZm9yIG1lIHdoYXQgcGluDQo+IGluIHNoYXJlZCBiZXR3ZWVu
IHRoZSBPTEVEIGRpc3BsYXkgYW5kIHRvdWNoIHNjcmVlbi4NCj4gDQo+IENvdWxkIHlvdSBwbGVh
c2UgY2xhcmlmeSB3aGljaCBwaW4geW91IGFyZSByZWZlcnJpbmcgdG8/DQpJdCdzIGFib3V0IHRo
ZSBEU0lfRU4gcGluIG9uIHRoZSBEU0kgTENEIElGIHBoeXNpY2FsIHBvcnQgSjE1MDEuIFRoaXMN
CmdvZXMgaW50byBSU1RfQl8xVjggb24gdGhlIHBhbmVsIHBvcnQgd2hpY2ggaXMgdXNlZCBmb3Ig
Ym90aCBkaXNwbGF5DQphbmQgdG91Y2ggcmVzZXRzLg0KPiANCj4gPiANCj4gPiB0b3VjaCBjb250
cm9sbGVyLCBib3RoIGZvdW5kIG9uIHRoZSBzYW1lIHBhbmVsLiBTaW5jZSwgdGhlIHRvdWNoDQo+
ID4gZHJpdmVyDQo+ID4gYWxzbyBhY2Nlc2VzIHRoaXMgZ3BpbyBwaW4sIGluIHNvbWUgY2FzZXMg
dGhlIGRpc3BsYXkgY2FuIGJlIHB1dCB0bw0KPiA+IHNsZWVwLCBidXQgdGhlIHRvdWNoIGlzIHN0
aWxsIGFjdGl2ZS4gVGhpcyBpcyB3aHksIGR1cmluZyBzdXNwZW5kIEkNCj4gPiByZWxlYXNlIHRo
ZSBncGlvIHJlc291cmNlLCBhbmQgSSBoYXZlIHRvIHRha2UgaXQgYmFjayBpbiByZXN1bWUuDQo+
ID4gV2l0aG91dCB0aGlzIHJlbGVhc2UvYWNxdWlyZSBtZWNoYW5pc20gZHVyaW5nIHN1c3BlbmQv
cmVzdW1lLA0KPiA+IHN0cmVzcy0NCj4gPiB0ZXN0cyBzaG93ZWQgc29tZSBmYWlsdXJlczogdGhl
IHJlc3VtZSBmcmVlemVzIGNvbXBsZXRseS4NCj4gTG9va2luZyBhdCB0aGUgaW14OG1xLWV2ayBk
dHMgZnJvbSB0aGUgdmVuZG9yIHRyZWUgSSBzZWUgdGhhdCB0aGUNCj4gdG91Y2hzY3JlZW4gaXMg
bm90IHN1cHBvcnRlZCBpbiBtYWlubGluZSB5ZXQuDQo+IA0KPiBNYXliZSB0aGVyZSBpcyBhIGJl
dHRlciB3YXkgdG8gc29sdmUgdGhpcywgc28gd2hhdCBpZiB5b3UgZG9uJ3QNCj4gaW50cm9kdWNl
IHRoZSBzdXNwZW5kL3Jlc3VtZSBob29rcyBmb3Igbm93IGFuZCB0aGVuIHdlIHJldmlzaXQgdGhp
cw0KPiBhZnRlciB0aGUgdG91Y2hzY3JlZW4gZHJpdmVyIGlzIGFkZGVkPw0KWW91IGFyZSByaWdo
dC4gV2UgY2FuIGRvIHRoaXMgdG9vLiBJIHdpbGwgcmVtb3ZlIGl0IGZvciBub3cu
