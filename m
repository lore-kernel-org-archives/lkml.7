Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A6EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A965520673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="r/mwFqxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfI0MpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:45:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17358 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfI0MpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:45:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8RCf7Do023288;
        Fri, 27 Sep 2019 14:45:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=c2263AQj5goxPH7EsCg1rVlru4wVSjoHgnO39hvQMvU=;
 b=r/mwFqxoJAAbj87JK8+QsrqK4//Z3gqalF4KpBrjPTVB2JQsYrRzLYcJFzHxqg2PxRE7
 4cm4Washim2C0ET+m+uFwBbEW8wZL/uE8ix1YYQ/nFrinQlC2AYV7roO4U6r1B2QG76u
 ccEQnJaNAXoz9B3cFj2iKvxZ8G3rK2ie/RSWQJKSTRR432Rcho9AC700iSonRYa8XNCg
 mkjcyu4cdiBQ1QpO2FXbiInaeJ+xchBL9IzgYs1yo3YO5qun1VnA65ML0nD83DlC6bGN
 pBpmMcI0H1jf3uPAryo0TU76dT4b/HhfzxyaMVyyJbzsr71orpQkdtZLs4TkEbjgFZWY dg== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2v59mxmks1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Sep 2019 14:45:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 287334E;
        Fri, 27 Sep 2019 12:44:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9F3222BCB3B;
        Fri, 27 Sep 2019 14:44:56 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Sep
 2019 14:44:56 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 27 Sep 2019 14:44:56 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: stm32: Enable high resolution timer
Thread-Topic: [PATCH] ARM: dts: stm32: Enable high resolution timer
Thread-Index: AQHVdRBWUjMsQJUFmUWpOD9xBCdtcac/P/aAgAAUtICAAAFTgIAAARMA
Date:   Fri, 27 Sep 2019 12:44:55 +0000
Message-ID: <69af57d1-13a9-9e35-78f2-4a0d17bdaf6d@st.com>
References: <20190927084819.645-1-benjamin.gaignard@st.com>
 <da48ce9633441cd0186518fa7ce1d528@www.loen.fr>
 <341949c8-7864-5d65-2797-988022724a4c@st.com>
 <ff11797da8f049b354797689754fde52@www.loen.fr>
