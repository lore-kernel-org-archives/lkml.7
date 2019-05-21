Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A2C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DEF21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="OT+b5hcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfEUNnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:43:01 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:44476 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728470AbfEUNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:43:01 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LDZeuu018642;
        Tue, 21 May 2019 09:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=pp6tPZXyuLLxq41a6rBWLh75d04HggU+65CWIRK9yUQ=;
 b=OT+b5hcID7XbtGgl2Qu/tbZ5vz1ny5Hfvjv+4j0BuQucSCoBa7cTYQtEny8GGjZPqpyk
 80Vv1CCvwv94XNZ9lKK0jOK7abc+EJCv1/285tAJ3yGNUr2GRIN7BDav0uB2TvwZymMW
 p/ltmidcihb4YW+IjdmOPtMB9pDueo3oCBmeUxHcpvJopwaGDTHXuRwj50P9GJzF6ao9
 Mk6hY+vmYQXZOJPdOeZ8DEkcAo86RKMF5B4lcy1qBh5sQbO3HGx8qjnFvD7/smvgh7cE
 mOSMIJz7eTOF71m/roMZP5m/3dHw1Rufq3+CZxLJgjhvATwXwU1YzyWySKxp4uAX/Ym9 gg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2sjeqnr559-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 May 2019 09:42:59 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LDc9i2177251;
        Tue, 21 May 2019 09:42:58 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2sjc9qkyxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 09:42:57 -0400
X-LoopCount0: from 10.166.132.128
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1408349857"
From:   <Mario.Limonciello@dell.com>
To:     <jettrink@chromium.org>, <mathewk@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <acelan.kao@canonical.com>,
        <andy@infradead.org>, <dvhart@infradead.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v2] platform/x86: intel-vbtn: Report switch events when
 event wakes device
Thread-Topic: [PATCH v2] platform/x86: intel-vbtn: Report switch events when
 event wakes device
Thread-Index: AQHVD103f4iXW1gb802WUHY84GHNT6Z16a+A//+tbXA=
Date:   Tue, 21 May 2019 13:42:00 +0000
Message-ID: <a7a23cbea93d46b48f7c9bd4e4cd4314@AUSX13MPC105.AMER.DELL.COM>
References: <20190520224124.153005-1-mathewk@chromium.org>
 <CAK+PMK47_OE-BgOYD_TD0kwxD4RG+nS9Wstg4ydUy7yV9nVmHQ@mail.gmail.com>
