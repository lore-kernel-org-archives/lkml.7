Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EFC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B7327FB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HFaqQm0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfFCJUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:20:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56047 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbfFCJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:20:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x539G8qF016966;
        Mon, 3 Jun 2019 11:20:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=KP1E2smY61q6p4hXM1Poa06ylj50nuS1wWa3VqF16Hw=;
 b=HFaqQm0fM+7F/PSlDShv3fAXd4tCEhioUJFUpktHYtv5ej4P2yund40IoGpbUy3RoFb7
 y0KYACDxLfOLieIn71YtUCyn3sg1J+h0P6BoP3KWybqkqDw6789aMJoyimNIyvCB5A6j
 cGgA1yvkQeL3kDgm8jljxHwkrMvpDMjBKH34jqNl/MKvcfF9efDOPUixbGVrf22WLZpD
 kdmPChZA45thqjZeUYsc6jP6rbJSEURQwiEmpV10l+ZifMbj+VGp4dSP4kBuHRjlMv1f
 3D6eEGaXbd6UugL8HuNQXoNLkh5oRWtpJdHV0ZnHtwcNhu7TTRYy5rhF4rb4nQetXSjj Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sunmc13fk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Jun 2019 11:20:03 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 939683F;
        Mon,  3 Jun 2019 09:20:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B8BC2619;
        Mon,  3 Jun 2019 09:20:02 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Jun
 2019 11:20:02 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Mon, 3 Jun 2019 11:20:01 +0200
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mfd: stmfx: Uninitialized variable in stmfx_irq_handler()
Thread-Topic: [PATCH] mfd: stmfx: Uninitialized variable in
 stmfx_irq_handler()
