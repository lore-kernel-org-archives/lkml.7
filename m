Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09519C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4F520740
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="mHjn7cvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfKRIvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:51:09 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14092 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbfKRIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:51:09 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8g912024724;
        Mon, 18 Nov 2019 09:50:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Npr6b/rvW2p3vyDbOovmjWkHvtCK3QNb78JsQ25FEE8=;
 b=mHjn7cvzJFqMewAxbVioRjex5Ekp46vR2PEgVQLGxrTbKetgequnsiDSb5l2SKi/LXVi
 QYmHVWLYed1W77JFeDKowzvnn6VCrxG3sUFhJj43s0UkXyUkp5yIx7yJf+7r9GGM2fXp
 x1BGGcqomuRTV/r4kykamnSWjm/Z2PjmEmxRy8Clsj76St1ALl6pxQbp1ikWjANck3Vi
 PG0bbtOqWR4DA6TegBC+Fl5wkBt/QZRfEkFAT9ox9GG/RYEcI09XIbDPujSzZ4m6P412
 jO8m8mzf0erUd/78PVR612/OATZqGNe6tRXoBXPTx+KD1eWnW4pUlBHlcFEwyWBHkrOo nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9unrate-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 09:50:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8DDB10002A;
        Mon, 18 Nov 2019 09:50:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5C542B8BE8;
        Mon, 18 Nov 2019 09:50:53 +0100 (CET)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 09:50:53 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Mon, 18 Nov 2019 09:50:53 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>
Subject: Re: [PATCH v4] remoteproc: stm32: fix probe error case
Thread-Topic: [PATCH v4] remoteproc: stm32: fix probe error case
Thread-Index: AQHVm5vlCsf8lNbU9ES36nbBAkDt6aeMhJuAgAQN+QA=
Date:   Mon, 18 Nov 2019 08:50:53 +0000
Message-ID: <ee487060-1eda-0716-9fba-48f806644632@st.com>
References: <1573812188-19842-1-git-send-email-fabien.dessenne@st.com>
 <20191115185549.GA17332@xps15>