In-Reply-To: <CAK+PMK47_OE-BgOYD_TD0kwxD4RG+nS9Wstg4ydUy7yV9nVmHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210087
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZXR0IFJpbmsgPGpldHRyaW5r
QGNocm9taXVtLm9yZz4NCj4gU2VudDogVHVlc2RheSwgTWF5IDIxLCAyMDE5IDg6MzcgQU0NCj4g
VG86IE1hdGhldyBLaW5nDQo+IENjOiBsaW51eC1rZXJuZWw7IEFjZUxhbiBLYW87IEFuZHkgU2hl
dmNoZW5rbzsgRGFycmVuIEhhcnQ7IHBsYXRmb3JtLWRyaXZlci0NCj4geDg2QHZnZXIua2VybmVs
Lm9yZzsgTGltb25jaWVsbG8sIE1hcmlvDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHBsYXRm
b3JtL3g4NjogaW50ZWwtdmJ0bjogUmVwb3J0IHN3aXRjaCBldmVudHMgd2hlbiBldmVudA0KPiB3
YWtlcyBkZXZpY2UNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBPbiBNb24sIE1h
eSAyMCwgMjAxOSBhdCA0OjQxIFBNIE1hdGhldyBLaW5nIDxtYXRoZXdrQGNocm9taXVtLm9yZz4N
Cj4gd3JvdGU6DQo+ID4NCj4gPiBXaGVuIGEgc3dpdGNoIGV2ZW50LCBzdWNoIGFzIHRhYmxldCBt
b2RlL2xhcHRvcCBtb2RlIG9yIGRvY2tlZC91bmRvY2tlZCwNCj4gPiB3YWtlcyBhIGRldmljZSBt
YWtlIHN1cmUgdGhhdCB0aGUgdmFsdWUgb2YgdGhlIHN3aWNoIGlzIHJlcG9ydGVkLg0KPiA+IFdp
dGhvdXQgd2hlbiBhIGRldmljZSBpcyBwdXQgaW4gdGFibGV0IG1vZGUgZnJvbSBsYXB0b3AgbW9k
ZSB3aGVuIGl0IGlzDQo+ID4gc3VzcGVuZGVkIG9yIHZpY2UgdmVyc2EgdGhlIGRldmljZSB3aWxs
IHdha2UgdXAgYnV0IG1vZGUgd2lsbCBiZQ0KPiA+IGluY29ycmVjdC4NCj4gPg0KPiA+IFRlc3Rl
ZCBieSBzdXNwZW5kaW5nIGEgZGV2aWNlIGluIGxhcHRvcCBtb2RlIGFuZCBwdXR0aW5nIGl0IGlu
IHRhYmxldA0KPiA+IG1vZGUsIHRoZSBkZXZpY2UgcmVzdW1lcyBhbmQgaXMgaW4gdGFibGV0IG1v
ZGUuIFdoZW4gc3VzcGVuZGluZyB0aGUNCj4gPiBkZXZpY2UgaW4gdGFibGV0IG1vZGUgYW5kIHB1
dHRpbmcgaXQgaW4gbGFwdG9wIG1vZGUgdGhlIGRldmljZSByZXN1bWVzDQo+ID4gYW5kIGlzIGlu
IGxhcHRvcCBtb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0aGV3IEtpbmcgPG1hdGhl
d2tAY2hyb21pdW0ub3JnPg0KPiA+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAg
IC0gQWRkZWQgY29tbWVudCBleHBsYWluaW5nIHdoeSBzd2l0Y2ggZXZlbnRzIGFyZSByZXBvcnRl
ZA0KPiA+ICAgLSBGb3JtYXQgc28gdGhhdCBjaGVja3BhdGNoIGlzIGhhcHB5DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsLXZidG4uYyB8IDE2ICsrKysrKysrKysrKysr
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwtdmJ0bi5j
IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwtdmJ0bi5jDQo+ID4gaW5kZXggMDZjZDdlODE4
ZWQ1Li5hMGQwY2VjZmY1NWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYv
aW50ZWwtdmJ0bi5jDQo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwtdmJ0bi5j
DQo+ID4gQEAgLTc2LDEyICs3NiwyNCBAQCBzdGF0aWMgdm9pZCBub3RpZnlfaGFuZGxlcihhY3Bp
X2hhbmRsZSBoYW5kbGUsIHUzMg0KPiBldmVudCwgdm9pZCAqY29udGV4dCkNCj4gPiAgICAgICAg
IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldmljZSA9IGNvbnRleHQ7DQo+ID4gICAgICAgICBz
dHJ1Y3QgaW50ZWxfdmJ0bl9wcml2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKCZkZXZpY2UtPmRl
dik7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgdmFsID0gIShldmVudCAmIDEpOyAvKiBFdmVu
PXByZXNzLCBPZGQ9cmVsZWFzZSAqLw0KPiA+IC0gICAgICAgY29uc3Qgc3RydWN0IGtleV9lbnRy
eSAqa2VfcmVsOw0KPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IGtleV9lbnRyeSAqa2UsICprZV9y
ZWw7DQo+ID4gICAgICAgICBib29sIGF1dG9yZWxlYXNlOw0KPiA+DQo+ID4gICAgICAgICBpZiAo
cHJpdi0+d2FrZXVwX21vZGUpIHsNCj4gPiAtICAgICAgICAgICAgICAgaWYgKHNwYXJzZV9rZXlt
YXBfZW50cnlfZnJvbV9zY2FuY29kZShwcml2LT5pbnB1dF9kZXYsIGV2ZW50KSkgew0KPiA+ICsg
ICAgICAgICAgICAgICBrZSA9IHNwYXJzZV9rZXltYXBfZW50cnlfZnJvbV9zY2FuY29kZShwcml2
LT5pbnB1dF9kZXYsIGV2ZW50KTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGtlKSB7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgcG1fd2FrZXVwX2hhcmRfZXZlbnQoJmRldmljZS0+ZGV2
KTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgKiBTd2l0Y2ggZXZlbnRzIGxpa2UgdGFibGV0IG1vZGUgd2lsbCB3YWtl
IHRoZSBkZXZpY2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBhbmQgcmVwb3J0IHRo
ZSBuZXcgc3dpdGNoIHBvc2l0aW9uIHRvIHRoZSBpbnB1dA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAqIHN1YnN5c3RlbS4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4g
VGhhbmtzIGZvciBhZGRpbmcgdGhlIGNvbW1lbnQ7IFRoaXMgbG9va3MgZ29vZCB0byBtZS4NCj4g
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGtlLT50eXBlID09IEtFX1NXKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3BhcnNlX2tleW1hcF9yZXBvcnRfZXZl
bnQocHJpdi0+aW5wdXRfZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZXZlbnQsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWwsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwKTsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICAgICAgICAg
IH0NCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXRfdW5rbm93bjsNCj4gPiAtLQ0KPiA+IDIu
MjEuMC4xMDIwLmdmMjgyMGNmMDFhLWdvb2cNCj4gPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEpldHQg
UmluayA8amV0dHJpbmtAY2hyb21pdW0ub3JnPg0KDQpSZXZpZXdlZC1ieTogTWFyaW8gTGltb25j
aWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGRlbGwuY29tPg0K
