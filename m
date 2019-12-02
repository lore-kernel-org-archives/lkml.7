Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C5C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3E120833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rnSYxE9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfLBRTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:19:17 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727628AbfLBRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:19:17 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2HCrok015839;
        Mon, 2 Dec 2019 18:18:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=ajIX9WQCsBYLKyNEdOZyKdS4oEk7N1oMheg1Z9YD/LU=;
 b=rnSYxE9be3BTdERhx7CdwME9chL5wHCPU6DHd5Ak/qF2JFkVV67kr4JAZPuKzA3A2YDU
 XgX3G5euB1YxPfnYctv9/ncDz2j47mvc7S0GpU+XAXdwedDyXsA2+mR2ouN425qVNaZO
 M168QwGgtmU6JpT01uzOkaroifTZ1obJindrjHEEhONhCXizWgx/8Ym1nTDGDkAg6TIi
 ibxA2z/LAPNKWX2FIAF+FgL+m2RlD/TpvJpEh9dFDmejP+goVuuIa6Y7jhzUHoDYkzce
 HKfG7PdFnv8UJ30/Ii29shdf9NvRdUiO19k4qDq6ZFG5DeNeV5d331bzTZftf/WpwcGn ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wkes2k09n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 18:18:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7CED010002A;
        Mon,  2 Dec 2019 18:18:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 40B162AF6B8;
        Mon,  2 Dec 2019 18:18:46 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Dec
 2019 18:18:45 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Mon, 2 Dec 2019 18:18:45 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: move pinctrl to encoder mode set
