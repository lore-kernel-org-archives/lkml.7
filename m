Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB0D206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="t1VcWy0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfDZIge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:36:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39416 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfDZIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:36:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q8QqP5025247;
        Fri, 26 Apr 2019 10:36:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=+6MftkKbnbH/KW7oBBIqslz9WQNIVGXd3nOLM2QlIbU=;
 b=t1VcWy0PuheRBPWgQyg/Q0nNVI1M5hWJFgHpcbmq0srpQHx2nJ9p43JRNdWmiDaL69uM
 5JdT9ANcQZQE9etrKVXjzHSMrQCNTgXTpPlP+2CsnjFzWMxpkY85HlBomgws2t8k82w6
 9iXZIWAm1BlJmxiMeLtI5Sis5zmC93SdidOC6oJgpAop+XCDtJIjgqIvEVko5CmDoHdY
 nKYYyAfLrSfAljnWECxys1YABb+y1UqOZliWpbGpTDg0XGCv9L6h1FznHgO1x3z3EPJQ
 SYKO1YKZYnUY1FQXXHuBcOxPqfu/cthlDhzG6INJ9H+BmctsbZxDVdWMaykLyElv62EB Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxscjb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Apr 2019 10:36:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8740756;
        Fri, 26 Apr 2019 08:36:11 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2179A1490;
        Fri, 26 Apr 2019 08:36:11 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 26 Apr
 2019 10:36:10 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 26 Apr 2019 10:36:10 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Input <linux-input@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] Add of_ functions for device_link_add()
Thread-Topic: [PATCH 0/5] Add of_ functions for device_link_add()
Thread-Index: AQHU+oc1scuk0YI6LEm1fzDoT4JGLKZNDQSAgAAVewCAADz4gIAAoCSA
Date:   Fri, 26 Apr 2019 08:36:10 +0000
Message-ID: <6a026213-482b-6c82-a965-2ba8a4472928@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
 <CAL_JsqJp9f3Sv08igSyR38Z5eXnAYWMNY29U5qEGLp=r2YReRw@mail.gmail.com>
 <CAKdAkRTUsJ4TU7BrSNXCKiQGZnArao9o_qk7i0xSzYJ1SGU14A@mail.gmail.com>
 <CAL_JsqJAnaJo4uLgNaqfnNMGYO+qqLaqdEn159hMTYqYE-Afhg@mail.gmail.com>
