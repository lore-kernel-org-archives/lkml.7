Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA47CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55FF20989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfCRU3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:29:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:43060 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfCRU3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:29:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 13:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="329757621"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2019 13:29:37 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.119]) with mapi id 14.03.0415.000;
 Mon, 18 Mar 2019 13:29:37 -0700
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
Thread-Index: AQHU3W4CxBpVHj9eWUWGK6VdnZAdN6YRsl2wgAAjrJA=
Date:   Mon, 18 Mar 2019 20:29:37 +0000
Message-ID: <BC9B17E68BB84346BEE0B491BDB7D8AE28A68B8A@ORSMSX101.amr.corp.intel.com>
References: <20190318084144.657740413@linuxfoundation.org>
 <20190318084149.364327318@linuxfoundation.org> 
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

V2l0aCB0aGUgcGF0Y2gsIHRoZSBrZXJuZWwgY3Jhc2ggaXMgbm90IHNlZW4gb24gNC4xNCwgNC4x
OSBhbmQgNC4yMCBrZXJuZWxzLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
RFNvdXphLCBOZWxzb24gDQpTZW50OiBNb25kYXksIE1hcmNoIDE4LCAyMDE5IDExOjIxIEFNDQpU
bzogJ0dyZWcgS3JvYWgtSGFydG1hbicgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IFRv
bnkgSm9uZXMgPHRvbnlqQHN1c2UuY29tPjsgUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+OyBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IGVy
YW5pYW5AZ29vZ2xlLmNvbTsgam9sc2FAcmVkaGF0LmNvbTsgc3RhYmxlQGtlcm5lbC5vcmcNClN1
YmplY3Q6IFJFOiBbUEFUQ0ggNC4xNCAzMS8zNF0gcGVyZi94ODYvaW50ZWw6IEZpeCBtZW1vcnkg
Y29ycnVwdGlvbg0KDQpIaSBHcmVnLA0KDQpJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGUga2Vy
bmVsIGNyYXNoIG9uIDQuMTQsIDQuMTkgYW5kIDQuMjAga2VybmVscy4gV2lsbCBhcHBseSB5b3Vy
IHBhdGNoZXMgYW5kIHJlLXRlc3QuDQoNClRoYW5rcywNCk5lbHNvbg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIFttYWlsdG86Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmddIA0KU2VudDogTW9uZGF5LCBNYXJjaCAxOCwgMjAxOSAyOjI2IEFN
DQpUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KQ2M6IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBU
b255IEpvbmVzIDx0b255akBzdXNlLmNvbT47IERTb3V6YSwgTmVsc29uIDxuZWxzb24uZHNvdXph
QGludGVsLmNvbT47IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBlcmFuaWFuQGdvb2dsZS5j
b207IGpvbHNhQHJlZGhhdC5jb207IHN0YWJsZUBrZXJuZWwub3JnDQpTdWJqZWN0OiBbUEFUQ0gg
NC4xNCAzMS8zNF0gcGVyZi94ODYvaW50ZWw6IEZpeCBtZW1vcnkgY29ycnVwdGlvbg0KDQo0LjE0
LXN0YWJsZSByZXZpZXcgcGF0Y2guICBJZiBhbnlvbmUgaGFzIGFueSBvYmplY3Rpb25zLCBwbGVh
c2UgbGV0IG1lIGtub3cuDQoNCi0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpGcm9tOiBQZXRlciBaaWps
c3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQoNCmNvbW1pdCBlZGUyNzFiMDU5NDYzNzMxY2Jk
NmRmZmU1NWZmZDcwZDdkYmU4MzkyIHVwc3RyZWFtLg0KDQpUaHJvdWdoOg0KDQogIHZhbGlkYXRl
X2V2ZW50KCkNCiAgICB4ODZfcG11LmdldF9ldmVudF9jb25zdHJhaW50cyguaWR4PS0xKQ0KICAg
ICAgdGZhX2dldF9ldmVudF9jb25zdHJhaW50cygpDQogICAgICAgIGR5bl9jb25zdHJhaW50KCkN
Cg0KY3B1Yy0+Y29uc3RyYWludF9saXN0Wy0xXSBpcyB1c2VkLCB3aGljaCBpcyBhbiBvYnZpb3Vz
IG91dC1vZi1ib3VuZCBhY2Nlc3MuDQoNCkluIHRoaXMgY2FzZSwgc2ltcGx5IHNraXAgdGhlIFRG
QSBjb25zdHJhaW50IGNvZGUsIHRoZXJlIGlzIG5vIGV2ZW50IGNvbnN0cmFpbnQgd2l0aCBqdXN0
IFBNQzMsIHRoZXJlZm9yZSB0aGUgY29kZSB3aWxsIG5ldmVyIHJlc3VsdCBpbiB0aGUgZW1wdHkg
c2V0Lg0KDQpGaXhlczogNDAwODE2ZjYwYzU0ICgicGVyZi94ODYvaW50ZWw6IEltcGxlbWVudCBz
dXBwb3J0IGZvciBUU1ggRm9yY2UgQWJvcnQiKQ0KUmVwb3J0ZWQtYnk6IFRvbnkgSm9uZXMgPHRv
bnlqQHN1c2UuY29tPg0KUmVwb3J0ZWQtYnk6ICJEU291emEsIE5lbHNvbiIgPG5lbHNvbi5kc291
emFAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4NClRlc3RlZC1ieTogVG9ueSBKb25lcyA8dG9ueWpAc3VzZS5jb20+DQpU
ZXN0ZWQtYnk6ICJEU291emEsIE5lbHNvbiIgPG5lbHNvbi5kc291emFAaW50ZWwuY29tPg0KQ2M6
IGVyYW5pYW5AZ29vZ2xlLmNvbQ0KQ2M6IGpvbHNhQHJlZGhhdC5jb20NCkNjOiBzdGFibGVAa2Vy
bmVsLm9yZw0KTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MDMxNDEzMDcwNS40
NDE1NDkzNzhAaW5mcmFkZWFkLm9yZw0KU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFu
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCg0KLS0tDQogYXJjaC94ODYvZXZlbnRzL2lu
dGVsL2NvcmUuYyB8ICAgIDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KLS0tIGEvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0KKysrIGIv
YXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0KQEAgLTMyNjIsNyArMzI2Miw3IEBAIHRmYV9n
ZXRfZXZlbnRfY29uc3RyYWludHMoc3RydWN0IGNwdV9od18NCiAJLyoNCiAJICogV2l0aG91dCBU
RkEgd2UgbXVzdCBub3QgdXNlIFBNQzMuDQogCSAqLw0KLQlpZiAoIWFsbG93X3RzeF9mb3JjZV9h
Ym9ydCAmJiB0ZXN0X2JpdCgzLCBjLT5pZHhtc2spKSB7DQorCWlmICghYWxsb3dfdHN4X2ZvcmNl
X2Fib3J0ICYmIHRlc3RfYml0KDMsIGMtPmlkeG1zaykgJiYgaWR4ID49IDApIHsNCiAJCWMgPSBk
eW5fY29uc3RyYWludChjcHVjLCBjLCBpZHgpOw0KIAkJYy0+aWR4bXNrNjQgJj0gfigxVUxMIDw8
IDMpOw0KIAkJYy0+d2VpZ2h0LS07DQoNCg0K
