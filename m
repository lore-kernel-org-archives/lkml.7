Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944DC21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfCVIfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37243 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727713AbfCVIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:32 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2M8QleO024094;
        Fri, 22 Mar 2019 09:35:25 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r8rwkj9kb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Mar 2019 09:35:25 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9312834;
        Fri, 22 Mar 2019 08:35:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A9F62539;
        Fri, 22 Mar 2019 08:35:24 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Mar
 2019 09:35:24 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Fri, 22 Mar 2019 09:35:24 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH] tty: fix NULL pointer issue when tty_port ops is not set
Thread-Topic: [PATCH] tty: fix NULL pointer issue when tty_port ops is not set
Thread-Index: AQHU3/zXcSiC5ycjuECfnfEnyEBf1KYWSSKAgAD6gQA=
Date:   Fri, 22 Mar 2019 08:35:24 +0000
Message-ID: <49b89d39-f3c0-7c90-806c-9a552c96367a@st.com>
References: <1553183006-12820-1-git-send-email-fabien.dessenne@st.com>
 <20190321173847.GA7032@kroah.com>
In-Reply-To: <20190321173847.GA7032@kroah.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2383F8D9AE559048883E3E255B8ACFC8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KSSBkbyBub3QgdGhpbmsgdGhhdCBhbnkgZHJpdmVyIGZhY2VzIHRoaXMgcHJv
YmxlbS4NCg0KTmV2ZXJ0aGVsZXNzIEkgZm91bmQgMiBkcml2ZXJzIGRlY2xhcmluZyBhbiAnZW1w
dHknIHN0cnVjdCAod2FzdGVkKSB0byANCnNvbHZlIHRoaXMgaXNzdWU6DQoNCmRyaXZlcnMvY2hh
ci90dHlwcmludGs6DQpzdGF0aWMgY29uc3Qgc3RydWN0IHR0eV9wb3J0X29wZXJhdGlvbnMgbnVs
bF9vcHMgPSB7IH07DQoNCmRyaXZlcnMvdHR5L3ZjYy5jOg0Kc3RhdGljIHN0cnVjdCB0dHlfcG9y
dF9vcGVyYXRpb25zIHZjY19wb3J0X29wcyA9IHsgMCB9Ow0KDQoNClBsZWFzZSBsZXQgbWUga25v
dyBpZiB5b3UgcHJlZmVyIEkgYWJhbmRvbiB0aGlzIHBhdGNoIGFuZCB1c2UgYW4gJ2VtcHR5JyAN
CnN0cnVjdCBpbiB0aGUgbmV3IGNvZGUgSSBhZGQuDQoNCk9yIGlmIHlvdSB0aGluayB0aGF0IHRo
aXMgcGF0Y2ggaXMgc2FmZSwgZmVlbCBmcmVlIHRvIGFzayBtZSB0byB1cGRhdGUgDQp0aGUgdHdv
IGRyaXZlcnMgbGlzdGVkIGFib3ZlLg0KDQoNCkJSDQoNCg0KRmFiaWVuDQoNCg0KDQpPbiAyMS8w
My8yMDE5IDY6MzggUE0sIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gVGh1LCBNYXIg
MjEsIDIwMTkgYXQgMDQ6NDM6MjZQTSArMDEwMCwgRmFiaWVuIERlc3Nlbm5lIHdyb3RlOg0KPj4g
VW5saWtlICdjbGllbnRfb3BzJyB3aGljaCBpcyBpbml0aWFsaXplZCB0byAnZGVmYXVsdF9jbGll
bnRfb3BzJywgdGhlDQo+PiBwb3J0IG9wZXJhdGlvbnMgJ29wcycgbWF5IGJlIGxlZnQgdG8gTlVM
TC4NCj4+IENoZWNrIHRoZSAnb3BzJyB2YWx1ZSBiZWZvcmUgY2hlY2tpbmcgdGhlICdvcHMtPngn
IHZhbHVlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZhYmllbiBEZXNzZW5uZSA8ZmFiaWVuLmRl
c3Nlbm5lQHN0LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3R0eS90dHlfcG9ydC5jIHwgMTAg
KysrKystLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS90dHlfcG9ydC5jIGIvZHJp
dmVycy90dHkvdHR5X3BvcnQuYw0KPj4gaW5kZXggMDQ0YzNjYi4uYTllMTJiMyAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvdHR5L3R0eV9wb3J0LmMNCj4+ICsrKyBiL2RyaXZlcnMvdHR5L3R0eV9w
b3J0LmMNCj4+IEBAIC0zMjUsNyArMzI1LDcgQEAgc3RhdGljIHZvaWQgdHR5X3BvcnRfc2h1dGRv
d24oc3RydWN0IHR0eV9wb3J0ICpwb3J0LCBzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5KQ0KPj4gICAJ
CWlmICh0dHkgJiYgQ19IVVBDTCh0dHkpKQ0KPj4gICAJCQl0dHlfcG9ydF9sb3dlcl9kdHJfcnRz
KHBvcnQpOw0KPj4gICANCj4+IC0JCWlmIChwb3J0LT5vcHMtPnNodXRkb3duKQ0KPj4gKwkJaWYg
KHBvcnQtPm9wcyAmJiBwb3J0LT5vcHMtPnNodXRkb3duKQ0KPj4gICAJCQlwb3J0LT5vcHMtPnNo
dXRkb3duKHBvcnQpOw0KPj4gICAJfQ0KPj4gICBvdXQ6DQo+PiBAQCAtMzk4LDcgKzM5OCw3IEBA
IEVYUE9SVF9TWU1CT0xfR1BMKHR0eV9wb3J0X3R0eV93YWtldXApOw0KPj4gICAgKi8NCj4+ICAg
aW50IHR0eV9wb3J0X2NhcnJpZXJfcmFpc2VkKHN0cnVjdCB0dHlfcG9ydCAqcG9ydCkNCj4+ICAg
ew0KPj4gLQlpZiAocG9ydC0+b3BzLT5jYXJyaWVyX3JhaXNlZCA9PSBOVUxMKQ0KPj4gKwlpZiAo
IXBvcnQtPm9wcyB8fCAhcG9ydC0+b3BzLT5jYXJyaWVyX3JhaXNlZCkNCj4+ICAgCQlyZXR1cm4g
MTsNCj4+ICAgCXJldHVybiBwb3J0LT5vcHMtPmNhcnJpZXJfcmFpc2VkKHBvcnQpOw0KPj4gICB9
DQo+PiBAQCAtNDE0LDcgKzQxNCw3IEBAIEVYUE9SVF9TWU1CT0wodHR5X3BvcnRfY2Fycmllcl9y
YWlzZWQpOw0KPj4gICAgKi8NCj4+ICAgdm9pZCB0dHlfcG9ydF9yYWlzZV9kdHJfcnRzKHN0cnVj
dCB0dHlfcG9ydCAqcG9ydCkNCj4+ICAgew0KPj4gLQlpZiAocG9ydC0+b3BzLT5kdHJfcnRzKQ0K
Pj4gKwlpZiAocG9ydC0+b3BzICYmIHBvcnQtPm9wcy0+ZHRyX3J0cykNCj4+ICAgCQlwb3J0LT5v
cHMtPmR0cl9ydHMocG9ydCwgMSk7DQo+PiAgIH0NCj4+ICAgRVhQT1JUX1NZTUJPTCh0dHlfcG9y
dF9yYWlzZV9kdHJfcnRzKTsNCj4+IEBAIC00MjksNyArNDI5LDcgQEAgRVhQT1JUX1NZTUJPTCh0
dHlfcG9ydF9yYWlzZV9kdHJfcnRzKTsNCj4+ICAgICovDQo+PiAgIHZvaWQgdHR5X3BvcnRfbG93
ZXJfZHRyX3J0cyhzdHJ1Y3QgdHR5X3BvcnQgKnBvcnQpDQo+PiAgIHsNCj4+IC0JaWYgKHBvcnQt
Pm9wcy0+ZHRyX3J0cykNCj4+ICsJaWYgKHBvcnQtPm9wcyAmJiBwb3J0LT5vcHMtPmR0cl9ydHMp
DQo+PiAgIAkJcG9ydC0+b3BzLT5kdHJfcnRzKHBvcnQsIDApOw0KPj4gICB9DQo+PiAgIEVYUE9S
VF9TWU1CT0wodHR5X3BvcnRfbG93ZXJfZHRyX3J0cyk7DQo+PiBAQCAtNjg0LDcgKzY4NCw3IEBA
IGludCB0dHlfcG9ydF9vcGVuKHN0cnVjdCB0dHlfcG9ydCAqcG9ydCwgc3RydWN0IHR0eV9zdHJ1
Y3QgKnR0eSwNCj4+ICAgDQo+PiAgIAlpZiAoIXR0eV9wb3J0X2luaXRpYWxpemVkKHBvcnQpKSB7
DQo+PiAgIAkJY2xlYXJfYml0KFRUWV9JT19FUlJPUiwgJnR0eS0+ZmxhZ3MpOw0KPj4gLQkJaWYg
KHBvcnQtPm9wcy0+YWN0aXZhdGUpIHsNCj4+ICsJCWlmIChwb3J0LT5vcHMgJiYgcG9ydC0+b3Bz
LT5hY3RpdmF0ZSkgew0KPj4gICAJCQlpbnQgcmV0dmFsID0gcG9ydC0+b3BzLT5hY3RpdmF0ZShw
b3J0LCB0dHkpOw0KPj4gICAJCQlpZiAocmV0dmFsKSB7DQo+PiAgIAkJCQltdXRleF91bmxvY2so
JnBvcnQtPm11dGV4KTsNCj4+IC0tIA0KPj4gMi43LjQNCj4+DQo+IENhbiB5b3UgaGl0IHRoaXMg
dG9kYXkgd2l0aCBhbnkgaW4ta2VybmVsIGRyaXZlcnM/ICBPciBpcyB0aGlzIG9ubHkgZm9yDQo+
IHlvdXIgbmV3IGNvZGUgeW91IGFyZSBhZGRpbmc/DQo+DQo+IHRoYW5rcywNCj4NCj4gZ3JlZyBr
LWg=
