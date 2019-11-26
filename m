Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08F320733
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SUFHjTwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfKZDBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:01:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37782 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbfKZDBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:01:00 -0500
X-UUID: a39f13485f844b13895c3be9b3b498dd-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=U4VK8y3TGwrQrTTLGoGY/Sz/+8bSigII6WIe7UI7Fsg=;
        b=SUFHjTwtnhBzGLG9YOyIDp1I1RtMyUDYWZE/RbN2B03qM432PH1Xdb7GDVgvXDDXd7PviVe4A1oEA3P6E8CMnzjwZgwsE0I1itVnLLLMkyHQrdj0YfXJRvupQWWgVi28Rh0DWlZXlrdvOHG6FWMVJKkbrxkjHGS5B9uPbuiot90=;
X-UUID: a39f13485f844b13895c3be9b3b498dd-20191126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yt.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 635451793; Tue, 26 Nov 2019 11:00:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 11:00:43 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 11:00:33 +0800
Message-ID: <1574737251.12247.11.camel@mtksdccf07>
Subject: Re: [PATCH 1/1] sched: cfs_rq h_load might not update due to irq
 disable
From:   Kathleen Chang <yt.chang@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 26 Nov 2019 11:00:51 +0800
In-Reply-To: <20191121123804.GR4097@hirez.programming.kicks-ass.net>
References: <1574325009-10846-1-git-send-email-yt.chang@mediatek.com>
         <20191121123804.GR4097@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTIxIGF0IDEzOjM4ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBOb3YgMjEsIDIwMTkgYXQgMDQ6MzA6MDlQTSArMDgwMCwgWVQgQ2hhbmcgd3Jv
