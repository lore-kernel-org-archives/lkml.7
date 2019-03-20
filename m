Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0152184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfCTMKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:10:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:14948 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfCTMKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:10:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 05:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="scan'208";a="330291275"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2019 05:10:49 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.146]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.139]) with mapi id 14.03.0415.000;
 Wed, 20 Mar 2019 12:10:48 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Greg KH" <gregkh@linuxfoundation.org>
Subject: RE: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Topic: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU3W7K/qF6gc5OOEis06RmzC4AhqYR090AgAA2yACAAmTpQA==
Date:   Wed, 20 Mar 2019 12:10:47 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C0EA9C@IRSMSX102.ger.corp.intel.com>
References: <20190318094128.1488-1-elena.reshetova@intel.com>
 <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
 <20190318233148.25uee3s6g7vuhags@treble>
In-Reply-To: <20190318233148.25uee3s6g7vuhags@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2ZjMjYyM2MtNmIzYy00YTYxLWFiZjctZTZjMGJlNWQ2YjNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRGxySWVQbTVRQjh0bURBenJjejNHcFhZTlwvYkJkclFHMmdHYjVaZnF5elRWT2F0UHBENE1PU3NaWWgxZm1cL1BjIn0=
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNb24sIE1hciAxOCwgMjAxOSBhdCAwMToxNTo0NFBNIC0wNzAwLCBBbmR5IEx1dG9taXJz
a2kgd3JvdGU6DQo+ID4gT24gTW9uLCBNYXIgMTgsIDIwMTkgYXQgMjo0MSBBTSBFbGVuYSBSZXNo
ZXRvdmENCj4gPiA8ZWxlbmEucmVzaGV0b3ZhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+
ID4gSWYgQ09ORklHX1JBTkRPTUlaRV9LU1RBQ0tfT0ZGU0VUIGlzIHNlbGVjdGVkLA0KPiA+ID4g
dGhlIGtlcm5lbCBzdGFjayBvZmZzZXQgaXMgcmFuZG9taXplZCB1cG9uIGVhY2gNCj4gPiA+IGVu
dHJ5IHRvIGEgc3lzdGVtIGNhbGwgYWZ0ZXIgZml4ZWQgbG9jYXRpb24gb2YgcHRfcmVncw0KPiA+
ID4gc3RydWN0Lg0KPiA+ID4NCj4gPiA+IFRoaXMgZmVhdHVyZSBpcyBiYXNlZCBvbiB0aGUgb3Jp
Z2luYWwgaWRlYSBmcm9tDQo+ID4gPiB0aGUgUGFYJ3MgUkFOREtTVEFDSyBmZWF0dXJlOg0KPiA+
ID4gaHR0cHM6Ly9wYXguZ3JzZWN1cml0eS5uZXQvZG9jcy9yYW5ka3N0YWNrLnR4dA0KPiA+ID4g
QWxsIHRoZSBjcmVkaXRzIGZvciB0aGUgb3JpZ2luYWwgaWRlYSBnb2VzIHRvIHRoZSBQYVggdGVh
bS4NCj4gPiA+IEhvd2V2ZXIsIHRoZSBkZXNpZ24gYW5kIGltcGxlbWVudGF0aW9uIG9mDQo+ID4g
PiBSQU5ET01JWkVfS1NUQUNLX09GRlNFVCBkaWZmZXJzIGdyZWF0bHkgZnJvbSB0aGUgUkFOREtT
VEFDSw0KPiA+ID4gZmVhdHVyZSAoc2VlIGJlbG93KS4NCj4gPiA+DQo+ID4gPiBSZWFzb25pbmcg
Zm9yIHRoZSBmZWF0dXJlOg0KPiA+ID4NCj4gPiA+IFRoaXMgZmVhdHVyZSBhaW1zIHRvIG1ha2Ug
Y29uc2lkZXJhYmx5IGhhcmRlciB2YXJpb3VzDQo+ID4gPiBzdGFjay1iYXNlZCBhdHRhY2tzIHRo
YXQgcmVseSBvbiBkZXRlcm1pbmlzdGljIHN0YWNrDQo+ID4gPiBzdHJ1Y3R1cmUuDQo+ID4gPiBX
ZSBoYXZlIGhhZCBtYW55IG9mIHN1Y2ggYXR0YWNrcyBpbiBwYXN0IFsxXSxbMl0sWzNdDQo+ID4g
PiAoanVzdCB0byBuYW1lIGZldyksIGFuZCBhcyBMaW51eCBrZXJuZWwgc3RhY2sgcHJvdGVjdGlv
bnMNCj4gPiA+IGhhdmUgYmVlbiBjb25zdGFudGx5IGltcHJvdmluZyAodm1hcC1iYXNlZCBzdGFj
aw0KPiA+ID4gYWxsb2NhdGlvbiB3aXRoIGd1YXJkIHBhZ2VzLCByZW1vdmFsIG9mIHRocmVhZF9p
bmZvLA0KPiA+ID4gU1RBQ0tMRUFLKSwgYXR0YWNrZXJzIGhhdmUgdG8gZmluZCBuZXcgd2F5cyBm
b3IgdGhlaXINCj4gPiA+IGV4cGxvaXRzIHRvIHdvcmsuDQo+ID4gPg0KPiA+ID4gSXQgaXMgaW1w
b3J0YW50IHRvIG5vdGUgdGhhdCB3ZSBjdXJyZW50bHkgY2Fubm90IHNob3cNCj4gPiA+IGEgY29u
Y3JldGUgYXR0YWNrIHRoYXQgd291bGQgYmUgc3RvcHBlZCBieSB0aGlzIG5ldw0KPiA+ID4gZmVh
dHVyZSAoZ2l2ZW4gdGhhdCBvdGhlciBleGlzdGluZyBzdGFjayBwcm90ZWN0aW9ucw0KPiA+ID4g
YXJlIGVuYWJsZWQpLCBzbyB0aGlzIGlzIGFuIGF0dGVtcHQgdG8gYmUgb24gYSBwcm9hY3RpdmUN
Cj4gPiA+IHNpZGUgdnMuIGNhdGNoaW5nIHVwIHdpdGggZXhpc3Rpbmcgc3VjY2Vzc2Z1bCBleHBs
b2l0cy4NCj4gPiA+DQo+ID4gPiBUaGUgbWFpbiBpZGVhIGlzIHRoYXQgc2luY2UgdGhlIHN0YWNr
IG9mZnNldCBpcw0KPiA+ID4gcmFuZG9taXplZCB1cG9uIGVhY2ggc3lzdGVtIGNhbGwsIGl0IGlz
IHZlcnkgaGFyZCBmb3INCj4gPiA+IGF0dGFja2VyIHRvIHJlbGlhYmx5IGxhbmQgaW4gYW55IHBh
cnRpY3VsYXIgcGxhY2Ugb24NCj4gPiA+IHRoZSB0aHJlYWQgc3RhY2sgd2hlbiBhdHRhY2sgaXMg
cGVyZm9ybWVkLg0KPiA+ID4gQWxzbywgc2luY2UgcmFuZG9taXphdGlvbiBpcyBwZXJmb3JtZWQg
KmFmdGVyKiBwdF9yZWdzLA0KPiA+ID4gdGhlIHB0cmFjZS1iYXNlZCBhcHByb2FjaCB0byBkaXNj
b3ZlciByYW5kb21pemF0aW9uDQo+ID4gPiBvZmZzZXQgZHVyaW5nIGEgbG9uZy1ydW5uaW5nIHN5
c2NhbGwgc2hvdWxkIG5vdCBiZQ0KPiA+ID4gcG9zc2libGUuDQo+ID4gPg0KPiA+ID4gWzFdIGpv
bi5vYmVyaGVpZGUub3JnL2ZpbGVzL2luZmlsdHJhdGUxMi10aGVzdGFja2lzYmFjay5wZGYNCj4g
PiA+IFsyXSBqb24ub2JlcmhlaWRlLm9yZy9maWxlcy9zdGFja2phY2tpbmctaW5maWx0cmF0ZTEx
LnBkZg0KPiA+ID4gWzNdIGdvb2dsZXByb2plY3R6ZXJvLmJsb2dzcG90LmNvbS8yMDE2LzA2L2V4
cGxvaXRpbmctDQo+ID4gPiByZWN1cnNpb24taW4tbGludXgta2VybmVsXzIwLmh0bWwNCj4gDQo+
IE5vdyB0aGF0IHRocmVhZF9pbmZvIGlzIG9mZiB0aGUgc3RhY2ssIGFuZCB2bWFwIHN0YWNrIGd1
YXJkIHBhZ2VzIGV4aXN0LA0KPiBpdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IHRoZSBiZW5lZml0
IGlzLg0KDQpZZXMsIGFzIGl0IHNheXMgYWJvdmUsIHRoaXMgaXMgYW4gYXR0ZW1wdCB0byBiZSBw
cm9hY3RpdmUgdnMuIHJlYWN0aXZlLiANCldlIGNhbm5vdCBzaG93IGNvbmNyZXRlIGF0dGFjayBu
b3cgdGhhdCB3b3VsZCBzdWNjZWVkIHdpdGggdm1hcA0Kc3RhY2sgZW5hYmxlZCwgdGhyZWFkX2lu
Zm8gcmVtb3ZlZCBhbmQgb3RoZXIgcHJvdGVjdGlvbnMgZW5hYmxlZC4gDQpIb3dldmVyLCB0aGUg
ZmFjdCB0aGF0IGtlcm5lbCB0aHJlYWQgc3RhY2sgaXMgc3RpbGwgdmVyeSBkZXRlcm1pbmlzdGlj
DQpyZW1haW5zLCBhbmQgdGhpcyBmZWF0dXJlIG9mIGl0IGhhcyBiZWVuIHV0aWxpemVkIG1hbnkg
dGltZXMgaW4gYXR0YWNrcy4gDQpXZSBkb24ndCBrbm93IHdoZXJlIGNyZWF0aXZlIGF0dGFja2Vy
cyB3b3VsZCBnbyBuZXh0IGFuZCB3aGF0IHRoZXkNCmNhbiB1c2UgdG8gbW91bnQgbmV4dCBrZXJu
ZWwgc3RhY2stYmFzZWQgYXR0YWNrLCBidXQgSSB0aGluayB0aGlzIGlzIGp1c3QNCmEgcXVlc3Rp
b24gb2YgdGltZS4gSSBkb24ndCBiZWxpZXZlIHdlIGNhbiBjbGFpbSB0aGF0IGN1cnJlbnRseSBM
aW51eCBrZXJuZWwNCnRocmVhZCBzdGFjayBpcyBpbW11bmUgZnJvbSBhdHRhY2tzLg0KDQpTbywg
aWYgd2UgY2FuIGFkZCBhIHByb3RlY3Rpb24gdGhhdCBpcyBub3QgaW52YXNpdmUsIGJvdGggb24g
Y29kZSBhbmQgcGVyZm9ybWFuY2UsDQphbmQgd2hpY2ggbWlnaHQgbWFrZSB0aGUgYXR0YWNrZXIn
cyBsaWZlIGNvbnNpZGVyYWJseSBoYXJkZXIsIHdoeSBub3QgbWFraW5nIGl0PyANCg0KPiANCj4g
PiA+IFRoZSBtYWluIGlzc3VlIHdpdGggdGhpcyBhcHByb2FjaCBpcyB0aGF0IGl0IHNsaWdodGx5
IGJyZWFrcyB0aGUNCj4gPiA+IHByb2Nlc3Npbmcgb2YgbGFzdCBmcmFtZSBpbiB0aGUgdW53aW5k
ZXIsIHNvIEkgaGF2ZSBtYWRlIGEgc2ltcGxlDQo+ID4gPiBmaXggdG8gdGhlIGZyYW1lIHBvaW50
ZXIgdW53aW5kZXIgKEkgZ3Vlc3Mgb3RoZXJzIHNob3VsZCBiZSBmaXhlZA0KPiA+ID4gc2ltaWxh
cmx5KSBhbmQgc3RhY2sgZHVtcCBmdW5jdGlvbmFsaXR5IHRvICJqdW1wIiBvdmVyIHRoZSByYW5k
b20gaG9sZQ0KPiA+ID4gYXQgdGhlIGVuZC4gTXkgd2F5IG9mIHNvbHZpbmcgdGhpcyBpcyBwcm9i
YWJseSBmYXIgZnJvbSBpZGVhbCwNCj4gPiA+IHNvIEkgd291bGQgcmVhbGx5IGFwcHJlY2lhdGUg
ZmVlZGJhY2sgb24gaG93IHRvIGltcHJvdmUgaXQuDQo+ID4NCj4gPiBUaGF0J3MgcHJvYmFibHkg
YSBxdWVzdGlvbiBmb3IgSm9zaCA6KQ0KPiA+DQo+ID4gQW5vdGhlciB3YXkgdG8gZG8gdGhlIGRp
cnR5IHdvcmsgd291bGQgYmUgdG8gZG86DQo+ID4NCj4gPiAgICAgY2hhciAqcHRyID0gYWxsb2Nh
KG9mZnNldCk7DQo+ID4gICAgIGFzbSB2b2xhdGlsZSAoIiIgOjogIm0iICgqcHRyKSk7DQo+ID4N
Cj4gPiBpbiBkb19zeXNjYWxsXzY0KCkgYW5kIGFkanVzdCBjb21waWxlciBmbGFncyBhcyBuZWVk
ZWQgdG8gYXZvaWQgd2FybmluZ3MuICBIbW0uDQo+IA0KPiBJIGxpa2UgdGhlIGFsbG9jYSgpIGlk
ZWEgYSBsb3QuICBJZiB5b3UgZG8gdGhlIHN0YWNrIGFkanVzdG1lbnQgaW4gQywNCj4gdGhlbiBl
dmVyeXRoaW5nIHNob3VsZCBqdXN0IHdvcmssIHdpdGggbm8gY3VzdG9tIGhhY2tzIGluIGVudHJ5
IGNvZGUgb3INCj4gdGhlIHVud2luZGVycy4NCg0KT2ssIHNvIG1heWJlIHRoaXMgaXMgd2hhdCBJ
IGFtIGdvaW5nIHRvIHRyeSBuZXh0IHRoZW4uIA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==
