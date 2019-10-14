Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5571C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9498A2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lfM2QVEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbfJNOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:11:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15734 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732349AbfJNOLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:11:40 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EE4xcu027729;
        Mon, 14 Oct 2019 16:11:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=FBKBmbXbb2VMQYvWLF+7xp5vpVM8m1N8lwxubX8nusg=;
 b=lfM2QVEbPrG1yuEed4Bj9p8yJWBLMyggg8Ntw17yX18Zst/c3+ER4dhmHQGq7SmiDB3j
 N+uVFgqtlUZvycLnlNTgiOxgCHylEmKACtn8fa6WlQpcOPZ6OD58udeBHiYJatzC0OFw
 JdZQOLuWWxQwallCvbJ5F/Ez4boCYNJ92QBLERb3RYaEjm6gVjb/ADQxzk7yS6Ss33WF
 Q8DThHoRNaQlkqguPnFJ3k/nKVduUi//+oTg5Ls+Q9rrCeePA5oNqXMMJGrX+ng+C/TD
 OkRFGM8SMuIkOhs90ylGI9GwA2gKqf8pfAzwLXz7Ec8t0p/QA6u3dyVkwo9+G0izwG1r EQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vk3y9k51b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 16:11:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B751410002A;
        Mon, 14 Oct 2019 16:11:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A182F2C7EBD;
        Mon, 14 Oct 2019 16:11:29 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 14 Oct
 2019 16:11:29 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 14 Oct 2019 16:11:29 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] tick: check if broadcast device could really be stopped
