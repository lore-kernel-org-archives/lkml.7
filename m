Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31256C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC238206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mshFRFH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393223AbfIFNQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:16:20 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:47359 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388106AbfIFNQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567775776; x=1599311776;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Z+c/2/FP7SqLIVegXjm3Q/SIZ39g6Irm8z2g2XMogZ4=;
  b=mshFRFH/MPI90TUYf0FXOuQ+IuW04Ia0kxDOPJcX2HlBQBo87+cq3rbQ
   s7bnMYFykBoq6ICKk2ftC7ujOtn10tftLTeFHXSpKh+7SENhc4aNh72gR
   CczTJ8hzOyRg+CQCDT8BVmACcSpWqI/7I5nRSR3rNFygFsrJ9UtNGkZsp
   4=;
X-IronPort-AV: E=Sophos;i="5.64,473,1559520000"; 
   d="scan'208";a="749382019"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 06 Sep 2019 13:16:14 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id AE2F7A2CCE;
        Fri,  6 Sep 2019 13:16:12 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 13:16:11 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.160.149) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 13:16:09 +0000
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
To:     Christoffer Dall <christoffer.dall@arm.com>
CC:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        "lkml - Kernel Mailing List" <linux-kernel@vger.kernel.org>,
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
 <20190906131252.GG4320@e113682-lin.lund.arm.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <fbb6f068-a0eb-6ca8-d922-a7627243e230@amazon.com>