In-Reply-To: <20191115185549.GA17332@xps15>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F74F2676284B340997AADED506AE1C1@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldQ0KDQoNCk9uIDE1LzExLzIwMTkgNzo1NSBQTSwgTWF0aGlldSBQb2lyaWVyIHdy
b3RlOg0KPiBIaSBGYWJpZW4sDQo+DQo+IE9uIEZyaSwgTm92IDE1LCAyMDE5IGF0IDExOjAzOjA4
QU0gKzAxMDAsIEZhYmllbiBEZXNzZW5uZSB3cm90ZToNCj4+IElmIHRoZSBycHJvYyBkcml2ZXIg
aXMgcHJvYmVkIGJlZm9yZSB0aGUgbWFpbGJveCBkcml2ZXIgYW5kIGlmIHRoZSBycHJvYw0KPj4g
RGV2aWNlIFRyZWUgbm9kZSBoYXMgc29tZSBtYWlsYm94IHByb3BlcnRpZXMsIHRoZSBycHJvYyBk
cml2ZXIgcHJvYmUNCj4+IHNoYWxsIGJlIGRlZmVycmVkIGluc3RlYWQgb2YgYmVpbmcgcHJvYmVk
IHdpdGhvdXQgbWFpbGJveCBzdXBwb3J0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZhYmllbiBE
ZXNzZW5uZSA8ZmFiaWVuLmRlc3Nlbm5lQHN0LmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBzaW5j
ZSB2Mzogb24gZXJyb3IsIGZyZWUgbWFpbGJveGVzIGZyb20gc3RtMzJfcnByb2NfcmVxdWVzdF9t
Ym94KCkNCj4+IENoYW5nZXMgc2luY2UgdjI6IGZyZWUgb3RoZXIgcmVxdWVzdGVkIG1haWxib3hl
cyBhZnRlciBvbmUgcmVxdWVzdCBmYWlscw0KPj4gQ2hhbmdlcyBzaW5jZSB2MTogdGVzdCBJU19F
UlIoKSBiZWZvcmUgY2hlY2tpbmcgUFRSX0VSUigpDQo+PiAtLS0NCj4+ICAgZHJpdmVycy9yZW1v
dGVwcm9jL3N0bTMyX3Jwcm9jLmMgfCAxNyArKysrKysrKysrKysrKystLQ0KPj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL3N0bTMyX3Jwcm9jLmMgYi9kcml2ZXJzL3JlbW90ZXBy
b2Mvc3RtMzJfcnByb2MuYw0KPj4gaW5kZXggMmNmNGIyOS4uYmNlYmI3OCAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9zdG0zMl9ycHJvYy5jDQo+PiArKysgYi9kcml2ZXJzL3Jl
bW90ZXByb2Mvc3RtMzJfcnByb2MuYw0KPj4gQEAgLTMxMCwxMSArMzEwLDEyIEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc3RtMzJfbWJveCBzdG0zMl9ycHJvY19tYm94W01CT1hfTkJfTUJYXSA9IHsN
Cj4+ICAgCX0NCj4+ICAgfTsNCj4+ICAgDQo+PiAtc3RhdGljIHZvaWQgc3RtMzJfcnByb2NfcmVx
dWVzdF9tYm94KHN0cnVjdCBycHJvYyAqcnByb2MpDQo+PiArc3RhdGljIGludCBzdG0zMl9ycHJv
Y19yZXF1ZXN0X21ib3goc3RydWN0IHJwcm9jICpycHJvYykNCj4+ICAgew0KPj4gICAJc3RydWN0
IHN0bTMyX3Jwcm9jICpkZGF0YSA9IHJwcm9jLT5wcml2Ow0KPj4gICAJc3RydWN0IGRldmljZSAq
ZGV2ID0gJnJwcm9jLT5kZXY7DQo+PiAgIAl1bnNpZ25lZCBpbnQgaTsNCj4+ICsJaW50IGo7DQo+
PiAgIAljb25zdCB1bnNpZ25lZCBjaGFyICpuYW1lOw0KPj4gICAJc3RydWN0IG1ib3hfY2xpZW50
ICpjbDsNCj4+ICAgDQo+PiBAQCAtMzI5LDEwICszMzAsMjAgQEAgc3RhdGljIHZvaWQgc3RtMzJf
cnByb2NfcmVxdWVzdF9tYm94KHN0cnVjdCBycHJvYyAqcnByb2MpDQo+PiAgIA0KPj4gICAJCWRk
YXRhLT5tYltpXS5jaGFuID0gbWJveF9yZXF1ZXN0X2NoYW5uZWxfYnluYW1lKGNsLCBuYW1lKTsN
Cj4+ICAgCQlpZiAoSVNfRVJSKGRkYXRhLT5tYltpXS5jaGFuKSkgew0KPj4gKwkJCWlmIChQVFJf
RVJSKGRkYXRhLT5tYltpXS5jaGFuKSA9PSAtRVBST0JFX0RFRkVSKQ0KPj4gKwkJCQlnb3RvIGVy
cl9wcm9iZTsNCj4+ICAgCQkJZGV2X3dhcm4oZGV2LCAiY2Fubm90IGdldCAlcyBtYm94XG4iLCBu
YW1lKTsNCj4+ICAgCQkJZGRhdGEtPm1iW2ldLmNoYW4gPSBOVUxMOw0KPj4gICAJCX0NCj4+ICAg
CX0NCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiArDQo+PiArZXJyX3Byb2JlOg0KPj4gKwlmb3Ig
KGogPSBpIC0gMTsgaiA+PSAwOyBqLS0pDQo+PiArCQlpZiAoZGRhdGEtPm1iW2pdLmNoYW4pDQo+
PiArCQkJbWJveF9mcmVlX2NoYW5uZWwoZGRhdGEtPm1iW2pdLmNoYW4pOw0KPiBEbyB5b3UgbmVl
ZCB0byBzZXQgZGRhdGEtPm1iW2ldLmNoYW4gdG8gTlVMTCBhcyBpdCBpcyBkb25lIGluDQo+IHN0
bTMyX3Jwcm9jX2ZyZWVfbWJveD8NCg0KVGhpcyBpcyBwcm9iYWJseSB1c2VsZXNzIDogd2hlbiB3
ZSBoaXQgdGhpcyBlcnJvciwgd2UgZXhpdCB0aGUgcHJvYmUgDQpmdW5jdGlvbiB3aXRob3V0IGFu
eSBuZWVkIHRvIHRyYWNrIHRoZSBjaGFubmVscyBzdGF0dXMuIExhdGVyIHdoZW4gdGhlIA0KcHJv
YmUgZGVmZXJyYWwgdHJpZ2dlcnMgdGhlIHByb2JlIGNhbGwgYWdhaW4sIHJwcm9jX2FsbG9jKCkg
aXMgY2FsbGVkIA0KYW5kIHplcm8tYWxsb2NhdGVzIHRoZSBwcml2YXRlIGRhdGEgKD1jaGFubmVs
cywgLi4uKQ0KDQpUaGUgYXNzaWdubWVudCB0byBOVUxMIGluIHN0bTMyX3Jwcm9jX2ZyZWVfbWJv
eCBpcyBwcm9iYWJseSB1c2VsZXNzIHRvbywgDQpidXQgSSBwcmVmZXIgdG8gbm90IGNsZWFuIGl0
IHVwIG5vdy4NCg0KDQo+DQo+IEFsc28gSSdtIHdvbmRlcmluZyBhYm91dCB0aGUgZXJyb3IgcGF0
aCBmb3IgdGhpcyBmdW5jdGlvbi4gIElmIHNvbWV0aGluZyBnb2VzDQo+IHdyb25nIGluIG1ib3hf
cmVxdWVzdF9jaGFubmVsX2J5bmFtZSgpIG5vbmUgb2YgdGhlIHByZXZpb3VzbHkgYWxsb2NhdGVk
IGNoYW5uZWxzDQo+IGFyZSBmcmVlZCBhbmQgbm8gZnVydGhlciBhY3Rpb25zIGlzIHRha2VuLiAg
U2hvdWxkIHdlIHNpbXBseSBhYm9ydCB0aGUgcHJvYmluZw0KPiBvZiB0aGUgcnByb2MgaWYgYW55
IG9mIGNoYW5uZWxzIGNhbid0IGJlIHByb2JlZD8NCg0KVGhlIG1haWxib3hlcyBhcmUgb3B0aW9u
YWwgKHNwZWNpZmllZCBhcyBEVCBvcHRpb25hbCBwcm9wZXJ0aWVzKSBzbyB3ZSANCnNoYWxsIG5v
dCBicmVhayBvbiBtYm94X3JlcXVlc3RfY2hhbm5lbCgpIGVycm9ycy4NCg0KDQo+DQo+IFJlZ2Fy
ZGxlc3Mgb2YgdGhlIGFib3ZlIGFuZCB3aXRob3V0IHN1cnByaXNlOg0KPg0KPiBUZXN0ZWQtYnk6
IE1hdGhpZXUgUG9pcmllciA8bWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc+DQpUaGFuayB5b3Ug
OikNCj4NCj4+ICsJcmV0dXJuIC1FUFJPQkVfREVGRVI7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIHN0
YXRpYyBpbnQgc3RtMzJfcnByb2Nfc2V0X2hvbGRfYm9vdChzdHJ1Y3QgcnByb2MgKnJwcm9jLCBi
b29sIGhvbGQpDQo+PiBAQCAtNTk2LDcgKzYwNyw5IEBAIHN0YXRpYyBpbnQgc3RtMzJfcnByb2Nf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgCWlmIChyZXQpDQo+PiAg
IAkJZ290byBmcmVlX3Jwcm9jOw0KPj4gICANCj4+IC0Jc3RtMzJfcnByb2NfcmVxdWVzdF9tYm94
KHJwcm9jKTsNCj4+ICsJcmV0ID0gc3RtMzJfcnByb2NfcmVxdWVzdF9tYm94KHJwcm9jKTsNCj4+
ICsJaWYgKHJldCkNCj4+ICsJCWdvdG8gZnJlZV9ycHJvYzsNCj4+ICAgDQo+PiAgIAlyZXQgPSBy
cHJvY19hZGQocnByb2MpOw0KPj4gICAJaWYgKHJldCkNCj4+IC0tIA0KPj4gMi43LjQNCj4+DQo+
Pg0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+
IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+PiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbA==
