Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F875C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CE8208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g0GUr2Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfFXEG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:06:28 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:57633
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfFXEG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYQDGM7N5MY/oKufxIwBegkwRmRqGA0xRi8IXs4ww9c=;
 b=g0GUr2XizR/ci3I72Im6RzBpKSlHCxSuiQQrEh8X9ZffgSd/xAtc3CM/NBqxijldYlPAlz2ky/sgbkjGSeybQqZgbGUdDz94AVdZ7QXoT7f5YubSOjQF1UFuDA6wB1lLg7U2dynEexJJyVPn3KvAnd6jNO4P2nHwxaVmJNhYsFw=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4190.eurprd04.prod.outlook.com (52.134.30.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 04:05:43 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::bcac:811a:b5bf:1431]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::bcac:811a:b5bf:1431%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 04:05:43 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v7 4/5] usb: host: Stops USB controller init if
 PLL fails to lock
Thread-Topic: [EXT] Re: [PATCH v7 4/5] usb: host: Stops USB controller init if
 PLL fails to lock
Thread-Index: AQHVIo6QieXrOkuFP0CWMyQ1TInvsKakfSuAgAWYcyA=
Date:   Mon, 24 Jun 2019 04:05:42 +0000
Message-ID: <VI1PR04MB41581F96118B9FD33636C63DE9E00@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190614085433.22344-1-yinbo.zhu@nxp.com>
 <20190614085433.22344-4-yinbo.zhu@nxp.com> <20190620121025.GB19295@kroah.com>
