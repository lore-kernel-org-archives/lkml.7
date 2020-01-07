Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15135C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AB4207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ELcm+RwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGIb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:31:58 -0500
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:28360
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgAGIb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:31:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEo3OKRvo4RuthXlYHBOBZUoSsEOqJFmoOWI4MYa399YFnUbI0mz/RfNSzZHj0tRg8SlFENKpPy6dQ+JGISincrNsi9mJHzJsi6mqxs8KopGk9VqCkaEfUGlDyNL9zWFoC6nq2i/ZHNcfGHGnYq1zA9z9It1lt6h9y1WGQ7jVsSPlqe1NufyBvduPFvph26bqMP7/jPuXzy5i5JBFrCeSmDYz+9NEMnQlQV7iU18RntcyzNIWly8PvF7asUYqgj+CVMiuTJ9rc9m2XZR/qigWUdHCF0n7FhdtldZy69/5XXQkY/HlpUeexgULtf5EMa/+BSYqe0/fKDl4yOaeiIclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoYesY8cbHtBv0CDkJZmgycuW0WcBanZcHwPBkMW8Oc=;
 b=RK+tpUIz6KusYM81oG1SbYd5f61WQzvD66FIz4h/P0ScQg1+blOgq4oiCTGdEqXdO+Xgf3Uu9OUijbAAiCNYGL1cFPgaJrJl4KtS8/rzbj/Ec0F8PvxTvA3rVjxSK++hEWXakCac4lK8+5T4TGUtYyVWHkzDLD3hn93FeaP7NFCTeiBJgQqPvvFAfql6I0lsDv4sYuLPB+MPIlRz0rQDz6nJdePA4jHWqRC58eQkhT71kaksm/PaRkBF3w2KgKYCA2o0Ki0iSV8vRsVl2Mwe0Aos9tW4mUi60c9OYgGDAuIGHmGmCk8UFF+nW+uXGJ4k2Z+0MCdmNXO+JNBFdJc9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoYesY8cbHtBv0CDkJZmgycuW0WcBanZcHwPBkMW8Oc=;
 b=ELcm+RwLX6eJrQi93W9UIJCqDH8Kexui1g3zp3LGnQLCAMVkjEHafVVC3oI/rTnieJM+5oFLngD/FfLidPRJw7/EWYWuV1QEsh5AmzCLjPwvH1uru1gPAVGHYf7JaElB1sL+jOyLSb92VXufqeLGe8PL8mH5vfD4smjMgQRjSVU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 08:31:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f%7]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 08:31:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>, Jacky Bai <ping.bai@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will@kernel.org" <will@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] clk: imx: Add support for i.MX8MP clock driver
Thread-Topic: [PATCH 2/3] clk: imx: Add support for i.MX8MP clock driver
Thread-Index: AQHVvFuWiN3d+7pKeE+rF1Aj40+sqqfdAdWAgABZqkCAAZTXsA==
Date:   Tue, 7 Jan 2020 08:31:12 +0000
Message-ID: <DB3PR0402MB391625E9E0C5078C64DAA523F53F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1577412748-28213-1-git-send-email-Anson.Huang@nxp.com>
 <1577412748-28213-2-git-send-email-Anson.Huang@nxp.com>
 <20200106025914.A180E206F0@mail.kernel.org>
 <DB3PR0402MB39164DCE1E5A819A5A614E86F53C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39164DCE1E5A819A5A614E86F53C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c372a9b-7275-4dbe-a461-08d7934bf478
