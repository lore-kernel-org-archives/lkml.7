Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB1B2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gV68P5Bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391780AbfIFMIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:08:48 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:13322 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732863AbfIFMIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567771724; x=1599307724;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hxs/scbeDUuiqXhNmj59X3zMejisYXVxIxd+xioJtUQ=;
  b=gV68P5Btpo89hWkT4aKFnrZcLwfud4Za1qrlcw+rS9T7uMnzQiiXbFFV
   t0HBaiG26hisA9ZLHSju7iRMubWGbkP3FFomWsyOEd3QpjaygjowdNaVC
   tsnJE+hrdEBAwTPISIGC9qax8VEz9iwtNrg8isSaCE74fLudiimwnWF42
   w=;
X-IronPort-AV: E=Sophos;i="5.64,473,1559520000"; 
   d="scan'208";a="419804944"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 06 Sep 2019 12:08:22 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id A29A7A06DA;
        Fri,  6 Sep 2019 12:08:21 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 12:08:21 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.160.160) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 12:08:18 +0000
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <maz@kernel.org>
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
From:   Alexander Graf <graf@amazon.com>
Message-ID: <a58c5f76-641a-8381-2cf3-e52d139c4236@amazon.com>
Date:   Fri, 6 Sep 2019 14:08:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906080033.GF4320@e113682-lin.lund.arm.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.160]
X-ClientProxiedBy: EX13D05UWB001.ant.amazon.com (10.43.161.181) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwNi4wOS4xOSAxMDowMCwgQ2hyaXN0b2ZmZXIgRGFsbCB3cm90ZToKPiBPbiBUaHUsIFNl
cCAwNSwgMjAxOSBhdCAwMjowOToxOFBNICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+IE9u
IDA1LzA5LzIwMTkgMTA6MjIsIENocmlzdG9mZmVyIERhbGwgd3JvdGU6Cj4+PiBPbiBUaHUsIFNl
cCAwNSwgMjAxOSBhdCAwOTo1Njo0NEFNICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOgo+Pj4+
IE9uIFRodSwgNSBTZXAgMjAxOSBhdCAwOTo1MiwgTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9y
Zz4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+IE9uIFRodSwgMDUgU2VwIDIwMTkgMDk6MTY6NTQgKzAxMDAs
Cj4+Pj4+IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gd3JvdGU6Cj4+
Pj4+PiBUaGlzIGlzIHRydWUsIGJ1dCB0aGUgcHJvYmxlbSBpcyB0aGF0IGJhcmZpbmcgb3V0IHRv
IHVzZXJzcGFjZQo+Pj4+Pj4gbWFrZXMgaXQgaGFyZGVyIHRvIGRlYnVnIHRoZSBndWVzdCBiZWNh
dXNlIGl0IG1lYW5zIHRoYXQKPj4+Pj4+IHRoZSBWTSBpcyBpbW1lZGlhdGVseSBkZXN0cm95ZWQs
IHdoZXJlYXMgQUlVSSBpZiB3ZQo+Pj4+Pj4gaW5qZWN0IHNvbWUga2luZCBvZiBleGNlcHRpb24g
dGhlbiAoYXNzdW1pbmcgeW91J3JlIHNldCB1cAo+Pj4+Pj4gdG8gZG8ga2VybmVsLWRlYnVnIHZp
YSBnZGJzdHViKSB5b3UgY2FuIGFjdHVhbGx5IGV4YW1pbmUKPj4+Pj4+IHRoZSBvZmZlbmRpbmcg
Z3Vlc3QgY29kZSB3aXRoIGEgZGVidWdnZXIgYmVjYXVzZSBhdCBsZWFzdAo+Pj4+Pj4geW91ciBW
TSBpcyBzdGlsbCBhcm91bmQgdG8gaW5zcGVjdC4uLgo+Pj4+Pgo+Pj4+PiBUbyBDaHJpc3RvZmZl
cidzIHBvaW50LCBJIGZpbmQgdGhlIGJlbmVmaXQgYSBiaXQgZHViaW91cy4gWWVzLCB5b3UgZ2V0
Cj4+Pj4+IGFuIGV4Y2VwdGlvbiwgYnV0IHRoZSBpbnN0cnVjdGlvbiB0aGF0IGNhdXNlZCBpdCBt
YXkgYmUgY29tcGxldGVseQo+Pj4+PiBsZWdhbCAoc3RvcmUgd2l0aCBwb3N0LWluY3JlbWVudCwg
Zm9yIGV4YW1wbGUpLCBsZWFkaW5nIHRvIGFuIGV2ZW4KPj4+Pj4gbW9yZSBwdXp6bGVkIGRldmVs
b3BlciAodGhhdCBleGNlcHRpb24gc2hvdWxkIG5ldmVyIGhhdmUgYmVlbgo+Pj4+PiBkZWxpdmVy
ZWQgdGhlIGZpcnN0IHBsYWNlKS4KPj4+Pgo+Pj4+IFJpZ2h0LCBidXQgdGhlIGNvbWJpbmF0aW9u
IG9mICJob3N0IGtlcm5lbCBwcmludHMgYSBtZXNzYWdlCj4+Pj4gYWJvdXQgYW4gdW5zdXBwb3J0
ZWQgbG9hZC9zdG9yZSBpbnNuIiBhbmQgIndpdGhpbi1ndWVzdCBkZWJ1Zwo+Pj4+IGR1bXAvc3Rh
Y2sgdHJhY2UvZXRjIiBpcyBtdWNoIG1vcmUgdXNlZnVsIHRoYW4ganVzdCBoYXZpbmcKPj4+PiAi
aG9zdCBrZXJuZWwgcHJpbnRzIG1lc3NhZ2UiIGFuZCAiUUVNVSBleGl0cyI7IGFuZCBpdCByZXF1
aXJlcwo+Pj4+IGFib3V0IDMgbGluZXMgb2YgY29kZSBjaGFuZ2UuLi4KPj4+Pgo+Pj4+PiBJJ20g
ZmFyIG1vcmUgaW4gZmF2b3VyIG9mIGR1bXBpbmcgdGhlIHN0YXRlIG9mIHRoZSBhY2Nlc3MgaW4g
dGhlIHJ1bgo+Pj4+PiBzdHJ1Y3R1cmUgKG11Y2ggbGlrZSB3ZSBkbyBmb3IgYSBNTUlPIGFjY2Vz
cykgYW5kIGxldCB1c2Vyc3BhY2UgZG8KPj4+Pj4gc29tZXRoaW5nIGFib3V0IGl0IChzdWNoIGFz
IGR1bXBpbmcgaW5mb3JtYXRpb24gb24gdGhlIGNvbnNvbGUgb3IKPj4+Pj4gYnJlYWtpbmcpLiBJ
dCBjb3VsZCBldmVuIGluamVjdCBhbiBleGNlcHRpb24gKmlmKiB0aGUgdXNlciBoYXMgYXNrZWQK
Pj4+Pj4gZm9yIGl0Lgo+Pj4+Cj4+Pj4gLi4ud2hlcmVhcyB0aGlzIHJlcXVpcmVzIGFncmVlbWVu
dCBvbiBhIGtlcm5lbC11c2Vyc3BhY2UgQVBJLAo+Pj4+IGxhcmdlciBjaGFuZ2VzIGluIHRoZSBr
ZXJuZWwsIHNvbWVib2R5IHRvIGltcGxlbWVudCB0aGUgdXNlcnNwYWNlCj4+Pj4gc2lkZSBvZiB0
aGluZ3MsIGFuZCB0aGUgdXNlciB0byB1cGRhdGUgYm90aCB0aGUga2VybmVsIGFuZCBRRU1VLgo+
Pj4+IEl0J3MgaGFyZCBmb3IgbWUgdG8gc2VlIHRoYXQgdGhlIGJlbmVmaXQgaGVyZSBvdmVyIHRo
ZSAzLWxpbmUKPj4+PiBhcHByb2FjaCByZWFsbHkgb3V0d2VpZ2hzIHRoZSBleHRyYSBlZmZvcnQg
bmVlZGVkLiBJbiBwcmFjdGljZQo+Pj4+IHNheWluZyAid2Ugc2hvdWxkIGRvIHRoaXMiIGlzIHNh
eWluZyAid2UncmUgZ29pbmcgdG8gZG8gbm90aGluZyIsCj4+Pj4gYmFzZWQgb24gdGhlIGhpc3Rv
cmljYWwgcmVjb3JkLgo+Pj4+Cj4+Pgo+Pj4gSG93IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoZSBm
b2xsb3dpbmcgKGNvbXBsZXRlbHkgdW50ZXN0ZWQsIGxpYWJsZSBmb3IKPj4+IEFCSSBkaXNjdXNz
aW9ucyBldGMuIGV0Yy4sIGJ1dCBmb3IgaWxsdXN0cmF0aW9uIHB1cnBvc2VzKS4KPj4+Cj4+PiBJ
IHRoaW5rIGl0IHJhaXNlcyB0aGUgcXVlc3Rpb24gKGFuZCBsaWtlbHkgbWFueSBvdGhlcikgb2Yg
d2hldGhlciB3ZSBjYW4KPj4+IGJyZWFrIHRoZSBleGlzdGluZyAnQUJJJyBhbmQgY2hhbmdlIGJl
aGF2aW9yIGZvciBtaXNzaW5nIElTVgo+Pj4gcmV0cm9zcGVjdGl2ZWx5IGZvciBsZWdhY3kgdXNl
ciBzcGFjZSB3aGVuIHRoZSBpc3N1ZSBoYXMgb2NjdXJyZWQ/Cj4+PiAgICAgCj4+PiBTb21lb25l
IG1pZ2h0IGhhdmUgd3JpdHRlbiBjb2RlIHRoYXQgcmVhY3RzIHRvIHRoZSAtRU5PU1lTLCBzbyBJ
J3ZlCj4+PiB0YWtlbiB0aGUgY29uc2VydmF0aXZlIGFwcHJvYWNoIGZvciB0aGlzIGZvciB0aGUg
dGltZSBiZWluZy4KPj4+Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNt
L2t2bV9ob3N0LmggYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCj4+PiBpbmRleCA4
YTM3YzhlODk3NzcuLjE5YTkyYzQ5MDM5YyAxMDA2NDQKPj4+IC0tLSBhL2FyY2gvYXJtL2luY2x1
ZGUvYXNtL2t2bV9ob3N0LmgKPj4+ICsrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2t2bV9ob3N0
LmgKPj4+IEBAIC03Niw2ICs3NiwxNCBAQCBzdHJ1Y3Qga3ZtX2FyY2ggewo+Pj4gICAKPj4+ICAg
CS8qIE1hbmRhdGVkIHZlcnNpb24gb2YgUFNDSSAqLwo+Pj4gICAJdTMyIHBzY2lfdmVyc2lvbjsK
Pj4+ICsKPj4+ICsJLyoKPj4+ICsJICogSWYgd2UgZW5jb3VudGVyIGEgZGF0YSBhYm9ydCB3aXRo
b3V0IHZhbGlkIGluc3RydWN0aW9uIHN5bmRyb21lCj4+PiArCSAqIGluZm9ybWF0aW9uLCByZXBv
cnQgdGhpcyB0byB1c2VyIHNwYWNlLiAgVXNlciBzcGFjZSBjYW4gKGFuZAo+Pj4gKwkgKiBzaG91
bGQpIG9wdCBpbiB0byB0aGlzIGZlYXR1cmUgaWYgS1ZNX0NBUF9BUk1fTklTVl9UT19VU0VSIGlz
Cj4+PiArCSAqIHN1cHBvcnRlZC4KPj4+ICsJICovCj4+PiArCWJvb2wgcmV0dXJuX25pc3ZfaW9f
YWJvcnRfdG9fdXNlcjsKPj4+ICAgfTsKPj4+ICAgCj4+PiAgICNkZWZpbmUgS1ZNX05SX01FTV9P
QkpTICAgICA0MAo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hv
c3QuaCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+Pj4gaW5kZXggZjY1NjE2
OWRiOGMzLi4wMTliYzU2MGVkYzEgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUv
YXNtL2t2bV9ob3N0LmgKPj4+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3Qu
aAo+Pj4gQEAgLTgzLDYgKzgzLDE0IEBAIHN0cnVjdCBrdm1fYXJjaCB7Cj4+PiAgIAo+Pj4gICAJ
LyogTWFuZGF0ZWQgdmVyc2lvbiBvZiBQU0NJICovCj4+PiAgIAl1MzIgcHNjaV92ZXJzaW9uOwo+
Pj4gKwo+Pj4gKwkvKgo+Pj4gKwkgKiBJZiB3ZSBlbmNvdW50ZXIgYSBkYXRhIGFib3J0IHdpdGhv
dXQgdmFsaWQgaW5zdHJ1Y3Rpb24gc3luZHJvbWUKPj4+ICsJICogaW5mb3JtYXRpb24sIHJlcG9y
dCB0aGlzIHRvIHVzZXIgc3BhY2UuICBVc2VyIHNwYWNlIGNhbiAoYW5kCj4+PiArCSAqIHNob3Vs
ZCkgb3B0IGluIHRvIHRoaXMgZmVhdHVyZSBpZiBLVk1fQ0FQX0FSTV9OSVNWX1RPX1VTRVIgaXMK
Pj4+ICsJICogc3VwcG9ydGVkLgo+Pj4gKwkgKi8KPj4+ICsJYm9vbCByZXR1cm5fbmlzdl9pb19h
Ym9ydF90b191c2VyOwo+Pj4gICB9Owo+Pj4gICAKPj4+ICAgI2RlZmluZSBLVk1fTlJfTUVNX09C
SlMgICAgIDQwCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oIGIvaW5j
bHVkZS91YXBpL2xpbnV4L2t2bS5oCj4+PiBpbmRleCA1ZTNmMTJkNTM1OWUuLmE0ZGQwMDRkMGRi
OSAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaAo+Pj4gKysrIGIvaW5j
bHVkZS91YXBpL2xpbnV4L2t2bS5oCj4+PiBAQCAtMjM1LDYgKzIzNSw3IEBAIHN0cnVjdCBrdm1f
aHlwZXJ2X2V4aXQgewo+Pj4gICAjZGVmaW5lIEtWTV9FWElUX1MzOTBfU1RTSSAgICAgICAgMjUK
Pj4+ICAgI2RlZmluZSBLVk1fRVhJVF9JT0FQSUNfRU9JICAgICAgIDI2Cj4+PiAgICNkZWZpbmUg
S1ZNX0VYSVRfSFlQRVJWICAgICAgICAgICAyNwo+Pj4gKyNkZWZpbmUgS1ZNX0VYSVRfQVJNX05J
U1YgICAgICAgICAyOAo+Pj4gICAKPj4+ICAgLyogRm9yIEtWTV9FWElUX0lOVEVSTkFMX0VSUk9S
ICovCj4+PiAgIC8qIEVtdWxhdGUgaW5zdHJ1Y3Rpb24gZmFpbGVkLiAqLwo+Pj4gQEAgLTk5Niw2
ICs5OTcsNyBAQCBzdHJ1Y3Qga3ZtX3BwY19yZXNpemVfaHB0IHsKPj4+ICAgI2RlZmluZSBLVk1f
Q0FQX0FSTV9QVFJBVVRIX0FERFJFU1MgMTcxCj4+PiAgICNkZWZpbmUgS1ZNX0NBUF9BUk1fUFRS
QVVUSF9HRU5FUklDIDE3Mgo+Pj4gICAjZGVmaW5lIEtWTV9DQVBfUE1VX0VWRU5UX0ZJTFRFUiAx
NzMKPj4+ICsjZGVmaW5lIEtWTV9DQVBfQVJNX05JU1ZfVE9fVVNFUiAxNzQKPj4+ICAgCj4+PiAg
ICNpZmRlZiBLVk1fQ0FQX0lSUV9ST1VUSU5HCj4+PiAgIAo+Pj4gZGlmZiAtLWdpdCBhL3ZpcnQv
a3ZtL2FybS9hcm0uYyBiL3ZpcnQva3ZtL2FybS9hcm0uYwo+Pj4gaW5kZXggMzVhMDY5ODE1YmFm
Li4yY2U5NGJkOWQ0YTkgMTAwNjQ0Cj4+PiAtLS0gYS92aXJ0L2t2bS9hcm0vYXJtLmMKPj4+ICsr
KyBiL3ZpcnQva3ZtL2FybS9hcm0uYwo+Pj4gQEAgLTk4LDYgKzk4LDI2IEBAIGludCBrdm1fYXJj
aF9jaGVja19wcm9jZXNzb3JfY29tcGF0KHZvaWQpCj4+PiAgIAlyZXR1cm4gMDsKPj4+ICAgfQo+
Pj4gICAKPj4+ICtpbnQga3ZtX3ZtX2lvY3RsX2VuYWJsZV9jYXAoc3RydWN0IGt2bSAqa3ZtLAo+
Pj4gKwkJCSAgICBzdHJ1Y3Qga3ZtX2VuYWJsZV9jYXAgKmNhcCkKPj4+ICt7Cj4+PiArCWludCBy
Owo+Pj4gKwo+Pj4gKwlpZiAoY2FwLT5mbGFncykKPj4+ICsJCXJldHVybiAtRUlOVkFMOwo+Pj4g
Kwo+Pj4gKwlzd2l0Y2ggKGNhcC0+Y2FwKSB7Cj4+PiArCWNhc2UgS1ZNX0NBUF9BUk1fTklTVl9U
T19VU0VSOgo+Pj4gKwkJciA9IDA7Cj4+PiArCQlrdm0tPmFyY2gucmV0dXJuX25pc3ZfaW9fYWJv
cnRfdG9fdXNlciA9IHRydWU7Cj4+PiArCQlicmVhazsKPj4+ICsJZGVmYXVsdDoKPj4+ICsJCXIg
PSAtRUlOVkFMOwo+Pj4gKwkJYnJlYWs7Cj4+PiArCX0KPj4+ICsKPj4+ICsJcmV0dXJuIHI7Cj4+
PiArfQo+Pj4gICAKPj4+ICAgLyoqCj4+PiAgICAqIGt2bV9hcmNoX2luaXRfdm0gLSBpbml0aWFs
aXplcyBhIFZNIGRhdGEgc3RydWN0dXJlCj4+PiBAQCAtMTk2LDYgKzIxNiw3IEBAIGludCBrdm1f
dm1faW9jdGxfY2hlY2tfZXh0ZW5zaW9uKHN0cnVjdCBrdm0gKmt2bSwgbG9uZyBleHQpCj4+PiAg
IAljYXNlIEtWTV9DQVBfTVBfU1RBVEU6Cj4+PiAgIAljYXNlIEtWTV9DQVBfSU1NRURJQVRFX0VY
SVQ6Cj4+PiAgIAljYXNlIEtWTV9DQVBfVkNQVV9FVkVOVFM6Cj4+PiArCWNhc2UgS1ZNX0NBUF9B
Uk1fTklTVl9UT19VU0VSOgo+Pj4gICAJCXIgPSAxOwo+Pj4gICAJCWJyZWFrOwo+Pj4gICAJY2Fz
ZSBLVk1fQ0FQX0FSTV9TRVRfREVWSUNFX0FERFI6Cj4+PiBAQCAtNjczLDYgKzY5NCw4IEBAIGlu
dCBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1bihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBr
dm1fcnVuICpydW4pCj4+PiAgIAkJcmV0ID0ga3ZtX2hhbmRsZV9tbWlvX3JldHVybih2Y3B1LCB2
Y3B1LT5ydW4pOwo+Pj4gICAJCWlmIChyZXQpCj4+PiAgIAkJCXJldHVybiByZXQ7Cj4+PiArCX0g
ZWxzZSBpZiAocnVuLT5leGl0X3JlYXNvbiA9PSBLVk1fRVhJVF9BUk1fTklTVikgewo+Pj4gKwkJ
a3ZtX2luamVjdF91bmRlZmluZWQodmNwdSk7Cj4+Cj4+IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5k
ZXJzdGFuZDogSXMgdGhlIGV4cGVjdGF0aW9uIGhlcmUgdGhhdCB1c2Vyc3BhY2UKPj4gY291bGQg
Y2xlYXIgdGhlIGV4aXQgcmVhc29uIGlmIGl0IG1hbmFnZWQgdG8gaGFuZGxlIHRoZSBleGl0PyBB
bmQKPj4gb3RoZXJ3aXNlIHdlJ2QgaW5qZWN0IGFuIFVOREVGIG9uIHJlZW50cnk/Cj4+Cj4gCj4g
WWVzLCBidXQgSSB0aGluayB3ZSBzaG91bGQgY2hhbmdlIHRoYXQgdG8gYW4gZXh0ZXJuYWwgYWJv
cnQuICBJJ2xsIHRlc3QKPiBzb21ldGhpbmcgYW5kIHNlbmQgYSBwcm9wZXIgcGF0Y2ggd2l0aCBt
b3JlIGNsZWFyIGRvY3VtZW50YXRpb24uCgpXaHkgbm90IGxlYXZlIHRoZSBpbmplY3Rpb24gdG8g
dXNlciBzcGFjZSBpbiBhbnkgY2FzZT8gQVBJIHdpc2UgdGhlcmUgaXMgCm5vIG5lZWQgdG8gYmUg
YmFja3dhcmRzIGNvbXBhdGlibGUsIGFzIHdlIHJlcXVpcmUgdGhlIENBUCB0byBiZSBlbmFibGVk
LCAKcmlnaHQ/CgpJTUhPIGl0IHNob3VsZCBiZSAxMDAlIGEgcG9saWN5IGRlY2lzaW9uIGluIHVz
ZXIgc3BhY2Ugd2hldGhlciB0byAKZW11bGF0ZSBhbmQgd2hhdCB0eXBlIG9mIGV4Y2VwdGlvbiB0
byBpbmplY3QsIGlmIGFueXRoaW5nLgoKCkFsZXgKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRl
ciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVo
cnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgUmFsZiBIZXJicmljaApFaW5nZXRyYWdlbiBhbSBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGlu
ClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

