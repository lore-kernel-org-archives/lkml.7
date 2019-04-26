Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6FCC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8653C20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vSscYAAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfDZIrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:47:49 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:12165
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDZIrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGKRzEKRD0yxYZoKEZLnS7vXZPGXjXct+wYWsciIgJs=;
 b=vSscYAAy4A6kSNPVqCEAlU594/h6+QuZlfnnY/TfUA+uJhntX09JejnISeIiYR8kqOI3yMTF8mPqD0PArqAXUnYBXnIxo7zrFfYU7gdTLxZmahfEpr5wARkaMSsE1xCe8DNw9pPf8Q2biDFyh09UDcVudsGmbm/ffXzTiaS6aKc=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5037.eurprd04.prod.outlook.com (20.177.50.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:47:04 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:47:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v2 00/15] add ecspi ERR009165 for i.mx6/7 soc
 family
Thread-Topic: [EXT] Re: [PATCH v2 00/15] add ecspi ERR009165 for i.mx6/7 soc
 family
Thread-Index: AQHU/AbBy202P2j5a0C7BDmMWU+Kf6ZOGYeAgAAF6QA=
Date:   Fri, 26 Apr 2019 08:47:03 +0000
Message-ID: <1556268048.9298.11.camel@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556266779.2584.15.camel@pengutronix.de>
In-Reply-To: <1556266779.2584.15.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c23c7579-2943-4d61-e0b5-08d6ca23c195
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5037;
x-ms-traffictypediagnostic: VI1PR04MB5037:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB50375CB6CC3126F7A6831644893E0@VI1PR04MB5037.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(478600001)(71200400001)(45080400002)(99286004)(7736002)(76116006)(91956017)(305945005)(14454004)(7416002)(71190400001)(36756003)(68736007)(81166006)(6436002)(8676002)(53936002)(110136005)(66476007)(6512007)(316002)(66946007)(66446008)(64756008)(966005)(2501003)(66556008)(54906003)(73956011)(86362001)(6306002)(66066001)(97736004)(2201001)(6506007)(26005)(103116003)(76176011)(102836004)(2906002)(5660300002)(53546011)(8936002)(2616005)(11346002)(476003)(486006)(446003)(4326008)(6246003)(6486002)(25786009)(81156014)(3846002)(6116002)(256004)(50226002)(229853002)(186003)(99106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5037;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8B0MdFOaNUquD+uT7/q2bFHHPm5jr9rVY1LV9FuQX2UBRBQj8zcgrSLr8xXjE2U4gc5e8yH7ewLUkcS/XuenxTLmRxRCtTyoqg7dpQ4AwSRYR2vSRb00QVSEV7YzhSpkAjfX49eeFhZwdwtUAbsMKEZqH1RnTRGxUmf0LWEhgbLmSBa6tedyMrj3yWSa4miNW/TI3FLhpj3f+8WVSfUps32ZicZn1z3rY9ar79+yWcRw5GFQlUa/FqgqKz1d2+tfCzGRzPJzr5yRJaWxfYLJGj31o+jPVCMlRj8NiVhXDKovWKTIzv7AwRXifftBn+EiiBmt8hqfnbpwYEUvBf2Lw0R75W7Rt4de2NPQRxpyFo6QMjITvzEs+VqG3DH5Y38DL0Xl3GlG31e7f4bSSS6rXJbPSYviLmIlFTayD+qH/Gk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C931906363223438109019DB56EA928@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23c7579-2943-4d61-e0b5-08d6ca23c195
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:47:03.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNiBhdCAwODoxOSArMDAwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+IENhdXRp
b246IEVYVCBFbWFpbA0KPiANCj4gSGkgUm9iaW4sDQo+IA0KPiBBbSBGcmVpdGFnLCBkZW4gMjYu
MDQuMjAxOSwgMDg6MDUgKzAwMDAgc2NocmllYiBSb2JpbiBHb25nOg0KPiA+IA0KPiA+IMKgIFRo
ZXJlIGlzIGVjc3BpIEVSUjAwOTE2NSBvbiBpLm14Ni83IHNvYyBmYW1pbHksIHdoaWNoIGNhdXNl
IEZJRk8NCj4gPiB0cmFuc2ZlciB0byBiZSBzZW5kIHR3aWNlIGluIERNQSBtb2RlLiBQbGVhc2Ug
Z2V0IG1vcmUgaW5mb3JtYXRpb24NCj4gPiBmcm9tOg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRncNCj4gPiB3dy5u
eHAuY29tJTJGZG9jcyUyRmVuJTJGZXJyYXRhJTJGSU1YNkRRQ0UucGRmJmFtcDtkYXRhPTAyJTdD
MDElN0N5DQo+ID4gaWJpbi5nb25nJTQwbnhwLmNvbSU3QzAwNzg2OTRiMjMxNDQzZDFjYjdkMDhk
NmNhMWZlZWNmJTdDNjg2ZWExZDNiYw0KPiA+IDJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MSU3QzYzNjkxODYzNTgyODQ4OTA0OSZhbXA7c2RhdGE9SWNQemcNCj4gPiB1SFRTODFyZEhHTXpV
MndRZERZSm45YkUxVURDc2MwQlVPNUluOCUzRCZhbXA7cmVzZXJ2ZWQ9MC4gVGhlDQo+ID4gd29y
a2Fyb3VuZCBpcyBhZGRpbmcNCj4gPiBuZXcgc2RtYSByYW0gc2NyaXB0IHdoaWNoIHdvcmtzIGlu
IFhDSMKgwqBtb2RlIGFzIFBJTyBpbnNpZGUgc2RtYQ0KPiA+IGluc3RlYWQNCj4gPiBvZiBTTUMg
bW9kZSwgbWVhbndoaWxlLCAnVFhfVEhSRVNIT0xEJyBzaG91bGQgYmUgMC4NCj4gSSB3b3VsZCBs
aWtlIHRvIGhhdmUgYSBtb3JlIGluLWRlcHRoIGV4cGxhbmF0aW9uIGFib3V0IGhvdyB0aGlzIG5l
dw0KPiBSQU0NCj4gc2NyaXB0IGRpZmZlcnMgZnJvbSB0aGUgZXhpc3RpbmcgUk9NIHNjcmlwdCBh
bmQgdGhlIGNoYW5nZXMgdG8gdGhlDQo+IHN0YXRlIHRyYW5zaXRpb25zLg0KVGhlIG5ldyBlY3Nw
aSByYW0gc2NyaXB0IGp1c3QgZm9sbG93IGVycmF0YSB0byBlbmFibGUgZWNzcGkgWENIIGJpdA0K
YWZ0ZXIgZXZlcnkgdGltZSB0eGZpZm8gZmlsbGVkIGp1c3QgYXMgUElPLCBwbGVhc2UgY2hlY2sg
c3BpX2lteF9wdXNoKCkNCmluIHNwaS1pbXguYy4NCj4gDQo+ID4gDQo+ID4gwqAgVGhlIGlzc3Vl
IHNob3VsZCBiZSBleGlzdCBvbiBhbGwgbGVnYWN5IGkubXg2Lzcgc29jIGZhbWlseSBiZWZvcmUN
Cj4gPiBpLm14NnVsLA0KPiA+IE5YUCBmaXggdGhpcyBkZXNpZ24gaXNzdWUgZnJvbSBpLm14NnVs
LCBzbyBuZXdlciBjaGlwcyBzdWNoIGFzDQo+ID4gaS5teDZ1bGwvDQo+ID4gaS5teDhtcS9pLm14
OG1tLCBkb24ndCBuZWVkIHRoaXMgd29ya2Fyb3VkIGFueW1vcmUuIFRoaXMgcGF0Y2ggc2V0DQo+
ID4gYWRkIG5ldyAnZnNsLGlteDZ1bC1lY3NwaScgZm9yIGVjc3BpIGRyaXZlciBhbmQgJ2Vjc3Bp
X2ZpeGVkJyBpbg0KPiA+IHNkbWENCj4gPiBkcml2ZXIgdG8gY2hvb3NlIGlmIG5lZWQgZXJyYXRh
IG9yIG5vdC4NCj4gPiDCoCBUaGUgZmlyc3QgdHdvIHJldmVydGVkIHBhdGNoZXMgc2hvdWxkIGJl
IHRoZSBzYW1lIGlzc3VlLCB0aG91Z2gsDQo+ID4gaXQNCj4gPiBzZWVtcyAnZml4ZWQnIGJ5IGNo
YW5naW5nIHRvIG90aGVyIHNocCBzY3JpcHQuIEhvcGUgU2VhbiBvciBTYXNjaGENCj4gPiBjb3Vs
ZA0KPiA+IGhhdmUgdGhlIGNoYW5jZSB0byB0ZXN0IHRoaXMgcGF0Y2ggc2V0IGlmIGNvdWxkIGZp
eCB0aGVpciBpc3N1ZXMuDQo+ID4gwqAgQmVzaWRlcywgZW5hYmxlIHNkbWEgc3VwcG9ydCBmb3Ig
aS5teDhtbS84bXEgYW5kIGZpeCBlY3NwaTEgbm90DQo+ID4gd29yaw0KPiA+IG9uIGkubXg4bW0g
YmVjYXVzZSB0aGUgZXZlbnQgaWQgaXMgemVyby4NCj4gPiANCj4gPiBQUzoNCj4gPiDCoFBsZWFz
ZSBnZXQgc2RtYSBmaXJtd2FyZSBmcm9tIGJlbG93IGxpbnV4LWZpcm13YXJlIGFuZCBjb3B5IGl0
IHRvDQo+ID4geW91cg0KPiA+IGxvY2FsIHJvb3RmcyAvbGliL2Zpcm13YXJlL2lteC9zZG1hLg0K
PiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmcNCj4gPiBpdC5rZXJuZWwub3JnJTJGcHViJTJGc2NtJTJGbGludXglMkZr
ZXJuZWwlMkZnaXQlMkZmaXJtd2FyZSUyRmxpbnV4DQo+ID4gLWZpcm13YXJlLmdpdCUyRnRyZWUl
MkZpbXglMkZzZG1hJmFtcDtkYXRhPTAyJTdDMDElN0N5aWJpbi5nb25nJTQwbg0KPiA+IHhwLmNv
bSU3QzAwNzg2OTRiMjMxNDQzZDFjYjdkMDhkNmNhMWZlZWNmJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTkNCj4gPiBjNWMzMDE2MzUlN0MwJTdDMSU3QzYzNjkxODYzNTgyODQ4OTA0OSZhbXA7c2Rh
dGE9U01vb25KOUhRcFVqM1R6UG1pDQo+ID4gN0NjQ1NBd2FSNDQlMkJHUGklMkJTQmolMkZYY2Vx
byUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiBUaGlzIGlzIG5vdCBhbiBvcHRpb24gYXMgbG9uZyBhcyB0
aGUgU0RNQSBSQU0gZmlybXdhcmUgYnJlYWtzIHRoZQ0KPiBtYWlubGluZSBzZXJpYWwgRE1BIHN1
cHBvcnQuIFBsZWFzZSBwcm92aWRlIGEgZml4ZWQgU0RNQSBSQU0gZmlybXdhcmUNCj4gdGhhdCBk
b2Vzbid0IHJlcGxhY2UgdGhlIFJPTSBzZXJpYWwgc2NyaXB0LCBhcyB0aGF0IG9uZSBpcyB0b3Rh
bGx5DQo+IGZpbmUuDQpZZXMsIEkgaGF2ZSBhbm90aGVyIHBhdGNoIHRvIGZpeCBzdWNoIHVhcnQg
ZnVuY3Rpb24gYnJva2VuIHdpdGggU0RNQQ0KUkFNIGZpcm13YXJlLCBpbmNsdWRpbmcgbmV3IHNk
bWEgZmlybXdhcmUgdXBkYXRlZCBhbmQga2VybmVsIHBhdGNoLg0KU2hvdWxkIEkgYWRkIHRoYXQg
cGF0Y2ggaW50byB0aGlzIHBhdGNoIHNldD8NCg0K
