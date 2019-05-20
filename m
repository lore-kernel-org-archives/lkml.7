Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24761C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B6206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQVfDl1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbfETJcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:32:22 -0400
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:19429
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729030AbfETJcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3Rfa3g+nXDdmOQDRYlRfQr/BcJieVIBp7wafljkUgE=;
 b=cQVfDl1j5pZwpX8GrfrqKsMN3mI/1fNeI7wPBkVdJVMyVF8jrBYOiRD7Uj2IX9w/rEpV+G/7JFO9kvBqcaBFw4hoQJXFlEo+e4oTaaJVA1iUDi8o9VsARojg6L5Y9xokcJPbsMkRashV7vDGwkPoyhu0sGmKb0cnJ/ZJtpVM5qA=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB3422.eurprd04.prod.outlook.com (52.134.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 09:32:15 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::2417:67da:c1aa:29f3]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::2417:67da:c1aa:29f3%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 09:32:15 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Topic: [PATCH v3 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Index: AdUO7epHnSU3J1GET8qTnAQLAE2UrA==
Date:   Mon, 20 May 2019 09:32:15 +0000
Message-ID: <VI1PR0402MB3519CE9CC1BD721708304D2987060@VI1PR0402MB3519.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ec18584-389b-4a52-1f6e-08d6dd060be1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3422;
x-ms-traffictypediagnostic: VI1PR0402MB3422:
x-microsoft-antispam-prvs: <VI1PR0402MB342276EEB26B56DBE13E896C87060@VI1PR0402MB3422.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(189003)(229853002)(6116002)(476003)(3846002)(26005)(6436002)(64756008)(14454004)(2906002)(54906003)(102836004)(186003)(486006)(68736007)(33656002)(66556008)(66446008)(66476007)(7736002)(6506007)(66066001)(6916009)(256004)(66946007)(73956011)(6246003)(74316002)(305945005)(52536014)(7696005)(5660300002)(86362001)(478600001)(81166006)(81156014)(99286004)(8936002)(8676002)(4326008)(53936002)(76116006)(71190400001)(71200400001)(55016002)(9686003)(25786009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3422;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xIaCqtw9wPLGgX6E17JWnhPs9spS2rPufk4EI1FQSgSJ92nL/gNrD6HInp37JxMcR7tbNat3DGD/tPt4A18vJPW8A+0HfG9JO+oy7j/Cyq/6NfNPJP1SyhJtEvF9HwkFmr3K7hFac5+mNGUmcl3RNq0hgNPuB6uxocUfeO0tjfBJxnj+nmFYJwNDE277wD3BPaSa3cRFOG8FVLgB2S8MYy2DDedQYXWV6A01fc9JS3d3JCWI++NByxRa+e/bs6Q7HdD3RNebuXRNvE9PXPQkNtJU4Q75MHZ8surTHrHty6Q0moxtDVsuuJDNlqtuEh6juFfPPf+KwpuvHNxp7fnN7cngiHZDsMZbdFlur9aKAUxxDeQ2fuIxEV6KYDbOKn4d9Ur4cZNYzvQVbDcIo3wXxroiD/mqeGm2DDEsMiqVXw4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec18584-389b-4a52-1f6e-08d6dd060be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 09:32:15.7359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIGRlbGF5ZWQgcmVzcG9uc2UgdG8geW91LCBteSBtYWlsIGNsaWVudCBkaWQgc29t
ZXRoaW5nIHdyb25nLiA6KA0KDQo+IE9uIFdlZCwgMyBBcHIgMjAxOSwgSmFja3kgQmFpIHdyb3Rl
Og0KPiANCj4gPiBGcm9tOiBCYWkgUGluZyA8cGluZy5iYWlAbnhwLmNvbT4NCj4gPg0KPiA+IFRo
ZSBzeXN0ZW0gY291bnRlciAoc3lzX2N0cikgaXMgYSBwcm9ncmFtbWFibGUgc3lzdGVtIGNvdW50
ZXIgd2hpY2gNCj4gPiBwcm92aWRlcyBhIHNoYXJlZCB0aW1lIGJhc2UgdG8gdGhlIENvcnRleCBB
MTUsIEE3LCBBNTMgZXRjIGNvcmVzLg0KPiA+IEl0IGlzIGludGVuZGVkIGZvciB1c2UgaW4gYXBw
bGljYXRpb25zIHdoZXJlIHRoZSBjb3VudGVyIGlzIGFsd2F5cw0KPiA+IHBvd2VyZWQgb24gYW5k
IHN1cHBvcnRzIG11bHRpcGxlLCB1bnJlbGF0ZWQgY2xvY2tzLiBUaGUgc3lzX2N0cg0KPiA+IGhh
cmR3YXJlDQo+ID4gc3VwcG9ydHM6DQo+ID4gIC0gNTYtYml0IGNvdW50ZXIgd2lkdGggKHJvbGwt
b3ZlciB0aW1lIGdyZWF0ZXIgdGhhbiA0MCB5ZWFycykNCj4gPiAgLSBjb21wYXJlIGZyYW1lKDY0
LWJpdCBjb21wYXJlIHZhbHVlKSBjb250YWlucyBwcm9ncmFtbWFibGUgaW50ZXJydXB0DQo+ID4g
ICAgZ2VuZXJhdGlvbg0KPiANCj4gSSBob3BlIHRoYXQncyBhIDw9IGNvbXBhcmUgYW5kIG5vdCBh
ID09IC4uLi4NCj4gDQoNClllcywgaXQgaXMgPD0gY29tcGFyZSwgd2hlbiB0aGUgZnJlZSBydW5u
aW5nIGNvdW50ZXIgdmFsdWUgPj0gdGhlIGNvbXBhcmUgdmFsdWUsIHRoZW4gaW50ZXJydXB0IGlz
IHRyaWdnZXJlZC4NCg0KPiA+ICtzdGF0aWMgdm9pZCBzeXNjdHJfdGltZXJfZW5hYmxlKGJvb2wg
ZW5hYmxlKSB7DQo+ID4gKyAgICAgdTMyIHZhbDsNCj4gPiArDQo+ID4gKyAgICAgdmFsID0gcmVh
ZGwoc3lzX2N0cl9iYXNlICsgQ01QQ1IpOw0KPiA+ICsgICAgIHZhbCAmPSB+U1lTX0NUUl9FTjsN
Cj4gPiArICAgICBpZiAoZW5hYmxlKQ0KPiA+ICsgICAgICAgICAgICAgdmFsIHw9IFNZU19DVFJf
RU47DQo+ID4gKw0KPiA+ICsgICAgIHdyaXRlbCh2YWwsIHN5c19jdHJfYmFzZSArIENNUENSKTsN
Cj4gDQo+IFRoaXMgcmVhZCBpcyByZWFsbHkganVzdCBvdmVyaGVhZC4gV2h5IGFyZW4ndCB5b3Ug
Y2FjaGluZyB0aGUgY29udHJvbCByZWdpc3Rlcg0KPiB2YWx1ZT8gSXQncyBub3QgYSBzZWxmIG1v
ZGlmeWluZyByZWdpc3RlciBhbmQgSSBkb24ndCBzZWUgY29uY3VycmVuY3kgaGVyZQ0KPiBlaXRo
ZXIuDQo+IA0KDQpUaGFua3MsIEkgd2lsbCB1c2UgYSBjYWNoZWQgdmFsdWUgZm9yIGl0Lg0KDQo+
ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHN5c2N0cl9pcnFfYWNrbm93bGVkZ2Uodm9p
ZCkgew0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICogY2xlYXIgdGhlIGVuYWJsZSBiaXQoRU4g
PTApIHdpbGwgY2xlYXINCj4gPiArICAgICAgKiB0aGUgc3RhdHVzIGJpdChJU1RBVCA9IDApLCB0
aGVuIHRoZSBpbnRlcnJ1cHQNCj4gPiArICAgICAgKiBzaWduYWwgd2lsbCBiZSBuZWdhdGVkKGFj
a25vd2xlZGdlZCkuDQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgc3lzY3RyX3RpbWVyX2VuYWJs
ZShmYWxzZSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgdTY0IHN5c2N0cl9y
ZWFkX2NvdW50ZXIodm9pZCkgew0KPiA+ICsgICAgIHUzMiBjbnRfaGksIHRtcF9oaSwgY250X2xv
Ow0KPiA+ICsNCj4gPiArICAgICBkbyB7DQo+ID4gKyAgICAgICAgICAgICBjbnRfaGkgPSByZWFk
bF9yZWxheGVkKHN5c19jdHJfYmFzZSArIENOVENWX0hJKTsNCj4gPiArICAgICAgICAgICAgIGNu
dF9sbyA9IHJlYWRsX3JlbGF4ZWQoc3lzX2N0cl9iYXNlICsgQ05UQ1ZfTE8pOw0KPiA+ICsgICAg
ICAgICAgICAgdG1wX2hpID0gcmVhZGxfcmVsYXhlZChzeXNfY3RyX2Jhc2UgKyBDTlRDVl9ISSk7
DQo+ID4gKyAgICAgfSB3aGlsZSAodG1wX2hpICE9IGNudF9oaSk7DQo+IA0KPiBXaGVuIHdpbGwg
aGFyZHdhcmUgcGVvcGxlIGZpbmFsbHkgZ2V0IGl0PyBJcyBpdCBzbyBkYW1uZWQgaGFyZCB0byBt
YWtlIHRoZQ0KPiByZWFkb3V0IGRvOg0KPiANCj4gICAgICAgICBsbyA9IHJlYWRfbG8oKSAgICAg
ICAgICAtPiBpbnRlcm5hbGx5IGxhdGNoZXMgSEkgaW4gaGFyZHdhcmUNCj4gICAgICAgICBoaSA9
IHJlYWRfaGkoKSAgICAgICAgICAtPiByZWFkcyB0aGUgbGF0Y2hlZCB2YWx1ZQ0KPiANCj4gSXQn
cyBub3Qgcm9ja2V0IHNjaWVuY2UsIGJ1dCBpdCB3b3VsZCBzcGFyZSB0aGVzZSBob3JyaWJsZSBy
ZWFkIGxvb3BzLiBCdXQgc3VyZSwNCj4gcGVyZm9ybWFuY2UgaGFwcGVucyBpbiB3aGl0ZXBhcGVy
cyBhbmQgbWFya2V0aW5nIHNsaWRlcyAuLi4uDQo+IA0KDQpTYWRseSwgaGFyZHdhcmUgcGVvcGxl
IGRvbid0IGltcGxlbWVudCBzdWNoIGludGVybmFsIGxhdGNoIGxvZ2ljLCBzbyB3ZSBuZWVkIHRv
IHVzZSBzdWNoIHJlYWQgbG9vcC4NCg0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gICgodTY0KSBj
bnRfaGkgPDwgMzIpIHwgY250X2xvOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHN5c2N0cl9z
ZXRfbmV4dF9ldmVudCh1bnNpZ25lZCBsb25nIGRlbHRhLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlICpldnQpIHsNCj4gPiArICAg
ICB1MzIgY21wX2hpLCBjbXBfbG87DQo+ID4gKyAgICAgdTY0IG5leHQ7DQo+ID4gKw0KPiA+ICsg
ICAgIHN5c2N0cl90aW1lcl9lbmFibGUoZmFsc2UpOw0KPiA+ICsNCj4gPiArICAgICBuZXh0ID0g
c3lzY3RyX3JlYWRfY291bnRlcigpOw0KPiA+ICsNCj4gPiArICAgICBuZXh0ICs9IGRlbHRhOw0K
PiA+ICsNCj4gPiArICAgICBjbXBfaGkgPSAobmV4dCA+PiAzMikgJiAweDAwZmZmZmY7DQo+ID4g
KyAgICAgY21wX2xvID0gbmV4dCAmIDB4ZmZmZmZmZmY7DQo+ID4gKw0KPiA+ICsgICAgIHdyaXRl
bF9yZWxheGVkKGNtcF9oaSwgc3lzX2N0cl9iYXNlICsgQ01QQ1ZfSEkpOw0KPiA+ICsgICAgIHdy
aXRlbF9yZWxheGVkKGNtcF9sbywgc3lzX2N0cl9iYXNlICsgQ01QQ1ZfTE8pOw0KPiANCj4gUGxl
YXNlIGRvY3VtZW50IHRoYXQgdGhpcyBpcyBhIDw9IGNvbXBhcmF0b3IuIElmIHRoYXQncyBub3Qg
dHJ1ZSB0aGVuIHRoaXMNCj4gZnVuY3Rpb24gaXMgYnJva2VuIGZvciBzbWFsbCBkZWx0YXMgYW5k
IGRlbGF5cyBiZXR3ZWVuIHJlYWRfY291bnRlcigpIGFuZA0KPiBlbmFibGUuDQoNCkl0IGlzIDw9
IGNvbXBhcmF0b3IsIHNvIGl0IGlzIHNhZmUuDQoNCj4gDQo+ID4gKw0KPiA+ICsgICAgIHN5c2N0
cl90aW1lcl9lbmFibGUodHJ1ZSk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHN5c2N0cl9zZXRfc3RhdGVfb25lc2hvdChzdHJ1Y3Qg
Y2xvY2tfZXZlbnRfZGV2aWNlICpldnQpIHsNCj4gPiArICAgICBzeXNjdHJfdGltZXJfZW5hYmxl
KHRydWUpOw0KPiANCj4gVGhhdCdzIHdyb25nLiBXaHkgZG8geW91IHdhbnQgdG8gZW5hYmxlIHRo
ZSB0aW1lciBoZXJlPyBXaGVuIHRoZSBzdGF0ZSBpcw0KPiBzZXQgdG8gb25lIHNob3QgdGhlbiB0
aGUgbmV4dCBvcGVyYXRpb24gaXMgc2V0X25leHRfZXZlbnQoKSBidXQgYmVmb3JlIHRoYXQNCj4g
bm90aGluZyBzaG91bGQgZXZlciBjb21lIG91dCBvZiB0aGUgdGltZXIuDQo+IA0KDQpUaGFua3Ms
IEkgd2lsbCByZW1vdmUgaXQgaW4gVjQuDQoNCkJSDQpKYWNreSBCYWkNCg0KPiBUaGFua3MsDQo+
IA0KPiAgICAgICAgIHRnbHgNCg==
