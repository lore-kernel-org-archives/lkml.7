Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DECC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D4A214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ko4KjipT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfDWORs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:17:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22758 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbfDWORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:17:48 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NECqrc030414;
        Tue, 23 Apr 2019 16:17:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=os869RF4BexNzUhbSc1vKwJ7072dfRhCI8hR7rOSMqg=;
 b=Ko4KjipTbj9Hw5oP1yLP0tjmnp6LICUD+trEpWE7N8usU7uAlETNNLKkiUn/HEyU1rjd
 EIGffCWPtBLMqVGkFTkUnmnVaSV1ZLORpIWY6NKENgu+MXExkPQrQ/n892Ynrw0ZBUM7
 gfzt9cDuEIYI/yvHqkpAOJ2XhhjkM3YTwhnLerLN5DhiUI+DqDcXW7t+xqEtxRoYY1Bs
 VpGrGhb4h7Luhq+v7X3q0tMML/BtO5k8jP/xalF6+otFHl7ML16pZWTkS3WEMGPyUreu
 Yct444xyPukZCNCS/ncchqdODjFSGGy1FPS/E56qgqpepEsHYEh8U3n9asQD8NJ0ApLX Ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6rqwsx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Apr 2019 16:17:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 483B638;
        Tue, 23 Apr 2019 14:17:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE7C62799;
        Tue, 23 Apr 2019 14:17:23 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 23 Apr
 2019 16:17:23 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 23 Apr 2019 16:17:23 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Loic PALLARDY" <loic.pallardy@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH 0/7] Introduce bus domains controller framework
Thread-Topic: [RESEND PATCH 0/7] Introduce bus domains controller framework
Thread-Index: AQHU3XI+UFYqCLO6eUyiTs5dTNdeG6YRI0GAgAAGMwCAOKkIAIAAA1KAgAAGSgCAAAYGgA==
Date:   Tue, 23 Apr 2019 14:17:23 +0000
Message-ID: <c8a23e26-79af-eb0f-80bc-5360f30b2a37@st.com>
References: <20190318100605.29120-1-benjamin.gaignard@st.com>
 <20190318104343.GA15574@e107155-lin>
 <CA+M3ks6bsiGXCKEQmaFmzBRhWPVhV5wBjVhgyfCa-25DohnsOg@mail.gmail.com>
 <20190423132116.GA3892@e107155-lin>
 <b36d8e3b-926c-11ce-747c-74124c09d13b@st.com>
 <20190423135550.GB3892@e107155-lin>
