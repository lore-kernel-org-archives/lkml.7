Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF0BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D5B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BssSLA+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE2LQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:16:01 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:52214
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfE2LQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42gmD+pbaUCOnPDZfFlDDclPYZM2fb6Hb44jZeHXNOc=;
 b=BssSLA+/W4AaVyXTYXxMdfre9DhzsInPdFgdwD5eHrPQIFMfn3r5QRFF5433xFwO8W/dp5KyFcCiK1XyCkrDxPyyrr/CNL4kmMrqtS7xlo+bMJO4KHMLu3JvCxP+jqjUL+kEu+J+ipfcyCDsCFmC8FmnUfg/5K06oDFn3+Xoils=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB6128.eurprd04.prod.outlook.com (20.179.26.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Wed, 29 May 2019 11:15:54 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 11:15:54 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v7 2/5] USB: use genalloc for USB HCs with local memory
Thread-Topic: [PATCH v7 2/5] USB: use genalloc for USB HCs with local memory
Thread-Index: AQHVFglRosJR8I7CTUyICG2fRY8cAKaB6UYAgAAKaYA=
Date:   Wed, 29 May 2019 11:15:54 +0000
Message-ID: <34a83e74-4c85-cf9f-54c3-b69b0dcb628e@nxp.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-3-laurentiu.tudor@nxp.com>
 <20190529103838.GC7383@kroah.com>
