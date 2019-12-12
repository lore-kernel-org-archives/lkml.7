Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89149C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551C4214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rVmo3/Ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfLLJn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:43:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13260 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728374AbfLLJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:43:27 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC9bXog013369;
        Thu, 12 Dec 2019 10:43:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=W7ta/D/nEVXWd0swsme5vM2t6D5+rqjLo8hFeAJNVHk=;
 b=rVmo3/EyUG85blnhiM7tQSAV0dAr0Fjzn1vGZx5fUdsQC5GoLV2gCUln9bv0km9RvQix
 QWPstxdaGvO9YjYG/219WQ/r1mb0otvJ+tXz/KLHXF26HFQEfInGOpsAj/DWZB+k0QJB
 Se3enbBVWQfMKbbvVhs4eB88XJMK0BL0IOcGWtgfWWvxA6gNziBTECpGfwck4+fQjYa0
 D0nVGyYuywdDuc/96zKZFKcVLdWb98BEjxMJ6lSexJ7VIzG6vU3OOxbZxvp7M7Iy0cFS
 95vW7nPBuKvyL1E+UMrnBfN5pRjm7Qh5+Q5lQoUo/NuIAQCLoHSETofACQKe3IEynj34 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wrbrfpma4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 10:43:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DD6910002A;
        Thu, 12 Dec 2019 10:43:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EE8442B8FFA;
        Thu, 12 Dec 2019 10:43:13 +0100 (CET)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Dec
 2019 10:43:13 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Thu, 12 Dec 2019 10:43:13 +0100
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
Subject: Re: [PATCH v4 2/5] remoteproc: Add device-managed variants of
 rproc_alloc/rproc_add
Thread-Topic: [PATCH v4 2/5] remoteproc: Add device-managed variants of
 rproc_alloc/rproc_add
Thread-Index: AQHVr3iIZbYIxXYBCk6/jTgSiJoOx6e2MW2A
Date:   Thu, 12 Dec 2019 09:43:13 +0000
Message-ID: <6fff431f-dd3f-a67e-e40b-8cee4060c37a@st.com>
References: <20191210164014.50739-1-paul@crapouillou.net>
 <20191210164014.50739-2-paul@crapouillou.net>
