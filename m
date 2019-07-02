Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA4C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B41F21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+i1lO63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGBRDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:03:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41282 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfGBRDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:03:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so6498136pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lTLYMlpcH/Ck5QvMOobX90tbMZ5kb5L0afZG0WmLSGo=;
        b=p+i1lO63uPwwxxUgqmTVzm1WiK1WXGsGwDGLuVemP8EcKFdGTIHWouZlQbgXqIZgah
         mA4qnp4JbyWA9v0vF6RyGNR0JhNeablrCY4YyyZYcrCuxijfNHYtZbZZRyfTipKQiAp0
         r/UJrcRIG5l+DCTUgmIbrKlmj5xjOyWnZ1k8ummciV1phZm7XVgGjlnhUBU+H1vvt0mR
         U0noy43NQH2D81U2uZ11wP46/JMzGrkFMrdtkgPsRX3Wu0OgzM8npvhLwrFhJ9G7Ts2H
         bSaQaQX+WEBiOA636GPQy/r+CjxtNjNd2Cpkpcr+mNAMVuWXiehHrFWgNF2+DhhJwi6Q
         7xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lTLYMlpcH/Ck5QvMOobX90tbMZ5kb5L0afZG0WmLSGo=;
        b=HOGRpna3IXfZgavBMhEc5nqneMmwTTd9AHf8Omjfpyxam9AUn1qY8aANDL2FW6l3lJ
         F12DdqvQ5q3lTp1MFfkLbyzjQZBf44V1pqXShvM+zz9aRdYI/reOZYJ9qBqjc2ydiJYA
         DFS4lU2R59C2KxlBx/2wLGTv2ZUIRYP/WL/JzEDvNvwnE0JO48pJquRjvlxlyocERYMn
         8Hn1LHnEWTgpZpxTl/CHYks3NBZcZynYwJcPVt0ou0VdHc+vtSx26Ooo1Dw5+dB6s8tp
         xtcoSQzLBwRRQ8yyq+JOg0r4OjF2IWY6/LG0o1U/hoRzbN6/cfGuRBe7cyLXtITNUMs0
         vUng==
X-Gm-Message-State: APjAAAVmIfO5nAN6cpj5yE/oh3wletQGk0xCFdyEX/kdR/Gr6tiAqRqx
        0Z9ojTMOGTNGxvIomxUy0gzdtQ==
X-Google-Smtp-Source: APXvYqwEhCFzfzATrdcqpX0KuUrx3AMmN6ORxbbB4sdtC5j3wQvdl7pLHPd3KWy/rduZZAoLOa/CSA==
X-Received: by 2002:a63:c14c:: with SMTP id p12mr31877632pgi.138.1562086989931;
        Tue, 02 Jul 2019 10:03:09 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k16sm14111163pfa.87.2019.07.02.10.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 10:03:09 -0700 (PDT)
Date:   Tue, 2 Jul 2019 11:03:06 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 11/11] perf cs-etm: Smatch: Fix potential NULL pointer
 dereference
Message-ID: <20190702170306.GA17808@xps15>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-12-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702103420.27540-12-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Tue, Jul 02, 2019 at 06:34:20PM +0800, Leo Yan wrote:
> Based on the following report from Smatch, fix the potential
> NULL pointer dereference check.
> 
>   tools/perf/util/cs-etm.c:2545
>   cs_etm__process_auxtrace_info() error: we previously assumed
>   'session->itrace_synth_opts' could be null (see line 2541)
> 
> tools/perf/util/cs-etm.c
> 2541         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> 2542                 etm->synth_opts = *session->itrace_synth_opts;
> 2543         } else {
> 2544                 itrace_synth_opts__set_default(&etm->synth_opts,
> 2545                                 session->itrace_synth_opts->default_no_sample);
>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 2546                 etm->synth_opts.callchain = false;
> 2547         }
> 
> To dismiss the potential NULL pointer dereference, this patch validates
> the pointer 'session->itrace_synth_opts' before access its elements.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0c7776b51045..b79df56eb9df 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2540,7 +2540,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
>  		etm->synth_opts = *session->itrace_synth_opts;
> -	} else {
> +	} else if (session->itrace_synth_opts) {

This will work but we end up checking session->itrace_synth_opts twice.  I
suggest to check it once and then process with the if/else if valid:

        if (session->itrace_synth_opts) {
                if (session->itrace_synth_opts->set) {
                        ...
                } else {
                        ...
                }
        }

Thanks,
Mathieu

>  		itrace_synth_opts__set_default(&etm->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
>  		etm->synth_opts.callchain = false;
> -- 
> 2.17.1
> 