Thread-Topic: [PATCH] tick: check if broadcast device could really be stopped
Thread-Index: AQHVfrsEmc79HQHAz0CZKn5VsbroAadZ/p0AgAAE/ACAAAdCgIAACLIA
Date:   Mon, 14 Oct 2019 14:11:29 +0000
Message-ID: <16f7e8e9-eefe-5973-a08a-3e1823d20034@st.com>
References: <20191009160246.17898-1-benjamin.gaignard@st.com>
 <alpine.DEB.2.21.1910141441350.2531@nanos.tec.linutronix.de>
 <a4b4b785-c471-a3c2-2c41-01bd9865e479@st.com>
 <alpine.DEB.2.21.1910141535500.2531@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910141535500.2531@nanos.tec.linutronix.de>
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
Content-ID: <3FBD4E9FC443504BA1D025EEB71ED12C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_08:2019-10-11,2019-10-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC8xNC8xOSAzOjQwIFBNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IE9uIE1vbiwg
MTQgT2N0IDIwMTksIEJlbmphbWluIEdBSUdOQVJEIHdyb3RlOg0KPj4gT24gMTAvMTQvMTkgMjo1
NiBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+IE9uIFdlZCwgOSBPY3QgMjAxOSwgQmVu
amFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+Pj4+IEBAIC03OCw3ICs3OCw3IEBAIHN0YXRpYyBib29s
IHRpY2tfY2hlY2tfYnJvYWRjYXN0X2RldmljZShzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlICpj
dXJkZXYsDQo+Pj4+ICAgIHsNCj4+Pj4gICAgCWlmICgobmV3ZGV2LT5mZWF0dXJlcyAmIENMT0NL
X0VWVF9GRUFUX0RVTU1ZKSB8fA0KPj4+PiAgICAJICAgIChuZXdkZXYtPmZlYXR1cmVzICYgQ0xP
Q0tfRVZUX0ZFQVRfUEVSQ1BVKSB8fA0KPj4+PiAtCSAgICAobmV3ZGV2LT5mZWF0dXJlcyAmIENM
T0NLX0VWVF9GRUFUX0MzU1RPUCkpDQo+Pj4+ICsJICAgIHRpY2tfYnJvYWRjYXN0X2NvdWxkX3N0
b3AobmV3ZGV2KSkNCj4+PiBOby4gVGhpcyBtaWdodCBiZSBjYWxsZWQgX2JlZm9yZV8gYSBjcHVp
ZGxlIGRyaXZlciBpcyBhdmFpbGFibGUgYW5kIHRoZW4NCj4+PiB3aGVuIHRoYXQgZHJpdmVyIGlz
IGxvYWRlZCBhbmQgZ29lcyBkZWVwLCBldmVyeXRoaW5nIGdvZXMgc291dGguDQo+PiBXaGF0IGNv
dWxkIGJlIHRoZSBzb2x1dGlvbiB0byBsZXQga25vdyB0byB0aWNrIGJyb2FkY2FzdCBmcmFtZXdv
cmsgdGhhdA0KPj4gdGhpcyBkZXZpY2UNCj4+DQo+PiB3aWxsIG5vdCBiZSBzdG9wcGVkIChiZWNh
dXNlIENQVSB3b24ndCBnbyBpbiBpZGxlKSA/DQo+Pg0KPj4gSSBoYXZlIHRyaWVkIHRvIHB1dCAi
YWx3YXlzLW9uIiBwcm9wZXJ0eSBvbiBEVCBidXQgaXQgd2FzIGEgTkFDSyB0b286DQo+Pg0KPj4g
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvOS8yNy8xNjQNCj4+DQo+PiBEbyBJIGhhdmUgbWlz
cyBhIGZsYWcgc29tZXdoZXJlID8NCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IGFyZSB0
cnlpbmcgdG8gYWNoaWV2ZSBoZXJlLiBJZiB0aGUgdGljayBkZXZpY2UsDQo+IGkuZS4gdGhlIGNv
bXBhcmF0b3Igc3RvcHMgd29ya2luZyBpbiBkZWVwIGlkbGUgc3RhdGVzLCB0aGVuIHRoZSBkZXZp
Y2UgaGFzDQo+IHJpZ2h0ZnVsbHkgdGhlIENMT0NLX0VWVF9GRUFUX0MzU1RPUCAobWlzKWZlYXR1
cmUgc2V0LiBXaGljaCBtZWFucyB0aGF0IHRoZQ0KPiBzeXN0ZW0gbmVlZHMgYSBmYWxsYmFjayBk
ZXZpY2UgZm9yIHRoZSBkZWVwIGlkbGUgY2FzZS4gSWYgdGhlcmUgaXMgbm8NCj4gcGh5c2ljYWwg
ZmFsbGJhY2sgZGV2aWNlIHRoZW4geW91IHNob3VsZCBlbmFibGUgdGhlIGhydGltZXIgYmFzZWQg
YnJvYWRjYXN0DQo+IHBzZXVkbyB0aWNrIGRldmljZS4NCj4NCj4gSWYgdGhlIENQVXMgbmV2ZXIg
Z28gZGVlcCBpZGxlIGJlY2F1c2UgdGhlcmUgaXMgbm8gaWRsZSBkcml2ZXIgbG9hZGVkIG9yDQo+
IHRoZSBkZWVwIHBvd2VyIHN0YXRlIGluIHdoaWNoIHRoZSBjb21wYXJhdG9yIHN0b3BzIHdvcmtp
bmcgaXMgbmV2ZXINCj4gcmVhY2hlZCwgdGhlbiB0aGUgYnJvYWRjYXN0IGhydGltZXIgd2lsbCBu
ZXZlciBiZSB1c2VkLiBJdCBqdXN0IGVhdHMgYSBiaXQNCj4gb2YgbWVtb3J5IGFuZCBhIGZldyBl
eHRyYSBpbnN0cnVjdGlvbnMuDQoNClNpbmNlIENQVXMgd29uJ3QgZ28gaW4gZGVlcCBpZGxlIEkg
ZG9uJ3Qgd2FudCB0byBnZXQgYSBicm9hZGNhc3QgdGltZXINCg0KYnV0IG9ubHkgYW4gaHJ0aW1l
ciB0byBnZXQgYWNjdXJlIGxhdGVuY2llcyBmb3IgdGhlIHNjaGVkdWxlci4NCg0KV2hlbiBhcmNo
IGFybSB0aW1lciBkb2Vzbid0IHNldCBDTE9DS19FVlRfRkVBVF9DM1NUT1AgZmxhZywgbXkgc3lz
dGVtDQoNCmdvdCBhIGhydGltZXIgYW5kIGV2ZXJ5dGhpbmcgZ29lcyB3ZWxsLiBJZiBhcmNoIGFy
bSB0aW1lciBzZXQgDQpDTE9DS19FVlRfRkVBVF9DM1NUT1ANCg0KaHJ0aW1lciBkaXNhcHBlYXIg
KGV4Y2VwdCBpZiBJIGFkZCBhbiBhZGRpdGlvbmFsIGJyb2FkY2FzdCB0aW1lcikuDQoNCldoYXQg
aXMgdGhlIGxpbmsgYmV0d2VlbiB0aWNrIGJyb2FkY2FzdCB0aW1lciBhbmQgaHJ0aW1lciA/IERv
ZXMgYXJjaCANCmFybSB0aW1lciBjb3VsZCBvbmx5DQoNCmltcGxlbWVudCB0aGVtIGF0IHRoZSBz
YW1lIHRpbWUgPw0KDQpCZW5qYW1pbg0KDQo+DQo+IFRoYW5rcywNCj4NCj4gCXRnbHgNCj4=
