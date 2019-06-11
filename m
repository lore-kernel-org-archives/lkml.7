Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F80C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5F720896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SY4md4uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbfFKGtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:49:53 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:21123
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390485AbfFKGtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVF6nsxEQ9hmF8CQcRfI3/eq+nddHvTEqmR6ieDJaAM=;
 b=SY4md4uB04MR19AIXRJRiQpq+SIWO0uUdU9cxm5V38SbEZgBkhr1r5nncDzhAZq52xFY52oe7UlqjSJHVNgHG1w9Z2dXAhR0b/D29kFAirctafNFUu4U/NUfSQUN7BIPHCisdUNvgkOdIViLzljzawHbTvETinsosp50m4Kw4JA=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB3982.eurprd04.prod.outlook.com (10.171.182.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 11 Jun 2019 06:48:07 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::adce:72e8:d327:a10]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::adce:72e8:d327:a10%7]) with mapi id 15.20.1965.011; Tue, 11 Jun 2019
 06:48:07 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 4/5] usb: host: Stops USB controller init if
 PLL fails to lock
Thread-Topic: [EXT] Re: [PATCH v6 4/5] usb: host: Stops USB controller init if
 PLL fails to lock
Thread-Index: AQHVG2JFHPrNwRzzI0qVTHZVwmHoiqaNHVEAgAELuXCAB+Fn0A==
Date:   Tue, 11 Jun 2019 06:48:07 +0000
Message-ID: <VI1PR04MB4158848A7F9C3E68948EBAACE9ED0@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190605054952.34687-4-yinbo.zhu@nxp.com>
 <Pine.LNX.4.44L0.1906051020540.1788-100000@iolanthe.rowland.org>
 <VI1PR04MB4158822B3E935275A488FDA7E9170@VI1PR04MB4158.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4158822B3E935275A488FDA7E9170@VI1PR04MB4158.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 601cabe7-0658-4e97-feaa-08d6ee38c2ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3982;
