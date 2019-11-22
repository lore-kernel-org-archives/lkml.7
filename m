Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF4FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B582068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKVRsQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:48:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:31498 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:48:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 09:48:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="216401175"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2019 09:48:15 -0800
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 Nov 2019 09:48:14 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.121]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.116]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 09:48:15 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, "Will Deacon" <will@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVoA1uR0NpEjA1wUmtm7eAgTQzs6eVqSUAgAB0jYCAAEXyAIAACNaAgAACA4CAABFSgIAAGboAgAAP84CAAMozgIAABOHw
Date:   Fri, 22 Nov 2019 17:48:14 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191122092555.GA4097@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTUzMTJiZmYtNTMyYy00NDZlLTlkZWEtOGIwNDRiYTkzYjQzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS2k4dUdCSGNrY296dEV0bEw0XC82cXB5cFNSeEl2Z3I3VGJoc3VPb0c5bENkODhnSDVTeTM1Y2FURFlBdGpBYnAifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When we use byte ops, we must consider the word as 4 independent
> variables. And in that case the later load might observe the lock-byte
> state from 3, because the modification to the lock byte from 4 is in
> CPU2's store-buffer.

So we absolutely violate this with the optimization for constant arguments
to set_bit(), clear_bit() and change_bit() that are implemented as byte ops.

So is code that does:

	set_bit(0, bitmap);

on one CPU. While another is doing:

	set_bit(mybit, bitmap);

on another CPU safe? The first operates on just one byte, the second  on 8 bytes.

-Tony
