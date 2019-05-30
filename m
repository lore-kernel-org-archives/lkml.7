Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31267C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB10E25F03
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFusgsTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfE3SEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:04:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37574 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfE3SEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:04:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so8124992qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5cJTRc1EI6T/boEycvbBtY55OS1pcz7kmj1lFB3RxPQ=;
        b=BFusgsTO1cyqHb5tBqkcxEDr5ynRMLbsmdlsPR2PtMeQKw+DOTBW315eQi2yG2Z1x2
         a2hHif6dvhFOBGFFoigALRQ4qc272qYQse6ifskVp7swkRyU+fPQY004DYt+lKM9wzqz
         7vv25jEcHdIqhokfGvAdnyewIBApS92myKQg07WDptSCscVYuH4UVBqBc/cRFQj9JiVy
         IfovOaozTqGIOnk2QwK5aVPeOjkVVn9ynpJ9vUB1kwNvORjM6adOOTSQMKFnHz9Xw4Oh
         9Dyc+szfhpB4VnneF7zsPTlfzzagLHOqcVK1qskyTR/NCNv9tSsxxsQ6BIyTK7fq5Kzn
         GAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5cJTRc1EI6T/boEycvbBtY55OS1pcz7kmj1lFB3RxPQ=;
        b=IhNwNZO+rwQTJTRS72Ds41jcn9rwSA7jv+MlUQefltT6VYHhJ3RZHu5CQaSlbZIv/f
         jKocRENRf6LojqeaGkBQ1z8bpnADJlJx984djExve+TID2hpXsVt4bQlRiIy9XjFMVvt
         QyTPdQ7LkH3xB4Fw7KwADw5UL8tVMk95jJ1dR3HQqlDGkkUGBRsAMKk6AtA/eRhNhLa/
         PJoj/bBbl0lvxzw4uHxEJ4/qsyhxV2hfWJMrO06dI/gk00Mw0nOzRTLsQlkwjUmHSoQb
         KpmEFrvbwJRWZRr+I5hiqqY6AT9Qi7rPVv+UI7gIMXYJxw5Rif8ZCdu6jkU+qdLpuh5d
         MCtw==
X-Gm-Message-State: APjAAAX4Ppzgv3dc0vuj/XQz4Fbrf9LnQ6c/E3Ulc1q7BNdTeq0GytW3
        BWCs5GDLjWrLg/oD0eLJb0+ktdEB
X-Google-Smtp-Source: APXvYqzHLJ8UtIi5d6cGKfKlOe8txqg4YjYbh8WPxviaVx/dvDpMrKkpymd+WZBN2EBlDYlfuh+RXw==
X-Received: by 2002:ac8:16ac:: with SMTP id r41mr4920297qtj.346.1559239473028;
        Thu, 30 May 2019 11:04:33 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m18sm1803916qki.21.2019.05.30.11.04.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 11:04:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53D6941149; Thu, 30 May 2019 15:04:28 -0300 (-03)
Date:   Thu, 30 May 2019 15:04:28 -0300
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
Message-ID: <20190530180428.GA3711@kernel.org>
References: <01a322ee-c99d-0bb7-b7cf-bc1fa8064d75@linux.intel.com>
 <20190529192506.GB5553@kernel.org>
 <378b81a7-b7db-c60f-134d-0c0f7cd6c0a1@linux.intel.com>
 <20190530131337.GB21962@kernel.org>
 <dd70a760-aab5-cc65-5e6a-3a0340a4466f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd70a760-aab5-cc65-5e6a-3a0340a4466f@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 30, 2019 at 07:24:57PM +0300, Alexey Budankov escreveu:
