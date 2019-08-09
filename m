Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5785DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F71214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nyCl1RTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406938AbfHIN66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:58:58 -0400
Received: from mail-eopbgr780050.outbound.protection.outlook.com ([40.107.78.50]:42496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfHIN66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:58:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsZOibyBIdfGTG3xdQly6lkv+BjM4Wcxc6R/Yx9H6nMPLRkPq86KQJ9iy612jEqSySfm0UeZ3zZOnK+a56uJPxWswpMDJWc2wzlwFJB1+G4IC6tthmcRFGYTk6I5uu8Z7DcNmjvDG/Jed2vVSTUP+LhiKzhUF40nuTj82z9+IPMarxlj98cRfYHPhf/Jdd+AhMrLnoM6eEmuuBDwUwd7jLVIVwT2hQXIZBd8gJBgDWQd4HRgf85SBnHX/oLQY7kz2cVxxwLO6ZcdFR1QYlWJMch/KCzYpTjEMAywewRgHrdZ8nfEflExt9TXSp9TpmfgfrbJn5R7XRbNb1Ed/LIYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9jP8nTRJMhDWY2ykdZdlDFEO310i9FU0Re9EUiyxEs=;
 b=CnhwBnJTpHGrpBz6BSl8oJ0yaVEEHQ3Jvs3+dC8GvF4PyAAmWC8McHzUcCGiI6e0WCYSmmzRZSRigpNMc2AwvYcK+K6c0R6RjojJKmkfui6HWifqfNGug1NFD6DgRA3qAyxj2dHAxg0Y6w6wmD2YRqsv2oP4shX7OhQ+UgT0h8qXNy4k7Hk8BtnwU9Ga9wFiKvedlubTZTgvviEFHH6gKWBYviZ72PldmY+zAmTmtcChPB0PRWNE6bVjoz1eEEXaTqw51k/PNk++8/XNNT4Kzv/fXkYd2Y+X0V8EE2u+wdlNl63/g3RQWVj2ZKUxUm9uo4eQHf4sXXNdhqO3L9Z2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9jP8nTRJMhDWY2ykdZdlDFEO310i9FU0Re9EUiyxEs=;
 b=nyCl1RTOS5qDshz9PVL9FoQCvVgofZuRVNyWMei40JbDkYlZBg7XLv99tmNSI6dYDNq7HeNrLsAKUKVpKsGtpZlE/Spar6fyL/0ZqsWWPgqau/OMC6dBsJFBUTgtl6y/ZiY4MfuC/d5eUwU27AyHSvGArLOdlt4rQ/GAnUlqU1Q=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3737.namprd12.prod.outlook.com (10.255.172.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 9 Aug 2019 13:58:55 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 13:58:55 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] x86/apic: Handle missing global clockevent gracefully
Thread-Topic: [PATCH] x86/apic: Handle missing global clockevent gracefully
Thread-Index: AQHVTrGPLB0HySR+r0Syd2Nd7GZcYqby17aA
Date:   Fri, 9 Aug 2019 13:58:55 +0000
Message-ID: <d212566c-3ee6-a7c1-98f5-2db5d3c63e44@amd.com>
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
 <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com>
 <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0031.namprd05.prod.outlook.com
 (2603:10b6:803:40::44) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a50144c8-b80a-41d7-7d28-08d71cd1b78c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3737;
x-ms-traffictypediagnostic: DM6PR12MB3737:
x-microsoft-antispam-prvs: <DM6PR12MB373767A5357D523C008946FEECD60@DM6PR12MB3737.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(14444005)(256004)(478600001)(66066001)(6436002)(316002)(31696002)(53546011)(8936002)(7736002)(6506007)(386003)(54906003)(102836004)(5660300002)(76176011)(52116002)(3846002)(4326008)(71200400001)(71190400001)(53936002)(6246003)(86362001)(25786009)(66446008)(66476007)(14454004)(66946007)(6512007)(6916009)(66556008)(64756008)(6116002)(2906002)(8676002)(81156014)(476003)(81166006)(2616005)(486006)(31686004)(186003)(99286004)(26005)(11346002)(446003)(305945005)(6486002)(229853002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3737;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MT0aMqYroe5e/tNt/7Al9VDfxeBflzKrVYKJJOiuw+BGAr0g8MQaUNgIvmY/YvjATbtCgP//JTAeOychiA0+TPlXyKNr0GWI2AOb3Myg4YruOuWrU05Uk6garap8nA02Ds3HuM2gpwvhKgm1wATmE8VaUHjpaamfoIVaLd1k/kMrO3HJIWH3dYGIqsK67qb4Rrgokq6eL61WKsEVIBbF2ZhurkY2VMLu6w7SK6zrA9F4SwV46xYVlOjix6D8FAKzXS9V0o4sN37XPiBZ41C8nkHIZVpwidGEag4pGgpY9+axAAZG2cqL2zCrVyl/fFPqUzjFEdCU/I3q6hZmnJqs4wuurXd/4vW2cKnyQDHpcpKZbV1X7ouG7oQC8CDlLjHDUnllYsvUkD/+BsdmVGSk6be7Ypnd4IYxIzt7oitbBq8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A75EE9E25D1EB8498689EC41D4572FAB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50144c8-b80a-41d7-7d28-08d71cd1b78c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 13:58:55.2143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKOsf8h7WUbdhfyvC9fjgmRHOpL9O/10DEf3uHDUQEwtpOPE8/Jk7QU0G3EhspOzAAHiW3vkb3MxNQj+xN1Znw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC85LzE5IDc6NTQgQU0sIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gU29tZSBuZXdlciBt
YWNoaW5lcyBkbyBub3QgYWR2ZXJ0aXNlIGxlZ2FjeSB0aW1lcnMuIFRoZSBrZXJuZWwgY2FuIGhh
bmRsZQ0KPiB0aGF0IHNpdHVhdGlvbiBpZiB0aGUgVFNDIGFuZCB0aGUgQ1BVIGZyZXF1ZW5jeSBh
cmUgZW51bWVyYXRlZCBieSBDUFVJRCBvcg0KPiBNU1JzIGFuZCB0aGUgQ1BVIHN1cHBvcnRzIFRT
QyBkZWFkbGluZSB0aW1lci4gSWYgdGhlIENQVSBkb2VzIG5vdCBzdXBwb3J0DQo+IFRTQyBkZWFk
bGluZSB0aW1lciB0aGUgbG9jYWwgQVBJQyB0aW1lciBmcmVxdWVuY3kgaGFzIHRvIGJlIGtub3du
IGFzIHdlbGwuDQo+IA0KPiBTb21lIFJ5emVucyBtYWNoaW5lcyBkbyBub3QgYWR2ZXJ0aXplIGxl
Z2FjeSB0aW1lcnMsIGJ1dCB0aGVyZSBpcyBubw0KPiByZWxpYWJsZSB3YXkgdG8gZGV0ZXJtaW5l
IHRoZSBidXMgZnJlcXVlbmN5IHdoaWNoIGZlZWRzIHRoZSBsb2NhbCBBUElDDQo+IHRpbWVyIHdo
ZW4gdGhlIG1hY2hpbmUgYWxsb3dzIG92ZXJjbG9ja2luZyBvZiB0aGF0IGZyZXF1ZW5jeS4NCj4g
DQo+IEFzIHRoZXJlIGlzIG5vIGxlZ2FjeSB0aW1lciB0aGUgbG9jYWwgQVBJQyB0aW1lciBjYWxp
YnJhdGlvbiBjcmFzaGVzIGR1ZSB0bw0KPiBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSB3aGVu
IGFjY2Vzc2luZyB0aGUgbm90IGluc3RhbGxlZCBnbG9iYWwgY2xvY2sNCj4gZXZlbnQgZGV2aWNl
Lg0KPiANCj4gU3dpdGNoIHRoZSBjYWxpYnJhdGlvbiBsb29wIHRvIGEgbm9uIGludGVycnVwdCBi
YXNlZCBvbmUsIHdoaWNoIHBvbGxzDQo+IGVpdGhlciBUU0MgKGZyZXF1ZW5jeSBrbm93bikgb3Ig
amlmZmllcy4gVGhlIGxhdHRlciByZXF1aXJlcyBhIGdsb2JhbA0KPiBjbG9ja2V2ZW50LiBBcyB0
aGUgbWFjaGluZXMgd2hpY2ggZG8gbm90IGhhdmUgYSBnbG9iYWwgY2xvY2tldmVudCBpbnN0YWxs
ZWQNCj4gaGF2ZSBhIGtub3duIFRTQyBmcmVxdWVuY3kgdGhpcyBpcyBhIG5vbiBpc3N1ZS4gRm9y
IG9sZGVyIG1hY2hpbmVzIHdoZXJlDQo+IFRTQyBmcmVxdWVuY3kgaXMgbm90IGtub3duLCB0aGVy
ZSBpcyBubyBrbm93biBjYXNlIHdoZXJlIHRoZSBsZWdhY3kgdGltZXJzDQo+IGRvIG5vdCBleGlz
dCBhcyB0aGF0IHdvdWxkIGhhdmUgYmVlbiByZXBvcnRlZCBsb25nIGFnby4NCj4gDQo+IFJlcG9y
dGVkLWJ5OiBEYW5pZWwgRHJha2UgPGRyYWtlQGVuZGxlc3NtLmNvbT4NCj4gUmVwb3J0ZWQtYnk6
IEppcmkgU2xhYnkgPGpzbGFieUBzdXNlLmN6Pg0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gLS0tDQo+IA0KPiBOb3RlOiBPbmx5IGxpZ2h0
bHkgdGVzdGVkLCBidXQgb2YgY291cnNlIG5vdCBvbiBhbiBhZmZlY3RlZCBtYWNoaW5lLg0KPiAN
Cj4gICAgICAgIElmIHRoYXQgd29ya3MgcmVsaWFibHksIHRoZW4gdGhpcyBuZWVkcyBzb21lIGV4
aGF1c3RpdmUgdGVzdGluZw0KPiAgICAgICAgb24gYSB3aWRlIHJhbmdlIG9mIHN5c3RlbXMgc28g
d2UgY2FuIHJpc2sgYmFja3BvcnRzIHRvIHN0YWJsZQ0KPiAgICAgICAga2VybmVscy4NCj4gDQo+
IC0tLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9hcGljL2FwaWMuYyB8ICAgNzAgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gICBpbmNsdWRlL2xpbnV4L2FjcGlf
cG10bXIuaCAgfCAgIDEwICsrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9u
cygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9h
cGljLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpYy5jDQo+IEBAIC04NTEsNyAr
ODUxLDggQEAgYm9vbCBfX2luaXQgYXBpY19uZWVkc19waXQodm9pZCkNCj4gICBzdGF0aWMgaW50
IF9faW5pdCBjYWxpYnJhdGVfQVBJQ19jbG9jayh2b2lkKQ0KPiAgIHsNCj4gICAJc3RydWN0IGNs
b2NrX2V2ZW50X2RldmljZSAqbGV2dCA9IHRoaXNfY3B1X3B0cigmbGFwaWNfZXZlbnRzKTsNCj4g
LQl2b2lkICgqcmVhbF9oYW5kbGVyKShzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlICpkZXYpOw0K
PiArCXU2NCB0c2NfcGVyaiA9IDAsIHRzY19zdGFydCA9IDA7DQo+ICsJdW5zaWduZWQgbG9uZyBq
aWZfc3RhcnQ7DQo+ICAgCXVuc2lnbmVkIGxvbmcgZGVsdGFqOw0KPiAgIAlsb25nIGRlbHRhLCBk
ZWx0YXRzYzsNCj4gICAJaW50IHBtX3JlZmVyZW5jZWQgPSAwOw0KPiBAQCAtODc4LDI5ICs4Nzks
NjUgQEAgc3RhdGljIGludCBfX2luaXQgY2FsaWJyYXRlX0FQSUNfY2xvY2sodg0KPiAgIAlhcGlj
X3ByaW50ayhBUElDX1ZFUkJPU0UsICJVc2luZyBsb2NhbCBBUElDIHRpbWVyIGludGVycnVwdHMu
XG4iDQo+ICAgCQkgICAgImNhbGlicmF0aW5nIEFQSUMgdGltZXIgLi4uXG4iKTsNCj4gICANCj4g
LQlsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPiAtDQo+IC0JLyogUmVwbGFjZSB0aGUgZ2xvYmFsIGlu
dGVycnVwdCBoYW5kbGVyICovDQo+IC0JcmVhbF9oYW5kbGVyID0gZ2xvYmFsX2Nsb2NrX2V2ZW50
LT5ldmVudF9oYW5kbGVyOw0KPiAtCWdsb2JhbF9jbG9ja19ldmVudC0+ZXZlbnRfaGFuZGxlciA9
IGxhcGljX2NhbF9oYW5kbGVyOw0KPiArCS8qDQo+ICsJICogVGhlcmUgYXJlIHBsYXRmb3JtcyB3
L28gZ2xvYmFsIGNsb2NrZXZlbnQgZGV2aWNlcy4gSW5zdGVhZCBvZg0KPiArCSAqIG1ha2luZyB0
aGUgY2FsaWJyYXRpb24gY29uZGl0aW9uYWwgb24gdGhhdCwgdXNlIGEgcG9sbGluZyBiYXNlZA0K
PiArCSAqIGFwcHJvYWNoIGV2ZXJ5d2hlcmUuDQo+ICsJICovDQo+ICAgDQo+ICsJbG9jYWxfaXJx
X2Rpc2FibGUoKTsNCj4gICAJLyoNCj4gICAJICogU2V0dXAgdGhlIEFQSUMgY291bnRlciB0byBt
YXhpbXVtLiBUaGVyZSBpcyBubyB3YXkgdGhlIGxhcGljDQo+ICAgCSAqIGNhbiB1bmRlcmZsb3cg
aW4gdGhlIDEwMG1zIGRldGVjdGlvbiB0aW1lIGZyYW1lDQo+ICAgCSAqLw0KPiAgIAlfX3NldHVw
X0FQSUNfTFZUVCgweGZmZmZmZmZmLCAwLCAwKTsNCj4gICANCj4gLQkvKiBMZXQgdGhlIGludGVy
cnVwdHMgcnVuICovDQo+IC0JbG9jYWxfaXJxX2VuYWJsZSgpOw0KPiArCS8qDQo+ICsJICogTWV0
aG9kcyB0byB0ZXJtaW5hdGUgdGhlIGNhbGlicmF0aW9uIGxvb3A6DQo+ICsJICogIDEpIEdsb2Jh
bCBjbG9ja2V2ZW50IGlmIGF2YWlsYWJsZSAoamlmZmllcykNCj4gKwkgKiAgMikgVFNDIGlmIGF2
YWlsYWJsZSBhbmQgZnJlcXVlbmN5IGlzIGtub3duDQo+ICsJICovDQo+ICsJamlmX3N0YXJ0ID0g
UkVBRF9PTkNFKGppZmZpZXMpOw0KPiArDQo+ICsJaWYgKHRzY19raHopIHsNCj4gKwkJdHNjX3N0
YXJ0ID0gcmR0c2MoKTsNCj4gKwkJdHNjX3BlcmogPSBkaXZfdTY0KCh1NjQpdHNjX2toeiAqIDEw
MDAsIEhaKTsNCj4gKwl9DQo+ICsNCj4gKwl3aGlsZSAobGFwaWNfY2FsX2xvb3BzIDw9IExBUElD
X0NBTF9MT09QUykgew0KPiArCQkvKg0KPiArCQkgKiBFbmFibGUgaW50ZXJydXB0cyBzbyB0aGUg
dGljayBjYW4gZmlyZSwgaWYgYSBnbG9iYWwNCj4gKwkJICogY2xvY2tldmVudCBkZXZpY2UgaXMg
YXZhaWxhYmxlDQo+ICsJCSAqLw0KPiArCQlsb2NhbF9pcnFfZW5hYmxlKCk7DQoNCkp1c3QgYSBu
aXQsIGJ1dCB5b3UgZW5kIHVwIGRvaW5nIHRoaXMgYXQgdGhlIGJvdHRvbSBvZiB0aGUgbG9vcCwg
c28geW91DQpjb3VsZCBtb3ZlIHRoaXMgaW52b2NhdGlvbiB0byBqdXN0IGJlZm9yZSB0aGUgbG9v
cCBhbmQgYXZvaWQgZG9pbmcgdHdvDQpsb2NhbF9pcnFfZW5hYmxlKCkgY2FsbHMgaW4gc3VjY2Vz
c2lvbiBhZnRlciB0aGUgZmlyc3QgaXRlcmF0aW9uLg0KDQpUaGFua3MsDQpUb20NCg0KPiAgIA0K
PiAtCXdoaWxlIChsYXBpY19jYWxfbG9vcHMgPD0gTEFQSUNfQ0FMX0xPT1BTKQ0KPiAtCQljcHVf
cmVsYXgoKTsNCj4gKwkJLyogV2FpdCBmb3IgYSB0aWNrIHRvIGVsYXBzZSAqLw0KPiArCQl3aGls
ZSAoMSkgew0KPiArCQkJaWYgKHRzY19raHopIHsNCj4gKwkJCQl1NjQgdHNjX25vdyA9IHJkdHNj
KCk7DQo+ICsJCQkJaWYgKCh0c2Nfbm93IC0gdHNjX3N0YXJ0KSA+PSB0c2NfcGVyaikgew0KPiAr
CQkJCQl0c2Nfc3RhcnQgKz0gdHNjX3Blcmo7DQo+ICsJCQkJCWJyZWFrOw0KPiArCQkJCX0NCj4g
KwkJCX0gZWxzZSB7DQo+ICsJCQkJdW5zaWduZWQgbG9uZyBqaWZfbm93ID0gUkVBRF9PTkNFKGpp
ZmZpZXMpOw0KPiArDQo+ICsJCQkJaWYgKHRpbWVfYWZ0ZXIoamlmX25vdywgamlmX3N0YXJ0KSkg
ew0KPiArCQkJCQlqaWZfc3RhcnQgPSBqaWZfbm93Ow0KPiArCQkJCQlicmVhazsNCj4gKwkJCQl9
DQo+ICsJCQl9DQo+ICsJCQljcHVfcmVsYXgoKTsNCj4gKwkJfQ0KPiArDQo+ICsJCS8qIEludm9r
ZSB0aGUgY2FsaWJyYXRpb24gcm91dGluZSAqLw0KPiArCQlsb2NhbF9pcnFfZGlzYWJsZSgpOw0K
PiArCQlsYXBpY19jYWxfaGFuZGxlcihOVUxMKTsNCj4gKwkJbG9jYWxfaXJxX2VuYWJsZSgpOw0K
PiArCX0NCj4gICANCj4gICAJbG9jYWxfaXJxX2Rpc2FibGUoKTsNCj4gICANCj4gLQkvKiBSZXN0
b3JlIHRoZSByZWFsIGV2ZW50IGhhbmRsZXIgKi8NCj4gLQlnbG9iYWxfY2xvY2tfZXZlbnQtPmV2
ZW50X2hhbmRsZXIgPSByZWFsX2hhbmRsZXI7DQo+IC0NCj4gICAJLyogQnVpbGQgZGVsdGEgdDEt
dDIgYXMgYXBpYyB0aW1lciBjb3VudHMgZG93biAqLw0KPiAgIAlkZWx0YSA9IGxhcGljX2NhbF90
MSAtIGxhcGljX2NhbF90MjsNCj4gICAJYXBpY19wcmludGsoQVBJQ19WRVJCT1NFLCAiLi4uIGxh
cGljIGRlbHRhID0gJWxkXG4iLCBkZWx0YSk7DQo+IEBAIC05NDMsMTAgKzk4MCwxMSBAQCBzdGF0
aWMgaW50IF9faW5pdCBjYWxpYnJhdGVfQVBJQ19jbG9jayh2DQo+ICAgCWxldnQtPmZlYXR1cmVz
ICY9IH5DTE9DS19FVlRfRkVBVF9EVU1NWTsNCj4gICANCj4gICAJLyoNCj4gLQkgKiBQTSB0aW1l
ciBjYWxpYnJhdGlvbiBmYWlsZWQgb3Igbm90IHR1cm5lZCBvbg0KPiAtCSAqIHNvIGxldHMgdHJ5
IEFQSUMgdGltZXIgYmFzZWQgY2FsaWJyYXRpb24NCj4gKwkgKiBQTSB0aW1lciBjYWxpYnJhdGlv
biBmYWlsZWQgb3Igbm90IHR1cm5lZCBvbiBzbyBsZXRzIHRyeSBBUElDDQo+ICsJICogdGltZXIg
YmFzZWQgY2FsaWJyYXRpb24sIGlmIGEgZ2xvYmFsIGNsb2NrZXZlbnQgZGV2aWNlIGlzDQo+ICsJ
ICogYXZhaWxhYmxlLg0KPiAgIAkgKi8NCj4gLQlpZiAoIXBtX3JlZmVyZW5jZWQpIHsNCj4gKwlp
ZiAoIXBtX3JlZmVyZW5jZWQgJiYgZ2xvYmFsX2Nsb2NrX2V2ZW50KSB7DQo+ICAgCQlhcGljX3By
aW50ayhBUElDX1ZFUkJPU0UsICIuLi4gdmVyaWZ5IEFQSUMgdGltZXJcbiIpOw0KPiAgIA0KPiAg
IAkJLyoNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9hY3BpX3BtdG1yLmgNCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9hY3BpX3BtdG1yLmgNCj4gQEAgLTE4LDYgKzE4LDExIEBADQo+ICAgZXh0ZXJuIHUz
MiBhY3BpX3BtX3JlYWRfdmVyaWZpZWQodm9pZCk7DQo+ICAgZXh0ZXJuIHUzMiBwbXRtcl9pb3Bv
cnQ7DQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgYWNwaV9wbV90aW1lcl9hdmFpbGFibGUo
dm9pZCkNCj4gK3sNCj4gKwlyZXR1cm4gcG10bXJfaW9wb3J0ICE9IDA7DQo+ICt9DQo+ICsNCj4g
ICBzdGF0aWMgaW5saW5lIHUzMiBhY3BpX3BtX3JlYWRfZWFybHkodm9pZCkNCj4gICB7DQo+ICAg
CWlmICghcG10bXJfaW9wb3J0KQ0KPiBAQCAtMjgsNiArMzMsMTEgQEAgc3RhdGljIGlubGluZSB1
MzIgYWNwaV9wbV9yZWFkX2Vhcmx5KHZvaQ0KPiAgIA0KPiAgICNlbHNlDQo+ICAgDQo+ICtzdGF0
aWMgaW5saW5lIGJvb2wgYWNwaV9wbV90aW1lcl9hdmFpbGFibGUodm9pZCkNCj4gK3sNCj4gKwly
ZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgaW5saW5lIHUzMiBhY3BpX3BtX3Jl
YWRfZWFybHkodm9pZCkNCj4gICB7DQo+ICAgCXJldHVybiAwOw0KPiANCg==