x-ms-traffictypediagnostic: VI1PR04MB3982:
x-microsoft-antispam-prvs: <VI1PR04MB398224A5116FD362A008C36EE9ED0@VI1PR04MB3982.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(346002)(39860400002)(189003)(199004)(13464003)(256004)(52536014)(99286004)(71190400001)(14444005)(73956011)(54906003)(5660300002)(71200400001)(66066001)(14454004)(2906002)(74316002)(6116002)(3846002)(33656002)(11346002)(86362001)(6506007)(229853002)(53936002)(446003)(102836004)(2171002)(486006)(26005)(68736007)(476003)(186003)(44832011)(55016002)(9686003)(6246003)(76116006)(66946007)(66476007)(64756008)(66446008)(53546011)(8936002)(25786009)(6916009)(6436002)(4326008)(76176011)(305945005)(8676002)(7696005)(478600001)(81166006)(66556008)(316002)(7736002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3982;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ybzZndxF4Bmd/X8JnJ7MxsnWc0hSd4ooO7ngGMBpGAv3EqoW0IEKafEtRS+N0OsUAZOsaG0sDtf2SpWnuq7Q8gAgN2wM9+ccQXWKH3COVF3mOUqNWQjouhoxh3B0Cwvtb3gYiwLQBb3YqgbotVqz882zyF6q9g5QZQukqnkpYAjhHnfg6zJFMt+1gNDiY4VimmWVLybL8BNqYaidb6pDN2Mk4ZI0d837J+MNl3cFkhAzF4jIrRQicQ7D/xbB62GCvhn8Y25h0telUdMap0OB27KjL3+xA+pKXHDLWL1OJs1I4iI/ys2z3zDE+xtOCBV0U/WBxX8cl18YDiWNVldGrf7XTg7weUHtyLlPj+fROBLtqhLVzZU7sbzudFAdcXWn1tMENrj6fLtpSEqlUKpm8utAD/pIlMBFqdDkTgXcbPA=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601cabe7-0658-4e97-feaa-08d6ee38c2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 06:48:07.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yinbo.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWluYm8gWmh1DQo+IFNl
bnQ6IDIwMTnE6jbUwjbI1SAxNDozNQ0KPiBUbzogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5o
YXJ2YXJkLmVkdT4NCj4gQ2M6IFhpYW9ibyBYaWUgPHhpYW9iby54aWVAbnhwLmNvbT47IEdyZWcg
S3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBSYW1uZWVrIE1l
aHJlc2gNCj4gPHJhbW5lZWsubWVocmVzaEBmcmVlc2NhbGUuY29tPjsgTmlraGlsIEJhZG9sYQ0K
PiA8bmlraGlsLmJhZG9sYUBmcmVlc2NhbGUuY29tPjsgUmFuIFdhbmcgPHJhbi53YW5nXzFAbnhw
LmNvbT47DQo+IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEppYWZlaSBQYW4NCj4gPGppYWZlaS5wYW5AbnhwLmNvbT4NCj4gU3ViamVjdDog
UkU6IFtFWFRdIFJlOiBbUEFUQ0ggdjYgNC81XSB1c2I6IGhvc3Q6IFN0b3BzIFVTQiBjb250cm9s
bGVyIGluaXQgaWYgUExMDQo+IGZhaWxzIHRvIGxvY2sNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEFsYW4gU3Rlcm4gW21haWx0bzpzdGVybkBy
b3dsYW5kLmhhcnZhcmQuZWR1XQ0KPiA+IFNlbnQ6IDIwMTnE6jbUwjXI1SAyMjoyMg0KPiA+IFRv
OiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KPiA+IENjOiBYaWFvYm8gWGllIDx4aWFv
Ym8ueGllQG54cC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+OyBSYW1uZWVrIE1laHJlc2gNCj4gPiA8cmFtbmVlay5tZWhyZXNoQGZyZWVz
Y2FsZS5jb20+OyBOaWtoaWwgQmFkb2xhDQo+ID4gPG5pa2hpbC5iYWRvbGFAZnJlZXNjYWxlLmNv
bT47IFJhbiBXYW5nIDxyYW4ud2FuZ18xQG54cC5jb20+Ow0KPiA+IGxpbnV4LXVzYkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppYWZlaSBQYW4NCj4gPiA8
amlhZmVpLnBhbkBueHAuY29tPg0KPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjYgNC81
XSB1c2I6IGhvc3Q6IFN0b3BzIFVTQiBjb250cm9sbGVyIGluaXQNCj4gPiBpZiBQTEwgZmFpbHMg
dG8gbG9jaw0KPiA+DQo+ID4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+ID4NCj4gPiBPbiBXZWQsIDUg
SnVuIDIwMTksIFlpbmJvIFpodSB3cm90ZToNCj4gPg0KPiA+ID4gRnJvbTogUmFtbmVlayBNZWhy
ZXNoIDxyYW1uZWVrLm1laHJlc2hAZnJlZXNjYWxlLmNvbT4NCj4gPiA+DQo+ID4gPiBVU0IgZXJy
YXR1bS1BMDA2OTE4IHdvcmthcm91bmQgdHJpZXMgdG8gc3RhcnQgaW50ZXJuYWwgUEhZIGluc2lk
ZQ0KPiA+ID4gdWJvb3QgKHdoZW4gUExMIGZhaWxzIHRvIGxvY2spLiBIb3dldmVyLCBpZiB0aGUg
d29ya2Fyb3VuZCBhbHNvDQo+ID4gPiBmYWlscywgdGhlbiBVU0IgaW5pdGlhbGl6YXRpb24gaXMg
YWxzbyBzdG9wcGVkIGluc2lkZSBMaW51eC4NCj4gPiA+IEVycmF0dW0tQTAwNjkxOCB3b3JrYXJv
dW5kIGZhaWx1cmUgY3JlYXRlcyAiZnNsLGVycmF0dW1fYTAwNjkxOCINCj4gPiA+IG5vZGUgaW4g
ZGV2aWNlLXRyZWUuIFByZXNlbmNlIG9mIHRoaXMgbm9kZSBpbiBkZXZpY2UtdHJlZSBpcyB1c2Vk
IHRvDQo+ID4gPiBzdG9wIFVTQiBjb250cm9sbGVyIGluaXRpYWxpemF0aW9uIGluIExpbnV4DQo+
ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmFtbmVlayBNZWhyZXNoIDxyYW1uZWVrLm1laHJl
c2hAZnJlZXNjYWxlLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1cmVzaCBHdXB0YSA8c3Vy
ZXNoLmd1cHRhQGZyZWVzY2FsZS5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaW5ibyBaaHUg
PHlpbmJvLnpodUBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2UgaW4gdjY6DQo+ID4g
PiAgICAgICAgICAgICAgIGFkZCBhICJGYWxsIHRocm91Z2giIGNvbW1lbnQNCj4gPiA+DQo+ID4g
PiAgZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jICAgICAgfCAxMCArKysrKysrKystDQo+ID4g
PiAgZHJpdmVycy91c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMgfCAgMyArKy0NCj4gPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYw0KPiA+ID4gYi9kcml2
ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMgaW5kZXggOGYzYmYzZWZiMDM4Li44NmFlMzcwODZhNzQN
Cj4gPiA+IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jDQo+
ID4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMNCj4gPiA+IEBAIC0yMzQsOCAr
MjM0LDE2IEBAIHN0YXRpYyBpbnQgZWhjaV9mc2xfc2V0dXBfcGh5KHN0cnVjdCB1c2JfaGNkICpo
Y2QsDQo+ID4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gICAgICAgY2FzZSBGU0xfVVNC
Ml9QSFlfVVRNSV9XSURFOg0KPiA+ID4gICAgICAgICAgICAgICBwb3J0c2MgfD0gUE9SVF9QVFNf
UFRXOw0KPiA+ID4gLSAgICAgICAgICAgICAvKiBmYWxsIHRocm91Z2ggKi8NCj4gPiA+ICAgICAg
IGNhc2UgRlNMX1VTQjJfUEhZX1VUTUk6DQo+ID4gPiArICAgICAgICAgICAgIC8qIFByZXNlbmNl
IG9mIHRoaXMgbm9kZSAiaGFzX2ZzbF9lcnJhdHVtX2EwMDY5MTgiDQo+ID4gPiArICAgICAgICAg
ICAgICAqIGluIGRldmljZS10cmVlIGlzIHVzZWQgdG8gc3RvcCBVU0IgY29udHJvbGxlcg0KPiA+
ID4gKyAgICAgICAgICAgICAgKiBpbml0aWFsaXphdGlvbiBpbiBMaW51eA0KPiA+ID4gKyAgICAg
ICAgICAgICAgKi8NCj4gPiA+ICsgICAgICAgICAgICAgaWYgKHBkYXRhLT5oYXNfZnNsX2VycmF0
dW1fYTAwNjkxOCkgew0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwg
IlVTQiBQSFkgY2xvY2sgaW52YWxpZFxuIik7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArICAgICAgICAgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICAg
ICAgIGNhc2UgRlNMX1VTQjJfUEhZX1VUTUlfRFVBTDoNCj4gPg0KPiA+DQo+ID4gWW91IG5lZWQg
dG8gYWRkIGEgIkZhbGwgdGhyb3VnaCIgY29tbWVudCBiZXR3ZWVuIHRoZXNlIHR3byBjYXNlcy4N
Cj4gPiA+ICAgICAgIGNhc2UgRlNMX1VTQjJfUEhZX1VUTUlfRFVBTDoNCj4gPiA+ICAgICAgICAg
ICAgICAgLyogUEhZX0NMS19WQUxJRCBiaXQgaXMgZGUtZmVhdHVyZWQgZnJvbSBhbGwgY29udHJv
bGxlcg0KPiA+ID4gICAgICAgICAgICAgICAgKiB2ZXJzaW9ucyBiZWxvdyAyLjQgYW5kIGlzIHRv
IGJlIGNoZWNrZWQgb25seSBmb3INCj4gPg0KPiA+IEFsYW4gU3Rlcm4NCj4gPiBIaSBBbGFuIFN0
ZXJuLA0KPiA+DQo+ID4gWW91ciBtZWFuaW5nIGlzIHRvIHJlbW92ZSAiLyogZmFsbCB0aHJvdWdo
Ki8iIG9yIGFkZCB0aGUgZXJyYXR1bSBjb21tb250DQo+IHJlcGxhY2UgIi8qIGZhbGwgdGhyb3Vn
aCovIg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBZaW5ibw0KPiA+IFRoaXMgaXMgYmFkLiAgWW91
IGdvdCByaWQgb2YgYSAiZmFsbCB0aHJvdWdoIiBjb21tZW50IHRoYXQgd2FzIG5lZWRlZCwNCj4g
PiBhbmQgeW91IGZhaWxlZCB0byBhZGQgYW5vdGhlciBvbmUgd2hlcmUgaXQgd2FzIG5lZWRlZC4N
Cj4gPg0KPiA+IEFsYW4gU3Rlcm4NCj4gSSBkb24ndCBnZXQgeW91ciBtZWFuaW5nLg0KPiBZaW5i
bw0KSGkgQWxhbiwNCg0KWW91ciBtZWFuaW5nIGlzIGxpa2UgZm9sbG93aW5nIGNvZGUgY2hhbmdl
LCBpc24ndCBpdD8gaWYgbm8sIGNvdWxkIHlvdSBnaXZlIGEgZXhhbXBsZQ0KICAgICAgICAgICAg
ICAgIHBvcnRzYyB8PSBQT1JUX1BUU19QVFc7DQogICAgICAgICAgICAgICAgLyogZmFsbCB0aHJv
dWdoICovDQogICAgICAgIGNhc2UgRlNMX1VTQjJfUEhZX1VUTUk6DQorICAgICAgICAgICAgICAg
LyogUHJlc2VuY2Ugb2YgdGhpcyBub2RlICJoYXNfZnNsX2VycmF0dW1fYTAwNjkxOCINCisgICAg
ICAgICAgICAgICAgKiBpbiBkZXZpY2UtdHJlZSBpcyB1c2VkIHRvIHN0b3AgVVNCIGNvbnRyb2xs
ZXINCisgICAgICAgICAgICAgICAgKiBpbml0aWFsaXphdGlvbiBpbiBMaW51eA0KKyAgICAgICAg
ICAgICAgICAqLw0KKyAgICAgICAgICAgICAgIGlmIChwZGF0YS0+aGFzX2ZzbF9lcnJhdHVtX2Ew
MDY5MTgpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIlVTQiBQSFkg
Y2xvY2sgaW52YWxpZFxuIik7DQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCisgICAgICAgICAgICAgICB9DQorDQogICAgICAgIGNhc2UgRlNMX1VTQjJfUEhZX1VUTUlf
RFVBTDoNCiAgICAgICAgICAgICAgICAvKiBQSFlfQ0xLX1ZBTElEIGJpdCBpcyBkZS1mZWF0dXJl
ZCBmcm9tIGFsbCBjb250cm9sbGVyDQpSZWdhcmRzLA0KWWluYm8uDQoNCj4gPg0KPiA+ID4gICAg
ICAgICAgICAgICAvKiBQSFlfQ0xLX1ZBTElEIGJpdCBpcyBkZS1mZWF0dXJlZCBmcm9tIGFsbCBj
b250cm9sbGVyDQo+ID4gPiAgICAgICAgICAgICAgICAqIHZlcnNpb25zIGJlbG93IDIuNCBhbmQg
aXMgdG8gYmUgY2hlY2tlZCBvbmx5IGZvcg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2hvc3QvZnNsLW1waC1kci1vZi5jDQo+ID4gPiBiL2RyaXZlcnMvdXNiL2hvc3QvZnNsLW1waC1k
ci1vZi5jDQo+ID4gPiBpbmRleCA0ZjhiOGEwOGM5MTQuLjc2MmI5NzYwMGFiMCAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QvZnNsLW1waC1kci1vZi5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL3VzYi9ob3N0L2ZzbC1tcGgtZHItb2YuYw0KPiA+ID4gQEAgLTIyNCwxMyArMjI0LDE0
IEBAIHN0YXRpYyBpbnQgZnNsX3VzYjJfbXBoX2RyX29mX3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRm
b3JtX2RldmljZSAqb2ZkZXYpDQo+ID4gPiAgICAgICAgICAgICAgIG9mX3Byb3BlcnR5X3JlYWRf
Ym9vbChucCwgImZzbCx1c2ItZXJyYXR1bS1hMDA1Mjc1Iik7DQo+ID4gPiAgICAgICBwZGF0YS0+
aGFzX2ZzbF9lcnJhdHVtX2EwMDU2OTcgPQ0KPiA+ID4gICAgICAgICAgICAgICBvZl9wcm9wZXJ0
eV9yZWFkX2Jvb2wobnAsICJmc2wsdXNiX2VycmF0dW0tYTAwNTY5NyIpOw0KPiA+ID4gKyAgICAg
cGRhdGEtPmhhc19mc2xfZXJyYXR1bV9hMDA2OTE4ID0NCj4gPiA+ICsgICAgICAgICAgICAgb2Zf
cHJvcGVydHlfcmVhZF9ib29sKG5wLCAiZnNsLHVzYl9lcnJhdHVtLWEwMDY5MTgiKTsNCj4gPiA+
DQo+ID4gPiAgICAgICBpZiAob2ZfZ2V0X3Byb3BlcnR5KG5wLCAiZnNsLHVzYl9lcnJhdHVtXzE0
IiwgTlVMTCkpDQo+ID4gPiAgICAgICAgICAgICAgIHBkYXRhLT5oYXNfZnNsX2VycmF0dW1fMTQg
PSAxOw0KPiA+ID4gICAgICAgZWxzZQ0KPiA+ID4gICAgICAgICAgICAgICBwZGF0YS0+aGFzX2Zz
bF9lcnJhdHVtXzE0ID0gMDsNCj4gPiA+DQo+ID4gPiAtDQo+ID4gPiAgICAgICAvKg0KPiA+ID4g
ICAgICAgICogRGV0ZXJtaW5lIHdoZXRoZXIgcGh5X2Nsa192YWxpZCBuZWVkcyB0byBiZSBjaGVj
a2VkDQo+ID4gPiAgICAgICAgKiBieSByZWFkaW5nIHByb3BlcnR5IGluIGRldmljZSB0cmVlDQo+
ID4gPg0KDQo=
