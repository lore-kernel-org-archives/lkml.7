Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66803C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD4F206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RIJzntA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfG3KCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:02:51 -0400
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:36690
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfG3KCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:02:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbHN//t56AxjfTW4upRlFlbVASd4GLX8+Z76kv+0ErK67KemBmDr7b1Dd7ctfjxY4SIhY1bKb17qPcnVxfAaRdGNoQPdqqM0USu6dUpREcAA6foEVQdUjB7mVVbj2zhGry6BOsdx8ysHzM5LwzTs2Aa+ZjXzd4WOgzRwYEG/5rbN06neg9I8vpcnJD3ycxI7wAY6JYqx8ig1chgUQWtBg04cUWWHHRaJY2fJAxCXGqh3/A0NFTOH5YemO01TmiXNdyN+ngMKHnFrkCSDnpdGHh1bu6LXTZxF2ZYI9oW3eim2XR7NizJ+W0Zw+v3R00mnzG2F89kwcUKKLbxkEEuJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTLcj16svmN12PC6axhQenoxHGPtvYkqcxJnn2qQ/b0=;
 b=X0BVR9Rg/fJXnBXWbt5xmy6+AZojgOFF5UbDNyTMI5a/A5eNw/+LqOx2dVzk/C413j6nLzaKvQDeU+EKnI0eDt3Y+cceD/7cEOC1jplAcnKTAw5xq7ZYu1rnDioFY/uYJI38DKwwrt7RvwbeWZ9s2jRyjJOuxYafD50ODopAoP05F2Oxu1KXKn48gwHiKnSNrd769OU3b2fLut1UYsB2vtuptdWeACdiBqvtZaaPosFAk3Kz8EzL1MYGWgcY9BfA7fddJuHl/AEwmlYEnXbqaGt1caJJNYlcFLAbnie4cIt6cr0NYWrCNxgfccbbH+6UiNGWLR2S19rhscABM8LEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTLcj16svmN12PC6axhQenoxHGPtvYkqcxJnn2qQ/b0=;
 b=RIJzntA93nXE8ekKrzx24F8j9sTY5LPquLI6uG8glAV3ggIRUBGu2Vq9/InPUE4WeQXzUAxVHOyeOy5KOAjMRl7aWumV7IWgD30TLtSziccVMi712yKAAbdrJ/rZvSYU254R7PzO1Vy+kUaffa1r4tsps/4vYPyNtq+yaxaap10=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Tue, 30 Jul 2019 10:02:44 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::71e8:4224:fefb:596f]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::71e8:4224:fefb:596f%7]) with mapi id 15.20.2094.017; Tue, 30 Jul 2019
 10:02:44 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH v3] arm64: dts: ls1028a: Add esdhc node in dts