x-ms-traffictypediagnostic: DB3PR0402MB3899:|DB3PR0402MB3899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3899DE45153874971FA78443F53F0@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(44832011)(7416002)(186003)(6506007)(5660300002)(7696005)(2906002)(26005)(52536014)(71200400001)(33656002)(8676002)(4326008)(478600001)(81156014)(81166006)(110136005)(86362001)(316002)(66476007)(66556008)(8936002)(9686003)(64756008)(66946007)(76116006)(66446008)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NsSk5t0DN8y+iksHCRlfyrVw6bYV5uyMJ14KmMU2CDcHlorWA13dSA3oOBrzz00qfJEE8SCPCKgcBP9LsqS5xQ7iGWwK2hzTFhEurN5gdAkNDGW1aN4Nfo5NqgSi45LnNvEUJjlnSzg3UpMtexDlOLqITivz2MKZLRlXnowo6hH/WiPqeFNC05Lk+N20IM9WDVkqcg05Iv+T7+3FnvK5lsz54wEj7Q+lmBMU6Q9k/AXy7em0Mih14CPJun4K/tScCX9liYQUNSshgF4QYun82BYCnq+mv76cJfIy8XRKnWscEmRxTDSC0fVhbwOEO1sKL7oyLn7INja+xmrKwQNH/KoriemD1DkvIg+v3TfvLSdvke4ebWX7C1LlDBEwy2nxGIK8T37UR0N1F6OcE0/qzvkaByMHHv2QhKGec7QtC5CgA/LbIpi8KFOFd34YVy8EQLO5hiot9NzC+a0PjC1abQeQoHx9e5wSiR38MTJ+9eFDuH92Y76pUyb5m6Ew/gZG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c372a9b-7275-4dbe-a461-08d7934bf478
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 08:31:12.8282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEBv6hhrOoIEVnQrdmIJMz82KCNkzfQpyu2mzoGSU34PRQG16pyRj9nNeYs0rWyxka4AOiZe+09hXbE3GZc0lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiA+ID4gKyAgICAgICBjbGtzW0lNWDhNUF9BVURJT19QTEwxX09VVF0g
PSBpbXhfY2xrX2dhdGUoImF1ZGlvX3BsbDFfb3V0IiwNCj4gPiAiYXVkaW9fcGxsMV9ieXBhc3Mi
LCBiYXNlLCAxMyk7DQo+ID4gPiArICAgICAgIGNsa3NbSU1YOE1QX0FVRElPX1BMTDJfT1VUXSA9
IGlteF9jbGtfZ2F0ZSgiYXVkaW9fcGxsMl9vdXQiLA0KPiA+ICJhdWRpb19wbGwyX2J5cGFzcyIs
IGJhc2UgKyAweDE0LCAxMyk7DQo+ID4gPiArICAgICAgIGNsa3NbSU1YOE1QX1ZJREVPX1BMTDFf
T1VUXSA9IGlteF9jbGtfZ2F0ZSgidmlkZW9fcGxsMV9vdXQiLA0KPiA+ICJ2aWRlb19wbGwxX2J5
cGFzcyIsIGJhc2UgKyAweDI4LCAxMyk7DQo+ID4gPiArICAgICAgIGNsa3NbSU1YOE1QX0RSQU1f
UExMX09VVF0gPSBpbXhfY2xrX2dhdGUoImRyYW1fcGxsX291dCIsDQo+ID4gImRyYW1fcGxsX2J5
cGFzcyIsIGJhc2UgKyAweDUwLCAxMyk7DQo+ID4gPiArICAgICAgIGNsa3NbSU1YOE1QX0dQVV9Q
TExfT1VUXSA9IGlteF9jbGtfZ2F0ZSgiZ3B1X3BsbF9vdXQiLA0KPiA+ICJncHVfcGxsX2J5cGFz
cyIsIGJhc2UgKyAweDY0LCAxMSk7DQo+ID4gPiArICAgICAgIGNsa3NbSU1YOE1QX1ZQVV9QTExf
T1VUXSA9IGlteF9jbGtfZ2F0ZSgidnB1X3BsbF9vdXQiLA0KPiA+ICJ2cHVfcGxsX2J5cGFzcyIs
IGJhc2UgKyAweDc0LCAxMSk7DQo+ID4gPiArICAgICAgIGNsa3NbSU1YOE1QX0FSTV9QTExfT1VU
XSA9IGlteF9jbGtfZ2F0ZSgiYXJtX3BsbF9vdXQiLA0KPiA+ICJhcm1fcGxsX2J5cGFzcyIsIGJh
c2UgKyAweDg0LCAxMSk7DQo+ID4gPiArICAgICAgIGNsa3NbSU1YOE1QX1NZU19QTEwxX09VVF0g
PSBpbXhfY2xrX2dhdGUoInN5c19wbGwxX291dCIsDQo+ID4gInN5c19wbGwxX2J5cGFzcyIsIGJh
c2UgKyAweDk0LCAxMSk7DQo+ID4gPiArICAgICAgIGNsa3NbSU1YOE1QX1NZU19QTEwyX09VVF0g
PSBpbXhfY2xrX2dhdGUoInN5c19wbGwyX291dCIsDQo+ID4gInN5c19wbGwyX2J5cGFzcyIsIGJh
c2UgKyAweDEwNCwgMTEpOw0KPiA+ID4gKyAgICAgICBjbGtzW0lNWDhNUF9TWVNfUExMM19PVVRd
ID0gaW14X2Nsa19nYXRlKCJzeXNfcGxsM19vdXQiLA0KPiA+ID4gKyAic3lzX3BsbDNfYnlwYXNz
IiwgYmFzZSArIDB4MTE0LCAxMSk7DQo+ID4NCj4gPiBBbnkgcmVhc29uIHdoeSB3ZSBjYW4ndCBn
ZXQgYmFjayBjbGtfaHcgcG9pbnRlcnMgaW5zdGVhZCBhbmQgcmVnaXN0ZXINCj4gPiBhIGh3IGJh
c2VkIHByb3ZpZGVyPw0KPiANCj4gQmVjYXVzZSBpLk1YOE0gc2VyaWVzIFNvQ3MgYXJlIHN0aWxs
IE5PVCB1c2luZyBodyBiYXNlZCBjbG9jaw0KPiBpbXBsZW1lbnRhdGlvbiwgc29tZSBvZiB0aGUg
QVBJcyBhcmUgc2hhcmVkLCBsaWtlIGlteF9jbGtfcGxsMTR4eCgpIGFuZA0KPiBpbXg4bV9jbGtf
Y29tcG9zaXRlKCkgZXRjLiwgc28gSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8ga2VlcA0KPiB0aGVt
KGkuTVg4TVEvaS5NWDhNTS9pLk1YOE1OL2kuTVg4TVApIGFsaWduZWQsIGFuZCBJIHdpbGwgZmlu
ZCBhDQo+IGNoYW5jZSBzb29uIHRvIGRvIGEgcGF0Y2ggc2VyaWVzIHRvIHN3aXRjaCBhbGwgb2Yg
dGhlbSB0byBodyBiYXNlZCBjbG9jaywNCj4gZG9lcyBpdCBtYWtlIHNlbnNlIHRvIHlvdT8NCg0K
UGxlYXNlIGlnbm9yZSB0aGlzLCBJIHdpbGwgZG8gbmVjZXNzYXJ5IHBhdGNoZXMgdG9nZXRoZXIg
aW4gdGhpcyBzZXJpZXMgdG8gc3VwcG9ydA0KaHcgY2xrIGJhc2VkIHByb3ZpZGVyIGZvciBpLk1Y
OE0gU29DcywgaS5NWDhNUCB3aWxsIHVzZSBodyBiYXNlZCBwcm92aWRlciwNCmFuZCBvbGQgaS5N
WDhNIFNvQ3Mgd2lsbCBiZSBoYW5kbGVkIGxhdGVyIHdpdGggc2VwYXJhdGUgcGF0Y2guDQoNClRo
YW5rcywNCkFuc29uDQo=
