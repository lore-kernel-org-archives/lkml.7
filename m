Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD4C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E7F2596C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmNA5Ppf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfE3NNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:13:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44283 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfE3NNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:13:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so3431684qtk.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sF5nMRjKdOWU4XpRCkyuji3hWyyX9u+t9j/V5Jt3lMA=;
        b=GmNA5Ppf0vdzs480aG9sTJwq119t8xTalA61+BEkj6N0vUXE36bQV25qA1rPL7CMRf
         Xv85j3ljanKRRcHKE9i4f86pothGJ4WaVIBY1q+QQev53ui+7nK6qMMYjXZvG/txU4oh
         T/BPsgMaMkWfu7oZC4pR5xFk+d+4v1gK1wjfFdmljj5nB6mzXzBKEbGjWyrcOO7NYxEj
         invQ5tgADT8fwqCdqH0ljJFnyQ95vMalxZ0MeuOf1AxtYtac8mcG/UaF+GUdIl+Kqy7X
         NhS0uBz5WenDWry0P+SdviHWOMgjMlMzLThQB8n0zyP2QZnLMYhgD5Y0vPZohOBtgZxM
         xxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sF5nMRjKdOWU4XpRCkyuji3hWyyX9u+t9j/V5Jt3lMA=;
        b=dQRDEhibAv92NKdFTr2X44b0W3rAHXY+hmfhYfzap74s61gmBnRRVmZCBt9iONPIkX
         xQ3U+22maBDMD+FqfqtORdEoFeNJ4t5hA3DtWzaYFlXAOIJVHZH8v2vyfCz56OP1RJ3B
         v2nX5qscstwFFtGNtWWqAx4Hl8OP4lcE7cDRjIpTpl/ehoRUPzxKaVmFVWTULxCBDt4h
         TnAQrEzMInHMKKOmUUktOBmL7txf2KTf8B9Ciuf5vlLe4nLtpWY3VJOOLzRuBW1iQ42g
         YN1Gtekfx+4fLp78ZMmtauf+VYXLuO65rW5ukcCE3ubfPJdWsR6cB+NmceOi1qag148/
         MUYA==
X-Gm-Message-State: APjAAAUUeJ4Cid5UWHqpCMhkpU9iYrSTWsLa5PdtQHy/HxOLA26mHzmr
        4KKeVJnUSYyg66kNhv/MOvw=
X-Google-Smtp-Source: APXvYqyVRLvIwLuhckg/+kMunfdIlPVbMEIXDDUf6OvOWBlyL6a5zAgNfsnCdci+2ejH05C83oUY7g==
X-Received: by 2002:a0c:b98d:: with SMTP id v13mr3261358qvf.11.1559222020724;
        Thu, 30 May 2019 06:13:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f67sm1509551qtb.68.2019.05.30.06.13.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 06:13:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E55841149; Thu, 30 May 2019 10:13:37 -0300 (-03)
Date:   Thu, 30 May 2019 10:13:37 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190530131337.GB21962@kernel.org>
References: <01a322ee-c99d-0bb7-b7cf-bc1fa8064d75@linux.intel.com>
 <20190529192506.GB5553@kernel.org>
 <378b81a7-b7db-c60f-134d-0c0f7cd6c0a1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378b81a7-b7db-c60f-134d-0c0f7cd6c0a1@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 30, 2019 at 11:24:49AM +0300, Alexey Budankov escreveu:
> On 29.05.2019 22:25, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 29, 2019 at 05:30:49PM +0300, Alexey Budankov escreveu:
> <SNIP>
> >> +++ b/tools/perf/util/evsel.c
> >> +#define DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
> >> +			 (1ULL << PERF_REG_SP))
> >> +
> >>  static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
> >>  					   struct record_opts *opts,
> >>  					   struct callchain_param *param)
> >> @@ -702,7 +705,13 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
> >>  		if (!function) {
> >>  			perf_evsel__set_sample_bit(evsel, REGS_USER);
> >>  			perf_evsel__set_sample_bit(evsel, STACK_USER);
> >> -			attr->sample_regs_user |= PERF_REGS_MASK;
> >> +			if (opts->sample_user_regs) {
> > 
> > Where are you checking that opts->sample_user_regs doesn't have either
> > IP or SP?
> 
> Sure. The the intention was to avoid such a complication, merge two 
> masks and provide explicit warning that the resulting mask is extended.

s/is/may be/g
 
> If you still see the checking and auto detection of the exact mask 
> extension as essential it can be implemented.

perf, tracing, systems internals, etc are super complicated, full of
details, the more precise we can make the messages, the better.
 
> > So, __perf_evsel__config_callchain its the routine that sets up the
> > attr->sample_regs_user when callchains are asked for, and what was it
> > doing? Asking for _all_ user regs, right?
> > 
> > I.e. what you're saying is that when --callgraph-dwarf is asked for,
> > then only IP and BP are needed, and we should stop doing that, so that
> > would be a first patch, if that is the case. I.e. a patch that doesn't
> > even mention opts->sample_user_regs.
> > 
> > Then, a second patch would fix the opt->sample_user_regs request clash
> > with --callgraph dwarf, i.e. it would do something like:
> > 
> > 	      if ((opts->sample_regs_user & DWARF_REGS_MASK) != DWARF_REGS_MASK) {
> > 	      		char * ip = (opts->sample_regs_user & (1ULL << PERF_REG_IP)) ? NULL : "IP",
> > 	      		     * sp = (opts->sample_regs_user & (1ULL << PERF_REG_SP)) ? NULL : "SP",
> > 			     * all = (!ip && !sp) ?  "s" : "";
> > 
> > 			pr_warning("WARNING: specified --user-regs register set doesn't include register%s "
> > 				   "needed by also specified --call-graph=dwarf, auto adding %s%s%s register%s.\n",
> > 				   all, ip, all : ", " : "", sp, all);
> > 		}
> > 
> > This if and only if all the registers that are needed to do DWARF
> > unwinding are just IP and BP, which doesn't look like its true, since
> > when no --user_regs is set (i.e. opts->user_regs is not set) then we
> > continue asking for PERF_REGS_MASK...
> > 
> > Can you check where I'm missing something?
> 
> 1.  -g call-graph dwarf,K                         full_regs
> 2.  --user-regs=user_regs                         user_regs
> 3.  -g call-graph dwarf,K --user-regs=user_regs	  user_regs + dwarf_regs
> 
> The default behavior stays the same for cases 1, 2 above.
> For case 3 register set becomes the one asked using --user_regs option.
> If the option value misses IP or SP or the both then they are explicitly
> added to the option value and a warning message mentioning the exact 
> added registers is provided.
 
> > Jiri DWARF unwind uses just IP and SP? Looking at
> > tools/perf/util/unwind-libunwind-local.c's access_reg() I don't think
> > so, right?
 
> If you ask me, AFAIK, DWARF unwind rules sometimes can refer additional 
> general purpose registers for frames boundaries calculation.

:-) So that DWARF_REGS is misleading, should be something like
DWARF_MINIMAL_REGS, as we may need other registers, so the original code
was correct, right?

After all if the user asks for both --call-graph dwarf and --user-regs,
then probably we should require --force? I.e. the message then would be:

"
WARNING: The use of --call-graph=dwarf may require all the user
registers, specifying a subset with --user-regs may render DWARF
unwinding unreliable, please use --force if you're sure that the subset
specified via --user-regs is enough for your specific use case.
"

And then plain refuse, if the user _really_ wants it, then we have
--force/-f for those cases.

Does this sound better?

- Arnaldo
