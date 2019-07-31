Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47852208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="CDAvYoMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfGaGna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:43:30 -0400
Received: from mail-eopbgr130132.outbound.protection.outlook.com ([40.107.13.132]:4772
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387431AbfGaGn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7nuKTtIB9TT8DDRbooj8Qye9Xg3WPEXidT/8m3DbsI4N1uNe07RVyP1S7Rt3yyWPOTYOT0I8Ji8jSVE5Vs0WAHPePRqBJPXr+l98eFczNDybDa9W4evm2fodcDzexrh8eskDZkvWqFcQL1PTCuUuzMYZD/Ty1dhmNlW/Ce2NTiD82NqRxkIij7utzpgopkVHgsEs//V1eU5Ue/nSohjyqnRteIxpAzverLhvvlWx2k+AVehrXHD8F0I8sDvkoAF7eAtKoo75RJTizZaF6/ltsTkbMDGeOTkhhfABLFfZnxxDY1Tg4AvvJiPC0OdiqxlWCJKfz9rtYNkuRadPg+yXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVpbjrT1LnDXpbDC2yTmY8tdStzlFWkzGvznfv0kQY0=;
 b=E8f30Bz0TkgJwyI9W6ES3eFyWEDH6c4x5Sat27pLA3JVQHBO/pEmxYLJfepFjewT9FEdUwftJFB+ceyyc2p621bG9cW6A4HRbvFD4uuEWYHWQuZHIbkjZrDSOp9wBafWmWLiM6kCENRve6ck4YAOa+86RFT58ErHFfhRPEot1XzYOH/TjNDAovy7/X6ZDlsWd17TD05GL3vVtFuWAgAzrpwCrOHN/+dLYT8p9F5riFubC2dBZ14Zt3jEtGyRxLV1zFuv+EFNzbIm8U3CVV7Yboq8QMkz2nhGBL2zj9GxshoGi4iFATWv3Yj7jY1+FfsJK0BFX/aH5LUENDHIcudL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVpbjrT1LnDXpbDC2yTmY8tdStzlFWkzGvznfv0kQY0=;
 b=CDAvYoMpe+OMp8abgLmB9LYg05sD2P1N2F2T/GRD1TCK6EfLQZ8aLPCOFnWiPs7ooGhooadAZNL2PwRcybGpH7U0d8tSMUQD8ntRcw/Kql51AA5FM/2OCHuhdno3smybV3Mdzw8wAV/00cjnmJFqsRY4VMt3S7bq1mIumvXjVfw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2927.eurprd05.prod.outlook.com (10.175.20.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 06:43:24 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 06:43:24 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH 12/22] ARM: dts: imx6: Add touchscreens used on Toradex
 eval boards
Thread-Topic: [PATCH 12/22] ARM: dts: imx6: Add touchscreens used on Toradex
 eval boards
Thread-Index: AQHVRucqGTC4xSC72EKF/Chxy8fH4abjoekAgACmx4A=
Date:   Wed, 31 Jul 2019 06:43:24 +0000
Message-ID: <60760aa2d4710252e13877c409d0c4d2267824a6.camel@toradex.com>
References: <20190730144649.19022-1-dev@pschenker.ch>
         <20190730144649.19022-13-dev@pschenker.ch>
         <CAOMZO5DRi6yawn3RF-Mouiejz0nc7htdsCjOBC_EXZZKUZ3nvA@mail.gmail.com>
In-Reply-To: <CAOMZO5DRi6yawn3RF-Mouiejz0nc7htdsCjOBC_EXZZKUZ3nvA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b46b4810-f29b-4fa9-660c-08d7158262c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2927;
x-ms-traffictypediagnostic: VI1PR0502MB2927:
x-microsoft-antispam-prvs: <VI1PR0502MB2927D1BF5EE61F325364D376F4DF0@VI1PR0502MB2927.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39840400004)(376002)(136003)(346002)(189003)(199004)(2351001)(7736002)(71200400001)(71190400001)(478600001)(256004)(486006)(14444005)(54906003)(2616005)(476003)(44832011)(36756003)(76116006)(118296001)(14454004)(316002)(86362001)(91956017)(66476007)(66946007)(66556008)(66446008)(64756008)(1411001)(6246003)(5660300002)(76176011)(99286004)(186003)(53546011)(6916009)(26005)(2906002)(81166006)(3846002)(4326008)(25786009)(1361003)(6116002)(229853002)(6486002)(2501003)(66066001)(8936002)(6436002)(7416002)(6506007)(68736007)(6512007)(305945005)(102836004)(1730700003)(81156014)(11346002)(446003)(5640700003)(53936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2927;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QLnuOZ4j1Tklh3LUvLPYr1xwGIMKglErzKFRRp5ehZdTAQueIsh20j51CVeOc+Iy3ict/Pjbss59Vi3iYu7ep1jcolkv8e+RYA0BNik2ainyzZulm44bYiJCYZwdArFWpmRd33etG/4pk2dnvtVRGWfE5XFFVg6wiUT7kDRc7NLheL6JBHELFeFbRBZMIn7wD5w7JmjCgnMwnk6gDq4IpokDIiEk+1C9nqrWG89LgYtco6jfG1OMXOvAsT6s8bvBi8sRoiGmFSkO7bautPPjd9uBwHeVXkCzl4hGeCr/l+Z5QHn08YyUM7M+YfGlZIhtw9Vbwu5knnwlQ1DmsTbqLV1qHGQMPuXN+mZQDjYWA92Ql9dn/hJ/bGCvv6jmvGzjM7+1Ll5A/y1Jl0kTRVDFIS9mVA4voUk1txeTLapVGAU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C5CED9DF11A2343A65EE4D73A529649@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b4810-f29b-4fa9-660c-08d7158262c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 06:43:24.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2927
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA3LTMwIGF0IDE3OjQ2IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBPbiBUdWUsIEp1bCAzMCwgMjAxOSBhdCAxMTo1NyBBTSBQaGlsaXBwZSBTY2hlbmtlciA8ZGV2
QHBzY2hlbmtlci5jaD4gd3JvdGU6DQo+IA0KPiA+ICsgICAgICAgLyogQXRtZWwgbWF4dG91Y2gg
Y29udHJvbGxlciAqLw0KPiA+ICsgICAgICAgYXRtZWxfbXh0X3RzOiBhdG1lbF9teHRfdHNANGEg
ew0KPiANCj4gR2VuZXJpYyBub2RlIG5hbWVzLCBwbGVhc2U6DQo+IA0KPiB0b3VjaHNjcmVlbkA0
YQ0KPiANCj4gPiArICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxtYXh0b3VjaCI7
DQo+ID4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKyAg
ICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2FwXzE+Ow0KPiA+ICsgICAgICAg
ICAgICAgICByZWcgPSA8MHg0YT47DQo+ID4gKyAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJl
bnQgPSA8JmdwaW8xPjsNCj4gPiArICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDw5IElSUV9U
WVBFX0VER0VfRkFMTElORz47IC8qIFNPRElNTSAyOCAqLw0KPiA+ICsgICAgICAgICAgICAgICBy
ZXNldC1ncGlvcyA9IDwmZ3BpbzIgMTAgR1BJT19BQ1RJVkVfSElHSD47IC8qIFNPRElNTSAzMCAq
Lw0KPiA+ICsgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsgICAgICAg
fTsNCj4gPiArDQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogdGhlIFBDQVBzIHVzZSBT
T0RJTU0gMjgvMzAsIGFsc28gdXNlZCBmb3IgUFdNPEI+LCBQV008Qz4sIGFrYQ0KPiA+IHB3bTEs
DQo+ID4gKyAgICAgICAgKiBwd200LiBTbyBpZiB5b3UgZW5hYmxlIG9uZSBvZiB0aGUgUENBUCBj
b250cm9sbGVycyBkaXNhYmxlIHRoZQ0KPiA+IHB3bXMuDQo+ID4gKyAgICAgICAgKi8NCj4gPiAr
ICAgICAgIHBjYXA6IHBjYXBAMTAgew0KPiANCj4gdG91Y2hzY3JlZW5AMTANCj4gDQo+ID4gKyAg
ICAgICAgICAgICAgIC8qIFRvdWNoUmV2b2x1dGlvbiBGdXNpb24gNyBhbmQgMTAgbXVsdGktdG91
Y2ggY29udHJvbGxlciAqLw0KPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInRvdWNo
cmV2b2x1dGlvbixmdXNpb24tZjA3MTBhIjsNCj4gDQo+IEkgZG8gbm90IGZpbmQgdGhpcyBiaW5k
aW5nIGRvY3VtZW50ZWQuDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayBGYWJpbywgYW5kIHNv
cnJ5IHN1Y2ggb2J2aW91cyBzdHVmZiB3ZW50IHRocm91Z2guIEkNCndpbGwgZ28gdGhyb3VnaCBt
eSB3aG9sZSBwYXRjaHNldCBhZ2FpbiBtb3JlIGNhcmVmdWxseSBsb29rdXAgYWxsIHRoZSBiaW5k
aW5ncy4NCg0KUGhpbGlwcGUNCg==
