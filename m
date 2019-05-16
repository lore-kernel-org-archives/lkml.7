Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D413FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918B720833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mr+VbTiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfEPLtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:49:39 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:53478
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727668AbfEPLtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCyZxGQrtbhjNfurEOsr5ZYl0uO40TTquZGJbJBYroY=;
 b=mr+VbTiN+HsIH5+BWcGznYnc9LXQnX1zH2TVwloQcLwpcQQXFJnPNYYsnlxYmjIGindeabWYdeBIdwrJdwVzgyiOb0zlqxXpLItwVkUKVamDub7YT66guIEBMxxy7gu4sKV1UZh4HoLqS4cZTyBZ7NxWlw+r+BjDlfvEaZWFPI0=
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com (20.176.235.28) by
 DB7PR04MB4170.eurprd04.prod.outlook.com (52.135.130.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 11:49:31 +0000
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::3cde:1777:e184:52ac]) by DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::3cde:1777:e184:52ac%4]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:49:31 +0000
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
Thread-Index: AQHVCmKoDp6AVawLEEugEGZuSLgHU6Zqu4uAgAA1oICAAQ5TAIAAYlQAgAFEQAA=
Date:   Thu, 16 May 2019 11:49:31 +0000
Message-ID: <ed63c117-610c-ea49-f45e-727be220745f@nxp.com>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com> <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com> <20190515162858.GB17162@sx9>
In-Reply-To: <20190515162858.GB17162@sx9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64892632-735d-4609-760f-08d6d9f48ee9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(49563074)(7193020);SRVR:DB7PR04MB4170;
x-ms-traffictypediagnostic: DB7PR04MB4170:
x-microsoft-antispam-prvs: <DB7PR04MB41707C4963947F2FF2478FB4EC0A0@DB7PR04MB4170.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(51444003)(54906003)(68736007)(99286004)(76176011)(256004)(7736002)(229853002)(305945005)(8676002)(66446008)(81166006)(8936002)(64756008)(66556008)(66476007)(66616009)(6486002)(6512007)(66946007)(76116006)(91956017)(71200400001)(71190400001)(81156014)(6436002)(14444005)(5024004)(73956011)(6246003)(2616005)(31686004)(14454004)(44832011)(4326008)(476003)(6116002)(486006)(11346002)(446003)(25786009)(31696002)(3846002)(53936002)(6916009)(86362001)(26005)(102836004)(53546011)(6506007)(66066001)(99936001)(186003)(478600001)(316002)(5660300002)(36756003)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4170;H:DB7PR04MB5132.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OAcmYMih7TpLqEaL6nQnx2EyDOSXvS47BZUbU3mc/8hI3GMM+GIEG/hBPTV6MJoq02oGm+eLzIC81XutMFwDRPL43tYUon/1rpLgeHucgVNZUjpTW0bomlOJ7fdeWeS2mERO5VDoihPCg31zOlD7ZSugN8dOvIHAgeSQACYH7wljPv2M1nCl2gJR7r3f9T9SAV9kxyGyaqT9Hml+Lv3mkSou5Zcxja0ihS1xpy1AVBZevFa20qLUpqMtz3xvOZcCy3ZrXKEgwGxcHUnofMQlp2amqN4Xpn0LhtrQshBpA33DKZ+tzYIQVfqAyvoTADy3dlTNzYsHpACXXwUMZbbtCKBGVFDIwJWsd7RgfN90jwzkbf3yvurEkUzzz3fhGLsS94UjmgMrwCxZaR1ZS5WaO6eQPaDgWT7rxrf7iQIQQ9I=
Content-Type: multipart/mixed;
        boundary="_002_ed63c117610cea49f45e727be220745fnxpcom_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64892632-735d-4609-760f-08d6d9f48ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:49:31.0845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_ed63c117610cea49f45e727be220745fnxpcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0EB8F30D72A4D40AA5C8A5D048DA3B5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

