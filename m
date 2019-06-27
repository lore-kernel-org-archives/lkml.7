Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AC82080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="SXGozLCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfF0JuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:50:03 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:12314 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbfF0JuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:50:03 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 05:50:01 EDT
X-IronPort-AV: E=McAfee;i="6000,8403,9300"; a="4700467"
X-IronPort-AV: E=Sophos;i="5.63,423,1557154800"; 
   d="scan'208";a="4700467"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2019 18:41:46 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector1-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xau6Txq9jQewfvZAJs10LxHpWFjBeu+ae//TvuxrF4=;
 b=SXGozLCa+Le0qXnwncW6dt7JbMMFXRK1cQztjrhqpDDj86gVTqjrXrNcIVbyfzNHk2SpaHOLEisxOLy5F1cqwnL2OPv3LA/EYL+R/2URf+29ZyJqF80K59EW8EZQcQHsjRlb0S11UiGalPNGRXToP2EGymuUpS3RxwG+AUaDyCY=
Received: from OSAPR01MB4993.jpnprd01.prod.outlook.com (20.179.178.151) by
 OSAPR01MB2179.jpnprd01.prod.outlook.com (52.134.234.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Thu, 27 Jun 2019 09:41:43 +0000
Received: from OSAPR01MB4993.jpnprd01.prod.outlook.com
 ([fe80::59f0:837d:b06f:9dbd]) by OSAPR01MB4993.jpnprd01.prod.outlook.com
 ([fe80::59f0:837d:b06f:9dbd%5]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 09:41:43 +0000
From:   "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To:     Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Anup Patel <anup.Patel@wdc.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Julien Grall <julien.grall@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Thread-Topic: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Thread-Index: AQHU4ARcPz9tm+J3xUqwKj8A/ooqYqaNvxWAgBVs3wCAAA0vgIAAMV6AgANNMoCAA0uhgIABKgAAgASsFgA=
Date:   Thu, 27 Jun 2019 09:41:42 +0000
Message-ID: <c5be6baa-91aa-c178-6698-c83d4d82a217@jp.fujitsu.com>
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
 <20190621141606.GF18954@arrakis.emea.arm.com>
 <CAJF2gTTVUToRkRtxTmtWDotMGXy5YQCpL1h_2neTBuN3e6oz1w@mail.gmail.com>
 <20190624102209.ngwtosgr5fvp3ler@willie-the-truck>
In-Reply-To: <20190624102209.ngwtosgr5fvp3ler@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qi.fuli@fujitsu.com; 
x-originating-ip: [211.13.147.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e67b46a7-e10b-44ac-f919-08d6fae3a9b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:OSAPR01MB2179;
x-ms-traffictypediagnostic: OSAPR01MB2179:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <OSAPR01MB21797B3EF4119D4D4EB1B736F7FD0@OSAPR01MB2179.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(31696002)(14444005)(256004)(6306002)(6512007)(53936002)(6436002)(6486002)(5660300002)(76116006)(73956011)(6246003)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(71190400001)(966005)(31686004)(316002)(229853002)(2906002)(54906003)(110136005)(14454004)(76176011)(7736002)(66066001)(99286004)(8936002)(6506007)(68736007)(85182001)(4326008)(25786009)(102836004)(26005)(476003)(53546011)(8676002)(186003)(7416002)(81166006)(81156014)(486006)(11346002)(478600001)(86362001)(6116002)(3846002)(446003)(305945005)(3714002)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSAPR01MB2179;H:OSAPR01MB4993.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zVoC3YR9MYzDJEChb14qJgO2JqQHqjnYYNSCYmultvC+waI3cGko/WW5cp8QCdjSeFli69QotZRwIWaPfu/pearC6ydL1lMChYHEU6dP/QPEhN5aIFHuRYbhDnWXR4ADRNlGQB0bJOUrr1+Fl4MNWgUesp8q+1g+BqPtTQRHVKUez7AVeiunKkykAssuLFGA2mbOXBfgkvYMB/MofffS4x5yVDobN+xAYsO7rdomu/HU0tx/ABvq3WnubLzaphZikVxNy75WJaZyxwmgPrtnW1XJqp+IF+nuHWUBkCV1Gnd/ikma4/g2bxR6yiLE+UHcIdg8jXEXrlGm4h2amHtGmId89opcFbTluAGXMn4uziiXswsGahJCJ0Qorw+tgFfTM/K5E9oelMT/2nLyuJIhwzLw2NAOWzGN1Nxcv4cc1UM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD4886E71D71804996690C96B064C95D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67b46a7-e10b-44ac-f919-08d6fae3a9b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 09:41:43.0328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qi.fuli@jp.fujitsu.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA2LzI0LzE5IDc6MjIgUE0sIFdpbGwgRGVhY29uIHdyb3RlOg0KPiBPbiBNb24sIEp1biAy
NCwgMjAxOSBhdCAxMjozNTozNUFNICswODAwLCBHdW8gUmVuIHdyb3RlOg0KPj4gT24gRnJpLCBK
dW4gMjEsIDIwMTkgYXQgMTA6MTYgUE0gQ2F0YWxpbiBNYXJpbmFzDQo+PiA8Y2F0YWxpbi5tYXJp
bmFzQGFybS5jb20+IHdyb3RlOg0KPj4+IE9uIFdlZCwgSnVuIDE5LCAyMDE5IGF0IDA3OjUxOjAz
UE0gKzA4MDAsIEd1byBSZW4gd3JvdGU6DQo+Pj4+IE9uIFdlZCwgSnVuIDE5LCAyMDE5IGF0IDQ6
NTQgUE0gSnVsaWVuIEdyYWxsIDxqdWxpZW4uZ3JhbGxAYXJtLmNvbT4gd3JvdGU6DQo+Pj4+PiBP
biA2LzE5LzE5IDk6MDcgQU0sIEd1byBSZW4gd3JvdGU6DQo+Pj4+Pj4gTW92ZSBhcm0gYXNpZCBh
bGxvY2F0b3IgY29kZSBpbiBhIGdlbmVyaWMgb25lIGlzIGEgYWdvb2QgaWRlYSwgSSd2ZQ0KPj4+
Pj4+IG1hZGUgYSBwYXRjaHNldCBmb3IgQy1TS1kgYW5kIHRlc3QgaXMgb24gcHJvY2Vzc2luZywg
U2VlOg0KPj4+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWNza3kvMTU2MDkzMDU1
My0yNjUwMi0xLWdpdC1zZW5kLWVtYWlsLWd1b3JlbkBrZXJuZWwub3JnLw0KPj4+Pj4+DQo+Pj4+
Pj4gSWYgeW91IHBsYW4gdG8gc2VwZXJhdGUgaXQgaW50byBnZW5lcmljIG9uZSwgSSBjb3VsZCBj
by13b3JrIHdpdGggeW91Lg0KPj4+Pj4gV2FzIHRoZSBBU0lEIGFsbG9jYXRvciB3b3JrIG91dCBv
ZiBib3ggb24gQy1Ta3k/DQo+Pj4+IEFsbW9zdCBkb25lLCBidXQgb25lIHF1ZXN0aW9uOg0KPj4+
PiBhcm02NCByZW1vdmUgdGhlIGNvZGUgaW4gc3dpdGNoX21tOg0KPj4+PiAgICBjcHVtYXNrX2Ns
ZWFyX2NwdShjcHUsIG1tX2NwdW1hc2socHJldikpOw0KPj4+PiAgICBjcHVtYXNrX3NldF9jcHUo
Y3B1LCBtbV9jcHVtYXNrKG5leHQpKTsNCj4+Pj4NCj4+Pj4gV2h5PyBBbHRob3VnaCBhcm02NCBj
YWNoZSBvcGVyYXRpb25zIGNvdWxkIGFmZmVjdCBhbGwgaGFydHMgd2l0aCBDVEMNCj4+Pj4gbWV0
aG9kIG9mIGludGVyY29ubmVjdCwgSSB0aGluayB3ZSBzaG91bGQga2VlcCB0aGVzZSBjb2RlIGZv
cg0KPj4+PiBwcmltaXRpdmUgaW50ZWdyaXR5IGluIGxpbnV4LiBCZWNhdXNlIGNwdV9iaXRtYXAg
aXMgaW4gbW1fc3RydWN0DQo+Pj4+IGluc3RlYWQgb2YgbW0tPmNvbnRleHQuDQo+Pj4gV2UgZGlk
bid0IGhhdmUgYSB1c2UgZm9yIHRoaXMgaW4gdGhlIGFybTY0IGNvZGUsIHNvIG5vIHBvaW50IGlu
DQo+Pj4gbWFpbnRhaW5pbmcgdGhlIG1tX2NwdW1hc2suIE9uIHNvbWUgYXJtMzIgc3lzdGVtcyAo
QVJNdjYpIHdpdGggbm8NCj4+PiBoYXJkd2FyZSBicm9hZGNhc3Qgb2Ygc29tZSBUTEIvY2FjaGUg
b3BlcmF0aW9ucywgd2UgdXNlIGl0IHRvIHRyYWNrDQo+Pj4gd2hlcmUgdGhlIHRhc2sgaGFzIHJ1
biB0byBpc3N1ZSBJUEkgZm9yIFRMQiBpbnZhbGlkYXRpb24gb3Igc29tZQ0KPj4+IGRlZmVycmVk
IEktY2FjaGUgaW52YWxpZGF0aW9uLg0KPj4gVGhlIG9wZXJhdGlvbiBvZiBzZXQvY2xlYXIgbW1f
Y3B1bWFzayB3YXMgcmVtb3ZlZCBpbiBhcm02NCBjb21wYXJlZCB0bw0KPj4gYXJtMzIuIEl0IHNl
ZW1zIG5vIHNpZGUgZWZmZWN0IG9uIGN1cnJlbnQgYXJtNjQgc3lzdGVtLCBidXQgZnJvbQ0KPj4g
c29mdHdhcmUgbWVhbmluZyBpdCdzIHdyb25nLg0KPj4gSSB0aGluayB3ZSBzaG91bGQga2VlcCBt
bV9jcHVtYXNrIGp1c3QgbGlrZSBhcm0zMi4NCj4gSXQgd2FzIGEgd2hpbGUgYWdvIG5vdywgYnV0
IEkgcmVtZW1iZXIgdGhlIGF0b21pYyB1cGRhdGUgb2YgdGhlIG1tX2NwdW1hc2sNCj4gYmVpbmcg
cXVpdGUgZXhwZW5zaXZlIHdoZW4gSSB3YXMgcHJvZmlsaW5nIHRoaXMgc3R1ZmYsIHNvIEkgcmVt
b3ZlZCBpdA0KPiBiZWNhdXNlIHdlIGRvbid0IG5lZWQgaXQgZm9yIGFybTY0IChhdCBsZWFzdCwg
aXQgZG9lc24ndCBhbGxvdyB1cyB0bw0KPiBvcHRpbWlzZSBvdXIgc2hvb3Rkb3ducyBpbiBwcmFj
dGljZSkuDQoNCkhpIFdpbGwsDQoNCkkgdGhpbmsgbW1fY3B1bWFzayBjYW4gYmUgdXNlZCBmb3Ig
ZmlsdGVyaW5nIHRoZSBjcHVzIHRoYXQgdGhlcmUgYXJlIFRCTCANCmVudHJpZXMgb24uDQpUaGUg
T1Mgaml0dGVyIGNhbiBiZSByZWR1Y2VkIGJ5IGludmFsaWRhdGluZyBUTEIgZW50cmllcyBvbmx5
IG9uIHRoZSANCkNQVXMgc3BlY2lmaWVkIGJ5IG1tX2NwdW1hc2sobW0pLg0KQXMgSSBtZW50aW9u
ZWQgaW4gYW4gZWFybGllciBlbWFpbCwgdGhlIDIuNSUgT1Mgaml0dGVyIGNhbiByZXN1bHQgaW4g
DQpvdmVyIGEgZmFjdG9yIG9mIDIwIHNsb3dkb3duIGZvciB0aGUgc2FtZSBhcHBsaWNhdGlvbiBb
MV0uDQpUaG91Z2ggaXQgbWF5IGJlIGFuIGV4dHJlbWUgZXhhbXBsZSwgcmVkdWNpbmcgdGhlIE9T
IGppdHRlciBoYXMgYmVlbiBhbiANCmlzc3VlIGluIEhQQyBlbnZpcm9ubWVudC4NCkkgd291bGQg
bGlrZSB0byBhdm9pZCBicm9hZGNhc3QgVExCSSBieSB1c2luZyBtbV9jcHVtYXNrIG9uIGFybTY0
LCBjbG91ZCANCnlvdSBwbGVhc2UgdGVsbCBtZSBtb3JlIGFib3V0IHRoZSBjb3N0cyBjYXVzZWQg
YnkgdXBkYXRpbmcgbW1fY3B1bWFzaz8NCg0KSGVyZSBpcyBteSBwYXRjaDoNCmh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE5LzYvMTcvNzAzDQoNClsxXSBGZXJyZWlyYSwgS3VydCBCLiwgUGF0cmlj
ayBCcmlkZ2VzLCBhbmQgUm9uIEJyaWdodHdlbGwuIA0KIkNoYXJhY3Rlcml6aW5nIGFwcGxpY2F0
aW9uIHNlbnNpdGl2aXR5IHRvIE9TIGludGVyZmVyZW5jZSB1c2luZyANCmtlcm5lbC1sZXZlbCBu
b2lzZSBpbmplY3Rpb24uIiBQcm9jZWVkaW5ncyBvZiB0aGUgMjAwOCBBQ00vSUVFRSANCmNvbmZl
cmVuY2Ugb24gU3VwZXJjb21wdXRpbmcuIElFRUUgUHJlc3MsIDIwMDguDQoNClRoYW5rcywNClFJ
IEZ1bGkNCg0KPiBJIHN0aWxsIHRoaW5rIHRoaXMgaXMgb3Zlci1lbmdpbmVlcmVkIGZvciB3aGF0
IHlvdSB3YW50IG9uIGMtc2t5IGFuZCBtYWtpbmcNCj4gdGhpcyBjb2RlIGdlbmVyaWMgaXMgYSBt
aXN0YWtlLg0KPg0KPiBXaWxs
