Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70433C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42024214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mOf6cG7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfLLBNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:13:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43875 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfLLBNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:13:45 -0500
X-UUID: bca38d7082df45099191f9447f744823-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=B4MILXq3ZMERWeqsdACp65BTdrLNU+AFrjMI+Ui8c0s=;
        b=mOf6cG7lzAyHQaWJzLGQ1IwDcHX1n70k9sM+f/NzOge0xvRurzaA9nhOr+Q3LWMBQZV6cBqcyeGFUqpZAaxYRCIZ+e22jFTDCnOGhUn2hotuR3c6i3j+mwVgoqFTo2XaVR2WSk689d3oDghkpwNoo1/ZKSS9qZffPaOGTJ4GD1o=;
X-UUID: bca38d7082df45099191f9447f744823-20191212
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1427452136; Thu, 12 Dec 2019 09:13:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:13:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:13:37 +0800
Message-ID: <1576113221.17653.6.camel@mtkswgap22>
Subject: Re: [PATCH v2 04/14] mailbox: mediatek: cmdq: clear task in channel
 before shutdown
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 09:13:41 +0800
In-Reply-To: <1575946181.16676.4.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-6-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575946181.16676.4.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAxMDo0OSArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBXZWQsIDIwMTktMTEtMjcgYXQgMDk6NTggKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBEbyBzdWNjZXNzIGNhbGxiYWNrIGluIGNoYW5u
ZWwgd2hlbiBzaHV0ZG93bi4gRm9yIHRob3NlIHRhc2sgbm90IGZpbmlzaCwNCj4gPiBjYWxsYmFj
ayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFzIGNoYW5jZSB0byBjbGVhbnVwIG9yIHJl
c2V0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXlj
LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5jDQo+ID4gaW5kZXggZmQ1MTliNmY1MThiLi5jMTJhNzY4ZDExNzUgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBAQCAtNDUwLDYgKzQ1MCwzMiBA
QCBzdGF0aWMgaW50IGNtZHFfbWJveF9zdGFydHVwKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+
ID4gIA0KPiA+ICBzdGF0aWMgdm9pZCBjbWRxX21ib3hfc2h1dGRvd24oc3RydWN0IG1ib3hfY2hh
biAqY2hhbikNCj4gPiAgew0KPiA+ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQgPSAoc3Ry
dWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQo+ID4gKwlzdHJ1Y3QgY21kcSAqY21k
cSA9IGRldl9nZXRfZHJ2ZGF0YShjaGFuLT5tYm94LT5kZXYpOw0KPiA+ICsJc3RydWN0IGNtZHFf
dGFzayAqdGFzaywgKnRtcDsNCj4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gKw0KPiA+
ICsJc3Bpbl9sb2NrX2lycXNhdmUoJnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KPiA+ICsJ
aWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KPiA+ICsJCWdvdG8gZG9u
ZTsNCj4gPiArDQo+ID4gKwlXQVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFk
KSA8IDApOw0KPiA+ICsNCj4gPiArCS8qIG1ha2Ugc3VyZSBleGVjdXRlZCB0YXNrcyBoYXZlIHN1
Y2Nlc3MgY2FsbGJhY2sgKi8NCj4gPiArCWNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRo
cmVhZCk7DQo+ID4gKwlpZiAobGlzdF9lbXB0eSgmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCkpDQo+
ID4gKwkJZ290byBkb25lOw0KPiA+ICsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh0
YXNrLCB0bXAsICZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0LA0KPiA+ICsJCQkJIGxpc3RfZW50cnkp
IHsNCj4gPiArCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIC1FQ09OTkFCT1JURUQpOw0KPiA+
ICsJCWtmcmVlKHRhc2spOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWNtZHFfdGhyZWFkX2Rpc2Fi
bGUoY21kcSwgdGhyZWFkKTsNCj4gPiArCWNsa19kaXNhYmxlKGNtZHEtPmNsb2NrKTsNCj4gPiAr
ZG9uZToNCj4gDQo+IGNtZHFfdGhyZWFkX3Jlc3VtZSh0aHJlYWQpOw0KPiANCj4gUmVnYXJkcywN
Cj4gQ0sNCj4gDQoNCkNhbGwgcmVzdW1lIGhlcmUgd2lsbCBjYXVzZSB2aW9sYXRpb24uIFRoZSB0
aHJlYWQtPnRhc2tfYnVzeV9saXN0IGVtcHR5DQptZWFucyBubyB0YXNrIHdvcmsgaW4gZ2NlIGFu
ZCB0aHJlYWQgc3RhdGUgc2hvdWxkIGFscmVhZHkgZGlzYWJsZQ0Kd2l0aG91dCBjbG9jaywgd2hp
Y2ggaXMgd2hhdCB3ZSB3YW50IHNpbmNlIGNsaWVudCB0cnkgdG8gc2h1dCBkb3duIHRoaXMNCm1i
b3ggY2hhbm5lbC4gU28gSSB0aGluayB3ZSBkb24ndCBuZWVkIHJlc3VtZSBoZXJlLg0KDQoNClJl
Z2FyZHMsDQpEZW5uaXMNCg0KPiA+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5j
aGFuLT5sb2NrLCBmbGFncyk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbWJveF9jaGFuX29wcyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7DQo+IA0KPiANCg0K

