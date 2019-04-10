Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14AFC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BE72133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dLYQfoRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfDJH02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:26:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbfDJH01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:26:27 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A7G8V1015908;
        Wed, 10 Apr 2019 09:26:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=IP7WZmkGyUJG7/v6Y7Em1HM3bny1cEITNMZcm6FIsxI=;
 b=dLYQfoRP98p4gRr/LbwHjyaiOVk40BwCq94ewzKEBIxY7XMIeagBvkWl+i/mYXC/f4JD
 H0PUp3BVHQA55oU5IIl6VV9BjJSqIdwMC264oAhv0DSQEN+h60zVlRaBfF1S8rH2btZW
 XGSyDLKNb7PG70m1X9HduaFrdIstDzznh+F656oRqc9Ll7aD9/k7hZfF0FXbzT51V2Yq
 HEO4TCf7lSjBtWZYzD7eGq5wa/77jTnPkac4Ti1A9sMMfBpVpjnR5myrYwblSsDAmMdt
 OyQMIiO6RjHb4NUQo31ZgR514lvRWrMb6opNeU/eT+xpJMz+6Ud+G27hUcSib7H30rWM 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7wpegh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 09:26:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A66A231;
        Wed, 10 Apr 2019 07:26:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76789107C;
        Wed, 10 Apr 2019 07:26:03 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 09:26:03 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 10 Apr 2019 09:26:03 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/23] watchdog: st_lpc_wdt: Convert to use device managed
 functions
Thread-Topic: [PATCH 19/23] watchdog: st_lpc_wdt: Convert to use device
 managed functions
Thread-Index: AQHU7vkdmhJakUhG+EGqRwjpWPzWHaY03dMA
Date:   Wed, 10 Apr 2019 07:26:03 +0000
Message-ID: <e96fd22f-2717-3ad7-028a-b44fe963a265@st.com>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
 <1554830641-9247-20-git-send-email-linux@roeck-us.net>
