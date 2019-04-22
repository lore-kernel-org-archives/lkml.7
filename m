Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEDDC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F338F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2iz3lx7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDVIXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:23:34 -0400
Received: from mail-eopbgr700075.outbound.protection.outlook.com ([40.107.70.75]:5345
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfDVIXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBePdVZSm2c2PGoq0V9mTgOdyMJJzI/BzsCDeIoKYS4=;
 b=2iz3lx7lAn51PhYoh82d1F7nltSY6e1QfAqWRJt03aT3Qx7xWfvFWthgWDnZja3D00u9pSFpXlPB7EdTP+Ooky3wu8IGs3YgsLUE0GO4ZVdmcyojvBO8jGaBTG7f1JV2jZPtpUiO7WyyuasKnVV59CVbJ3PzVrDqFPyTUip3ku4=
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) by
 MN2PR12MB3469.namprd12.prod.outlook.com (20.178.242.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Mon, 22 Apr 2019 08:23:29 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c5a0:395e:b9c6:4e5a]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c5a0:395e:b9c6:4e5a%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 08:23:29 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
To:     Cheng-yi Chiang <cychiang@chromium.org>
CC:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Support Opensource <support.opensource@diasemi.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        "yuhsuan@chromium.org" <yuhsuan@chromium.org>,
        "tzungbi@chromium.org" <tzungbi@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: DA7219: Fix failure in hw_params by
 not letting set_rate error out
Thread-Topic: [alsa-devel] [PATCH] ASoC: DA7219: Fix failure in hw_params by
 not letting set_rate error out
Thread-Index: AQHU+NKXxx2OJXUZeEu60aoSrd+M3KZHy1CAgAAMMgA=
Date:   Mon, 22 Apr 2019 08:23:29 +0000
Message-ID: <f0cb97b0-19aa-aff5-0ac4-60406e6e1a97@amd.com>
References: <20190422061334.4243-1-akshu.agrawal@amd.com>
 <CAFv8NwKZskTeyaUQWevydfxZf0=nf+Z4kBOkYynTfiOMOq-LDA@mail.gmail.com>
