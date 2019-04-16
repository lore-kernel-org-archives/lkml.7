Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCF6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A43D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dzTIwP4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfDPH1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:27:41 -0400
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:19332
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbfDPH1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIHj2qS0nzuICWB7JGial7+/JlNYpw8in+2xgLfcPJU=;
 b=dzTIwP4WD0iArWmwpK0fFHO3CubRy6mFAZovas3FFO/lbcTgrGOEcPcyvjBISVm6avcNkQ3gVwKIvF9lmBnM5zA6LT/J5SNrJgXVw/zzgGro5kMPDQx1/6Sx85eJBbvVMt0AySdzTaGmOxC/2ZC1FwSu640YM1cRiWL33PG6/iA=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB4267.eurprd04.prod.outlook.com (52.135.131.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 16 Apr 2019 07:27:35 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::9c1e:27f0:1ee9:fdb3]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::9c1e:27f0:1ee9:fdb3%7]) with mapi id 15.20.1792.020; Tue, 16 Apr 2019
 07:27:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        BOUGH CHEN <haibo.chen@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [RFC] mmc: cqhci: clear pending interrupt and halt
Thread-Topic: [RFC] mmc: cqhci: clear pending interrupt and halt
Thread-Index: AdT0JRdlQAalgnPYSsORgSA2pNnttw==
Date:   Tue, 16 Apr 2019 07:27:35 +0000
Message-ID: <DB7PR04MB44904965E8F1BF09A5C150B288240@DB7PR04MB4490.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 815e3c04-34ca-4057-db1b-08d6c23cff35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR04MB4267;
x-ms-traffictypediagnostic: DB7PR04MB4267:
x-microsoft-antispam-prvs: <DB7PR04MB4267BE7CD7E327487B91806888240@DB7PR04MB4267.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(486006)(8936002)(305945005)(8676002)(66066001)(81156014)(25786009)(316002)(476003)(6116002)(4326008)(9686003)(81166006)(55016002)(5660300002)(105586002)(2906002)(14454004)(2201001)(106356001)(3846002)(14444005)(44832011)(86362001)(53546011)(52536014)(229853002)(186003)(68736007)(71200400001)(71190400001)(256004)(97736004)(53936002)(478600001)(6246003)(26005)(7696005)(110136005)(74316002)(54906003)(7736002)(6436002)(99286004)(2501003)(102836004)(33656002)(6636002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4267;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kThuLdMsz5yoQwSJSFQ9Xj8jxRBtPf6Ew/gBWy5rZjIUyUGkCuty9Vc2uYMdGAaixush8jtyL54Ifz2z4Vajh9h8jWE1muTAnCQix00aFslbzveYKiBSDZqVgBAKJSHhECYXtWzBj1j2PPR1R5iEpfnB4Oki63hdDapPToRst0FQOdZhfuCewXr6ec+qf79KTgLqVc49HKRZzVbB/dT3KreN5KHvCd+JHvnrChPEvKUAnSpRLLuEeoAdXu48wHueCdhgki5ilw29UZUM07aBZFlJxtisT+dTgds2tDftpT0I+RXyGegpFGIbqRwMTxh5eqiJf+zLIGnIqLYu7fq6WKgvavN+avxS/pjH07St/kSwRxGrUoQtJhRIGQPad0Nk4mInlhvB8L4xEs/ZwRTzPG7TQ6t7BDk+SJg94JzgDtM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815e3c04-34ca-4057-db1b-08d6c23cff35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 07:27:35.4299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRyaWFuLA0KDQo+IA0KPiBPbiAxNi8wNC8xOSA5OjQ4IEFNLCBQZW5nIEZhbiB3cm90ZToN
Cj4gPiBPbiBpLk1YOE1NLCB3ZSBhcmUgcnVubmluZyBEdWFsIExpbnV4IE9TLCB3aXRoIDFzdCBM
aW51eCB1c2luZyBTRCBDYXJkDQo+ID4gYXMgcm9vdGZzIHN0b3JhZ2UsIDJuZCBMaW51eCB1c2lu
ZyBlTU1DIGFzIHJvb3RmcyBzdG9yYWdlLiBXZSBsZXQgdGhlDQo+ID4gdGhlIDFzdCBsaW51eCBj
b25maWd1cmUgcG93ZXIvY2xvY2sgZm9yIHRoZSAybmQgTGludXguDQo+ID4NCj4gPiBXaGVuIHRo
ZSAybmQgTGludXggaXMgYm9vdGluZyBpbnRvIHJvb3RmcyBzdGFnZSwgd2UgbGV0IHRoZSAxc3Qg
TGludXgNCj4gPiB0byBkZXN0cm95IHRoZSAybmQgbGludXgsIHRoZW4gcmVzdGFydCB0aGUgMXN0
IGxpbnV4LCB3ZSBtZXQgU0RIQ0kNCj4gPiBkdW1wIGFzIGZvbGxvd2luZywgYWZ0ZXIgd2UgY2xl
YXIgdGhlIHBlbmRpbmcgaW50ZXJydXB0IGFuZCBoYWx0DQo+ID4gQ1FDVEwsIGlzc3VlIGdvbmUu
DQo+IA0KPiBJIHRoaW5rIGl0IGlzIGJldHRlciBpZiB0aGUgdmVuZG9yIGRyaXZlciBkb2VzIGFu
eSBuZWNlc3NhcnkgcmVzZXRzIGJlZm9yZQ0KPiBpbml0aWFsaXphdGlvbi4NCg0KSW4gZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYywgdGhlcmUgaXMgYSBjYWxsIHRvIGNxaGNpX2lu
aXQNCiIgMTUyNSAgICAgICAgICAgICAgICAgZXJyID0gY3FoY2lfaW5pdChjcV9ob3N0LCBob3N0
LT5tbWMsIGZhbHNlKTsiDQoNCllvdSBtZWFuIEkgcHV0IHRoZSBmb2xsb3dpbmcgcGllY2UgY29k
ZSBpbnRvIHNkaGNpLWVzZGhjLWlteC5jPw0KDQoiDQogICAgIHN0YXR1cyA9IGNxaGNpX3JlYWRs
KGNxX2hvc3QsIENRSENJX0lTKTsNCiAgICAgY3FoY2lfd3JpdGVsKGNxX2hvc3QsIHN0YXR1cywg
Q1FIQ0lfSVMpOw0KICAgICBjcWhjaV93cml0ZWwoY3FfaG9zdCwgQ1FIQ0lfSEFMVCwgQ1FIQ0lf
Q1RMKTsNCiINCg0KSG93IGFib3V0IHRoZSBmb2xsb3dpbmcgcGF0Y2g/DQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIGIvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1lc2RoYy1pbXguYw0KaW5kZXggYjhlMTFhNzdlMjc0Li5mMmU0NmRkZjk2OTUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQorKysgYi9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQpAQCAtMTQzNSw2ICsxNDM1LDcgQEAgc3RhdGlj
IGludCBzZGhjaV9lc2RoY19pbXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAgICAgICAgc3RydWN0IGNxaGNpX2hvc3QgKmNxX2hvc3Q7DQogICAgICAgIGludCBlcnI7DQog
ICAgICAgIHN0cnVjdCBwbHRmbV9pbXhfZGF0YSAqaW14X2RhdGE7DQorICAgICAgIHUzMiBzdGF0
dXM7DQoNCiAgICAgICAgaG9zdCA9IHNkaGNpX3BsdGZtX2luaXQocGRldiwgJnNkaGNpX2VzZGhj
X2lteF9wZGF0YSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKCppbXhf
ZGF0YSkpOw0KQEAgLTE1NDIsNiArMTU0MywxMSBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX2lt
eF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KICAgICAgICAgICAgICAgIGVy
ciA9IGNxaGNpX2luaXQoY3FfaG9zdCwgaG9zdC0+bW1jLCBmYWxzZSk7DQogICAgICAgICAgICAg
ICAgaWYgKGVycikNCiAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZGlzYWJsZV9haGJfY2xr
Ow0KKw0KKyAgICAgICAgICAgICAgIHN0YXR1cyA9IGNxaGNpX3JlYWRsKGNxX2hvc3QsIENRSENJ
X0lTKTsNCisgICAgICAgICAgICAgICBjcWhjaV93cml0ZWwoY3FfaG9zdCwgc3RhdHVzLCBDUUhD
SV9JUyk7DQorICAgICAgICAgICAgICAgY3FoY2lfd3JpdGVsKGNxX2hvc3QsIENRSENJX0hBTFQs
IENRSENJX0NUTCk7DQorDQogICAgICAgIH0NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gPg0K
PiA+IFsgMS4zMzQ1OTRdIG1tYzI6IEdvdCBjb21tYW5kIGludGVycnVwdCAweDAwMDAwMDAxIGV2
ZW4gdGhvdWdoIG5vDQo+IGNvbW1hbmQgb3BlcmF0aW9uIHdhcyBpbiBwcm9ncmVzcy4NCj4gPiBb
IDEuMzM0NTk1XSBtbWMyOiBzZGhjaTogPT09PT09PT09PT09IFNESENJIFJFR0lTVEVSIERVTVAN
Cj4gPT09PT09PT09PT0NCj4gPiBbIDEuMzM0NTk5XSBtbWMyOiBzZGhjaTogU3lzIGFkZHI6IDB4
YTA1ZGNjMDAgfCBWZXJzaW9uOiAweDAwMDAwMDAyIFsNCj4gPiAxLjM0MDgxOV0gbGliODAyMTE6
IGNvbW1vbiByb3V0aW5lcyBmb3IgSUVFRTgwMi4xMSBkcml2ZXJzIFsgMS4zNDU1MzhdDQo+ID4g
bW1jMjogc2RoY2k6IEJsayBzaXplOiAweDAwMDAwMjAwIHwgQmxrIGNudDogMHgwMDAwMDAwMCBb
IDEuMzQ1NTQxXQ0KPiA+IG1tYzI6IHNkaGNpOiBBcmd1bWVudDogMHgwMDAxODAwMCB8IFRybiBt
b2RlOiAweDAwMDAwMDMzIFsgMS4zNDU1NDNdDQo+ID4gbW1jMjogc2RoY2k6IFByZXNlbnQ6IDB4
MDFmODgwMDggfCBIb3N0IGN0bDogMHgwMDAwMDAzMSBbIDEuMzQ1NTQ3XQ0KPiA+IG1tYzI6IHNk
aGNpOiBQb3dlcjogMHgwMDAwMDAwMiB8IEJsayBnYXA6IDB4MDAwMDAwODAgWyAxLjM1NzkwM10N
Cj4gbW1jMjoNCj4gPiBzZGhjaTogV2FrZS11cDogMHgwMDAwMDAwOCB8IENsb2NrOiAweDAwMDAw
MDNmIFsgMS4zNTc5MDVdIG1tYzI6DQo+ID4gc2RoY2k6IFRpbWVvdXQ6IDB4MDAwMDAwOGYgfCBJ
bnQgc3RhdDogMHgwMDAwMDAwMCBbIDEuMzU3OTA4XSBtbWMyOg0KPiA+IHNkaGNpOiBJbnQgZW5h
YjogMHgxMDdmMTAwYiB8IFNpZyBlbmFiOiAweDEwN2YxMDBiIFsgMS4zNTc5MTFdIG1tYzI6DQo+
ID4gc2RoY2k6IEFDMTIgZXJyOiAweDAwMDAwMDAwIHwgU2xvdCBpbnQ6IDB4MDAwMDA1MDIgWyAx
LjM3MDI2OF0gbW1jMjoNCj4gPiBzZGhjaTogQ2FwczogMHgwN2ViMDAwMCB8IENhcHNfMTogMHgw
MDAwYjQwMCBbIDEuMzcwMjcwXSBtbWMyOiBzZGhjaToNCj4gPiBDbWQ6IDB4MDAwMDBkMWEgfCBN
YXggY3VycjogMHgwMGZmZmZmZiBbIDEuMzcwMjczXSBtbWMyOiBzZGhjaToNCj4gPiBSZXNwWzBd
OiAweDAwMDAwYjAwIHwgUmVzcFsxXTogMHhmZmZmZmZmZiBbIDEuMzcwMjc2XSBtbWMyOiBzZGhj
aToNCj4gPiBSZXNwWzJdOiAweDMyOGY1OTAzIHwgUmVzcFszXTogMHgwMGQwMGYwMCBbIDEuMzgy
MTMyXSBtbWMyOiBzZGhjaToNCj4gPiBIb3N0IGN0bDI6IDB4MDAwMDAwMDAgWyAxLjM4MjEzNV0g
bW1jMjogc2RoY2k6IEFETUEgRXJyOiAweDAwMDAwMDAwIHwNCj4gPiBBRE1BIFB0cjogMHhhMjA0
MDIwOA0KPiA+DQo+ID4gWyAyLjA2MDkzMl0gbW1jMjogVW5leHBlY3RlZCBpbnRlcnJ1cHQgMHgw
MDAwNDAwMC4NCj4gPiBbIDIuMDY1NTM4XSBtbWMyOiBzZGhjaTogPT09PT09PT09PT09IFNESENJ
IFJFR0lTVEVSIERVTVANCj4gPT09PT09PT09PT0NCj4gPiBbIDIuMDcxNzIwXSBtbWMyOiBzZGhj
aTogU3lzIGFkZHI6IDB4MDAwMDAwMDAgfCBWZXJzaW9uOiAweDAwMDAwMDAyIFsNCj4gPiAyLjA3
NzkwMl0gbW1jMjogc2RoY2k6IEJsayBzaXplOiAweDAwMDAwMjAwIHwgQmxrIGNudDogMHgwMDAw
MDAwMSBbDQo+ID4gMi4wODQwODNdIG1tYzI6IHNkaGNpOiBBcmd1bWVudDogMHgwMDAwMDAwMCB8
IFRybiBtb2RlOiAweDAwMDAwMDAwIFsNCj4gPiAyLjA5MDI2NF0gbW1jMjogc2RoY2k6IFByZXNl
bnQ6IDB4MDFmODgwMDkgfCBIb3N0IGN0bDogMHgwMDAwMDAxMSBbDQo+ID4gMi4wOTY0NDZdIG1t
YzI6IHNkaGNpOiBQb3dlcjogMHgwMDAwMDAwMiB8IEJsayBnYXA6IDB4MDAwMDAwODAgWw0KPiA+
IDIuMTAyNjI3XSBtbWMyOiBzZGhjaTogV2FrZS11cDogMHgwMDAwMDAwOCB8IENsb2NrOiAweDAw
MDAxMGZmIFsNCj4gPiAyLjEwODgwOV0gbW1jMjogc2RoY2k6IFRpbWVvdXQ6IDB4MDAwMDAwOGYg
fCBJbnQgc3RhdDogMHgwMDAwNDAwMCBbDQo+ID4gMi4xMTQ5OTBdIG1tYzI6IHNkaGNpOiBJbnQg
ZW5hYjogMHgwMDdmMTAwMyB8IFNpZyBlbmFiOiAweDAwN2YxMDAzIFsNCj4gPiAyLjEyMTE3MV0g
bW1jMjogc2RoY2k6IEFDMTIgZXJyOiAweDAwMDAwMDAwIHwgU2xvdCBpbnQ6IDB4MDAwMDA1MDIg
Ww0KPiA+IDIuMTI3MzUzXSBtbWMyOiBzZGhjaTogQ2FwczogMHgwN2ViMDAwMCB8IENhcHNfMTog
MHgwMDAwYjQwMCBbDQo+ID4gMi4xMzM1MzRdIG1tYzI6IHNkaGNpOiBDbWQ6IDB4MDAwMDM3MWEg
fCBNYXggY3VycjogMHgwMGZmZmZmZiBbDQo+ID4gMi4xMzk3MTVdIG1tYzI6IHNkaGNpOiBSZXNw
WzBdOiAweDAwMDAwOTAwIHwgUmVzcFsxXTogMHhmZmZmZmZmZiBbDQo+ID4gMi4xNDU4OTZdIG1t
YzI6IHNkaGNpOiBSZXNwWzJdOiAweDMyOGY1OTAzIHwgUmVzcFszXTogMHgwMGQwMGYwMCBbDQo+
ID4gMi4xNTIwNzddIG1tYzI6IHNkaGNpOiBIb3N0IGN0bDI6IDB4MDAwMDAwMDAgWyAyLjE1NjM0
Ml0gbW1jMjogc2RoY2k6DQo+ID4gQURNQSBFcnI6IDB4MDAwMDAwMDAgfCBBRE1BIFB0cjogMHgw
MDAwMDAwMA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYyB8IDUgKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYyBpbmRl
eA0KPiA+IGQ1OWNiMGE1MTk2NC4uNGY0MTk2MGFjN2FkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3QvY3FoY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYw0K
PiA+IEBAIC0xMTE2LDYgKzExMTYsNyBAQCBpbnQgY3FoY2lfaW5pdChzdHJ1Y3QgY3FoY2lfaG9z
dCAqY3FfaG9zdCwgc3RydWN0DQo+IG1tY19ob3N0ICptbWMsDQo+ID4gICAgICAgICAgICAgYm9v
bCBkbWE2NCkNCj4gPiAgew0KPiA+ICAgICAgIGludCBlcnI7DQo+ID4gKyAgICAgdTMyIHN0YXR1
czsNCj4gPg0KPiA+ICAgICAgIGNxX2hvc3QtPmRtYTY0ID0gZG1hNjQ7DQo+ID4gICAgICAgY3Ff
aG9zdC0+bW1jID0gbW1jOw0KPiA+IEBAIC0xMTM5LDYgKzExNDAsMTAgQEAgaW50IGNxaGNpX2lu
aXQoc3RydWN0IGNxaGNpX2hvc3QgKmNxX2hvc3QsDQo+ID4gc3RydWN0IG1tY19ob3N0ICptbWMs
DQo+ID4NCj4gPiAgICAgICBzcGluX2xvY2tfaW5pdCgmY3FfaG9zdC0+bG9jayk7DQo+ID4NCj4g
PiArICAgICBzdGF0dXMgPSBjcWhjaV9yZWFkbChjcV9ob3N0LCBDUUhDSV9JUyk7DQo+ID4gKyAg
ICAgY3FoY2lfd3JpdGVsKGNxX2hvc3QsIHN0YXR1cywgQ1FIQ0lfSVMpOw0KPiA+ICsgICAgIGNx
aGNpX3dyaXRlbChjcV9ob3N0LCBDUUhDSV9IQUxULCBDUUhDSV9DVEwpOw0KPiA+ICsNCj4gPiAg
ICAgICBpbml0X2NvbXBsZXRpb24oJmNxX2hvc3QtPmhhbHRfY29tcCk7DQo+ID4gICAgICAgaW5p
dF93YWl0cXVldWVfaGVhZCgmY3FfaG9zdC0+d2FpdF9xdWV1ZSk7DQo+ID4NCj4gPg0KDQo=
