Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE03DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228520B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UOfEk2a/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfFFWde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:33:34 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:53294
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfFFWdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5ghpEB51pcsHDyuCVH3nzaGcKb+YTllL1QjNBnVDVQ=;
 b=UOfEk2a/T4tZs3/FWdApBmSlIVimK8QCEVKq5moDXsHygT8pNfcv01QfkYRref6o6HsUguuA4NcF+J1S8U3EW0RS/OT2ekZNGJtom+pQljbxeeXaOze84rbYjQ4xlWLiTYGJZv0d34qC6pT9m/oBsa6wusgqdeCYI7j0qd/HUns=
Received: from AM0PR04MB4961.eurprd04.prod.outlook.com (20.176.215.222) by
 AM0PR04MB4147.eurprd04.prod.outlook.com (52.134.125.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 6 Jun 2019 22:33:29 +0000
Received: from AM0PR04MB4961.eurprd04.prod.outlook.com
 ([fe80::e046:3c99:88be:90a1]) by AM0PR04MB4961.eurprd04.prod.outlook.com
 ([fe80::e046:3c99:88be:90a1%3]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 22:33:29 +0000
From:   Han Xu <han.xu@nxp.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
CC:     "boris.brezillon@free-electrons.com" 
        <boris.brezillon@free-electrons.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kdasu.kdev@gmail.com" <kdasu.kdev@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: RE: [EXT] Re: [PATCH] mtd: spi-nor: Add prep/unprep for
 spi_nor_resume
Thread-Topic: [EXT] Re: [PATCH] mtd: spi-nor: Add prep/unprep for
 spi_nor_resume
Thread-Index: AQHU+uHfbtBiSaKzx0CN/OQDDONR1qaOYFKAgAEUgBA=
Date:   Thu, 6 Jun 2019 22:33:29 +0000
Message-ID: <AM0PR04MB4961A2E7620DF5BD346C94D097170@AM0PR04MB4961.eurprd04.prod.outlook.com>
References: <20190424210818.25205-1-han.xu@nxp.com>
 <ae82d8ea-dd85-0bc3-ff2d-0ba57f635030@microchip.com>
In-Reply-To: <ae82d8ea-dd85-0bc3-ff2d-0ba57f635030@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [70.112.23.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e34549a-a82b-4d7c-73ec-08d6eaceff9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4147;
x-ms-traffictypediagnostic: AM0PR04MB4147:
x-microsoft-antispam-prvs: <AM0PR04MB414736BC36F094656F937F3497170@AM0PR04MB4147.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(366004)(13464003)(189003)(199004)(3846002)(7416002)(8936002)(6116002)(81166006)(81156014)(8676002)(9686003)(256004)(66946007)(55016002)(305945005)(74316002)(7736002)(14444005)(6506007)(73956011)(76116006)(5660300002)(76176011)(7696005)(99286004)(53546011)(66556008)(66476007)(64756008)(66446008)(102836004)(186003)(2501003)(26005)(52536014)(54906003)(44832011)(33656002)(11346002)(446003)(316002)(476003)(486006)(2906002)(478600001)(14454004)(86362001)(6436002)(2201001)(71190400001)(71200400001)(66066001)(68736007)(229853002)(53936002)(25786009)(4326008)(110136005)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4147;H:AM0PR04MB4961.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FvXYM2CjLLgb99bmsMvplCzcJIggPMDMhTai+7kCuvf7NjORFMECtevfqXQ3Mb9l/RfGySA2d8AgqzkFcLJFochrWYpSi8tl2ZFsKBqll9aw8PNuAdesCj8r7hebvLNjpfsq/phk8JI2W4FX40SAuCFl9DNR7GoCqu5P5LhNX5EfR1yGqptMGFBtXkw2PZYDgQjeePbeOzAMZ70Y4s6xHm4Fcg3zgoI9hUULjh2j+1fHhUvoTZF5+Dsg1UiHSiQ4Je8hxvcU7m/dt8h+iIv5jO26mFtAEfk8AF6TOgtodhdC1fETWIIi6mALJYb2dYajyPdYAhGsM+ttbJNt4jv7YIaTKT8XBnSEH801ArIJhZmA4en6L6kBfsHQzhK+hhvoyAkMPgw1ZK8KHjxMv7x0I5WpjIhJ4cReaWYOpbdC9IE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e34549a-a82b-4d7c-73ec-08d6eaceff9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 22:33:29.0824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: han.xu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IuQW1iYXJ1c0Bt
aWNyb2NoaXAuY29tIDxUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDYsIDIwMTkgMTI6NDYgQU0NCj4gVG86IEhhbiBYdSA8aGFuLnh1QG54cC5jb20+
OyBjeXJpbGxlLnBpdGNoZW5Ad2VkZXY0dS5mcjsNCj4gbWFyZWsudmFzdXRAZ21haWwuY29tDQo+
IENjOiBib3Jpcy5icmV6aWxsb25AZnJlZS1lbGVjdHJvbnMuY29tOyBmLmZhaW5lbGxpQGdtYWls
LmNvbTsNCj4ga2Rhc3Uua2RldkBnbWFpbC5jb207IHJpY2hhcmRAbm9kLmF0OyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWls
LmNvbQ0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBtdGQ6IHNwaS1ub3I6IEFkZCBwcmVw
L3VucHJlcCBmb3INCj4gc3BpX25vcl9yZXN1bWUNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0K
PiANCj4gSGksIEhhbiwNCj4gDQo+IE9uIDA0LzI1LzIwMTkgMTI6MDggQU0sIEhhbiBYdSB3cm90
ZToNCj4gPiBFeHRlcm5hbCBFLU1haWwNCj4gPg0KPiA+DQo+ID4gSW4gdGhlIG5ldyBpbXBsZW1l
bnRlZCBzcGlfbm9yX3Jlc3VtZSBmdW5jdGlvbiwgdGhlIHNwaV9ub3JfaW5pdCgpDQo+ID4gc2hv
dWxkIGJlIGJyYWNlZCBieSBwcmVwL3VucHJlcCBmdW5jdGlvbnMuXw0KPiA+DQo+IA0KPiBXb3Vs
ZCB5b3UgcGxlYXNlIGV4cGxhaW4gd2h5IHRoaXMgaXMgbmVlZGVkPyBIYXZlIHlvdSB0cmllZCBh
DQo+IHN1c3BlbmQvcmVzdW1lIGN5Y2xlIHdoaWxlIGEgd3JpdGUgd2FzIGluIHByb2dyZXNzIGFu
ZCBpdCBmYWlsZWQ/DQoNClNhbWUgYXMgYWxsIG90aGVyIGZ1bmN0aW9ucyB0aGF0IGhvb2tlZCB1
cCB3aXRoIG10ZCBvcHMsIHN1Y2ggYXMNCl9yZWFkL193cml0ZS9fbG9jay9fdW5sb2NrLCB0aGUg
X3Jlc3VtZSBmdW5jdGlvbiBhbHNvIG5lZWQgdG8gY2FsbCB0aGUNCmxvd2VyIGxldmVsIGNvbnRy
b2xsZXIncyBwcmVwL3VucHJlcCBmdW5jdGlvbnMgdG8gcHJvcGVybHkgaGFuZGxlIHJ1bnRpbWUN
CnBtIGFuZCBtdXRleC4NCg0KSSBkaWRuJ3QgdHJ5IHN1c3BlbmQvcmVzdW1lIGR1cmluZyB3cml0
aW5nLCBidXQgZm91bmQgYWNjZXNzaW5nIHJlZ2lzdGVycw0Kd2l0aG91dCBlbmFibGluZyBjbG9j
ayB3aGVuIHN5c3RlbSByZXN1bWVkLg0KDQo+IA0KPiBUaGFua3MsDQo+IHRhDQo=
