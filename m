Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325AEC32754
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A4D206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hLlUL1oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfHAErv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 00:47:51 -0400
Received: from mail-eopbgr780053.outbound.protection.outlook.com ([40.107.78.53]:29696
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfHAErv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:47:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWlO0EbTWBPq9Dbj+MTGjgzYUUu/TtI+7upsuSat01HoX/0I9fwgltwrLcNBWA/xVlWVxb8RQZVioFpih1SDRUhALejlIq5VbUbqSdsvqJJCrQz7c2WtYSF9utDpSkzna6G9cjLTazKZgywlY1cZ6VHdk46DmWPQ/znOYKYQz3eB+domSUK80YzwF/lo1sXcEV0IdAhkPXUEWTyJtDNTie5OYLFfdM2rfMiiJcGY0X3NXayVkNe24ImGDg/Z6larL2QWoVsfLFgqTJTGyFN2n49YWDi80xdb/cxuFrmFhIRLFahIVDyVAQvl9OIHU35jNN2eoljb0ds8pcj5XgVATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1y+Jdl3MkxZH/3zC2FhtVaDMVrBgMw0986z/p+FNSo=;
 b=F9BAlp8yBdeAKnWjZaq+Cb5ZyMV/5sea8lYm5c/7lcLLYccQgUKUdwcmo+Nx2w7isHYUZ5RTr4ruUGLHCUpKdiasL1akzHkFdadEF42mrLfUE28N+hfH0fojOOsYOAEgpebn0RsR2W6OQdKhq3pRd6t8sXWPoQBnLYmY4AHKKOCmxojreQlHzy9oDnkqzvIeN/RkQu62iI/uycGq7vIfnQCYe3EWXapV4UeOyxKGovMdwPfVLBEd0gkB8Im7kV8qR7LAKUpVFkcZeI9ogf2Zy7eucx5RRUAkPvrjfMVCYy3LdSF/fMwxGNN/GJINQDToMmI3OqqnUx3tR1xiaeF5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=xilinx.com;dmarc=pass action=none
 header.from=xilinx.com;dkim=pass header.d=xilinx.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1y+Jdl3MkxZH/3zC2FhtVaDMVrBgMw0986z/p+FNSo=;
 b=hLlUL1oF0Ul9FCiwHwejJgF+44RDmBOMteYY/90F7ST5RjaU0rxPHBR6hOCY/o8jFV/M8WGdREVObWVoPuj1p16r4hdXyXjLatR6J8ZN0sqdeen5eXxAkoPXYgDS0/0WMIbKzCIjrhVCuXsrm7VoEocr5xdJ41t1+dlCQuZzl34=
Received: from MN2PR02MB5727.namprd02.prod.outlook.com (20.179.85.153) by
 MN2PR02MB7102.namprd02.prod.outlook.com (20.180.27.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Thu, 1 Aug 2019 04:47:48 +0000
Received: from MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::3873:a3ea:1f66:fc89]) by MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::3873:a3ea:1f66:fc89%7]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 04:47:48 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Topic: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Index: AQHVR4AuPtwOhxyzBUKoXu06OueqLabkpU9AgAANTICAAQbGMA==
Date:   Thu, 1 Aug 2019 04:47:48 +0000
Message-ID: <MN2PR02MB5727B99A02E915AEFE89D318AFDE0@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
 <20190731091145.27374-6-tudor.ambarus@microchip.com>
 <MN2PR02MB5727FF8617B1A2FC89739601AFDF0@MN2PR02MB5727.namprd02.prod.outlook.com>
 <cfe63aee-2c48-c321-53b7-3997c97dc215@microchip.com>
