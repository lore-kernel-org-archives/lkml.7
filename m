Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D070AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D4421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="y4lAKSci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfDXNjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:39:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31692 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730462AbfDXNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:39:42 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ODbcsF002995;
        Wed, 24 Apr 2019 15:39:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Wg65FVOwwOJ8gKv+dGZjJ5twwwzOQXRLRqnQ7xWVYGU=;
 b=y4lAKScifXJ5YQ0PxILnXXzejLF0OWO1Hc8v+0vG8lv1nMIx76l/zoB3h8yBRT2dnTO4
 /uBkAE/DV0ILBiXs3vLKrgWofAEAb8mKh9zmtLvMysis9RIpdr/zRvuAIfZdUfYom4BT
 a4XYh2nz4YDnszHcQCiuaH+sSnAfoWviWyfbnVHkabFYqinfEMG44EuMEe5kCCsJYVft
 IasXlP/I+GVsT7le0oAg6hro1W8fA0er04juBmErskXG4n92/2GqrT0XN2ldqIZ/SZTD
 oYVOCdUxZHHld9wWGEN9l3XVPjDeZC3mc8M6VOsnRQabaaG6R1mcKR6h7oPWQBwVChNH TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6rwq42-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 15:39:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5DB7931;
        Wed, 24 Apr 2019 13:39:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21CE226B4;
        Wed, 24 Apr 2019 13:39:24 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 15:39:23 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 24 Apr 2019 15:39:23 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        Yannick FERTRE <yannick.fertre@st.com>
CC:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/5] of/device: Add of_ functions for
 device_link_{add,remove}
Thread-Topic: [PATCH 1/5] of/device: Add of_ functions for
 device_link_{add,remove}
Thread-Index: AQHU+oc37LMrmwzwhEGk0uqRwGdBwqZLJpUAgAAJFQA=
Date:   Wed, 24 Apr 2019 13:39:23 +0000
Message-ID: <a762a6b6-a039-3b80-e1dc-edbc2ebcde7c@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
 <20190424101913.1534-2-benjamin.gaignard@st.com>
 <d038f078-08dc-41ff-edc2-12f37d88a8a3@intel.com>
