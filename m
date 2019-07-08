Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_DBL_URL_LINKBAIT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA66C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2C22086C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWeAkyPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfGHEse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:48:34 -0400
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:56035
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727313AbfGHEse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Q+9K+lpM+b3wJ+tAZjY9i66iD8WabYPEAqsv/gwIY=;
 b=cWeAkyPj3rnV2yP2qQxRRKJLj5cbhDUOm4Zumo6UBOK2LV0K44KXXzb48ZYBrzac+3LfWK3dEpRKcLg51Z+2VzftTZu2CuvbtlHBJK7DlBwQRhAL3ERIn5UqWcjSa0xPFeWB4uhCfmqvsSosab09bhSn94STOjjRMn3ZCnuS2B4=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6637.eurprd04.prod.outlook.com (20.179.235.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Mon, 8 Jul 2019 04:48:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 04:48:30 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     zhangfei <zhangfei.gao@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vinod Koul <vkoul@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: RE: linux-next: build failure after merge of the slave-dma tree
Thread-Topic: linux-next: build failure after merge of the slave-dma tree
Thread-Index: AQHVMjqAoCw3ift/eE+RdAWMvGtRgabAD+XYgAAbC0A=
Date:   Mon, 8 Jul 2019 04:48:30 +0000
Message-ID: <VE1PR04MB6638E6DA13B445FF2AD8260689F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190704173108.0646eef8@canb.auug.org.au>
 <VE1PR04MB6638080C43EC68EFF9F7B38A89F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <58c9b815-9bfc-449c-6017-c6da582dffc5@linaro.org>
In-Reply-To: <58c9b815-9bfc-449c-6017-c6da582dffc5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bf5f0ca-ea1e-4c10-2914-08d7035f8629
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6637;
x-ms-traffictypediagnostic: VE1PR04MB6637:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VE1PR04MB6637326B80195C3089958D6589F60@VE1PR04MB6637.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(66066001)(81166006)(8936002)(68736007)(2906002)(8676002)(14454004)(6306002)(53936002)(55016002)(6246003)(9686003)(305945005)(966005)(478600001)(86362001)(7736002)(52536014)(73956011)(76116006)(66446008)(64756008)(66556008)(66476007)(256004)(45080400002)(71190400001)(74316002)(81156014)(6436002)(66946007)(11346002)(446003)(5660300002)(4326008)(3846002)(316002)(486006)(25786009)(6116002)(33656002)(476003)(110136005)(229853002)(54906003)(99286004)(71200400001)(26005)(102836004)(186003)(6506007)(53546011)(7696005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6637;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mPM2O0HCc7SHPWkBR8wsZhO3mGy0u4J3zEPjyEOi9immvXEnRO2/C3XPmLkCRsrQ4uMViQYy1OX7Q0LunnJjtBq1NTbPr6rbX1SwPAFTlXRZhySobAQG53z8CjOelG9qofU26f58C/0H98hq1cv+rkJ3jwdm0K8OTMRSbTiCy68x5CNEUJ3B3TmYI1T243Km3GWlxA0DD7vIUj3mqgF0f8ahmQRv49rIVdQ0JJ5oyRELXbZrsDWG/nob1EG/gtroTRjbCqYYYtBNBES2J4T7y2VHttB3XL4DyvH67TkI/a1rv8/bQ2cb+fxpFJyriUZrGi01dlw7WFECY2r/pL2m3RBeEJ/0RDftiYvnknSz1tkRlZfrA4Y9DRbz4tNZJsZ/9Tyz3MWf8FTxY/EMG3/DnLwnD1KrTUW0xavjOREXfZU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf5f0ca-ea1e-4c10-2914-08d7035f8629
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 04:48:30.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS83LzggMTE6MDYgQU0sIHpoYW5nZmVpIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4g
d3JvdGU6DQo+IEhpLCBSb2Jpbg0KPiANCj4gT24gMjAxOS83Lzgg5LiK5Y2IOToyMiwgUm9iaW4g
R29uZyB3cm90ZToNCj4gPiBIaSBTdGVwaGVuLA0KPiA+IAlUaGF0J3MgY2F1c2VkIGJ5ICdvZl9p
cnFfY291bnQnIE5PVCBleHBvcnQgdG8gZ2xvYmFsIHN5bWJvbCwgYW5kIEknbQ0KPiA+IGN1cmlv
dXMgd2h5IGl0IGhhcyBiZWVuIGhlcmUgZm9yIHNvIGxvbmcgc2luY2UgWmhhbmdmZWkgZm91bmQg
aXQgaW4NCj4gPiAyMDE1Lg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGMNCj4gPg0KPiBod29yay5rZXJuZWwu
b3JnJTJGcGF0Y2glMkY3NDA0NjgxJTJGJmFtcDtkYXRhPTAyJTdDMDElN0N5aWJpbi5nb24NCj4g
ZyU0MA0KPiA+DQo+IG54cC5jb20lN0M1OTE3ZTQxYmFiZTg0ZDU2MmQ0NzA4ZDcwMzUxNGVkOCU3
QzY4NmVhMWQzYmMyYjRjNmZhDQo+IDkyY2Q5OWM1DQo+ID4NCj4gYzMwMTYzNSU3QzAlN0MwJTdD
NjM2OTgxNTIwMDYwNDE3OTMwJmFtcDtzZGF0YT1Rd1BqaWZ4ZUNFSm1scmswDQo+IDJOZTcxQmIN
Cj4gPiBoU2dzWk5MTGd4N1BuTzgxTUhtQSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+IEhpIFJvYiwN
Cj4gPiAJSXMgdGhlcmUgc29tZXRoaW5nIEkgbWlzcyBzbyB0aGF0IFpoYW5nZmVpJ3MgcGF0Y2gg
bm90IGFjY2VwdGVkIGZpbmFsbHk/DQo+ID4NCj4gPg0KPiANCj4gSSByZW1lbWJlcmVkIFJvYiBz
dWdnZXN0ZWQgdXMgbm90IHVzaW5nIG9mX2lycV9jb3VudCBhbmQgdXNlDQo+IHBsYXRmb3JtX2dl
dF9pcnEgZXRjLg0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLm9yZw0KPiAlMkZsa21sJTJGMjAxNSUyRjExJTJG
MTglMkY0NjYmYW1wO2RhdGE9MDIlN0MwMSU3Q3lpYmluLmdvbmclNA0KPiAwbnhwLmNvbSU3QzU5
MTdlNDFiYWJlODRkNTYyZDQ3MDhkNzAzNTE0ZWQ4JTdDNjg2ZWExZDNiYzJiNGM2Zg0KPiBhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5ODE1MjAwNjA0MTc5MzAmYW1wO3NkYXRhPWcybU5C
DQo+IDMzJTJCYTA5SklwWG90NmowdyUyRlYzMGdyU1ZDdDFHeFpKQ0h5RWdpTSUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KPiANCj4gU28gd2UgcmVtb3ZlIG9mX2lycV9jb3VudA0KPiBjb21taXQgOGM3N2Rj
YTAxMTEyNWI3OTViZmExYzg2Zjg1YTgwMTMyZmVlZTU3OA0KPiBBdXRob3I6IEpvaG4gR2Fycnkg
PGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4gRGF0ZTrCoMKgIFRodSBOb3YgMTkgMjA6MjM6NTkg
MjAxNSArMDgwMA0KPiANCj4gIMKgwqDCoCBoaXNpX3NhczogUmVtb3ZlIGRlcGVuZGVuY3kgb24g
b2ZfaXJxX2NvdW50DQo+IA0KPiBUaGFua3MNClRoYW5rIEZlaSBmb3IgeW91ciBraW5kIGluZm9y
bWF0aW9u77ya77yJDQo=
