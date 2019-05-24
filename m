Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAC3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9260B2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391781AbfEXUIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:08:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:6671 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391612AbfEXUIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:08:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 13:08:45 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 13:08:44 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 24 May 2019 13:08:44 -0700
Received: from crsmsx104.amr.corp.intel.com (172.18.63.32) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 24 May 2019 13:08:44 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.116]) by
 CRSMSX104.amr.corp.intel.com ([169.254.6.192]) with mapi id 14.03.0415.000;
 Fri, 24 May 2019 14:08:42 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC] mm/swap: make release_pages() and put_pages() match
Thread-Topic: [PATCH RFC] mm/swap: make release_pages() and put_pages() match
Thread-Index: AQHVEmeV6lwaEiR3+E6UJvvneFDW0qZ7EgQA//+iDIA=
Date:   Fri, 24 May 2019 20:08:42 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79D3ACC3@CRSMSX101.amr.corp.intel.com>
References: <20190524193415.9733-1-ira.weiny@intel.com>
 <CALvZod6skK6NxeRXjKS64+1jpF9NwbLp7DhpWueB0F6Tj4MNUw@mail.gmail.com>
In-Reply-To: <CALvZod6skK6NxeRXjKS64+1jpF9NwbLp7DhpWueB0F6Tj4MNUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDJlYzY3Y2ItYjdlMC00NDc0LThlN2EtNDZmODQxOTFlNTUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWGhaUUYxZ29XQW9TaXRNU2VBVHFcL0tkRWJrdDN3OFlUcFJyNFNKRmJmYWVubmZvVkdDTzFDRWU3VmtFcDc3b3kifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gRnJpLCBNYXkgMjQsIDIwMTkgYXQgMTI6MzMgUE0gPGlyYS53ZWlueUBpbnRlbC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29t
Pg0KPiA+DQo+ID4gUkZDIEkgaGF2ZSBubyBpZGVhIGlmIHRoaXMgaXMgY29ycmVjdCBvciBub3Qu
ICBCdXQgbG9va2luZyBhdA0KPiA+IHJlbGVhc2VfcGFnZXMoKSBJIHNlZSBhIGNhbGwgdG8gYm90
aCBfX0NsZWFyUGFnZUFjdGl2ZSgpIGFuZA0KPiA+IF9fQ2xlYXJQYWdlV2FpdGVycygpIHdoaWxl
IGluIF9fcGFnZV9jYWNoZV9yZWxlYXNlKCkgSSBkbyBub3QuDQo+ID4NCj4gPiBJcyB0aGlzIGEg
YnVnIHdoaWNoIG5lZWRzIHRvIGJlIGZpeGVkPyAgRGlkIEkgbWlzcyBjbGVhcmluZyBhY3RpdmUN
Cj4gPiBzb21ld2hlcmUgZWxzZSBpbiB0aGUgY2FsbCBjaGFpbiBvZiBwdXRfcGFnZT8NCj4gPg0K
PiA+IFRoaXMgd2FzIGZvdW5kIHZpYSBjb2RlIGluc3BlY3Rpb24gd2hpbGUgZGV0ZXJtaW5pbmcg
aWYNCj4gPiByZWxlYXNlX3BhZ2VzKCkgYW5kIHRoZSBuZXcgcHV0X3VzZXJfcGFnZXMoKSBjb3Vs
ZCBiZSBpbnRlcmNoYW5nZWFibGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBJcmEgV2Vpbnkg
PGlyYS53ZWlueUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIG1tL3N3YXAuYyB8IDEgKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9t
bS9zd2FwLmMgYi9tbS9zd2FwLmMNCj4gPiBpbmRleCAzYTc1NzIyZTY4YTkuLjlkMDQzMmJhZGRi
MCAxMDA2NDQNCj4gPiAtLS0gYS9tbS9zd2FwLmMNCj4gPiArKysgYi9tbS9zd2FwLmMNCj4gPiBA
QCAtNjksNiArNjksNyBAQCBzdGF0aWMgdm9pZCBfX3BhZ2VfY2FjaGVfcmVsZWFzZShzdHJ1Y3Qg
cGFnZSAqcGFnZSkNCj4gPiAgICAgICAgICAgICAgICAgZGVsX3BhZ2VfZnJvbV9scnVfbGlzdChw
YWdlLCBscnV2ZWMsDQo+ID4gcGFnZV9vZmZfbHJ1KHBhZ2UpKTsNCj4gDQo+IHNlZSBwYWdlX29m
Zl9scnUocGFnZSkgYWJvdmUgd2hpY2ggY2xlYXIgYWN0aXZlIGJpdC4NCg0KVGhhbmtzLCAgU29y
cnkgZm9yIHRoZSBub2lzZSwNCklyYQ0KDQoNCj4gDQo+ID4gICAgICAgICAgICAgICAgIHNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJnBnZGF0LT5scnVfbG9jaywgZmxhZ3MpOw0KPiA+ICAgICAgICAg
fQ0KPiA+ICsgICAgICAgX19DbGVhclBhZ2VBY3RpdmUocGFnZSk7DQo+ID4gICAgICAgICBfX0Ns
ZWFyUGFnZVdhaXRlcnMocGFnZSk7DQo+ID4gICAgICAgICBtZW1fY2dyb3VwX3VuY2hhcmdlKHBh
Z2UpOw0KPiA+ICB9DQo+ID4gLS0NCj4gPiAyLjIwLjENCj4gPg0K
