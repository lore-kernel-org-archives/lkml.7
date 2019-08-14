Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02EFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7D02083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="xYU3fNas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfHNOeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:34:15 -0400
Received: from mail-eopbgr130122.outbound.protection.outlook.com ([40.107.13.122]:28222
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfHNOeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4JF44Sq+je9nPfk0Xux88CRFW+11Zhz4ycPUOPbT6Tw+270ewrNzHyYilYEIt1eI3pYMElA/IDladhUsxD7X6Ofxwc9eQVrTtKiXHjLZjoKnLaPnMO51F0eoS2FBFpY6zJimR0uKE4dQV5T2HFTjpHRV/bw/qNw+TjgKZfVZRXEWHjurd/qbjx8R0Lcwv+ial4glYy/UNd2e4F8YzWnqBXtFk+QCoeOjsyQXG2p5jfRsXfGp9GkQvKpQZJXtv7nIYwORADIraMNWakNlO/1CIsa6W7PxsHyUxemUWbZVVVmAcsDB1rVbGc/mRkWhlIU1QJD49SbY14YGQ5JQWP/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neaORzkuSUjdxaXP6cbsshQ1CBLNBNXH69ksClyFaWU=;
 b=ERXi87l39dGrWCYpbHv/bRfue7dlwWYovfwVX98BxPauJifp1rMuW4TbTaPiagYkrW90ZzhJexTddUiOqI7AQ9stnSYCfAH4rk8odX5axV2HpnlRxJQ7YcLcczGyGjZyJO1aOCdCzpcjnP+KLizhals3YXLcGj2+0Srbz0H3ArJkeV93NDvlIAQlWZj2CgCzhsn8n5MicEvKs6/nodKZnkAqMUGGUzckWu882inAPAHjhs0QsN9ZyOi5SMOv83U8gtDgD8XFn0RVqL8YsEZzlcwQVz7KgpaC5TTJCIkHo39ns+KwSINILxvybuiDgGhVbeHRFPnvkzghWFecTFUjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neaORzkuSUjdxaXP6cbsshQ1CBLNBNXH69ksClyFaWU=;
 b=xYU3fNaszL14+PqhiSa14lcTrJ8ML4JAJNhhWRxE9LWPHyCpzTOONVW8k83edhyHD7Zx4dTcwne48VqxLp0gXxQdN5M6lPuX1g58+mnf4Dut6Yh0z/IF1nT+glSi+i3M0XTjId2UTwM0PNuru61uYtcv4EgD7BtJpVWeaEt2nXI=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB2703.eurprd04.prod.outlook.com (10.172.255.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Wed, 14 Aug 2019 14:34:07 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 14:34:07 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
Thread-Topic: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Thread-Index: AQHVTidIVfq9W1HbR0i2bNtry39Joab0Aj2AgAN9ywCAADnOgIAAFmOAgAAEuYCAABfagIAAyLIAgAD1I4CAAROyAA==
Date:   Wed, 14 Aug 2019 14:34:07 +0000
Message-ID: <c023a18c-8b70-dc59-3db8-51d3a6b23d3c@silicom-usa.com>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
 <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com>
 <20190812180613.GA18377@infradead.org>
 <CAA9_cme3saBAJEyob3B1tX=t8keTodWJZMUd1j_v7vPMRU+aXA@mail.gmail.com>
 <20190813072954.GA23417@infradead.org>
 <CAPcyv4h5kCKVyCjomBUY27MJwheDZ8v87+a9K-2YCgyqRWR7eQ@mail.gmail.com>
In-Reply-To: <CAPcyv4h5kCKVyCjomBUY27MJwheDZ8v87+a9K-2YCgyqRWR7eQ@mail.gmail.com>
Reply-To: Stephen Douthit <stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0083.namprd02.prod.outlook.com
 (2603:10b6:405:60::24) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ca9e2d6-259d-4442-bb0c-08d720c47658
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB2703;
x-ms-traffictypediagnostic: VI1PR0402MB2703:
x-microsoft-antispam-prvs: <VI1PR0402MB270301D99A4D6EA3A29357E794AD0@VI1PR0402MB2703.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(366004)(136003)(346002)(376002)(189003)(199004)(6486002)(26005)(66556008)(66946007)(64756008)(66446008)(14454004)(66476007)(5660300002)(305945005)(229853002)(478600001)(486006)(66066001)(110136005)(316002)(71190400001)(8936002)(7736002)(6436002)(71200400001)(43066004)(25786009)(2906002)(446003)(54906003)(6116002)(76176011)(476003)(3450700001)(99286004)(31696002)(81156014)(6512007)(102836004)(86362001)(4326008)(186003)(81166006)(53546011)(31686004)(2616005)(8676002)(386003)(14444005)(256004)(6506007)(53936002)(52116002)(3846002)(11346002)(36756003)(6246003)(69594002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB2703;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nUThwNzi9PpTM/DL/1SHDfIkRXPzy66ObLA/Sp9SZx34h3ZDA5bBrOJry6ZlvTi7tWssLK9lAe17F+zLBhE7d8ldzur+5M3lMS/lVu6bJv8Qa8Vkc1UEMSpnw67fwCdRhJsQqtIgKtpKCyGftfZg9tZnMdHsD4DBO5Psdl7koB8Buxl1nL5Efj0MBMWX9MYlwlZ1YkNRwa2ji5VV1DcUoH4rkEzH44IOh6Lla6g9F0p/7+LaVzpvGkJAxWxn1bbf9KEYIwk1A1io1jNFrfeteF1wqyPtl/A4iU5cW1p4pB8yGOMd2SQONUcreaBRZxuCPkyi0e0QBo9X0Y5k1v+ETNX6MjP6HCa017OrLMLd4zF0xDIzouAWSq3wah21rdHxB+uVE64PO6PMQUaH66UW+iCID9duJZBnG2M+ytIOsCA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2EF2236FBF3D34C83B14917503EAB37@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca9e2d6-259d-4442-bb0c-08d720c47658
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 14:34:07.1498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blLo4t2PRhgBuknSxDzcy6oFhjV0t1iMfdodOuZbKa9qZarJji6Jy8X7j3wlHz+tJPg/VFEnFtnvW6f3kgt604ygfmg5CifYJHoUPbwTDm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2703
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMy8xOSA2OjA3IFBNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IE9uIFR1ZSwgQXVnIDEz
LCAyMDE5IGF0IDEyOjMxIEFNIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4g
d3JvdGU6DQo+Pg0KPj4gT24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgMTI6MzE6MzVQTSAtMDcwMCwg
RGFuIFdpbGxpYW1zIHdyb3RlOg0KPj4+IEl0IHNlZW1zIHBsYXRmb3JtcyAvIGNvbnRyb2xsZXJz
IHRoYXQgZmFpbCB0byBydW4gdGhlIG9wdGlvbi1yb20NCj4+PiBzaG91bGQgYmUgcXVpcmtlZCBi
eSBkZXZpY2UtaWQsIGJ1dCB0aGUgUENTIHJlZ2lzdGVyIHR3aWRkbGluZyBiZQ0KPj4+IHJlbW92
ZWQgZm9yIGV2ZXJ5b25lIGVsc2UuICJDYXJkIEJJT1MiIHRvIG1lIGltcGxpZXMgZGV2aWNlcyB3
aXRoIGFuDQo+Pj4gT3B0aW9uLVJPTSBCQVIgd2hpY2ggSSBkb24ndCB0aGluayBtb2Rlcm4gZGV2
aWNlcyBoYXZlLCBzbyB0aGF0IG1pZ2h0DQo+Pj4gYmUgYSBzaW1wbGUgd2F5IHRvIHRyeSB0byBw
aGFzZSBvdXQgdGhpcyBxdWlyayBnb2luZyBmb3J3YXJkIHdpdGhvdXQNCj4+PiByZWdyZXNzaW5n
IHdvcmtpbmcgc2V0dXBzIHRoYXQgbWlnaHQgYmUgcmVseWluZyBvbiB0aGlzLg0KPj4+DQo+Pj4g
VGhlbiBhZ2FpbiB0aGUgZHJpdmVyIGlzIGFscmVhZHkgZGVwZW5kaW5nIG9uIHRoZSBudW1iZXIg
b2YgZW5hYmxlZA0KPj4+IHBvcnRzIHRvIGJlIHJlbGlhYmxlIGJlZm9yZSBQQ1MgaXMgd3JpdHRl
biwgYW5kIHRoZSBjdXJyZW50IGRyaXZlcg0KPj4+IGRvZXMgbm90IGF0dGVtcHQgdG8gZW5hYmxl
IHBvcnRzIHRoYXQgd2VyZSBub3QgZW5hYmxlZCBwcmV2aW91c2x5Lg0KPj4+IFRoYXQgdGVsbHMg
bWUgdGhhdCBpZiB0aGUgUENTIHF1aXJrIGV2ZXIgbWF0dGVyZWQgaXQgd291bGQgaGF2ZQ0KPj4+
IGFscmVhZHkgcmVncmVzc2VkIHdoZW4gdGhlIGRyaXZlciBzd2l0Y2hlZCBmcm9tIGJsaW5kbHkg
d3JpdGluZyAweGYgdG8NCj4+PiBvbmx5IHNldHRpbmcgdGhlIGJpdHMgdGhhdCB3ZXJlIGFscmVh
ZHkgc2V0IGluIC0+cG9ydF9tYXAuDQo+Pg0KPj4gQnV0IGhvdyBkbyB3ZSBmaW5kIHRoYXQgb3V0
Pw0KPiANCj4gV2UgY2FuIGxheWVyIGFub3RoZXIgYXNzdW1wdGlvbiBvbiB0b3Agb2YgVGVqdW4n
cyBhc3N1bXB0aW9ucyBmcm9tDQo+IGNvbW1pdCA0OWYyOTA5MDM5MzUgImFoY2k6IHVwZGF0ZSBQ
Q1MgcHJvZ3JhbW1pbmciLiBUaGUga2VybmVsDQo+IGNvbW11bml0eSBoYXMgbm90IHJlY2VpdmVk
IGFueSByZWdyZXNzaW9uIHJlcG9ydHMgZnJvbSB0aGF0IGNoYW5nZQ0KPiB3aGljaCBzYXlzOg0K
PiANCj4gIg0KPiAgICAgIHBvcnRfbWFwIGlzIGRldGVybWluZWQgZnJvbSBQT1JUU19JTVBMIFBD
SSByZWdpc3RlciB3aGljaCBpcw0KPiAgICAgIGltcGxlbWVudGVkIGFzIHdyaXRlIG9yIHdyaXRl
LW9uY2UgcmVnaXN0ZXIuICBJZiB0aGUgcmVnaXN0ZXIgaXNuJ3QNCj4gICAgICBwcm9ncmFtbWVk
LCBhaGNpIGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVzIGl0IGZyb20gbnVtYmVyIG9mIHBvcnRzLA0K
PiAgICAgIHdoaWNoIGlzIGdvb2QgZW5vdWdoIGZvciBQQ1MgcHJvZ3JhbW1pbmcuICBJQ0g2LzdN
IGFyZSBwcm9iYWJseSB0aGUNCj4gICAgICBvbmx5IG9uZXMgd2hlcmUgbm9uLWNvbnRpZ3VvdXMg
ZW5hYmxlIGJpdHMgYXJlIG5lY2Vzc2FyeSAmJiBQT1JUU19JTVBMDQo+ICAgICAgaXNuJ3QgcHJv
Z3JhbW1lZCBwcm9wZXJseSBidXQgdGhleSdyZSBwcm92ZW4gdG8gd29yayByZWxpYWJseSB3aXRo
IDB4Zg0KPiAgICAgIGFueXdheS4NCj4gIg0KPiANCj4gU28gdGhlIHBvdGVudGlhbCBvcHRpb25z
IEkgc2VlIGFyZToNCj4gDQo+IDEvIEtlZXAgdGhlIGN1cnJlbnQgc2NoZW1lLCBidXQgbGltaXQg
aXQgdG8gY2FzZXMgd2hlcmUgUE9SVFNfSU1QTCBpcw0KPiBsZXNzIHRoYW4gOCBhbmQgYXNzdW1l
IHRoaXMgbmVlZCB0byBzZXQgdGhlIGJpdHMgaXMgdW5uZWNlc3NhcnkgbGVnYWN5DQo+IHRvIGNh
cnJ5IGZvcndhcmQNCj4gDQo+IDIvIE9wdGlvbjEgKyBhZGRpdGlvbmFsbHkgdXNlIFBPUlRTX0lN
UEwgYXMgYSBnYXRlIHRvIGd1ZXNzIHdoZW4gdGhlDQo+IFBDUyBmb3JtYXQgbWlnaHQgYmUgZGlm
ZmVyZW50IGZvciB2YWx1ZXMgPj0gOC4NCj4gDQo+IEkgdGhpbmsgdGhlIGRyaXZlciBkb2VzIG5v
dCBuZWVkIHRvIGNvbnNpZGVyIE9wdGlvbjIgdW5sZXNzIC8gdW50aWwgaXQNCj4gZW5jb3VudGVy
cyBhIHBsYXRmb3JtIHdoZXJlIGZpcm13YXJlIGRvZXMgbm90ICJkbyB0aGUgcmlnaHQgdGhpbmci
LA0KPiBhbmQgZ2l2ZW4gRGVudmVydG9uIGhhcyBiZWVuIGluIHRoZSB3aWxkIHdpdGggdGhlIHdy
b25nIFBDUyB0d2lkZGxpbmcNCj4gaXQgc2VlbXMgdG8gc3VnZ2VzdCBub3RoaW5nIG5lZWRzIHRv
IGJlIGRvbmUgdGhlcmUuDQo+IA0KPj4gQSBjb21wcm9taXNlIHRvIG1lIHNlZW1zIHRoYXQgd2Ug
anVzdCBkbyB0aGUgUENTIHF1aXJrIGZvciBhbGwgSW50ZWwNCj4+IGRldmljZXMgZXhwbGljaXRs
eSBsaXN0ZWQgaW4gdGhlIFBDSSBJZHMgYmFzZWQgb24gbmV3IGJvYXJkXyogdmFsdWVzDQo+PiBh
cyBsb25nIGFzIHRoZXkgaGF2ZSB0aGUgb2xkIFBDUyBsb2NhdGlvbiwgYW5kIGFzc3VtZSBhbnl0
aGluZyBuZXcNCj4+IGVub3VnaCB0byBoYXZlIHRoZSBuZXcgbG9jYXRpb24gd29uJ3QgbmVlZCB0
byBxdWlyaywgZ2l2ZW4gdGhhdCBpdA0KPj4gbmV2ZXIgcHJvcGVybHkgd29ya2VkLiAgVGhpcyBt
aWdodCBtaXNzIHNvbWUgaW50ZWwgZGV2aWNlcyB0aGF0IHdlcmUNCj4+IHN1cHBvcnRlZCB3aXRo
IHRoZSBjbGFzcyBiYXNlZCBjYXRjaGFsbCwgdGhvdWdoLg0KPiANCj4gSSdkIGJlIG1vcmUgY29t
Zm9ydGFibGUgd2l0aCBQT1JUX0lNUEwgYXMgdGhlIGRlY2lkaW5nIGZhY3Rvci4NCg0KVW5mb3J0
dW5hdGVseSB3ZSBjYW4ndCB1c2UgQ0FQLk5QIG9yIFBPUlRTX0lNUEwgZm9yIHRoaXMgaGV1cmlz
dGljLg0KDQpUaGUgcHJvYmxlbSBpcyB0aGF0IEJJT1Mgc2hvdWxkIGJlIHNldHRpbmcgdGhlIFBP
UlRTX0lNUEwgYml0bWFzayB0bw0KbWF0Y2ggd2hpY2ggbGFuZXMgaGF2ZSBhY3R1YWxseSBiZWVu
IGNvbm5lY3RlZCBvbiB0aGUgYm9hcmQuICBTbw0KUE9SVFNfSU1QTCBjYW4gYmUgPCA4IGV2ZW4g
aWYgdGhlIGNvbnRyb2xsZXIgaXMgbmV3IGVub3VnaCB0bw0KcG90ZW50aWFsbHkgc3VwcG9ydCA+
IDggYW5kIGhhcyB0aGUgbmV3IGNvbmZpZyBzcGFjZSBsYXlvdXQuDQoNCkFzIHByb29mIGhlcmUn
cyB0aGUgcmVsZXZhbnQgYWhjaV9wcmludF9pbmZvKCkgb3V0cHV0IGJvb3Rpbmcgb24gYQ0KRGVu
dmVydG9uIGJhc2VkIGJveCB3aXRoIDUgcG9ydHMgaW1wbGVtZW50ZWQ6DQoNCmFoY2kgMDAwMDow
MDoxNC4wOiBBSENJIDAwMDEuMDMwMSAzMiBzbG90cyA1IHBvcnRzIDYgR2JwcyAweDdhIGltcGwg
U0FUQSBtb2RlDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBcLVBPUlRTX0lNUEwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXC1DQVAuTlANCg==
