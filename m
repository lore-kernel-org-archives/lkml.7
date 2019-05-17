Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADF5C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EBC20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QN9twPCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfEQKw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:52:59 -0400
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:59874
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbfEQKw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvjlUBzi5tBs9nF0SKImk5BtJBVOcM5EqX+Tmjh8+tI=;
 b=QN9twPCz/9j7cZWIH50FIBy8qU/ToC2LcAmKplr3d++XhYSGlOGZitGwE0lAn9rXXcPnBsRgSFnrg0p8ccL0V14g1aur+KQ3kqnCSnxECY0lrK9DyL524l6PSlRpxxsQ5gc2+Jq52N4tzgVWH2TOJUf+tGPpiAyj5JrtQToeBik=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4511.eurprd04.prod.outlook.com (20.177.54.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 10:52:54 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 10:52:54 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Thread-Topic: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Thread-Index: AQHVCmKoDp6AVawLEEugEGZuSLgHU6Zqu4uAgAA1oICAAQ5TAIAAYlQAgAFEQACAADmjAIABSOCA
Date:   Fri, 17 May 2019 10:52:54 +0000
Message-ID: <5fa97254-3038-6fe7-a7e7-a267262049c6@nxp.com>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com> <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com> <20190515162858.GB17162@sx9>
 <ed63c117-610c-ea49-f45e-727be220745f@nxp.com> <20190516151548.GB53952@sx9>
In-Reply-To: <20190516151548.GB53952@sx9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24c9fda5-a4fb-4d26-d7f0-08d6dab5d08e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(49563074)(7193020);SRVR:VI1PR04MB4511;
x-ms-traffictypediagnostic: VI1PR04MB4511:
x-microsoft-antispam-prvs: <VI1PR04MB451120E1795FEBA90BD5FDA9EC0B0@VI1PR04MB4511.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(366004)(199004)(189003)(68736007)(76176011)(66946007)(44832011)(4326008)(76116006)(73956011)(6436002)(11346002)(8676002)(36756003)(91956017)(31686004)(2616005)(54906003)(99936001)(99286004)(66066001)(186003)(486006)(6246003)(476003)(446003)(316002)(14444005)(5024004)(256004)(14454004)(102836004)(53936002)(229853002)(8936002)(478600001)(6916009)(71200400001)(71190400001)(25786009)(86362001)(7736002)(26005)(6506007)(81156014)(5660300002)(66616009)(64756008)(66476007)(66556008)(6116002)(3846002)(66446008)(81166006)(53546011)(6512007)(2906002)(6486002)(305945005)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4511;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pz68AP12eQ430Ez6UTGuR0kNhI2VEdSPoEWrTrOvkzXWPkVsWtqtY+o1f+iHjMWBOQHaNAnMv6Z0nWqxMFwf/SdNVtvrVUIe+gjBfQq1Kf6D1r6Iy0I4YQ4i0u16GlBE/wvdelitricj/ch217UyjlRXV/L6+g0VBh+apiZnh3x9j8VZ6HBlBBZ8FxxDPj302NmQlpxqVG24rgT7LJPxH2XCzsUvSCYvQFPhgVcN+8lVXHEaHwqrdGn9dYxP6PaEMO/pXI90mCTwjGVDxb1DlIf/n8wvn3a0ZobC/b47F5Y/LZTb1hbmD4K1F/ZZHxnsikUezYB5ITt4B1EDqJnHrqCq/Z7cslJyL+qOXkCJHZAAb78jyc5iwuFGeQ8+uYQigqA9hAOSqL3W1yiLHtHHaYX9idOglAGhD21GzyvCMfg=
Content-Type: multipart/mixed;
        boundary="_002_5fa9725430386fe7a7e7a267262049c6nxpcom_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c9fda5-a4fb-4d26-d7f0-08d6dab5d08e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 10:52:54.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_5fa9725430386fe7a7e7a267262049c6nxpcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB3BD85E23E1BE4EBD237E828470105A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

SGkgRnJlZHJpaywNCg0KT24gMTYuMDUuMjAxOSAxODoxNSwgRnJlZHJpayBOb3Jpbmcgd3JvdGU6
DQo+IEhpIExhdXJlbnRpdSwNCj4gDQo+PiBJIHRvb2sgeW91ciBjb2RlLCBhZGRlZCB0aGUgbWlz
c2luZyBtYXBwaW5nIGFuZCBwbGFjZWQgaXQgaW4gYSBwYXRjaC4NCj4+IFBsZWFzZSBzZWUgYXR0
YWNoZWQgKGNvbXBpbGUgdGVzdGVkIG9ubHkpLg0KPiANCj4gVGhhbmtzISBVbmZvcnR1bmF0ZWx5
LCB0aGUgT0hDSSBmYWlscyB3aXRoIGVycm9ycyBzdWNoIGFzDQo+IA0KPiAJdXNiIDEtMTogZGV2
aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTEyDQoNCkFscmlnaHQsIGF0IGxlYXN0IHRo
ZSBjcmFzaCB3ZW50IGF3YXkuIDotKQ0KDQo+IHRoYXQgSSB0cmFja2VkIGRvd24gdG8gdGhlIGNh
bGxzDQo+IA0KPiAJICAgaHViX3BvcnRfaW5pdA0KPiAJLT4gdXNiX2NvbnRyb2xfbXNnDQo+IAkt
PiB1c2JfaW50ZXJuYWxfY29udHJvbF9tc2cNCj4gCS0+IHVzYl9zdGFydF93YWl0X3VyYg0KPiAJ
LT4gdXNiX3N1Ym1pdF91cmINCj4gCS0+IHVzYl9oY2Rfc3VibWl0X3VyYg0KPiAJLT4gaGNkLT5k
cml2ZXItPnVyYl9lbnF1ZXVlDQo+IAktPiBvaGNpX3VyYl9lbnF1ZXVlDQo+IAktPiBlZF9nZXQN
Cj4gCS0+IGVkX2FsbG9jDQo+IAktPiBkbWFfcG9vbF96YWxsb2MNCj4gCS0+IGRtYV9wb29sX2Fs
bG9jDQo+IAktPiBwb29sX2FsbG9jX3BhZ2UsDQo+IA0KPiB3aGljaCByZXR1cm5zIE5VTEwuIFRo
ZW4gSSBub3RpY2VkDQo+IA0KPiAJLyogcG9vbF9hbGxvY19wYWdlKCkgbWlnaHQgc2xlZXAsIHNv
IHRlbXBvcmFyaWx5IGRyb3AgJnBvb2wtPmxvY2sgKi8NCj4gdGhhdCBtaWdodCBiZSBhIHByb2Js
ZW0gY29uc2lkZXJpbmcgdGhhdCB0aGUgSENEIGhhbmRsZXMgcG9vbCBtZW1vcnkgaW4NCj4gSVJR
IGhhbmRsZXJzLCBmb3IgaW5zdGFuY2U6DQo+IA0KPiAJICAgZG9fSVJRDQo+IAktPiBnZW5lcmlj
X2hhbmRsZV9pcnENCj4gCS0+IGhhbmRsZV9sZXZlbF9pcnENCj4gCS0+IGhhbmRsZV9pcnFfZXZl
bnQNCj4gCS0+IGhhbmRsZV9pcnFfZXZlbnRfcGVyY3B1DQo+IAktPiBfX2hhbmRsZV9pcnFfZXZl
bnRfcGVyY3B1DQo+IAktPiB1c2JfaGNkX2lycQ0KPiAJLT4gb2hjaV9pcnENCj4gCS0+IG9oY2lf
d29yaw0KPiAJLT4gZmluaXNoX3VyYg0KPiAJLT4gX191c2JfaGNkX2dpdmViYWNrX3VyYg0KPiAJ
LT4gdXNiX2hjZF91bm1hcF91cmJfZm9yX2RtYQ0KPiAJLT4gaGNkX2J1ZmZlcl9mcmVlDQoNCg0K
VGhhdCBsb29rcyBpbmRlZWQgd29ycmlzb21lIGJ1dCBJJ2QgZXhwZWN0IHRoYXQgaXQncyBub3Qg
cmVsYXRlZCB0byANCnRoZXNlIGdlbmFsbG9jIGNoYW5nZXMgdGhhdCBJJ20gd29ya2luZyBvbi4g
SSdsbCB0cnkgdG8gbG9vayBpbnRvIGl0IGJ1dCANCmFzIEknbSBub3QgZmFtaWxpYXIgd2l0aCB0
aGUgYXJlYSBtYXliZSBvdGhlcnMgd2lsbCBjb21tZW50Lg0KDQo+IEFsc28sIERNQV9CVUZGRVJf
U0laRSBpbiBvaGNpLXBzMi5jIGlzIG9ubHkgMjU2IEtpQiBpbiB0b3RhbC4gSXMgdGhlIG5ldw0K
PiBwb29sIGltcGxlbWVudGF0aW9uIGF0IGxlYXN0IGFzIGVmZmljaWVudCBhcyB0aGUgcHJldmlv
dXMgb25lPw0KDQpJIGRvbid0IHNlZSBhbnkgb2J2aW91cyByZWFzb25zIGZvciBnZW5hbGxvYyB0
byBiZSBsZXNzIGVmZmljaWVudC4NCg0KT25lIHRoaW5nIEkgbm90aWNlZCBiZXR3ZWVuIGdlbmFs
bG9jIGFuZCB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24gaXMgDQp0aGF0IHByZXZpb3VzbHkg
dGhlIGRldmljZSBtZW1vcnkgd2FzIG1hcHBlZCB3aXRoIG1lbXJlbWFwKCkgd2hpbGUgd2l0aCAN
CmdlbmFsbG9jIEknbSBkb2luZyBhIGRldm1faW9yZW1hcCgpLiBJIGNhbid0IHRoaW5rIG9mIGEg
cmVsZXZhbnQgDQpkaWZmZXJlbmNlIGV4Y2VwdCB0aGF0IG1lbXJlbWFwKCkgbWFwcyB3aXRoIFdD
IGJ1dGggbWF5YmUgdGhlcmUgYXJlIA0Kb3RoZXIgYXJjaCBzcGVjaWZpYyBzdWJ0bGV0aWVzLiBJ
J3ZlIGF0dGFjaGVkIGEgbmV3IHZlcnNpb24gb2YgdGhlIA0Kb2hjaS1wczIgcGF0Y2ggcmVwbGFj
aW5nIHRoZSBkZXZtX2lvcmVtYXAoKSB3aXRoIGRldm1fbWVtcmVtYXAoKSB0byANCmJldHRlciBt
YXRjaCB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24uIFBsZWFzZSB0ZXN0IGlmIHlvdSBmaW5k
IHNvbWUgdGltZS4NCg0KLS0tDQpUaGFua3MgJiBCZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ0K

--_002_5fa9725430386fe7a7e7a267262049c6nxpcom_
Content-Type: text/x-patch;
	name="v2-0001-usb-host-ohci-ps2-init-genalloc-for-local-memory.patch"
Content-Description:
 v2-0001-usb-host-ohci-ps2-init-genalloc-for-local-memory.patch
Content-Disposition: attachment;
	filename="v2-0001-usb-host-ohci-ps2-init-genalloc-for-local-memory.patch";
	size=3447; creation-date="Fri, 17 May 2019 10:52:53 GMT";
	modification-date="Fri, 17 May 2019 10:52:53 GMT"
Content-ID: <241E69301961B74A89CC46A627E9E182@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAzY2MyMWFhNmMxNTg5NGYzZWI2NjJjYzM5Nzg4ZTU1YjcyZTI0NjM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhw
LmNvbT4NCkRhdGU6IFRodSwgMTYgTWF5IDIwMTkgMTQ6MzU6MDYgKzAzMDANClN1YmplY3Q6IFtQ
QVRDSCB2Ml0gdXNiOiBob3N0OiBvaGNpLXBzMjogaW5pdCBnZW5hbGxvYyBmb3IgbG9jYWwgbWVt
b3J5DQoNCkluIHByZXBhcmF0aW9uIGZvciBkcm9wcGluZyB0aGUgZXhpc3RpbmcgImNvaGVyZW50
IiBkbWEgbWVtIGRlY2xhcmF0aW9uDQpBUElzLCByZXBsYWNlIHRoZSBjdXJyZW50IGRtYV9kZWNs
YXJlX2NvaGVyZW50X21lbW9yeSgpIGJhc2VkIG1lY2hhbmlzbQ0Kd2l0aCB0aGUgY3JlYXRpb24g
b2YgYSBnZW5hbGxvYyBwb29sIHRoYXQgd2lsbCBiZSB1c2VkIGluIHRoZSBPSENJDQpzdWJzeXN0
ZW0gYXMgcmVwbGFjZW1lbnQgZm9yIHRoZSBETUEgQVBJcy4NCg0KRm9yIGNvbnRleHQsIHNlZSB0
aHJlYWQgaGVyZTogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNC8yMi8zNTcNCg0KU2lnbmVk
LW9mZi1ieTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdXNiL2hvc3Qvb2hjaS1wczIuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L29oY2ktcHMyLmMgYi9k
cml2ZXJzL3VzYi9ob3N0L29oY2ktcHMyLmMNCmluZGV4IDc2NjliNzM1OGJjMy4uOWY0MDIzZjAw
OTdhIDEwMDc1NQ0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC9vaGNpLXBzMi5jDQorKysgYi9kcml2
ZXJzL3VzYi9ob3N0L29oY2ktcHMyLmMNCkBAIC03LDYgKzcsNyBAQA0KICAqLw0KIA0KICNpbmNs
dWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0KKyNpbmNsdWRlIDxsaW51eC9nZW5hbGxvYy5oPg0K
ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi5oPg0KQEAgLTkyLDEyICs5MywxMyBAQCBzdGF0
aWMgaXJxcmV0dXJuX3Qgb2hjaV9wczJfaXJxKHN0cnVjdCB1c2JfaGNkICpoY2QpDQogCXJldHVy
biBvaGNpX2lycShoY2QpOyAvKiBDYWxsIG5vcm1hbCBJUlEgaGFuZGxlci4gKi8NCiB9DQogDQot
c3RhdGljIGludCBpb3BoZWFwX2FsbG9jX2NvaGVyZW50KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYsDQotCXNpemVfdCBzaXplLCBpbnQgZmxhZ3MpDQorc3RhdGljIGludCBpb3BoZWFwX2Fs
bG9jX2NvaGVyZW50KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHNpemVfdCBzaXplKQ0K
IHsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCiAJc3RydWN0IHVzYl9oY2Qg
KmhjZCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KIAlzdHJ1Y3QgcHMyX2hjZCAqcHMy
cHJpdiA9IGhjZF90b19wcml2KGhjZCk7DQorCXZvaWQgX19pb21lbSAqbG9jYWxfbWVtOw0KKwlp
bnQgZXJyOw0KIA0KIAlpZiAocHMycHJpdi0+aW9wX2RtYV9hZGRyICE9IDApDQogCQlyZXR1cm4g
MDsNCkBAIC0xMTIsMjggKzExNCw0NSBAQCBzdGF0aWMgaW50IGlvcGhlYXBfYWxsb2NfY29oZXJl
bnQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJCXJldHVybiAtRU5PTUVNOw0KIAl9
DQogDQotCWlmIChkbWFfZGVjbGFyZV9jb2hlcmVudF9tZW1vcnkoZGV2LA0KLQkJCWlvcF9idXNf
dG9fcGh5cyhwczJwcml2LT5pb3BfZG1hX2FkZHIpLA0KLQkJCXBzMnByaXYtPmlvcF9kbWFfYWRk
ciwgc2l6ZSwgZmxhZ3MpKSB7DQotCQlkZXZfZXJyKGRldiwgImRtYV9kZWNsYXJlX2NvaGVyZW50
X21lbW9yeSBmYWlsZWRcbiIpOw0KLQkJaW9wX2ZyZWUocHMycHJpdi0+aW9wX2RtYV9hZGRyKTsN
Ci0JCXBzMnByaXYtPmlvcF9kbWFfYWRkciA9IDA7DQotCQlyZXR1cm4gLUVOT01FTTsNCisJaGNk
LT5sb2NhbG1lbV9wb29sID0gZGV2bV9nZW5fcG9vbF9jcmVhdGUoZGV2LCBQQUdFX1NISUZULA0K
KwkJCQkJCSAgZGV2X3RvX25vZGUoZGV2KSwgRFJWX05BTUUpOw0KKwlpZiAoSVNfRVJSKGhjZC0+
bG9jYWxtZW1fcG9vbCkpIHsNCisJCWVyciA9IFBUUl9FUlIoaGNkLT5sb2NhbG1lbV9wb29sKTsN
CisJCWdvdG8gb3V0X2VycjsNCisJfQ0KKw0KKwlsb2NhbF9tZW0gPSBkZXZtX21lbXJlbWFwKGRl
diwNCisJCQkJICBpb3BfYnVzX3RvX3BoeXMocHMycHJpdi0+aW9wX2RtYV9hZGRyKSwNCisJCQkJ
ICBzaXplLCBNRU1SRU1BUF9XQyk7DQorCWlmICghbG9jYWxfbWVtKSB7DQorCQllcnIgPSAtRU5P
TUVNOw0KKwkJZ290byBvdXRfZXJyOw0KKwl9DQorDQorCWVyciA9IGdlbl9wb29sX2FkZF92aXJ0
KGhjZC0+bG9jYWxtZW1fcG9vbCwgKHVuc2lnbmVkIGxvbmcpbG9jYWxfbWVtLA0KKwkJCQlwczJw
cml2LT5pb3BfZG1hX2FkZHIsIHNpemUsIGRldl90b19ub2RlKGRldikpOw0KKwlpZiAoZXJyIDwg
MCkgew0KKwkJZGV2X2VycihkZXYsICJnZW5fcG9vbF9hZGRfdmlydCBmYWlsZWQgd2l0aCAlZFxu
IiwgZXJyKTsNCisJCWdvdG8gb3V0X2VycjsNCiAJfQ0KIA0KIAlyZXR1cm4gMDsNCisNCitvdXRf
ZXJyOg0KKwlpb3BfZnJlZShwczJwcml2LT5pb3BfZG1hX2FkZHIpOw0KKwlwczJwcml2LT5pb3Bf
ZG1hX2FkZHIgPSAwOw0KKw0KKwlyZXR1cm4gZXJyOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBpb3Bo
ZWFwX2ZyZWVfY29oZXJlbnQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQotCXN0
cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQogCXN0cnVjdCB1c2JfaGNkICpoY2QgPSBw
bGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCiAJc3RydWN0IHBzMl9oY2QgKnBzMnByaXYgPSBo
Y2RfdG9fcHJpdihoY2QpOw0KIA0KIAlpZiAocHMycHJpdi0+aW9wX2RtYV9hZGRyID09IDApDQog
CQlyZXR1cm47DQogDQotCWRtYV9yZWxlYXNlX2RlY2xhcmVkX21lbW9yeShkZXYpOw0KIAlpb3Bf
ZnJlZShwczJwcml2LT5pb3BfZG1hX2FkZHIpOw0KIAlwczJwcml2LT5pb3BfZG1hX2FkZHIgPSAw
Ow0KIH0NCkBAIC0xNzcsOCArMTk2LDcgQEAgc3RhdGljIGludCBvaGNpX2hjZF9wczJfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCWdvdG8gZXJyOw0KIAl9DQogDQotCXJl
dCA9IGlvcGhlYXBfYWxsb2NfY29oZXJlbnQocGRldiwNCi0JCURNQV9CVUZGRVJfU0laRSwgRE1B
X01FTU9SWV9FWENMVVNJVkUpOw0KKwlyZXQgPSBpb3BoZWFwX2FsbG9jX2NvaGVyZW50KHBkZXYs
IERNQV9CVUZGRVJfU0laRSk7DQogCWlmIChyZXQgIT0gMCkNCiAJCWdvdG8gZXJyX2FsbG9jX2Nv
aGVyZW50Ow0KIA0KLS0gDQoyLjE3LjENCg0K

--_002_5fa9725430386fe7a7e7a267262049c6nxpcom_--
