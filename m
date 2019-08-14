Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FA9C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217742063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="u9cqcL1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfHNQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:54:06 -0400
Received: from mail-eopbgr30103.outbound.protection.outlook.com ([40.107.3.103]:32416
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728219AbfHNQyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDjwYedh7pyvchbJmSNXRf/wczCFAUHqZ4+4oFchsOhTqdb5fE9FtrTCtQGPE46PM52B3hrygEfPHvZGiYMJKceFDXVnzZ98fGyzRX0OxoZ9SXHUmmG9CPenqcm7QvdPQiRW63qzUIhjvxpTA2Kjpm+nvACWCZKZN2Hl2J+IaDM/86EKAGtnHVpFUEyVxNpACah8BJWGryg0jrFmCPXMciGU8WN+zBMv1z3dkWgSX5ETIKWJfUnAX0y+w2aHo66enzFSESGoA2ITscZWPT77tRfu2pnN2xm8WDUs6aqalgHPoMkUkv6Li6W4/mrP5hGaVHoq7R70WTh3x9kFg/MTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6j3Q/+NnXnSsCSq+wEd9w0mMp7NHFK3g6550IXWr2I=;
 b=Dk6CRhWaAZ/di2dYWtAHTG0Kx1pYQJP/B37NZMK9Mb2x0TDTxQUJCIgKE/hHSszSu88XzlRChR2iasfMg69UlQ3UnTSLyrkcgAqRCr/95m0gnUriF0WLPewivrMtGDmYCylqSmBj91TETvvmF5nbfDJmiunzYclrFormagPCaNrTDGXPfYrVMobWDI8t5Ggi7iQ9Fi8h+UYFKXHck+twynmcyZd1LtZDHdN3zsJaRnTRl9NYwcQv6kUUkyGjQ79zKxQur5YwNG9gr+wQzlPWKXMTulGjJWUzBM32DJTkTfCTz2mWKZIWIj3kCK2eBrjegKO58K5MlYEBgrw0QaS2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6j3Q/+NnXnSsCSq+wEd9w0mMp7NHFK3g6550IXWr2I=;
 b=u9cqcL1gYSQ5fXFNlxDGkhETvSjzySotFTKYrZfFsne8cppRCaxKSi8o/GrMi/wg18xRniGpoNfehd8NXlYMeZKLSGMbBKYSv9WZN5FbRH7audcnMDZy7dc3vXK+f1jDLtI9AYOCrbE/Baycuop+qWWnmEW1r/lrTj4Mr1SpT/s=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3855.eurprd04.prod.outlook.com (52.134.16.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Wed, 14 Aug 2019 16:54:00 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 16:54:00 +0000
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
Thread-Index: AQHVTidIVfq9W1HbR0i2bNtry39Joab0Aj2AgAN9ywCAADnOgIAAFmOAgAAEuYCAABfagIAAyLIAgAD1I4CAAROyAIAAGoqAgAAMi4A=
Date:   Wed, 14 Aug 2019 16:54:00 +0000
Message-ID: <40ef7e71-2c87-9853-fcbd-1510b97647f0@silicom-usa.com>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
 <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com>
 <20190812180613.GA18377@infradead.org>
 <CAA9_cme3saBAJEyob3B1tX=t8keTodWJZMUd1j_v7vPMRU+aXA@mail.gmail.com>
 <20190813072954.GA23417@infradead.org>
 <CAPcyv4h5kCKVyCjomBUY27MJwheDZ8v87+a9K-2YCgyqRWR7eQ@mail.gmail.com>
 <c023a18c-8b70-dc59-3db8-51d3a6b23d3c@silicom-usa.com>
 <CAPcyv4jcaY04nu31oStLc-eCO-+T1iOpxARmAHvPS1jxKF9cQA@mail.gmail.com>
In-Reply-To: <CAPcyv4jcaY04nu31oStLc-eCO-+T1iOpxARmAHvPS1jxKF9cQA@mail.gmail.com>
Reply-To: Stephen Douthit <stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1301CA0010.namprd13.prod.outlook.com
 (2603:10b6:405:29::23) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69c29725-9616-4bf9-e1b6-08d720d8014b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB3855;
x-ms-traffictypediagnostic: VI1PR0402MB3855:
x-microsoft-antispam-prvs: <VI1PR0402MB38554B8C5729B9E707399EF394AD0@VI1PR0402MB3855.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(6486002)(2906002)(14444005)(53936002)(54906003)(99286004)(43066004)(478600001)(25786009)(256004)(71200400001)(71190400001)(316002)(6512007)(81156014)(8676002)(4326008)(305945005)(81166006)(6246003)(5660300002)(14454004)(26005)(6506007)(31696002)(76176011)(36756003)(66446008)(64756008)(3450700001)(7736002)(6116002)(186003)(53546011)(229853002)(386003)(66556008)(66476007)(476003)(8936002)(31686004)(86362001)(102836004)(66946007)(66066001)(2616005)(3846002)(486006)(11346002)(6916009)(52116002)(6436002)(446003)(69594002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3855;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kLBVDn8qYsDL78N/dpIAKvAWT0UGUmhBDWMZblmExrOeUYnU6OHNGTcr82nPeMKcUhYG0c7CGfXnzzpZg3qV2Awr2TyvoyWRnD6fbhyNYLusv6vL3YmZ+R+23CJ2n1xIs7kic9z5NWswLBzU0qkZK3nrvTa+5OjJAh6xCO0PvWZH3MLqURZqQNnSSiA+D9QRqlT5F4GyUIlSI0ZJJvWvGnT2wROB1i4wyBK/ZbrPulvVkLHFdDUQbDg41pUEPg28jeH4z3w8b/SOe/2EqjnSQFIwy7FAnxX9tQhwncShOHRJgO0wgICT+YE+yRcHOZjT2LC6VzVcF754clfepXCYVW7D9e3qwi1AvSMK7/Si3fNJah5U9QOBoROPRxbCqiqmZns30hfxCvKfERJMevkGNnuXMKr3cyC2fga9tiFfygo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A37A6AF148643C4783E8185E09AA6244@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c29725-9616-4bf9-e1b6-08d720d8014b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 16:54:00.5178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJBOUHUPhyV4hsKTjpYE/qofvnRkMPIJUz5kjreJFCs/4erzgeiaAcM1v+KizLNWRxjgYk06kB9KeTgv/n6pNZ1ZXX+TzTQeidNuz64BajY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xNC8xOSAxMjowOSBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAx
NCwgMjAxOSBhdCA3OjM0IEFNIFN0ZXBoZW4gRG91dGhpdA0KPiA8c3RlcGhlbmRAc2lsaWNvbS11
c2EuY29tPiB3cm90ZToNCj4+DQo+PiBPbiA4LzEzLzE5IDY6MDcgUE0sIERhbiBXaWxsaWFtcyB3
cm90ZToNCj4+PiBPbiBUdWUsIEF1ZyAxMywgMjAxOSBhdCAxMjozMSBBTSBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4+Pg0KPj4+PiBPbiBNb24sIEF1ZyAx
MiwgMjAxOSBhdCAxMjozMTozNVBNIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+Pj4+PiBJ
dCBzZWVtcyBwbGF0Zm9ybXMgLyBjb250cm9sbGVycyB0aGF0IGZhaWwgdG8gcnVuIHRoZSBvcHRp
b24tcm9tDQo+Pj4+PiBzaG91bGQgYmUgcXVpcmtlZCBieSBkZXZpY2UtaWQsIGJ1dCB0aGUgUENT
IHJlZ2lzdGVyIHR3aWRkbGluZyBiZQ0KPj4+Pj4gcmVtb3ZlZCBmb3IgZXZlcnlvbmUgZWxzZS4g
IkNhcmQgQklPUyIgdG8gbWUgaW1wbGllcyBkZXZpY2VzIHdpdGggYW4NCj4+Pj4+IE9wdGlvbi1S
T00gQkFSIHdoaWNoIEkgZG9uJ3QgdGhpbmsgbW9kZXJuIGRldmljZXMgaGF2ZSwgc28gdGhhdCBt
aWdodA0KPj4+Pj4gYmUgYSBzaW1wbGUgd2F5IHRvIHRyeSB0byBwaGFzZSBvdXQgdGhpcyBxdWly
ayBnb2luZyBmb3J3YXJkIHdpdGhvdXQNCj4+Pj4+IHJlZ3Jlc3Npbmcgd29ya2luZyBzZXR1cHMg
dGhhdCBtaWdodCBiZSByZWx5aW5nIG9uIHRoaXMuDQo+Pj4+Pg0KPj4+Pj4gVGhlbiBhZ2FpbiB0
aGUgZHJpdmVyIGlzIGFscmVhZHkgZGVwZW5kaW5nIG9uIHRoZSBudW1iZXIgb2YgZW5hYmxlZA0K
Pj4+Pj4gcG9ydHMgdG8gYmUgcmVsaWFibGUgYmVmb3JlIFBDUyBpcyB3cml0dGVuLCBhbmQgdGhl
IGN1cnJlbnQgZHJpdmVyDQo+Pj4+PiBkb2VzIG5vdCBhdHRlbXB0IHRvIGVuYWJsZSBwb3J0cyB0
aGF0IHdlcmUgbm90IGVuYWJsZWQgcHJldmlvdXNseS4NCj4+Pj4+IFRoYXQgdGVsbHMgbWUgdGhh
dCBpZiB0aGUgUENTIHF1aXJrIGV2ZXIgbWF0dGVyZWQgaXQgd291bGQgaGF2ZQ0KPj4+Pj4gYWxy
ZWFkeSByZWdyZXNzZWQgd2hlbiB0aGUgZHJpdmVyIHN3aXRjaGVkIGZyb20gYmxpbmRseSB3cml0
aW5nIDB4ZiB0bw0KPj4+Pj4gb25seSBzZXR0aW5nIHRoZSBiaXRzIHRoYXQgd2VyZSBhbHJlYWR5
IHNldCBpbiAtPnBvcnRfbWFwLg0KPj4+Pg0KPj4+PiBCdXQgaG93IGRvIHdlIGZpbmQgdGhhdCBv
dXQ/DQo+Pj4NCj4+PiBXZSBjYW4gbGF5ZXIgYW5vdGhlciBhc3N1bXB0aW9uIG9uIHRvcCBvZiBU
ZWp1bidzIGFzc3VtcHRpb25zIGZyb20NCj4+PiBjb21taXQgNDlmMjkwOTAzOTM1ICJhaGNpOiB1
cGRhdGUgUENTIHByb2dyYW1taW5nIi4gVGhlIGtlcm5lbA0KPj4+IGNvbW11bml0eSBoYXMgbm90
IHJlY2VpdmVkIGFueSByZWdyZXNzaW9uIHJlcG9ydHMgZnJvbSB0aGF0IGNoYW5nZQ0KPj4+IHdo
aWNoIHNheXM6DQo+Pj4NCj4+PiAiDQo+Pj4gICAgICAgcG9ydF9tYXAgaXMgZGV0ZXJtaW5lZCBm
cm9tIFBPUlRTX0lNUEwgUENJIHJlZ2lzdGVyIHdoaWNoIGlzDQo+Pj4gICAgICAgaW1wbGVtZW50
ZWQgYXMgd3JpdGUgb3Igd3JpdGUtb25jZSByZWdpc3Rlci4gIElmIHRoZSByZWdpc3RlciBpc24n
dA0KPj4+ICAgICAgIHByb2dyYW1tZWQsIGFoY2kgYXV0b21hdGljYWxseSBnZW5lcmF0ZXMgaXQg
ZnJvbSBudW1iZXIgb2YgcG9ydHMsDQo+Pj4gICAgICAgd2hpY2ggaXMgZ29vZCBlbm91Z2ggZm9y
IFBDUyBwcm9ncmFtbWluZy4gIElDSDYvN00gYXJlIHByb2JhYmx5IHRoZQ0KPj4+ICAgICAgIG9u
bHkgb25lcyB3aGVyZSBub24tY29udGlndW91cyBlbmFibGUgYml0cyBhcmUgbmVjZXNzYXJ5ICYm
IFBPUlRTX0lNUEwNCj4+PiAgICAgICBpc24ndCBwcm9ncmFtbWVkIHByb3Blcmx5IGJ1dCB0aGV5
J3JlIHByb3ZlbiB0byB3b3JrIHJlbGlhYmx5IHdpdGggMHhmDQo+Pj4gICAgICAgYW55d2F5Lg0K
Pj4+ICINCj4+Pg0KPj4+IFNvIHRoZSBwb3RlbnRpYWwgb3B0aW9ucyBJIHNlZSBhcmU6DQo+Pj4N
Cj4+PiAxLyBLZWVwIHRoZSBjdXJyZW50IHNjaGVtZSwgYnV0IGxpbWl0IGl0IHRvIGNhc2VzIHdo
ZXJlIFBPUlRTX0lNUEwgaXMNCj4+PiBsZXNzIHRoYW4gOCBhbmQgYXNzdW1lIHRoaXMgbmVlZCB0
byBzZXQgdGhlIGJpdHMgaXMgdW5uZWNlc3NhcnkgbGVnYWN5DQo+Pj4gdG8gY2FycnkgZm9yd2Fy
ZA0KPj4+DQo+Pj4gMi8gT3B0aW9uMSArIGFkZGl0aW9uYWxseSB1c2UgUE9SVFNfSU1QTCBhcyBh
IGdhdGUgdG8gZ3Vlc3Mgd2hlbiB0aGUNCj4+PiBQQ1MgZm9ybWF0IG1pZ2h0IGJlIGRpZmZlcmVu
dCBmb3IgdmFsdWVzID49IDguDQo+Pj4NCj4+PiBJIHRoaW5rIHRoZSBkcml2ZXIgZG9lcyBub3Qg
bmVlZCB0byBjb25zaWRlciBPcHRpb24yIHVubGVzcyAvIHVudGlsIGl0DQo+Pj4gZW5jb3VudGVy
cyBhIHBsYXRmb3JtIHdoZXJlIGZpcm13YXJlIGRvZXMgbm90ICJkbyB0aGUgcmlnaHQgdGhpbmci
LA0KPj4+IGFuZCBnaXZlbiBEZW52ZXJ0b24gaGFzIGJlZW4gaW4gdGhlIHdpbGQgd2l0aCB0aGUg
d3JvbmcgUENTIHR3aWRkbGluZw0KPj4+IGl0IHNlZW1zIHRvIHN1Z2dlc3Qgbm90aGluZyBuZWVk
cyB0byBiZSBkb25lIHRoZXJlLg0KPj4+DQo+Pj4+IEEgY29tcHJvbWlzZSB0byBtZSBzZWVtcyB0
aGF0IHdlIGp1c3QgZG8gdGhlIFBDUyBxdWlyayBmb3IgYWxsIEludGVsDQo+Pj4+IGRldmljZXMg
ZXhwbGljaXRseSBsaXN0ZWQgaW4gdGhlIFBDSSBJZHMgYmFzZWQgb24gbmV3IGJvYXJkXyogdmFs
dWVzDQo+Pj4+IGFzIGxvbmcgYXMgdGhleSBoYXZlIHRoZSBvbGQgUENTIGxvY2F0aW9uLCBhbmQg
YXNzdW1lIGFueXRoaW5nIG5ldw0KPj4+PiBlbm91Z2ggdG8gaGF2ZSB0aGUgbmV3IGxvY2F0aW9u
IHdvbid0IG5lZWQgdG8gcXVpcmssIGdpdmVuIHRoYXQgaXQNCj4+Pj4gbmV2ZXIgcHJvcGVybHkg
d29ya2VkLiAgVGhpcyBtaWdodCBtaXNzIHNvbWUgaW50ZWwgZGV2aWNlcyB0aGF0IHdlcmUNCj4+
Pj4gc3VwcG9ydGVkIHdpdGggdGhlIGNsYXNzIGJhc2VkIGNhdGNoYWxsLCB0aG91Z2guDQo+Pj4N
Cj4+PiBJJ2QgYmUgbW9yZSBjb21mb3J0YWJsZSB3aXRoIFBPUlRfSU1QTCBhcyB0aGUgZGVjaWRp
bmcgZmFjdG9yLg0KPj4NCj4+IFVuZm9ydHVuYXRlbHkgd2UgY2FuJ3QgdXNlIENBUC5OUCBvciBQ
T1JUU19JTVBMIGZvciB0aGlzIGhldXJpc3RpYy4NCj4+DQo+PiBUaGUgcHJvYmxlbSBpcyB0aGF0
IEJJT1Mgc2hvdWxkIGJlIHNldHRpbmcgdGhlIFBPUlRTX0lNUEwgYml0bWFzayB0bw0KPj4gbWF0
Y2ggd2hpY2ggbGFuZXMgaGF2ZSBhY3R1YWxseSBiZWVuIGNvbm5lY3RlZCBvbiB0aGUgYm9hcmQu
ICBTbw0KPj4gUE9SVFNfSU1QTCBjYW4gYmUgPCA4IGV2ZW4gaWYgdGhlIGNvbnRyb2xsZXIgaXMg
bmV3IGVub3VnaCB0bw0KPj4gcG90ZW50aWFsbHkgc3VwcG9ydCA+IDggYW5kIGhhcyB0aGUgbmV3
IGNvbmZpZyBzcGFjZSBsYXlvdXQuDQo+Pg0KPj4gQXMgcHJvb2YgaGVyZSdzIHRoZSByZWxldmFu
dCBhaGNpX3ByaW50X2luZm8oKSBvdXRwdXQgYm9vdGluZyBvbiBhDQo+PiBEZW52ZXJ0b24gYmFz
ZWQgYm94IHdpdGggNSBwb3J0cyBpbXBsZW1lbnRlZDoNCj4+DQo+PiBhaGNpIDAwMDA6MDA6MTQu
MDogQUhDSSAwMDAxLjAzMDEgMzIgc2xvdHMgNSBwb3J0cyA2IEdicHMgMHg3YSBpbXBsIFNBVEEg
bW9kZQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgIFwtUE9SVFNfSU1QTA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXC1DQVAuTlANCj4gDQo+IFVnaCwgb2ssIHRoYW5rcyBmb3IgY2xh
cmlmeWluZyBhbmQgbXkgbWlzdGFrZSBmb3Igbm90IHJlYWxpemluZw0KPiBEZW52ZXJ0b24gYWxy
ZWFkeSB2aW9sYXRlcyB0aGF0IGhldXJpc3RpYy4NCj4gDQo+IFNvIG5vdyBJJ20gdHJ5aW5nIHRv
IGdyb2sgQ2hyaXN0b3BoJ3Mgc3VnZ2VzdGlvbi4gQXJlIHlvdSBzYXlpbmcgdGhhdA0KPiBhbGwg
ZXhpc3RpbmcgYm9hcmQtaWRzIHdvdWxkIGFzc3VtZSBvbGQgUENTIGZvcm1hdD8gVGhhdCB3b3Vs
ZCBtZWFuDQo+IHRoYXQgRGVudmVydG9uIGdldHMgdGhlIHdyb25nIGZvcm1hdCB2aWEgYm9hcmRf
YWhjaSB2aWEgdGhlIGNsYXNzIGNvZGUNCj4gbWF0Y2hpbmc/IE1heWJlIEknbSBub3QgdW5kZXJz
dGFuZGluZyB0aGUgc3VnZ2VzdGlvbi4uLg0KDQpNeSB1bmRlcnN0YW5kaW5nIG9mIENocmlzdG9w
aCdzIHN1Z2dlc3Rpb24gd2FzIHRoYXQgd2UgY3JlYXRlIGEgbmV3DQpib2FyZF9haGNpXyogZW50
cnkgKGUuZy4gYm9hcmRfYWhjaV9pbnRlbF9sZWdhY3kpIHRvIG1hdGNoIGluDQphaGNpX3BjaV90
YmwgYWdhaW5zdCB0aG9zZSBkZXZpY2VzIHVzaW5nIHRoZSBvcmlnaW5hbCBjb25maWcgc3BhY2UN
CmxheW91dCB3aGVyZSBQQ1MgaXMgQCAweDkyLg0KDQpPbmNlIHdlIGhhdmUgdGhhdCB3ZSBjYW4g
Y29uZGl0aW9uYWxseSBydW4gdGhlIFBDUyBwb2tlIGNvZGUgaW4NCmFoY2lfcGNpX3Jlc2V0X2Nv
bnRyb2xsZXIoKSBvbmx5IGZvciBkZXZpY2VzIHdpdGggdGhhdCBuZXcgYm9hcmRfaWQuICBXZQ0K
YXNzdW1lIHRoYXQgYWxsIG5ld2VyIGRldmljZXMgYWRkZWQgdG8gdGhlIHRhYmxlIHdpbGwgbm90
IHVzZSB0aGUgbGVnYWN5DQpib2FyZF9pZCBhbmQgbm90IG5lZWQgdG8gZG8gUENTIHBva2VzLg0K
DQpSaWdodCBub3cgdGhlcmUgYXJlIGVudHJpZXMgZm9yIGRldmljZXMgd2l0aCBib3RoIHRoZSBu
ZXcgYW5kIG9sZCBjb25maWcNCnNwYWNlIGxheW91dCBpbiBhaGNpX3BjaV90YmwuICBUaGF0IG1l
YW5zIHNvbWVvbmUgYXQgSW50ZWwgd291bGQgbmVlZA0KdG8gZ28gdGhyb3VnaCBlYWNoIGVudHJ5
IGFuZCBtYXJrIGl0IGFzIG5ldyBvciBvbGQuDQoNCllvdXIgcG9pbnQgYWJvdXQgZGV2aWNlcyBt
YXRjaGluZyBzb2xlbHkgb24gdGhlIGNsYXNzIGNvZGUgc3RpbGwNCmFwcGxpZXMuDQoNCj4gQW5v
dGhlciBvcHRpb24gbWlnaHQgYmUgdGhhdCBjb250cm9sbGVycyA+PSAxLjMuMSB3aWxsIHN0b3Ag
dXNpbmcgdGhlDQo+IFBDUyB0d2lkZGxpbmcsIGFuZCB0aGVuIHdlIGdvIGFkZCBhIG5ldyBib2Fy
ZCBpZCB3aGVyZSAvIGlmIGl0IGhhcHBlbnMNCj4gdG8gbWF0dGVyIGluIHByYWN0aWNlLg0KDQpD
YW4geW91IGdldCBzb21lb25lIGZyb20gdGhlIGNvbnRyb2xsZXIgZGVzaWduIHRlYW0gdG8gZ2l2
ZSB1cyBhIGNsZWFyDQphbnN3ZXIgb24gYSByZXZpc2lvbiB3aGVyZSB0aGlzIFBDUyBjaGFuZ2Ug
aGFwcGVuZWQ/DQoNCkl0IHdvdWxkIGJlIG5pY2UgaWYgd2UgY291bGQganVzdCBjaGVjayBQQ0lf
UkVWSVNJT05fSUQgb3Igc29tZXRoaW5nDQpzaW1pbGFyLg0K
