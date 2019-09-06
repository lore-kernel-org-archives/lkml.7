Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D155C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E878520578
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GfpINObq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392800AbfIFNCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:02:17 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:49894 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfIFNCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567774935; x=1599310935;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BsL/MpON9lOcR0hZ9plTd/PmmADOU1tKuQ65tHkbvfo=;
  b=GfpINObqBPMUrX3J+wt23j0+alS1eQA27hYxqlZIj4eZFuKwZ7hgEfBt
   9B+b3emR+MA/Js9lRj4EyEay7o48JE82/aqMxaJwkUjcRnyrIBRTsd5eX
   HEz3NZ38b0+Sp0roJE5y815QmTeFrzmEHDkLWwfesU+bWosFXsoAFOQ+J
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,473,1559520000"; 
   d="scan'208";a="413929647"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Sep 2019 13:02:12 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 56569A23DF;
        Fri,  6 Sep 2019 13:02:12 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 13:02:11 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.160.20) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 13:02:09 +0000
Subject: Re: [UNVERIFIED SENDER] Re: [PATCH 1/1] KVM: inject data abort if
 instruction cannot be decoded
To:     Marc Zyngier <maz@kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>
CC:     =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
References: <20190904180736.29009-1-xypron.glpk@gmx.de>
 <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com>
 <86mufjrup7.wl-maz@kernel.org>
 <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
 <20190905092223.GC4320@e113682-lin.lund.arm.com>
 <4b6662bd-56e4-3c10-3b65-7c90828a22f9@kernel.org>
 <20190906080033.GF4320@e113682-lin.lund.arm.com>
 <a58c5f76-641a-8381-2cf3-e52d139c4236@amazon.com>
 <0a99ce2b-7700-2a2f-eb3a-4922631cbe02@kernel.org>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <9745a09c-3410-38a5-1399-24eefbed8336@amazon.com>
