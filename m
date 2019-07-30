Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDA1C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339512089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPGF86H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfG3WCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:02:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37024 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbfG3WCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:02:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so47706158qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=70YtNZee86bM8zmkGCj1cIXJNy70se2pWgKA+1v4Zj8=;
        b=QPGF86H+u6+PcvcZLXjAD/grPr3NZdUhnonr+ozkvJ858465bqZTbe2nrBfQmNI4CS
         yJZcjPo+A+Lv+3AdM1X3MYFSO/CxdB+AzE4/r52AjeFDH3/YpO0j9JTJ17zegi+3tYJo
         GB6cth+N308dMvf5gbMhRE5XzBq9GtlpPD0XLIeQRYZkwT0orlZgv3g2n1bJsCoFVzl7
         8o1+28j0ex1pd3sZookXLlqDtiH5JWDgyiuauBhPgtDmCBU7tRc8ULu1Wj/mMHLsXdch
         495cIaE+bqZU6VLCWJFx0WOiSJGzReNaZaDTlriVlQFnxS3G7FnL8Fxsbi5opaQuL/iu
         Zwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=70YtNZee86bM8zmkGCj1cIXJNy70se2pWgKA+1v4Zj8=;
        b=eZTpZ7fNm7GOegsBzfTZccBrDwr17I1WWoCX1sFwfcT6h38Oh4zUAUSh5FOMFz7iLB
         XUmMk/CMi0AXbl1zyNxcqzXjhrq+8OXfvybUAOnpyMA5JyWl+GvW1ugjPR4k1EmdFfqv
         Kd0JRJzcf/FiEYTSJOPiyv6vbmQJHRhaHs6oTQ2//Zz1+id4Dxl+JdjQXhohmPY/5XDZ
         NccBm9/BehoCPwA/KWhiVqtJRQWq96lJqzMOaAWjvTfwieHnyNq05Yuq/NixhOInkmcq
         5d3eQ57egzHqOlUhFATkZUZHN2l/z8GzflAHVDwCFPGqDcVD4gyuwvxODT/veHGfJUAP
         a3/w==
X-Gm-Message-State: APjAAAWymluImEFOfMaZS0BURmLsdtb+C+AWf4DecQzqkjbF4zBopSrA
        7vZDgXprMw/I1ig+GEns2us=
X-Google-Smtp-Source: APXvYqxhTZD95h50Sn/PfrBv4uMh3JsvvnzdNS1j2YC8QaRqWs3R5ZADjU0d7i4SvxkB9jdJnXDW6A==
X-Received: by 2002:a37:a142:: with SMTP id k63mr76239578qke.278.1564524167438;
        Tue, 30 Jul 2019 15:02:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id g3sm28228822qke.105.2019.07.30.15.02.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:02:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A79740340; Tue, 30 Jul 2019 19:02:44 -0300 (-03)
Date:   Tue, 30 Jul 2019 19:02:44 -0300
To:     Luke Mujica <lukemujica@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH] perf tools: Fix paths in include statements
Message-ID: <20190730220244.GB13361@kernel.org>
References: <20190719202253.220261-1-lukemujica@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719202253.220261-1-lukemujica@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 19, 2019 at 01:22:53PM -0700, Luke Mujica escreveu:
> These paths point to the wrong location but still work because
> they get picked up by a -I flag that happens to direct to the correct
> file. Fix paths to lead to the actual file location without help from
> include flags.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Luke Mujica <lukemujica@google.com>
> ---
>  tools/perf/arch/x86/util/kvm-stat.c | 4 ++--
>  tools/perf/arch/x86/util/tsc.c      | 6 +++---
>  tools/perf/ui/helpline.c            | 4 ++--
>  tools/perf/ui/util.c                | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> index 865a9762f22e..3f84403c0983 100644
> --- a/tools/perf/arch/x86/util/kvm-stat.c
> +++ b/tools/perf/arch/x86/util/kvm-stat.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> -#include "../../util/kvm-stat.h"
> -#include "../../util/evsel.h"
> +#include "../../../util/kvm-stat.h"
> +#include "../../../util/evsel.h"
>  #include <asm/svm.h>
>  #include <asm/vmx.h>
>  #include <asm/kvm.h>
> diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
> index 950539f9a4f7..b1eb963b4a6e 100644
> --- a/tools/perf/arch/x86/util/tsc.c
> +++ b/tools/perf/arch/x86/util/tsc.c
> @@ -5,10 +5,10 @@
>  #include <linux/stddef.h>
>  #include <linux/perf_event.h>
>  
> -#include "../../perf.h"
> +#include "../../../perf.h"
>  #include <linux/types.h>
> -#include "../../util/debug.h"
> -#include "../../util/tsc.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/tsc.h"
>  
>  int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
>  			     struct perf_tsc_conversion *tc)
> diff --git a/tools/perf/ui/helpline.c b/tools/perf/ui/helpline.c
> index b3c421429ed4..54bcd08df87e 100644
> --- a/tools/perf/ui/helpline.c
> +++ b/tools/perf/ui/helpline.c
> @@ -3,10 +3,10 @@
>  #include <stdlib.h>
>  #include <string.h>
>  
> -#include "../debug.h"
> +#include "../util/debug.h"
>  #include "helpline.h"
>  #include "ui.h"
> -#include "../util.h"
> +#include "../util/util.h"
>  
>  char ui_helpline__current[512];
>  
> diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
> index 63bf06e80ab9..9ed76e88a3e4 100644
> --- a/tools/perf/ui/util.c
> +++ b/tools/perf/ui/util.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "util.h"
> -#include "../debug.h"
> +#include "../util/debug.h"
>  
>  
>  /*
> -- 
> 2.22.0.657.g960e92d24f-goog

-- 

- Arnaldo
