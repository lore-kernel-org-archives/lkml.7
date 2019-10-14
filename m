Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D19FECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E6920854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Dl9gN9Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbfJNPWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:22:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733176AbfJNPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:22:52 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EFBUlC030427;
        Mon, 14 Oct 2019 17:22:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=p5rZtICDTGDhmscH1gPbidMkXd5JfN9px0OIcu79+No=;
 b=Dl9gN9RopCtdx/q6FoqO0nxR+rz8u7SbLV/jGvEq96WRoYWQZ+nmD4hMzxGrZq/UZ7v8
 ccEVktixvqpqQTY4zhfeqlG+GZ5cYgygCpRCuj/+lRweZgQff40SikRVQvUARf1UrvHK
 T6JVHgj53nZQCYfxjqWE1yMsib+oycNb2uY9H2Vi4KkE6q31y1vQZvp84aM5M6UmF7JH
 3Uc1AJlMPVo4U6nXc3SE/rUbO+7BEpq6UYRx9p/YOuEFhK1mZP3KwWr+bCn9Iwi7pBTo
 lYSRhj/lyMTSY2PqmXet7NruXWeMUFsktrMD1F6EhdZY1E/9Z0m1fm6peF+DMJyHJC+V 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vk4kwu219-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 17:22:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7AEAA100038;
        Mon, 14 Oct 2019 17:22:35 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 66F222D3764;
        Mon, 14 Oct 2019 17:22:35 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 14 Oct
 2019 17:22:35 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 14 Oct 2019 17:22:35 +0200
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
Thread-Index: AQHVfrsEmc79HQHAz0CZKn5VsbroAadZ/p0AgAAE/ACAAAdCgIAACLIAgAAExoCAAA8XAA==
Date:   Mon, 14 Oct 2019 15:22:35 +0000
Message-ID: <c3565734-05e3-0a9d-1101-92c4be476ae6@st.com>
References: <20191009160246.17898-1-benjamin.gaignard@st.com>
 <alpine.DEB.2.21.1910141441350.2531@nanos.tec.linutronix.de>
 <a4b4b785-c471-a3c2-2c41-01bd9865e479@st.com>
 <alpine.DEB.2.21.1910141535500.2531@nanos.tec.linutronix.de>
 <16f7e8e9-eefe-5973-a08a-3e1823d20034@st.com>
 <alpine.DEB.2.21.1910141620100.2531@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910141620100.2531@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <980D4CABC8F9A84983FFA5A5C097E248@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_08:2019-10-11,2019-10-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC8xNC8xOSA0OjI4IFBNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IE9uIE1vbiwg