In-Reply-To: <ff11797da8f049b354797689754fde52@www.loen.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <92F7A698A77B6645A13BFC2DB06725DE@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-27_06:2019-09-25,2019-09-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA5LzI3LzE5IDI6NDEgUE0sIE1hcmMgWnluZ2llciB3cm90ZToNCj4gT24gMjAxOS0wOS0y
NyAxMzozNiwgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+PiBPbiA5LzI3LzE5IDE6MjIgUE0s
IE1hcmMgWnluZ2llciB3cm90ZToNCj4+PiBPbiAyMDE5LTA5LTI3IDA5OjQ4LCBCZW5qYW1pbiBH
YWlnbmFyZCB3cm90ZToNCj4+Pj4gQWRkaW5nIGFsd2F5cy1vbiBtYWtlcyBhcm0gYXJjaF90aW1l
ciBjbGFpbSB0byBiZSBhbiBoaWdoIHJlc29sdXRpb24NCj4+Pj4gdGltZXIuDQo+Pj4+IFRoYXQg
aXMgcG9zc2libGUgYmVjYXVzZSBwb3dlciBtb2RlIHdvbid0IHN0b3AgY2xvY2tpbmcgdGhlIHRp
bWVyLg0KPj4+DQo+Pj4gVGhlICJhbHdheXMtb24iIGlzIG5vdCBhYm91dCB0aGUgY2xvY2suIEl0
IGlzIGFib3V0IHRoZSBjb21wYXJhdG9yLg0KPj4+IFRoZSBjbG9jayBpdHNlbGYgaXMgKmd1YXJh
bnRlZWQqIHRvIGFsd2F5cyB0aWNrLiBJZiBpdCBkaWRuJ3QsIA0KPj4+IHRoYXQnZCBiZQ0KPj4+
IGFuIGludGVncmF0aW9uIGJ1ZywgYW5kIGEgcHJldHR5IGJhZCBvbmUuDQo+Pj4NCj4+PiBXaGF0
IHlvdSdyZSBjbGFpbWluZyBoZXJlIGlzIHRoYXQgeW91ciBDUFUgbmV2ZXIgZW50ZXJzIGEgbG93
LXBvd2VyIA0KPj4+IG1vZGU/DQo+Pj4gRXZlcj8gSSBmaW5kIHRoaXMgdmVyeSBoYXJkIHRvIGJl
bGlldmUuDQo+Pj4NCj4+PiBGdXJ0aGVybW9yZSwgY2xhaW1pbmcgdGhhdCBhbHdheXMtb24gaXMg
dGhlIHdheSB0byBmb3JjZSB0aGUgYXJjaC10aW1lcg0KPj4+IHRvIGJlIGFuIGhydGltZXIgaXMg
ZmFjdHVhbGx5IHdyb25nLiBUaGlzIGlzIHdoYXQgaGFwcGVucyAqaWYqIHRoaXMgaXMNCj4+PiB0
aGUgb25seSB0aW1lciBpbiB0aGUgc3lzdGVtLiBUaGUgb25seSBjYXNlIHRoaXMgaXMgdHJ1ZSBp
cyBmb3IgdmlydHVhbA0KPj4+IG1hY2hpbmVzLiBBbnl0aGluZyBlbHNlIGhhcyBhIGdsb2JhbCB0
aW1lciBzb21ld2hlcmUgdGhhdCB3aWxsIGFsbG93DQo+Pj4gdGhlIGFyY2ggdGltZXJzIHRvIGJl
IHVzZWQgYXMgYW4gaHJ0aW1lci4NCj4+Pg0KPj4+IEknbSBwcmV0dHkgc3VyZSB5b3UgdG9vIGhh
dmUgYSBnbG9iYWwgdGltZXIgc29tZXdoZXJlIGluIHlvdXIgc3lzdGVtLg0KPj4+IEVuYWJsZSBp
dCwgYW5kIGVuam95IGhydGltZXJzIHdpdGhvdXQgaGF2aW5nIHRvIGxpZSBhYm91dCB0aGUgDQo+
Pj4gcHJvcGVydGllcw0KPj4+IG9mIHlvdXIgc3lzdGVtISA7LSkNCj4+DQo+PiBIaSBNYXJjLA0K
Pj4NCj4+IFRoaXMgU29DIGRvZXNuJ3QgaGF2ZSBhbnkgb3RoZXIgZ2xvYmFsIHRpbWVyLiBVc2Ug
YXJjaF90aW1lIGlzIHRoZSBvbmx5DQo+PiB3ZSBoYXZlIHRvIHByb3ZpZGUgaHJ0aW1lciBvbiB0
aGlzIHN5c3RlbS4NCj4NCj4gQW5kIHlvdSBkb24ndCBoYXZlIGFueSBmb3JtIG9mIHBvd2VyIG1h
bmFnZW1lbnQgZWl0aGVyPyBXaGF0IGhhcHBlbnMgd2hlbg0KPiB5b3VyIENQVSBnb2VzIGludG8g
aWRsZT8gSWYgeW91ciBzeXN0ZW0gZG9lcyBhbnkgZm9ybSBvZiBwb3dlciBtYW5hZ2VtZW50DQo+
ICphbmQqIGRvZXNuJ3QgaGF2ZSBhIHNlcGFyYXRlIHRpbWVyLCBpdCBpcyByZW1hcmthYmx5IGJy
b2tlbi4NCg0KRXZlbiBpbiBsb3ctcG93ZXIgbW9kZXMgdGhpcyB0aW1lciBpcyBhbHdheXMgcG93
ZXJlZCBhbmQgY2xvY2tlZCBzbyBpdCANCmlzIHdvcmtpbmcgZmluZS4NCg0KPg0KPiDCoMKgwqDC
oMKgwqDCoCBNLg==
