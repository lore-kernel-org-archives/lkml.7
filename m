Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE66C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BF020716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QCZBynWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfLQKWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:22:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbfLQKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:22:15 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHA8Tf2013901;
        Tue, 17 Dec 2019 11:22:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Cb/tDPl2HQwN1b/zcPQrK850sACKfnslSiYb6ZuPhcQ=;
 b=QCZBynWwNYgO+OFQltp2W4e0lVRuMW0IBO+vUxTp9vwjBifAbDfzE/dJvlttwR6UDicZ
 VexGPMP7QqUZhyEWsKkzEWl1opLk6Rx44qnC2a29ymJqaOlmhsn7tl8+uO4ADCVHjiSE
 8889Sm7yL6YMVQGGO+CcHaBPRPZA7LaAW+FfxxBxDj73NgmPcvBIIoEDedBtIZBNbfUS
 M5vclofQoejGJMyM2UPBsq+cTIyU140/YHw/fWcR/5fUoJijWBXx+RKpVvrLqndQ59lM
 uECbtRCaykB7kaQRxVsakBHbE+EHK+GyMI4SkB5McpACrGNhVH2P8gopen9PJl7IgTSA mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wvnree9dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 11:22:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43F3310003A;
        Tue, 17 Dec 2019 11:21:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2928D2AA04D;
        Tue, 17 Dec 2019 11:21:58 +0100 (CET)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 11:21:57 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Tue, 17 Dec 2019 11:21:57 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, "od@zcrc.me" <od@zcrc.me>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
Thread-Topic: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
Thread-Index: AQHVr3iM0Th6FxYEikio3vlP+UikqKe2NxmAgAP1QICAA+uHgA==
Date:   Tue, 17 Dec 2019 10:21:57 +0000
Message-ID: <ac16c0ee-0dd1-d383-14ed-13b360e3e79d@st.com>
References: <20191210164014.50739-1-paul@crapouillou.net>
 <20191210164014.50739-3-paul@crapouillou.net>
 <f25180f2-7c6d-0022-12b2-cd9c202f39d3@st.com>
 <1576362603.3.5@crapouillou.net>
