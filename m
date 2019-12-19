Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BCCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B88227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSQum convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:50:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:58536 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSQum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:50:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 08:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,332,1571727600"; 
   d="scan'208";a="267271483"
Received: from irsmsx154.ger.corp.intel.com ([163.33.192.96])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Dec 2019 08:50:39 -0800
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX154.ger.corp.intel.com (163.33.192.96) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Dec 2019 16:50:38 +0000
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.26]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.126]) with mapi id 14.03.0439.000;
 Thu, 19 Dec 2019 16:50:38 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] perf/x86: Add perf text poke event
Thread-Topic: [PATCH 1/3] perf/x86: Add perf text poke event
Thread-Index: AQHVta9Gfa1pWpXoq0mm3n/Xld+336fBb6cAgAAFmRA=
Date:   Thu, 19 Dec 2019 16:50:37 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C66B7C0@IRSMSX106.ger.corp.intel.com>
References: <20191218142618.19332-1-adrian.hunter@intel.com>
 <20191218142618.19332-2-adrian.hunter@intel.com>
 <20191219130914.GJ2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191219130914.GJ2827@hirez.programming.kicks-ass.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmNiOGU0NDItZDYwYi00MTgyLWIxNmUtYjY4MWJjMGEyMGM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNU82azFMRE0wSndHOWFrMDhReXA2MWE2OGNaT0RHUEFjM1wvV3VNckJ2OG9JYVdPdGo1T0pUNUF2aG04NGlGcEEifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Thursday, December 19, 2019 3:09 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H .
> Peter Anvin <hpa@zytor.com>; x86@kernel.org; Mark Rutland
> <mark.rutland@arm.com>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Mathieu Poirier
> <mathieu.poirier@linaro.org>; Leo Yan <leo.yan@linaro.org>; Arnaldo
> Carvalho de Melo <acme@kernel.org>; Jiri Olsa <jolsa@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] perf/x86: Add perf text poke event
> 
> On Wed, Dec 18, 2019 at 04:26:16PM +0200, Adrian Hunter wrote:
> > Record changes to kernel text (i.e. self-modifying code) in order to
> > support tracers like Intel PT decoding through jump labels.
> 
> I don't get the obsession with just jump-labels, we need a solution all
> modifying code. The fentry site usage is increasing, and optprobes are also
> fairly popular with a bunch of people.

Yes we need a solution for all modifying code.  Jump labels are just a good
place to start because they are the biggest problem by far.

> 
> > A copy of the running kernel code is needed as a reference point (e.g.
> > from /proc/kcore). The text poke event records the old bytes and the
> > new bytes so that the event can be processed forwards or backwards.
> >
> > In the case of Intel PT tracing, the executable code must be walked to
> > reconstruct the control flow. For x86 a jump label text poke begins:
> >   - write INT3 byte
> >   - IPI-SYNC
> >   - write instruction tail
> > At this point the actual control flow will be through the INT3 and
> > handler and not hit the old or new instruction. Intel PT outputs
> > FUP/TIP packets for the INT3, so the flow can still be decoded.
> Subsequently:
> >   - emit RECORD_TEXT_POKE with the new instruction
> >   - IPI-SYNC
> >   - write first byte
> >   - IPI-SYNC
> > So before the text poke event timestamp, the decoder will see either
> > the old instruction flow or FUP/TIP of INT3. After the text poke event
> > timestamp, the decoder will see either the new instruction flow or
> > FUP/TIP of INT3. Thus decoders can use the timestamp as the point at
> > which to modify the executable code.
> 
> I feel a much better justification for the design can be found in the discussion
> we've had around ARM-CS.
> 
> Basically SMP instruction coherency mandates something like this, it is just a
> happy accident x86 already had all the bits in place.
> 
> How is something like:
> 
> "Record (single instruction) changes to the kernel text (i.e.
> self-modifying code) in order to support tracers like Intel PT and ARM
> CoreSight.
> 
> A copy of the running kernel code is needed as a reference point (e.g.
> from /proc/kcore). The text poke event records the old bytes and the new
> bytes so that the event can be processed forwards or backwards.
> 
> The basic problem is recording the modified instruction in an unambiguous
> manner given SMP instruction cache (in)coherence. That is, when modifying
> an instruction concurrently any solution with one or multiple timestamps is
> not sufficient:
> 
> 	CPU0				CPU1
>  0
>  1	write insn A
>  2					execute insn A
>  3	sync-I$
>  4
> 
> Due to I$, CPU1 might execute either the old or new A. No matter where we
> record tracepoints on CPU0, one simply cannot tell what CPU1 will have
> observed, except that at 0 it must be the old one and at 4 it must be the new
> one.
> 
> To solve this, take inspiration from x86 text poking, which has to solve this
> exact problem due to variable length instruction encoding and I-fetch
> windows.
> 
>  1) overwrite the instruction with a breakpoint and sync I$
> 
> This guarantees that that code flow will never hit the target instruction
> anymore, on any CPU (or rather, it will cause an exception).
> 
>  2) issue the TEXT_POKE event
> 
>  3) overwrite the breakpoint with the new instruction and sync I$
> 
> Now we know that any execution after the TEXT_POKE event will either
> observe the breakpoint (and hit the exception) or the new instruction.
> 
> So by guarding the TEXT_POKE event with an exception on either side; we
> can now tell, without doubt, which instruction another CPU will have
> observed."
> 
> ?

Ok

> 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  arch/x86/kernel/alternative.c   | 37 +++++++++++++-
> 
> I'm thinking it might make sense to do this x86 part in a separate patch, and
> just present the generic thing first:
> 
> >  include/linux/perf_event.h      |  6 +++
> >  include/uapi/linux/perf_event.h | 19 ++++++-
> >  kernel/events/core.c            | 87 ++++++++++++++++++++++++++++++++-
> >  4 files changed, 146 insertions(+), 3 deletions(-)
> >
> 
> > @@ -1006,6 +1007,22 @@ enum perf_event_type {
> >  	 */
> >  	PERF_RECORD_BPF_EVENT			= 18,
> >
> > +	/*
> > +	 * Records changes to kernel text i.e. self-modified code.
> > +	 * 'len' is the number of old bytes, which is the same as the number
> > +	 * of new bytes. 'bytes' contains the old bytes followed immediately
> > +	 * by the new bytes.
> > +	 *
> > +	 * struct {
> > +	 *	struct perf_event_header	header;
> > +	 *	u64				addr;
> > +	 *	u16				len;
> > +	 *	u8				bytes[];
> 
> Would it make sense to have something like:
> 
> 	 *	u16				old_len;
> 	 *	u16				new_len;
> 	 *	u8				old_bytes[old_len];
> 	 *	u8				new_bytes[new_len];
> 
> That would allow using this for (short) trampolines (ftrace, optprobes etc..).
> {old_len=0, new_len>0} would indicate a new trampoline, while {old_len>0,
> new_len=0} would indicate the dissapearance of a trampoline.

Yes that makes sense.

> 
> > +	 *	struct sample_id		sample_id;
> > +	 * };
> > +	 */
> > +	PERF_RECORD_TEXT_POKE			= 19,
> > +
> >  	PERF_RECORD_MAX,			/* non-ABI */
> >  };
> 
> Then the x86 patch, hooking up the event, can also cover kprobes and stuff.

Ok

