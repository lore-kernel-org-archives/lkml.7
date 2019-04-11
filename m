Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C403C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E2520850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDKJFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:05:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:35345 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbfDKJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:05:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-155-aE9HNz44M0CEXlc5xVJdDg-1; Thu, 11 Apr 2019 10:05:28 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 11 Apr 2019 10:06:37 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 11 Apr 2019 10:06:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paolo Bonzini' <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: optimize check for valid PAT value
Thread-Topic: [PATCH] KVM: x86: optimize check for valid PAT value
Thread-Index: AQHU74O4C+qyka3PCE+FdT/UfNmwwaY1VKDwgABM6iOAAQTVgA==
Date:   Thu, 11 Apr 2019 09:06:37 +0000
Message-ID: <39f5588fe3394c88bcf139c820af2033@AcuMS.aculab.com>
References: <1554890126-347-1-git-send-email-pbonzini@redhat.com>
 <c2aaa028ef564c6d8bd50dbd86489115@AcuMS.aculab.com>
 <20190410145725.GB10760@linux.intel.com>
 <d737a046-86c0-427a-ce6f-9f9d5f6fb7da@redhat.com>
In-Reply-To: <d737a046-86c0-427a-ce6f-9f9d5f6fb7da@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: aE9HNz44M0CEXlc5xVJdDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGFvbG8gQm9uemluaQ0KPiBTZW50OiAxMCBBcHJpbCAyMDE5IDE4OjA5DQo+IE9uIDEw
LzA0LzE5IDE2OjU3LCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPiA+IE9uIFdlZCwgQXBy
IDEwLCAyMDE5IGF0IDEyOjU1OjUzUE0gKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPj4g
RnJvbTogUGFvbG8gQm9uemluaQ0KPiA+Pj4gU2VudDogMTAgQXByaWwgMjAxOSAxMDo1NQ0KPiA+
Pj4NCj4gPj4+IFRoaXMgY2hlY2sgd2lsbCBzb29uIGJlIGRvbmUgb24gZXZlcnkgbmVzdGVkIHZt
ZW50cnkgYW5kIHZtZXhpdCwNCj4gPj4+ICJwYXJhbGxlbGl6ZSIgaXQgdXNpbmcgYml0d2lzZSBv
cGVyYXRpb25zLg0KLi4uDQo+ID4+IEhvdyBhYm91dDoNCj4gPj4gCS8qDQo+ID4+IAkgKiBFYWNo
IGJ5dGUgbXVzdCBiZSAwLCAxLCA0LCA1LCA2IG9yIDcuDQo+ID4+IAkgKiBDb252ZXJ0IDAwMXgg
dG8gMDExeCB0aGVuIDEwMHggc28gMiBhbmQgMyBmYWlsIHRoZSB0ZXN0Lg0KPiA+PiAJICovDQo+
ID4+IAlkYXRhIHw9IChkYXRhIF4gMHgwNDA0MDQwNDA0MDQwNDA0VUxMKSkgKyAweDAyMDIwMjAy
MDIwMjAyMDJVTEw7DQo+ID4+IAlpZiAoZGF0YSAmIDB4RjhGOEY4RjhGOEY4RjhGOFVMTCkNCj4g
Pj4gCQlyZXR1cm4gZmFsc2U7DQouLi4NCj4gPiBSZWFsbHkgZmFuY3k6DQo+ID4gICAgMHgwMDAw
MDAwMDAwMDQ4NDQ3IDwrMjQ3PjogICBtb3ZhYnMgJDB4NDA0MDQwNDA0MDQwNDA0LCVyY3gNCj4g
PiAgICAweDAwMDAwMDAwMDAwNDg0NTEgPCsyNTc+OiAgIG1vdmFicyAkMHgyMDIwMjAyMDIwMjAy
MDIsJXJheA0KPiA+ICAgIDB4MDAwMDAwMDAwMDA0ODQ1YiA8KzI2Nz46ICAgeG9yICAgICVyZHgs
JXJjeA0KPiA+ICAgIDB4MDAwMDAwMDAwMDA0ODQ1ZSA8KzI3MD46ICAgYWRkICAgICVyYXgsJXJj
eA0KPiA+ICAgIDB4MDAwMDAwMDAwMDA0ODQ2MSA8KzI3Mz46ICAgbW92YWJzICQweGY4ZjhmOGY4
ZjhmOGY4ZjgsJXJheA0KPiA+ICAgIDB4MDAwMDAwMDAwMDA0ODQ2YiA8KzI4Mz46ICAgb3IgICAg
ICVyY3gsJXJkeA0KPiA+ICAgIDB4MDAwMDAwMDAwMDA0ODQ2ZSA8KzI4Nj46ICAgdGVzdCAgICVy
YXgsJXJkeA0KPiA+ICAgIDB4MDAwMDAwMDAwMDA0ODQ3MSA8KzI4OT46ICAgc2V0ZSAgICVhbA0K
PiA+ICAgIDB4MDAwMDAwMDAwMDA0ODQ3NCA8KzI5Mj46ICAgcmV0cQ0KPiANCj4gWWVhaCwgdGhl
IHRocmVlIGNvbnN0YW50cyBhcmUgZXhwZW5zaXZlLiAgVG9vIGJhZCB0aGUgcmVhbGx5IGZhbmN5
DQo+IHZlcnNpb24gc3VtcyB0d29zIGFuZCB4b3JzIGZvdXJzOyBpZiBpdCB3ZXJlIHRoZSBvcHBv
c2l0ZSwgaXQgY291bGQgaGF2ZQ0KPiB1c2VkIGxlYSBhbmQgdGhlbiBJIHdvdWxkIGhhdmUgY2hv
c2VuIHRoYXQgb25lIGp1c3QgZm9yIHRoZSBjb29sbmVzcyBmYWN0b3IuDQoNClRoZSBjb25zdGFu
dHMgYXJlIGp1c3QgYmlnLCBpZiB0aGUgY29kZSBpcyBpbmxpbmVkIHRoZXkgYXJlIHByb2JhYmx5
DQpvdGhlcndpc2UgZnJlZSAodGhleSB3b24ndCBjaGFuZ2UgdGhlIGxlbmd0aCBvZiB0aGUgZGVw
ZW5kZW5jeSBjaGFpbikuDQpUaGUgdHdvcyBjYW4gYmUgZ2VuZXJhdGVkIGZyb20gdGhlIGZvdXJz
IHdpdGhvdXQgaW5jcmVhc2luZyB0aGUgbGVuZ3RoDQpvZiB0aGUgZGVwZW5kZW5jeSBjaGFpbiBh
bmQgc2F2aW5nIHNvbWUgYnl0ZXMuDQoNCkl0IG1heSBiZSBwb3NzaWJsZSB0byBnZW5lcmF0ZSBz
aG9ydGVyIGNvZGUgdGhhdCBleGVjdXRlcyBqdXN0IGFzDQpmYXN0IGJ5IGdlbmVyYXRpbmcgYSBz
aW5nbGUgY29uc3RhbnQgYW5kIGRlcml2aW5nIHRoZSBvdGhlcnMgZnJvbSBpdC4NCi0gZ2VuZXJh
dGUgNHMgLSBuZWVkZWQgZmlyc3QNCi0gc2hpZnQgcmlnaHQgMiB0byBnZXQgMXMgKGluIHBhcmFs
bGVsIHdpdGggdGhlIHhvcikNCi0gdXNlIGxlYSB0byBnZXQgNnMgKGluIHBhcmFsbGVsIHdpdGgg
YW4gbGVhIHRvIGRvIHRoZSBhZGQpDQotIGludmVydCB0aGUgMXMgdG8gZ2V0IEZFcyAoYWxzbyBp
biBwYXJhbGxlbCB3aXRoIHRoZSBhZGQpDQotIHhvciB0aGUgRkVzIHdpdGggdGhlIDZzIHRvIGdl
dCBGOHMgKGluIHBhcmFsbGVsIHdpdGggdGhlIG9yKQ0KLSBhbmQvdGVzdCBmb3IgdGhlIHJlc3Vs
dA0KSSdtIG5vdCBnb2luZyB0byB0cnkgdG8gcGVyc3VhZGUgZ2NjIHRvIGdvIHRoYXQuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

