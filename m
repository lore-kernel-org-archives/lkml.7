Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A9C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF2B216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hp25j02b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbfHHVgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:36:10 -0400
Received: from mail-eopbgr800071.outbound.protection.outlook.com ([40.107.80.71]:38930
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbfHHVgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDZ7xeXpHbzk4m1OkbaP5yy7/V68iomA7LRQqFiMvluLsDvm9k5kCZGM65KLr4wJbyJYYlVWbmZim6RLyf/BHDLA+L49oXHseoYCqObk/hVzztToSZ+MemjHUga/k/n6osy2YD46PhxnEycIfC0/edibcZOlUHw3zk/h01fsCVWwoIU46SMQgHDyI9W1i/R/Rub9D4wG31ccmCN9VAX0iCCCK05NHekCLYoW39KKNouzlzYCZMJZ1f0ADN0l+ZW2MeC+jC97gMfn7swL3qObxHkfQeJob/sUF2zcaXnZjC35+JWz5Oo8s6fBX0fp5/lpjSpeCjtBBDSJ7jggSHYufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hth4/bXrbJtN96CWl7AakSMiSQUugVLM/K6G6n+LMfI=;
 b=ezdGeSh00MLMpLW6LOi2v8OpS3Rfx4/Js6G1Rx2JGD7NEoKA2xLvWolI0xpYvTP2V+ae5aL+4tNf3YtkRP3/KgythhwXjRMz43wsWOrjTLClK7LvlIV5rZ+EooKIFjnG/fOPMhp/8gqV8df9JYuxhd5rgATsciYPGjWTAQpJGTKXVXWpsz+6H6OCSDjQdVJYHbo5kfBllka6+GUFo0B+ta7mmeRm+g+RxA34p1ZWsXcJ9woSQPFwDF4qAhTvWFIHZrLJrOttmSzJuhChKhPkS/ZQ5nItB6rWMy/K+DzpzZpK9Rc9+IV+Q9iRbJHuMEX41GpaCVx7Gq8gLXNukPXfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hth4/bXrbJtN96CWl7AakSMiSQUugVLM/K6G6n+LMfI=;
 b=Hp25j02bVXWspEDTZHZTM4zpnNh26d2v/F5t0Bq8/0fRBxINudhRMkDjHj2esZsJEWK5AY78yHKebUV+JzK8cph2jgAAQCToEhXeiKAtMkEmkSoL+6DQdIq40gSfcDVpH6bVtFWzlidcCRI+FkrRKF5VR7MZX38mMhMtTC/Lo6A=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB4025.namprd12.prod.outlook.com (10.255.175.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 8 Aug 2019 21:36:05 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 21:36:05 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
Thread-Topic: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
Thread-Index: AQHVSDHageyJLuj1e02we0A4NQI8qKbl4bwAgAAFR4CAAAXXgIAABMSAgAACPYCAAB85AIAAXHyAgAtSC4CAAAbxAIAAAgoAgAAHhAA=
Date:   Thu, 8 Aug 2019 21:36:05 +0000
Message-ID: <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
 <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
 <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com>
 <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com>
 <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0023.prod.exchangelabs.com (2603:10b6:805:1::36)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd10c2a9-33d7-4a2d-c131-08d71c486ad4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB4025;
x-ms-traffictypediagnostic: DM6PR12MB4025:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB4025DB5AB087E86DE8D7D719ECD70@DM6PR12MB4025.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(6116002)(4326008)(3846002)(86362001)(31696002)(66066001)(478600001)(8936002)(966005)(71200400001)(256004)(99286004)(71190400001)(14444005)(6512007)(6306002)(14454004)(316002)(8676002)(25786009)(6436002)(26005)(7736002)(6506007)(53546011)(102836004)(76176011)(52116002)(6486002)(6246003)(2906002)(305945005)(53936002)(229853002)(54906003)(31686004)(64756008)(66476007)(5660300002)(66556008)(66946007)(36756003)(386003)(446003)(6916009)(2616005)(81166006)(81156014)(476003)(66446008)(486006)(11346002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4025;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fkJa0LZvE3RuksN4GAgX06Yn970xSvMdpQWj8JI00tYrJsxrqoXEYhxTULDECVnw0RBlzjCpLv4BhsWmJJG5Ohj3vmRe9yOg8kyzzb41Oqxj8PUouY48dQk1w9L+NZXWqgyS9wc94h3t1CgPPAHOtDvUcwEkIFdja4y0qR/TNJ7+kgoR3SQTpmDjbuPBzZUn3pP4HyHkUpBSh8yL3qNKX4aViENbDeBWg2hPRXBjE7Pkjdl6b7vYeeuTlJZnk90nOXbtnoMTXj+W//hfSXQn47Ng5Y1WKdb2/S6GNf/54BVm4LEQjT43B89zzN7r5tjQ93TvFXEGZKQSyRzg0I/50ZlugjSQPVT5zE8p6GLqpNgG8EmolRMn6Svm9G9Zw1B/aeXFDzhywP6PRGKjfbUxMryL4vBwVpOeGRzqX1S9z20=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A05770B0DEE144D9BAECE023D08AD27@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd10c2a9-33d7-4a2d-c131-08d71c486ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 21:36:05.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4aXRo+WbHJHPt6axunx0pHJP0vNrZVhYmR4atrsX4cfKoTrG5iwdKW2trvnZ2I4clyejS1vgneWb2yS3xIxbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLA0KDQpPbiA4LzgvMTkgNDowOCBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0K
PiBUb20sDQo+IA0KPiBPbiBUaHUsIDggQXVnIDIwMTksIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6
DQo+PiBPbiA4LzgvMTkgMzozNiBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+IE9uIFRo
dSwgMSBBdWcgMjAxOSwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+Pj4gT24gOC8xLzE5IDU6
MTMgQU0sIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+Pj4+ICAgICAyLjEuOSBUaW1lcnMNCj4+
Pj4+DQo+Pj4+PiAgICAgIEVhY2ggY29yZSBpbmNsdWRlcyB0aGUgZm9sbG93aW5nIHRpbWVycy4g
VGhlc2UgdGltZXJzIGRvIG5vdCB2YXJ5IGluDQo+Pj4+PiAgICAgIGZyZXF1ZW5jeSByZWdhcmRs
ZXNzIG9mIHRoZSBjdXJyZW50IFAtc3RhdGUgb3IgQy1zdGF0ZS4NCj4+Pj4+DQo+Pj4+PiAgICAg
ICogQ29yZTo6WDg2OjpNc3I6OlRTQzsgdGhlIFRTQyBpbmNyZW1lbnRzIGF0IHRoZSByYXRlIHNw
ZWNpZmllZCBieSB0aGUNCj4+Pj4+ICAgICAgICBQMCBQc3RhdGUuIFNlZSBDb3JlOjpYODY6Ok1z
cjo6UFN0YXRlRGVmLg0KPj4+Pj4NCj4+Pj4+ICAgICAgKiBUaGUgQVBJQyB0aW1lciAoQ29yZTo6
WDg2OjpBcGljOjpUaW1lckluaXRpYWxDb3VudCBhbmQNCj4+Pj4+ICAgICAgICBDb3JlOjpYODY6
OkFwaWM6OlRpbWVyQ3VycmVudENvdW50KSwgd2hpY2ggaW5jcmVtZW50cyBhdCB0aGUgcmF0ZSBv
Zg0KPj4+Pj4gICAgICAgIDJ4Q0xLSU47IHRoZSBBUElDIHRpbWVyIG1heSBpbmNyZW1lbnQgaW4g
dW5pdHMgb2YgYmV0d2VlbiAxIGFuZCA4Lg0KPj4+Pj4NCj4+Pj4+IFRoZSBSeXplbnMgdXNlIGEg
MTAwTUh6IGlucHV0IGNsb2NrIGZvciB0aGUgQVBJQyBub3JtYWxseSwgYnV0IEknbSBub3Qgc3Vy
ZQ0KPj4+Pj4gd2hldGhlciB0aGlzIGlzIHN1YmplY3QgdG8gb3ZlcmNsb2NraW5nLiBJZiBzbyB0
aGVuIGl0IHNob3VsZCBiZSBwb3NzaWJsZQ0KPj4+Pj4gdG8gZmlndXJlIHRoYXQgb3V0IHNvbWVo
b3cuIFRvbT8NCj4+Pj4NCj4+Pj4gTGV0IG1lIGNoZWNrIHdpdGggdGhlIGhhcmR3YXJlIGZvbGtz
IGFuZCBJJ2xsIGdldCBiYWNrIHRvIHlvdS4NCj4+Pg0KPj4+IGFueSB1cGRhdGUgb24gdGhpcz8g
VGhlIHByb2JsZW0gc2VlbXMgdG8gY29tZSBpbiBmcm9tIHNldmVyYWwgc2lkZXMgbm93Lg0KPj4N
Cj4+IFllcywgc29ydCBvZi4gVGhlcmUgYXJlIHR3byB3YXlzIHRvIG92ZXJjbG9jayBhbmQgaXQg
YWxsIGRlcGVuZHMgb24gd2hpY2gNCj4+IG9uZSB3YXMgdXNlZC4gSWYgdGhlIG92ZXJjbG9ja2lu
ZyBpcyBkb25lIGJ5IGNoYW5naW5nIHRoZSBtdWx0aXBsaWVycywNCj4+IHRoZW4gdGhhdCAxMDBN
SHogY2xvY2sgd2lsbCBzdGlsbCBiZSAxMDBNSHouIEJ1dCBpZiB0aGUgb3ZlcmNsb2NraW5nIGlz
DQo+PiBkb25lIGJ5IGluY3JlYXNpbmcgdGhlIGlucHV0IGNsb2NrLCB0aGVuIHRoYXQgMTAwTUh6
IGNsb2NrIHdpbGwgYWxzbw0KPj4gaW5jcmVhc2UuDQo+Pg0KPj4gSSB3YXMgdHJ5aW5nIHRvIGdl
dCBhIGJpdCBtb3JlIGNsYXJpZmljYXRpb24gb24gdGhpcyBiZWZvcmUgcmVwbHlpbmcsIGJ1dA0K
Pj4gaXQgY2FuIGJlIGRldGVjdGVkIGluIHNvZnR3YXJlLiBUaGUgYmFzZSBjbG9jayBpcyAxMDBN
SHosIHNvIHJlYWQgdGhlIFAwDQo+PiBtdWx0aXBsaWVyIGFuZCB0aGUgVFNDIHNob3VsZCBiZSBj
b3VudGluZyBhdCBQMCAqIDEwME1Iei4gSWYgeW91IGNhbGlicmF0ZQ0KPj4gdGhlIHNwZWVkIG9m
IHRoZSBUU0Mgd2l0aCB0aGUgSFBFVCB5b3UgY2FuIHNlZSB3aGF0IHNwZWVkIHRoZSBUU0MgaXMN
Cj4+IGNvdW50aW5nIGF0LiBJZiB5b3UgZGl2aWRlIHRoZSBUU0MgZGVsdGEgZnJvbSB0aGUgSFBF
VCBjYWxpYnJhdGlvbiBieSB0aGUNCj4+IFAwIG11bHRpcGxpZXIgeW91IHdpbGwgZWl0aGVyIGdl
dCAxMDBNSHogaWYgdGhlcmUgaXMgbm8gb3ZlcmNsb2NraW5nIG9yIGlmDQo+PiB0aGUgbXVsdGlw
bGllciBtZXRob2Qgb2Ygb3ZlcmNsb2NraW5nIHdhcyB1c2VkLCBvdGhlcndpc2UgeW91J2xsIGdl
dCBhDQo+PiBoaWdoZXIgdmFsdWUgaWYgdGhlIGlucHV0IGNsb2NrIG1ldGhvZCB3YXMgdXNlZC4g
RWl0aGVyIHdheSwgdGhhdCBzaG91bGQNCj4+IGdpdmUgeW91IHRoZSBBUElDIGNsb2NrIHNwZWVk
IGJhc2VkIG9uIGEgc3RhcnRpbmcgYXNzdW1wdGlvbiBvZiAxMDBNSHouDQo+IA0KPiBUaGUgcHJv
YmxlbSBpcyB0aGF0IHdlIGhhdmUgbm8gSFBFVCBvbiB0aG9zZSBtYWNoaW5lcyAuLi4uDQoNClNv
cnJ5IGFib3V0IHRoYXQuLi4gIEkgaW50ZXJwcmV0ZWQgdGhlIGVtYWlsWzFdIHRoYXQgc2FpZCB0
aGUgSFBFVCBBQ1BJDQp0YWJsZSB3YXMgcHJlc2VudCwgaW5jb3JyZWN0bHkuIEkgZ2V0IGl0IG5v
dywgZm9yIGhhcmR3YXJlLXJlZHVjZWQgQUNQSQ0KeW91IGNhbid0IGRlcGVuZCBvbiB0aGF0IHRh
YmxlIHRvIGJlIHByZXNlbnQuDQoNClRoYW5rcywNClRvbQ0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC9DQUQ4THA0NTJHZG9MLUJ0N3JTUD11M1JLRVoySDNxbTNMdktmZT1jQ3Nq
UDBiaUdfc1FAbWFpbC5nbWFpbC5jb20vDQogDQo+IA0KPiBJIHRoaW5rIEkgY2FuIGdldCBhd2F5
IHdpdGhvdXQgaGF2aW5nIEhQRVQgYW5kIFBJVCBhbmQgZG8gc29tZSBzbWFydCBzdHVmZg0KPiB3
aXRoIHRoZSBwbSB0aW1lciBmb3IgdGhhdCBzdHVmZi4gSSdsbCBsb29rIGF0IGl0IHRvbW9ycm93
IHdpdGggYnJhaW4NCj4gYWN0dWFsbHkgYXdha2UuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJdGds
eA0KPiANCj4gDQo+IA0KPiANCj4gDQo=