In-Reply-To: <1576362603.3.5@crapouillou.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <908073462757134794BFB627F5122D0F@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF1bA0KDQoNCk9uIDE0LzEyLzIwMTkgMTE6MzAgUE0sIFBhdWwgQ2VyY3VlaWwgd3JvdGU6
DQo+IEhpIEZhYmllbiwNCj4NCj4NCj4gTGUgamV1LiwgZMOpYy4gMTIsIDIwMTkgYXQgMTA6MDMs
IEZhYmllbiBERVNTRU5ORSANCj4gPGZhYmllbi5kZXNzZW5uZUBzdC5jb20+IGEgw6ljcml0IDoN
Cj4+IEhpIFBhdWwNCj4+DQo+Pg0KPj4gT24gMTAvMTIvMjAxOSA1OjQwIFBNLCBQYXVsIENlcmN1
ZWlsIHdyb3RlOg0KPj4+IMKgVGhlIC5wcmVwYXJlKCkgY2FsbGJhY2sgaXMgY2FsbGVkIGJlZm9y
ZSB0aGUgZmlybXdhcmUgaXMgbG9hZGVkIHRvDQo+Pj4gwqBtZW1vcnkuIFRoaXMgaXMgdXNlZnVs
IGZvciBpbnN0YW5jZSBpbiB0aGUgY2FzZSB3aGVyZSBzb21lIHNldHVwIGlzDQo+Pj4gwqByZXF1
aXJlZCBmb3IgdGhlIG1lbW9yeSB0byBiZSBhY2Nlc3NpYmxlLg0KPj4NCj4+DQo+PiBJIGFtIHRy
eWluZyB0byBmaWd1cmUgb3V0IHdoYXQga2luZyBvZiAnc2V0dXAnIG1heSBiZSByZXF1aXJlZC4g
RnJvbSB0aGUNCj4+IGluZ2VuaWMgZHJpdmVyIEkgdW5kZXJzdGFuZCB0aGF0IHlvdSBuZWVkIHRv
IGVuYWJsZSBjbG9ja3MgdG8gYWxsb3cgc29tZQ0KPj4gbWVtb3J5IGFjY2Vzcy4NCj4+DQo+PiBJ
bnN0ZWFkIG9mIGFkZGluZyB0aGlzIG5ldyBvcHMsIHdoeSBub3QgZW5hYmxpbmcgY2xvY2tzIGlu
IHByb2JlKCk/DQo+DQo+IEVuYWJsaW5nIHRoZSBjbG9ja3MgaW4gdGhlIHByb2JlIG1lYW5zIHRo
YXQgdGhlIGNsb2NrcyB3aWxsIGJlIA0KPiB1bmNvbmRpdGlvbmFsbHkgZW5hYmxlZCB1bnRpbCB0
aGUgZHJpdmVyIGlzIHJlbW92ZWQsIGV2ZW4gaWYgdGhlIA0KPiByZW1vdGUgcHJvY2Vzc29yIGVu
ZCB1cCBiZWluZyB1bnVzZWQuIFRoYXQgd291bGQgYmUgYSB3YXN0ZSBvZiBwb3dlci4NCg0KDQpP
SyBJIHVuZGVyc3RhbmQuDQoNCk5ldmVydGhlbGVzcyBJIHRoaW5rIHRoYXQgeW91IG1heSBuZWVk
IHRvIGNhbGwgLnByZXBhcmUoKSBmcm9tIA0KcnByb2NfZndfYm9vdCgpIHNpbmNlIHlvdSBtYXkg
bmVlZCB0byBhY2Nlc3Mgc29tZSBtZW1vcmllcyBmcm9tIHRoZSANCnBvaW50IHJwcm9jX2hhbmRs
ZV9yZXNvdXJjZXMoKSBpcyBjYWxsZWQgKHRoaXMgc2V0cyB1cCB2aXJ0aW8gd2hpY2ggaXMgDQp1
c2VkIGlmIHlvdSBoYXZlIGEgcmVzb3VyY2UgdGFibGUgZGVmaW5pbmcgdmRldikuDQoNCkFuZCBy
cHJvY19md19ib290KCkgY2FsbHMgcnByb2NfZW5hYmxlX2lvbW11KCksIHdoaWNoIHNvdW5kcyBs
aWtlIA0KInByZXBhcmUgbWVtb3J5Iiwgc28gdGhpcyBtYXkgYmUgdGhlIHJpZ2h0IHBsYWNlIHRv
IGNhbGwgLnByZXBhcmUoKQ0KDQoNCkJSDQoNCkZhYmllbg0KDQoNCj4NCj4gQ2hlZXJzLA0KPiAt
UGF1bA0KPg0KPg0KPj4NCj4+IEJSDQo+Pg0KPj4gRmFiaWVuDQo+Pg0KPj4NCj4+Pg0KPj4+IMKg
U2lnbmVkLW9mZi1ieTogUGF1bCBDZXJjdWVpbCA8cGF1bEBjcmFwb3VpbGxvdS5uZXQ+DQo+Pj4g
wqAtLS0NCj4+Pg0KPj4+IMKgTm90ZXM6DQo+Pj4gwqDCoMKgwqDCoCB2Mi12NDogTm8gY2hhbmdl
DQo+Pj4NCj4+PiDCoMKgIGRyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYyB8IDE2
ICsrKysrKysrKysrKysrKy0NCj4+PiDCoMKgIGluY2x1ZGUvbGludXgvcmVtb3RlcHJvYy5owqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKysrKw0KPj4+IMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiDCoGRpZmYgLS1naXQgYS9k
cml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMgDQo+Pj4gYi9kcml2ZXJzL3JlbW90
ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCj4+PiDCoGluZGV4IDBhOWZjN2ZkZDFjMy4uM2VhNWY2
NzVhMTQ4IDEwMDY0NA0KPj4+IMKgLS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2Nf
Y29yZS5jDQo+Pj4gwqArKysgYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMN
Cj4+PiDCoEBAIC0xMjk5LDExICsxMjk5LDE5IEBAIHN0YXRpYyBpbnQgcnByb2Nfc3RhcnQoc3Ry
dWN0IHJwcm9jICpycHJvYywgDQo+Pj4gY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdykNCj4+PiDC
oMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2ID0gJnJwcm9jLT5kZXY7DQo+Pj4gwqDCoMKg
wqDCoMKgIGludCByZXQ7DQo+Pj4NCj4+PiDCoCvCoMKgwqAgaWYgKHJwcm9jLT5vcHMtPnByZXBh
cmUpIHsNCj4+PiDCoCvCoMKgwqDCoMKgwqDCoCByZXQgPSBycHJvYy0+b3BzLT5wcmVwYXJlKHJw
cm9jKTsNCj4+PiDCoCvCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7DQo+Pj4gwqArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBwcmVwYXJlIHJwcm9jOiAlZFxu
IiwgcmV0KTsNCj4+PiDCoCvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4g
wqArwqDCoMKgwqDCoMKgwqAgfQ0KPj4+IMKgK8KgwqDCoCB9DQo+Pj4gwqArDQo+Pj4gwqDCoMKg
wqDCoMKgIC8qIGxvYWQgdGhlIEVMRiBzZWdtZW50cyB0byBtZW1vcnkgKi8NCj4+PiDCoMKgwqDC
oMKgwqAgcmV0ID0gcnByb2NfbG9hZF9zZWdtZW50cyhycHJvYywgZncpOw0KPj4+IMKgwqDCoMKg
wqDCoCBpZiAocmV0KSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycihkZXYsICJG
YWlsZWQgdG8gbG9hZCBwcm9ncmFtIHNlZ21lbnRzOiAlZFxuIiwgcmV0KTsNCj4+PiDCoC3CoMKg
wqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4+IMKgK8KgwqDCoMKgwqDCoMKgIGdvdG8gdW5wcmVw
YXJlX3Jwcm9jOw0KPj4+IMKgwqDCoMKgwqDCoCB9DQo+Pj4NCj4+PiDCoMKgwqDCoMKgwqAgLyoN
Cj4+PiDCoEBAIC0xMzU0LDYgKzEzNjIsOSBAQCBzdGF0aWMgaW50IHJwcm9jX3N0YXJ0KHN0cnVj
dCBycHJvYyAqcnByb2MsIA0KPj4+IGNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZncpDQo+Pj4gwqDC
oMKgwqDCoMKgIHJwcm9jX3VucHJlcGFyZV9zdWJkZXZpY2VzKHJwcm9jKTsNCj4+PiDCoMKgIHJl
c2V0X3RhYmxlX3B0cjoNCj4+PiDCoMKgwqDCoMKgwqAgcnByb2MtPnRhYmxlX3B0ciA9IHJwcm9j
LT5jYWNoZWRfdGFibGU7DQo+Pj4gwqArdW5wcmVwYXJlX3Jwcm9jOg0KPj4+IMKgK8KgwqDCoCBp
ZiAocnByb2MtPm9wcy0+dW5wcmVwYXJlKQ0KPj4+IMKgK8KgwqDCoMKgwqDCoMKgIHJwcm9jLT5v
cHMtPnVucHJlcGFyZShycHJvYyk7DQo+Pj4NCj4+PiDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsN
Cj4+PiDCoMKgIH0NCj4+PiDCoEBAIC0xNDgzLDYgKzE0OTQsOSBAQCBzdGF0aWMgaW50IHJwcm9j
X3N0b3Aoc3RydWN0IHJwcm9jICpycHJvYywgDQo+Pj4gYm9vbCBjcmFzaGVkKQ0KPj4+DQo+Pj4g
wqDCoMKgwqDCoMKgIHJwcm9jLT5zdGF0ZSA9IFJQUk9DX09GRkxJTkU7DQo+Pj4NCj4+PiDCoCvC
oMKgwqAgaWYgKHJwcm9jLT5vcHMtPnVucHJlcGFyZSkNCj4+PiDCoCvCoMKgwqDCoMKgwqDCoCBy
cHJvYy0+b3BzLT51bnByZXBhcmUocnByb2MpOw0KPj4+IMKgKw0KPj4+IMKgwqDCoMKgwqDCoCBk
ZXZfaW5mbyhkZXYsICJzdG9wcGVkIHJlbW90ZSBwcm9jZXNzb3IgJXNcbiIsIHJwcm9jLT5uYW1l
KTsNCj4+Pg0KPj4+IMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+PiDCoGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3JlbW90ZXByb2MuaCBiL2luY2x1ZGUvbGludXgvcmVtb3RlcHJvYy5oDQo+
Pj4gwqBpbmRleCA1ZjIwMWYwYzg2YzMuLmE2MjcyZDFiYTM4NCAxMDA2NDQNCj4+PiDCoC0tLSBh
L2luY2x1ZGUvbGludXgvcmVtb3RlcHJvYy5oDQo+Pj4gwqArKysgYi9pbmNsdWRlL2xpbnV4L3Jl
bW90ZXByb2MuaA0KPj4+IMKgQEAgLTM1NSw2ICszNTUsOCBAQCBlbnVtIHJzY19oYW5kbGluZ19z
dGF0dXMgew0KPj4+DQo+Pj4gwqDCoCAvKioNCj4+PiDCoMKgwqAgKiBzdHJ1Y3QgcnByb2Nfb3Bz
IC0gcGxhdGZvcm0tc3BlY2lmaWMgZGV2aWNlIGhhbmRsZXJzDQo+Pj4gwqArICogQHByZXBhcmU6
wqDCoMKgIHByZXBhcmUgdGhlIGRldmljZSBmb3IgcG93ZXIgdXAgKGJlZm9yZSB0aGUgDQo+Pj4g
ZmlybXdhcmUgaXMgbG9hZGVkKQ0KPj4+IMKgKyAqIEB1bnByZXBhcmU6wqDCoMKgIHVucHJlcGFy
ZSB0aGUgZGV2aWNlIGFmdGVyIGl0IGlzIHN0b3BwZWQNCj4+PiDCoMKgwqAgKiBAc3RhcnQ6wqDC
oMKgIHBvd2VyIG9uIHRoZSBkZXZpY2UgYW5kIGJvb3QgaXQNCj4+PiDCoMKgwqAgKiBAc3RvcDrC
oMKgwqAgcG93ZXIgb2ZmIHRoZSBkZXZpY2UNCj4+PiDCoMKgwqAgKiBAa2ljazrCoMKgwqAga2lj
ayBhIHZpcnRxdWV1ZSAodmlydHF1ZXVlIGlkIGdpdmVuIGFzIGEgcGFyYW1ldGVyKQ0KPj4+IMKg
QEAgLTM3MSw2ICszNzMsOCBAQCBlbnVtIHJzY19oYW5kbGluZ19zdGF0dXMgew0KPj4+IMKgwqDC
oCAqIEBnZXRfYm9vdF9hZGRyOsKgwqDCoCBnZXQgYm9vdCBhZGRyZXNzIHRvIGVudHJ5IHBvaW50
IHNwZWNpZmllZCANCj4+PiBpbiBmaXJtd2FyZQ0KPj4+IMKgwqDCoCAqLw0KPj4+IMKgwqAgc3Ry
dWN0IHJwcm9jX29wcyB7DQo+Pj4gwqArwqDCoMKgIGludCAoKnByZXBhcmUpKHN0cnVjdCBycHJv
YyAqcnByb2MpOw0KPj4+IMKgK8KgwqDCoCB2b2lkICgqdW5wcmVwYXJlKShzdHJ1Y3QgcnByb2Mg
KnJwcm9jKTsNCj4+PiDCoMKgwqDCoMKgwqAgaW50ICgqc3RhcnQpKHN0cnVjdCBycHJvYyAqcnBy
b2MpOw0KPj4+IMKgwqDCoMKgwqDCoCBpbnQgKCpzdG9wKShzdHJ1Y3QgcnByb2MgKnJwcm9jKTsN
Cj4+PiDCoMKgwqDCoMKgwqAgdm9pZCAoKmtpY2spKHN0cnVjdCBycHJvYyAqcnByb2MsIGludCB2
cWlkKTsNCj4NCj4=
