Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C647CC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE82063F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="mLocYcDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfD2Iud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:50:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1183 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727517AbfD2Iuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:50:32 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3T8fTMS007712;
        Mon, 29 Apr 2019 10:49:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=i2CLqYU4GwrLxCYnOOSir1J49uaIFg3QwOiHNqW/DMI=;
 b=mLocYcDosabWj+1ZZh/jun41Uyto0EFSNoSUHIPb23+2+As++SIBKc1XCDhALb+zqDa2
 cSP9Zxa4+v5fc8mUkzRKGjdnDvPHpVnxPU/s7Hj14MIRVO9bYppDfLj3SLKjZMYQOzSl
 YyaN9e2ThRYO7mVt/9QXKLbKvUY/006FNSdAIXnDZUWjUeyGACIgFUfyJ/GcxjKAWirl
 M1TV7To33skxQtCTC5PF1Ftj0RTyQ6jISnjkjRm26PtDW51mHngz79hKp4I2V2mIenE4
 RVQ/pazP9N7xWy8eAuw6v9m6ut6bbWAa5S8kU8lZKFxs096AINP87EeQ4+rznfyu08s6 Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s4cutu1mb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Apr 2019 10:49:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 69BB946;
        Mon, 29 Apr 2019 08:49:40 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30A82139B;
        Mon, 29 Apr 2019 08:49:40 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Apr
 2019 10:49:39 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 29 Apr 2019 10:49:39 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Loic PALLARDY" <loic.pallardy@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [RESEND PATCH 1/7] devicetree: bindings: Document domains
 controller bindings
Thread-Topic: [RESEND PATCH 1/7] devicetree: bindings: Document domains
 controller bindings
Thread-Index: AQHU3XI+crMGE3C/8EqSA6+xEWAscaZS9IgA
Date:   Mon, 29 Apr 2019 08:49:39 +0000
Message-ID: <dbb7440f-f055-6ff3-d367-3435c3c34d89@st.com>
References: <20190318100605.29120-1-benjamin.gaignard@st.com>
 <20190318100605.29120-2-benjamin.gaignard@st.com>
