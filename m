Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBFFC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952B218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0viGfEoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbfDYHWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:22:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10338 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbfDYHWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:22:20 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P7BMwN000697;
        Thu, 25 Apr 2019 09:22:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=9Orgf7dALebuw4TSrE6igAWB/4j71nfutNVZIf3ODuw=;
 b=0viGfEoDb7jincEXkrwdXZmTd58BC7uXkbGTuZPSh+gT2u5ck0sHsrfo/nyf5bP6vev5
 5VwNUZZjgtSFw6MM6bPVFu1wp1M5e1v/17WIRZBRYIMwBTFQRh8mQjbXWZJCCRAe37uH
 KdR7Cq684IlXoNdW/uz8C4xQi/Bllbxx55NhHVx7BDR8RXQRcJ122Jfo1kFzTbSTxwlI
 ii2IojMlV+tTL9wGwkt/M6tMJT0YLnjrVfWKKKh+SgprofZUUMVAnax7e/rohSciQPPy
 joNE/RakRGNN7mFDVn224FFSxmqNci+bgQBIVr7prP+G+feRv4XsT6DeMed/RmwJAh3R YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxj1cj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 09:22:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 980C584;
        Thu, 25 Apr 2019 07:22:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55ABF13F0;
        Thu, 25 Apr 2019 07:22:04 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 25 Apr
 2019 09:22:04 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 25 Apr 2019 09:22:03 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "Yannick FERTRE" <yannick.fertre@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH 3/5] input: edt-ft5x06 - Call devm_of_device_links_add()
 to create links
Thread-Topic: [PATCH 3/5] input: edt-ft5x06 - Call devm_of_device_links_add()
 to create links
Thread-Index: AQHU+oc7nl11mE/LSEGo9ROeX/giu6ZLyjuAgACOWIA=
Date:   Thu, 25 Apr 2019 07:22:03 +0000
Message-ID: <769d2c1e-8a33-d4fe-a3d9-6de4772b67d4@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
 <20190424101913.1534-4-benjamin.gaignard@st.com>
 <20190424225235.GA225055@dtor-ws>
In-Reply-To: <20190424225235.GA225055@dtor-ws>
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
Content-ID: <FFB026A3F1B8D5459817496E3480153C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzI1LzE5IDEyOjUyIEFNLCBEbWl0cnkgVG9yb2tob3Ygd3JvdGU6DQo+IEhpIEJlbmph
bWluLA0KPg0KPiBPbiBXZWQsIEFwciAyNCwgMjAxOSBhdCAxMjoxOToxMVBNICswMjAwLCBCZW5q
YW1pbiBHYWlnbmFyZCB3cm90ZToNCj4+IEZyb206IFlhbm5pY2sgRmVydHLDg8KpIDx5YW5uaWNr
LmZlcnRyZUBzdC5jb20+DQo+Pg0KPj4gQWRkIGEgY2FsbCB0byBkZXZtX29mX2RldmljZV9saW5r
c19hZGQoKSB0byBjcmVhdGUgbGlua3Mgd2l0aCBzdXBwbGllcnMNCj4+IGF0IHByb2JlIHRpbWUu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFubmljayBGZXJ0csOpIDx5YW5uaWNrLmZlcnRyZUBz
dC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2Fp
Z25hcmRAc3QuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZWR0
LWZ0NXgwNi5jIHwgMiArKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZWR0LWZ0NXgwNi5j
IGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9lZHQtZnQ1eDA2LmMNCj4+IGluZGV4IDcwMmJm
ZGE3ZWU3Ny4uYWM5ZjdlODVlZmIwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbnB1dC90b3Vj
aHNjcmVlbi9lZHQtZnQ1eDA2LmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4v
ZWR0LWZ0NXgwNi5jDQo+PiBAQCAtMTE2Nyw2ICsxMTY3LDggQEAgc3RhdGljIGludCBlZHRfZnQ1
eDA2X3RzX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+PiAgIA0KPj4gICAJaTJj
X3NldF9jbGllbnRkYXRhKGNsaWVudCwgdHNkYXRhKTsNCj4+ICAgDQo+PiArCWRldm1fb2ZfZGV2
aWNlX2xpbmtzX2FkZCgmY2xpZW50LT5kZXYpOw0KPj4gKw0KPiBUaGlzIHNlZW1zIHByZXR0eSBn
ZW5lcmljIGFjdGlvbiBhbmQgSSBiZWxpZXZlIGl0IHNob3VsZCBiZSBkb25lIGluDQo+IGdlbmVy
aWMgY29kZSwgZWl0aGVyIGJ1cyAoaTJjLCBzcGksIGV0YyksIG9yIGluIGRldmljZSBjb3JlLg0K
SXQgaXMgZG9uZSAob3IgY291bGQgYmUgZG9uZSkgaW4gbW9zdCBvZiB0aGUgYnVzZXMgb3IgZnJh
bWV3b3JrIChsaWtlIA0KZm9yIHJlZ3VsYXRvcikNCmJ1dCBJIHRoaW5rIHRoYXQgYWRkaW5nIGl0
IGluIGRldmljZSBjb3JlIGFkZCBhIGRldmljZS10cmVlIG5vZGUgcGFyc2luZyANCmZvciBhbGwg
dGhlDQpkcml2ZXJzIHdoaWxlIG9ubHkgYSBmZXcgb2YgdGhlbSB3aWxsIHJlYWxseSBuZWVkIHRo
aXMgZmVhdHVyZS4gVGhhdCB3aHkgDQpJIGhhdmUgcHV0IHRoZQ0KY2FsbCBoZXJlLg0KDQpCZW5q
YW1pbg0KPg0KPiBUaGFua3MuDQo+