Thread-Index: AQHVCwEO/u3xED8wwkiZua0lI4uaJqaJo4GA
Date:   Mon, 3 Jun 2019 09:20:01 +0000
Message-ID: <ccefbd0b-3397-a26e-95e7-059fcced9154@st.com>
References: <20190515093141.GA3409@mwanda>
In-Reply-To: <20190515093141.GA3409@mwanda>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC5391FCB7987D46B2273D74DD2C441A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuLA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2guIE9uZSBtaW5vciBjb21tZW50Og0KDQpP
biA1LzE1LzE5IDExOjMxIEFNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBUaGUgcHJvYmxlbSBp
cyB0aGF0IG9uIDY0Yml0IHN5c3RlbXMgdGhlbiB3ZSBkb24ndCBjbGVhciB0aGUgaGlnaGVyDQo+
IGJpdHMgb2YgdGhlICJwZW5kaW5nIiB2YXJpYWJsZS4gIFNvIHdoZW4gd2UgZG86DQo+IA0KPiAJ
YWNrID0gcGVuZGluZyAmIH5CSVQoU1RNRlhfUkVHX0lSUV9TUkNfRU5fR1BJTyk7DQo+IAlpZiAo
YWNrKSB7DQo+IA0KPiB0aGUgaWYgKGFjaykgY29uZGl0aW9uIHJlbGllcyBvbiB1bmluaXRpYWxp
emVkIGRhdGEuICBUaGUgZml4IGl0IHRoYXQNCj4gSSd2ZSBjaGFuZ2VkICJwZW5kaW5nIiBmcm9t
IGFuIHVuc2lnbmVkIGxvbmcgdG8gYSB1MzIuICBJIGNoYW5nZWQgIm4iIGFzDQo+IHdlbGwsIGJl
Y2F1c2UgdGhhdCdzIGEgbnVtYmVyIGluIHRoZSAwLTEwIHJhbmdlIGFuZCBpdCBmaXRzIGVhc2ls
eQ0KPiBpbnNpZGUgYW4gaW50LiAgV2UgZG8gbmVlZCB0byBhZGQgYSBjYXN0IHRvICJwZW5kaW5n
IiB3aGVuIHdlIHVzZSBpdCBpbg0KPiB0aGUgZm9yX2VhY2hfc2V0X2JpdCgpIGxvb3AsIGJ1dCB0
aGF0IGRvZXNuJ3QgY2F1c2UgYSBwcm9ibGUsIGl0J3MNCj4gZmluZS4NCj4gDQo+IEZpeGVzOiAw
NjI1MmFkZTkxNTYgKCJtZmQ6IEFkZCBTVCBNdWx0aS1GdW5jdGlvbiBlWHBhbmRlciAoU1RNRlgp
IGNvcmUgZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL21mZC9zdG1meC5jIHwgOCArKysr
LS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvc3RtZnguYyBiL2RyaXZlcnMvbWZkL3N0
bWZ4LmMNCj4gaW5kZXggZmU4ZWZiYTJkNDVmLi5mZWU3NWI1ZDA5OGUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbWZkL3N0bWZ4LmMNCj4gKysrIGIvZHJpdmVycy9tZmQvc3RtZnguYw0KPiBAQCAt
MjA0LDEyICsyMDQsMTIgQEAgc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBzdG1meF9pcnFfY2hpcCA9
IHsNCj4gICBzdGF0aWMgaXJxcmV0dXJuX3Qgc3RtZnhfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9p
ZCAqZGF0YSkNCj4gICB7DQo+ICAgCXN0cnVjdCBzdG1meCAqc3RtZnggPSBkYXRhOw0KPiAtCXVu
c2lnbmVkIGxvbmcgbiwgcGVuZGluZzsNCj4gKwl1MzIgcGVuZGluZzsNCj4gICAJdTMyIGFjazsN
Cj4gKwlpbnQgbjsNCj4gICAJaW50IHJldDsNCg0KQ291bGQgeW91IGdyb3VwOg0KDQp1MzIgcGVu
ZGluZywgYWNrOw0KaW50IG4sIHJldDsNCg0KPiAgIA0KPiAtCXJldCA9IHJlZ21hcF9yZWFkKHN0
bWZ4LT5tYXAsIFNUTUZYX1JFR19JUlFfUEVORElORywNCj4gLQkJCSAgKHUzMiAqKSZwZW5kaW5n
KTsNCj4gKwlyZXQgPSByZWdtYXBfcmVhZChzdG1meC0+bWFwLCBTVE1GWF9SRUdfSVJRX1BFTkRJ
TkcsICZwZW5kaW5nKTsNCj4gICAJaWYgKHJldCkNCj4gICAJCXJldHVybiBJUlFfTk9ORTsNCj4g
ICANCj4gQEAgLTIyNCw3ICsyMjQsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qgc3RtZnhfaXJxX2hh
bmRsZXIoaW50IGlycSwgdm9pZCAqZGF0YSkNCj4gICAJCQlyZXR1cm4gSVJRX05PTkU7DQo+ICAg
CX0NCj4gICANCj4gLQlmb3JfZWFjaF9zZXRfYml0KG4sICZwZW5kaW5nLCBTVE1GWF9SRUdfSVJR
X1NSQ19NQVgpDQo+ICsJZm9yX2VhY2hfc2V0X2JpdChuLCAodW5zaWduZWQgbG9uZyAqKSZwZW5k
aW5nLCBTVE1GWF9SRUdfSVJRX1NSQ19NQVgpDQo+ICAgCQloYW5kbGVfbmVzdGVkX2lycShpcnFf
ZmluZF9tYXBwaW5nKHN0bWZ4LT5pcnFfZG9tYWluLCBuKSk7DQo+ICAgDQo+ICAgCXJldHVybiBJ
UlFfSEFORExFRDsNCj4gDQoNCkkndmUgdGVzdGVkIGl0IG9uIHN0bTMybXAxNTdjLWV2MSwgc28g
eW91IGNhbiBhZGQgbXkNClRlc3RlZC1ieTogQW1lbGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVu
YXlAc3QuY29tPg0KDQpSZWdhcmRzLA0KQW1lbGll