In-Reply-To: <20190529103838.GC7383@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b456aba6-9d0a-42a0-f6b0-08d6e4270463
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6128;
x-ms-traffictypediagnostic: VI1PR04MB6128:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB612892171AA14E586BD08F74EC1F0@VI1PR04MB6128.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(51444003)(199004)(189003)(66446008)(6512007)(64756008)(66476007)(66556008)(8936002)(66946007)(31686004)(6486002)(76176011)(102836004)(8676002)(31696002)(26005)(86362001)(25786009)(71200400001)(71190400001)(66066001)(5660300002)(256004)(36756003)(6306002)(229853002)(6506007)(81166006)(6916009)(81156014)(53546011)(76116006)(54906003)(14454004)(966005)(4326008)(476003)(498600001)(6436002)(68736007)(305945005)(45080400002)(11346002)(91956017)(6116002)(6246003)(446003)(2906002)(486006)(73956011)(7736002)(53936002)(99286004)(2616005)(44832011)(3846002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6128;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mnca3SgNYgpEEYsT7oK5BCfvLXPeSFAYoxXy4l0aDzGjwSS1mG5Ew6qWjmDmGhSGGhPAC75kZUBj0wmjj4gA8SPriRMRQhiLSAxq6rYjRlPYP3YSsaCq8qjJ3id9072eGLcuxqfdzP0jDIbFQsp+MseN+BrLcRWDR96up6JM4QBhtwbNxYEcF3gzCjO1Y2Yb7KVH5utXZMY0cDkwKPgJFYl5dkpdKZ/4CL6KuxwHMxksL9lYvyqbSBSArWBkF4wcruorqsjIJgyWtTtSf8Sxvcs91V+Gg9sQz/zJm54yjakNeq6pjFkxwctqNFMa90eZaPsxrRcUrqxutketyXwkVTpFOJwPZxsh7NeoFOysHj6R0pok6PUOBnOuAFvtw3ntZE9uCjjeThYlix5JDCQbEzTNLxiG7+Vt1Mnr99Me4dI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA0C6826B01A55469906208829F03310@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b456aba6-9d0a-42a0-f6b0-08d6e4270463
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 11:15:54.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laurentiu.tudor@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI5LjA1LjIwMTkgMTM6MzgsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDI5
LCAyMDE5IGF0IDAxOjI4OjQwUE0gKzAzMDAsIGxhdXJlbnRpdS50dWRvckBueHAuY29tIHdyb3Rl
Og0KPj4gRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4+
DQo+PiBGb3IgSENzIHRoYXQgaGF2ZSBsb2NhbCBtZW1vcnksIHJlcGxhY2UgdGhlIGN1cnJlbnQg
RE1BIEFQSSB1c2FnZQ0KPj4gd2l0aCBhIGdlbmFsbG9jIGdlbmVyaWMgYWxsb2NhdG9yIHRvIG1h
bmFnZSB0aGUgbWFwcGluZ3MgZm9yIHRoZXNlDQo+PiBkZXZpY2VzLiBUbyBoZWxwIHVzZXJzLCBp
bnRyb2R1Y2UgYSBuZXcgSENEIEFQSSwNCj4+IHVzYl9oY2Rfc2V0dXBfbG9jYWxfbWVtKCkgdGhh
dCB3aWxsIHNldHVwIHVwIHRoZSBnZW5hbGxvYyBiYWNraW5nDQo+PiB1cCB0aGUgZGV2aWNlIGxv
Y2FsIG1lbW9yeS4gSXQgd2lsbCBiZSB1c2VkIGluIHN1YnNlcXVlbnQgcGF0Y2hlcy4NCj4+IFRo
aXMgaXMgaW4gcHJlcGFyYXRpb24gZm9yIGRyb3BwaW5nIHRoZSBleGlzdGluZyAiY29oZXJlbnQi
IGRtYQ0KPj4gbWVtIGRlY2xhcmF0aW9uIEFQSXMuIEN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2Fz
IHJlbHlpbmcgb24gYSBzaG9ydA0KPj4gY2lyY3VpdCBpbiB0aGUgRE1BIEFQSSB0aGF0IGluIHRo
ZSBlbmQsIHdhcyBhY3RpbmcgYXMgYW4gYWxsb2NhdG9yDQo+PiBmb3IgdGhlc2UgdHlwZSBvZiBk
ZXZpY2VzLg0KPj4gRm9yIHNoIGFyY2ggdG8gY29tcGlsZSBHRU5FUklDX0FMTE9DQVRPUiBuZWVk
cyB0byBiZSBzZWxlY3RlZCBpbg0KPj4gS2NvbmZpZy4NCj4+DQo+PiBGb3IgY29udGV4dCwgc2Vl
IHRocmVhZCBoZXJlOiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLm9yZyUyRmxrbWwlMkYyMDE5JTJGNCUyRjIyJTJG
MzU3JmFtcDtkYXRhPTAyJTdDMDElN0NsYXVyZW50aXUudHVkb3IlNDBueHAuY29tJTdDYWRlMjhl
MWYzMjJjNDUwMmNkNDgwOGQ2ZTQyMWQwYmElN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMw
MTYzNSU3QzAlN0MwJTdDNjM2OTQ3MjMxMjIwMjY0MDcyJmFtcDtzZGF0YT14dm16RHp0TWJlRDlH
d2xjQWZ4N2JCb3hoQVJXZ0Izdm1Ra3FpRTgxTGJnJTNEJmFtcDtyZXNlcnZlZD0wDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEZyZWRyaWsgTm9yaW5nIDxub3JpbmdAbm9jcmV3Lm9yZz4NCj4+
IFRlc3RlZC1ieTogRnJlZHJpayBOb3JpbmcgPG5vcmluZ0Bub2NyZXcub3JnPg0KPj4gUmVwb3J0
ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGRy
aXZlcnMvdXNiL0tjb25maWcgICAgICAgICB8ICAxICsNCj4+ICAgZHJpdmVycy91c2IvY29yZS9i
dWZmZXIuYyAgIHwgIDkgKysrKysrKysrDQo+PiAgIGRyaXZlcnMvdXNiL2NvcmUvaGNkLmMgICAg
ICB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBkcml2ZXJz
L3VzYi9ob3N0L29oY2ktaGNkLmMgfCAyMyArKysrKysrKysrKysrKysrKystLS0tLQ0KPj4gICBk
cml2ZXJzL3VzYi9ob3N0L29oY2ktbWVtLmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLQ0KPj4gICBkcml2ZXJzL3VzYi9ob3N0L29oY2kuaCAgICAgfCAgMiArKw0KPj4g
ICBpbmNsdWRlL2xpbnV4L3VzYi9oY2QuaCAgICAgfCAgNSArKysrKw0KPj4gICA3IGZpbGVzIGNo
YW5nZWQsIDEwMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9LY29uZmlnIGIvZHJpdmVycy91c2IvS2NvbmZpZw0KPj4gaW5kZXgg
ZTRiMjc0MTNmNTI4Li4zODljNTdkOGViYTcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9L
Y29uZmlnDQo+PiArKysgYi9kcml2ZXJzL3VzYi9LY29uZmlnDQo+PiBAQCAtNDUsNiArNDUsNyBA
QCBjb25maWcgVVNCX0FSQ0hfSEFTX0hDRA0KPj4gICBjb25maWcgVVNCDQo+PiAgIAl0cmlzdGF0
ZSAiU3VwcG9ydCBmb3IgSG9zdC1zaWRlIFVTQiINCj4+ICAgCWRlcGVuZHMgb24gVVNCX0FSQ0hf
SEFTX0hDRA0KPj4gKwlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1INCj4gDQo+IEFyZSB0aGVyZSBh
bnkgYXJjaGVzIHRoYXQgZG9lcyBub3QgaGF2ZSBHRU5FUklDX0FMTE9DQVRPUj8gIEkgZG9uJ3Qg
d2FudA0KPiB0byBzdWRkZW5seSBjdXQgb2ZmIGEgYnVuY2ggb2Ygd29ya2luZyBzeXN0ZW1zIGZy
b20gaGF2aW5nIFVTQiBzdXBwb3J0Lg0KPiANCg0KbGtwIHJlcG9ydCBtZW50aW9ucyBvbmx5IHNo
LCBidXQgZXZlbiBpZiB0aGVyZSBhcmUgb3RoZXJzLCBJIHRoaW5rIHRoYXQgDQpub3cgaGF2aW5n
IHRoZSBleHBsaWNpdCBzZWxlY3Qgc2hvdWxkIGNvdmVyIHRoZW0sIHJpZ2h0Pw0KDQotLS0NCkJl
c3QgUmVnYXJkcywgTGF1cmVudGl1
