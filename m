Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF4C2BD09
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19112073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iXHtkFlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLJCtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:49:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40597 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbfLJCtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:49:49 -0500
X-UUID: 9c5509bccf6f4399b862490ffa15bd33-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3p9xe1k8UZpHU7V65IFk3agqCgquUJjR9B/HHNjxoE4=;
        b=iXHtkFlw5EqtcJGCRYIPyntinI+xVifE0nr4IvDgZRIl/aq4thDe3nIk9dpHgyrYFJW1BHUFdu3st2/sl8tVzGiUPavST++VF5LAuVQzb6fGTE398Cc8hjl+iNhjcQaiS6tIBarGU632FVV3ao18dQPePtT+3mScB4p/kRiohKo=;
X-UUID: 9c5509bccf6f4399b862490ffa15bd33-20191210
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2088386181; Tue, 10 Dec 2019 10:49:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 10:49:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 10:49:09 +0800
Message-ID: <1575946181.16676.4.camel@mtksdaap41>
Subject: Re: [PATCH v2 04/14] mailbox: mediatek: cmdq: clear task in channel
 before shutdown
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 10 Dec 2019 10:49:41 +0800
In-Reply-To: <1574819937-6246-6-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-6-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IERvIHN1Y2Nlc3MgY2FsbGJhY2sgaW4gY2hhbm5lbCB3aGVuIHNo
dXRkb3duLiBGb3IgdGhvc2UgdGFzayBub3QgZmluaXNoLA0KPiBjYWxsYmFjayB3aXRoIGVycm9y
IGNvZGUgdGh1cyBjbGllbnQgaGFzIGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAyNiAr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5jIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBpbmRleCBmZDUxOWI2
ZjUxOGIuLmMxMmE3NjhkMTE3NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYw0KPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5j
DQo+IEBAIC00NTAsNiArNDUwLDMyIEBAIHN0YXRpYyBpbnQgY21kcV9tYm94X3N0YXJ0dXAoc3Ry
dWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gIA0KPiAgc3RhdGljIHZvaWQgY21kcV9tYm94X3NodXRk
b3duKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+ICB7DQo+ICsJc3RydWN0IGNtZHFfdGhyZWFk
ICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQo+ICsJc3Ry
dWN0IGNtZHEgKmNtZHEgPSBkZXZfZ2V0X2RydmRhdGEoY2hhbi0+bWJveC0+ZGV2KTsNCj4gKwlz
dHJ1Y3QgY21kcV90YXNrICp0YXNrLCAqdG1wOw0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
ICsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+
ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KPiArCQlnb3RvIGRv
bmU7DQo+ICsNCj4gKwlXQVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8
IDApOw0KPiArDQo+ICsJLyogbWFrZSBzdXJlIGV4ZWN1dGVkIHRhc2tzIGhhdmUgc3VjY2VzcyBj
YWxsYmFjayAqLw0KPiArCWNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQo+
ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KPiArCQlnb3RvIGRv
bmU7DQo+ICsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUodGFzaywgdG1wLCAmdGhyZWFk
LT50YXNrX2J1c3lfbGlzdCwNCj4gKwkJCQkgbGlzdF9lbnRyeSkgew0KPiArCQljbWRxX3Rhc2tf
ZXhlY19kb25lKHRhc2ssIC1FQ09OTkFCT1JURUQpOw0KPiArCQlrZnJlZSh0YXNrKTsNCj4gKwl9
DQo+ICsNCj4gKwljbWRxX3RocmVhZF9kaXNhYmxlKGNtZHEsIHRocmVhZCk7DQo+ICsJY2xrX2Rp
c2FibGUoY21kcS0+Y2xvY2spOw0KPiArZG9uZToNCg0KY21kcV90aHJlYWRfcmVzdW1lKHRocmVh
ZCk7DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFk
LT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bWJveF9jaGFuX29wcyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7DQoNCg==

