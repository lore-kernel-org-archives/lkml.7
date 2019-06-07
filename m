Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45772C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15613208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2e0W6Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfFGTta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:49:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38415 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbfFGTt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:49:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so1570744qtl.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XetnfZzEQtXF/XrKdqkwd5MCUzqaJ2o3w0f1N7FnhFE=;
        b=j2e0W6BqNUid0rxnebMn5Hr9iaql3SX07RO42txy8qnnOmU48epJYX6py40IzhOez/
         blXsIBDZxLY0D8q50NwIq/J158qWmlEYwsG0gxeCdXSeG8VUt9YoWN4NJ0/6m+rZkyqD
         aWRAU0OOGVjXAu6/tLfBaZ8xeavToQuBrkIz6N7U+UdLuwQcgEj6xu78gpMtdc3eJ4yd
         MhXaXacpd20zhbYkWxWxjUN6aozCXeZL9GK5jeJ8z7fM5w15T4SwdGS5Woz9JFctg8Po
         ZKumNaQYeqVorzVTjbJOnZRtvr1t3HlmX1263UKBqO+4g2kENFQmkbyiHk4YhVMGdNmq
         PcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XetnfZzEQtXF/XrKdqkwd5MCUzqaJ2o3w0f1N7FnhFE=;
        b=au3Y59jA4VkUos4dmywNhFwMe7jbu6cM8A/UbDd7PZI3VrOPnr5TjXEyalHV2oB8E1
         XkjTKezxKNE5ZW9ncx8l4hBIXLkru0d1aZ2Rmh1mp3F/RuIeWudhLC6+Tvm/77cqjQYU
         00OH+W4l/WDsMxl40jQQKY4z0NnwW7+OqCJgy3dhm2Ciy9RZEZVMk/72gPn8J4HZ4dea
         dVyQwslPY+6xU6AAoZpHVJCSDW206Qf6SDOAeGtj7LrMpoaDN/JuX1s023nrarDKeXtQ
         SAAwBh4nnaES9KKYehtIbRSKqenQVYK8Pdt+Q6Uig0dfrU3iHxh/+CtqXPvlFpHvk0Bg
         b6gA==
X-Gm-Message-State: APjAAAWlHHpPfScKoqm6M7gozAmFKdN7WJmVDdh1vfufYoImLw36PLE/
        DnWZhh1PVbXUF2NcUwnDDss=
X-Google-Smtp-Source: APXvYqxSGsrQ17qLjpihKknfwIl2QkjKjO5Wq2z2Cyt7df3oxdd5iUulP5xcz4UPbigHFwFBpgt6tA==
X-Received: by 2002:ac8:2c6a:: with SMTP id e39mr48964705qta.179.1559936968380;
        Fri, 07 Jun 2019 12:49:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-97-17.3g.claro.net.br. [187.26.97.17])
        by smtp.gmail.com with ESMTPSA id p13sm1435620qkj.4.2019.06.07.12.49.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 12:49:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABA9041149; Fri,  7 Jun 2019 16:49:23 -0300 (-03)
Date:   Fri, 7 Jun 2019 16:49:23 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] perf intel-pt: Add support for efficient time
 interval filtering
Message-ID: <20190607194923.GP21245@kernel.org>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 04, 2019 at 03:59:58PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are some patches to add support for efficient time interval filtering.
> First there are 3 patches to add perf time interval to the itrace options
> structure.  Then changes to Intel PT to support "fast forwarding" to a
> particular timestamp.  The filtering is added in patch "perf intel-pt: Add
> support for efficient time interval filtering".  After that there are
> patches to time-utils, leading up to adding a new test and adding support
> multiple explicit time intervals.
> 
> The Intel PT changes make time filtering much faster because decoding is
> limited to the minimal time ranges needed to support the time intervals.

Thanks, applied!

Will now go with the other patches in this batch to the container tests,
hopefully should hit Ingo's mail box soon :-)

- Arnaldo

- Arnaldo
 
> 
> Adrian Hunter (19):
>       perf auxtrace: Add perf time interval to itrace_synth_ops
>       perf script: Set perf time interval in itrace_synth_ops
>       perf report: Set perf time interval in itrace_synth_ops
>       perf intel-pt: Add lookahead callback
>       perf intel-pt: Factor out intel_pt_8b_tsc()
>       perf intel-pt: Factor out intel_pt_reposition()
>       perf intel-pt: Add reposition parameter to intel_pt_get_data()
>       perf intel-pt: Add intel_pt_fast_forward()
>       perf intel-pt: Factor out intel_pt_get_buffer()
>       perf intel-pt: Add support for lookahead
>       perf intel-pt: Add support for efficient time interval filtering
>       perf time-utils: Treat time ranges consistently
>       perf time-utils: Factor out set_percent_time()
>       perf time-utils: Prevent percentage time range overlap
>       perf time-utils: Fix --time documentation
>       perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly
>       perf time-utils: Make perf_time__parse_for_ranges() more logical
>       perf tests: Add a test for time-utils
>       perf time-utils: Add support for multiple explicit time intervals
> 
>  tools/perf/Documentation/perf-diff.txt             |  14 +-
>  tools/perf/Documentation/perf-report.txt           |   9 +-
>  tools/perf/Documentation/perf-script.txt           |   9 +-
>  tools/perf/builtin-report.c                        |   8 +-
>  tools/perf/builtin-script.c                        |   8 +-
>  tools/perf/tests/Build                             |   1 +
>  tools/perf/tests/builtin-test.c                    |   4 +
>  tools/perf/tests/tests.h                           |   1 +
>  tools/perf/tests/time-utils-test.c                 | 251 ++++++++++++++++
>  tools/perf/util/auxtrace.h                         |  34 +++
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 188 ++++++++++--
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   5 +
>  tools/perf/util/intel-pt.c                         | 325 +++++++++++++++++++--
>  tools/perf/util/time-utils.c                       | 132 ++++++---
>  14 files changed, 894 insertions(+), 95 deletions(-)
>  create mode 100644 tools/perf/tests/time-utils-test.c
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
