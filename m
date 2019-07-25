Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42180C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A5122C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IlDdyaIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390724AbfGYJln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:41:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36040 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387502AbfGYJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:41:42 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P9VIvm019586;
        Thu, 25 Jul 2019 11:41:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=CwGUEJlNPRnLlktsO1S0XN9Odmud6VF8V/BLiayyxtw=;
 b=IlDdyaIPgxFZcZT4SV3Zpu3zeCCA/wutcPzYiKcX6rC5fVRpa6PKCV96Nv5WAB+D7KR1
 cv4DkwhWmFWdcfWQfeUoUd1BUErL9zI/kqfwMum8ymUjGQvKBic4ZlfqEWPm7yanFYka
 0b9kTZqZQejemXX9jUhHu8Bo8gykHXB+iJl3+N116apvocJ2qR6W/+pCV0ChpEBVvh3M
 wYom/r9r2X8aLfvSDFIUG63wQYTknJRxBZ3lYSqLYv1wTykj2ehjNpEH/ubkDp7FRnjG
 /WYplnpv60WkMcvqIM5jw9oNKL1w/Z3hrQrvgqqutgCY5cBvKhF7gnSX2oSiRe2g+c7T Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tx60833y7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Jul 2019 11:41:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A937C38;
        Thu, 25 Jul 2019 09:41:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 496AF2834;
        Thu, 25 Jul 2019 09:41:29 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 25 Jul
 2019 11:41:28 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 25 Jul 2019 11:41:28 +0200
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: stm32: add audio codec support on
 stm32mp157a-dk1 board
Thread-Topic: [PATCH] ARM: dts: stm32: add audio codec support on
 stm32mp157a-dk1 board
Thread-Index: AQHVQj6Deex2/J9kJEqdPNgaDJMMOqba9CwA
Date:   Thu, 25 Jul 2019 09:41:28 +0000
Message-ID: <f43b8af7-e2c0-6193-d666-9fa60050e07d@st.com>
References: <1562327580-19647-1-git-send-email-olivier.moysan@st.com>
 <27476214-07fe-886b-1cab-20902837f29c@st.com>
