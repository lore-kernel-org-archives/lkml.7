Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5009AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253B621850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfCTLLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:11:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20811 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbfCTLLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:11:09 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-190-gGw3zY5nP3eJLsUE3SxWEw-1; Wed, 20 Mar 2019 11:11:05 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 Mar 2019 11:12:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Mar 2019 11:12:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Topic: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU3ceS4xXYBMxxoEiV6xS01ZPx8qYUXb/A
Date:   Wed, 20 Mar 2019 11:12:07 +0000
Message-ID: <30998bcd55a34ed38b681f9bb3e3fb87@AcuMS.aculab.com>
References: <20190318094128.1488-1-elena.reshetova@intel.com>
 <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
In-Reply-To: <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: gGw3zY5nP3eJLsUE3SxWEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDE4IE1hcmNoIDIwMTkgMjA6MTYNCi4uLg0K
PiA+IEFzIGEgcmVzdWx0IHRoaXMgcGF0Y2ggaW50cm9kdWNlcyA4IGJpdHMgb2YgcmFuZG9tbmVz
cw0KPiA+IChiaXRzIDQgLSAxMSBhcmUgcmFuZG9taXplZCwgYml0cyAwLTMgbXVzdCBiZSB6ZXJv
IGR1ZSB0byBzdGFjayBhbGlnbm1lbnQpDQo+ID4gYWZ0ZXIgcHRfcmVncyBsb2NhdGlvbiBvbiB0
aGUgdGhyZWFkIHN0YWNrLg0KPiA+IFRoZSBhbW91bnQgb2YgcmFuZG9tbmVzcyBjYW4gYmUgYWRq
dXN0ZWQgYmFzZWQgb24gaG93IG11Y2ggb2YgdGhlDQo+ID4gc3RhY2sgc3BhY2Ugd2Ugd2lzaC9j
YW4gdHJhZGUgZm9yIHNlY3VyaXR5Lg0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIGZvdXIgemVybyBi
aXRzIGF0IHRoZSBib3R0b20/ICB4ODZfNjQgTGludXggb25seQ0KPiBtYWludGFpbnMgOCBieXRl
IHN0YWNrIGFsaWdubWVudC4NCg0KSVNUUiB0aGF0IHRoZSBnY2MgZGV2ZWxvcGVycyBhcmJpdHJh
cmlseSBjaGFuZ2VkIHRoZSBhbGlnbm1lbnQNCmEgZmV3IHllYXJzIGFnby4NCklmIHRoZSBzdGFj
ayBpcyBvbmx5IDggYnl0ZSBhbGlnbmVkIGFuZCB5b3UgYWxsb2NhdGUgYSB2YXJpYWJsZSB0aGF0
DQpyZXF1aXJlcyAxNiBieXRlIGFsaWdubWVudCB5b3UgbmVlZCBnY2MgdG8gZ2VuZXJhdGUgdGhl
IGV4dHJhIHN0YWNrDQpmcmFtZSB0byBhbGlnbiB0aGUgc3RhY2suDQpJIGRvbid0IHJlbWVtYmVy
IHNlZWluZyB0aGUgcmVsZXZhbnQgZ2NjIG9wdGlvbnMgb24gdGhlIGxpbnV4DQpnY2MgY29tbWFu
ZCBsaW5lcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

