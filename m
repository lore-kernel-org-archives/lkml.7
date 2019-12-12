Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8830CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506DA20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="siwB0OfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfLLKDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:03:53 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18042 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbfLLKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:03:53 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCA3IR0026906;
        Thu, 12 Dec 2019 11:03:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=dpMHjjbInUpLUskSrI7RT6ikCEHKPk+prPxxqthL2VA=;
 b=siwB0OfArfvejgfvIJESwVe1mBfRs6cY8v5/+HJec5eCjnnxqS0zSLQPNkrbQXfKaXsc
 1c7kQ6LpoQyZFunsETi4FpPUVvTRZF2IwzOwtLbXgSn9ZdxTfJbQ9qxArwn12MMw+yLw
 apy9PlLyXnHyEGnMWhVMLIUEP0q+sccZ9t2Y+RMgcVwxXsul1i40Wb7f1uPAsU70SOj+
 6yUO8fRWDeguhvJx9FRIsnH3Yua3NDdSo+TqjWLEh2dOeWdx9yTCaRllFA7cUc3ytJBu
 ICFFZW4B18/scFB9eKyCJWq6IWSZdCKLs24w3Hfbzra7T+J4o2q/rxuu9YiQ43R7SPj/ 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wtfqh8vus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 11:03:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DE5F100034;
        Thu, 12 Dec 2019 11:03:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BCE42BC7A1;
        Thu, 12 Dec 2019 11:03:30 +0100 (CET)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Dec
 2019 11:03:30 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Thu, 12 Dec 2019 11:03:30 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "od@zcrc.me" <od@zcrc.me>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
Thread-Topic: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
Thread-Index: AQHVr3iM0Th6FxYEikio3vlP+UikqKe2NxmA
Date:   Thu, 12 Dec 2019 10:03:29 +0000
Message-ID: <f25180f2-7c6d-0022-12b2-cd9c202f39d3@st.com>
References: <20191210164014.50739-1-paul@crapouillou.net>
 <20191210164014.50739-3-paul@crapouillou.net>