MTQgT2N0IDIwMTksIEJlbmphbWluIEdBSUdOQVJEIHdyb3RlOg0KPj4gT24gMTAvMTQvMTkgMzo0
MCBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0
IHlvdSBhcmUgdHJ5aW5nIHRvIGFjaGlldmUgaGVyZS4gSWYgdGhlIHRpY2sgZGV2aWNlLA0KPj4+
IGkuZS4gdGhlIGNvbXBhcmF0b3Igc3RvcHMgd29ya2luZyBpbiBkZWVwIGlkbGUgc3RhdGVzLCB0
aGVuIHRoZSBkZXZpY2UgaGFzDQo+Pj4gcmlnaHRmdWxseSB0aGUgQ0xPQ0tfRVZUX0ZFQVRfQzNT
VE9QIChtaXMpZmVhdHVyZSBzZXQuIFdoaWNoIG1lYW5zIHRoYXQgdGhlDQo+Pj4gc3lzdGVtIG5l
ZWRzIGEgZmFsbGJhY2sgZGV2aWNlIGZvciB0aGUgZGVlcCBpZGxlIGNhc2UuIElmIHRoZXJlIGlz
IG5vDQo+Pj4gcGh5c2ljYWwgZmFsbGJhY2sgZGV2aWNlIHRoZW4geW91IHNob3VsZCBlbmFibGUg
dGhlIGhydGltZXIgYmFzZWQgYnJvYWRjYXN0DQo+Pj4gcHNldWRvIHRpY2sgZGV2aWNlLg0KPj4+
DQo+Pj4gSWYgdGhlIENQVXMgbmV2ZXIgZ28gZGVlcCBpZGxlIGJlY2F1c2UgdGhlcmUgaXMgbm8g
aWRsZSBkcml2ZXIgbG9hZGVkIG9yDQo+Pj4gdGhlIGRlZXAgcG93ZXIgc3RhdGUgaW4gd2hpY2gg
dGhlIGNvbXBhcmF0b3Igc3RvcHMgd29ya2luZyBpcyBuZXZlcg0KPj4+IHJlYWNoZWQsIHRoZW4g
dGhlIGJyb2FkY2FzdCBocnRpbWVyIHdpbGwgbmV2ZXIgYmUgdXNlZC4gSXQganVzdCBlYXRzIGEg
Yml0DQo+Pj4gb2YgbWVtb3J5IGFuZCBhIGZldyBleHRyYSBpbnN0cnVjdGlvbnMuDQo+PiBTaW5j
ZSBDUFVzIHdvbid0IGdvIGluIGRlZXAgaWRsZSBJIGRvbid0IHdhbnQgdG8gZ2V0IGEgYnJvYWRj
YXN0IHRpbWVyDQo+PiBidXQgb25seSBhbiBocnRpbWVyIHRvIGdldCBhY2N1cmUgbGF0ZW5jaWVz
IGZvciB0aGUgc2NoZWR1bGVyLg0KPiBXaGF0J3Mgd3Jvbmcgd2l0aCB0aGUgYnJvYWRjYXN0IHRp
bWVyIGlmIGl0IGlzIG5ldmVyIHV0aWxpemVkPyBJdCdzIHRoZXJlLA0KPiBuZWVkcyBhIGZldyBi
eXRlcyBvZiBtZW1vcnkgYW5kIHRoYXQncyBpdC4NCj4NCj4+IFdoZW4gYXJjaCBhcm0gdGltZXIg
ZG9lc24ndCBzZXQgQ0xPQ0tfRVZUX0ZFQVRfQzNTVE9QIGZsYWcsIG15IHN5c3RlbSBnb3QNCj4+
IGEgaHJ0aW1lciBhbmQgZXZlcnl0aGluZyBnb2VzIHdlbGwuDQo+IFN1cmUsIGJ1dCB0aGF0J3Mg
YXBwbGljYWJsZSB0byB5b3VyIHBhcnRpY3VsYXIgc3lzdGVtIG9ubHkgYW5kIG5vdCBhDQo+IGdl
bmVyaWMgc29sdXRpb24uIE5laXRoZXIgeW91ciBEVCBoYWNrLCBub3IgdGhlIG90aGVyIG9uZSB5
b3UgcG9zdGVkLg0KPg0KPj4gSWYgYXJjaCBhcm0gdGltZXIgc2V0IENMT0NLX0VWVF9GRUFUX0Mz
U1RPUCBocnRpbWVyIGRpc2FwcGVhciAoZXhjZXB0IGlmDQo+PiBJIGFkZCBhbiBhZGRpdGlvbmFs
IGJyb2FkY2FzdCB0aW1lcikuDQo+IFJpZ2h0Lg0KPg0KPj4gV2hhdCBpcyB0aGUgbGluayBiZXR3
ZWVuIHRpY2sgYnJvYWRjYXN0IHRpbWVyIGFuZCBocnRpbWVyID8gRG9lcyBhcmNoDQo+PiBhcm0g
dGltZXIgY291bGQgb25seSBpbXBsZW1lbnQgdGhlbSBhdCB0aGUgc2FtZSB0aW1lID8NCj4gSWYg
dGhlIGNsb2NrIGV2ZW50IGRldmljZSBpcyBhZmZlY3RlZCBieSBkZWVwIHBvd2VyIHN0YXRlcywg
dGhlbiB0aGUgY29yZQ0KPiByZXF1aXJlcyBhIGZhbGxiYWNrIGRldmljZSwgYWthLiBicm9hZGNh
c3QgdGltZXIsIHdoaWNoIG1ha2VzIHN1cmUgdGhhdCBubw0KPiBldmVudCBpcyBsb3N0IGluIGNh
c2UgdGhhdCB0aGUgQ1BVIGdvZXMgaW50byBhIGRlZXAgcG93ZXIgc3RhdGUuIElmIG5vIENQVQ0K
PiBldmVyIGdvZXMgZGVlcCwgdGhlIGJyb2FkY2FzdCB0aW1lciBpcyB0aGVyZSBhbmQgdW51c2Vk
Lg0KPg0KPiBPYnZpb3VzbHkgdGhlIHN5c3RlbSBjYW5ub3QgZW5hYmxlIGhpZ2ggcmVzb2x1dGlv
biB0aW1lcnMgaWYgdGhlIGNsb2NrDQo+IGV2ZW50IGRldmljZSBpcyBhZmZlY3RlZCBieSBwb3dl
ciBzdGF0ZXMuDQo+DQo+IFVubGVzcyB5b3UgaGF2ZSBhIHNvbHV0aW9uIHdoaWNoIHdvcmtzIHVu
ZGVyIGFsbCBjaXJjdW1zdGFuY2VzIChhbmQgdGhlDQo+IGN1cnJlbnQgcGF0Y2ggZGVmaW5pdGVs
eSBkb2VzIG5vdCkgdGhlbiB5b3UgaGF2ZSB0byBkZWFsIHdpdGggdGhlDQo+IHJlcXVpcmVtZW50
IG9mIHRoZSBicm9hZGNhc3QgdGltZXIgKGVpdGhlciBwaHlzaWNhbCBvciBzb2Z0d2FyZSBiYXNl
ZCkuDQoNCklmIEkgZm9sbG93IHlvdSBJIG5lZWQsIGZvciBteSBzeXN0ZW0sIGEgc29mdHdhcmUg
YmFzZWQgYnJvYWRjYXN0IHRpbWVyIA0KKHRpY2stYnJvYWRjYXN0LWhydGltZXIgPykuDQoNCklm
IHRoYXQgaXMgY29ycmVjdCBJICdqdXN0JyBuZWVkIHRvIGFkZCBhIGNhbGwgdG8gDQp0aWNrX3Nl
dHVwX2hydGltZXJfYnJvYWRjYXN0KCkgaW4gYXJjaC9hcm0va2VybmVsL3RpbWUuYw0KDQpSZWdh
cmRzLA0KDQpCZW5qYW1pbg0KDQo+DQo+ICJJIGRvbid0IHdhbnQgYSBicm9hZGNhc3QgdGltZXIg
ZmFsbHMiIGludG8gdGhlICJJIHdhbnQgYSBwb255IiByZWFsbS4NCj4NCj4gVGhhbmtzLA0KPg0K
PiAJdGdseA0KPg==
