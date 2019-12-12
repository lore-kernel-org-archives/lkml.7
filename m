Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06DDC2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCA52077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FJqm1hGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfLLCDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:03:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:13277 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727544AbfLLCDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:03:31 -0500
X-UUID: 3be0c63a967649d99dd905438b2ab4d7-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=58Kn1gNg/Vbwnp9rOtOIWJfzSVNVySk5I9bvfgOs8zs=;
        b=FJqm1hGYBNcAr0iCcqx0uQRFX+TkLaek5WlEXOOW8/psp/5KbWOkLqnX0SRxtPTLncu22Vrr9z84cz4KnxHP4st2AKLCtGmaIYZ0GgwVy1ofrnd2AGMrMPbzMue7ev1eKGIptPFlZeswsQ5PB4o1BzVZLdIyzf0LpH8zw0SgqZE=;
X-UUID: 3be0c63a967649d99dd905438b2ab4d7-20191212
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 211027014; Thu, 12 Dec 2019 10:03:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 10:02:24 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 10:03:20 +0800
Message-ID: <1576116202.16444.4.camel@mtksdaap41>
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
Date:   Thu, 12 Dec 2019 10:03:22 +0800
In-Reply-To: <1576115494.17653.21.camel@mtkswgap22>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-6-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575946181.16676.4.camel@mtksdaap41> <1576113221.17653.6.camel@mtkswgap22>
         <1576114297.11762.1.camel@mtksdaap41>
         <1576115494.17653.21.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A8FE64F7829C208CB8FCB2A8C581833FEC7AEC50ED8D9CA3A499B8304934AA792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVGh1LCAyMDE5LTEyLTEyIGF0IDA5OjUxICswODAwLCBEZW5uaXMt
