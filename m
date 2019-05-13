Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D5C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C682084F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QW39YRQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfEMXe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:34:57 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:42822
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfEMXe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivm63irdRJqw1B0UFl9vceTxhPPPFVUSmI9sdgJODZE=;
 b=QW39YRQIIjZw9+k+JSfb4nHP29JZCdAVp/VObEKKqL194N/UMbojPo2CawhknuDyB5XkWCEtI6EmYwriguZQDEHBUfjDgfI3IqidX1FLH2RW69Rs2fJTqN+7HjpFHxhrOy1o97VaR4ZWGDveGqu7glf917AXw3UxKqTzTl4+arU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3835.eurprd04.prod.outlook.com (52.134.65.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 23:34:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Mon, 13 May 2019
 23:34:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVCTfaYqtO/eSQ1UCSJJ4U0eiBlKZpHh8AgACXn+A=
Date:   Mon, 13 May 2019 23:34:12 +0000
Message-ID: <DB3PR0402MB3916A46BFFE5E6F3D4832A33F50F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
 <CAEnQRZDSTuUMrc9AC1S2zfo0PdQ-v35GmNrf70Zoasid_XMJzw@mail.gmail.com>
In-Reply-To: <CAEnQRZDSTuUMrc9AC1S2zfo0PdQ-v35GmNrf70Zoasid_XMJzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aa44f39-9874-46b3-46e1-08d6d7fb8196
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3835;
x-ms-traffictypediagnostic: DB3PR0402MB3835:
x-microsoft-antispam-prvs: <DB3PR0402MB3835373BD12968D5CC89C398F50F0@DB3PR0402MB3835.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(13464003)(199004)(189003)(7736002)(52536014)(71190400001)(81156014)(71200400001)(74316002)(6246003)(5660300002)(14454004)(44832011)(6506007)(53546011)(6116002)(3846002)(102836004)(256004)(8936002)(478600001)(8676002)(86362001)(76176011)(4326008)(7696005)(25786009)(33656002)(66066001)(6436002)(186003)(9686003)(55016002)(99286004)(305945005)(2906002)(6916009)(26005)(486006)(54906003)(11346002)(446003)(476003)(81166006)(66446008)(64756008)(66556008)(66476007)(73956011)(76116006)(53936002)(229853002)(66946007)(316002)(7416002)(68736007)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3835;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YmSGZMdPXcAhbVm2Jbf/Rt0BD0lgzXpkgmYMGuZ0ssf3ZCRRxNbZs4VNkcA0FxQbpgpNpUAoFXbmUmGNjVb53FFz6PlmOFP8hV88Su1QAme/mXpo4Df97ucqYLH8SY2h36TmzStcmAzVv27sC+QVRVwlCwL4TM3fd2a+UCspj08DYNV0L6CMoJUFEp0dzlRb5bvzjSqgTpDT9dt+FMOpqXMX3YRGYBmvfNyWBxVsa/BA8oJSCnrQlduVc7p9yDiTqhcOB1Eombc4VZts2rQA6hOy+1fLeaAlNpc/EAW8I8zeyrVibETpEFTD8EEoUrY0Q424PIB8W/CyTHUwNgVL8ljW6kDXowpd1xlVjY76jyeJkzwNGtlfvelV0hFqtnqf+uPA41Lgf2vfGjafB3gMKOcvov7+voij9KxfBQnpiGA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa44f39-9874-46b3-46e1-08d6d7fb8196
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 23:34:12.7924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBCYWx1dGEgW21haWx0bzpkYW5pZWwuYmFsdXRhQGdtYWlsLmNvbV0NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTMsIDIwMTkgMTA6MzAgUE0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0Bu
eHAuY29tPg0KPiBDYzogY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5j
b207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBtYXhpbWUucmlwYXJkQGJv
b3RsaW4uY29tOyBhZ3Jvc3NAa2VybmVsLm9yZzsNCj4gb2xvZkBsaXhvbS5uZXQ7IGhvcm1zK3Jl
bmVzYXNAdmVyZ2UubmV0LmF1Ow0KPiBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgYmpvcm4u
YW5kZXJzc29uQGxpbmFyby5vcmc7IExlb25hcmQgQ3Jlc3Rleg0KPiA8bGVvbmFyZC5jcmVzdGV6
QG54cC5jb20+OyBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsNCj4gZGluZ3V5ZW5Aa2VybmVsLm9y
ZzsgZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5n
LmRvbmdAbnhwLmNvbT47IHJvYmhAa2VybmVsLm9yZzsgQWJlbCBWZXNhDQo+IDxhYmVsLnZlc2FA
bnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4
LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRh
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIDEvMl0gc29jOiBpbXg6IEFk
ZCBTQ1UgU29DIGluZm8gZHJpdmVyIHN1cHBvcnQNCj4gDQo+IDxzbmlwPg0KPiANCj4gPiArDQo+
ID4gK3N0YXRpYyB1MzIgaW14OHF4cF9zb2NfcmV2aXNpb24odm9pZCkgew0KPiA+ICsgICAgICAg
c3RydWN0IGlteF9zY19tc2dfbWlzY19nZXRfc29jX2lkIG1zZzsNCj4gPiArICAgICAgIHN0cnVj
dCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4gKyAgICAgICB1MzIgcmV2ID0g
MDsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgaGRyLT52ZXIgPSBJ
TVhfU0NfUlBDX1ZFUlNJT047DQo+ID4gKyAgICAgICBoZHItPnN2YyA9IElNWF9TQ19SUENfU1ZD
X01JU0M7DQo+ID4gKyAgICAgICBoZHItPmZ1bmMgPSBJTVhfU0NfTUlTQ19GVU5DX0dFVF9DT05U
Uk9MOw0KPiA+ICsgICAgICAgaGRyLT5zaXplID0gMzsNCj4gPiArDQo+ID4gKyAgICAgICBtc2cu
ZGF0YS5zZW5kLmNvbnRyb2wgPSBJTVhfU0NfQ19JRDsNCj4gPiArICAgICAgIG1zZy5kYXRhLnNl
bmQucmVzb3VyY2UgPSBJTVhfU0NfUl9TWVNURU07DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0g
aW14X3NjdV9jYWxsX3JwYyhzb2NfaXBjX2hhbmRsZSwgJm1zZywgdHJ1ZSk7DQo+ID4gKyAgICAg
ICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJmlteF9zY3Vfc29jX3Bk
ZXYtPmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAiZ2V0IHNvYyBpbmZvIGZhaWxl
ZCwgcmV0ICVkXG4iLCByZXQpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV2Ow0KPiAN
Cj4gU28geW91IHJldHVybiAwIChyZXYgID0gMCkgaGVyZSBpbiBjYXNlIG9mIGVycm9yPyBUaGlz
IGRvZXNuJ3Qgc2VlbSB0byBiZSByaWdodC4NCj4gTWF5YmUgcmV0dXJuIHJldD8NCg0KVGhpcyBp
cyBpbnRlbnRpb25hbCwgc2ltaWxhciB3aXRoIGN1cnJlbnQgaS5NWDhNUSBzb2MgaW5mbyBkcml2
ZXIsIHdoZW4gZ2V0dGluZyByZXZpc2lvbg0KZmFpbGVkLCBqdXN0IHJldHVybiAwIGFzIHJldmlz
aW9uIGluZm8gYW5kIGl0IHdpbGwgc2hvdyAidW5rbm93biIgaW4gc3lzZnMuDQoNClRoYW5rcywN
CkFuc29uLg0KDQo=
