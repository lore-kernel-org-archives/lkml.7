Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66CDC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1A9206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XjGeF/Ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfHPBEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:04:30 -0400
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:14375
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfHPBE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:04:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoOFpuZJV2eWz9LOXlbR8g5tRoBQv03GeHegnU1dXrLQHk66/NET2dofYkO6aWOZXX+cLdAjJekuaeAb1BDRg1FTceOnQR1iu7H2Xv0gWpzq/3cOGpN9YI5QfilfZkV8vOXO/zGGUbV+Y1Jm8pgjYUv3ignopinOjP4lV8/mnZm7tRgei8ePW3teOLUoh1K5WArq9bd8J8ivvxB63x8zxlsCE8BiIagylkvhh5WR7drU8khY/1sqlVHnvQ8/i/vhKojR3PJxCO5VCuNCw7cnZy7LQJsIRkwLeRkhO6FO9smP8dIIpFckGLGuagSWg9P72sruxoxjHtvIgRp+/Tw2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GARQSXyQChu24RT84zo5tONi7LFmHT7AJreQt9UeVMI=;
 b=gGL/+LZ7rX3pA6n7/3Trljl/nN7pQRRMsgJEhGQLTIpiXljz9kuPUhYhLcUokvsVVXsz5Sd7/lb0iK8CmIKm4opRG4FKEUaGlLJiWSvO2rqYcH90dXCpm5bsH/mAyRcjE/MhnEigNLAn5UE7OpHLlYf/2cyDwiCtTSkejt6gzQBMXARSXfivvQHLN3w2CAyHoYH8XFfI49tgbjfeZ8G82HVaFXzOt9hpuFzP+NWWuKuEhfjpffbSqr/jJJxDn2pem46WU6vmWTJlBXXzSl4q0K8R0HWme17p4hx7q8NHehTfFuYl7l9vkr3J62I10HCUWYnA+irUmbYR7PPRobwKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GARQSXyQChu24RT84zo5tONi7LFmHT7AJreQt9UeVMI=;
 b=XjGeF/ChOXP/BIf9vA0tlOdv+kd0UGn5LqlgOrGLWOMtW98+DfGbmTwkzVlndBcAknaMndv3XZYi5HnNg6SbUp95AxsZlDQAe5jkGkQOI9FSIPLGvN+LaSGYEqeQZ1pV36SZGyJiblnlUVF7rs9+n5yaQ+wR3bF7EVf5Tm8tTd4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3660.eurprd04.prod.outlook.com (52.134.70.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 16 Aug 2019 01:03:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2178.016; Fri, 16 Aug 2019
 01:03:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V5 5/5] arm64: dts: imx8mm: Enable cpu-idle driver
Thread-Topic: [PATCH V5 5/5] arm64: dts: imx8mm: Enable cpu-idle driver
Thread-Index: AQHVNupfPchyCELhWUGTZyEOvBMD5ab8mrwAgACSYaA=
Date:   Fri, 16 Aug 2019 01:03:45 +0000
Message-ID: <DB3PR0402MB39160C450FC99A359B2366BDF5AF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190710063056.35689-1-Anson.Huang@nxp.com>
 <20190710063056.35689-5-Anson.Huang@nxp.com>
 <34c03d76-ae61-63b4-153f-3f9911cc962e@linaro.org>
