Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5437BC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B01E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="E6iQyyyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfEMJOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:14:53 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38758 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727576AbfEMJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:28 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4D9Crjs028859;
        Mon, 13 May 2019 11:13:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=IWhtElWmdpgKIU8VGl5G2wFIivmrFZHb3+vkvkOzBGA=;
 b=E6iQyyyNDLealIRBDwwE1PJRXet68DzmjV/MzkkvfL7fEnyvVlT1Qo6UAOQyNfFgbywo
 wh0HHkKmexaCwPl0x4409KMWbQbXOQhe8G62Bp7kPUrQb77X1/YnJgavAMad4vxRWPOD
 Rf5AORgARCAky3RE/pXkqL4NFa42RPpYl8DnzkEhZAv0s99NHpDC555Sy5rvZxDoXFFm
 +KDcCuHxPU+o4az8B43kmydkb3nPK51goWLVvBD3VfAtR0JV2iN+xJSPYSewY8dCMOpk
 5uhbUZORK7+hNSoOPM72zj1ksuNuiDrg9HlduGf59TP5ol/1kSn5r6e3jNqVJLnRZrZ2 mA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sdn9fhywd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 May 2019 11:13:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C44BF31;
        Mon, 13 May 2019 09:13:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7DB691651;
        Mon, 13 May 2019 09:13:12 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 13 May
 2019 11:13:12 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Mon, 13 May 2019 11:13:12 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH v2 0/6] hwspinlock: allow sharing of hwspinlocks
