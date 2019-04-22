Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CD4C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B5F20684
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfDVRXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:23:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:51895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfDVRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:23:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 10:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="144742608"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2019 10:23:43 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 10:23:42 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.183]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.109]) with mapi id 14.03.0415.000;
 Mon, 22 Apr 2019 10:23:42 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Thread-Topic: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Thread-Index: AQHU9jKBC6KJVSji90+B+N/k56qJIaZC+16AgAAKogCAAAgoAIAAB+6AgAHqtYCAADq4gIAAmG0AgAAIIQCAAofRkIAAdskA//+NmhCAAHvbgP//jlpw
Date:   Mon, 22 Apr 2019 17:23:41 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7E90A869@ORSMSX104.amr.corp.intel.com>
References: <20190418232910.GR27160@zn.tnic>
 <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic>
 <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
 <20190420091313.GA29704@zn.tnic>
 <CAM_iQpUaBOS92u7K+hzzRX5hw0Kbrp-0o0DSfLwSGBhenntVjA@mail.gmail.com>
 <20190420184751.GE29704@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E90A49F@ORSMSX104.amr.corp.intel.com>
 <20190422163138.GF21457@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E90A5E7@ORSMSX104.amr.corp.intel.com>
 <20190422170529.GG21457@zn.tnic>
In-Reply-To: <20190422170529.GG21457@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjhmOGE2ZTUtNmJjMS00MzhmLTk2OGQtYWM3OTBlYzZhYWIzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicFZqdE1lSjZtNlJUcG9LbTEzK0pHSkVPRGJIalwvMjJjK1R0N25kTXFqVUN2UkU0S0ZWcHNqTG1BMUVnM09lR3YifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHRoaW5rIHdlJ3JlIHRhbGtpbmcgcGFzdCBlYWNoIG90aGVyIGhlcmU6IEkgbWVhbiBkaXNh
YmxlIHRoZSBDRUMNCj4gKmZvcmV2ZXIqIGFuZCAqbmV2ZXIqIHVzZSBpdC4gVXNlIG9ubHkgYSB1
c2Vyc3BhY2UgYWdlbnQgYW5kIGxvZyBlcnJvcnMNCj4gd2l0aCBpdC4NCj4NCj4gTWFrZXMgc2Vu
c2U/DQoNCk5vdCByZWFsbHkuIFdlIHdhbnQgcHJldHR5IG11Y2ggZXZlcnlvbmUgdG8gZW5hYmxl
IGFuZCB1c2UgQ0VDLiBUaGF0IHdheQ0KcGVvcGxlIGRvbid0IGJvdGhlciB1c2UgYWJvdXQgdGhl
IG9jY2FzaW9uYWwgbmV1dHJvbiBzdHJpa2UgZmxpcHBpbmcgYSBiaXQuDQoNClNvIHdlIG5lZWQg
dG8gbWFrZSBzdXJlIHRoZXJlIGFyZSBubyBleGN1c2VzIGZvciBkaXNhYmxpbmcgaXQuIFBlb3Bs
ZQ0KbWF5IGNvbWUgdXAgd2l0aCBvdGhlciBjYXNlcyB3aGVyZSB0aGV5IHNheSB0aGV5IHdvdWxk
IG5lZWQgdG8gZGlzYWJsZQ0KKHBlcmhhcHMgZ2VudWluZSwgcGVyaGFwcyBib2d1cykgLi4uIGlm
IG91ciBvbmx5IGFuc3dlcnMgYXJlIHJlYm9vdCwgb3INCnJlY29tcGlsZSBhbmQgcmVib290IC4u
LiB0aGVuIHRoZXknbGwgZGlzYWJsZSBmb3JldmVyLg0KDQpJZiB0aGV5IGRvIHRoYXQsIHdoeSBk
byB3ZSBldmVuIGhhdmUgaXQgaW4gdGhlIGtlcm5lbD8NCg0KLVRvbnkNCg==