In-Reply-To: <CAFv8NwKZskTeyaUQWevydfxZf0=nf+Z4kBOkYynTfiOMOq-LDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::33) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3578de0-c895-4952-3b8d-08d6c6fbcc76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3469;
x-ms-traffictypediagnostic: MN2PR12MB3469:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR12MB34695ECA280432779049D03EF8220@MN2PR12MB3469.namprd12.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(199004)(189003)(966005)(256004)(86362001)(31696002)(11346002)(2616005)(476003)(446003)(478600001)(99286004)(6512007)(6306002)(316002)(229853002)(52116002)(4326008)(97736004)(7416002)(36756003)(26005)(102836004)(186003)(53546011)(6506007)(76176011)(386003)(72206003)(53936002)(6916009)(31686004)(5660300002)(486006)(54906003)(14454004)(8936002)(305945005)(6246003)(71190400001)(71200400001)(8676002)(7736002)(2906002)(6116002)(25786009)(66066001)(6486002)(81166006)(81156014)(73956011)(64756008)(66556008)(66476007)(66446008)(66946007)(68736007)(3846002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3469;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iYPujT5uh52QlYitOuGrLquaACvKg4loAzTOcytHS03NY0v6wXkInIqDCxFTwCQvu527Bcze06ixv0ahwWZeM2d2U396plbI01nbWUHV9cFGcfgkjUp6nNhnDW6t7EHoLjIybq4isNylzRFbBjwKuu57h1NG90Imbvd4ruW7xvleD4ejmXz0Jt3SCPfJtrSL6nDSzXqXtXlRQlMuUXaUfxL4RWh6kVDGX2kULwNrSWaVzsDAk/KnrS+Si4XPvvFh2bI43Z/ZanLna6pQJxYljkr5WscpFUTRZtw/BpKHNL7ADzmyXHmWh0BUGy3CcnIViDfg4cXLNaArr83gUZr/Z2789LBIVRBJ6PdPUb5k0sWYuq091kLzcglN0ecM7bQ3LhMMIjNxrorIvX6TE2pvwzFBZ03x56CiiW7D+AEXrQQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A8DFADB8F9D9147A86963DAA545825B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3578de0-c895-4952-3b8d-08d6c6fbcc76
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 08:23:29.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjIvMjAxOSAxOjA5IFBNLCBDaGVuZy15aSBDaGlhbmcgd3JvdGU6DQo+IEhpIEFr
c2h1LA0KPiANCj4gDQo+IE9uIE1vbiwgQXByIDIyLCAyMDE5IGF0IDI6MTUgUE0gQWdyYXdhbCwg
QWtzaHUgPEFrc2h1LkFncmF3YWxAYW1kLmNvbT4gd3JvdGU6DQo+Pg0KPj4gV2UgbmVlZCB0byBz
ZXQgbWluaW11bSBiY2xrIDY0eCBvZiB3Y2xrIGFzIHRoaXMgaXMgaHcgY29uc3RyYWludCBpbiBv
bmUNCj4+IG9mIHRoZSBjb21wb25lbnQgdXNlZC4NCj4+IFNpbmNlLCBjbGtfc2V0X3JhdGUgYW5k
IGNsayBpcyBlbmFibGVkIGluIG1hY2hpbmUgZHJpdmVyIHRoZQ0KPj4gY2xrX3NldF9yYXRlIGlu
IGh3X3BhcmFtcyBvZiBkYTcyMTkgZmFpbHMgYW5kIGVycm9ycyBvdXQgYW5kIHdoZW4gaXQNCj4+
IHRyaWVzIHRvIG92ZXJyaWRlIHRoZSB2YWx1ZS4NCj4+DQo+PiBJbiBjYXNlcyBsaWtlIHRoZXNl
IG5vdCBvbmx5IGNsa19zZXRfcmF0ZSBvZiBkYTcyMTkgY29kZWMgc2hvdWxkIGZhaWwNCj4+IGFu
ZCBub3Qgb3ZlcnJpZGUgdGhlIHZhbHVlIGJ1dCBhbHNvIHNob3VsZCBub3QgZXJyb3Igb3V0Lg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFrc2h1IEFncmF3YWwgPGFrc2h1LmFncmF3YWxAYW1kLmNv
bT4NCj4+IC0tLQ0KPj4gIHNvdW5kL3NvYy9jb2RlY3MvZGE3MjE5LmMgfCA4ICstLS0tLS0tDQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL2RhNzIxOS5jIGIvc291bmQvc29jL2NvZGVj
cy9kYTcyMTkuYw0KPj4gaW5kZXggNWY1ZmEzNDE2YWYzLi5hMDQxZGJmNDQyYWYgMTAwNjQ0DQo+
PiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL2RhNzIxOS5jDQo+PiArKysgYi9zb3VuZC9zb2MvY29k
ZWNzL2RhNzIxOS5jDQo+PiBAQCAtMTYyMSwxMyArMTYyMSw3IEBAIHN0YXRpYyBpbnQgZGE3MjE5
X2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCj4+DQo+PiAg
ICAgICAgICAgICAgICAgaWYgKGJjbGspIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGJj
bGtfcmF0ZSA9IGZyYW1lX3NpemUgKiBzcjsNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IGNsa19zZXRfcmF0ZShiY2xrLCBiY2xrX3JhdGUpOw0KPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHJldCkgew0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZf
ZXJyKGNvbXBvbmVudC0+ZGV2LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJGYWlsZWQgdG8gc2V0IEJDTEsgcmF0ZSAlbHU6ICVkXG4iLA0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJjbGtfcmF0ZSwgcmV0KTsNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsa19zZXRfcmF0ZShiY2xr
LCBiY2xrX3JhdGUpOw0KPiANCj4gSSB0aGluayB0aGlzIG1pZ2h0IG1hc2sgdGhlIHJlYWwgaXNz
dWUgd2hlbiBzZXR0aW5nIHJhdGUgZmFpbHMuDQoNCk5vdCBkb2luZyBhbiBlcnJvciBjaGVjayBm
b3IgY2xrX3NldF9yYXRlIGlzIG5vdCByYXJlIGJlY2F1c2UNCmNsa19zZXRfcmF0ZSBmYWlscyBp
ZiB0aGUgY2xrIHdoaWNoIHlvdSBhcmUgdHJ5aW5nIHRvIHNldCBpcyBhbHJlYWR5DQplbmFibGVk
LiBOb3cgd2UgY2FuIGFkZCBhIGlzX3ByZXBhcmVkIGNoZWNrIGJlZm9yZSBjYWxsaW5nIGNsa19z
ZXRfcmF0ZQ0KYnV0IHRoYXQgd291bGQgYmUgcmVkdW5kYW50IGFzIGNsa19zZXRfcmF0ZSBkb2Vz
IHRoZSBzYW1lIGNoZWNrLg0KDQo+IEEgbW9yZSBmdW5kYW1lbnRhbCBwcm9ibGVtIG1pZ2h0IGJl
IHdoYXQgYXJlIHRoZSBhY2NlcHRhYmxlIHJhdGlvcw0KPiBiZXR3ZWVuIGJjbGsgYW5kIHdjbGsu
DQo+IA0KDQphY2NlcHRhYmxlIHJhdGlvcyBmb3IgZGE3MjE5IGZyb20gc3BlYyBhcmU6DQowMCA9
IDMyIEJDTEtTIHBlciBXQ0xLDQowMSA9IDY0IEJDTEtTIHBlciBXQ0xLDQoxMCA9IDEyOCBCQ0xL
IHBlciBXQ0xLDQoxMSA9IDI1NiBCQ0xLIHBlciBXQ0xLDQoNCmRhNzIxOSBkZXJpdmVzIHRoaXMg
cmF0aW9uIGZyb20gU1IgZm9yIGEgd2Nsay4gVGhlIHNhbWUgd2UgZG8gaW4gbWFjaGluZQ0KZHJp
dmVyLg0KQ29uZmxpY3QgY29tZXMgb25seSBpbiBjYXNlIG9mIGFuIGV4Y2VwdGlvbiB3aGVyZSB0
aGVyZSBpcyBjb25zdHJhaW50DQpmcm9tIGEgaHcgY29tcG9uZW50LiBFbHNlIHdoZW4gdGhlIGF1
ZGlvIGlzIHBsYXllZCBvbiBkYTcyMTkgY29kZWMgd2UNCmNvdWxkIGhhdmUgbGV0IGRhNzIxOSBv
bmx5IHNldCByYXRlIGFuZCBlbmFibGUgY2xrcy4NCg0KVGhhbmtzLA0KQWtzaHUNCg0KPiBGcm9t
IGV4aXN0aW5nIGNvZGUgb2YgZGE3MjE5IEkgc2VlIHRoZXJlIGFyZSBvbmx5IHR3byBjaG9pY2Vz
IG9mDQo+IGZyYW1lX3NpemU6IDMyIG9yIDY0Lg0KPiANCj4gSW4gZGE3MjE5X2h3X3BhcmFtczoN
Cj4gLi4uDQo+IGlmIChkYTcyMTktPm1hc3RlciAmJiAhZGE3MjE5LT50ZG1fZW4pIHsNCj4gICBp
ZiAoKHdvcmRfbGVuICogREE3MjE5X0RBSV9DSF9OVU1fTUFYKSA8PSAzMikNCj4gICAgICBmcmFt
ZV9zaXplID0gMzI7DQo+ICAgZWxzZQ0KPiAgICAgIGZyYW1lX3NpemUgPSA2NDsNCj4gDQo+IEFu
ZCBpbiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS80LzE3LzMyMg0KPiB0aGUgY2hvaWNlIGZy
b20gbWFjaGluZSBkcml2ZXIgaXMgNjQgb3IgaGlnaGVyLg0KPiANCj4gSW4gY3pfZGE3MjE5X3Bh
cmFtczoNCj4gIC4uLg0KPiAgaWYgKGJjbGsgPCAod2NsayAqIDY0KSkNCj4gICBiY2xrID0gd2Ns
ayAqIDY0Ow0KPiAgcmV0dXJuIGRhNzIxOV9jbGtfZW5hYmxlKHN1YnN0cmVhbSwgd2NsaywgYmNs
ayk7DQo+IA0KPiBJIGRvbid0IGtub3cgd2hhdCBpcyB0aGUgYmVzdCBzb2x1dGlvbiB0byBhdm9p
ZCB0aGlzIGNvbmZsaWN0Lg0KPiBNYXliZSBqdXN0IHNldCBhIGZpeGVkIHJhdGlvIGZyb20gZGV2
aWNlIHByb3BlcnR5IHRoYXQgY2FuIGJlc3Qgd29yaw0KPiBmb3IgdGhlIGNvbWJpbmF0aW9uIG9m
IGNvZGVjcyBvbiB0aGUgbWFjaGluZT8NCj4gDQo+IA0KPiANCj4gDQo+IA0KPj4gICAgICAgICAg
ICAgICAgIH0gZWxzZSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBkYTcyMTlf
c2V0X2JjbGtzX3Blcl93Y2xrKGNvbXBvbmVudCwgZnJhbWVfc2l6ZSk7DQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+PiAtLQ0KPj4gMi4xNy4xDQo+Pg0KPj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IEFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0DQo+PiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcNCj4+IGh0dHBzOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbA0K
