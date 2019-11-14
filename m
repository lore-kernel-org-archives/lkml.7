Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A90C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEE02071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfKNXnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:43:01 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:39590 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKNXnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:43:01 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xAENgPBW016714
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Nov 2019 08:42:25 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xAENgP8s020520;
        Fri, 15 Nov 2019 08:42:25 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xAENeWlm018242;
        Fri, 15 Nov 2019 08:42:25 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-10391874; Fri, 15 Nov 2019 08:36:44 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0439.000; Fri,
 15 Nov 2019 08:36:43 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
Thread-Topic: [PATCH 2/3] mm: Introduce subsection_dev_map
Thread-Index: AQHVlciaV4LdiB2s4UGTCvjTchQqtqeBDuKAgAfVYoCAAAQ6gIAADP8AgAAE4gCAAAOxgIAABLSAgAAItACAAAMVAIAAARcAgAG27YA=
Date:   Thu, 14 Nov 2019 23:36:42 +0000
Message-ID: <49786b4d-ba95-21b5-c079-46d93c2fe53f@vx.jp.nec.com>
References: <CAPcyv4gpN8kbh1i6jCDdC2OP41G3C2+7YD4rYz-3HaD_pufvyg@mail.gmail.com>
 <3E71366A-9232-46BB-8261-3FCB2300C80A@redhat.com>
 <CAPcyv4hw58eYJdb4ifvwX8m1E-AMyF5COmjEppz7px6vaB5cRA@mail.gmail.com>
