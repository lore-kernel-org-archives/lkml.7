Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C11213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TjUclnJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfCNCKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:10:15 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:42308
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfCNCKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57dLfP8eqPjyG6hvLfLGcWxDud1cE7q5VlJpzVCjacM=;
 b=TjUclnJyr3CVNO92h2h02sI2r9PjnglRRrg4bphUq0CCD3jiA+hS8Uy1uQknZofCr2UuctVba6cpoDFR3nPS9Lh8b6/Z2yeQgrZiTt0CkNt8fptrSxfXv8EgxvP4MfJ3nM8jXRCkMKan0VcPRHvex/T4alXIXWHhKmnNFsLOilQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3851.eurprd04.prod.outlook.com (52.134.73.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Thu, 14 Mar 2019 02:10:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 02:10:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: RE: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog
 binding
Thread-Index: AQHUx1azBL+yCPCH8ke6RA/LaBE/tKXsQYyAgAFkewCAAKW9YIAABU2AgAGCOQCAAtQPAIANitkAgAbhPwCAA3C6IA==
Date:   Thu, 14 Mar 2019 02:10:05 +0000
Message-ID: <DB3PR0402MB391699A42921B2F037D9A45BF54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
 <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
 <AM0PR04MB4211EAEA6F03465D372B0B4F804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAL_JsqJiKx8UvZ8qu-YaaPooLbSMKANSX=YZQO=Nm_anD2v9gw@mail.gmail.com>
In-Reply-To: <CAL_JsqJiKx8UvZ8qu-YaaPooLbSMKANSX=YZQO=Nm_anD2v9gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b930c751-08ed-4e1f-f005-08d6a8222cf7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3851;
x-ms-traffictypediagnostic: DB3PR0402MB3851:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM4NTE7MjM6dk9LZGVSdm84ZElvUWppTWVqc3ZHT2F3?=
 =?utf-8?B?OTg3Y1hOWk9EY0ZVRlRRUm1Xak45UjB0UzdvYWQwVW9SSG53VC9vUW4zN0g0?=
 =?utf-8?B?ejR6WUpERmtUS1ZkQlJuM3d4OWJqL1dSQ2p0c1hWZTNXdk5oSGpEY0VIM2Uy?=
 =?utf-8?B?OVBRTUZtYm0xUGJYV0E5ZzRVY2d3YmlXcHZ5Szh0aHlDM0d4dUE3MkdscFk3?=
 =?utf-8?B?RkVxR2RFOGZBMTI0cVF1VUdlbkhkL2YvWUxBWkY3WFl0NFRiSFVEY1FkUW1G?=
 =?utf-8?B?VlZzK3crTjlkQnBDY0FyWjNNbUZ4a3d1aTh3YUtVbWZ6ajA5Q3cwWWRDNXpG?=
 =?utf-8?B?a0tEM0FpbTcyaVVRazBoZVVLTnJzQlZvSitmWEE0Vittb3dZTkRaS0dQc1Ba?=
 =?utf-8?B?VjFua3U5TXpKMHRwT004eUlPZDQ1SldwWHpuZWMwZzdGNjNwSGtZQjc0Y3p5?=
 =?utf-8?B?d095c0RnV25Xd3RZUk1zWUpLR0JMOUJYLy9pKzZGZzFvY0lTOFhxMldOdzk3?=
 =?utf-8?B?ZHFZS3NUS0dzWStiZUl1TUhHcVg2MW9WMXIvUlFFd0phZjdrSHZNU3BNb25l?=
 =?utf-8?B?THlIQ0EwT0ZUR2NWZzUrRVlFWllHUUtPSE51czlQZHRTL2tELzc5LytzaTBV?=
 =?utf-8?B?RjErSTNqaTZtRlpYZXM5ckU4K0k1a05Mbm5yaDZnTURCcGVrNUdnbkhDNkJi?=
 =?utf-8?B?NnNORDdlSTNqcVFST25taFhHdWp2RGhPdzdoODNBS3ZuZTFMNkVxaG5GSkNt?=
 =?utf-8?B?a1VjaldyWDlqVVMyRlhTWG5CNmpTR2ZyQjdCTDEwL3U1TTkxa05UNXRwYmFz?=
 =?utf-8?B?c3hCampjRmtvLzl2WllBcmNWVGhOZWRwd1ZXOXJFa2V2eVNGeml0azVKTzAr?=
 =?utf-8?B?cXAwWmFIVi9WYkNNSHhQZ0l4UXZ4MkhoeGQ4ZkxTd2t6SDVYWW43WGs1UURy?=
 =?utf-8?B?SlZKRU8wTFYvanhNVVQzT2FsOW9ocW93eHpRTDRYWkJRcWxvdWd1TzBNY0Fl?=
 =?utf-8?B?dTRGOTcrSUxMd3AxeWt2Vk85KzhLTnU2N3RBV2FFY3dQcUlFbFNlbGROYzN6?=
 =?utf-8?B?emYyY3RQOFpqUnFlMTNxSlRSTU5OODgvLzVUZ1o1QnRRLzRSN1c0Y3dBTitU?=
 =?utf-8?B?OEMrY1YrUUMva0JYbEpEaUpaaGpBODhJVHdYRThsc01tcVpxM1cxRW9oUitZ?=
 =?utf-8?B?bkVmdnloYXgwTHVsblpFcHBvYzFNckxXM25nZWtTQ3ZENlpJekN6R0F3N0J0?=
 =?utf-8?B?WlYyajVjUlg5U0c5S3JWL1RoVkNvU3MvMmZWalNtaTVqRDJvMjR3OGFCcUl2?=
 =?utf-8?B?QnJZM1pyYlVCVGZIUGgyd2tWNUtLdHdwbWJKNUM4bGVTMnFzWVVqN0dqeEZI?=
 =?utf-8?B?QkwrcVQ3QTYzS2JTSHJiUWJuQUUzSWRUQnZFQmRpRlF1bXhwR3pQKzVMNlZq?=
 =?utf-8?B?MHB1YTROcHk2MWp2ODJCUU9JSGJaS1JpbVRML010b2pENDYwZzYxRWdiNzBy?=
 =?utf-8?B?OWhtRnQ5TDJJcEV6VVdNZE9WWWJOQ0t0dGVFa1YrTzZidm1ka3EvalJ5YnVq?=
 =?utf-8?B?cGZIWHBuQ2NlbFNRbjlPU2ZoN3RCY2dxQjFGNnBxWHFkbFN0UmdpVys5TWJB?=
 =?utf-8?B?cnVvU3RKR0pZWTBuUU1SNHdLRDdoVkdMRlN3c3dCTnVvZk9majRZRFlqczBl?=
 =?utf-8?B?VlZmYUJYQzBXUFc3VzdyRWxQNnFoU0RCUjFuUktjbldXYjNZQldOMmRtN282?=
 =?utf-8?B?UXEya3ljc2xGNnRNcDdjTFl3Wmp4OENXbG5uT0JxanpLZ00rWWdsNk5kalVq?=
 =?utf-8?B?T0hINXpjeThlQ0QzTHh6ZUwxSGRXVTFxYWlTcFBjSG01VFd4Zkl3VEV1ems3?=
 =?utf-8?Q?y6F6tPNQ+gj2c=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3851D4810345DFA7333CCAC7F54B0@DB3PR0402MB3851.eurprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(13464003)(189003)(81156014)(8676002)(81166006)(25786009)(93886005)(316002)(54906003)(110136005)(14444005)(33656002)(256004)(6116002)(97736004)(229853002)(71200400001)(6436002)(305945005)(71190400001)(9686003)(7736002)(74316002)(2906002)(55016002)(3846002)(68736007)(76176011)(102836004)(6506007)(53546011)(446003)(6636002)(7696005)(66066001)(4326008)(476003)(6246003)(5660300002)(8936002)(99286004)(11346002)(14454004)(53936002)(86362001)(44832011)(478600001)(486006)(186003)(105586002)(7416002)(26005)(106356001)(52536014)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3851;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pVatc3mJqeWzyzAmYpy/DDaLYYz2DNtv9XitpwG9mdf61WEwKb1pKo8KUZUJjFhfVywiGPtWRwjy0UVW4EGV07uLt3z4hjhlo8c7wjphh6KufhzGRpK92903HCMtDwnEeW/hX+Zrw1omHm9CF+UniD9H/bpQhK7kSzQO0iIqr1Ks3xoc3nsTkydea5pZ0UKowPEEsBIxqB/8JC/cCS5kFvQ/tliHY99bF08MPKZ/3T6HChWN+//uT8Yk0iVE4EnnfQIf0HOLKhvzXyvh1BJf+4XSm6kgSINn9ZvOlff4PemcHKWQhvOMrlmQWFAtxeQGXQwbza2ahb7mbgTfIvHd1tUEOqVApZNLpvAogWj/USLnK4of8c1mDKnUlh8P2iRQKm00ziD55TvPw+gNVX7df08s2CWw5kpFIxnawJoomSU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b930c751-08ed-4e1f-f005-08d6a8222cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 02:10:05.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDE55bm0M+aciDEy5pelIDU6MjYNCj4gVG86IEFpc2hlbmcgRG9uZyA8YWlz
aGVuZy5kb25nQG54cC5jb20+DQo+IENjOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNv
bT47IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLQ0KPiB1cy5uZXQ+OyBtYXJrLnJ1dGxhbmRA
YXJtLmNvbTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgaGVpa29Ac250ZWNoLmRlOw0KPiBjYXRh
bGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gYmpvcm4uYW5kZXJz
c29uQGxpbmFyby5vcmc7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gamFnYW5AYW1hcnVsYXNvbHV0
aW9ucy5jb207IEFuZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47IGRsLQ0KPiBsaW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGFybmRAYXJuZGIuZGU7IG1hcmMudy5n
b256YWxlekBmcmVlLmZyOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBlbnJpYy5iYWxsZXRi
b0Bjb2xsYWJvcmEuY29tOw0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgd2ltQGxpbnV4
LXdhdGNoZG9nLm9yZzsgRGFuaWVsIEJhbHV0YQ0KPiA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBvbG9mQGxpeG9tLm5ldDsNCj4g
c2hhd25ndW9Aa2VybmVsLm9yZzsgSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVyQGxpbmFy
by5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIFYyIDEvNF0gZHQtYmluZGluZ3M6
IGZzbDogc2N1OiBhZGQgd2F0Y2hkb2cNCj4gYmluZGluZw0KPiANCj4gK0plbnMgVw0KPiANCj4g
T24gVGh1LCBNYXIgNywgMjAxOSBhdCA2OjIyIEFNIEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25n
QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGkgUm9iLA0KPiA+DQo+ID4gPiA+ID4gSSB0
aGluayBSb2Igc3VnZ2VzdGVkIHRoYXQgdGhlIFNDVSBwYXJlbnQgZHJpdmVyIHNob3VsZA0KPiA+
ID4gPiA+IGluc3RhbnRpYXRlIHRoZSB3YXRjaGRvZyB3aXRob3V0IGV4cGxpY2l0IHdhdGNoZG9n
IG5vZGUuIFRoYXQNCj4gPiA+ID4gPiB3b3VsZCBiZSBwb3NzaWJsZSwgYnV0IGl0IGN1cnJlbnRs
eSB1c2VzDQo+ID4gPiA+ID4gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIHRvIGRvIHRoZSBp
bnN0YW50aWF0aW9uLCBhbmQNCj4gPiA+ID4gPiBjaGFuZ2luZyB0aGF0IHdvdWxkIGJlIGEgbWVz
cy4gQmVzaWRlcywgaXQgZG9lcyBzZW0gdG8gbWUgdGhhdA0KPiA+ID4gPiA+IHlvdXIgc3VnZ2Vz
dGVkIG5vZGUgd291bGQgZGVzY3JpYmUgdGhlIGhhcmR3YXJlLCBzbyBJIGFtIG5vdA0KPiA+ID4g
PiA+IHN1cmUgSSB1bmRlcnN0YW5kIHRoZQ0KPiA+ID4gcmVhc29uaW5nLg0KPiA+ID4NCj4gPiA+
IEl0IHdvdWxkIGp1c3QgYmUgYSBjYWxsIHRvIGNyZWF0ZSBhIHBsYXRmb3JtIGRldmljZSBpbnN0
ZWFkLiBIb3cgaXMgdGhhdCBhDQo+IG1lc3M/DQo+ID4gPg0KPiA+ID4gSXQncyBkZXNjcmliaW5n
IGZpcm13YXJlLiBXZSBoYXZlIERUIGZvciBkZXNjcmliaW5nIGgvdyB3ZSd2ZSBmYWlsZWQNCj4g
PiA+IHRvIG1ha2UgZGlzY292ZXJhYmxlLiBXZSBzaG91bGQgbm90IHJlcGVhdCB0aGF0IGFuZCBq
dXN0IGRlc2NyaWJlDQo+IGZpcm13YXJlIGluIERULg0KPiA+ID4gTWFrZSB0aGUgZmlybXdhcmUg
ZGlzY292ZXJhYmxlISBUaG91Z2ggdGhlcmUgYXJlIGNhc2VzIGxpa2UgZmlybXdhcmUNCj4gPiA+
IHByb3ZpZGVkIGNsb2NrcyB3aGVyZSB3ZSBzdGlsbCBuZWVkIHNvbWV0aGluZyBpbiBEVCwgYnV0
IHRoaXMgaXMgbm90DQo+ID4gPiBvbmUgb2YgdGhlbS4NCj4gPiA+DQo+ID4NCj4gPiBUaGUgd2F0
Y2hkb2cgbm9kZSBoZXJlIGluIHF1ZXN0aW9uIGFjdHVhbGx5IGlzIG5vdCB1c2luZyBTQ1UgZmly
bXdhcmUgY2FsbC4NCj4gPiBEdWUgdG8gc2VjdXJpdHkgcmVxdWlyZW1lbnQgYnkgU0NVLCB3YXRj
aGRvZyBjYW4gb25seSBiZSBhY2Nlc3NlZCBpbg0KPiA+IHNlY3VyaXR5IG1vZGUsIGZvciBJTVgg
Y2FzZSwgdmlhIEFSTSBUcnVzdCBGaXJtd2FyZS4gVGhhdCBtZWFucyB0aGUNCj4gPiB3YXRjaGRv
ZyB1c2VkIGluIExpbnV4IGFjdHVhbGx5IGlzIHVzaW5nIEFSTSBTTUMgY2FsbCBhbmQgZG9lcyBu
b3QNCj4gPiBkZXBlbmQgU0NVIGRyaXZlci4gU28gSXQgd291bGQgYmUgc3RyYW5nZSBmb3IgU0NV
IGRyaXZlciB0byBpbnN0YW50aWF0ZSBpdC4NCj4gPg0KPiA+IEZvciB0aGlzIHNpdHVhdGlvbiwg
ZG8geW91IHRoaW5rIHdlIGNhbiBtb3ZlIHdhdGNoZG9nIG91dCBvZiBzY3Ugbm9kZT8NCj4gPiBN
YXliZSByZW5hbWUgdGhlIGNvbXBhdGlibGUgc3RyaW5nIGxpa2UgImZzbCxpbXg4cXhwLXNpcC13
YXRjaGRvZyINCj4gPiBiZWNhdXNlIGl0J3MgYWN0dWFsbHkgYSB3YXRjaGRvZyBzZXJ2aWNlZCBi
eSBBVEYgZmlybXdhcmUuDQo+IA0KPiBZZXMsIGJ1dCB0aGF0IGNyZWF0ZXMgbW9yZSBxdWVzdGlv
bnMuIFdoYXQgZXhhY3RseSBkb2VzIEFURiB0YWxrIHRvIGZvciB0aGUNCj4gd2F0Y2hkb2c/IFRo
ZSBTQ1UgZmlybXdhcmU/DQoNClllcywgQVRGIHRhbGtzIHRvIFNDVSBmaXJtd2FyZSBkaXJlY3Rs
eSwgTGludXgga2VybmVsIHdhdGNoZG9nIGRyaXZlciBjYWxsIFNNQyBpbnN0cnVjdGlvbnMNCnRv
IHNlbmQgY29tbWFuZCB0byBBVEYsIGFuZCBBVEYgd2lsbCBjYWxsIFNDVSBmaXJtd2FyZSBBUEkg
dG8gZmluaXNoIHRoZSBvcGVyYXRpb24gcmVxdWVzdGVkDQpieSBMaW51eCBrZXJuZWwgd2F0Y2hk
b2cgZHJpdmVyLg0KDQo+IA0KPiBNYXliZSBBVEYgc2hvdWxkIGRlZmluZSBhbmQgcHJvdmlkZSBh
IHN0YW5kYXJkIHdhdGNoZG9nIGludGVyZmFjZT8gSXQgaXMNCj4gc3RpbGwgYSBxdWVzdGlvbiBv
ZiBtYWtpbmcgdGhlIGZpcm13YXJlIGRpc2NvdmVyYWJsZSByYXRoZXIgdGhhbiB0cnlpbmcgdG8N
Cj4gZGVzY3JpYmUgdGhlIGZpcm13YXJlIGluIERULg0KDQpUaGUgU01DIGNhbGwgYnkgTGludXgg
a2VybmVsIHdhdGNoZG9nIGFscmVhZHkgZm9sbG93IHRoZSBTSVAoc2lsaWNvbiBwcm92aWRlcikg
c3RhbmRhcmQsIGVhY2gNClNvQyBjYW4gZGVmaW5lIGl0cyBvd24gcHJvdG9jb2wgZm9yIFNJUC4g
QVRGIGRvZXMgTk9UIGhhdmUgYSBzdGFuZGFyZCBjb21tb24gd2F0Y2hkb2cgaW50ZXJmYWNlDQpu
b3csIHNpbmNlIGl0IGlzIG1vcmUgbGlrZSBhIHBsYXRmb3JtIHNwZWNpZmljIGZlYXR1cmUsIG1v
c3Qgb2YgcGxhdGZvcm1zIGNhbiBjb250cm9sIHdhdGNoZG9nIGRpcmVjdGx5DQpmcm9tIExpbnV4
IGtlcm5lbCBJIHRoaW5rLiANCg0KU28sIGRvIHlvdSBoYXZlIHN1Z2dlc3Rpb24gZm9yIHRoaXMg
Y2FzZT8gRWl0aGVyIGZpbmQgYSBwbGFjZSBpbiBEVCB0byBwdXQgd2F0Y2hkb2cgbm9kZSwgb3Ig
bWFrZSBpdA0KYSBidWlsZC1pbiBkZXZpY2UgaW5zaWRlIFNDVSBkcml2ZXI/IE9yIHlvdSBoYXZl
IG90aGVyIGJldHRlciBpZGVhcz8NCg0KVGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+IFJvYg0K
