Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F42C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AEA2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AVmVE0Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfDWNdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:33:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9702 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfDWNdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:33:45 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NDWhjF002104;
        Tue, 23 Apr 2019 15:33:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=zq2lp7hP6vCd+TJr7a39X5+O3h2VM18KzIgQzL3+Afg=;
 b=AVmVE0Ty335rXKw7W+K/1GyJwYa210bxN1hyRlec9JI5ZGRjmSZ2ekw7aagpPidb9K4m
 2dbwhhVxCGSsMINzsjBBFLpAAb3sNMf5BlrFthJdA6cWtlYDMS7MmfGflbEvvHB7/T1W
 JcV5QndAV7+rcHVYVyvqn9WKeUSAGHaYH3gEiDXH+G0cJjc+X2NVcxCB8x8P6dVuME9Z
 JwzNw2z5OKbL0BxIHkZFEzRmCVkb5jbPWzsu5srGKKYlkkvR5pWd03oYalpNrtreRcFT
 oXSaCevSHfzfTsTrZheXACiCHllfiAb/eZk2cd8wBieKNCHCgOD3q2UPSYvhYoqEzqJz jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6rqpy8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Apr 2019 15:33:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B615548;
        Tue, 23 Apr 2019 13:33:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E8AD26DB;
        Tue, 23 Apr 2019 13:33:20 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 23 Apr
 2019 15:33:20 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 23 Apr 2019 15:33:19 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH 0/7] Introduce bus domains controller framework
Thread-Topic: [RESEND PATCH 0/7] Introduce bus domains controller framework
Thread-Index: AQHU3XI+UFYqCLO6eUyiTs5dTNdeG6YRI0GAgAAGMwCAOKkIAIAAA1KA
Date:   Tue, 23 Apr 2019 13:33:19 +0000
Message-ID: <b36d8e3b-926c-11ce-747c-74124c09d13b@st.com>
References: <20190318100605.29120-1-benjamin.gaignard@st.com>
 <20190318104343.GA15574@e107155-lin>
 <CA+M3ks6bsiGXCKEQmaFmzBRhWPVhV5wBjVhgyfCa-25DohnsOg@mail.gmail.com>
 <20190423132116.GA3892@e107155-lin>
