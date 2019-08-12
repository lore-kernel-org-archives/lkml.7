Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B62C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA7D206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml/MGLzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfHLUW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:22:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33819 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfHLUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:22:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id m10so2794857qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x36Zdhrbd36jlNpMgEK+It3M4pd2ku8s6wizrey81eQ=;
        b=ml/MGLzQ5saV9X1B44nl9UwnQZ9ePQjJ8hTKCvSAhp7c6bcvdAh4OZe95ApTh9vegf
         7U0AP+JImas6NgvsFmb6eC9h0TGpUAsYpfb8e2mRNXJljiCH2SWbb/LcjVadT/cMwmGK
         BW6iDS4c1Svm/aK4Tvl1sG5vHQloq3RuJJyVTlFZBDE+NkxNNbGBElrinkOXRp4TqABb
         vUtgb14z9/9t/d39khykbMvzJNav11a4+QLlZsesEtYbCyowq5jpfqHcR+MysIDMeSOO
         WmI9ass4AE8MEdKxp06RwJ5GbBjPBIn0PKyaI13Nc27NInqRoVosQ1aROr7YbO5b6F/k
         xiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x36Zdhrbd36jlNpMgEK+It3M4pd2ku8s6wizrey81eQ=;
        b=T7n/GCtDB+ojloufRJZTKQnSkxke75d0o4JNCWinXR7tvyu5P0lTM4Mf/3msxQmvqm
         P5UeD5FKfZ68IhzgkLqknkSB1GySr3IqFHXpZqZWtamSLCyrPyOIyrSJAcXZwqAjMQWM
         7xatdzJjlr+NV2IaoqNcxGl9Nllk7vxQ1sFXTNX+H+XWlsSMaf+5ZFIdlgjrhO6Z4Z5N
         KKXffn8bwEqdpLGRf79x9z06eOZrrgFVejgwV2s5XhBSFkv3qLaBdvZ9R9wF2qDlqWwk
         rGJf5Ut9iJUYjjJaB24710H6pATJefCp1TxM8nlH/zKow92ieEWMSLuOVFQQd/4ZOtZd
         2kBw==
X-Gm-Message-State: APjAAAXikv0OIvo8QJwRHLlSo+tZ56U5C/ikd99IDFeiXwdAEYhdHzyl
        +7IXq9BKS+sg9wobBDw3L3g=
X-Google-Smtp-Source: APXvYqzgbzL5Mm5f07CLUKO1VvXHfZiq1D0qFMkqcfETjVjkbGxvLhwlN5nG0T0ITiIdLeWHJugQKw==
X-Received: by 2002:ae9:d606:: with SMTP id r6mr30567211qkk.364.1565641375989;
        Mon, 12 Aug 2019 13:22:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-98-68.3g.claro.net.br. [187.26.98.68])
        by smtp.gmail.com with ESMTPSA id p32sm54442466qtb.67.2019.08.12.13.22.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:22:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F25040340; Mon, 12 Aug 2019 17:22:51 -0300 (-03)
Date:   Mon, 12 Aug 2019 17:22:51 -0300
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 4/4] perf: Use CAP_SYS_ADMIN instead of euid==0 with
 ftrace
Message-ID: <20190812202251.GG9280@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 07, 2019 at 10:44:17AM -0400, Igor Lubashev escreveu:
> Kernel requires CAP_SYS_ADMIN instead of euid==0 to mount debugfs for ftrace.
> Make perf do the same.
> 
> Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> ---
>  tools/perf/builtin-ftrace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index ae1466aa3b26..d09eac8a6d57 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -13,6 +13,7 @@
>  #include <signal.h>
>  #include <fcntl.h>
>  #include <poll.h>
> +#include <linux/capability.h>
>  
>  #include "debug.h"
>  #include <subcmd/parse-options.h>
> @@ -21,6 +22,7 @@
>  #include "target.h"
>  #include "cpumap.h"
>  #include "thread_map.h"
> +#include "util/cap.h"
>  #include "util/config.h"
>  
>  
> @@ -281,7 +283,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		.events = POLLIN,
>  	};
>  
> -	if (geteuid() != 0) {
> +	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
>  		pr_err("ftrace only works for root!\n");

I guess we should update the error message too? 

>  		return -1;
>  	}
> -- 
> 2.7.4

-- 

- Arnaldo
