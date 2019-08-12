Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD73C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892862070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="YmoSH13G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfHLRtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:49:36 -0400
Received: from mail-eopbgr70107.outbound.protection.outlook.com ([40.107.7.107]:27911
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbfHLRtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfwgWpvBtf/jQXthfKcoIMQDjPwvZtyZUobrAZHHTsc7rFFWwwfCJKxCE97WtBu7P94O5fWevAURhuMtBheafa7ohQNQ9X91wUq72NaG1R+p9lo5fHur2YRyEJskivIsPMKZCgw+7ESKVe6HdEJ/JWp5lGygZYjmS9Dk+1CponotS6oIFy3bdAdy6p3lo2XfxMn+5fs7ujtLxMgyDRRzETgijD8154yjHSZFcopDfH2XHx7YJSTQD0auIy6lHEFEWncdvggjHfDfxR3xDmCRlLZ3C5qE7qZM9ioMRmA5oaIT4b19u1RvmbBUd2fdRi+XuWxfH3YETMszSyBaVgta0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CtBFeGe3qtsx/6kiZdcri0XgFfxXXb6YtYbhqjal70=;
 b=K0gWX5eV8UVkbFL5xAyXNymq63wkGofg3RAALS46UBjRD7BJAXOWrqriQosU6XUiWpNB8U7YXe+93y4z41sM3OoJtJMNb3QMMc+pWerT3m8KEivyX+swe9bKwnXQigIO9tPauuXZORCNiwEUo6+wvRjsze5DXt95AZLFrmdPHFturbJ2J2sQdtReR78HZbsumM9FJGx4XkTz7tYYgE5vlC84H0B7SJfXQfsqHomRZBuevsa7pr4L08j1rvi5gaDlz1sfBjXOrvpH9mhT1eXZZXR6vIdtE8oFkLETaocnBKmhLUKpyErzBXrrHS600NEtJigpFgtNjcyyEg0q5bw9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CtBFeGe3qtsx/6kiZdcri0XgFfxXXb6YtYbhqjal70=;
 b=YmoSH13G7wCArd1HnV5Tt1KrIgUxDExkjD7I+zGslz9Yg0An/Y7oXP4W3aGLfh6P1cHD7vF/31Lvwry/nUbiCJdYRch/Jf6SogV4qssr0+Hn3S6ugvUgYRvmgfb9v6ORIC89X/zSfziPuZRGqHR5hhw4RQlMOaJIP5aE0fg9g8g=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3501.eurprd04.prod.outlook.com (52.134.4.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Mon, 12 Aug 2019 17:49:30 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 17:49:29 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
Thread-Topic: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Thread-Index: AQHVTidIVfq9W1HbR0i2bNtry39Joab0Aj2AgAN9ywCAADnOgIAAFmOA
Date:   Mon, 12 Aug 2019 17:49:29 +0000
Message-ID: <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
 <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
In-Reply-To: <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
Reply-To: Stephen Douthit <stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:408:34::37) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a9839d-54ce-49b6-26a9-08d71f4d6cba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB3501;
x-ms-traffictypediagnostic: VI1PR0402MB3501:
x-microsoft-antispam-prvs: <VI1PR0402MB35014721069EDBD6786BF4C894D30@VI1PR0402MB3501.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(66066001)(3450700001)(6916009)(71200400001)(71190400001)(2616005)(478600001)(2906002)(476003)(11346002)(7736002)(446003)(14454004)(486006)(305945005)(4326008)(6486002)(66446008)(25786009)(64756008)(66476007)(66556008)(66946007)(5660300002)(86362001)(31696002)(53936002)(6436002)(3846002)(6116002)(6512007)(229853002)(6246003)(8676002)(36756003)(43066004)(81156014)(81166006)(14444005)(256004)(54906003)(316002)(8936002)(26005)(186003)(102836004)(99286004)(31686004)(52116002)(53546011)(6506007)(386003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3501;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rfm/NM301eRKzKSbTHezD5NGAptDIJ5sQaflxRDa0RRcXssMyA6RKWhYoj3omTa1/5jRbqtLGhvriwhtLOKLds+tIPJgXalGNB9/31g0tS/f5ut3rU/S/edq20tjEenwFeclqajQQDMD8P88Z1KdQpAfyE7PqnLKzhYomJlDkGNSzZ16btgk6odQX5AnTJ7O+tUMXBYvMmC2ofGD1lWcvmKKebu4atR4UI6NfJyaib0bc0cgIuziNnFm0aSUEJRJfyXfKrz0ifcNnplv5sOxGVy/M670R4xPirW7j1if/4QyloO7gVqn6BKv+1sB7GLoB7yQ43pOLurlfzLyocEl+nlBAJ6rxp4p8Zmvq+TL9kx0SzAvZVQzox2lKPXFw2ojMfwMxyh/7n/Lj8VRmdiJH3dCkUC+FzF2Xb7VvwHx/7s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B712A294BF548248B951E1C92541A3E6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a9839d-54ce-49b6-26a9-08d71f4d6cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 17:49:29.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Wsn/RwsBVl7knm5PBvLjRjTl4ajn6oLpv+vdR4svgzC30ttAEWRUd+KEu+89y7ZVrf5krDxdJR5yl6pGHgZLnJEkUryIQlvg0w/UojN+rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMi8xOSAxMjoyOSBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBPbiBNb24sIEF1ZyAx
MiwgMjAxOSBhdCA2OjAzIEFNIFN0ZXBoZW4gRG91dGhpdA0KPiA8c3RlcGhlbmRAc2lsaWNvbS11
c2EuY29tPiB3cm90ZToNCj4+DQo+PiBPbiA4LzEwLzE5IDM6NDMgQU0sIENocmlzdG9waCBIZWxs
d2lnIHdyb3RlOg0KPj4+IE9uIFRodSwgQXVnIDA4LCAyMDE5IGF0IDA4OjI0OjMxUE0gKzAwMDAs
IFN0ZXBoZW4gRG91dGhpdCB3cm90ZToNCj4+Pj4gSW50ZWwgbW92ZWQgdGhlIFBDUyByZWdpc3Rl
ciBmcm9tIDB4OTIgdG8gMHg5NCBvbiBEZW52ZXJ0b24gZm9yIHNvbWUNCj4+Pj4gcmVhc29uLCBz
byBub3cgd2UgZ2V0IHRvIGNoZWNrIHRoZSBkZXZpY2UgSUQgYmVmb3JlIHBva2luZyBpdCBvbiBy
ZXNldC4NCj4+Pg0KPj4+IEFuZCBub3cgeW91IGp1c3QgbWF0Y2ggb24gdGhlIG5ldyBJRHMsIHdo
aWNoIG1lYW5zIHdlJ2xsIHBlcnBldHVhbGx5DQo+Pj4gY2F0Y2ggdXAgb24gYW55IG5ldyBkZXZp
Y2UuICBEYW4sIGNhbiB5b3UgcmVhY2ggb3V0IGluc2lkZSBJbnRlbCB0bw0KPj4+IGZpZ3VyZSBv
dXQgaWYgdGhlcmUgaXMgYSB3YXkgdG8gZmluZCBvdXQgdGhlIFBDUyByZWdpc3RlciBsb2NhdGlv
bg0KPj4+IHdpdGhvdXQgdGhlIFBDSSBJRCBjaGVjaz8NCj4+Pg0KPj4+DQo+Pj4+ICAgIHN0YXRp
YyBpbnQgYWhjaV9wY2lfcmVzZXRfY29udHJvbGxlcihzdHJ1Y3QgYXRhX2hvc3QgKmhvc3QpDQo+
Pj4+ICAgIHsNCj4+Pj4gICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGhv
c3QtPmRldik7DQo+Pj4+IEBAIC02MzQsMTMgKzY2OSwxNCBAQCBzdGF0aWMgaW50IGFoY2lfcGNp
X3Jlc2V0X2NvbnRyb2xsZXIoc3RydWN0IGF0YV9ob3N0ICpob3N0KQ0KPj4+Pg0KPj4+PiAgICAg
ICBpZiAocGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfSU5URUwpIHsNCj4+Pj4gICAgICAg
ICAgICAgICBzdHJ1Y3QgYWhjaV9ob3N0X3ByaXYgKmhwcml2ID0gaG9zdC0+cHJpdmF0ZV9kYXRh
Ow0KPj4+PiArICAgICAgICAgICAgaW50IHBjcyA9IGFoY2lfcGNzX29mZnNldChob3N0KTsNCj4+
Pj4gICAgICAgICAgICAgICB1MTYgdG1wMTY7DQo+Pj4+DQo+Pj4+ICAgICAgICAgICAgICAgLyog
Y29uZmlndXJlIFBDUyAqLw0KPj4+PiAtICAgICAgICAgICAgcGNpX3JlYWRfY29uZmlnX3dvcmQo
cGRldiwgMHg5MiwgJnRtcDE2KTsNCj4+Pj4gKyAgICAgICAgICAgIHBjaV9yZWFkX2NvbmZpZ193
b3JkKHBkZXYsIHBjcywgJnRtcDE2KTsNCj4+Pj4gICAgICAgICAgICAgICBpZiAoKHRtcDE2ICYg
aHByaXYtPnBvcnRfbWFwKSAhPSBocHJpdi0+cG9ydF9tYXApIHsNCj4+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgdG1wMTYgfD0gaHByaXYtPnBvcnRfbWFwOw0KPj4+PiAtICAgICAgICAgICAgICAg
ICAgICBwY2lfd3JpdGVfY29uZmlnX3dvcmQocGRldiwgMHg5MiwgdG1wMTYpOw0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICB0bXAxNiB8PSBocHJpdi0+cG9ydF9tYXAgJiAweGZmOw0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICBwY2lfd3JpdGVfY29uZmlnX3dvcmQocGRldiwgcGNzLCB0bXAx
Nik7DQo+Pj4+ICAgICAgICAgICAgICAgfQ0KPj4+PiAgICAgICB9DQo+Pj4NCj4+PiBBbmQgU3Rl
cGhlbiwgd2hpbGUgeW91IGFyZSBhdCBpdCwgY2FuIHlvdSBzcGxpdCB0aGlzIEludGVsLXNwZWNp
ZmljDQo+Pj4gcXVpcmsgaW50byBhIHNlcGFyYXRlIGhlbHBlcj8NCj4+DQo+PiBJIGNhbiBkbyB0
aGF0LiAgSSdsbCB3YWl0IHVudGlsIHdlIGhlYXIgYmFjayBmcm9tIERhbiBpZiB0aGVyZSdzIGEN
Cj4+IGJldHRlciBzY2hlbWUgdGhhbiBhIGRldmljZSBJRCBsb29rdXAuDQo+IA0KPiBEbyB5b3Ug
c2VlIGFueSBiZWhhdmlvciBjaGFuZ2UgaW4gcHJhY3RpY2Ugd2l0aCB0aGlzIHBhdGNoPyBJdCdz
DQo+IHB1cnBvcnRlZGx5IHRvIHJlLWVuYWJsZSB0aGUgcG9ydHMgYWZ0ZXIgYSByZXNldCwgYnV0
IHRoYXQgd291bGQgb25seQ0KPiBiZSBuZWVkZWQgaWYgdGhlIGVudGlyZSBwY2kgZGV2aWNlIHJl
c2V0LiBJbiB0aGlzIHBhdGggdGhlIHJlc2V0IGlzDQo+IGJlaW5nIHBlcmZvcm1lZCB2aWEgdGhl
IGhvc3QgY29udHJvbCByZWdpc3Rlci4gVGhhdCBpcyBvbmx5IG1lYW50IHRvDQo+IHRvdWNoIG1t
aW8gcmVnaXN0ZXJzLCBub3QgY29uZmlnIHJlZ2lzdGVycy4gU28sIGFzIGZhciBhcyBJIGNhbiBz
ZWUNCj4gdGhpcyByZWdpc3RlciBiaXQgdHdpZGRsaW5nIGFmdGVyIHJlc2V0IGhhcyBuZXZlciBi
ZWVuIG5lY2Vzc2FyeS4NCg0KTm90IG9uIERlbnZlcnRvbi4gIEkgaGF2ZSBzZWVuIEFIQ0kgcmVz
ZXQgaXNzdWVzIG9uIEF2b3Rvbi9SYW5nZWxleSwgYnV0DQpJJ2QgaGF2ZSB0byBnbyBkaWdnaW5n
IGF0IHRoaXMgcG9pbnQgdG8ga25vdyBmb3Igc3VyZSBpZiB0aGV5IHdlcmUgZml4ZWQNCnNvbGVs
eSBieSB0aGUgYWhjaV9hdm5faGFyZHJlc2V0KCkgd29ya2Fyb3VuZCwgb3IgdGhhdCBpbiBjb21i
aW5hdGlvbg0Kd2l0aCB0aGUgZXhpc3RpbmcgUENTIHdvcmthcm91bmQuDQoNCkkgZm91bmQgdGhp
cyBub3QgYmVjYXVzZSBvZiBmYWlsdXJlIEkgc2F3IGluIExpbnV4LCBidXQgYmVjYXVzZSBJIHdh
cw0KdXNpbmcgdGhlIExpbnV4IGRyaXZlciBhcyByZWZlcmVuY2Ugd2hpbGUgZGVidWdnaW5nIHRo
ZSB1LWJvb3QgQUhDSQ0KZHJpdmVyLiAgV2hlbiBJIGNvdWxkbid0IGZpbmQgY29uZmlnIHNwYWNl
IG9mZnNldCAweDkyIGRlZmluZWQgaW4gdGhlDQpEZW52ZXJ0b24gRURTIEkgd2VudCBkaWdnaW5n
LCBhbmQgdGhhdCdzIHdoZXJlIHRoZSBwYXRjaCBjb21lcyBmcm9tLg0KDQpJIHdhc24ndCBxdWlj
a2x5IGFibGUgdG8gZmluZCB3aGF0IGNoaXBzZXQgdGhlIFBDUyB3b3JrYXJvdW5kIHdhcyBhZGRl
ZA0KZm9yLiAgSWYgaXQncyBmb3IgYW4gb2Jzb2xldGUgY2hpcHNldCB0aGVuIGRyb3BwaW5nIHRo
aXMgZW50aXJlbHkgd291bGQNCmJlIGNsZWFuZXIuDQoNCkRvZXMgYW55b25lIGtub3cgdGhlIGJh
Y2tncm91bmQgb2YgdGhlIG9yaWdpbmFsIFBDUyB3b3JrYXJvdW5kPw0K
