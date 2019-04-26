Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF6FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00BA206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfDZLAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:00:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59456 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbfDZLAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:00:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-134-EeXaVSXZND2Xqi96RvPx-Q-1; Fri, 26 Apr 2019 12:00:02 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 26 Apr 2019 12:00:01 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 26 Apr 2019 12:00:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kirill Smelkov' <kirr@nexedi.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Yongzhi Pan" <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for
 stream-like files so that read and write can run simultaneously without
 deadlock
Thread-Topic: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for
 stream-like files so that read and write can run simultaneously without
 deadlock
Thread-Index: AQHU+sv1fO+IA011LUiCdkMgFh110KZMozvQgAFedgCAAELwAA==
Date:   Fri, 26 Apr 2019 11:00:01 +0000
Message-ID: <073e5def9e654a1d80cdd79cdcf23361@AcuMS.aculab.com>
References: <20190424143341.27665-1-sashal@kernel.org>
 <20190424143341.27665-59-sashal@kernel.org>
 <20190424163415.GB21413@kroah.com>
 <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
 <20190424171926.GA17719@sasha-vm>
 <CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com>
 <20190424183012.GB3798@deco.navytux.spb.ru>
 <4d366f81f90442cb9da7ad393680d004@AcuMS.aculab.com>
 <20190426074522.GA16247@deco.navytux.spb.ru>
In-Reply-To: <20190426074522.GA16247@deco.navytux.spb.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: EeXaVSXZND2Xqi96RvPx-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2lyaWxsIFNtZWxrb3YNCj4gU2VudDogMjYgQXByaWwgMjAxOSAwODo0Ng0KLi4uDQo+
IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgeW91ciBjb21tZW50IGNvbXBsZXRlbHksIGJ1dCB3
ZSBjb252ZXJ0IHRvDQo+IHN0cmVhbV9vcGVuIG9ubHkgZHJpdmVycyB0aGF0IGFjdHVhbGx5IGRv
IF9ub3RfIHVzZSBwb3NpdGlvbiBhdCBhbGwsIGFuZA0KPiB0aGF0IHdlcmUgYWxyZWFkeSB1c2lu
ZyBub25zZWVrYWJsZV9vcGVuLCB0aHVzIHByZWFkIGFuZCBwd3JpdGUgd2VyZQ0KPiBhbHJlYWR5
IHJldHVybmluZyAtRVNQSVBFIGZvciB0aGVtIChub25zZWVrYWJsZV9vcGVuIGNsZWFycw0KPiBG
TU9ERV97UFJFQUQsUFdSSVRFfSBhbmQga3N5c197cHJlYWQscHdyaXRlfTY0IGNoZWNrIGZvciB0
aGF0IGZsYWcpLiBXZQ0KPiBhbHNvIGNvbnZlcnQgb25seSBkcml2ZXJzIHRoYXQgdXNlIG5vX2xs
c2VlayBmb3IgLmxsc2Vlaywgc28gbHNlZWsNCj4gb24gdGhvc2UgZmlsZXMgaXMvd2FzIGFsd2F5
cyByZXR1cm5pbmcgLUVTUElQRSBhcyB3ZWxsLg0KPiANCj4gSWYgYSBkcml2ZXIgdXNlcyBwb3Np
dGlvbiBpbiBpdHMgcmVhZCBhbmQgd3JpdGUgYW5kIGhhcyBzdXBwb3J0IGZvcg0KPiBwcmVhZC9w
d3JpdGUgKEZNT0RFX1BSRUFEIGFuZCBGTU9ERV9QV1JJVEUpLCBwcmVhZCBhbmQgcHdyaXRlIGFy
ZQ0KPiBhbHJlYWR5IHdvcmtpbmcgX3dpdGhvdXRfIGZpbGUtPmZfcG9zIGxvY2tpbmcgLSBiZWNh
dXNlIHRob3NlIHN5c3RlbQ0KPiBjYWxscyBkbyBub3Qgc2VtYW50aWNhbGx5IHVwZGF0ZSBmaWxl
LT5mX3BvcyBhdCBhbGwgYW5kIHRodXMgZG8gbm90IHRha2UNCj4gZmlsZS0+Zl9wb3NfbG9jayAt
IGkuZS4gcHJlYWQvcHdyaXRlIGNhbiBiZSBydW4gc2ltdWx0YW5lb3VzbHkgYWxyZWFkeS4NCg0K
TG9va3MgbGlrZSBJIGtuZXcgdGhhdCBvbmNlIDotKQ0KTWluZCB5b3UsICdtYW4gcHJlYWQnIG9u
IG15IHN5c3RlbSBpcyBzb21ld2hhdCB1bmluZm9ybWF0aXZlLg0KDQpNYXliZSBwcmVhZCgpIHNo
b3VsZCBhbHdheXMgYmUgYWxsb3dlZCBhdCBvZmZzZXQgMC4NClRoZW4geW91IHdvdWxkbid0IG5l
ZWQgYWxsIHRoaXMgZXh0cmEgbG9naWMuDQoNCj4gSWYgbGliYyBpbXBsZW1lbnRzIHByZWFkIGFz
IGxzZWVrK3JlYWQgaXQgd2lsbCB3b3JrIGZvciBhIHNpbmdsZQ0KPiB1c2VyIGNhc2UgIChzaW5n
bGUgdGhyZWFkLCBvciBmZCBub3Qgc2hhcmVkIGJldHdlZW4gcHJvY2Vzc2VzKSwgYnV0IGl0DQo+
IHdpbGwgYnJlYWsgYmVjYXVzZSBvZiBsc2VlaytyZWFkIG5vbi1hdG9taWNpdHkgaWYgbXVsdGlw
bGUgcHJlYWRzIGFyZQ0KPiBzaW11bHRhbmVvdXNseSB1c2VkIGZyb20gc2V2ZXJhbCB0aHJlYWRz
LiBBbmQgYWxzbyBmb3Igc3VjaCBlbXVsYXRpb24NCj4gZm9yIG11bHRpcGxlIHVzZXJzIGNhc2Ug
dGhlcmUgaXMgYSBjaGFuY2UgZm9yIHByZWFkIHZzIHB3cml0ZSBkZWFkbG9jaywNCj4gc2luY2Ug
dGhvc2Ugc3lzdGVtIGNhbGxzIGFyZSB1c2luZyByZWFkIGFuZCB3cml0ZSBhbmQgcmVhZCBhbmQg
d3JpdGUNCj4gdGFrZSBmaWxlLT5mX3Bvc19sb2NrLg0KDQpJJ2QgYWN0dWFsbHkgcmF0aGVyIHRo
ZSBwcmVhZCgpIGZhaWxlZCB0byBjb21waWxlLg0KVGhlIGFjdHVhbCBpbXBsZW1lbnRhdGlvbiBk
aWQgMyBsc2VlaygpcyAodG8gc2F2ZSBhbmQgcmVzdG9yZSB0aGUgb2Zmc2V0KS4NCkEgdXNlciBs
ZXZlbCBlbXVsYXRpb24gY291bGQgdXN1YWxseSBnZXQgYXdheSB3aXRoIG9uZSBsc2VlaygpLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

