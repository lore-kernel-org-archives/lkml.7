Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D0C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BC42147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9QwyRGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfHFGEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:04:36 -0400
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:52547
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731557AbfHFGEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZEKZpLRDCHaf13I2N1hmyZQutVPjdswmBamX8Ct/Y6c4/5JHqRAdZgkQuPuxrAJTmfs62pEhuK8148RBMHgbV8Tjp6VtObmP8/TjwQIb7284WjfBXNU6aIZvsK9+WSIems0CTvCGYuJlGUVZAhurYkE765y9rTr2tEsHatZ0D8VBJnScZSw0tBtInpJR33dciZ88cX98gOBTThP9BtUHrfjaSTtHCyIXlrQvIUSiHRsB1/jCn2tCAA50XBzW/tYKZIy/AQHIYbtEYqbaaEQv5VkOAn/UOBoxkTHxoaRjR/kmepHfDIhtqyUM0krf7+PK+fNcJ3B76Sm0/2Bzdi8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcR+wvYqi7wJDAkHQtna5mtBINHjjR+wcb7pKqHsOEE=;
 b=kh8+8BGzXdmZXCtX8zy6btjNrubhhMLKQkNgKtxzMvfpuGrBpex9AslGmLGy/KqokZbpEWrBQOrgicGzGYDcN4fkN6tzFSEkImbseDGcUZl7QqYaXSfHuY5/8qp0cnU6ocMeTy8IEIAPWMhp0KtdBvajjkjcUsx+DVC9QTU2kvZfxOwa9j00pkxZoZFVyWYYmVjLGBKKZKL1YxgBKgtHKBaFO2QrnhiamqxsZF4NEBErHkkos7d3ySd2Rjjug/3WFHj9ScCE213abMVuwjh93UOeQ8dX2YL33OAPnHHD0ljvDK/EFjI/NvWAyCa9FSQIaYdXM/fk1/jBXB02gH9XSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcR+wvYqi7wJDAkHQtna5mtBINHjjR+wcb7pKqHsOEE=;
 b=U9QwyRGITwjNZroc1VnWwZA/pBWa74YwUakb85o4jTUf7/tElZPZJTh9UuV2e6eV7dR6q1DcOF99M8e6wg7vPwYBBYjWEm8UM9sIHM7fw5aPTHWiynFXfaDOwru9XR0eBwkG/7PO0wyGQeXBKHdMgqRb/X9W+xhTxeO1fplEu+c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Tue, 6 Aug 2019 06:04:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 06:04:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Topic: [PATCH V3] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Index: AQHVMKtuuPFHSCY26k2sG80ZDaRX1qbQInuAgB21jFA=
Date:   Tue, 6 Aug 2019 06:04:32 +0000
Message-ID: <DB3PR0402MB39163E3E626256B22634EFE7F5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190702074545.48267-1-Anson.Huang@nxp.com>
 <20190718082216.GO3738@dragon>
