Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC8C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C554D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="O3wWqBLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfHEItF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:49:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45128 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727158AbfHEItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:49:04 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x758atno025763;
        Mon, 5 Aug 2019 10:48:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=f3ijeXQ1vaJ8D+q8FKJiBffQoyjrbScy2wkKDFxrN6Y=;
 b=O3wWqBLZohLLX/xjh26dFqUF20f5CrTIzdbdXFds138EQlSuIZyF9N943uwUbCRQwigR
 kuP9awZokTZSCAuypE/a8wpa+Inpn6QV1+zfpL9OXcoPD6FtBELTArOT5yj9SJI9poqY
 hwAUfsu6uTIGQ5b0oD3wyYwd1Ghqls1q3/LUXDSmhZswEIhVvl4BA/7b7IwzsYjPRThl
 4w8qUXVvtQFDtMRxC5te+9++VCbuDiLSpCgUnUr11yoh1od5L1Y3zCnL8YqgVODOo0lC
 xaXAjr+pE46VpU4wRetAwC/TylRMXW7VNbZlsf9zmOKsEMl9X664537z0P2fuwZEfm0t uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u515maagr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 05 Aug 2019 10:48:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43A7931;
        Mon,  5 Aug 2019 08:48:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F31A82D6013;
        Mon,  5 Aug 2019 10:48:44 +0200 (CEST)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 5 Aug
 2019 10:48:44 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Mon, 5 Aug 2019 10:48:44 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH 0/6] hwspinlock: allow sharing of hwspinlocks
Thread-Topic: [PATCH 0/6] hwspinlock: allow sharing of hwspinlocks
Thread-Index: AQHU2bSOZtnkIyxqbUq77/gp1YrMkqbnZZ+AgAWakoA=
Date:   Mon, 5 Aug 2019 08:48:44 +0000
Message-ID: <1a057176-81ab-e302-4375-2717ceef6924@st.com>
References: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
 <20190801191403.GA7234@tuxbook-pro>