Date:   Fri, 6 Sep 2019 15:16:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906131252.GG4320@e113682-lin.lund.arm.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.149]
X-ClientProxiedBy: EX13D18UWC001.ant.amazon.com (10.43.162.105) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwNi4wOS4xOSAxNToxMiwgQ2hyaXN0b2ZmZXIgRGFsbCB3cm90ZToKPiBPbiBGcmksIFNl
cCAwNiwgMjAxOSBhdCAwMjowODoxNVBNICswMjAwLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToKPj4K
Pj4KPj4gT24gMDYuMDkuMTkgMTA6MDAsIENocmlzdG9mZmVyIERhbGwgd3JvdGU6Cj4+PiBPbiBU
aHUsIFNlcCAwNSwgMjAxOSBhdCAwMjowOToxOFBNICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6
Cj4+Pj4gT24gMDUvMDkvMjAxOSAxMDoyMiwgQ2hyaXN0b2ZmZXIgRGFsbCB3cm90ZToKPj4+Pj4g
T24gVGh1LCBTZXAgMDUsIDIwMTkgYXQgMDk6NTY6NDRBTSArMDEwMCwgUGV0ZXIgTWF5ZGVsbCB3
cm90ZToKPj4+Pj4+IE9uIFRodSwgNSBTZXAgMjAxOSBhdCAwOTo1MiwgTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4gd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+PiBPbiBUaHUsIDA1IFNlcCAyMDE5
IDA5OjE2OjU0ICswMTAwLAo+Pj4+Pj4+IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZz4gd3JvdGU6Cj4+Pj4+Pj4+IFRoaXMgaXMgdHJ1ZSwgYnV0IHRoZSBwcm9ibGVtIGlz
IHRoYXQgYmFyZmluZyBvdXQgdG8gdXNlcnNwYWNlCj4+Pj4+Pj4+IG1ha2VzIGl0IGhhcmRlciB0
byBkZWJ1ZyB0aGUgZ3Vlc3QgYmVjYXVzZSBpdCBtZWFucyB0aGF0Cj4+Pj4+Pj4+IHRoZSBWTSBp
cyBpbW1lZGlhdGVseSBkZXN0cm95ZWQsIHdoZXJlYXMgQUlVSSBpZiB3ZQo+Pj4+Pj4+PiBpbmpl
Y3Qgc29tZSBraW5kIG9mIGV4Y2VwdGlvbiB0aGVuIChhc3N1bWluZyB5b3UncmUgc2V0IHVwCj4+
Pj4+Pj4+IHRvIGRvIGtlcm5lbC1kZWJ1ZyB2aWEgZ2Ric3R1YikgeW91IGNhbiBhY3R1YWxseSBl
eGFtaW5lCj4+Pj4+Pj4+IHRoZSBvZmZlbmRpbmcgZ3Vlc3QgY29kZSB3aXRoIGEgZGVidWdnZXIg
YmVjYXVzZSBhdCBsZWFzdAo+Pj4+Pj4+PiB5b3VyIFZNIGlzIHN0aWxsIGFyb3VuZCB0byBpbnNw
ZWN0Li4uCj4+Pj4+Pj4KPj4+Pj4+PiBUbyBDaHJpc3RvZmZlcidzIHBvaW50LCBJIGZpbmQgdGhl
IGJlbmVmaXQgYSBiaXQgZHViaW91cy4gWWVzLCB5b3UgZ2V0Cj4+Pj4+Pj4gYW4gZXhjZXB0aW9u
LCBidXQgdGhlIGluc3RydWN0aW9uIHRoYXQgY2F1c2VkIGl0IG1heSBiZSBjb21wbGV0ZWx5Cj4+
Pj4+Pj4gbGVnYWwgKHN0b3JlIHdpdGggcG9zdC1pbmNyZW1lbnQsIGZvciBleGFtcGxlKSwgbGVh
ZGluZyB0byBhbiBldmVuCj4+Pj4+Pj4gbW9yZSBwdXp6bGVkIGRldmVsb3BlciAodGhhdCBleGNl
cHRpb24gc2hvdWxkIG5ldmVyIGhhdmUgYmVlbgo+Pj4+Pj4+IGRlbGl2ZXJlZCB0aGUgZmlyc3Qg
cGxhY2UpLgo+Pj4+Pj4KPj4+Pj4+IFJpZ2h0LCBidXQgdGhlIGNvbWJpbmF0aW9uIG9mICJob3N0
IGtlcm5lbCBwcmludHMgYSBtZXNzYWdlCj4+Pj4+PiBhYm91dCBhbiB1bnN1cHBvcnRlZCBsb2Fk
L3N0b3JlIGluc24iIGFuZCAid2l0aGluLWd1ZXN0IGRlYnVnCj4+Pj4+PiBkdW1wL3N0YWNrIHRy
YWNlL2V0YyIgaXMgbXVjaCBtb3JlIHVzZWZ1bCB0aGFuIGp1c3QgaGF2aW5nCj4+Pj4+PiAiaG9z
dCBrZXJuZWwgcHJpbnRzIG1lc3NhZ2UiIGFuZCAiUUVNVSBleGl0cyI7IGFuZCBpdCByZXF1aXJl
cwo+Pj4+Pj4gYWJvdXQgMyBsaW5lcyBvZiBjb2RlIGNoYW5nZS4uLgo+Pj4+Pj4KPj4+Pj4+PiBJ
J20gZmFyIG1vcmUgaW4gZmF2b3VyIG9mIGR1bXBpbmcgdGhlIHN0YXRlIG9mIHRoZSBhY2Nlc3Mg
aW4gdGhlIHJ1bgo+Pj4+Pj4+IHN0cnVjdHVyZSAobXVjaCBsaWtlIHdlIGRvIGZvciBhIE1NSU8g
YWNjZXNzKSBhbmQgbGV0IHVzZXJzcGFjZSBkbwo+Pj4+Pj4+IHNvbWV0aGluZyBhYm91dCBpdCAo
c3VjaCBhcyBkdW1waW5nIGluZm9ybWF0aW9uIG9uIHRoZSBjb25zb2xlIG9yCj4+Pj4+Pj4gYnJl
YWtpbmcpLiBJdCBjb3VsZCBldmVuIGluamVjdCBhbiBleGNlcHRpb24gKmlmKiB0aGUgdXNlciBo
YXMgYXNrZWQKPj4+Pj4+PiBmb3IgaXQuCj4+Pj4+Pgo+Pj4+Pj4gLi4ud2hlcmVhcyB0aGlzIHJl
cXVpcmVzIGFncmVlbWVudCBvbiBhIGtlcm5lbC11c2Vyc3BhY2UgQVBJLAo+Pj4+Pj4gbGFyZ2Vy
IGNoYW5nZXMgaW4gdGhlIGtlcm5lbCwgc29tZWJvZHkgdG8gaW1wbGVtZW50IHRoZSB1c2Vyc3Bh
Y2UKPj4+Pj4+IHNpZGUgb2YgdGhpbmdzLCBhbmQgdGhlIHVzZXIgdG8gdXBkYXRlIGJvdGggdGhl
IGtlcm5lbCBhbmQgUUVNVS4KPj4+Pj4+IEl0J3MgaGFyZCBmb3IgbWUgdG8gc2VlIHRoYXQgdGhl
IGJlbmVmaXQgaGVyZSBvdmVyIHRoZSAzLWxpbmUKPj4+Pj4+IGFwcHJvYWNoIHJlYWxseSBvdXR3
ZWlnaHMgdGhlIGV4dHJhIGVmZm9ydCBuZWVkZWQuIEluIHByYWN0aWNlCj4+Pj4+PiBzYXlpbmcg
IndlIHNob3VsZCBkbyB0aGlzIiBpcyBzYXlpbmcgIndlJ3JlIGdvaW5nIHRvIGRvIG5vdGhpbmci
LAo+Pj4+Pj4gYmFzZWQgb24gdGhlIGhpc3RvcmljYWwgcmVjb3JkLgo+Pj4+Pj4KPj4+Pj4KPj4+
Pj4gSG93IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmcgKGNvbXBsZXRlbHkgdW50
ZXN0ZWQsIGxpYWJsZSBmb3IKPj4+Pj4gQUJJIGRpc2N1c3Npb25zIGV0Yy4gZXRjLiwgYnV0IGZv
ciBpbGx1c3RyYXRpb24gcHVycG9zZXMpLgo+Pj4+Pgo+Pj4+PiBJIHRoaW5rIGl0IHJhaXNlcyB0
aGUgcXVlc3Rpb24gKGFuZCBsaWtlbHkgbWFueSBvdGhlcikgb2Ygd2hldGhlciB3ZSBjYW4KPj4+
Pj4gYnJlYWsgdGhlIGV4aXN0aW5nICdBQkknIGFuZCBjaGFuZ2UgYmVoYXZpb3IgZm9yIG1pc3Np
bmcgSVNWCj4+Pj4+IHJldHJvc3BlY3RpdmVseSBmb3IgbGVnYWN5IHVzZXIgc3BhY2Ugd2hlbiB0
aGUgaXNzdWUgaGFzIG9jY3VycmVkPwo+Pj4+PiBTb21lb25lIG1pZ2h0IGhhdmUgd3JpdHRlbiBj
b2RlIHRoYXQgcmVhY3RzIHRvIHRoZSAtRU5PU1lTLCBzbyBJJ3ZlCj4+Pj4+IHRha2VuIHRoZSBj
b25zZXJ2YXRpdmUgYXBwcm9hY2ggZm9yIHRoaXMgZm9yIHRoZSB0aW1lIGJlaW5nLgo+Pj4+Pgo+
Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vaW5jbHVkZS9hc20va3ZtX2hvc3QuaCBi
L2FyY2gvYXJtL2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKPj4+Pj4gaW5kZXggOGEzN2M4ZTg5Nzc3
Li4xOWE5MmM0OTAzOWMgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2t2
bV9ob3N0LmgKPj4+Pj4gKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+Pj4+
PiBAQCAtNzYsNiArNzYsMTQgQEAgc3RydWN0IGt2bV9hcmNoIHsKPj4+Pj4gICAgCS8qIE1hbmRh
dGVkIHZlcnNpb24gb2YgUFNDSSAqLwo+Pj4+PiAgICAJdTMyIHBzY2lfdmVyc2lvbjsKPj4+Pj4g
Kwo+Pj4+PiArCS8qCj4+Pj4+ICsJICogSWYgd2UgZW5jb3VudGVyIGEgZGF0YSBhYm9ydCB3aXRo
b3V0IHZhbGlkIGluc3RydWN0aW9uIHN5bmRyb21lCj4+Pj4+ICsJICogaW5mb3JtYXRpb24sIHJl
cG9ydCB0aGlzIHRvIHVzZXIgc3BhY2UuICBVc2VyIHNwYWNlIGNhbiAoYW5kCj4+Pj4+ICsJICog
c2hvdWxkKSBvcHQgaW4gdG8gdGhpcyBmZWF0dXJlIGlmIEtWTV9DQVBfQVJNX05JU1ZfVE9fVVNF
UiBpcwo+Pj4+PiArCSAqIHN1cHBvcnRlZC4KPj4+Pj4gKwkgKi8KPj4+Pj4gKwlib29sIHJldHVy
bl9uaXN2X2lvX2Fib3J0X3RvX3VzZXI7Cj4+Pj4+ICAgIH07Cj4+Pj4+ICAgICNkZWZpbmUgS1ZN
X05SX01FTV9PQkpTICAgICA0MAo+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRl
L2FzbS9rdm1faG9zdC5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCj4+Pj4+
IGluZGV4IGY2NTYxNjlkYjhjMy4uMDE5YmM1NjBlZGMxIDEwMDY0NAo+Pj4+PiAtLS0gYS9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKPj4+Pj4gKysrIGIvYXJjaC9hcm02NC9pbmNs
dWRlL2FzbS9rdm1faG9zdC5oCj4+Pj4+IEBAIC04Myw2ICs4MywxNCBAQCBzdHJ1Y3Qga3ZtX2Fy
Y2ggewo+Pj4+PiAgICAJLyogTWFuZGF0ZWQgdmVyc2lvbiBvZiBQU0NJICovCj4+Pj4+ICAgIAl1
MzIgcHNjaV92ZXJzaW9uOwo+Pj4+PiArCj4+Pj4+ICsJLyoKPj4+Pj4gKwkgKiBJZiB3ZSBlbmNv
dW50ZXIgYSBkYXRhIGFib3J0IHdpdGhvdXQgdmFsaWQgaW5zdHJ1Y3Rpb24gc3luZHJvbWUKPj4+
Pj4gKwkgKiBpbmZvcm1hdGlvbiwgcmVwb3J0IHRoaXMgdG8gdXNlciBzcGFjZS4gIFVzZXIgc3Bh
Y2UgY2FuIChhbmQKPj4+Pj4gKwkgKiBzaG91bGQpIG9wdCBpbiB0byB0aGlzIGZlYXR1cmUgaWYg
S1ZNX0NBUF9BUk1fTklTVl9UT19VU0VSIGlzCj4+Pj4+ICsJICogc3VwcG9ydGVkLgo+Pj4+PiAr
CSAqLwo+Pj4+PiArCWJvb2wgcmV0dXJuX25pc3ZfaW9fYWJvcnRfdG9fdXNlcjsKPj4+Pj4gICAg
fTsKPj4+Pj4gICAgI2RlZmluZSBLVk1fTlJfTUVNX09CSlMgICAgIDQwCj4+Pj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmggYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgK
Pj4+Pj4gaW5kZXggNWUzZjEyZDUzNTllLi5hNGRkMDA0ZDBkYjkgMTAwNjQ0Cj4+Pj4+IC0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaAo+Pj4+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgv
a3ZtLmgKPj4+Pj4gQEAgLTIzNSw2ICsyMzUsNyBAQCBzdHJ1Y3Qga3ZtX2h5cGVydl9leGl0IHsK
Pj4+Pj4gICAgI2RlZmluZSBLVk1fRVhJVF9TMzkwX1NUU0kgICAgICAgIDI1Cj4+Pj4+ICAgICNk
ZWZpbmUgS1ZNX0VYSVRfSU9BUElDX0VPSSAgICAgICAyNgo+Pj4+PiAgICAjZGVmaW5lIEtWTV9F
WElUX0hZUEVSViAgICAgICAgICAgMjcKPj4+Pj4gKyNkZWZpbmUgS1ZNX0VYSVRfQVJNX05JU1Yg
ICAgICAgICAyOAo+Pj4+PiAgICAvKiBGb3IgS1ZNX0VYSVRfSU5URVJOQUxfRVJST1IgKi8KPj4+
Pj4gICAgLyogRW11bGF0ZSBpbnN0cnVjdGlvbiBmYWlsZWQuICovCj4+Pj4+IEBAIC05OTYsNiAr
OTk3LDcgQEAgc3RydWN0IGt2bV9wcGNfcmVzaXplX2hwdCB7Cj4+Pj4+ICAgICNkZWZpbmUgS1ZN
X0NBUF9BUk1fUFRSQVVUSF9BRERSRVNTIDE3MQo+Pj4+PiAgICAjZGVmaW5lIEtWTV9DQVBfQVJN
X1BUUkFVVEhfR0VORVJJQyAxNzIKPj4+Pj4gICAgI2RlZmluZSBLVk1fQ0FQX1BNVV9FVkVOVF9G
SUxURVIgMTczCj4+Pj4+ICsjZGVmaW5lIEtWTV9DQVBfQVJNX05JU1ZfVE9fVVNFUiAxNzQKPj4+
Pj4gICAgI2lmZGVmIEtWTV9DQVBfSVJRX1JPVVRJTkcKPj4+Pj4gZGlmZiAtLWdpdCBhL3ZpcnQv
a3ZtL2FybS9hcm0uYyBiL3ZpcnQva3ZtL2FybS9hcm0uYwo+Pj4+PiBpbmRleCAzNWEwNjk4MTVi
YWYuLjJjZTk0YmQ5ZDRhOSAxMDA2NDQKPj4+Pj4gLS0tIGEvdmlydC9rdm0vYXJtL2FybS5jCj4+
Pj4+ICsrKyBiL3ZpcnQva3ZtL2FybS9hcm0uYwo+Pj4+PiBAQCAtOTgsNiArOTgsMjYgQEAgaW50
IGt2bV9hcmNoX2NoZWNrX3Byb2Nlc3Nvcl9jb21wYXQodm9pZCkKPj4+Pj4gICAgCXJldHVybiAw
Owo+Pj4+PiAgICB9Cj4+Pj4+ICtpbnQga3ZtX3ZtX2lvY3RsX2VuYWJsZV9jYXAoc3RydWN0IGt2
bSAqa3ZtLAo+Pj4+PiArCQkJICAgIHN0cnVjdCBrdm1fZW5hYmxlX2NhcCAqY2FwKQo+Pj4+PiAr
ewo+Pj4+PiArCWludCByOwo+Pj4+PiArCj4+Pj4+ICsJaWYgKGNhcC0+ZmxhZ3MpCj4+Pj4+ICsJ
CXJldHVybiAtRUlOVkFMOwo+Pj4+PiArCj4+Pj4+ICsJc3dpdGNoIChjYXAtPmNhcCkgewo+Pj4+
PiArCWNhc2UgS1ZNX0NBUF9BUk1fTklTVl9UT19VU0VSOgo+Pj4+PiArCQlyID0gMDsKPj4+Pj4g
KwkJa3ZtLT5hcmNoLnJldHVybl9uaXN2X2lvX2Fib3J0X3RvX3VzZXIgPSB0cnVlOwo+Pj4+PiAr
CQlicmVhazsKPj4+Pj4gKwlkZWZhdWx0Ogo+Pj4+PiArCQlyID0gLUVJTlZBTDsKPj4+Pj4gKwkJ
YnJlYWs7Cj4+Pj4+ICsJfQo+Pj4+PiArCj4+Pj4+ICsJcmV0dXJuIHI7Cj4+Pj4+ICt9Cj4+Pj4+
ICAgIC8qKgo+Pj4+PiAgICAgKiBrdm1fYXJjaF9pbml0X3ZtIC0gaW5pdGlhbGl6ZXMgYSBWTSBk
YXRhIHN0cnVjdHVyZQo+Pj4+PiBAQCAtMTk2LDYgKzIxNiw3IEBAIGludCBrdm1fdm1faW9jdGxf
Y2hlY2tfZXh0ZW5zaW9uKHN0cnVjdCBrdm0gKmt2bSwgbG9uZyBleHQpCj4+Pj4+ICAgIAljYXNl
IEtWTV9DQVBfTVBfU1RBVEU6Cj4+Pj4+ICAgIAljYXNlIEtWTV9DQVBfSU1NRURJQVRFX0VYSVQ6
Cj4+Pj4+ICAgIAljYXNlIEtWTV9DQVBfVkNQVV9FVkVOVFM6Cj4+Pj4+ICsJY2FzZSBLVk1fQ0FQ
X0FSTV9OSVNWX1RPX1VTRVI6Cj4+Pj4+ICAgIAkJciA9IDE7Cj4+Pj4+ICAgIAkJYnJlYWs7Cj4+
Pj4+ICAgIAljYXNlIEtWTV9DQVBfQVJNX1NFVF9ERVZJQ0VfQUREUjoKPj4+Pj4gQEAgLTY3Myw2
ICs2OTQsOCBAQCBpbnQga3ZtX2FyY2hfdmNwdV9pb2N0bF9ydW4oc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCBzdHJ1Y3Qga3ZtX3J1biAqcnVuKQo+Pj4+PiAgICAJCXJldCA9IGt2bV9oYW5kbGVfbW1p
b19yZXR1cm4odmNwdSwgdmNwdS0+cnVuKTsKPj4+Pj4gICAgCQlpZiAocmV0KQo+Pj4+PiAgICAJ
CQlyZXR1cm4gcmV0Owo+Pj4+PiArCX0gZWxzZSBpZiAocnVuLT5leGl0X3JlYXNvbiA9PSBLVk1f
RVhJVF9BUk1fTklTVikgewo+Pj4+PiArCQlrdm1faW5qZWN0X3VuZGVmaW5lZCh2Y3B1KTsKPj4+
Pgo+Pj4+IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZDogSXMgdGhlIGV4cGVjdGF0aW9u
IGhlcmUgdGhhdCB1c2Vyc3BhY2UKPj4+PiBjb3VsZCBjbGVhciB0aGUgZXhpdCByZWFzb24gaWYg
aXQgbWFuYWdlZCB0byBoYW5kbGUgdGhlIGV4aXQ/IEFuZAo+Pj4+IG90aGVyd2lzZSB3ZSdkIGlu
amVjdCBhbiBVTkRFRiBvbiByZWVudHJ5Pwo+Pj4+Cj4+Pgo+Pj4gWWVzLCBidXQgSSB0aGluayB3
ZSBzaG91bGQgY2hhbmdlIHRoYXQgdG8gYW4gZXh0ZXJuYWwgYWJvcnQuICBJJ2xsIHRlc3QKPj4+
IHNvbWV0aGluZyBhbmQgc2VuZCBhIHByb3BlciBwYXRjaCB3aXRoIG1vcmUgY2xlYXIgZG9jdW1l
bnRhdGlvbi4KPj4KPj4gV2h5IG5vdCBsZWF2ZSB0aGUgaW5qZWN0aW9uIHRvIHVzZXIgc3BhY2Ug
aW4gYW55IGNhc2U/IEFQSSB3aXNlIHRoZXJlIGlzIG5vCj4+IG5lZWQgdG8gYmUgYmFja3dhcmRz
IGNvbXBhdGlibGUsIGFzIHdlIHJlcXVpcmUgdGhlIENBUCB0byBiZSBlbmFibGVkLCByaWdodD8K
Pj4KPiAKPiBJJ2QgcHJlZmVyIGxlYXZpbmcgaXQgdG8gdXNlcnNwYWNlIHRvIHdvcnJ5IGFib3V0
LCBidXQgSSB0aG91Z2h0IFBldGVyCj4gc2FpZCB0aGF0IGhhZCBiZWVuIHByb2JsZW1hdGljIGhp
c3RvcmljYWxseSwgd2hpY2ggSSB0b29rIGF0IGZhY2UgdmFsdWUsCj4gYnV0IEkgY291bGQgaGF2
ZSBtaXN1bmRlcnN0b29kLgo+IAo+IElmIFFFTVUsIGt2bXRvb2wsIGFuZCB3aGF0ZXZlciB0aGUg
Y3JhenleSCBjb29sIGtpZHMgYXJlIHVzaW5nIGluCj4gdXNlcnNwYWNlIHRoZXNlIGRheXMgYXJl
IGhhcHB5IGVtdWxhdGluZyB0aGUgZXhjZXB0aW9uLCB0aGVuIHRoYXQncyBhCj4gdmlhYmxlIGFw
cHJvYWNoLiAgVGhlIG1haW4gY29uY2VybiBJIGhhdmUgd2l0aCB0aGF0IGlzIHdoZXRoZXIgdGhl
eSdsbAo+IGFsbCBnZXQgaXQgcmlnaHQsIGFuZCBzaW5jZSB3ZSBhbHJlYWR5IGhhdmUgdGhlIGNv
ZGUgaW4gdGhlIGtlcm5lbCB0byBkbwo+IHRoaXMsIGl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gcmUt
dXNlIHRoZSBrZXJuZWwgbG9naWMgZm9yIGl0LgoKWW91IGNvdWxkIG1ha2UgdGhlIHNhbWUgYXJn
dW1lbnQgYWJvdXQgaW5qZWN0aW5nIGFuICNTRXJyb3Igb24gYW4gb3V0IG9mIApib3VuZHMgYWNj
ZXNzIHRvIE1NSU8uCgpJZiBpbmplY3RpbmcgYSBmYXVsdCBpcyB0b28gY29tcGxpY2F0ZWQsIHdl
IHNob3VsZCBmaXggdGhhdCByYXRoZXIgdGhhbiAKY3JlYXRlIGFuIHVuYmFsYW5jZWQgdXNlciBz
cGFjZSBpbnRlcmZhY2UgOikuCgo+IEknbGwgbGVhdmUgaXQgaW4gZm9yIHYxIG9mIHRoZSBwYXRj
aCwgYW5kIGlmIGJhc2VkIG9uIGhvdyB0aGF0IGNvZGUgYW5kCj4gaW50ZXJmYWNlIGxvb2tzIGxp
a2UsIHdlIGFncmVlIGl0J3MgYmV0dGVyIHRvIGxlYXZlIGl0IHRvIHVzZXJzcGFjZSwgSQo+IGNh
biByZW1vdmUgaXQgaW4gdjIuCgpTdXJlLCB3b3JrcyBmb3IgbWUgOikuIFBsZWFzZSBDQyBtZSBv
biB2MSBzbyBJIGNhbiBjb21tZW50IG9uIGl0IDspCgoKQWxleAoKCgpBbWF6b24gRGV2ZWxvcG1l
bnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hh
ZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoCkVpbmdldHJh
Z2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6
OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

