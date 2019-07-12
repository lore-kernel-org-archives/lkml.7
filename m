Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FB4C742B0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04346216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FahXqdBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfGLJAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:00:11 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:35650 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfGLJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562922010; x=1594458010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=OoeXV66HMCiCE8///mVVeViK+QsNj7YHb5Peo1lavf4=;
  b=FahXqdBHLx9pfa3CMlHYIcIpbVSIgfxshXw5QkJQrtsUHJYbnR8ivrXN
   EwSdIsPGMUbrtFQkhWkp6hmb2/+xQu1IHGMoC7YHOkR2+2pLsxdqZ3bKr
   bTSW0sd5/DCuDzIbZ3/iqYMfJN/HyVOvomNofHqDbPQdJ1Q+XWQRDadoW
   E=;
X-IronPort-AV: E=Sophos;i="5.62,481,1554768000"; 
   d="scan'208";a="404652279"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Jul 2019 09:00:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id B7E54141902;
        Fri, 12 Jul 2019 09:00:01 +0000 (UTC)
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 09:00:00 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB002.ant.amazon.com (10.43.166.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 08:59:59 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 12 Jul 2019 08:59:59 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "info@metux.net" <info@metux.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] arm: Extend the check for RAM in /dev/mem
Thread-Topic: [PATCH] arm: Extend the check for RAM in /dev/mem
Thread-Index: AQHVODcIGfDHKrKqiE2jyO8cjDhCoqbGRNqAgAAGCACAAGPzAIAAARkA
Date:   Fri, 12 Jul 2019 08:59:59 +0000
Message-ID: <1562921998.1345.15.camel@amazon.de>
References: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
         <14f02e29-77b2-29d9-a9f4-7f89ad0194f6@arm.com>
         <1562900298.1345.12.camel@amazon.de>
         <20190712085602.v2tncu5tsngtvbww@shell.armlinux.org.uk>
In-Reply-To: <20190712085602.v2tncu5tsngtvbww@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.55]
Content-Type: text/plain; charset="utf-8"
Content-ID: <95EBDE33927643488B6CA975A983494F@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDA5OjU2ICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4gd3JvdGU6DQo+IE9uIEZyaSwgSnVsIDEyLCAyMDE5IGF0IDAyOjU4OjE4QU0gKzAw
MDAsIFJhc2xhbiwgS2FyaW1BbGxhaCB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIDIwMTktMDct
MTIgYXQgMDg6MDYgKzA1MzAsIEFuc2h1bWFuIEtoYW5kdWFsIHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiANCj4gPiA+IE9uIDA3LzEyLzIwMTkgMDM6NTEgQU0sIEthcmltQWxsYWggQWhtZWQgd3JvdGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gU29tZSB2YWxpZCBSQU0gY2FuIGxpdmUgb3V0
c2lkZSBrZXJuZWwgY29udHJvbCAoZS5nLiB1c2luZyBtZW09IGtlcm5lbA0KPiA+ID4gPiBjb21t
YW5kLWxpbmUpLiBGb3IgdGhlc2UgcmVnaW9ucywgcGZuX3ZhbGlkIHdvdWxkIHJldHVybiAiZmFs
c2UiIGNhdXNpbmcNCj4gPiA+ID4gc3lzdGVtIFJBTSB0byBiZSBtYXBwZWQgYXMgdW5jYWNoZWQu
IFVzZSBtZW1ibG9jayBpbnN0ZWFkIHRvIGlkZW50aWZ5IFJBTS4NCj4gPiA+IA0KPiA+ID4gT25j
ZSB0aGUgcmVtYWluaW5nIG1lbW9yeSBpcyBvdXRzaWRlIG9mIHRoZSBrZXJuZWwgKGFzIHRoZSBh
ZG1pbiB3b3VsZCBoYXZlDQo+ID4gPiBpbnRlbmRlZCB3aXRoIG1lbT0gY29tbWFuZCBsaW5lKSB3
aGF0IGlzIHRoZSBwYXJ0aWN1bGFyIGNvbmNlcm4gcmVnYXJkaW5nDQo+ID4gPiB0aGUgd2F5IHRo
b3NlIGdldCBtYXBwZWQgKGNhY2hlZCBvciBub3QpID8gSXQgaXMgbm90IHRvIGJlIHVzZWQgYW55
IHdheS4NCj4gPiANCj4gPiBUaGV5IGNhbiBiZSB1c2VkIGJ5IHVzZXItc3BhY2Ugd2hpY2ggbWln
aHQgbGVhZCB0byB0aGVtIGJlaW5nIHVzZWQgYnkgdGhlwqANCj4gPiBrZXJuZWwuIE9uZSB1c2Ut
Y2FzZSB3b3VsZCBiZSB1c2luZyB0aGVtIGFzIGd1ZXN0IG1lbW9yeSBmb3IgS1ZNIGFzIEkgZGV0
YWlsZWTCoA0KPiA+IGhlcmU6DQo+ID4gDQo+ID4gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzc3
ODI0MC8NCj4gDQo+IEZyb20gdGhlIDMyLWJpdCBBUk0gcG9pbnQgb2Ygdmlldy4uLg0KPiANCj4g
V2hhdCBpZiBzb21lb25lJ3MgYWxyZWFkeSBkb2luZyBzb21ldGhpbmcgc2ltaWxhciB3aXRoIGEg
bm9uLWNvaGVyZW50DQo+IERTUCBhbmQgaXMgcmVseWluZyBvbiB0aGUgY3VycmVudCBiZWhhdmlv
dXI/ICBUaGlzIGNoYW5nZSBpcyBhIHVzZXINCj4gdmlzaWJsZSBiZWhhdmlvdXJhbCBjaGFuZ2Ug
dGhhdCBjb3VsZCBlbmQgdXAgYnJlYWtpbmcgdXNlcnNwYWNlLg0KPiANCj4gSW4gb3RoZXIgd29y
ZHMsIGl0IGlzbid0IHNvbWV0aGluZyB3ZSBzaG91bGQgcnVzaCBpbnRvLg0KDQpZZXMsIHRoYXQg
bWFrZXMgc2Vuc2UuIEhvdyBhYm91dCBhZGRpbmcgYSBjb21tYW5kLWxpbmUgb3B0aW9uIGZvciB0
aGlzIG5ld8KgDQpiZWhhdmlvciBpbnN0ZWFkPyBXb3VsZCB0aGlzIGJlIG1vcmUgcmVhc29uYWJs
ZT8KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4g
MzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwg
UmFsZiBIZXJicmljaApFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1
bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

