Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612B1C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AAE2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l1bwdwT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEID6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 23:58:10 -0400
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:60670
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbfEID6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpGlwJHmEXiGpkDz+SKaOqwgrxGwYCjqEHXiAaPXRjc=;
 b=l1bwdwT8uEv5hAtnzMnESJ6BA1X4nI/isCy0JOAlsVze1pA7dEwFpwiY/mDpofeHHR/OHoimn5LW6LCnJRaGPB4gYem6+hVqnLyM8EUDoQ2YNqp43Vv+BG7o7DEFEQB7hRMxHB6Xqeiruv9hDpTyoQPcwqx7FyWV4Jg22YEUM6o=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4317.eurprd04.prod.outlook.com (52.134.31.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 03:58:04 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 03:58:04 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Suresh Gupta <suresh.gupta@freescale.com>
Subject: RE: [EXT] Re: [PATCH v5 4/5] usb: host: Stops USB controller init if
 PLL fails to lock
Thread-Topic: [EXT] Re: [PATCH v5 4/5] usb: host: Stops USB controller init if
 PLL fails to lock
Thread-Index: AQHVBWPwtPsu0fLjhE+qRODS4vtH+6ZhcX6AgAC5hiA=
Date:   Thu, 9 May 2019 03:58:04 +0000
Message-ID: <VI1PR04MB4158AA40AB4A4E60711FD580E9330@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190508060608.33882-4-yinbo.zhu@nxp.com>
 <Pine.LNX.4.44L0.1905081248440.1699-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1905081248440.1699-100000@iolanthe.rowland.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 843b58be-f38d-4ab0-8b5d-08d6d43289f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4317;
x-ms-traffictypediagnostic: VI1PR04MB4317:
x-microsoft-antispam-prvs: <VI1PR04MB4317F2B9FDE90D536E57550AE9330@VI1PR04MB4317.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(13464003)(229853002)(305945005)(74316002)(81166006)(76116006)(102836004)(7736002)(52536014)(66066001)(26005)(99286004)(186003)(6116002)(2906002)(3846002)(9686003)(73956011)(6246003)(66446008)(107886003)(4326008)(53936002)(53546011)(6916009)(6506007)(25786009)(86362001)(66946007)(64756008)(66556008)(66476007)(2171002)(71190400001)(68736007)(71200400001)(55016002)(476003)(33656002)(5660300002)(81156014)(486006)(8676002)(44832011)(446003)(11346002)(6436002)(14444005)(256004)(478600001)(54906003)(316002)(8936002)(7696005)(14454004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4317;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nZNIemHESZFyPSIVsUvthyZgXLSq3wNtIax8l6yiR1mIwoaWB9W8pWJfOLAppsp7rQKb31Vaha+ao/qTCcEQ46Itg5gnEdhfAglmNZ/nwM8V0S2nWKidOGTCR1hX3jyb5t+ToZvXYJsOrWoGRzJP9ngIOqJt7Oc08dxQ/OlMEuw1ZMjVDaov/qmvG6w8FhE+OoLndF5jcJmel9MizUc7TNlmkzz068M82Mjzm9lXlfd2vpPU2zcM7Qte4ZYlL5nRESgxx7ISkXbS06PB9qVDZLOGZglITYyUkXUcp1tmL2OYOOcATIWWWqTYNytM+D2/7G9g6QNenAHwSXSr0LOYmRf+NYUNDisLUcbHpCA9ivNknU4wqCAI5v8VSU8W/BcOl7CQo8KCEH4x4VOBqxv52JHeby6E83xXVj1K8Q4r8BA=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843b58be-f38d-4ab0-8b5d-08d6d43289f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 03:58:04.5626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxhbiBTdGVybiBbbWFp
bHRvOnN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHVdDQo+IFNlbnQ6IDIwMTnE6jXUwjnI1SAwOjUw
DQo+IFRvOiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KPiBDYzogWGlhb2JvIFhpZSA8
eGlhb2JvLnhpZUBueHAuY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz47IFJhbW5lZWsgTWVocmVzaA0KPiA8cmFtbmVlay5tZWhyZXNoQGZyZWVz
Y2FsZS5jb20+OyBOaWtoaWwgQmFkb2xhDQo+IDxuaWtoaWwuYmFkb2xhQGZyZWVzY2FsZS5jb20+
OyBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAuY29tPjsNCj4gbGludXgtdXNiQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmlhZmVpIFBhbg0KPiA8amlhZmVp
LnBhbkBueHAuY29tPjsgU3VyZXNoIEd1cHRhIDxzdXJlc2guZ3VwdGFAZnJlZXNjYWxlLmNvbT4N
Cj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2NSA0LzVdIHVzYjogaG9zdDogU3RvcHMgVVNC
IGNvbnRyb2xsZXIgaW5pdCBpZiBQTEwgZmFpbHMgdG8NCj4gbG9jaw0KPiANCj4gQ2F1dGlvbjog
RVhUIEVtYWlsDQo+IA0KPiBPbiBXZWQsIDggTWF5IDIwMTksIFlpbmJvIFpodSB3cm90ZToNCj4g
DQo+ID4gRnJvbTogUmFtbmVlayBNZWhyZXNoIDxyYW1uZWVrLm1laHJlc2hAZnJlZXNjYWxlLmNv
bT4NCj4gPg0KPiA+IFVTQiBlcnJhdHVtLUEwMDY5MTggd29ya2Fyb3VuZCB0cmllcyB0byBzdGFy
dCBpbnRlcm5hbCBQSFkgaW5zaWRlDQo+ID4gdWJvb3QgKHdoZW4gUExMIGZhaWxzIHRvIGxvY2sp
LiBIb3dldmVyLCBpZiB0aGUgd29ya2Fyb3VuZCBhbHNvIGZhaWxzLA0KPiA+IHRoZW4gVVNCIGlu
aXRpYWxpemF0aW9uIGlzIGFsc28gc3RvcHBlZCBpbnNpZGUgTGludXguDQo+ID4gRXJyYXR1bS1B
MDA2OTE4IHdvcmthcm91bmQgZmFpbHVyZSBjcmVhdGVzICJmc2wsZXJyYXR1bV9hMDA2OTE4Ig0K
PiA+IG5vZGUgaW4gZGV2aWNlLXRyZWUuIFByZXNlbmNlIG9mIHRoaXMgbm9kZSBpbiBkZXZpY2Ut
dHJlZSBpcyB1c2VkIHRvDQo+ID4gc3RvcCBVU0IgY29udHJvbGxlciBpbml0aWFsaXphdGlvbiBp
biBMaW51eA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFtbmVlayBNZWhyZXNoIDxyYW1uZWVr
Lm1laHJlc2hAZnJlZXNjYWxlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdXJlc2ggR3VwdGEg
PHN1cmVzaC5ndXB0YUBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpbmJvIFpo
dSA8eWluYm8uemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlIGluIHY1Og0KPiA+ICAg
ICAgICAgICAgICAgdXNlIGRldl93YXJuKCkgaW5zdGVhZCBvZiBwcl93YXJuKCkNCj4gPg0KPiA+
ICBkcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMgICAgICB8ICAgIDUgKysrKysNCj4gPiAgZHJp
dmVycy91c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMgfCAgICAzICsrLQ0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2kt
ZnNsLmMNCj4gPiBpbmRleCAxNjM0YWM4Li45MDU1MGE2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvdXNiL2hvc3QvZWhjaS1mc2wuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1m
c2wuYw0KPiA+IEBAIC0yMzYsNiArMjM2LDExIEBAIHN0YXRpYyBpbnQgZWhjaV9mc2xfc2V0dXBf
cGh5KHN0cnVjdCB1c2JfaGNkICpoY2QsDQo+ID4gICAgICAgICAgICAgICBwb3J0c2MgfD0gUE9S
VF9QVFNfUFRXOw0KPiA+ICAgICAgICAgICAgICAgLyogZmFsbCB0aHJvdWdoICovDQo+ID4gICAg
ICAgY2FzZSBGU0xfVVNCMl9QSFlfVVRNSToNCj4gPiArICAgICAgICAgICAgIGlmIChwZGF0YS0+
aGFzX2ZzbF9lcnJhdHVtX2EwMDY5MTgpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgZGV2
X3dhcm4oZGV2LCAiVVNCIFBIWSBjbG9jayBpbnZhbGlkXG4iKTsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4gKw0KPiAN
Cj4gWW91IG5lZWQgdG8gYWRkIGEgIkZhbGwgdGhyb3VnaCIgY29tbWVudCBiZXR3ZWVuIHRoZXNl
IHR3byBjYXNlcy4NCj4gPiAgICAgICBjYXNlIEZTTF9VU0IyX1BIWV9VVE1JX0RVQUw6DQo+ID4g
ICAgICAgICAgICAgICAvKiBQSFlfQ0xLX1ZBTElEIGJpdCBpcyBkZS1mZWF0dXJlZCBmcm9tIGFs
bCBjb250cm9sbGVyDQo+ID4gICAgICAgICAgICAgICAgKiB2ZXJzaW9ucyBiZWxvdyAyLjQgYW5k
IGlzIHRvIGJlIGNoZWNrZWQgb25seSBmb3INCj4gDQo+IEFsYW4gU3Rlcm4NCkhpIEFsYW4gU3Rl
cm4sDQoNCllvdXIgbWVhbmluZyBpcyB0byByZW1vdmUgIi8qIGZhbGwgdGhyb3VnaCovIiBvciBh
ZGQgdGhlIGVycmF0dW0gY29tbW9udCByZXBsYWNlICIvKiBmYWxsIHRocm91Z2gqLyINCg0KUmVn
YXJkcywNCllpbmJvDQo=
