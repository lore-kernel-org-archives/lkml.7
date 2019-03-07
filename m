Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DC320684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RG8SdGsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCGON2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:13:28 -0500
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:61518
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfCGON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mylPQwI8FuNrGJNbEvthXspC9x/BMnI0T3/2Z/U+enE=;
 b=RG8SdGsG2czQnIX3TqGLSqVmTt8t4FjQT2fZakHqsu132okMeWIzT6phXw5ymS47X8P5rzNraoDo/zAnPAu/LWfg8e+l5azGPj9WAPjDidd5Fdn8DNkc/7E+rMyC38TWr+HZ2AgRkfUMMWNuIWvGUEhktdzMkRKfR4Sm5VXyOJY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Thu, 7 Mar 2019 14:13:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 14:13:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Topic: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHU07jNtorBWhAbJkylCtaCxH6iDKYAGsHAgAAXwOCAAAGQcIAAA5JQ
Date:   Thu, 7 Mar 2019 14:13:21 +0000
Message-ID: <DB3PR0402MB391641F558061A561162136CF54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211060E8DA8BA9CEAAA0F15804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB391677CB27E45A6EC16D6F69F54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB42118452D9B975337E3BDDAD804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42118452D9B975337E3BDDAD804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f21d5429-05d0-4c7c-30d9-08d6a3070df8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM2NzY7MjM6eDNzemF6bDhjYTFHYVMyU0FaRmhVbUdr?=
 =?gb2312?B?Y1BhOWF3ZlA2Kzc5NUdSTmFMNW5rRngyMEl1TmF5T3FFZzJIc1oreVA4SVRX?=
 =?gb2312?B?WjUxekZGK3ZQTmNLaVppSkhRNzE4bGN6clJ0akYzalAydDFiSTNXM0NHdlZx?=
 =?gb2312?B?N3h5K00xYm1PS0NJdVFJWGZNV29rVHZiSXZCd3p6L0lBMjBwRmZoS2poMnFX?=
 =?gb2312?B?NCs2ZFB1WDZRbjdoaXUzU1VrY3RZYnQ1eTlXS242RW9YVGM0amtHYXpMbW1E?=
 =?gb2312?B?SXBma2NvNVlnbWN3RGdLOWFpRWVadmNNM3NPaFpYUzdhWDlGM2txV0dvZ2sz?=
 =?gb2312?B?d2hKK3ZkN3JTUWFnSXJvNXI4N0RpWTZMbHRraFh3b3gzRnZIZklFVW9aYnRx?=
 =?gb2312?B?MmlsOHI3K3UvbDRHUjE0WlltMzNwdUhiRnZZYUh2dGxBTXZBejdsZGVGTnpv?=
 =?gb2312?B?emJ4UGdOdW1hSitBV1dlM1RxN0JLSXVGa3ZHaEFKQVZXdkorRlNxcFE1TEp6?=
 =?gb2312?B?UktseWRoZ20yYVZ6Q2xaaHpXNUc1ZE9GeWFDbmdkM0RaRkRuZWhvcVk2dFdo?=
 =?gb2312?B?QkdZRllrMFIzVjFIa2VseEpkeVQzR2F4WXJsQWdET0l0NzlJNUlLSWVTMHRZ?=
 =?gb2312?B?TUhxQVNabnI1M3lybWdod09aWm5xQStWSEQ2OE12MThURjBDeCtFMGFQVTR0?=
 =?gb2312?B?eTE2ekgrdXFnNGluNFZVVml2QzRzMGpYRGdXL2lVNXRYc3lyTG92clZHRW9n?=
 =?gb2312?B?N3dSRXFTTHk2Z3ZmQnNPYXBjbm9DeU84aVMzSkxjeE1ZUmdOT3c4VG5wN1lh?=
 =?gb2312?B?aEdubUVrU3RNQzVSSVJXSnoxOGNSQzRpRWhLdG1Jcm81aXRQNEJqazZHSWNM?=
 =?gb2312?B?ck9IK05HVUNrUW9oMGUwU3ZsSk9XK21qSE80YWZjS3pHK0djK2dzaHFvVEkw?=
 =?gb2312?B?RXF2UU5lU2QyR01DeXFWcnppZ2xJQUdEUEpnZnhwVEtpTGcwRHdmSXA5SFlz?=
 =?gb2312?B?T1RUV0l1QXM2Q3ZRN2xIMWFPUm9DTlRaZ081djVOQlZ2MGRHTnFaUUxUT2Zk?=
 =?gb2312?B?MnB0QnBybG1wNkJrazIvQWlzdTk3bS9LUVliVU1zT3BwQVZ2N3Zydm1qZmZR?=
 =?gb2312?B?d3VxQTQzaVVxU3lPZEpSd2J3bFFoWDc4ellGL1lGVExWQW50a1pkTUdjTE8v?=
 =?gb2312?B?ek5lL1YwUk1kSndIVXJMZ0Y5c3crZmIxajZiMlJxTmozMDRLSGlkWHEzcm5J?=
 =?gb2312?B?bkZhSzAzQU1ncTJzRDlTRk9tY3pmRGlsbmxGR05pT283aVNmUjRKbkNXTTRQ?=
 =?gb2312?B?bzJmTG40b1FDUnh6N3h6aGVTeC9PaDVMU2U5WEgwb1RoWjFnaktRbHVsWlNW?=
 =?gb2312?B?TmJuN1U3eUQ1ZTVRcjgwUlRSMm1QVEQ1ZFVRVXFPWkVNQ05kL2V5LytJa012?=
 =?gb2312?B?K05XdnV0Z2dMUXgyNUZmaXQ2elYzR3ZKZUxrbnRTZHVaZ0NzaG1oeUxGbm13?=
 =?gb2312?B?OTVKck12R2xIallWYXNLRlN4TnFJOWhxdmpoVi9BZXJRWmVoZEpQMTRLNjBk?=
 =?gb2312?B?MHBPcHVSeXgycG5VaEZ0UmlaNmlvUi93UG0zd3d1cTFWOVNqd20xcnRvQWlL?=
 =?gb2312?B?eGIxbXQzeW9jbUZ0dTZWdzJuUXM2NE1VYVF5aExsVU1nNHR5RSttTmkzR2xD?=
 =?gb2312?B?OG9iMklMeHZYU1ZXb2t1Yi9uRVBlYmJmYlcxc3FMTmtUS3lOR3V1TS93d2ZS?=
 =?gb2312?B?WnJ1WmVaU0ZQdGRrKzlkZVdjT1ZRNEdYYkVDS2Y0N2tKSjYzY0tYU0JvZFdT?=
 =?gb2312?B?TzdpVFNqWE00U3lJaE4zUUZNWUJqUzVLZVVZcUd0QVh6dWtraXJpWHB0amJi?=
 =?gb2312?B?QWJRY1Zhak5sL2FhRzU1NUd6ZG1YdGJpRXlYSVc0WGxBR1JNdUx4N256R0Zy?=
 =?gb2312?B?M3NKTDQ4OFRKeXc9PQ==?=
