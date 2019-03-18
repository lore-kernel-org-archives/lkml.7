Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E3C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717A92133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCRSUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:20:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:29909 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfCRSUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:20:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 11:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="308255279"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 11:20:41 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 18 Mar 2019 11:20:41 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.91]) with mapi id 14.03.0415.000;
 Mon, 18 Mar 2019 11:20:41 -0700
From:   "DSouza, Nelson" <nelson.dsouza@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Tony Jones <tonyj@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "eranian@google.com" <eranian@google.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 4.14 31/34] perf/x86/intel: Fix memory corruption
Thread-Topic: [PATCH 4.14 31/34] perf/x86/intel: Fix memory corruption
Thread-Index: AQHU3W4CxBpVHj9eWUWGK6VdnZAdN6YRsl2w
Date:   Mon, 18 Mar 2019 18:20:40 +0000
Message-ID: <BC9B17E68BB84346BEE0B491BDB7D8AE28A68B05@ORSMSX101.amr.corp.intel.com>
References: <20190318084144.657740413@linuxfoundation.org>
 <20190318084149.364327318@linuxfoundation.org>
In-Reply-To: <20190318084149.364327318@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODY5OTViNDAtMzJiYS00NjQyLThmM2ItNTBkOTBlNzY5Y2YxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiM2FTMkhzdkhGbG5HZ2hsbUZPTDhnT3NybGNXVUV0MzRjY25BcVFoa1JYTGNBSUxrdE5vVnFjME1qbzhMSGUrbCJ9
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KSSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhlIGtlcm5lbCBjcmFzaCBvbiA0
LjE0LCA0LjE5IGFuZCA0LjIwIGtlcm5lbHMuIFdpbGwgYXBwbHkgeW91ciBwYXRjaGVzIGFuZCBy
ZS10ZXN0Lg0KDQpUaGFua3MsDQpOZWxzb24NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEdyZWcgS3JvYWgtSGFydG1hbiBbbWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnXSANClNlbnQ6IE1vbmRheSwgTWFyY2ggMTgsIDIwMTkgMjoyNiBBTQ0KVG86IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgVG9ueSBKb25lcyA8dG9u
eWpAc3VzZS5jb20+OyBEU291emEsIE5lbHNvbiA8bmVsc29uLmRzb3V6YUBpbnRlbC5jb20+OyBQ
ZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgZXJhbmlhbkBnb29nbGUuY29tOyBqb2xzYUByZWRo
YXQuY29tOyBzdGFibGVAa2VybmVsLm9yZw0KU3ViamVjdDogW1BBVENIIDQuMTQgMzEvMzRdIHBl
cmYveDg2L2ludGVsOiBGaXggbWVtb3J5IGNvcnJ1cHRpb24NCg0KNC4xNC1zdGFibGUgcmV2aWV3
IHBhdGNoLiAgSWYgYW55b25lIGhhcyBhbnkgb2JqZWN0aW9ucywgcGxlYXNlIGxldCBtZSBrbm93
Lg0KDQotLS0tLS0tLS0tLS0tLS0tLS0NCg0KRnJvbTogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPg0KDQpjb21taXQgZWRlMjcxYjA1OTQ2MzczMWNiZDZkZmZlNTVmZmQ3MGQ3
ZGJlODM5MiB1cHN0cmVhbS4NCg0KVGhyb3VnaDoNCg0KICB2YWxpZGF0ZV9ldmVudCgpDQogICAg
eDg2X3BtdS5nZXRfZXZlbnRfY29uc3RyYWludHMoLmlkeD0tMSkNCiAgICAgIHRmYV9nZXRfZXZl
bnRfY29uc3RyYWludHMoKQ0KICAgICAgICBkeW5fY29uc3RyYWludCgpDQoNCmNwdWMtPmNvbnN0
cmFpbnRfbGlzdFstMV0gaXMgdXNlZCwgd2hpY2ggaXMgYW4gb2J2aW91cyBvdXQtb2YtYm91bmQg
YWNjZXNzLg0KDQpJbiB0aGlzIGNhc2UsIHNpbXBseSBza2lwIHRoZSBURkEgY29uc3RyYWludCBj
b2RlLCB0aGVyZSBpcyBubyBldmVudCBjb25zdHJhaW50IHdpdGgganVzdCBQTUMzLCB0aGVyZWZv
cmUgdGhlIGNvZGUgd2lsbCBuZXZlciByZXN1bHQgaW4gdGhlIGVtcHR5IHNldC4NCg0KRml4ZXM6
IDQwMDgxNmY2MGM1NCAoInBlcmYveDg2L2ludGVsOiBJbXBsZW1lbnQgc3VwcG9ydCBmb3IgVFNY
IEZvcmNlIEFib3J0IikNClJlcG9ydGVkLWJ5OiBUb255IEpvbmVzIDx0b255akBzdXNlLmNvbT4N
ClJlcG9ydGVkLWJ5OiAiRFNvdXphLCBOZWxzb24iIDxuZWxzb24uZHNvdXphQGludGVsLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQu
b3JnPg0KU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
DQpUZXN0ZWQtYnk6IFRvbnkgSm9uZXMgPHRvbnlqQHN1c2UuY29tPg0KVGVzdGVkLWJ5OiAiRFNv
dXphLCBOZWxzb24iIDxuZWxzb24uZHNvdXphQGludGVsLmNvbT4NCkNjOiBlcmFuaWFuQGdvb2ds
ZS5jb20NCkNjOiBqb2xzYUByZWRoYXQuY29tDQpDYzogc3RhYmxlQGtlcm5lbC5vcmcNCkxpbms6
IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTAzMTQxMzA3MDUuNDQxNTQ5Mzc4QGluZnJh
ZGVhZC5vcmcNClNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQoNCi0tLQ0KIGFyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMgfCAg
ICAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
Ci0tLSBhL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCisrKyBiL2FyY2gveDg2L2V2ZW50
cy9pbnRlbC9jb3JlLmMNCkBAIC0zMjYyLDcgKzMyNjIsNyBAQCB0ZmFfZ2V0X2V2ZW50X2NvbnN0
cmFpbnRzKHN0cnVjdCBjcHVfaHdfDQogCS8qDQogCSAqIFdpdGhvdXQgVEZBIHdlIG11c3Qgbm90
IHVzZSBQTUMzLg0KIAkgKi8NCi0JaWYgKCFhbGxvd190c3hfZm9yY2VfYWJvcnQgJiYgdGVzdF9i
aXQoMywgYy0+aWR4bXNrKSkgew0KKwlpZiAoIWFsbG93X3RzeF9mb3JjZV9hYm9ydCAmJiB0ZXN0
X2JpdCgzLCBjLT5pZHhtc2spICYmIGlkeCA+PSAwKSB7DQogCQljID0gZHluX2NvbnN0cmFpbnQo
Y3B1YywgYywgaWR4KTsNCiAJCWMtPmlkeG1zazY0ICY9IH4oMVVMTCA8PCAzKTsNCiAJCWMtPndl
aWdodC0tOw0KDQoNCg==