In-Reply-To: <20190801191403.GA7234@tuxbook-pro>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD42D37166C1054EAD8F83598A26246D@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwMS8wOC8yMDE5IDk6MTQgUE0sIEJqb3JuIEFuZGVyc3NvbiB3cm90ZToNCj4gT24gV2Vk
IDEzIE1hciAwODo1MCBQRFQgMjAxOSwgRmFiaWVuIERlc3Nlbm5lIHdyb3RlOg0KPg0KPj4gVGhl
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZG9lcyBub3QgYWxsb3cgdHdvIGRpZmZlcmVudCBkZXZp
Y2VzIHRvIHVzZQ0KPj4gYSBjb21tb24gaHdzcGlubG9jay4gVGhpcyBwYXRjaCBzZXQgcHJvcG9z
ZXMgdG8gaGF2ZSwgYXMgYW4gb3B0aW9uLCBzb21lDQo+PiBod3NwaW5sb2NrcyBzaGFyZWQgYmV0
d2VlbiBzZXZlcmFsIHVzZXJzLg0KPj4NCj4+IEJlbG93IGlzIGFuIGV4YW1wbGUgdGhhdCBleHBs
YWluIHRoZSBuZWVkIGZvciB0aGlzOg0KPj4gCWV4dGk6IGludGVycnVwdC1jb250cm9sbGVyQDUw
MDBkMDAwIHsNCj4+IAkJY29tcGF0aWJsZSA9ICJzdCxzdG0zMm1wMS1leHRpIiwgInN5c2NvbiI7
DQo+PiAJCWludGVycnVwdC1jb250cm9sbGVyOw0KPj4gCQkjaW50ZXJydXB0LWNlbGxzID0gPDI+
Ow0KPj4gCQlyZWcgPSA8MHg1MDAwZDAwMCAweDQwMD47DQo+PiAJCWh3bG9ja3MgPSA8JmhzZW0g
MT47DQo+PiAJfTsNCj4+IFRoZSB0d28gZHJpdmVycyAoc3RtMzJtcDEtZXh0aSBhbmQgc3lzY29u
KSByZWZlciB0byB0aGUgc2FtZSBod2xvY2suDQo+PiBXaXRoIHRoZSBjdXJyZW50IGh3c3Bpbmxv
Y2sgaW1wbGVtZW50YXRpb24sIG9ubHkgdGhlIGZpcnN0IGRyaXZlciBzdWNjZWVkcw0KPj4gaW4g
cmVxdWVzdGluZyAoaHdzcGluX2xvY2tfcmVxdWVzdF9zcGVjaWZpYykgdGhlIGh3bG9jay4gVGhl
IHNlY29uZCByZXF1ZXN0DQo+PiBmYWlscy4NCj4+DQo+Pg0KPj4gVGhlIHByb3Bvc2VkIGFwcHJv
YWNoIGRvZXMgbm90IG1vZGlmeSB0aGUgQVBJLCBidXQgZXh0ZW5kcyB0aGUgRFQgJ2h3bG9ja3Mn
DQo+PiBwcm9wZXJ0eSB3aXRoIGEgc2Vjb25kIG9wdGlvbmFsIHBhcmFtZXRlciAodGhlIGZpcnN0
IG9uZSBpZGVudGlmaWVzIGFuDQo+PiBod2xvY2spIHRoYXQgc3BlY2lmaWVzIHdoZXRoZXIgYW4g
aHdsb2NrIGlzIHJlcXVlc3RlZCBmb3IgZXhjbHVzaXZlIHVzYWdlDQo+PiAoY3VycmVudCBiZWhh
dmlvcikgb3IgY2FuIGJlIHNoYXJlZCBiZXR3ZWVuIHNldmVyYWwgdXNlcnMuDQo+PiBFeGFtcGxl
czoNCj4+IAlod2xvY2tzID0gPCZoc2VtIDg+OwlSZWYgdG8gaHdsb2NrICM4IGZvciBleGNsdXNp
dmUgdXNhZ2UNCj4+IAlod2xvY2tzID0gPCZoc2VtIDggMD47CVJlZiB0byBod2xvY2sgIzggZm9y
IGV4Y2x1c2l2ZSAoMCkgdXNhZ2UNCj4+IAlod2xvY2tzID0gPCZoc2VtIDggMT47CVJlZiB0byBo
d2xvY2sgIzggZm9yIHNoYXJlZCAoMSkgdXNhZ2UNCj4+DQo+PiBBcyBhIGNvbnN0cmFpbnQsIHRo
ZSAjaHdsb2NrLWNlbGxzIHZhbHVlIG11c3QgYmUgMSBvciAyLg0KPj4gSW4gdGhlIGN1cnJlbnQg
aW1wbGVtZW50YXRpb24sIHRoaXMgY2FuIGhhdmUgdGhlb3JpY2FsbHkgYW55IHZhbHVlIGJ1dDoN
Cj4+IC0gYWxsIG9mIHRoZSBleGlzaXRpbmcgZHJpdmVycyB1c2UgdGhlIHNhbWUgdmFsdWUgOiAx
Lg0KPj4gLSB0aGUgZnJhbWV3b3JrIHN1cHBvcnRzIG9ubHkgb25lIHZhbHVlIDogMSAoc2VlIGlt
cGxlbWVudGF0aW9uIG9mDQo+PiAgICBvZl9od3NwaW5fbG9ja19zaW1wbGVfeGxhdGUoKSkNCj4+
IEhlbmNlLCBpdCBzaGFsbCBub3QgYmUgYSBwcm9ibGVtIHRvIHJlc3RyaWN0IHRoaXMgdmFsdWUg
dG8gMSBvciAyIHNpbmNlDQo+PiBpdCB3b24ndCBicmVhayBhbnkgZHJpdmVyLg0KPj4NCj4gSGkg
RmFiaWVuLA0KPg0KPiBZb3VyIHNlcmllcyBsb29rcyBnb29kLCBidXQgaXQgbWFrZXMgbWUgd29u
ZGVyIHdoeSB0aGUgaGFyZHdhcmUgbG9ja3MNCj4gc2hvdWxkIGJlIGFuIGV4Y2x1c2l2ZSByZXNv
dXJjZS4NCj4NCj4gSG93IGFib3V0IGp1c3QgbWFraW5nIGFsbCAoc3BlY2lmaWMpIGxvY2tzIHNo
YXJlZD8NCg0KSGkgQmpvcm4sDQoNCk1ha2luZyBhbGwgbG9ja3Mgc2hhcmVkIGlzIGEgcG9zc2li
bGUgaW1wbGVtZW50YXRpb24gKG15IGZpcnN0IA0KaW1wbGVtZW50YXRpb24NCndhcyBnb2luZyB0
aGlzIHdheSkgYnV0IHRoZXJlIGFyZSBzb21lIGRyYXdiYWNrcyB3ZSBtdXN0IGJlIGF3YXJlIG9m
Og0KDQpBLyBUaGlzIHRoZW9yZXRpY2FsbHkgYnJlYWsgdGhlIGxlZ2FjeSBiZWhhdmlvciAodGhl
IGxlZ2FjeSB3b3JrcyB3aXRoDQpleGNsdXNpdmUgKFVOVVNFRCByYWRpeCB0YWcpIHVzYWdlKS4g
QXMgYSBjb25zZXF1ZW5jZSwgYW4gZXhpc3RpbmcgZHJpdmVyDQp0aGF0IGlzIGN1cnJlbnRseSBm
YWlsaW5nIHRvIHJlcXVlc3QgYSBsb2NrIChhbHJlYWR5IGNsYWltZWQgYnkgYW5vdGhlcg0KdXNl
cikgd291bGQgbm93IHdvcmsgZmluZS4gTm90IHN1cmUgdGhhdCB0aGVyZSBhcmUgc3VjaCBkcml2
ZXJzLCBzbyB0aGlzDQpwb2ludCBpcyBwcm9iYWJseSBub3QgYSByZWFsIGlzc3VlLg0KDQpCLyBU
aGlzIHdvdWxkIGludHJvZHVjZSBzb21lIGluY29uc2lzdGVuY3kgYmV0d2VlbiB0aGUgdHdvICdy
ZXF1ZXN0JyBBUEkNCndoaWNoIGFyZSBod3NwaW5fbG9ja19yZXF1ZXN0KCkgYW5kIGh3c3Bpbl9s
b2NrX3JlcXVlc3Rfc3BlY2lmaWMoKS4NCmh3c3Bpbl9sb2NrX3JlcXVlc3QoKSBsb29rcyBmb3Ig
YW4gdW51c2VkIGxvY2ssIHNvIHJlcXVlc3RzIGZvciBhbiBleGNsdXNpdmUNCnVzYWdlLiBPbiB0
aGUgb3RoZXIgc2lkZSwgcmVxdWVzdF9zcGVjaWZpYygpIHdvdWxkIHJlcXVlc3Qgc2hhcmVkIGxv
Y2tzLg0KV29yc3QgdGhlIGZvbGxvd2luZyBzZXF1ZW5jZSBjYW4gdHJhbnNmb3JtIGFuIGV4Y2x1
c2l2ZSB1c2FnZSBpbnRvIGEgc2hhcmVkDQoNCm9uZToNCiDCoCAtaHdzcGluX2xvY2tfcmVxdWVz
dCgpIC0+IHJldHVybnMgSWQjMCAoZXhjbHVzaXZlKQ0KIMKgIC1od3NwaW5fbG9ja19yZXF1ZXN0
KCkgLT4gcmV0dXJucyBJZCMxIChleGNsdXNpdmUpDQogwqAgLWh3c3Bpbl9sb2NrX3JlcXVlc3Rf
c3BlY2lmaWMoMCkgLT4gcmV0dXJucyBJZCMwIGFuZCBtYWtlcyBJZCMwIHNoYXJlZA0KSG9uZXN0
bHkgSSBhbSBub3Qgc3VyZSB0aGF0IHRoaXMgaXMgYSByZWFsIGlzc3VlLCBidXQgaXQncyBiZXR0
ZXIgdG8gaGF2ZSBpdA0KaW4gbWluZCBiZWZvcmUgd2UgdGFrZSBheSBkZWNpc2lvbg0KSSBjb3Vs
ZCBub3QgZmluZCBhbnkgZHJpdmVyIHVzaW5nIHRoZSBod3NwaW5fbG9ja19yZXF1ZXN0KCkgQVBJ
LCB3ZSBtYXkgDQpkZWNpZGUNCnRvIHJlbW92ZSAob3IgdG8gbWFrZSBkZXByZWNhdGVkKSB0aGlz
IEFQSSwgaGF2aW5nIGV2ZXJ5dGhpbmcgJ3NoYXJlZCANCndpdGhvdXQNCmFueSBjb25kaXRpb25z
Jy4NCg0KDQpJIGNhbiBzZWUgdGhyZWUgb3B0aW9uczoNCjEtIEtlZXAgbXkgaW5pdGlhbCBwcm9w
b3NpdGlvbg0KMi0gSGF2ZSBod3NwaW5fbG9ja19yZXF1ZXN0X3NwZWNpZmljKCkgdXNpbmcgc2hh
cmVkIGxvY2tzIGFuZA0KIMKgwqAgaHdzcGluX2xvY2tfcmVxdWVzdCgpIHVzaW5nIHVudXNlZCAo
c28gJ2luaXRpYWxseScgZXhjbHVzaXZlKSBsb2Nrcy4NCjMtIEhhdmUgaHdzcGluX2xvY2tfcmVx
dWVzdF9zcGVjaWZpYygpIHVzaW5nIHNoYXJlZCBsb2NrcyBhbmQNCiDCoMKgIHJlbW92ZS9tYWtl
IGRlcHJlY2F0ZWQgaHdzcGluX2xvY2tfcmVxdWVzdCgpLg0KDQpKdXN0IGxldCBtZSBrbm93IHdo
YXQgaXMgeW91ciBwcmVmZXJlbmNlLg0KDQpCUg0KDQpGYWJpZW4NCg0KPg0KPiBSZWdhcmRzLA0K
PiBCam9ybg0KPg0KPj4gRmFiaWVuIERlc3Nlbm5lICg2KToNCj4+ICAgIGR0LWJpbmRpbmdzOiBo
d2xvY2s6IGFkZCBzdXBwb3J0IG9mIHNoYXJlZCBsb2Nrcw0KPj4gICAgaHdzcGlubG9jazogYWxs
b3cgc2hhcmluZyBvZiBod3NwaW5sb2Nrcw0KPj4gICAgZHQtYmluZGluZ3M6IGh3bG9jazogdXBk
YXRlIFNUTTMyICNod2xvY2stY2VsbHMgdmFsdWUNCj4+ICAgIEFSTTogZHRzOiBzdG0zMjogQWRk
IGh3c3BpbmxvY2sgbm9kZSBmb3Igc3RtMzJtcDE1NyBTb0MNCj4+ICAgIEFSTTogZHRzOiBzdG0z
MjogQWRkIGh3bG9jayBmb3IgaXJxY2hpcCBvbiBzdG0zMm1wMTU3DQo+PiAgICBBUk06IGR0czog
c3RtMzI6IGh3bG9ja3MgZm9yIEdQSU8gZm9yIHN0bTMybXAxNTcNCj4+DQo+PiAgIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2h3bG9jay9od2xvY2sudHh0ICAgICAgICAgIHwgMjcgKysrKystLQ0K
Pj4gICAuLi4vYmluZGluZ3MvaHdsb2NrL3N0LHN0bTMyLWh3c3BpbmxvY2sudHh0ICAgICAgICB8
ICA2ICstDQo+PiAgIERvY3VtZW50YXRpb24vaHdzcGlubG9jay50eHQgICAgICAgICAgICAgICAg
ICAgICAgIHwgMTAgKystDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTctcGluY3Ry
bC5kdHNpICAgICAgICAgIHwgIDIgKw0KPj4gICBhcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3
Yy5kdHNpICAgICAgICAgICAgICAgICB8IDEwICsrKw0KPj4gICBkcml2ZXJzL2h3c3BpbmxvY2sv
aHdzcGlubG9ja19jb3JlLmMgICAgICAgICAgICAgICB8IDgyICsrKysrKysrKysrKysrKysrLS0t
LS0NCj4+ICAgZHJpdmVycy9od3NwaW5sb2NrL2h3c3BpbmxvY2tfaW50ZXJuYWwuaCAgICAgICAg
ICAgfCAgMiArDQo+PiAgIDcgZmlsZXMgY2hhbmdlZCwgMTA4IGluc2VydGlvbnMoKyksIDMxIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IC0tIA0KPj4gMi43LjQNCj4+
