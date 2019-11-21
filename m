Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F34AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED80A206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUW3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:29:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:49227 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKUW3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:29:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 14:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="259515670"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2019 14:29:42 -0800
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 Nov 2019 14:29:42 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.121]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.211]) with mapi id 14.03.0439.000;
 Thu, 21 Nov 2019 14:29:41 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVoA1uR0NpEjA1wUmtm7eAgTQzs6eVqSUAgAB0jYCAAAPEAIAAChQAgACPToD//3rs4A==
Date:   Thu, 21 Nov 2019 22:29:41 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4DC167@ORSMSX115.amr.corp.intel.com>
References: <20191121215126.GA9075@agluck-desk2.amr.corp.intel.com>
 <159DB397-87E2-435D-9F33-067FF9296ADC@amacapital.net>
In-Reply-To: <159DB397-87E2-435D-9F33-067FF9296ADC@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmFjNTRmZjgtNDBmYS00MDI5LWJkMzgtMmQ0ZGEzNDNhOTkwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS1paY29aMjdmWlwvb1hoRUhtRFY0XC9qTEFSbmxwbGFqdVVKaU1xZVBxd1dDNFYxNzZkOTdWSTVxME40VEdVN0pyIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJdCB3b3VsZCBiZSByZWFsbHksIHJlYWxseSBuaWNlIGlmIHdlIGNvdWxkIHBhc3MgdGhpcyBm
ZWF0dXJlIHRocm91Z2ggdG8gYSBWTS4gQ2FuIHdlPw0KDQpJdCdzIGhhcmQgYmVjYXVzZSB0aGUg
TVNSIGlzIGNvcmUgc2NvcGVkIHJhdGhlciB0aGFuIHRocmVhZCBzY29wZWQuICBTbyBvbiBhbiBI
VA0KZW5hYmxlZCBzeXN0ZW0gYSBwYWlyIG9mIGxvZ2ljYWwgcHJvY2Vzc29ycyBnZXRzIGVuYWJs
ZWQvZGlzYWJsZWQgdG9nZXRoZXIuDQoNCi1Ub255DQo=