Thread-Topic: [PATCH v3] arm64: dts: ls1028a: Add esdhc node in dts
Thread-Index: AQHVCvrdHrRlATyZO0OFUe73KN44yqbjZQxQ
Date:   Tue, 30 Jul 2019 10:02:44 +0000
Message-ID: <VI1PR04MB4158BFD0D6C44BB6817E1483E9DC0@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190515084925.30155-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190515084925.30155-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f23bcd8-6b34-494c-f708-08d714d5110f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5134;
x-ms-traffictypediagnostic: VI1PR04MB5134:
x-microsoft-antispam-prvs: <VI1PR04MB5134B29DDEFF98CA449AEF6DE9DC0@VI1PR04MB5134.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(13464003)(86362001)(6116002)(486006)(66066001)(14444005)(3846002)(25786009)(256004)(68736007)(52536014)(229853002)(6246003)(6436002)(44832011)(305945005)(7736002)(4326008)(5660300002)(71190400001)(446003)(74316002)(66446008)(9686003)(99286004)(14454004)(64756008)(66946007)(8676002)(81166006)(7696005)(316002)(478600001)(81156014)(8936002)(102836004)(186003)(11346002)(54906003)(26005)(66476007)(66556008)(110136005)(33656002)(71200400001)(2906002)(476003)(76116006)(53546011)(6506007)(55016002)(76176011)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5134;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TRTZOIEaC4uDwMlRnsZhJt0H4g0emENNzgjEQfb7WJHyFzDQr2TF35GHQ+EK53DZLrwGialCHlDkT8k6SDLVUfmzsufMFz8W1zi+xAVGfOjGhBj3KsVIhHjq6YBryesor41Pg6i/YK1dtZQ3hY7wWn8389fzas0Pk9giBwSIzGOaKsbZxajcur71BPgh7Qb5yb+mC2AzgK+GfemuTroryNW/5bNDc2pNnh4vvps2d2LvX2FLSbLWDQG9IxCFIwyq1Si274pPW5L4P8EJlvHqzwc4jedNEB2x6n+Mx63syt+Vwk3OoCT9Lzky0Bd+GbQhP7FjUuEvfhT0V7iLzinPoTzS0h2ZcBI9SC7L0msudaEANQmpDY9DPSGerNO7plp7ZLU0vTiOJ9h0GciZOotFUEweliaW11k/DgHqCPQfOk8=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f23bcd8-6b34-494c-f708-08d714d5110f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 10:02:44.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yinbo.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQpJIGp1c3QgY2hlY2sgbW1jIHVwc3RyZWFtIGNvZGUsIHRoYXQgcGF0Y2ggc3RpbGwg
bm90IHVwc3RyZWFtLg0KUGxlYXNlIGhlbHAgbWVyZ2UgaXQgdG8gdXBzdHJlYW0gdHJlZS4NCg0K
VGhhbmtzDQpSZWdhcmRzLA0KWWluYm8gWmh1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogWWluYm8gWmh1IFttYWlsdG86eWluYm8uemh1QG54cC5jb21dDQo+IFNlbnQ6
IDIwMTnE6jXUwjE1yNUgMTY6NDkNCj4gVG86IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9y
Zz47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgUm9iDQo+IEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz4NCj4gQ2M6IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+OyBYaWFvYm8g
WGllIDx4aWFvYm8ueGllQG54cC5jb20+OyBNYXJrDQo+IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBh
cm0uY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgtbW1jQHZnZXIua2VybmVsLm9yZzsgWS5iLiBMdSA8eWFuZ2JvLmx1QG54cC5jb20+OyBKaWFm
ZWkgUGFuDQo+IDxqaWFmZWkucGFuQG54cC5jb20+OyBBc2hpc2ggS3VtYXIgPGFzaGlzaC5rdW1h
ckBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjNdIGFybTY0OiBkdHM6IGxzMTAyOGE6IEFk
ZCBlc2RoYyBub2RlIGluIGR0cw0KPiANCj4gRnJvbTogQXNoaXNoIEt1bWFyIDxBc2hpc2guS3Vt
YXJAbnhwLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgdG8gYWRkIGVzZGhjIG5vZGUgYW5kIGVu
YWJsZSBTRCBVSFMtSSwgZU1NQyBIUzIwMCBmb3INCj4gbHMxMDI4YXJkYi9sczEwMjhhcWRzIGJv
YXJkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXNoaXNoIEt1bWFyIDxBc2hpc2guS3VtYXJAbnhw
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWFuZ2JvIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCj4gLS0tDQo+IENo
YW5nZSBpbiB2MzoNCj4gCQlyZXBsYWNlICJlc2RoY0AiIHdpdGggIm1tY0AiDQo+IA0KPiAgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0cyB8ICAgIDggKysr
KysrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRz
IHwgICAxMyArKysrKysrKysrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDI4YS5kdHNpICAgIHwgICAyNw0KPiArKysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmls
ZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRz
DQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0cw0K
PiBpbmRleCAxNGM3OWY0Li4xODBlNWQyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gQEAgLTQyLDYgKzQyLDE0IEBA
DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gDQo+ICsmZXNkaGMgew0KPiArCXN0YXR1
cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZlc2RoYzEgew0KPiArCXN0YXR1cyA9ICJva2F5
IjsNCj4gK307DQo+ICsNCj4gICZpMmMwIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRi
LmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5k
dHMNCj4gaW5kZXggZjg2YjA1NC4uMWJmYWY0MiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KPiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQo+IEBAIC0zMCw2ICszMCwx
OSBAQA0KPiAgCX07DQo+ICB9Ow0KPiANCj4gKyZlc2RoYyB7DQo+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPiArCXNkLXVocy1zZHIxMDQ7DQo+ICsJc2QtdWhzLXNkcjUwOw0KPiArCXNkLXVocy1zZHIy
NTsNCj4gKwlzZC11aHMtc2RyMTI7DQo+ICsJfTsNCj4gKw0KPiArJmVzZGhjMSB7DQo+ICsJc3Rh
dHVzID0gIm9rYXkiOw0KPiArCW1tYy1oczIwMC0xXzh2Ow0KPiArCX07DQo+ICsNCj4gICZpMmMw
IHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gaW5kZXggMjg5NmJiYy4uNDYyODMzYyAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEu
ZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5k
dHNpDQo+IEBAIC0yNzQsNiArMjc0LDMzIEBADQo+ICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiAgCQl9Ow0KPiANCj4gKwkJZXNkaGM6IG1tY0AyMTQwMDAwIHsNCj4gKwkJCWNvbXBhdGlibGUg
PSAiZnNsLGxzMTAyOGEtZXNkaGMiLCAiZnNsLGVzZGhjIjsNCj4gKwkJCXJlZyA9IDwweDAgMHgy
MTQwMDAwIDB4MCAweDEwMDAwPjsNCj4gKwkJCWludGVycnVwdHMgPSA8MCAyOCAweDQ+OyAvKiBM
ZXZlbCBoaWdoIHR5cGUgKi8NCj4gKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsgLyogZml4ZWQg
dXAgYnkgYm9vdGxvYWRlciAqLw0KPiArCQkJY2xvY2tzID0gPCZjbG9ja2dlbiAyIDE+Ow0KPiAr
CQkJdm9sdGFnZS1yYW5nZXMgPSA8MTgwMCAxODAwIDMzMDAgMzMwMD47DQo+ICsJCQlzZGhjaSxh
dXRvLWNtZDEyOw0KPiArCQkJbGl0dGxlLWVuZGlhbjsNCj4gKwkJCWJ1cy13aWR0aCA9IDw0PjsN
Cj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJCX07DQo+ICsNCj4gKwkJZXNkaGMxOiBt
bWNAMjE1MDAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxsczEwMjhhLWVzZGhjIiwgImZz
bCxlc2RoYyI7DQo+ICsJCQlyZWcgPSA8MHgwIDB4MjE1MDAwMCAweDAgMHgxMDAwMD47DQo+ICsJ
CQlpbnRlcnJ1cHRzID0gPDAgNjMgMHg0PjsgLyogTGV2ZWwgaGlnaCB0eXBlICovDQo+ICsJCQlj
bG9jay1mcmVxdWVuY3kgPSA8MD47IC8qIGZpeGVkIHVwIGJ5IGJvb3Rsb2FkZXIgKi8NCj4gKwkJ
CWNsb2NrcyA9IDwmY2xvY2tnZW4gMiAxPjsNCj4gKwkJCXZvbHRhZ2UtcmFuZ2VzID0gPDE4MDAg
MTgwMCAzMzAwIDMzMDA+Ow0KPiArCQkJc2RoY2ksYXV0by1jbWQxMjsNCj4gKwkJCWJyb2tlbi1j
ZDsNCj4gKwkJCWxpdHRsZS1lbmRpYW47DQo+ICsJCQlidXMtd2lkdGggPSA8ND47DQo+ICsJCQlz
dGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQl9Ow0KPiArDQo+ICAJCXNhdGE6IHNhdGFAMzIwMDAw
MCB7DQo+ICAJCQljb21wYXRpYmxlID0gImZzbCxsczEwMjhhLWFoY2kiOw0KPiAgCQkJcmVnID0g
PDB4MCAweDMyMDAwMDAgMHgwIDB4MTAwMDA+LA0KPiAtLQ0KPiAxLjcuMQ0KDQo=
