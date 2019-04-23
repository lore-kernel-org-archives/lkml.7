Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3D8214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IK5VFbcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfDWNah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:30:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60489 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbfDWNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:30:37 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NDRI1Z030720;
        Tue, 23 Apr 2019 15:29:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=ziBi1b9KCM/HRjGNBDnks5nEaa5asmpnQ6wixB7M/r4=;
 b=IK5VFbcOwQBzyG2y3Npjaw/kVVClqXWOKkt8l/Wa1RuElSIysQDlf2sabpiJi2lElMJm
 OYCAZtmA4iMDPJORvzwZ3A+XvhxvyViT4AuMRkGvh3XnmKNyLmm8BQEu7v64M26vFeIs
 BTiHkkx1PRRgqlek0RVX2v8mBjpx3A+Hj+73jap4Zt9jFIWEYPAKx6susKDEWg0mcnkY
 pGfRFiAKpzhs52XHs6IlRBKE44LDNstYCfHt8HzObAEeGFPTNsHI36nZ8bLqZDftmhrV
 wnMMradGSAnXFHp0D2JynXepgirpjdSPWAnK6Cnk9R6W7jLsWRbx8sK9SHI0hmvTxk6D 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6rqpcs-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Apr 2019 15:29:41 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7A0A38;
        Tue, 23 Apr 2019 13:29:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 621F526CC;
        Tue, 23 Apr 2019 13:29:38 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 23 Apr
 2019 15:29:38 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 23 Apr 2019 15:29:37 +0200
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: stm32: simplify dai driver initialisation
Thread-Topic: [PATCH] ASoC: stm32: simplify dai driver initialisation
Thread-Index: AQHU65G62eNTx3G20k6GNDjWIJYtyqZJuIaA
Date:   Tue, 23 Apr 2019 13:29:37 +0000
Message-ID: <9cb0aea8-81d3-3122-da55-2ee0c90809e8@st.com>
References: <1554456387-3088-1-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1554456387-3088-1-git-send-email-arnaud.pouliquen@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BA1FD71D75DC14A8BA5064AFB8FBA14@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQXJuYXVkLA0KDQpPbiA0LzUvMTkgMTE6MjYgQU0sIEFybmF1ZCBQb3VsaXF1ZW4gd3Jv
dGU6DQo+IFN1cHByZXNzIHRoZSB1c2VsZXNzIGR5bmFtaWMgYWxsb2NhdGlvbiBvZiB0aGUgZGFp
IGRyaXZlciBzdHJ1Y3R1cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBcm5hdWQgUG91bGlxdWVu
IDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT4NCj4gLS0tDQo+ICAgc291bmQvc29jL3N0bS9zdG0z
Ml9zYWlfc3ViLmMgfCA0MyArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3N0bS9zdG0zMl9zYWlfc3ViLmMgYi9zb3Vu
ZC9zb2Mvc3RtL3N0bTMyX3NhaV9zdWIuYw0KPiBpbmRleCAzZGQ1NGJjLi5lM2IwMjFjIDEwMDY0
NA0KPiAtLS0gYS9zb3VuZC9zb2Mvc3RtL3N0bTMyX3NhaV9zdWIuYw0KPiArKysgYi9zb3VuZC9z
b2Mvc3RtL3N0bTMyX3NhaV9zdWIuYw0KPiBAQCAtMTA5LDcgKzEwOSw3IEBAIHN0cnVjdCBzdG0z
Ml9zYWlfc3ViX2RhdGEgew0KPiAgIAlzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ICAgCWNvbnN0
IHN0cnVjdCByZWdtYXBfY29uZmlnICpyZWdtYXBfY29uZmlnOw0KPiAgIAlzdHJ1Y3Qgc25kX2Rt
YWVuZ2luZV9kYWlfZG1hX2RhdGEgZG1hX3BhcmFtczsNCj4gLQlzdHJ1Y3Qgc25kX3NvY19kYWlf
ZHJpdmVyICpjcHVfZGFpX2RydjsNCj4gKwlzdHJ1Y3Qgc25kX3NvY19kYWlfZHJpdmVyIGNwdV9k
YWlfZHJ2Ow0KPiAgIAlzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWk7DQo+ICAgCXN0cnVjdCBz
bmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtOw0KPiAgIAlzdHJ1Y3Qgc3RtMzJfc2FpX2RhdGEg
KnBkYXRhOw0KPiBAQCAtMTIwNCw4ICsxMjA0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRf
cGNtX2hhcmR3YXJlIHN0bTMyX3NhaV9wY21faHcgPSB7DQo+ICAgCS5wZXJpb2RzX21heCA9IDgs
DQo+ICAgfTsNCj4gICANCj4gLXN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfZHJpdmVyIHN0bTMy
X3NhaV9wbGF5YmFja19kYWlbXSA9IHsNCj4gLXsNCj4gK3N0YXRpYyBzdHJ1Y3Qgc25kX3NvY19k
YWlfZHJpdmVyIHN0bTMyX3NhaV9wbGF5YmFja19kYWkgPSB7DQo+ICAgCQkucHJvYmUgPSBzdG0z
Ml9zYWlfZGFpX3Byb2JlLA0KPiAgIAkJLnBjbV9uZXcgPSBzdG0zMl9zYWlfcGNtX25ldywNCj4g
ICAJCS5pZCA9IDEsIC8qIGF2b2lkIGNhbGwgdG8gZm10X3NpbmdsZV9uYW1lKCkgKi8NCj4gQEAg
LTEyMjIsMTEgKzEyMjEsOSBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciBzdG0z
Ml9zYWlfcGxheWJhY2tfZGFpW10gPSB7DQo+ICAgCQkJCVNORFJWX1BDTV9GTVRCSVRfUzMyX0xF
LA0KPiAgIAkJfSwNCj4gICAJCS5vcHMgPSAmc3RtMzJfc2FpX3BjbV9kYWlfb3BzLA0KPiAtCX0N
Cj4gICB9Ow0KPiAgIA0KPiAtc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9kcml2ZXIgc3RtMzJf
c2FpX2NhcHR1cmVfZGFpW10gPSB7DQo+IC17DQo+ICtzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFp
X2RyaXZlciBzdG0zMl9zYWlfY2FwdHVyZV9kYWkgPSB7DQo+ICAgCQkucHJvYmUgPSBzdG0zMl9z
YWlfZGFpX3Byb2JlLA0KPiAgIAkJLmlkID0gMSwgLyogYXZvaWQgY2FsbCB0byBmbXRfc2luZ2xl
X25hbWUoKSAqLw0KPiAgIAkJLmNhcHR1cmUgPSB7DQo+IEBAIC0xMjQyLDcgKzEyMzksNiBAQCBz
dGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciBzdG0zMl9zYWlfY2FwdHVyZV9kYWlbXSA9
IHsNCj4gICAJCQkJU05EUlZfUENNX0ZNVEJJVF9TMzJfTEUsDQo+ICAgCQl9LA0KPiAgIAkJLm9w
cyA9ICZzdG0zMl9zYWlfcGNtX2RhaV9vcHMsDQo+IC0JfQ0KPiAgIH07DQo+ICAgDQo+ICAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBzbmRfZG1hZW5naW5lX3BjbV9jb25maWcgc3RtMzJfc2FpX3BjbV9j
b25maWcgPSB7DQo+IEBAIC0xNDExLDI5ICsxNDA3LDYgQEAgc3RhdGljIGludCBzdG0zMl9zYWlf
c3ViX3BhcnNlX29mKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ICAgCXJldHVybiAw
Ow0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbnQgc3RtMzJfc2FpX3N1Yl9kYWlzX2luaXQoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gLQkJCQkgICBzdHJ1Y3Qgc3RtMzJfc2FpX3N1
Yl9kYXRhICpzYWkpDQo+IC17DQo+IC0Jc2FpLT5jcHVfZGFpX2RydiA9IGRldm1fa3phbGxvYygm
cGRldi0+ZGV2LA0KPiAtCQkJCQlzaXplb2Yoc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciksDQo+
IC0JCQkJCUdGUF9LRVJORUwpOw0KPiAtCWlmICghc2FpLT5jcHVfZGFpX2RydikNCj4gLQkJcmV0
dXJuIC1FTk9NRU07DQo+IC0NCj4gLQlpZiAoU1RNX1NBSV9JU19QTEFZQkFDSyhzYWkpKSB7DQo+
IC0JCW1lbWNweShzYWktPmNwdV9kYWlfZHJ2LCAmc3RtMzJfc2FpX3BsYXliYWNrX2RhaSwNCj4g
LQkJICAgICAgIHNpemVvZihzdG0zMl9zYWlfcGxheWJhY2tfZGFpKSk7DQo+IC0JCXNhaS0+Y3B1
X2RhaV9kcnYtPnBsYXliYWNrLnN0cmVhbV9uYW1lID0gc2FpLT5jcHVfZGFpX2Rydi0+bmFtZTsN
Cj4gLQl9IGVsc2Ugew0KPiAtCQltZW1jcHkoc2FpLT5jcHVfZGFpX2RydiwgJnN0bTMyX3NhaV9j
YXB0dXJlX2RhaSwNCj4gLQkJICAgICAgIHNpemVvZihzdG0zMl9zYWlfY2FwdHVyZV9kYWkpKTsN
Cj4gLQkJc2FpLT5jcHVfZGFpX2Rydi0+Y2FwdHVyZS5zdHJlYW1fbmFtZSA9IHNhaS0+Y3B1X2Rh
aV9kcnYtPm5hbWU7DQo+IC0JfQ0KPiAtCXNhaS0+Y3B1X2RhaV9kcnYtPm5hbWUgPSBkZXZfbmFt
ZSgmcGRldi0+ZGV2KTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAtfQ0KPiAtDQo+ICAgc3RhdGlj
IGludCBzdG0zMl9zYWlfc3ViX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAgew0KPiAgIAlzdHJ1Y3Qgc3RtMzJfc2FpX3N1Yl9kYXRhICpzYWk7DQo+IEBAIC0xNDY1LDkg
KzE0MzgsMTEgQEAgc3RhdGljIGludCBzdG0zMl9zYWlfc3ViX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAgCWlmIChyZXQpDQo+ICAgCQlyZXR1cm4gcmV0Ow0KPiAgIA0K
PiAtCXJldCA9IHN0bTMyX3NhaV9zdWJfZGFpc19pbml0KHBkZXYsIHNhaSk7DQo+IC0JaWYgKHJl
dCkNCj4gLQkJcmV0dXJuIHJldDsNCj4gKwlpZiAoU1RNX1NBSV9JU19QTEFZQkFDSyhzYWkpKQ0K
PiArCQlzYWktPmNwdV9kYWlfZHJ2ID0gc3RtMzJfc2FpX3BsYXliYWNrX2RhaTsNCj4gKwllbHNl
DQo+ICsJCXNhaS0+Y3B1X2RhaV9kcnYgPSBzdG0zMl9zYWlfY2FwdHVyZV9kYWk7DQo+ICsJc2Fp
LT5jcHVfZGFpX2Rydi5uYW1lID0gZGV2X25hbWUoJnBkZXYtPmRldik7DQo+ICAgDQo+ICAgCXJl
dCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgc2FpLT5wZGF0YS0+aXJxLCBzdG0zMl9z
YWlfaXNyLA0KPiAgIAkJCSAgICAgICBJUlFGX1NIQVJFRCwgZGV2X25hbWUoJnBkZXYtPmRldiks
IHNhaSk7DQo+IEBAIC0xNDc3LDcgKzE0NTIsNyBAQCBzdGF0aWMgaW50IHN0bTMyX3NhaV9zdWJf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJfQ0KPiAgIA0KPiAgIAly
ZXQgPSBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJfY29tcG9uZW50KCZwZGV2LT5kZXYsICZzdG0zMl9j
b21wb25lbnQsDQo+IC0JCQkJCSAgICAgIHNhaS0+Y3B1X2RhaV9kcnYsIDEpOw0KPiArCQkJCQkg
ICAgICAmc2FpLT5jcHVfZGFpX2RydiwgMSk7DQo+ICAgCWlmIChyZXQpDQo+ICAgCQlyZXR1cm4g
cmV0Ow0KPiAgIA0KPiANCg0KSnVzdCBvbmUgY29tbWVudC4gc2FpIGlzIG1pc3NpbmcgaW4gY29t
bWl0IG1lc3NhZ2UuDQoNClJldmlld2VkLWJ5OiBPbGl2aWVyIE1veXNhbiA8b2xpdmllci5tb3lz
YW5Ac3QuY29tPg0KDQpCUnMNCm9saXZpZXINCg==
