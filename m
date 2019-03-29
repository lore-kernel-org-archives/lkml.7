Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628592173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfC2Hw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:52:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:35172 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbfC2Hw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:52:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 00:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,283,1549958400"; 
   d="scan'208";a="218681730"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2019 00:52:24 -0700
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 irsmsx110.ger.corp.intel.com (163.33.3.25) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 29 Mar 2019 07:50:06 +0000
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.146]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.140]) with mapi id 14.03.0415.000;
 Fri, 29 Mar 2019 07:50:05 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     'Kees Cook' <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Topic: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU3W7K/qF6gc5OOEis06RmzC4AhqYR090AgAAOl4CAC99ecIABLxOAgAJO6ICAAAwXgIAABToAgAACwaA=
Date:   Fri, 29 Mar 2019 07:50:05 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C203E8@IRSMSX102.ger.corp.intel.com>
References: <20190318094128.1488-1-elena.reshetova@intel.com>
 <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
 <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C19A55@IRSMSX102.ger.corp.intel.com>
 <CALCETrXnfk5zYWmpdLvYbcJ7hhFM13+LPq14MF7s99iqtS4-jg@mail.gmail.com>
 <CAGXu5j+r-NH5+QY=siE+6RTkUKoRF0Rso6KHM4NOMsCvpcjW5g@mail.gmail.com>
 <3F1480E2-3D58-4A79-8609-2A9F7991804F@amacapital.net>
 <CAGXu5jLBP-95aEF2refYimAJ=ea42C_3Ywb+1dZAaVR1rbmP9Q@mail.gmail.com>
