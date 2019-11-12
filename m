Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37ADC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82779206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tBu0QLNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKLOJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:09:53 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42873 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfKLOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:09:53 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACDuqqN018120;
        Tue, 12 Nov 2019 15:09:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=jHbqLIGkDg3TeVdZ4Rvu7IZ9xT2WoUqaOpJODt681lE=;
 b=tBu0QLNI68RaJwYBheyd5T0hxfD/tTLo2T6geljr+ZzAt42Zo1YMgKgsUbGYA0aydXbY
 ez+sPAnHAOgqKs6Uk/i9xffBHOMVAvGkc/SYOF68OCyRLPCdM20WqoRkx+w9jTt15URC
 1QhKO7ORGLGCdr1zPiyhKSWXefezcd3UBDYgPrJV8mX+8f0mhPU0z4iK18IJkO5tlQL5
 SC35B+XeXEX280bQdmm35tPoIGHmAOB3cbvYnpZzA/UKczHqY0aGVBGhkpS58oPKOghp
 aRgPl3G+l/HX4G2SAvcmAwk2fAPsjGpfr3ktMHDVI5TOgXW3v/XSlIjRMHfQV5rNu9Cm tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psb2j5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 15:09:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2382810002A;
        Tue, 12 Nov 2019 15:09:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10DA12C1604;
        Tue, 12 Nov 2019 15:09:41 +0100 (CET)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 15:09:40 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Tue, 12 Nov 2019 15:09:40 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2] remoteproc: stm32: fix probe error case
Thread-Topic: [PATCH v2] remoteproc: stm32: fix probe error case
Thread-Index: AQHVfOJqz28evgfEckmKeaDvWZiFgaeGrWIAgAENuoA=
Date:   Tue, 12 Nov 2019 14:09:40 +0000
Message-ID: <392808fa-1504-233f-234b-0cca21886c17@st.com>
References: <1570433991-16353-1-git-send-email-fabien.dessenne@st.com>
 <20191111220416.GB3108315@builder>
