Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BF2C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD2920857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfCZKf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:35:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:5219 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfCZKf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:35:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 03:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="310494053"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by orsmga005.jf.intel.com with ESMTP; 26 Mar 2019 03:35:53 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.146]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.102]) with mapi id 14.03.0415.000;
 Tue, 26 Mar 2019 10:35:52 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Greg KH" <gregkh@linuxfoundation.org>
Subject: RE: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Topic: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU3W7K/qF6gc5OOEis06RmzC4AhqYR090AgAAOl4CAC99ecA==
Date:   Tue, 26 Mar 2019 10:35:51 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C19A55@IRSMSX102.ger.corp.intel.com>
References: <20190318094128.1488-1-elena.reshetova@intel.com>
 <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
 <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com>
In-Reply-To: <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWJhYzU4NjMtNGJiZS00NGY0LWExY2YtOTkxM2YxNTVmZjcyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTTN6eGV1ZFVWdmpXVW5JWHhKWndpayt4eDh1eWFESDJXNFE2XC92bGE4eUMwXC95VlZrZHRzemRSditieWlNbTVVIn0=
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNb24sIE1hciAxOCwgMjAxOSBhdCAxOjE2IFBNIEFuZHkgTHV0b21pcnNraSA8bHV0b0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4gPiBPbiBNb24sIE1hciAxOCwgMjAxOSBhdCAyOjQxIEFNIEVs
ZW5hIFJlc2hldG92YQ0KPiA+IDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPiB3cm90ZToNCj4g
PiA+IFBlcmZvcm1hbmNlOg0KPiA+ID4NCj4gPiA+IDEpIGxtYmVuY2g6IC4vbGF0X3N5c2NhbGwg
LU4gMTAwMDAwMCBudWxsDQo+ID4gPiAgICAgYmFzZTogICAgICAgICAgICAgICAgICAgICBTaW1w
bGUgc3lzY2FsbDogMC4xNzc0IG1pY3Jvc2Vjb25kcw0KPiA+ID4gICAgIHJhbmRvbV9vZmZzZXQg
KHJkdHNjKTogICAgIFNpbXBsZSBzeXNjYWxsOiAwLjE4MDMgbWljcm9zZWNvbmRzDQo+ID4gPiAg
ICAgcmFuZG9tX29mZnNldCAocmRyYW5kKTogU2ltcGxlIHN5c2NhbGw6IDAuMzcwMiBtaWNyb3Nl
Y29uZHMNCj4gPiA+DQo+ID4gPiAyKSAgQW5keSdzIHRlc3RzLCBtaXNjLXRlc3RzOiAuL3RpbWlu
Z190ZXN0XzY0IDEwTSBzeXNfZW5vc3lzDQo+ID4gPiAgICAgYmFzZTogICAgICAgICAgICAgICAg
ICAgICAxMDAwMDAwMCBsb29wcyBpbiAxLjYyMjI0cyA9IDE2Mi4yMiBuc2VjIC8gbG9vcA0KPiA+
ID4gICAgIHJhbmRvbV9vZmZzZXQgKHJkdHNjKTogICAgIDEwMDAwMDAwIGxvb3BzIGluIDEuNjQ2
NjBzID0gMTY0LjY2IG5zZWMgLyBsb29wDQo+ID4gPiAgICAgcmFuZG9tX29mZnNldCAocmRyYW5k
KTogMTAwMDAwMDAgbG9vcHMgaW4gMy41MTMxNXMgPSAzNTEuMzIgbnNlYyAvIGxvb3ANCj4gPiA+
DQo+ID4NCj4gPiBFZ2FkcyEgIFJEVFNDIGlzIG5pY2UgYW5kIGZhc3QgYnV0IHByb2JhYmx5IGZh
aXJseSBlYXN5IHRvIGRlZmVhdC4NCj4gPiBSRFJBTkQgaXMgYXdmdWwuICBJIGhhZCBob3BlZCBm
b3IgYmV0dGVyLg0KPiANCj4gUkRSQU5EIGNhbiBhbHNvIGZhaWwuDQo+IA0KPiA+IFNvIHBlcmhh
cHMgd2UgbmVlZCBhIGxpdHRsZSBwZXJjcHUgYnVmZmVyIHRoYXQgY29sbGVjdHMgNjQgYml0cyBv
Zg0KPiA+IHJhbmRvbW5lc3MgYXQgYSB0aW1lLCBzaGlmdHMgb3V0IHRoZSBuZWVkZWQgYml0cywg
YW5kIHJlZmlsbHMgdGhlDQo+ID4gYnVmZmVyIHdoZW4gd2UgcnVuIG91dC4NCj4gDQo+IEknZCBs
aWtlIHRvIGF2b2lkIHNhdmluZyB0aGUgX2V4YWN0XyBkZXRhaWxzIG9mIHdoZXJlIHRoZSBuZXh0
IG9mZnNldA0KPiB3aWxsIGJlLCBidXQgaWYgbm90aGluZyBlbHNlIHdvcmtzLCB0aGlzIHNob3Vs
ZCBiZSBva2F5LiBXZSBjYW4gdXNlIDgNCj4gYml0cyBhdCBhIHRpbWUgYW5kIGNhbGwgcHJhbmRv
bV91MzIoKSBldmVyeSA0dGggY2FsbC4gU29tZXRoaW5nIGxpa2UNCj4gcHJhbmRvbV9ieXRlcygp
LCBidXQgd2hlcmUgaXQgZG9lc24ndCB0aHJvdyBhd2F5IHRoZSB1bnVzZWQgYnl0ZXMuDQoNCkFj
dHVhbGx5IEkgdGhpbmsgdGhpcyB3b3VsZCBtYWtlIHRoZSBlbmQgcmVzdWx0IGV2ZW4gd29yc2Ug
c2VjdXJpdHktd2lzZQ0KdGhhbiBzaW1wbHkgdXNpbmcgcmR0c2MoKSBvbiBldmVyeSBzeXNjYWxs
LiBTYXZpbmcgdGhlIHJhbmRvbW5lc3MgaW4gcGVyY3B1DQpidWZmZXIsIHdoaWNoIGlzIHByb2Jh
Ymx5IGVhc2lseSBhY2Nlc3NpYmxlIGFuZCBjYW4gYmUgcHJvYmVkIGlmIG5lZWRlZCwNCndvdWxk
IHN1cHBseSBhdHRhY2tlciB3aXRoIG11Y2ggbW9yZSBrbm93bGVkZ2UgYWJvdXQgdGhlIG5leHQg
My00DQpyYW5kb20gb2Zmc2V0cyB0aGF0IHdoYXQgaGUgd291bGQgZ2V0IGlmIHdlIHVzZSAid2Vh
ayIgcmR0c2MuIEdpdmVuIA0KdGhhdCBmb3IgYSBzdWNjZXNzZnVsIGV4cGxvaXQsIGFuIGF0dGFj
a2VyIHdvdWxkIG5lZWQgdG8gaGF2ZSBzdGFjayBhbGlnbmVkDQpvbmNlIG9ubHksIGhhdmluZyBh
IGtub3dsZWRnZSBvZiAzLTQgbmV4dCBvZmZzZXRzIHNvdW5kcyBsaWtlIGEgcHJlc2VudCB0byBh
bg0KZXhwbG9pdCB3cml0ZXIuLi4gIEFkZGl0aW9uYWxseSBpdCBjcmVhdGVzIGNvbXBsZXhpdHkg
YXJvdW5kIHRoZSBjb2RlIHRoYXQgSQ0KaGF2ZSBpc3N1ZXMganVzdGlmeWluZyB3aXRoICJzZWN1
cml0eSIgYXJndW1lbnQgYmVjYXVzZSBvZiBhYm92ZS4uLiANCg0KSSBoYXZlIHRoZSBwYXRjaCBu
b3cgd2l0aCBhbGxvY2EoKSBhbmQgcmR0c2MoKSB3b3JraW5nLCBJIGNhbiBwb3N0IGl0IA0KKGFs
YmVpdCBpdCBpcyB2ZXJ5IHNpbXBsZSksIGJ1dCBJIGFtIHJlYWxseSBoZXNpdGF0aW5nIG9uIGFk
ZGluZyB0aGUgcGVyY3B1DQpidWZmZXIgcmFuZG9tbmVzcyBzdG9yYWdlIHRvIGl0Li4uDQoNCkJl
c3QgUmVnYXJkcywNCkVsZW5hLg0K
