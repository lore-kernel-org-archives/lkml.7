Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759C720644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfDYMvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:51:46 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59119 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDYMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:51:45 -0400
Received: by ajax-webmail-mail (Coremail) ; Thu, 25 Apr 2019 20:51:17 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [222.210.139.220]
Date:   Thu, 25 Apr 2019 20:51:17 +0800 (GMT+08:00)
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
Subject: Re: Re: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix
 loongson_llsc_mb() wreckage
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <20190425122611.GT4038@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
 <5b13fd3b.c031.16a54452744.Coremail.huangpei@loongson.cn>
 <20190425122611.GT4038@hirez.programming.kicks-ass.net>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: C5u0eWZvb3Rlcl90eHQ9MzM3Mzo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2ff11adc.c051.16a548cd90c.Coremail.huangpei@loongson.cn>
X-CM-TRANSID: QMiowPDxVuRFrcFcpMTJAA--.11166W
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/1tbiAQALAVEBqdXKNQABsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIlBldGVyIFppamxz
dHJhIiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAxOS0wNC0yNSAy
MDoyNjoxMSAo5pif5pyf5ZubKQ0KPiDmlLbku7bkuro6IGh1YW5ncGVpQGxvb25nc29uLmNuDQo+
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
DQo+IOS4u+mimDogUmU6IFJlOiBSZTogW1JGQ11bUEFUQ0ggMi81XSBtaXBzL2F0b21pYzogRml4
IGxvb25nc29uX2xsc2NfbWIoKSB3cmVja2FnZQ0KPiANCj4gT24gVGh1LCBBcHIgMjUsIDIwMTkg
YXQgMDc6MzI6NTlQTSArMDgwMCwgaHVhbmdwZWlAbG9vbmdzb24uY24gd3JvdGU6DQo+IA0KPiA+
ID4gPiBJZiBpdCBpcyBub3QgTEwvU0MgYnV0IG90aGVyIG1lbW9yeSBhY2Nlc3MgZnJvbSBCIG9u
IFYsIEEncyBsbC9zYyBjYW4NCj4gPiA+ID4gZm9sbG93IHRoZSBhdG9taWMgc2VtYW50aWNzIGV2
ZW4gaWYgQSB2aW9sYXRlIHRoZSBjb2hlcmVuY2UgcHJvdG9jb2wNCj4gPiA+ID4gaW4gdGhlIHNh
bWUgc2l0dWF0aW9uLg0KPiA+ID4gDQo+ID4gPiAqc2h1ZGRlciouLi4NCj4gPiA+IA0KPiA+ID4g
ICBDIGF0b21pYy1zZXQNCj4gPiA+IA0KPiA+ID4gICB7DQo+ID4gPiAJICBhdG9taWNfc2V0KHYs
IDEpOw0KPiA+ID4gICB9DQo+IA0KPiBUaGlzIGlzIHRoZSBpbml0aWFsIHN0YXRlLg0KPiANCj4g
PiANCj4gPiA+IA0KPiA+ID4gICBQMShhdG9taWNfdCAqdikNCj4gPiA+ICAgew0KPiA+ID4gCSAg
YXRvbWljX2FkZF91bmxlc3ModiwgMSwgMCk7DQo+ID4gPiAgIH0NCj4gPiA+IA0KPiA+ID4gICBQ
MihhdG9taWNfdCAqdikNCj4gPiA+ICAgew0KPiA+ID4gCSAgYXRvbWljX3NldCh2LCAwKTsNCj4g
PiA+ICAgfQ0KPiA+ID4gDQo+ID4gPiAgIGV4aXN0cw0KPiA+ID4gICAodj0yKQ0KPiA+ID4gDQo+
ID4gPiBTbyB0aGF0IG9uZSB3aWxsIHN0aWxsIHdvcms/ICh0aGF0IGlzLCB2PTIgaXMgZm9yYmlk
ZGVuKQ0KPiA+IA0KPiA+IHlvdSBtZWFuIEPvvIxQMSwgUDIgb24gMyBkaWZmZXJlbnQgQ1BVPyBJ
IGRvIG5vdCBrbm93IG11Y2ggYWJvdXQgTEtNTSwgY2FuIGV4cGxhaW4gdGhlIHRlc3QgY2FzZSBt
b3JlIGV4cGxpY2l0Pw0KPiANCj4gVGhlICdDJyBpcyB0aGUgbGFuZ3VhZ2UgaWRlbnRpZmllciwg
dGhlICdhdG9taWMtc2V0JyBpcyB0aGUgbGl0bXVzIG5hbWUuDQo+IA0KPiBUaGUgdW5uYW1lZCBi
bG9jayBnaXZlIHRoZSBpbml0aWFsIGNvbmRpdGlvbnMuDQo+IA0KPiBQbiBibG9ja3MgZ2l2ZSBj
b2RlIHNlcXVlbmNlcyBmb3IgQ1BVIG4NCj4gDQo+IFRoZSAnZXhpc3RzJyBjbGF1c2UgaXMgZXZh
bHVhdGVkIGFmdGVyIGFsbCBQbiBibG9ja3MgYXJlIGRvbmUuDQo+IA0KPiBUaGVyZSdzIG90aGVy
cyBpbiB0aGlzIHRocmVhZCB0aGF0IGNhbiBwb2ludCB5b3UgdG8gbWFueSBwYXBlcnMgYW5kDQo+
IHJlc291cmNlcyBvbiB0aGVzZSBsaXRtdXMgdGVzdCB0aGluZ2llcy4NCj4gDQo+IFNvIGJhc2lj
YWxseSB0aGUgaW5pdGlhbCB2YWx1ZSBvZiBAdiBpcyBzZXQgdG8gMS4NCj4gDQo+IFRoZW4gQ1BV
LTEgZG9lcyBhdG9taWNfYWRkX3VubGVzcyh2LCAxLCAwKQ0KPiAgICAgIENQVS0yIGRvZXMgYXRv
bWljX3NldCh2LCAwKQ0KPiANCj4gSWYgQ1BVMSBnb2VzIGZpcnN0LCBpdCB3aWxsIHNlZSAxLCB3
aGljaCBpcyBub3QgMCBhbmQgdGh1cyBhZGQgMSB0byAxDQo+IGFuZCBvYnRhaW5zIDIuIFRoZW4g
Q1BVMiBnb2VzIGFuZCB3cml0ZXMgMCwgc28gdGhlIGV4aXN0IGNsYXVzZSBzZWVzDQo+IHY9PTAg
YW5kIGRvZXNuJ3Qgb2JzZXJ2ZSAyLg0KPiANCj4gVGhlIG90aGVyIHdheSBhcm91bmQsIENQVS0y
IGdvZXMgZmlyc3QsIHdyaXRlcyBhIDAsIHRoZW4gQ1BVLTEgZ29lcyBhbmQNCj4gb2JzZXJ2ZXMg
dGhlIDAsIGZpbmRzIGl0IG1hdGNoZXMgMCBhbmQgZG9lc24ndCBhZGQuICBBZ2FpbiwgdGhlIGV4
aXN0DQo+IGNsYXVzZSB3aWxsIGZpbmQgMCBkb2Vzbid0IG1hdGNoIDIuDQo+IA0KPiBUaGlzIGFs
bCBnb2VzIHVuc3R1Y2sgaWYgaW50ZXJsZWF2ZWQgbGlrZToNCj4gDQo+IA0KPiAJQ1BVLTEJCQlD
UFUtMg0KPiANCj4gCQkJCXhvcgl0MCwgdDANCj4gMToJbGwJdDAsIHYNCj4gCWJlegl0MCwgMmYN
Cj4gCQkJCXN3CXQwLCB2DQo+IAlhZGQJdDAsIHQxDQo+IAlzYwl0MCwgdg0KPiAJYmVxeiB0MCwg
MWINCj4gDQo+IChzb3JyeSBpZiBJIGdvdCB0aGUgTUlQUyBhc20gd3Jvbmc7IGl0J3Mgbm90IHNv
bWV0aGluZyBJIG5vcm1hbGx5IHdyaXRlKQ0KPiANCj4gQW5kIHRoZSBzdG9yZS13b3JkIGZyb20g
Q1BVLTIgZG9lc24ndCBtYWtlIHRoZSBTQyBmcm9tIENQVS0xIGZhaWwuDQo+IA0KDQpsb29uZ3Nv
bidzIGxsc2MgYnVnIERPRVMgTk9UIGZhaWwgdGhpcyBsaXRtdXMoIHdlIHdpbGwgbm90IGdldCBW
PTIp77ybDQoNCm9ubHkgc3BlY3VsYXRpdmUgbWVtb3J5IGFjY2VzcyBmcm9tIENQVS0xIGNhbiAi
YmxpbmQiIENQVS0xKGhlcmUgYmxpbmQgbWVhbnMgZG8gbGwvc2MNCiB3cm9uZ++8iSwgdGhpcyBz
cGVjdWxhdGl2ZSBtZW1vcnkgYWNjZXNzIGNhbiBiZSBvYnNlcnZlZCBjb3JyZW50bHkgYnkgQ1BV
Mi4gSW4gdGhpcyANCmNhc2UsIHN3IGZyb20gQ1BVLTIgY2FuIGdldCBJICwgd2hpY2ggY2FuIGJl
IG9ic2VydmVkIGJ5IENQVS0xLCBhbmQgY2xlYXIgbGxiaXTvvIx0aGVuIA0KZmFpbGVkIHNjLiAN
Cg0KDQoNCuWMl+S6rOW4gua1t+a3gOWMuuS4reWFs+adkeeOr+S/neenkeaKgOekuuiMg+Wbrem+
meiKr+S6p+S4muWbrTLlj7fmpbwgMTAwMDk155S16K+dOiArODYgKDEwKSA2MjU0NjY2OOS8oOec
nzogKzg2ICgxMCkgNjI2MDA4MjZ3d3cubG9vbmdzb24uY27mnKzpgq7ku7blj4rlhbbpmYTku7bl
kKvmnInpvpnoiq/kuK3np5HmioDmnK/mnInpmZDlhazlj7jnmoTllYbkuJrnp5jlr4bkv6Hmga/v
vIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTn
u4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zk
vYbkuI3pmZDkuo7lhajpg6jmiJbpg6gg5YiG5Zyw5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ
5pys6YKu5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu
5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk
5pys6YKu5Lu244CCIA0KDQpUaGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBj
b25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBMb29uZ3Nvbg0KVGVjaG5vbG9neSBDb3Jwb3Jh
dGlvbiBMaW1pdGVkLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVu
dGl0eQ0Kd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9y
bWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4NCmFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBs
aW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsDQpyZXByb2R1Y3Rpb24gb3Ig
ZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykNCmlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4gZXJyb3Is
IHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieQ0KcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkg
YW5kIGRlbGV0ZSBpdC4g
