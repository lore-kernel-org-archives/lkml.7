Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1066AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98F1217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vcqBUUu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfIBJ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:56:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:25088 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729489AbfIBJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:56:50 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x829pf3o027045;
        Mon, 2 Sep 2019 02:56:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=rN4ushvvwvOUFH2hJVmXf/JXg5fmZ/Z8tx7GujfZh1c=;
 b=vcqBUUu9WHdQJX+SQqJgHxr3ef1DPQFXCAuOdYZNcHbZLweFPrVOXaSUQes7diBi7vR8
 +pGwT9emDfD5SRnI4LOfqhIjkSHYOphnflmV9OjHgsW1LsDXegdcjhaKdDqrlBAMKqLp
 KoxVtc9mdgSJ+Tw0e+hB0BvfJVvfDSeS+6DxvR37TtvO7UcvkNySVtiyJhEt5SJ7ZdDw
 2CVSm2PIxKO67o+MbGpqq10kjG859Aq3NCVGj+nTQqFrz0QdALT8pRwoV0lvrPK0rQjS
 xN4FQb+5lFQXiW+yWbx3Hfb9wNziSXKAjcYt6sNdSxvz8yJ2yWINoP7kTAnEVOBOWV5M cg== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2uqmt82xpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 02:56:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RH6JjfCWJsHvdYrtquR2GNEUNRRXAgC3t+dgJ6D6t0TgXJJGgbRXf0EPK+WE1rF3Jo5HdNqTczvqGGNIAziZKOabDr9PUzYU+gxWmKVY7UmszOUtEZiD6fg46Snw7D5ZXyr9F/+kCNIAIn9wN2xW0JoZYP/By+qsfYFEjv5vpyvHYv7LGYQYWETJxHmzY4ONKrdiNFvEJO7JvEYzk9vyCs1FVByrybA3rv60tG+IjZHh4ITg8M8x44qPpT1W5IunuSaom4168JJrBPTL+vrmSuUuFFj8791Sxdpmy8QfgCjQCtzUGhxWN5w/BSDnrFr1RkUQGC6gf8DpXCZLWVaqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN4ushvvwvOUFH2hJVmXf/JXg5fmZ/Z8tx7GujfZh1c=;
 b=atzx9dImYeO45mPv2w96AySJguoM8ck8WufZ8sMeM7oRV6/2VldXjZJL2YOnQ/8sXXLJSIBtJjllqQcjbjs4X3Dv/o5wMblcDpunynrVI0ATdVoLdOSltRShNXYQYdK5sBF6FWIrVzoEo9TsCt28GhHhTPaqoGVWTx9HoUFuGOHpNFaRc6PUwbmHX1/d0rQZMLYEFQXoh7l2QdyNNCQhPc56AKYh9R1CkQSmT+PjBrNl9tIKYyblsj+sNwxjh2SgW3hJtDAq5+S1jh8uICuH2BQt8PVoF6oEcQ6xrDfZUI5Dwbk9Co7KUc+IZLwmmYT9AC6jZm71SnfgJB9Rj8F8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB3634.namprd02.prod.outlook.com (52.132.27.154) by
 BL0PR02MB4579.namprd02.prod.outlook.com (10.167.180.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 09:56:43 +0000
Received: from BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::fd1a:595d:b861:1f55]) by BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::fd1a:595d:b861:1f55%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 09:56:43 +0000
From:   Matej Genci <matej.genci@nutanix.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
Thread-Topic: [PATCH] virtio: Change typecasts in vring_init()
Thread-Index: AQHVXOsGnWphIXIpHkCP5ncx23ivmacTvUwAgABB5YCAAY4fgIACoksA
Date:   Mon, 2 Sep 2019 09:56:42 +0000
Message-ID: <6454e12b-470b-cce6-5570-3fb92cbc916d@nutanix.com>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
 <20190830095928-mutt-send-email-mst@kernel.org>
 <41b8eb4b-0d3b-f103-9ec4-332a903612ee@nutanix.com>
 <20190831134218-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190831134218-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3addb015-3cf9-4e08-a392-08d72f8bdbe4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR02MB4579;
