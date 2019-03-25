Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C937C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF062087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfCYSDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:03:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbfCYSDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:03:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7D7436807;
        Mon, 25 Mar 2019 18:03:40 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6926860CCC;
        Mon, 25 Mar 2019 18:03:38 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Guard against invalid cpu # in
 pv_vcpu_is_preempted()
To:     Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20190325155706.26987-1-longman@redhat.com>
 <e01da674-cbf0-22f1-7aba-6041f892b689@suse.com>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <5a48f5fb-799e-84f8-1fa7-eda851878d50@redhat.com>
Date:   Mon, 25 Mar 2019 14:03:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e01da674-cbf0-22f1-7aba-6041f892b689@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 25 Mar 2019 18:03:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMvMjUvMjAxOSAxMjo0MCBQTSwgSnVlcmdlbiBHcm9zcyB3cm90ZToKPiBPbiAyNS8w
My8yMDE5IDE2OjU3LCBXYWltYW4gTG9uZyB3cm90ZToKPj4gSXQgd2FzIGZvdW5kIHRoYXQg
cGFzc2luZyBhbiBpbnZhbGlkIGNwdSBudW1iZXIgdG8gcHZfdmNwdV9pc19wcmVlbXB0ZWQo
KQo+PiBtaWdodCBwYW5pYyB0aGUga2VybmVsIGluIGEgVk0gZ3Vlc3QuIEZvciBleGFtcGxl
LAo+Pgo+PiBbICAgIDIuNTMxMDc3XSBPb3BzOiAwMDAwIFsjMV0gU01QIFBUSQo+PiAgIDoK
Pj4gWyAgICAyLjUzMjU0NV0gSGFyZHdhcmUgbmFtZTogUmVkIEhhdCBLVk0sIEJJT1MgMC41
LjEgMDEvMDEvMjAxMQo+PiBbICAgIDIuNTMzMzIxXSBSSVA6IDAwMTA6X19yYXdfY2FsbGVl
X3NhdmVfX19rdm1fdmNwdV9pc19wcmVlbXB0ZWQrMHgwLzB4MjAKPj4KPj4gVG8gZ3VhcmQg
YWdhaW5zdCB0aGlzIGtpbmQgb2Yga2VybmVsIHBhbmljLCBjaGVjayBpcyBhZGRlZCB0bwo+
PiBwdl92Y3B1X2lzX3ByZWVtcHRlZCgpIHRvIG1ha2Ugc3VyZSB0aGF0IG5vIGludmFsaWQg
Y3B1IG51bWJlciB3aWxsCj4+IGJlIHVzZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFdhaW1h
biBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgYXJjaC94ODYvaW5jbHVk
ZS9hc20vcGFyYXZpcnQuaCB8IDYgKysrKysrCj4+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJh
dmlydC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaAo+PiBpbmRleCBjMjVj
MzhhMDVjMWMuLjRjZmI0NjVkY2RlNCAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vcGFyYXZpcnQuaAo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmly
dC5oCj4+IEBAIC02NzEsNiArNjcxLDEyIEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9p
ZCBwdl9raWNrKGludCBjcHUpCj4+ICAKPj4gIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9v
bCBwdl92Y3B1X2lzX3ByZWVtcHRlZChsb25nIGNwdSkKPj4gIHsKPj4gKwkvKgo+PiArCSAq
IEd1YXJkIGFnYWluc3QgaW52YWxpZCBjcHUgbnVtYmVyIG9yIHRoZSBrZXJuZWwgbWlnaHQg
cGFuaWMuCj4+ICsJICovCj4+ICsJaWYgKFdBUk5fT05fT05DRSgodW5zaWduZWQgbG9uZylj
cHUgPj0gbnJfY3B1X2lkcykpCj4+ICsJCXJldHVybiBmYWxzZTsKPj4gKwo+PiAgCXJldHVy
biBQVk9QX0NBTExFRTEoYm9vbCwgbG9jay52Y3B1X2lzX3ByZWVtcHRlZCwgY3B1KTsKPj4g
IH0KPiBDYW4gdGhpcyByZWFsbHkgaGFwcGVuIHdpdGhvdXQgYmVpbmcgYSBwcm9ncmFtbWlu
ZyBlcnJvcj8KClRoaXMgc2hvdWxkbid0IGhhcHBlbiB3aXRob3V0IGEgcHJvZ3JhbW1pbmcg
ZXJyb3IsIEkgdGhpbmsuIEluIG15IGNhc2UsCml0IHdhcyBjYXVzZWQgYnkgYSByYWNlIGNv
bmRpdGlvbiBsZWFkaW5nIHRvIHVzZS1hZnRlci1mcmVlIG9mIHRoZSBjcHUKbnVtYmVyLiBI
b3dldmVyLCBteSBwb2ludCBpcyB0aGF0IGVycm9yIGxpa2UgdGhhdCBzaG91bGRuJ3QgY2F1
c2UgdGhlCmtlcm5lbCB0byBwYW5pYy4KCj4gQmFzaWNhbGx5IHlvdSdkIG5lZWQgdG8gZ3Vh
cmQgYWxsIHBlcmNwdSBhcmVhIGFjY2Vzc2VzIHRvIGZvcmVpZ24gY3B1cwo+IHRoaXMgd2F5
LiBXaHkgaXMgdGhpcyBvbmUgc3BlY2lhbD8KCkl0IGRlcGVuZHMuIElmIG91dC1vZi1ib3Vu
ZCBhY2Nlc3MgY2FuIG9ubHkgaGFwcGVuIHdpdGggb2J2aW91cwpwcm9ncmFtbWluZyBlcnJv
ciwgSSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGd1YXJkIGFnYWluc3QgdGhlbS4gSW4gdGhp
cwpjYXNlLCBJIGFtIG5vdCB0b3RhbGx5IHN1cmUgaWYgdGhlIHJhY2UgY29uZGl0aW9uIHRo
YXQgSSBmb3VuZCBtYXkKaGFwcGVuIHdpdGggZXhpc3RpbmcgY29kZSBvciBub3QuIFRvIGJl
IHBydWRlbnQsIEkgZGVjaWRlIHRvIHNlbmQgdGhpcwpwYXRjaCBvdXQuCgpUaGUgcmFjZSBj
b25kaXRpb24gdGhhdCBJIGFtIGxvb2tpbmcgYXQgaXMgYXMgZm9sbG93czoKCsKgIENQVSAw
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENQVSAx
CsKgIC0tLS0twqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC0tLS0tCnVwX3dyaXRlOgrCoCBvd25lciA9IE5VTEw7CsKgIDxyZWxlYXNlLWJhcnJp
ZXI+CsKgIGNvdW50ID0gMDsKCjxyY3UtZnJlZSB0YXNrIHN0cnVjdHVyZT4KwqAKwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcndzZW1fY2Fu
X3NwaW5fb25fb3duZXI6CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByY3VfcmVhZF9sb2NrKCk7CsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWFkIG93bmVyOwrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDoK
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHZjcHVfaXNfcHJlZW1wdGVkKG93bmVyLT5jcHUpOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDoKwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjdV9yZWFkX3VubG9j
aygpCgpXaGVuIEkgdHJpZWQgdG8gbWVyZ2UgdGhlIG93bmVyIGludG8gdGhlIGNvdW50IChj
bGVhciB0aGUgb3duZXIgYWZ0ZXIKdGhlIGJhcnJpZXIpLCBJIGNhbiByZXByb2R1Y2UgdGhl
IGNyYXNoIDEwMCUgd2hlbiBib290aW5nIHVwIHRoZSBrZXJuZWwKaW4gYSBWTSBndWVzdC4g
SG93ZXZlciwgSSBhbSBub3Qgc3VyZSBpZiB0aGUgY29uZmlndXJhdGlvbiBhYm92ZSBpcyBz
YWZlCmFuZCBpcyBqdXN0IHZlcnkgaGFyZCB0byByZXByb2R1Y2UuCgpBbHRlcm5hdGl2ZWx5
LCBJIGNhbiBhbHNvIGRvIHRoZSBjcHUgY2hlY2sgYmVmb3JlIGNhbGxpbmcKdmNwdV9pc19w
cmVlbXB0ZWQoKS4KCkNoZWVycywKTG9uZ21hbgoKCg==
