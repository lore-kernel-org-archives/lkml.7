Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEE2C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435CF20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="K14Npc1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgABIoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:44:03 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16404 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727756AbgABIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:44:03 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0028Z1nj022070;
        Thu, 2 Jan 2020 09:43:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=OS+yDpqq7SyVkVspEB/RBh0yAJda6QqIhoTkhDJ6UBk=;
 b=K14Npc1SGCwL4TFz2snFFL7TQ9itMUDnjpjXZy6l8L2FA7qqeesT/oGwUz5v7nseBZRI
 fx7wsI++iFevb4UCN/gF4GGCIdSYlHKAzUs7QoR0J7YMd5iMQ6NrpORi9i09n6j7IfjL
 GDe6dfemNZmY652wtVyO0IPfDx/0+uW8qYW/G32NCVjLYXg6fkycaJSdWOpGfBoYNwH7
 XkrccgRpLoDH9YzjiKczOSA2hyHbppdqt2/Ko1jtmiMyJmG3m+BxWs955A5d9vrNkNZM
 FVzgGqYyF9hG0/nn9hUhK6DGsxVtCvOOH53u4yR2clZ41+rYCWruXZLzS05rv2pO+A1o Hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2x5wd6a3g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 09:43:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 52C3710002A;
        Thu,  2 Jan 2020 09:43:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C5F92A6E01;
        Thu,  2 Jan 2020 09:43:41 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jan
 2020 09:43:40 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 2 Jan 2020 09:43:40 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Convert DWC2 bindings to
 json-schema
Thread-Topic: [PATCH v2 1/2] dt-bindings: usb: Convert DWC2 bindings to
 json-schema
Thread-Index: AQHVtlgPPJ7kqTKWikGryQVd+VmeDKfS0A0AgARD9IA=
Date:   Thu, 2 Jan 2020 08:43:40 +0000
Message-ID: <b9b1b18f-b331-de6a-1622-ad43143eb56f@st.com>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
 <20191219103536.25485-2-benjamin.gaignard@st.com> <20191230153524.GA4918@pi3>
In-Reply-To: <20191230153524.GA4918@pi3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <37C7D06533EBC444B8B03560F4795446@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_02:2019-12-30,2020-01-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8zMC8xOSA0OjM1IFBNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiBU
aHUsIERlYyAxOSwgMjAxOSBhdCAxMTozNTozNUFNICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3
cm90ZToNCj4+IENvbnZlcnQgRFdDMiBiaW5kaW5ncyB0byBEVCBzY2hlbWEgZm9ybWF0IHVzaW5n
IGpzb24tc2NoZW1hLg0KPj4gRFdDMiBpcyB3aWRlbHkgdXNlIGJ1dCBhIGNvdXBsZSBvZiBjb21w
YXRpYmxlcyBhbmQgcHJvcGVydGllcw0KPj4gKHZ1c2JfZC1zdXBwbHksdnVzYl9hLXN1cHBseSkg
d2VyZSBtaXNzaW5nIGluIGR3YzIudHh0LCB0aGUNCj4+IHBhdGNoIGFkZCB0aGVtLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5j
b20+DQo+PiAtLS0NCj4+IENDOiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5bm9wc3lzLmNv
bT4NCj4+DQo+PiBjaGFuZ2VzIGluIHZlcnNpb24gMjoNCj4+IC0gcHV0IE1pbmFzIEhhcnV0eXVu
eWFuIDxobWluYXNAc3lub3BzeXMuY29tPiBhcyBtYWludGFpbmVyDQo+PiAtIHJlbW92ZSB0eXBl
IGFuZCBkZXNjcmlwdGlvbiBmcm9tIHBoeSBwcm9wZXJ0eQ0KPj4gLSByZW1vdmUgZGVzY3JpcHRp
b24gZnJvbSBjb21wYXRpYmxlIGl0ZW1zDQo+PiAtIHNpbXBsaWZ5IHNhbXN1bmcsczNjNjQwMC1o
c290ZyBjb21wYXRpYmxlIGhhbmRsaW5nDQo+Pg0KPiAoLi4uKQ0KPg0KPj4gK3JlcXVpcmVkOg0K
Pj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSBpbnRlcnJ1cHRzDQo+PiAr
ICAtIGNsb2Nrcw0KPj4gKyAgLSBjbG9jay1uYW1lcw0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgICAg
dXNiQDEwMWMwMDAwIHsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAicmFsaW5rLHJ0MzA1MC11
c2IsIHNucHMsZHdjMiI7DQo+IERvZXMgaXQgcGFzcyBkdGJzX2NoZWNrPyBTaG91bGQgYmUgdHdv
IHN0cmluZ3MuDQoNCkJhZCBjb3B5L3Bhc3QgZnJvbSB0aGUgb3JpZ2luYWwgdGV4dCBmaWxlLg0K
DQpZb3UgYXJlIHJpZ2h0IGl0IHNob3VsZCB0d28gc3RyaW5ncyBhbmQgZHQgY2hlY2sgdG9vbHMg
ZG9uJ3QgZGV0ZWN0IA0KYmVjYXVzZSB0aGV5IHNlZSBpdCBhcyBhIGRpZmZlcmVudCBjb21wYXRp
YmxlLg0KDQpCZW5qYW1pbg0KDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+DQo+