dGU6DQo+ID4gU3luZHJvbWU6DQo+ID4gDQo+ID4gVHdvIENQVXMgbWlnaHQgZG8gaWRsZSBiYWxh
bmNlIGluIHRoZSBzYW1lIHRpbWUuDQo+ID4gT25lIENQVSBkb2VzIGlkbGUgYmFsYW5jZSBhbmQg
cHVsbHMgc29tZSB0YXNrcy4NCj4gPiBIb3dldmVyIGJlZm9yZSBwaWNrIG5leHQgdGFzaywgQUxM
IHRhc2sgYXJlIHB1bGxlZCBiYWNrIHRvIG90aGVyIENQVS4NCj4gPiBUaGF0IHJlc3VsdHMgaW4g
aW5maW5pdGUgbG9vcCBpbiBib3RoIENQVXMuDQo+IA0KPiBDYW4geW91IGVhc2lseSByZXByb2R1
Y2UgdGhpcz8NCg0KTm8sIEkgY2FuJ3QgZWFzaWx5IHJlcHJvZHVjZSB0aGlzLiANCj4gDQo+ID4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiBjb2RlIGZsb3c6
DQo+ID4gDQo+ID4gaW4gcGlja19uZXh0X3Rhc2tfZmFpcigpDQo+ID4gDQo+ID4gYWdhaW46DQo+
ID4gDQo+ID4gaWYgbnJfcnVubmluZyA9PSAwDQo+ID4gCWdvdG8gaWRsZQ0KPiA+IHBpY2sgbmV4
dCB0YXNrDQo+ID4gCXJldHVybg0KPiA+IA0KPiA+IGlkbGU6DQo+ID4gCWlkbGVfYmFsYW5jZQ0K
PiA+ICAgICAgICAvKiBwdWxsIHNvbWUgdGFza3MgZnJvbSBvdGhlciBDUFUsDQo+ID4gICAgICAg
ICAqIEhvd2V2ZXIgb3RoZXIgQ1BVIGFyZSBhbHNvIGRvIGlkbGUgYmFsYW5jZSwNCj4gPiAJKiBh
bmQgcHVsbCBiYWNrIHRoZXNlIHRhc2sgKi8NCj4gPiANCj4gPiAJZ28gdG8gYWdhaW4NCj4gPiAN
Cj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IFRoZSBy
ZXN1bHQgdG8gcHVsbCBBTEwgdGFza3MgYmFjayB3aGVuIHRoZSB0YXNrX2hfbG9hZA0KPiA+IGlz
IGluY29ycmVjdCBhbmQgdG9vIGxvdy4NCj4gDQo+IENsZWFybHkgeW91J3JlIG5vdCBydW5uaW5n
IGEgUFJFRU1QVCBrZXJuZWwsIG90aGVyd2lzZSB0aGUgYnJlYWsgaW4NCj4gZGV0YWNoX3Rhc2tz
KCkgd291bGQndmUgc2F2ZWQgeW91LCByaWdodD8NCj4gDQo+ID4gc3RhdGljIHVuc2lnbmVkIGxv
bmcgdGFza19oX2xvYWQoc3RydWN0IHRhc2tfc3RydWN0ICpwKQ0KPiA+IHsNCj4gPiAgICAgICAg
IHN0cnVjdCBjZnNfcnEgKmNmc19ycSA9IHRhc2tfY2ZzX3JxKHApOw0KPiA+IA0KPiA+IAl1cGRh
dGVfY2ZzX3JxX2hfbG9hZChjZnNfcnEpOw0KPiA+IAlyZXR1cm4gZGl2NjRfdWwocC0+c2UuYXZn
LmxvYWRfYXZnX2NvbnRyaWIgKiBjZnNfcnEtPmhfbG9hZCwNCj4gPiAJCQljZnNfcnEtPnJ1bm5h
YmxlX2xvYWRfYXZnICsgMSk7DQo+ID4gfQ0KPiA+IA0KPiA+IFRoZSBjZnNfcnEtPmhfbG9hZCBp
cyBpbmNvcnJlY3QgYW5kIG1pZ2h0IHRvbyBzbWFsbC4NCj4gPiBUaGUgb3JpZ2luYWwgaWRlYSBv
ZiBjZnNfcnE6Omxhc3RfaF9sb2FkX3VwZGF0ZSB3aWxsIG5vdA0KPiA+IHVwZGF0ZSBjZnNfcnE6
OmhfbG9hZCBtb3JlIHRoYW4gb25jZSBhIGppZmZpZXMuDQo+ID4gV2hlbiB0aGUgVHdvIENQVXMg
cHVsbCBlYWNoIG90aGVyIGluIHRoZSBwaWNrX25leHRfdGFza19mYWlyLA0KPiA+IHRoZSBpcnEg
ZGlzYWJsZWQgYW5kIHJlc3VsdCBpbiBqaWZmaWUgbm90IHVwZGF0ZS4NCj4gPiAoT3RoZXIgQ1BV
cyB3YWl0IGZvciBydW5xdWV1ZSBsb2NrIGxvY2tlZCBieSB0aGUgdHdvIENQVXMuDQo+ID4gU28s
IEFMTCBDUFVzIGFyZSBpcnEgZGlzYWJsZWQuKQ0KPiANCj4gVGhpcyBjYW5ub3QgYmUgdHJ1ZTsg
YmVjYXVzZSB0aGUgbG9vcCBkcm9wcyBycS0+bG9jaywgc28gb3RoZXIgQ1BVcw0KPiBzaG91bGQg
aGF2ZSBhbiBvcHBvcnR1bml0eSB0byBhY3F1aXJlIHRoZSBsb2NrIGFuZCBtYWtlIHByb2dyZXNz
Lg0KDQpJIHJlY2hlY2sgb3RoZXIgQ1BVcyBzaXR1YXRpb24uIA0KT3RoZXIgQ1BVcyBhcmUgaXJx
IGRpc2FibGVkIGR1ZSB0byB3YWl0IGZvciBsb2NrIChOb3QgcnVucXVldWUgbG9jaykuDQoNClRo
ZSByb290IGNhdXNlIHNob3VsZCBiZSB3aHkgb3RoZXIgQ1BVcyBhcmUgd2FpdGluZyBmb3IgdGhl
IGxvY2sgDQpyYXRoZXIgdGhhbiByZXBsYWNpbmcgamlmZmllcyB3aXRoIHNjaGVkX2Nsb2NrKCku
DQoNCj4gDQo+ID4gU29sdXRpb246DQo+ID4gY2ZzX3JxIGhfbG9hZCBtaWdodCBub3QgdXBkYXRl
IGR1ZSB0byBpcnEgZGlzYWJsZQ0KPiA+IHVzZSBzY2hlZF9jbG9jayBpbnN0ZWFkIGppZmZpZXMN
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZVCBDaGFuZyA8eXQuY2hhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBrZXJuZWwvc2NoZWQvZmFpci5jIHwgNCArKystDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gPiBp
bmRleCA4M2FiMzVlLi4yMzFjNTNmIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9zY2hlZC9mYWly
LmMNCj4gPiArKysgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+ID4gQEAgLTc1NzgsOSArNzU3OCwx
MSBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfY2ZzX3JxX2hfbG9hZChzdHJ1Y3QgY2ZzX3JxICpjZnNf
cnEpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBycSAqcnEgPSBycV9vZihjZnNfcnEpOw0KPiA+ICAJ
c3RydWN0IHNjaGVkX2VudGl0eSAqc2UgPSBjZnNfcnEtPnRnLT5zZVtjcHVfb2YocnEpXTsNCj4g
PiAtCXVuc2lnbmVkIGxvbmcgbm93ID0gamlmZmllczsNCj4gPiArCXU2NCBub3cgPSBzY2hlZF9j
bG9ja19jcHUoY3B1X29mKHJxKSk7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGxvYWQ7DQo+ID4gIA0K
PiA+ICsJbm93ID0gbm93ICogSFogPj4gMzA7DQo+ID4gKw0KPiA+ICAJaWYgKGNmc19ycS0+bGFz
dF9oX2xvYWRfdXBkYXRlID09IG5vdykNCj4gPiAgCQlyZXR1cm47DQo+ID4gIA0KPiANCj4gVGhp
cyBpcyBkaXNndWlzdGluZyBhbmQgd3JvbmcuIFRoYXQgaXMgbm90IHRoZSBjb3JyZWN0IHJlbGF0
aW9uIGJldHdlZW4NCj4gc2NoZWRfY2xvY2soKSBhbmQgamlmZmllcy4NCg0K

