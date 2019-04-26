Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EADC20878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfDZAFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:05:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:18239 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZAFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:05:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 17:05:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; 
   d="scan'208";a="134457201"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2019 17:05:03 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.17]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 17:05:03 -0700
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     Sasha Levin <sashal@kernel.org>, Joseph Yasi <joe.yasi@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "e1000-devel@lists.sourceforge.net" 
        <e1000-devel@lists.sourceforge.net>
Subject: RE: [PATCH 2/2] e1000e: start network tx queue only when link is up
Thread-Topic: [PATCH 2/2] e1000e: start network tx queue only when link is up
Thread-Index: AQHU9PWEP7ZO9G38rk2Elc+mnFjspaZNnE3w
Date:   Fri, 26 Apr 2019 00:05:02 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9703A79B@ORSMSX103.amr.corp.intel.com>
References: <155548879651.3454.13167784936351314661.stgit@buzz>
 <155548880068.3454.1621821881762819373.stgit@buzz>
In-Reply-To: <155548880068.3454.1621821881762819373.stgit@buzz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWVlZTJhZDctNTBlOS00NTA5LThiZWQtMmQzZTAzMmY3YWNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTlVkbUQ5OTlPTGx3aEN3cDN0eDd4TVNheGpGTFFyNTNibGkwQXhqV2g4dFljWnpJVEZjY2ZvUWt0TkQxS2w0YiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBLb25zdGFudGluIEtobGVibmlrb3YgW21haWx0bzpraGxlYm5pa292QHlhbmRleC10
ZWFtLnJ1XQ0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE3LCAyMDE5IDE6MTMgQU0NCj4gVG86
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2lyc2hlciwgSmVmZnJleSBUIDxq
ZWZmcmV5LnQua2lyc2hlckBpbnRlbC5jb20+DQo+IENjOiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtl
cm5lbC5vcmc+OyBKb3NlcGggWWFzaSA8am9lLnlhc2lAZ21haWwuY29tPjsNCj4gQnJvd24sIEFh
cm9uIEYgPGFhcm9uLmYuYnJvd25AaW50ZWwuY29tPjsgQWxleGFuZGVyIER1eWNrDQo+IDxhbGV4
YW5kZXIuZHV5Y2tAZ21haWwuY29tPjsgZTEwMDAtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
DQo+IFN1YmplY3Q6IFtQQVRDSCAyLzJdIGUxMDAwZTogc3RhcnQgbmV0d29yayB0eCBxdWV1ZSBv
bmx5IHdoZW4gbGluayBpcyB1cA0KPiANCj4gRHJpdmVyIGRvZXMgbm90IHdhbnQgdG8ga2VlcCBw
YWNrZXRzIGluIHR4IHF1ZXVlIHdoZW4gbGluayBpcyBsb3N0Lg0KPiBCdXQgcHJlc2VudCBjb2Rl
IG9ubHkgcmVzZXQgTklDIHRvIGZsdXNoIHRoZW0sIGJ1dCBkb2VzIG5vdCBwcmV2ZW50DQo+IHF1
ZXVpbmcgbmV3IHBhY2tldHMuIE1vcmVvdmVyIHJlc2V0IHNlcXVlbmNlIGl0c2VsZiBjb3VsZCBn
ZW5lcmF0ZQ0KPiBuZXcgcGFja2V0cyB2aWEgbmV0Y29uc29sZSBhbmQgTklDIGZhbGxzIGludG8g
ZW5kbGVzcyByZXNldCBsb29wLg0KPiANCj4gVGhpcyBwYXRjaCB3YWtlcyB0eCBxdWV1ZSBvbmx5
IHdoZW4gTklDIGlzIHJlYWR5IHRvIHNlbmQgcGFja2V0cy4NCj4gDQo+IFRoaXMgaXMgcHJvcGVy
IGZpeCBmb3IgcHJvYmxlbSBhZGRyZXNzZWQgYnkgY29tbWl0IDBmOWU5ODBiZjVlZQ0KPiAoImUx
MDAwZTogZml4IGN5Y2xpYyByZXNldHMgYXQgbGluayB1cCB3aXRoIGFjdGl2ZSB0eCIpLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogS29uc3RhbnRpbiBLaGxlYm5pa292IDxraGxlYm5pa292QHlhbmRl
eC10ZWFtLnJ1Pg0KPiBTdWdnZXN0ZWQtYnk6IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyLmR1
eWNrQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAw
MGUvbmV0ZGV2LmMgfCAgICA2ICsrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQpUZXN0ZWQtYnk6IEFhcm9uIEJyb3duIDxhYXJvbi5m
LmJyb3duQGludGVsLmNvbT4NCkFnYWluLCBtb3JlIG9mIGEgcmVncmVzc2lvbiBjaGVjayB0aGFu
IGEgdGVzdCB0aGF0IHRoZSBwYXRjaCBzb2x2ZXMgdGhlIHByb2JsZW0gYXMgSSBkaWQgbm90IG1h
bmFnZSB0byB0cmlnZ2VyIHRoZSBoYW5nLg0K
