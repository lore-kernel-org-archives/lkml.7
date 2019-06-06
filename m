Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B0C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D09F20673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+BqiICW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfFFO32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:29:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35883 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfFFO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:29:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id u12so2886039qth.3;
        Thu, 06 Jun 2019 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=63js31eXRcU8jBoDG4gjDfHpp/+nRhez2vrjmZ7DH8s=;
        b=N+BqiICWI+Ly/preMLNFUsTWVrvmB7pZ2S2pX0fRuP3bwaST2oR/3ul2tXyRLcQDwO
         WUxtl/eWvH5znFerESkUA4R/4figZ7Rh5ZFy9Tp0T1QE21BxiuKYZGczGmFsqckgn+HV
         SUk+QvQ2QgeQjNaqVivjxV2ywTLrAobGyVSnMFSb7MBbWGwL26x8233I1Rz6EOMS8lwA
         uWWZhZbixEJnQXBoNEvVSra5Df7EKysq5bAQWnB37IRylyktrj9mGQ9On0MTS0D0OPUj
         isjDWM5l0KFIkZfqJCjx19ZdlHB+928AVDhZO6sgE76n3QwwElhe5CaBRbtcYSkNkrCA
         IPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=63js31eXRcU8jBoDG4gjDfHpp/+nRhez2vrjmZ7DH8s=;
        b=pvpV4lWLjWiiicy5V6DHC2NeRhxMgj9PEBtcqf4hV/GrP0nDlxcHvwGlHm2rshQMkG
         CUpxTDqe4ni/vZhXAVV1ZLlC9fU0W9+YI0pBxrEAMZk0ubEYoq08wFssp27i+FjAwVlv
         3vnpNm7BRs9cVK3Q0xUzW6JUar/NzinbDQN1g0vddxU2bW5Avtba5GxcDIKQEdasthJA
         G9oviG3t59sdvMzVrgcJYNcCLAQ0fcoEW61KuHPZQ/3RrNmKuToRFAfFI7Rdjvcu3V+J
         iAUVBuW/VSps0hA/fi6TizOuQsReJlF8wu8QU/HLqB78TIOac0bwUX1fXcBjAncfK00z
         kKQw==
X-Gm-Message-State: APjAAAVp357SuQjFH22LDIvBdi85XkGEmSGXSFfgw0Nz9iBLBegzw4c5
        kT82mprVQNXZBVfBzMTMC40=
X-Google-Smtp-Source: APXvYqxfxlU94Olww40Y633iAm1vizMCBvBiV5Ut+neykUI6EKz7LtN5/SOLKWWvWDXokvL3OfZ7cg==
X-Received: by 2002:aed:3f1a:: with SMTP id p26mr40639406qtf.113.1559831366406;
        Thu, 06 Jun 2019 07:29:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.208.82])
        by smtp.gmail.com with ESMTPSA id q37sm1192622qtj.94.2019.06.06.07.29.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 07:29:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27C9541149; Thu,  6 Jun 2019 11:29:22 -0300 (-03)
Date:   Thu, 6 Jun 2019 11:29:22 -0300
To:     ufo19890607 <ufo19890607@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com,
        arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com,
        adrian.hunter@intel.com, wangnan0@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
Message-ID: <20190606142922.GB21245@kernel.org>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
 <20190606142644.GA21245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606142644.GA21245@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 06, 2019 at 11:26:44AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, May 30, 2019 at 02:29:22PM +0100, ufo19890607 escreveu:
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> > 
> > One can just record callchains in the kernel or user space with
> > this new options. We can use it together with "--all-kernel" options.
> > This two options is used just like print_stack(sys) or print_ustack(usr)
> > for systemtap.
> > 
> > Show below is the usage of this new option combined with "--all-kernel"
> > options.
> > 	1. Configure all used events to run in kernel space and just
> > collect kernel callchains.
> > 	$ perf record -a -g --all-kernel --kernel-callchains
> > 	2. Configure all used events to run in kernel space and just
> > collect user callchains.
> > 	$ perf record -a -g --all-kernel --user-callchains
> > 
> > Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt | 6 ++++++
> >  tools/perf/builtin-record.c              | 4 ++++
> >  tools/perf/perf.h                        | 2 ++
> >  tools/perf/util/evsel.c                  | 4 ++++
> >  4 files changed, 16 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index de269430720a..b647eb3db0c6 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -490,6 +490,12 @@ Configure all used events to run in kernel space.
> >  --all-user::
> >  Configure all used events to run in user space.
> >  
> > +--kernel-callchains::
> > +Collect callchains from kernel space.
> 
> Ok, changing this to:
> 
> Collect callchains only from kernel space. I.e. this option sets
> perf_event_attr.exclude_callchain_user to 1,
> perf_event_attr.exclude_callchain_kernel to 0.
> 
> > +
> > +--user-callchains::
> > +Collect callchains from user space.
> 
> And this one to:
> Collect callchains only from user space. I.e. this option sets
> 
> perf_event_attr.exclude_callchain_kernel to 1,
> perf_event_attr.exclude_callchain_user to 0.

Yeah, each of this options just sets the exclude bit for the undesired
callchains, not setting 0 for the desired, so I'm fixing up the doc I
suggested accordingly, my comment below remains valid tho:

> 
> So that the user don't try using:
> 
>     pref record --user-callchains --kernel-callchains
> 
> expecting to get both user and kernel callchains and instead gets
> nothing.
> 
> Ok?
> 
> - Arnaldo
> 
> > +
> >  --timestamp-filename
> >  Append timestamp to output file name.
> >  
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index e2c3a585a61e..dca55997934e 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -2191,6 +2191,10 @@ static struct option __record_options[] = {
> >  	OPT_BOOLEAN_FLAG(0, "all-user", &record.opts.all_user,
> >  			 "Configure all used events to run in user space.",
> >  			 PARSE_OPT_EXCLUSIVE),
> > +	OPT_BOOLEAN(0, "kernel-callchains", &record.opts.kernel_callchains,
> > +		    "collect kernel callchains"),
> > +	OPT_BOOLEAN(0, "user-callchains", &record.opts.user_callchains,
> > +		    "collect user callchains"),
> >  	OPT_STRING(0, "clang-path", &llvm_param.clang_path, "clang path",
> >  		   "clang binary to use for compiling BPF scriptlets"),
> >  	OPT_STRING(0, "clang-opt", &llvm_param.clang_opt, "clang options",
> > diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> > index d59dee61b64d..711e009381ec 100644
> > --- a/tools/perf/perf.h
> > +++ b/tools/perf/perf.h
> > @@ -61,6 +61,8 @@ struct record_opts {
> >  	bool	     record_switch_events;
> >  	bool	     all_kernel;
> >  	bool	     all_user;
> > +	bool	     kernel_callchains;
> > +	bool	     user_callchains;
> >  	bool	     tail_synthesize;
> >  	bool	     overwrite;
> >  	bool	     ignore_missing_thread;
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a6f572a40deb..a606b2833e27 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -680,6 +680,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
> >  
> >  	attr->sample_max_stack = param->max_stack;
> >  
> > +	if (opts->kernel_callchains)
> > +		attr->exclude_callchain_user = 1;
> > +	if (opts->user_callchains)
> > +		attr->exclude_callchain_kernel = 1;
> >  	if (param->record_mode == CALLCHAIN_LBR) {
> >  		if (!opts->branch_stack) {
> >  			if (attr->exclude_user) {
> > -- 
> > 2.14.1
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
