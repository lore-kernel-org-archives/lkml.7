Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB78C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453232087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfC0BvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:51:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:51273 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfC0BvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:51:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 18:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="145524779"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2019 18:51:00 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 26 Mar 2019 18:51:00 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 26 Mar 2019 18:50:59 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.57]) with mapi id 14.03.0415.000;
 Wed, 27 Mar 2019 09:50:58 +0800
From:   "Zhang, Jun" <jun.zhang@intel.com>
To:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "He, Bo" <bo.he@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: RE: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Thread-Topic: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Thread-Index: AQHU4KqYqvmIcV2TkUOhSnG4am5KzqYXST2AgADz6ICAA8MXgIABGF2AgAB4qoCAASo2QA==
Date:   Wed, 27 Mar 2019 01:50:57 +0000
Message-ID: <88DC34334CA3444C85D647DBFA962C2735B04EB8@SHSMSX104.ccr.corp.intel.com>
References: <20190322111210.465931067@linuxfoundation.org>
 <20190322111220.102008032@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A646D1@SHSMSX104.ccr.corp.intel.com>
 <20190323063315.GB31361@kroah.com> <20190325160017.GD4102@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A6526B@SHSMSX104.ccr.corp.intel.com>
 <20190326155537.GO4102@linux.ibm.com>
