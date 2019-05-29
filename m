Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ACAC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EA8240EB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWjv0kC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2TZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:25:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41640 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2TZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:25:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id s57so4061719qte.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OshedFNv7ZepaxsRg7Ll0LAb7kHFflsz2AJ5H3wX4EQ=;
        b=cWjv0kC181GK6dDASReLMCLrXa6KGGj5/HpVBLrdfO67mRbQuYls/K4Wkd01yu/4Md
         03xEA4/UUvu3KCnY8VmrK2A1rh2JNtHT97dFbbvYkDfHkhPTdawOZd9hTin2UNqVDfs0
         Ehj1lK/PJhwfl6Xy7c3AjfLVmFCQsbLCCmBWIpzuXeqWLfbjVn7R6rORV5BD/dQnr1/Q
         ztrnT9gZDAO/1OlhPSdwn7bv0R64DOA6VbI9W/2K5y1y3WhbUUzyA2iynHc+GkM2O4EL
         PFPfJYP8R3SzbsEvB3Fz4/YhVboZq7WRsjD0xqh3DFjO5y2VkGz1Kp8KRpyGA6cTdToa
         zyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OshedFNv7ZepaxsRg7Ll0LAb7kHFflsz2AJ5H3wX4EQ=;
        b=jqN2/56jEYZ0BwW7FRKa4fMxCVBaf/WIIcZkUG4QFI6byS7qoGz29O9ADlggTSI7xo
         0SmrnbfLy0eic4+0iqxc9En8bkmZGB1qwZRA1zG0QpR3K1QvuoYkLTFcHhDkd7ihVkrV
         jR12tsO+mtkcMCb9ANgKwv3puHxRFcKVgc9BkeEJVtCohMNregJhOqtSUPfeowqRH9++
         KL1tIMK6oU/+AypPe3KMKzHZncBSV+uNOOeVN9GiI7MTtbgFcwWdvoCj+z7SCnDuyePK
         Ov4tWUEWv03+e6doSXV/8YGP3Jgs0X2p44i7x/Zj1PpS2kWVGgWssGsvOjeiPuqMitap
         FCAQ==
X-Gm-Message-State: APjAAAVZzrGSVwEx6zakSaeATVuloK2TaBeffsBHCvqf375NgX/nOeJX
        DIb3nLEx2FFsdWBC1Gp1QE9Gv0sk
X-Google-Smtp-Source: APXvYqxugppB+FhpQpzS23jZUMZ3JUedDNm7PRBMbfrYUdcOtpFb0A0Kial8z2rpIWe/C5HW7pHMCQ==
X-Received: by 2002:ac8:17a5:: with SMTP id o34mr8391436qtj.232.1559157911845;
        Wed, 29 May 2019 12:25:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id k5sm202289qkc.75.2019.05.29.12.25.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 12:25:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9680641149; Wed, 29 May 2019 16:25:06 -0300 (-03)
