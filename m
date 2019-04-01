Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58930C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7C42082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfDANkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:40:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37686 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbfDANkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:40:08 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31DUtGD000946;
        Mon, 1 Apr 2019 15:37:58 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rhxt4jxgh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Apr 2019 15:37:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E244D34;
        Mon,  1 Apr 2019 13:37:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5053C2A37;
        Mon,  1 Apr 2019 13:37:57 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Apr
 2019 15:37:57 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 1 Apr 2019 15:37:57 +0200
From:   Hugues FRUCHET <hugues.fruchet@st.com>
To:     Andi Kleen <andi@firstfloor.org>, "x86@kernel.org" <x86@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "mchehab@s-opensource.com" <mchehab@s-opensource.com>
Subject: Re: [PATCH 10/17] delta: Fix buffer overrun in delta_ipc_open
Thread-Topic: [PATCH 10/17] delta: Fix buffer overrun in delta_ipc_open
Thread-Index: AQHU4DF+EkeJEPLYVkuR2+5UpJYj4KYnPk8A
Date:   Mon, 1 Apr 2019 13:37:56 +0000
Message-ID: <bb7d9aeb-9cde-92c6-cbd1-c0ba3d283f07@st.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-11-andi@firstfloor.org>
In-Reply-To: <20190321220009.29334-11-andi@firstfloor.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <347000EB36C52C4B9F56618F7C3B4CCF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kaSwNCg0KV2UgaGF2ZSBhbHJlYWR5IGRpc2N1c3NlZCBhYm91dCB0aGF0IGhlcmU6DQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvODY2NDA2Lw0KDQpOb3cgdGhh
dCBzdHJzY3B5IGlzIGxhcmdlbHkgZGVwbG95ZWQgd2l0aGluIGtlcm5lbCwgY291bGQgeW91IHJl
dGVzdCANCndpdGggdGhlIGNoYW5nZSBJIHN1Z2dlc3RlZCA/DQoNCkJlc3QgcmVnYXJkcywNCkh1
Z3Vlcy4NCg0KT24gMy8yMS8xOSAxMTowMCBQTSwgQW5kaSBLbGVlbiB3cm90ZToNCj4gRnJvbTog
QW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPg0KPiANCj4gZGVsdGFfaXBjX29wZW4gaXMg
YWx3YXlzIGNhbGxlZCB3aXRoIGEgc2luZ2xlIGNvbnN0YW50IHN0cmluZw0KPiBhcyBuYW1lLCBi
dXQgaXQgdXNlcyBhIGxvbmdlciBtZW1jcHkgdG8gY29weSB0aGUgc3RyaW5nIHRvDQo+IGEgZGlm
ZmVyZW50IHN0cnVjdHVyZS4gVGhlIG1lbWNweSB3b3VsZCByZWFkIG91dHNpZGUgdGhlIGJvdW5k
cw0KPiBvZiB0aGUgc3RyaW5nLCBwb3RlbnRpYWxseSBhY2Nlc3NpbmcgdW5tYXBwZWQgbWVtb3J5
Lg0KPiANCj4gSnVzdCB1c2Ugc3RyY3B5IGluc3RlYWQgYWZ0ZXIgY2xlYXJpbmcgdGhlIGFyZWEu
DQo+IA0KPiBUaGlzIGZpeGVzIGEgYnVpbGQgZXJyb3Igd2l0aCBMVE8sIHdoaWNoIGNhbiBkZXRl
Y3QgdGhpcy4NCj4gDQo+IENjOiBodWd1ZXMuZnJ1Y2hldEBzdC5jb20NCj4gQ2M6IG1jaGVoYWJA
cy1vcGVuc291cmNlLmNvbQ0KPiBGaXhlczogOTFjODNmMzk1ZmJlIFttZWRpYV0gc3QtZGVsdGE6
IHJwbXNnIGlwYyBzdXBwb3J0DQo+IFNpZ25lZC1vZmYtYnk6IEFuZGkgS2xlZW4gPGFrQGxpbnV4
LmludGVsLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdGkvZGVsdGEv
ZGVsdGEtaXBjLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vc3RpL2RlbHRhL2RlbHRhLWlwYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdGkvZGVs
dGEvZGVsdGEtaXBjLmMNCj4gaW5kZXggYTQ2MDNkNTczYzM0Li5iZDFiYmJlZWRlYzMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RpL2RlbHRhL2RlbHRhLWlwYy5jDQo+
ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RpL2RlbHRhL2RlbHRhLWlwYy5jDQo+IEBA
IC0xNzUsOCArMTc1LDggQEAgaW50IGRlbHRhX2lwY19vcGVuKHN0cnVjdCBkZWx0YV9jdHggKnBj
dHgsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAgCW1zZy5pcGNfYnVmX3NpemUgPSBpcGNfYnVmX3Np
emU7DQo+ICAgCW1zZy5pcGNfYnVmX3BhZGRyID0gY3R4LT5pcGNfYnVmLT5wYWRkcjsNCj4gICAN
Cj4gLQltZW1jcHkobXNnLm5hbWUsIG5hbWUsIHNpemVvZihtc2cubmFtZSkpOw0KPiAtCW1zZy5u
YW1lW3NpemVvZihtc2cubmFtZSkgLSAxXSA9IDA7DQo+ICsJbWVtc2V0KG1zZy5uYW1lLCAwLCBz
aXplb2YobXNnLm5hbWUpKTsNCj4gKwlzdHJjcHkobXNnLm5hbWUsIG5hbWUpOw0KPiAgIA0KPiAg
IAltc2cucGFyYW1fc2l6ZSA9IHBhcmFtLT5zaXplOw0KPiAgIAltZW1jcHkoY3R4LT5pcGNfYnVm
LT52YWRkciwgcGFyYW0tPmRhdGEsIG1zZy5wYXJhbV9zaXplKTsNCj4g
