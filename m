Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0826C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C055020650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V103KYjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393347AbfIFNlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:41:31 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49334 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732512AbfIFNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567777289; x=1599313289;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XMIKAY1xJL7NYmAZNKLAmXbXU9LqB+oBH7gwXT7mxi8=;
  b=V103KYjnlek9k+nL+OVEjDwuZdjOUKzrO7ByegAxEQKVOm42LtsYvtP3
   lXtO6IOeT223cMU8QZzIQ1Um0sHXjjGdeGlbBpP7YAjBprowS5UkW/4Qp
   5VShguIqxbuW+n6jUwLtiG0vRh/1CTThdgTgHMR0xO6ZWZof+DT0tsOJg
   8=;
X-IronPort-AV: E=Sophos;i="5.64,473,1559520000"; 
   d="scan'208";a="783639180"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 06 Sep 2019 13:41:26 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 5EB25A17B2;
        Fri,  6 Sep 2019 13:41:25 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 13:41:24 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.218) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 13:41:22 +0000
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
To:     Peter Maydell <peter.maydell@linaro.org>,
        Christoffer Dall <christoffer.dall@arm.com>
CC:     =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
 <CAFEAcA9vwyhAN8uO8=PpaBkBXb0Of4G0jEij7nMrYcnJjSRVjg@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <28c5c021-7cb0-616b-4215-dd75242c16e6@amazon.com>