In-Reply-To: <20190326155537.GO4102@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmFlYWI3MjItNGJkYy00NDg2LWJlNTEtODFhNTNjODRjZTc5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWGpFa0c4Z1RJa0FldjZYc0lZUVFvV29MTnNZelwvZnZjVmg4NEhSUU9KVW9LcVdEMG5sQkxYdDdkTzBwS3pudE8ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG+jrFBhdWwNCg0KSSB1c2UgYSBuZXcgTlVDIChtYWRlIGluIDIwMTcpIHRvIHRlc3QsIG1l
ZXQgdGhlIHNhbWUgaGFuZy4gU3lzdGVtIHJ1biB2ZXJ5IHNsb3dseS4NCg0KQnV0IEkgdXNlIG15
IFBDIChtYWRlIGJlZm9yZSAyMDE1KSwgdGVzdCBWMy4xOC4xMzYrIHBhdGNoIGZvciAxMiBob3Vy
cywgc3RpbGwgd2VsbC4NCg0KTWF5YmUgVjMuMTgueSBkb24ndCBzdXBwb3J0IHNvbWUgbmV3IGRl
dmljZXMuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhdWwgRS4gTWNL
ZW5uZXkgW21haWx0bzpwYXVsbWNrQGxpbnV4LmlibS5jb21dIA0KU2VudDogVHVlc2RheSwgTWFy
Y2ggMjYsIDIwMTkgMjM6NTYNClRvOiBIZSwgQm8gPGJvLmhlQGludGVsLmNvbT4NCkNjOiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgWmhhbmcsIEp1biA8anVu
LnpoYW5nQGludGVsLmNvbT47IFhpYW8sIEppbiA8amluLnhpYW9AaW50ZWwuY29tPjsgQmFpLCBK
aWUgQSA8amllLmEuYmFpQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMy4xOCAxMzIv
MTM0XSByY3U6IERvIFJDVSBHUCBrdGhyZWFkIHNlbGYtd2FrZXVwIGZyb20gc29mdGlycSBhbmQg
aW50ZXJydXB0DQoNCk9uIFR1ZSwgTWFyIDI2LCAyMDE5IGF0IDA4OjQzOjQ1QU0gKzAwMDAsIEhl
LCBCbyB3cm90ZToNCj4gSGksIFBhdWw6DQo+IAlJIGhhdmUgdHJpZWQgb24gbXkgUEMgYW5kIG5v
dCBoaXQgYW55IGhhbmcgaXNzdWUgd2l0aCBSQ1UgdG9ydHVyZSB0ZXN0IGZvciBvbmUgaG91ciwg
dGhlIGNvbmZpZ3VyYXRpb25zIGFyZSBsaWtlOg0KPiBPUzogdWJ1bnR1IDE2LjA0DQo+IGtlbnJl
bDogMy4xOC4xMzYgKyAzLjE4IHJjdSBwYXRjaA0KPiBDUFU6ICBJbnRlbChSKSBYZW9uKFIpIENQ
VSBFMy0xMjI1IFYyIEAgMy4yMEdIeg0KDQpTb3VuZHMgZ29vZCwgcGxlYXNlIHByb2NlZWQhDQoN
CgkJCQkJCQlUaGFueCwgUGF1bA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAbGludXguaWJtLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgTWFyY2ggMjYsIDIwMTkgMTI6MDAgQU0NCj4gVG86IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IENjOiBIZSwgQm8gPGJvLmhlQGludGVsLmNv
bT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnOyBaaGFuZywgSnVuIDxqdW4uemhhbmdAaW50ZWwuY29tPjsgWGlhbywgSmluIA0KPiA8amlu
LnhpYW9AaW50ZWwuY29tPjsgQmFpLCBKaWUgQSA8amllLmEuYmFpQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAzLjE4IDEzMi8xMzRdIHJjdTogRG8gUkNVIEdQIGt0aHJlYWQgc2Vs
Zi13YWtldXAgDQo+IGZyb20gc29mdGlycSBhbmQgaW50ZXJydXB0DQo+IA0KPiBPbiBTYXQsIE1h
ciAyMywgMjAxOSBhdCAwNzozMzoxNUFNICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6
DQo+ID4gT24gRnJpLCBNYXIgMjIsIDIwMTkgYXQgMDQ6MDA6MTdQTSArMDAwMCwgSGUsIEJvIHdy
b3RlOg0KPiA+ID4gSGksIEdyZWc6DQo+ID4gPiAJQ2FuIHlvdSBob2xkIG9uIHRoZSAzLjE4LXN0
YWJsZSBicmFuY2gsIGl0IHNlZW1zIHRoZXJlIGFyZSBzb21lIGlzc3VlLCBwbGVhc2Ugc2VlIHRo
ZSBjb21tZW50cyBmcm9tIFBhdWw6DQo+ID4gPiANCj4gPiA+IENvbW1lbnRzIGZyb20gUGF1bDoN
Cj4gPiA+IEkgc3ViamVjdGVkIGFsbCBvZiB0aGUgb3RoZXJzIHRvIGxpZ2h0IHJjdXRvcnR1cmUg
dGVzdGluZywgd2hpY2ggDQo+ID4gPiB0aGV5IHBhc3NlZC4gIFRoaXMgdjMuMTggcGF0Y2ggaHVu
ZywgaG93ZXZlci4gIFRyeWluZyBpdCBhZ2FpbiANCj4gPiA+IHdpdGggc3RvY2sNCj4gPiA+IHYz
LjE4IGdvdCB0aGUgc2FtZSBoYW5nLCBzbyBJIGJlbGlldmUgd2UgY2FuIGV4b25lcmF0ZSB0aGUg
cGF0Y2ggYW5kIGdpdmUgaXQgYSBnb29kIGZpcm0gIm1heWJlIiBvbiAzLjE4Lg0KPiA+ID4gDQo+
ID4gPiBXb3J0aCBwYXlpbmcgc3BlY2lhbCBhdHRlbnRpb24gdG8gZnVydGhlciB0ZXN0IHJlc3Vs
dHMgZnJvbSAzLjE4LngsIHRob3VnaCENCj4gPiANCj4gPiBPaywgSSd2ZSBkcm9wcGVkIHRoaXMg
ZnJvbSB0aGUgMy4xOC55IHF1ZXVlIG5vdywgdGhhbmtzLg0KPiANCj4gQm8sIGlmIHlvdSBrbm93
IG9mIGEgInkiIGZvciAzLjE4LnkgdGhhdCB3b3VsZCBsaWtlbHkgcGFzcyByY3V0b3J0dXJlIHRl
c3RpbmcsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IAkJCQkJCQlUaGFueCwgUGF1bA0KPiAN
Cg0K
