Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E5DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DD720693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rntsjE+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbfDRIFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:05:17 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:23542
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728074AbfDRIFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrZZ/eV12AUkgFsyvflQjy/xISYGUJceDNh3Vj7rDzQ=;
 b=rntsjE+diSpBo+kqAcBmKrTy0MLMbYHOu2IUD0L3h2fZcBvTbywwSuvGi4M7sn7VQs08DpE8Pv60lpFV3FkReW9dTgIDFcGHPbQoEZWVrj6hVNPboLpfkIfnS0o3rAmsOhzwU/NIN2P9wxN27oifR5ztnenjR7e1Op6LNRcye6Q=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) by
 DB7PR04MB5131.eurprd04.prod.outlook.com (20.176.235.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Thu, 18 Apr 2019 08:05:12 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::969:29f3:543c:26cb]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::969:29f3:543c:26cb%3]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 08:05:11 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "plyatov@gmail.com" <plyatov@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: Issues with i.MX SPI DMA transfers
Thread-Topic: Issues with i.MX SPI DMA transfers
Thread-Index: AQHU9b1ypR3rGgFlLEuonA7sM1XSkw==
Date:   Thu, 18 Apr 2019 08:05:11 +0000
Message-ID: <1555574342.24617.3.camel@nxp.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
         <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
         <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
         <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
         <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
         <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <VI1PR04MB454302BAF353124ED13747DC892D0@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <VI1PR04MB4543A5CA46FBB3ACC9F3B3E289260@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <c9f24997-0112-8684-dc38-a6f8ba64c158@gmail.com>
In-Reply-To: <c9f24997-0112-8684-dc38-a6f8ba64c158@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c31da4a7-aea9-44c0-d0a5-08d6c3d49502
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR04MB5131;
x-ms-traffictypediagnostic: DB7PR04MB5131:
x-microsoft-antispam-prvs: <DB7PR04MB5131E0B2CC5837612833376C89260@DB7PR04MB5131.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(13464003)(1411001)(478600001)(2906002)(36756003)(71190400001)(14454004)(25786009)(71200400001)(66066001)(7416002)(86362001)(103116003)(6512007)(53936002)(76176011)(8936002)(97736004)(4326008)(5660300002)(81156014)(81166006)(8676002)(1730700003)(6246003)(50226002)(99286004)(11346002)(476003)(1361003)(229853002)(6436002)(5024004)(6916009)(446003)(2616005)(14444005)(256004)(6486002)(53546011)(186003)(6506007)(3846002)(6116002)(26005)(5640700003)(2501003)(4744005)(102836004)(7736002)(305945005)(93886005)(68736007)(316002)(54906003)(486006)(2351001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5131;H:DB7PR04MB4538.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BO11sJ6RJoy4cvHvGTxmMdzqp5R8sAkGYoB52Mb/DG3RzHfADY0gebDc6sYEldr7SZXk/6hFOSJEmI9XzuOKRo3l4d2WiIUVnOGTKLazdd65Xn4GEgKj0IKY6xwOuzhmL4TDNc+f6KgB5J+D/SaikALl34PF3kHHbPU/XVMxs80CdtmzNOBz9CSQvfnNF4h0gfm29mQJxPLJ6CNFL2dE+9fO4aZ9fAVaAsiyOgf9ItPao5/Y4Ci6Z2XDa1n3MDvXKoJPnJ3rX8wA8ENfMkGVpDUGGozqUhovJqCuJotzfPj+eMqPRRoVFtuyEpVulTBsXF8bAA91WwhsDMhlQOt5VsQR//4YnRo1MbhI1v7IaEmugEnftfCWM1j53l3BaYLZYXDsXhpiuIE46gNxR4RNZNK6Ek3dbfo0xgesFIFiRpQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32EC64B3B22C6541BFA87235B8532033@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31da4a7-aea9-44c0-d0a5-08d6c3d49502
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 08:05:11.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0xOCBhdCAwNjozMCArMDAwMCwgSWdvciBQbHlhdG92IHdyb3RlOg0KPiBXQVJO
SU5HOiBUaGlzIGVtYWlsIHdhcyBjcmVhdGVkIG91dHNpZGUgb2YgTlhQLiBETyBOT1QgQ0xJQ0sg
bGlua3Mgb3INCj4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBh
bmQga25vdyB0aGUgY29udGVudCBpcw0KPiBzYWZlLg0KPiANCj4gDQo+IA0KPiBEZWFyIFJvYmlu
LA0KPiANCj4gPiANCj4gPiBIaSBJZ29yLA0KPiA+IMKgwqDCoMKgwqDCoERpZCB5b3UgbWVldCBh
bnkgaXNzdWUgd2l0aCBteSBsYXRlc3QgcGF0Y2g/DQo+IHNvcnJ5LCBidXQgdW5mb3J0dW5hdGVs
eSBJIGhhdmUgbm8gdGltZSB0byB0ZXN0IGl0Lg0KPiANCj4gSSBoYXZlIHN3aXRjaGVkIHRvIFBJ
TyBtb2RlIGFuZCBjb250aW51ZSBvdGhlciBkZXZlbG9wbWVudC4NCj4gDQo+IE1heWJlIGxhdGVy
IEkgd2lsbCBmaW5kIHRpbWUgdG8gdGVzdCBETUEgbW9kZSwgYnV0IG5vdCBzdXJlIHdoZW4uDQo+
IA0KPiBUaGFuayB5b3UgZm9yIHN1cHBvcnQhDQpPa2F5LCBJJ2xsIHNlbmQgb3V0IHBhdGNoIHNl
dCB0byByZXZpZXcsIGhvcGUgeW91IGNvdWxkIGhhdmUgY2hhbmNlIHRvDQp0cnkuDQo+IA0KPiAt
LQ0KPiANCj4gSWdvciBQbHlhdG92DQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUm9iaW4gR29uZw0KPiA+ID4gU2VudDogQXBy
aWwgOSwgMjAxOSAxMToyNj4NCj4gPiA+IEhpIElnb3IsDQo+ID4gPiDCoMKgwqDCoMKgUGxlYXNl
IGhhdmUgYSB0cnkgd2l0aCB0aGUgYXR0YWNoZWQgcGF0Y2hlcywgYW5kIHJldmVydA0KPiA+ID4g
MjVhYWE3NWRmMWU2LA0KPiA+ID4gYWQwZDkyZDdiYTZhICwgZGQ0YjQ4N2IzMmEzLCBkZjA3MTAx
ZTFjNGEgYmVmb3JlIGFwcGx5LiBCZXNpZGVzDQo+ID4gPiBYQ0gsIHR4DQo+ID4gPiB0aHJlc2gg
c2hvdWxkIGJlIHNldCB0byAwICwgbm93IG5vIGZhaWx1cmUgY2F1Z2h0IG9uIGVjc3BpNS4NCj4g
PiA+IA==