SGkgRnJlZHJpY2ssDQoNCk9uIDE1LjA1LjIwMTkgMTk6MjgsIEZyZWRyaWsgTm9yaW5nIHdyb3Rl
Og0KPiBIaSBMYXVyZXRuaXUsDQo+IA0KPj4gSSB0aGluayB0aGF0IGFueSByZWNlbnQga2VybmVs
IHdpbGwgZG8sIHNvIEknZCBzYXkgeW91ciBjdXJyZW50IGJyYW5jaA0KPj4gc2hvdWxkIGJlIGZp
bmUuDQo+IA0KPiBUaGUga2VybmVsIG9vcHNlcyB3aXRoICJ1bmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsDQo+IGFkZHJlc3MgMDAwYWJhMGIiIGluIGhjZF9h
bGxvY19jb2hlcmVudCB2aWEgdXNiX2hjZF9tYXBfdXJiX2Zvcl9kbWEuIFRoaXMNCj4gcmVsYXRl
cyB0byBwYXRjaCAyLzMgdGhhdCBJIGRpZG4ndCBxdWl0ZSB1bmRlcnN0YW5kLCB3aGVyZQ0KPiAN
Cj4gLQlyZXR2YWwgPSBkbWFfZGVjbGFyZV9jb2hlcmVudF9tZW1vcnkoZGV2LCBtZW0tPnN0YXJ0
LA0KPiAtCQkJCQkgbWVtLT5zdGFydCAtIG1lbS0+cGFyZW50LT5zdGFydCwNCj4gLQkJCQkJIHJl
c291cmNlX3NpemUobWVtKSk7DQo+IA0KPiBiZWNvbWVzDQo+IA0KPiArCXJldHZhbCA9IGdlbl9w
b29sX2FkZF92aXJ0KGhjZC0+bG9jYWxtZW1fcG9vbCwNCj4gKwkJCQkgICAodW5zaWduZWQgbG9u
ZyltZW0tPnN0YXJ0IC0NCj4gKwkJCQkJbWVtLT5wYXJlbnQtPnN0YXJ0LA0KPiArCQkJCSAgIG1l
bS0+c3RhcnQsIHJlc291cmNlX3NpemUobWVtKSwNCj4gDQo+IHNvIHRoYXQgYXJndW1lbnRzIHR3
byBhbmQgdGhyZWUgc3dpdGNoIHBsYWNlcy4gR2l2ZW4NCj4gDQo+IGludCBkbWFfZGVjbGFyZV9j
b2hlcmVudF9tZW1vcnkoc3RydWN0IGRldmljZSAqZGV2LCBwaHlzX2FkZHJfdCBwaHlzX2FkZHIs
DQo+IAkJCQlkbWFfYWRkcl90IGRldmljZV9hZGRyLCBzaXplX3Qgc2l6ZSk7DQo+IA0KPiBhbmQN
Cj4gDQo+IGludCBnZW5fcG9vbF9hZGRfdmlydChzdHJ1Y3QgZ2VuX3Bvb2wgKnBvb2wsIHVuc2ln
bmVkIGxvbmcgdmlydCwgcGh5c19hZGRyX3QgcGh5cw0KPiAJCSBzaXplX3Qgc2l6ZSwgaW50IG5p
ZCkNCj4gDQo+IGl0IHNlZW1zIHRoYXQgdGhlIGRldmljZSBhZGRyZXNzIChkbWFfYWRkcl90IGRl
dmljZV9hZGRyKSBub3cgYmVjb21lcyBhDQo+IHZpcnR1YWwgYWRkcmVzcyAodW5zaWduZWQgbG9u
ZyB2aXJ0KS4gSXMgdGhhdCBpbnRlbmRlZD8NCj4gDQo+IE15IGNvcnJlc3BvbmRpbmcgcGF0Y2gg
aXMgYmVsb3cgZm9yIHJlZmVyZW5jZS4gSSBhcHBsaWVkIHlvdXIgMS8zIHBhdGNoDQo+IHRvIHRl
c3QgaXQuDQoNCkkgdG9vayB5b3VyIGNvZGUsIGFkZGVkIHRoZSBtaXNzaW5nIG1hcHBpbmcgYW5k
IHBsYWNlZCBpdCBpbiBhIHBhdGNoLiANClBsZWFzZSBzZWUgYXR0YWNoZWQgKGNvbXBpbGUgdGVz
dGVkIG9ubHkpLg0KDQotLS0NClRoYW5rcyAmIEJlc3QgUmVnYXJkcywgTGF1cmVudGl1DQo=

--_002_ed63c117610cea49f45e727be220745fnxpcom_
Content-Type: text/x-patch;
	name="0001-usb-host-ohci-ps2-init-genalloc-for-local-memory.patch"
Content-Description:
 0001-usb-host-ohci-ps2-init-genalloc-for-local-memory.patch
Content-Disposition: attachment;
	filename="0001-usb-host-ohci-ps2-init-genalloc-for-local-memory.patch";
	size=3428; creation-date="Thu, 16 May 2019 11:49:30 GMT";
	modification-date="Thu, 16 May 2019 11:49:30 GMT"
