Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FFEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B3720811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfDYLdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:33:23 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57755 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfDYLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:33:22 -0400
Received: by ajax-webmail-mail (Coremail) ; Thu, 25 Apr 2019 19:32:59 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [222.210.139.220]
Date:   Thu, 25 Apr 2019 19:32:59 +0800 (GMT+08:00)
From:   huangpei@loongson.cn
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Paul Burton" <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Huacai Chen" <chenhc@lemote.com>
Subject: Re: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb()
 wreckage
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <20190425073348.GV11158@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: +hpso2Zvb3Rlcl90eHQ9MzY1Mjo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5b13fd3b.c031.16a54452744.Coremail.huangpei@loongson.cn>
X-CM-TRANSID: QMiowPDx77_rmsFcubnJAA--.7732W
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/1tbiAQALAVEBqdXJaAACsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIlBldGVyIFppamxz
dHJhIiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAxOS0wNC0yNSAx
NTozMzo0OCAo5pif5pyf5ZubKQ0KPiDmlLbku7bkuro6IGh1YW5ncGVpQGxvb25nc29uLmNuDQo+
IOaKhOmAgTogIlBhdWwgQnVydG9uIiA8cGF1bC5idXJ0b25AbWlwcy5jb20+LCAic3Rlcm5Acm93
bGFuZC5oYXJ2YXJkLmVkdSIgPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+LCAiYWtpeWtzQGdt
YWlsLmNvbSIgPGFraXlrc0BnbWFpbC5jb20+LCAiYW5kcmVhLnBhcnJpQGFtYXJ1bGFzb2x1dGlv
bnMuY29tIiA8YW5kcmVhLnBhcnJpQGFtYXJ1bGFzb2x1dGlvbnMuY29tPiwgImJvcXVuLmZlbmdA
Z21haWwuY29tIiA8Ym9xdW4uZmVuZ0BnbWFpbC5jb20+LCAiZGx1c3RpZ0BudmlkaWEuY29tIiA8
ZGx1c3RpZ0BudmlkaWEuY29tPiwgImRob3dlbGxzQHJlZGhhdC5jb20iIDxkaG93ZWxsc0ByZWRo
YXQuY29tPiwgImouYWxnbGF2ZUB1Y2wuYWMudWsiIDxqLmFsZ2xhdmVAdWNsLmFjLnVrPiwgImx1
Yy5tYXJhbmdldEBpbnJpYS5mciIgPGx1Yy5tYXJhbmdldEBpbnJpYS5mcj4sICJucGlnZ2luQGdt
YWlsLmNvbSIgPG5waWdnaW5AZ21haWwuY29tPiwgInBhdWxtY2tAbGludXguaWJtLmNvbSIgPHBh
dWxtY2tAbGludXguaWJtLmNvbT4sICJ3aWxsLmRlYWNvbkBhcm0uY29tIiA8d2lsbC5kZWFjb25A
YXJtLmNvbT4sICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz4sICJ0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZyIgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiwgIkh1YWNhaSBDaGVuIiA8Y2hlbmhjQGxlbW90ZS5jb20+
DQo+IOS4u+mimDogUmU6IFJlOiBbUkZDXVtQQVRDSCAyLzVdIG1pcHMvYXRvbWljOiBGaXggbG9v
bmdzb25fbGxzY19tYigpIHdyZWNrYWdlDQo+IA0KPiANCj4gQTogQmVjYXVzZSBpdCBtZXNzZXMg
dXAgdGhlIG9yZGVyIGluIHdoaWNoIHBlb3BsZSBub3JtYWxseSByZWFkIHRleHQuDQo+IFE6IFdo
eSBpcyB0b3AtcG9zdGluZyBzdWNoIGEgYmFkIHRoaW5nPw0KPiBBOiBUb3AtcG9zdGluZy4NCj4g
UTogV2hhdCBpcyB0aGUgbW9zdCBhbm5veWluZyB0aGluZyBpbiBlLW1haWw/DQo+IA0KPiBPbiBU
aHUsIEFwciAyNSwgMjAxOSBhdCAxMjo1ODo1MFBNICswODAwLCBodWFuZ3BlaUBsb29uZ3Nvbi5j
biB3cm90ZToNCj4gPiBJbiBteSBvcGluaW9uLiBwYXRjaCAyLzMgaXMgYWJvdXQgTG9vbmdzb24n
cyBidWcsIGFuZCBwYXRjaCA0LzUgaXMgYW5vdGhlciB0aGVtZS4NCj4gDQo+IEFncmVlZDsgaXQn
cyBqdXN0IHRoYXQgbG9va2luZyBhdCB0aGUgTUlQUyBjb2RlIHRvIGZpeCA0LzUgbWFkZSBtZSB0
cmlwDQo+IG92ZXIgdGhpcyBzdHVmZi4NCj4gDQo+ID4gTGV0IG1lIGV4cGxhaW4gdGhlIGJ1ZyBt
b3JlIHNwZWNpZmljOg0KPiA+IA0KPiA+IHRoZSBidWcgT05MWSBtYXR0ZXJzIGluIGZvbGxvd2lu
ZyBzaXR1YXRpb246DQo+ID4gDQo+ID4gIy4gbW9yZSB0aGFuIG9uZSBjcHUgKGFzc3VtZSBjcHUg
QSBhbmQgQikgZG9pbmcgbGwvc2Mgb24gc2FtZSBzaGFyZWQNCj4gPiB2YXIgVg0KPiA+IA0KPiA+
ICMuIHNwZWN1bGF0aXZlIG1lbW9yeSBhY2Nlc3MgZnJvbSBBIGNhdXNlIEEgZXJyb25lb3VzbHkg
c3VjY2VlZCBzYw0KPiA+IG9wZXJhdGlvbiwgc2luY2UgdGhlIGVycm9uZW91c2x5IHN1Y2Nlc3Nm
dWwgc2Mgb3BlcmF0aW9uIHZpb2xhdGUgdGhlDQo+ID4gY29oZXJlbmNlIHByb3RvY29sLiAoaGVy
ZSBjb2hlcmVuY2UgcHJvdG9jb2wgbWVhbnMgdGhlIHJ1bGVzIHRoYXQgQ1BVDQo+ID4gZm9sbG93
IHRvIGltcGxlbWVudCBsbC9zYyByaWdodCkNCj4gPiANCj4gPiAjLiBCIHN1Y2NlZWQgc2Mgb3Bl
cmF0aW9uIHRvbywgYnV0IHRoaXMgc2Mgb3BlcmF0aW9uIGlzIHJpZ2h0IGJvdGgNCj4gPiBsb2dp
Y2FsbHkgYW5kIGZvbGxvdyB0aGUgY29oZXJlbmNlIHByb3RvY29sLCBhbmQgbWFrZXMgQSdzIHNj
IHdyb25nDQo+ID4gbG9naWNhbGx5IHNpbmNlIG9ubHkgT05FIHNjIG9wZXJhdGlvbiBjYW4gc3Vj
Y2VlZC4NCj4gDQo+IChJIGtub3cgeW91ciBjb2hlcmVuY2UgcHJvdG9jb2wgaXMgcHJvYmFibHkg
bW9yZSBjb21wbGljYXRlZCB0aGFuIE1FU0ksDQo+IGJ1dCBiZWFyIHdpdGggbWUpDQoNCm91ciBj
b2hlcmVudGNlIHByb3RvY2FsIGlzIHNpbXBsZXIgdGhhbiBNRVNJLg0KPiANCj4gU28gQSBzcGVj
dWxhdGl2ZWx5IGdldHMgVidzIGxpbmUgaW4gRXhjbHVzaXZlIG1vZGUsIHNwZWN1bGF0ZXMgdGhl
IExvY2sNCj4gZmxhZyBpcyBzdGlsbCB0aGVyZSBhbmQgY29tcGxldGVzIHRoZSBTdG9yZS4gVGhp
cyBzcGVjdWxhdGl2ZSBzdG9yZSB0aGVuDQo+IGxlYWtzIG91dCBhbmQgdmlvbGF0ZXMgTUVTSSBi
ZWNhdXNlIHRoZXJlIF9zaG91bGRfIG9ubHkgYmUgb25lIEV4Y2x1c2l2ZQ0KPiBvd25lciBvZiBh
IGxpbmUgKEIpLg0KPiANCj4gU29tZXRoaW5nIGxpa2UgdGhhdD8NCg0KWWVzDQoNCj4gDQo+ID4g
SWYgaXQgaXMgbm90IExML1NDIGJ1dCBvdGhlciBtZW1vcnkgYWNjZXNzIGZyb20gQiBvbiBWLCBB
J3MgbGwvc2MgY2FuDQo+ID4gZm9sbG93IHRoZSBhdG9taWMgc2VtYW50aWNzIGV2ZW4gaWYgQSB2
aW9sYXRlIHRoZSBjb2hlcmVuY2UgcHJvdG9jb2wNCj4gPiBpbiB0aGUgc2FtZSBzaXR1YXRpb24u
DQo+IA0KPiAqc2h1ZGRlciouLi4NCj4gDQo+ICAgQyBhdG9taWMtc2V0DQo+IA0KPiAgIHsNCj4g
CSAgYXRvbWljX3NldCh2LCAxKTsNCj4gICB9DQoNCg0KPiANCj4gICBQMShhdG9taWNfdCAqdikN
Cj4gICB7DQo+IAkgIGF0b21pY19hZGRfdW5sZXNzKHYsIDEsIDApOw0KPiAgIH0NCj4gDQo+ICAg
UDIoYXRvbWljX3QgKnYpDQo+ICAgew0KPiAJICBhdG9taWNfc2V0KHYsIDApOw0KPiAgIH0NCj4g
DQo+ICAgZXhpc3RzDQo+ICAgKHY9MikNCj4gDQo+IFNvIHRoYXQgb25lIHdpbGwgc3RpbGwgd29y
az8gKHRoYXQgaXMsIHY9MiBpcyBmb3JiaWRkZW4pDQoNCnlvdSBtZWFuIEPvvIxQMSwgUDIgb24g
MyBkaWZmZXJlbnQgQ1BVPyBJIGRvIG5vdCBrbm93IG11Y2ggYWJvdXQgTEtNTSwgY2FuIGV4cGxh
aW4gdGhlIHRlc3QgY2FzZSBtb3JlIGV4cGxpY2l0Pw0KDQo+IA0KPiA+IEluIG9uZSB3b3Jk77yM
IHRoZSBidWcgb25seSBhZmZlY3QgbG9jYWwgY3B14oCYcyBsbC9zYyBvcGVyYXRpb24sIGFuZA0K
PiA+IGFmZmVjdCBNUCBzeXN0ZW0uDQo+IA0KPiBCZWNhdXNlIGl0IGlzIGEgY29oZXJlbmNlIGlz
c3VlLCB0cmlnZ2VyZWQgYnkgYSByZW9yZGVyLiBPSy4NCg0KTm90IGV4YWN0bHksIGl0IGlzIGEg
bGwvc2MgaXNzdWUsIHRyaWdnZXJlZCBieSBzcGVjdWxhdGl2ZSBtZW1vcnkgYWNjZXNzIGZyb20g
bG9jYWwgY3B1DQogYmFzZWQgb24gd2hhdCBJIHdhcyB0b2xkLg0KPiANCj4gPiBQUzoNCj4gPiAN
Cj4gPiBJZiBsb2NhbF90IGlzIG9ubHkgbGwvc2MgbWFuaXB1bGF0ZWQgYnkgY3VycmVudCBDUFXv
vIwgdGhlbiBubyBuZWVkIGZpeCBpdC4NCj4gDQo+IEl0IF9zaG91bGRfIGJlIENQVSBsb2NhbCwg
YnV0IHRoaXMgd2FzIG5vdCBhdCBhbGwgY2xlYXIgZnJvbSByZWFkaW5nIHRoZQ0KPiBvcmlnaW5h
bCBjaGFuZ2Vsb2cgbm9yIHRoZSBjb21tZW50IHdpdGggbG9vbmdzb25fbGxzY19tYigpLg0KDQoN
CuWMl+S6rOW4gua1t+a3gOWMuuS4reWFs+adkeeOr+S/neenkeaKgOekuuiMg+Wbrem+meiKr+S6
p+S4muWbrTLlj7fmpbwgMTAwMDk155S16K+dOiArODYgKDEwKSA2MjU0NjY2OOS8oOecnzogKzg2
ICgxMCkgNjI2MDA4MjZ3d3cubG9vbmdzb24uY27mnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInp
vpnoiq/kuK3np5HmioDmnK/mnInpmZDlhazlj7jnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4Xp
mZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILn
poHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3p
mZDkuo7lhajpg6jmiJbpg6gg5YiG5Zyw5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu
5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM
6K+35oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu
5Lu244CCIA0KDQpUaGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRl
bnRpYWwgaW5mb3JtYXRpb24gZnJvbSBMb29uZ3Nvbg0KVGVjaG5vbG9neSBDb3Jwb3JhdGlvbiBM
aW1pdGVkLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eQ0K
d2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9u
IGNvbnRhaW5lZCBoZXJlaW4gaW4NCmFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVk
IHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsDQpyZXByb2R1Y3Rpb24gb3IgZGlzc2Vt
aW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykN
CmlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFz
ZSBub3RpZnkgdGhlIHNlbmRlciBieQ0KcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRl
bGV0ZSBpdC4g