In-Reply-To: <1554830641-9247-20-git-send-email-linux@roeck-us.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7B1BA0D89EC5C4D8DC358A900E09176@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VlbnRlcg0KDQpPbiA0LzkvMTkgNzoyMyBQTSwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4g
VXNlIGRldmljZSBtYW5hZ2VkIGZ1bmN0aW9ucyB0byBzaW1wbGlmeSBlcnJvciBoYW5kbGluZywg
cmVkdWNlDQo+IHNvdXJjZSBjb2RlIHNpemUsIGltcHJvdmUgcmVhZGFiaWxpdHksIGFuZCByZWR1
Y2UgdGhlIGxpa2VseWhvb2Qgb2YgYnVncy4NCj4gDQo+IFRoZSBjb252ZXJzaW9uIHdhcyBkb25l
IGF1dG9tYXRpY2FsbHkgd2l0aCBjb2NjaW5lbGxlIHVzaW5nIHRoZQ0KPiBmb2xsb3dpbmcgc2Vt
YW50aWMgcGF0Y2hlcy4gVGhlIHNlbWFudGljIHBhdGNoZXMgYW5kIHRoZSBzY3JpcHRzDQo+IHVz
ZWQgdG8gZ2VuZXJhdGUgdGhpcyBjb21taXQgbG9nIGFyZSBhdmFpbGFibGUgYXQNCj4gaHR0cHM6
Ly9naXRodWIuY29tL2dyb2Vjay9jb2NjaW5lbGxlLXBhdGNoZXMNCj4gDQo+IC0gVXNlIGRldm1f
YWRkX2FjdGlvbl9vcl9yZXNldCgpIGZvciBjYWxscyB0byBjbGtfZGlzYWJsZV91bnByZXBhcmUN
Cj4gLSBJbnRyb2R1Y2UgbG9jYWwgdmFyaWFibGUgJ3N0cnVjdCBkZXZpY2UgKmRldicgYW5kIHVz
ZSBpdCBpbnN0ZWFkIG9mDQo+ICAgZGVyZWZlcmVuY2luZyBpdCByZXBlYXRlZGx5DQo+IC0gVXNl
IGRldm1fd2F0Y2hkb2dfcmVnaXN0ZXJfZHJpdmVyKCkgdG8gcmVnaXN0ZXIgd2F0Y2hkb2cgZGV2
aWNlDQo+IA0KPiBDYzogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+IC0t
LQ0KPiAgZHJpdmVycy93YXRjaGRvZy9zdF9scGNfd2R0LmMgfCA0NyArKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0
aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRj
aGRvZy9zdF9scGNfd2R0LmMgYi9kcml2ZXJzL3dhdGNoZG9nL3N0X2xwY193ZHQuYw0KPiBpbmRl
eCAxOTZmYjRiNzJjNWQuLjlhNWVkOTVjMzQwMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy93YXRj
aGRvZy9zdF9scGNfd2R0LmMNCj4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9zdF9scGNfd2R0LmMN
Cj4gQEAgLTE0MiwxMCArMTQyLDE2IEBAIHN0YXRpYyBzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlIHN0
X3dkb2dfZGV2ID0gew0KPiAgCS5vcHMJCT0gJnN0X3dkb2dfb3BzLA0KPiAgfTsNCj4gIA0KPiAr
c3RhdGljIHZvaWQgc3RfY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHZvaWQgKmRhdGEpDQo+ICt7DQo+
ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRhdGEpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50
IHN0X3dkb2dfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gKwlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCWNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgKm1hdGNoOw0KPiAtCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zf
bm9kZTsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiAgCXN0
cnVjdCBzdF93ZG9nICpzdF93ZG9nOw0KPiAgCXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4gIAlz
dHJ1Y3QgY2xrICpjbGs7DQo+IEBAIC0xNTUsNyArMTYxLDcgQEAgc3RhdGljIGludCBzdF93ZG9n
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlyZXQgPSBvZl9w
cm9wZXJ0eV9yZWFkX3UzMihucCwgInN0LGxwYy1tb2RlIiwgJm1vZGUpOw0KPiAgCWlmIChyZXQp
IHsNCj4gLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiQW4gTFBDIG1vZGUgbXVzdCBiZSBwcm92aWRl
ZFxuIik7DQo+ICsJCWRldl9lcnIoZGV2LCAiQW4gTFBDIG1vZGUgbXVzdCBiZSBwcm92aWRlZFxu
Iik7DQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gIA0KPiBAQCAtMTYzLDEzICsxNjks
MTMgQEAgc3RhdGljIGludCBzdF93ZG9nX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAJaWYgKG1vZGUgIT0gU1RfTFBDX01PREVfV0RUKQ0KPiAgCQlyZXR1cm4gLUVOT0RF
VjsNCj4gIA0KPiAtCXN0X3dkb2cgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpz
dF93ZG9nKSwgR0ZQX0tFUk5FTCk7DQo+ICsJc3Rfd2RvZyA9IGRldm1fa3phbGxvYyhkZXYsIHNp
emVvZigqc3Rfd2RvZyksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghc3Rfd2RvZykNCj4gIAkJcmV0
dXJuIC1FTk9NRU07DQo+ICANCj4gLQltYXRjaCA9IG9mX21hdGNoX2RldmljZShzdF93ZG9nX21h
dGNoLCAmcGRldi0+ZGV2KTsNCj4gKwltYXRjaCA9IG9mX21hdGNoX2RldmljZShzdF93ZG9nX21h
dGNoLCBkZXYpOw0KPiAgCWlmICghbWF0Y2gpIHsNCj4gLQkJZGV2X2VycigmcGRldi0+ZGV2LCAi
Q291bGRuJ3QgbWF0Y2ggZGV2aWNlXG4iKTsNCj4gKwkJZGV2X2VycihkZXYsICJDb3VsZG4ndCBt
YXRjaCBkZXZpY2VcbiIpOw0KPiAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gIAl9DQo+ICAJc3Rfd2Rv
Zy0+c3lzY2ZnCT0gKHN0cnVjdCBzdF93ZG9nX3N5c2NmZyAqKW1hdGNoLT5kYXRhOw0KPiBAQCAt
MTgwLDE3ICsxODYsMTcgQEAgc3RhdGljIGludCBzdF93ZG9nX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlyZWdtYXAgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9i
eV9waGFuZGxlKG5wLCAic3Qsc3lzY2ZnIik7DQo+ICAJaWYgKElTX0VSUihyZWdtYXApKSB7DQo+
IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgIk5vIHN5c2NmZyBwaGFuZGxlIHNwZWNpZmllZFxuIik7
DQo+ICsJCWRldl9lcnIoZGV2LCAiTm8gc3lzY2ZnIHBoYW5kbGUgc3BlY2lmaWVkXG4iKTsNCj4g
IAkJcmV0dXJuIFBUUl9FUlIocmVnbWFwKTsNCj4gIAl9DQo+ICANCj4gLQljbGsgPSBkZXZtX2Ns
a19nZXQoJnBkZXYtPmRldiwgTlVMTCk7DQo+ICsJY2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgTlVM
TCk7DQo+ICAJaWYgKElTX0VSUihjbGspKSB7DQo+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgIlVu
YWJsZSB0byByZXF1ZXN0IGNsb2NrXG4iKTsNCj4gKwkJZGV2X2VycihkZXYsICJVbmFibGUgdG8g
cmVxdWVzdCBjbG9ja1xuIik7DQo+ICAJCXJldHVybiBQVFJfRVJSKGNsayk7DQo+ICAJfQ0KPiAg
DQo+IC0Jc3Rfd2RvZy0+ZGV2CQk9ICZwZGV2LT5kZXY7DQo+ICsJc3Rfd2RvZy0+ZGV2CQk9IGRl
djsNCj4gIAlzdF93ZG9nLT5iYXNlCQk9IGJhc2U7DQo+ICAJc3Rfd2RvZy0+Y2xrCQk9IGNsazsN
Cj4gIAlzdF93ZG9nLT5yZWdtYXAJCT0gcmVnbWFwOw0KPiBAQCAtMTk4LDM5ICsyMDQsNDAgQEAg
c3RhdGljIGludCBzdF93ZG9nX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJc3Rfd2RvZy0+Y2xrcmF0ZQk9IGNsa19nZXRfcmF0ZShzdF93ZG9nLT5jbGspOw0KPiAgDQo+
ICAJaWYgKCFzdF93ZG9nLT5jbGtyYXRlKSB7DQo+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgIlVu
YWJsZSB0byBmZXRjaCBjbG9jayByYXRlXG4iKTsNCj4gKwkJZGV2X2VycihkZXYsICJVbmFibGUg
dG8gZmV0Y2ggY2xvY2sgcmF0ZVxuIik7DQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0NCj4g
IAlzdF93ZG9nX2Rldi5tYXhfdGltZW91dCA9IDB4RkZGRkZGRkYgLyBzdF93ZG9nLT5jbGtyYXRl
Ow0KPiAtCXN0X3dkb2dfZGV2LnBhcmVudCA9ICZwZGV2LT5kZXY7DQo+ICsJc3Rfd2RvZ19kZXYu
cGFyZW50ID0gZGV2Ow0KPiAgDQo+ICAJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGNsayk7DQo+
ICAJaWYgKHJldCkgew0KPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJVbmFibGUgdG8gZW5hYmxl
IGNsb2NrXG4iKTsNCj4gKwkJZGV2X2VycihkZXYsICJVbmFibGUgdG8gZW5hYmxlIGNsb2NrXG4i
KTsNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+ICsJcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29y
X3Jlc2V0KGRldiwgc3RfY2xrX2Rpc2FibGVfdW5wcmVwYXJlLCBjbGspOw0KPiArCWlmIChyZXQp
DQo+ICsJCXJldHVybiByZXQ7DQo+ICANCj4gIAl3YXRjaGRvZ19zZXRfZHJ2ZGF0YSgmc3Rfd2Rv
Z19kZXYsIHN0X3dkb2cpOw0KPiAgCXdhdGNoZG9nX3NldF9ub3dheW91dCgmc3Rfd2RvZ19kZXYs
IFdBVENIRE9HX05PV0FZT1VUKTsNCj4gIA0KPiAgCS8qIEluaXQgV2F0Y2hkb2cgdGltZW91dCB3
aXRoIHZhbHVlIGluIERUICovDQo+IC0JcmV0ID0gd2F0Y2hkb2dfaW5pdF90aW1lb3V0KCZzdF93
ZG9nX2RldiwgMCwgJnBkZXYtPmRldik7DQo+ICsJcmV0ID0gd2F0Y2hkb2dfaW5pdF90aW1lb3V0
KCZzdF93ZG9nX2RldiwgMCwgZGV2KTsNCj4gIAlpZiAocmV0KSB7DQo+IC0JCWRldl9lcnIoJnBk
ZXYtPmRldiwgIlVuYWJsZSB0byBpbml0aWFsaXNlIHdhdGNoZG9nIHRpbWVvdXRcbiIpOw0KPiAt
CQljbGtfZGlzYWJsZV91bnByZXBhcmUoY2xrKTsNCj4gKwkJZGV2X2VycihkZXYsICJVbmFibGUg
dG8gaW5pdGlhbGlzZSB3YXRjaGRvZyB0aW1lb3V0XG4iKTsNCj4gIAkJcmV0dXJuIHJldDsNCj4g
IAl9DQo+ICANCj4gLQlyZXQgPSB3YXRjaGRvZ19yZWdpc3Rlcl9kZXZpY2UoJnN0X3dkb2dfZGV2
KTsNCj4gKwlyZXQgPSBkZXZtX3dhdGNoZG9nX3JlZ2lzdGVyX2RldmljZShkZXYsICZzdF93ZG9n
X2Rldik7DQo+ICAJaWYgKHJldCkgew0KPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJVbmFibGUg
dG8gcmVnaXN0ZXIgd2F0Y2hkb2dcbiIpOw0KPiAtCQljbGtfZGlzYWJsZV91bnByZXBhcmUoY2xr
KTsNCj4gKwkJZGV2X2VycihkZXYsICJVbmFibGUgdG8gcmVnaXN0ZXIgd2F0Y2hkb2dcbiIpOw0K
PiAgCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4gIA0KPiAgCXN0X3dkb2dfc2V0dXAoc3Rfd2RvZywg
dHJ1ZSk7DQo+ICANCj4gLQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiTFBDIFdhdGNoZG9nIGRyaXZl
ciByZWdpc3RlcmVkLCByZXNldCB0eXBlIGlzICVzIiwNCj4gKwlkZXZfaW5mbyhkZXYsICJMUEMg
V2F0Y2hkb2cgZHJpdmVyIHJlZ2lzdGVyZWQsIHJlc2V0IHR5cGUgaXMgJXMiLA0KPiAgCQkgc3Rf
d2RvZy0+d2FybV9yZXNldCA/ICJ3YXJtIiA6ICJjb2xkIik7DQo+ICANCj4gIAlyZXR1cm4gcmV0
Ow0KPiBAQCAtMjQxLDggKzI0OCw2IEBAIHN0YXRpYyBpbnQgc3Rfd2RvZ19yZW1vdmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzdHJ1Y3Qgc3Rfd2RvZyAqc3Rfd2RvZyA9IHdh
dGNoZG9nX2dldF9kcnZkYXRhKCZzdF93ZG9nX2Rldik7DQo+ICANCj4gIAlzdF93ZG9nX3NldHVw
KHN0X3dkb2csIGZhbHNlKTsNCj4gLQl3YXRjaGRvZ191bnJlZ2lzdGVyX2RldmljZSgmc3Rfd2Rv
Z19kZXYpOw0KPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShzdF93ZG9nLT5jbGspOw0KPiAgDQo+
ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KDQpBY2tlZC1ieTogUGF0cmljZSBDaG90YXJkIDxwYXRy
aWNlLmNob3RhcmRAc3QuY29tPg0KDQpUaGFua3MNCg==
