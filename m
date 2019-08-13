Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46C7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3C3206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfHMIJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:09:36 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:15328 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:09:36 -0400
IronPort-SDR: zPXjHNeTtWka6OWrCsMSK3dZl0YuvYNBSsn3UZPrHcsI2AtZp19FZMUl9wxleapPHsAs34R8KO
 oPXNxcNOeCIw3jrmCxbTLNNTupuKiLNlMl9+8T8D9Uhz2tX0e2v1h0ZgwHTAweKzsf4bDUmuI+
 GzQ6EE2g82C4AHYuGkVMQS6J1DSZRu7Oc+IXgIrCc1MJUTQpszO3yx1ZU81O5T2ey8/2D/Mlh4
 ciP2ojNKryTYpKohy4RmFKVG7tn6zDbuYPNmREjFZm9eDVAEId+JR0/ByFveNHT+j6QMEraXgE
 a+Q=
X-IronPort-AV: E=Sophos;i="5.64,380,1559548800"; 
   d="scan'208";a="42205101"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 13 Aug 2019 00:09:35 -0800
IronPort-SDR: s8i8PDGueMbmlQfnUAaS19Tsqell/mfvnFkq/xLV+c6Mvg1QS+O8rOEEed7+gWO09HiWSbEf9T
 H41h+H+DMvQltBWGAyy5HHC68McfvWqIWrDIKnBJHSESLPnAWIYfQIDhoDGG2wzF4wDLxMR0Nh
 NuouB1TujG0qBL738FEgR6nYDBUikYeOPQEJjxt68yT5R4qvZHVt8YEExDc7XZk7vZ8flbes3X
 UzijmW94hIOpzXnSpfL1C1ShCluC6JB3qD0EWxpJETOndWNv/gMrlY3RBXZpCntd+OHa9Nd3+d
 hLI=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>
CC:     "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: AW: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Topic: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Index: AQHVTrktoAw70LsxJE6oaOICoAXoo6bzWCGAgAACFoCABWNbkA==
Date:   Tue, 13 Aug 2019 08:09:29 +0000
Message-ID: <421b9738bee141648d87a5b1c1b4d4aa@SVR-IES-MBX-03.mgc.mentorg.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>
 <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
In-Reply-To: <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gSW4gdGhlb3J5LCBjaGlsZCBtYXkgaGF2ZSBzaWJsaW5ncy4gV291bGQgaXQgYmUg
cG9zc2libGUgdG8gaGF2ZSBzZXZlcmFsDQo+ID4gZGV2aWNlcyB1bmRlciB4aGNpLWhjZD8NCj4g
DQo+IEknbSBsZXNzIGludGVyZXN0ZWQgaW4gdGhlIHhoY2ktaGNkIGNhc2UgLSB3aGljaCBJIGNl
cnRhaW5seSAqaG9wZSogaXMNCj4gZml4ZWQgYWxyZWFkeT8gLSB0aGFuIGluICJpZiB0aGlzIGhh
cHBlbnMgc29tZXdoZXJlIGVsc2UiLg0KPiANCj4gU28gaWYgd2UgZG8gd2FudCB0byByZW1vdmUg
dGhlIHBhcmVudCAod2hpY2ggbWF5IGJlIGEgZ29vZCBpZGVhIHdpdGggYQ0KPiB3YXJuaW5nKSwg
YW5kIHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIGNoaWxkcmVuIGFyZSByZWFsbHkgcmVtb3Zl
ZA0KPiBmcm9tIHRoZSByZXNvdXJjZSBoaWVyYXJjaHksIHdlIHNob3VsZCBkbyBzb21ldGhpaW5n
IGxpa2UNCj4gDQo+ICAgc3RhdGljIGJvb2wgZGV0YWNoX2NoaWxkcmVuKHN0cnVjdCByZXNvdXJj
ZSAqcmVzKQ0KPiAgIHsNCj4gICAgICAgICByZXMgPSByZXMtPmNoaWxkOw0KPiAgICAgICAgIGlm
ICghcmVzKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICAgIGRvIHsN
Cj4gICAgICAgICAgICAgICAgIHJlcy0+cGFyZW50ID0gTlVMTDsNCj4gICAgICAgICAgICAgICAg
IHJlcyA9IHJlcy0+c2libGluZzsNCj4gICAgICAgICB9IHdoaWxlIChyZXMpOw0KPiAgICAgICAg
IHJldHVybiB0cnVlOw0KPiAgIH0NCj4gDQo+IGFuZCB0aGVuIHdlIGNvdWxkIHdyaXRlIHRoZSBf
X3JlbGVhc2VfcmVnaW9uKCkgd2FybmluZyBhcw0KPiANCj4gICAgICAgICAvKiBZb3Ugc2hvdWxk
IG5vdCByZWxlYXNlIGEgcmVzb3VyY2UgdGhhdCBoYXMgY2hpbGRyZW4gKi8NCj4gICAgICAgICBX
QVJOX09OX09OQ0UoZGV0YWNoX2NoaWxkcmVuKHJlcykpOw0KPiANCj4gb3Igc29tZXRoaW5nPw0K
PiANCi4uLiBhbmQgYSBjaGlsZCBtYXkgaGF2ZSBjaGlsZHJlbiB0b28gLi4uDQoNClRoZXJlIGlz
IGEgX19yZWxlYXNlX2NoaWxkX3Jlc291cmNlcyBpbiByZXNvdXJjZS5jIGFyb3VuZCBsaW5lIDI0
Mi4NCkEgYml0IG5vaXN5LCBhbmQgZG9lcyBhIHNpbWlsYXIgdGhpbmcgeW91IG91dGxpbmVkIGFi
b3ZlLg0KSSdtIHRoaW5raW5nIGFib3V0IHRvIHJlLXVzZSB0aGF0LCBidXQgd2l0aCBtb3JlIHBy
ZWNpc2Ugb3V0cHV0DQphbmQgV0FSTl9PTl9PTkNFLg0KDQpTdWdnZXN0aW9ucyBiZWZvcmUgaSBz
dGFydCB3b3JrIG9uIHRoYXQ/DQoNCkJlc3QgcmVnYXJkcw0KQ2Fyc3Rlbg0K