In-Reply-To: <CAGXu5jLBP-95aEF2refYimAJ=ea42C_3Ywb+1dZAaVR1rbmP9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2U3MGQ2NGYtZDMyNS00ZmUyLWIxN2QtNTU4ODZiM2IzNWM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidUY0eVhXUVBVakZYbHpyaVdyZDA1d2J5Skh3cXcrbUdLdFdcL05ES3R2NklOTTYzcmw3YmZqdytzUW5LYXBOdDEifQ==
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIE1hciAyOCwgMjAxOSBhdCA5OjI5IEFNIEFuZHkgTHV0b21pcnNraSA8bHV0b0Bh
bWFjYXBpdGFsLm5ldD4gd3JvdGU6DQo+ID4gRG9lc27igJl0IHRoaXMganVzdCBsZWFrIHNvbWUg
b2YgdGhlIGNhbmFyeSB0byB1c2VyIGNvZGUgdGhyb3VnaCBzaWRlIGNoYW5uZWxzPw0KPiANCj4g
RXJmLCB5ZXMsIGdvb2QgcG9pbnQuIExldCdzIGp1c3QgdXNlIHByYW5kb20gYW5kIGJlIGRvbmUg
d2l0aCBpdC4NCg0KQW5kIGhlcmUgSSBoYXZlIHNvbWUgbnVtYmVycyBvbiB0aGlzLiBBY3R1YWxs
eSBwcmFuZG9tIHR1cm5lZCBvdXQgdG8gYmUgcHJldHR5DQpmYXN0LCBldmVuIHdoZW4gY2FsbGVk
IGV2ZXJ5IHN5c2NhbGwuIFNlZSB0aGUgbnVtYmVycyBiZWxvdzoNCg0KMSkgbG1iZW5jaDogLi9s
YXRfc3lzY2FsbCAtTiAxMDAwMDAwIG51bGwNCiAgICBiYXNlOiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBTaW1wbGUgc3lzY2FsbDogMC4xNzc0IG1pY3Jvc2Vj
b25kcw0KICAgIHJhbmRvbV9vZmZzZXQgKHByYW5kb21fdTMyKCkgZXZlcnkgc3lzY2FsbCk6ICAg
ICBTaW1wbGUgc3lzY2FsbDogMC4xODIyIG1pY3Jvc2Vjb25kcw0KICAgIHJhbmRvbV9vZmZzZXQg
KHByYW5kb21fdTMyKCkgZXZlcnkgNHRoIHN5c2NhbGwpOiBTaW1wbGUgc3lzY2FsbDogMC4xODQ0
IG1pY3Jvc2Vjb25kcw0KDQoyKSAgQW5keSdzIHRlc3RzLCBtaXNjLXRlc3RzOiAuL3RpbWluZ190
ZXN0XzY0IDEwTSBzeXNfZW5vc3lzDQogICAgYmFzZTogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMTAwMDAwMDAgbG9vcHMgaW4gMS42MjIyNHMgPSAxNjIuMjIg
bnNlYyAvIGxvb3ANCiAgICByYW5kb21fb2Zmc2V0IChwcmFuZG9tX3UzMigpIGV2ZXJ5IHN5c2Nh
bGwpOiAgICAgMTAwMDAwMDAgbG9vcHMgaW4gMS42NDY2MHMgPSAxNjYuMjYgbnNlYyAvIGxvb3AN
CiAgICByYW5kb21fb2Zmc2V0IChwcmFuZG9tX3UzMigpIGV2ZXJ5IDR0aCBzeXNjYWxsKTogMTAw
MDAwMDAgbG9vcHMgaW4gMy41MTMxNXMgPSAxNjkuMzAgbnNlYyAvIGxvb3ANCg0KVGhlIHNlY29u
ZCBjYXNlIGlzIHdoZW4gcHJhbmRvbSBpcyBjYWxsZWQgb25seSBvbmNlIGluIDQgc3lzY2FsbHMg
YW5kIHVudXNlZCByYW5kb20NCmJpdHMgYXJlIHByZXNlcnZlZCBpbiBhIHBlci1jcHUgYnVmZmVy
LiBBcyB5b3UgY2FuIHNlZSBpdCBpcyBhY3R1YWxseSBzbG93ZXIgKG1vZHVsbyBteSBtYXliZSBu
b3QNCnNvIG9wdGltaXplZCBjb2RlIGluIHByYW5kb20sIHNlZSBiZWxvdykgdnMuIGNhbGxpbmcg
aXQgZXZlcnkgdGltZSwgc28gSSB3b3VsZCB2b3RlIGZvciBhY3R1YWxseSBjYWxsaW5nIGl0IGV2
ZXJ5IHRpbWUgYW5kIHNhdmluZw0Kb24gdGhlIGhhc3NsZSBhbmQgYWxzbyBhdm9pZCBhZGRpdGlv
bmFsIGNvZGUgaW4gcHJhbmRvbS4NCg0KQW5kIGJlbG93IGlzIHdoYXQgSSB3YXMgY2FsbGluZyBp
bnN0ZWFkIG9mIHByYW5kb21fdTMyKCkgdG8gcHJlc2VydmUgcmFuZG9tIGJpdHMNCihuZXRfcmFu
ZF9zdGF0ZV9idWZmZXIgaXMgYSBuZXcgcGVyLWNwdSBidWZmZXIgSSBhZGRlZCB0byBzYXZlIHJh
bmRvbSBiaXRzKToNCkFuZCBJIGRpZG4ndCBpbmNsdWRlIHRoZSBjaGVjayBmb3IgYnl0ZXMgPj0g
c2l6ZW9mKHUzMikgc2luY2UgdGhpcyB3YXMgDQpqdXN0IHBvYyB0byB0ZXN0IHRoZSBiYXNlIHNw
ZWVkLCBidXQgZm9yIGdlbmVyaWMgY2FzZSBpdCB3b3VsZCBiZSBuZWVkZWQuDQoNCit2b2lkIHBy
YW5kb21fYnl0ZXNfcHJlc2VydmUodm9pZCAqYnVmLCBzaXplX3QgYnl0ZXMpDQorew0KKyAgICB1
MzIgKmJ1ZmZlciA9ICZnZXRfY3B1X3ZhcihuZXRfcmFuZF9zdGF0ZV9idWZmZXIpOw0KKyAgICB1
OCAqcHRyID0gYnVmOw0KKw0KKyAgICBpZiAoISgqYnVmZmVyKSkgew0KKyAgICAgICAgc3RydWN0
IHJuZF9zdGF0ZSAqc3RhdGUgPSAmZ2V0X2NwdV92YXIobmV0X3JhbmRfc3RhdGUpOw0KKyAgICAg
ICAgaWYgKGJ5dGVzID4gMCkgew0KKyAgICAgICAgICAgICpidWZmZXIgPSBwcmFuZG9tX3UzMl9z
dGF0ZShzdGF0ZSk7DQorICAgICAgICAgICAgZG8gew0KKyAgICAgICAgICAgICAgICAqcHRyKysg
PSAodTgpICpidWZmZXI7DQorICAgICAgICAgICAgICAgIGJ5dGVzLS07DQorICAgICAgICAgICAg
ICAgICpidWZmZXIgPj49IEJJVFNfUEVSX0JZVEU7DQorICAgICAgICAgICAgfSB3aGlsZSAoYnl0
ZXMgPiAwKTsNCisgICAgICAgIH0NCisgICAgICAgIHB1dF9jcHVfdmFyKG5ldF9yYW5kX3N0YXRl
KTsNCisgICAgICAgIHB1dF9jcHVfdmFyKG5ldF9yYW5kX3N0YXRlX2J1ZmZlcik7DQorICAgIH0g
ZWxzZSB7DQorICAgICAgICBpZiAoYnl0ZXMgPiAwKSB7DQorICAgICAgICAgICAgZG8gew0KKyAg
ICAgICAgICAgICAgICAqcHRyKysgPSAodTgpICpidWZmZXI7DQorICAgICAgICAgICAgICAgIGJ5
dGVzLS07DQorICAgICAgICAgICAgICAgICpidWZmZXIgPj49IEJJVFNfUEVSX0JZVEU7DQorICAg
ICAgICAgICAgfSB3aGlsZSAoYnl0ZXMgPiAwKTsNCisgICAgICAgIH0NCisgICAgICAgIHB1dF9j
cHVfdmFyKG5ldF9yYW5kX3N0YXRlX2J1ZmZlcik7DQorICAgIH0NCit9DQoNCkkgd2lsbCBzZW5k
IHRoZSBmaXJzdCB2ZXJzaW9uIG9mIHBhdGNoIChjYWxsaW5nIHByYW5kb21fdTMyKCkgZXZlcnkg
dGltZSkNCnNob3J0bHkgaWYgYW55b25lIHdhbnRzIHRvIGRvdWJsZSBjaGVjayBwZXJmb3JtYW5j
ZSBpbXBsaWNhdGlvbnMuIA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==
