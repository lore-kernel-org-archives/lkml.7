Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15694C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EAE21019
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfCHOEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:04:12 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32823 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726431AbfCHOEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:04:11 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x28DvLnv032274;
        Fri, 8 Mar 2019 15:03:58 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhknp4v4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 08 Mar 2019 15:03:58 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 567A049;
        Fri,  8 Mar 2019 14:03:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F6495743;
        Fri,  8 Mar 2019 14:03:56 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 8 Mar
 2019 15:03:55 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Fri, 8 Mar 2019 15:03:55 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH] irqchip: stm32: add a second level init to request
 hwspinlock
Thread-Topic: [PATCH] irqchip: stm32: add a second level init to request
 hwspinlock
Thread-Index: AQHU1QIoQlGKLyEqVUCXZ0malJJs9aYATz+AgAFlgYA=
Date:   Fri, 8 Mar 2019 14:03:55 +0000
Message-ID: <faef4957-0261-bcdf-32fb-4b0763298236@st.com>
References: <1551975829-16350-1-git-send-email-fabien.dessenne@st.com>
 <97040a1e-7a24-3d41-c3b7-43b551a70825@arm.com>
In-Reply-To: <97040a1e-7a24-3d41-c3b7-43b551a70825@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <74F710C22D289047BF71DC5B245F4CD8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLiBMZXQgbWUgdHJ5IHRvIGV4
cGxhaW4gdGhpcyBwYXRjaCwgYW5kIHRoZSANCnJlYXNvbiBvZiBpdHMgdW51c3VhbCBpbXBsZW1l
bnRhdGlvbiBjaG9pY2VzLg0KDQoNClJlZ2FyZGluZyB0aGUgZHJpdmVyIGluaXQgbW9kZToNCkFz
IGFuIGltcG9ydGFudCByZXF1aXJlbWVudCwgSSB3YW50IHRvIGtlZXAgdGhpcyBpcnEgZHJpdmVy
IGRlY2xhcmVkIA0Kd2l0aCBJUlFDSElQX0RFQ0xBUkUoKSwgc28gaXQgaXMgaW5pdGlhbGl6ZWQg
ZWFybHkgZnJvbSANCnN0YXJ0X2tlcm5lbCgpL2luaXRfSVJRKCkuDQpNb3N0IG9mIHRoZSBvdGhl
ciBpcnEgZHJpdmVycyBhcmUgaW1wbGVtZW50ZWQgdGhpcyB3YXkgYW5kIEkgaW1hZ2luZSANCnRo
YXQgdGhpcyBlbnN1cmVzIHRoZSBhdmFpbGFiaWxpdHkgb2YgdGhlIGlycSBkcml2ZXJzLCBiZWZv
cmUgdGhlIG90aGVyIA0KcGxhdGZvcm0gZHJpdmVycyBnZXQgcHJvYmVkLg0KDQoNCg0KUmVnYXJk
aW5nIHRoZSBzZWNvbmQgaW5pdDoNCldpdGggdGhlIHVzYWdlIG9mIHRoZSBod3NwaW5sb2NrIGZy
YW1ld29yayAodXNlZCB0byBwcm90ZWN0IGFnYWluc3QgDQpjb3Byb2Nlc3NvciBjb25jdXJyZW50
IGFjY2VzcyB0byByZWdpc3RlcnMpIHdlIGhhdmUgYSBwcm9ibGVtIGFzIHRoZSANCmh3c3Bpbmxv
Y2sgZHJpdmVyIGlzIG5vdCBhdmFpbGFibGUgd2hlbiB0aGUgaXJxIGRyaXZlciBpcyBiZWluZyBp
bml0aWFsaXplZC4NCkluIG9yZGVyIHRvIHNvbHZlIHRoaXMsIEkgYWRkZWQgYSBzZWNvbmQgaW5p
dGlhbGl6YXRpb24gd2hlcmUgd2UgZ2V0IGEgDQpyZWZlcmVuY2UgdG8gaHdzcGlubG9jay4NCllv
dSBwb2ludGVkIHRoYXQgd2UgYXJlIG5vdCBzdXBwb3NlZCB0byB1c2Ugb2Zfbm9kZV9jbGVhcl9m
bGFnICh3aGljaCANCmFsbG93cyB0byBnZXQgYSBzZWNvbmQgaW5pdCBjYWxsKSA6DQpJIHNwZW50
IHNvbWUgdGltZSB0byBmaW5kIGFueSBpbmZvcm1hdGlvbiBhYm91dCBpdCwgYnV0IGNvdWxkIG5v
dCBmaW5kIA0KYW55IHJlYXNvbiB0byBub3QgdXNlIGl0Lg0KUGxlYXNlLCBsZXQgbWUga25vdyBp
ZiBJIG1pc3NlZCBzb21ldGhpbmcgaGVyZS4NCg0KDQoNClJlZ2FyZGluZyB0aGUgaW5pdHMgc2Vx
dWVuY2UgYW5kIGRlcGVuZGVuY2llczoNCi0gVGhlIHNlY29uZCBpbml0IGlzIGd1YXJhbnRlZWQg
dG8gYmUgY2FsbGVkIGFmdGVyIHRoZSBmaXJzdCBvbmUsIHNpbmNlIA0Kc3RhcnRfa2VybmVsKCkt
PmluaXRfSVJRKCkgaXMgY2FsbGVkIGJlZm9yZSBwbGF0Zm9ybSBkcml2ZXJzIGluaXQuDQotIER1
cmluZyB0aGUgc2Vjb25kIGluaXQsIHRoZSBkZXBlbmRlbmN5IHdpdGggdGhlIGh3c3BpbmxvY2sg
ZHJpdmVyIGlzIA0KaW1wbGVtZW50ZWQgY29ycmVjdGx5IDogaXQgbWFrZXMgdXNlIG9mIGRlZmVy
ZWQgcHJvYmUgd2hlbiBuZWVkZWQuDQoNCg0KDQpJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIHBhdGNo
IGlzICdzdXJwcmlzaW5nJyBidXQgSSBob3BlIHRoYXQgbXkgDQpleHBsYW5hdGlvbnMganVzdGlm
eSBpdHMgaW1wbGVtZW50YXRpb24uDQpXYWl0aW5nIGZvciB5b3VyIGZlZWRiYWNrDQoNCkJSDQoN
CkZhYmllbg0KDQpPbiAwNy8wMy8yMDE5IDU6NDQgUE0sIE1hcmMgWnluZ2llciB3cm90ZToNCj4g
T24gMDcvMDMvMjAxOSAxNjoyMywgRmFiaWVuIERlc3Nlbm5lIHdyb3RlOg0KPj4gUmVxdWVzdGlu
ZyBod3NwaW5sb2NrLCBhdCB0aGUgZmlyc3QgdGltZSBpdCBpcyB1c2VkLCBpcyBub3QgY29ycmVj
dDoNCj4+IGluZGVlZCwgYXQgdGhhdCBtb21lbnQgd2UgYXJlIHVuZGVyIHJhd19zcGluX2xvY2tf
aXJxc2F2ZSgpIGNvbnRleHQgYW5kDQo+PiBod3NwaW5fbG9ja19yZXF1ZXN0X3NwZWNpZmljKCkg
bWF5IHNsZWVwICgiQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQNCj4+IGZyb20gaW52YWxp
ZCBjb250ZXh0IikuDQo+PiBSZXF1ZXN0aW5nIGh3c3BpbmxvY2sgZHVyaW5nIHRoZSBpbml0IChz
dG0zMipfZXh0aV9vZl9pbml0KCkpIGlzIGFsc28NCj4+IG5vdCBwb3NzaWJsZSAodGhlIGh3c3Bp
bmxvY2sgZnJhbWV3b3JrIGlzIG5vdCByZWFkeSBhdCB0aGF0IHN0YWdlIG9mIHRoZQ0KPj4ga2Vy
bmVsIGluaXQpLg0KPj4gQXMgYSBjb25zZXF1ZW5jZSwgYWRkIGEgc2Vjb25kIGxldmVsIGluaXQg
KHByb2JlZCB3aXRoIGFyY2hfaW5pdGNhbGwpDQo+PiB3aGVyZSB3ZSBjYW4gc2FmZWx5IHJlcXVl
c3QgaHdzcGlubG9jay4NCj4gTm8sIHRoaXMgaXMgZmFpcmx5IGJyb2tlbi4gWW91J3JlIHBsYXlp
bmcgd2l0aCBzdHVmZiB5b3UncmUgbm90IHN1cHBvc2VkDQo+IHRvIChPRl9QT1BVTEFURT8gcmVh
bGx5PyksIGFuZCBhZGRpbmcgaW5pdGNhbGxzIGlzIGNvbXBsZXRlbHkgdW5yZWxpYWJsZQ0KPiAo
dGhpbmdzIGRlcGVuZCBvbiB0aGUgbGluayBvcmRlciBhbmQgd2lsbCByYW5kb21seSBicmVhayku
DQo+DQo+IElmIHlvdSBuZWVkIGRlcGVuZGVuY2llcywgaW1wbGVtZW50IHRoZW0gY29ycmVjdGx5
LiBUdXJuIHRoaXMgZHJpdmVyDQo+IGludG8gYSByZWFsIGRldmljZSBkcml2ZXIgKGluIHRoZSBw
bGF0Zm9ybSBkZXZpY2Ugc2Vuc2UpLCBhbmQgcmV0dXJuDQo+IFBST0JFX0RFRkVSIHdoZW4geW91
IGNhbid0IGZpbmQgeW91ciBkZXBlbmRlbmN5Lg0KPg0KPiBUaGFua3MsDQo+DQo+IAlNLg==