x-microsoft-antispam-prvs: <DB3PR0402MB367646EF29868326784EA68FF54C0@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(13464003)(52314003)(105586002)(4326008)(7696005)(81166006)(25786009)(99286004)(6116002)(316002)(6246003)(2201001)(53546011)(76176011)(102836004)(71200400001)(52536013)(86362001)(476003)(3846002)(486006)(5660300002)(53936002)(9686003)(229853002)(55016002)(256004)(26005)(71190400001)(97736004)(6506007)(8936002)(6436002)(11346002)(14454004)(2906002)(44832011)(66066001)(186003)(478600001)(446003)(74316002)(33656002)(68736007)(110136005)(2501003)(106356001)(8676002)(7416002)(93886005)(7736002)(305945005)(81156014)(921003)(15866825006)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mE0J2JTvu8oIfbguQ9VNVV6QRq7ev8Wp3nTqI2rrnhAEVainqCXVk0yrYiMQxavpvzha0Ovf4FrV1WUSX9qyN3mRhbfiepBhCjRset9fa+7WW2+QSQpvkiqAYwNaLCE1R/qGbIwCNUxLvGRzL5uTvd3fw3eZKlUQHOrA+WCuZtjdp8/1+i5LTNR5E2QyBd5YIAxGDG7O8fMCWxSpLw8qJkzm/MrXHj3brR7tYLykXUlDDMgpLRbeT1dTH7IWAVwMGKf6ROCBacTECD8ojHqDCD/eXl5z8RloSKVGbY4bEMmHqr3H7Hkpt2h6vx7u1rEH4sC7Hdh9LhPg91+zDEWQvI+QjI9LiGKR4In6rNjhMqW9SUQNpqZZF4Yb/WIN4Q+k8gaZ/CgX9+fwPrcQMboF+7R+ex9vdWwExKHBiYheTdE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21d5429-05d0-4c7c-30d9-08d6a3070df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 14:13:21.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+IFNlbnQ6IDIwMTnE6jPUwjfI1SAyMjowMA0K
PiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBjYXRhbGluLm1hcmluYXNA
YXJtLmNvbTsNCj4gd2lsbC5kZWFjb25AYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7DQo+IGxpbnV4QHJvZWNrLXVzLm5ldDsg
QW5keSBHcm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsgaGVpa29Ac250ZWNoLmRlOw0KPiBo
b3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgYXJuZEBhcm5kYi5kZTsNCj4gbWF4aW1lLnJpcGFy
ZEBib290bGluLmNvbTsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IGJqb3JuLmFuZGVy
c3NvbkBsaW5hcm8ub3JnOyBlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOw0KPiBtYXJjLncu
Z29uemFsZXpAZnJlZS5mcjsgb2xvZkBsaXhvbS5uZXQ7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjcgMS8zXSB3YXRjaGRvZzogaW14X3Nj
OiBBZGQgaS5NWCBzeXN0ZW0gY29udHJvbGxlcg0KPiB3YXRjaGRvZyBzdXBwb3J0DQo+IA0KPiBb
Li4uXQ0KPiANCj4gPiA+IEFzIEkgcmVwbGllZCBpbiBhbm90aGVyIG1haWwsIGl0IGFjdHVhbGx5
IGRvZXMgbm90IGRlcGVuZCBvbiBTQ1UuDQo+ID4gPiBMZXQncyB3YWl0IGZvciBSb2IncyBjb21t
ZW50IG9uIHdoZXRoZXIgd2UgY291bGQgbW92ZSB3YXRjaGRvZyBPdXQNCj4gPiA+IG9mIFNDVSBu
b2RlLg0KPiA+DQo+ID4gUGVyIHByZXZpb3VzIGRpc2N1c3Npb24sIHRoZSBkZXBlbmRlbmN5IGhl
cmUgaXMgdG8gcHJldmVudCBlbmFibGluZw0KPiA+IHRoaXMgbW9kdWxlIGZvciBwbGF0Zm9ybSB3
aXRob3V0IElNWCBTQ1UsIGFsdGhvdWdoIGl0IGRvZXMgTk9UIHVzZSBTQ1UNCj4gPiBJUEMgY2Fs
bCwgYnV0IHRoZSBTTUMgY2FsbCB0cmFwIGludG8gQVJNLVRydXN0ZWQtRmlybXdhcmUgd2lsbA0K
PiA+IGV2ZW50dWFsbHkgY2FsbCBTQ1UgQVBJLCBzbyBpdCBzdGlsbCBkZXBlbmRzIG9uIElNWCBT
Q1UgaGFyZHdhcmUsIEkgYW0NCj4gPiBOT1QgdmVyeSBzdXJlIGlmIGl0IGlzIGNvcnJlY3QgdG8g
cmVtb3ZlIGl0IGhlcmUuDQo+ID4NCj4gDQo+IFRoZW4gaXQncyBBVEYgZGVwZW5kcyBvbiBTQ1Us
IG5vdCB0aGlzIHZpcnR1YWwgd2F0Y2hkb2cgYmFzZWQgb24gQVJNIFNJUCwNCj4gcmlnaHQ/DQoN
CkJ1dCB3ZSBkb24ndCBoYXZlIEFURiBkcml2ZXIgaW4gTGludXgga2VybmVsLi4uLCBJIGFtIGNv
bmZ1c2VkLCBhbnl3YXksIGlmIEd1ZW50ZXINCmFncmVlcywgSSBjYW4gcmVtb3ZlIHRoaXMgZGVw
ZW5kZW5jeSBoZXJlLg0KDQpBbnNvbi4NCg0KPiANCj4gUmVnYXJkcw0KPiBEb25nIEFpc2hlbmcN
Cj4gDQo+ID4gPg0KPiA+ID4gPiArCWRlcGVuZHMgb24gSEFWRV9BUk1fU01DQ0MNCj4gPiA+ID4g
KwlzZWxlY3QgV0FUQ0hET0dfQ09SRQ0KPiA+ID4gPiArCWhlbHANCj4gPiA+ID4gKwkgIFRoaXMg
aXMgdGhlIGRyaXZlciBmb3IgdGhlIHN5c3RlbSBjb250cm9sbGVyIHdhdGNoZG9nDQo+ID4gPiA+
ICsJICBvbiB0aGUgTlhQIGkuTVggU29DcyB3aXRoIHN5c3RlbSBjb250cm9sbGVyIGluc2lkZS4N
Cj4gPiA+ID4gKwkgIElmIHlvdSBoYXZlIG9uZSBvZiB0aGVzZSBwcm9jZXNzb3JzIGFuZCB3aXNo
IHRvIGhhdmUNCj4gPiA+ID4gKwkgIHdhdGNoZG9nIHN1cHBvcnQgZW5hYmxlZCwgc2F5IFksIG90
aGVyd2lzZSBzYXkgTi4NCj4gPiA+ID4gKw0K