In-Reply-To: <cfe63aee-2c48-c321-53b7-3997c97dc215@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1214451-18f6-48ae-0b15-08d7163b675e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR02MB7102;
x-ms-traffictypediagnostic: MN2PR02MB7102:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR02MB71026829BF43E6E66CE0EC41AFDE0@MN2PR02MB7102.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(13464003)(189003)(199004)(26005)(33656002)(66066001)(6246003)(52536014)(54906003)(110136005)(316002)(6436002)(229853002)(8676002)(71190400001)(71200400001)(186003)(53936002)(102836004)(81156014)(7696005)(305945005)(99286004)(256004)(8936002)(7736002)(81166006)(5660300002)(76176011)(6116002)(3846002)(476003)(66946007)(2906002)(446003)(9686003)(6306002)(55016002)(4326008)(74316002)(14454004)(11346002)(478600001)(7416002)(2501003)(68736007)(53546011)(2201001)(6506007)(966005)(486006)(25786009)(86362001)(64756008)(66556008)(76116006)(66476007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB7102;H:MN2PR02MB5727.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ziD/EEI4Y3TcIrW1D9+IrkevZxaNA1W2qLEKFAYKyXoDZs3f8c+9dpK+h50ZdRo9U1Hawr9fnxKvED+8dr5Zs5qxMO2G7eIXADcsRyUnWW8Mg4mvvKxPEk0LH6qbcS4DtveGq45bL/iu3Qe/hhemZn1FJ60BBO/5WHd1QsqPV/t3Wr1lgD/Rbhzf5sZFPrIRJRnMf1fyyRJE7QcdJ+tDDFjbGiQ0S0XTvpbuLJgMtS3wMRNAMcWbdoeomfZYAbwKxmg0KRGckbDZ06Yn5+QiHoCVwk9sSQ6IgE+/nTnHFJ6WIqVsacYWhU+3G86Zqwj8cWZ1AtqfIDqDYeUVUKbx9+ZV6FO+NKFhO/4NzraxYKaul4NKjNnCdDta0q2Jdxjr1kawkITxTmywoNlO/XWxfD1/VOdrC1TceOd9cfvRURc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1214451-18f6-48ae-0b15-08d7163b675e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 04:47:48.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIDxUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgSnVseSAzMSwgMjAxOSA2OjM3IFBNDQo+IFRvOiBOYWdhIFN1cmVzaGt1
bWFyIFJlbGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPjsgYm9yaXMuYnJlemlsbG9uQGNvbGxhYm9y
YS5jb207DQo+IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgdmlnbmVzaHJAdGkuY29tDQo+IENjOiBy
aWNoYXJkQG5vZC5hdDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbXRkQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb207IGNvbXB1dGVy
c2ZvcnBlYWNlQGdtYWlsLmNvbTsgZHdtdzJAaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDUvNl0gbXRkOiBzcGktbm9yOiBBZGQgczNhbl9wb3N0X3NmZHBfZml4dXBzKCkNCj4g
DQo+IEhpLCBOYWdhLA0KPiANCj4gT24gMDcvMzEvMjAxOSAwMzozMSBQTSwgTmFnYSBTdXJlc2hr
dW1hciBSZWxsaSB3cm90ZToNCj4gPj4gKwlpZiAobm9yLT5pbmZvLT5mbGFncyAmIFNQSV9TM0FO
KQ0KPiA+PiArCQlzM2FuX3Bvc3Rfc2ZkcF9maXh1cHMobm9yKTsNCj4gPj4gIH0NCj4gPj4NCj4g
PiBJbnN0ZWFkIG9mIGNoZWNraW5nIHRoZSBmbGFncywgd2h5IGNhbid0IHdlIGNhbGwgZGlyZWN0
bHkgdGhlIG5vcl9maXh1cHM/DQo+ID4gbGlrZSBCb3JpcyBpbXBsZW1lbnRhdGlvbiBub3ItPmlu
Zm8tPmZpeHVwcy0+cG9zdF9zZmRwKCkNCj4gPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3Jn
L3BhdGNoLzEwMDkyOTEvDQo+IA0KPiBUaGlzIGNoZWNrIHdpbGwgdmFuaXNoIGFuZCBub3ItPmlu
Zm8tPmZpeHVwcy0+cG9zdF9zZmRwKCkgd2lsbCBiZSBjYWxsZWQgZGlyZWN0bHkgb25jZSBJJ2xs
DQo+IHJlc3BpbiB0aGUgbWFudWZhY3R1cmVyIGRyaXZlciBwYXJ0LiBwb3N0X3NmZHAoKSB3aWxs
IHNldCBqdXN0IGZsYXNoIHBhcmFtZXRlcnMuIENoZWNrIEJvcmlzJw0KPiBwYXRjaCBhdCBodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEwMDkyOTUvDQo+IA0KPiBJJ2xsIHRyeSB0
byByZXNwaW4gdGhlIHJlc3Qgb2YgQm9yaXMnIHBhdGNoZXMgc29tZXRpbWUgYXQgdGhlIGJlZ2lu
bmluZyBvZiB0aGUgbmV4dCB3ZWVrLg0KT2ssIFRoYW5rcy4NCg0KUmVnYXJkcywNCk5hZ2EgU3Vy
ZXNoa3VtYXIgUmVsbGkNCj4gDQo+IENoZWVycywNCj4gdGENCg==
