Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2755D2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfLLTq2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:46:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:41514 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfLLTq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:46:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 11:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="211222079"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2019 11:46:26 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Dec 2019 11:46:25 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.94]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.240]) with mapi id 14.03.0439.000;
 Thu, 12 Dec 2019 11:46:25 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        'Andy Lutomirski' <luto@kernel.org>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        'Ingo Molnar' <mingo@kernel.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'H Peter Anvin' <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        'linux-kernel' <linux-kernel@vger.kernel.org>,
        'x86' <x86@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVoA1uR0NpEjA1wUmtm7eAgTQzs6eVqSUAgAB0jYCAAEXyAP//gC6AgAGn1ICAAEz+gP//pIgggACuT4CAAAUeAIAADDWAgB6dr4CAAB9eQIAADuCQ
Date:   Thu, 12 Dec 2019 19:46:25 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5013AA@ORSMSX115.amr.corp.intel.com>
References: <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD20D@ORSMSX115.amr.corp.intel.com>
 <20191122202345.GC2844@hirez.programming.kicks-ass.net>
 <20191122204204.GA192370@romley-ivt3.sc.intel.com>
 <CALCETrUBomb2_2xyX-tZUD84smtDWH6e16zSN1qupkv-DWu5kw@mail.gmail.com>
 <20191212085755.GR2827@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F5011B2@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5011B2@ORSMSX115.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjIxYmY1ODUtOWQzMC00MDBhLWI1OTQtN2YwMWYxY2E1M2YyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid1dSbGpcL2lsQVd3MmFxSlwvamZyZjJmQm5zeFlSRjhJa3ExTnZyZURyMDh4RkJLZ0RUM3ZnWmtXeVZwZTRcL3dDeiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> If anything we could switch the entire bitmap interface to unsigned int,
>> but I'm not sure that'd actually help much.
>
> As we've been looking for potential split lock issues in kernel code, most of
> the ones we found relate to callers who have <=32 bits and thus stick:
>
>	u32 flags;
>
> in their structure.  So it would solve those places, and fix any future code
> where someone does the same thing.

If different architectures can do better with 8-bit/16-bit/32-bit/64-bit instructions
to manipulate bitmaps, then perhaps this is justification to make all the
functions operate on "bitmap_t" and have each architecture provide the
typedef for their favorite width.

-Tony
