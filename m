Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDDCC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F7121882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9/XjXME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbfKGMiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:38:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39071 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGMiI (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:38:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id 15so1793957qkh.6
        for <Linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2QqilF9nFZEM8MWg+bnU8rbP3nE7eHcRGvo4vVkckrg=;
        b=A9/XjXMEeW5mVBt7Ul/rWhzVm+8iz5sns3X6FY+FbqTTiJsFmu/X49Yq5vcgjU1xP5
         ABfMPxIHsxjy2dsvV4j1vfuQJb7hc3hjPp/pgpaIfya+r+lXOtcRZECDS0g5Qbppwc/E
         Icdys+JCBnRzOXFKtVMHRDM80WqNCSkV1wa4Wrj42zNRySHsptPPwTS95mUH/dsF5bWC
         e5d0T03Qfd3atWjcMOPydxmizDr1xVfWdovA9ojCpEdjUuVn6EbjRS23+0DwE+VQE8sq
         avaOlVckq/UXCJ0k4olQSMljCG5/yRDvhnc2WHGzlSpnfJBDzslUZjQf2KAnqc62rGz8
         OAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2QqilF9nFZEM8MWg+bnU8rbP3nE7eHcRGvo4vVkckrg=;
        b=JicdQRrhRTaEB796OxmVuSe6oi0aRbAJ/CI/q5fBtgGs4RlDtD38Zdjx8ehzAiF8tJ
         hzXUfa+Zg3tfW7cww4h6mxmFZIQOiERMUJRlPlzV+DOxKo0vYJFWRtmuiWJcPvWEj2iW
         S/PJqyedfYn3FkAndfycX4e99yEDYpwZ4YtgrAlTMsO5/pqwYzWhivq/Y+ibdPFPT7rW
         69tV6TQ1wu9BGIiTPeu9+rJYb84XC5pAGkZEINzx9JXNBFdd6HovrdOK3gyyY3NZHjWa
         PBBUPU+4EouiRvpYOxLN6NGlCGILejkTD7mffEup3pbllXSF+NbLq+LwJYu0DykYA707
         NLbQ==
X-Gm-Message-State: APjAAAW8LJcW659RM5jFhi3tE1Ffy5D+hZxCp7g0w5BzjRYdjhyGks8y
        6cols9dD5K7FkAmqGGUUoWo=
X-Google-Smtp-Source: APXvYqxnBvvxikzdVTRzZzo9OOEV68uEj4cIiJGk/+EHZHwMcxdmbKieKzdLeIr/wOqOBIviN9g6XQ==
X-Received: by 2002:a37:81c1:: with SMTP id c184mr2570206qkd.59.1573130286919;
        Thu, 07 Nov 2019 04:38:06 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y33sm2095424qta.18.2019.11.07.04.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:38:05 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AA50C40B1D; Thu,  7 Nov 2019 09:38:02 -0300 (-03)
Date:   Thu, 7 Nov 2019 09:38:02 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v7 7/7] perf report: Sort by sampled cycles percent per
 block for tui
Message-ID: <20191107123802.GB11372@kernel.org>
References: <20191107074719.26139-1-yao.jin@linux.intel.com>
 <20191107074719.26139-8-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107074719.26139-8-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I prefer that all the browsers be in tools/perf/ui/browsers, but won't,
ho-hum, block this patch because of that, we can fix that later, and
don't need to hurry, I have patches that touch 'struct map'/'struct
addr_location', that I'll have to fixup to account for this, so its
better to fix anything here after I get my work merged,

Thanks a lot for this new feature, it looks awesome!

To further clarify: I've applied everything and also test it, very good
so far, we can fix things we find later, now going thru tests on my
build farm.

Thanks Jiri for all the reviewing, appreciated, as usual,

- Arnaldo
 
> +++ b/tools/perf/util/block-info.c
> @@ -10,6 +10,7 @@
>  #include "map.h"
>  #include "srcline.h"
>  #include "evlist.h"
> +#include "ui/browsers/hists.h"
>  
>  static struct block_header_column{
>  	const char *name;
> @@ -445,9 +446,75 @@ struct block_report *block_info__create_report(struct evlist *evlist,
>  	return block_reports;
>  }
>  
> +#ifdef HAVE_SLANG_SUPPORT
> +static int block_hists_browser__title(struct hist_browser *browser, char *bf,
> +				      size_t size)
> +{
> +	struct hists *hists = evsel__hists(browser->block_evsel);
> +	const char *evname = perf_evsel__name(browser->block_evsel);
> +	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
> +	int ret;
> +
> +	ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
> +	if (evname)
> +		scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
> +
> +	return 0;
> +}
> +
> +static int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
> +				  float min_percent)
> +{
> +	struct hists *hists = &bh->block_hists;
> +	struct hist_browser *browser;
> +	int key = -1;
> +	static const char help[] =
> +	" q             Quit \n";
> +
> +	browser = hist_browser__new(hists);
> +	if (!browser)
> +		return -1;
> +
> +	browser->block_evsel = evsel;
> +	browser->title = block_hists_browser__title;
> +	browser->min_pcnt = min_percent;
> +
> +	/* reset abort key so that it can get Ctrl-C as a key */
> +	SLang_reset_tty();
> +	SLang_init_tty(0, 0, 0);
> +
> +	while (1) {
> +		key = hist_browser__run(browser, "? - help", true);
> +
> +		switch (key) {
> +		case 'q':
> +			goto out;
> +		case '?':
> +			ui_browser__help_window(&browser->b, help);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +out:
> +	hist_browser__delete(browser);
> +	return 0;
> +}
> +#else
> +static int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
> +				  struct evsel *evsel __maybe_unused,
> +				  float min_percent __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif
> +
>  int report__browse_block_hists(struct block_hist *bh, float min_percent,
> -			       struct evsel *evsel __maybe_unused)
> +			       struct evsel *evsel)
>  {
> +	int ret;
> +
>  	switch (use_browser) {
>  	case 0:
>  		symbol_conf.report_individual_block = true;
> @@ -455,6 +522,11 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
>  			       stdout, true);
>  		hists__delete_entries(&bh->block_hists);
>  		return 0;
> +	case 1:
> +		symbol_conf.report_individual_block = true;
> +		ret = block_hists_tui_browse(bh, evsel, min_percent);
> +		hists__delete_entries(&bh->block_hists);
> +		return ret;
>  	default:
>  		return -1;
>  	}
> -- 
> 2.17.1

-- 

- Arnaldo
