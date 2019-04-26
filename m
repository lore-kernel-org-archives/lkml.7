Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E093C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326A220878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfDZC56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:57:58 -0400
Received: from mail.loongson.cn ([114.242.206.163]:41904 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDZC56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:57:58 -0400
Received: by ajax-webmail-mail (Coremail) ; Fri, 26 Apr 2019 10:57:20 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [220.166.230.208]
Date:   Fri, 26 Apr 2019 10:57:20 +0800 (GMT+08:00)
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
Subject: Re: Re: Re: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix
 loongson_llsc_mb() wreckage
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <20190425133105.GV4038@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
 <5b13fd3b.c031.16a54452744.Coremail.huangpei@loongson.cn>
 <20190425122611.GT4038@hirez.programming.kicks-ass.net>
 <2ff11adc.c051.16a548cd90c.Coremail.huangpei@loongson.cn>
 <20190425133105.GV4038@hirez.programming.kicks-ass.net>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: BPPjbWZvb3Rlcl90eHQ9Mzk0Nzo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <592bc84.c106.16a57936acf.Coremail.huangpei@loongson.cn>
X-CM-TRANSID: QMiowPDxpuSQc8JcYyjKAA--.11208W
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/1tbiAQAMAVEBqdXPMQAAse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIlBldGVyIFppamxz
dHJhIiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAxOS0wNC0yNSAy
MTozMTowNSAo5pif5pyf5ZubKQ0KPiDmlLbku7bkuro6IGh1YW5ncGVpQGxvb25nc29uLmNuDQo+
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
DQo+IOS4u+mimDogUmU6IFJlOiBSZTogUmU6IFtSRkNdW1BBVENIIDIvNV0gbWlwcy9hdG9taWM6
IEZpeCBsb29uZ3Nvbl9sbHNjX21iKCkgd3JlY2thZ2UNCj4gDQo+IE9uIFRodSwgQXByIDI1LCAy
MDE5IGF0IDA4OjUxOjE3UE0gKzA4MDAsIGh1YW5ncGVpQGxvb25nc29uLmNuIHdyb3RlOg0KPiAN
Cj4gPiA+IFNvIGJhc2ljYWxseSB0aGUgaW5pdGlhbCB2YWx1ZSBvZiBAdiBpcyBzZXQgdG8gMS4N
Cj4gPiA+IA0KPiA+ID4gVGhlbiBDUFUtMSBkb2VzIGF0b21pY19hZGRfdW5sZXNzKHYsIDEsIDAp
DQo+ID4gPiAgICAgIENQVS0yIGRvZXMgYXRvbWljX3NldCh2LCAwKQ0KPiA+ID4gDQo+ID4gPiBJ
ZiBDUFUxIGdvZXMgZmlyc3QsIGl0IHdpbGwgc2VlIDEsIHdoaWNoIGlzIG5vdCAwIGFuZCB0aHVz
IGFkZCAxIHRvIDENCj4gPiA+IGFuZCBvYnRhaW5zIDIuIFRoZW4gQ1BVMiBnb2VzIGFuZCB3cml0
ZXMgMCwgc28gdGhlIGV4aXN0IGNsYXVzZSBzZWVzDQo+ID4gPiB2PT0wIGFuZCBkb2Vzbid0IG9i
c2VydmUgMi4NCj4gPiA+IA0KPiA+ID4gVGhlIG90aGVyIHdheSBhcm91bmQsIENQVS0yIGdvZXMg
Zmlyc3QsIHdyaXRlcyBhIDAsIHRoZW4gQ1BVLTEgZ29lcyBhbmQNCj4gPiA+IG9ic2VydmVzIHRo
ZSAwLCBmaW5kcyBpdCBtYXRjaGVzIDAgYW5kIGRvZXNuJ3QgYWRkLiAgQWdhaW4sIHRoZSBleGlz
dA0KPiA+ID4gY2xhdXNlIHdpbGwgZmluZCAwIGRvZXNuJ3QgbWF0Y2ggMi4NCj4gPiA+IA0KPiA+
ID4gVGhpcyBhbGwgZ29lcyB1bnN0dWNrIGlmIGludGVybGVhdmVkIGxpa2U6DQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gCUNQVS0xCQkJQ1BVLTINCj4gPiA+IA0KPiA+ID4gCQkJCXhvcgl0MCwgdDAN
Cj4gPiA+IDE6CWxsCXQwLCB2DQo+ID4gPiAJYmV6CXQwLCAyZg0KPiA+ID4gCQkJCXN3CXQwLCB2
DQo+ID4gPiAJYWRkCXQwLCB0MQ0KPiA+ID4gCXNjCXQwLCB2DQo+ID4gPiAJYmVxeiB0MCwgMWIN
Cj4gPiA+IA0KPiA+ID4gKHNvcnJ5IGlmIEkgZ290IHRoZSBNSVBTIGFzbSB3cm9uZzsgaXQncyBu
b3Qgc29tZXRoaW5nIEkgbm9ybWFsbHkgd3JpdGUpDQo+ID4gPiANCj4gPiA+IEFuZCB0aGUgc3Rv
cmUtd29yZCBmcm9tIENQVS0yIGRvZXNuJ3QgbWFrZSB0aGUgU0MgZnJvbSBDUFUtMSBmYWlsLg0K
PiA+ID4gDQo+ID4gDQo+ID4gbG9vbmdzb24ncyBsbHNjIGJ1ZyBET0VTIE5PVCBmYWlsIHRoaXMg
bGl0bXVzKCB3ZSB3aWxsIG5vdCBnZXQgVj0yKe+8mw0KPiA+IA0KPiA+IG9ubHkgc3BlY3VsYXRp
dmUgbWVtb3J5IGFjY2VzcyBmcm9tIENQVS0xIGNhbiAiYmxpbmQiIENQVS0xKGhlcmUgYmxpbmQg
bWVhbnMgZG8gbGwvc2MNCj4gPiAgd3JvbmfvvIksIHRoaXMgc3BlY3VsYXRpdmUgbWVtb3J5IGFj
Y2VzcyBjYW4gYmUgb2JzZXJ2ZWQgY29ycmVudGx5IGJ5IENQVTIuIEluIHRoaXMgDQo+ID4gY2Fz
ZSwgc3cgZnJvbSBDUFUtMiBjYW4gZ2V0IEkgLCB3aGljaCBjYW4gYmUgb2JzZXJ2ZWQgYnkgQ1BV
LTEsIGFuZCBjbGVhciBsbGJpdO+8jHRoZW4gDQo+ID4gZmFpbGVkIHNjLiANCj4gDQo+IEknbSBu
b3QgZm9sbG93aW5nLCBzdXBwb3NlIENQVS0xIGhhcHBlbnMgYXMgYSBzcGVjdWxhdGlvbiAoaW1h
Z2luZQ0KPiB3aGF0ZXZlciBjb2RlIGlzIHJlcXVpcmVkIHRvIG1ha2UgdGhhdCBoYXBwZW4gYmVm
b3JlKS4gQ1BVLTIgc3cgd2lsbA0KPiBjYXVzZSBJIG9uIENQVS0xJ3MgbGwgYnV0LCBhcyBpbiB0
aGUgcHJldmlvdXMgZW1haWwsIENQVS0xIHdpbGwgY29udGludWUNCj4gYXMgaWYgaXQgc3RpbGwg
aGFzIEUgYW5kIGNvbXBsZXRlIHRoZSBTQy4NCj4gDQo+IFRoYXQgaXM7IEknbSBqdXN0IG5vdCBz
ZWVpbmcgd2h5IHRoaXMgY2FzZSB3b3VsZCBiZSBkaWZmZXJlbnQgZnJvbSB0d28NCj4gY29tcGV0
aW5nIExML1NDcy4NCj4gDQoNCkkgZ2V0IHlvdXIgcG9pbnQuIEkga2VwdCBteSBleWUgb24gdGhl
IHN3IGZyb20gQ1BVLTIsIGJ1dCBmb3Jnb3QgdGhlIHNwZWN1bGF0aXZlDQogbWVtIGFjY2VzcyBm
cm9tIENQVS0xLiANCg0KVGhlcmUgaXMgbm8gZGlmZmVyZW5jZSBiZXd0ZWVuIHRoaXMgb25lIGFu
ZCB0aGUgZm9ybWVyIGNhc2UuDQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0gDQogICAgICAgICAgICAgICAg
ICAgICAgIFYgPSAxDQoNCiAgICBDUFUtMSAgICAgICAgICAgICAgICAgICAgICAgQ1BVLTINCg0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4b3IgIHQwLCB0MA0KMTogIGxsICAgICB0
MCwgViAgICAgICAgICAgICAgIA0KICAgIGJlcXogICB0MCwgMmYNCg0KICAgIC8qIGlmIHNwZWN1
bGF0aXZlIG1lbSANCiAgICBhY2Nlc3Mga2ljayBjYWNoZWxpbmUgb2YNCiAgICBWIG91dCwgaXQg
Y2FuIGJsaW5kIENQVS0xIA0KICAgIGFuZCBtYWtlIENQVS0xIGJlbGlldmUgaXQgDQogICAgc3Rp
bGwgaG9sZCBFIG9uIFYsIGFuZCBjYW4NCiAgICBOT1Qgc2VlIHRoZSBzdyBmcm9tIENQVS0yDQog
ICAgYWN0dWFsbHkgaW52YWxpZCBWLCB3aGljaCANCiAgICBzaG91bGQgY2xlYXIgTExCaXQgb2Yg
Q1BVLTEsIA0KICAgIGJ1dCBub3QgKi8NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3cgICB0MCwgViAgICAgLy8ganVzdCBhZnRlciBzdywgViA9IDANCiAgICBhZGRpdSAgdDAsIHQw
LCAxICAgICAgICAgICAgDQoNCiAgICBzYyAgICAgdDAsIFYNCiAgICAvKiBvb3BzLCBzYyB3cml0
ZSB0MCgyKSANCiAgICBpbnRvIFYgd2l0aCBMTEJpdCAqLw0KDQogICAgLyogZ2V0IFY9MiAqLw0K
ICAgIGJlcXogICB0MCwgMWINCiAgICBub3ANCjI6DQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSAg
ICANCiAgICAgICAgICAgICAgIA0KaWYgc3BlY3VsYXRpdmUgbWVtIGFjY2VzcyAqZG9lcyBub3Qq
IGtpY2sgb3V0IGNhY2hlIGxpbmUgb2YgViwgQ1BVLTEgY2FuIHNlZSBzdw0KZnJvbSBDUFUtMiwg
YW5kIGNsZWFyIExMQml0LCB3aGljaCBjYXVzZSBzYyBmYWlsIGFuZCByZXRyeSwgVGhhdCdzIE9L
DQogDQoNCg0K5YyX5Lqs5biC5rW35reA5Yy65Lit5YWz5p2R546v5L+d56eR5oqA56S66IyD5Zut
6b6Z6Iqv5Lqn5Lia5ZutMuWPt+alvCAxMDAwOTXnlLXor506ICs4NiAoMTApIDYyNTQ2NjY45Lyg
55yfOiArODYgKDEwKSA2MjYwMDgyNnd3dy5sb29uZ3Nvbi5jbuacrOmCruS7tuWPiuWFtumZhOS7
tuWQq+aciem+meiKr+S4reenkeaKgOacr+aciemZkOWFrOWPuOeahOWVhuS4muenmOWvhuS/oeaB
r++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+
pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaL
rOS9huS4jemZkOS6juWFqOmDqOaIlumDqCDliIblnLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5Hv
vInmnKzpgq7ku7blj4rlhbbpmYTku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzp
gq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDp
maTmnKzpgq7ku7bjgIIgDQoNClRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWlu
IGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIExvb25nc29uDQpUZWNobm9sb2d5IENvcnBv
cmF0aW9uIExpbWl0ZWQsIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3Ig
ZW50aXR5DQp3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5m
b3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbg0KYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90
IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwNCnJlcHJvZHVjdGlvbiBv
ciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKQ0KaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJv
ciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5DQpwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVs
eSBhbmQgZGVsZXRlIGl0LiA=
