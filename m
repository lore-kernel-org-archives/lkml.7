Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508C520661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lcE3DBPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbgAIQTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:19:06 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57517 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729722AbgAIQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:19:04 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009G7nSU029953;
        Thu, 9 Jan 2020 17:18:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=idKaq3yf7AW1Ooj8i11PIIlN4aaycLYtIV7dTwDVLvA=;
 b=lcE3DBPva4g9K59cg+eKniB2pli9JCUeDkQxApL2qyaRjEDnxeTWIrlzTil27CApak9V
 gUNoHGloW1qni/9eJwvIxeFNo3lLvdFv+x4cqYHyKzpktwZao7+QPb4r3l3eKpM7Liaf
 eQHb5XAbagfrKHWbQD/3Khsfm1IccniycqzDALVJ2GoUh7NxtG0D0QmBdG2Fn2CT29CY
 cKsMmDaIebawhqz3Y1sq2RG3NLL6fd88ZvIpIY8YqBS4EIJzmlVcL9CbwLjLIvEtvbcT
 beUw4f892SoxwYxvXJ/l6CuseA3pcFi/Sp5qUYocCNbntYQt09B9Ire3EeGZ+Qx/1hsm JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur2n6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 17:18:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 989FF10002A;
        Thu,  9 Jan 2020 17:18:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3E1922C6A6E;
        Thu,  9 Jan 2020 17:18:41 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Jan
 2020 17:18:40 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 9 Jan 2020 17:18:40 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "yakui.zhao@intel.com" <yakui.zhao@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/modes: tag unused variables to avoid warnings
Thread-Topic: [PATCH] drm/modes: tag unused variables to avoid warnings
Thread-Index: AQHVr0QHe45uG+/0wEOCcI9XDhFsl6ffTFuAgANVQQA=
Date:   Thu, 9 Jan 2020 16:18:40 +0000
Message-ID: <ab5d769f-60ff-e99d-6802-d93f94fd240d@st.com>
References: <20191210102437.19377-1-benjamin.gaignard@st.com>
 <ec3838df-6e8a-b0d9-4b00-2fcd07f97630@suse.de>