Date:   Wed, 29 May 2019 16:25:06 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190529192506.GB5553@kernel.org>
References: <01a322ee-c99d-0bb7-b7cf-bc1fa8064d75@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a322ee-c99d-0bb7-b7cf-bc1fa8064d75@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 29, 2019 at 05:30:49PM +0300, Alexey Budankov escreveu:
> 
> When dwarf stacks are collected jointly with user specified register
> set using --user-regs option like below the full register context is
> still captured on a sample:
> 
>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3
> 
>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
>   ... FP chain: nr:0
>   ... user regs: mask 0xff0fff ABI 64-bit
>   .... AX    0x53b
>   .... BX    0x7ffedbdd3cc0
>   .... CX    0xffffffff
>   .... DX    0x33d3a
>   .... SI    0x7f09b74c38d0
>   .... DI    0x0
>   .... BP    0x401260
>   .... SP    0x7ffedbdd3cc0
>   .... IP    0x401236
>   .... FLAGS 0x20a
>   .... CS    0x33
>   .... SS    0x2b
>   .... R8    0x7f09b74c3800
>   .... R9    0x7f09b74c2da0
>   .... R10   0xfffffffffffff3ce
>   .... R11   0x246
>   .... R12   0x401070
>   .... R13   0x7ffedbdd5db0
>   .... R14   0x0
>   .... R15   0x0
>   ... ustack: size 1024, offset 0xe0
>    . data_src: 0x5080021
>    ... thread: stack_test2.g.O:23828
>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> 
> After applying the change suggested in the patch the sample data contain
> only user specified register values. IP and SP registers (dwarf_regs)
> are collected anyways regardless of the --user-regs option value provided
> from the command line:
> 
>   -g call-graph dwarf,K                         full_regs
>   -g call-graph dwarf,K --user-regs=user_regs	user_regs + dwarf_regs
>   --user-regs=user_regs                         user_regs
> 
>   $ perf record -g --call-graph dwarf,1024 --user-regs=BP -- ls
>   WARNING: specified --user-regs register set doesn't include registers needed by also specified --call-graph=dwarf, auto adding IP, SP registers.
>   arch   COPYING	Documentation  include	Kbuild	 lbuild    MAINTAINERS	modules.builtin		 Module.symvers  perf.data.old	scripts   System.map  virt
>   block  CREDITS	drivers        init	Kconfig  lib	   Makefile	modules.builtin.modinfo  net		 README		security  tools       vmlinux
>   certs  crypto	fs	       ipc	kernel	 LICENSES  mm		modules.order		 perf.data	 samples	sound	  usr	      vmlinux.o
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.030 MB perf.data (10 samples) ]
> 
>   188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
>   ... FP chain: nr:0
>   ... user regs: mask 0x1c0 ABI 64-bit
>   .... BP    0x401260
>   .... SP    0x7ffd3d85cc20
>   .... IP    0x401236
>   ... ustack: size 1024, offset 0x58
>    . data_src: 0x5080021
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v4:
> - added warning message about dwarf registers unconditionally 
>   included into the collected registers set
> 
> Changes in v3:
> - avoid changes in platform specific header files
> 
> Changes in v2:
> - implemented dwarf register set to avoid corrupted trace 
>   when --user-regs option value omits IP,SP
> 
> ---
>  tools/perf/util/evsel.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a6f572a40deb..426dfefeecda 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -669,6 +669,9 @@ int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
>  	return ret;
>  }
>  
> +#define DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
> +			 (1ULL << PERF_REG_SP))
> +
>  static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>  					   struct record_opts *opts,
>  					   struct callchain_param *param)
> @@ -702,7 +705,13 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>  		if (!function) {
>  			perf_evsel__set_sample_bit(evsel, REGS_USER);
>  			perf_evsel__set_sample_bit(evsel, STACK_USER);
> -			attr->sample_regs_user |= PERF_REGS_MASK;
> +			if (opts->sample_user_regs) {

Where are you checking that opts->sample_user_regs doesn't have either
IP or SP?

So, __perf_evsel__config_callchain its the routine that sets up the
attr->sample_regs_user when callchains are asked for, and what was it
doing? Asking for _all_ user regs, right?

I.e. what you're saying is that when --callgraph-dwarf is asked for,
then only IP and BP are needed, and we should stop doing that, so that
would be a first patch, if that is the case. I.e. a patch that doesn't
even mention opts->sample_user_regs.

Then, a second patch would fix the opt->sample_user_regs request clash
with --callgraph dwarf, i.e. it would do something like:

	      if ((opts->sample_regs_user & DWARF_REGS_MASK) != DWARF_REGS_MASK) {
	      		char * ip = (opts->sample_regs_user & (1ULL << PERF_REG_IP)) ? NULL : "IP",
	      		     * sp = (opts->sample_regs_user & (1ULL << PERF_REG_SP)) ? NULL : "SP",
			     * all = (!ip && !sp) ?  "s" : "";

			pr_warning("WARNING: specified --user-regs register set doesn't include register%s "
				   "needed by also specified --call-graph=dwarf, auto adding %s%s%s register%s.\n",
				   all, ip, all : ", " : "", sp, all);
		}

This if and only if all the registers that are needed to do DWARF
unwinding are just IP and BP, which doesn't look like its true, since
when no --user_regs is set (i.e. opts->user_regs is not set) then we
continue asking for PERF_REGS_MASK...

Can you check where I'm missing something?

Jiri DWARF unwind uses just IP and SP? Looking at
tools/perf/util/unwind-libunwind-local.c's access_reg() I don't think
so, right?

- Arnaldo

> +				attr->sample_regs_user |= DWARF_REGS_MASK;
> +				pr_warning("WARNING: specified --user-regs register set doesn't include registers "
> +					   "needed by also specified --call-graph=dwarf, auto adding IP, SP registers.\n");
> +			} else {
> +				attr->sample_regs_user |= PERF_REGS_MASK;
> +			}
>  			attr->sample_stack_user = param->dump_size;
>  			attr->exclude_callchain_user = 1;
>  		} else {
> -- 
> 2.20.1

-- 

- Arnaldo