In-Reply-To: <20191210164014.50739-2-paul@crapouillou.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E47CC4E35B31C94CA71149C4F5BFCD46@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_02:2019-12-12,2019-12-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF1bCwNCg0KDQpHb29kIGluaXRpYXRpdmUhIFNlZSBtZSByZW1hcmtzIGJlbG93Lg0KDQoN
Ck9uIDEwLzEyLzIwMTkgNTo0MCBQTSwgUGF1bCBDZXJjdWVpbCB3cm90ZToNCj4gQWRkIEFQSSBm
dW5jdGlvbnMgZGV2bV9ycHJvY19hbGxvYygpIGFuZCBkZXZtX3Jwcm9jX2FkZCgpLCB3aGljaCBi
ZWhhdmUNCj4gbGlrZSBycHJvY19hbGxvYygpIGFuZCBycHJvY19hZGQoKSByZXNwZWN0aXZlbHks
IGJ1dCByZWdpc3RlciB0aGVpcg0KPiByZXNwZWN0aXZlIGNsZWFudXAgZnVuY3Rpb24gdG8gYmUg
Y2FsbGVkIG9uIGRyaXZlciBkZXRhY2guDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFBhdWwgQ2VyY3Vl
aWwgPHBhdWxAY3JhcG91aWxsb3UubmV0Pg0KPiAtLS0NCj4NCj4gTm90ZXM6DQo+ICAgICAgdjM6
IE5ldyBwYXRjaA0KPiAgICAgIHY0OiBObyBjaGFuZ2UNCj4NCj4gICBkcml2ZXJzL3JlbW90ZXBy
b2MvcmVtb3RlcHJvY19jb3JlLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICAgaW5jbHVkZS9saW51eC9yZW1vdGVwcm9jLmggICAgICAgICAgIHwgIDUgKysrDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMgYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3Rl
cHJvY19jb3JlLmMNCj4gaW5kZXggMzA3ZGY5ODM0N2JhLi4wYTlmYzdmZGQxYzMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiArKysgYi9kcml2
ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCg0KDQpNYXliZSB0aGVzZSBkZXZtIGZ1
bmN0aW9uIHNoYWxsIGJlIGRlZmluZWQgaW4gYSBuZXcgcmVtb3RlcHJvYy9kZXZyZXMuYyANCmZp
bGUuIEFsdGhvdWdoIGl0IHNlZW1zIHRvIGJlIGEgY29tbW9uIHVzYWdlIEkgZG9uJ3Qga25vdyBp
ZiB0aGVyZSBpcyBhIA0KcnVsZSBmb3IgdGhhdC4NCg0KDQo+IEBAIC0xOTMyLDYgKzE5MzIsMzMg
QEAgaW50IHJwcm9jX2FkZChzdHJ1Y3QgcnByb2MgKnJwcm9jKQ0KPiAgIH0NCj4gICBFWFBPUlRf
U1lNQk9MKHJwcm9jX2FkZCk7DQo+ICAgDQo+ICtzdGF0aWMgdm9pZCBkZXZtX3Jwcm9jX3JlbW92
ZSh2b2lkICpycHJvYykNCj4gK3sNCj4gKwlycHJvY19kZWwocnByb2MpOw0KPiArfQ0KPiArDQo+
ICsvKioNCj4gKyAqIGRldm1fcnByb2NfYWRkKCkgLSByZXNvdXJjZSBtYW5hZ2VkIHJwcm9jX2Fk
ZCgpDQo+ICsgKiBAZGV2OiB0aGUgdW5kZXJseWluZyBkZXZpY2UNCj4gKyAqIEBycHJvYzogdGhl
IHJlbW90ZSBwcm9jZXNzb3IgaGFuZGxlIHRvIHJlZ2lzdGVyDQo+ICsgKg0KPiArICogVGhpcyBm
dW5jdGlvbiBwZXJmb3JtcyBsaWtlIHJwcm9jX2FkZCgpIGJ1dCB0aGUgcmVnaXN0ZXJlZCBycHJv
YyBkZXZpY2Ugd2lsbA0KPiArICogYXV0b21hdGljYWxseSBiZSByZW1vdmVkIG9uIGRyaXZlciBk
ZXRhY2guDQo+ICsgKg0KPiArICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MgYW5kIGFuIGFwcHJvcHJp
YXRlIGVycm9yIGNvZGUgb3RoZXJ3aXNlLg0KPiArICovDQo+ICtpbnQgZGV2bV9ycHJvY19hZGQo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnByb2MgKnJwcm9jKQ0KPiArew0KPiArCWludCBl
cnI7DQo+ICsNCj4gKwllcnIgPSBycHJvY19hZGQocnByb2MpOw0KPiArCWlmIChlcnIpDQo+ICsJ
CXJldHVybiBlcnI7DQo+ICsNCj4gKwlyZXR1cm4gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRl
diwgZGV2bV9ycHJvY19yZW1vdmUsIHJwcm9jKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0woZGV2
bV9ycHJvY19hZGQpOw0KPiArDQo+ICAgLyoqDQo+ICAgICogcnByb2NfdHlwZV9yZWxlYXNlKCkg
LSByZWxlYXNlIGEgcmVtb3RlIHByb2Nlc3NvciBpbnN0YW5jZQ0KPiAgICAqIEBkZXY6IHRoZSBy
cHJvYydzIGRldmljZQ0KPiBAQCAtMjE0OSw2ICsyMTc2LDQ2IEBAIGludCBycHJvY19kZWwoc3Ry
dWN0IHJwcm9jICpycHJvYykNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTChycHJvY19kZWwpOw0K
PiAgIA0KPiArc3RhdGljIHZvaWQgZGV2bV9ycHJvY19mcmVlKHN0cnVjdCBkZXZpY2UgKmRldiwg
dm9pZCAqcmVzKQ0KPiArew0KPiArCXJwcm9jX2ZyZWUoKihzdHJ1Y3QgcnByb2MgKiopcmVzKTsN
Cj4gK30NCj4gKw0KPiArLyoqDQo+ICsgKiBkZXZtX3Jwcm9jX2FsbG9jKCkgLSByZXNvdXJjZSBt
YW5hZ2VkIHJwcm9jX2FsbG9jKCkNCj4gKyAqIEBkZXY6IHRoZSB1bmRlcmx5aW5nIGRldmljZQ0K
PiArICogQG5hbWU6IG5hbWUgb2YgdGhpcyByZW1vdGUgcHJvY2Vzc29yDQo+ICsgKiBAb3BzOiBw
bGF0Zm9ybS1zcGVjaWZpYyBoYW5kbGVycyAobWFpbmx5IHN0YXJ0L3N0b3ApDQo+ICsgKiBAZmly
bXdhcmU6IG5hbWUgb2YgZmlybXdhcmUgZmlsZSB0byBsb2FkLCBjYW4gYmUgTlVMTA0KPiArICog
QGxlbjogbGVuZ3RoIG9mIHByaXZhdGUgZGF0YSBuZWVkZWQgYnkgdGhlIHJwcm9jIGRyaXZlciAo
aW4gYnl0ZXMpDQo+ICsgKg0KPiArICogVGhpcyBmdW5jdGlvbiBwZXJmb3JtcyBsaWtlIHJwcm9j
X2FsbG9jKCkgYnV0IHRoZSBhY3VpcmVkIHJwcm9jIGRldmljZSB3aWxsDQoNCg0KdHlwbzogcy9h
Y3VpcmVkL2FjcXVpcmVkDQoNCg0KPiArICogYXV0b21hdGljYWxseSBiZSByZWxlYXNlZCBvbiBk
cml2ZXIgZGV0YWNoLg0KPiArICoNCj4gKyAqIE9uIHN1Y2Nlc3MgdGhlIG5ldyBycHJvYyBpcyBy
ZXR1cm5lZCwgYW5kIG9uIGZhaWx1cmUsIE5VTEwuDQo+ICsgKi8NCj4gK3N0cnVjdCBycHJvYyAq
ZGV2bV9ycHJvY19hbGxvYyhzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+
ICsJCQkgICAgICAgY29uc3Qgc3RydWN0IHJwcm9jX29wcyAqb3BzLA0KPiArCQkJICAgICAgIGNv
bnN0IGNoYXIgKmZpcm13YXJlLCBpbnQgbGVuKQ0KPiArew0KPiArCXN0cnVjdCBycHJvYyAqKnB0
ciwgKnJwcm9jOw0KPiArDQo+ICsJcHRyID0gZGV2cmVzX2FsbG9jKGRldm1fcnByb2NfZnJlZSwg
c2l6ZW9mKCpwdHIpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXB0cikNCj4gKwkJcmV0dXJuIEVS
Ul9QVFIoLUVOT01FTSk7DQo+ICsNCj4gKwlycHJvYyA9IHJwcm9jX2FsbG9jKGRldiwgbmFtZSwg
b3BzLCBmaXJtd2FyZSwgbGVuKTsNCj4gKwlpZiAocnByb2MpIHsNCj4gKwkJKnB0ciA9IHJwcm9j
Ow0KPiArCQlkZXZyZXNfYWRkKGRldiwgcHRyKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlkZXZyZXNf
ZnJlZShwdHIpOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBycHJvYzsNCg0KDQpDYW4ndCB5b3Ug
dXNlIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIGhlcmUgdG9vPw0KDQoNCj4gK30NCj4gK0VY
UE9SVF9TWU1CT0woZGV2bV9ycHJvY19hbGxvYyk7DQo+ICsNCj4gICAvKioNCj4gICAgKiBycHJv
Y19hZGRfc3ViZGV2KCkgLSBhZGQgYSBzdWJkZXZpY2UgdG8gYSByZW1vdGVwcm9jDQo+ICAgICog
QHJwcm9jOiBycHJvYyBoYW5kbGUgdG8gYWRkIHRoZSBzdWJkZXZpY2UgdG8NCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvcmVtb3RlcHJvYy5oIGIvaW5jbHVkZS9saW51eC9yZW1vdGVwcm9j
LmgNCj4gaW5kZXggMTZhZDY2NjgzYWQwLi41ZjIwMWYwYzg2YzMgMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvcmVtb3RlcHJvYy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcmVtb3RlcHJv
Yy5oDQo+IEBAIC01OTUsNiArNTk1LDExIEBAIGludCBycHJvY19hZGQoc3RydWN0IHJwcm9jICpy
cHJvYyk7DQo+ICAgaW50IHJwcm9jX2RlbChzdHJ1Y3QgcnByb2MgKnJwcm9jKTsNCj4gICB2b2lk
IHJwcm9jX2ZyZWUoc3RydWN0IHJwcm9jICpycHJvYyk7DQo+ICAgDQo+ICtzdHJ1Y3QgcnByb2Mg
KmRldm1fcnByb2NfYWxsb2Moc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0K
PiArCQkJICAgICAgIGNvbnN0IHN0cnVjdCBycHJvY19vcHMgKm9wcywNCj4gKwkJCSAgICAgICBj
b25zdCBjaGFyICpmaXJtd2FyZSwgaW50IGxlbik7DQo+ICtpbnQgZGV2bV9ycHJvY19hZGQoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnByb2MgKnJwcm9jKTsNCj4gKw0KPiAgIHZvaWQgcnBy
b2NfYWRkX2NhcnZlb3V0KHN0cnVjdCBycHJvYyAqcnByb2MsIHN0cnVjdCBycHJvY19tZW1fZW50
cnkgKm1lbSk7DQo+ICAgDQo+ICAgc3RydWN0IHJwcm9jX21lbV9lbnRyeSAqDQoNCg0KQlINCg0K
RmFiaWVuDQo=