In-Reply-To: <34c03d76-ae61-63b4-153f-3f9911cc962e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5a0b319-5a50-480b-f7c4-08d721e59676
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3660;
x-ms-traffictypediagnostic: DB3PR0402MB3660:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3660114E3AD7B707265686D1F5AF0@DB3PR0402MB3660.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(478600001)(66066001)(53936002)(74316002)(305945005)(102836004)(81166006)(8936002)(486006)(81156014)(8676002)(7416002)(26005)(14454004)(316002)(186003)(25786009)(76176011)(7696005)(6506007)(53546011)(52536014)(6246003)(5660300002)(44832011)(6116002)(2906002)(110136005)(2501003)(256004)(76116006)(6436002)(3846002)(66556008)(55016002)(66476007)(9686003)(86362001)(71200400001)(2201001)(66446008)(64756008)(14444005)(229853002)(33656002)(66946007)(99286004)(446003)(476003)(71190400001)(11346002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3660;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ExPN7JdVLUfaHoFzdrRwNdHZOKk0CJSw4ErHeJ9Jru1eP7liQINFmoDy1XvDP8Pwdco469xcsmCZQec+AzBzxwV84BkfVaKcFCAjCQT15NsygILmMhQIvm3fJ+PxMswm9GZrln1PGuA8x4y7zNEiMSpAr/Yy/UZRDoAxYX8mqcvQbJUAtx1i1sjNY3i55283fEEq2mqmoKNi8qW/qD8Zy/t8lKi/J2IsOeh3ECdZTjlom+UFVQ+JHPuP+dbeIjkTRX9nsNrLQO8K1g7oYOfKBT234EMcqCWucgT1WzHnITbGsHDk0IyiFH1GjPtSgRbJj2DUcqgIZBvG+7GFQugjYofNZqIJDMEdF1AST+8MZRAhrOzYZFmN0H3+7ORjXkWQZyNdgy99A1c9TJTLm5pAEkPIhPCU1IMyMnmQ0Wq64nU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a0b319-5a50-480b-f7c4-08d721e59676
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 01:03:45.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AIWr60vIPfjAW+5asl9JtGF1DlNblInOjcHEUdy9jgsarxPmJH5ye93KfDYxJMwDGr7o4//b5YewGUCwJZNlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IEhpIEFuc29uLA0KPiANCj4gc29ycnkgZm9yIHRoZSBsYXRlIHJldmll
dywgSSd2ZSBiZWVuIHByZXR0eSBidXN5Lg0KDQpUaGF0IGlzIE9LIGZvciBzdXJlLg0KDQo+IA0K
PiBJZiBTaGF3biBpcyBvaywgSSBjYW4gcGljayB0aGUgcGF0Y2hlcyAxLTQgaW4gbXkgdHJlZSBh
bmQgdGhlbiB0aGlzIG9uZSBhZnRlcg0KPiB5b3UgZml4IHRoZSBjb21tZW50cyBiZWxvdy4NCg0K
U2hhd24gc2hvdWxkIGJlIE9LIGZvciBpdCwgYW5kIGhlIGFscmVhZHkgdG9vayBwYXRjaCBbUEFU
Q0ggVjUgMi81XSBhcm02NDogRW5hYmxlIFRJTUVSX0lNWF9TWVNfQ1RSIGZvciBBUkNIX01YQyBw
bGF0Zm9ybXMNCnNpbmNlIEkgZXZlciBzZW50IGl0IGJlZm9yZSBpbiBvdGhlciBzZXJpZXMgd2hl
biBzeXN0ZW0gY291bnRlciBkcml2ZXIgaXMgTk9UIGxhbmRpbmcgb24gbWFpbiBsaW5lLCBub3cg
aXQgbGFuZGVkLCBTaGF3biBqdXN0IGFwcGx5DQp0aGF0IG9sZCBwYXRjaCwgc28gaW4gVjYgcGF0
Y2ggSSBqdXN0IHNlbnQsIEkgZGlkIE5PVCBpbmNsdWRlIHRoaXMgcGF0Y2gsIHlvdSBjYW4ganVz
dCBhcHBseSB0aGUgNCBwYXRjaGVzIGluIFY2Lg0KDQpIaSwgU2hhd24NCglEYW5pZWwgd2lsbCBw
aWNrIHRoaXMgd2hvbGUgcGF0Y2ggc2VyaWVzLCBwbGVhc2UgcmFpc2UgaWYgeW91IGhhdmUgYW55
IGNvbmNlcm4sIHRoYW5rcy4NCg0KPiANCj4gT24gMTAvMDcvMjAxOSAwODozMCwgQW5zb24uSHVh
bmdAbnhwLmNvbSB3cm90ZToNCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4gKwkJaWRsZS1zdGF0ZXMg
ew0KPiA+ICsJCQllbnRyeS1tZXRob2QgPSAicHNjaSI7DQo+ID4gKw0KPiA+ICsJCQljcHVfc2xl
ZXBfd2FpdDogY3B1LXNsZWVwLXdhaXQgew0KPiANCj4gSXMgdGhhdCBhIHJldGVudGlvbiBzdGF0
ZSBvciBhIHBvd2VyZG93bj8gSXQgaXMgcHJlZmVyYWJsZSB0byBjaGFuZ2UgdGhlIG5hbWUNCj4g
dG8gdGhlIGlkbGUgc3RhdGUgbmFtaW5nIGNvbnZlbnRpb24gZ2l2ZW4gaW4gdGhlIFBTQ0kgZG9j
dW1lbnRhdGlvbiBbMV0gcGFnZQ0KPiAxNi0xNw0KDQpUaGFua3MgZm9yIHlvdXIgZGV0YWlsIHJl
ZmVyZW5jZSwgaXQgaXMgYSBwb3dlciBkb3duIHN0YXRlIHdpdGggU29DIGVudGVyaW5nIFdBSVQg
bW9kZSwNCnNvIGluIFY2LCBJIGNoYW5nZSB0aGUgbmFtZSB0byAiY3B1X3BkX3dhaXQ6Y3B1LXBk
LXdhaXQiLg0KDQo+IA0KPiANCj4gPiArCQkJCWNvbXBhdGlibGUgPSAiYXJtLGlkbGUtc3RhdGUi
Ow0KPiA+ICsJCQkJYXJtLHBzY2ktc3VzcGVuZC1wYXJhbSA9IDwweDAwMTAwMzM+Ow0KPiA+ICsJ
CQkJbG9jYWwtdGltZXItc3RvcDsNCj4gPiArCQkJCWVudHJ5LWxhdGVuY3ktdXMgPSA8MTAwMD47
DQo+ID4gKwkJCQlleGl0LWxhdGVuY3ktdXMgPSA8NzAwPjsNCj4gPiArCQkJCW1pbi1yZXNpZGVu
Y3ktdXMgPSA8MjcwMD47DQo+ID4gKwkJCQl3YWtldXAtbGF0ZW5jeS11cyA9IDwxNTAwPjsNCj4g
DQo+IEl0IGlzIHBvaW50bGVzcyB0byBzcGVjaWZ5IHRoZSBlbnRyeSArIGV4aXQgKmFuZCogdGhl
IHdha2V1cC1sYXRlbmN5IFsyXS4NCg0KQWgsIHllcywgdGhpcyBpcyBuZXcgdG8gbWUsIEkgd2ls
bCBqdXN0IHJlbW92ZSB0aGUg4oCcd2FrZXVwLWxhdGVuY3ktdXPigJ0gcHJvcGVydHkuDQoNClRo
YW5rcywNCkFuc29uLg0KDQo=
