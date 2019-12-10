Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1370FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD36B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J8Hz74sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfLJHzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:55:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:12187 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726062AbfLJHzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:55:21 -0500
X-UUID: fbe1b8f9fdfa449ea7285c67eebc5ec6-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JVrSUftnU6zu374DeJmbQdbn/1WkZQorVyvlrHedkhs=;
        b=J8Hz74skYS0bk9AvTrD9mhRNxhLc3pvsAtBW5vPw3WtPridK15sZIT/xtXMoGkD472VvxtmnWYbvSfenov/4xFZtChoPm4IB/N2xN0roxiYnzIgf+Mrn8BKedQEgUXKgLuWOuTtFWpCqSLFo2rrH3u5CJu6AzTb53xJdH/NWAHE=;
X-UUID: fbe1b8f9fdfa449ea7285c67eebc5ec6-20191210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1197431199; Tue, 10 Dec 2019 15:55:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 15:54:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 15:55:19 +0800
Message-ID: <1575964515.13210.3.camel@mtksdaap41>
Subject: Re: [PATCH v2 09/14] soc: mediatek: cmdq: add read_s function
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
Date:   Tue, 10 Dec 2019 15:55:15 +0800
In-Reply-To: <1574819937-6246-11-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-11-git-send-email-dennis-yc.hsieh@mediatek.com>
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
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCByZWFkX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVu
Y3Rpb25zIHdoaWNoIHN1cHBvcnQgcmVhZCB2YWx1ZSBmcm9tDQo+IHJlZ2lzdGVyIG9yIGRtYSBw
aHlzaWNhbCBhZGRyZXNzIGludG8gZ2NlIGludGVybmFsIHJlZ2lzdGVyLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAyMCAr
KysrKysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guaCB8ICAxICsNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
ICAgfCAxMCArKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IDJlZGJj
MDk1NGQ5Ny4uMmNkNjkzZTM0OTgwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KPiBAQCAtMjMxLDYgKzIzMSwyNiBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFz
ayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJP
TChjbWRxX3BrdF93cml0ZV9tYXNrKTsNCj4gIA0KPiAraW50IGNtZHFfcGt0X3JlYWRfcyhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCwgcGh5c19hZGRyX3QgYWRkciwgdTE2IHJlZ19pZHgpDQo+ICt7DQoN
ClNob3VsZCBhZGRyIGJlIHNoaWZ0ZWQgaW4gbXQ2Nzc5Pw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAr
CXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiArCWludCBlcnI7DQo+
ICsJY29uc3QgdTE2IHNyY19yZWdfaWR4ID0gQ01EUV9TUFJfVEVNUDsNCj4gKw0KPiArCWVyciA9
IGNtZHFfcGt0X2Fzc2lnbihwa3QsIHNyY19yZWdfaWR4LCBDTURRX0FERFJfSElHSChhZGRyKSk7
DQo+ICsJaWYgKGVyciA8IDApDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwlpbnN0Lm9wID0g
Q01EUV9DT0RFX1JFQURfUzsNCj4gKwlpbnN0LmRzdF90ID0gQ01EUV9SRUdfVFlQRTsNCj4gKwlp
bnN0LnNvcCA9IHNyY19yZWdfaWR4Ow0KPiArCWluc3QucmVnX2RzdCA9IHJlZ19pZHg7DQo+ICsJ
aW5zdC5hcmdfYiA9IENNRFFfQUREUl9MT1coYWRkcik7DQo+ICsNCj4gKwlyZXR1cm4gY21kcV9w
a3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0woY21k
cV9wa3RfcmVhZF9zKTsNCj4gKw0KPiAgaW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIsIHUxNiByZWdfaWR4LA0KPiAgCQkgICAgIHUzMiBt
YXNrKQ0KPiAgew0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRx
LW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4g
aW5kZXggOGVmODdlMWJkMDNiLi4zZjZiYzBkZmQ1ZGEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9t
YWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBAQCAtNTksNiArNTksNyBAQCBlbnVtIGNtZHFf
Y29kZSB7DQo+ICAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KPiAgCUNNRFFfQ09ERV9XRkUgPSAw
eDIwLA0KPiAgCUNNRFFfQ09ERV9FT0MgPSAweDQwLA0KPiArCUNNRFFfQ09ERV9SRUFEX1MgPSAw
eDgwLA0KPiAgCUNNRFFfQ09ERV9XUklURV9TID0gMHg5MCwNCj4gIAlDTURRX0NPREVfV1JJVEVf
U19NQVNLID0gMHg5MSwNCj4gIAlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5kZXggNTZmZjE5NzAxOTdjLi5iYzI4YTQxZDc3
ODAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgN
Cj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMTA2
LDYgKzEwNiwxNiBAQCBpbnQgY21kcV9wa3Rfd3JpdGUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4
IHN1YnN5cywgdTE2IG9mZnNldCwgdTMyIHZhbHVlKTsNCj4gIGludCBjbWRxX3BrdF93cml0ZV9t
YXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICAJCQl1MTYgb2Zmc2V0LCB1
MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gIA0KPiArLyoqDQo+ICsgKiBjbWRxX3BrdF9yZWFkX3Mo
KSAtIGFwcGVuZCByZWFkX3MgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gKyAqIEBwa3Q6
CXRoZSBDTURRIHBhY2tldA0KPiArICogQGFkZHI6CXRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIHJl
Z2lzdGVyIG9yIGRtYSB0byByZWFkDQo+ICsgKiBAcmVnX2lkeDoJdGhlIENNRFEgaW50ZXJuYWwg
cmVnaXN0ZXIgSUQgdG8gY2FjaGUgcmVhZCBkYXRhDQo+ICsgKg0KPiArICogUmV0dXJuOiAwIGZv
ciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ICsgKi8NCj4gK2lu
dCBjbWRxX3BrdF9yZWFkX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIs
IHUxNiByZWdfaWR4KTsNCj4gKw0KPiAgLyoqDQo+ICAgKiBjbWRxX3BrdF93cml0ZV9zX21hc2so
KSAtIGFwcGVuZCB3cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ICAgKiBAcGt0
Ogl0aGUgQ01EUSBwYWNrZXQNCg0K

