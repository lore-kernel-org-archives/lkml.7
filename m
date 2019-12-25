Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA29C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD0120730
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hyyuIbMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLYJ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 04:29:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:6623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726025AbfLYJ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:29:11 -0500
X-UUID: b3d58ddf514249d9b3da9fc4c7ea5b75-20191225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MQpZnlOW3rHl7XcCvW/fiVIv7mvsoc4U1tYgVz64kwo=;
        b=hyyuIbMzic0VYRogqCCFKuTYs/TvNOwZZqr3i4C9wi7o02au4JYeRZIBX7eE+d+1YxCxemQ6wqkBH+jYcCav7rCqQf8lnogQrTosc5wa3vFbkbf5B95fVHzV0N2WDfTDe2trqnv7fkXez12tdAeRb9+VBen+LOYi5FRhcIK5Di4=;
X-UUID: b3d58ddf514249d9b3da9fc4c7ea5b75-20191225
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 430936111; Wed, 25 Dec 2019 17:29:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Dec 2019 17:28:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Dec 2019 17:28:42 +0800
Message-ID: <1577266145.31907.4.camel@mtkswgap22>
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM
 panic occurs
From:   Miles Chen <miles.chen@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-mediatek@lists.infradead.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 25 Dec 2019 17:29:05 +0800
In-Reply-To: <5E08DE19-5B71-4245-8908-548BB4FA861F@lca.pw>
References: <1577169946.4959.4.camel@mtkswgap22>
         <5E08DE19-5B71-4245-8908-548BB4FA861F@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTI0IGF0IDA4OjQ3IC0wNTAwLCBRaWFuIENhaSB3cm90ZToNCj4gDQo+
