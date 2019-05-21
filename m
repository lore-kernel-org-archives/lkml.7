Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE5FC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9A216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfEUKr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:47:27 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:48341 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:47:27 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x4LAkXik006037
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 May 2019 19:46:33 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4LAkXo0029763;
        Tue, 21 May 2019 19:46:33 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4LAiEhb002991;
        Tue, 21 May 2019 19:46:33 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5240706; Tue, 21 May 2019 19:43:31 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Tue,
 21 May 2019 19:43:31 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Baoquan He <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Thread-Topic: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI
 systab and ACPI tables
Thread-Index: AQHVD7QFUJEBPcePeESpYMnbGSS4VaZ0zb0A
Date:   Tue, 21 May 2019 10:43:30 +0000
Message-ID: <d9d9a627-d0e5-4ee6-7ce1-676db6cb60f4@ce.jp.nec.com>
References: <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv> <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv> <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv> <20190513075006.GB20105@zn.tnic>
 <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
 <20190515065843.GA24212@zn.tnic>
 <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
 <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
In-Reply-To: <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8CB98E7593A254FA2F953E6D7F99473@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS8wNS8yMSAxODowMiwgS2FpcnVpIFNvbmcgd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDE1
LCAyMDE5IGF0IDM6MTAgUE0gSnVuaWNoaSBOb211cmEgPGotbm9tdXJhQGNlLmpwLm5lYy5jb20+
IHdyb3RlOg0KPj4gT24gNS8xNS8xOSAzOjU4IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+
Pj4gT24gV2VkLCBNYXkgMTUsIDIwMTkgYXQgMDU6MTc6MTlBTSArMDAwMCwgSnVuaWNoaSBOb211
cmEgd3JvdGU6DQo+Pj4+IEkgZm91bmQga2V4ZWMoMSkgZmFpbHMgdG8gbG9hZCBrZXJuZWwgb24g
YSBmZXcgbWFjaGluZXMgaWYgdGhpcyBwYXRjaA0KPj4+PiBpcyBhcHBsaWVkLiAgVGhvc2UgbWFj
aGluZXMgZG9uJ3QgaGF2ZSBJT1JFU19ERVNDX0FDUElfVEFCTEVTIHJlZ2lvbg0KPj4+PiBhbmQg
aGF2ZSBBQ1BJIHRhYmxlcyBpbiBJT1JFU19ERVNDX0FDUElfTlZfU1RPUkFHRSByZWdpb24gaW5z
dGVhZC4NCj4+Pg0KPj4+IFdoeT8gV2hhdCBraW5kIG9mIG1hY2hpbmVzIGFyZSB0aG9zZT8NCj4+
DQo+PiBJIGRvbid0IGtub3cuICBUaGV5IGFyZSBqdXN0IGdlbmVyYWwgcHVycG9zZSBYZW9uLWJh
c2VkIHNlcnZlcnMNCj4+IGFuZCBub3Qgc29tZSBzcGVjaWFsIHB1cnBvc2UgbWFjaGluZXMuICBT
byBJIGd1ZXNzIHRoZXJlIGFyZSBvdGhlcg0KPj4gc3VjaCBtYWNoaW5lcyBpbiB0aGUgd2lsZC4N
Cj4gDQo+IEhpLCBJIHRoaW5rIGl0J3MgcmVhc29uYWJsZSB0byB1cGRhdGUgdGhlIHBhdGNoIHRv
IGluY2x1ZGUgdGhlDQo+IE5WX1NUT1JBR0UgcmVnaW9ucyBhcyB3ZWxsLCBtb3N0IGxpa2VseSB0
aGUgZmlybXdhcmUgb25seSBwcm92aWRlZA0KPiBOVl9TVE9SQUdFIHJlZ2lvbj8gQ2FuIHlvdSBo
ZWxwIGNvbmZpcm0gaWYgdGhlIGU4MjAgZGlkbid0IGNvbnRhaW4NCj4gQUNQSSBkYXRhLCBhbmQg
b25seSBBQ1BJIE5WUz8NCg0KWWVzLCB0aG9zZSBtYWNoaW5lcyBvbmx5IGhhdmUgQUNQSSBOVlMg
cmVnaW9uIGFzIGZhciBhcyBJIHNlZSBmcm9tIGtlcm5lbCBsb2cuDQoNCj4gSSBoYWQgYSB0cnkg
d2l0aCB0aGlzIHVwZGF0ZSBwYXRjaCwgaXQgd29ya2VkIGFuZCBkaWRuJ3QgYnJlYWsgYW55dGhp
bmcuDQo+IA0KPiBIaSBCb3Jpcywgd291bGQgeW91IHByZWZlciB0byBqdXN0IGZvbGQgSnVuaWNo
aSB1cGRhdGUgcGF0Y2ggaW50byB0aGUNCj4gcHJldmlvdXMgb25lIG9yIEkgc2hvdWxkIHNlbmQg
YW4gdXBkYXRlZCBwYXRjaD8NCg0KLS0gDQpKdW4naWNoaSBOb211cmEsIE5FQyBDb3Jwb3JhdGlv
biAvIE5FQyBTb2x1dGlvbiBJbm5vdmF0b3JzLCBMdGQu

