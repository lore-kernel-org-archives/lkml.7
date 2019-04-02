Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FDDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E6420857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfDBKKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:10:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:57958 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729993AbfDBKKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:10:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-15-hrdr5yCxOYS4hEWZbV34XA-1; Tue, 02 Apr 2019 11:10:25 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 2 Apr 2019 11:11:31 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 2 Apr 2019 11:11:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'NeilBrown' <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Thread-Topic: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Thread-Index: AQHU6N/+KEMHzUp83kSbBGni6HHGjKYoprDg
Date:   Tue, 2 Apr 2019 10:11:31 +0000
Message-ID: <87470518ac3f4ab28918917401b9313b@AcuMS.aculab.com>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
 <155416006521.9540.5662092375167065834.stgit@noble.brown>
In-Reply-To: <155416006521.9540.5662092375167065834.stgit@noble.brown>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: hrdr5yCxOYS4hEWZbV34XA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmVpbEJyb3duDQo+IFNlbnQ6IDAyIEFwcmlsIDIwMTkgMDA6MDgNCj4gDQo+IFRoaXMg
cGF0Y2ggY2hhbmdlcyByaGFzaHRhYmxlcyB0byB1c2UgYSBiaXRfc3Bpbl9sb2NrIG9uIEJJVCgx
KSBvZiB0aGUNCj4gYnVja2V0IHBvaW50ZXIgdG8gbG9jayB0aGUgaGFzaCBjaGFpbiBmb3IgdGhh
dCBidWNrZXQuDQouLi4NCj4gVG8gZW5oYW5jZSB0eXBlIGNoZWNraW5nLCBhIG5ldyBzdHJ1Y3Qg
aXMgaW50cm9kdWNlZCB0byByZXByZXNlbnQgdGhlDQo+ICAgcG9pbnRlciBwbHVzIGxvY2stYml0
DQo+IHRoYXQgaXMgc3RvcmVkIGluIHRoZSBidWNrZXQtdGFibGUuICBUaGlzIGlzICJzdHJ1Y3Qg
cmhhc2hfbG9ja19oZWFkIg0KPiBhbmQgaXMgZW1wdHkuICBBIHBvaW50ZXIgdG8gdGhpcyBuZWVk
cyB0byBiZSBjYXN0IHRvIGVpdGhlciBhbg0KPiB1bnNpZ25lZCBsb2NrLCBvciBhICJzdHJ1Y3Qg
cmhhc2hfaGVhZCAqIiB0byBiZSB1c2VmdWwuDQo+IFZhcmlhYmxlcyBvZiB0aGlzIHR5cGUgYXJl
IG1vc3Qgb2Z0ZW4gY2FsbGVkICJia3QiLg0KDQpEaWQgeW91IHRyeSB1c2luZyBhIHVuaW9uIG9m
IHRoZSBwb2ludGVyIGFuZCBhbiAndW5zaWduZWQgbG9uZycgPw0KU2hvdWxkIHJlbW92ZSBhIGxv
dCBvZiB0aGUgY2FzdHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

