Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0129AC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70320879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AzI25pdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfEWGkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:40:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25924 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbfEWGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:40:10 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4N6W1if012749;
        Thu, 23 May 2019 08:39:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=ho0xlKX03HhiHuuMo5Fyh6gxLhNZqkg4on/Piy7I8/k=;
 b=AzI25pdKMW2AjCHGniSJK4KsArt6w16MeGtqNv6ySWJN2y0Ga0RgV0gy8isVaQha347W
 n4ULpsYM+oEedpcpSY4Rl+bGtGcT3yLYp66/J7BZQjPur1ovG2hA2mgDkhrbTO/P3doy
 mt0kdlnD4Y1KZxOW0q+eLLlJCRQcMCDPF3XRG5vc07okdJAsEsGvXXgfLmraX2JjB1Fp
 JD8q79MZieR23MMkiXznPys1uVASw4p2yhHODeAqpZGAuQ5JWdrVERKhQ8U8eb/XoUU1
 Q2VTIVzkW1W718PwZNueBENTv//afmBYzun3loTA5DIQyrpACZB/pWokAWKgGAbiq2n3 gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sj7tucwk2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 23 May 2019 08:39:57 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB7B034;
        Thu, 23 May 2019 06:39:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B933614C9;
        Thu, 23 May 2019 06:39:56 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 May
 2019 08:39:56 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 23 May 2019 08:39:56 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mailbox: stm32_ipcc: add spinlock to fix channels
 concurrent access
Thread-Topic: [PATCH] mailbox: stm32_ipcc: add spinlock to fix channels
 concurrent access
