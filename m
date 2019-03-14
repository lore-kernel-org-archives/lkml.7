Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3372921019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwzJ5b0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCNOZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:25:39 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:61571
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfCNOZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCWAFaGgiNjCniwXE8dAppwK2E5yIo7bH9eVY2nWikw=;
 b=YwzJ5b0bFZicrFcJprto5lR1uq+obfH3wRVAPWPB1dK6Fcfian2WEpGyrTAGmvpTKudN8Noz10qC+aYNqv8H7I7/+8JR3G1OAjvvm9TCi1g0yiWPznHp/8/7v4FCk/THf5l2kz7G7K2/+bAiUw3NBi/FCSkDvcQJtlaW1uqKFb4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 14:25:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 14:25:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Topic: [PATCH V2 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Index: AQHU2W6+mizqa10BqkKrjLjL0sRSWaYK2oAAgAADnNCAAAiXAIAAR+rw
Date:   Thu, 14 Mar 2019 14:25:32 +0000
Message-ID: <DB3PR0402MB391616E8DBC8086C86B25D01F54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
 <1552461970-20813-3-git-send-email-Anson.Huang@nxp.com>
 <20190314091702.sooxvnzd4mqr2ilz@pengutronix.de>
 <DB3PR0402MB3916975BC10346C612135334F54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190314100042.fl4kdwn7awcw4aov@pengutronix.de>
In-Reply-To: <20190314100042.fl4kdwn7awcw4aov@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4af1deaf-729f-4ed2-2222-08d6a888eb20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3724D79370F6EB8D399EECBEF54B0@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(51444003)(199004)(189003)(13464003)(14454004)(229853002)(7736002)(6306002)(55016002)(93886005)(9686003)(81156014)(6436002)(106356001)(6916009)(305945005)(74316002)(2906002)(81166006)(105586002)(52536014)(8676002)(45080400002)(33656002)(316002)(3846002)(6116002)(54906003)(71190400001)(966005)(7416002)(53936002)(26005)(97736004)(11346002)(186003)(476003)(446003)(486006)(6246003)(7696005)(86362001)(4326008)(25786009)(102836004)(6506007)(99286004)(76176011)(53546011)(8936002)(5660300002)(256004)(14444005)(71200400001)(66574012)(44832011)(68736007)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mXrZ2TDx0I5Xc3sx9wvjMQTfU1/yZQnjVbdJsqEJdoJbuZcFNm3OAZi/WYxVqiUPDis8h/0LUMW12px/XyhprW5+N0s+dwg9tS2zzl28UDyxqdPs9zXxV8IwUeoe8XiTbHt2S5lp1+h3ww/l2PnwRw9HbPyxdH+Sgjju5QZPxTP4mtOxCFucxd+H4R22/l6APCqXTGtoY/WR/zf3U3QAx/b4BSNTCB+i8EVp44dwMAfuACtN7khQ8g0Q8wCDHP6avNUxJ5r1SW0cnRWJebSS9ziV3bG+EzfMUKKh0auxo5Rt86Eyhlx1Y99RLmtRGk4PzW6z0RmwnVfHgXFUGaZ6hKqtuTSQ68N1dD/S2bJ16jjqNyqNXWXQnjtu11RM+a/CkHuaoLI14OEn5Hawi4CUQ8HuLfrZ9OrbCfIdURd+SVQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af1deaf-729f-4ed2-2222-08d6a888eb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 14:25:33.2083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFV3ZSBLbGVpbmUtS8O2bmlnIFttYWlsdG86dS5rbGVpbmUt
a29lbmlnQHBlbmd1dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE55bm0M+aciDE05pelIDE4OjAxDQo+
IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHRoaWVycnkucmVk
aW5nQGdtYWlsLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsN
Cj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBl
bmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4QGFybWxpbnV4Lm9yZy51
azsgc3RlZmFuQGFnbmVyLmNoOw0KPiBvdGF2aW9Ab3NzeXN0ZW1zLmNvbS5icjsgTGVvbmFyZCBD
cmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47DQo+IHNjaG5pdHplbHRvbnlAZ21haWwu
Y29tOyBqYW4udHVlcmtAZW10cmlvbi5jb207IFJvYmluIEdvbmcNCj4gPHlpYmluLmdvbmdAbnhw
LmNvbT47IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvNV0gcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGRyaXZl
ciBzdXBwb3J0DQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIFRodSwgTWFyIDE0LCAyMDE5IGF0IDA5
OjQ5OjA2QU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBNYXIgMTMs
IDIwMTkgYXQgMDc6MzE6MTZBTSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ICtz
dGF0aWMgdm9pZCBpbXhfdHBtX3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlwICpjaGlwLA0KPiA+
ID4gPiArCQkJICAgICAgIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQo+ID4gPiA+ICsJCQkgICAg
ICAgc3RydWN0IHB3bV9zdGF0ZSAqc3RhdGUpIHsNCj4gPiA+ID4gKwlzdHJ1Y3QgaW14X3RwbV9w
d21fY2hpcCAqdHBtID0gdG9faW14X3RwbV9wd21fY2hpcChjaGlwKTsNCj4gPiA+ID4gKwlzdGF0
aWMgYm9vbCB0cG1fY250X2luaXRpYWxpemVkOw0KPiA+ID4gPiArCXVuc2lnbmVkIGludCBkdXR5
X2NudDsNCj4gPiA+ID4gKwl1MzIgdmFsOw0KPiA+ID4gPiArCXU2NCB0bXA7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKwkvKg0KPiA+ID4gPiArCSAqIFRQTSBjb3VudGVyIGlzIHNoYXJlZCBieSBtdWx0
aSBjaGFubmVscywgbGV0J3MgbWFrZSBpdCB0byBiZQ0KPiA+ID4gPiArCSAqIE9OTFkgZmlyc3Qg
Y2hhbm5lbCBjYW4gY29uZmlnIFRQTSBjb3VudGVyJ3MgcHJlY2FsZSBhbmQgcGVyaW9kDQo+ID4g
PiA+ICsJICogY291bnQuDQo+ID4gPiA+ICsJICovDQo+ID4gPiA+ICsJaWYgKCF0cG1fY250X2lu
aXRpYWxpemVkKSB7DQo+ID4gPiA+ICsJCWlteF90cG1fcHdtX2NvbmZpZ19jb3VudGVyKGNoaXAs
IHN0YXRlLT5wZXJpb2QpOw0KPiA+ID4gPiArCQl0cG1fY250X2luaXRpYWxpemVkID0gdHJ1ZTsN
Cj4gPiA+ID4gKwl9DQo+ID4gPg0KPiA+ID4gU28gdGhlIHBlcmlvZCBjYW4gb25seSBiZSBjb25m
aWd1cmVkIG9uY2UuIFRoYXQgaXMgbm90IGFzIGdvb2QgYXMgaXQgY291bGQNCj4gYmUuDQo+ID4g
PiBZb3Ugc2hvdWxkIGFsbG93IGEgY2hhbmdlIHdoZW5ldmVyIHRoZXJlIGlzIGV4YWN0bHkgb25l
IFBXTSBpbiB1c2UuDQo+ID4NCj4gPiBPSywgbWF5YmUgSSBjYW4gYWRkIGNoZWNrIGZvciBvdGhl
ciBjaGFubmVscycgc3RhdHVlIGhlcmUsIGFuZCBhbGxvdw0KPiA+IHRoZSBwZXJpb2QgdXBkYXRl
IGlmIE9OTFkgMSBjaGFubmVsIGlzIGVuYWJsZWQuDQo+IA0KPiBTZWUgaG93IHRoZSBTaUZpdmUg
cGF0Y2ggdGhhdCBJIGFscmVhZHkgcG9pbnRlZCBvdXQgc29sdmVzIHRoaXMgc2FtZSBwcm9ibGVt
Lg0KDQpUaGFua3MsIEkgd2lsbCBhZGQgYSB1c2VyX2NvdW50IHRvIGRldGVybWluZSBob3cgbWFu
eSBjaGFubmVscyBhcmUgdXNlZC4NCg0KDQo+IA0KPiA+ID4gPiArCS8qIHNldCBkdXR5IGNvdW50
ZXIgKi8NCj4gPiA+ID4gKwl0bXAgPSByZWFkbCh0cG0tPmJhc2UgKyBUUE1fTU9EKSAmIFRQTV9N
T0RfTU9EX01BU0s7DQo+ID4gPiA+ICsJdG1wICo9IHN0YXRlLT5kdXR5X2N5Y2xlOw0KPiA+ID4g
PiArCWR1dHlfY250ID0gRElWX1JPVU5EX0NMT1NFU1RfVUxMKHRtcCwgc3RhdGUtPnBlcmlvZCk7
DQo+ID4gPg0KPiA+ID4gVWFoLCB5b3UgdXNlIHN0YXRlLT5wZXJpb2QgaGVyZSBldmVuIHRob3Vn
aCBmb3IgdGhlIDJuZCBQV00gdGhlDQo+ID4gPiBEaXZpZGVyIG1pZ2h0IG5vdCBiZSBzZXR1cCBh
cHByb3ByaWF0ZWx5Lg0KPiA+DQo+ID4gSSB0aGluayB0aGF0IGlzIDEgbGltaXRhdGlvbiBoZXJl
LCB0aGUgZHRzIHNob3VsZCBtYWtlIHN1cmUgdGhlIHBlcmlvZA0KPiA+IHVzZWQgZm9yIGRpZmZl
cmVudCBjaGFubmVscyBhcmUgc2FtZSBvciBhdCBsZWFzdCB0aGV5IGNhbiBzaGFyZSBzYW1lDQo+
ID4gZGl2aWRlciwgb3RoZXJ3aXNlLCB3aGF0IGlmIG11bHRpcGxlIGNoYW5uZWxzIGNhbiBOT1Qg
ZmluZCBhIGRpdmlkZXINCj4gPiBnb29kIGZvciBldmVyeSBjaGFubmVsPyBIb3cgdG8gZGVhbCB3
aXRoIHRoaXMgY2FzZT8NCj4gDQo+IFlvdSBzaG91bGQgcmV0dXJuIC1FUkFOR0Ugb3IgLUVJTlZB
TCBmb3IgdGhlIGNhbGxzIHRoYXQgY2Fubm90IGJlIHNhdGlzZmllZC4NCg0KSW4gbXkgbGF0ZXN0
IGltcGxlbWVudGF0aW9uLCBJIGhhdmUgYWRkZWQgdGhlIHBlcmlvZCBzZXR0aW5nIGNoZWNrIGF0
IHRoZSBiZWdpbm5pbmcNCm9mIHRoZSAuYXBwbHksIGFzIHRoZSBsaW1pdGF0aW9uIHN0YXRlcywg
YWxsIGNoYW5uZWxzIHNob3VsZCB1c2Ugc2FtZSBwZXJpb2Qgc2V0dGluZ3MsIHNvDQp0aGUgcGVy
aW9kIGhlcmUgaXMgc2FtZSBmb3IgYWxsIGNoYW5uZWxzLCBvbmNlIGl0IGlzIGRpZmZlcmVudCwg
dGhlIC5hcHBseSBjYWxsIHdpbGwgcmV0dXJuIGZhaWxlZA0KYW5kIHRoZSBkdXR5IGN5Y2xlIHNl
dHRpbmcgd2lsbCBiZSBza2lwcGVkIGFzIHdlbGwuDQoNCjIzMiAgICAgICAgIGlmIChzdGF0ZS0+
cGVyaW9kICE9IGN1cnN0YXRlLnBlcmlvZCkgew0KMjMzICAgICAgICAgICAgICAgICAvKg0KMjM0
ICAgICAgICAgICAgICAgICAgKiBUUE0gY291bnRlciBpcyBzaGFyZWQgYnkgbXVsdGlwbGUgY2hh
bm5lbHMsIHNvIHRoZSBwcmVzY2FsZQ0KMjM1ICAgICAgICAgICAgICAgICAgKiBhbmQgcGVyaW9k
IGNhbiBOT1QgYmUgbW9kaWZpZWQgd2hlbiBhbnkgb3RoZXIgY2hhbm5lbCBpcyB1c2VkLg0KMjM2
ICAgICAgICAgICAgICAgICAgKi8NCjIzNyAgICAgICAgICAgICAgICAgaWYgKHRwbS0+dXNlcl9j
b3VudCAhPSAxKQ0KMjM4ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQoy
MzkgICAgICAgICAgICAgICAgIHJldCA9IGlteF90cG1fcHdtX2NvbmZpZ19jb3VudGVyKGNoaXAs
IHN0YXRlLT5wZXJpb2QpOw0KMjQwICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KMjQxICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQoyNDIgICAgICAgICB9DQoyNDMNCjI0NCAg
ICAgICAgIGlmICghc3RhdGUtPmVuYWJsZWQpDQoyNDUgICAgICAgICAgICAgICAgIGR1dHlfY3lj
bGUgPSAwOw0KMjQ2DQoyNDcgICAgICAgICBpZiAoc3RhdGUtPmR1dHlfY3ljbGUgIT0gY3Vyc3Rh
dGUuZHV0eV9jeWNsZSB8fA0KMjQ4ICAgICAgICAgICAgIHN0YXRlLT5wb2xhcml0eSAhPSBjdXJz
dGF0ZS5wb2xhcml0eSkNCjI0OSAgICAgICAgICAgICAgICAgaW14X3RwbV9wd21fY29uZmlnKGNo
aXAsIHB3bSwNCjI1MCAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0ZS0+cGVyaW9kLCBkdXR5
X2N5Y2xlLCBzdGF0ZS0+cG9sYXJpdHkpOw0KDQoNCg0KDQo+IA0KPiA+ID4gPiBbLi4uXQ0KPiA+
ID4gPiArc3RhdGljIGludCBpbXhfdHBtX3B3bV9hcHBseShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAs
IHN0cnVjdA0KPiBwd21fZGV2aWNlICpwd20sDQo+ID4gPiA+ICsJCQkgIHN0cnVjdCBwd21fc3Rh
dGUgKnN0YXRlKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0cnVjdCBpbXhfdHBtX3B3bV9jaGlw
ICp0cG0gPSB0b19pbXhfdHBtX3B3bV9jaGlwKGNoaXApOw0KPiA+ID4gPiArCXN0cnVjdCBwd21f
c3RhdGUgY3Vyc3RhdGU7DQo+ID4gPiA+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArCWlteF90cG1fcHdtX2dldF9zdGF0ZShjaGlwLCBwd20sICZjdXJzdGF0ZSk7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdHBtLT5sb2NrLCBmbGFn
cyk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAoc3RhdGUtPnBlcmlvZCAhPSBjdXJzdGF0ZS5w
ZXJpb2QgfHwNCj4gPiA+ID4gKwkgICAgc3RhdGUtPmR1dHlfY3ljbGUgIT0gY3Vyc3RhdGUuZHV0
eV9jeWNsZSB8fA0KPiA+ID4gPiArCSAgICBzdGF0ZS0+cG9sYXJpdHkgIT0gY3Vyc3RhdGUucG9s
YXJpdHkpDQo+ID4gPiA+ICsJCWlteF90cG1fcHdtX2NvbmZpZyhjaGlwLCBwd20sIHN0YXRlKTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChzdGF0ZS0+ZW5hYmxlZCAhPSBjdXJzdGF0ZS5lbmFi
bGVkKQ0KPiA+ID4gPiArCQlpbXhfdHBtX3B3bV9lbmFibGUoY2hpcCwgcHdtLCBzdGF0ZS0+ZW5h
YmxlZCk7DQo+ID4gPg0KPiA+ID4gVGhpcyBpcyB3cm9uZy4gVGhpcyBzZXF1ZW5jZToNCj4gPiA+
DQo+ID4gPiAJcHdtX2FwcGx5X3N0YXRlKHB3bSwgeyAuZHV0eV9jeWNsZSA9IDAsIC5wZXJpb2Qg
PSAxMDAwMCwgLmVuYWJsZWQgPQ0KPiA+ID4gdHJ1ZSB9KTsNCj4gPiA+IAlwd21fYXBwbHlfc3Rh
dGUocHdtLCB7IC5kdXR5X2N5Y2xlID0gMTAwMDAsIC5wZXJpb2QgPSAxMDAwMCwNCj4gPiA+IC5l
bmFibGVkID0gZmFsc2UgfSk7DQo+ID4gPg0KPiA+ID4gbXVzdCBrZWVwIHRoZSBvdXRwdXQgcGlu
IGxvdyB3aGljaCBpc24ndCBndWFyYW50ZWVkIGhlcmUuDQo+ID4NCj4gPiBTbyB5b3UgbWVhbiBm
b3IgZXZlcnkgLmFwcGx5IG9wZXJhdGlvbiwgdGhlIGNoYW5uZWwgTVVTVCBiZSBkaXNhYmxlZA0K
PiA+IGZpcnN0LCB0aGVuIGNvbmZpZyBpdCwgdGhlbiBlbmFibGUgaXQ/DQo+IA0KPiBOby4gSSBv
bmx5IHNheSB0aGF0IHlvdSBzaG91bGQgbm90IGNvbmZpZ3VyZSB0aGUgbmV3IHBlcmlvZCBhbmQg
ZHV0eSBjeWNsZSBpZg0KPiBpbiB0aGUgZW5kIHRoZSBoYXJkd2FyZSBzaG91bGQgYmUgZGlzYWJs
ZWQuIEFsd2F5cyBkaXNhYmxpbmcgaXMgd3JvbmcsIHRvby4NCj4NCg0KVW5kZXJzdGFuZCBub3cs
IEkgd2lsbCBjaGVjayB0aGUgc3RhdGUtPmVuYWJsZSBmaXJzdCwgaWYgaXQgaXMgZmFsc2UsIEkg
d2lsbCBzZXQgdGhlIGR1dHlfY3ljbGUNCnRvIDAgYmVmb3JlIGNvbmZpZ3VyaW5nIHRoZSBjaGFu
bmVsLg0KDQpBbnNvbi4NCg0KIA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0KPiAtLQ0KPiBQ
ZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvD
tm5pZyAgICAgICAgICAgIHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAg
ICAgICAgIHwNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cucA0KPiBlbmd1dHJvbml4LmRlJTJGJmFtcDtkYXRhPTAy
JTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0M2ZjMNCj4gMGJiNDBmYjlkNDYwY2Q3M2Ew
OGQ2YTg2M2Y0YzklN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNQ0KPiAlN0MwJTdD
MCU3QzYzNjg4MTU0NDYwMDQ0OTg3NSZhbXA7c2RhdGE9U1JCVG4lMkJjcXV6UlJSTHJ6T1RHDQo+
IHZsQzVXTnZvZjI4SjAlMkI3N2lTeHRGVllBJTNEJmFtcDtyZXNlcnZlZD0wICB8DQo=
