Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5BCC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD0E20989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J6+p4jwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEIDyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 23:54:22 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:46094
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbfEIDyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbdLSUDcayYQREiswDLxEAFTMew7GK5Wy0Vn0irjZ7M=;
 b=J6+p4jwWtMHqz6DDGe5OQyI1hVkayKHP9sYdXNqVpXgtaZw72a74hFJFk8F5XEsb/IPG94fxmVmjVuCxYNd5ZUUywVL3wJN67UlchKfk55TF8GY+rDRhtHYByPBX2Rb7Y3RxAnrGZ8+3nxFid1gx0ahNRpcbw0ZbPp89/UMMQ04=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4317.eurprd04.prod.outlook.com (52.134.31.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 03:54:13 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 03:54:13 +0000
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
        Suresh Gupta <B42813@freescale.com>
Subject: RE: [EXT] Re: [PATCH v5 2/5] usb: phy: Workaround for USB
 erratum-A005728
Thread-Topic: [EXT] Re: [PATCH v5 2/5] usb: phy: Workaround for USB
 erratum-A005728
Thread-Index: AQHVBWPrsnmaeqJdaEa/eR5Ny2mKMqZhRh+AgADjmyA=
Date:   Thu, 9 May 2019 03:54:12 +0000
Message-ID: <VI1PR04MB4158A2782C3696142B6792BAE9330@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190508060608.33882-2-yinbo.zhu@nxp.com>
 <Pine.LNX.4.44L0.1905081013490.1699-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1905081013490.1699-100000@iolanthe.rowland.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5483866c-4902-47ea-1fe5-08d6d431ffe8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4317;
x-ms-traffictypediagnostic: VI1PR04MB4317:
x-microsoft-antispam-prvs: <VI1PR04MB43179FE82D87BE993A003C9CE9330@VI1PR04MB4317.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(13464003)(229853002)(305945005)(74316002)(81166006)(76116006)(102836004)(7736002)(52536014)(66066001)(26005)(99286004)(186003)(6116002)(2906002)(3846002)(9686003)(73956011)(6246003)(66446008)(107886003)(4326008)(53936002)(53546011)(6916009)(6506007)(25786009)(86362001)(66946007)(64756008)(66556008)(66476007)(2171002)(71190400001)(68736007)(71200400001)(55016002)(476003)(33656002)(5660300002)(81156014)(486006)(8676002)(44832011)(446003)(11346002)(6436002)(256004)(478600001)(54906003)(316002)(8936002)(7696005)(14454004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4317;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: flHKohWZhgBI/z2SBI+ShYPSAGQ1j7QAn621VbZQyKuxEZYUG2EqI7RJ8TfzPVbsAYAy6M0MiF+C1HeIshF8eCuRkpkdpFnQaWODMfuT/d4RFmnw3fsz7de9euUTNopaIY286qwPhwjAKPzgfW1Kt5nq/OgIjeWQxlSR01BPkyz7144d4a6q0MtLZ169MUvQeXgscYQE6vlXyiAlwKeuglq0Wfw/1Kn+ZxFCrvdHkS0QDpz//FxT7hBgH+4q3+BTyyhL601G4hxP6/m8jJV7q8X33eJM7VoO9Eca2D4lXxEUZy1N7DmsgUtbd1SVeqwoDVupqSOxlnViePRpLnphXQ6ymIEiZ4gTvwLiFuoyQ0gjcJEPHQ3pSeX2cZlTJroz+oLgsdhUHuiHMC5nyipxarmdfW8g1aO5iBxf6f89/NI=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5483866c-4902-47ea-1fe5-08d6d431ffe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 03:54:12.9901
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
bHRvOnN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHVdDQo+IFNlbnQ6IDIwMTnE6jXUwjjI1SAyMjox
NQ0KPiBUbzogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCj4gQ2M6IFhpYW9ibyBYaWUg
PHhpYW9iby54aWVAbnhwLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBSYW1uZWVrIE1laHJlc2gNCj4gPHJhbW5lZWsubWVocmVzaEBmcmVl
c2NhbGUuY29tPjsgTmlraGlsIEJhZG9sYQ0KPiA8bmlraGlsLmJhZG9sYUBmcmVlc2NhbGUuY29t
PjsgUmFuIFdhbmcgPHJhbi53YW5nXzFAbnhwLmNvbT47DQo+IGxpbnV4LXVzYkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppYWZlaSBQYW4NCj4gPGppYWZl
aS5wYW5AbnhwLmNvbT47IFN1cmVzaCBHdXB0YSA8QjQyODEzQGZyZWVzY2FsZS5jb20+DQo+IFN1
YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjUgMi81XSB1c2I6IHBoeTogV29ya2Fyb3VuZCBmb3Ig
VVNCDQo+IGVycmF0dW0tQTAwNTcyOA0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBP
biBXZWQsIDggTWF5IDIwMTksIFlpbmJvIFpodSB3cm90ZToNCj4gDQo+ID4gRnJvbTogU3VyZXNo
IEd1cHRhIDxCNDI4MTNAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IFBIWV9DTEtfVkFMSUQgYml0
IGZvciBVVE1JIFBIWSBpbiBVU0JEUiBkb2VzIG5vdCBzZXQgZXZlbiBpZiBQSFkgaXMNCj4gPiBw
cm92aWRpbmcgdmFsaWQgY2xvY2suIFdvcmthcm91bmQgZm9yIHRoaXMgaW52b2x2ZXMgcmVzZXR0
aW5nIG9mIFBIWQ0KPiA+IGFuZCBjaGVjayBQSFlfQ0xLX1ZBTElEIGJpdCBtdWx0aXBsZSB0aW1l
cy4gSWYgUEhZX0NMS19WQUxJRCBiaXQgaXMNCj4gPiBzdGlsbCBub3Qgc2V0IGV2ZW4gYWZ0ZXIg
NSByZXRyaWVzLCBpdCB3b3VsZCBiZSBzYWZlIHRvIGRlYWNsYXJlIHRoYXQNCj4gPiBQSFkgY2xv
Y2sgaXMgbm90IGF2YWlsYWJsZS4NCj4gPiBUaGlzIGVycmF0dW0gaXMgYXBwbGljYWJsZSBmb3Ig
VVNCRFIgbGVzcyB0aGVuIHZlciAyLjQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdXJlc2gg
R3VwdGEgPEI0MjgxM0BmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpbmJvIFpo
dSA8eWluYm8uemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlIGluIHY1Og0KPiA+ICAg
ICAgICAgICAgICAgcmVtb3ZlIGRldl9lcnIgZnVuY3Rpb24gdW5uZWNlc3NhcnkgcGFyYW1ldGVy
cw0KPiA+DQo+ID4gIGRyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYyB8ICAgMzcgKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9ob3N0L2VoY2kt
ZnNsLmggfCAgICAzICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyks
IDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3Qv
ZWhjaS1mc2wuYyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYw0KPiA+IGluZGV4IDM4Njc0
YjcuLjE2MzRhYzggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5j
DQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jDQo+ID4gQEAgLTE4Myw2ICsx
ODMsMTcgQEAgc3RhdGljIGludCBmc2xfZWhjaV9kcnZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gPiAgICAgICByZXR1cm4gcmV0dmFsOw0KPiA+ICB9DQo+ID4NCj4g
PiArc3RhdGljIGJvb2wgdXNiX3BoeV9jbGtfdmFsaWQoc3RydWN0IHVzYl9oY2QgKmhjZCkgew0K
PiA+ICsgICAgIHZvaWQgX19pb21lbSAqbm9uX2VoY2kgPSBoY2QtPnJlZ3M7DQo+ID4gKyAgICAg
Ym9vbCByZXQgPSB0cnVlOw0KPiA+ICsNCj4gPiArICAgICBpZiAoIShpb3JlYWQzMmJlKG5vbl9l
aGNpICsgRlNMX1NPQ19VU0JfQ1RSTCkgJiBQSFlfQ0xLX1ZBTElEKSkNCj4gPiArICAgICAgICAg
ICAgIHJldCA9IGZhbHNlOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+
ID4gKw0KPiA+ICBzdGF0aWMgaW50IGVoY2lfZnNsX3NldHVwX3BoeShzdHJ1Y3QgdXNiX2hjZCAq
aGNkLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBmc2xfdXNiMl9waHlf
bW9kZXMgcGh5X21vZGUsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25l
ZCBpbnQgcG9ydF9vZmZzZXQpIEBAIC0yMjYsNg0KPiA+ICsyMzcsMTYgQEAgc3RhdGljIGludCBl
aGNpX2ZzbF9zZXR1cF9waHkoc3RydWN0IHVzYl9oY2QgKmhjZCwNCj4gPiAgICAgICAgICAgICAg
IC8qIGZhbGwgdGhyb3VnaCAqLw0KPiA+ICAgICAgIGNhc2UgRlNMX1VTQjJfUEhZX1VUTUk6DQo+
ID4gICAgICAgY2FzZSBGU0xfVVNCMl9QSFlfVVRNSV9EVUFMOg0KPiA+ICsgICAgICAgICAgICAg
LyogUEhZX0NMS19WQUxJRCBiaXQgaXMgZGUtZmVhdHVyZWQgZnJvbSBhbGwgY29udHJvbGxlcg0K
PiA+ICsgICAgICAgICAgICAgICogdmVyc2lvbnMgYmVsb3cgMi40IGFuZCBpcyB0byBiZSBjaGVj
a2VkIG9ubHkgZm9yDQo+ID4gKyAgICAgICAgICAgICAgKiBpbnRlcm5hbCBVVE1JIHBoeQ0KPiA+
ICsgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICBpZiAocGRhdGEtPmNvbnRyb2xs
ZXJfdmVyID4gRlNMX1VTQl9WRVJfMl80ICYmDQo+ID4gKyAgICAgICAgICAgICAgICAgcGRhdGEt
PmhhdmVfc3lzaWZfcmVncyAmJiAhdXNiX3BoeV9jbGtfdmFsaWQoaGNkKSkgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIlVTQiBQSFkgY2xvY2sgaW52YWxpZFxuIik7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAg
ICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgIGlmIChwZGF0YS0+aGF2ZV9zeXNpZl9y
ZWdzICYmIHBkYXRhLT5jb250cm9sbGVyX3Zlcikgew0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAvKiBjb250cm9sbGVyIHZlcnNpb24gMS42IG9yIGFib3ZlICovDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgIHRtcCA9IGlvcmVhZDMyYmUobm9uX2VoY2kgKyBGU0xfU09DX1VTQl9DVFJMKTsN
Cj4gPiBAQCAtMjQ5LDE3ICsyNzAsMTEgQEAgc3RhdGljIGludCBlaGNpX2ZzbF9zZXR1cF9waHko
c3RydWN0IHVzYl9oY2QgKmhjZCwNCj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAg
IH0NCj4gPg0KPiA+IC0gICAgIC8qDQo+ID4gLSAgICAgICogY2hlY2sgUEhZX0NMS19WQUxJRCB0
byBkZXRlcm1pbmUgcGh5IGNsb2NrIHByZXNlbmNlIGJlZm9yZSB3cml0aW5nDQo+ID4gLSAgICAg
ICogdG8gcG9ydHNjDQo+ID4gLSAgICAgICovDQo+ID4gLSAgICAgaWYgKHBkYXRhLT5jaGVja19w
aHlfY2xrX3ZhbGlkKSB7DQo+ID4gLSAgICAgICAgICAgICBpZiAoIShpb3JlYWQzMmJlKG5vbl9l
aGNpICsgRlNMX1NPQ19VU0JfQ1RSTCkgJg0KPiA+IC0gICAgICAgICAgICAgICAgIFBIWV9DTEtf
VkFMSUQpKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGhjZC0+c2VsZi5j
b250cm9sbGVyLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiVVNCIFBIWSBj
bG9jayBpbnZhbGlkXG4iKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+ID4gLSAgICAgICAgICAgICB9DQo+ID4gKyAgICAgaWYgKHBkYXRhLT5oYXZlX3N5c2lm
X3JlZ3MgJiYNCj4gPiArICAgICAgICAgcGRhdGEtPmNvbnRyb2xsZXJfdmVyID4gRlNMX1VTQl9W
RVJfMV82ICYmDQo+ID4gKyAgICAgICAgICAgICAhdXNiX3BoeV9jbGtfdmFsaWQoaGNkKSkgew0K
PiANCj4gVGhpcyBpcyBzdGlsbCB3cm9uZy4gIFRoZSBsaW5lIGFib3ZlIHNob3VsZCBiZSBpbmRl
bnRlZCBmb3VyIGNoYXJhY3RlcnMgbGVzcyB0aGFuIGl0DQo+IGlzOiB0aGUgJyEnIHNob3VsZCBs
aW5lIHVwIHdpdGggdGhlICdwJyBpbiB0aGUgbGluZSBhYm92ZSBpdC4NCj4gDQo+IEFsYW4gU3Rl
cm4NCkhpIEFsYW4gU3Rlcm4sDQoNCllvdXIgbWVhbmluZyBpcyB0aGF0IGFzIGZvbGxvd2luZyBj
aGFuZ2VzPw0KICsgICAgIGlmIChwZGF0YS0+aGF2ZV9zeXNpZl9yZWdzICYmDQogKyAgICAgICAg
IHBkYXRhLT5jb250cm9sbGVyX3ZlciA+IEZTTF9VU0JfVkVSXzFfNiAmJg0KICsgICAgICAgICAh
dXNiX3BoeV9jbGtfdmFsaWQoaGNkKSkgew0KDQpSZWdhcmRzLA0KWWluYm8NCj4gDQo+ID4gKyAg
ICAgICAgICAgICBkZXZfd2FybihoY2QtPnNlbGYuY29udHJvbGxlciwgIlVTQiBQSFkgY2xvY2sg
aW52YWxpZFxuIik7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAgICAg
ICB9DQo+ID4NCj4gPiAgICAgICBlaGNpX3dyaXRlbChlaGNpLCBwb3J0c2MsDQo+ID4gJmVoY2kt
PnJlZ3MtPnBvcnRfc3RhdHVzW3BvcnRfb2Zmc2V0XSk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2hvc3QvZWhjaS1mc2wuaCBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuaA0KPiA+
IGluZGV4IGNiYzQyMjAuLjlkMThjNmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9z
dC9laGNpLWZzbC5oDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5oDQo+ID4g
QEAgLTUwLDQgKzUwLDcgQEANCj4gPiAgI2RlZmluZSBVVE1JX1BIWV9FTiAgICAgICAgICAgICAo
MTw8OSkNCj4gPiAgI2RlZmluZSBVTFBJX1BIWV9DTEtfU0VMICAgICAgICAoMTw8MTApDQo+ID4g
ICNkZWZpbmUgUEhZX0NMS19WQUxJRCAgICAgICAgICAgICAgICAoMTw8MTcpDQo+ID4gKw0KPiA+
ICsvKiBSZXRyeSBjb3VudCBmb3IgY2hlY2tpbmcgVVRNSSBQSFkgQ0xLIHZhbGlkaXR5ICovICNk
ZWZpbmUNCj4gPiArVVRNSV9QSFlfQ0xLX1ZBTElEX0NIS19SRVRSWSA1DQo+ID4gICNlbmRpZiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBfRUhDSV9GU0xfSCAqLw0KPiA+DQoNCg==
