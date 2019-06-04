Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02339C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19D623CBA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfFDQRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:17:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:23532 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbfFDQRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:17:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 09:17:39 -0700
X-ExtLoop1: 1
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2019 09:17:39 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 4 Jun 2019 09:17:38 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.47]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.37]) with mapi id 14.03.0415.000;
 Tue, 4 Jun 2019 09:17:38 -0700
From:   "Yang, Hyungwoo" <hyungwoo.yang@intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kadam, Rushikesh S" <rushikesh.s.kadam@intel.com>,
        "jettrink@chromium.org" <jettrink@chromium.org>
Subject: RE: [PATCH] platform/chrome: fix crash during suspend
Thread-Topic: [PATCH] platform/chrome: fix crash during suspend
Thread-Index: AQHVF5qm8M0/r/p6W0SmnQQR6VYnwKaFik0QgAaJS4D//55H8A==
Date:   Tue, 4 Jun 2019 16:17:38 +0000
Message-ID: <7A4F467111FEF64486F40DFE7DF3500A221AFDEC@ORSMSX121.amr.corp.intel.com>
References: <1559189034-11268-1-git-send-email-hyungwoo.yang@intel.com>
 <8b7a8d63-d9e4-6a9e-1b13-423441416c8a@collabora.com>
 <7A4F467111FEF64486F40DFE7DF3500A221AEE76@ORSMSX121.amr.corp.intel.com>
 <2fc73fbf-8d30-9aba-c12e-799e6f2a824f@collabora.com>
In-Reply-To: <2fc73fbf-8d30-9aba-c12e-799e6f2a824f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmE0YzY1NGUtODY2OS00MmUwLWExMGEtNDY1ZjUzNWJjNWNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMTNvaDM4bThMVXJlXC9aWFNDeXVZXC9iVjEyWWEwQkJSZkdHMDhcL0FCQnVURGNLcjdPZzVzV3RwbWdycFZiME82VyJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFbnJpYyBCYWxsZXRibyBpIFNl
cnJhIDxlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tPiANCj4gU2VudDogVHVlc2RheSwgSnVu
ZSA0LCAyMDE5IDg6MDQgQU0NCj4gVG86IFlhbmcsIEh5dW5nd29vIDxoeXVuZ3dvby55YW5nQGlu
dGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEthZGFtLCBSdXNo
aWtlc2ggUyA8cnVzaGlrZXNoLnMua2FkYW1AaW50ZWwuY29tPjsgamV0dHJpbmtAY2hyb21pdW0u
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBsYXRmb3JtL2Nocm9tZTogZml4IGNyYXNoIGR1
cmluZyBzdXNwZW5kDQo+ID4+Pg0KPiA+Pg0KPiA+PiBBcyB0aGlzIHBhdGNoIGlzIGEgZml4IGZv
ciAnMjZhMTQyNjdhZmYyIHBsYXRmb3JtL2Nocm9tZTogQWRkIENocm9tZU9TIEVDIElTSFRQIGRy
aXZlcicgd2hpY2ggaXMgc3RpbGwgZm9yLW5leHQgbWF0ZXJpYWwsIGRvIHlvdSBtaW5kIGlmIEkg
c3F1YXNoIGJvdGggcGF0Y2hlcz8NCj4gPj4NCj4gPj4gSWYgeW91IGRvbid0IG1pbmQgSSdsbCBh
ZGQgeW91ciBTaWduZWQtb2ZmIGFuZCBhIHNtYWxsIGNvbW1lbnQgc2F5aW5nIHRoYXQgeW91IGZp
eGVkIHRoaXMuDQo+ID4gDQo+ID4gSSBkb24ndCBtaW5kLiBwbGVhc2UgZG8gd2hhdGV2ZXIgeW91
IHdhbnQuIGJ1dCBpdCBoYXMgZGVwZW5kZW5jeSB3aXRoIA0KPiA+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1pbnB1dC9saXN0Lz9zZXJpZXM9MTI0NzgwDQo+IA0K
PiBXaGF0IHBhdGNoZXMgZXhhY3RseT8gVGhlIGxpbmsgcG9pbnRzIG1lIHRvIGEgYmlnIGxpc3Qg
b2YgcGF0Y2hlcy4gQW5kIGRvIHlvdSBtZWFuIHRoYXQgdGhpcyBwYXRjaCBpcyBhIGZpeCBmb3Ig
YSBwYXRjaCB0aGF0IGRpZG4ndCBsYW5kIHlldCBhbmQgY3VycmVudCBjb2RlIGlzIG5vdCB3cm9u
Zz8NCg0KSSdtIHNvcnJ5IEkgZGlkbid0IGtub3cgSSBtYWRlIG1pc3Rha2Ugd2l0aCAic2VuZC1t
YWlsIi4gSSd2ZSBzdWJtaXR0ZWQgbmV3IG9uZSh2NCkgYXMgdGhleSBhc2tlZCBtZS4NCg0KaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWlucHV0L2xpc3QvP3Nlcmll
cz0xMjY2OTcNCg0KVGhhbmtzLA0KSHl1bmd3b28NCg0KDQo=
