Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C792FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97E620896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403973AbfFKGqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:46:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:23142 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbfFKGqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:46:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 23:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,578,1557212400"; 
   d="scan'208";a="183696202"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2019 23:46:19 -0700
Subject: Re: [PATCH] perf script/intel-pt: set synth_opts.callchain for
 use_browser > 0
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, davidca@fb.com,
        Milian Wolff <milian.wolff@kdab.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20190610234216.2849236-1-songliubraving@fb.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <def87b9f-a4fa-37ff-722a-9f14b14b2c7b@intel.com>
Date:   Tue, 11 Jun 2019 09:45:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610234216.2849236-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/19 2:42 AM, Song Liu wrote:
> Currently, intel_pt_process_auxtrace_info() sets synth_opts.callchain for
> use_browser != -1, which is not accurate after we set use_browser to 0 in
> cmd_script(). As a result, the following commands sees a lot more errors
> like:
> 
>   perf record -e intel_pt//u -C 10 -- sleep 3
>   perf script
> 
>   ...
>   instruction trace error type 1 time ...
>   ...
> 
> This patch fixes this by checking use_browser > 0 instead.
> 
> Fixes: c1c9b9695cc8 ("perf script: Allow extended console debug output")
> Reported-by: David Carrillo Cisneros <davidca@fb.com>
> Cc: Milian Wolff <milian.wolff@kdab.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/intel-pt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 6d288237887b..15692c104ca8 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2588,7 +2588,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  	} else {
>  		itrace_synth_opts__set_default(&pt->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
> -		if (use_browser != -1) {
> +		if (use_browser > 0) {

That code has changed recently.  Refer:

	https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=26f19c2eb7e54


>  			pt->synth_opts.branches = false;
>  			pt->synth_opts.callchain = true;
>  		}
> 