In-Reply-To: <20190718082216.GO3738@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a91fddb-f051-4c64-cfd0-08d71a33f382
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3642;
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-microsoft-antispam-prvs: <DB3PR0402MB36428C9AE2B3F92222B9AC30F5D50@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(64756008)(66446008)(54906003)(71190400001)(71200400001)(44832011)(486006)(7696005)(476003)(74316002)(11346002)(446003)(68736007)(86362001)(14454004)(4326008)(478600001)(25786009)(316002)(6246003)(6436002)(76116006)(33656002)(305945005)(7736002)(26005)(3846002)(5660300002)(110136005)(55016002)(186003)(9686003)(6116002)(66946007)(66556008)(76176011)(229853002)(2906002)(66066001)(99286004)(53936002)(102836004)(52536014)(66476007)(8676002)(81156014)(81166006)(6506007)(256004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wcje9bPQj/eStg5kncDu4omLAhuMsNG/5S+SVn+pkUYyVLml8jaEhRDKHA3tPj45soBBhUmmeLTLaVL/r+/7ljfV4nYgUR/xowO/WqJjmHNyp2ZBMOrxno4RMdgkI2Ij2qC53dBC3SAzmZq/ARiFnR8WouN8vbQ7ZgGMyOff0eGfIPXxqgI1ouAmIQbl6tG3dA77jYNUitRkS3T9+meIeLEvJdSTS+Jm6vsihcu3u3tRWYHzGG+zSPIe3+QYS6W0+uVeTvdCxojah3bpG0T+7u3cRpoeEwrHH2VzgwpW41BeRqBTL9HK9RkzlsdtCEWz93CuMpKsNV87ge+kmSbcXh9UE1ZkxlkLGqQ2nIcJ1yQNVrc8X1FTYQHnHZGLdeVl4LH8XCdCaPlGVAF6HClvv3n+/IFKK2onwLVTW0OguO0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a91fddb-f051-4c64-cfd0-08d71a33f382
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 06:04:32.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoJQXJlIHlvdSBPSyB3aXRoIHRoaXMgcGF0Y2g/DQoNClRoYW5rcywNCkFuc29u
Lg0KDQo+IE9uIFR1ZSwgSnVsIDAyLCAyMDE5IGF0IDAzOjQ1OjQ1UE0gKzA4MDAsIEFuc29uLkh1
YW5nQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54
cC5jb20+DQo+ID4NCj4gPiBBZGQgaS5NWCBTQ1UgU29DJ3MgVUlEKHVuaXF1ZSBpZGVudGlmaWVy
KSBzdXBwb3J0LCB1c2VyIGNhbiByZWFkIGl0DQo+ID4gZnJvbSBzeXNmczoNCj4gPg0KPiA+IHJv
b3RAaW14OHF4cG1lazp+IyBjYXQgL3N5cy9kZXZpY2VzL3NvYzAvc29jX3VpZA0KPiA+IDdCNjQy
ODBCNTdBQzE4OTgNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5I
dWFuZ0BueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFs
dXRhQG54cC5jb20+DQo+IA0KPiBATWFyY28sIGFyZSB5b3UgaGFwcHkgd2l0aCBpdD8NCj4gDQo+
IFNoYXduDQo+IA0KPiA+IC0tLQ0KPiA+IENoYW5nZSBzaW5jZSBWMjoNCj4gPiAJLSBUaGUgU0NV
IEZXIEFQSSBmb3IgZ2V0dGluZyBVSUQgZG9lcyBOT1QgaGF2ZSByZXNwb25zZSwgc28gd2UNCj4g
c2hvdWxkIHNldA0KPiA+IAkgIGlteF9zY3VfY2FsbF9ycGMoKSdzIDNyZCBwYXJhbWV0ZXIgYXMg
ZmFsc2UgYW5kIHN0aWxsIGNhbiBjaGVjayB0aGUNCj4gcmV0dXJuZWQNCj4gPiAJICB2YWx1ZSwg
YW5kIGNvbW1lbnQgaXMgbm8gbmVlZGVkIGFueSBtb3JlLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L3NvYy9pbXgvc29jLWlteC1zY3UuYyB8IDM5DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gPiBi
L2RyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jIGluZGV4IDY3NmY2MTIuLjUwODMxZWIgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gPiArKysgYi9k
cml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYw0KPiA+IEBAIC0yNyw2ICsyNyw0MCBAQCBzdHJ1
Y3QgaW14X3NjX21zZ19taXNjX2dldF9zb2NfaWQgew0KPiA+ICAJfSBkYXRhOw0KPiA+ICB9IF9f
cGFja2VkOw0KPiA+DQo+ID4gK3N0cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3NvY191aWQgew0K
PiA+ICsJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gPiArCXUzMiB1aWRfbG93Ow0KPiA+
ICsJdTMyIHVpZF9oaWdoOw0KPiA+ICt9IF9fcGFja2VkOw0KPiA+ICsNCj4gPiArc3RhdGljIHNz
aXplX3Qgc29jX3VpZF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArCQkJICAgIHN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpIHsNCj4gPiArCXN0cnVjdCBpbXhf
c2NfbXNnX21pc2NfZ2V0X3NvY191aWQgbXNnOw0KPiA+ICsJc3RydWN0IGlteF9zY19ycGNfbXNn
ICpoZHIgPSAmbXNnLmhkcjsNCj4gPiArCXU2NCBzb2NfdWlkOw0KPiA+ICsJaW50IHJldDsNCj4g
PiArDQo+ID4gKwloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gPiArCWhkci0+c3Zj
ID0gSU1YX1NDX1JQQ19TVkNfTUlTQzsNCj4gPiArCWhkci0+ZnVuYyA9IElNWF9TQ19NSVNDX0ZV
TkNfVU5JUVVFX0lEOw0KPiA+ICsJaGRyLT5zaXplID0gMTsNCj4gPiArDQo+ID4gKwlyZXQgPSBp
bXhfc2N1X2NhbGxfcnBjKHNvY19pcGNfaGFuZGxlLCAmbXNnLCBmYWxzZSk7DQo+ID4gKwlpZiAo
cmV0KSB7DQo+ID4gKwkJcHJfZXJyKCIlczogZ2V0IHNvYyB1aWQgZmFpbGVkLCByZXQgJWRcbiIs
IF9fZnVuY19fLCByZXQpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJc29jX3VpZCA9IG1zZy51aWRfaGlnaDsNCj4gPiArCXNvY191aWQgPDw9IDMyOw0KPiA+ICsJ
c29jX3VpZCB8PSBtc2cudWlkX2xvdzsNCj4gPiArDQo+ID4gKwlyZXR1cm4gc3ByaW50ZihidWYs
ICIlMDE2bGxYXG4iLCBzb2NfdWlkKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIERFVklDRV9BVFRS
X1JPKHNvY191aWQpOw0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBpbXhfc2N1X3NvY19pZCh2b2lk
KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF9zb2NfaWQgbXNnOyBA
QCAtMTAyLDYgKzEzNiwxMSBAQA0KPiBzdGF0aWMNCj4gPiBpbnQgaW14X3NjdV9zb2NfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCQlnb3RvIGZyZWVfcmV2aXNpb247
DQo+ID4gIAl9DQo+ID4NCj4gPiArCXJldCA9IGRldmljZV9jcmVhdGVfZmlsZShzb2NfZGV2aWNl
X3RvX2RldmljZShzb2NfZGV2KSwNCj4gPiArCQkJCSAmZGV2X2F0dHJfc29jX3VpZCk7DQo+ID4g
KwlpZiAocmV0KQ0KPiA+ICsJCWdvdG8gZnJlZV9yZXZpc2lvbjsNCj4gPiArDQo+ID4gIAlyZXR1
cm4gMDsNCj4gPg0KPiA+ICBmcmVlX3JldmlzaW9uOg0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