In-Reply-To: <20190620121025.GB19295@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e381b365-c08d-4c42-1c7a-08d6f8593a1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4190;
x-ms-traffictypediagnostic: VI1PR04MB4190:
x-microsoft-antispam-prvs: <VI1PR04MB4190F111E42C85EDE119E08CE9E00@VI1PR04MB4190.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(136003)(13464003)(199004)(189003)(33656002)(8676002)(186003)(4326008)(26005)(71190400001)(71200400001)(5660300002)(25786009)(86362001)(6916009)(478600001)(73956011)(52536014)(66446008)(66556008)(14454004)(66946007)(76116006)(64756008)(66476007)(68736007)(81156014)(6506007)(9686003)(476003)(81166006)(486006)(44832011)(7696005)(256004)(14444005)(6116002)(229853002)(102836004)(305945005)(74316002)(11346002)(446003)(316002)(2906002)(53936002)(99286004)(8936002)(6246003)(55016002)(76176011)(66066001)(54906003)(6436002)(53546011)(7736002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4190;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5oDzf8pFouuUayCsg4+8Tu9ErtA1K2DNi6UAbX6Jk5uadFHkKP8tQbwUdVGXqpoDo8VAlcgbUfR5ZwFhjdKOcQ2AsUWR4HaRz9lru/5wUUTB2xsPeqjy13C0wicn8MVtelLssdihVRFVngz5Hl8acUEY/rCo72E4s50k5yxr02J4r7c8Z8v9AXpmIGOPbDyEOE5DfnFPLAnOOLa/pREllZzLcj3Jv+RGS9J3KoY1OerkBIShS9lFO/o8/w6FmuYdMto+2aGZAkRXomOUAmIXMUENvVu7aUt68pjYHP0AnXIHJAqUiFa4ODc+9LDU5a1H8uw+9WMpPSmcppm4oB5wIfX28Ef6O//tsrhtL7y+WeB/IaEC7VNcByl0kAm+nVNRy1V8ioV91xZHZdIGLG9+DBpEi5Ktok+gZdXDDlb1Xls=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e381b365-c08d-4c42-1c7a-08d6f8593a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 04:05:42.8987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yinbo.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLcm9haC1IYXJ0
bWFuIFttYWlsdG86Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+IFNlbnQ6IDIwMTnE6jbU
wjIwyNUgMjA6MTANCj4gVG86IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQo+IENjOiBB
bGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1PjsgWGlhb2JvIFhpZSA8eGlhb2Jv
LnhpZUBueHAuY29tPjsNCj4gSmlhZmVpIFBhbiA8amlhZmVpLnBhbkBueHAuY29tPjsgUmFtbmVl
ayBNZWhyZXNoDQo+IDxyYW1uZWVrLm1laHJlc2hAZnJlZXNjYWxlLmNvbT47IE5pa2hpbCBCYWRv
bGENCj4gPG5pa2hpbC5iYWRvbGFAZnJlZXNjYWxlLmNvbT47IFJhbiBXYW5nIDxyYW4ud2FuZ18x
QG54cC5jb20+Ow0KPiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjcgNC81XSB1c2I6IGhv
c3Q6IFN0b3BzIFVTQiBjb250cm9sbGVyIGluaXQgaWYgUExMIGZhaWxzIHRvDQo+IGxvY2sNCj4g
DQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgMDQ6
NTQ6MzJQTSArMDgwMCwgWWluYm8gWmh1IHdyb3RlOg0KPiA+IEZyb206IFJhbW5lZWsgTWVocmVz
aCA8cmFtbmVlay5tZWhyZXNoQGZyZWVzY2FsZS5jb20+DQo+ID4NCj4gPiBVU0IgZXJyYXR1bS1B
MDA2OTE4IHdvcmthcm91bmQgdHJpZXMgdG8gc3RhcnQgaW50ZXJuYWwgUEhZIGluc2lkZQ0KPiA+
IHVib290ICh3aGVuIFBMTCBmYWlscyB0byBsb2NrKS4gSG93ZXZlciwgaWYgdGhlIHdvcmthcm91
bmQgYWxzbyBmYWlscywNCj4gPiB0aGVuIFVTQiBpbml0aWFsaXphdGlvbiBpcyBhbHNvIHN0b3Bw
ZWQgaW5zaWRlIExpbnV4Lg0KPiA+IEVycmF0dW0tQTAwNjkxOCB3b3JrYXJvdW5kIGZhaWx1cmUg
Y3JlYXRlcyAiZnNsLGVycmF0dW1fYTAwNjkxOCINCj4gPiBub2RlIGluIGRldmljZS10cmVlLiBQ
cmVzZW5jZSBvZiB0aGlzIG5vZGUgaW4gZGV2aWNlLXRyZWUgaXMgdXNlZCB0bw0KPiA+IHN0b3Ag
VVNCIGNvbnRyb2xsZXIgaW5pdGlhbGl6YXRpb24gaW4gTGludXgNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFJhbW5lZWsgTWVocmVzaCA8cmFtbmVlay5tZWhyZXNoQGZyZWVzY2FsZS5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU3VyZXNoIEd1cHRhIDxzdXJlc2guZ3VwdGFAZnJlZXNjYWxlLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+IENoYW5nZSBpbiB2NzoNCj4gPiAgICAgICAgICAgICAgIGtlZXAgdjUgdmVyc2lv
biAiZmFsbCB0aHJvdWdoIg0KPiA+DQo+ID4gIGRyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYyAg
ICAgIHwgOSArKysrKysrKysNCj4gPiAgZHJpdmVycy91c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMg
fCAzICsrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMg
Yi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMNCj4gPiBpbmRleCA4ZjNiZjNlZmIwMzguLmVm
M2RmZDMzYTYyZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMNCj4gPiBAQCAtMjM2LDYgKzIz
NiwxNSBAQCBzdGF0aWMgaW50IGVoY2lfZnNsX3NldHVwX3BoeShzdHJ1Y3QgdXNiX2hjZCAqaGNk
LA0KPiA+ICAgICAgICAgICAgICAgcG9ydHNjIHw9IFBPUlRfUFRTX1BUVzsNCj4gPiAgICAgICAg
ICAgICAgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPiA+ICAgICAgIGNhc2UgRlNMX1VTQjJfUEhZX1VU
TUk6DQo+ID4gKyAgICAgICAgICAgICAvKiBQcmVzZW5jZSBvZiB0aGlzIG5vZGUgImhhc19mc2xf
ZXJyYXR1bV9hMDA2OTE4Ig0KPiA+ICsgICAgICAgICAgICAgICogaW4gZGV2aWNlLXRyZWUgaXMg
dXNlZCB0byBzdG9wIFVTQiBjb250cm9sbGVyDQo+ID4gKyAgICAgICAgICAgICAgKiBpbml0aWFs
aXphdGlvbiBpbiBMaW51eA0KPiA+ICsgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAg
ICBpZiAocGRhdGEtPmhhc19mc2xfZXJyYXR1bV9hMDA2OTE4KSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIGRldl93YXJuKGRldiwgIlVTQiBQSFkgY2xvY2sgaW52YWxpZFxuIik7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAgICAgICAg
fQ0KPiA+ICsNCj4gDQo+IFlvdSBuZWVkIGEgLyogZmFsbCB0aHJvdWdoICovIGNvbW1lbnQgaGVy
ZSwgcmlnaHQ/DQo+IA0KSEkgZ3JlZyBrLWguDQoNClRoYW5rcyB5b3VyIGZlZWRiYWNrIQ0KDQpZ
ZXMgLGl0IGlzIG5lZWRlZCwgYmVjYXVzZSB0aGlzIGNhc2UgZG9lc24ndCBoYXZlIGJyZWFrLCBp
biBhZGRpdGlvbiBJIHdpbGwgYWRkIGEgIi8qIGZhbGwgdGhyb3VnaCovIiBpbg0KY2FzZSBGU0xf
VVNCMl9QSFlfVVRNSSwgcGxlYXNlIHlvdSBub3RlLg0KVGhhbmtzDQoNCkJlc3QgUmVnYXJkcywN
CllpbmJvIFpodS4NCg0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0K
