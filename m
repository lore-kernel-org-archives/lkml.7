Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09631C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 07:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0922083B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 07:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF2HVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 03:21:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:2509 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfF2HVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:21:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2019 00:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,430,1557212400"; 
   d="scan'208";a="164867061"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2019 00:21:04 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Jun 2019 00:21:04 -0700
Received: from crsmsx104.amr.corp.intel.com (172.18.63.32) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Jun 2019 00:21:04 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.124]) by
 CRSMSX104.amr.corp.intel.com ([169.254.6.189]) with mapi id 14.03.0439.000;
 Sat, 29 Jun 2019 01:21:01 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v7 12/18] x86/fsgsbase/64: GSBASE handling with FSGSBASE
 in the paranoid path
Thread-Topic: [PATCH v7 12/18] x86/fsgsbase/64: GSBASE handling with
 FSGSBASE in the paranoid path
Thread-Index: AQHVBb/uJnB46cEwCkSKnwiziojozaay73oA
Date:   Sat, 29 Jun 2019 07:21:00 +0000
Message-ID: <E8E632D1-7A16-4F42-954B-0ACA3C5F7409@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
 <1557309753-24073-13-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1557309753-24073-13-git-send-email-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.33.104]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B652891D6911048A7074E739991CDAC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1heSA4LCAyMDE5LCBhdCAwMzowMiwgQ2hhbmcgUy4gQmFlIDxjaGFuZy5zZW9rLmJh
ZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gRU5UUlkocGFyYW5vaWRfZXhpdCkNCj4g4oCmDQo+
ICsNCj4gKwkvKiBPbiBGU0dTQkFTRSBzeXN0ZW1zLCBhbHdheXMgcmVzdG9yZSB0aGUgc3Rhc2hl
ZCBHU0JBU0UgKi8NCj4gKwl3cmdzYmFzZQklcmJ4DQo+ICsJam1wCS5McGFyYW5vaWRfZXhpdF9u
b19zd2FwZ3M7DQoNCkl0IHdvdWxkIGNyYXNoIGFueSB0aW1lIGdldHRpbmcgYSBwYXJhbm9pZCBl
bnRyeSB3aXRoIHVzZXIgR1MgYnV0IGtlcm5lbCBDUjMuDQpUaGUgaXNzdWUgaXMgdGhhbmtmdWxs
eSB1bmNvdmVyZWQgYnkgVmVnYXJkIE4uIEEgcmVsZXZhbnQgdGVzdCBjYXNlIHdpbGwgYmUNCnB1
Ymxpc2hlZCBieSBBbmR5IEwuIFRoZSBwYXRjaCBmaXhlcyB0aGUgaXNzdWUuIChSZWJhc2VkIG9u
IHRoZSB0aXAgbWFzdGVyLikNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0
LlMgYi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TDQppbmRleCBiNWU3ODJhLi5kZmRhZGMxIDEw
MDY0NA0KLS0tIGEvYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUw0KKysrIGIvYXJjaC94ODYvZW50
cnkvZW50cnlfNjQuUw0KQEAgLTEyODgsOSArMTI4OCwxMiBAQCBFTlRSWShwYXJhbm9pZF9leGl0
KQ0KICAgICAgIC8qIEhhbmRsZSBHUyBkZXBlbmRpbmcgb24gRlNHU0JBU0UgYXZhaWxhYmlsaXR5
ICovDQogICAgICAgQUxURVJOQVRJVkUgImptcCAuTHBhcmFub2lkX2V4aXRfY2hlY2tncyIsICJu
b3AiLFg4Nl9GRUFUVVJFX0ZTR1NCQVNFDQoNCisgICAgICAgVFJBQ0VfSVJRU19JUkVUUQ0KKyAg
ICAgICAvKiBBbHdheXMgcmVzdG9yZSBzdGFzaGVkIENSMyB2YWx1ZSAoc2VlIHBhcmFub2lkX2Vu
dHJ5KSAqLw0KKyAgICAgICBSRVNUT1JFX0NSMyAgICAgc2NyYXRjaF9yZWc9JXJheCBzYXZlX3Jl
Zz0lcjE0DQogICAgICAgLyogV2l0aCBGU0dTQkFTRSBlbmFibGVkLCB1bmNvbmRpdGlvbmFsbHkg
cmVzdG9yZSBHU0JBU0UgKi8NCiAgICAgICB3cmdzYmFzZSAgICAgICAgJXJieA0KLSAgICAgICBq
bXAgICAgIC5McGFyYW5vaWRfZXhpdF9ub19zd2FwZ3M7DQorICAgICAgIGptcCAgICAgLkxwYXJh
bm9pZF9leGl0X3Jlc3RvcmU7DQoNCi5McGFyYW5vaWRfZXhpdF9jaGVja2dzOg0KICAgICAgIC8q
IE9uIG5vbi1GU0dTQkFTRSBzeXN0ZW1zLCBjb25kaXRpb25hbGx5IGRvIFNXQVBHUyAqLw0KDQo+
ICAuLi4NCj4gLkxwYXJhbm9pZF9leGl0X25vX3N3YXBnczoNCj4gCVRSQUNFX0lSUVNfSVJFVFFf
REVCVUcNCj4gCS8qIEFsd2F5cyByZXN0b3JlIHN0YXNoZWQgQ1IzIHZhbHVlIChzZWUgcGFyYW5v
aWRfZW50cnkpICovDQo+IAlSRVNUT1JFX0NSMwlzY3JhdGNoX3JlZz0lcmJ4IHNhdmVfcmVnPSVy
MTQNCj4gKw0KPiAuTHBhcmFub2lkX2V4aXRfcmVzdG9yZToNCj4gLQlqbXAgcmVzdG9yZV9yZWdz
X2FuZF9yZXR1cm5fdG9fa2VybmVsDQo+ICsJam1wCXJlc3RvcmVfcmVnc19hbmRfcmV0dXJuX3Rv
X2tlcm5lbA0KPiBFTkQocGFyYW5vaWRfZXhpdCkNCj4gDQoNCg0K
