Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B23C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD33206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDAQ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:59:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53838 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728589AbfDAQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:59:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-82-OHAA-ULKOuyrP3FmXwJELA-1; Mon, 01 Apr 2019 17:58:58 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 1 Apr 2019 18:00:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 1 Apr 2019 18:00:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Colascione' <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: RE: [PATCH v2 0/5] pid: add pidfd_open()
Thread-Topic: [PATCH v2 0/5] pid: add pidfd_open()
Thread-Index: AQHU6Kp9h8RLcDOeZ0KwVtPeHu3B0aYnhmZQ
Date:   Mon, 1 Apr 2019 17:00:03 +0000
Message-ID: <8c53a2601a3742bbb017a2a8aca77eaf@AcuMS.aculab.com>
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
 <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com>
 <CAKOZuetovU9NawSjUfGTAwXVfnmKC9GFtmS8FxAE5Hjmzq0HHA@mail.gmail.com>
 <CAHk-=wjgENV0pT8=MjB1UVBeWCrECCNXv15AKKX7Kfg7Eak7qw@mail.gmail.com>
 <CAKOZuet2QCoW1XMpTAzXS868PhF-gh14czFn4gwE4A=oX=Yr8w@mail.gmail.com>
In-Reply-To: <CAKOZuet2QCoW1XMpTAzXS868PhF-gh14czFn4gwE4A=oX=Yr8w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: OHAA-ULKOuyrP3FmXwJELA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFuaWVsIENvbGFzY2lvbmUNCj4gU2VudDogMDEgQXByaWwgMjAxOSAxNzo0NQ0KLi4u
DQo+ID4gTm93LCBub25lIG9mIHRoaXMgd2FzIGV2ZXIgcmVhbGx5IHVzZWQuIFRoZSBwZW9wbGUg
d2hvIHdhbnRlZCBBSU8NCj4gPiB3YW50ZWQgdGhlIGJyYWluLWRhbWFnZWQgUE9TSVgga2luZCBv
ZiBBSU8sIG5vdCBzb21ldGhpbmcgY29vbCBhbmQNCj4gPiBjbGV2ZXIuIFNvIEkgc3VzcGVjdCB0
aGUgd2hvbGUgZXhpdC1zaWduYWwgdGhpbmcgd2FzIGp1c3QgdXNlZCBmb3INCj4gPiByYW5kb20g
c21hbGwgcGVyLXByb2plY3QgdGhpbmdzLg0KPiANCj4gQUlPIGlzIGEgd2hvbGUgb3RoZXIgYmFs
bCBvZiB3YXguIDotKQ0KDQpGb3IgQUlPIHlvdSBuZWVkIHRvIGdvIGJhY2sgYW5kIHRlbGwgSyZS
IHRvIHVzZSB0aGUgSU9fUUlPIHN0dWZmIGZyb20NClJTWC8xMU0gcmF0aGVyIHRoYW4gdGhlICdJ
TyBpbiBwcm9jZXNzIGNvbnRleHQnIHRoZXkgdXNlZCBmb3IgVW5peCA6LSkNCg0KVGhlbiB5b3Un
ZCBlbmQgdXAgd2l0aCB0aGUgd2luZG93cyBrZXJuZWwuLi4uLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