In-Reply-To: <27476214-07fe-886b-1cab-20902837f29c@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF0A7C08C4373B42860E80A2452E7D13@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMjQvMTkgNjo0MCBQTSwgQWxleGFuZHJlIFRvcmd1ZSB3cm90ZToNCj4gSGkgT2xp
dmllcg0KPiANCj4gT24gNy81LzE5IDE6NTMgUE0sIE9saXZpZXIgTW95c2FuIHdyb3RlOg0KPj4g
QWRkIHN1cHBvcnQgb2YgQ2lycnVzIGNzNDJsNTEgYXVkaW8gY29kZWMgb24gc3RtMzJtcDE1N2Et
ZGsxIGJvYXJkLg0KPj4gQ29uZmlndXJhdGlvbiBvdmVydmlldzoNCj4+IC0gU0FJMkEgaXMgdGhl
IENQVSBpbnRlcmZhY2UgdXNlZCBmb3IgdGhlIGNvZGVjIGF1ZGlvIHBsYXliYWNrDQo+PiAtIFNB
STJCIGlzIHRoZSBDUFUgaW50ZXJmYWNlIHVzZWQgZm9yIHRoZSBjb2RlYyBhdWRpbyByZWNvcmQN
Cj4+IC0gU0FJMkEgaXMgY29uZmlndXJlZCBhcyBhIGNsb2NrIHByb3ZpZGVyIGZvciB0aGUgYXVk
aW8gY29kZWMNCj4+IC0gU0FJMkEmQiBhcmUgY29uZmlndXJlZCBhcyBzbGF2ZSBvZiB0aGUgYXVk
aW8gY29kZWMNCj4+IC0gU0FJMkEmQiBzaGFyZSB0aGUgc2FtZSBpbnRlcmZhY2Ugb2YgdGhlIGF1
ZGlvIGNvZGVjDQo+Pg0KPj4gTm90ZToNCj4+IEluIG1hc3RlciBtb2RlLCBjczQybDUxIGF1ZGlv
IGNvZGVjIHByb3ZpZGVzIGEgYml0Y2xvY2sNCj4+IGF0IDY0IHggRlMsIHJlZ2FyZGxlc3Mgb2Yg
ZGF0YSB3aWR0aC4gVGhpcyBtZWFucyB0aGF0DQo+PiBzbG90IHdpZHRoIGlzIGFsd2F5cyAzMiBi
aXRzLg0KPj4gU2V0IHNsb3Qgd2lkdGggdG8gMzIgYml0cyBhbmQgc2xvdCBudW1iZXIgdG8gMg0K
Pj4gaW4gU0FJMkEmQiBlbmRwb2ludCBub2RlcywgdG8gbWF0Y2ggdGhpcyBjb25zdHJhaW50Lg0K
Pj4gZGFpLXRkbS1zbG90LW51bSBhbmQgZGFpLXRkbS1zbG90LXdpZHRoIHByb3BlcnRpZXMgYXJl
IHVzZWQgaGVyZSwNCj4+IGFzc3VtaW5nIHRoYXQgaTJzIGlzIGEgc3BlY2lhbCBjYXNlIG9mIHRk
bSwgd2hlcmUgc2xvdCBudW1iZXIgaXMgMi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBPbGl2aWVy
IE1veXNhbiA8b2xpdmllci5tb3lzYW5Ac3QuY29tPg0KPj4gLS0tDQo+PiAgICBhcmNoL2FybS9i
b290L2R0cy9zdG0zMm1wMTU3YS1kazEuZHRzIHwgODkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspDQo+Pg0K
PiANCj4gLi4uDQo+IA0KPj4gICAgDQo+PiArJnNhaTIgew0KPj4gKwljbG9ja3MgPSA8JnJjYyBT
QUkyPiwgPCZyY2MgUExMM19RPiwgPCZyY2MgUExMM19SPjsNCj4+ICsJY2xvY2stbmFtZXMgPSAi
cGNsayIsICJ4OGsiLCAieDExayI7DQo+PiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJz
bGVlcCI7DQo+PiArCXBpbmN0cmwtMCA9IDwmc2FpMmFfcGluc19hPiwgPCZzYWkyYl9waW5zX2I+
Ow0KPj4gKwlwaW5jdHJsLTEgPSA8JnNhaTJhX3NsZWVwX3BpbnNfYT4sIDwmc2FpMmJfc2xlZXBf
cGluc19iPjsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gKw0KPj4gKwlzYWkyYTogYXVkaW8t
Y29udHJvbGxlckA0NDAwYjAwNCB7DQo+PiArCQkjY2xvY2stY2VsbHMgPSA8MD47DQo+PiArCQlk
bWEtbmFtZXMgPSAidHgiOw0KPj4gKwkJY2xvY2tzID0gPCZyY2MgU0FJMl9LPjsNCj4+ICsJCWNs
b2NrLW5hbWVzID0gInNhaV9jayI7DQo+PiArCQlzdGF0dXMgPSAib2theSI7DQo+PiArDQo+PiAr
CQlzYWkyYV9wb3J0OiBwb3J0IHsNCj4+ICsJCQlzYWkyYV9lbmRwb2ludDogZW5kcG9pbnQgew0K
Pj4gKwkJCQlyZW1vdGUtZW5kcG9pbnQgPSA8JmNzNDJsNTFfdHhfZW5kcG9pbnQ+Ow0KPj4gKwkJ
CQlmb3JtYXQgPSAiaTJzIjsNCj4+ICsJCQkJbWNsay1mcyA9IDwyNTY+Ow0KPj4gKwkJCQlkYWkt
dGRtLXNsb3QtbnVtID0gPDI+Ow0KPj4gKwkJCQlkYWktdGRtLXNsb3Qtd2lkdGggPSA8MzI+Ow0K
Pj4gKwkJCX07DQo+PiArCQl9Ow0KPj4gKwl9Ow0KPj4gKw0KPiBZb3UgY291bGQgdXNlIGxhYmVs
IHRvIG92ZXJsb2FkIHNhaTJhIGFuZCBzYWkyYi4gbm8gPw0KSSBwcm9wb3NlIHRvIGtlZXAgaXQg
dW5jaGFuZ2VkIGZvciBiZXR0ZXIgcmVhZGFiaWxpdHkNCj4gDQo+PiArCXNhaTJiOiBhdWRpby1j
b250cm9sbGVyQDQ0MDBiMDI0IHsNCj4+ICsJCWRtYS1uYW1lcyA9ICJyeCI7DQo+PiArCQlzdCxz
eW5jID0gPCZzYWkyYSAyPjsNCj4+ICsJCWNsb2NrcyA9IDwmcmNjIFNBSTJfSz4sIDwmc2FpMmE+
Ow0KPj4gKwkJY2xvY2stbmFtZXMgPSAic2FpX2NrIiwgIk1DTEsiOw0KPj4gKwkJc3RhdHVzID0g
Im9rYXkiOw0KPj4gKw0KPj4gKwkJc2FpMmJfcG9ydDogcG9ydCB7DQo+PiArCQkJc2FpMmJfZW5k
cG9pbnQ6IGVuZHBvaW50IHsNCj4+ICsJCQkJcmVtb3RlLWVuZHBvaW50ID0gPCZjczQybDUxX3J4
X2VuZHBvaW50PjsNCj4+ICsJCQkJZm9ybWF0ID0gImkycyI7DQo+PiArCQkJCW1jbGstZnMgPSA8
MjU2PjsNCj4+ICsJCQkJZGFpLXRkbS1zbG90LW51bSA9IDwyPjsNCj4+ICsJCQkJZGFpLXRkbS1z
bG90LXdpZHRoID0gPDMyPjsNCj4+ICsJCQl9Ow0KPj4gKwkJfTsNCj4+ICsJfTsNCj4+ICt9Ow0K
Pj4gKw0KPj4gICAgJnNkbW1jMSB7DQo+PiAgICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0Iiwg
Im9wZW5kcmFpbiIsICJzbGVlcCI7DQo+PiAgICAJcGluY3RybC0wID0gPCZzZG1tYzFfYjRfcGlu
c19hPjsNCj4+