In-Reply-To: <20190318100605.29120-2-benjamin.gaignard@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <06E79A3F4E1BA74194AF26EC2207345D@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzLzE4LzE5IDExOjA1IEFNLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4gRG9jdW1l
bnQgY29tbW9ucyBkb21haW5zIGNvbnRyb2xsZXIgYmluZGluZ3MgZm9yIGNvbnRyb2xsZXINCj4g
YW5kIGNsaWVudCBkZXZpY2VzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFy
ZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KDQpIaSBSb2IsDQoNCkluIHRoZSBmaXJzdCB2
ZXJzaW9uIG9mIHRoaXMgc2VyaWVzIHlvdSBoYXZlIGFza2VkIG1lIHRvIHJld29yayB0aGUgDQpm
cmFtZXdvcmsgZGVzY3JpcHRpb24uDQpEb2VzIHRoaXMgdjIgZmVlbCBiZXR0ZXIgZm9yIHlvdSA/
DQoNCkJlbmphbWluDQoNCj4gLS0tDQo+ICAgLi4uL2JpbmRpbmdzL2J1cy9kb21haW5zL2RvbWFp
bnNjdHJsLnR4dCAgICAgICAgICAgfCA1NSArKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2J1cy9kb21haW5zL2RvbWFpbnNjdHJsLnR4
dA0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2J1
cy9kb21haW5zL2RvbWFpbnNjdHJsLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9idXMvZG9tYWlucy9kb21haW5zY3RybC50eHQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mODJlNWUxMWVhNjQNCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYnVzL2RvbWFpbnMvZG9tYWlu
c2N0cmwudHh0DQo+IEBAIC0wLDAgKzEsNTUgQEANCj4gK0NvbW1vbiBEb21haW5zIENvbnRyb2xs
ZXIgYmluZGluZ3MgcHJvcGVydGllcw0KPiArDQo+ICtCdXMgZG9tYWlucyBjb250cm9sbGVycyBh
bGxvdyB0byBkaXZpZGVkIHN5c3RlbSBvbiBjaGlwIGludG8gbXVsdGlwbGUgZG9tYWlucw0KPiAr
dGhhdCBjYW4gYmUgdXNlZCB0byBzZWxlY3QgYnkgd2hvIGhhcmR3YXJlIGJsb2NrcyBjb3VsZCBi
ZSBhY2Nlc3NlZC4NCj4gK0EgZG9tYWluIGNvdWxkIGJlIGEgY2x1c3RlciBvZiBDUFVzIChvciBj
b3Byb2Nlc3NvcnMpLCBhIHJhbmdlIG9mIGFkZHJlc3NlcyBvcg0KPiArYSBncm91cCBvZiBoYXJk
d2FyZSBibG9ja3MuDQo+ICsNCj4gK1RoaXMgZGV2aWNlIHRyZWUgYmluZGluZ3MgY2FuIGJlIHVz
ZWQgdG8gYmluZCBidXMgZG9tYWluIGNvbnN1bWVyIGRldmljZXMgd2l0aA0KPiArdGhlaXIgYnVz
IGRvbWFpbnMgcHJvdmlkZWQgYnkgYnVzIGRvbWFpbnMgY29udHJvbGxlcnMuIEEgYnVzIGRvbWFp
biBwcm92aWRlcg0KPiArY2FuIGJlIHJlcHJlc2VudGVkIGJ5IGFueSBub2RlIGluIHRoZSBkZXZp
Y2UgdHJlZSBhbmQgY2FuIHByb3ZpZGUgb25lIG9yIG1vcmUNCj4gK2J1cyBkb21haW5zLiBBIGNv
bnN1bWVyIG5vZGUgY2FuIHJlZmVyIHRvIHRoZSBwcm92aWRlciBieSBhIHBoYW5kbGUgYW5kIGEg
c2V0DQo+ICtvZiBwaGFuZGxlIGFyZ3VtZW50cyBvZiBsZW5ndGggc3BlY2lmaWVkIGJ5IHRoZSAj
ZG9tYWluY3RybC1jZWxscyBwcm9wZXJ0eSBpbg0KPiArdGhlIGJ1cyBkb21haW4gcHJvdmlkZXIg
bm9kZS4NCj4gKw0KPiArPT1CdXMgZG9tYWluIHByb3ZpZGVyPT0NCj4gKw0KPiArUmVxdWlyZWQg
cHJvcGVydGllczoNCj4gKy0gI2RvbWFpbmN0cmwtY2VsbHMJOiBOdW1iZXIgb2YgY2VsbHMgaW4g
YSBidXMgZG9tYWluIHNwZWNpZmllcjsNCj4gKwkJCSAgQ2FuIGJlIGFueSB2YWx1ZSBhcyBzcGVj
aWZpZWQgYnkgZGV2aWNlIHRyZWUgYmluZGluZw0KPiArCQkJICBkb2N1bWVudGF0aW9uIG9mIGEg
cGFydGljdWxhciBwcm92aWRlci4NCj4gKw0KPiArPT1CdXMgZG9tYWluIGNvbnN1bWVyPT0NCj4g
Kw0KPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gKy0gZG9tYWluc2N0cmwtWAkJOiBBIGxpc3Qg
b2YgYnVzIGRvbWFpbiBzcGVjaWZpZXJzLCBhcyBkZWZpbmVkIGJ5DQo+ICsJCQkgIGJpbmRpbmdz
IG9mIHRoZSBidXMgZG9tYWluIGNvbnRyb2xsZXIgdGhhdCBpcyB0aGUNCj4gKwkJCSAgYnVzIGRv
bWFpbiBwcm92aWRlci4NCj4gKw0KPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gKy0gZG9tYWlu
c2N0cmwtbmFtZXMJOiBBIGxpc3Qgb2YgYnVzIGRvbWFpbiBuYW1lIHN0cmluZyBzb3J0ZWQgaW4g
dGhlIHNhbWUNCj4gKwkJCSAgb3JkZXIgYXMgdGhlIGRvbWFpbnNjdHJsLVggcHJvcHJlcnRpZXMu
IENvbnN1bWVyDQo+ICsJCQkgIGRyaXZlcnMgd2lsbCB1c2UgZG9tYWluc2N0cmwtbmFtZXMgdG8g
bWF0Y2ggYnVzDQo+ICsJCQkgIGRvbWFpbnMgd2l0aCBidXMgZG9tYWlucyBzcGVjaWZpZXJzLg0K
PiArCQkJICBOb3RlIHRoYXQgImRlZmF1bHQiIGFuZCAidW5iaW5kIiBhcmUgcmVzZXJ2ZWQgbmFt
ZXMNCj4gKwkJCSAgdXNlZCBieSB0aGUgZnJhbWV3b3JrLg0KPiArDQo+ICtFeGFtcGxlIG9mIHVz
YWdlIHdpdGg6DQo+ICstIGEgZG9tYWlucyBjb250cm9sbGVyIHdpdGggYSAyIHBhcmFtZXRlcnMg
Y2VsbA0KPiArLSBhIGRvbWFpbnMgY29udHJvbGxlciB3aXRoIGEgMyBwYXJhbWV0ZXJzIGNlbGwN
Cj4gKy0gYSBjbGllbnQgZGV2aWNlIG5vZGUgdXNpbmcgdGhlIGJvdGggY29udHJvbGxlcnMgYW5k
IDIgY29uZmlndXJhdGlvbnMNCj4gKyAgbmFtZWQgImRlZmF1bHQiIGFuZCAidW5iaW5kIg0KPiAr
DQo+ICtjdHJsMDogY3RybEAwIHsNCj4gKwkjZG9tYWluY3RybC1jZWxscyA9IDwyPjsNCj4gK307
DQo+ICsNCj4gK2N0cmwxOiBjdHJsQDEgew0KPiArCSNkb21haW5jdHJsLWNlbGxzID0gPDM+Ow0K
PiArfTsNCj4gKw0KPiArZm9vQDAgew0KPiArCWRvbWFpbnMtbmFtZXMgPSAiZGVmYXVsdCIsICJ1
bmJpbmQiOw0KPiArCWRvbWFpbmN0cmwtMCA9IDwmY3RybDAgMSAyPiwgPCZjdHJsMSAzIDQgNT47
DQo+ICsJZG9tYWluY3RybC0xID0gPCZjdHJsMCA2IDc+LCA8JmN0cmwxIDggOSAwPjsNCj4gK307