In-Reply-To: <20191210164014.50739-3-paul@crapouillou.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD804467A68AAF4AB0507174BC5F24AC@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_02:2019-12-12,2019-12-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF1bA0KDQoNCk9uIDEwLzEyLzIwMTkgNTo0MCBQTSwgUGF1bCBDZXJjdWVpbCB3cm90ZToN
Cj4gVGhlIC5wcmVwYXJlKCkgY2FsbGJhY2sgaXMgY2FsbGVkIGJlZm9yZSB0aGUgZmlybXdhcmUg
aXMgbG9hZGVkIHRvDQo+IG1lbW9yeS4gVGhpcyBpcyB1c2VmdWwgZm9yIGluc3RhbmNlIGluIHRo
ZSBjYXNlIHdoZXJlIHNvbWUgc2V0dXAgaXMNCj4gcmVxdWlyZWQgZm9yIHRoZSBtZW1vcnkgdG8g
YmUgYWNjZXNzaWJsZS4NCg0KDQpJIGFtIHRyeWluZyB0byBmaWd1cmUgb3V0IHdoYXQga2luZyBv
ZiAnc2V0dXAnIG1heSBiZSByZXF1aXJlZC4gRnJvbSB0aGUgDQppbmdlbmljIGRyaXZlciBJIHVu
ZGVyc3RhbmQgdGhhdCB5b3UgbmVlZCB0byBlbmFibGUgY2xvY2tzIHRvIGFsbG93IHNvbWUgDQpt
ZW1vcnkgYWNjZXNzLg0KDQpJbnN0ZWFkIG9mIGFkZGluZyB0aGlzIG5ldyBvcHMsIHdoeSBub3Qg
ZW5hYmxpbmcgY2xvY2tzIGluIHByb2JlKCk/DQoNCkJSDQoNCkZhYmllbg0KDQoNCj4NCj4gU2ln
bmVkLW9mZi1ieTogUGF1bCBDZXJjdWVpbCA8cGF1bEBjcmFwb3VpbGxvdS5uZXQ+DQo+IC0tLQ0K
Pg0KPiBOb3RlczoNCj4gICAgICB2Mi12NDogTm8gY2hhbmdlDQo+DQo+ICAgZHJpdmVycy9yZW1v
dGVwcm9jL3JlbW90ZXByb2NfY29yZS5jIHwgMTYgKysrKysrKysrKysrKysrLQ0KPiAgIGluY2x1
ZGUvbGludXgvcmVtb3RlcHJvYy5oICAgICAgICAgICB8ICA0ICsrKysNCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYyBiL2RyaXZlcnMvcmVtb3RlcHJv
Yy9yZW1vdGVwcm9jX2NvcmUuYw0KPiBpbmRleCAwYTlmYzdmZGQxYzMuLjNlYTVmNjc1YTE0OCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jDQo+ICsr
KyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiBAQCAtMTI5OSwxMSAr
MTI5OSwxOSBAQCBzdGF0aWMgaW50IHJwcm9jX3N0YXJ0KHN0cnVjdCBycHJvYyAqcnByb2MsIGNv
bnN0IHN0cnVjdCBmaXJtd2FyZSAqZncpDQo+ICAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZycHJv
Yy0+ZGV2Ow0KPiAgIAlpbnQgcmV0Ow0KPiAgIA0KPiArCWlmIChycHJvYy0+b3BzLT5wcmVwYXJl
KSB7DQo+ICsJCXJldCA9IHJwcm9jLT5vcHMtPnByZXBhcmUocnByb2MpOw0KPiArCQlpZiAocmV0
KSB7DQo+ICsJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBwcmVwYXJlIHJwcm9jOiAlZFxuIiwg
cmV0KTsNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gICAJLyogbG9h
ZCB0aGUgRUxGIHNlZ21lbnRzIHRvIG1lbW9yeSAqLw0KPiAgIAlyZXQgPSBycHJvY19sb2FkX3Nl
Z21lbnRzKHJwcm9jLCBmdyk7DQo+ICAgCWlmIChyZXQpIHsNCj4gICAJCWRldl9lcnIoZGV2LCAi
RmFpbGVkIHRvIGxvYWQgcHJvZ3JhbSBzZWdtZW50czogJWRcbiIsIHJldCk7DQo+IC0JCXJldHVy
biByZXQ7DQo+ICsJCWdvdG8gdW5wcmVwYXJlX3Jwcm9jOw0KPiAgIAl9DQo+ICAgDQo+ICAgCS8q
DQo+IEBAIC0xMzU0LDYgKzEzNjIsOSBAQCBzdGF0aWMgaW50IHJwcm9jX3N0YXJ0KHN0cnVjdCBy
cHJvYyAqcnByb2MsIGNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZncpDQo+ICAgCXJwcm9jX3VucHJl
cGFyZV9zdWJkZXZpY2VzKHJwcm9jKTsNCj4gICByZXNldF90YWJsZV9wdHI6DQo+ICAgCXJwcm9j
LT50YWJsZV9wdHIgPSBycHJvYy0+Y2FjaGVkX3RhYmxlOw0KPiArdW5wcmVwYXJlX3Jwcm9jOg0K
PiArCWlmIChycHJvYy0+b3BzLT51bnByZXBhcmUpDQo+ICsJCXJwcm9jLT5vcHMtPnVucHJlcGFy
ZShycHJvYyk7DQo+ICAgDQo+ICAgCXJldHVybiByZXQ7DQo+ICAgfQ0KPiBAQCAtMTQ4Myw2ICsx
NDk0LDkgQEAgc3RhdGljIGludCBycHJvY19zdG9wKHN0cnVjdCBycHJvYyAqcnByb2MsIGJvb2wg
Y3Jhc2hlZCkNCj4gICANCj4gICAJcnByb2MtPnN0YXRlID0gUlBST0NfT0ZGTElORTsNCj4gICAN
Cj4gKwlpZiAocnByb2MtPm9wcy0+dW5wcmVwYXJlKQ0KPiArCQlycHJvYy0+b3BzLT51bnByZXBh
cmUocnByb2MpOw0KPiArDQo+ICAgCWRldl9pbmZvKGRldiwgInN0b3BwZWQgcmVtb3RlIHByb2Nl
c3NvciAlc1xuIiwgcnByb2MtPm5hbWUpOw0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvcmVtb3RlcHJvYy5oIGIvaW5jbHVkZS9saW51eC9yZW1vdGVw
cm9jLmgNCj4gaW5kZXggNWYyMDFmMGM4NmMzLi5hNjI3MmQxYmEzODQgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvcmVtb3RlcHJvYy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcmVtb3Rl
cHJvYy5oDQo+IEBAIC0zNTUsNiArMzU1LDggQEAgZW51bSByc2NfaGFuZGxpbmdfc3RhdHVzIHsN
Cj4gICANCj4gICAvKioNCj4gICAgKiBzdHJ1Y3QgcnByb2Nfb3BzIC0gcGxhdGZvcm0tc3BlY2lm
aWMgZGV2aWNlIGhhbmRsZXJzDQo+ICsgKiBAcHJlcGFyZToJcHJlcGFyZSB0aGUgZGV2aWNlIGZv
ciBwb3dlciB1cCAoYmVmb3JlIHRoZSBmaXJtd2FyZSBpcyBsb2FkZWQpDQo+ICsgKiBAdW5wcmVw
YXJlOgl1bnByZXBhcmUgdGhlIGRldmljZSBhZnRlciBpdCBpcyBzdG9wcGVkDQo+ICAgICogQHN0
YXJ0Oglwb3dlciBvbiB0aGUgZGV2aWNlIGFuZCBib290IGl0DQo+ICAgICogQHN0b3A6CXBvd2Vy
IG9mZiB0aGUgZGV2aWNlDQo+ICAgICogQGtpY2s6CWtpY2sgYSB2aXJ0cXVldWUgKHZpcnRxdWV1
ZSBpZCBnaXZlbiBhcyBhIHBhcmFtZXRlcikNCj4gQEAgLTM3MSw2ICszNzMsOCBAQCBlbnVtIHJz
Y19oYW5kbGluZ19zdGF0dXMgew0KPiAgICAqIEBnZXRfYm9vdF9hZGRyOglnZXQgYm9vdCBhZGRy
ZXNzIHRvIGVudHJ5IHBvaW50IHNwZWNpZmllZCBpbiBmaXJtd2FyZQ0KPiAgICAqLw0KPiAgIHN0
cnVjdCBycHJvY19vcHMgew0KPiArCWludCAoKnByZXBhcmUpKHN0cnVjdCBycHJvYyAqcnByb2Mp
Ow0KPiArCXZvaWQgKCp1bnByZXBhcmUpKHN0cnVjdCBycHJvYyAqcnByb2MpOw0KPiAgIAlpbnQg
KCpzdGFydCkoc3RydWN0IHJwcm9jICpycHJvYyk7DQo+ICAgCWludCAoKnN0b3ApKHN0cnVjdCBy
cHJvYyAqcnByb2MpOw0KPiAgIAl2b2lkICgqa2ljaykoc3RydWN0IHJwcm9jICpycHJvYywgaW50
IHZxaWQpOw==
