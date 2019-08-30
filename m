Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457CBC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0212087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfH3Qme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:42:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:49953 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727976AbfH3Qme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:42:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-117-W1tnBhGoOWa2nq3fOcF08g-1; Fri, 30 Aug 2019 17:42:31 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 30 Aug 2019 17:42:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Aug 2019 17:42:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: RE: objtool warning "uses BP as a scratch register" with clang-9
Thread-Topic: objtool warning "uses BP as a scratch register" with clang-9
Thread-Index: AQHVX0pqqj9VEXOMQ0SdqQ13OMpYJacT10cw///xooCAABloAA==
Date:   Fri, 30 Aug 2019 16:42:30 +0000
Message-ID: <108518fd630642468e5c6e0274485a93@AcuMS.aculab.com>
References: <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble>
 <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
 <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
 <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
 <20190830150208.jyk7tfzznqimc6ow@treble>
 <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
 <d1af87f139b54346b420d06855297cfa@AcuMS.aculab.com>
 <CAHk-=wh33ouqv7UNovQn8WWXGA_kXEHDY3_H7x5-_j33AHYPwg@mail.gmail.com>
In-Reply-To: <CAHk-=wh33ouqv7UNovQn8WWXGA_kXEHDY3_H7x5-_j33AHYPwg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: W1tnBhGoOWa2nq3fOcF08g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzAgQXVndXN0IDIwMTkgMTc6MDENCj4gT24g
RnJpLCBBdWcgMzAsIDIwMTkgYXQgODo1NSBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCi4uLg0KPiBCdXQgeWVhaCwgaW4gZ2VuZXJhbCBpdCdzIGp1c3Qg
bm90IG9idmlvdXNseSBzYWZlIHRvIHR1cm4gaW5kaXZpZHVhbA0KPiBhY2Nlc3NlcyBpbnRvIG1l
bXNldC9tZW1jcHkuIEluIGNvbnRyYXN0LCB0aGUgcmV2ZXJzZSBpcyBvYnZpb3VzbHkNCj4gZmlu
ZSAoYW5kIF9yZXF1aXJlZF8gZm9yIGFueSBraW5kIG9mIGhhbGYtd2F5IGdvb2QgcGVyZm9ybWFu
Y2Ugd2hlbg0KPiB5b3UgZG8gc21hbGwgY29uc3RhbnQtc2l6ZWQgbWVtb3J5IGNvcGllcywgd2hp
Y2ggaXMgYWN0dWFsbHkgYSBjb21tb24NCj4gcGF0dGVybiBwYXJ0bHkgYmVjYXVzZSB0aGUgaW5z
YW5lIEMgYWxpYXNpbmcgcnVsZXMgaGF2ZSB0YXVnaHQgcGVvcGxlDQo+IHRoYXQgaXQncyB0aGUg
X29ubHlfIHNhZmUgcGF0dGVybiBpbiBzb21lIHNpdHVhdGlvbnMpLg0KDQpJIHdvbmRlciB3aGVy
ZSB0aGUgYWN0dWFsIGN1dG9mZiBpcyBmb3IgY29udmVydGluZyBhIHNlcXVlbmNlIG9mIHdyaXRl
cw0Kb2YgemVybyBpbnRvIGEgY2FsbCB0byBtZW1zZXQoKT8NCg0KSWYgeW91IGFzc3VtZSBlaXRo
ZXI6DQoxKSBjb2xkIGNhY2hlIChmb3IgbWVtc2V0KS4NCjIpIGJyYW5jaCBwcmVkaWN0b3Igbm90
IHNldCBmb3IgemVyb2luZyBhIHNtYWxsIG51bWJlciBvZiB3b3Jkcy4NCkkgc3VzcGVjdCB0aGF0
IGl0IGlzIGNvbnNpZGVyYWJsZS4NCg0KPiBUaGlzIGlzIHdoeSBJIHRoaW5rICItZmZyZWVzdGFu
ZGluZyIgYW5kICItZm5vLWJ1aWx0aW4tbWVtY3B5IiBhcmUNCj4gY29tcGxldGVseSBicm9rZW4g
YXMtaXM6IHRoZXkgYXJlIGFuIGFsbC1vci1ub3RoaW5nIHRoaW5nLCB0aGV5IGRvbid0DQo+IHVu
ZGVyc3RhbmQgdGhhdCBpdCdzIGRpcmVjdGlvbmFsLg0KDQpZZXAsIGFuZCBzb21lIG9mIHRoZSBj
b252ZXJzaW9ucyBhcmUgYSBqdXN0IGEgUElUQS4NCmVnIHByaW50ZigiJXMiLCBzdHJpbmcpID0+
IHB1dHMoc3RyaW5nKS4NCg0KSSB3YXMgYWxzbyB0cnlpbmcgdG8gZ2V0IGFyb3VuZCB0aGUgbWVt
Y3B5QEdMSUJDNCBmdWJhciBzbyBJIGNvdWxkDQpjb21waWxlIGNvZGUgdGhhdCB3b3VsZCBydW4g
b24gYW4gb2xkIHN5c3RlbS4NCkkgbWFuYWdlZCBldmVyeXRoaW5nIGV4Y2VwdCB0aGUgbWVtY3B5
KCkgY2FsbHMgdGhhdCBnY2MgZW1pdHMgZm9yDQpzdHJ1Y3R1cmUgY29waWVzIChpdCBtaWdodCBl
dmVuIGRvIHRoYXQgZXZlbiBmb3IgJ2ZyZWVzdGFuZGluZycpLg0KSXQgcmVhbGx5IG91Z2h0IHRv
IGVtaXQgYSBjYWxsIHRvIGEgZGlmZmVyZW50IHN5bWJvbCB0aGF0IHdvdWxkIG5vcm1hbGx5DQpi
ZSBhbGlhc2VkIHRvIG1lbWNweSgpIChvciBiZXR0ZXIgYSBtZW1jcHlfd29yZHMoKSBmdW5jdGlv
bikuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

