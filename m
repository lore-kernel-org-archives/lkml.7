Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D984C282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C163021855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Mhms55/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfDEQc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:32:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44286 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731183AbfDEQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:32:27 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35GVM8Y014365;
        Fri, 5 Apr 2019 18:32:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=iq9AuM8NQpqF04s6Qr02BqcJsEwf2aDbe/RpmYXNhoA=;
 b=Mhms55/TdZ7M6XhxLn+CX/ZXF4/Cfq11dbWOs6sqH9fywtt9bOfQaXYd1C7dqayDa39K
 OM8ydpg7kB344Aq58s0BTItvINkjraNIcoxbk3+2Uv/zg0YxbfSosYU3kZOfl5NW9Ho3
 EC2HBHI183rdeyysEHEUcFp7BfKK1Cc8/ajpxXWM+VVaTKlDCQejrQJ6B5Zc7QV8Debt
 OtT46+PBqP0o2D7D0t1dM61VDmRuBU+gQY+x98beOjv7HHwB/8PdbekxIr2ulkXv3zOq
 ZxFyXIkgnGVdqzG6AHIbSHG/Un0uOx7H/YjfZGe4XaeS0MdrTiM6k08kqUrVpCgP22yW tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rmh5yu34f-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 18:32:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4677D38;
        Fri,  5 Apr 2019 16:32:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21B875011;
        Fri,  5 Apr 2019 16:32:15 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr
 2019 18:32:14 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 5 Apr 2019 18:32:14 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: add modifier support