x-ms-traffictypediagnostic: BL0PR02MB4579:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR02MB4579802C4D8A56FFF5A2066DFBBE0@BL0PR02MB4579.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(52314003)(5660300002)(25786009)(2906002)(966005)(478600001)(36756003)(6306002)(14454004)(71190400001)(102836004)(26005)(54906003)(71200400001)(11346002)(6486002)(186003)(229853002)(66066001)(305945005)(86362001)(446003)(53936002)(2616005)(44832011)(476003)(486006)(31696002)(6506007)(316002)(31686004)(256004)(6916009)(7736002)(4326008)(99286004)(6436002)(6246003)(66446008)(64756008)(66556008)(3846002)(6116002)(6512007)(8676002)(81156014)(81166006)(91956017)(66476007)(66946007)(76116006)(76176011)(53546011)(8936002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB4579;H:BL0PR02MB3634.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t/CiYv1GIrashT2gipRty/vfE8iZYQqbiteZGNg3u9OUHWS4l23Ev7hY8kx2WwQBTNxGbSr8enF0JS+PzqdBjQsBbFa7tIW0eq0s+QEOETPADWc4J0G+pZE/Ql8/Mw+Fy3XPfZvtfhkm9k+p+HdJ69Qp8nRZajLcmL6v1eqiQ+/TheTanNnteHoXFIsIkEwrjw91FUN8afc0PGqUuTzbnkwSZVTdhJAzZhn0uffPXcTvzPfy3WUFFy7vGb/ZAU42yUZrnv4wNQeZqzpzKxL3RsGG8eeXGeMamNmEfqp5MAQUBC3MnuBrBTM+CB2jln5qjRim9ov+Jrl7oRErgvuUgTMz6F4YGAXFXHkWvwRnE9YpOs5ptdbTnnGaBIBKxh5O7rFaLoQ7NytbFUchbgjiE7kd+f3NRNErNIoqFTn71+o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBA4C79627AE1041B0FC55441CDBB2C2@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3addb015-3cf9-4e08-a392-08d72f8bdbe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 09:56:42.9530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkO0qRPUtvt6zAbCfNW1YhQq9ufJnweGBuiy4Xtd/EFYqSimbFSmV6NSuYNSiko/DfGY6LlEv6lZrEOGj1d3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4579
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8zMS8yMDE5IDY6NDMgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24gRnJp
LCBBdWcgMzAsIDIwMTkgYXQgMDU6NTg6MjNQTSArMDAwMCwgTWF0ZWogR2VuY2kgd3JvdGU6DQo+
PiBPbiA4LzMwLzIwMTkgMzowMiBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPj4+IE9u
IFR1ZSwgQXVnIDI3LCAyMDE5IGF0IDAzOjIwOjU3UE0gKzAwMDAsIE1hdGVqIEdlbmNpIHdyb3Rl
Og0KPj4+PiBDb21waWxlcnMgc3VjaCBhcyBnKysgNy4zIGNvbXBsYWluIGFib3V0IGFzc2lnbmlu
ZyB2b2lkKiB2YXJpYWJsZSB0bw0KPj4+PiBhIG5vbi12b2lkKiB2YXJpYWJsZSAobGlrZSBzdHJ1
Y3QgcG9pbnRlcnMpIGFuZCBwb2ludGVyIGFyaXRobWV0aWNzDQo+Pj4+IG9uIHZvaWQqLg0KPj4+
Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXRlaiBHZW5jaSA8bWF0ZWouZ2VuY2lAbnV0YW5peC5j
b20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3JpbmcuaCB8
IDkgKysrKystLS0tDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgv
dmlydGlvX3JpbmcuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcmluZy5oDQo+Pj4+IGlu
ZGV4IDRjNGUyNGMyOTFhNS4uMmMzMzliOWUyOTIzIDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRl
L3VhcGkvbGludXgvdmlydGlvX3JpbmcuaA0KPj4+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgv
dmlydGlvX3JpbmcuaA0KPj4+PiBAQCAtMTY4LDEwICsxNjgsMTEgQEAgc3RhdGljIGlubGluZSB2
b2lkIHZyaW5nX2luaXQoc3RydWN0IHZyaW5nICp2ciwgdW5zaWduZWQgaW50IG51bSwgdm9pZCAq
cCwNCj4+Pj4gICAgCQkJICAgICAgdW5zaWduZWQgbG9uZyBhbGlnbikNCj4+Pj4gICAgew0KPj4+
PiAgICAJdnItPm51bSA9IG51bTsNCj4+Pj4gLQl2ci0+ZGVzYyA9IHA7DQo+Pj4+IC0JdnItPmF2
YWlsID0gcCArIG51bSpzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2MpOw0KPj4+PiAtCXZyLT51c2Vk
ID0gKHZvaWQgKikoKCh1aW50cHRyX3QpJnZyLT5hdmFpbC0+cmluZ1tudW1dICsgc2l6ZW9mKF9f
dmlydGlvMTYpDQo+Pj4+IC0JCSsgYWxpZ24tMSkgJiB+KGFsaWduIC0gMSkpOw0KPj4+PiArCXZy
LT5kZXNjID0gKHN0cnVjdCB2cmluZ19kZXNjICopcDsNCj4+Pj4gKwl2ci0+YXZhaWwgPSAoc3Ry
dWN0IHZyaW5nX2F2YWlsICopKCh1aW50cHRyX3QpcA0KPj4+PiArCQkrIG51bSpzaXplb2Yoc3Ry
dWN0IHZyaW5nX2Rlc2MpKTsNCj4+Pj4gKwl2ci0+dXNlZCA9IChzdHJ1Y3QgdnJpbmdfdXNlZCAq
KSgoKHVpbnRwdHJfdCkmdnItPmF2YWlsLT5yaW5nW251bV0NCj4+Pj4gKwkJKyBzaXplb2YoX192
aXJ0aW8xNikgKyBhbGlnbi0xKSAmIH4oYWxpZ24gLSAxKSk7DQo+Pj4+ICAgIH0NCj4+Pj4gICAg
DQo+Pj4+ICAgIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgdnJpbmdfc2l6ZSh1bnNpZ25lZCBpbnQg
bnVtLCB1bnNpZ25lZCBsb25nIGFsaWduKQ0KPj4+DQo+Pj4gSSdtIG5vdCByZWFsbHkgaW50ZXJl
c3RlZCBpbiBidWlsZGluZyB3aXRoIGcrKywgc29ycnkuDQo+Pj4gQ2VudGFpbmx5IG5vdCBpZiBp
dCBtYWtlcyBjb2RlIGxlc3Mgcm9idXN0IGJ5IGZvcmNpbmcNCj4+PiBjYXN0cyB3aGVyZSB0aGV5
IHdlcmVuJ3QgcHJldmlvdXNseSBuZWNlc3NhcnkuDQo+Pg0KPj4gQ2FuIHlvdSBlbGFib3JhdGUg
b24gaG93IHRoZXNlIGNhc3RzIG1ha2UgdGhlIGNvZGUgbGVzcyByb2J1c3Q/DQo+IA0KPiBJZiB3
ZSBldmVyIGNoYW5nZSB0aGUgdmFyaWFibGUgdHlwZXMgYnVpbGQgd2lsbCBzdGlsbCBwYXNzDQo+
IGJlY2F1c2Ugb2YgdGhlIGNhc3QuDQo+IA0KDQpXb3VsZG4ndCB0aGF0IGJlIHRoZSBjYXNlIGlu
IHRoZSBvcmlnaW5hbCBhcyB3ZWxsPw0KWW91J3JlIGFzc2lnbmluZyB2b2lkKiwgd2hpY2ggaXMg
aW1wbGljaXRseSBjYXN0IHRvIGV2ZXJ5dGhpbmcuDQoNCj4+IFRoZXkgYXJlbid0IG5lY2Vzc2Fy
eSBpbiBDIGJ1dCBJIHRoaW5rIGJlaW5nIGV4cGxpY2l0IGNhbiBpbXByb3ZlDQo+PiByZWFkYWJp
bGl0eSBhcyBhcmd1ZWQgaW4NCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92
Mi91cmw/dT1odHRwcy0zQV9fc29mdHdhcmVlbmdpbmVlcmluZy5zdGFja2V4Y2hhbmdlLmNvbV9h
XzI3NTcxNCZkPUR3SUJBZyZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1kYlBERG41MkpnWm5k
ZC1XUHZHY0w1UExaVHJtcy03MlRJdFlKeC1JZjVJJm09c3c2eHhDMkVPRjlnM1h0VUt1STZPdlQ1
eGhZRjdYY1dCcXlRdkdiLVVNdyZzPVFXb1pIRjRYbE96UGVzbm5iZnNmMV9LT1JyemtYYjZ5ZmQ2
eVFHQ3dlcGMmZT0NCj4+DQo+Pj4NCj4+PiBIb3dldmVyLCB2cmluZ19pbml0IGFuZCB2cmluZ19z
aXplIGFyZSBsZWdhY3kgQVBJcyBhbnl3YXksDQo+Pj4gc28gSSdkIGJlIGhhcHB5IHRvIGFkZCBp
Zm5kZWZzIHRoYXQgd2lsbCBhbGxvdyB1c2Vyc3BhY2UNCj4+PiBzaW1wbHkgaGlkZSB0aGVzZSBm
dW5jdGlvbnMgaWYgaXQgZG9lcyBub3QgbmVlZCB0aGVtLg0KPj4+DQo+Pg0KPj4gSSBmZWVsIGxp
a2UgbXkgcGF0Y2ggaXMgYSBoYXJtbGVzcyB3YXkgb2YgYWxsb3dpbmcgdGhpcyBoZWFkZXINCj4+
IHRvIGJlIHVzZWQgaW4gQysrIHByb2plY3RzLCBidXQgSSdtIGhhcHB5IHRvIGRyb3AgaXQgaW4g
bGlldSBvZg0KPj4gdGhlIGd1YXJkcyBpZiB5b3UgZmVlbCBzdHJvbmdseSBhYm91dCBpdC4NCj4+
DQo+PiBUaGFua3MuDQo+PiBNYXRlag0KPiANCj4gWWVhIGxldCdzIG5vdCBldmVuIHN0YXJ0Lg0K
PiANCg0KU3VyZS4gSSBjYW4gcmUtc2VuZCB0aGUgcGF0Y2ggd2l0aCBndWFyZHMuIEJ1dCBmb3Ig
bXkgb3duIHNha2UsDQpjYW4geW91IGVsYWJvcmF0ZSBvbiB0aGUgYWJvdmU/DQoNCj4+Pg0KPj4+
PiAtLSANCj4+Pj4gMi4yMi4wDQo+Pj4+DQo+Pg0KDQo=