In-Reply-To: <20191111220416.GB3108315@builder>
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
Content-ID: <95ED63541F302C428DC02C0FF61927C7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_04:2019-11-11,2019-11-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmpvcm4sDQoNCg0KT24gMTEvMTEvMjAxOSAxMTowNCBQTSwgQmpvcm4gQW5kZXJzc29uIHdy
b3RlOg0KPiBPbiBNb24gMDcgT2N0IDAwOjM5IFBEVCAyMDE5LCBGYWJpZW4gRGVzc2VubmUgd3Jv
dGU6DQo+DQo+PiBJZiB0aGUgcnByb2MgZHJpdmVyIGlzIHByb2JlZCBiZWZvcmUgdGhlIG1haWxi
b3ggZHJpdmVyIGFuZCBpZiB0aGUgcnByb2MNCj4+IERldmljZSBUcmVlIG5vZGUgaGFzIHNvbWUg
bWFpbGJveCBwcm9wZXJ0aWVzLCB0aGUgcnByb2MgZHJpdmVyIHByb2JlDQo+PiBzaGFsbCBiZSBk
ZWZlcnJlZCBpbnN0ZWFkIG9mIGJlaW5nIHByb2JlZCB3aXRob3V0IG1haWxib3ggc3VwcG9ydC4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBz
dC5jb20+DQo+PiAtLS0NCj4+IENoYW5nZXMgc2luY2UgdjE6IHRlc3QgSVNfRVJSKCkgYmVmb3Jl
IGNoZWNraW5nIFBUUl9FUlIoKQ0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvcmVtb3RlcHJvYy9zdG0z
Ml9ycHJvYy5jIHwgMTAgKysrKysrKystLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlbW90
ZXByb2Mvc3RtMzJfcnByb2MuYyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9zdG0zMl9ycHJvYy5jDQo+
PiBpbmRleCAyY2Y0YjI5Li5hNTA3MzMyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9yZW1vdGVw
cm9jL3N0bTMyX3Jwcm9jLmMNCj4+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9zdG0zMl9ycHJv
Yy5jDQo+PiBAQCAtMzEwLDcgKzMxMCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3RtMzJfbWJv
eCBzdG0zMl9ycHJvY19tYm94W01CT1hfTkJfTUJYXSA9IHsNCj4+ICAgCX0NCj4+ICAgfTsNCj4+
ICAgDQo+PiAtc3RhdGljIHZvaWQgc3RtMzJfcnByb2NfcmVxdWVzdF9tYm94KHN0cnVjdCBycHJv
YyAqcnByb2MpDQo+PiArc3RhdGljIGludCBzdG0zMl9ycHJvY19yZXF1ZXN0X21ib3goc3RydWN0
IHJwcm9jICpycHJvYykNCj4+ICAgew0KPj4gICAJc3RydWN0IHN0bTMyX3Jwcm9jICpkZGF0YSA9
IHJwcm9jLT5wcml2Ow0KPj4gICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnJwcm9jLT5kZXY7DQo+
PiBAQCAtMzI5LDEwICszMjksMTQgQEAgc3RhdGljIHZvaWQgc3RtMzJfcnByb2NfcmVxdWVzdF9t
Ym94KHN0cnVjdCBycHJvYyAqcnByb2MpDQo+PiAgIA0KPj4gICAJCWRkYXRhLT5tYltpXS5jaGFu
ID0gbWJveF9yZXF1ZXN0X2NoYW5uZWxfYnluYW1lKGNsLCBuYW1lKTsNCj4+ICAgCQlpZiAoSVNf
RVJSKGRkYXRhLT5tYltpXS5jaGFuKSkgew0KPj4gKwkJCWlmIChQVFJfRVJSKGRkYXRhLT5tYltp
XS5jaGFuKSA9PSAtRVBST0JFX0RFRkVSKQ0KPj4gKwkJCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsN
Cj4gSWYgZm9yIHNvbWUgcmVhc29uIHlvdSBnZXQgRVBST0JFX0RFRkVSIHdoZW4gaSA+IDAgeW91
IG5lZWQgdG8NCj4gbWJveF9mcmVlX2NoYW5uZWwoKSBjaGFubmVscyBbMC4uaSkgYmVmb3JlIHJl
dHVybmluZy4NCg0KVGhlIG1haWxib3ggZnJhbWV3b3JrIHJldHVybnMgRVBST0JFX0RJRkZFUiB0
byBpbmZvcm0gdGhhdCB0aGUgbWFpbGJveCANCnByb3ZpZGVyIGhhcyBub3QgcmVnaXN0ZXJlZCB5
ZXQuIEkgZG8gbm90IGV4cGVjdGVkIHRvIGhhdmUgYSBzdWNjZXNzIA0KZm9sbG93ZWQgYnkgYSBF
UFJPQkVfREVGRVIgZXJyb3IuDQoNCkJ1dCBpbiB0aGUgdmVyeSBzcGVjaWFsIGNhc2Ugd2hlcmUg
d2UgdXNlIHR3byBkaWZmZXJlbnQgbWFpbGJveCANCnByb3ZpZGVycyB0aGlzIG1heSBoYXBwZW4u
DQoNCkkgd2lsbCBzZW5kIGFuIHVwZGF0ZWQgdmVyc2lvbiwgdGhhbmtzIGZvciBwb2ludGluZyB0
aGlzLg0KDQpCUg0KDQpGYWJpZW4NCg0KPg0KPiBSZWdhcmRzLA0KPiBCam9ybg0KPg0KPj4gICAJ
CQlkZXZfd2FybihkZXYsICJjYW5ub3QgZ2V0ICVzIG1ib3hcbiIsIG5hbWUpOw0KPj4gICAJCQlk
ZGF0YS0+bWJbaV0uY2hhbiA9IE5VTEw7DQo+PiAgIAkJfQ0KPj4gICAJfQ0KPj4gKw0KPj4gKwly
ZXR1cm4gMDsNCj4+ICAgfQ0KPj4gICANCj4+ICAgc3RhdGljIGludCBzdG0zMl9ycHJvY19zZXRf
aG9sZF9ib290KHN0cnVjdCBycHJvYyAqcnByb2MsIGJvb2wgaG9sZCkNCj4+IEBAIC01OTYsNyAr
NjAwLDkgQEAgc3RhdGljIGludCBzdG0zMl9ycHJvY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPj4gICAJaWYgKHJldCkNCj4+ICAgCQlnb3RvIGZyZWVfcnByb2M7DQo+PiAg
IA0KPj4gLQlzdG0zMl9ycHJvY19yZXF1ZXN0X21ib3gocnByb2MpOw0KPj4gKwlyZXQgPSBzdG0z
Ml9ycHJvY19yZXF1ZXN0X21ib3gocnByb2MpOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJZ290byBm
cmVlX3Jwcm9jOw0KPj4gICANCj4+ICAgCXJldCA9IHJwcm9jX2FkZChycHJvYyk7DQo+PiAgIAlp
ZiAocmV0KQ0KPj4gLS0gDQo+PiAyLjcuNA0KPj4=
