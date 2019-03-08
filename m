Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB54C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE8120868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCHQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:01:42 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41825 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbfCHQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:01:42 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x28G1NWs009217;
        Fri, 8 Mar 2019 17:01:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r3gx53jer-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 08 Mar 2019 17:01:22 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3EF843D;
        Fri,  8 Mar 2019 16:01:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E448C5A96;
        Fri,  8 Mar 2019 16:01:17 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 8 Mar
 2019 17:01:17 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Fri, 8 Mar 2019 17:01:17 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH] irqchip: stm32: add a second level init to request
 hwspinlock
Thread-Topic: [PATCH] irqchip: stm32: add a second level init to request
 hwspinlock
Thread-Index: AQHU1QIoQlGKLyEqVUCXZ0malJJs9aYATz+AgAFlgYCAABhNgIAACH0A
Date:   Fri, 8 Mar 2019 16:01:17 +0000
Message-ID: <18de3399-363f-e180-d078-1dfd3bb31c34@st.com>
References: <1551975829-16350-1-git-send-email-fabien.dessenne@st.com>
 <97040a1e-7a24-3d41-c3b7-43b551a70825@arm.com>
 <faef4957-0261-bcdf-32fb-4b0763298236@st.com>
 <864l8d1iz6.wl-marc.zyngier@arm.com>
