Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292E8C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10B521738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VC3odIxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbfDEQex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:34:53 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729269AbfDEQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:34:52 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35GM1ba013638;
        Fri, 5 Apr 2019 18:34:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=cntIyWAi4fvBOSdA0ykPCoJbdRmSoT3Yb5kwoW9iNlY=;
 b=VC3odIxU36aO9Y1T1MILMKOoqPzAxewvObTQPvdHLpmPTjgBU6OZOrOzWxb7C9QsR2h/
 /aNXoY3VE9m/Gu9bT/G+UTcMK3rHI7MoFeawD7leaRmkr9ADH0Z+OaWOnSA5tXHqtXgZ
 XUP31cqhA72LWq4u4FpulXLEM9wrQ6Vxk8JXK4NmkxT8NQcRNaFu9FxrSMBUuywO0pXf
 LTrwpWciwajbxp0FGUieQNfHHhPmMiP5LDJnzMG16GSg14MpDMCXHlohIX3y2ToCgRl+
 m2RXuT5r2HC5ls4YfUUvc+avSSsBnl9r77ztPz5elHaMhFATjY4DobcEZ8W5/esrMk1O Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rmharjym9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 18:34:37 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71CF134;
        Fri,  5 Apr 2019 16:34:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 446D0501A;
        Fri,  5 Apr 2019 16:34:36 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr
 2019 18:34:35 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 5 Apr 2019 18:34:35 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] drm/stm: dw_mipi_dsi-stm: add support of an
 optional regulator
Thread-Topic: [PATCH v1 2/5] drm/stm: dw_mipi_dsi-stm: add support of an
 optional regulator