Thread-Topic: [PATCH] drm/stm: ltdc: move pinctrl to encoder mode set
Thread-Index: AQHVpQy83g+L3HcPpECGo0y4vMZ4rqenDjcA
Date:   Mon, 2 Dec 2019 17:18:45 +0000
Message-ID: <90e15f5b-0b65-1de7-229d-c8e0470071b5@st.com>
References: <1574850218-13257-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1574850218-13257-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD1DE62153C9A94B962ABF94CB242BED@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_03:2019-11-29,2019-12-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLA0KDQpBY2tlZC1ieTogUGhp
bGlwcGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0pDQoNCk9u
IDExLzI3LzE5IDExOjIzIEFNLCBZYW5uaWNrIEZlcnRyZSB3cm90ZToNCj4gRnJvbTogWWFubmlj
ayBGZXJ0csOpIDx5YW5uaWNrLmZlcnRyZUBzdC5jb20+DQo+IA0KPiBUaGUgcGluIGNvbnRyb2wg
bXVzdCBiZSBzZXQgdG8gZGVmYXVsdCBhcyBzb29uIGFzIHBvc3NpYmxlIHRvDQo+IGVzdGFibGlz
aCBhIGdvb2QgdmlkZW8gbGluayBiZXR3ZWVuIHR2ICYgYnJpZGdlIGhkbWkNCj4gKGVuY29kZXIg
bW9kZSBzZXQgaXMgY2FsbCBiZWZvcmUgZW5jb2RlciBlbmFibGUpLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogWWFubmljayBGZXJ0cmUgPHlhbm5pY2suZmVydHJlQHN0LmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgfCAyNCArKysrKysrKysrKysrKysrKystLS0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9zdG0vbHRkYy5jDQo+IGluZGV4IDQ5ZWY0MDYuLmRiYThlN2YgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0v
bHRkYy5jDQo+IEBAIC00MzUsOSArNDM1LDYgQEAgc3RhdGljIHZvaWQgbHRkY19jcnRjX2F0b21p
Y19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiAgIAkvKiBDb21taXQgc2hhZG93IHJl
Z2lzdGVycyA9IHVwZGF0ZSBwbGFuZXMgYXQgbmV4dCB2YmxhbmsgKi8NCj4gICAJcmVnX3NldChs
ZGV2LT5yZWdzLCBMVERDX1NSQ1IsIFNSQ1JfVkJSKTsNCj4gICANCj4gLQkvKiBFbmFibGUgTFRE
QyAqLw0KPiAtCXJlZ19zZXQobGRldi0+cmVncywgTFREQ19HQ1IsIEdDUl9MVERDRU4pOw0KPiAt
DQo+ICAgCWRybV9jcnRjX3ZibGFua19vbihjcnRjKTsNCj4gICB9DQo+ICAgDQo+IEBAIC00NTEs
OSArNDQ4LDYgQEAgc3RhdGljIHZvaWQgbHRkY19jcnRjX2F0b21pY19kaXNhYmxlKHN0cnVjdCBk
cm1fY3J0YyAqY3J0YywNCj4gICANCj4gICAJZHJtX2NydGNfdmJsYW5rX29mZihjcnRjKTsNCj4g
ICANCj4gLQkvKiBkaXNhYmxlIExUREMgKi8NCj4gLQlyZWdfY2xlYXIobGRldi0+cmVncywgTFRE
Q19HQ1IsIEdDUl9MVERDRU4pOw0KPiAtDQo+ICAgCS8qIGRpc2FibGUgSVJRICovDQo+ICAgCXJl
Z19jbGVhcihsZGV2LT5yZWdzLCBMVERDX0lFUiwgSUVSX1JSSUUgfCBJRVJfRlVJRSB8IElFUl9U
RVJSSUUpOw0KPiAgIA0KPiBAQCAtMTA0Miw5ICsxMDM2LDEzIEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZHJtX2VuY29kZXJfZnVuY3MgbHRkY19lbmNvZGVyX2Z1bmNzID0gew0KPiAgIHN0YXRpYyB2
b2lkIGx0ZGNfZW5jb2Rlcl9kaXNhYmxlKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlcikNCj4g
ICB7DQo+ICAgCXN0cnVjdCBkcm1fZGV2aWNlICpkZGV2ID0gZW5jb2Rlci0+ZGV2Ow0KPiArCXN0
cnVjdCBsdGRjX2RldmljZSAqbGRldiA9IGRkZXYtPmRldl9wcml2YXRlOw0KPiAgIA0KPiAgIAlE
Uk1fREVCVUdfRFJJVkVSKCJcbiIpOw0KPiAgIA0KPiArCS8qIERpc2FibGUgTFREQyAqLw0KPiAr
CXJlZ19jbGVhcihsZGV2LT5yZWdzLCBMVERDX0dDUiwgR0NSX0xURENFTik7DQo+ICsNCj4gICAJ
LyogU2V0IHRvIHNsZWVwIHN0YXRlIHRoZSBwaW5jdHJsIHdoYXRldmVyIHR5cGUgb2YgZW5jb2Rl
ciAqLw0KPiAgIAlwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9zdGF0ZShkZGV2LT5kZXYpOw0KPiAg
IH0NCj4gQEAgLTEwNTIsNiArMTA1MCwxOSBAQCBzdGF0aWMgdm9pZCBsdGRjX2VuY29kZXJfZGlz
YWJsZShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIpDQo+ICAgc3RhdGljIHZvaWQgbHRkY19l
bmNvZGVyX2VuYWJsZShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIpDQo+ICAgew0KPiAgIAlz
dHJ1Y3QgZHJtX2RldmljZSAqZGRldiA9IGVuY29kZXItPmRldjsNCj4gKwlzdHJ1Y3QgbHRkY19k
ZXZpY2UgKmxkZXYgPSBkZGV2LT5kZXZfcHJpdmF0ZTsNCj4gKw0KPiArCURSTV9ERUJVR19EUklW
RVIoIlxuIik7DQo+ICsNCj4gKwkvKiBFbmFibGUgTFREQyAqLw0KPiArCXJlZ19zZXQobGRldi0+
cmVncywgTFREQ19HQ1IsIEdDUl9MVERDRU4pOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBs
dGRjX2VuY29kZXJfbW9kZV9zZXQoc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyLA0KPiArCQkJ
CSAgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUsDQo+ICsJCQkJICBzdHJ1Y3QgZHJtX2Rp
c3BsYXlfbW9kZSAqYWRqdXN0ZWRfbW9kZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgZHJtX2RldmljZSAq
ZGRldiA9IGVuY29kZXItPmRldjsNCj4gICANCj4gICAJRFJNX0RFQlVHX0RSSVZFUigiXG4iKTsN
Cj4gICANCj4gQEAgLTEwNjcsNiArMTA3OCw3IEBAIHN0YXRpYyB2b2lkIGx0ZGNfZW5jb2Rlcl9l
bmFibGUoc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyKQ0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZHJtX2VuY29kZXJfaGVscGVyX2Z1bmNzIGx0ZGNfZW5jb2Rlcl9oZWxwZXJfZnVuY3MgPSB7
DQo+ICAgCS5kaXNhYmxlID0gbHRkY19lbmNvZGVyX2Rpc2FibGUsDQo+ICAgCS5lbmFibGUgPSBs
dGRjX2VuY29kZXJfZW5hYmxlLA0KPiArCS5tb2RlX3NldCA9IGx0ZGNfZW5jb2Rlcl9tb2RlX3Nl
dCwNCj4gICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgbHRkY19lbmNvZGVyX2luaXQoc3RydWN0
IGRybV9kZXZpY2UgKmRkZXYsIHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UpDQo+IA==