> 
> On 30.05.2019 16:13, Arnaldo Carvalho de Melo wrote:
> > Em Thu, May 30, 2019 at 11:24:49AM +0300, Alexey Budankov escreveu:
> >> On 29.05.2019 22:25, Arnaldo Carvalho de Melo wrote:
> >>> Em Wed, May 29, 2019 at 05:30:49PM +0300, Alexey Budankov escreveu:
> >> <SNIP>
> >>>> +++ b/tools/perf/util/evsel.c
> >>>> +#define DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
> >>>> +			 (1ULL << PERF_REG_SP))
> >>>> +
> >>>>  static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
> >>>>  					   struct record_opts *opts,
> >>>>  					   struct callchain_param *param)
> >>>> @@ -702,7 +705,13 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
> >>>>  		if (!function) {
> >>>>  			perf_evsel__set_sample_bit(evsel, REGS_USER);
> >>>>  			perf_evsel__set_sample_bit(evsel, STACK_USER);
> >>>> -			attr->sample_regs_user |= PERF_REGS_MASK;
> >>>> +			if (opts->sample_user_regs) {
> >>>
> >>> Where are you checking that opts->sample_user_regs doesn't have either
> >>> IP or SP?
> >>
> >> Sure. The the intention was to avoid such a complication, merge two 
> >> masks and provide explicit warning that the resulting mask is extended.
> > 
> > s/is/may be/g
> >  
> >> If you still see the checking and auto detection of the exact mask 
> >> extension as essential it can be implemented.
> > 
> > perf, tracing, systems internals, etc are super complicated, full of
> > details, the more precise we can make the messages, the better.
> >  
> >>> So, __perf_evsel__config_callchain its the routine that sets up the
> >>> attr->sample_regs_user when callchains are asked for, and what was it
> >>> doing? Asking for _all_ user regs, right?
> >>>
> >>> I.e. what you're saying is that when --callgraph-dwarf is asked for,
> >>> then only IP and BP are needed, and we should stop doing that, so that
> >>> would be a first patch, if that is the case. I.e. a patch that doesn't
> >>> even mention opts->sample_user_regs.
> >>>
> >>> Then, a second patch would fix the opt->sample_user_regs request clash
> >>> with --callgraph dwarf, i.e. it would do something like:
> >>>
> >>> 	      if ((opts->sample_regs_user & DWARF_REGS_MASK) != DWARF_REGS_MASK) {
> >>> 	      		char * ip = (opts->sample_regs_user & (1ULL << PERF_REG_IP)) ? NULL : "IP",
> >>> 	      		     * sp = (opts->sample_regs_user & (1ULL << PERF_REG_SP)) ? NULL : "SP",
> >>> 			     * all = (!ip && !sp) ?  "s" : "";
> >>>
> >>> 			pr_warning("WARNING: specified --user-regs register set doesn't include register%s "
> >>> 				   "needed by also specified --call-graph=dwarf, auto adding %s%s%s register%s.\n",
> >>> 				   all, ip, all : ", " : "", sp, all);
> >>> 		}
> >>>
> >>> This if and only if all the registers that are needed to do DWARF
> >>> unwinding are just IP and BP, which doesn't look like its true, since
> >>> when no --user_regs is set (i.e. opts->user_regs is not set) then we
> >>> continue asking for PERF_REGS_MASK...
> >>>
> >>> Can you check where I'm missing something?
> >>
> >> 1.  -g call-graph dwarf,K                         full_regs
> >> 2.  --user-regs=user_regs                         user_regs
> >> 3.  -g call-graph dwarf,K --user-regs=user_regs	  user_regs + dwarf_regs
> >>
> >> The default behavior stays the same for cases 1, 2 above.
> >> For case 3 register set becomes the one asked using --user_regs option.
> >> If the option value misses IP or SP or the both then they are explicitly
> >> added to the option value and a warning message mentioning the exact 
> >> added registers is provided.
> >  
> >>> Jiri DWARF unwind uses just IP and SP? Looking at
> >>> tools/perf/util/unwind-libunwind-local.c's access_reg() I don't think
> >>> so, right?
> >  
> >> If you ask me, AFAIK, DWARF unwind rules sometimes can refer additional 
> >> general purpose registers for frames boundaries calculation.
> > 
> > :-) So that DWARF_REGS is misleading, should be something like
> > DWARF_MINIMAL_REGS, as we may need other registers, so the original code
> > was correct, right?
> 
> Right. Actually came to the same conclusion with the same naming for IP,SP mask :)
> 
> > 
> > After all if the user asks for both --call-graph dwarf and --user-regs,
> > then probably we should require --force? I.e. the message then would be:
> > 
> > "
> > WARNING: The use of --call-graph=dwarf may require all the user
> > registers, specifying a subset with --user-regs may render DWARF
> > unwinding unreliable, please use --force if you're sure that the subset
> > specified via --user-regs is enough for your specific use case.
> > "
> > 
> > And then plain refuse, if the user _really_ wants it, then we have
> > --force/-f for those cases.
> > 
> > Does this sound better?
> 
> If --user-regs is specified jointly with --call-graph dwarf option then
> --user-regs already serves as the --force and, IMHO, a warning does the best.
 
> The ideal solution, I could imagine, is to also dynamically calculate regs 
> set extension and provide it in the warning, but it is only for two registers.
> 
> So, if --call-graph dwarf --user-regs=A,B,C are specified jointly then
> "
> WARNING: The use of --call-graph=dwarf may require all the user registers, 
> specifying a subset with --user-regs may render DWARF unwinding unreliable,
> so the minimal registers set (IP, SP) is explicitly forced.
> "

I think with this wording and the renaming of DWARF_REGS to
DWARF_MINIMAL_REGS it should be enough.

- Arnaldo