Date:   Fri, 6 Sep 2019 15:02:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0a99ce2b-7700-2a2f-eb3a-4922631cbe02@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.43.160.20]
X-ClientProxiedBy: EX13D07UWB002.ant.amazon.com (10.43.161.131) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwNi4wOS4xOSAxNDozNCwgTWFyYyBaeW5naWVyIHdyb3RlOgo+IE9uIDA2LzA5LzIwMTkg
MTM6MDgsIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+Pgo+Pgo+PiBPbiAwNi4wOS4xOSAxMDowMCwg
Q2hyaXN0b2ZmZXIgRGFsbCB3cm90ZToKPj4+IE9uIFRodSwgU2VwIDA1LCAyMDE5IGF0IDAyOjA5
OjE4UE0gKzAxMDAsIE1hcmMgWnluZ2llciB3cm90ZToKPiAKPiBbLi4uXQo+IAo+Pj4+PiBAQCAt
NjczLDYgKzY5NCw4IEBAIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1bihzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHN0cnVjdCBrdm1fcnVuICpydW4pCj4+Pj4+ICAgIAkJcmV0ID0ga3ZtX2hhbmRs
ZV9tbWlvX3JldHVybih2Y3B1LCB2Y3B1LT5ydW4pOwo+Pj4+PiAgICAJCWlmIChyZXQpCj4+Pj4+
ICAgIAkJCXJldHVybiByZXQ7Cj4+Pj4+ICsJfSBlbHNlIGlmIChydW4tPmV4aXRfcmVhc29uID09
IEtWTV9FWElUX0FSTV9OSVNWKSB7Cj4+Pj4+ICsJCWt2bV9pbmplY3RfdW5kZWZpbmVkKHZjcHUp
Owo+Pj4+Cj4+Pj4gSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kOiBJcyB0aGUgZXhwZWN0
YXRpb24gaGVyZSB0aGF0IHVzZXJzcGFjZQo+Pj4+IGNvdWxkIGNsZWFyIHRoZSBleGl0IHJlYXNv
biBpZiBpdCBtYW5hZ2VkIHRvIGhhbmRsZSB0aGUgZXhpdD8gQW5kCj4+Pj4gb3RoZXJ3aXNlIHdl
J2QgaW5qZWN0IGFuIFVOREVGIG9uIHJlZW50cnk/Cj4+Pj4KPj4+Cj4+PiBZZXMsIGJ1dCBJIHRo
aW5rIHdlIHNob3VsZCBjaGFuZ2UgdGhhdCB0byBhbiBleHRlcm5hbCBhYm9ydC4gIEknbGwgdGVz
dAo+Pj4gc29tZXRoaW5nIGFuZCBzZW5kIGEgcHJvcGVyIHBhdGNoIHdpdGggbW9yZSBjbGVhciBk
b2N1bWVudGF0aW9uLgo+Pgo+PiBXaHkgbm90IGxlYXZlIHRoZSBpbmplY3Rpb24gdG8gdXNlciBz
cGFjZSBpbiBhbnkgY2FzZT8gQVBJIHdpc2UgdGhlcmUgaXMKPj4gbm8gbmVlZCB0byBiZSBiYWNr
d2FyZHMgY29tcGF0aWJsZSwgYXMgd2UgcmVxdWlyZSB0aGUgQ0FQIHRvIGJlIGVuYWJsZWQsCj4+
IHJpZ2h0Pwo+Pgo+PiBJTUhPIGl0IHNob3VsZCBiZSAxMDAlIGEgcG9saWN5IGRlY2lzaW9uIGlu
IHVzZXIgc3BhY2Ugd2hldGhlciB0bwo+PiBlbXVsYXRlIGFuZCB3aGF0IHR5cGUgb2YgZXhjZXB0
aW9uIHRvIGluamVjdCwgaWYgYW55dGhpbmcuCj4gCj4gVGhlIGV4Y2VwdGlvbiBoYXMgdG8gYmUg
c29tZXRoaW5nIHRoYXQgdGhlIHRyYXBwZWQgaW5zdHJ1Y3Rpb24gY2FuCj4gYWN0dWFsbHkgZ2Vu
ZXJhdGUuIEFuIFVOREVGIGlzIGRlZmluaXRlbHkgd3JvbmcsIGFzIHRoZSBndWVzdCB3b3VsZCBo
YXZlCj4gb3RoZXJ3aXNlIFVOREVGJ2QgYXQgRUwxLCBhbmQgS1ZNIHdvdWxkIGhhdmUgbmV2ZXIg
c2VlbiBpdC4gWW91IGNhbm5vdAo+IGRldmlhdGUgZnJvbSB0aGUgcnVsZSBvZiBhcmNoaXRlY3R1
cmUsIGFuZCB1c2Vyc3BhY2UgZmVlbHMgbGlrZSB0aGUKPiB3cm9uZyBwbGFjZSB0byBlbmZvcmNl
IGl0LgoKVGhlcmUgYXJlIG11bHRpcGxlIHZpYWJsZSBvcHRpb25zIHVzZXIgc3BhY2UgaGFzOgoK
ICAgMSkgVHJpZ2dlciBhbiBleHRlcm5hbCBhYm9ydAogICAyKSBFbXVsYXRlIHRoZSBpbnN0cnVj
dGlvbiBpbiB1c2VyIHNwYWNlCiAgIDMpIEluamVjdCBhIFBWIG1lY2hhbmlzbSBpbnRvIHRoZSBn
dWVzdCB0byBlbXVsYXRlIHRoZSBpbnNuIGluc2lkZSAKZ3Vlc3Qgc3BhY2UKCldoeSBzaG91bGQg
d2UgdHJlYXQgMSkgYW55IGRpZmZlcmVudCBmcm9tIDIpIG9yIDMpPyBXaHkgaXMgdGhlcmUgYSAi
ZmFzdCAKcGF0aCIgZm9yIHRoZSBleHRlcm5hbCBhYm9ydCwgb24gYW4gZXhpdCB0aGF0IGlzIG5v
dCBwZXJmb3JtYW5jZSAKY3JpdGljYWwgb3IgaGFzIGFueSBvdGhlciByZWFzb24gdG8gZ2V0IHNw
ZWNpYWwgYXR0ZW50aW9uIGZyb20ga2VybmVsIApzcGFjZS4gQWxsIHdlJ3JlIGRvaW5nIGlzIGFk
ZCBtb3JlIGNvZGUgaW4gYSBwcml2aWxlZ2VkIGxheWVyIGZvciBhIGNhc2UgCnRoYXQgcmVhbGlz
dGljYWxseSBzaG91bGQgbmV2ZXIgb2NjdXIgaW4gdGhlIGZpcnN0IHBsYWNlLgoKCkFsZXgKCgoK
QW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgUmFsZiBI
ZXJicmljaApFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBI
UkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