ID4gT24gRGVjIDI0LCAyMDE5LCBhdCAxOjQ1IEFNLCBNaWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gV2UgdXNlIGttZW1sZWFrIHRvbywgYnV0IGEg
bWVtb3J5IGxlYWthZ2Ugd2hpY2ggaXMgY2F1c2VkIGJ5DQo+ID4gYWxsb2NfcGFnZXMoKSBpbiBh
IGtlcm5lbCBkZXZpY2UgZHJpdmVyIGNhbm5vdCBiZSBjYXVnaHQgYnkga21lbWxlYWsuDQo+ID4g
V2UgaGF2ZSBmb3VnaHQgYWdhaW5zdCB0aGlzIGtpbmQgb2YgcmVhbCBwcm9ibGVtcyBmb3IgYSBm
ZXcgeWVhcnMgYW5kIA0KPiA+IGZpbmQgYSB3YXkgdG8gbWFrZSB0aGUgZGVidWdnaW5nIGVhc2ll
ci4NCj4gPiANCj4gPiBXZSBjdXJyZW50bHkgaGF2ZSBpbmZvcm1hdGlvbiBkdXJpbmcgT09NOiBw
cm9jZXNzIE5vZGUsIHpvbmUsIHN3YXAsIA0KPiA+IHByb2Nlc3MgKHBpZCwgcnNzLCBuYW1lKSwg
c2xhYiB1c2FnZSwgYW5kIHRoZSBiYWNrdHJhY2UsIG9yZGVyLCBhbmQNCj4gPiBnZnAgZmxhZ3Mg
b2YgdGhlIE9PTSBiYWNrdHJhY2UuIA0KPiA+IFdlIGNhbiB0ZWxsIG1hbnkgZGlmZmVyZW50IHR5
cGVzIG9mIE9PTSBwcm9ibGVtcyBieSB0aGUgaW5mb3JtYXRpb24NCj4gPiBhYm92ZSBleGNlcHQg
dGhlIGFsbG9jX3BhZ2VzKCkgbGVha2FnZS4NCj4gPiANCj4gPiBUaGUgcGF0Y2ggZG9lcyB3b3Jr
IGFuZCBzYXZlIGEgbG90IG9mIGRlYnVnZ2luZyB0aW1lLg0KPiA+IENvdWxkIHdlIGNvbnNpZGVy
IHRoZSAiZ3JlYXRlc3QgbWVtb3J5IGNvbnN1bWVyIiBhcyBhbm90aGVyIHVzZWZ1bCANCj4gPiBP
T00gaW5mb3JtYXRpb24/DQo+IA0KPiBUaGlzIGlzIHJhdGhlciBzaXR1YXRpb25hbCBjb25zaWRl
cmluZyB0aGVyZSBhcmUgbWVtb3J5IGxlYWtzIGhlcmUgYW5kIHRoZXJlIGJ1dCBpdCBpcyBub3Qg
bmVjZXNzYXJ5IHRoYXQgc3RyYWlnaHRmb3J3YXJkIGFzIGEgc2luZ2xlIHBsYWNlIG9mIGdyZWF0
ZXN0IGNvbnN1bWVyLg0KDQpBZ3JlZWQsIGJ1dCBoYXZpbmcgdGhlIGdyZWF0ZXN0IG1lbW9yeSBj
b25zdW1lciBpbmZvcm1hdGlvbiBkb2VzIG5vIGhhcm0NCmhlcmUuDQpNYXliZSB5b3UgY2FuIHNo
YXJlIHNvbWUgY2FzZXMgdG8gbWU/DQoNCg0KVGhlIGdyZWF0ZXN0IG1lbW9yeSBjb25zdW1lciBw
cm92aWRlcyBhIHN0cm9uZyBjbHVlIG9mIG9mIGEgbWVtb3J5DQpsZWFrYWdlLg0KSSBoYXZlIHNl
ZW4gc29tZSBkaWZmZXJlbnQgdHlwZXMgb2YgT09NIGlzc3Vlcy4NCg0KMS4gdGFzayBsZWFrYWdl
LCB3ZSBjYW4gb2JzZXJ2ZSB0aGVzZSBieSB0aGUga2VybmVsX3N0YWNrIG51bWJlcnMNCg0KMi4g
bWVtb3J5IGZyYWdtZW50YXRpb24sIGNoZWNrIHRoZSBaT05FIG1lbW9yeSBzdGF0dXMgYW5kIHRo
ZSBhbGxvY2F0aW9uDQpvcmRlcg0KDQozLiBrbWFsbG9jIGxlYWthZ2UsIGNoZWNrIHRoZSBzbGFi
IG51bWJlcnMgYW5kIGxldCdzIHNheSB0aGUgbnVtYmVyDQprYW1sbG9jLTUxMiBpcyBhYm5vcm1h
bCwNCmFuZCB3ZSBjYW4gZW5hYmxlIGttZW1sZWFrLCByZXByb2R1Y2UgdGhlIGlzc3VlLiBNb3N0
IG9mIHRoZSB0aW1lLCBJIHNhdw0KYSBzaW5nbGUgYmFja3RyYWNlIG9mIHRoYXQgbGVhay4NCkl0
J3MgaGVscGZ1bCB0byBoYXZlIHRoZSBncmVhdGVzdCBtZW1vcnkgY29uc3VtZXIgaW4gdGhpcyBj
YXNlLg0KDQo0LiB2bWFsbG9jIGxlYWthZ2UsIHdlIGhhdmUgbm8gdm1hbGxvYyBudW1iZXJzIG5v
dy4gQW5kIEkgc2F3IGEgY2FzZQ0KdGhhdCB3ZSBwYXNzIGEgbGFyZ2UgbnVtYmVyDQppbnRvIHZt
YWxsb2MoKSBpbiBhIGZ1enppbmcgdGVzdCBhbmQgaXQgY2F1c2VzIE9PTSBrZXJuZWwgcGFuaWMu
DQpJdCBpcyBoYXJkIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgYW5kIGttZW1sZWFrIGNhbiBkbyBs
aXR0bGUgaGVscCBoZXJlDQpiZWNhdXNlIGl0IGlzIGEgT09NIGtlcm5lbCBwYW5pYy4NClRoYXQg
aXMgdGhlIGlzc3VlIHdoaWNoIGluc3BpcmVzIG1lIHRvIGNyZWF0ZSB0aGlzIHBhdGNoLiBXZSBm
b3VuZCB0aGUNCnJvb3QgY2F1c2UgYnkgdGhpcyBhcHByb2FjaC4NCg0KNS4gT09NIGR1ZSB0byBv
dXQgb2Ygbm9ybWFsIG1lbW9yeSAoaW4gMzJiaXQga2VybmVsKSwgd2UgY2FuIGNoZWNrIHRoZQ0K
YWxsb2NhdGUgZmxhZ3MgYW5kIHRoZQ0Kem9uZSBtZW1vcnkgc3RhdHVzLiBJbiB0aGlzIGNhc2Us
IHdlIGNhbiB0cnkgdG8gY2hlY2sgdGhlIG1lbW9yeQ0KYWxsb2NhdGlvbnMgYW5kIHNlZSBpZiB0
aGV5IGNhbg0KdXNlIGhpZ2htZW0uIEtub3dpbmcgdGhlIGdyZWF0ZXN0IG1lbW9yeSBjb25zdW1l
ciBtYXkgb3IgbWF5IG5vdCBiZQ0KdXNlZnVsIGhlcmUuDQoNCjYuIE9PTSBjYXVzZWQgYnkgMiBv
ciBtb3JlIGRpZmZlcmVudCBiYWNrdHJhY2VzLiBJIHNhdyB0aGlzIG9uY2UgYW5kIHdlDQplbmFi
bGUgUEFHRV9PV05FUiBhbmQNCmdldCB0aGUgY29tcGxldGUgaW5mb3JtYXRpb24gb2YgbWVtb3J5
IHVzYWdlIGFuZCBsb2NhdGUgdGhlIHJvb3QgY2F1c2UuDQpBZ2Fpbiwga25vd2luZyB0aGUgZ3Jl
YXRlc3QNCm1lbW9yeSBjb25zdW1lciBpcyBzdGlsbCBhIGhlbHAgaW4gdGhpcyBpc3N1ZS4NCg0K
Ny4gT09NIGNhdXNlIGJ5IGFsbG9jX3BhZ2VzKCkuIFRoZXJlIGFyZSBubyBleGlzdGluZyB1c2Vm
dWwgaW5mb3JtYXRpb24NCmZvciB0aGlzIGlzc3VlLiANCkNPTkZJR19QQUdFX09XTkVSIGlzIHVz
ZWZ1bCBhbmQgd2UgY2FuIGRvIG1vcmUgYmFzZSBvbg0KQ09ORklHX1BBR0VfT1dORVIuICh0aGlz
IHBhdGNoKQ0KDQo+IA0KPiBUaGUgb3RoZXIgcXVlc3Rpb24gaXMgd2h5IHRoZSBvZmZlbnNpdmUg
ZHJpdmVycyB0aGF0IHVzZSBhbGxvY19wYWdlcygpIHJlcGVhdGVkbHkgd2l0aG91dCB1c2luZyBh
bnkgb2JqZWN0IGFsbG9jYXRvcj8gRG8geW91IGhhdmUgZXhhbXBsZXMgb2YgdGhpcyBpbiBkcml2
ZXJzIHRoYXQgY291bGQgaGFwcGVuPw0KDQoNCkZvciBleGFtcGxlLCB3ZSdyZSBpbXBsZW1lbnRp
bmcgb3VyIGlvbW11IGRyaXZlciBhbmQgdGhlcmUgYXJlIG1hbnkNCmFsbG9jX3BhZ2VzKCkgaW4g
ZHJpdmVycy9pb21tdS4NClRoaXMgYXBwcm9hY2ggaGVscHMgdXMgbG9jYXRlZCBzb21lIG1lbW9y
eSBsZWFrYWdlcyBpbiBvdXINCmltcGxlbWVudGF0aW9uLg0KDQpUaGFua3MgYWdhaW4gZm9yIHlv
dXIgY29tbWVudHMNCkl0J3MgQ2hyaXN0bWFzIG5vdyBzbyBJIHRoaW5rIHdlIGNhbiBkaXNjdXNz
IGFmdGVyIHRoZSBDaHJpc3RtYXMgYnJlYWs/DQoNCkkgaGF2ZSBwb3N0ZWQgdGhlIG51bWJlciBv
ZiBpc3N1ZXMgYWRkcmVzc2VkIGJ5IHRoaXMgYXBwcm9hY2ggKDcgcmVhbA0KcHJvYmxlbXMgc2lu
Y2UgMjAxOS81KSANCkkgdGhpbmsgdGhpcyBhcHByb2FjaCBjYW4gaGVscCBwZW9wbGUuIDopDQoN
Cg0KICBNaWxlcw0KDQo=