In-Reply-To: <20190423135550.GB3892@e107155-lin>
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
Content-ID: <524B6BA4FCDD0E4C9671EE9E183AC388@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzIzLzE5IDM6NTUgUE0sIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gVHVlLCBBcHIg
MjMsIDIwMTkgYXQgMDE6MzM6MTlQTSArMDAwMCwgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+
PiBPbiA0LzIzLzE5IDM6MjEgUE0sIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+PiBPbiBNb24sIE1h
ciAxOCwgMjAxOSBhdCAxMjowNTo1NFBNICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToN
Cj4+Pj4gTGUgbHVuLiAxOCBtYXJzIDIwMTkgw6AgMTE6NDMsIFN1ZGVlcCBIb2xsYSA8c3VkZWVw
LmhvbGxhQGFybS5jb20+IGEgw6ljcml0IDoNCj4+Pj4+IE9uIE1vbiwgTWFyIDE4LCAyMDE5IGF0
IDExOjA1OjU4QU0gKzAxMDAsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4+Pj4+IEJ1cyBk
b21haW5zIGNvbnRyb2xsZXJzIGFsbG93IHRvIGRpdmlkZWQgc3lzdGVtIG9uIGNoaXAgaW50byBt
dWx0aXBsZSBkb21haW5zDQo+Pj4+Pj4gdGhhdCBjYW4gYmUgdXNlZCB0byBzZWxlY3QgYnkgd2hv
IGhhcmR3YXJlIGJsb2NrcyBjb3VsZCBiZSBhY2Nlc3NlZC4NCj4+Pj4+PiBBIGRvbWFpbiBjb3Vs
ZCBiZSBhIGNsdXN0ZXIgb2YgQ1BVcyAob3IgY29wcm9jZXNzb3JzKSwgYSByYW5nZSBvZiBhZGRy
ZXNzZXMgb3INCj4+Pj4+PiBhIGdyb3VwIG9mIGhhcmR3YXJlIGJsb2Nrcy4NCj4+Pj4+Pg0KPj4+
Pj4+IEZyYW1ld29yayBhcmNoaXRlY3R1cmUgaXMgaW5zcGlyYXRlZCBieSBwaW5jdHJsIGZyYW1l
d29yazoNCj4+Pj4+PiAtIGEgZGVmYXVsdCBjb25maWd1cmF0aW9uIGNvdWxkIGJlIGFwcGxpZWQg
YmVmb3JlIGJpbmQgdGhlIGRyaXZlcg0KPj4+Pj4+IC0gY29uZmlndXJhdGlvbnMgY291bGQgYmUg
YXBsbGllZCBkeW5hbWljYWxseSBieSBkcml2ZXJzDQo+Pj4+Pj4gLSBkZXZpY2Ugbm9kZSBwcm92
aWRlcyB0aGUgYnVzIGRvbWFpbnMgY29uZmlndXJhdGlvbnMNCj4+Pj4+Pg0KPj4+Pj4+IEFuIGV4
YW1wbGUgb2YgYnVzIGRvbWFpbnMgY29udHJvbGxlciBpcyBTVE0zMiBFVFpQQyBoYXJkd2FyZSBi
bG9jaw0KPj4+Pj4+IHdoaWNoIGdvdCAzIGRvbWFpbnM6DQo+Pj4+Pj4gLSBzZWN1cmU6IGhhcmR3
YXJlIGJsb2NrcyBhcmUgb25seSBhY2Nlc3NpYmxlIGJ5IHNvZnR3YXJlIHJ1bm5pbmcgb24gdHJ1
c3QNCj4+Pj4+PiAgICAgem9uZS4NCj4+Pj4+PiAtIG5vbi1zZWN1cmU6IGhhcmR3YXJlIGJsb2Nr
cyBhcmUgYWNjZXNzaWJsZSBieSBub24tc2VjdXJlIHNvZnR3YXJlIChpLmUuDQo+Pj4+Pj4gICAg
IGxpbnV4IGtlcm5lbCkuDQo+Pj4+Pj4gLSBjb3Byb2Nlc3NvcjogaGFyZHdhcmUgYmxvY2tzIGFy
ZSBvbmx5IGFjY2Vzc2libGUgYnkgdGhlIGNvcnBvY2Vzc29yLg0KPj4+Pj4+IFVwIHRvIDk0IGhh
cmR3YXJlIGJsb2NrcyBvZiB0aGUgc29jIGNvdWxkIGJlIG1hbmFnZWQgYnkgRVRaUEMgYW5kDQo+
Pj4+Pj4gYXNzaWduZWQgdG8gb25lIG9mIHRoZSB0aHJlZSBkb21haW5zLg0KPj4+Pj4+DQo+Pj4+
PiBZb3UgZmFpbCB0byBleHBsYWluIHdoeSBkbyB3ZSBuZWVkIHRoaXMgaW4gbm9uLXNlY3VyZSBM
aW51eCA/DQo+Pj4+PiBZb3UgbmVlZCB0byBoYXZlIHNvbGlkIHJlYXNvbnMgYXMgd2h5IHRoaXMg
Y2FuJ3QgYmUgZG9uZSBpbiBzZWN1cmUNCj4+Pj4+IGZpcm13YXJlLiBBbmQgeWVzIEkgbWVhbiBl
dmVuIG9uIGFybTMyLiBPbiBwbGF0Zm9ybXMgd2l0aCBzdWNoIGhhcmR3YXJlDQo+Pj4+PiBjYXBh
YmlsaXRpZXMgeW91IHdpbGwgbmVlZCBzb21lIHNlY3VyZSBmaXJtd2FyZSB0byBiZSBydW5uaW5n
IGFuZCB0aGVzZQ0KPj4+Pj4gdGhpbmdzIGNhbiBiZSBkb25lIHRoZXJlLiBJIGRvbid0IHdhbnQg
dGhpcyBlbmFibGVkIGZvciBBUk02NCBhdCBhbGwsDQo+Pj4+PiBmaXJtd2FyZSAqaGFzIHRvIGRl
YWwqIHdpdGggdGhpcy4NCj4+Pj4gV2UgdXNlIEVUWlBDIHRvIGRlZmluZSBpZiBoYXJkd2FyZSBi
bG9ja3MgY2FuIGJlIHVzZWQgYnkgQ29ydGV4IEE3IG9yIENvcnRleA0KPj4+PiBNNCAoYm90aCBu
b24tc2VjdXJlKSBvbiBTVE0zMk1QMSBTb0MsIHRoaXMgbmV3IGZyYW1ld29yayBhbGxvdyB0byBj
aGFuZ2UNCj4+Pj4gaGFyZHdhcmUgYmxvY2sgc3BsaXQgYXQgcnVudGltZS4gVGhpcyBjb3VsZCBi
ZSBkb25lIGV2ZW4gb24gbm9uLXNlY3VyZSB3b3JsZA0KPj4+PiBiZWNhdXNlIHRoZWlyIGlzIG5v
dGhpbmcgY3JpdGljYWwgdG8gY2hhbmdlIGhhcmR3YXJlIGJsb2NrcyB1c2Vycy4NCj4+PiBPSywg
dGhhdCdzIGludGVyZXN0aW5nLCBhc3N1bWluZyBDb3J0ZXggTTQgZXhlY3V0aW9uIGFzIG5vbi1z
ZWN1cmUuIEkgd291bGQNCj4+PiBleHBlY3Qgb3RoZXJ3aXNlLiBFdmVuIGlmIGl0J3MgY29uZmln
dXJhYmxlLCBJIHdvdWxkIHNlZSB0aGF0IGhhcHBlbiBpbg0KPj4+IHNlY3VyZSBlbnRpdHkgdmlh
IE9QVEVFIG9yIHNvbWV0aGluZyBzaW1pbGFyIGZyb20gbm9uLXNlY3VyZSBzaWRlLg0KPj4gWW91
ciBhc3N1bXB0aW9uIGlzIGNvcnJlY3QgQ29ydGV4IE00IGV4ZWN1dGlvbiBpcyBub24tc2VjdXJl
Lg0KPiBTb3JyeSBpZiBJIHdhcyBub3QgY2xlYXIuIEkgdG9sZCBDb3J0ZXggTTQgbm9uLXNlY3Vy
ZSBleGVjdXRpb24gaXMgaW50ZXJlc3RpbmcNCj4gYXMgSSBleHBlY3RlZCBpdCB0byBiZSBzZWN1
cmUuDQo+DQo+Pj4gRG8geW91IGhhdmUgYW55IGRvY3VtZW50cyB0aGF0IEkgY2FuIHJlZmVyIHRv
IGdldCB0aGUgb3ZlcmFsbCBzZWN1cml0eQ0KPj4+IGRlc2lnbiBmb3Igc3VjaCBwbGF0Zm9ybXMg
Pw0KPj4gU29DIGRhdGFzaGVldCBpcyBoZXJlOg0KPj4NCj4+IGh0dHBzOi8vd3d3LnN0LmNvbS9y
ZXNvdXJjZS9lbi9kYXRhc2hlZXQvc3RtMzJtcDE1N2EucGRmDQo+Pg0KPj4gd2l0aCBqdXN0IGZl
dyB3b3JkcyBhYm91dCBFVFpQQzoNCj4+DQo+PiAzLjE0IFRydXN0Wm9uZSBwcm90ZWN0aW9uIGNv
bnRyb2xsZXIgKEVUWlBDKQ0KPj4gRVRaUEMgaXMgdXNlZCB0byBjb25maWd1cmUgVHJ1c3Rab25l
IHNlY3VyaXR5IG9mIGJ1cyBtYXN0ZXJzIGFuZCBzbGF2ZXMgd2l0aA0KPj4gcHJvZ3JhbW1hYmxl
LXNlY3VyaXR5IGF0dHJpYnV0ZXMgKHNlY3VyYWJsZSByZXNvdXJjZXMpIHN1Y2ggYXM6DQo+PiDi
gKIgT24tY2hpcCBTWVNSQU0gd2l0aCBwcm9ncmFtbWFibGUgc2VjdXJlIHJlZ2lvbiBzaXplDQo+
PiDigKIgQUhCIGFuZCBBUEIgcGVyaXBoZXJhbHMgdG8gYmUgbWFkZSBzZWN1cmUNCj4+IE5vdGlj
ZSB0aGF0IGJ5IGRlZmF1bHQsIFNZU1JBTSBhbmQgcGVyaXBoZXJhbCBhcmUgc2V0IHRvIHNlY3Vy
ZSBhY2Nlc3MNCj4+IG9ubHksIHNvLCBub3QgYWNjZXNzaWJsZSBieSBub24tc2VjdXJlIG1hc3Rl
cnMgc3VjaCBhcyBDb3J0ZXgtTTQgb3IgRE1BMS9ETUEyLg0KPj4gRVRaUEMgY2FuIGFsc28gYWxs
b2NhdGUgcGVyaXBoZXJhbHMgYW5kIFNSQU0gdG8gYmUgYWNjZXNzaWJsZSBvbmx5IGJ5DQo+PiB0
aGUgQ29ydGV4LU00IGFuZC9vciBETUExL0RNQTIuIFRoaXMgZW5zdXJlcyB0aGUgc2FmZSBleGVj
dXRpb24gb2YgdGhlDQo+PiBDb3J0ZXgtTTQgZmlybXdhcmUsIHByb3RlY3RlZCBmcm9tIG90aGVy
IG1hc3RlcnMgKGUuZy4gQ29ydGV4LUE3KSB1bndhbnRlZA0KPj4gYWNjZXNzZXMuDQo+Pg0KPiBU
aGUgYWJvdmUgc3RhdGVtZW50IG1ha2VzIG1lIHdvbmRlciBpZiBDb3J0ZXgtTTQgZmlybXdhcmUg
aXMgcmVhbGx5DQo+IG5vbi1zZWN1cmUsIGlmIHNvIHdoeSBkb2VzIGl0IG5lZWQgc3VjaCBhbiBp
c29sYXRpb24gZnJvbSBvdGhlciBtYXN0ZXJzDQo+IGxpa2UgQ29ydGV4LUE3LiBGb3IgbWUgQ29y
dGV4LU00IGlzIHNlY3VyZSBhbmQgQ29ydGV4LUE3IGNhbiBleGVjdXRlDQo+IGluIG5vbi1zZWN1
cmUgaGVuY2UgQ29ydGV4LU00IG5lZWRzIHRvIGJlIGlzb2xhdGVkIGZyb20gQ29ydGV4LUE3IGFz
DQo+IG1lbnRpb25lZCBpbiB0aGUgYWJvdmUgZXhjZXJwdHMgZnJvbSB0aGUgZGF0YXNoZWV0Lg0K
Q29ydGV4LU00IGZpcm13YXJlIGlzIG5vbi1zZWN1cmUsIGl0IGNvdWxkIGJlIGEgZnJlZSBSVE9T
Lg0KRVRaUEMgZG9lc24ndCBpc29sYXRlIENvcnRleCBNNCBvciBBNyBidXQgY29udHJvbCB3aGlj
aCBvZiB0aGVtIGhhdmUgDQphY2Nlc3MgdG8gaGFyZHdhcmUgYmxvY2tzLg0KRm9yIGV4YW1wbGUg
RVRaUEMgY29udHJvbHMgaWYgTTQgb3IgQTcgY2FuIGhhdmUgYWNjZXNzIHRvIEkyQyBoYXJkd2Fy
ZSANCmJsb2Nrcy4gVGhlIGdvYWwgaXMgdG8gbWFrZSBzdXJlDQpmaXJtd2FyZSBydW5uaW5nIG9u
IGVhY2ggc2lkZSBkb24ndCB1c2UgdGhlIGhhcmR3YXJlIGJsb2NrcyBvZiB0aGUgb3RoZXIgDQpz
aWRlLg0KDQpCZW5qYW1pbg0KDQo+DQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA==