In-Reply-To: <CAPcyv4hw58eYJdb4ifvwX8m1E-AMyF5COmjEppz7px6vaB5cRA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE0C9BAFB163B94494C8E9D488AEE0ED@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS8xMS8xNCA2OjI2LCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IE9uIFdlZCwgTm92IDEz
LCAyMDE5IGF0IDE6MjIgUE0gRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdy
b3RlOg0KPj4NCj4+DQo+Pg0KPj4+IEFtIDEzLjExLjIwMTkgdW0gMjI6MTIgc2NocmllYiBEYW4g
V2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT46DQo+Pj4NCj4+PiDvu79PbiBXZWQs
IE5vdiAxMywgMjAxOSBhdCAxMjo0MCBQTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+Pj4gWy4uXQ0KPj4+Pj4+Pj4gSSdtIHN0aWxsIHN0cnVnZ2xpbmcgdG8g
dW5kZXJzdGFuZCB0aGUgbW90aXZhdGlvbiBvZiBkaXN0aW5ndWlzaGluZw0KPj4+Pj4+Pj4gImFj
dGl2ZSIgYXMgc29tZXRoaW5nIGRpc3RpbmN0IGZyb20gIm9ubGluZSIuIEFzIGxvbmcgYXMgdGhl
ICJvbmxpbmUiDQo+Pj4+Pj4+PiBncmFudWxhcml0eSBpcyBpbXByb3ZlZCBmcm9tIHNlY3Rpb25z
IGRvd24gdG8gc3Vic2VjdGlvbnMgdGhlbiBtb3N0DQo+Pj4+Pj4+PiBjb2RlIHBhdGhzIGFyZSBn
b29kIHRvIGdvLiBUaGUgb3RoZXJzIGNhbiB1c2UgZ2V0X2RldnBhZ2VtYXAoKSB0bw0KPj4+Pj4+
Pj4gY2hlY2sgZm9yIFpPTkVfREVWSUNFIGluIGEgcmFjZSBmcmVlIG1hbm5lciBhcyB0aGV5IGN1
cnJlbnRseSBkby4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSB0aG91Z2h0IHdlIHdhbnRlZCB0byB1bmlm
eSBhY2Nlc3MgaWYgd2UgZG9u4oCZdCByZWFsbHkgY2FyZSBhYm91dCB0aGUgem9uZSBhcyBpbiBt
b3N0IHBmbiB3YWxrZXJzIC0gRS5nLiwgZm9yIHpvbmUgc2hyaW5raW5nLg0KPj4+Pj4+DQo+Pj4+
Pj4gQWdyZWUsIHdoZW4gdGhlIHpvbmUgZG9lcyBub3QgbWF0dGVyLCB3aGljaCBpcyBtb3N0IGNh
c2VzLCB0aGVuDQo+Pj4+Pj4gcGZuX29ubGluZSgpIGFuZCBwZm5fdmFsaWQoKSBhcmUgc3VmZmlj
aWVudC4NCj4+Pj4NCj4+Pj4gT2gsIGFuZCBqdXN0IHRvIGNsYXJpZnkgd2h5IEkgcHJvcG9zZWQg
cGZuX2FjdGl2ZSgpOiBUaGUgaXNzdWUgcmlnaHQgbm93IGlzIHRoYXQgYSBQRk4gdGhhdCBpcyB2
YWxpZCBidXQgbm90IG9ubGluZSBjb3VsZCBiZSBvZmZsaW5lIG1lbW9yeSAobWVtbWFwIG5vdCBp
bml0aWFsaXplZCkgb3IgWk9ORV9ERVZJQ0UuIFRoYXTigJhzIHdoeSBJIHdhbnRlZCB0byBoYXZl
IGEgd2F5IHRvIGRldGVjdCBpZiBhIG1lbW1hcCB3YXMgaW5pdGlhbGl6ZWQsIGluZGVwZW5kZW50
IG9mIHRoZSB6b25lLiBUaGF04oCYcyBpbXBvcnRhbnQgZm9yIGdlbmVyaWMgUEZOIHdhbGtlcnMu
DQo+Pj4NCj4+PiBUaGF0J3Mgd2hhdCBJIHdhcyBkZWJhdGluZyB3aXRoIFRvc2hpa2kgWzFdLCB3
aGV0aGVyIHRoZXJlIGlzIGEgcmVhbA0KPj4+IGV4YW1wbGUgb2YgbmVlZGluZyB0byBkaXN0aW5n
dWlzaCBaT05FX0RFVklDRSBmcm9tIG9mZmxpbmUgbWVtb3J5IGluIGENCj4+PiBwZm4gd2Fsa2Vy
LiBUaGUgcHJvcG9zZWQgdXNlIGNhc2UgaW4gdGhpcyBwYXRjaCBzZXQgb2YgYmVpbmcgYWJsZSB0
bw0KPj4+IHNldCBod3BvaXNvbiBvbiBaT05FX0RFVklDRSBwYWdlcyBkb2VzIG5vdCBzZWVtIGxp
a2UgYSBnb29kIGlkZWEgdG8NCj4+PiBtZS4gTXkgc3VzcGljaW9uIGlzIHRoYXQgdGhpcyBpcyBh
IGNvbW1vbiB0aGVtZSBhbmQgb3RoZXJzIGFyZSBsb29raW5nDQo+Pj4gdG8gZG8gdGhlc2UgdHlw
ZXMgcGFnZSBtYW5pcHVsYXRpb25zIHRoYXQgb25seSBtYWtlIHNlbnNlIGZvciBvbmxpbmUNCj4+
PiBtZW1vcnkuIElmIHRoYXQgaXMgdGhlIGNhc2UgdGhlbiB0cmVhdGluZyBaT05FX0RFVklDRSBh
cyBvZmZsaW5lIHNlZW1zDQo+Pj4gdGhlIHJpZ2h0IGRpcmVjdGlvbi4NCj4+DQo+PiBSaWdodC4g
QXQgbGVhc3QgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIGZvciB6b25lIHNocmlua2luZyAtIG5v
dCBzdXJlIGFib3V0IHRoZSBvdGhlciB3YWxrZXJzLiBXZSB3b3VsZCBoYXZlIHRvIHNwZWNpYWwt
Y2FzZSBaT05FX0RFVklDRSBoYW5kbGluZyB0aGVyZS4NCj4+DQo+IA0KPiBJIHRoaW5rIHRoYXQn
cyBvay4uLiBJdCdzIGFscmVhZHkgem9uZSBhd2FyZSBjb2RlIHdoZXJlYXMgcGZuIHdhbGtlcnMN
Cj4gYXJlIHpvbmUgdW5hd2FyZSBhbmQgc2hvdWxkIHN0YXkgdGhhdCB3YXkgaWYgYXQgYWxsIHBv
c3NpYmxlLg0KPiANCj4+IEJ1dCBhcyBJIHNhaWQsIGEgc3Vic2VjdGlvbiBtYXAgZm9yIG9ubGlu
ZSBtZW1vcnkgaXMgYSBnb29kIHN0YXJ0LCBlc3BlY2lhbGx5IHRvIGZpeCBwZm5fdG9fb25saW5l
X3BhZ2UoKS4gQWxzbywgSSB0aGluayB0aGlzIG1pZ2h0IGJlIGEgdmVyeSBnb29kIHRoaW5nIHRv
IGhhdmUgZm9yIE9zY2FycyBtZW1tYXAtb24tbWVtb3J5IHdvcmsgKEkgaGF2ZSBhIHBsYW4gaW4g
bXkgaGVhZCBJIGNhbiBkaXNjdXNzIHdpdGggT3NjYXIgb25jZSBoZSBoYXMgdGltZSB0byB3b3Jr
IG9uIHRoYXQgYWdhaW4pLg0KPiANCj4gT2ssIEknbGwga2VlcCBhbiBleWUgb3V0Lg0KDQpJIHVu
ZGVyc3RhbmQgeW91ciBwb2ludC4gVGhhbmtzIQ0KDQpCeSB0aGUgd2F5LCBJIGZvdW5kIGFub3Ro
ZXIgcHJvYmxlbSBhYm91dCBaT05FX0RFVklDRSwgd2hpY2gNCmlzIHJhY2UgYmV0d2VlbiBtZW1t
YXAgaW5pdGlhbGl6YXRpb24gYW5kIHpvbmUgc2hyaW5raW5nLg0KDQpJdGVyYXRpb24gb2YgY3Jl
YXRlIGFuZCBkZXN0cm95IG5hbWVzcGFjZSBjYXVzZXMgdGhlIHBhbmljIGFzIGJlbG93Og0KDQpb
ICAgNDEuMjA3Njk0XSBrZXJuZWwgQlVHIGF0IG1tL3BhZ2VfYWxsb2MuYzo1MzUhDQpbICAgNDEu
MjA4MTA5XSBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNNUCBQVEkNClsgICA0MS4yMDg1MDhd
IENQVTogNyBQSUQ6IDI3NjYgQ29tbTogbmRjdGwgTm90IHRhaW50ZWQgNS40LjAtcmM0ICM2DQpb
ICAgNDEuMjA5MDY0XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQ
SUlYLCAxOTk2KSwgQklPUyByZWwtMS4xMS4wLTAtZzYzNDUxZmNhMTMtcHJlYnVpbHQucWVtdS1w
cm9qZWN0Lm9yZyAwNC8wMS8yMDE0DQpbICAgNDEuMjEwMTc1XSBSSVA6IDAwMTA6c2V0X3BmbmJs
b2NrX2ZsYWdzX21hc2srMHg5NS8weGYwDQpbICAgNDEuMjEwNjQzXSBDb2RlOiAwNCA0MSA4MyBl
MiAzYyA0OCA4ZCAwNCBhOCA0OCBjMSBlMCAwNyA0OCAwMyAwNCBkZCBlMCA1OSA1NSBiYiA0OCA4
YiA1OCA2OCA0OCAzOSBkYSA3MyAwZSA0OCBjNyBjNiA3MCBhYyAxMSBiYiBlOCAxYiBiMiBmZCBm
ZiA8MGY+IDBiIDQ4IDAzIDU4IDc4IDQ4IDM5IGRhIDczIGU5IDQ5IDAxIGNhIGI5IDNmIDAwIDAw
IDAwIDRmIDhkIDBjDQpbICAgNDEuMjEyMzU0XSBSU1A6IDAwMTg6ZmZmZmFjMGQ0MTU1N2M4MCBF
RkxBR1M6IDAwMDEwMjQ2DQpbICAgNDEuMjEyODIxXSBSQVg6IDAwMDAwMDAwMDAwMDAwNGEgUkJY
OiAwMDAwMDAwMDAwMjQ0YTAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDQxLjIxMzQ1OV0g
UkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IGZmZmZmZmZm
YmIxMTk3ZGMNClsgICA0MS4yMTQxMDBdIFJCUDogMDAwMDAwMDAwMDAwMDAwYyBSMDg6IDAwMDAw
MDAwMDAwMDA0MzkgUjA5OiAwMDAwMDAwMDAwMDAwMDU5DQpbICAgNDEuMjE0NzM2XSBSMTA6IDAw
MDAwMDAwMDAwMDAwMDAgUjExOiBmZmZmYWMwZDQxNTU3YjA4IFIxMjogZmZmZjhiZTQ3NWVhNzJi
MA0KWyAgIDQxLjIxNTM3Nl0gUjEzOiAwMDAwMDAwMDAwMDBmYTAwIFIxNDogMDAwMDAwMDAwMDI1
MDAwMCBSMTU6IDAwMDAwMDAwZmZmYzBiYjUNClsgICA0MS4yMTYwMDhdIEZTOiAgMDAwMDdmMzA4
NjJhYjYwMCgwMDAwKSBHUzpmZmZmOGJlNTdiYzQwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAw
MDAwMDANClsgICA0MS4yMTY3NzFdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAw
MDAwMDAwODAwNTAwMzMNClsgICA0MS4yMTcyOTldIENSMjogMDAwMDU1ZTgyNGQwZDUwOCBDUjM6
IDAwMDAwMDAyMzFkYWMwMDAgQ1I0OiAwMDAwMDAwMDAwMDAwNmUwDQpbICAgNDEuMjE3OTM0XSBD
YWxsIFRyYWNlOg0KWyAgIDQxLjIxODIyNV0gIG1lbW1hcF9pbml0X3pvbmVfZGV2aWNlKzB4MTY1
LzB4MTdjDQpbICAgNDEuMjE4NjQyXSAgbWVtcmVtYXBfcGFnZXMrMHg0YzEvMHg1NDANClsgICA0
MS4yMTg5ODldICBkZXZtX21lbXJlbWFwX3BhZ2VzKzB4MWQvMHg2MA0KWyAgIDQxLjIxOTM2N10g
IHBtZW1fYXR0YWNoX2Rpc2srMHgxNmIvMHg2MDAgW25kX3BtZW1dDQpbICAgNDEuMjE5ODA0XSAg
PyBkZXZtX25zaW9fZW5hYmxlKzB4YjgvMHhlMA0KWyAgIDQxLjIyMDE3Ml0gIG52ZGltbV9idXNf
cHJvYmUrMHg2OS8weDFjMA0KWyAgIDQxLjIyMDUyNl0gIHJlYWxseV9wcm9iZSsweDFjMi8weDNl
MA0KWyAgIDQxLjIyMDg1Nl0gIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHhiNC8weDEwMA0KWyAgIDQx
LjIyMTIzOF0gIGRldmljZV9kcml2ZXJfYXR0YWNoKzB4NGYvMHg2MA0KWyAgIDQxLjIyMTYxMV0g
IGJpbmRfc3RvcmUrMHhjOS8weDExMA0KWyAgIDQxLjIyMTkxOV0gIGtlcm5mc19mb3Bfd3JpdGUr
MHgxMTYvMHgxOTANClsgICA0MS4yMjIzMjZdICB2ZnNfd3JpdGUrMHhhNS8weDFhMA0KWyAgIDQx
LjIyMjYyNl0gIGtzeXNfd3JpdGUrMHg1OS8weGQwDQpbICAgNDEuMjIyOTI3XSAgZG9fc3lzY2Fs
bF82NCsweDViLzB4MTgwDQpbICAgNDEuMjIzMjY0XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lKzB4NDQvMHhhOQ0KWyAgIDQxLjIyMzcxNF0gUklQOiAwMDMzOjB4N2YzMDg2NWQwZWQ4
DQpbICAgNDEuMjI0MDM3XSBDb2RlOiA4OSAwMiA0OCBjNyBjMCBmZiBmZiBmZiBmZiBlYiBiMyAw
ZiAxZiA4MCAwMCAwMCAwMCAwMCBmMyAwZiAxZSBmYSA0OCA4ZCAwNSA0NSA3OCAwZCAwMCA4YiAw
MCA4NSBjMCA3NSAxNyBiOCAwMSAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAwIGYwIGZmIGZmIDc3
IDU4IGMzIDBmIDFmIDgwIDAwIDAwIDAwIDAwIDQxIDU0IDQ5IDg5IGQ0IDU1DQpbICAgNDEuMjI1
OTIwXSBSU1A6IDAwMmI6MDAwMDdmZmZlNWQzMGE3OCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFY
OiAwMDAwMDAwMDAwMDAwMDAxDQpbICAgNDEuMjI2NjA4XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEg
UkJYOiAwMDAwNTVlODI0ZDA3ZjQwIFJDWDogMDAwMDdmMzA4NjVkMGVkOA0KWyAgIDQxLjIyNzI0
Ml0gUkRYOiAwMDAwMDAwMDAwMDAwMDA3IFJTSTogMDAwMDU1ZTgyNGQwN2Y0MCBSREk6IDAwMDAw
MDAwMDAwMDAwMDQNClsgICA0MS4yMjc4NzBdIFJCUDogMDAwMDAwMDAwMDAwMDAwNyBSMDg6IDAw
MDAwMDAwMDAwMDAwMDcgUjA5OiAwMDAwMDAwMDAwMDAwMDA2DQpbICAgNDEuMjI4NzUzXSBSMTA6
IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAw
MDAwNA0KWyAgIDQxLjIyOTQxOV0gUjEzOiAwMDAwN2YzMDg2MmFiNTI4IFIxNDogMDAwMDAwMDAw
MDAwMDAwMSBSMTU6IDAwMDA1NWU4MjRkMDdmNDANCg0KV2hpbGUgY3JlYXRpbmcgYSBuYW1lc3Bh
Y2UgYW5kIGluaXRpYWxpemluZyBtZW1tYXAsIGlmIHlvdSBkZXN0cm95IHRoZSBuYW1lc3BhY2UN
CmFuZCBzaHJpbmsgdGhlIHpvbmUsIGl0IHdpbGwgaW5pdGlhbGl6ZSB0aGUgbWVtbWFwIG91dHNp
ZGUgdGhlIHpvbmUgYW5kDQp0cmlnZ2VyIFZNX0JVR19PTl9QQUdFKCF6b25lX3NwYW5zX3Bmbihw
YWdlX3pvbmUocGFnZSksIHBmbiksIHBhZ2UpIGluDQpzZXRfcGZuYmxvY2tfZmxhZ3NfbWFzaygp
Lg0KDQpUaGFua3MsDQpUb3NoaWtpIEZ1a2FzYXdh

