Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B748C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F66207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6ugV7Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLJQAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:00:34 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34678 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJQAd (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:00:33 -0500
Received: by mail-vs1-f67.google.com with SMTP id g15so13435440vsf.1
        for <Linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r4Jrn3VZN19lN+Ke0gy7vLwQPNH/flZIQfr/q3sfjeY=;
        b=O6ugV7XlgNOv5qkcyw2GW/L3uJMG2r/fEDti0d0aeXW7cro+OOiAMNbhyWcPXT9gQ4
         Tn2FGfZs9JCThZCM+n/Ru4l9j38yk6aXa1S6QN7RN5G+toGyOyrNACa/WCibtVLSLR+Y
         FwSFZ6MNqCqqDpLlwU1z18KKqSp4mH+6QGbXsnyWY8WclTghrI+oJAmuo7pk5R1mtuzT
         b1X5RDGL2jcb9VKSqmEQ6z69Erc0NbIq6wQBsp5UdqBIOaT6Jm8YtB+GatGWUsM7KBby
         11ZMf/CydaGg9gbR1T0qTyhONtvZGWGqLo5VUQG7jE673xTK4qtsKyBUszFvFVJmKsWd
         rePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r4Jrn3VZN19lN+Ke0gy7vLwQPNH/flZIQfr/q3sfjeY=;
        b=Wvr+uJMEVoAOxTvVyAo4m+h6pAsMGecvFcjg+NRr+Q4dZivXnC7P+woLXqG9DZRhxr
         qdA+x639xdHOocs27ahBYBjNpK14Zos4knYEYZrm+5GLoXZ3DOV7bRVgE9V8VeGjMYfv
         jhQQo6KcBsM41BdkqboQjV/EXW53un5A+SbdD7gqzx4RCj+ngGGIsDYGo9ifHpr7C70n
         CzLmw2x43faEQMRQdc1OsklV/ug5w/5jycGW8SvxHRVTXbLx/Xp+NzpzoSgHyNMWKU9V
         Fsj2gqMa/mmCGRpMEn5W7/0vWYiQILPo5UcGtlbGQDXpkEBTn/kyxl9+5YYcyfkTa8oo
         DX3w==
X-Gm-Message-State: APjAAAWPuEKsfin0i3JKCr9KJx6jac++CaCsxWfa0ScustWyNiLwwNr+
        3TCe6splVKw52NFAl/YFH+o=
X-Google-Smtp-Source: APXvYqzHJ6nHCvqq8ViT0I1LofyDEJSUcRJJnfqKkxrPB6lyJunY7L9AWkyN7c19EFzzSoX231r5Xw==
X-Received: by 2002:a67:eb86:: with SMTP id e6mr25173664vso.209.1575993631932;
        Tue, 10 Dec 2019 08:00:31 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y129sm2554036vky.43.2019.12.10.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:00:31 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 30A3640352; Tue, 10 Dec 2019 13:00:28 -0300 (-03)
Date:   Tue, 10 Dec 2019 13:00:28 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 2/2] perf report: support hotkey to let user select
 any event in group for sorting
Message-ID: <20191210160028.GA28084@kernel.org>
References: <20191210083207.31569-1-yao.jin@linux.intel.com>
 <20191210083207.31569-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210083207.31569-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 10, 2019 at 04:32:07PM +0800, Jin Yao escreveu:
