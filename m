Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F10C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277B52084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XilYRzyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfDZGtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:49:52 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:1344
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfDZGts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agxfFhjzG/itdRxjk62Z1TS6kfiYRHc10H1UdZzBsWA=;
 b=XilYRzyfqUCz8438e0wzZnemZcSdpu/w8DvlejTatwWvF7hISD8Aggaw5vfqs6YURAn3tgSc50mbwaBwiTp+oWdJRxT0+aj4oIGy/UQNGhMqLF1KJglNa+9jhl5m9XZwCMVsY72RwGrl4BFWzpDfPx/t+J3jk/U943WjwBsb+D8=
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com (20.177.32.218) by
 AM6PR04MB5046.eurprd04.prod.outlook.com (20.177.34.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 06:49:43 +0000
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::2c:6837:2927:a618]) by AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::2c:6837:2927:a618%3]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 06:49:43 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Andy Tang <andy.tang@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] clk: qoriq: add support for lx2160a
Thread-Topic: [EXT] Re: [PATCH v3] clk: qoriq: add support for lx2160a
Thread-Index: AQHU+27EnTHp/aOrT06vySVf5Nn13KZNMMmAgADQekA=
Date:   Fri, 26 Apr 2019 06:49:43 +0000
Message-ID: <AM6PR04MB478978C59EA044545A2E90F5F33E0@AM6PR04MB4789.eurprd04.prod.outlook.com>
References: <1556200638-24066-1-git-send-email-vabhav.sharma@nxp.com>
 <155621654326.15276.741983919838675194@swboyd.mtv.corp.google.com>
In-Reply-To: <155621654326.15276.741983919838675194@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.120.0.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92c2b8a1-5677-4bb6-2e01-08d6ca135d5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5046;
x-ms-traffictypediagnostic: AM6PR04MB5046:
x-microsoft-antispam-prvs: <AM6PR04MB504629754D2010F8BC7EDE9AF33E0@AM6PR04MB5046.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(13464003)(189003)(199004)(64756008)(66446008)(66946007)(66476007)(110136005)(54906003)(66556008)(316002)(2201001)(486006)(8936002)(73956011)(5660300002)(7696005)(97736004)(476003)(52536014)(76116006)(2906002)(186003)(26005)(53546011)(6506007)(76176011)(66066001)(446003)(71200400001)(6436002)(71190400001)(102836004)(11346002)(86362001)(6116002)(3846002)(44832011)(55016002)(229853002)(256004)(305945005)(478600001)(33656002)(4326008)(7736002)(14454004)(25786009)(2501003)(9686003)(81166006)(8676002)(81156014)(53936002)(99286004)(68736007)(74316002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5046;H:AM6PR04MB4789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 94NZtJvq1eVNRTESyARjprAu67BrrnVUEmDW0ytEPDZICFGN6enggBypG1/dReGwE6YvcJez1Ds5JLDFeNFoSH0vsk34hs62YP0dYuTgIL2+E5WRd40KoMNcufqVLpL6UqsaaVCnEYhS7vOvUncnIYDTGWoZlfjP64iXnm1EG2LnbDwXBameY4JM5hUjfge7Tdka1WEoeItuGkhyn0AbmqeB4IQ2NfZDWZY7ilCS7n50hI9bZTim17lnvnMTxj8ON1SRKhboKm+dRsFEpFUOd/awz+syYuit9nFwKMVU2yx4NeZKZODhsJjb1aMiC+6xda82uyEwG0R21sHPafGHMB5mTSvw79OGF0/ZpYIjNziazK7bYR9+tX3zS5DzG6u8kqcwF/6VGnZLVWQ6hIiBRnd0EH06/cvvrghNXJ42JIA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c2b8a1-5677-4bb6-2e01-08d6ca135d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 06:49:43.7930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjUsIDIwMTkgMTE6NTIg
UE0NCj4gVG86IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5vcmc7IFZhYmhhdiBTaGFybWEgPHZh
Ymhhdi5zaGFybWFAbnhwLmNvbT4NCj4gQ2M6IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyByandA
cmp3eXNvY2tpLm5ldDsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7DQo+IFlvZ2VzaCBOYXJheWFu
IEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPjsgQW5keSBUYW5nDQo+IDxhbmR5LnRh
bmdAbnhwLmNvbT47IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4gU3Vi
amVjdDogW0VYVF0gUmU6IFtQQVRDSCB2M10gY2xrOiBxb3JpcTogYWRkIHN1cHBvcnQgZm9yIGx4
MjE2MGENCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gUXVvdGluZyBWYWJoYXYgU2hh
cm1hICgyMDE5LTA0LTI1IDA2OjU3OjA1KQ0KPiA+IEZyb206IFlvZ2VzaCBHYXVyIDx5b2dlc2hu
YXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGFuZCBj
b25maWd1cmF0aW9uIGZvciBOWFAgU29DIGx4MjE2MGEgaW4gcW9yaXENCj4gPiBjbG9jayBkcml2
ZXIgd2l0aCBjb21wYXRpYmxlIHByb3BlcnR5IGFzICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIuDQo+
ID4NCj4gPiBxb3JpcS1jcHVmcmVxIGRyaXZlciBpcyBiYXNlZCBvbiBxb3JpcSBjbG9jayBkcml2
ZXIsIGVuYWJsZSBzdXBwb3J0IG9mDQo+ID4gTlhQIFNvQyBseDIxNjBhIGluIHFvcmlxIGNwdWZy
ZXEgZHJpdmVyIHRvIGhhbmRsZSB0aGUgbHgyMTYwYSBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBUYW5nIFl1YW50aWFuIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBZb2dlc2ggR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiA+IEFja2VkLWJ5
OiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0Pg0KPiA+IEFja2VkLWJ5OiBTdGVwaGVuIEJv
eWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+ID4gQWNrZWQtYnk6IFZpcmVzaCBLdW1hciA8dmlyZXNo
Lmt1bWFyQGxpbmFyby5vcmc+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmb3IgdjM6DQo+ID4gLSBJ
bmNvcnBvcmF0ZWQgcmV2aWV3IGNvbW1lbnRzIG9mIFJhZmFlbCBKLiBXeXNvY2tpDQo+ID4gLSBV
cGRhdGVkIGNvbW1pdCBtZXNzYWdlDQo+IA0KPiBJZiB5b3UgY2FuIHNwbGl0IGl0IGludG8gY2xr
IGFuZCBjcHVmcmVxIHRoYXQgd291bGQgYmUgcHJlZmVycmVkLiBUaGVuIEkgY2FuDQo+IHRha2Ug
dGhlIGNsayBwYXJ0IGFuZCBQTSB0cmVlIGNhbiB0YWtlIHRoZSBjcHVmcmVxIHBhcnQuIE90aGVy
d2lzZSwgeW91IGhhdmUNCj4gc2VudCBvdGhlciBwYXRjaGVzIHRvIGRyaXZlcnMvY2xrL2Nsay1x
b3JpcS5jIGFuZCBJJ20gd29ycmllZCB0aGVyZSB3aWxsIGJlDQo+IGNyb3NzIHRyZWUgY29uZmxp
Y3RzIGlmIEkgdGFrZSB0aG9zZSBvdGhlciBwYXRjaGVzIHRoaXMgY3ljbGUuDQpBZ3JlZSwgc3Vy
ZS4NCkkgd2lsbCBzcGxpdCB0aGUgcGF0Y2ggYW5kIHNlbnQgaXQgdG8gY2xrIGFuZCBQTSB0cmVl
Lg0KDQo=
