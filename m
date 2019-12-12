Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A2C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CCF214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hf0wI6Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfLLBvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:51:42 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4534 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727542AbfLLBvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:51:41 -0500
X-UUID: 4d76d4903548490187c1f044308c533d-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Of+6/V6XHKRPg6mlAyJMUp0eBfOyc4qsodtrpJM/gLY=;
        b=hf0wI6Lbzx9A3JC6ZZvvjJLvUFs4QR2tHG8ke1hDEqxM8UvvfbOGF97Iejlt6Bw5QPrh0id8jPXIMAoZD4IiEo9b7m4QZvnEg4Elw7IfRC93saQBdQ1flVYjeksu5UEXsdmQ/qd1OUMVw+Wj9JNZe5l+LnY2zZnIqpT663El8rs=;
X-UUID: 4d76d4903548490187c1f044308c533d-20191212
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1924915242; Thu, 12 Dec 2019 09:51:35 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:51:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:51:31 +0800
Message-ID: <1576115494.17653.21.camel@mtkswgap22>
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
Date:   Thu, 12 Dec 2019 09:51:34 +0800
In-Reply-To: <1576114297.11762.1.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-6-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575946181.16676.4.camel@mtksdaap41> <1576113221.17653.6.camel@mtkswgap22>
         <1576114297.11762.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFRodSwgMjAxOS0xMi0xMiBhdCAwOTozMSArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBUaHUsIDIwMTktMTItMTIgYXQgMDk6MTMgKzA4MDAs
IERlbm5pcy1ZQyBIc2llaCB3cm90ZToNCj4gPiBIaSBDSywNCj4gPiANCj4gPiBPbiBUdWUsIDIw
MTktMTItMTAgYXQgMTA6NDkgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiA+ID4gSGksIERlbm5pczoN
Cj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+ID4gPiA+IERvIHN1Y2Nlc3MgY2FsbGJhY2sgaW4gY2hhbm5lbCB3
aGVuIHNodXRkb3duLiBGb3IgdGhvc2UgdGFzayBub3QgZmluaXNoLA0KPiA+ID4gPiBjYWxsYmFj
ayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFzIGNoYW5jZSB0byBjbGVhbnVwIG9yIHJl
c2V0Lg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxk
ZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZl
cnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCj4gPiA+ID4g
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5j
IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gPiBpbmRleCBmZDUx
OWI2ZjUxOGIuLmMxMmE3NjhkMTE3NSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9tYWls
Ym94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5jDQo+ID4gPiA+IEBAIC00NTAsNiArNDUwLDMyIEBAIHN0YXRpYyBpbnQg
Y21kcV9tYm94X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gPiA+ID4gIA0KPiA+
ID4gPiAgc3RhdGljIHZvaWQgY21kcV9tYm94X3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4gKmNo
YW4pDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQgPSAo
c3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQo+ID4gPiA+ICsJc3RydWN0IGNt
ZHEgKmNtZHEgPSBkZXZfZ2V0X2RydmRhdGEoY2hhbi0+bWJveC0+ZGV2KTsNCj4gPiA+ID4gKwlz
dHJ1Y3QgY21kcV90YXNrICp0YXNrLCAqdG1wOw0KPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcgZmxh
Z3M7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdGhyZWFkLT5jaGFu
LT5sb2NrLCBmbGFncyk7DQo+ID4gPiA+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19i
dXN5X2xpc3QpKQ0KPiA+ID4gPiArCQlnb3RvIGRvbmU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlX
QVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsJLyogbWFrZSBzdXJlIGV4ZWN1dGVkIHRhc2tzIGhhdmUgc3VjY2VzcyBjYWxs
YmFjayAqLw0KPiA+ID4gPiArCWNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7
DQo+ID4gPiA+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KPiA+
ID4gPiArCQlnb3RvIGRvbmU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUodGFzaywgdG1wLCAmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCwNCj4gPiA+ID4gKwkJ
CQkgbGlzdF9lbnRyeSkgew0KPiA+ID4gPiArCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIC1F
Q09OTkFCT1JURUQpOw0KPiA+ID4gPiArCQlrZnJlZSh0YXNrKTsNCj4gPiA+ID4gKwl9DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKwljbWRxX3RocmVhZF9kaXNhYmxlKGNtZHEsIHRocmVhZCk7DQo+ID4g
PiA+ICsJY2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KPiA+ID4gPiArZG9uZToNCj4gPiA+IA0K
PiA+ID4gY21kcV90aHJlYWRfcmVzdW1lKHRocmVhZCk7DQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMs
DQo+ID4gPiBDSw0KPiA+ID4gDQo+ID4gDQo+ID4gQ2FsbCByZXN1bWUgaGVyZSB3aWxsIGNhdXNl
IHZpb2xhdGlvbi4gVGhlIHRocmVhZC0+dGFza19idXN5X2xpc3QgZW1wdHkNCj4gPiBtZWFucyBu
byB0YXNrIHdvcmsgaW4gZ2NlIGFuZCB0aHJlYWQgc3RhdGUgc2hvdWxkIGFscmVhZHkgZGlzYWJs
ZQ0KPiA+IHdpdGhvdXQgY2xvY2ssIHdoaWNoIGlzIHdoYXQgd2Ugd2FudCBzaW5jZSBjbGllbnQg
dHJ5IHRvIHNodXQgZG93biB0aGlzDQo+ID4gbWJveCBjaGFubmVsLiBTbyBJIHRoaW5rIHdlIGRv
bid0IG5lZWQgcmVzdW1lIGhlcmUuDQo+ID4gDQo+IA0KPiBPSy4gV2hlbiBjbGllbnQgZnJlZSBj
aGFubmVsLCB0aHJlYWQgaXMgc3VzcGVuZGVkLiBUaGVuIGNsaWVudCByZXF1ZXN0DQo+IGNoYW5u
ZWwsIHdoZXJlIGRvIHlvdSByZXN1bWUgdGhyZWFkPw0KPiANCg0Kd2hlbiBjbGllbnQgc2VuZCBu
ZXcgcGt0IHRvIG5ldyBjaGFubmVsLCBjbWRxX21ib3hfc2VuZF9kYXRhKCkgd2lsbA0KZW5hYmxl
IHRocmVhZC4NCg0KDQpSZWdhcmRzLA0KRGVubmlzDQoNCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+
ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBEZW5uaXMNCj4gPiANCj4gPiA+ID4gKwlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCj4gPiA+ID4gIH0NCj4g
PiA+ID4gIA0KPiA+ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtYm94X2NoYW5fb3BzIGNtZHFf
bWJveF9jaGFuX29wcyA9IHsNCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gDQo+IA0KPiANCg0K