> When performing "perf report --group", it shows the event group information
> together. In previous patch, we have supported a new option "--group-sort-idx"
> to sort the output by the event at the index n in event group.
> 
> It would be nice if we can use a hotkey in browser to select a event
> for sorting.
> 
> For example,
> 
>   # perf report --group
> 
>  Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
>                         Overhead  Command    Shared Object            Symbol
>   92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
>    3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>    1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>    1.56%   0.01%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494ce
>    1.56%   0.00%   0.00%   0.00%  mgen       [kernel.kallsyms]        [k] task_tick_fair
>    0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
>    0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
>    0.00%   0.03%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] g_main_context_check
>    0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] apic_timer_interrupt
>    0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] check_preempt_curr
> 
> When user press hotkey '3' (event index, starting from 0), it indicates
> to sort output by the fourth event in group.
> 
>   Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
>                         Overhead  Command    Shared Object            Symbol
>   92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
>    0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
>    3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>    0.00%   0.00%   0.00%   0.06%  swapper    [kernel.kallsyms]        [k] hrtimer_start_range_ns
>    1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>    0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
>    0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] update_curr
>    0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] apic_timer_interrupt
>    0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] native_apic_msr_eoi_write
>    0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] __update_load_avg_se
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c    |  4 ++--
>  tools/perf/ui/browsers/hists.c | 21 ++++++++++++++++++++-
>  tools/perf/ui/keysyms.h        |  1 +
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 729cf7611d8a..02178fc54d67 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -635,7 +635,7 @@ static int report__browse_hists(struct report *rep)
>  		 * Usually "ret" is the last pressed key, and we only
>  		 * care if the key notifies us to switch data file.
>  		 */
> -		if (ret != K_SWITCH_INPUT_DATA)
> +		if (ret != K_SWITCH_INPUT_DATA && ret != K_RELOAD)
>  			ret = 0;
>  		break;
>  	case 2:
> @@ -1538,7 +1538,7 @@ int cmd_report(int argc, const char **argv)
>  	sort__setup_elide(stdout);
>  
>  	ret = __cmd_report(&report);
> -	if (ret == K_SWITCH_INPUT_DATA) {
> +	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
>  		perf_session__delete(session);
>  		goto repeat;
>  	} else
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index d4d3558fdef4..1de2456f27c3 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2876,7 +2876,8 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>  	"s             Switch to another data file in PWD\n"
>  	"t             Zoom into current Thread\n"
>  	"V             Verbose (DSO names in callchains, etc)\n"
> -	"/             Filter symbol by name";
> +	"/             Filter symbol by name\n"
> +	"0-9           Sort by event n in group";
>  	static const char top_help[] = HIST_BROWSER_HELP_COMMON
>  	"P             Print histograms to perf.hist.N\n"
>  	"t             Zoom into current Thread\n"
> @@ -2937,6 +2938,24 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>  			 * go to the next or previous
>  			 */
>  			goto out_free_stack;
> +		case '0':

case '0' ... '9':

works as well, for instance, in the kernel sources we have:

[acme@quaco perf]$ grep 'case.*\.\..*:' */*.c
block/bio.c:	case 2 ... 4:
block/bio.c:	case 5 ... 16:
block/bio.c:	case 17 ... 64:
block/bio.c:	case 65 ... 128:
block/bio.c:	case 129 ... BIO_MAX_PAGES:
block/sed-opal.c:		case 0xbfff ... 0xffff:
fs/binfmt_elf.c:		case PT_LOPROC ... PT_HIPROC:
fs/binfmt_elf.c:			case PT_LOPROC ... PT_HIPROC:
kernel/audit.c:	case AUDIT_FIRST_USER_MSG ... AUDIT_LAST_USER_MSG:
kernel/audit.c:	case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
kernel/audit.c:	case AUDIT_FIRST_USER_MSG ... AUDIT_LAST_USER_MSG:
kernel/audit.c:	case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
[acme@quaco perf]$

> +		case '1':
> +		case '2':
> +		case '3':
> +		case '4':
> +		case '5':
> +		case '6':
> +		case '7':
> +		case '8':
> +		case '9':
> +			symbol_conf.group_sort_idx = key - '0';
> +			if (!symbol_conf.event_group ||
> +			    symbol_conf.group_sort_idx >= evsel->core.nr_members) {
> +				continue;

Better to put something on the helpline as:

    The max event group index to sort is N!

And if symbol_conf.event_group isn't set, something like:

    Sort by index only available with group events!

> +			}
> +
> +			key = K_RELOAD;
> +			goto out_free_stack;
>  		case 'a':
>  			if (!hists__has(hists, sym)) {
>  				ui_browser__warning(&browser->b, delay_secs * 2,
> diff --git a/tools/perf/ui/keysyms.h b/tools/perf/ui/keysyms.h
> index fbfac29077f2..04cc4e5c031f 100644
> --- a/tools/perf/ui/keysyms.h
> +++ b/tools/perf/ui/keysyms.h
> @@ -25,5 +25,6 @@
>  #define K_ERROR	 -2
>  #define K_RESIZE -3
>  #define K_SWITCH_INPUT_DATA -4
> +#define K_RELOAD -5

Can you please split the K_RELOAD logic from this patch?
  
>  #endif /* _PERF_KEYSYMS_H_ */
> -- 
> 2.17.1

-- 

- Arnaldo