WUMgSHNpZWggd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gT24gVGh1LCAyMDE5LTEyLTEyIGF0IDA5
OjMxICswODAwLCBDSyBIdSB3cm90ZToNCj4gPiBIaSwgRGVubmlzOg0KPiA+IA0KPiA+IE9uIFRo
dSwgMjAxOS0xMi0xMiBhdCAwOToxMyArMDgwMCwgRGVubmlzLVlDIEhzaWVoIHdyb3RlOg0KPiA+
ID4gSGkgQ0ssDQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAxMDo0OSArMDgw
MCwgQ0sgSHUgd3JvdGU6DQo+ID4gPiA+IEhpLCBEZW5uaXM6DQo+ID4gPiA+IA0KPiA+ID4gPiBP
biBXZWQsIDIwMTktMTEtMjcgYXQgMDk6NTggKzA4MDAsIERlbm5pcyBZQyBIc2llaCB3cm90ZToN
Cj4gPiA+ID4gPiBEbyBzdWNjZXNzIGNhbGxiYWNrIGluIGNoYW5uZWwgd2hlbiBzaHV0ZG93bi4g
Rm9yIHRob3NlIHRhc2sgbm90IGZpbmlzaCwNCj4gPiA+ID4gPiBjYWxsYmFjayB3aXRoIGVycm9y
IGNvZGUgdGh1cyBjbGllbnQgaGFzIGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXlj
LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9t
YWlsYm94L210ay1jbWRxLW1haWxib3guYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiA+ID4gaW5kZXgg
ZmQ1MTliNmY1MThiLi5jMTJhNzY4ZDExNzUgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+ID4gPiBAQCAtNDUwLDYgKzQ1MCwzMiBAQCBz
dGF0aWMgaW50IGNtZHFfbWJveF9zdGFydHVwKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+ID4g
PiA+ID4gIA0KPiA+ID4gPiA+ICBzdGF0aWMgdm9pZCBjbWRxX21ib3hfc2h1dGRvd24oc3RydWN0
IG1ib3hfY2hhbiAqY2hhbikNCj4gPiA+ID4gPiAgew0KPiA+ID4gPiA+ICsJc3RydWN0IGNtZHFf
dGhyZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQo+
ID4gPiA+ID4gKwlzdHJ1Y3QgY21kcSAqY21kcSA9IGRldl9nZXRfZHJ2ZGF0YShjaGFuLT5tYm94
LT5kZXYpOw0KPiA+ID4gPiA+ICsJc3RydWN0IGNtZHFfdGFzayAqdGFzaywgKnRtcDsNCj4gPiA+
ID4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJc3Bp
bl9sb2NrX2lycXNhdmUoJnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gPiA+ICsJ
aWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KPiA+ID4gPiA+ICsJCWdv
dG8gZG9uZTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlXQVJOX09OKGNtZHFfdGhyZWFkX3N1
c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCS8qIG1h
a2Ugc3VyZSBleGVjdXRlZCB0YXNrcyBoYXZlIHN1Y2Nlc3MgY2FsbGJhY2sgKi8NCj4gPiA+ID4g
PiArCWNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQo+ID4gPiA+ID4gKwlp
ZiAobGlzdF9lbXB0eSgmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCkpDQo+ID4gPiA+ID4gKwkJZ290
byBkb25lOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZSh0YXNrLCB0bXAsICZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0LA0KPiA+ID4gPiA+ICsJCQkJIGxp
c3RfZW50cnkpIHsNCj4gPiA+ID4gPiArCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIC1FQ09O
TkFCT1JURUQpOw0KPiA+ID4gPiA+ICsJCWtmcmVlKHRhc2spOw0KPiA+ID4gPiA+ICsJfQ0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArCWNtZHFfdGhyZWFkX2Rpc2FibGUoY21kcSwgdGhyZWFkKTsN
Cj4gPiA+ID4gPiArCWNsa19kaXNhYmxlKGNtZHEtPmNsb2NrKTsNCj4gPiA+ID4gPiArZG9uZToN
Cj4gPiA+ID4gDQo+ID4gPiA+IGNtZHFfdGhyZWFkX3Jlc3VtZSh0aHJlYWQpOw0KPiA+ID4gPiAN
Cj4gPiA+ID4gUmVnYXJkcywNCj4gPiA+ID4gQ0sNCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IENh
bGwgcmVzdW1lIGhlcmUgd2lsbCBjYXVzZSB2aW9sYXRpb24uIFRoZSB0aHJlYWQtPnRhc2tfYnVz
eV9saXN0IGVtcHR5DQo+ID4gPiBtZWFucyBubyB0YXNrIHdvcmsgaW4gZ2NlIGFuZCB0aHJlYWQg
c3RhdGUgc2hvdWxkIGFscmVhZHkgZGlzYWJsZQ0KPiA+ID4gd2l0aG91dCBjbG9jaywgd2hpY2gg
aXMgd2hhdCB3ZSB3YW50IHNpbmNlIGNsaWVudCB0cnkgdG8gc2h1dCBkb3duIHRoaXMNCj4gPiA+
IG1ib3ggY2hhbm5lbC4gU28gSSB0aGluayB3ZSBkb24ndCBuZWVkIHJlc3VtZSBoZXJlLg0KPiA+
ID4gDQo+ID4gDQo+ID4gT0suIFdoZW4gY2xpZW50IGZyZWUgY2hhbm5lbCwgdGhyZWFkIGlzIHN1
c3BlbmRlZC4gVGhlbiBjbGllbnQgcmVxdWVzdA0KPiA+IGNoYW5uZWwsIHdoZXJlIGRvIHlvdSBy
ZXN1bWUgdGhyZWFkPw0KPiA+IA0KPiANCj4gd2hlbiBjbGllbnQgc2VuZCBuZXcgcGt0IHRvIG5l
dyBjaGFubmVsLCBjbWRxX21ib3hfc2VuZF9kYXRhKCkgd2lsbA0KPiBlbmFibGUgdGhyZWFkLg0K
DQppbiBjbWRxX21ib3hfc2VuZF9kYXRhKCksIGl0IHdvdWxkIHJ1biBiZWxvdyBjb21tYW5kOg0K
DQpXQVJOX09OKGNsa19lbmFibGUoY21kcS0+Y2xvY2spIDwgMCk7DQpXQVJOX09OKGNtZHFfdGhy
ZWFkX3Jlc2V0KGNtZHEsIHRocmVhZCkgPCAwKTsNCg0Kd3JpdGVsKHRhc2stPnBhX2Jhc2UsIHRo
cmVhZC0+YmFzZSArIENNRFFfVEhSX0NVUlJfQUREUik7DQp3cml0ZWwodGFzay0+cGFfYmFzZSAr
IHBrdC0+Y21kX2J1Zl9zaXplLA0KICAgICAgIHRocmVhZC0+YmFzZSArIENNRFFfVEhSX0VORF9B
RERSKTsNCndyaXRlbCh0aHJlYWQtPnByaW9yaXR5LCB0aHJlYWQtPmJhc2UgKyBDTURRX1RIUl9Q
UklPUklUWSk7DQp3cml0ZWwoQ01EUV9USFJfSVJRX0VOLCB0aHJlYWQtPmJhc2UgKyBDTURRX1RI
Ul9JUlFfRU5BQkxFKTsNCndyaXRlbChDTURRX1RIUl9FTkFCTEVELCB0aHJlYWQtPmJhc2UgKyBD
TURRX1RIUl9FTkFCTEVfVEFTSyk7DQoNCkRvIHlvdSBtZWFuIENNRFFfVEhSX0VOQUJMRV9UQVNL
IGlzIHNldCB0byBDTURRX1RIUl9FTkFCTEVELCB0aGVuDQpDTURRX1RIUl9TVVNQRU5EX1RBU0sg
d291bGQgYmUgYXV0b21hdGljYWxseSBzZXQgdG8gQ01EUV9USFJfUkVTVU1FPyBJZg0KdGhpcyBo
YXJkd2FyZSB3b3JrIGluIHNvIHNwZWNpYWwgYmVoYXZpb3IsIHBsZWFzZSBhZGQgY29tbWVudCBm
b3IgdGhpcy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBEZW5uaXMN
Cj4gDQo+ID4gUmVnYXJkcywNCj4gPiBDSw0KPiA+IA0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0K
PiA+ID4gRGVubmlzDQo+ID4gPiANCj4gPiA+ID4gPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4gIA0K
PiA+ID4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG1ib3hfY2hhbl9vcHMgY21kcV9tYm94X2No
YW5fb3BzID0gew0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+
IA0KPiANCj4gDQoNCg==

