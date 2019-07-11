Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C8C74A36
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA88B21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ozto4Npr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfGKBE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 21:04:57 -0400
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:45449
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfGKBE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 21:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFFXG3NNPjiSl14l1zlB561UPLmSIOY60R1QUKn3dGg=;
 b=ozto4Nprvvk893KuRSJoAGZdDBChX7cDeqiLJr3Elr20XK+2HxJKXl8K5n5vTwjASdIImkz/Pp1+890+vTNSp8SyZCzoBm0RQPdy2XTcIzvsx3DKs4Mu1f6gbbmIxQ5092bK3o6hgiJ2OIYMc6nXZpUQ1rh9knubNCQn01w0NvA=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3512.eurprd04.prod.outlook.com (52.133.19.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 11 Jul 2019 01:04:53 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::d5e6:6a87:7e6:95a]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::d5e6:6a87:7e6:95a%5]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 01:04:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/5] clocksource/drivers/sysctr: Add clock-frequency
 property
Thread-Topic: [PATCH V4 2/5] clocksource/drivers/sysctr: Add clock-frequency
 property
Thread-Index: AQHVL/II1Ibi8cGYOUSIKmrgeiNcLabCyoSAgABPmdCAAMtKgIAAwymQ
Date:   Thu, 11 Jul 2019 01:04:52 +0000
Message-ID: <AM6PR0402MB39117F91D660450647A692E8F5F30@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <20190701093826.5472-1-Anson.Huang@nxp.com>
 <20190701093826.5472-2-Anson.Huang@nxp.com>
 <CAL_JsqKeu-b8mbMJBtnNn1vL=RSvUXbo+g40haZnjXTW11CJ6w@mail.gmail.com>
 <DB3PR0402MB39167FC68991F071E9E58D81F5F00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJbHFZ2qcLvhZGk8Q-f80_QhdgQxcHe2TyCjc4GGRNJNQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJbHFZ2qcLvhZGk8Q-f80_QhdgQxcHe2TyCjc4GGRNJNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc7dfedb-ad9d-4db2-c9ad-08d7059bc81b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3512;
