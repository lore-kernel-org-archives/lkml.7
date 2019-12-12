Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA9C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81998208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ctJMPO1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfLLBbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:31:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51556 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727409AbfLLBbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:31:48 -0500
X-UUID: 1282512acbeb4759b0798f94b9793544-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=q8/oNDXucgX/Eg8dpJir+m+Bj6aJJFfQRqRdzNzivkQ=;
        b=ctJMPO1bAR3Ly2dqN4Olo+fF2yHpLIa9kh2ZJAHPYmCmIAzUmmnMY9vZGr6WTQFaj0zbeNeb2k1k9xJYi3MYtzvq7PsDOrHivdeI5i3dmpSJbpUGx0oTPJbdAWvZ0KRjmNS+mjSH9JultH46G/UUVQz1Veou8oBYQxCvbReIafI=;
X-UUID: 1282512acbeb4759b0798f94b9793544-20191212
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 799098882; Thu, 12 Dec 2019 09:31:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:30:38 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:31:02 +0800
Message-ID: <1576114297.11762.1.camel@mtksdaap41>
Subject: Re: [PATCH v2 04/14] mailbox: mediatek: cmdq: clear task in channel
 before shutdown
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 09:31:37 +0800
In-Reply-To: <1576113221.17653.6.camel@mtkswgap22>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-6-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575946181.16676.4.camel@mtksdaap41> <1576113221.17653.6.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C441F67C5D7EA4E3320772BC92C7B1B7DFA318C63082BF0DE82C3B1EB5E06E732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVGh1LCAyMDE5LTEyLTEyIGF0IDA5OjEzICswODAwLCBEZW5uaXMt
WUMgSHNpZWggd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gT24gVHVlLCAyMDE5LTEyLTEwIGF0IDEw
OjQ5ICswODAwLCBDSyBIdSB3cm90ZToNCj4gPiBIaSwgRGVubmlzOg0KPiA+IA0KPiA+IE9uIFdl
ZCwgMjAxOS0xMS0yNyBhdCAwOTo1OCArMDgwMCwgRGVubmlzIFlDIEhzaWVoIHdyb3RlOg0KPiA+
ID4gRG8gc3VjY2VzcyBjYWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9z
ZSB0YXNrIG5vdCBmaW5pc2gsDQo+ID4gPiBjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUgdGh1cyBj
bGllbnQgaGFzIGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KPiA+ID4gDQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+
DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIHwg
MjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjYg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94
L210ay1jbWRxLW1haWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMN
Cj4gPiA+IGluZGV4IGZkNTE5YjZmNTE4Yi4uYzEyYTc2OGQxMTc1IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gQEAgLTQ1MCw2ICs0NTAsMzIgQEAg
c3RhdGljIGludCBjbWRxX21ib3hfc3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiA+
ID4gIA0KPiA+ID4gIHN0YXRpYyB2b2lkIGNtZHFfbWJveF9zaHV0ZG93bihzdHJ1Y3QgbWJveF9j
aGFuICpjaGFuKQ0KPiA+ID4gIHsNCj4gPiA+ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQg
PSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQo+ID4gPiArCXN0cnVjdCBj
bWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRhKGNoYW4tPm1ib3gtPmRldik7DQo+ID4gPiArCXN0
cnVjdCBjbWRxX3Rhc2sgKnRhc2ssICp0bXA7DQo+ID4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
DQo+ID4gPiArDQo+ID4gPiArCXNwaW5fbG9ja19pcnFzYXZlKCZ0aHJlYWQtPmNoYW4tPmxvY2ss
IGZsYWdzKTsNCj4gPiA+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3Qp
KQ0KPiA+ID4gKwkJZ290byBkb25lOw0KPiA+ID4gKw0KPiA+ID4gKwlXQVJOX09OKGNtZHFfdGhy
ZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KPiA+ID4gKw0KPiA+ID4gKwkvKiBtYWtl
IHN1cmUgZXhlY3V0ZWQgdGFza3MgaGF2ZSBzdWNjZXNzIGNhbGxiYWNrICovDQo+ID4gPiArCWNt
ZHFfdGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQo+ID4gPiArCWlmIChsaXN0X2Vt
cHR5KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkNCj4gPiA+ICsJCWdvdG8gZG9uZTsNCj4gPiA+
ICsNCj4gPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHRhc2ssIHRtcCwgJnRocmVhZC0+
dGFza19idXN5X2xpc3QsDQo+ID4gPiArCQkJCSBsaXN0X2VudHJ5KSB7DQo+ID4gPiArCQljbWRx
X3Rhc2tfZXhlY19kb25lKHRhc2ssIC1FQ09OTkFCT1JURUQpOw0KPiA+ID4gKwkJa2ZyZWUodGFz
ayk7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJY21kcV90aHJlYWRfZGlzYWJsZShjbWRx
LCB0aHJlYWQpOw0KPiA+ID4gKwljbGtfZGlzYWJsZShjbWRxLT5jbG9jayk7DQo+ID4gPiArZG9u
ZToNCj4gPiANCj4gPiBjbWRxX3RocmVhZF9yZXN1bWUodGhyZWFkKTsNCj4gPiANCj4gPiBSZWdh
cmRzLA0KPiA+IENLDQo+ID4gDQo+IA0KPiBDYWxsIHJlc3VtZSBoZXJlIHdpbGwgY2F1c2Ugdmlv
bGF0aW9uLiBUaGUgdGhyZWFkLT50YXNrX2J1c3lfbGlzdCBlbXB0eQ0KPiBtZWFucyBubyB0YXNr
IHdvcmsgaW4gZ2NlIGFuZCB0aHJlYWQgc3RhdGUgc2hvdWxkIGFscmVhZHkgZGlzYWJsZQ0KPiB3
aXRob3V0IGNsb2NrLCB3aGljaCBpcyB3aGF0IHdlIHdhbnQgc2luY2UgY2xpZW50IHRyeSB0byBz
aHV0IGRvd24gdGhpcw0KPiBtYm94IGNoYW5uZWwuIFNvIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCBy
ZXN1bWUgaGVyZS4NCj4gDQoNCk9LLiBXaGVuIGNsaWVudCBmcmVlIGNoYW5uZWwsIHRocmVhZCBp
cyBzdXNwZW5kZWQuIFRoZW4gY2xpZW50IHJlcXVlc3QNCmNoYW5uZWwsIHdoZXJlIGRvIHlvdSBy
ZXN1bWUgdGhyZWFkPw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gUmVnYXJkcywNCj4gRGVubmlz
DQo+IA0KPiA+ID4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ0aHJlYWQtPmNoYW4tPmxvY2ss
IGZsYWdzKTsNCj4gPiA+ICB9DQo+ID4gPiAgDQo+ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
Ym94X2NoYW5fb3BzIGNtZHFfbWJveF9jaGFuX29wcyA9IHsNCj4gPiANCj4gPiANCj4gDQo+IA0K
DQo=