Thread-Index: AQHU6fWRxyBCZlD2VEeDzVBelHoTlqYtpXaA
Date:   Fri, 5 Apr 2019 16:34:35 +0000
Message-ID: <f66fe75c-c288-82ef-71d7-5d15b9b8e4b3@st.com>
References: <1554279389-27377-1-git-send-email-yannick.fertre@st.com>
 <1554279389-27377-3-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1554279389-27377-3-git-send-email-yannick.fertre@st.com>
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
Content-ID: <1ED47A6DDFC244478BDD886D005658FD@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMy8xOSAxMDoxNiBBTSwgWWFubmljayBGZXJ0csOpIHdyb3RlOg0KPiBBZGQgc3Vw
cG9ydCBvZiBhbiBvcHRpb25hbCByZWd1bGF0b3IgZm9yIHRoZSBwaHkgcGFydCBvZiB0aGUgRFNJ
DQo+IGNvbnRyb2xsZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyw6kgPHlh
bm5pY2suZmVydHJlQHN0LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9kd19t
aXBpX2RzaS1zdG0uYyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
c3RtL2R3X21pcGlfZHNpLXN0bS5jIGIvZHJpdmVycy9ncHUvZHJtL3N0bS9kd19taXBpX2RzaS1z
dG0uYw0KPiBpbmRleCBhNjcyYjU5Li44NDcwM2QwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vc3RtL2R3X21pcGlfZHNpLXN0bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0v
ZHdfbWlwaV9kc2ktc3RtLmMNCj4gQEAgLTksNiArOSw3IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4
L2Nsay5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gICAjaW5jbHVkZSA8bGlu
dXgvbW9kdWxlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+DQo+
ICAgI2luY2x1ZGUgPGRybS9kcm1QLmg+DQo+ICAgI2luY2x1ZGUgPGRybS9kcm1fbWlwaV9kc2ku
aD4NCj4gICAjaW5jbHVkZSA8ZHJtL2JyaWRnZS9kd19taXBpX2RzaS5oPg0KPiBAQCAtNzYsNiAr
NzcsNyBAQCBzdHJ1Y3QgZHdfbWlwaV9kc2lfc3RtIHsNCj4gICAJdTMyIGh3X3ZlcnNpb247DQo+
ICAgCWludCBsYW5lX21pbl9rYnBzOw0KPiAgIAlpbnQgbGFuZV9tYXhfa2JwczsNCj4gKwlzdHJ1
Y3QgcmVndWxhdG9yICp2ZGRfc3VwcGx5Ow0KPiAgIH07DQo+ICAgDQo+ICAgc3RhdGljIGlubGlu
ZSB2b2lkIGRzaV93cml0ZShzdHJ1Y3QgZHdfbWlwaV9kc2lfc3RtICpkc2ksIHUzMiByZWcsIHUz
MiB2YWwpDQo+IEBAIC0zMTgsMTYgKzMyMCwzMiBAQCBzdGF0aWMgaW50IGR3X21pcGlfZHNpX3N0
bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAkJcmV0dXJuIFBUUl9F
UlIoZHNpLT5iYXNlKTsNCj4gICAJfQ0KPiAgIA0KPiArCWRzaS0+dmRkX3N1cHBseSA9IGRldm1f
cmVndWxhdG9yX2dldF9vcHRpb25hbChkZXYsICJwaHktZHNpIik7DQo+ICsJaWYgKElTX0VSUihk
c2ktPnZkZF9zdXBwbHkpKSB7DQo+ICsJCXJldCA9IFBUUl9FUlIoZHNpLT52ZGRfc3VwcGx5KTsN
Cj4gKwkJaWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KPiArCQkJZGV2X2VycihkZXYsICJmYWls
ZWQgdG8gcmVxdWVzdCByZWd1bGF0b3I6ICVkXG4iLCByZXQpOw0KPiArCQlyZXR1cm4gcmV0Ow0K
PiArCX0NCj4gKw0KPiArCXJldCA9IHJlZ3VsYXRvcl9lbmFibGUoZHNpLT52ZGRfc3VwcGx5KTsN
Cj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSByZWd1
bGF0b3I6ICVkXG4iLCByZXQpOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiAgIAlk
c2ktPnBsbHJlZl9jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAicmVmIik7DQo+ICAgCWlmIChJU19F
UlIoZHNpLT5wbGxyZWZfY2xrKSkgew0KPiAgIAkJcmV0ID0gUFRSX0VSUihkc2ktPnBsbHJlZl9j
bGspOw0KPiAgIAkJZGV2X2VycihkZXYsICJVbmFibGUgdG8gZ2V0IHBsbCByZWZlcmVuY2UgY2xv
Y2s6ICVkXG4iLCByZXQpOw0KPiArCQlyZWd1bGF0b3JfZGlzYWJsZShkc2ktPnZkZF9zdXBwbHkp
Ow0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICAJfQ0KPiAgIA0KPiAgIAlyZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoZHNpLT5wbGxyZWZfY2xrKTsNCj4gICAJaWYgKHJldCkgew0KPiAgIAkJZGV2X2Vy
cihkZXYsICIlczogRmFpbGVkIHRvIGVuYWJsZSBwbGxyZWZfY2xrXG4iLCBfX2Z1bmNfXyk7DQo+
ICsJCXJlZ3VsYXRvcl9kaXNhYmxlKGRzaS0+dmRkX3N1cHBseSk7DQo+ICAgCQlyZXR1cm4gcmV0
Ow0KPiAgIAl9DQo+ICAgDQo+IEBAIC0zMzksNiArMzU3LDcgQEAgc3RhdGljIGludCBkd19taXBp
X2RzaV9zdG1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJZHNpLT5k
c2kgPSBkd19taXBpX2RzaV9wcm9iZShwZGV2LCAmZHdfbWlwaV9kc2lfc3RtX3BsYXRfZGF0YSk7
DQo+ICAgCWlmIChJU19FUlIoZHNpLT5kc2kpKSB7DQo+ICAgCQlEUk1fRVJST1IoIkZhaWxlZCB0
byBpbml0aWFsaXplIG1pcGkgZHNpIGhvc3RcbiIpOw0KPiArCQlyZWd1bGF0b3JfZGlzYWJsZShk
c2ktPnZkZF9zdXBwbHkpOw0KPiAgIAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRzaS0+cGxscmVm
X2Nsayk7DQo+ICAgCQlyZXR1cm4gUFRSX0VSUihkc2ktPmRzaSk7DQo+ICAgCX0NCj4gQEAgLTM1
MSw2ICszNzAsNyBAQCBzdGF0aWMgaW50IGR3X21pcGlfZHNpX3N0bV9yZW1vdmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJc3RydWN0IGR3X21pcGlfZHNpX3N0bSAqZHNpID0g
cGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAgDQo+ICAgCWNsa19kaXNhYmxlX3VucHJl
cGFyZShkc2ktPnBsbHJlZl9jbGspOw0KPiArCXJlZ3VsYXRvcl9kaXNhYmxlKGRzaS0+dmRkX3N1
cHBseSk7DQoNCkRlYXIgWWFubmljaywNCg0KQWNrZWQtYnk6IFBoaWxpcHBlIENvcm51IDxwaGls
aXBwZS5jb3JudUBzdC5jb20+DQoNClBoaWxpcHBlDQoNCj4gICAJZHdfbWlwaV9kc2lfcmVtb3Zl
KGRzaS0+ZHNpKTsNCj4gICANCj4gICAJcmV0dXJuIDA7DQo+IA==
