Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56624C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDBE206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kJMMa5hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfDYNoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:44:13 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:34886
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfDYNoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXadrvWo/MMrUXkY+9OfXOMW1w7nle4YZSh36tluxaU=;
 b=kJMMa5hCGaO88l5JcgjAJECvXOhyShlL0HFVYNOsWkwWNhnLrS75yOZyuloaZYw0Tz5pxMyGKYfFcFiDt8cOEIC9jixTxHbREOtK2HOICYGAfnBFaIUhXh2WL5bzeQfBKYqjFWYkm4pelC+Exv3wYoSNKhIgepXBEp+8feFf3iA=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4125.eurprd04.prod.outlook.com (52.133.14.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 13:44:09 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 13:44:09 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Tang <andy.tang@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [EXT] Re: [PATCH v2] clk: qoriq: Add clockgen support for
 lx2160a
Thread-Index: AQHU+0v+B00Z51pg7EC3G4Yx/RLSjaZMpcWAgAABiCCAAAWOgIAANlDw
Date:   Thu, 25 Apr 2019 13:44:08 +0000
Message-ID: <VI1PR04MB4800B9D8F71166868CB6D209F33D0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
 <CAJZ5v0iwrjonKpA3Skkhkg3g5Pp9Qzx0v2GBYKdv7eM_jL4p8g@mail.gmail.com>
 <VI1PR04MB43336A0C62B956CA29A7E621F33D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <CAJZ5v0jQFXpHmpxSYSUxwGkMV98g3S+zV1oh1RYxvkebmzT29Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jQFXpHmpxSYSUxwGkMV98g3S+zV1oh1RYxvkebmzT29Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e356d6a-6d88-498f-507a-08d6c9841815
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4125;
x-ms-traffictypediagnostic: VI1PR04MB4125:
x-microsoft-antispam-prvs: <VI1PR04MB4125F4AE949F37E031AD508AF33D0@VI1PR04MB4125.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(396003)(376002)(189003)(199004)(13464003)(54534003)(66556008)(66476007)(53936002)(93886005)(64756008)(66446008)(7696005)(486006)(256004)(14444005)(66946007)(26005)(76176011)(73956011)(186003)(76116006)(52536014)(6246003)(8936002)(102836004)(9686003)(55016002)(81166006)(81156014)(8676002)(4326008)(33656002)(6636002)(476003)(99286004)(3846002)(6116002)(86362001)(478600001)(68736007)(446003)(11346002)(305945005)(7736002)(5660300002)(229853002)(54906003)(97736004)(6436002)(14454004)(6506007)(25786009)(53546011)(44832011)(74316002)(71200400001)(316002)(71190400001)(110136005)(2906002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4125;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dvc4f9y3MTjL3WWomGL9l8FVJ1tvdpdKE7QCollr9FyV5EDuz6SPisrGp9X3E42PoKBazpis7+elYOK1XyEeI1BrZcbtFq7lkF4d0k1PktxaEw3tmtK/Nvm95uSaMkUTfuX5FB+BVNaRuzCDZbtnOLtCa4pZWiKPIWcRus/EIZKaDtBrpEMj9rmiRPsjEKo0O1sfSeg93UoYh3kKSV45Tl1VIf+R/d5dTix/7nJGu5QarS1YD/h6HgLduqUUxcnkT48z/dDZc9Ptop7gfuKhDzFPr8pUEE3JTLn2zKBGBw/ttCrTIO2Tf+bTvolqkDGeNoNSmWzNzgQFJtBbD7Yqtfn60bnft9dB/+Dn68uWYq4qiL5QzVlOovQi4jbYYDy8L9ycRuD/MsYImRx6TKEHoLVguuhfil6XcB2vLN0l9XI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e356d6a-6d88-498f-507a-08d6c9841815
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 13:44:09.3197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjUsIDIwMTkg
Mzo1OSBQTQ0KPiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gQ2M6IFJhZmFl
bCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IFZhYmhhdiBTaGFybWENCj4gPHZhYmhh
di5zaGFybWFAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBjbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IHNib3lkQGtl
cm5lbC5vcmc7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyByandAcmp3eXNvY2tpLm5ldDsg
dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7DQo+IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5h
cmF5YW4uZ2F1ckBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2Ml0g
Y2xrOiBxb3JpcTogQWRkIGNsb2NrZ2VuIHN1cHBvcnQgZm9yIGx4MjE2MGENCj4gDQo+IENhdXRp
b246IEVYVCBFbWFpbA0KPiANCj4gT24gVGh1LCBBcHIgMjUsIDIwMTkgYXQgMTI6MTUgUE0gQW5k
eSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZh
ZWxAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMTnlubQ05pyIMjXml6UgMTg6MDQNCj4gPiA+
IFRvOiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+DQo+ID4gPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4g
PiA+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgc2JveWRAa2VybmVsLm9yZzsgbXR1cnF1ZXR0
ZUBiYXlsaWJyZS5jb207DQo+ID4gPiByandAcmp3eXNvY2tpLm5ldDsgdmlyZXNoLmt1bWFyQGxp
bmFyby5vcmc7IFlvZ2VzaCBOYXJheWFuIEdhdXINCj4gPiA+IDx5b2dlc2huYXJheWFuLmdhdXJA
bnhwLmNvbT47IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBb
RVhUXSBSZTogW1BBVENIIHYyXSBjbGs6IHFvcmlxOiBBZGQgY2xvY2tnZW4gc3VwcG9ydCBmb3IN
Cj4gPiA+IGx4MjE2MGENCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPiA+DQo+
ID4gPiBPbiBUaHUsIEFwciAyNSwgMjAxOSBhdCAxMTo0OCBBTSBWYWJoYXYgU2hhcm1hDQo+ID4g
PiA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+
IEZyb206IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPiA+ID4N
Cj4gPiA+ID4gQWRkIGNsb2NrZ2VuIHN1cHBvcnQgZm9yIGx4MjE2MGEuDQo+ID4gPiA+IEFkZGVk
IGVudHJ5IGZvciBjb21wYXQgJ2ZzbCxseDIxNjBhLWNsb2NrZ2VuJy4NCj4gPiA+DQo+ID4gPiBX
ZWxsLCBpZiBJJ20gZXhwZWN0ZWQgdG8gYXBwbHkgdGhpcywgdGhlIGFib3ZlIGlzIGEgYml0IHRl
cnNlLg0KPiA+ID4NCj4gPiA+IEl0IGxvb2tzIGxpa2UgdGhlIHBhdGNoIG1ha2VzIHRoZSBxb3Jp
cS1jcHVmcmVxIGRyaXZlciBoYW5kbGUgc29tZQ0KPiA+ID4gbmV3IGhhcmR3YXJlLCBidXQgdGhl
IGNoYW5nZWxvZyBkb2Vzbid0IHNheSBtdWNoIGFib3V0IHRoYXQuDQo+ID4gPg0KPiA+ID4gSSdt
IGd1ZXNzaW5nIHRoYXQgdGhlIGNsb2NrZ2VuIHN1cHBvcnQgYWRkZWQgaGVyZSBtYWtlcyBpdCBw
b3NzaWJsZQ0KPiA+ID4gZm9yIHFvcmlxLWNwdWZyZXEgdG8gaGFuZGxlIHRoaXMgY2hpcCwgaXMg
dGhhdCBjb3JyZWN0Pw0KPiA+IFllcywgeW91ciBndWVzcyBpcyBjb3JyZWN0LiBUaGUgY3B1ZnJl
cSBmZWF0dXJlIGlzIGJhc2VkIG9uIGNsb2NrIGRyaXZlci4NCj4gPiBJdCBzaG91bGQgaGFkIGJl
ZW4gc2VwYXJhdGVkIHRvIHR3byBwYXRjaGVzIGFuZCByZWR1Y2VkIHRoZSBjb25mdXNlLg0KPiA+
IERvIEkgbmVlZCB0byB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIG9yIHlvdSBqdXN0IHRha2Ug
aXQ/DQo+IA0KPiBQbGVhc2UgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IFRoYW5r
cyENCk9rDQo=
