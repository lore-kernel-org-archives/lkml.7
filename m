Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE8C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106A22146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Qf2bQgxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfDEQdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:33:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27898 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729269AbfDEQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:33:43 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35GLrJa013306;
        Fri, 5 Apr 2019 18:33:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=kdKM/BY01rOBGqzUJaWGf36+SCyjloxTlF+2p3ZHCjI=;
 b=Qf2bQgxjBeJ7xdlsk8urkn1aslP9cLMyddrPyNHpnUIoQbPJnyUh97rDnvTOSZYWHl8I
 ae2M6+j/oYNFA1QSgoBgZmsP4sWy2bk9td9npXkj5WNkmdaWq+5LZ2YeHpv4m8tiNowj
 qDSTjhqLdYB/reAlGxIsEmAP41c8prUB2Oi7qxdXYPg2JEv1M+MzC9ojuCm4SzVRt4RW
 WMXGMEXBss8mrH/CrBynnp6WCSp+S4+dFpDaigzbIdiyt4uPQDSIJYBpeHzQsoFNYxy8
 BVTb0JsaEW/AExrp9ZFGwTiIzPmni5kX2CwUUUT0VN55d69cpbtc6wdjNsUTMmw+TKT0 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rmharjyeb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 18:33:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1FF3B34;
        Fri,  5 Apr 2019 16:33:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA8CA5012;
        Fri,  5 Apr 2019 16:33:29 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr
 2019 18:33:29 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 5 Apr 2019 18:33:29 +0200
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
Subject: Re: [PATCH v1 1/5] dt-bindings: display: stm32: add supply property
 to DSI controller
Thread-Topic: [PATCH v1 1/5] dt-bindings: display: stm32: add supply property
 to DSI controller
Thread-Index: AQHU6fWRJBRHNKgROEKLecE3w8kXoqYtpSeA
Date:   Fri, 5 Apr 2019 16:33:29 +0000
Message-ID: <0adc22b0-10aa-9c9b-d998-f0705bfb15fd@st.com>
References: <1554279389-27377-1-git-send-email-yannick.fertre@st.com>
 <1554279389-27377-2-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1554279389-27377-2-git-send-email-yannick.fertre@st.com>
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
Content-ID: <6F1FC8ACA86F7A4D9570706DAA8C6F4F@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8zLzE5IDEwOjE2IEFNLCBZYW5uaWNrIEZlcnRyw6kgd3JvdGU6DQo+IFRoaXMgcGF0Y2gg
YWRkcyBkb2N1bWVudGF0aW9uIG9mIGEgbmV3IHByb3BlcnR5IHBoeS1kc2ktc3VwcGx5IHRvIHRo
ZQ0KPiBTVE0zMiBEU0kgY29udHJvbGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbm5pY2sg
RmVydHLDqSA8eWFubmljay5mZXJ0cmVAc3QuY29tPg0KPiAtLS0NCj4gICBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9zdCxzdG0zMi1sdGRjLnR4dCB8IDMgKysrDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3N0LHN0bTMyLWx0ZGMudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvc3Qsc3RtMzItbHRk
Yy50eHQNCj4gaW5kZXggM2ViMWI0OC4uNjBjNTRkYSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvc3Qsc3RtMzItbHRkYy50eHQNCj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvc3Qsc3RtMzItbHRk
Yy50eHQNCj4gQEAgLTQwLDYgKzQwLDggQEAgTWFuZGF0b3J5IG5vZGVzIHNwZWNpZmljIHRvIFNU
TTMyIERTSToNCj4gICAtIHBhbmVsIG9yIGJyaWRnZSBub2RlOiBBIG5vZGUgY29udGFpbmluZyB0
aGUgcGFuZWwgb3IgYnJpZGdlIGRlc2NyaXB0aW9uIGFzDQo+ICAgICBkb2N1bWVudGVkIGluIFs2
XS4NCj4gICAgIC0gcG9ydDogcGFuZWwgb3IgYnJpZGdlIHBvcnQgbm9kZSwgY29ubmVjdGVkIHRv
IHRoZSBEU0kgb3V0cHV0IHBvcnQgKHBvcnRAMSkuDQo+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0K
PiArLSBwaHktZHNpLXN1cHBseTogcGhhbmRsZSBvZiB0aGUgcmVndWxhdG9yIHRoYXQgcHJvdmlk
ZXMgdGhlIHN1cHBseSB2b2x0YWdlLg0KPiAgIA0KPiAgIE5vdGU6IFlvdSBjYW4gZmluZCBtb3Jl
IGRvY3VtZW50YXRpb24gaW4gdGhlIGZvbGxvd2luZyByZWZlcmVuY2VzDQo+ICAgWzFdIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9jbG9jay1iaW5kaW5ncy50eHQNCj4g
QEAgLTEwMSw2ICsxMDMsNyBAQCBFeGFtcGxlIDI6IERTSSBwYW5lbA0KPiAgIAkJCWNsb2NrLW5h
bWVzID0gInBjbGsiLCAicmVmIjsNCj4gICAJCQlyZXNldHMgPSA8JnJjYyBTVE0zMkY0X0FQQjJf
UkVTRVQoRFNJKT47DQo+ICAgCQkJcmVzZXQtbmFtZXMgPSAiYXBiIjsNCj4gKwkJCXBoeS1kc2kt
c3VwcGx5ID0gPCZyZWcxOD47DQoNCkRlYXIgWWFubmljaywNClRoYW5rIHlvdSBmb3IgeW91ciBw
YXRjaCwNCg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5j
b20+DQoNClBoaWxpcHBlIDopDQoNCg0KPiAgIA0KPiAgIAkJCXBvcnRzIHsNCj4gICAJCQkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQo+IA==
