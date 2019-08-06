Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D014C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3851C20679
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfHFQKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:10:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:58388 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732203AbfHFQKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:10:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 09:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="198355562"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2019 09:10:16 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.96]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.157]) with mapi id 14.03.0439.000;
 Tue, 6 Aug 2019 09:10:16 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: RE: [PATCH V2] fork: Improve error message for corrupted page tables
Thread-Topic: [PATCH V2] fork: Improve error message for corrupted page
 tables
Thread-Index: AQHVTARBoUI2WxhjVEayaDrB3An0D6buNXYAgAAUpHA=
Date:   Tue, 6 Aug 2019 16:10:16 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4FA16EF9@ORSMSX114.amr.corp.intel.com>
References: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
 <5ba88460-cf01-3d53-6d13-45e650b4eacd@suse.cz>
In-Reply-To: <5ba88460-cf01-3d53-6d13-45e650b4eacd@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjY0MjgyNjMtNzcwZC00Yzk1LWE0NzEtNDY0NWU5ZTcxYzg2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaUJ5clZZdENIcktBbmpycTA5TER2Vlk2QVJPZlVEUElwXC93MzZIOVwvTG5Tb1VcL3l4MEw3XC9YUXVVUzlvcDhUbVwvIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: request-justification,no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFdpdGggcGF0Y2g6DQo+ID4gLS0tLS0tLS0tLS0NCj4gPiBbICAgNjkuODE1NDUzXSBtbS9w
Z3RhYmxlLWdlbmVyaWMuYzoyOTogYmFkIHA0ZA0KPiAwMDAwMDAwMDg0NjUzNjQyKDgwMDAwMDAy
NWNhMzc0NjcpDQo+ID4gWyAgIDY5LjgxNTg3Ml0gQlVHOiBCYWQgcnNzLWNvdW50ZXIgc3RhdGUg
bW06MDAwMDAwMDAwMTRhNmMwMw0KPiB0eXBlOk1NX0ZJTEVQQUdFUyB2YWw6Mg0KPiA+IFsgICA2
OS44MTU5NjJdIEJVRzogQmFkIHJzcy1jb3VudGVyIHN0YXRlIG1tOjAwMDAwMDAwMDE0YTZjMDMN
Cj4gdHlwZTpNTV9BTk9OUEFHRVMgdmFsOjUNCj4gPiBbICAgNjkuODE2MDUwXSBCVUc6IG5vbi16
ZXJvIHBndGFibGVzX2J5dGVzIG9uIGZyZWVpbmcgbW06IDIwNDgwDQo+ID4NCj4gPiBBbHNvLCBj
aGFuZ2UgcHJpbnQgZnVuY3Rpb24gKGZyb20gcHJpbnRrKEtFUk5fQUxFUlQsIC4uKSB0bw0KPiA+
IHByX2FsZXJ0KCkpIHNvIHRoYXQgaXQgbWF0Y2hlcyB0aGUgb3RoZXIgcHJpbnQgc3RhdGVtZW50
Lg0KPiA+DQo+ID4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiA+IENjOiBW
bGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pg0KPiA+IENjOiBQZXRlciBaaWpsc3RyYSA8
cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+ID4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+DQo+ID4gQ2M6IEFuc2h1bWFuIEtoYW5kdWFsIDxhbnNodW1hbi5raGFu
ZHVhbEBhcm0uY29tPg0KPiA+IEFja2VkLWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50
ZWwuY29tPg0KPiA+IFN1Z2dlc3RlZC1ieTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVs
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWkgUHJhbmVldGggUHJha2h5YSA8c2FpLnByYW5l
ZXRoLnByYWtoeWFAaW50ZWwuY29tPg0KPiANCj4gQWNrZWQtYnk6IFZsYXN0aW1pbCBCYWJrYSA8
dmJhYmthQHN1c2UuY3o+DQo+IA0KPiBJIHdvdWxkIGFsc28gYWRkIHNvbWV0aGluZyBsaWtlIHRo
aXMgdG8gcmVkdWNlIHJpc2sgb2YgYnJlYWtpbmcgaXQgaW4gdGhlDQo+IGZ1dHVyZToNCg0KU3Vy
ZSEgU291bmRzIGdvb2QgdG8gbWUuIFdpbGwgYWRkIGl0IHRvIFYzLg0KDQpSZWdhcmRzLA0KU2Fp
DQo=
