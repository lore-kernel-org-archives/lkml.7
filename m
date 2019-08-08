Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C0C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD9C218A2
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJYtb07E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbfHHNjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:39:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40223 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbfHHNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:39:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so92095329qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eQTwtEozLwLfOe1la51JGO2rzPdUFPEK41M+Jl7lX7g=;
        b=SJYtb07EHeObPnIYm5BnL84Bj5QLg8bkxRqOVltXJWo8n4+KGU3d8ClXLvo2DUdRk7
         XoeUbF17zJMtRG2qK29LhWxj6WAhR+12npl8PIw9ZgYtAe9dBib57GPqNE5B0YlUjccu
         C87bMMG2AQj2xasXEjxx8HPHMe/9vZfkmgwtQXkxWxtomPbmW+5W4HNNjTSMQ3dZ5mzE
         AoxWc8OKlLnJHawRfpKlD3UpBxaC4kjIbIkwN4WJlSq7cfRocEHzByey1Tc3O6/Yriv/
         w1WEWe98YRAgXRvyh2OCa0As/vVKiY4bIFsigK83ywbpG1NxPqaL64trCaWuP6NZ/fUg
         qblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eQTwtEozLwLfOe1la51JGO2rzPdUFPEK41M+Jl7lX7g=;
        b=ngFie5vcyLQupTSoA6A4Kv0eAheonbW3Ve5pEZfweXLwYmtVVrM2o71sruADqkYac/
         AWNhYu+UAgw8VE3KOgPck4u0KOW+4G/ndXHaZAG9xw81fEuUijAISgyzRsUClvCBsPXV
         0hkAWYgfOlrMyzFRs5Zu8QedjaRAklfD39qS3zSTZVCx3VNL7fGz0umDBMHGsWT14cYY
         jDAMVqeQPA6ZO77UbU6QQGZuU9hvkx4bTso2PFy2LR5M4aHV60ahzoHmD3LfybdjxrrN
         JAY8X5IxDdbMv9dZ8N0LRxitBL3Yq+gp97jfga0aeBY2vseKziiIN1eyarDgH4UaDkQQ
         EVdg==
X-Gm-Message-State: APjAAAU5QKXMTHucK2H5muGZHOBVv2wjjmytkAMm68mfZ9rxCQGMw+/b
        HSZ8sqm0ZkkP02uc9H/36Io=
X-Google-Smtp-Source: APXvYqy75K82uWoCZYeqZQKP7fP9ixpV3j7ek8BbsPaOkyXaXG2wd/I5w6+GgkUfVs23ajtCZ/WcNA==
X-Received: by 2002:a0c:b084:: with SMTP id o4mr13184105qvc.227.1565271561893;
        Thu, 08 Aug 2019 06:39:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p3sm60801071qta.12.2019.08.08.06.39.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:39:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39E9440340; Thu,  8 Aug 2019 10:39:17 -0300 (-03)
Date:   Thu, 8 Aug 2019 10:39:17 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: Fix include paths in ui
Message-ID: <20190808133917.GE19444@kernel.org>
References: <20190731225441.233800-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731225441.233800-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 31, 2019 at 03:54:41PM -0700, Ian Rogers escreveu:
> These paths point to the wrong location but still work because they
> get picked up by a -I flag that happens to direct to the correct
> file. Fix paths to point to the correct location without -I flags.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/ui/browser.c      | 9 +++++----
>  tools/perf/ui/tui/progress.c | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> index f80c51d53565..d227d74b28f8 100644
> --- a/tools/perf/ui/browser.c
> +++ b/tools/perf/ui/browser.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "../string2.h"
> -#include "../config.h"
> -#include "../../perf.h"
> +#include "../util/util.h"
> +#include "../util/string2.h"
> +#include "../util/config.h"
> +#include "../perf.h"
>  #include "libslang.h"
>  #include "ui.h"
>  #include "util.h"
> @@ -14,7 +15,7 @@
>  #include "browser.h"
>  #include "helpline.h"
>  #include "keysyms.h"
> -#include "../color.h"
> +#include "../util/color.h"
>  #include <linux/ctype.h>
>  #include <linux/zalloc.h>
>  
> diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
> index bc134b82829d..5a24dd3ce4db 100644
> --- a/tools/perf/ui/tui/progress.c
> +++ b/tools/perf/ui/tui/progress.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/kernel.h>
> -#include "../cache.h"
> +#include "../../util/cache.h"
>  #include "../progress.h"
>  #include "../libslang.h"
>  #include "../ui.h"
> -- 
> 2.22.0.770.g0f2c4a37fd-goog

-- 

- Arnaldo
