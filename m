Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075E8C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D162186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfH3J4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:56:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53541 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbfH3J4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:56:42 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-130-P6GY7liWP8u9PLRWlkmegQ-1; Fri, 30 Aug 2019 10:56:39 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 30 Aug 2019 10:56:39 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Aug 2019 10:56:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: RE: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Thread-Topic: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Thread-Index: AQHVV6Op4hc1jesckEO2Njx8G6LSv6cHrBeAgAC6ywCAAHvDAIABi1YAgAAYGYCAAC0oAIAACaQAgAi0npA=
Date:   Fri, 30 Aug 2019 09:56:38 +0000
Message-ID: <0eb1d644d233432b8e62d87bd470d7d5@AcuMS.aculab.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
 <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com>
 <CAHk-=wjD5MMbAm0OkbKadzerwG3yGr9SvE7mrsCnhmiqRRdxMw@mail.gmail.com>
In-Reply-To: <CAHk-=wjD5MMbAm0OkbKadzerwG3yGr9SvE7mrsCnhmiqRRdxMw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: P6GY7liWP8u9PLRWlkmegQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgQXVndXN0IDIwMTkgMjE6NTcNCj4gT24g
U2F0LCBBdWcgMjQsIDIwMTkgYXQgMToyMiBQTSBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9y
Zz4gd3JvdGU6DQo+ID4NCj4gPiBUaGF0IG1ha2VzIHNlbnNlOiBJIG1lYXN1cmVkIDE3IHNlY29u
ZHMgcGVyIDEwMCBNQiBvZiBkYXRhLCB3aGljaCBpcyBpcw0KPiA+IDAuMTYgdXNlY3MgcGVyIGJ5
dGUuIFRoZSBpbnN0cnVjdGlvbiB1c2VkIGJ5DQo+ID4gY29weV91c2VyX2VuaGFuY2VkX2Zhc3Rf
c3RyaW5nKCkgaXMgUkVQIE1PVlNCIC0gd2hpY2ggc3VwcG9zZWRseSBnb2VzIGFzDQo+ID4gaGln
aCBhcyBjYWNoZWxpbmUgc2l6ZSBhY2Nlc3NlcyAtIGJ1dCBwZXJoYXBzIHRob3NlIGdldCBicm9r
ZW4gZG93biBmb3INCj4gPiBwaHlzaWNhbCBtZW1vcnkgdGhhdCBoYXMgbm8gZGV2aWNlIGNsYWlt
aW5nIGl0Pw0KPiANCj4gQWxsIHRoZSAicmVwIHN0cmluZyIgb3B0aW1pemF0aW9ucyBhcmUgX29u
bHlfIGRvbmUgZm9yIHJlZ3VsYXIgbWVtb3J5Lg0KDQpNb3JlIGxpa2VseSBmb3IgcGFnZXMgdGhh
dCB1c2VzIHRoZSBkYXRhIGNhY2hlLg0KSXQgb3VnaHQgdG8gYmUgcG9zc2libGUgdG8gbWFwIFBD
SWUgbWVtb3J5IHRocm91Z2ggdGhlIGRhdGEgY2FjaGUuDQpXaXRoIGNhcmUgdGhhdCB3b3VsZCBh
bGxvdyBsb25nZXIgVExQcyAoZXNwZWNpYWxseSByZWFkIFRMUCkgZm9yDQpjcHUgJ3BpbycgYnVm
ZmVyIHRyYW5zZmVycy4NCg0KPiBXaGVuIGl0IGhpdHMgYW55IElPIGFjY2Vzc2VzLCBpdCB3aWxs
IGRvIHRoZSBhY2Nlc3NlcyBhdCB0aGUgc3BlY2lmaWVkDQo+IHNpemUgKHNvICJtb3ZzYiIgd2ls
bCBkbyBpdCBhIGJ5dGUgYXQgYSB0aW1lKS4NCj4gDQo+IDAuMTYgdXNlYyBwZXIgYnl0ZSBpcyBm
YXN0ZXIgdGhhbiB0aGUgdHJhZGl0aW9uYWwgSVNBICdpbmInLCBidXQgbm90DQo+IGJ5IGEgaHVn
ZSBmYWN0b3IuDQoNClRoYXQgc3BlZWQgZGVwZW5kcyBvbiB0aGUgdGFyZ2V0LCBJSVJDIG91ciBm
cGdhIHRhcmdldCB0YWtlcyAxMjggY2xvY2tzDQphdCA2Mi41TUh6IHRvIHByb2Nlc3MgYSBQQ0ll
IHJlYWQgcmVxdWVzdC4NCk5vbmUgb2YgdGhlIGN1cnJlbnQgSW50ZWwgeDg2IGNwdXMgd2lsbCBp
c3N1ZSBtdWx0aXBsZSByZWFkIFRMUCBmcm9tDQphIHNpbmdsZSBjb3JlLCBzbyByZWFkcyBuZXZl
ciBnZXQgYW55IG92ZXJsYXBwaW5nIGFuZCBzdWZmZXIgdGhlDQpmdWxsIGxhdGVuY3kuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