In-Reply-To: <ec3838df-6e8a-b0d9-4b00-2fcd07f97630@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D968947B67812B498EA79ABC97EB4C37@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzcvMjAgMjoyNCBQTSwgVGhvbWFzIFppbW1lcm1hbm4gd3JvdGU6DQo+IEhpDQo+DQo+
IEFtIDEwLjEyLjE5IHVtIDExOjI0IHNjaHJpZWIgQmVuamFtaW4gR2FpZ25hcmQ6DQo+PiBTb21l
IHZhcmlhYmxlcyBhcmUgc2V0IGJ1dCBuZXZlciB1c2VkLiBUbyBhdm9pZCB3YXJuaW5nIHdoZW4g
Y29tcGlsaW5nDQo+PiB3aXRoIFc9MSBhbmQga2VlcCB0aGUgYWxnb3JpdGhtIGxpa2UgaXQgaXMg
dGFnIHRoZXNlcyB2YXJpYWJsZXMNCj4+IHdpdGggX21heWJlX3VudXNlZCBtYWNyby4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3Qu
Y29tPg0KPiBBY2tlZC1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+
DQoNCkFwcGxpZWQgb24gZHJtLW1pc2MtbmV4dC4NCg0KVGhhbmtzLA0KDQpCZW5qYW1pbg0KDQo+
DQo+PiAtLS0NCj4+IGNoYW5nZXMgaW4gdGhpcyB2ZXJzaW9uOg0KPj4gLSBkbyBub3QgbW9kaWZ5
IHRoZSBjb2RlIHRvIHJlbW92ZSB0aGUgdW51c2VkIHZhcmlhYmxlcw0KPj4gICAganVzdCBwcmVm
aXggdGhlbSB3aXRoIF9fbWF5YmVfdW51c2VkIG1hY3JvLg0KPj4gICAgDQo+PiAgIGRyaXZlcnMv
Z3B1L2RybS9kcm1fbW9kZXMuYyB8IDkgKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9kcm1fbW9kZXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fbW9kZXMuYw0KPj4g
aW5kZXggODgyMzI2OThkN2EwLi43MGFlZDRlMjk5MGQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vZHJtX21vZGVzLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fbW9kZXMu
Yw0KPj4gQEAgLTIzMyw3ICsyMzMsNyBAQCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqZHJtX2N2
dF9tb2RlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGludCBoZGlzcGxheSwNCj4+ICAgCQkvKiAz
KSBOb21pbmFsIEhTeW5jIHdpZHRoICglIG9mIGxpbmUgcGVyaW9kKSAtIGRlZmF1bHQgOCAqLw0K
Pj4gICAjZGVmaW5lIENWVF9IU1lOQ19QRVJDRU5UQUdFCTgNCj4+ICAgCQl1bnNpZ25lZCBpbnQg
aGJsYW5rX3BlcmNlbnRhZ2U7DQo+PiAtCQlpbnQgdnN5bmNhbmRiYWNrX3BvcmNoLCB2YmFja19w
b3JjaCwgaGJsYW5rOw0KPj4gKwkJaW50IHZzeW5jYW5kYmFja19wb3JjaCwgX19tYXliZV91bnVz
ZWQgdmJhY2tfcG9yY2gsIGhibGFuazsNCj4+ICAgDQo+PiAgIAkJLyogZXN0aW1hdGVkIHRoZSBo
b3Jpem9udGFsIHBlcmlvZCAqLw0KPj4gICAJCXRtcDEgPSBIVl9GQUNUT1IgKiAxMDAwMDAwICAt
DQo+PiBAQCAtMzg2LDkgKzM4NiwxMCBAQCBkcm1fZ3RmX21vZGVfY29tcGxleChzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2LCBpbnQgaGRpc3BsYXksIGludCB2ZGlzcGxheSwNCj4+ICAgCWludCB0b3Bf
bWFyZ2luLCBib3R0b21fbWFyZ2luOw0KPj4gICAJaW50IGludGVybGFjZTsNCj4+ICAgCXVuc2ln
bmVkIGludCBoZnJlcV9lc3Q7DQo+PiAtCWludCB2c3luY19wbHVzX2JwLCB2YmFja19wb3JjaDsN
Cj4+IC0JdW5zaWduZWQgaW50IHZ0b3RhbF9saW5lcywgdmZpZWxkcmF0ZV9lc3QsIGhwZXJpb2Q7
DQo+PiAtCXVuc2lnbmVkIGludCB2ZmllbGRfcmF0ZSwgdmZyYW1lX3JhdGU7DQo+PiArCWludCB2
c3luY19wbHVzX2JwLCBfX21heWJlX3VudXNlZCB2YmFja19wb3JjaDsNCj4+ICsJdW5zaWduZWQg
aW50IHZ0b3RhbF9saW5lcywgX19tYXliZV91bnVzZWQgdmZpZWxkcmF0ZV9lc3Q7DQo+PiArCXVu
c2lnbmVkIGludCBfX21heWJlX3VudXNlZCBocGVyaW9kOw0KPj4gKwl1bnNpZ25lZCBpbnQgdmZp
ZWxkX3JhdGUsIF9fbWF5YmVfdW51c2VkIHZmcmFtZV9yYXRlOw0KPj4gICAJaW50IGxlZnRfbWFy
Z2luLCByaWdodF9tYXJnaW47DQo+PiAgIAl1bnNpZ25lZCBpbnQgdG90YWxfYWN0aXZlX3BpeGVs
cywgaWRlYWxfZHV0eV9jeWNsZTsNCj4+ICAgCXVuc2lnbmVkIGludCBoYmxhbmssIHRvdGFsX3Bp
eGVscywgcGl4ZWxfZnJlcTsNCj4+