Thread-Index: AQHVEHf3zLD2dpF4NEGX8BuhDUErpqZ4IjCA
Date:   Thu, 23 May 2019 06:39:56 +0000
Message-ID: <7a0352eb-41ea-4d81-4a22-ba9df2c72148@st.com>
References: <1558513535-16736-1-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1558513535-16736-1-git-send-email-arnaud.pouliquen@st.com>
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
Content-ID: <12B83101779F314AADBBE24BC168E7AC@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuYXVkLA0KDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KDQoNCk9uIDIyLzA1LzIw
MTkgMTA6MjUgQU0sIEFybmF1ZCBQb3VsaXF1ZW4gd3JvdGU6DQo+IEFkZCBzcGlubG9jayBwcm90
ZWN0aW9uIG9uIElQQ0MgcmVnaXN0ZXIgdXBkYXRlIHRvIGF2b2lkIHJhY2UgY29uZGl0aW9uLg0K
PiBXaXRob3V0IHRoaXMgZml4LCBzdG0zMl9pcGNjX3NldF9iaXRzIGFuZCBzdG0zMl9pcGNjX2Ns
cl9iaXRzIGNhbiBiZQ0KPiBjYWxsZWQgaW4gcGFyYWxsZWwgZm9yIGRpZmZlcmVudCBjaGFubmVs
cy4gVGhpcyByZXN1bHRzIGluIHJlZ2lzdGVyDQo+IGNvcnJ1cHRpb25zLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBBcm5hdWQgUG91bGlxdWVuIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IEZhYmllbiBEZXNzZW5uZSA8ZmFiaWVuLmRlc3Nlbm5lQHN0LmNvbT4NCg0KDQo+
IC0tLQ0KPiAgIGRyaXZlcnMvbWFpbGJveC9zdG0zMi1pcGNjLmMgfCAzNyArKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlv
bnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94
L3N0bTMyLWlwY2MuYyBiL2RyaXZlcnMvbWFpbGJveC9zdG0zMi1pcGNjLmMNCj4gaW5kZXggZjkx
ZGZiMTMyN2M3Li41YzJkMWUxZjk4OGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9z
dG0zMi1pcGNjLmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L3N0bTMyLWlwY2MuYw0KPiBAQCAt
NTAsNiArNTAsNyBAQCBzdHJ1Y3Qgc3RtMzJfaXBjYyB7DQo+ICAgCXZvaWQgX19pb21lbSAqcmVn
X2Jhc2U7DQo+ICAgCXZvaWQgX19pb21lbSAqcmVnX3Byb2M7DQo+ICAgCXN0cnVjdCBjbGsgKmNs
azsNCj4gKwlzcGlubG9ja190IGxvY2s7IC8qIHByb3RlY3QgYWNjZXNzIHRvIElQQ0MgcmVnaXN0
ZXJzICovDQo+ICAgCWludCBpcnFzW0lQQ0NfSVJRX05VTV07DQo+ICAgCWludCB3a3A7DQo+ICAg
CXUzMiBwcm9jX2lkOw0KPiBAQCAtNTgsMTQgKzU5LDI0IEBAIHN0cnVjdCBzdG0zMl9pcGNjIHsN
Cj4gICAJdTMyIHhtcjsNCj4gICB9Ow0KPiAgIA0KPiAtc3RhdGljIGlubGluZSB2b2lkIHN0bTMy
X2lwY2Nfc2V0X2JpdHModm9pZCBfX2lvbWVtICpyZWcsIHUzMiBtYXNrKQ0KPiArc3RhdGljIGlu
bGluZSB2b2lkIHN0bTMyX2lwY2Nfc2V0X2JpdHMoc3BpbmxvY2tfdCAqbG9jaywgdm9pZCBfX2lv
bWVtICpyZWcsDQo+ICsJCQkJICAgICAgIHUzMiBtYXNrKQ0KPiAgIHsNCj4gKwl1bnNpZ25lZCBs
b25nIGZsYWdzOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUobG9jaywgZmxhZ3MpOw0KPiAg
IAl3cml0ZWxfcmVsYXhlZChyZWFkbF9yZWxheGVkKHJlZykgfCBtYXNrLCByZWcpOw0KPiArCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUobG9jaywgZmxhZ3MpOw0KPiAgIH0NCj4gICANCj4gLXN0YXRp
YyBpbmxpbmUgdm9pZCBzdG0zMl9pcGNjX2Nscl9iaXRzKHZvaWQgX19pb21lbSAqcmVnLCB1MzIg
bWFzaykNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzdG0zMl9pcGNjX2Nscl9iaXRzKHNwaW5sb2Nr
X3QgKmxvY2ssIHZvaWQgX19pb21lbSAqcmVnLA0KPiArCQkJCSAgICAgICB1MzIgbWFzaykNCj4g
ICB7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKw0KPiArCXNwaW5fbG9ja19pcnFzYXZl
KGxvY2ssIGZsYWdzKTsNCj4gICAJd3JpdGVsX3JlbGF4ZWQocmVhZGxfcmVsYXhlZChyZWcpICYg
fm1hc2ssIHJlZyk7DQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZShsb2NrLCBmbGFncyk7DQo+
ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpcnFyZXR1cm5fdCBzdG0zMl9pcGNjX3J4X2lycShpbnQg
aXJxLCB2b2lkICpkYXRhKQ0KPiBAQCAtOTIsNyArMTAzLDcgQEAgc3RhdGljIGlycXJldHVybl90
IHN0bTMyX2lwY2NfcnhfaXJxKGludCBpcnEsIHZvaWQgKmRhdGEpDQo+ICAgDQo+ICAgCQltYm94
X2NoYW5fcmVjZWl2ZWRfZGF0YSgmaXBjYy0+Y29udHJvbGxlci5jaGFuc1tjaGFuXSwgTlVMTCk7
DQo+ICAgDQo+IC0JCXN0bTMyX2lwY2Nfc2V0X2JpdHMoaXBjYy0+cmVnX3Byb2MgKyBJUENDX1hT
Q1IsDQo+ICsJCXN0bTMyX2lwY2Nfc2V0X2JpdHMoJmlwY2MtPmxvY2ssIGlwY2MtPnJlZ19wcm9j
ICsgSVBDQ19YU0NSLA0KPiAgIAkJCQkgICAgUlhfQklUX0NIQU4oY2hhbikpOw0KPiAgIA0KPiAg
IAkJcmV0ID0gSVJRX0hBTkRMRUQ7DQo+IEBAIC0xMjEsNyArMTMyLDcgQEAgc3RhdGljIGlycXJl
dHVybl90IHN0bTMyX2lwY2NfdHhfaXJxKGludCBpcnEsIHZvaWQgKmRhdGEpDQo+ICAgCQlkZXZf
ZGJnKGRldiwgIiVzOiBjaGFuOiVkIHR4XG4iLCBfX2Z1bmNfXywgY2hhbik7DQo+ICAgDQo+ICAg
CQkvKiBtYXNrICd0eCBjaGFubmVsIGZyZWUnIGludGVycnVwdCAqLw0KPiAtCQlzdG0zMl9pcGNj
X3NldF9iaXRzKGlwY2MtPnJlZ19wcm9jICsgSVBDQ19YTVIsDQo+ICsJCXN0bTMyX2lwY2Nfc2V0
X2JpdHMoJmlwY2MtPmxvY2ssIGlwY2MtPnJlZ19wcm9jICsgSVBDQ19YTVIsDQo+ICAgCQkJCSAg
ICBUWF9CSVRfQ0hBTihjaGFuKSk7DQo+ICAgDQo+ICAgCQltYm94X2NoYW5fdHhkb25lKCZpcGNj
LT5jb250cm9sbGVyLmNoYW5zW2NoYW5dLCAwKTsNCj4gQEAgLTE0MSwxMCArMTUyLDEyIEBAIHN0
YXRpYyBpbnQgc3RtMzJfaXBjY19zZW5kX2RhdGEoc3RydWN0IG1ib3hfY2hhbiAqbGluaywgdm9p
ZCAqZGF0YSkNCj4gICAJZGV2X2RiZyhpcGNjLT5jb250cm9sbGVyLmRldiwgIiVzOiBjaGFuOiVk
XG4iLCBfX2Z1bmNfXywgY2hhbik7DQo+ICAgDQo+ICAgCS8qIHNldCBjaGFubmVsIG4gb2NjdXBp
ZWQgKi8NCj4gLQlzdG0zMl9pcGNjX3NldF9iaXRzKGlwY2MtPnJlZ19wcm9jICsgSVBDQ19YU0NS
LCBUWF9CSVRfQ0hBTihjaGFuKSk7DQo+ICsJc3RtMzJfaXBjY19zZXRfYml0cygmaXBjYy0+bG9j
aywgaXBjYy0+cmVnX3Byb2MgKyBJUENDX1hTQ1IsDQo+ICsJCQkgICAgVFhfQklUX0NIQU4oY2hh
bikpOw0KPiAgIA0KPiAgIAkvKiB1bm1hc2sgJ3R4IGNoYW5uZWwgZnJlZScgaW50ZXJydXB0ICov
DQo+IC0Jc3RtMzJfaXBjY19jbHJfYml0cyhpcGNjLT5yZWdfcHJvYyArIElQQ0NfWE1SLCBUWF9C
SVRfQ0hBTihjaGFuKSk7DQo+ICsJc3RtMzJfaXBjY19jbHJfYml0cygmaXBjYy0+bG9jaywgaXBj
Yy0+cmVnX3Byb2MgKyBJUENDX1hNUiwNCj4gKwkJCSAgICBUWF9CSVRfQ0hBTihjaGFuKSk7DQo+
ICAgDQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gQEAgLTE2Myw3ICsxNzYsOCBAQCBzdGF0aWMg
aW50IHN0bTMyX2lwY2Nfc3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpsaW5rKQ0KPiAgIAl9DQo+
ICAgDQo+ICAgCS8qIHVubWFzayAncnggY2hhbm5lbCBvY2N1cGllZCcgaW50ZXJydXB0ICovDQo+
IC0Jc3RtMzJfaXBjY19jbHJfYml0cyhpcGNjLT5yZWdfcHJvYyArIElQQ0NfWE1SLCBSWF9CSVRf
Q0hBTihjaGFuKSk7DQo+ICsJc3RtMzJfaXBjY19jbHJfYml0cygmaXBjYy0+bG9jaywgaXBjYy0+
cmVnX3Byb2MgKyBJUENDX1hNUiwNCj4gKwkJCSAgICBSWF9CSVRfQ0hBTihjaGFuKSk7DQo+ICAg
DQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gQEAgLTE3NSw3ICsxODksNyBAQCBzdGF0aWMgdm9p
ZCBzdG0zMl9pcGNjX3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4gKmxpbmspDQo+ICAgCQkJCQkg
ICAgICAgY29udHJvbGxlcik7DQo+ICAgDQo+ICAgCS8qIG1hc2sgcngvdHggaW50ZXJydXB0ICov
DQo+IC0Jc3RtMzJfaXBjY19zZXRfYml0cyhpcGNjLT5yZWdfcHJvYyArIElQQ0NfWE1SLA0KPiAr
CXN0bTMyX2lwY2Nfc2V0X2JpdHMoJmlwY2MtPmxvY2ssIGlwY2MtPnJlZ19wcm9jICsgSVBDQ19Y
TVIsDQo+ICAgCQkJICAgIFJYX0JJVF9DSEFOKGNoYW4pIHwgVFhfQklUX0NIQU4oY2hhbikpOw0K
PiAgIA0KPiAgIAljbGtfZGlzYWJsZV91bnByZXBhcmUoaXBjYy0+Y2xrKTsNCj4gQEAgLTIwOCw2
ICsyMjIsOCBAQCBzdGF0aWMgaW50IHN0bTMyX2lwY2NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gICAJaWYgKCFpcGNjKQ0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAg
DQo+ICsJc3Bpbl9sb2NrX2luaXQoJmlwY2MtPmxvY2spOw0KPiArDQo+ICAgCS8qIHByb2NfaWQg
Ki8NCj4gICAJaWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAic3QscHJvYy1pZCIsICZpcGNj
LT5wcm9jX2lkKSkgew0KPiAgIAkJZGV2X2VycihkZXYsICJNaXNzaW5nIHN0LHByb2MtaWRcbiIp
Ow0KPiBAQCAtMjU5LDkgKzI3NSwxMCBAQCBzdGF0aWMgaW50IHN0bTMyX2lwY2NfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJfQ0KPiAgIA0KPiAgIAkvKiBtYXNrIGFu
ZCBlbmFibGUgcngvdHggaXJxICovDQo+IC0Jc3RtMzJfaXBjY19zZXRfYml0cyhpcGNjLT5yZWdf
cHJvYyArIElQQ0NfWE1SLA0KPiArCXN0bTMyX2lwY2Nfc2V0X2JpdHMoJmlwY2MtPmxvY2ssIGlw
Y2MtPnJlZ19wcm9jICsgSVBDQ19YTVIsDQo+ICAgCQkJICAgIFJYX0JJVF9NQVNLIHwgVFhfQklU
X01BU0spOw0KPiAtCXN0bTMyX2lwY2Nfc2V0X2JpdHMoaXBjYy0+cmVnX3Byb2MgKyBJUENDX1hD
UiwgWENSX1JYT0lFIHwgWENSX1RYT0lFKTsNCj4gKwlzdG0zMl9pcGNjX3NldF9iaXRzKCZpcGNj
LT5sb2NrLCBpcGNjLT5yZWdfcHJvYyArIElQQ0NfWENSLA0KPiArCQkJICAgIFhDUl9SWE9JRSB8
IFhDUl9UWE9JRSk7DQo+ICAgDQo+ICAgCS8qIHdha2V1cCAqLw0KPiAgIAlpZiAob2ZfcHJvcGVy
dHlfcmVhZF9ib29sKG5wLCAid2FrZXVwLXNvdXJjZSIpKSB7
