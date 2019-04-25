Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D635C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A00218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfDYKD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:03:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39692 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbfDYKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:03:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-192-rYyFcLadNtKyKkvGMCUC0w-1; Thu, 25 Apr 2019 11:03:22 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 25 Apr 2019 11:04:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 25 Apr 2019 11:04:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kirill Smelkov' <kirr@nexedi.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHU+sv1fO+IA011LUiCdkMgFh110KZMozvQ
Date:   Thu, 25 Apr 2019 10:04:34 +0000
Message-ID: <4d366f81f90442cb9da7ad393680d004@AcuMS.aculab.com>
References: <20190424143341.27665-1-sashal@kernel.org>
 <20190424143341.27665-59-sashal@kernel.org>
 <20190424163415.GB21413@kroah.com>
 <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
 <20190424171926.GA17719@sasha-vm>
 <CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com>
 <20190424183012.GB3798@deco.navytux.spb.ru>
In-Reply-To: <20190424183012.GB3798@deco.navytux.spb.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: rYyFcLadNtKyKkvGMCUC0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2lyaWxsIFNtZWxrb3YNCj4gU2VudDogMjQgQXByaWwgMjAxOSAxOTozMA0KPiANCj4g
T24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgMTA6MjY6NTVBTSAtMDcwMCwgTGludXMgVG9ydmFsZHMg
d3JvdGU6DQo+ID4gT24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgMTA6MTkgQU0gU2FzaGEgTGV2aW4g
PHNhc2hhbEBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIbSwgSSBtaWdodCBiZSBj
b25mdXNpbmcgc29tZXRoaW5nIGhlcmUgYnV0IEkgc2VlIGEgYnVuY2ggb2YgcGF0Y2hlcw0KPiA+
ID4gdGhhdCBjb252ZXJ0IGV4aXN0aW5nIGNhbGxlcnMgbWVudGlvbmVkIGluIHRoaXMgcGF0Y2gg
dG8gdXNlDQo+ID4gPiBzdHJlYW1fb3BlbigpIHdoaWNoIHdhcyBpbnRyb2R1Y2VkIGhlcmUuDQo+
ID4NCj4gPiBUaGUgb25seSB1c2Ugb2Ygc3RyZWFtX29wZW4oKSB1cHN0cmVhbSByaWdodCBub3cg
aXMgdGhlIHhlbmJ1cw0KPiA+IGNvbnZlcnNpb24sIGFuZCB0aGF0IGlzbid0IGFjdHVhbGx5IGEg
YnVnZml4LCBiZWNhdXNlIHhlbmJ1cyB1c2VkIHRvDQo+ID4gbWFudWFsbHkgZG8gdGhhdA0KPiA+
DQo+ID4gICAgICAgICBmaWxwLT5mX21vZGUgJj0gfkZNT0RFX0FUT01JQ19QT1M7IC8qIGNkZXYt
c3R5bGUgc2VtYW50aWNzICovDQo+ID4NCj4gPiB0aGF0IHN0cmVhbV9vcGVuKCkgZG9lcy4NCj4g
Pg0KPiA+IFNvIG5vLCB0aGVyZSBpc24ndCAiYSBidW5jaCBvZiBwYXRjaGVzIiBhbnl3aGVyZS4N
Cj4gPg0KPiA+IFRoZXJlIGFyZSAqZnV0dXJlKiBjbGVhbnVwcyBmb3IgNS4yIHRoYXQgd2lsbCBo
YXBwZW4sIGFuZCB0aGF0IG1pZ2h0DQo+ID4gaGF2ZSBoaXQgbGludXgtbmV4dC4gQW5kIHRoZXJl
IGlzIGF0IGxlYXN0IG9uZSBGVVNFIHBhdGNoIChhZ2FpbiAtDQo+ID4gcGVuZGluZywgbm90IHVw
c3RyZWFtKSB0aGF0IG1heSBnZXQgbWFya2VkIGZvciBzdGFibGUuDQo+ID4NCj4gPiBCdXQgSSBz
ZWUgbm90aGluZyByaWdodCBub3cgdGhhdCBtYWtlcyBpdCBzdGFibGUgbWF0ZXJpYWwgeWV0Lg0K
PiANCj4gTGludXMsIHRoYW5rcyBmb3IgZXhwbGFpbmluZy4gU2FzaGEsIEdyZWcsIHRoZXJlIGlz
IGEgRlVTRSBwYXRjaCB0aGF0DQo+IHNob3VsZCBiZSBzdGFibGUgbWF0ZXJpYWwgdGhhdCB3aWxs
IG5lZWQgdGhpcyBzdHJlYW1fb3BlbigpIHRoaW5nLiBUaGF0DQo+IHBhdGNoIGhhcyBqdXN0IGVu
dGVyZWQgZnVzZS5naXQjZm9yLW5leHQgdG9kYXk6DQo+IA0KPiAJaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXN6ZXJlZGkvZnVzZS5naXQvY29tbWl0Lz9p
ZD1iYmQ4NGYzMzY1MmYNCj4gDQo+IGFuZCB3aWxsIGhvcGVmdWxseSBlbnRlciA1LjIgd2hlbiBt
ZXJnZSB3aW5kb3cgb3BlbnMuIEkgYWdyZWUgd2Ugc2hvdWxkDQo+IG5vdCBibGluZGx5IGJhY2tw
b3J0IGJ1bGsgc3RyZWFtX29wZW4gY29udmVyc2lvbnMgYXMgcGVyZm9ybWVkIGJ5DQo+IHN0cmVh
bV9vcGVuLmNvY2NpLCBhdCBsZWFzdCB1bmxlc3MgdGhlcmUgaXMgYSBidWcgcmVwb3J0IGluZGlj
YXRpbmcgdGhhdA0KPiBpdCBpcyBhY3R1YWxseSByZXF1aXJlZCBmb3IgYSBwYXJ0aWN1bGFyIGRy
aXZlci4gT24gdGhlIG90aGVyIGhhbmQgYm90aA0KPiBYZW4gYW5kIEZVU0UgZGVhZGxvY2tzIHdl
cmUgaGl0IGZvciByZWFsIHdoaWNoIGp1c3RpZmllcyBzdGFibGUNCj4gcHJvcGFnYXRpb24gZm9y
IHRoZWlyIGZpeGVzLg0KPiANCj4gWW91IGNhbiByZWFkIGFib3V0IHRoZSBkZWFkbG9jayByZWdy
ZXNzaW9uIGFuZCB0aGUgcGxhbiB0byBmaXggaXQgaW4NCj4gb3JpZ2luYWwgImZzOiBzdHJlYW1f
b3BlbiAtIG9wZW5lciBmb3Igc3RyZWFtLWxpa2UgZmlsZXMgc28gdGhhdCByZWFkDQo+IGFuZCB3
cml0ZSBjYW4gcnVuIHNpbXVsdGFuZW91c2x5IHdpdGhvdXQgZGVhZGxvY2siIHBhdGNoICh0aGUg
NTkvNjYNCj4gcGF0Y2ggdGhhdCB3YXMgc2VuZCBpbiB0aGlzIHRocmVhZCksIG9yIGhlcmU6DQo+
IA0KPiAJaHR0cHM6Ly9naXQua2VybmVsLm9yZy9saW51cy8xMGRjZThhZjM0MjINCj4gDQo+IA0K
PiBIb3BlIGl0IGNsYXJpZmllcyB0aGluZ3MgYSBiaXQsDQoNCkkgY2FuIGFsc28gaW1hZ2luZSBk
cml2ZXJzIHRoYXQgZXhwZWN0IGFjY2Vzc2VzIHRvIGJlIGRvbmUgdXNpbmcNCnByZWFkKCkgYW5k
IHB3cml0ZSgpIC0gbWF5YmUgb25seSBpZiB0aGUgZmQgaXMgc2hhcmVkLg0KUHJvdmlkZWQgYWNj
ZXNzZXMgZ2V0IHRoZSBjb3JyZWN0IG9mZnNldCB0aGV5IGNhbiBiZSBjb25jdXJyZW50Lg0KSW4g
ZmFjdCB0aGV5IG9ubHkgbmVlZCB0byB1cGRhdGUgdGhlIG9mZnNldCBpbiB0aGUgZmlsZSBzdHJ1
Y3R1cmUNCndoZW4gdGhleSBjb21wbGV0ZSAtIHRoZXkgbWF5IGRvIHRoaXMgYWxyZWFkeS4NCg0K
SSBrbm93IChJIHRoaW5rKSB1Y2xpYmMgaW1wbGVtZW50aW5nIHByZWFkKCkgYXMgbHNlZWsoKSAr
IHJlYWQoKQ0KY2F1c2VkIG1lIGdyaWVmIC0gYnV0IHRoYXQgbWlnaHQganVzdCBoYXZlIGJlZW4g
dGhlIGV4dHJhIHN5c3RlbQ0KY2FsbCBvdmVyaGVhZCByYXRoZXIgdGhhbiBhbnkgcHJvYmxlbXMg
d2l0aCB0aGUgb2Zmc2V0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

