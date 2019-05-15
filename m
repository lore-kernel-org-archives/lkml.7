Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739D720843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W2KaMfNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEOH4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:56:15 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:31068
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfEOH4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfw7tIirkwCnRpnfsoTwEOAubjFw3Zu2rG9tnNmnNkw=;
 b=W2KaMfNU79AUzzD4BuoN50gdx9ccXb12frws7P38JjziK41O7tJbaWKea/nYcmV5JtuAgAlBCGON2xLv8KEY+JurLDRxgpdN0AsDDDg5c7yvQoo4YpdmAgE/TgKlfbUck8ytvj7Dbca3vpWro2W5/G4Evzl7+tzPugeklYkoYbI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4644.eurprd04.prod.outlook.com (52.135.149.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Wed, 15 May 2019 07:53:28 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 07:53:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH V3 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Topic: [PATCH V3 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Index: AQHVCvNIvY47qD01X0W2BY2Hg3O+1g==
Date:   Wed, 15 May 2019 07:53:27 +0000
Message-ID: <20190515080703.19147-2-peng.fan@nxp.com>
References: <20190515080703.19147-1-peng.fan@nxp.com>
In-Reply-To: <20190515080703.19147-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2315de07-dec2-4f29-121f-08d6d90a6a5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4644;
x-ms-traffictypediagnostic: AM0PR04MB4644:
x-microsoft-antispam-prvs: <AM0PR04MB4644FE14AE82D912A1E474C788090@AM0PR04MB4644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(99286004)(54906003)(256004)(110136005)(50226002)(478600001)(8936002)(14454004)(14444005)(2501003)(66066001)(71190400001)(71200400001)(52116002)(102836004)(53936002)(7736002)(4326008)(305945005)(6506007)(81156014)(386003)(81166006)(25786009)(8676002)(6636002)(66476007)(66446008)(64756008)(76176011)(66946007)(73956011)(66556008)(486006)(3846002)(44832011)(476003)(6512007)(6436002)(2616005)(446003)(11346002)(68736007)(6486002)(186003)(7416002)(2906002)(6116002)(316002)(1076003)(36756003)(26005)(86362001)(5660300002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4644;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LTAjgpv9ks9OlynULbxkgMaR7I3CclG+/T+wFz+B/OaBGqN7NWmYlFquuU6mlpojSIK3nUhbK5k9YWjEHDLq7Lj1CvYT8Sbr6Gcdtvrcv+dcOh4GVaWbyh1P/Q3rYUqGxAK4x8lSV/0enYg08gQMNxsmrud/Vc5qv6bKywnlrHi4Te612ov+/OgJf7N1QV0j5mh2kpXJdUffPcn2vhjc7SykmO9Cdrxu1qdHT22mLfBOatP3z/mB8FcVlL4hvr4w0USULxHttqRDJIT3PkwnqspNN3dlVPaTsikZhozXDaqJndNXvLp9wk3bnYvapK2FkxfDnFWCJ7f5DvKMVO0n3pT8LuM88YZrFb9hMVdrLDRLweiGncFZ7LCSHx1g+VN+eiZozfv+S1Wa6QFZydlBdp54hr8IsJrFTflmpY7XcB0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2315de07-dec2-4f29-121f-08d6d90a6a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 07:53:27.9588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGkuTVg4IG52bWVtIG9jb3RwIGRyaXZlciB0byBhY2Nlc3MgZnVzZSB2
aWENClJQQyB0byBpLk1YOCBzeXN0ZW0gY29udHJvbGxlci4NCg0KQ2M6IFNyaW5pdmFzIEthbmRh
Z2F0bGEgPHNyaW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZz4NCkNjOiBTaGF3biBHdW8gPHNo
YXduZ3VvQGtlcm5lbC5vcmc+DQpDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4
LmRlPg0KQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+
DQpDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KQ2M6IE5YUCBMaW51eCBU
ZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4NCkNjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcNClNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KLS0t
DQoNClYzOg0KIFVzZSBpbXhfc2NfbXNnX21pc2NfZnVzZV9yZWFkIGZvciByZXEvcmVzcA0KIERy
b3AgdW5lY2Nlc3NhcnkgY2hlY2sNCiBEcm9wIHRoZSB1bm5lY2Vzc2FyeSB0eXBlIGNvbnZlcnNp
b24NCiBNaW5vciBmaXhlcyBhY2NvcmRpbmcgdG8gdjIgY29tbWVudHMNCg0KVjI6DQogQWRkICJz
Y3UiIG9yICJTQ1UiLCBBZGQgaW14X3NjX21pc2Nfb3RwX2Z1c2VfcmVhZCwgbWlub3IgZml4ZXMN
Cg0KIGRyaXZlcnMvbnZtZW0vS2NvbmZpZyAgICAgICAgIHwgICA3ICsrDQogZHJpdmVycy9udm1l
bS9NYWtlZmlsZSAgICAgICAgfCAgIDIgKw0KIGRyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5j
IHwgMTYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDMgZmls
ZXMgY2hhbmdlZCwgMTcwIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vS2Nv
bmZpZyBiL2RyaXZlcnMvbnZtZW0vS2NvbmZpZw0KaW5kZXggNTMwZDU3MDcyNGM5Li43OWFmZTQ0
MTk1YTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWVtL0tjb25maWcNCisrKyBiL2RyaXZlcnMv
bnZtZW0vS2NvbmZpZw0KQEAgLTM2LDYgKzM2LDEzIEBAIGNvbmZpZyBOVk1FTV9JTVhfT0NPVFAN
CiAJICBUaGlzIGRyaXZlciBjYW4gYWxzbyBiZSBidWlsdCBhcyBhIG1vZHVsZS4gSWYgc28sIHRo
ZSBtb2R1bGUNCiAJICB3aWxsIGJlIGNhbGxlZCBudm1lbS1pbXgtb2NvdHAuDQogDQorY29uZmln
IE5WTUVNX0lNWF9PQ09UUF9TQ1UNCisJdHJpc3RhdGUgImkuTVg4IFNDVSBPbi1DaGlwIE9UUCBD
b250cm9sbGVyIHN1cHBvcnQiDQorCWRlcGVuZHMgb24gSU1YX1NDVQ0KKwloZWxwDQorCSAgVGhp
cyBpcyBhIGRyaXZlciBmb3IgdGhlIFNDVSBPbi1DaGlwIE9UUCBDb250cm9sbGVyIChPQ09UUCkN
CisJICBhdmFpbGFibGUgb24gaS5NWDggU29Dcy4NCisNCiBjb25maWcgTlZNRU1fTFBDMThYWF9F
RVBST00NCiAJdHJpc3RhdGUgIk5YUCBMUEMxOFhYIEVFUFJPTSBNZW1vcnkgU3VwcG9ydCINCiAJ
ZGVwZW5kcyBvbiBBUkNIX0xQQzE4WFggfHwgQ09NUElMRV9URVNUDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lbS9NYWtlZmlsZSBiL2RyaXZlcnMvbnZtZW0vTWFrZWZpbGUNCmluZGV4IDJlY2U4
ZmZmZmRkYS4uMzBkNjUzZDM0ZTU3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lbS9NYWtlZmls
ZQ0KKysrIGIvZHJpdmVycy9udm1lbS9NYWtlZmlsZQ0KQEAgLTEzLDYgKzEzLDggQEAgb2JqLSQo
Q09ORklHX05WTUVNX0lNWF9JSU0pCSs9IG52bWVtLWlteC1paW0ubw0KIG52bWVtLWlteC1paW0t
eQkJCTo9IGlteC1paW0ubw0KIG9iai0kKENPTkZJR19OVk1FTV9JTVhfT0NPVFApCSs9IG52bWVt
LWlteC1vY290cC5vDQogbnZtZW0taW14LW9jb3RwLXkJCTo9IGlteC1vY290cC5vDQorb2JqLSQo
Q09ORklHX05WTUVNX0lNWF9PQ09UUF9TQ1UpCSs9IG52bWVtLWlteC1vY290cC1zY3Uubw0KK252
bWVtLWlteC1vY290cC1zY3UteQkJOj0gaW14LW9jb3RwLXNjdS5vDQogb2JqLSQoQ09ORklHX05W
TUVNX0xQQzE4WFhfRUVQUk9NKQkrPSBudm1lbV9scGMxOHh4X2VlcHJvbS5vDQogbnZtZW1fbHBj
MTh4eF9lZXByb20teQk6PSBscGMxOHh4X2VlcHJvbS5vDQogb2JqLSQoQ09ORklHX05WTUVNX0xQ
QzE4WFhfT1RQKQkrPSBudm1lbV9scGMxOHh4X290cC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lbS9pbXgtb2NvdHAtc2N1LmMgYi9kcml2ZXJzL252bWVtL2lteC1vY290cC1zY3UuYw0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uZDlkYzQ4MmVjYjJmDQotLS0g
L2Rldi9udWxsDQorKysgYi9kcml2ZXJzL252bWVtL2lteC1vY290cC1zY3UuYw0KQEAgLTAsMCAr
MSwxNjEgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCisvKg0KKyAq
IGkuTVg4IE9DT1RQIGZ1c2Vib3ggZHJpdmVyDQorICoNCisgKiBDb3B5cmlnaHQgMjAxOSBOWFAN
CisgKg0KKyAqIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KKyAqLw0KKw0KKyNpbmNsdWRl
IDxsaW51eC9maXJtd2FyZS9pbXgvc2NpLmg+DQorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
KyNpbmNsdWRlIDxsaW51eC9udm1lbS1wcm92aWRlci5oPg0KKyNpbmNsdWRlIDxsaW51eC9vZl9k
ZXZpY2UuaD4NCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4NCisNCitlbnVtIG9jb3RwX2RldnR5cGUgew0KKwlJTVg4UVhQLA0KK307
DQorDQorc3RydWN0IG9jb3RwX2RldnR5cGVfZGF0YSB7DQorCWludCBkZXZ0eXBlOw0KKwlpbnQg
bnJlZ3M7DQorfTsNCisNCitzdHJ1Y3Qgb2NvdHBfcHJpdiB7DQorCXN0cnVjdCBkZXZpY2UgKmRl
djsNCisJY29uc3Qgc3RydWN0IG9jb3RwX2RldnR5cGVfZGF0YSAqZGF0YTsNCisJc3RydWN0IGlt
eF9zY19pcGMgKm52bWVtX2lwYzsNCit9Ow0KKw0KK3N0cnVjdCBpbXhfc2NfbXNnX21pc2NfZnVz
ZV9yZWFkIHsNCisJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCisJdTMyIHdvcmQ7DQorfSBf
X3BhY2tlZDsNCisNCitzdGF0aWMgc3RydWN0IG9jb3RwX2RldnR5cGVfZGF0YSBpbXg4cXhwX2Rh
dGEgPSB7DQorCS5kZXZ0eXBlID0gSU1YOFFYUCwNCisJLm5yZWdzID0gODAwLA0KK307DQorDQor
c3RhdGljIGludCBpbXhfc2NfbWlzY19vdHBfZnVzZV9yZWFkKHN0cnVjdCBpbXhfc2NfaXBjICpp
cGMsIHUzMiB3b3JkLA0KKwkJCQkgICAgIHUzMiAqdmFsKQ0KK3sNCisJc3RydWN0IGlteF9zY19t
c2dfbWlzY19mdXNlX3JlYWQgbXNnOw0KKwlzdHJ1Y3QgaW14X3NjX3JwY19tc2cgKmhkciA9ICZt
c2cuaGRyOw0KKwlpbnQgcmV0Ow0KKw0KKwloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsN
CisJaGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDOw0KKwloZHItPmZ1bmMgPSBJTVhfU0Nf
TUlTQ19GVU5DX09UUF9GVVNFX1JFQUQ7DQorCWhkci0+c2l6ZSA9IDI7DQorDQorCW1zZy53b3Jk
ID0gd29yZDsNCisNCisJcmV0ID0gaW14X3NjdV9jYWxsX3JwYyhpcGMsICZtc2csIHRydWUpOw0K
KwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJKnZhbCA9IG1zZy53b3JkOw0KKw0KKwly
ZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGludCBpbXhfc2N1X29jb3RwX3JlYWQodm9pZCAqY29u
dGV4dCwgdW5zaWduZWQgaW50IG9mZnNldCwNCisJCQkgICAgICB2b2lkICp2YWwsIHNpemVfdCBi
eXRlcykNCit7DQorCXN0cnVjdCBvY290cF9wcml2ICpwcml2ID0gY29udGV4dDsNCisJdTMyIGNv
dW50LCBpbmRleCwgbnVtX2J5dGVzOw0KKwl1MzIgKmJ1ZjsNCisJdm9pZCAqcDsNCisJaW50IGks
IHJldDsNCisNCisJaW5kZXggPSBvZmZzZXQgPj4gMjsNCisJbnVtX2J5dGVzID0gcm91bmRfdXAo
KG9mZnNldCAlIDQpICsgYnl0ZXMsIDQpOw0KKwljb3VudCA9IG51bV9ieXRlcyA+PiAyOw0KKw0K
KwlpZiAoY291bnQgPiAocHJpdi0+ZGF0YS0+bnJlZ3MgLSBpbmRleCkpDQorCQljb3VudCA9IHBy
aXYtPmRhdGEtPm5yZWdzIC0gaW5kZXg7DQorDQorCXAgPSBremFsbG9jKG51bV9ieXRlcywgR0ZQ
X0tFUk5FTCk7DQorCWlmICghcCkNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlidWYgPSBwOw0K
Kw0KKwlmb3IgKGkgPSBpbmRleDsgaSA8IChpbmRleCArIGNvdW50KTsgaSsrKSB7DQorCQlpZiAo
cHJpdi0+ZGF0YS0+ZGV2dHlwZSA9PSBJTVg4UVhQKSB7DQorCQkJaWYgKChpID4gMjcxKSAmJiAo
aSA8IDU0NCkpIHsNCisJCQkJKmJ1ZisrID0gMDsNCisJCQkJY29udGludWU7DQorCQkJfQ0KKwkJ
fQ0KKw0KKwkJcmV0ID0gaW14X3NjX21pc2Nfb3RwX2Z1c2VfcmVhZChwcml2LT5udm1lbV9pcGMs
IGksIGJ1Zik7DQorCQlpZiAocmV0KSB7DQorCQkJa2ZyZWUocCk7DQorCQkJcmV0dXJuIHJldDsN
CisJCX0NCisJCWJ1ZisrOw0KKwl9DQorDQorCW1lbWNweSh2YWwsICh1OCAqKXAgKyBvZmZzZXQg
JSA0LCBieXRlcyk7DQorDQorCWtmcmVlKHApOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3Rh
dGljIHN0cnVjdCBudm1lbV9jb25maWcgaW14X3NjdV9vY290cF9udm1lbV9jb25maWcgPSB7DQor
CS5uYW1lID0gImlteC1zY3Utb2NvdHAiLA0KKwkucmVhZF9vbmx5ID0gdHJ1ZSwNCisJLndvcmRf
c2l6ZSA9IDQsDQorCS5zdHJpZGUgPSAxLA0KKwkub3duZXIgPSBUSElTX01PRFVMRSwNCisJLnJl
Z19yZWFkID0gaW14X3NjdV9vY290cF9yZWFkLA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgaW14X3NjdV9vY290cF9kdF9pZHNbXSA9IHsNCisJeyAuY29tcGF0aWJs
ZSA9ICJmc2wsaW14OHF4cC1zY3Utb2NvdHAiLCAodm9pZCAqKSZpbXg4cXhwX2RhdGEgfSwNCisJ
eyB9LA0KK307DQorTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14X3NjdV9vY290cF9kdF9pZHMp
Ow0KKw0KK3N0YXRpYyBpbnQgaW14X3NjdV9vY290cF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KK3sNCisJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCisJc3Ry
dWN0IG9jb3RwX3ByaXYgKnByaXY7DQorCXN0cnVjdCBudm1lbV9kZXZpY2UgKm52bWVtOw0KKwlp
bnQgcmV0Ow0KKw0KKwlwcml2ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQ
X0tFUk5FTCk7DQorCWlmICghcHJpdikNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlyZXQgPSBp
bXhfc2N1X2dldF9oYW5kbGUoJnByaXYtPm52bWVtX2lwYyk7DQorCWlmIChyZXQpDQorCQlyZXR1
cm4gcmV0Ow0KKw0KKwlwcml2LT5kYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7
DQorCXByaXYtPmRldiA9IGRldjsNCisJaW14X3NjdV9vY290cF9udm1lbV9jb25maWcuc2l6ZSA9
IDQgKiBwcml2LT5kYXRhLT5ucmVnczsNCisJaW14X3NjdV9vY290cF9udm1lbV9jb25maWcuZGV2
ID0gZGV2Ow0KKwlpbXhfc2N1X29jb3RwX252bWVtX2NvbmZpZy5wcml2ID0gcHJpdjsNCisJbnZt
ZW0gPSBkZXZtX252bWVtX3JlZ2lzdGVyKGRldiwgJmlteF9zY3Vfb2NvdHBfbnZtZW1fY29uZmln
KTsNCisNCisJcmV0dXJuIFBUUl9FUlJfT1JfWkVSTyhudm1lbSk7DQorfQ0KKw0KK3N0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGlteF9zY3Vfb2NvdHBfZHJpdmVyID0gew0KKwkucHJvYmUJ
PSBpbXhfc2N1X29jb3RwX3Byb2JlLA0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUJPSAiaW14X3Nj
dV9vY290cCIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBpbXhfc2N1X29jb3RwX2R0X2lkcywNCisJ
fSwNCit9Ow0KK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoaW14X3NjdV9vY290cF9kcml2ZXIpOw0K
Kw0KK01PRFVMRV9BVVRIT1IoIlBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiIpOw0KK01PRFVM
RV9ERVNDUklQVElPTigiaS5NWDggU0NVIE9DT1RQIGZ1c2UgYm94IGRyaXZlciIpOw0KK01PRFVM
RV9MSUNFTlNFKCJHUEwgdjIiKTsNCi0tIA0KMi4xNi40DQoNCg==
