Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D90AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B45218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfCTX2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:28:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:59419 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCTX2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:28:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 16:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,250,1549958400"; 
   d="scan'208";a="156860089"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2019 16:28:41 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 20 Mar 2019 16:28:40 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.192]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.56]) with mapi id 14.03.0415.000;
 Wed, 20 Mar 2019 16:28:40 -0700
From:   "Yang, Fei" <fei.yang@intel.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "andrzej.p@collabora.com" <andrzej.p@collabora.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Josh Gao <jmgao@google.com>,
        "Alistair Strachan" <astrachan@google.com>,
        "Shen, JingX" <jingx.shen@intel.com>
Subject: RE: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
Thread-Topic: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
Thread-Index: AQHU3t5XE8/CBxAewk+Cmpw9nrOH2aYVLtiA///6c4A=
Date:   Wed, 20 Mar 2019 23:28:39 +0000
Message-ID: <02E7334B1630744CBDC55DA8586225837F7FB935@ORSMSX102.amr.corp.intel.com>
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
 <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com>
In-Reply-To: <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTFhZmEzZDEtZGVkYi00YWIxLTg1ZjUtMWQ2YThkN2VkMzkwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidkdHdElZYkVvSTZTcUN2aWpBOWhITW9aUWVuRFdITlVSVUFPQ1A4dWx0c2R4eGwzMFgxR2ZDdUMzODgxc1hpaiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIZXkgRmVpLA0KPiAgU28gd2hpbGUgdGhpcyBwYXRjaCBkb2VzIHJlc29sdmUgdGhlIGlzc3Vl
cyBJIHdhcyBzZWVpbmcgd2l0aCBtYWlubGluZSBrZXJuZWxzIGFuZCByZWNlbnQgY2hhbmdlcyB0
byBhZGJkLA0KPiBKb3NoIHBvaW50ZWQgb3V0IHRoYXQgaXQgd291bGRuJ3QgcmVzb2x2ZSB0aGUg
aXNzdWVzIEkgd2FzIHNlZWluZyB3aXRoIG9sZGVyIGtlcm5lbHMgd2hpY2ggaXMgc2xpZ2h0bHkg
ZGlmZmVyZW50IChidXQgc3RpbGwgcmVsYXRlZCB0byBhaW8gdXNhZ2UpLg0KPiANCj4gT24gdGhl
IG9sZGVyIGtlcm5lbHMgSSdtIGhpdHRpbmcgc2NoZWR1bGluZyB3aGlsZSBhdG9taWMgb24gcmVi
b290LCB3aGljaCBzZWVtcyB0byBiZSBkdWUgdG8gZmZzX2Fpb19jYW5jZWwoKSB0YWtpbmcgYSBz
cGlubG9jayB0aGVuIGNhbGxpbmcgdXNiX2VwX2RlcXVldWUoKSB3aGljaCBtaWdodCBzbGVlcC4N
Cj4gDQo+IEl0IHNlZW1zIGEgZml4IGZvciB0aGlzIHdhcyB0cmllZCBlYXJsaWVyIHdpdGggZDUy
ZTRkMGMwYzQyOCAoInVzYjoNCj4gZ2FkZ2V0OiBmZnM6IEZpeCBCVUcgd2hlbiB1c2VybGFuZCBl
eGl0cyB3aXRoIHN1Ym1pdHRlZCBBSU8NCj4gdHJhbnNmZXJzIikgd2hpY2ggd2FzIHRoZW4gcmV2
ZXJ0ZWQgYnkgYTljODU5MDMzZjZlLg0KPiANCj4gRWxzZXdoZXJlIGl0IHNlZW1zIHRoZSBmZnMg
ZHJpdmVyIHRha2VzIGVmZm9ydCB0byBkcm9wIGFueSBsb2NrcyBiZWZvcmUgY2FsbGluZyB1c2Jf
ZXBfZGVxdWV1ZSgpLCBzbyB0aGlzIHNlZW1zIGxpa2UNCj4gdGhhdCBzaG91bGQgYmUgYWRkcmVz
c2VkLCBidXQgaXQgYWxzbyBzZWVtcyBsaWtlIHJlY2VudCBjaGFuZ2UgdG8gdGhlIGR3YzMgZHJp
dmVyIGhhcyBiZWVuIG1hZGUgdG8gYXZvaWQgc2xlZXBpbmcNCj4gaW4gdGhhdCBwYXRoIChzZWUg
ZmVjOTA5NWJkZWY0ICgidXNiOiBkd2MzOiBnYWRnZXQ6IHJlbW92ZSB3YWl0X2VuZF90cmFuc2Zl
ciIpKSwgd2hpY2ggbWF5IGJlIHdoeSBJJ20gbm90IHNlZWluZw0KPiB0aGUgcHJvYmxlbSB3aXRo
IG1haW5saW5lIChhbmQgeW91ciBwYXRjaCBoZXJlLCBvZiBjb2Fyc2UpLiBCdXQgdGhhdCBhbHNv
IGRvZXNuJ3QgY2xhcmlmeSBpZiBpdHMgc3RpbGwgYSBwb3RlbnRpYWwgaXNzdWUNCj4gdy8gbm9u
LWR3YzMgcGxhdGZvcm1zLg0KPiANCj4gU28gZm9yIG9sZGVyIGtlcm5lbHMsIGRvIHlvdSBoYXZl
IGEgc3VnZ2VzdGlvbiBvZiB3aGljaCBhcHByb2FjaCBpcyBhZHZpc2VkPyAgRG9lcyB1c2JfZXBf
ZGVxdWV1ZSBuZWVkIHRvIGF2b2lkDQo+IHNsZWVwaW5nIG9yIGRvIHdlIG5lZWQgdG8gcmV3b3Jr
IHRoZSBmZnNfYWlvX2NhbmNlbCBsb2dpYz8NCg0KQXJlIHlvdSBzZWVpbmcgdGhpcyBpc3N1ZSB3
aXRoIEFuZHJvaWQ/IFdoZW4gcnVubmluZyBhZGIgcmVib290Pw0KSSBoYXZlIHRyaWVkIDQuMTkg
YW5kIDQuOSBrZXJuZWwgd2l0aCBBbmRyb2lkIFAtZGVzc2VydCBvbiBvbmUgb2YgdGhlIEludGVs
IHBsYXRmb3JtcywgYnV0IG5vIGx1Y2sgb24gcmVwcm9kdWNpbmcgdGhlIGlzc3VlLg0KSSB3aWxs
IGdldCBiYWNrIHRvIHlvdSBpZiBJIGNvdWxkIHJlcHJvZHVjZSB0aGUgaXNzdWUuIEknbSBhZnJh
aWQgSSB3b27igJl0IGJlIGFibGUgdG8gZG8gbXVjaCBieSBqdXN0IGxvb2tpbmcgYXQgdGhlIGNv
ZGUuDQoNCg==