Thread-Topic: [PATCH] drm/stm: ltdc: add modifier support
Thread-Index: AQHU6f8o8bz7wrZU3U6xnPkTXIgfm6YtpLmA
Date:   Fri, 5 Apr 2019 16:32:14 +0000
Message-ID: <f031fc0f-ea81-1083-df7a-e7ce413d2868@st.com>
References: <1554283514-2960-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1554283514-2960-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0F393FEFD351C46B3D28D7471A9BE85@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMy8xOSAxMToyNSBBTSwgWWFubmljayBGZXJ0csOpIHdyb3RlOg0KPiBTaWduZWQt
b2ZmLWJ5OiBNaWNrYWVsIFJldWxpZXIgPG1pY2thZWwucmV1bGllckBzdC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFlhbm5pY2sgRmVydHLDqSA8eWFubmljay5mZXJ0cmVAc3QuY29tPg0KPiAtLS0N
Cj4gICBkcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyB8IDIxICsrKysrKysrKysrKysrKysrKysr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgYi9kcml2ZXJzL2dw
dS9kcm0vc3RtL2x0ZGMuYw0KPiBpbmRleCBiMTc0MWE5Li42ZmE4ZmJjIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc3Rt
L2x0ZGMuYw0KPiBAQCAtMjMyLDYgKzIzMiwxMSBAQCBzdGF0aWMgY29uc3QgZW51bSBsdGRjX3Bp
eF9mbXQgbHRkY19waXhfZm10X2ExW05CX1BGXSA9IHsNCj4gICAJUEZfQVJHQjQ0NDQJCS8qIDB4
MDcgKi8NCj4gICB9Ow0KPiAgIA0KPiArc3RhdGljIGNvbnN0IHU2NCBsdGRjX2Zvcm1hdF9tb2Rp
ZmllcnNbXSA9IHsNCj4gKwlEUk1fRk9STUFUX01PRF9MSU5FQVIsDQo+ICsJRFJNX0ZPUk1BVF9N
T0RfSU5WQUxJRA0KPiArfTsNCj4gKw0KPiAgIHN0YXRpYyBpbmxpbmUgdTMyIHJlZ19yZWFkKHZv
aWQgX19pb21lbSAqYmFzZSwgdTMyIHJlZykNCj4gICB7DQo+ICAgCXJldHVybiByZWFkbF9yZWxh
eGVkKGJhc2UgKyByZWcpOw0KPiBAQCAtODY0LDYgKzg2OSwxNiBAQCBzdGF0aWMgdm9pZCBsdGRj
X3BsYW5lX2F0b21pY19wcmludF9zdGF0ZShzdHJ1Y3QgZHJtX3ByaW50ZXIgKnAsDQo+ICAgCWZw
c2ktPmNvdW50ZXIgPSAwOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBib29sIGx0ZGNfcGxhbmVf
Zm9ybWF0X21vZF9zdXBwb3J0ZWQoc3RydWN0IGRybV9wbGFuZSAqcGxhbmUsDQo+ICsJCQkJCSAg
ICB1MzIgZm9ybWF0LA0KPiArCQkJCQkgICAgdTY0IG1vZGlmaWVyKQ0KPiArew0KPiArCWlmICht
b2RpZmllciA9PSBEUk1fRk9STUFUX01PRF9MSU5FQVIpDQo+ICsJCXJldHVybiB0cnVlOw0KPiAr
DQo+ICsJcmV0dXJuIGZhbHNlOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
cm1fcGxhbmVfZnVuY3MgbHRkY19wbGFuZV9mdW5jcyA9IHsNCj4gICAJLnVwZGF0ZV9wbGFuZSA9
IGRybV9hdG9taWNfaGVscGVyX3VwZGF0ZV9wbGFuZSwNCj4gICAJLmRpc2FibGVfcGxhbmUgPSBk
cm1fYXRvbWljX2hlbHBlcl9kaXNhYmxlX3BsYW5lLA0KPiBAQCAtODcyLDYgKzg4Nyw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX3BsYW5lX2Z1bmNzIGx0ZGNfcGxhbmVfZnVuY3MgPSB7DQo+
ICAgCS5hdG9taWNfZHVwbGljYXRlX3N0YXRlID0gZHJtX2F0b21pY19oZWxwZXJfcGxhbmVfZHVw
bGljYXRlX3N0YXRlLA0KPiAgIAkuYXRvbWljX2Rlc3Ryb3lfc3RhdGUgPSBkcm1fYXRvbWljX2hl
bHBlcl9wbGFuZV9kZXN0cm95X3N0YXRlLA0KPiAgIAkuYXRvbWljX3ByaW50X3N0YXRlID0gbHRk
Y19wbGFuZV9hdG9taWNfcHJpbnRfc3RhdGUsDQo+ICsJLmZvcm1hdF9tb2Rfc3VwcG9ydGVkID0g
bHRkY19wbGFuZV9mb3JtYXRfbW9kX3N1cHBvcnRlZCwNCj4gICB9Ow0KPiAgIA0KPiAgIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZHJtX3BsYW5lX2hlbHBlcl9mdW5jcyBsdGRjX3BsYW5lX2hlbHBlcl9m
dW5jcyA9IHsNCj4gQEAgLTg5MCw2ICs5MDYsNyBAQCBzdGF0aWMgc3RydWN0IGRybV9wbGFuZSAq
bHRkY19wbGFuZV9jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYsDQo+ICAgCXVuc2lnbmVk
IGludCBpLCBuYl9mbXQgPSAwOw0KPiAgIAl1MzIgZm9ybWF0c1tOQl9QRiAqIDJdOw0KPiAgIAl1
MzIgZHJtX2ZtdCwgZHJtX2ZtdF9ub19hbHBoYTsNCj4gKwljb25zdCB1NjQgKm1vZGlmaWVycyA9
IGx0ZGNfZm9ybWF0X21vZGlmaWVyczsNCj4gICAJaW50IHJldDsNCj4gICANCj4gICAJLyogR2V0
IHN1cHBvcnRlZCBwaXhlbCBmb3JtYXRzICovDQo+IEBAIC05MTgsNyArOTM1LDcgQEAgc3RhdGlj
IHN0cnVjdCBkcm1fcGxhbmUgKmx0ZGNfcGxhbmVfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZGV2LA0KPiAgIA0KPiAgIAlyZXQgPSBkcm1fdW5pdmVyc2FsX3BsYW5lX2luaXQoZGRldiwgcGxh
bmUsIHBvc3NpYmxlX2NydGNzLA0KPiAgIAkJCQkgICAgICAgJmx0ZGNfcGxhbmVfZnVuY3MsIGZv
cm1hdHMsIG5iX2ZtdCwNCj4gLQkJCQkgICAgICAgTlVMTCwgdHlwZSwgTlVMTCk7DQo+ICsJCQkJ
ICAgICAgIG1vZGlmaWVycywgdHlwZSwgTlVMTCk7DQo+ICAgCWlmIChyZXQgPCAwKQ0KPiAgIAkJ
cmV0dXJuIE5VTEw7DQo+ICAgDQo+IEBAIC0xMTc5LDYgKzExOTYsOCBAQCBpbnQgbHRkY19sb2Fk
KHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2KQ0KPiAgIAkJZ290byBlcnI7DQo+ICAgCX0NCj4gICAN
Cj4gKwlkZGV2LT5tb2RlX2NvbmZpZy5hbGxvd19mYl9tb2RpZmllcnMgPSB0cnVlOw0KPiArDQoN
Cg0KQWNrZWQtYnk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQoNClBo
aWxpcHBlIDopDQoNCj4gICAJcmV0ID0gbHRkY19jcnRjX2luaXQoZGRldiwgY3J0Yyk7DQo+ICAg
CWlmIChyZXQpIHsNCj4gICAJCURSTV9FUlJPUigiRmFpbGVkIHRvIGluaXQgY3J0Y1xuIik7DQo+
IA==
