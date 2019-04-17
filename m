Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D140C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4453820645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbfDQOkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:40:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQOkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:40:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 398D430ADBD3;
        Wed, 17 Apr 2019 14:40:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 501001001E9F;
        Wed, 17 Apr 2019 14:40:03 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:40:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190417144002.GB2705@krava>
References: <a83183c0-21f4-02af-1443-1a3fdb5d89c3@linux.intel.com>
 <20190417073952.GF17024@krava>
 <20190417143542.GA5246@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417143542.GA5246@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 17 Apr 2019 14:40:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:35:42AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 17, 2019 at 09:39:52AM +0200, Jiri Olsa escreveu:
> > On Mon, Apr 15, 2019 at 06:36:13PM +0300, Alexey Budankov wrote:
> > > 
> > > When dwarf stacks are collected jointly with user specified register
> > > set using --user-regs option like below the full register context is
> > > still captured on a sample:
> > > 
> > >   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- matrix.gcc.g.O3
> > > 
> > >   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
> > >   ... FP chain: nr:0
> > >   ... user regs: mask 0xff0fff ABI 64-bit
> > >   .... AX    0x53b
> > >   .... BX    0x7ffedbdd3cc0
> > >   .... CX    0xffffffff
> > >   .... DX    0x33d3a
> > >   .... SI    0x7f09b74c38d0
> > >   .... DI    0x0
> > >   .... BP    0x401260
> > >   .... SP    0x7ffedbdd3cc0
> > >   .... IP    0x401236
> > >   .... FLAGS 0x20a
> > >   .... CS    0x33
> > >   .... SS    0x2b
> > >   .... R8    0x7f09b74c3800
> > >   .... R9    0x7f09b74c2da0
> > >   .... R10   0xfffffffffffff3ce
> > >   .... R11   0x246
> > >   .... R12   0x401070
> > >   .... R13   0x7ffedbdd5db0
> > >   .... R14   0x0
> > >   .... R15   0x0
> > >   ... ustack: size 1024, offset 0xe0
> > >    . data_src: 0x5080021
> > >    ... thread: stack_test2.g.O:23828
> > >    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> > > 
> > > After applying the change suggested in the patch the sample data contain
> > > only user specified register values:
> > > 
> > >   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- matrix.gcc.g.03
> > > 
> > >   188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
> > >   ... FP chain: nr:0
> > >   ... user regs: mask 0x1c0 ABI 64-bit
> > >   .... BP    0x401260
> > >   .... SP    0x7ffd3d85cc20
> > >   .... IP    0x401236
> > >   ... ustack: size 1024, offset 0x58
> > >    . data_src: 0x5080021
> > >    ... thread: stack_test2.g.O:23839
> > >    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> > > 
> > > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> So, there are registers that are needed to do the DWARF unwinding,
> right? But at the same time, if the user says only some are needed, he
> better know what they're doing and ask for at least the registers needed
> for the unwinding process to be successfull, right?

yep, that's how understand that

jirka

> 
> - Arnaldo
>  
> > thanks,
> > jirka
> > 
> > > ---
> > >  tools/perf/util/evsel.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 84cfb9fe2fc6..29a223b4c699 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -702,7 +702,8 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
> > >  		if (!function) {
> > >  			perf_evsel__set_sample_bit(evsel, REGS_USER);
> > >  			perf_evsel__set_sample_bit(evsel, STACK_USER);
> > > -			attr->sample_regs_user |= PERF_REGS_MASK;
> > > +			if (!opts->sample_user_regs)
> > > +				attr->sample_regs_user |= PERF_REGS_MASK;
> > >  			attr->sample_stack_user = param->dump_size;
> > >  			attr->exclude_callchain_user = 1;
> > >  		} else {
> > > -- 
> > > 2.20.1
> > > 
> 
> -- 
> 
> - Arnaldo