In-Reply-To: <CAL_JsqJAnaJo4uLgNaqfnNMGYO+qqLaqdEn159hMTYqYE-Afhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ACCBD2087A7E445B63CCD27E02AF2D8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzI2LzE5IDE6MDIgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUaHUsIEFwciAy
NSwgMjAxOSBhdCAyOjI0IFBNIERtaXRyeSBUb3Jva2hvdg0KPiA8ZG1pdHJ5LnRvcm9raG92QGdt
YWlsLmNvbT4gd3JvdGU6DQo+PiBPbiBUaHUsIEFwciAyNSwgMjAxOSBhdCAxMTowOCBBTSBSb2Ig
SGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiBPbiBXZWQsIEFwciAyNCwg
MjAxOSBhdCA1OjE5IEFNIEJlbmphbWluIEdhaWduYXJkDQo+Pj4gPGJlbmphbWluLmdhaWduYXJk
QHN0LmNvbT4gd3JvdGU6DQo+Pj4+IEl0IGNvdWxkIGhhcHBlbiB0aGF0IHdlIG5lZWQgdG8gY29u
dHJvbCBzdXNwZW5kL3Jlc3VtZSBvcmRlcmluZyBiZXR3ZWVuDQo+Pj4+IGRldmljZXMgd2l0aG91
dCBvYnZpb3VzIGNvbnN1bWVyL3N1cHBsaWVyIGxpbmsuIEZvciBleGFtcGxlIHdoZW4gdG91Y2hz
Y3JlZW5zDQo+Pj4+IGFuZCBEU0kgcGFuZWxzIHNoYXJlIHRoZSBzYW1lIHJlc2V0IGxpbmUsIGlu
IHRoaXMgY2FzZSB3ZSBuZWVkIHRvIGJlIHN1cmUNCj4+Pj4gb2YgcG1fcnVudGltZSBvcGVyYXRp
b25zIG9yZGVyaW5nIGJldHdlZW4gdGhvc2UgdHdvIGRldmljZXMgdG8gY29ycmVjdGx5DQo+Pj4+
IHBlcmZvcm0gcmVzZXQuDQo+Pj4+IERTSSBwYW5lbCBhbmQgdG91Y2hzY3JlZW4gYXJlbid0IHNo
YXJpbmcgYW55IGhlcmlhY2hpY2FsIHJlbGF0aW9uc2hpcCAodW5saWtlDQo+Pj4+IEkyQyBjbGll
bnQgYW5kIEkyQyBidXMgb3IgcmVndWxhdG9yIGNsaWVudCBhbmQgcmVndWxhdG9yIHByb3ZpZGVy
KSBzbyB3ZSBuZWVkDQo+Pj4+IHRvIGRlc2NyaWJlIHRoaXMgaW4gZGV2aWNlLXRyZWUuDQo+Pj4g
TmVlZGluZyB0byBrbm93IHdoaWNoIHRvdWNoc2NyZWVuIGlzIGF0dGFjaGVkIHRvIGEgcGFuZWwg
Y291bGQgYmUNCj4+PiBpbXBvcnRhbnQgdG8gZGVzY3JpYmUgaWYgeW91IGhhdmUgbXVsdGlwbGUg
ZGlzcGxheXMuDQo+Pj4NCj4+PiBEb2Vzbid0IHRoZSByZXNldCBzdWJzeXN0ZW0gYWxyZWFkeSBo
YXZlIHNvbWUgc3VwcG9ydCBmb3Igc2hhcmVkDQo+Pj4gcmVzZXRzPyBTZWVtcyBsaWtlIGl0IGNv
dWxkIHByb3ZpZGUgY2xpZW50cyB3aXRoIHN0cnVjdCBkZXZpY2Ugb3INCj4+PiBkZXZpY2Vfbm9k
ZSBwdHJzIHRvIG90aGVyIGRldmljZXMgc2hhcmluZyBhIHJlc2V0Lg0KU2hhcmluZyByZXNldCB3
aWxsIG5vdCBoZWxwIGhlcmUgYmVjYXVzZSB3ZSBkb24ndCB3YW50IHRvIGhhdmUgdHdvIHJlc2V0
DQpvY2N1cmluZyBpbiB0aGUgc2FtZSBsaW5lIGJ1dCBvbmx5IG9uZSB3aGVuIHRoZSBib3RoIGRl
dmljZXMgYXJlIHJlc3VtZWQuDQpUaGF0IHdoeSB3ZSB0byBmb3JjZSBzdXNwZW5kL3Jlc3VtZSBv
cmRlcmluZyBhbmQgc28gYWRkIGEgbGluayBiZXR3ZWVuIHRoZQ0KZGV2aWNlcy4NCj4+Pg0KPj4+
PiBUaGlzIHNlcmllcyBpbnRyb2R1Y2Ugb2ZfZGV2aWNlX2xpbmtzX3thZGQscmVtb3ZlfSBhbmQg
ZGV2bV9vZl9kZXZpY2VfbGlua3NfYWRkKCkNCj4+Pj4gaGVscGVycyB0byBmaW5kIGFuZCBwYXJz
ZSAnbGlua3MtYWRkJyBwcm9wZXJ0eSBpbiBhIGRldmljZS10cmVlIG5vZGUuDQo+Pj4gR29pbmcg
dG8gZG9jdW1lbnQgdGhhdCBwcm9wZXJ0eSBzb21ld2hlcmU/IDopDQpJIGhhdmUgcHV0IGEgZGVz
Y3JpcHRpb24gb2YgdGhpcyBwcm9wZXJ0eSBpbiBlYWNoIGRldmljZSBiaW5kaW5ncyBidXQgaWYg
DQp5b3UgY2FuIHRlbGwgbWUNCndoZXJlIHRvIHB1dCBpdCwgSSB3aWxsIGZvbGxvdyB5b3VyIGFk
dmljZS4NCj4+Pg0KPj4+IEkgdGhpbmsgdGhpcyBpcyB0b28gZ2VuZXJpYyBhbmQgY291cGxlZCB0
byBMaW51eC4gSXQgZG9lc24ndCBoYXZlIGFueQ0KPj4+IGluZm9ybWF0aW9uIGFzIHRvIHdoYXQg
aXMgdGhlIGRlcGVuZGVuY3kgb3IgY29ubmVjdGlvbiBub3Igd2hhdCB0aGUNCj4+PiBkaXJlY3Rp
b24gb2YgdGhlIGRlcGVuZGVuY3kgaXMuDQpDb3VsZCBzb21ldGhpbmcgbGlrZSAnbGluay1zdXBw
bGllcnMnIG9yICdwbS1ydW50aW1lLWRlcGVuZGVuY2llcycNCmFyZSBtb3JlIGV4cGxpY2l0IHBy
b3BlcnR5IG5hbWUgdG8gZGVzY3JpYmUgZGlyZWN0aW9uLCBnb2FsLCBhbmQgY29ubmVjdGlvbg0K
YmV0d2VlbiBjb25zdW1lciBhbmQgc3VwcGxpZXIgPw0KPj4+DQo+Pj4gSSdtIG5vdCBjb252aW5j
ZWQgd2UgbmVlZCB0byBzb2x2ZSB0aGlzIGdlbmVyaWNhbGx5IHZzLiBkZWZpbmluZw0KPj4+IHNv
bWV0aGluZyBmb3IgdGhpcyBzcGVjaWZpYyBleGFtcGxlLg0KPj4gSSBhbSBwcmV0dHkgc3VyZSB0
aGVyZSB3aWxsIGJlIG1vcmUgZHJpdmVycyBuZWVkaW5nIGNvbXBsZXgNCj4+IGRlcGVuZGVuY2ll
cy4gRG9lc24ndCBBQ1BJIGFsbG93IGRlZmluaW5nIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGRldmlj
ZXMNCj4+IHRoYXQgZ29lcyBiZXlvbmQgdGhlIHRyZWUgc3RydWN0dXJlPw0KPiBDYW4ndCBzcGVh
ayB0byBBQ1BJLCBidXQgSSBhc3N1bWUgeW91IHdoZXJlIGltcGx5aW5nIEFDUEkgc3VwcG9ydHMN
Cj4gdGhpcyBzbyBEVCBzaG91bGQgdG9vLg0KPg0KPiBBbG1vc3QgZXZlcnkgYmluZGluZyB3ZSBo
YXZlIGlzIGRlZmluaW5nIHJlbGF0aW9uc2hpcHMgYmV0d2Vlbg0KPiBkZXZpY2VzLiBJbnRlcnJ1
cHRzLCBjbG9ja3MsIGdwaW8sIHBpbmN0cmwsIGV0Yy4gYWxsIGRvIHRoaXMuIFRvIHVzZSBhDQo+
IHNpbWlsYXIgZXhhbXBsZSB0byB0aGUgb25lIGhlcmUsIHdlIGFscmVhZHkgZGVmaW5lIHRoZSBy
ZWxhdGlvbnNoaXANCj4gYmV0d2VlbiBhIGRpc3BsYXkgYW5kIGEgYmFja2xpZ2h0IHdpdGggYSAn
YmFja2xpZ2h0JyBwcm9wZXJ0eSBpbiB0aGUNCj4gZGlzcGxheSBub2RlLiBXaHkgc2hvdWxkIHRv
dWNoc2NyZWVuIGJlIGFueSBkaWZmZXJlbnQgdGhhbiBiYWNrbGlnaHQ/DQpJdCBpcyBkaWZmZXJl
bnQgYmVjYXVzZSBpdCBpcyBvbmx5IGFib3V0IHN1c3BlbmQvcmVzdW1lIG9yZGVyaW5nLg0KVGhl
cmUgaXMgbm8gbmVlZCBmb3IgYSBwYW5lbCB0byBrbm93cyBhYm91dCB0b3VjaHNjcmVlbiB1bmxp
a2UNCnRoYW4gYmFja2xpZ2h0IHRoYXQgaXQgY291bGQgZHJpdmUuDQpJIGhhdmUgdGhlIHNhbWUg
bmVlZCB0byBvcmRlciBzdXNwZW5kL3Jlc3VtZSBvcGVyYXRpb25zIGJldHdlZW4NCkdQVSBhbmQg
ZGlzcGxheSB0byBiZSBzdXJlIHRoYXQgR1BVIGlzIHN1c3BlbmQgYmVmb3JlIGRpc3BsYXkgYW5k
IHJlc3VtZQ0KYWZ0ZXIgaXQuDQoNCj4NCj4gV2hhdCByZWFsbHkgY29uY2VybnMgbWUgaGVyZSBp
cyBmb2xrcyBqdXN0IGFkZCByZWxhdGlvbnNoaXBzIHRvDQo+ICdsaW5rcy1hZGQnIHdoaWNoIGFy
ZSBhbHJlYWR5IGNhcHR1cmVkIGluIERUIChzdWNoIGFzIGJhY2tsaWdodCkganVzdA0KPiBiZWNh
dXNlIHRoZXknbGwgZ2V0IGl0IGZvciBmcmVlIGFuZCBub3QgaGF2ZSB0byBnbyBhZGQgc3VwcG9y
dCB0bw0KPiBoYW5kbGUgZWFjaCBzcGVjaWZpYyBiaW5kaW5nLg0KSXQgd29uJ3QgYmUgZm9yIGZy
ZWUgc2luY2UgSSBkb24ndCB3YW50IHRvIHB1dCBpdCBpbiBkZXZpY2UgY29yZSBzbyBlYWNoIA0K
ZHJpdmVyDQp3aWxsIGhhdmUgdG8gYWRkIGEgY2FsbCB0byBhIGZ1bmN0aW9uIHRvIGVuYWJsZSBp
dCBhbmQgd2lsbCBoYXZlIHRvIA0KZXhwbGFpbiB3aHkgZG9pbmcgaXQuDQoNCkJlbmphbWluDQoN
Cj4NCj4gUm9i