In-Reply-To: <864l8d1iz6.wl-marc.zyngier@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADFACE0722FA5C4CADE91182107920F8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_14:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KDQpUaGFua3MgZm9yIHlvdXIgZGV0YWlsZWQgYW5zd2VyLg0KDQpJIHdpbGwg
c3R1ZHkgaG93IHRvIG1vdmUgdGhpcyBkcml2ZXIgdG8gYSBkZXZpY2Ugb25lLg0KDQoNCkJSDQoN
CkZhYmllbg0KDQoNCk9uIDA4LzAzLzIwMTkgNDozMCBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOg0K
PiBPbiBGcmksIDA4IE1hciAyMDE5IDE0OjAzOjU1ICswMDAwLA0KPiBGYWJpZW4gREVTU0VOTkUg
PGZhYmllbi5kZXNzZW5uZUBzdC5jb20+IHdyb3RlOg0KPg0KPiBGYWJpZW4sDQo+DQo+PiBIaSBN
YXJjLA0KPj4NCj4+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gTGV0IG1lIHRyeSB0byBl
eHBsYWluIHRoaXMgcGF0Y2gsIGFuZCB0aGUNCj4+IHJlYXNvbiBvZiBpdHMgdW51c3VhbCBpbXBs
ZW1lbnRhdGlvbiBjaG9pY2VzLg0KPj4NCj4+DQo+PiBSZWdhcmRpbmcgdGhlIGRyaXZlciBpbml0
IG1vZGU6DQo+PiBBcyBhbiBpbXBvcnRhbnQgcmVxdWlyZW1lbnQsIEkgd2FudCB0byBrZWVwIHRo
aXMgaXJxIGRyaXZlciBkZWNsYXJlZA0KPj4gd2l0aCBJUlFDSElQX0RFQ0xBUkUoKSwgc28gaXQg
aXMgaW5pdGlhbGl6ZWQgZWFybHkgZnJvbQ0KPj4gc3RhcnRfa2VybmVsKCkvaW5pdF9JUlEoKS4N
Cj4+IE1vc3Qgb2YgdGhlIG90aGVyIGlycSBkcml2ZXJzIGFyZSBpbXBsZW1lbnRlZCB0aGlzIHdh
eSBhbmQgSSBpbWFnaW5lDQo+PiB0aGF0IHRoaXMgZW5zdXJlcyB0aGUgYXZhaWxhYmlsaXR5IG9m
IHRoZSBpcnEgZHJpdmVycywgYmVmb3JlIHRoZSBvdGhlcg0KPj4gcGxhdGZvcm0gZHJpdmVycyBn
ZXQgcHJvYmVkLg0KPiBMZXQgbWUgZ2V0IHRoaXMgc3RyYWlnaHQ6DQo+DQo+IC0gRWl0aGVyIHlv
dSBkb24ndCBoYXZlIGRlcGVuZGVuY2llcyBvbiBhbnl0aGluZywgYW5kIHlvdSBuZWVkIHRvDQo+
ICAgIGVuYWJsZSB5b3VyIGlycWNoaXAgZWFybHkgLT4geW91IHVzZSBJUlFDSElQX0RFQ0xBUkUu
DQo+DQo+IC0gT3IgeW91IGhhdmUgZGVwZW5kZW5jaWVzIG9uIG90aGVyIHN1YnN5c3RlbXMgLT4g
WW91ICpkbyBub3QqIHVzZQ0KPiAgICBJUlFDSElQX0RFQ0xBUkUsIGFuZCB1c2UgdGhlIGV4cGVj
dGVkIGRlcGVuZGVuY3kgc3lzdGVtIChkZWZlcnJlZA0KPiAgICBwcm9iaW5nKQ0KPg0KPiBUaGVy
ZSBpcyBubyBpbnRlcm1lZGlhdGUgc3RhdGUuIFRoZSBvdGhlciBpcnFjaGlwIGNvbnRyb2xsZXJz
IHRoYXQgdXNlDQo+IElSUUNISVBfREVDTEFSRSAqZG8gTk9UKiBoYXZlIGRlcGVuZGVuY2llcyBv
biBleHRlcm5hbCBzdWJzeXN0ZW1zLg0KPg0KPj4gUmVnYXJkaW5nIHRoZSBzZWNvbmQgaW5pdDoN
Cj4+IFdpdGggdGhlIHVzYWdlIG9mIHRoZSBod3NwaW5sb2NrIGZyYW1ld29yayAodXNlZCB0byBw
cm90ZWN0IGFnYWluc3QNCj4+IGNvcHJvY2Vzc29yIGNvbmN1cnJlbnQgYWNjZXNzIHRvIHJlZ2lz
dGVycykgd2UgaGF2ZSBhIHByb2JsZW0gYXMgdGhlDQo+PiBod3NwaW5sb2NrIGRyaXZlciBpcyBu
b3QgYXZhaWxhYmxlIHdoZW4gdGhlIGlycSBkcml2ZXIgaXMgYmVpbmcgaW5pdGlhbGl6ZWQuDQo+
PiBJbiBvcmRlciB0byBzb2x2ZSB0aGlzLCBJIGFkZGVkIGEgc2Vjb25kIGluaXRpYWxpemF0aW9u
IHdoZXJlIHdlIGdldCBhDQo+PiByZWZlcmVuY2UgdG8gaHdzcGlubG9jay4NCj4+IFlvdSBwb2lu
dGVkIHRoYXQgd2UgYXJlIG5vdCBzdXBwb3NlZCB0byB1c2Ugb2Zfbm9kZV9jbGVhcl9mbGFnICh3
aGljaA0KPj4gYWxsb3dzIHRvIGdldCBhIHNlY29uZCBpbml0IGNhbGwpIDoNCj4+IEkgc3BlbnQg
c29tZSB0aW1lIHRvIGZpbmQgYW55IGluZm9ybWF0aW9uIGFib3V0IGl0LCBidXQgY291bGQgbm90
IGZpbmQNCj4+IGFueSByZWFzb24gdG8gbm90IHVzZSBpdC4NCj4+IFBsZWFzZSwgbGV0IG1lIGtu
b3cgaWYgSSBtaXNzZWQgc29tZXRoaW5nIGhlcmUuDQo+IFllcywgeW91IG1pc3NlZCB0aGUgZmFj
dCB0aGF0IGVhY2ggdGltZSBzb21lb25lIHRyaWVzIHRvIGFkZCBzb21lDQo+IGRyaXZlciBwcm9i
aW5nIHZpYSBhbiBpbml0Y2FsbCwgd2UgcHVzaCBiYWNrLiBUaGlzIGlzIGFuIGludGVybmFsDQo+
IGtlcm5lbCBtZWNoYW5pc20gdGhhdCBpcyBub3QgdG8gYmUgdXNlZCBieSByYW5kb20sIG5vbiBh
cmNoaXRlY3R1cmFsDQo+IGRyaXZlcnMgc3VjaCBhcyB0aGlzIGludGVycnVwdCBjb250cm9sbGVy
Lg0KPg0KPiBGdXJ0aGVybW9yZSwgeW91J3JlIHBsYXlpbmcgd2l0aCBzdHVmZiB0aGF0IGlzIG91
dHNpZGUgb2YgdGhlIGV4cG9ydGVkDQo+IEFQSSBvZiB0aGUgRFQgZnJhbWV3b3JrLiBDbGVhcmlu
ZyBub2RlIGZsYWdzIGlzIG5vdCBzb21ldGhpbmcgSSByZWFsbHkNCj4gd2FudCB0byBzZWUsIGFz
IHlvdSdyZSBtZXNzaW5nIHdpdGggYSBzdGF0ZSBtYWNoaW5lIHRoYXQgaXNuJ3QgdW5kZXINCj4g
eW91ciBjb250cm9sLg0KPg0KPj4gUmVnYXJkaW5nIHRoZSBpbml0cyBzZXF1ZW5jZSBhbmQgZGVw
ZW5kZW5jaWVzOg0KPj4gLSBUaGUgc2Vjb25kIGluaXQgaXMgZ3VhcmFudGVlZCB0byBiZSBjYWxs
ZWQgYWZ0ZXIgdGhlIGZpcnN0IG9uZSwgc2luY2UNCj4+IHN0YXJ0X2tlcm5lbCgpLT5pbml0X0lS
USgpIGlzIGNhbGxlZCBiZWZvcmUgcGxhdGZvcm0gZHJpdmVycyBpbml0Lg0KPiBUaGVyZSBpcyBu
byBzdWNoIHJlcXVpcmVtZW50cyB0aGF0IGhvbGRzIGZvciBzZWNvbmRhcnkgaW50ZXJydXB0DQo+
IGNvbnRyb2xsZXJzLg0KPg0KPj4gLSBEdXJpbmcgdGhlIHNlY29uZCBpbml0LCB0aGUgZGVwZW5k
ZW5jeSB3aXRoIHRoZSBod3NwaW5sb2NrIGRyaXZlciBpcw0KPj4gaW1wbGVtZW50ZWQgY29ycmVj
dGx5IDogaXQgbWFrZXMgdXNlIG9mIGRlZmVyZWQgcHJvYmUgd2hlbiBuZWVkZWQuDQo+IFRoZW4g
ZG8gdGhlIHJpZ2h0IHRoaW5nIGFsbCB0aGUgd2F5OiBtb3ZlIHlvdXIgZmF2b3VyaXRlIHRveSBp
cnFjaGlwDQo+IHRvIGJlaW5nIGEgcHJvcGVyIGRldmljZSBkcml2ZXIsIHVzZSB0aGUgcmlnaHQg
YWJzdHJhY3Rpb24sIGFuZCBzdG9wDQo+IHBpbGluZyB1Z2x5IGhhY2tzIG9uIHRvcCBvZiBlYWNo
IG90aGVyLiBPdGhlciBpcnFjaGlwIGRyaXZlcnMgZG8gdGhhdA0KPiBqdXN0IGZpbmUgKGFsbCBH
UElPIGlycWNoaXBzLCBmb3IgZXhhbXBsZSksIGFuZCBtb3N0IGRyaXZlcnMgYXJlDQo+IGFscmVh
ZHkgYWJsZSB0byBkZWZlciB0aGVpciBwcm9iZSByb3V0aW5lLg0KPg0KPj4gSSB1bmRlcnN0YW5k
IHRoYXQgdGhpcyBwYXRjaCBpcyAnc3VycHJpc2luZycgYnV0IEkgaG9wZSB0aGF0IG15DQo+PiBl
eHBsYW5hdGlvbnMganVzdGlmeSBpdHMgaW1wbGVtZW50YXRpb24uDQo+IFN1cnByaXNpbmcgaXMg
bm90IHRoZSB3b3JkIEknZCBoYXZlIHVzZWQuIFRoZSBleHBsYW5hdGlvbnMgZG8gbm90DQo+IGp1
c3RpZnkgYW55dGhpbmcsIGFzIGFsbCB5b3UncmUgc2F5aW5nIGlzICJpdCBpcyB0aGUgd2F5IGl0
IGlzIGJlY2F1c2UNCj4gaXQgaXMgdGhlIHdheSBpdCBpcyIuIFNvIHBsZWFzZSBmaXggeW91ciBp
cnFjaGlwIGRyaXZlciBwcm9wZXJseSwgaW4gYQ0KPiB3YXkgdGhhdCBpcyBtYWludGFpbmFibGUg
aW4gdGhlIGxvbmcgdGVybSwgdXNpbmcgdGhlIGFic3RyYWN0aW9ucyB0aGF0DQo+IGFyZSBhdmFp
bGFibGUuIElmIHN1Y2ggYWJzdHJhY3Rpb25zIGFyZSBub3QgZ29vZCBlbm91Z2gsIHBsZWFzZQ0K
PiBleHBsYWluIHdoYXQgeW91IG5lZWQgYW5kIHdlJ2xsIHdvcmsgc29tZXRoaW5nIG91dC4NCj4N
Cj4gVGhhbmtzLA0KPg0KPiAJTS4NCj4=
