Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FD121900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfCVWO3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:14:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:14252 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfCVWO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:14:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 15:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154949731"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2019 15:14:27 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 22 Mar 2019 15:14:27 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.183]) with mapi id 14.03.0415.000;
 Fri, 22 Mar 2019 15:14:26 -0700
From:   "DSouza, Nelson" <nelson.dsouza@intel.com>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     'Tony Jones' <tonyj@suse.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Stephane Eranian' <eranian@google.com>,
        'Ingo Molnar' <mingo@kernel.org>,
        'Jiri Olsa' <jolsa@redhat.com>,
        'LKML' <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Thread-Topic: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Thread-Index: AQHU2meCJVx8rY9sAUm4QKznrmaLf6YS+ruAgABNOYCAAHF+gIAACAKAgAG7WACAABqBAIAA702AgABE+YCAAAcDgIAAAb6AgAARpoCAABcZgP//i2fggAB7WAD//7y0YIABgwHQ
Date:   Fri, 22 Mar 2019 22:14:26 +0000
Message-ID: <BC9B17E68BB84346BEE0B491BDB7D8AE28A6AB76@ORSMSX101.amr.corp.intel.com>
References: <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net>
 <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
 <20190321171047.GR5996@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211815300.1784@nanos.tec.linutronix.de>
 <20190321182011.GT5996@hirez.programming.kicks-ass.net>
 <fa2d8695-f87c-b141-a19b-2ed4b80df987@suse.com>
 <BC9B17E68BB84346BEE0B491BDB7D8AE28A6A745@ORSMSX101.amr.corp.intel.com>
 <20190321200700.GD2490@worktop.programming.kicks-ass.net>
 <BC9B17E68BB84346BEE0B491BDB7D8AE28A6A801@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <BC9B17E68BB84346BEE0B491BDB7D8AE28A6A801@ORSMSX101.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmU3YjFmMDktZGNjNi00NDcyLTkyYjktNGY2YzYyZDNjYzllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZFlDNE9YWktFUG8zYm9KSDFXRkF5a3BZamxhQkYyYk5ENkN1T1NyRGFIMldzQndaZWxXd2huV3R3bEU2SVRKRiJ9
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec was borked in 5.0+ kernel I was using.

Switched to 5.0.3 stable and kexec works as expected.
No warnings seen with a kexec boot.

-----Original Message-----
From: DSouza, Nelson 
Sent: Thursday, March 21, 2019 4:16 PM
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Jones <tonyj@suse.com>; Thomas Gleixner <tglx@linutronix.de>; Stephane Eranian <eranian@google.com>; Ingo Molnar <mingo@kernel.org>; Jiri Olsa <jolsa@redhat.com>; LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] perf/x86/intel: Fix memory corruption

Attached cpu hotplug test output while perf is running in the background. No WARN messages seen.

When I run the kexec command, it boots to bios. Haven't used kexec before. Still trying to figure that one out.

-----Original Message-----
From: Peter Zijlstra [mailto:peterz@infradead.org] 
Sent: Thursday, March 21, 2019 1:07 PM
To: DSouza, Nelson <nelson.dsouza@intel.com>
Cc: Tony Jones <tonyj@suse.com>; Thomas Gleixner <tglx@linutronix.de>; Stephane Eranian <eranian@google.com>; Ingo Molnar <mingo@kernel.org>; Jiri Olsa <jolsa@redhat.com>; LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption

On Thu, Mar 21, 2019 at 07:47:50PM +0000, DSouza, Nelson wrote:
> Is the request to check whether the msr gets reset to default upon reboot of the machine ?

basically:

 - apply patch
 - start workload with 4 counter (on all CPUs), such that tfa-msr=1
 - try the following:
   o cpu hotplug
   o kexec

to see if the new WARN will trigger -- it should not.