In-Reply-To: <d038f078-08dc-41ff-edc2-12f37d88a8a3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB55C97BB3984545BA608CBDC723BAC4@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzI0LzE5IDM6MDYgUE0sIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiA0LzI0
LzIwMTkgMTI6MTkgUE0sIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4gQWxsb3dzIHRvIGNy
ZWF0ZSBhbmQgcmVtb3ZlIGxpbmtzIGJldHdlZW4gY29uc3VtZXIgYW5kIHN1cHBsaWVycyBmcm9t
DQo+PiBkZXZpY2UtdHJlZSBkYXRhLiBVc2UgJ2xpbmtzLWFkZCcgcHJvcGVydHkgZnJvbSBjb25z
dW1lciBub2RlIHRvIHNldHVwDQo+PiBhIGxpbmsgd2l0aCBhIGxpc3Qgb2Ygc3VwcGxpZXJzLg0K
Pg0KPiBPbmUgaW1tZWRpYXRlIHF1ZXN0aW9uIGFib3V0IHRoaXMgb25lIGlzIHdoeSBzdGF0ZWxl
c3MgbGlua3MgYXJlIA0KPiBiZXR0ZXIgaGVyZT8NClRoZXkgYXJlbid0IGJldHRlciwgaXQgaXMg
anVzdCBiZWNhdXNlIEkgd2FudGVkIHRvIGtlZXAgb25lIG9mXyBmdW5jdGlvbiANCmZvciBlYWNo
IHJlbGF0ZWQgZGV2aWNlX2xpbmtfKiBmdW5jdGlvbnMuDQo+DQo+PiBDb25zdW1lcnMgd2lsbCBi
ZSBzdXNwZW5kIGJlZm9yZSB0aGVpciBzdXBwbGllcnMgYW5kIHJlc3VtZSBhZnRlciB0aGVtLg0K
Pj4NCj4+IEFkZCBkZXZtX29mX2RldmljZV9saW5rc19hZGQoKSB0byBhdXRvbWF0aWNhbGx5IHJl
bW92ZSB0aGUgbGlua3MNCj4+IHdoZW4gdGhlIGRldmljZSBpcyB1bmJvdW5kIGZyb20gdGhlIGJ1
cy4NCj4NCj4gQW5kIHRoaXMgbWlnaHQgbm90IGJlIG5lY2Vzc2FyeSBldmVuIHdpdGggbWFuYWdl
ZCBsaW5rcy4NCg0KSSBndWVzcyBJIGNvdWxkIHVzZSBETF9GTEFHX1BNX1JVTlRJTUUgYW5kIERM
X0ZMQUdfQVVUT1JFTU9WRV9DT05TVU1FUiANCmZsYWdzIGFuZCBqdXN0IGtlZXANCg0Kb2ZfZGV2
aWNlX2xpbmtzX2FkZCgpIGJ1dCB0aGUgbmFtaW5nIHdpbGwgbm90IGJlIGV4cGxpY2l0Lg0KDQo+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRA
c3QuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL29mL2RldmljZS5jwqDCoMKgwqDCoMKgIHwg
MTAzIA0KPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4gwqAgaW5jbHVkZS9saW51eC9vZl9kZXZpY2UuaCB8wqAgMjAgKysrKysrKysrDQo+PiDCoCAy
IGZpbGVzIGNoYW5nZWQsIDEyMyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvb2YvZGV2aWNlLmMgYi9kcml2ZXJzL29mL2RldmljZS5jDQo+PiBpbmRleCAzNzE3ZjJh
MjBkMGQuLjAxMWJhOWJmNzY0MiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvb2YvZGV2aWNlLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvb2YvZGV2aWNlLmMNCj4+IEBAIC0zMzYsMyArMzM2LDEwNiBAQCBp
bnQgb2ZfZGV2aWNlX3VldmVudF9tb2RhbGlhcyhzdHJ1Y3QgZGV2aWNlIA0KPj4gKmRldiwgc3Ry
dWN0IGtvYmpfdWV2ZW50X2VudiAqZW52KQ0KPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+IMKg
IH0NCj4+IMKgIEVYUE9SVF9TWU1CT0xfR1BMKG9mX2RldmljZV91ZXZlbnRfbW9kYWxpYXMpOw0K
Pj4gKw0KPj4gKy8qKg0KPj4gKyAqIG9mX2RldmljZV9saW5rc19hZGQgLSBDcmVhdGUgbGlua3Mg
YmV0d2VlbiBjb25zdW1lciBhbmQgc3VwcGxpZXJzIA0KPj4gZnJvbQ0KPj4gKyAqIGRldmljZSB0
cmVlIGRhdGENCj4+ICsgKg0KPj4gKyAqIEBjb25zdW1lcjogY29uc3VtZXIgZGV2aWNlDQo+PiAr
ICoNCj4+ICsgKiBSZXR1cm5zIDAgb24gc3VjY2VzcywgPCAwIG9uIGZhaWx1cmUuDQo+PiArICov
DQo+PiAraW50IG9mX2RldmljZV9saW5rc19hZGQoc3RydWN0IGRldmljZSAqY29uc3VtZXIpDQo+
PiArew0KPj4gK8KgwqDCoCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPj4gK8KgwqDCoCBzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Ow0KPj4gK8KgwqDCoCBpbnQgaSA9IDA7DQo+PiArDQo+
PiArwqDCoMKgIG5wID0gb2ZfcGFyc2VfcGhhbmRsZShjb25zdW1lci0+b2Zfbm9kZSwgImxpbmtz
LWFkZCIsIGkrKyk7DQo+PiArwqDCoMKgIHdoaWxlIChucCkgew0KPj4gK8KgwqDCoMKgwqDCoMKg
IHBkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKG5wKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBv
Zl9ub2RlX3B1dChucCk7DQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFwZGV2KQ0KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKg
wqAgZGV2aWNlX2xpbmtfYWRkKGNvbnN1bWVyLCAmcGRldi0+ZGV2LCBETF9GTEFHX1NUQVRFTEVT
Uyk7DQo+PiArwqDCoMKgwqDCoMKgwqAgcGxhdGZvcm1fZGV2aWNlX3B1dChwZGV2KTsNCj4+ICsN
Cj4+ICvCoMKgwqDCoMKgwqDCoCBucCA9IG9mX3BhcnNlX3BoYW5kbGUoY29uc3VtZXItPm9mX25v
ZGUsICJsaW5rcy1hZGQiLCBpKyspOw0KPj4gK8KgwqDCoCB9DQo+PiArDQo+PiArwqDCoMKgIHJl
dHVybiAwOw0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTChvZl9kZXZpY2VfbGlua3NfYWRk
KTsNCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBvZl9kZXZpY2VfbGlua3NfcmVtb3ZlIC0gUmVtb3Zl
IGxpbmtzIGJldHdlZW4gY29uc3VtZXIgYW5kIA0KPj4gc3VwcGxpZXJzIGZyb20NCj4+ICsgKiBk
ZXZpY2UgdHJlZSBkYXRhDQo+PiArICoNCj4+ICsgKiBAY29uc3VtZXI6IGNvbnN1bWVyIGRldmlj
ZQ0KPj4gKyAqDQo+PiArICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIDwgMCBvbiBmYWlsdXJlLg0K
Pj4gKyAqLw0KPj4gK2ludCBvZl9kZXZpY2VfbGlua3NfcmVtb3ZlKHN0cnVjdCBkZXZpY2UgKmNv
bnN1bWVyKQ0KPj4gK3sNCj4+ICvCoMKgwqAgc3RydWN0IGRldmljZV9ub2RlICpucDsNCj4+ICvC
oMKgwqAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsNCj4+ICvCoMKgwqAgaW50IGkgPSAw
Ow0KPj4gKw0KPj4gK8KgwqDCoCBucCA9IG9mX3BhcnNlX3BoYW5kbGUoY29uc3VtZXItPm9mX25v
ZGUsICJsaW5rcy1hZGQiLCBpKyspOw0KPj4gK8KgwqDCoCB3aGlsZSAobnApIHsNCj4+ICvCoMKg
wqDCoMKgwqDCoCBwZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShucCk7DQo+PiArwqDCoMKg
wqDCoMKgwqAgb2Zfbm9kZV9wdXQobnApOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghcGRldikN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPj4gKw0KPj4gK8Kg
wqDCoMKgwqDCoMKgIGRldmljZV9saW5rX3JlbW92ZShjb25zdW1lciwgJnBkZXYtPmRldik7DQo+
PiArwqDCoMKgwqDCoMKgwqAgcGxhdGZvcm1fZGV2aWNlX3B1dChwZGV2KTsNCj4+ICsNCj4+ICvC
oMKgwqDCoMKgwqDCoCBucCA9IG9mX3BhcnNlX3BoYW5kbGUoY29uc3VtZXItPm9mX25vZGUsICJs
aW5rcy1hZGQiLCBpKyspOw0KPj4gK8KgwqDCoCB9DQo+PiArDQo+PiArwqDCoMKgIHJldHVybiAw
Ow0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTChvZl9kZXZpY2VfbGlua3NfcmVtb3ZlKTsN
Cj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBkZXZtX29mX2RldmljZV9saW5rc19yZW1vdmUoc3RydWN0
IGRldmljZSAqZGV2LCB2b2lkICpyZXMpDQo+PiArew0KPj4gK8KgwqDCoCBvZl9kZXZpY2VfbGlu
a3NfcmVtb3ZlKCooc3RydWN0IGRldmljZSAqKilyZXMpOw0KPj4gK30NCj4+ICsNCj4+ICsvKioN
Cj4+ICsgKiBkZXZtX29mX2RldmljZV9saW5rc19hZGQgLSBDcmVhdGUgbGlua3MgYmV0d2VlbiBj
b25zdW1lciBhbmQgDQo+PiBzdXBwbGllcnMNCj4+ICsgKiBmcm9tIGRldmljZSB0cmVlIGRhdGEN
Cj4+ICsgKg0KPj4gKyAqIEBjb25zdW1lcjogY29uc3VtZXIgZGV2aWNlDQo+PiArICoNCj4+ICsg
KiBSZXR1cm5zIDAgb24gc3VjY2VzcywgPCAwIG9uIGZhaWx1cmUuDQo+PiArICoNCj4+ICsgKiBT
aW1pbGFyIHRvIG9mX2RldmljZV9saW5rc19hZGQoKSwgYnV0IHdpbGwgYXV0b21hdGljYWxseSBj
YWxsDQo+PiArICogb2ZfZGV2aWNlX2xpbmtzX3JlbW92ZSgpIHdoZW4gdGhlIGRldmljZSBpcyB1
bmJvdW5kIGZyb20gdGhlIGJ1cy4NCj4+ICsgKi8NCj4+ICtpbnQgZGV2bV9vZl9kZXZpY2VfbGlu
a3NfYWRkKHN0cnVjdCBkZXZpY2UgKmNvbnN1bWVyKQ0KPj4gK3sNCj4+ICvCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgZGV2aWNlICoqcHRyOw0KPj4gK8KgwqDCoCBpbnQgcmV0Ow0KPj4gKw0KPj4gK8Kg
wqDCoCBpZiAoIWNvbnN1bWVyKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0K
Pj4gKw0KPj4gK8KgwqDCoCBwdHIgPSBkZXZyZXNfYWxsb2MoZGV2bV9vZl9kZXZpY2VfbGlua3Nf
cmVtb3ZlLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKCpwdHIpLCBH
RlBfS0VSTkVMKTsNCj4+ICvCoMKgwqAgaWYgKCFwdHIpDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTk9NRU07DQo+PiArDQo+PiArwqDCoMKgIHJldCA9IG9mX2RldmljZV9saW5rc19hZGQo
Y29uc3VtZXIpOw0KPj4gK8KgwqDCoCBpZiAocmV0IDwgMCkgew0KPj4gK8KgwqDCoMKgwqDCoMKg
IGRldnJlc19mcmVlKHB0cik7DQo+PiArwqDCoMKgIH0gZWxzZSB7DQo+PiArwqDCoMKgwqDCoMKg
wqAgKnB0ciA9IGNvbnN1bWVyOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGRldnJlc19hZGQoY29uc3Vt
ZXIsIHB0cik7DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqAgcmV0dXJuIHJldDsNCj4+
ICt9DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoZGV2bV9vZl9kZXZpY2VfbGlua3NfYWRkKTsNCj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L29mX2RldmljZS5oIGIvaW5jbHVkZS9saW51eC9v
Zl9kZXZpY2UuaA0KPj4gaW5kZXggOGQzMWUzOWRkNTY0Li5hZDAxZGI2ODI4ZTggMTAwNjQ0DQo+
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L29mX2RldmljZS5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4
L29mX2RldmljZS5oDQo+PiBAQCAtNDEsNiArNDEsMTEgQEAgZXh0ZXJuIGludCBvZl9kZXZpY2Vf
cmVxdWVzdF9tb2R1bGUoc3RydWN0IGRldmljZSANCj4+ICpkZXYpOw0KPj4gwqAgZXh0ZXJuIHZv
aWQgb2ZfZGV2aWNlX3VldmVudChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCANCj4+IGtvYmpf
dWV2ZW50X2VudiAqZW52KTsNCj4+IMKgIGV4dGVybiBpbnQgb2ZfZGV2aWNlX3VldmVudF9tb2Rh
bGlhcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCANCj4+IGtvYmpfdWV2ZW50X2VudiAqZW52
KTsNCj4+IMKgICsNCj4+ICtleHRlcm4gaW50IG9mX2RldmljZV9saW5rc19hZGQoc3RydWN0IGRl
dmljZSAqY29uc3VtZXIpOw0KPj4gK2V4dGVybiBpbnQgb2ZfZGV2aWNlX2xpbmtzX3JlbW92ZShz
dHJ1Y3QgZGV2aWNlICpjb25zdW1lcik7DQo+PiArZXh0ZXJuIGludCBkZXZtX29mX2RldmljZV9s
aW5rc19hZGQoc3RydWN0IGRldmljZSAqY29uc3VtZXIpOw0KPj4gKw0KPj4gwqAgc3RhdGljIGlu
bGluZSB2b2lkIG9mX2RldmljZV9ub2RlX3B1dChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiDCoCB7
DQo+PiDCoMKgwqDCoMKgIG9mX25vZGVfcHV0KGRldi0+b2Zfbm9kZSk7DQo+PiBAQCAtOTEsNiAr
OTYsMjEgQEAgc3RhdGljIGlubGluZSBpbnQgb2ZfZGV2aWNlX3VldmVudF9tb2RhbGlhcyhzdHJ1
Y3QgDQo+PiBkZXZpY2UgKmRldiwNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7DQo+PiDC
oCB9DQo+PiDCoCArc3RhdGljIGludCBvZl9kZXZpY2VfbGlua3NfYWRkKHN0cnVjdCBkZXZpY2Ug
KmNvbnN1bWVyKQ0KPj4gK3sNCj4+ICvCoMKgwqAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4g
K3N0YXRpYyBpbnQgb2ZfZGV2aWNlX2xpbmtzX3JlbW92ZShzdHJ1Y3QgZGV2aWNlICpjb25zdW1l
cikNCj4+ICt7DQo+PiArwqDCoMKgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMg
aW50IGRldm1fb2ZfZGV2aWNlX2xpbmtzX2FkZChzdHJ1Y3QgZGV2aWNlICpjb25zdW1lcikNCj4+
ICt7DQo+PiArwqDCoMKgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+IMKgIHN0YXRpYyBpbmxp
bmUgdm9pZCBvZl9kZXZpY2Vfbm9kZV9wdXQoc3RydWN0IGRldmljZSAqZGV2KSB7IH0NCj4+IMKg
IMKgIHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqX19vZl9tYXRjaF9k
ZXZpY2UoDQo+DQo+