Date:   Fri, 6 Sep 2019 15:41:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9vwyhAN8uO8=PpaBkBXb0Of4G0jEij7nMrYcnJjSRVjg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.218]
X-ClientProxiedBy: EX13D16UWB004.ant.amazon.com (10.43.161.170) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwNi4wOS4xOSAxNTozMSwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToKPiBPbiBGcmksIDYgU2Vw
IDIwMTkgYXQgMTQ6MTMsIENocmlzdG9mZmVyIERhbGwgPGNocmlzdG9mZmVyLmRhbGxAYXJtLmNv
bT4gd3JvdGU6Cj4+IEknZCBwcmVmZXIgbGVhdmluZyBpdCB0byB1c2Vyc3BhY2UgdG8gd29ycnkg
YWJvdXQsIGJ1dCBJIHRob3VnaHQgUGV0ZXIKPj4gc2FpZCB0aGF0IGhhZCBiZWVuIHByb2JsZW1h
dGljIGhpc3RvcmljYWxseSwgd2hpY2ggSSB0b29rIGF0IGZhY2UgdmFsdWUsCj4+IGJ1dCBJIGNv
dWxkIGhhdmUgbWlzdW5kZXJzdG9vZC4KPj4KPj4gSWYgUUVNVSwga3ZtdG9vbCwgYW5kIHdoYXRl
dmVyIHRoZSBjcmF6eV5IIGNvb2wga2lkcyBhcmUgdXNpbmcgaW4KPj4gdXNlcnNwYWNlIHRoZXNl
IGRheXMgYXJlIGhhcHB5IGVtdWxhdGluZyB0aGUgZXhjZXB0aW9uLCB0aGVuIHRoYXQncyBhCj4+
IHZpYWJsZSBhcHByb2FjaC4gIFRoZSBtYWluIGNvbmNlcm4gSSBoYXZlIHdpdGggdGhhdCBpcyB3
aGV0aGVyIHRoZXknbGwKPj4gYWxsIGdldCBpdCByaWdodCwgYW5kIHNpbmNlIHdlIGFscmVhZHkg
aGF2ZSB0aGUgY29kZSBpbiB0aGUga2VybmVsIHRvIGRvCj4+IHRoaXMsIGl0IG1pZ2h0IG1ha2Ug
c2Vuc2UgdG8gcmUtdXNlIHRoZSBrZXJuZWwgbG9naWMgZm9yIGl0Lgo+IAo+IFdlbGwsIGZvciBR
RU1VIHdlJ3ZlIGhhZCBjb2RlIHRoYXQgaW4gdGhlb3J5IG1pZ2h0IGRvIHRoaXMgYnV0Cj4gaW4g
cHJhY3RpY2UgaXQncyBuZXZlciBiZWVuIHRlc3RlZC4gRXNzZW50aWFsbHkgdGhlIHByb2JsZW0g
aXMKPiB0aGF0IG5vYm9keSBldmVyIHdhbnRzIHRvIGluamVjdCBhbiBleGNlcHRpb24gZnJvbSB1
c2Vyc3BhY2UKPiBleGNlcHQgaW4gaW5jcmVkaWJseSByYXJlIGNhc2VzIGxpa2UgInRyeWluZyB0
byB1c2UgaC93IGJyZWFrcG9pbnRzCj4gc2ltdWx0YW5lb3VzbHkgaW5zaWRlIHRoZSBWTSBhbmQg
YWxzbyB0byBkZWJ1ZyB0aGUgVk0gZnJvbSBvdXRzaWRlIgo+IG9yICJ3ZSdyZSBydW5uaW5nIG9u
IFJBUyBoYXJkd2FyZSB0aGF0IGp1c3QgdG9sZCB1cyB0aGF0IHRoZSBWTSdzCj4gUkFNIHdhcyBm
YXVsdHkiLiBUaGVyZSdzIG5vIGV2ZW4gdmFndWVseSBjb21tb25seS11c2VkIHVzZWNhc2UKPiBm
b3IgaXQgdG9kYXk7IGFuZCB0aGlzIEFCSSBzdWdnZXN0aW9uIGFkZHMgYW5vdGhlciAidGhpcyBp
cyBpbgo+IHByYWN0aWNlIGFsbW9zdCBuZXZlciBnb2luZyB0byBoYXBwZW4iIGNhc2UgdG8gdGhl
IHBpbGUuIFRoZQo+IGNvZGVwYXRoIGlzIHVucmVsaWFibGUgaW4gUUVNVSBiZWNhdXNlIChhKSBp
dCByZXF1aXJlcyBnZXR0aW5nCj4gc3luY2luZyBvZiBzeXNyZWcgdmFsdWVzIHRvIGFuZCBmcm9t
IHRoZSBrZXJuZWwgcmlnaHQgLS0gdGhpcyBpcwo+IGFib3V0IHRoZSBvbmx5IHNpdHVhdGlvbiB3
aGVyZSB1c2Vyc3BhY2Ugd2FudHMgdG8gbW9kaWZ5IHN5c3JlZ3MKPiBkdXJpbmcgZXhlY3V0aW9u
IG9mIHRoZSBWTSwgYXMgb3Bwb3NlZCB0byBqdXN0IHJlYWRpbmcgdGhlbSAtLSBhbmQKPiAoYikg
d2UgdHJ5IHRvIHJldXNlIHRoZSBjb2RlIHdlIGFscmVhZHkgaGF2ZSB0aGF0IGRvZXMgVENHIGV4
Y2VwdGlvbgo+IGluamVjdGlvbiwgd2hpY2ggbWlnaHQgb3IgbWlnaHQgbm90IGJlIGEgZGVzaWdu
IG1pc3Rha2UsIGFuZAoKVGhhdCdzIHByb2JhYmx5IGEgZGVzaWduIG1pc3Rha2UsIGNvcnJlY3Qg
OikKCj4gKGMpIGFzIG5vdGVkIGFib3ZlIGl0J3MgYSBuZXZlci1hY3R1YWxseS11c2VkIHVudGVz
dGVkIGNvZGVwYXRoLi4uCgpTb3VuZHMgbGlrZSBhbiBlYXN5IHRoaW5nIHRvIHJlc29sdmUgdXNp
bmcga3ZtLXVuaXQtdGVzdHM/Cgo+IFNvIEkgdGhpbmsgaWYgSSB3ZXJlIHlvdSBJIHdvdWxkbid0
IGNvbW1pdCB0byB0aGUga2VybmVsIEFCSSB1bnRpbAo+IHNvbWVib2R5IGhhZCBhdCBsZWFzdCB3
cml0dGVuIHNvbWUgUkZDLXF1YWxpdHkgcGF0Y2hlcyBmb3IgUUVNVSBhbmQKPiB0ZXN0ZWQgdGhh
dCB0aGV5IHdvcmsgYW5kIHRoZSBBQkkgaXMgT0sgaW4gdGhhdCBzZW5zZS4gKEZvciB0aGUKPiBh
dm9pZGFuY2Ugb2YgZG91YnQsIEknbSBub3Qgdm9sdW50ZWVyaW5nIHRvIGRvIHRoYXQgbXlzZWxm
LikKPiBJIGRvbid0IG9iamVjdCB0byB0aGUgaWRlYSBpbiBwcmluY2lwbGUsIHRob3VnaC4KPiAK
PiBQUzogdGhlIG90aGVyICJpbmplY3RpbmcgZXhjZXB0aW9ucyB0byB0aGUgZ3Vlc3QiIG9kZGl0
eSBpcyB0aGF0Cj4gaWYgdGhlIGtlcm5lbCAqZG9lcyogZmluZCB0aGUgSVNWIGluZm9ybWF0aW9u
IGFuZCByZXR1cm5zIHRvIHVzZXJzcGFjZQo+IGZvciBpdCB0byBoYW5kbGUgdGhlIE1NSU8sIHRo
ZXJlJ3Mgbm8gd2F5IGZvciB1c2Vyc3BhY2UgdG8gc2F5Cj4gImFjdHVhbGx5IHRoYXQgYWRkcmVz
cyBpcyBzdXBwb3NlZCB0byBnZW5lcmF0ZSBhIGRhdGEgYWJvcnQiLgoKSSB0aGluayB3ZSdyZSBj
b252ZXJnaW5nIGhlcmUuIE15IHByb3Bvc2FsIGlzIHRoYXQgImluamVjdCBhIGZhdWx0IiAKc2hv
dWxkIG5vdCBiZSBzb21ldGhpbmcgc3BlY2lhbCBjYXNlZCBmb3IgdGhlICJJIGNhbid0IGRlY29k
ZSB0aGUgCmluc3RydWN0aW9uIiBjYXNlLCBidXQgcmF0aGVyIHRoYXQgd2UgbmVlZCBhIG1vcmUg
Z2VuZXJpYyBtZWNoYW5pc20uCgpXaGV0aGVyIHRoYXQncyBhIG5ldyBpb2N0bCwgYSBmbGFnIHdl
IHNldCBvbiBlbnRyeSBvciBzb21ldGhpbmcgZWxzZSBpcyAKYW4gaW1wbGVtZW50YXRpb24gZGV0
YWlsIEknbGwgYmUgaGFwcHkgdG8gbGVhdmUgZm9yIGRpc2N1c3Npb24uCgpUaGUgb25seSB0aGlu
ZyBJJ2QgbGlrZSB0byBhdm9pZCBzZWVpbmcgaXMgdGhhdCB3ZSBjcmVhdGUgYSBuZXcgdXNlciAK
c3BhY2UgQUJJIHRoYXQgbWFrZXMgaXQgZWFzeSB0byBpbmplY3QgYSBzaW5nbGUsIHBhcnRpY3Vs
YXIgZXhjZXB0aW9uLCAKYnV0IG5vdCBzb2x2ZSBhbGwgb2YgdGhlIG90aGVyIGNhc2VzIHdoaWxl
IGNyZWF0aW5nIGV4dHJhIHdvcmsgdG8ganVzdCAKaW1wbGVtZW50IGluc3RydWN0aW9uIGRlY29k
aW5nIGluIHVzZXIgc3BhY2UuCgoKQWxleAoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdl
cm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoCkVpbmdldHJhZ2VuIGFtIEFtdHNn
ZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0
LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