x-ms-traffictypediagnostic: AM6PR0402MB3512:
x-microsoft-antispam-prvs: <AM6PR0402MB35126F0D315C8D6E9231E525F5F30@AM6PR0402MB3512.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(74316002)(55016002)(52536014)(7736002)(305945005)(76116006)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(476003)(486006)(44832011)(9686003)(14454004)(53936002)(7416002)(6246003)(256004)(86362001)(99286004)(4326008)(7696005)(76176011)(53546011)(186003)(6506007)(66066001)(229853002)(102836004)(33656002)(26005)(478600001)(316002)(54906003)(2906002)(5660300002)(81156014)(8676002)(81166006)(6116002)(3846002)(11346002)(446003)(71200400001)(71190400001)(6436002)(25786009)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3512;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jb8cDzeXDHo6muqvAPZpRzmY7xd94hAKaP7ZkysaefZbWsqVHBTe20xcYiAsVB8PE/Ym36QnsxgxK+I5iU3MemydEDqcXd0GR4X/rJ8uofpE1VsP7ajmv10AMoKr3wGnEfqdyL48JRc1kMuK5FYIoDh7GvFgC44qDxDHAIQc0I+JSMaVbGqsg5zEbrOE9iA3IZF8wZi9aUbRGebCDf0PBtsmCFEgQNh7JS0sEhaKE1LPC6kGELule0ZtVbUEUgDjV9h5CcxQDIOOTWDhXeWbIeU6kVTyOPzrtHcId62gaO9bXff+O4LGGMxVVB9yvTFLK/CKrkIWskh2CbAMzn3v2ggxHfEc34K38oQnEKXzsYGKFQul5uReMdGwAg4Fc0GfPuIblMWUNLeKEdF+ToFJlJRt860bhzvKyJpym0odM8Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7dfedb-ad9d-4db2-c9ad-08d7059bc81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 01:04:52.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQo+IE9uIFR1ZSwgSnVsIDksIDIwMTkgYXQgNzozMCBQTSBBbnNvbiBIdWFuZyA8
YW5zb24uaHVhbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSwgUm9iDQo+ID4NCj4gPiA+
IE9uIE1vbiwgSnVsIDEsIDIwMTkgYXQgMzo0NyBBTSA8QW5zb24uSHVhbmdAbnhwLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+ID4NCj4gPiA+ICdkdC1iaW5kaW5nczogdGltZXI6IC4uLicgZm9yIHRoZSBzdWJq
ZWN0Lg0KPiA+DQo+ID4gT0ssIEkgbWFkZSBhIG1pc3Rha2UuDQo+ID4NCj4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IFN5c3RlbXMgd2hpY2ggdXNlIHBsYXRmb3JtIGRyaXZlciBtb2RlbCBmb3IgY2xv
Y2sgZHJpdmVyIHJlcXVpcmUNCj4gPiA+ID4gdGhlIGNsb2NrIGZyZXF1ZW5jeSB0byBiZSBzdXBw
bGllZCB2aWEgZGV2aWNlIHRyZWUgd2hlbiBzeXN0ZW0NCj4gPiA+ID4gY291bnRlciBkcml2ZXIg
aXMgZW5hYmxlZC4NCj4gPiA+DQo+ID4gPiBUaGlzIGlzIGEgRFQgYmluZGluZy4gV2hhdCdzIGEg
cGxhdGZvcm0gZHJpdmVyPw0KPiA+DQo+ID4gSXQgaXMganVzdCB0cnlpbmcgdG8gZXhwbGFpbiB3
aHkgd2UgbmVlZCB0byBpbnRyb2R1Y2UgdGhpcyAiY2xvY2stZnJlcXVlbmN5Ig0KPiA+IHByb3Bl
cnR5LCBub3RoaW5nIGFib3V0IHRoZSBiaW5kaW5nIGFuZCBwbGF0Zm9ybSBkcml2ZXIuDQo+ID4N
Cj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgaXMgbmVjZXNzYXJ5IGFzIGluIHRoZSBwbGF0
Zm9ybSBkcml2ZXIgbW9kZWwgdGhlIG9mX2Nsaw0KPiA+ID4gPiBvcGVyYXRpb25zIGRvIG5vdCB3
b3JrIGNvcnJlY3RseSBiZWNhdXNlIHN5c3RlbSBjb3VudGVyIGRyaXZlciBpcw0KPiA+ID4gPiBp
bml0aWFsaXplZCBpbiBlYXJseSBwaGFzZSBvZiBzeXN0ZW0gYm9vdCB1cCwgYW5kIGNsb2NrIGRy
aXZlcg0KPiA+ID4gPiB1c2luZyBwbGF0Zm9ybSBkcml2ZXIgbW9kZWwgaXMgTk9UIHJlYWR5IGF0
IHRoYXQgdGltZSwgaXQgd2lsbA0KPiA+ID4gPiBjYXVzZSBzeXN0ZW0gY291bnRlciBkcml2ZXIg
aW5pdGlhbGl6YXRpb24gZmFpbGVkLg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQgY2xvY2stZnJlcXVl
bmN5IHByb3BlcnR5IHRvIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5ncyBvZiB0aGUNCj4gPiA+ID4g
TlhQIHN5c3RlbSBjb3VudGVyLCBzbyB0aGUgZHJpdmVyIGNhbiB0ZWxsIHRpbWVyLW9mIGRyaXZl
ciB0byBnZXQNCj4gPiA+ID4gY2xvY2sgZnJlcXVlbmN5IGZyb20gRFQgZGlyZWN0bHkgaW5zdGVh
ZCBvZiBkb2luZyBvZl9jbGsNCj4gPiA+ID4gb3BlcmF0aW9ucyB2aWEgY2xrIEFQSXMuDQo+ID4g
Pg0KPiA+ID4gV2hpbGUgeW91J3ZlIG5vdyBnaXZlbiBhIGdvb2QgZXhwbGFuYXRpb24gd2h5IHlv
dSBuZWVkIHRoaXMsIGl0IGFsbA0KPiA+ID4gc291bmRzIGxpa2UgbGludXggc3BlY2lmaWMgaXNz
dWVzIGFuZCBhIERUIGNoYW5nZSBzaG91bGQgbm90IGJlIG5lY2Vzc2FyeS4NCj4gPiA+DQo+ID4g
PiBQcmVzdW1hYmx5LCAnY2xvY2tzJyBwb2ludHMgdG8gYSBmaXhlZC1jbG9jayBub2RlLCByaWdo
dD8gSnVzdCBwYXJzZSB0aGUNCj4gJ2Nsb2NrcycNCj4gPiA+IHBoYW5kbGUgYW5kIGZldGNoIHRo
ZSBmcmVxdWVuY3kgZnJvbSB0aGF0IG5vZGUgaWYgeW91IG5lZWQgdG8gZ2V0DQo+ID4gPiB0aGUg
ZnJlcXVlbmN5ICdlYXJseScuDQo+ID4NCj4gPiBTb3VuZCBsaWtlIGEgYmV0dGVyIHNvbHV0aW9u
LCBJIHdpbGwgdHJ5IHRoYXQsIHNpbmNlIHRoZSBzeXN0ZW0NCj4gPiBjb3VudGVyJ3MgY2xvY2sg
aXMgZnJvbSBvc2NfMjRtIGFuZCBkaXZpZGVkIGJ5IDMsIHNpbmNlIGRpZmZlcmVudA0KPiA+IHBs
YXRmb3JtcyBtYXkgaGF2ZSBkaWZmZXJlbnQgZGl2aWRlciwgc28gbWF5YmUgSSBjYW4gY3JlYXRl
IGENCj4gPiBmaXhlZC1jbG9jayBub2RlIGluIERULCB0aGVuIHN5c3RlbSBjb3VudGVyIGRyaXZl
ciBjYW4gcGFyc2UgdGhlIGNsb2NrIGFuZA0KPiBmZXRjaCB0aGUgZnJlcXVlbmN5IGZyb20gdGhh
dCBub2RlLCB3aWxsIHJlZG8gYSBWNSBwYXRjaC4NCj4gDQo+IFRoZSBkaXZpZGUgYnkgMyBjYW4g
YmUgaW1wbGllZCBieSB0aGUgY29tcGF0aWJsZS4gSWYgeW91IG5lZWQgYSBkaWZmZXJlbnQNCj4g
ZGl2aWRlciwgYWRkIGFub3RoZXIgY29tcGF0aWJsZS4NCg0KWWVzLCB3ZSBjYW4gY29uc2lkZXIg
aXQgbGF0ZXIsIHRpbGwgbm93LCBhbGwgdGhlIHBsYXRmb3JtcyB1c2VkIGFyZSB3aXRoIGFuIGlu
dGVybmFsDQpkaXZpZGVyIG9mIDMgaW4gc3lzdGVtIGNvdW50ZXIgYmxvY2ssIHNvIEkgbWFrZSBp
dCBmaXhlZCBkaXZpZGVkIGJ5IDMgaW4gc3lzdGVtIGNvdW50ZXINCmRyaXZlci4NCg0KPiANCj4g
PiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gTm8gY2hhbmdlLg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL254cCxzeXNjdHItdGltZXIudHh0ICAg
ICAgICB8IDE1ICsrKysrKysrKy0tDQo+IC0tLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQNCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbnhw
LHN5c2N0ci10aW1lci50eHQNCj4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdGltZXIvbnhwLHN5c2N0ci10aW1lci50eHQNCj4gPiA+ID4gaW5kZXggZDU3NjU5OS4u
NzA4OGEwZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RpbWVyL254cCxzeXNjdHItdGltZXIudHh0DQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9ueHAsc3lzY3RyLXRpbWVyLnR4dA0KPiA+
ID4gPiBAQCAtMTEsMTUgKzExLDE4IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAt
IHJlZyA6ICAgICAgICAgICAgIFNwZWNpZmllcyB0aGUgYmFzZSBwaHlzaWNhbCBhZGRyZXNzIGFu
ZCBzaXplIG9mIHRoZQ0KPiBjb21hcHJlDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIGZy
YW1lIGFuZCB0aGUgY291bnRlciBjb250cm9sLCByZWFkICYgY29tcGFyZS4NCj4gPiA+ID4gIC0g
aW50ZXJydXB0cyA6ICAgICAgc2hvdWxkIGJlIHRoZSBmaXJzdCBjb21wYXJlIGZyYW1lcycgaW50
ZXJydXB0DQo+ID4gPiA+IC0tIGNsb2NrcyA6ICAgICAgICAgU3BlY2lmaWVzIHRoZSBjb3VudGVy
IGNsb2NrLg0KPiA+ID4gPiAtLSBjbG9jay1uYW1lczogICAgICAgICAgICAgU3BlY2lmaWVzIHRo
ZSBjbG9jaydzIG5hbWUgb2YgdGhpcyBtb2R1bGUNCj4gPiA+ID4gKy0gY2xvY2tzIDogICAgICAg
ICAgU3BlY2lmaWVzIHRoZSBjb3VudGVyIGNsb2NrLCBtdXR1YWxseSBleGNsdXNpdmUgd2l0aA0K
PiBjbG9jay0NCj4gPiA+IGZyZXF1ZW5jeS4NCj4gPiA+ID4gKy0gY2xvY2stbmFtZXMgOiAgICAg
U3BlY2lmaWVzIHRoZSBjbG9jaydzIG5hbWUgb2YgdGhpcyBtb2R1bGUsIG11dHVhbGx5DQo+ID4g
PiBleGNsdXNpdmUgd2l0aA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIGNsb2NrLWZyZXF1
ZW5jeS4NCj4gPiA+ID4gKy0gY2xvY2stZnJlcXVlbmN5IDogU3BlY2lmaWVzIHN5c3RlbSBjb3Vu
dGVyIGNsb2NrIGZyZXF1ZW5jeSwNCj4gPiA+ID4gK211dHVhbGx5DQo+ID4gPiBleGNsdXNpdmUg
d2l0aA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIGNsb2Nrcy9jbG9jay1uYW1lcy4NCj4g
PiA+DQo+ID4gPiBJdCBkb2Vzbid0IHJlYWxseSB3b3JrIHRvIHNheSBvbmUgb3IgdGhlIG90aGVy
IGlzIG5lZWRlZCB1bmxlc3MgeW91DQo+ID4gPiBtYWtlIHRoZSBPUyBzdXBwb3J0IGJvdGggY2Fz
ZXMuDQo+ID4NCj4gPiBUaGUgT1MgYWxyZWFkeSBzdXBwb3J0IGJvdGggY2FzZXMgbm93IHdpdGgg
dGhpcyBwYXRjaCBzZXJpZXMuDQo+IA0KPiBXaGF0IGFib3V0IEZyZWVCU0Qgb3IgYW55IG90aGVy
IE9TPw0KDQpOb3cgdGhhdCBpbiBWNSwgSSB1c2UgdGhlIGZpeGVkIGNsb2NrIG9mIE9TQyBhcyBj
bG9jayBpbnB1dCBvZiBzeXN0ZW0gY291bnRlciwNCm5vIG5lZWQgdG8gaGF2ZSBhbGwgdGhlc2Ug
Y2hhbmdlcyBub3cuIEFuZCBhbHNvIG5vIGNoYW5nZXMgbmVlZGVkIGluIERUDQpiaW5kaW5nLCB0
aGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpBbnNvbi4NCg==
