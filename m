Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE528C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0120693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfDOJB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:01:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:48793 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfDOJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:01:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-227-CVLGtbTqOfaBQjKtMMmI4A-2; Mon, 15 Apr 2019 10:01:55 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 15 Apr 2019 10:03:05 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 15 Apr 2019 10:03:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paolo Bonzini' <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: optimize check for valid PAT value
Thread-Topic: [PATCH] KVM: x86: optimize check for valid PAT value
Thread-Index: AQHU74O4C+qyka3PCE+FdT/UfNmwwaY1VKDwgABM6iOAAQTVgIAGL5+AgAAdYAA=
Date:   Mon, 15 Apr 2019 09:03:05 +0000
Message-ID: <fc39847185a8423c8827b054a4b788c3@AcuMS.aculab.com>
References: <1554890126-347-1-git-send-email-pbonzini@redhat.com>
 <c2aaa028ef564c6d8bd50dbd86489115@AcuMS.aculab.com>
 <20190410145725.GB10760@linux.intel.com>
 <d737a046-86c0-427a-ce6f-9f9d5f6fb7da@redhat.com>
 <39f5588fe3394c88bcf139c820af2033@AcuMS.aculab.com>
 <1fa33c9b-eede-9214-b8af-b38d00047898@redhat.com>
In-Reply-To: <1fa33c9b-eede-9214-b8af-b38d00047898@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: CVLGtbTqOfaBQjKtMMmI4A-2
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGFvbG8gQm9uemluaQ0KPiBTZW50OiAxNSBBcHJpbCAyMDE5IDA5OjEyDQo+IE9uIDEx
LzA0LzE5IDExOjA2LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gSXQgbWF5IGJlIHBvc3NpYmxl
IHRvIGdlbmVyYXRlIHNob3J0ZXIgY29kZSB0aGF0IGV4ZWN1dGVzIGp1c3QgYXMNCj4gPiBmYXN0
IGJ5IGdlbmVyYXRpbmcgYSBzaW5nbGUgY29uc3RhbnQgYW5kIGRlcml2aW5nIHRoZSBvdGhlcnMg
ZnJvbSBpdC4NCj4gPiAtIGdlbmVyYXRlIDRzIC0gbmVlZGVkIGZpcnN0DQo+ID4gLSBzaGlmdCBy
aWdodCAyIHRvIGdldCAxcyAoaW4gcGFyYWxsZWwgd2l0aCB0aGUgeG9yKQ0KPiA+IC0gdXNlIGxl
YSB0byBnZXQgNnMgKGluIHBhcmFsbGVsIHdpdGggYW4gbGVhIHRvIGRvIHRoZSBhZGQpDQo+ID4g
LSBpbnZlcnQgdGhlIDFzIHRvIGdldCBGRXMgKGFsc28gaW4gcGFyYWxsZWwgd2l0aCB0aGUgYWRk
KQ0KPiA+IC0geG9yIHRoZSBGRXMgd2l0aCB0aGUgNnMgdG8gZ2V0IEY4cyAoaW4gcGFyYWxsZWwg
d2l0aCB0aGUgb3IpDQo+ID4gLSBhbmQvdGVzdCBmb3IgdGhlIHJlc3VsdA0KDQpUaGF0IHZlcnNp
b24gbmVlZHMgYW4gZXh0cmEgcmVnaXN0ZXIgbW92ZSBJIGhhZG4ndCBhbGxvd2VkIGZvci4NCkl0
IGlzIGFsc28gaW1wb3NzaWJsZSB0byBzdG9wIGdjYyBmb2xkaW5nIGNvbnN0YW50IGV4cHJlc3Np
b25zDQp3aXRob3V0IGFuIGFzbSBub3Agb24gYSByZWdpc3Rlci4NCg0KPiBGV0lXLCBoZXJlIGlz
IHlldCBhbm90aGVyIHdheSB0byBkbyBpdDoNCj4gDQo+IC8qIENoYW5nZSA2LzcgdG8gNC81ICov
DQo+IGRhdGEgJj0gfigoZGF0YSAmIDB4MDQwNDA0MDQwNDA0MDQwNFVMTCkgPj4gMSk7DQo+IC8q
IE9ubHkgYWxsb3cgMC8xLzQvNSBub3cgKi8NCj4gcmV0dXJuICEoZGF0YSAmIDB4RkFGQUZBRkFG
QUZBRkFGQVVMTCk7DQo+IA0KPiBtb3ZhYnMgJDB4NDA0MDQwNDA0MDQwNDA0LCAlcmN4DQo+IGFu
ZHEgICAlcmR4LCAlcmN4DQo+IHNocnEgICAlcmN4DQo+IG5vdHEgICAlcmN4DQo+IG1vdmFicyAk
MHhGQUZBRkFGQUZBRkFGQSwgJXJheA0KPiBhbmRxICAgJXJjeCwgJXJkeA0KPiB0ZXN0ICAgJXJh
eCwgJXJkeA0KDQpGZXdlciBvcGNvZGUgYnl0ZXMsIGJ1dCA1IGRlcGVuZGFudCBpbnN0cnVjdGlv
bnMNCihhc3N1bWluZyB0aGUgZmlyc3QgY29uc3RhbnQgY2FuIGV4ZWN1dGVkIGluIHBhcmFsbGVs
DQp3aXRoIGFuIGVhcmxpZXIgaW5zdHJ1Y3Rpb24pLg0KSSB0aGluayBteSBvbmUgd2FzIG9ubHkg
NCBkZXBlbmRhbnQgaW5zdHJ1Y3Rpb25zLg0KDQpBbGwgdGhlc2UgYXJlIGZhciBmYXN0ZXIgdGhh
biB0aGUgbG9vcC4uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