Thread-Topic: [PATCH v2 0/6] hwspinlock: allow sharing of hwspinlocks
Thread-Index: AQHU+0e1QzNWA48760KM6GhFSHX8FaZowBIA
Date:   Mon, 13 May 2019 09:13:11 +0000
Message-ID: <25aae4ca-0568-ccaf-0c47-4f5f4e2e8599@st.com>
References: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D55BFC742E8B3D4FAB756D29EDD9858A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KDQpJIEdvdCBSb2IncyBSZXZpZXdlZC1ieS4gQW55IGZ1cnRoZXIgY29tbWVudHM/DQoN
Cg0KRmFiaWVuDQoNCg0KT24gMjUvMDQvMjAxOSAxMToxNyBBTSwgRmFiaWVuIERlc3Nlbm5lIHdy
b3RlOg0KPiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBhbGxvdyB0d28gZGlm
ZmVyZW50IGRldmljZXMgdG8gdXNlDQo+IGEgY29tbW9uIGh3c3BpbmxvY2suIFRoaXMgcGF0Y2gg
c2V0IHByb3Bvc2VzIHRvIGhhdmUsIGFzIGFuIG9wdGlvbiwgc29tZQ0KPiBod3NwaW5sb2NrcyBz
aGFyZWQgYmV0d2VlbiBzZXZlcmFsIHVzZXJzLg0KPg0KPiBCZWxvdyBpcyBhbiBleGFtcGxlIHRo
YXQgZXhwbGFpbiB0aGUgbmVlZCBmb3IgdGhpczoNCj4gCWV4dGk6IGludGVycnVwdC1jb250cm9s
bGVyQDUwMDBkMDAwIHsNCj4gCQljb21wYXRpYmxlID0gInN0LHN0bTMybXAxLWV4dGkiLCAic3lz
Y29uIjsNCj4gCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gCQkjaW50ZXJydXB0LWNlbGxzID0g
PDI+Ow0KPiAJCXJlZyA9IDwweDUwMDBkMDAwIDB4NDAwPjsNCj4gCQlod2xvY2tzID0gPCZoc2Vt
IDE+Ow0KPiAJfTsNCj4gVGhlIHR3byBkcml2ZXJzIChzdG0zMm1wMS1leHRpIGFuZCBzeXNjb24p
IHJlZmVyIHRvIHRoZSBzYW1lIGh3bG9jay4NCj4gV2l0aCB0aGUgY3VycmVudCBod3NwaW5sb2Nr
IGltcGxlbWVudGF0aW9uLCBvbmx5IHRoZSBmaXJzdCBkcml2ZXIgc3VjY2VlZHMNCj4gaW4gcmVx
dWVzdGluZyAoaHdzcGluX2xvY2tfcmVxdWVzdF9zcGVjaWZpYykgdGhlIGh3bG9jay4gVGhlIHNl
Y29uZCByZXF1ZXN0DQo+IGZhaWxzLg0KPg0KPg0KPiBUaGUgcHJvcG9zZWQgYXBwcm9hY2ggZG9l
cyBub3QgbW9kaWZ5IHRoZSBBUEksIGJ1dCBleHRlbmRzIHRoZSBEVCAnaHdsb2NrcycNCj4gcHJv
cGVydHkgd2l0aCBhIHNlY29uZCBvcHRpb25hbCBwYXJhbWV0ZXIgKHRoZSBmaXJzdCBvbmUgaWRl
bnRpZmllcyBhbg0KPiBod2xvY2spIHRoYXQgc3BlY2lmaWVzIHdoZXRoZXIgYW4gaHdsb2NrIGlz
IHJlcXVlc3RlZCBmb3IgZXhjbHVzaXZlIHVzYWdlDQo+IChjdXJyZW50IGJlaGF2aW9yKSBvciBj
YW4gYmUgc2hhcmVkIGJldHdlZW4gc2V2ZXJhbCB1c2Vycy4NCj4gRXhhbXBsZXM6DQo+IAlod2xv
Y2tzID0gPCZoc2VtIDg+OwlSZWYgdG8gaHdsb2NrICM4IGZvciBleGNsdXNpdmUgdXNhZ2UNCj4g
CWh3bG9ja3MgPSA8JmhzZW0gOCAwPjsJUmVmIHRvIGh3bG9jayAjOCBmb3IgZXhjbHVzaXZlICgw
KSB1c2FnZQ0KPiAJaHdsb2NrcyA9IDwmaHNlbSA4IDE+OwlSZWYgdG8gaHdsb2NrICM4IGZvciBz
aGFyZWQgKDEpIHVzYWdlDQo+DQo+IEFzIGEgY29uc3RyYWludCwgdGhlICNod2xvY2stY2VsbHMg
dmFsdWUgbXVzdCBiZSAxIG9yIDIuDQo+IEluIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uLCB0
aGlzIGNhbiBoYXZlIHRoZW9yaWNhbGx5IGFueSB2YWx1ZSBidXQ6DQo+IC0gYWxsIG9mIHRoZSBl
eGlzaXRpbmcgZHJpdmVycyB1c2UgdGhlIHNhbWUgdmFsdWUgOiAxLg0KPiAtIHRoZSBmcmFtZXdv
cmsgc3VwcG9ydHMgb25seSBvbmUgdmFsdWUgOiAxIChzZWUgaW1wbGVtZW50YXRpb24gb2YNCj4g
ICAgb2ZfaHdzcGluX2xvY2tfc2ltcGxlX3hsYXRlKCkpDQo+IEhlbmNlLCBpdCBzaGFsbCBub3Qg
YmUgYSBwcm9ibGVtIHRvIHJlc3RyaWN0IHRoaXMgdmFsdWUgdG8gMSBvciAyIHNpbmNlDQo+IGl0
IHdvbid0IGJyZWFrIGFueSBkcml2ZXIuDQo+DQo+IENoYW5nZXMgc2luY2UgdjE6DQo+ICogUmVt
b3ZlZCB1c2VsZXNzICdzdGF0dXMgPSAib2theSInIGZyb20gc3RtMzJtcDE1N2MuZHRzaQ0KPg0K
PiBGYWJpZW4gRGVzc2VubmUgKDYpOg0KPiAgICBkdC1iaW5kaW5nczogaHdsb2NrOiBhZGQgc3Vw
cG9ydCBvZiBzaGFyZWQgbG9ja3MNCj4gICAgaHdzcGlubG9jazogYWxsb3cgc2hhcmluZyBvZiBo
d3NwaW5sb2Nrcw0KPiAgICBkdC1iaW5kaW5nczogaHdsb2NrOiB1cGRhdGUgU1RNMzIgI2h3bG9j
ay1jZWxscyB2YWx1ZQ0KPiAgICBBUk06IGR0czogc3RtMzI6IEFkZCBod3NwaW5sb2NrIG5vZGUg
Zm9yIHN0bTMybXAxNTcgU29DDQo+ICAgIEFSTTogZHRzOiBzdG0zMjogQWRkIGh3bG9jayBmb3Ig
aXJxY2hpcCBvbiBzdG0zMm1wMTU3DQo+ICAgIEFSTTogZHRzOiBzdG0zMjogaHdsb2NrcyBmb3Ig
R1BJTyBmb3Igc3RtMzJtcDE1Nw0KPg0KPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bG9j
ay9od2xvY2sudHh0ICAgICAgICAgIHwgMjcgKysrKystLQ0KPiAgIC4uLi9iaW5kaW5ncy9od2xv
Y2svc3Qsc3RtMzItaHdzcGlubG9jay50eHQgICAgICAgIHwgIDYgKy0NCj4gICBEb2N1bWVudGF0
aW9uL2h3c3BpbmxvY2sudHh0ICAgICAgICAgICAgICAgICAgICAgICB8IDEwICsrLQ0KPiAgIGFy
Y2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTctcGluY3RybC5kdHNpICAgICAgICAgIHwgIDIgKw0K
PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kgICAgICAgICAgICAgICAgIHwg
IDkgKysrDQo+ICAgZHJpdmVycy9od3NwaW5sb2NrL2h3c3BpbmxvY2tfY29yZS5jICAgICAgICAg
ICAgICAgfCA4MiArKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAgZHJpdmVycy9od3NwaW5sb2Nr
L2h3c3BpbmxvY2tfaW50ZXJuYWwuaCAgICAgICAgICAgfCAgMiArDQo+ICAgNyBmaWxlcyBjaGFu
Z2VkLCAxMDcgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQo+