In-Reply-To: <20190423132116.GA3892@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C4A126D5076144697082B1BDA313C6C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzIzLzE5IDM6MjEgUE0sIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gTW9uLCBNYXIg
MTgsIDIwMTkgYXQgMTI6MDU6NTRQTSArMDEwMCwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+
PiBMZSBsdW4uIDE4IG1hcnMgMjAxOSDDoCAxMTo0MywgU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9s
bGFAYXJtLmNvbT4gYSDDqWNyaXQgOg0KPj4+IE9uIE1vbiwgTWFyIDE4LCAyMDE5IGF0IDExOjA1
OjU4QU0gKzAxMDAsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4+PiBCdXMgZG9tYWlucyBj
b250cm9sbGVycyBhbGxvdyB0byBkaXZpZGVkIHN5c3RlbSBvbiBjaGlwIGludG8gbXVsdGlwbGUg
ZG9tYWlucw0KPj4+PiB0aGF0IGNhbiBiZSB1c2VkIHRvIHNlbGVjdCBieSB3aG8gaGFyZHdhcmUg
YmxvY2tzIGNvdWxkIGJlIGFjY2Vzc2VkLg0KPj4+PiBBIGRvbWFpbiBjb3VsZCBiZSBhIGNsdXN0
ZXIgb2YgQ1BVcyAob3IgY29wcm9jZXNzb3JzKSwgYSByYW5nZSBvZiBhZGRyZXNzZXMgb3INCj4+
Pj4gYSBncm91cCBvZiBoYXJkd2FyZSBibG9ja3MuDQo+Pj4+DQo+Pj4+IEZyYW1ld29yayBhcmNo
aXRlY3R1cmUgaXMgaW5zcGlyYXRlZCBieSBwaW5jdHJsIGZyYW1ld29yazoNCj4+Pj4gLSBhIGRl
ZmF1bHQgY29uZmlndXJhdGlvbiBjb3VsZCBiZSBhcHBsaWVkIGJlZm9yZSBiaW5kIHRoZSBkcml2
ZXINCj4+Pj4gLSBjb25maWd1cmF0aW9ucyBjb3VsZCBiZSBhcGxsaWVkIGR5bmFtaWNhbGx5IGJ5
IGRyaXZlcnMNCj4+Pj4gLSBkZXZpY2Ugbm9kZSBwcm92aWRlcyB0aGUgYnVzIGRvbWFpbnMgY29u
ZmlndXJhdGlvbnMNCj4+Pj4NCj4+Pj4gQW4gZXhhbXBsZSBvZiBidXMgZG9tYWlucyBjb250cm9s
bGVyIGlzIFNUTTMyIEVUWlBDIGhhcmR3YXJlIGJsb2NrDQo+Pj4+IHdoaWNoIGdvdCAzIGRvbWFp
bnM6DQo+Pj4+IC0gc2VjdXJlOiBoYXJkd2FyZSBibG9ja3MgYXJlIG9ubHkgYWNjZXNzaWJsZSBi
eSBzb2Z0d2FyZSBydW5uaW5nIG9uIHRydXN0DQo+Pj4+ICAgIHpvbmUuDQo+Pj4+IC0gbm9uLXNl
Y3VyZTogaGFyZHdhcmUgYmxvY2tzIGFyZSBhY2Nlc3NpYmxlIGJ5IG5vbi1zZWN1cmUgc29mdHdh
cmUgKGkuZS4NCj4+Pj4gICAgbGludXgga2VybmVsKS4NCj4+Pj4gLSBjb3Byb2Nlc3NvcjogaGFy
ZHdhcmUgYmxvY2tzIGFyZSBvbmx5IGFjY2Vzc2libGUgYnkgdGhlIGNvcnBvY2Vzc29yLg0KPj4+
PiBVcCB0byA5NCBoYXJkd2FyZSBibG9ja3Mgb2YgdGhlIHNvYyBjb3VsZCBiZSBtYW5hZ2VkIGJ5
IEVUWlBDIGFuZA0KPj4+PiBhc3NpZ25lZCB0byBvbmUgb2YgdGhlIHRocmVlIGRvbWFpbnMuDQo+
Pj4+DQo+Pj4gWW91IGZhaWwgdG8gZXhwbGFpbiB3aHkgZG8gd2UgbmVlZCB0aGlzIGluIG5vbi1z
ZWN1cmUgTGludXggPw0KPj4+IFlvdSBuZWVkIHRvIGhhdmUgc29saWQgcmVhc29ucyBhcyB3aHkg
dGhpcyBjYW4ndCBiZSBkb25lIGluIHNlY3VyZQ0KPj4+IGZpcm13YXJlLiBBbmQgeWVzIEkgbWVh
biBldmVuIG9uIGFybTMyLiBPbiBwbGF0Zm9ybXMgd2l0aCBzdWNoIGhhcmR3YXJlDQo+Pj4gY2Fw
YWJpbGl0aWVzIHlvdSB3aWxsIG5lZWQgc29tZSBzZWN1cmUgZmlybXdhcmUgdG8gYmUgcnVubmlu
ZyBhbmQgdGhlc2UNCj4+PiB0aGluZ3MgY2FuIGJlIGRvbmUgdGhlcmUuIEkgZG9uJ3Qgd2FudCB0
aGlzIGVuYWJsZWQgZm9yIEFSTTY0IGF0IGFsbCwNCj4+PiBmaXJtd2FyZSAqaGFzIHRvIGRlYWwq
IHdpdGggdGhpcy4NCj4+IFdlIHVzZSBFVFpQQyB0byBkZWZpbmUgaWYgaGFyZHdhcmUgYmxvY2tz
IGNhbiBiZSB1c2VkIGJ5IENvcnRleCBBNyBvciBDb3J0ZXgNCj4+IE00IChib3RoIG5vbi1zZWN1
cmUpIG9uIFNUTTMyTVAxIFNvQywgdGhpcyBuZXcgZnJhbWV3b3JrIGFsbG93IHRvIGNoYW5nZQ0K
Pj4gaGFyZHdhcmUgYmxvY2sgc3BsaXQgYXQgcnVudGltZS4gVGhpcyBjb3VsZCBiZSBkb25lIGV2
ZW4gb24gbm9uLXNlY3VyZSB3b3JsZA0KPj4gYmVjYXVzZSB0aGVpciBpcyBub3RoaW5nIGNyaXRp
Y2FsIHRvIGNoYW5nZSBoYXJkd2FyZSBibG9ja3MgdXNlcnMuDQo+IE9LLCB0aGF0J3MgaW50ZXJl
c3RpbmcsIGFzc3VtaW5nIENvcnRleCBNNCBleGVjdXRpb24gYXMgbm9uLXNlY3VyZS4gSSB3b3Vs
ZA0KPiBleHBlY3Qgb3RoZXJ3aXNlLiBFdmVuIGlmIGl0J3MgY29uZmlndXJhYmxlLCBJIHdvdWxk
IHNlZSB0aGF0IGhhcHBlbiBpbg0KPiBzZWN1cmUgZW50aXR5IHZpYSBPUFRFRSBvciBzb21ldGhp
bmcgc2ltaWxhciBmcm9tIG5vbi1zZWN1cmUgc2lkZS4NCllvdXIgYXNzdW1wdGlvbiBpcyBjb3Jy
ZWN0IENvcnRleCBNNCBleGVjdXRpb24gaXMgbm9uLXNlY3VyZS4NCj4NCj4gRG8geW91IGhhdmUg
YW55IGRvY3VtZW50cyB0aGF0IEkgY2FuIHJlZmVyIHRvIGdldCB0aGUgb3ZlcmFsbCBzZWN1cml0
eQ0KPiBkZXNpZ24gZm9yIHN1Y2ggcGxhdGZvcm1zID8NCg0KU29DIGRhdGFzaGVldCBpcyBoZXJl
Og0KDQpodHRwczovL3d3dy5zdC5jb20vcmVzb3VyY2UvZW4vZGF0YXNoZWV0L3N0bTMybXAxNTdh
LnBkZg0KDQp3aXRoIGp1c3QgZmV3IHdvcmRzIGFib3V0IEVUWlBDOg0KDQozLjE0IFRydXN0Wm9u
ZSBwcm90ZWN0aW9uIGNvbnRyb2xsZXIgKEVUWlBDKQ0KRVRaUEMgaXMgdXNlZCB0byBjb25maWd1
cmUgVHJ1c3Rab25lIHNlY3VyaXR5IG9mIGJ1cyBtYXN0ZXJzIGFuZCBzbGF2ZXMgd2l0aA0KcHJv
Z3JhbW1hYmxlLXNlY3VyaXR5IGF0dHJpYnV0ZXMgKHNlY3VyYWJsZSByZXNvdXJjZXMpIHN1Y2gg
YXM6DQrigKIgT24tY2hpcCBTWVNSQU0gd2l0aCBwcm9ncmFtbWFibGUgc2VjdXJlIHJlZ2lvbiBz
aXplDQrigKIgQUhCIGFuZCBBUEIgcGVyaXBoZXJhbHMgdG8gYmUgbWFkZSBzZWN1cmUNCk5vdGlj
ZSB0aGF0IGJ5IGRlZmF1bHQsIFNZU1JBTSBhbmQgcGVyaXBoZXJhbCBhcmUgc2V0IHRvIHNlY3Vy
ZSBhY2Nlc3MgDQpvbmx5LCBzbywgbm90DQphY2Nlc3NpYmxlIGJ5IG5vbi1zZWN1cmUgbWFzdGVy
cyBzdWNoIGFzIENvcnRleC1NNCBvciBETUExL0RNQTIuDQpFVFpQQyBjYW4gYWxzbyBhbGxvY2F0
ZSBwZXJpcGhlcmFscyBhbmQgU1JBTSB0byBiZSBhY2Nlc3NpYmxlIG9ubHkgYnkgDQp0aGUgQ29y
dGV4LU00DQphbmQvb3IgRE1BMS9ETUEyLiBUaGlzIGVuc3VyZXMgdGhlIHNhZmUgZXhlY3V0aW9u
IG9mIHRoZSBDb3J0ZXgtTTQgDQpmaXJtd2FyZSwgcHJvdGVjdGVkDQpmcm9tIG90aGVyIG1hc3Rl
cnMgKGUuZy4gQ29ydGV4LUE3KSB1bndhbnRlZCBhY2Nlc3Nlcy4NCg0KQmVuamFtaW4NCg0KPg0K
PiAtLQ0KPiBSZWdhcmRzLA0KPiBTdWRlZXA=