Content-ID: <662D3DB640F47242A864C23D98DD612D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA1MTBjMzQ5OTBiYmU4OTlhMmU0ZjQzZjNiOTA0MTgzZjEyNmY4MWRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhw
LmNvbT4NCkRhdGU6IFRodSwgMTYgTWF5IDIwMTkgMTQ6MzU6MDYgKzAzMDANClN1YmplY3Q6IFtQ
QVRDSF0gdXNiOiBob3N0OiBvaGNpLXBzMjogaW5pdCBnZW5hbGxvYyBmb3IgbG9jYWwgbWVtb3J5
DQoNCkluIHByZXBhcmF0aW9uIGZvciBkcm9wcGluZyB0aGUgZXhpc3RpbmcgImNvaGVyZW50IiBk
bWEgbWVtIGRlY2xhcmF0aW9uDQpBUElzLCByZXBsYWNlIHRoZSBjdXJyZW50IGRtYV9kZWNsYXJl
X2NvaGVyZW50X21lbW9yeSgpIGJhc2VkIG1lY2hhbmlzbQ0Kd2l0aCB0aGUgY3JlYXRpb24gb2Yg
YSBnZW5hbGxvYyBwb29sIHRoYXQgd2lsbCBiZSB1c2VkIGluIHRoZSBPSENJDQpzdWJzeXN0ZW0g
YXMgcmVwbGFjZW1lbnQgZm9yIHRoZSBETUEgQVBJcy4NCg0KRm9yIGNvbnRleHQsIHNlZSB0aHJl
YWQgaGVyZTogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNC8yMi8zNTcNCg0KU2lnbmVkLW9m
Zi1ieTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvdXNiL2hvc3Qvb2hjaS1wczIuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L29oY2ktcHMyLmMgYi9kcml2
ZXJzL3VzYi9ob3N0L29oY2ktcHMyLmMNCmluZGV4IDc2NjliNzM1OGJjMy4uNDU0ZTVlM2FjOTZl
IDEwMDc1NQ0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC9vaGNpLXBzMi5jDQorKysgYi9kcml2ZXJz
L3VzYi9ob3N0L29oY2ktcHMyLmMNCkBAIC03LDYgKzcsNyBAQA0KICAqLw0KIA0KICNpbmNsdWRl
IDxsaW51eC9kbWEtbWFwcGluZy5oPg0KKyNpbmNsdWRlIDxsaW51eC9nZW5hbGxvYy5oPg0KICNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNl
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi5oPg0KQEAgLTkyLDEyICs5MywxMyBAQCBzdGF0aWMg
aXJxcmV0dXJuX3Qgb2hjaV9wczJfaXJxKHN0cnVjdCB1c2JfaGNkICpoY2QpDQogCXJldHVybiBv
aGNpX2lycShoY2QpOyAvKiBDYWxsIG5vcm1hbCBJUlEgaGFuZGxlci4gKi8NCiB9DQogDQotc3Rh
dGljIGludCBpb3BoZWFwX2FsbG9jX2NvaGVyZW50KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYsDQotCXNpemVfdCBzaXplLCBpbnQgZmxhZ3MpDQorc3RhdGljIGludCBpb3BoZWFwX2FsbG9j
X2NvaGVyZW50KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHNpemVfdCBzaXplKQ0KIHsN
CiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCiAJc3RydWN0IHVzYl9oY2QgKmhj
ZCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KIAlzdHJ1Y3QgcHMyX2hjZCAqcHMycHJp
diA9IGhjZF90b19wcml2KGhjZCk7DQorCXZvaWQgX19pb21lbSAqbG9jYWxfbWVtOw0KKwlpbnQg
ZXJyOw0KIA0KIAlpZiAocHMycHJpdi0+aW9wX2RtYV9hZGRyICE9IDApDQogCQlyZXR1cm4gMDsN
CkBAIC0xMTIsMjggKzExNCw0NSBAQCBzdGF0aWMgaW50IGlvcGhlYXBfYWxsb2NfY29oZXJlbnQo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJCXJldHVybiAtRU5PTUVNOw0KIAl9DQog
DQotCWlmIChkbWFfZGVjbGFyZV9jb2hlcmVudF9tZW1vcnkoZGV2LA0KLQkJCWlvcF9idXNfdG9f
cGh5cyhwczJwcml2LT5pb3BfZG1hX2FkZHIpLA0KLQkJCXBzMnByaXYtPmlvcF9kbWFfYWRkciwg
c2l6ZSwgZmxhZ3MpKSB7DQotCQlkZXZfZXJyKGRldiwgImRtYV9kZWNsYXJlX2NvaGVyZW50X21l
bW9yeSBmYWlsZWRcbiIpOw0KLQkJaW9wX2ZyZWUocHMycHJpdi0+aW9wX2RtYV9hZGRyKTsNCi0J
CXBzMnByaXYtPmlvcF9kbWFfYWRkciA9IDA7DQotCQlyZXR1cm4gLUVOT01FTTsNCisJaGNkLT5s
b2NhbG1lbV9wb29sID0gZGV2bV9nZW5fcG9vbF9jcmVhdGUoZGV2LCBQQUdFX1NISUZULA0KKwkJ
CQkJCSAgZGV2X3RvX25vZGUoZGV2KSwgRFJWX05BTUUpOw0KKwlpZiAoSVNfRVJSKGhjZC0+bG9j
YWxtZW1fcG9vbCkpIHsNCisJCWVyciA9IFBUUl9FUlIoaGNkLT5sb2NhbG1lbV9wb29sKTsNCisJ
CWdvdG8gb3V0X2VycjsNCisJfQ0KKw0KKwlsb2NhbF9tZW0gPSBkZXZtX2lvcmVtYXAoZGV2LA0K
KwkJCQkgaW9wX2J1c190b19waHlzKHBzMnByaXYtPmlvcF9kbWFfYWRkciksDQorCQkJCSBzaXpl
KTsNCisJaWYgKCFsb2NhbF9tZW0pIHsNCisJCWVyciA9IC1FTk9NRU07DQorCQlnb3RvIG91dF9l
cnI7DQorCX0NCisNCisJZXJyID0gZ2VuX3Bvb2xfYWRkX3ZpcnQoaGNkLT5sb2NhbG1lbV9wb29s
LCAodW5zaWduZWQgbG9uZylsb2NhbF9tZW0sDQorCQkJCXBzMnByaXYtPmlvcF9kbWFfYWRkciwg
c2l6ZSwgZGV2X3RvX25vZGUoZGV2KSk7DQorCWlmIChlcnIgPCAwKSB7DQorCQlkZXZfZXJyKGRl
diwgImdlbl9wb29sX2FkZF92aXJ0IGZhaWxlZCB3aXRoICVkXG4iLCBlcnIpOw0KKwkJZ290byBv
dXRfZXJyOw0KIAl9DQogDQogCXJldHVybiAwOw0KKw0KK291dF9lcnI6DQorCWlvcF9mcmVlKHBz
MnByaXYtPmlvcF9kbWFfYWRkcik7DQorCXBzMnByaXYtPmlvcF9kbWFfYWRkciA9IDA7DQorDQor
CXJldHVybiBlcnI7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIGlvcGhlYXBfZnJlZV9jb2hlcmVudChz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCi0Jc3RydWN0IGRldmljZSAqZGV2ID0g
JnBkZXYtPmRldjsNCiAJc3RydWN0IHVzYl9oY2QgKmhjZCA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOw0KIAlzdHJ1Y3QgcHMyX2hjZCAqcHMycHJpdiA9IGhjZF90b19wcml2KGhjZCk7DQog
DQogCWlmIChwczJwcml2LT5pb3BfZG1hX2FkZHIgPT0gMCkNCiAJCXJldHVybjsNCiANCi0JZG1h
X3JlbGVhc2VfZGVjbGFyZWRfbWVtb3J5KGRldik7DQogCWlvcF9mcmVlKHBzMnByaXYtPmlvcF9k
bWFfYWRkcik7DQogCXBzMnByaXYtPmlvcF9kbWFfYWRkciA9IDA7DQogfQ0KQEAgLTE3Nyw4ICsx
OTYsNyBAQCBzdGF0aWMgaW50IG9oY2lfaGNkX3BzMl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAkJZ290byBlcnI7DQogCX0NCiANCi0JcmV0ID0gaW9waGVhcF9hbGxvY19j
b2hlcmVudChwZGV2LA0KLQkJRE1BX0JVRkZFUl9TSVpFLCBETUFfTUVNT1JZX0VYQ0xVU0lWRSk7
DQorCXJldCA9IGlvcGhlYXBfYWxsb2NfY29oZXJlbnQocGRldiwgRE1BX0JVRkZFUl9TSVpFKTsN
CiAJaWYgKHJldCAhPSAwKQ0KIAkJZ290byBlcnJfYWxsb2NfY29oZXJlbnQ7DQogDQotLSANCjIu
MTcuMQ0KDQo=

--_002_ed63c117610cea49f45e727be220745fnxpcom_--
